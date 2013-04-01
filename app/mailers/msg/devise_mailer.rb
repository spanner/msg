module Msg
  class DeviseMailer < Devise::Mailer
    default from: Msg.default_from_address, :bcc => Msg.email_bcc
    layout Msg.email_layout

    def confirmation_instructions(receiver, opts={})
      @message = Msg::Message.find_by_function('confirmation_instructions')
      @contents = @message.render_for(receiver)
      super
    end

    def reset_password_instructions(receiver, opts={})
      @message = Msg::Message.find_by_function('reset_password_instructions')
      @contents = @message.render_for(receiver)
      super
    end


  end
end
