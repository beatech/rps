class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :iidxid
      t.string :djname

      t.timestamps
    end
  end
end
