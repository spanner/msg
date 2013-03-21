module Msg
  class MsgMailer < ActionMailer::Base
    default from: Msg.email_from, :return_path => Msg.email_return_path, :bcc => Msg.email_bcc
    layout Msg.email_layout

    def message(message, receiver)
      @receiver = receiver
      @subject = message.subject
      @body = message.render_for(receiver)
      mail(:to => %{"#{@receiver.name}" <#{@receiver.email}>}, :subject => @subject) do |format|

        # so. how to use the body?

      end
    end
    
  end
end
