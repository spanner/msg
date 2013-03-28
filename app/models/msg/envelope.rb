module Msg
  class Envelope < ActiveRecord::Base
    attr_accessible :receiver, :sending
    
    belongs_to :sending
    belongs_to :receiver, :polymorphic => true
    has_many :bounces

    validates :receiver, :presence => true
    validates :sending, :presence => true
    after_create :send_email

    scope :opened, where("opened_at IS NOT NULL")
    scope :bounced, select("msg_envelopes.*")
                  .joins("LEFT OUTER JOIN msg_bounces as mb ON mb.envelope_id = msg_envelopes.id")
                  .having("count(mb.id) > 0")

    def message
      sending.message
    end

    def open!
      update_column(:opened_at, Time.now)
    end
    
    def status
      if opened_at?
        "read"
      elsif bounces.any?
        "bounced"
      else
        "unread"
      end
    end

  protected

    def send_email
      # Record sending parameters for later reference. The message or receiver properties might change after this is sent.
      self.email_id = "#{self.id}@#{Msg.sending_domain}"
      self.subject = message.subject
      self.from_address = message.from
      self.to_address = receiver.email
      # render the message for our receiver
      self.contents = message.render_for(receiver)
      # send it
      Msg::MsgMailer.message_in_envelope(self).deliver
      # note sending time
      Rails.logger.warn "setting envelope.sent_at to "
      self.sent_at = Time.now
      # and save our changes
      self.save!
    end

  end
end
