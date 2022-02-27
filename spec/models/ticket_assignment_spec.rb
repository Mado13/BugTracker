require 'rails_helper'

RSpec.describe TicketAssignment, type: :model do
  let(:developer) {
    Role.create(name: "Developer")
  }
  let(:project_manager) {
    Role.create(name: "Project Manager")
  }
  let(:lead_developer) {
    Role.create(name: "Lead Developer")
  }

  let(:project_manager_user) {
    User.create(first_name: "Siri", last_name: "Watasir", role: project_manager, email: "siri@example.com", password: 'Password')
  }

  let(:lead_developer_user) {
    User.create(first_name: "Tan", last_name: "Watasir", role: lead_developer, email: "tan@example.com", password: 'Password')
  }

  let(:developer_user) {
    User.create(first_name: "Melissa", last_name: "De la Cruz", role: developer, email: "meli@example.com", password: 'Password')
  }

  let(:project) {
    Project.create(title: "Logistics Program", description: "Blah blah blah blah blah.", project_manager: project_manager_user, lead_developer: lead_developer_user)
  }



  let(:ticket) {
    Ticket.create(title: "issue1", description: "hahahahahahahahah", lead_developer_id: lead_developer_user.id, project_id: project.id,status: 'Open', category: 'Bug', priority: 'Critical')
  }

  let(:ticket_assignment) {
    TicketAssignment.create(ticket: ticket, developer: developer_user)
  }

  it "is valid with a title, description, project_id, lead_developer_id, priority, status and category" do
    expect(ticket_assignment).to be_valid
  end

  it "belongs to one ticket" do
    expect(ticket_assignment.ticket).to eq(ticket)
  end

  it "belongs to one developer" do
    expect(ticket_assignment.developer).to eq(developer_user)
  end

end
