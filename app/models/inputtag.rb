class Inputtag
  include ActiveModel::Model
  attr_accessor :school, :faculty, :department, :tag1, :tag2, :tag3

  def setuniv(school:, faculty:, department:)
    self.school = school
    self.faculty = faculty
    self.department = department
  end
end
