class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  extend FriendlyId
  friendly_id :title, use: :slugged
end
