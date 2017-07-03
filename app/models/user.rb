class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :welcome_send
  after_initialize :init
  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators

  enum role: [:admin, :standard, :premium]

  def welcome_send
    WelcomeMailer.welcome_send(self).deliver_now
  end

  def init
    self.role ||= :standard
  end
end
