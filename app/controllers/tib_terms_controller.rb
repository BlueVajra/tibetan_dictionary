class TibTermsController < ApplicationController
  def index
    if params[:search]
      #@terms = TibTerm.search(params[:search]).paginate(:page => params[:page], :per_page => 30)
      @term = TibTerm.find_by(wyl: params[:search])
      if @term != nil
        redirect_to tib_term_path(@term.id)
      else
        redirect_to new_tib_term_path, notice: "This term is not in the dictionary.\nPlease add ''#{params[:search]}'' and a definition to your public glossary and help this dictionary grow!"
      end
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