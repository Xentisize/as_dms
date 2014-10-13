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
    if params[:queries][:school].present?
      result = SchoolDocument.search(params[:queries][:school])
      if result.size > 0
        result_ids = result.map(&:id)
      end
      result_ids
    end

    redirect_to :controller => "queries", :action => "results", :ids => result_ids
  end

  def results
    logger.info params[:ids]
    if params[:ids]
      @results = []
      params[:ids].each do |r|
        @results << SchoolDocument.find(r)
      end
    end

    @results
  end

end
