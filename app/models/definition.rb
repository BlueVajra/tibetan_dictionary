class Definition < ActiveRecord::Base
  belongs_to :tib_term, inverse_of: :definitions

  validates :entry, presence: {message: 'cannot be blank.'}
  validates :name, presence: {message: 'cannot be blank.'}
end