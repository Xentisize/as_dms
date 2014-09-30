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

  def create
    @public_exam = PublicExam.new(public_exam_params)

    unless public_exam_subject_params[:subject_id].blank?
      @public_exam.subject = Subject.find_or_create_by(id: public_exam_subject_params[:subject_id])
    end

    logger.info "!!!!!!!!#{public_exam_audio_params[:audios][1]}"


    unless public_exam_audio_params.blank?
      if public_exam_audio_params[:audios].size > 0

        if public_exam_audio_params[:audios].size == 1
          audio = Audio.new
          audio.audio_file = public_exam_audio_params[:audios]["1"][:audio_file]
          @public_exam.audios << audio
        else
          public_exam_audio_params[:audios].values.each do |a|
            audio = Audio.new
            audio.audio_file = a[:audio_file]
            @public_exam.audios << audio
          end
        end
      end
    end



    unless public_exam_solution_params[:solution].blank?
      @solution = Solution.new
      @solution.solution_file = public_exam_solution_params[:solution][:solution_file]
      if @solution.save
        @public_exam.solution = @solution
      end
    end

    unless public_exam_format_params[:format_id].blank?
      @public_exam.format = Format.find_by(id: public_exam_format_params[:format_id])
    end

    unless public_exam_publisher_params.blank?
      @public_exam.publisher = Publisher.find_or_create_by(name: public_exam_publisher_params[:publisher][:name])
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
    params.require(:public_exam).permit(:year, :file)
  end

  def public_exam_subject_params
    params.require(:public_exam).permit(:subject_id)
  end

  def public_exam_solution_params
    params.require(:public_exam).permit(:solution => [:solution_file])
  end

  def public_exam_audio_params
    params.require(:public_exam).permit(:audios => [:audio_file])
  end

  def public_exam_format_params
    params.require(:public_exam).permit(:format_id)
  end

  def public_exam_publisher_params
    params.require(:public_exam).permit(:publisher => [:name])
  end
end

