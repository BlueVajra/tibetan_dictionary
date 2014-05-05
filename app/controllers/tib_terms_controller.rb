class TibTermsController < ApplicationController
  def index
    @terms = TibTerm.all
  end

  def new
    @term = TibTerm.new
  end

  def create
    @term = TibTerm.new
    @term.wyl = params[:tib_term][:wyl].strip
    @term.tib = params[:tib_term][:tib]
    if @term.save
      redirect_to tib_terms_path
    else
      render :new
    end
  end

  def show
    @term = TibTerm.find(params[:id])
    @definition = Definition.new
  end

  def create_definition
    @term = TibTerm.find(params[:id])
    @term.definitions.create(
      entry: params[:tib_term][:definitions][:entry],
      name: params[:tib_term][:definitions][:name]
    )
    redirect_to tib_term_path(params[:id])
  end

end