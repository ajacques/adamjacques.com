class Resume
  attr_reader :key_points, :jobs, :education, :links

  def initialize
    @key_points = KeyPoint.root
    @jobs = Job.visible
    @education = Education.visible
    @links = Link.visible
  end

  def sub_title
    Info.find_by(key: 'sub_title').value
  end
end
