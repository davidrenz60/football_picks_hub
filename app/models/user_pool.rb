class UserPool < ApplicationRecord
  belongs_to :user
  belongs_to :pool
end