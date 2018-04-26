class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :books, through: :book_categories
  scope :top_categories, -> {
    where(id: BookCategory.order("COUNT(*)").group(:category_id).limit(10).pluck(:category_id))
  }
  scope :desc_at_create, -> {order(created_at: :desc)}
end
