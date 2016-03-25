class MsgData < ActiveRecord::Migration

  def change
    create_table :msg_messages do |t|
      t.string :subject
      t.text :message
      t.string :from_address
      t.string :from_name
      t.text :bcc
      t.datetime :sent_at
      t.integer :opened_by_count
      t.integer :clicked_by_count
      t.timestamps
    end

    create_table :msg_envelopes do |t|
      t.integer :message_id
      t.string :recipient_type
      t.integer :recipient_id
      t.string :mandrill_id
      t.string :email
      t.datetime :sent_at
      t.text :rendered_message
      t.text :rendered_subject
      t.text :rejection_message
      t.boolean :bounced, default: false
      t.boolean :read, default: false
      t.boolean :clicked, default: false
      t.timestamps
    end
    create_index :msg_envelopes, :message_id
    create_index :msg_envelopes, [:recipient_type, :recipient_id]
    create_index :msg_envelopes, :mandrill_id
    create_index :msg_envelopes, :bounced

    create_table :msg_attachments do |t|
      t.integer :message_id
      t.string :file_content_type
      t.string :file_name
      t.text :file_content, limit: 16.megabytes - 1
      t.timestamps
    end
    create_index :msg_attachments, :message_id

    create_table :msg_templates do |t|
      t.string :subject
      t.text :message
      t.timestamps
    end
  end
end
