class Public::SearchesController < ApplicationController


  def search
    @tasks = current_user.tasks
    @tasks = @tasks.where('task_title LIKE ?', "%#{params[:task_title]}%") if params[:task_title].present?
    render 'tasks/index'
    #start_date = params[:month].to_date
    #redirect_to tasks_path(task_title: params[:task_title], start_date)
    #  else
    #  search_date = Date.current
    #   @tasks = Task.where(created_at: search_date.all_month)
    #  end
    # else
    #  redirect_to tasks_path(task)
    # end
  end
end
