class CreateEditions < ActiveRecord::Migration[7.0]
  def change
    create_table :editions do |t|
      t.timestamp :begin_at
      t.timestamp :end_at
      t.string :name

      t.timestamps
    end


  end
end
