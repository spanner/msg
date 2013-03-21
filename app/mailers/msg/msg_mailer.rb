module Msg
  class MsgMailer < ActionMailer::Base
    default from: Msg.email_from
  end
end
