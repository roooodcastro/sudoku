class SetPuzzleColumnsToUniq < ActiveRecord::Migration[6.0]
  def change
    change_column :puzzles, :name, :string, unique: true
    change_column :puzzles, :slug, :string, unique: true
  end
end
