require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  include_context 'logged in user'

  before(:all) do
    @projects = [@project]
    @alter_project = FactoryGirl.create_list(:project, 2).last
    @valid_attrs = FactoryGirl.attributes_for(:project, user_id: @user.id)
    @invalid_attrs = FactoryGirl.attributes_for(:invalid_project)
  end

  context 'GET #index' do
    let!(:call_action) { get :index }

    let(:reset_session) { get :index }
    let(:result) { [to_json(@project)] }

    include_examples 'for successfull request'
    include_examples 'for assigning instance variable', :projects
    include_examples 'for rendering templates', [:index, :_project]
    include_examples 'for responding with json', :array, :projects
    include_examples 'for not authorized response'
  end

  context 'GET #show' do
    let!(:call_action) { get :show, id: @project.id }

    let(:reset_session) { get :show, id: @project.id }
    let(:result) { to_json(@project) }

    include_examples 'for successfull request'
    include_examples 'for assigning instance variable', :project
    include_examples 'for rendering templates', [:show]
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

  context 'POST #create' do
    before(:all) do
      @project = FactoryGirl.build(:project, @valid_attrs)
    end

    let(:reset_session) do
      post :create, project: FactoryGirl.attributes_for(:project)
    end

    context 'with valid params' do
      let!(:call_action) { post :create, project: @valid_attrs }

      include_examples 'for successfull request'
      include_examples 'for rendering templates', [:create]
      include_examples 'for not authorized response'
      include_examples 'for saved from', 'a newley created', 'project'
      include_examples 'for new instance', 'project'
      include_examples 'for instance params',
                       %w(title description user_id), :project

      it 'responds with json-object of @project attributes' do
        expect(json.except('id')).to eq(to_json(@project).except('id'))
      end
    end

    context 'with invalid params' do
      let!(:call_action) { post :create, project: @invalid_attrs }

      include_examples 'for render nothing with status', 422
      include_examples 'for assigning instance variable to nil', 'project'
    end
  end

  context 'PATCH/PUT #update' do
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
      include_examples 'for saved from', 'updated', 'project'
      include_examples 'for new instance', 'project'

      it 'assigns updated project to @project' do
        expect(assigns(:project).title).to eq(@valid_attrs[:title])
      end

      it 'responds with json-object of @project attributes' do
        expected_json = extract_json(@valid_attrs, [:title, :description, :id])

        expect(json).to eq(expected_json)
      end
    end

    context 'with invalid params' do
      let!(:call_action) { put :update, id: @project.id, project: @invalid_attrs }

      include_examples 'for render nothing with status', 422
      include_examples 'for failed update of', :project
    end
  end

  context 'DELETE #destroy' do
    let(:create_other) { FactoryGirl.create(:project, user: @user) }

    context 'with valid params' do
      let!(:call_action) { delete :destroy, id: @project.id }

      let(:reset_session) do
        delete :destroy, id: create_other.id
      end

      include_examples 'for successfull request', 'text/plain'
      include_examples 'for render nothing with status', 204
      include_examples 'for not authorized response'
      include_examples 'for new instance', 'project'
      include_examples 'for removing of', 'project'
    end

    context 'with invalid params' do
      let!(:call_action) { delete :destroy, id: 7777 }

      include_examples 'for render nothing with status', 404
      include_examples 'for assigning instance variable to nil', 'project'
    end
  end
end
