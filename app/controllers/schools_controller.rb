class SchoolsController < ApplicationController
  def match_english_and_chinese_school_name
    if params[:school] =~ /[A-Za-z]+/
      @school = School.find_by(english_name: params[:school])
    else
      @school = School.find_by(chinese_name: params[:school])
    end

    respond_to do |format|
      format.json { render :json => @school }
    end
  end
end
