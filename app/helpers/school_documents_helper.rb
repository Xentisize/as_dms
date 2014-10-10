module SchoolDocumentsHelper

  def has_solutions?(document)
    if document.solutions.size > 0
      "<span class='glyphicon glyphicon-ok'></span>"
    else
      "<span class='glyphicon glyphicon-remove'></span>"
    end
  end

  def has_audios?(document)
    if document.audios.size > 0
      "<span class='glyphicon glyphicon-ok'></span>"
    else
      "<span class='glyphicon glyphicon-remove'></span>"
    end
  end

  def display_school(document)
    "#{document.school.english_name}<br>#{document.school.chinese_name}"
  end

end
