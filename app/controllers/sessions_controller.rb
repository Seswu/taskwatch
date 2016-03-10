class SessionsController < ApplicationController
  def index
    redirect_to new_session_path
  end
  
  def new
    @Session = Session.new
  end
end
