class TibTermsController < ApplicationController
  def index
    if params[:search]
      # @terms = TibTerm.search(params[:search]).paginate(:page => params[:page], :per_page => 30)
      @query = params[:search]
      @terms = TibTerm.search(params[:search])
      @definition_terms = TibTerm.definition_search(@query)
      @term = TibTerm.find_by(wyl: @query)
      if !@terms.empty? || !@definition_terms.empty?
        @search = true
        render
      else
        redirect_to new_tib_term_path, notice: "This term is not in the dictionary.\nPlease add ''#{@query}'' and a definition to your public glossary and help this dictionary grow!"
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

  # THESE ARE POSSIBILITIES FOR FILTERING QUERIES
  # @term.definitions.includes(:glossary).references(:glossary).where(glossaries: {private: false}).each do |definition|

  # tib_term
  # def definitions_for_user(user)
  #  all_records = definitions.includes(:glossary)
  #  all_records.select do |definition|
  #    definition.glossary.private == false || definition.glossary.user == user
  #  end
  #end

  # definition
  # def self.available_for_term(term, user)
  #  all_records = where(term_id: term).includes(:glossary)
  #  all_records.select do |definition|
  #    definition.glossary.private == false || definition.glossary.user == user
  #  end
  #end

  def show
    @term = TibTerm.find(params[:id])
    filtered_definitions = @term.definitions_for_user(current_user)
    unique_glossaries = glossaries_for(filtered_definitions)
    @glossaries = sort_definitions(filtered_definitions, unique_glossaries)
    begin
      @dd = dharma_dictionary(@term.wyl)
    rescue
      @dd = "There has been some error"
    end

    @definition = Definition.new
  end

  private
  def remove_punctuation(term)
    term.strip
  end

  def glossaries_for(definitions)
    definitions.map { |definition| definition.glossary }.uniq
  end

  def sort_definitions(definitions, glossaries)
    glossaries.map do |glossary|
      result =[]
      result << glossary
      result << definitions.select do |definition|
        definition.glossary_id == glossary.id
      end
    end
  end

  def dharma_dictionary(word)

    conn = Faraday.new(:url => 'http://rywiki.tsadra.org') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      #faraday.response :logger                  # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end

    #http://rywiki.tsadra.org/api.php?format=json&action=query&prop=revisions&titles=sems&rvprop=content&rvsection=0&rvparse=1

    response = conn.get do |req|
      req.url "/api.php?format=json&action=query&prop=revisions&titles=#{word}&rvprop=content&rvsection=0&rvparse=1"
    end

    data = JSON.parse(response.body)
    id = data["query"]["pages"].keys[0]
    page_info = data["query"]["pages"][id]["revisions"][0]["*"]
  end
end