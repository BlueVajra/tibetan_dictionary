class Word < ActiveRecord::Base

  validates :tib, presence: true
  validates :wyl, presence: true

end