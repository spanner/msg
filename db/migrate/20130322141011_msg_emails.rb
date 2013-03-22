class MsgEmails < ActiveRecord::Migration
  def self.up
    unless table_exists?(:emails)
      create_table :emails do |t|
        t.string :from_address, :null => false

        t.string :reply_to_address,
                 :subject

        # The following addresses have been defined as text fields to allow for multiple recipients. These fields could
        # instead be defined as strings, and even indexed, if you'd like to improve search performance and you can
        # confidently limit the size of their contents.

        t.string :to_address,
                 :cc_address,
                 :bcc_address

        # The content field must be large enough to include the full content of emails, including any attachments. If you
        # do not plan to send any attachments or long emails, you could leave off this limit. In MySQL, this will result
        # in a TEXT column with a limit of 64KB characters. Otherwise, 100MB characters seems a safe limit for almost any
        # email. In MySQL, this will result in the creation of a LONGTEXT column with an actual limit of 4GB characters.

        t.text   :content, :limit => 1.megabytes

        t.datetime :sent_at
        t.timestamps
      end
    end
  end

  def self.down
    drop_table :emails
  end
end
