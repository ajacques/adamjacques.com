class Education
	include MongoMapper::Document

	alias __inspect__ inspect
    def method_missing(method, *arg)
		nil
    end
end