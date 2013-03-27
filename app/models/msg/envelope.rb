
module Msg
  class Envelope < ActiveRecord::Base
    attr_accessible :receiver, :sending
    
    belongs_to :sending
    belongs_to :receiver, :polymorphic => true
    has_many :bounces

    validates :receiver, :presence => true
    validates :sending, :presence => true
    after_create :send_email

    def message
      sending.message
    end

    def open!
      update_column(:opened_at, Time.now)
    end

    def url_to_open
      Msg::Engine.routes.url_helpers.envelope_url(self, :host => ActionMailer::Base.default_url_options[:host], :format => :png)
    end

  protected
  
    def render_with_tracker
      "#{message.render_for(receiver)}<img src=\"#{url_to_open}\" />"
      # message.render_for(receiver) + %{<img src="#{url_to_open}" />}
    end

    def send_email
      Rails.logger.warn "preparing email for envelope #{self.inspect}"
      Rails.logger.warn "sending is #{sending.inspect}"
      Rails.logger.warn "message is #{message.inspect}"
      
      
      self.email_id = "#{self.id}@#{Msg.sending_domain}"
      self.subject = message.subject
      self.from_address = message.from
      self.to_address = receiver.email
      self.contents = render_with_tracker
      Msg::MsgMailer.message_in_envelope(self).deliver
      self.sent_at = Time.now
      self.save
    end

  end
end
