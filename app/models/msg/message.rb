require 'mustache'

module Msg
  class Message < ActiveRecord::Base
    has_many :sendings
    belongs_to :created_by, :class_name => Msg.user_class

    scope :transactional, where(:transactional => true)
    scope :saved, where(:saved => true, :transactional => false)
    scope :unsaved, where(:saved => false)

    def from
      name = from_name? ? from_name : Msg.default_from_name
      address = from_address? ? from_address : Msg.default_from_address
      "#{name} <#{address}>"
    end

    def render_for(receiver, token=nil)
      values = receiver.for_email(token).reverse_merge(Msg.email_values)
      Mustache.render(body, values)
    end

  end
end
