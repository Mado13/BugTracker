require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  login_user

  let(:valid_attributes) {
    { title: "Test Title", description: "Some Description" }
  }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'Returnes a success response' do
      Project.create! valid_attributes
      get :index, params: {}, session: valid_session

      expect(response).to be_successful
    end
  end
end
