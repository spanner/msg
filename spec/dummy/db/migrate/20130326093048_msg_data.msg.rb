# This migration comes from msg (originally 20130320141926)
class MsgData < ActiveRecord::Migration
  def change
    create_table :msg_messages do |t|
      t.string :subject
      t.string :from_address
      t.string :from_name
      t.text :body
      t.string :function
      t.text :description
      t.boolean :transactional, :default => false
      t.boolean :saved, :default => false
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
      t.integer :email_id
      t.string :receiver_type
      t.string :to_address
      t.string :from_address
      t.string :subject
      t.text :contents
      t.datetime :sent_at
      t.datetime :opened_at
      t.timestamps
    end
    add_index :msg_envelopes, :sending_id
    add_index :msg_envelopes, :email_id
    add_index :msg_envelopes, :receiver_id
    add_index :msg_envelopes, [:receiver_id, :receiver_type]
    
    create_table :msg_bounces do |t|
      t.integer :envelope_id
      t.string :bounce_type
      t.string :bounce_subtype
      t.string :reporter
      t.text :raw_message
      t.timestamps
    end
    add_index :msg_bounces, :envelope_id
    
  end
end
