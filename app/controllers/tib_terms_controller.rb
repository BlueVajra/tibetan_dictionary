class TibTermsController < ApplicationController
  def index
    @terms = TibTerm.all
  end

  def new
    @tib_term = TibTerm.new
  end

  def create
    @term = TibTerm.new
    @term.wyl = params[:tib_term][:wyl]
    @term.tib = params[:tib_term][:tib]
    @term.save
    redirect_to tib_terms_path
  end
end