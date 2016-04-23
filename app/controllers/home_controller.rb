class HomeController < ApplicationController
  def resume
    @keypointgroup = KeyPoint.joins(:parent).where(active: true, parents_key_points: {value: 'root'}).order(:sort)
    @jobpositions = Job.includes(:responsibilities, :location, :organization).order('start_date DESC').active
    @education = Education.where(active: true)

    expires_in 5.minutes, public: true
    respond_to do |format|
      format.html
      format.text
    end
  end
end
