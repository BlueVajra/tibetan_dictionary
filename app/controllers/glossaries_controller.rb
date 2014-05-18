class GlossariesController < ApplicationController
  def index
    @glossaries = Glossary.all
  end

  def new
    @glossary = Glossary.new
  end

  def create
    @glossary = Glossary.new
    @glossary.name = params[:glossary][:name]
    @glossary.description = params[:glossary][:description]

    if @glossary.save
      redirect_to '/glossaries'
    else
      render :new
    end

  end
end