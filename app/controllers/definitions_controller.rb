class DefinitionsController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
    @term = TibTerm.find(params[:tib_term_id])
    @definition = Definition.new
    @definition.tib_term_id = @term.id
    @definition.entry = params[:definition][:entry]
      #get glossary from params instead of picking first id below
    @definition.glossary_id = params[:definition][:glossary_id]
    if @definition.save

      redirect_to tib_term_path(@term)
    else
      render 'tib_terms/show'
    end
  end
end
