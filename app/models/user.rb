class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy
  attachment :profile_image
  has_many :favorites, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :introduction, length: { maximum: 100 }
end
