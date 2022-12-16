class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :edition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
