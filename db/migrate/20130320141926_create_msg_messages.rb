class CreateMsgMessages < ActiveRecord::Migration
  def change
    create_table :msg_messages do |t|

      t.timestamps
    end
  end
end
