class Message
  include Mongoid::Document

  field :to, :type => String
  field :from, :type => String
  field :subject, :type => String
  field :content, :type => String
  field :created_at, :type => DateTime, default: ->{ Time.now }
  field :unread, :type => Boolean, :default => true

  attr_accessible :to, :from, :subject, :content, :unread
  attr_readonly :to, :from, :subject, :content, :created_at

  validates_presence_of :to, :subject, :content
end
