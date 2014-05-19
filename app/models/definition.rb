class Definition < ActiveRecord::Base
  belongs_to :tib_term, inverse_of: :definitions
  belongs_to :glossary

  validates :entry, presence: {message: 'cannot be blank.'}
  validates :glossary_id, presence: {message: 'glossary_id cannot be blank.'}
  validates :tib_term_id, presence: {message: 'term_id cannot be blank.'}
end