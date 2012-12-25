class HomeController < ApplicationController
	def resume
		@keypointgroup = KeyPoint.where(:active => true).sort(:sort)
		@jobpositions = Job.where(:active => true).sort(:start_date => -1)
		@education = Education.where(:active => true).sort(:start_Date => -1)
	end
end