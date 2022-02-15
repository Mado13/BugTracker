class RenamePeojectManagerIdIdToProjectManager < ActiveRecord::Migration[6.1]
  def change
    change_table :projects do |t|
      t.rename :project_manager_id_id, :project_manager_id
      t.rename :lead_developer_id_id, :lead_developer_id
    end
  end
end
