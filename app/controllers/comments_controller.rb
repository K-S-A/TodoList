class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:create]  
  before_action :find_comment, only: [:update, :destroy]

  def create
    @comment = @task.comments.create!(comment_params)
  end

  def update
    @comment.update!(comment_params)

    render 'create'
  end

  def destroy
    @comment.destroy

    render_with(204)
  end

  private

  def find_comment
    @comment = current_user.comments.find(params[:id])
  end

  def find_task
    @task = current_user.tasks.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :file_link)
  end
end
