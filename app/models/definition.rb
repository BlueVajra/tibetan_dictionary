class Definition < ActiveRecord::Base
  belongs_to :tib_term, inverse_of: :definitions
  belongs_to :glossary

  validates :entry, presence: {message: 'cannot be blank.'}
  validates :glossary_id, presence: {message: 'glossary_id cannot be blank.'}
  validates :tib_term_id, presence: {message: 'term_id cannot be blank.'}

  def self.available_for_term(term, user)
    all_records = where(term_id: term).includes(:glossary)
    all_records.select do |definition|
      definition.glossary.private == false || definition.glossary.user == user
    end
  end

end