require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views

  before(:all) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, user: @user)
    @projects = [@project]
    FactoryGirl.create_list(:project, 2)
  end

  let!(:log_in) { sign_in @user }

  let(:json) { JSON.parse(response.body) }
  let(:error) { 'You need to sign in or sign up before continuing.' }
  let(:project_to_json) { @project.attributes.reject { |k, _| k =~ /_/ } }
  let(:log_out) { sign_out @user }

  context 'GET index' do
    before(:each) { get :index }

    let(:result) { [project_to_json] }

    let(:reset_session) do
      log_out
      get :index
    end

    include_examples 'for successful json request'
    include_examples 'for assigning instance variable', :projects
    include_examples 'for rendering template', :index
    include_examples 'for responding with json', :array, :projects
    include_examples 'for not authorized response'
  end

  context 'GET show' do
    before(:each) { get :show, id: @project.id }

    let(:result) { project_to_json }

    let(:reset_session) do
      log_out
      get :show, id: @project.id
    end

    include_examples 'for successful json request'
    include_examples 'for assigning instance variable', :project
    include_examples 'for rendering template', :show
    include_examples 'for responding with json', :hash, :project
    include_examples 'for not authorized response'
  end
end
