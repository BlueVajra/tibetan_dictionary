class GlossariesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_ownership, only: [:edit, :update, :import_form, :import]

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
    @glossary = Glossary.find(params[:id])
    @glossary.user.id == current_user.id ? @is_current_owner = true : @is_current_owner = false
    respond_to do |format|
      format.html do
        @definitions = @glossary.definitions.paginate(:page => params[:page], :per_page => 30)
      end
      format.csv do
        send_data @glossary.to_csv, filename: "#{@glossary.name}.csv"
      end
      format.pdf do
        render :pdf => @glossary.name,
               :template => "/glossaries/show.pdf.erb",
               :disposition => 'attachment',
               :layout => "pdf.html"
        # :show_as_html => true
      end
    end
  end

  def edit
    @glossary = Glossary.find(params[:id])
  end

  def update
    @glossary = Glossary.find(params[:id])
    if @glossary.update(glossary_params)
      redirect_to glossaries_path
    else
      render :edit
    end
  end

  def import_form

  end

  def import
    glossary = Glossary.find(params[:id])
    error = ""
    begin
      glossary.create_definitions_from_csv(params[:file])
    rescue RuntimeError => e
      error = e
    end
    if !error.blank?
      flash.now[:error] = "There was an error with the import.\n#{error.message}\nPlease fix the problem and try again."
      render :import_form
    else
      redirect_to glossary_path(glossary), notice: "Your records have been successfully imported"
    end
  end

  def default
    current_user.default_glossary = params[:id]
    current_user.save
    redirect_to glossaries_path
  end

  private
  def glossary_params
    params.require(:glossary).permit(:name, :description,:private)
  end

  def verify_ownership
    @glossary = Glossary.find(params[:id])
    unless @glossary.user.id == current_user.id
      redirect_to glossary_path(@glossary), alert: "This action is not available"
    end
  end
end