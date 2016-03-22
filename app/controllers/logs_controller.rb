class LogsController < ApplicationController
  respond_to :html, :xls
  
  def index
    @session = Session.find_by token_id: params[:session_id]
    @logs = @session.logs
    #@logs = Log.all
    respond_with @logs
  end

  def new
    @session = Session.find_by token_id: params[:session_id]
    @task = Task.find(params[:id])
  end

  def destroy_all
    @session = Session.find_by token_id: params[:session_id]
    @logs = @session.logs
    #@logs = Log.all
    @logs.each do |l|
      l.destroy
    end
    redirect_to session_path(@session.token_id)
  end

end
