class User
  include Mongoid::Document

  field :email, type: String
  field :fname, type: String
  field :lname, type: String
  field :dob, type: Date
  field :gender, type: String

  authenticates_with_sorcery!

  attr_accessible :email, :fname, :lname, :dob, :gender, :password, :password_confirmation

  validates_date :dob, :before => lambda { 5.years.ago },
                                 :before_message => "must be at least 18 years old",
                                 :on_or_after => lambda { 105.years.ago },
                                 :on_or_after_message => "must be less than 105 yeas old"
  validates_length_of :password, :minimum => 3, :if => :password
  validates_confirmation_of :password, :if => :password

  validates_uniqueness_of :email

  validates_presence_of :fname, :lname, :dob, :gender

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  # TODO: bug. gender invalidated. possible to change form to submit any value to gender
  # validates_inclusion_of :gender, :in => ['M', 'F']

  validates_length_of :email, :maximum => 30
  validates_length_of :fname, :maximum => 30
  validates_length_of :lname, :maximum => 30

  def name_with_email
    "#{fname} #{lname} <#{email}>"
  end
end
