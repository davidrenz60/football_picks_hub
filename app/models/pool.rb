class Pool < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :user_pools, dependent: :destroy
  has_many :users, through: :user_pools

  accepts_nested_attributes_for :users

  def users_attributes=(users_attributes)
    #handle processing of user emails in the pool controller when new pool is created
  end
end