class CreatePowers < ActiveRecord::Migration
  def change
    create_table :powers do |t|
      t.string :score8
      t.string :title8
      t.string :score9
      t.string :title9
      t.string :score10
      t.string :title10
      t.string :score11
      t.string :clear11
      t.string :score12
      t.string :clear12
      t.string :score_total
      t.string :clear_total
      t.string :iidxid
      t.date :date

      t.timestamps
    end
  end
end
