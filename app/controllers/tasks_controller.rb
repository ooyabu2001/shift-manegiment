class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
    @task.start_time = task_params[:working_hours]
  end

  def create
    @task =Task.new(task_params)
    @task.user_id = current_user.id
    @task.start_time =params[:task][:display_date]+ task_params[:working_hours] # シンプルカレンダーで扱うカラムに同じ値を複製する
    # TODO: viewでシンプルカレンダーを呼び出す際にとある指定をするとstart_timeカラム以外のカラムを基準の日付として扱う事が出来る
    @task.save
     redirect_to tasks_path
  end

  

  private

  def task_params
     params.require(:task).permit(:task_title, :working_hours )
  end
end
