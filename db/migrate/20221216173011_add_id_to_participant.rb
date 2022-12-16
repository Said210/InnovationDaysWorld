class AddIdToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :id, :primary_key
  end
end
