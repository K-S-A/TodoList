require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before(:all) do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create_list(:project, 2)
  end
  
  before(:each) do
    sign_in @user
    get :index
  end

  let(:project) { FactoryGirl.create(:project, user: @user) }

  context 'GET index' do
    it 'assigns projects of current user to @projects' do
      expect(assigns(:projects)).to eq([project])
    end

    it 'responds to json format' do
      expect(response.content_type).to eq "application/json"
    end

    it 'responds with success status' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
