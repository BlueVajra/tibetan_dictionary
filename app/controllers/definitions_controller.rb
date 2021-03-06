class DefinitionsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_ownership, only: [:destroy, :edit, :update]
  respond_to :html, :js

  def create
    respond_to do |format|
      format.html do
        @term = TibTerm.find(params[:tib_term_id])
        @definition = Definition.new
        @definition.tib_term_id = @term.id
        @definition.entry = params[:definition][:entry]
        @definition.glossary_id = params[:definition][:glossary_id]
        if @definition.save
          redirect_to tib_term_path(@term)
        else
          render 'tib_terms/show'
        end
      end
      format.json do
        @term = TibTerm.find_or_create_by(wyl: remove_punctuation(params[:tib_definition][:wyl]))
        @definition = Definition.new
        @definition.tib_term_id = @term.id
        @definition.entry = params[:tib_definition][:entry]
        @definition.glossary_id = params[:glossary_id]
        if @term.save && @definition.save
          json = {
            wyl: @definition.tib_term.wyl,
            entry: @definition.entry,
            tib_term_path: tib_term_path(@definition.tib_term),
            definition_path: tib_term_definition_path(@definition.tib_term, @definition),
            glossary_definition_path: glossary_definition_path(@definition.glossary, @definition),
            definition_id: @definition.id,
          }
          render json: json
        end
      end
    end
  end

  def edit
    @term = TibTerm.find(params[:tib_term_id])
    @definition = Definition.find(params[:id])
    render
  end

  def update
    respond_to do |format|
      format.html do
        @term = TibTerm.find(params[:tib_term_id])
        @definition = Definition.find(params[:id])
        @definition.entry = params[:definition][:entry]
        @definition.e
        if @definition.save
          redirect_to glossary_path(@definition.glossary)
        else
          render :edit
        end
      end
      format.json do
        @term = TibTerm.find_or_create_by(wyl: remove_punctuation(params[:definition][:wyl]))
        @definition = Definition.find(params[:id])
        @definition.tib_term_id = @term.id
        @definition.entry = params[:definition][:entry]
        if @definition.save
          json = {
            wyl: @definition.tib_term.wyl,
            entry: @definition.entry,
            tib_term_path: tib_term_path(@definition.tib_term),
            definition_path: tib_term_definition_path(@definition.tib_term, @definition),
            glossary_definition_path: glossary_definition_path(@definition.glossary, @definition),
            definition_id: @definition.id,
          }
          render json: json
        end
      end
    end

  end

  def destroy
    @definition = Definition.find(params[:id])
    @glossary = @definition.glossary
    @definition.destroy
    redirect_to glossary_path(@glossary)
  end

  private
  def remove_punctuation(term)
    term.strip
  end

  def verify_ownership
    @definition = Definition.find(params[:id])
    unless @definition.glossary.user.id == current_user.id
      redirect_to glossary_path(@definition.glossary), alert: "This action is not available"
    end
  end
end
