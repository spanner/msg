class SendingCircumstances < ActiveRecord::Migration
  def change
    add_column :msg_sendings, :receiving_class, :string
    add_column :msg_sendings, :receiving_group, :string
  end
end
