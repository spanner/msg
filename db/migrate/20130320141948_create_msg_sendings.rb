class CreateMsgSendings < ActiveRecord::Migration
  def change
    create_table :msg_sendings do |t|

      t.timestamps
    end
  end
end
