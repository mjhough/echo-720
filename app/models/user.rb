class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
  has_many :videos, through: :subjects

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true

  def teacher?
    !!teacher
  end

  def can_access_video(video)
    videos.include?(video)
  end
end




