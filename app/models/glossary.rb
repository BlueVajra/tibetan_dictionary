class Glossary < ActiveRecord::Base
  belongs_to :user
  has_many :definitions

  validates :name, presence: {message: "cannot be blank."}
  validates :name, uniqueness: {message: "This glossary already exists, please choose another name"}

end