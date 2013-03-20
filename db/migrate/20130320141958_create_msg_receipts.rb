class CreateMsgReceipts < ActiveRecord::Migration
  def change
    create_table :msg_receipts do |t|

      t.timestamps
    end
  end
end
