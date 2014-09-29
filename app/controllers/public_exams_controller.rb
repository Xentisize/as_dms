class PublicExamsController < ApplicationController
  before_action :all_public_exams, only: [:index]
  def index
  end

  def new
    @public_exam = PublicExam.new
    @public_exam.build_subject
    @public_exam.build_format
  end

  def create
    @public_exam = PublicExam.new(public_exam_params)

    unless public_exam_subject_params[:subject_id].blank?
      @public_exam.subject = Subject.find_or_create_by(id: public_exam_subject_params[:subject_id])
    end

    unless public_exam_format_params[:format_id].blank?
      @public_exam.format = Format.find_by(id: public_exam_format_params[:format_id])
    end

    if @public_exam.save
      redirect_to public_exams_path
    else
      render :new
    end
  end

  # def new_



  private
  def all_public_exams
    @public_exams = PublicExam.all
  end

  def public_exam_params
    params.require(:public_exam).permit(:year, :publisher, :file)
  end

  def public_exam_subject_params
    params.require(:public_exam).permit(:subject_id)
  end

  def public_exam_format_params
    params.require(:public_exam).permit(:format_id)
  end

end
