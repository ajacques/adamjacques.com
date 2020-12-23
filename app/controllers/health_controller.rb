class HealthController < ApplicationController
  def ping
    render text: 'Healthy'
  end
end
