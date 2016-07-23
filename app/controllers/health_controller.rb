class HealthController < ActionController::Base
  def ping
    render text: 'Healthy'
  end
end
