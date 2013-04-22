module Msg
  class DeviseMailer < Devise::Mailer
    default from: Msg.default_from_address, :bcc => Msg.email_bcc, :return_path => Msg.email_return_path
    layout Msg.email_layout

    def confirmation_instructions(receiver, opts={})
      @message = Msg::Message.find_by_function('confirmation_instructions')
      @contents = @message.render_for(receiver)
      opts[:subject] = @message.subject
      super
    end

    def reset_password_instructions(receiver, opts={})
      @message = Msg::Message.find_by_function('reset_password_instructions')
      @contents = @message.render_for(receiver)
      opts[:subject] = @message.subject
      super
    end

  end
end
