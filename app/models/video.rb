class Video < ApplicationRecord
  belongs_to :subject

  validates :image, presence: true
  validates :title, presence: true
  validates :description, length: { minimum: 100 }

end
