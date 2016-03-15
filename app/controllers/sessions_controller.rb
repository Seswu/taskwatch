class SessionsController < ApplicationController

  def index
    if params["session_token"]
      redirect_to session_path(params["session_token"])
    end
    #redirect_to new_session_path
  end
  
  def new
    @session = Session.new
    @session.save
    redirect_to session_path(@session.token_id)
  end
  
  def show
    @session = Session.find_by token_id: params[:id]
    @tasks = @session.tasks
    #@tasks = Task.all
  end

end
