class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.references :lead_developer, null: false, foreign_key: { to_table: :users }
      t.references :project, null: false, foreign_key: true
      t.string :priority
      t.string :status
      t.string :category

      t.timestamps
    end
  end
end
