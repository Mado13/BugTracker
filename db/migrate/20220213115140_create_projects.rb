class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.references :project_manager_id, foreign_key: { to_table: :users }
      t.references :lead_developer_id, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
