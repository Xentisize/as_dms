class SchoolDocumentsController < ApplicationController
  before_action :all_school_documents, only: [:index]

  def index
  end

  def new
    @school_document = SchoolDocument.new
    @school_document.build_subject
    @school_document.build_student
    @school_document.build_school
  end

  def create
    @school_document = SchoolDocument.new(school_document_params)
    @school_document.subject = Subject.find_or_create_by(subject: school_document_subject_params[:subject][:subject])
    @school_document.student = Student.find_or_create_by(name: school_document_student_params[:student][:name])
    if @school_document.save
      redirect_to school_documents_path
    else
      render :new
    end
  end

  private

  def all_school_documents
    @school_documents = SchoolDocument.all
  end

  def school_document_params
    params.require(:school_document).permit(:name, :year, :term, :grade)
  end

  def school_document_subject_params
    params.require(:school_document).permit(:subject => [:subject])
  end

  def school_document_student_params
    params.require(:school_document).permit(:student => [:name])
  end

end
