require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  include_context 'logged in user'

  before(:all) do
    @task = FactoryGirl.build(:task, project: @project)
    @valid_attrs = FactoryGirl.attributes_for(:task, project: @project)
    @invalid_attrs = FactoryGirl.attributes_for(:invalid_task)
  end

  describe 'POST #create' do
    let(:reset_session) do
      post :create, project_id: @project.id,
                    task: FactoryGirl.attributes_for(:task)
    end

    context 'with valid params' do
      let!(:call_action) do
        post :create, project_id: @project.id, task: @task.attributes
      end

      include_examples 'for successfull request'
      include_examples 'for rendering templates', [:update]
      include_examples 'for not authorized response'
      include_examples 'for saved from', 'a newley created', 'task'
      include_examples 'for new instance', 'task'
      include_examples 'for instance params',
                       %w(name deadline completed project_id), :task
      include_examples 'for json-object with attributes of',
                       %w(name deadline completed), 'task'
    end

    context 'with invalid params' do
      let!(:call_action) { post :create, project_id: @project.id, task: @invalid_attrs }

      include_examples 'for render nothing with status', 422
      include_examples 'for assigning instance variable to nil', 'task'
    end
  end

  context 'PATCH/PUT #update' do
    before(:all) do
      @task = FactoryGirl.create(:task, project: @project)
      @valid_attrs = FactoryGirl.attributes_for(:task, id: @task.id)
    end

    let(:reset_session) do
      put :update, id: @task.id, task: @valid_attrs
    end

    context 'with valid params' do
      let!(:call_action) { put :update, id: @task.id, task: @valid_attrs }

      include_examples 'for successfull request'
      include_examples 'for rendering templates', [:update]
      include_examples 'for not authorized response'
      include_examples 'for saved from', 'updated', 'task'
      include_examples 'for new instance', 'task'

      it 'assigns updated task to @task' do
        expect(assigns(:task).name).to eq(@valid_attrs[:name])
      end

      it 'responds with json-object of @task attributes' do
        params = [:id, :name, :deadline, :completed]

        expect(json).to eq(extract_json(@valid_attrs, params))
      end
    end

    context 'with invalid params' do
      let!(:call_action) { put :update, id: @task.id, task: @invalid_attrs }

      include_examples 'for render nothing with status', 422
      include_examples 'for failed update of', :task
    end
  end

  context 'DELETE #destroy' do
    before(:all) do
      @task = FactoryGirl.create(:task, project: @project)
    end

    let(:create_other) { FactoryGirl.create(:task, project: @project) }

    context 'with valid params' do
      let!(:call_action) { delete :destroy, id: @task.id }

      let(:reset_session) do
        delete :destroy, id: create_other.id
      end

      include_examples 'for successfull request', 'text/plain'
      include_examples 'for render nothing with status', 204
      include_examples 'for not authorized response'
      include_examples 'for new instance', 'task'
      include_examples 'for removing of', 'task'
    end

    context 'with invalid params' do
      let!(:call_action) { delete :destroy, id: 7777 }

      include_examples 'for render nothing with status', 404
      include_examples 'for assigning instance variable to nil', 'task'
    end
  end
end
