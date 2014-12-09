class QueriesController < ApplicationController
  def match_school_name_from_english_or_chinese
    if params[:school] =~ /[A-Za-z]+/
      @school = School.find_by(english_name: params[:school])
    else
      @school = School.find_by(chinese_name: params[:school])
    end
    respond_to do |format|
      format.html { render :json => @school }
      format.json { render :json => @school }
    end
  end

  def index
  end

  def search
    if params[:queries][:subject].present?
      logger.info "Subject: #{params[:queries][:subject]}"
      subject_id = Subject.where(subject: params[:queries][:subject])[0].id
    # else
    #   subject = Subject.where(subject: "Not specified")
    #   results = subject[0].school_documents
    #   # logger.info results
    end


    if params[:queries][:school].present?
      logger.info "School Parameter: #{params[:queries][:school]}"
      if params[:queries][:school] =~ /[A-Za-z]+/
        school_id = School.where(english_name: params[:queries][:school])[0].id
      else
        school_id = School.where(chinese_name: params[:queries][:school])[0].id
      end
    end


    if params[:queries][:contributor].present?
      logger.info "Contributor: #{params[:queries][:contributor]}"
      contributor_id = Student.where(name: params[:queries][:contributor]).map {|sd| sd.id}
      logger.info "Contributor's ID: #{contributor_id}"
    end

    if params[:queries][:format].present?
      logger.info "Format: #{params[:queries][:format]}"
      format_id = Format.where(name: params[:queries][:format]).map {|sd| sd.id}
      logger.info "Format ID: #{format_id}"
    end

    results = []

    if params[:queries][:id].present?
      document_id_string = params[:queries][:id]
      logger.info "Inside School Document ID. #{document_id_string}"
      if document_id_string[0..2] =~ /SD/
        results << SchoolDocument.find(document_id_string[3..-1])
        logger.info "School Document ID: #{results}"
      else
        # Other document form
      end
    else
      results = SchoolDocument.all

      if subject_id
        results = results.where(subject_id: subject_id)
      end

      if school_id
        results = results.where(school_id: school_id)
      end

      if contributor_id
        results = results.where(student_id: contributor_id)
      end

      # logger.info "Grade: #{params[:queries][:grade]}"

      if params[:queries][:grade].present?
        logger.info "Grade: #{params[:queries][:grade]}"
        results = results.where(grade: params[:queries][:grade])
      end

      if params[:queries][:term].present?
        results = results.where(term: params[:queries][:term])
      end

      if format_id
        results = results.where(format_id: format_id)
      end

      if params[:queries][:year].present?
        results = results.where(year: params[:queries][:year])
      end

      if params[:queries][:content].present?
        search_results_id = SchoolDocument.search(params[:queries][:content]).map(&:id)
        results = results.where(id: search_results_id)
      end



    end

    results_ids = results.map {|sd| sd.id}


    # results_ids = []
    # results_ids << subject_results_id
    # results_ids << school_results_id
    # results_ids = results_ids.compact.flatten.uniq

    # if subject_results_id
    #
    #
    # results_id = subject_results_id | school_results_id


    #   school = School.where()
    #   result = SchoolDocument.search(params[:queries][:school])
    #
    #   if result.size > 0
    #     result_ids = result.map(&:id)
    #   end
    #   logger.info "In search method: #{result_ids}"
    #   result_ids
    # end
    logger.info "Results: #{results_ids}"

    redirect_to :controller => "queries", :action => "results", :ids => results_ids
  end

  def results
    logger.info params[:ids]
    if params[:ids]
      @results = []
      params[:ids].each do |r|
        @results << SchoolDocument.find(r)
        logger.info @results
      end
    end
    logger.info @results
    @results
  end

end
