class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    @books = @category.books.desc_at_create.paginate page: params[:page]
  end
end
