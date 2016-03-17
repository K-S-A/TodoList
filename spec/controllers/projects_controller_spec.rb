require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views

  before(:all) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, user: @user)
    @projects = [@project]
    FactoryGirl.create_list(:project, 2)
  end

  before(:each) { sign_in @user }

  let(:json) { JSON.parse(response.body) }
  let(:error) { 'You need to sign in or sign up before continuing.' }
  let(:project_to_json) { @project.attributes.reject { |k, _| k =~ /_/ } }
  let(:log_out) { sign_out @user }

  context 'GET index' do
    before(:each) { get :index }

    include_examples 'for successful json request'
    include_examples 'for assigning instance variable', :projects
    include_examples 'for rendering template', :index

    it 'responds with hash of project attributes' do
      expect(json).to eq([project_to_json])
    end
  end

  context 'GET show' do #, :focus do
    before(:each) { get :show, { id: @project.id } }

    let(:get_show) { get :show, { id: @project.id } }

    include_examples 'for successful json request'
    include_examples 'for assigning instance variable', :project
    include_examples 'for rendering template', :show

    it 'responds with 401 status if user not authorized' do
      log_out
      get_show

      expect(response.status).to eq(401)
      expect(json['error']).to eq(error)
    end

    it 'responds with hash of project attributes' do
      expect(json).to eq(project_to_json)
    end
  end
end
