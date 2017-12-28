class Subject < ApplicationRecord
  has_many :user_subjects
  has_many :users, through: :user_subjects
  has_many :videos

  validates :title, presence: true

  def user_attributes=(users_attributes)
    raise users_attributes
  end

  def user_emails
    users.pluck(:emails).first 
  end

  def user_emails=(user_emails)
    byebug
  end

end
