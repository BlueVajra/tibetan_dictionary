class DefinitionsController < ApplicationController
  def new

  end

  def show
    @definition = Definition.new
  end
end
