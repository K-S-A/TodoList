class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render nothing: true, status: 404
  end
end
