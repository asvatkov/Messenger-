class User
  include Mongoid::Document

  field :email, type: String
  field :fname, type: String
  field :lname, type: String
  field :dob, type: Date
  field :gender, type: String

  authenticates_with_sorcery!

  attr_accessible :email, :fname, :lname, :dob, :gender, :password, :password_confirmation

  # TODO: errors i18n
  validates_length_of :password, :minimum => 3, :message => 'user.error.pwd_length', :if => :password
  validates_confirmation_of :password, :message => 'user.error.pwd_no_match', :if => :password
  validates_uniqueness_of :email, :message => 'user.error.email.not_uniq'
  validates_presence_of :email, :fname, :lname, :dob, :gender
end
