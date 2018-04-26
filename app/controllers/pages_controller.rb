class PagesController < ApplicationController
  def index
    @books = Book.desc_at_create.paginate page: params[:page], per_page: 10
  end
end
