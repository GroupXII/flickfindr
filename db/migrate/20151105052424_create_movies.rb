class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :tmdbID
      t.string :synopsis
      t.string :posterPath
      t.string :releaseDate
      t.string :status
      t.decimal :averageScore
      t.integer :numVotes

      t.timestamps null: false
    end
  end
end
