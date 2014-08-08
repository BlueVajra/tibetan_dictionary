# ruby encoding: utf-8

# you must first create an admin to attach these global glossaries
admin = User.first
testing = true

dictionary_directory = Rails.root + "db/dictionaries"
if testing
  dictionary_files = Dir.glob("#{dictionary_directory}/*.test")
else
  dictionary_files = Dir.glob("#{dictionary_directory}/*.txt")
end

dictionary_files.each do |dictionary_file|
  puts dictionary_file

  File.open(dictionary_file, 'r') do |f|

    error_lines = []

    puts dictionary_file
    f.each_line do |line|
      begin
        if line.strip != ""
          line = line
          term = line.slice!(/^.*? -/).chop.strip
          puts "TERM: #{term}"

          gloss = line.strip!.slice!(/\[.{2,3}\]$/i)
          if gloss != nil && gloss.strip != ""
            gloss_name = gloss.gsub('[', "").gsub(']', "")
          else
            gloss_name = "unknown"
          end

          tib_term = TibTerm.find_or_create_by(wyl: term.strip)
          glossary = Glossary.find_or_create_by(name: gloss_name) do |g|
            g.user_id = admin.id
            g.description = gloss_name
          end
          Definition.create(entry: line, glossary_id: glossary.id, tib_term_id: tib_term.id)
        end
      rescue
        error_lines << line
      end
    end

    File.open("#{Rails.root}/db/errors/errors.txt", "a") do |f|
      f.puts dictionary_file
      error_lines.each { |element| f.puts(element) }
      f.puts "\n\n"
    end

  end
end
