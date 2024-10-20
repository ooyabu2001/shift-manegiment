class SearchesController < ApplicationController
  def search
     if params[:task].present?
      if params[:range]== 'task'
       @tasks=Task.where(id: params[:task][:id])
      else
      search_date = Date.current
       @tasks = Task.where(created_at: search_date.all_month)
      end
     else
      redirect_to tasks_path
     end
  end
end
