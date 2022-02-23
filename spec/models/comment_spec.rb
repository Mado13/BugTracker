require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:admin) {
    Role.create(name: "Admin")
  }
  let(:admin_user) {
    User.create(
      first_name: "Harold",
      last_name: "Torres",
      role: admin,
      email: "harold@example.com",
      password: "abcde12345"
    )
  }
  let(:lead_developer) {
    Role.create(name: "Lead Developer")
  }

  let(:project_manager) {
    Role.create(name: "Project Manager")
  }

  let(:developer) {
    Role.create(name: "Developer")
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

  let(:lead_developer_user_2) {
    User.create(
      first_name: "Carlos",
      last_name: "Martinez",
      role: lead_developer,
      email: "carlos@example.com",
      password: "password"
    )
  }

  let(:developer_user) {
    User.create(
      first_name: "Miguel",
      last_name: "Alzate",
      role: developer,
      email: "migue@example.com",
      password: "password"
    )
  }

  let(:developer_user_2) {
    User.create(
      first_name: "Hernando",
      last_name: "Torres",
      role: developer,
      email: "pa@example.com",
      password: "password"
    )
  }

  let(:project) {
    Project.create(
      title: "Logistics Program",
      description: "Blah blah blah blah blah.",
      project_manager: project_manager_user,
      lead_developer: lead_developer_user
    )
  }

  let(:ticket) {
    Ticket.create(
      title: "issue1",
      description: "hahahahahahahahah",
      lead_developer: lead_developer_user,
      project: project,
      priority: "Low",
      status: "Closed",
      category: "Bug")
  }

  let(:ticket_assignment_to_developer_1) {
    TicketAssignment.create(ticket: ticket, developer: developer_user)
  }

  let(:ticket_assignment_to_developer_2) {
    TicketAssignment.create(ticket: ticket, developer: developer_user_2)
  }

  let(:comment) {
    Comment.create(ticket: ticket, user:admin_user, comment: "hello")
  }


  it "belongs to one ticket" do
    expect(comment.ticket).to eq(ticket)
  end

  it "belongs to one user" do
    expect(comment.user).to eq(admin_user)
  end

end
