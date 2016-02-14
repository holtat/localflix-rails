class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.belongs_to :tv_show, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.datetime :air_date
      t.integer :season
      t.integer :number

      t.timestamps null: false
    end
  end
end
