require 'mustache'

module Msg
  class Envelope < ActiveRecord::Base

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

    def render_message
      values = receiver.for_email.reverse_merge(Msg.email_values)
      values[:tracker_dot] = url_to_open
      template = message.body + %{<img src="{{tracker_dot}}" />}
      rendered = Mustache.render(message.body, values)
      ActionController::Base.helpers.sanitize(rendered, :tags => Msg.tags_allowed_in_email, :attributes => Msg.attributes_allowed_in_email)
    end

    def send_email
      self.email_id = "#{self.id}@#{Msg.sending_domain}"
      self.subject = message.subject
      self.from_address = message.from
      self.to_address = receiver.email
      self.contents = render_message
      Msg::MsgMailer.message_in_envelope(self).deliver
      self.sent_at = Time.now
      self.save
    end

  end
end
