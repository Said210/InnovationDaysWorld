class AddEditionToProject < ActiveRecord::Migration[7.0]
  def change
    add_reference :projects, :edition, foreign_key: true

    # add edtion to participants table
    add_reference :participants, :edition, foreign_key: true
  end
end
