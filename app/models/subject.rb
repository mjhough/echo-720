class Subject < ApplicationRecord
  has_many :user_subjects
  has_many :users, through: :user_subjects
  has_many :videos

  validates :title, presence: true

  def user_attributes=(users_attributes)
    raise users_attributes
  end

  def user_emails
    users.pluck(:email).join(', ')
  end

  def user_emails=(user_emails)
    emails = user_emails.split(', ')
    users.clear 
    emails.each do |email|
      user = User.find_by(email: email)
      users << user if user
    end
  end
end
