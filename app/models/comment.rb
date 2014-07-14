class Comment < ActiveRecord::Base
  belongs_to :tib_term
  belongs_to :user
end
