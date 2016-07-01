module ApplicationHelper
  def full_name
    Rails.application.config.user.name
  end
end
