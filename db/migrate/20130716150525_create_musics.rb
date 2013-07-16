class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :title
      t.integer :level
      t.string :playtype
      t.string :difficulty
      t.integer :notes

      t.timestamps
    end
  end
end
