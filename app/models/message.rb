class Message
  include Mongoid::Document

  before_save :set_time

  field :to, :type => String
  field :from, :type => String
  field :subject, :type => String
  field :content, :type => String
  field :created_at, :type => DateTime#, default: ->{ Time.now }
  field :unread, :type => Boolean, :default => true

  attr_accessible :to, :from, :subject, :content, :unread
  # TODO: bug. created_at is not read-only. will be updated on removing unread flag.
  attr_readonly :to, :from, :subject, :content#, :created_at

  validates_presence_of :to, :from, :subject, :content

  validates_length_of :subject, :maximum => 100
  validates_length_of :content, :maximum => 1000

  private
  def set_time
    self.created_at = Time.now
  end
end
