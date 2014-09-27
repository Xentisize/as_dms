class SchoolDocumentsController < ApplicationController
  before_action :all_school_documents, only: [:index]

  def index
  end

  def new
    @school_document = SchoolDocument.new
    @school_document.build_subject
    @school_document.build_student
    @school_document.build_school
    # @school_document.categories.build
  end

  def create
    @school_document = SchoolDocument.new(school_document_params)
    @school_document.subject = Subject.find_or_create_by(id: school_document_subject_params[:subject_id])
    @school_document.student = Student.find_or_create_by(name: school_document_student_params[:student][:name])
    # logger.info "!!!!!!!!!! #{school_document_categories_params[:categories]}"
    unless school_document_categories_params[:categories].blank?
      logger.info "I am inside"
      school_document_categories_params[:categories].values.each do |c|
        # logger.info "I am inside the loop too. #{c}"
        # logger.info "!!!!!!!!!!#{c[:name]}"
        logger.info "!!!!!!!!! #{Category.find_or_create_by(name: c[:name])}"
        @school_document.categories << Category.find_or_create_by(name: c[:name])
        logger.info "#{@school_document.categories}"

      end
      # logger.info "!!!!!!!!!!: #{school_document_categories_params[:categories]}"
    end
    logger.info "#{@school_document.categories.first.name}"
    if @school_document.save
      redirect_to school_documents_path
    else
      render :new
    end
  end

  def new_category_field
    respond_to do |format|
      format.js
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
    params.require(:school_document).permit(:subject_id)
  end

  def school_document_student_params
    params.require(:school_document).permit(:student => [:name])
  end

  def school_document_categories_params
    params.require(:school_document).permit(:categories => [:name])
  end

end
