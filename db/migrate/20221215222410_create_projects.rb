class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :participant_limit
      t.boolean :is_winner
      t.boolean :is_open
      t.references :user,  null: true

      t.timestamps
    end

    create_join_table(:projects, :users, table_name: :participants) do |t|
      t.index :project_id
      t.index :user_id
      t.integer :role, default: 0

      t.timestamps
    end

  end
end

