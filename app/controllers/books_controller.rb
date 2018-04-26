class BooksController < ApplicationController
  def show
    @book = Book.find_by id: params[:id]
    if current_user
      @like = Like.find_like(current_user.id, params[:id]) || Like.new
    else
      @like = Like.new
    end
  end
end
