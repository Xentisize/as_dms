class PublicExamsController < ApplicationController
  before_action :all_public_exams, only: [:index]
  def index
  end

  def new
    @public_exam = PublicExam.new
    @public_exam.build_subject
    @public_exam.build_format
    @public_exam.build_publisher
  end

  def show
    @public_exam = PublicExam.find(params[:id])
  end

  def create
    @public_exam = PublicExam.new(public_exam_params)


    unless public_exam_subject_params[:subject_id].blank?
      @public_exam.subject = Subject.find_or_create_by(id: public_exam_subject_params[:subject_id])
    end

    unless public_exam_audio_params.blank?
      public_exam_audio_params[:audios].each do |audio|
        @audio = Audio.new
        @audio.audio_file = audio
        @public_exam.audios << @audio
      end
    end

    unless public_exam_solution_params[:solutions].blank?
      public_exam_solution_params[:solutions].each do |sol|
        @solution = Solution.new
        @solution.solution_file = sol
        @public_exam.solutions << @solution
      end
    end

    unless public_exam_format_params[:format_id].blank?
      @public_exam.format = Format.find_by(id: public_exam_format_params[:format_id])
    end

    unless public_exam_publisher_params.blank?
      @public_exam.publisher = Publisher.find_or_create_by(name: public_exam_publisher_params[:publisher][:name])
      logger.info "!!!!!!!!!!!!#{@public_exam.publisher}"
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
    # logger.info "!!!!!!! inside public_exam_params:\n#{params.require(:public_exam).permit(:file => [])}"
    params.require(:public_exam).permit(:year, :file)
  end

  def public_exam_file_params
    params.require(:public_exam).permit(:file => [])
  end

  def public_exam_subject_params
    params.require(:public_exam).permit(:subject_id)
  end

  def public_exam_solution_params
    params.require(:public_exam).permit(:solutions => [])
  end

  def public_exam_audio_params
    params.require(:public_exam).permit(:audios => [])
  end

  def public_exam_format_params
    params.require(:public_exam).permit(:format_id)
  end

  def public_exam_publisher_params
    logger.info "!!!!!!!! Insode publisher: #{   params.require(:public_exam).permit(:publisher => [:name])}"
    params.require(:public_exam).permit(:publisher => [:name])
  end
end

