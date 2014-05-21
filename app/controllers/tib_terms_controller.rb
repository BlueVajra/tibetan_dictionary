class TibTermsController < ApplicationController
  def index
    if params[:search]
      @terms = TibTerm.search(params[:search]).paginate(:page => params[:page], :per_page => 30)
    else
      @terms = TibTerm.paginate(:page => params[:page], :per_page => 30)
    end
  end

  def new
    @term = TibTerm.new
  end

  def create
    @term = TibTerm.new
    @term.wyl = remove_punctuation(params[:tib_term][:wyl])
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

  private
  def remove_punctuation(term)
    term.strip
  end
end