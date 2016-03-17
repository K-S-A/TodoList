require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views

  before(:all) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, user: @user)
    @projects = [@project]
    @alter_project = FactoryGirl.create_list(:project, 2).last
  end

  let!(:log_in) { sign_in @user }

  let(:json) { JSON.parse(response.body) }
  let(:error) { 'You need to sign in or sign up before continuing.' }
  let(:project_to_json) { @project.attributes.reject { |k, _| k =~ /_/ } }
  let(:log_out) { sign_out @user }

  context 'GET index' do
    let!(:call_action) { get :index }

    let(:reset_session) { get :index }
    let(:result) { [project_to_json] }

    include_examples 'for successful json request'
    include_examples 'for assigning instance variable', :projects
    include_examples 'for rendering template', :index
    include_examples 'for responding with json', :array, :projects
    include_examples 'for not authorized response'
  end

  context 'GET show' do
    let!(:call_action) { get :show, id: @project.id }

    let(:reset_session) { get :show, id: @project.id }
    let(:result) { project_to_json }

    include_examples 'for successful json request'
    include_examples 'for assigning instance variable', :project
    include_examples 'for rendering template', :show
    include_examples 'for responding with json', :hash, :project
    include_examples 'for not authorized response'

    context 'when project does not exist in scope of current user' do
      it 'responds with 404 status' do
        get :show, id: @alter_project.id

        expect(response).to render_template(nil)
        expect(response.status).to eq(404)
      end
    end
  end
end
