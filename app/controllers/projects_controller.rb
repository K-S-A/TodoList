class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: [:update, :destroy]

  def index
    @projects = current_user.projects.includes(:tasks).order(id: :desc)
  end

  def show
    @project = current_user.projects.includes(tasks: :comments).find(params[:id])
  end

  def create
    @project = current_user.projects.create!(project_params)
  end

  def update
    @project.update!(project_params)
  end

  def destroy
    @project.destroy

    render_with(204)
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
