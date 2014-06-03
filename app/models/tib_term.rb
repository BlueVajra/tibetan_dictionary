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
    all_records = definitions.includes(:glossary)
    all_records.select do |definition|
      definition.glossary.private == false || definition.glossary.user == user
    end
  end

end