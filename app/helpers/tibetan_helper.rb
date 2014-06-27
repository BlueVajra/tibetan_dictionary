module TibetanHelper

  TIBETAN_CONVERTER = Wylie::Converter.new

  def to_tibetan(phrase)
    TIBETAN_CONVERTER.tibetan(phrase)
  end
  
end