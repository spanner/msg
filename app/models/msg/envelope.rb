# Envelope is the sending of a message to one of its recipients,
# combining a snapshot of the message and recipient at that time
# with associated delivery and response data gathered from mandrill.

module Msg
  class Envelope < ActiveRecord::Base
    belongs_to :message
    belongs_to :recipient, polymorphic: true

    scope :bounced, -> {where(bounced: true)}
    scope :read, -> {where(read: true)}
    scope :clicked, -> {where(clicked: true)}

    def send!
      Msg::MandrillSendingJob.perform_later(self)
    end

    def render_message_for_recipient
      self.rendered_subject = message.render_subject_for_recipient(recipient)
      self.rendered_message = message.render_body_for_recipient(recipient)
      self.email = recipient.email
      self.save
    end
    
    def for_mandrill
      render_message_for_recipient
      {
        to: [{
          name: recipient.name,
          email: recipient.email
        }],
        subject: rendered_subject,
        html: rendered_message,
        attachments: message.attachments.map(&:for_mandrill)
      }
    end

  end
end
