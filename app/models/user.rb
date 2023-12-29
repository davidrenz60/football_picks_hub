class User < ApplicationRecord
  has_many :user_pools, dependent: :destroy
  has_many :pools, through: :user_pools

  has_many :created_pools, class_name: 'Pool', foreign_key: 'creator_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
