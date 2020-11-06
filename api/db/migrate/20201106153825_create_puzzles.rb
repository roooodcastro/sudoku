class CreatePuzzles < ActiveRecord::Migration[6.0]
  def change
    create_table :puzzles, id: :uuid do |t|
      t.string :name
      t.string :author
      t.string :definition
      t.string :slug

      t.timestamps
    end
  end
end
