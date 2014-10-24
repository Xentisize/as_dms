class SchoolDocumentsController < ApplicationController
  before_action :all_school_documents, only: [:index]

  def index
  end

  def new
    @school_document = SchoolDocument.new
    @school_document.build_subject
    @school_document.build_student
    @school_document.build_school
    @school_document.build_format
  end

  def create
    @school_document = SchoolDocument.new(school_document_file_params)

    school_document_params.each do |key, val|
      if val.empty?
        @school_document[key] = "Not Specified"
      else
        @school_document[key] = val
      end
    end

    unless school_document_solution_params[:solutions].blank?
      school_document_solution_params[:solutions].each do |sol|
        @solution = Solution.new
        @solution.solution_file = sol
        @school_document.solutions << @solution
      end
    end

    unless school_document_audio_params[:audios].blank?
      school_document_audio_params[:audios].each do |audio|
        @audio = Audio.new
        @audio.audio_file = audio
        @school_document.audios << @audio
      end
    end

    if school_document_subject_params[:subject_id].empty?
      # logger.info "XXXXXXXXXXX #{school_document_subject_params[:subject_id]}"
      @school_document.subject = Subject.find_or_create_by(subject: "Not specified")
    else
      @school_document.subject = Subject.find_or_create_by(id: school_document_subject_params[:subject_id])
    end


    unless school_document_format_params[:format_id].blank?
      @school_document.format = Format.find_by(id: school_document_format_params[:format_id])
    else
      @school_document.format = Format.find_by(name: "Not Specified")
    end

    unless school_document_student_params[:student][:name].blank?
      @school_document.student = Student.find_or_create_by(name: school_document_student_params[:student][:name])
    else
      @school_document.student = Student.find_or_create_by(name: "Not Specified")
    end

    unless school_document_categories_params[:categories].blank?
      school_document_categories_params[:categories].values.each do |c|
        @school_document.categories << Category.find_or_create_by(name: c[:name])
      end
    else
      @school_document.categories << Category.find_or_create_by(name: "Not Specified")
    end

    unless school_document_question_types_params[:question_types].blank?
      school_document_question_types_params[:question_types].values.each do |q|
        @school_document.question_types << QuestionType.find_or_create_by(name: q[:name])
      end
    else
      @school_document.question_types << QuestionType.find_or_create_by(name: "Not specified")
    end

    unless school_document_school_params[:school][:english_name].blank? && school_document_school_params[:school][:chinese_name].blank?
      chinese_school = School.find_by(chinese_name: school_document_school_params[:school][:chinese_name])
      if chinese_school.blank?
        english_school = School.find_by(english_name: school_document_school_params[:school][:english_name])
        if english_school.blank?
          @school_document.school = School.create(school_document_school_params[:school])
        end
      else
        if chinese_school.english_name == school_document_school_params[:school][:english_name]
          @school_document.school = chinese_school
        end
      end
    else
      @school_document.school = School.find_by(english_name: "Not Specified")
    end

    respond_to do |format|
      if @school_document.save
        format.html do
          redirect_to school_documents_path, notice: "Document was successfully created."
        end
      else
      f ormat.html { render :new }
      end
    end
  end

  def show
    @school_document = SchoolDocument.find(params[:id])
    printers = `lpstat -p -d`
    printer_list = printers.split("\n").select {|p| p =~ /^printer/ }
    @printers = printer_list.collect {|p| p.split(" ")[1] }
  end

  private

  def all_school_documents
    @school_documents = SchoolDocument.all
  end

  def school_document_params
    params.require(:school_document).permit(:name, :year, :term, :grade)
  end

  def school_document_file_params
    params.require(:school_document).permit(:file)
  end

  def school_document_solution_params
    params.require(:school_document).permit(:solutions => [])
  end

  def school_document_audio_params
    params.require(:school_document).permit(:audios => [])
  end

  def school_document_subject_params
    params.require(:school_document).permit(:subject_id)
  end

  def school_document_student_params
    params.require(:school_document).permit(:student => [:name])
  end

  def school_document_categories_params
    params.require(:school_document).permit(:categories => [:name])
  end

  def school_document_school_params
    params.require(:school_document).permit(:school => [:english_name, :chinese_name])
  end

  def school_document_question_types_params
    params.require(:school_document).permit(:question_types => [:name])
  end

  def school_document_format_params
    params.require(:school_document).permit(:format_id)
  end

end
