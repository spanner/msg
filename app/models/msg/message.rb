require 'mustache'

module Msg
  class Message < ActiveRecord::Base
    has_many :attachments
    has_many :envelopes
    has_many :message_recipients

    def from
      name = from_name? ? from_name : Msg.default_from_name
      address = from_address? ? from_address : Msg.default_from_address
      "#{name} <#{address}>"
    end

    def render_body_for(recipient)
      interpolations = recipient.for_email.reverse_merge(Msg.email_values)
      Mustache.render(body, interpolations)
    end

    def render_subject_for(recipient)
      interpolations = recipient.for_email.reverse_merge(Msg.email_values)
      Mustache.render(subject, interpolations)
    end

  end
end
