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
    @definitions = @glossary.definitions.paginate(:page => params[:page], :per_page => 30)
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

  def default
    current_user.default_glossary = params[:id]
    current_user.save
    redirect_to glossaries_path
  end
end