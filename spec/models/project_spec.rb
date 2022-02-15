require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:project_manager) {
    Role.create(name: 'Project Manager')
  }
  let(:lead_developer) {
    Role.create(name: 'Lead Developer')
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
      lead_developer: lead_developer_user
    )
  }

  it "is valid with a title, description, project_manager and lead_developer" do
    expect(project).to be_valid
  end

  it "belongs to one Project Manager" do
    expect(project.project_manager).to eq(project_manager_user)
  end

  it "belongs to one Project Manager" do
    expect(project.lead_developer).to eq(lead_developer_user)
  end

  it "has many tickets" do
    ticket = Ticket.create(title: "issue1", status:"Open", category: "Enhancement", priority: "Low", lead_developer_id: lead_developer_user.id, project_id: project.id)
    expect(project.tickets).to eq([ticket])
  end

end
