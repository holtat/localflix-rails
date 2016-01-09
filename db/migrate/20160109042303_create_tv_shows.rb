class CreateTvShows < ActiveRecord::Migration
  def change
    create_table :tv_shows do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.integer :year

      t.timestamps null: false
    end
  end
end
