# ruby encoding: utf-8

@admin = User.find_or_create_by(:email => 'cory.leistikow@gmail.com') do |user|
  user.password = '108Tibetan1*8'
  user.password_confirmation = '108Tibetan1*8'
end

File.open(Rails.root + "db/ry-dic2003-prop_short.txt", 'r') do |f|
  f.each_line do |line|

    #chags med ri chos - a famous retreat manual popular in both the rnying ma and bka' brgyud traditions, composed by kar ma chags med ra ga a sya (1613-1678) [tsd]
    @line = line
    term = @line.slice!(/^.*? -/).chop.strip
    #puts "TERM: #{term}"


    gloss = @line.strip!.slice!(/\[.{2,3}\]$/i)
    #puts "LINE: #{@line}"
    puts "GLOSS: #{gloss}"
    gloss_name = gloss.gsub('[', " ").gsub(']', " ").strip
    #puts "GLOSS_NAME: #{gloss_name}"
    @term = TibTerm.find_or_create_by(wyl: term.strip)
    @glossary = Glossary.find_or_create_by(name: gloss_name) do |g|
      g.user_id = @admin.id
      g.description = gloss_name
    end
    @definition = Definition.create(entry: @line, glossary_id: @glossary.id, tib_term_id: @term.id)

  end
end
