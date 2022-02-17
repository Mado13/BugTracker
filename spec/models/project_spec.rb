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
      first_name: "Project",
      last_name: "Manager",
      role: project_manager,
      email: "PM@CRM.com",
      password: "asdfasdf"
    )
  }

  let(:lead_developer_user) {
    User.create(
      first_name: "Lead",
      last_name: "Developer",
      role: lead_developer,
      email: "LD@CRM.com",
      password: "asdfasdf"
    )
  }

  let(:project) {
    Project.create(
      title: "Testing Project",
      description: "Project created for testing purposes",
      project_manager: project_manager_user,
      lead_developer: lead_developer_user
    )
  }

  it "Is valid with all attributes provided" do
    expect(project).to be_valid
  end

  it "Belongs to a Project Manager" do
    expect(project.project_manager).to eq(project_manager_user)
  end

  it "Belongs to a Lead Developer" do
    expect(project.lead_developer).to eq(lead_developer_user)
  end

  it "Has many tickets" do
    ticket1 = Ticket.create(title: 'Ticket1', lead_developer_id: lead_developer_user.id, project_id: project.id)
    ticket2 = Ticket.create(title: 'Ticket2', lead_developer_id: lead_developer_user.id, project_id: project.id)
    expect(project.tickets).to eq([ticket1, ticket2])
  end

end
