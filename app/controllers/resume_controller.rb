class ResumeController < ApplicationController
  def resume
    @keypointgroup = KeyPoint.root
    @jobpositions = Job.visible
    @education = Education.visible
    @links = Link.visible

    # Allow NGINX to cache the result temporarily
    expires_in 5.minutes, public: true

    respond_to do |format|
      format.html
      format.text
    end
  end
end
