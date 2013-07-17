class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :title
      t.string :playtype
      t.string :difficulty
      t.string :iidxid
      t.integer :exscore
      t.string :bp
      t.string :rate
      t.string :clear

      t.timestamps
    end
  end
end
