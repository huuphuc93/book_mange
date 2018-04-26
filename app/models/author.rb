class Author < ApplicationRecord
  has_many :books
  scope :desc_at_create, -> {order(created_at: :desc)}
end
