class DefinitionsController < ApplicationController
  before_action :authenticate_user!, :only => [:create]
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
            definition_id: @definition.id,
          }
          render json: json
        end
      end
    end
  end

  def show

  end

  def edit
    #respond_to do |format|
    #  format.html do
    @term = TibTerm.find(params[:tib_term_id])
    @definition = Definition.find(params[:id])
    if @definition.glossary.user_id != current_user.id
      redirect_to glossaries_path, alert: "This term is not available to edit"
    else
      render
    end

    #  format.json do
    #    #@term = TibTerm.find(params[:tib_term_id])
    #    @definition = Definition.find(params[:id])
    #    json = {
    #      entry: @definition.entry
    #    }
    #    render json: json
    #  end
    #end
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
            definition_id: @definition.id,
          }
          render json: json
        end
      end
    end

  end
  private
  def remove_punctuation(term)
    term.strip
  end
end
