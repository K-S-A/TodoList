require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include_context 'logged in user'

  before(:all) do
    @task = FactoryGirl.create(:task, project: @project)
    @valid_attrs = FactoryGirl.attributes_for(:comment, task_id: @task.id)
    @invalid_attrs = FactoryGirl.attributes_for(:invalid_comment)
    @comment = FactoryGirl.build(:comment, @valid_attrs)
  end

  describe 'POST #create' do
    let(:reset_session) do
      post :create, task_id: @task.id,
                    comment: FactoryGirl.attributes_for(:comment)
    end

    context 'with valid params' do
      let!(:call_action) do
        post :create, task_id: @task.id, comment: @valid_attrs
      end

      include_examples 'for successfull request'
      include_examples 'for rendering templates', [:create]
      include_examples 'for not authorized response'
      include_examples 'for saved from', 'a newley created', 'comment'
      include_examples 'for new instance', 'comment'
      include_examples 'for instance params',
                       %w(body file_link task_id), :comment
      include_examples 'for json-object with attributes of',
                       %w(body file_link), 'comment'
    end

    context 'with invalid params' do
      let!(:call_action) { post :create, task_id: @task.id, comment: @invalid_attrs }

      include_examples 'for render nothing with status', 422
      include_examples 'for assigning instance variable to nil', 'comment'
    end
  end

  context 'PATCH/PUT #update' do
    before(:all) do
      @comment = FactoryGirl.create(:comment, task: @task)
      @valid_attrs = FactoryGirl.attributes_for(:comment, id: @comment.id)
    end

    let(:reset_session) do
      put :update, id: @comment.id, comment: @valid_attrs
    end

    context 'with valid params' do
      let!(:call_action) { put :update, id: @comment.id, comment: @valid_attrs }

      include_examples 'for successfull request'
      include_examples 'for rendering templates', [:create]
      include_examples 'for not authorized response'
      include_examples 'for saved from', 'updated', 'comment'
      include_examples 'for new instance', 'comment'

      it 'assigns updated comment to @comment' do
        expect(assigns(:comment).body).to eq(@valid_attrs[:body])
      end

      it 'responds with json-object of @comment attributes' do
        params = [:id, :body, :file_link]

        expect(json).to eq(extract_json(@valid_attrs, params))
      end
    end

    context 'with invalid params' do
      let!(:call_action) { put :update, id: @comment.id, comment: @invalid_attrs }

      include_examples 'for render nothing with status', 422
      include_examples 'for failed update of', :comment
    end
  end

  context 'DELETE #destroy' do
    before(:all) do
      @comment = FactoryGirl.create(:comment, task: @task)
    end

    let(:create_other) { FactoryGirl.create(:comment, task: @task) }

    context 'with valid params' do
      let!(:call_action) { delete :destroy, id: @comment.id }

      let(:reset_session) do
        delete :destroy, id: create_other.id
      end

      include_examples 'for successfull request', 'text/plain'
      include_examples 'for render nothing with status', 204
      include_examples 'for not authorized response'
      include_examples 'for new instance', 'comment'
      include_examples 'for removing of', 'comment'
    end

    context 'with invalid params' do
      let!(:call_action) { delete :destroy, id: 7777 }

      include_examples 'for render nothing with status', 404
      include_examples 'for assigning instance variable to nil', 'comment'
    end
  end
end
