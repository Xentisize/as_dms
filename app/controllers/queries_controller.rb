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

end
