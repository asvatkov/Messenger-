class User
  include Mongoid::Document

  field :email, type: String
  field :fname, type: String
  field :lname, type: String
  field :dob, type: Date
  field :gender, type: String
  field :last_signin, type: Time
end
