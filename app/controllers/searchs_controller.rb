class SearchsController < ApplicationController
  def search
    if params[:search]
      @books = Book.searchs(params[:search]).desc_at_create.paginate page: params[:page]
    else
      @books = Book.desc_at_create.paginate page: params[:page]
    end
  end
end
