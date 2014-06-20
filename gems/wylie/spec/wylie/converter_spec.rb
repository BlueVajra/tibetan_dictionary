require 'spec_helper'

module Wylie
  describe Converter do

    context "converts single syllables tibetan," do
      it "converts with 'a' vowels" do
        converter = Converter.new

        expect(converter.tibetan_syllable("ka")).to eq "ཀ"
        expect(converter.tibetan_syllable("sha")).to eq "ཤ"
        expect(converter.tibetan_syllable("la")).to eq "ལ"
      end

      it "converts with 'i' vowels" do
        converter = Converter.new

        expect(converter.tibetan_syllable("ki")).to eq "ཀི"
        expect(converter.tibetan_syllable("shi")).to eq "ཤི"
        expect(converter.tibetan_syllable("hi")).to eq "ཧི"
      end

      it "converts suffexes" do
        converter = Converter.new

        expect(converter.tibetan_syllable("bod")).to eq "བོད"
        expect(converter.tibetan_syllable("ling")).to eq "ལིང"
        expect(converter.tibetan_syllable("thun")).to eq "ཐུན"
      end

      it "converts second suffexes" do
        converter = Converter.new

        expect(converter.tibetan_syllable("longs")).to eq "ལོངས"
        expect(converter.tibetan_syllable("sings")).to eq "སིངས"

      end

      it "works with sanskrit dhi variations" do
        converter = Converter.new

        expect(converter.tibetan_syllable("dhi")).to eq "དྷི"
        expect(converter.tibetan_syllable("Dhi")).to eq "ཌྷི"
        expect(converter.tibetan_syllable("D+hi")).to eq "ཌྷི"
      end

      it "works with other edge cases" do
        converter = Converter.new
        expect(converter.tibetan_syllable("longs")).to eq "ལོངས"
        expect(converter.tibetan_syllable("puMsoH")).to eq "པུཾསོཿ"
        expect(converter.tibetan_syllable("oM")).to eq "ཨོཾ"
        expect(converter.tibetan_syllable("hUM")).to eq "ཧཱུཾ"
        expect(converter.tibetan_syllable("d+hiH")).to eq "དྷིཿ"
        expect(converter.tibetan_syllable("eShAMpatiSh+ThAH")).to eq "ཨེཥཱཾཔཏིཥྛཱཿ"
        expect(converter.tibetan_syllable("hru'u")).to eq "ཧྲུའུ"
      end

      it "works with multiple syllables" do
        converter = Converter.new

        expect(converter.tibetan("dam pa'i chos ")).to eq "དམ་པའི་ཆོས་"
        expect(converter.tibetan("'jigs byed ")).to eq "འཇིགས་བྱེད་"
        expect(converter.tibetan("snyam rtsom ")).to eq "སྙམ་རྩོམ་"
        expect(converter.tibetan("gur guM")).to eq "གུར་གུཾ"
        expect(converter.tibetan("bkris ")).to eq "བཀྲིས་"
        expect(converter.tibetan("lo tsA ba ")).to eq "ལོ་ཙཱ་བ་"
        expect(converter.tibetan("dzam+b+ha ")).to eq "ཛམྦྷ་"
        expect(converter.tibetan("bsgrubs ")).to eq "བསྒྲུབས་"
      end

      it "adds ending character if one doesn't exist for multiple syllables" do
        expect(converter.tibetan("snyam rtsom")).to eq "སྙམ་རྩོམ་"
      end

    end

  end
end