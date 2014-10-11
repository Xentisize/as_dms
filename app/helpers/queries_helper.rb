module QueriesHelper
  def assign_school(id)
    doc = SchoolDocument.find(id)
  end

end
