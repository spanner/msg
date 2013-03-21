module Msg
  class DeviseMailer < ActionMailer::Base
    default from: Msg.email_from, :return_path => Msg.email_return_path, :bcc => Msg.email_bcc
    layout Msg.email_layout

    # here we subclass the devise mailer so that it retrieves messages from the database by role and renders them our way.
    
  end
end
