class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_validation :strip_blanks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :glossaries

  store_accessor :settings, :default_glossary
  validates :username, presence: {message: "cannot be blank."}
  validates :username, uniqueness: {message: "This username already exists, please pick another name"}

  protected

  def strip_blanks
    self.username = self.username.strip
  end
end
