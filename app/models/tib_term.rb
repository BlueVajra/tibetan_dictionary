class TibTerm < ActiveRecord::Base
  has_many :definitions, inverse_of: :tib_term

  validates :wyl, presence: {message: "cannot be blank."}
  validates :wyl, uniqueness: {message: "This term already exists, please check the spelling"}

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("wyl like ?", "%#{query}%")
  end
end