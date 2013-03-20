class CreateBounces < ActiveRecord::Migration
  def change
    create_table :bounces do |t|

      t.timestamps
    end
  end
end
