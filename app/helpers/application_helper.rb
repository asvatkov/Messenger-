module ApplicationHelper
  def unread_count
    current_user ? unread.count : 0
  end

  def unread
    Message.where(:to => current_user.email).where(:unread => true)
  end
end
