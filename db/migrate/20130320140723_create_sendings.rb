class CreateSendings < ActiveRecord::Migration
  def change
    create_table :sendings do |t|

      t.timestamps
    end
  end
end
