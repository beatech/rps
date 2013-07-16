class CreatePowers < ActiveRecord::Migration
  def change
    create_table :powers do |t|

      t.timestamps
    end
  end
end
