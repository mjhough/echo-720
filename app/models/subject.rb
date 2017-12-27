class Subject < ApplicationRecord
  has_many :user_subjects
  has_many :users, through: :subjects
  has_many :videos

  validates :title, presence: true
end
