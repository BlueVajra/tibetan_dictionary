class DefinitionsController < ApplicationController
  def new

  end

  def show
    @definition = Definition.new
  end

  #def create
  #  @term = TibTerm.find(params[:id])
  #  @definition = Definition.new
  #  @definition.entry = params[:definition][:entry]
  #  @definition.name = params[:definition][:name]
  #
  #  if @definition.save
  #    @term.definitions << @definition
  #    redirect_to tib_term_path(@term)
  #  else
  #    render tib_term_path(@term)
  #  end
  #end
end
