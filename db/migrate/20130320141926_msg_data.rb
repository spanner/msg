class MsgData < ActiveRecord::Migration
  def change
    create_table :msg_messages do |t|
      t.string :subject
      t.text :body
      t.string :role
      t.text :description
      t.boolean :transactional, :default => false
      t.boolean :saved
      t.integer :created_by_id
      t.timestamps
    end

    create_table :msg_sendings do |t|
      t.integer :message_id
      t.integer :created_by_id
      t.datetime :sent_at
      t.timestamps
    end
    add_index :msg_sendings, :message_id
    add_index :msg_sendings, :created_by_id
    
    create_table :msg_envelopes do |t|
      t.integer :sending_id
      t.integer :receiver_id
      t.string :receiver_type
      t.string :receiver_email
      t.string :message_token
      t.string :message_subject
      t.text :message_body
      t.datetime :opened_at
      t.timestamps
    end
    add_index :msg_envelopes, :sending_id
    add_index :msg_envelopes, :receiver_id
    add_index :msg_envelopes, [:receiver_id, :receiver_type]
    
    create_table :msg_bounces do |t|
      t.integer :envelope_id
      t.string :status
      t.string :error
      t.text :raw_message
      t.timestamps
    end
    add_index :msg_sendings, :envelope_id
    
  end
end
