class List < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :bookmarks, dependent: :destroy
  # has_many :movies, through: :bookmarks
  has_many_attached :photos
  has_many :movies, through: :bookmarks
  has_many :reviews, dependent: :destroy
end
