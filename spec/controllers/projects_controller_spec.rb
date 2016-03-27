require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views

  before(:all) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, user: @user)
    @projects = [@project]
    @alter_project = FactoryGirl.create_list(:project, 2).last
    @invalid_attrs = { title: 'New' }
  end

  let!(:log_in) { sign_in @user }

  let(:error) { 'You need to sign in or sign up before continuing.' }
  let(:log_out) { sign_out @user }

  let(:project_to_json) { to_json(@project) }

  context 'GET index' do
    let!(:call_action) { get :index }

    let(:reset_session) { get :index }
    let(:result) { [project_to_json] }

    include_examples 'for successfull request'
    include_examples 'for assigning instance variable', :projects
    include_examples 'for rendering templates', [:index, :_project]
    include_examples 'for responding with json', :array, :projects
    include_examples 'for not authorized response'
  end

  context 'GET show' do
    let!(:call_action) { get :show, id: @project.id }

    let(:reset_session) { get :show, id: @project.id }
    let(:result) { project_to_json }

    include_examples 'for successfull request'
    include_examples 'for assigning instance variable', :project
    include_examples 'for rendering templates', [:create, :_project]
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

  context 'POST create' do
    before(:all) do
      @valid_attrs = FactoryGirl.attributes_for(:project, user_id: @user.id)
      @project = FactoryGirl.build(:project, @valid_attrs)
    end

    let(:reset_session) do
      post :create, project: FactoryGirl.attributes_for(:project)
    end

    context 'with valid params' do
      let!(:call_action) { post :create, project: @valid_attrs }

      include_examples 'for successfull request'
      include_examples 'for rendering templates', [:create, :_project]
      include_examples 'for not authorized response'
      include_examples 'for saved from', 'a newley created'
      include_examples 'for Project instance'

      it 'assigns new project as @project' do
        [:title, :description, :user_id].each do |param|
          expect(assigns(:project)[param]).to eq(@project[param])
        end
      end

      it 'responds with json-object of @project attributes' do
        expect(json.except('id')).to eq(project_to_json.except('id'))
      end
    end

    context 'with invalid params' do
      let!(:call_action) { post :create, project: @invalid_attrs }

      include_examples 'for render nothing with status', 422
      include_examples 'for assigns @project to nil'
    end
  end

  context 'PATCH/PUT update' do
    before(:all) do
      @valid_attrs = FactoryGirl.attributes_for(:project, id: @project.id)
    end

    let(:reset_session) do
      put :update, id: @project.id, project: @valid_attrs
    end

    context 'with valid params' do
      let!(:call_action) { put :update, id: @project.id, project: @valid_attrs }

      include_examples 'for successfull request'
      include_examples 'for rendering templates', [:update]
      include_examples 'for not authorized response'
      include_examples 'for saved from', 'updated'
      include_examples 'for Project instance'

      it 'assigns updated project to @project' do
        expect(assigns(:project).title).to eq(@valid_attrs[:title])
      end

      it 'responds with json-object of @project attributes' do
        params = [:title, :description, :id]
        expected_json = @valid_attrs.dup.extract!(*params).stringify_keys!

        expect(json).to eq(expected_json)
      end
    end

    context 'with invalid params' do
      let!(:call_action) { put :update, id: @project.id, project: @invalid_attrs }

      include_examples 'for render nothing with status', 422

      it 'fails to update project' do
        expect(assigns(:project)).to eq(@project)
      end
    end
  end

  context 'DELETE destroy' do
    let(:create_project) { FactoryGirl.create(:project, user: @user) }

    context 'with valid project_id' do
      let!(:call_action) { delete :destroy, id: @project.id }

      let(:reset_session) do
        delete :destroy, id: create_project.id
      end

      include_examples 'for successfull request', 'text/plain'
      include_examples 'for render nothing with status', 204
      include_examples 'for not authorized response'
      include_examples 'for Project instance'

      it 'removes project from database' do
        create_project

        expect { reset_session }.to change { Project.count }.by(-1)
      end
    end

    context 'with invalid project_id' do
      let!(:call_action) { delete :destroy, id: 7777 }

      include_examples 'for render nothing with status', 404
      include_examples 'for assigns @project to nil'
    end
  end
end
