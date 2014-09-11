class GlossariesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_glossary, except: [:index, :create, :new]
  before_action :verify_ownership_of_public_glossary, only: [:edit, :update, :import_form, :import]
  before_action :verify_ownership_of_private_glossary, only: [:edit, :update, :import_form, :import, :show]

  def index
    @glossaries = current_user.glossaries
  end

  def new
    @glossary = Glossary.new
  end

  def create
    @glossary = current_user.glossaries.new(glossary_params)
    if @glossary.save
      redirect_to '/glossaries'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html do
        @definitions = @glossary.definitions.page(params[:page])
      end
      format.csv do
        send_data @glossary.to_csv, filename: "#{@glossary.name}.csv"
      end
      format.pdf do
        render :pdf => @glossary.name,
               :template => "/glossaries/show.pdf.erb",
               :disposition => 'attachment',
               :layout => "pdf.html"
      end
    end
  end

  def edit
  end

  def update
    if @glossary.update(glossary_params)
      redirect_to glossaries_path
    else
      render :edit
    end
  end

  def import_form

  end

  def import
    begin
      @glossary.create_definitions_from_csv(params[:file])
      redirect_to glossary_path(@glossary), notice: "Your records have been successfully imported"
    rescue RuntimeError => e
      flash.now[:error] = "There was an error with the import.\n#{e.message}\nPlease fix the problem and try again."
      render :import_form
    end
  end

  def default
    current_user.default_glossary = params[:id]
    current_user.save
    redirect_to glossaries_path
  end

  private
  def glossary_params
    params.require(:glossary).permit(:name, :description, :private)
  end

  def verify_ownership_of_public_glossary
    if !@glossary.private?
      if !@glossary.belongs_to?(current_user)
        redirect_to glossary_path(@glossary), alert: "This action is not available"
      end
    end
  end

  def verify_ownership_of_private_glossary
    if @glossary.private?
      if !@glossary.belongs_to?(current_user)
        render status: 404, text: 'Not found.'
      end
    end
  end

  def find_glossary
    @glossary = Glossary.find(params[:id])
  end
end