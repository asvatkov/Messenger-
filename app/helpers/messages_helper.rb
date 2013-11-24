module MessagesHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def inbox_count
    current_user ? Message.where(:to => current_user.email).count : 0
  end

  def outbox_count
    current_user ? Message.where(:from => current_user.email).count : 0
  end

  def recipients
    User.where(:activation_state => 'active')
  end

  def user_path_by_email(email)
    user = User.where(:email => email).first
    user_path(user) if user
  end
end
