module Msg
  class DeviseMailer < ActionMailer::Base
    default from: Msg.default_from_address, :bcc => Msg.email_bcc
    layout Msg.email_layout

    # It would be nice to intervene less in Devise but we can't send user-authored content straight
    # through: it has to be rendered in a limited way way first.
    
    def devise_mail(record, action, opts={})
      initialize_from_record(record)
      mail headers_for(record, action, opts)
    end
    
    def headers_for(record, action, opts)
      headers = super(action, opts)
      headers[:body] = body_for(record, action)
      headers
    end
    
    def body_for(record, action)
      if template = Msg::Message.find_by_function(action)
        template.render_for(record)
      end
    end
    
  end
end
