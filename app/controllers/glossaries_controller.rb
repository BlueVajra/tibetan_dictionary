class GlossariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @glossaries = current_user.glossaries
  end

  def new
    @glossary = Glossary.new
  end

  def create
    @glossary = Glossary.new
    @glossary.user_id = current_user.id
    @glossary.name = params[:glossary][:name]
    @glossary.description = params[:glossary][:description]
    @glossary.private = params[:glossary][:private]
    if @glossary.save
      redirect_to '/glossaries'
    else
      render :new
    end
  end

  def show
    @glossary = Glossary.find(params[:id])
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
    @glossary.name = params[:glossary][:name]
    @glossary.description = params[:glossary][:description]
    @glossary.private = params[:glossary][:private]
    if @glossary.save
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
end