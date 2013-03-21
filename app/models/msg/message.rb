module Msg
  class Message < ActiveRecord::Base
    attr_accessible :subject, :body, :role, :description, :required, :saved

    has_many :sendings
    belongs_to :created_by, :foreign_class => Msg.user_class
    
    scope :transactional, where(:transactional => true)
    scope :saved, where(:saved => true)
    scope :unsaved, where(:saved => false)



    def render_for(receiver)
      renderer.parse(self.body, receiver.for_email)
    end

    def renderer
      # Mustache?
    end

  end
end
