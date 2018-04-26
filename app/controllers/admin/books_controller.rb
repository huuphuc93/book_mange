class Admin::BooksController < Admin::BaseController
  before_action :load_book, only: [:edit, :update, :destroy]
  
  def new
    @book = Book.new
    @book.book_categories.build
  end
  
  def index
    @q = Book.search(params[:q])
    @books = @q.result(distinct: true).desc_at_create.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.xls
    end
  end
  
  def create

    @book = Book.new book_params
    if @book.save
      flash[:success] = "Succeed create book"
    else
      flash[:danger] = "Failed create book"
    end
    redirect_to admin_books_path
  end
  
  def update
    if @book.update_attributes book_params
      flash[:success] = "Succeed update book"
    else
      flash[:error] = "Failed update book"
    end
    redirect_to admin_books_path
  end
  
  def destroy
    if @book.destroy
      flash[:success] = "Succeed delete user"
    else
      flash[:error] = "Failed delete user"
    end
    redirect_to admin_books_path
  end
  private
  
  def book_params
    params.require(:book).permit :title, :publisher, :describe, :author_id, :cover_image,
      [book_categories_attributes: [:id, :category_id]]
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    redirect_to admin_books_path
    flash[:error] = "Can't find book with id: #{params[:id]}"
  end
end