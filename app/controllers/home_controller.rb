class HomeController < ApplicationController
  def resume
    @keypointgroup = KeyPoint.root
    @jobpositions = Job.visible
    @education = Education.visible
    @self = Rails.application.config.user

    expires_in 5.minutes, public: true
    respond_to do |format|
      format.html
      format.text
    end
  end
end
