module Wylie
  class Converter
    def initialize(debug = false)
      combined_characters = CONSONANTS.merge(VOWELS).merge(SANSKRIT_VOWELS).merge(FINAL).merge(OTHER)

      @sorted_characters = combined_characters.sort_by do |key, value|
        key.size
      end.reverse.to_h

      @vowels = VOWELS.merge(SANSKRIT_VOWELS)
      @debug = debug
    end

    def tibetan(wylie)
      wylie_syllables = wylie.split(" ")
      tibetan_text = wylie_syllables.map do |syl|
        tibetan_syllable(syl)
      end
      is_terminating_character?(wylie[-1]) ? ending = "" : ending = "་"
      tibetan_text.join(@sorted_characters[" "][0].join) + ending
    end

    def tibetan_syllable(syl)
      wylie_tokens = parse_syllable(syl)
      transcribe_wylie(wylie_tokens)
    end

    def transcribe_wylie(tokens)

      @new_stack = true
      @preceeded_by_plus = false

      tib_roles = tibetan_roles(tokens)
      tib_tokens = []

      pp tokens if @debug
      pp tib_roles if @debug

      tokens.each_with_index do |token, index|

        if token == "+"
          @preceeded_by_plus = true
          next
        end

        subjoined_characters = ["root_sub", "foot"]

        if VOWELS.include?(token)
          if index == 0
            tib_tokens << @sorted_characters["a"][0].join
          end

          if token == "a"
            next
          end
          @new_stack = true
        elsif subjoined_characters.include?(tib_roles[index])
          @new_stack = false
        elsif @preceeded_by_plus
          @new_stack = false
        else
          @new_stack = true
        end

        @preceeded_by_plus = false

        if is_new_stack?
          tib_tokens << @sorted_characters[token][0].join
        else
          tib_tokens << @sorted_characters[token][1].join
        end

      end

      tib_tokens.flatten.join

    end

    def is_new_stack?
      @new_stack
    end

    def is_preceeded_by_plus?
      @preceeded_by_plus
    end

    def is_vowel?(char)
      @vowels.has_key?(char)
    end

    def is_head_letter?(char)
      ["s", "r", "l"].include?(char)
    end

    def is_foot_letter?(char)
      ["y", "r", "l"].include?(char)
    end

    def is_prefix?(char)
      ["g", "d", "b", "m", "'"].include?(char)
    end

    def is_terminating_character?(char)
      ["g", "/"].include?(char)
    end

    def parse_syllable(syl)
      tib = syl
      x = true
      tib_string = []
      @y = false

      while x == true

        @sorted_characters.each do |key, value|
          @y = true
          if tib.start_with?(key)
            tib_string << key
            tib.slice!(0..key.size-1)
            @y = false
          end
          break if @y == false
        end

        # CHECKS FOR A + SYMBOL
        if tib.match(/^[\+]/)
          tib_string << "+"
          tib.sub!(/\+/, "")
          @y = false
        end

        x = false if @y == true
      end
      tib_string
    end

    def starts_with?(prefix)
      prefix = prefix.to_s
      self[0, prefix.length] == prefix
    end

    def tibetan_roles(tokens)
      tib_roles = []

      tokens.each_with_index do |token, index|

        next_token = tokens[index+1]
        next_next_token = tokens[index+2]
        previous_token = tokens[index-1]
        previous_role = tib_roles[index-1]

        if index == 0
          if is_vowel?(token)
            tib_roles << "vowel"
          elsif is_vowel?(next_token)
            tib_roles << "root"
          elsif is_foot_letter?(next_token) && is_vowel?(next_next_token)
            tib_roles << "root"
          elsif is_prefix?(token)
            tib_roles << "pre"
          elsif is_head_letter?(token)
            tib_roles << "head"
          else
            tib_roles << "root"
          end
        else
          if is_vowel?(token)
            tib_roles << "vowel"
          elsif is_vowel?(previous_token) || previous_role == "suf"
            tib_roles << "suf"
          elsif previous_role.include?("root") && is_foot_letter?(token)
            tib_roles << "foot"
          elsif previous_role == "head"
            tib_roles << "root_sub"
          elsif previous_role == "pre" && is_vowel?(next_token)
            tib_roles << "root"
          else
            tib_roles << "head"
          end
        end
      end
      tib_roles
    end

    def show_unicode
      pp CONSONANTS
      pp VOWELS
      pp SANSKRIT_VOWELS
      pp COMPLEX_VOWELS
      pp FINAL
      pp OTHER
    end

  end
end