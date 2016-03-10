class SessionsController < ApplicationController
  def index
    redirect_to new_session_path
  end
  
  def new
    @session = Session.new
    @session.save
  end
  
  def show
    @session = Session.find_by token_id: params[:id]
  end

end
