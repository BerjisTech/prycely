class Account < ApplicationRecord
  belongs_to :user
  has_many :members
  has_one_attached :image, :dependent => :destroy
end
