class TasksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
      @tasks = current_user.tasks
  end

  def show
      @task = current_user.tasks.find(params[:id])
  end

  def new
      @task = Task.new
  end

  def create
      @task = current_user.tasks.build(task_params)
      
      if @task.save
        flash[:success] =  '正常に投稿されました'
        redirect_to @task
      else
        flash.now[:danger] = '投稿に失敗しました'
        render :new
      end
  end

  def edit
      @task = current_user.tasks.find(params[:id])
  end

  def update
      @task = current_user.tasks.find(params[:id])
      
      if @task.update(task_params)
        flash[:succcess] = '正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = '更新できませんでした'
        render :edit
      end
  end

  def destroy
      @task = current_user.tasks.find(params[:id])
      @task.destroy
      
      flash[:success] = '削除されました'
      redirect_to tasks_url
  end
  
  private
  
  def task_params
      params.require(:task).permit(:content, :status)
  end

end
