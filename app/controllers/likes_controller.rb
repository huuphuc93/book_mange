class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :load_like, except: :create
  
  def create
    @like = Like.new like_params
    @like.user_id = current_user.id
    if @like.save
      flash[:success] = "Succeed like book"
    else
      flash[:danger] = "Failed like book"
    end
    redirect_to book_path(like_params[:book_id])
  end
  
  def destroy
    if @like.destroy
      flash[:success] = "Succeed unlike book"
    else
      flash[:danger] = "Failed unlike book"
    end
    redirect_to book_path(params[:book_id])
  end
  
  private
  
  def like_params
    params.require(:like).permit :book_id
  end
  
  def load_like
    @like = Like.find_by id: params[:id]
    return if @like
    flash[:danger] = "Failed to destroy like with id #{params[:id]}"
    redirect_to root_url
  end
end
