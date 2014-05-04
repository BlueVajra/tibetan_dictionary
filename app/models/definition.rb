class Definition < ActiveRecord::Base
  belongs_to :tib_term, inverse_of: :definitions
end