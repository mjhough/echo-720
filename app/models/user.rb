class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
  has_many :videos, through: :subjects

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :omniauthable, omniauth_providers: %i(microsoft_office365)

  validates :email, presence: true

  def students
    where(teacher: false)
  end

  def teacher?
    !!teacher
  end

  def can_access_video(video, subject)
    videos.include?(video) && subjects.include?(subject)
  end

  def can_access_subject(subject)
    subjects.include?(subject)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.microsoft_office365_data'] && session['devise.microsoft_office365_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end




