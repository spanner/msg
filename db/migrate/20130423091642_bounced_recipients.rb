class BouncedRecipients < ActiveRecord::Migration
  def change
    add_column :msg_bounces, :email, :string
    add_column :msg_bounces, :status, :string
    add_column :msg_bounces, :diagnostic, :string
  end
end
