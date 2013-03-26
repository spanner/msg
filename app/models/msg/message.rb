require 'mustache'

module Msg
  class Message < ActiveRecord::Base
    attr_accessible :subject, :body, :function, :description, :transactional, :saved, :from_name, :from_address

    has_many :sendings
    belongs_to :created_by, :class_name => Msg.user_class

    scope :transactional, where(:transactional => true)
    scope :saved, where(:saved => true)
    scope :unsaved, where(:saved => false)

    def from
      name = from_name? ? from_name : Msg.default_from_name
      address = from_address? ? from_address : Msg.default_from_address
      "#{from_name || Msg.default_from_name} <#{from_address || Msg.default_from_address}>"
    end
    
    def render_for(receiver)
      values = receiver.for_email.reverse_merge(Msg.email_values)
      rendered = Mustache.render(body, values)
      ActionController::Base.helpers.sanitize(rendered, :tags => Msg.tags_allowed_in_email, :attributes => Msg.attributes_allowed_in_email)
    end

  end
end
