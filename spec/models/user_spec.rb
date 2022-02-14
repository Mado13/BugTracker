require 'rails_helper'

RSpec.describe User, type: :model do

  context 'model validations' do

    it 'At registration User Must have an email' do
      user = User.new(password: 'asdfasdf', role_id: 24).save
      expect(user).to eq(false)
    end

    it 'At registration Email must be unique' do
      user = User.new(password: 'asdfasdf', role_id: 24, email: "z@dev.com").save
      user2 = User.new(password: 'asdfasdf', role_id: 24, email: "z@dev.com").save
      expect(user2).to eq(false)
    end

  end
end
