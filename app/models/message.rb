class Message
  include Mongoid::Document

  field :to, :type => String
  field :from, :type => String
  field :subject, :type => String
  field :content, :type => String
  field :created_at, :type => DateTime
  field :unread, :type => Boolean

  attr_accessible :to, :from, :subject, :content, :unread

  validates_presence_of :to, :subject, :content
end
