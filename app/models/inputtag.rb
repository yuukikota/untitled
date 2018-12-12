class Inputtag
  include ActiveModel::Model
  attr_accessor :school, :faculty, :department, :tag1, :tag2, :tag3, :tag4, :tag5, :tag6, :tag7

  def setuniv(school:, faculty:, department:)
    self.school = school
    self.faculty = faculty
    self.department = department
  end
end
