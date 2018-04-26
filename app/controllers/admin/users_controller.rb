class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:edit, :update, :destroy]
  before_action :check_activated, only: [:create, :update]
  
  def new
    @user = User.new  
  end
  
  def index
    @q = User.search(params[:q])
    @users = @q.result(distinct: true).desc_at_create.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.xls
    end
  end
  
  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Succeed create user"
    else
      flash[:danger] = "Failed create user"
    end
    redirect_to admin_users_path
  end
  
  def update
    if @user.update_attributes user_params
      flash[:success] = "Succeed update user"
    else
      flash[:error] = "Failed update user"
    end
    redirect_to admin_users_path
  end
  
  def destroy
    if @user.destroy
      flash[:success] = "Succeed delete user"
    else
      flash[:error] = "Failed delete user"
    end
    redirect_to admin_users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
  
  def check_activated
    if params[:user][:activated] == "0"
      @user.activated = false
    else
      @user.activated = true
    end
  end
  
  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to admin_users_path
    flash[:error] = "Can't find user with id: #{params[:id]}"
  end
end
