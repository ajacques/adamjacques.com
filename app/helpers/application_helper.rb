module ApplicationHelper
  def full_name
    Rails.application.appconfig.name
  end
end
