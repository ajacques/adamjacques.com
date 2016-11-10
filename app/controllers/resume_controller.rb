class ResumeController < ApplicationController
  def resume
    @resume = Resume.new

    # Allow NGINX to cache the result temporarily
    expires_in 5.minutes, public: true

    respond_to do |format|
      format.html
      format.text
    end
  end
end
