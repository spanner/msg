class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      # ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
    end
  end
end
