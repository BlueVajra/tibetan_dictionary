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

  def create_definitions_from_csv(file, limit=1000)
    Glossary.transaction do
      CSV.open(file.path, headers: true) do |csv_file|
        if csv_file.count > limit
          raise RangeError, "You may not have more than #{limit} lines. For larger files, please contact the Admin."
        end
        rows = csv_file.each
        rows.rewind
        headers = csv_file.first.headers
        if headers.include?("Term") && headers.include?("Definition")
          rows.rewind
          rows.each do |row|
            term = TibTerm.find_or_create_by(wyl: row["Term"].strip)
            term.definitions.create(entry: row["Definition"].strip, glossary: self)
          end
        else
          raise "Malformed header row"
        end
      end
    end
  end

  def belongs_to?(user)
    self.user == user
  end
end