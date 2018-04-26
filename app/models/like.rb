class Like < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  private
  
  def self.find_like user_id, book_id 
    find_by user_id: user_id, book_id: book_id
  end
end
  