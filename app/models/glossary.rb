class Glossary < ActiveRecord::Base
  belongs_to :user
  has_many :definitions
end