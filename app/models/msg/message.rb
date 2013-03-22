require 'mustache'

module Msg
  class Message < ActiveRecord::Base
    attr_accessible :subject, :body, :function, :description, :transactional, :saved

    has_many :sendings
    belongs_to :created_by, :class_name => Msg.user_class
    
    scope :transactional, where(:transactional => true)
    scope :saved, where(:saved => true)
    scope :unsaved, where(:saved => false)

    def render_for(receiver)
      values = receiver.for_email.reverse_merge(Msg.email_values)
      Mustache.render(body, values)
    end

  end
end
