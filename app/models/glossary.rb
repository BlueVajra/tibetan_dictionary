class Glossary < ActiveRecord::Base
  belongs_to :user
  has_many :definitions

  validates :name, presence: {message: "cannot be blank."}
  validates :name, uniqueness: {message: "This glossary already exists, please choose another name"}

  def to_csv
    CSV.generate do |csv|
      csv_names = ["Term", "Entry"]
      csv << csv_names
      definitions.each do |definition|
        csv << [definition.tib_term.wyl, definition.entry]
      end
    end
  end
end