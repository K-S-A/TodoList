class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: [:create]
  before_action :find_task, only: [:update, :destroy]

  def create
    @task = @project.tasks.create!(task_params)
  end

  def update
    @task.update!(task_params)

    render 'create'
  end

  def destroy
    @task.destroy

    render_with(204)
  end

  private

  def find_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :project_id, :priority_position, :deadline, :completed)
  end
end
