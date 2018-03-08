class TasklistsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    
    if @tasklist.save
      flash[:success] = 'タスクを投稿しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクを投稿できませんでした'
      render 'toppage/index'
    end
    
  end

  def destroy
    @tasklist.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def tasklist_params
    params.require(:tasklist).permit(:content)
  end
  
  def correct_user
    @tasklist = current_user.tasklists.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_url
    end
  end
end
