class TibTerm < ActiveRecord::Base
  has_many :definitions, inverse_of: :tib_term

  validates :wyl, presence: {message: "cannot be blank."}
  validates :wyl, uniqueness: {message: "This term already exists, please check the spelling"}
end