class Admin::AuthorsController < Admin::BaseController
  before_action :load_author, only: [:update, :edit, :destroy]
  
  def new
    @author = Author.new
  end
  
  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = "Succeed create author"
    else
      flash[:error] = "Failed create author"
    end
    redirect_to admin_authors_path
  end
  
  def index
    @q = Author.search(params[:q])
    @authors = @q.result(distinct: true).desc_at_create.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.xls
    end
  end
  
  def update
    if @author.update_attributes author_params
      flash[:success] = "Succeed update author"
    else
      flash[:error] = "Failed update author"
    end
    redirect_to admin_authors_path
  end
  
  def destroy
    if @author.destroy
      flash[:success] = "Succeed delete author"
    else
      flash[:error] = "Failed delete author"
    end
    redirect_to admin_authors_path
  end
  
  private
  
  def author_params
    params.require(:author).permit :name
  end
  
  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:error] = "Can't find this author with id: #{params[:id]}"
    redirect_to admin_authors_path
  end
end
