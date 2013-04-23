# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130423091642) do

  create_table "msg_bounces", :force => true do |t|
    t.integer  "envelope_id"
    t.string   "bounce_type"
    t.string   "bounce_subtype"
    t.string   "reporter"
    t.text     "raw_message"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "email"
    t.string   "status"
    t.string   "diagnostic"
  end

  add_index "msg_bounces", ["envelope_id"], :name => "index_msg_bounces_on_envelope_id"

  create_table "msg_envelopes", :force => true do |t|
    t.integer  "sending_id"
    t.integer  "receiver_id"
    t.integer  "email_id"
    t.string   "receiver_type"
    t.string   "to_address"
    t.string   "from_address"
    t.string   "subject"
    t.text     "contents"
    t.datetime "sent_at"
    t.datetime "opened_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "msg_envelopes", ["email_id"], :name => "index_msg_envelopes_on_email_id"
  add_index "msg_envelopes", ["receiver_id", "receiver_type"], :name => "index_msg_envelopes_on_receiver_id_and_receiver_type"
  add_index "msg_envelopes", ["receiver_id"], :name => "index_msg_envelopes_on_receiver_id"
  add_index "msg_envelopes", ["sending_id"], :name => "index_msg_envelopes_on_sending_id"

  create_table "msg_messages", :force => true do |t|
    t.string   "subject"
    t.string   "from_address"
    t.string   "from_name"
    t.text     "body"
    t.string   "function"
    t.text     "description"
    t.boolean  "transactional", :default => false
    t.boolean  "saved",         :default => false
    t.integer  "created_by_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "msg_sendings", :force => true do |t|
    t.integer  "message_id"
    t.integer  "created_by_id"
    t.datetime "sent_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "receiving_class"
    t.string   "receiving_group"
  end

  add_index "msg_sendings", ["created_by_id"], :name => "index_msg_sendings_on_created_by_id"
  add_index "msg_sendings", ["message_id"], :name => "index_msg_sendings_on_message_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "admin",                  :default => false
    t.datetime "activated_at"
    t.datetime "invited_at"
    t.datetime "invited_by_id"
    t.datetime "reminded_at"
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "password_salt"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

end
