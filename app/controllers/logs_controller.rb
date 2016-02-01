class LogsController < ApplicationController
  respond_to :html, :xls
  
  def index
    @logs = Log.all
    #redirect_to logs_index_path
    respond_with @logs
  end
  
  def destroy_all
    @logs = Log.all
    @logs.each do |l|
      l.destroy
    end
    redirect_to tasks_path
  end

end
