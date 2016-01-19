class LogsController < ApplicationController
  respond_to :html, :xls
  
  def index
    @logs = Log.all
    #redirect_to logs_index_path
    respond_with @logs
  end
end
