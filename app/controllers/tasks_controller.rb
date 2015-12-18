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
		#@task = Task.new(params[:task])
		@task.save
		redirect_to tasks_path
		#if @task.save
		#	redirect_to @task
		#else
		#	render 'new'
		#end
	end
	
	def update
		@task = Task.find(params[:id])
		@task.update(task_params)
		redirect_to tasks_path
		#fd = IO.sysopen "errors.log", "w"
		#ios = IO.new(fd, "w")
		#ios.puts "File written."
		#ios.puts params[:id]
		#@task = Task.find(params[:id])
		#if @task.update(params[:task])
		#	redirect_to @task
		#	ios.puts "Task updated."
		#else
		#	render 'edit'
		#	ios.puts "Task not updated."
		#end
		#ios.puts "File closed."
		#ios.close
	end
	
	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to tasks_path
	end
	
	private
		def task_params
			params.require(:task).permit(:name, :settings)
		end
end
