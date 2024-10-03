class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all
  end

  def create
    @tasks =Task.new(task_params)
    @task.user_id = current_user.id
    @task.save
     redirect_to tasks_path

  end

  private

  def task_params
    params.require(:task).permit(:task_title, :working_hours)
  end
end
