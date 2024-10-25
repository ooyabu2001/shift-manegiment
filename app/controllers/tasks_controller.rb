class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = current_user.tasks
    @tasks = @tasks.where('task_title LIKE ?', "%#{params[:task_title]}%") if params[:task_title].present?
    params[:start_date] = Date.current.to_s unless params[:start_date].present?
    current_date = Date.parse(params[:start_date])
    @months = (-3..3).map do |i|
      date = current_date.beginning_of_month.since(i.months)
      ["#{date.year}/#{date.month}", date]
    end
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
