class CreateTicketAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_assignments do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :developer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
