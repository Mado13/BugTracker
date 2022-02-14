class Ticket < ApplicationRecord
  belongs_to :lead_developer, class_name: "User"
  belongs_to :project
  has_many :ticket_assignments
end
