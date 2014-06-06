class TibTerm < ActiveRecord::Base
  has_many :definitions, inverse_of: :tib_term

  validates :wyl, presence: {message: "cannot be blank."}
  validates :wyl, uniqueness: {message: "This term already exists, please check the spelling"}

  def self.search(query)
    where("wyl like ?", "%#{query}%")
  end

  def self.search_exact(query)
    where(:wyl, query)
  end

  def definitions_for_user(user)
    definitions.joins(:glossary).where(['"glossaries"."user_id" = ? or "glossaries"."private" is false', user.id])
  end




end