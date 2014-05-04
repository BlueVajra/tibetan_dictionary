class TibTerm < ActiveRecord::Base
  has_many :definitions, inverse_of: :tib_term
end