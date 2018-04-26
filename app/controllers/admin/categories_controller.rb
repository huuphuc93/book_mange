class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: [:update, :edit, :destroy]
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Succeed create category"
    else
      flash[:error] = "Failed create category"
    end
    redirect_to admin_categories_path
  end
  
  def index
    @q = Category.search(params[:q])
    @categories = @q.result(distinct: true).desc_at_create.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.xls
    end
  end
  
  def update
    if @category.update_attributes category_params
      flash[:success] = "Succeed update category"
    else
      flash[:error] = "Failed update category"
    end
    redirect_to admin_categories_path
  end
  
  def destroy
    if @category.destroy
      flash[:success] = "Succeed delete category"
    else
      flash[:error] = "Failed delete category"
    end
    redirect_to admin_categories_path
  end
  
  private
  
  def category_params
    params.require(:category).permit :name
  end
  
  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:error] = "Can't find this category with id: #{params[:id]}"
    redirect_to admin_categories_path
  end
end
