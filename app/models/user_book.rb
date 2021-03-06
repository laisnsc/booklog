class UserBook < ApplicationRecord
  include PublicActivity::Model
  tracked owner: :user

  belongs_to :book
  belongs_to :user

  validates :book_id, uniqueness: true

  scope :favorite_books, -> { where(favorite_book: true) }
  scope :favorite_authors, -> { where(favorite_author: true) }
  scope :by_book_status, -> (book_status) { where(book_status: book_status) }
  scope :by_book_id, -> (book_id) { where(book_id: book_id) }

  TO_READ = 0
  READING = 1
  READ = 2

  def read
    self.book_status == READ
  end
end
