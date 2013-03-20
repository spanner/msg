class CreateMsgBounces < ActiveRecord::Migration
  def change
    create_table :msg_bounces do |t|

      t.timestamps
    end
  end
end
