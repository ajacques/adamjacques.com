class Job
	include MongoMapper::Document
	attr_accessible :active, :department, :endDate, :organization

	alias __inspect__ inspect
	def method_missing(method, *arg)
		nil
	end
end