class Position < ActiveRecord::Base

  belongs_to :user
  has_many :shifts
end
