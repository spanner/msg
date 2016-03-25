# Message attachments are received, stored and passed on to mandrill as base64 urls.
#
module Msg
  class Attachment < ActiveRecord::Base
    belongs_to :message

    def for_mandrill
      {
        type: file_content_type,
        name: file_name,
        content: file_content
      }
    end

  end
end
