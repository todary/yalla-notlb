class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :friend, class_name: "Friend", foreign_key: "user_id"
  has_many :friend, class_name: "Friend", foreign_key: "friend_id"
  has_many :group
  has_many :order
  has_many :notification
end
