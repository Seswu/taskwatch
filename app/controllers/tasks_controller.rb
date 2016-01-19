class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      #redirect_to @task
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task
      #redirect_to tasks_path
    else
      ##redirect_to @task
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def choice
    # Stop running task(s)
    stop_tasks

    # Start the new task
    @task = Task.find(params[:id])
    Log.create(taskname: @task.name, start: Time.now, stop: nil, active: true, settings: @task.settings)
    redirect_to tasks_path
  end

  def stop
    # Stop running task(s)
    stop_tasks

    # Stay at index page
    redirect_to tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:name, :settings)
    end

    def stop_tasks
      # Stop the currently running task, if there is one.
      # (actually stops all running tasks, but only one ought to be running at a given time)
      active_logs = Log.where(active: true)
      now = Time.now
      active_logs.each do |log|
        log.active = false
        log.stop = now
        log.save
      end
    end
end
