require 'rails_helper'

RSpec.describe Ticket, type: :model do
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
    User.create(
      first_name: "Siri",
      last_name: "Watasir",
      role: project_manager,
      email: "siri@example.com",
      password: "password"
    )
  }

  let(:lead_developer_user) {
    User.create(
      first_name: "Tan",
      last_name: "Watasir",
      role: lead_developer,
      email: "tan@example.com",
      password: "password"
    )
  }

  let(:project) {
    Project.create(
      title: "Logistics Program",
      description: "Blah blah blah blah blah.",
      project_manager: project_manager_user,
      lead_developer: lead_developer_user)
  }

  let(:ticket) {
    Ticket.create(
      title: "issue1",
      description: "hahahahahahahahah",
      lead_developer_id: lead_developer_user.id,
      project_id: project.id,
      priority: "Low",
      status: "Closed",
      category: "Bug")
  }

  it "is valid with a title, description, project_id, lead_developer_id, priority, status and category" do
    expect(ticket).to be_valid
  end

  it "belongs to one Lead Developer" do
    expect(ticket.lead_developer).to eq(lead_developer_user)
  end

  it "belongs to one project" do
    expect(ticket.project).to eq(project)
  end

  it "has many ticket_assignments and has many developers" do
    carmen = User.create(
      first_name: "Carmen",
      last_name: "Marino",
      role: developer,
      email: "carmen@example.com",
      password: "password"
    )
    luismi = User.create(
      first_name: "Luis",
      last_name: "De la Cruz",
      role: developer,
      email: "luismi@example.com",
      password: "password"
    )
    ticket_assignment1 = TicketAssignment.create(ticket: ticket, developer: carmen)
    ticket_assignment2 = TicketAssignment.create(ticket: ticket, developer: luismi)
    expect(ticket.ticket_assignments).to eq([ticket_assignment1, ticket_assignment2])
    expect(ticket.developers).to eq([carmen, luismi])
  end

  it "has many comments" do
    comment_1 = Comment.create(ticket: ticket, user: project_manager_user, comment: "hello")
    comment_2 = Comment.create(ticket: ticket, user: lead_developer_user, comment: "hello again")
    expect(ticket.comments.count).to eq(2)
  end
end
