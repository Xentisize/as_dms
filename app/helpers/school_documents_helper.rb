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
    "<small>#{document.school.english_name}</small><br><small>#{document.school.chinese_name}</small>"
  end

  def list_categories(document)
    output_html = ""
    document.categories.each do |c|
      output_html << "<dd>#{c.name}</dd>"
    end
    output_html
  end

  def list_question_types(document)
    output_html = ""
    document.question_types.each do |q|
      output_html << "<dd>#{q.name}</dd>"
    end
    output_html
  end

  def list_solutions(document)
    output_html = ""
    if document.solutions.size > 0
      document.solutions.each do |s|
        output_html << "<dd><a href='#{s.solution_file.url}'>Solution File</a></dd>"
        # link_to "Solution File", s.solution_file.url
      end
    end
    output_html
  end

  def list_audios(document)
    output_html = ""
    if document.audios.size > 0
      document.audios.each do |a|
        output_html << "<dd><a href='#{a.audio_file.url}'>Audio File</a></dd>"
      end
    end
    output_html
  end

end
