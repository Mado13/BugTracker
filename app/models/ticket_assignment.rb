class TicketAssignment < ApplicationRecord
  # Belongs to a ticket and a developer(User)
  belongs_to :ticket
  belongs_to :developer, class_name: 'User', foreign_key: :developer_id
end
