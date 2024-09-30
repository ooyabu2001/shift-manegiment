class TasksController < ApplicationController
  def index
    #@tasks =Task
    @tasks = Task.all
  end
end
