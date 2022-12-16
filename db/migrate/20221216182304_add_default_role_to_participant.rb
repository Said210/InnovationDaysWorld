class AddDefaultRoleToParticipant < ActiveRecord::Migration[7.0]
  def change
    change_column_default :participants, :role, 0
  end
end
