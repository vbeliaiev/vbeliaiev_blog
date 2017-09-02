require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      login_user(user, sign_in_path)
    end

    it 'render sign up page' do
      get :new
      expect(response).to render_template :new
    end
  end
end
