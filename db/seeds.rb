# ruby encoding: utf-8

@admin = User.find_or_create_by(:email => 'admin@admin.com') do |user|
  user.password = 'password1'
  user.password_confirmation = 'password1'
end

File.open(Rails.root + "db/dictionaries/ry-dic2003-prop.txt", 'r') do |f|

  error_lines = []

  f.each_line do |line|
    begin
      if line.strip != ""
        #chags med ri chos - a famous retreat manual popular in both the rnying ma and bka' brgyud traditions, composed by kar ma chags med ra ga a sya (1613-1678) [tsd]
        @line = line
        term = @line.slice!(/^.*? -/).chop.strip
        puts "TERM: #{term}"

        gloss = @line.strip!.slice!(/\[.{2,3}\]$/i)
        if gloss != nil && gloss.strip != ""
          #puts "LINE: #{@line}"
          #puts "GLOSS: #{gloss}"
          gloss_name = gloss.gsub('[', "").gsub(']', "")
          #puts "GLOSS_NAME: #{gloss_name}"
        else
          gloss_name = "unknown"
        end

        @term = TibTerm.find_or_create_by(wyl: term.strip)
        @glossary = Glossary.find_or_create_by(name: gloss_name) do |g|
          g.user_id = @admin.id
          g.description = gloss_name
        end
        @definition = Definition.create(entry: @line, glossary_id: @glossary.id, tib_term_id: @term.id)
      end
    rescue
      error_lines << line
    end
  end

  puts "ERROR LINES:"
  error_lines.each do |error|
    puts error
  end

end
