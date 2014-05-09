class DefinitionsController < ApplicationController
  #def index
  #
  #end
  #def new
  #
  #end
  #
  #def show
  #  @definition = Definition.new
  #end

  def create
    @term = TibTerm.find(params[:tib_term_id])
    @definition = Definition.new
    @definition.tib_term_id = @term.id
    @definition.entry = params[:definition][:entry]
    @definition.name = params[:definition][:name]

    if @definition.save

      redirect_to tib_term_path(@term)
    else
      render 'tib_terms/show'
    end
  end
end
