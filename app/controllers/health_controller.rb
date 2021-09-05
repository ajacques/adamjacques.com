class HealthController < ApplicationController
  def ping
    render plain: 'Healthy'
  end
end
