class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @session = Session.find_by token_id: params[:session_id]
  end

  def edit
    @session = Session.find_by token_id: params[:session_id]
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @session = Session.find_by token_id: params[:session_id]
    @task.session = @session
    if @task.save
      redirect_to session_path(@session.token_id)
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    @session = Session.find_by token_id: params[:session_id]
    if @task.update(task_params)
      redirect_to session_path(@session.token_id)
      #redirect_to tasks_path
    else
      ##redirect_to @task
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @session = Session.find_by token_id: params[:session_id]
    if @task.destroy
      redirect_to session_path(@session.token_id)
    else
      render 'edit'
    end
  end

  def choice
    @task = Task.find(params[:id])
    @session = Session.find_by token_id: params[:session_id]

    # Stop running task(s)
    stop_tasks

    # Start the new task
    Log.create(taskname: @task.name,
               start: Time.now,
               stop: nil,
               active: true,
               settings: "Description: " + params[:description] + "\n" +
                         "Invoiceable: " + (params[:invoiceable] ? "yes" : "no") + "\n" + 
                         ApplicationHelper.sanitize_yaml(@task.settings),
               session_id: @session.id)
    
    # Mark current task as actively logged, with start-time noted.
    @task.activated = Time.now
    @task.save

    # Reload page.
    redirect_to session_path(@session.token_id)
  end

  def stop
    @session = Session.find_by token_id: params[:session_id]

    # Stop running task(s)
    stop_tasks

    # Stay at index page
    redirect_to session_path(@session.token_id)
  end

  private
    def task_params
      params.require(:task).permit(:name, :settings)
    end

    def stop_tasks
      # Stop the currently running task, if there is one.
      # (actually stops all running tasks, but only one ought to be running at a given time)
      # ..and now, since multiple sessions are being implemented, more than one task can
      # definitely be running.
      # So we're limiting task-stopping by session.

      @session = Session.find_by token_id: params[:session_id]
      active_logs = @session.logs.where(active: true)
      #active_logs = Log.where(active: true)
      now = Time.now
      active_logs.each do |log|
        log.active = false
        log.stop = now
        log.save
      end
      
      # Mark all (presumably one) currently active tasks as inactive
      active_tasks = @session.tasks.where.not(activated: nil)
      active_tasks.each do |task|
        task.activated = nil
        task.save
      end
    end
end
