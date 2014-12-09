
  class UpdateChangelog

    def self.call(directory)
      unless directory.last == '/'
        directory + '/'
      end
      
      version_input = question

      file = File.open(directory+'CHANGELOG.md').read.split("\n")
      unreleased_line_num = nil
      version_array = nil

      file.each_with_index do |line, line_num|
        if line.match(/#\s[uU]nreleased$/)
          unreleased_line_num = line_num
        end

        if line.match(/^##\s\d+\.\d+\.\d+/)
          version_array = line.match(/\d+\.\d+\.\d+/)[0].split('.').map(&:to_i)
          old_version_line_num = line_num
          break
        end 
      end
    
      if version_input  == 'patch'
        version_array[-1] += 1
      elsif version_input == 'minor'
        version_array[1] += 1
        version_array[-1] = 0
      elsif version_input == 'major'
        version_array[0] += 1
        version_array[1] = 0
        version_array[-1] = 0
      end

      new_version_line = "## "+version_array.join(".")+" - "+Time.now.strftime("%Y-%m-%d")

      file.insert(unreleased_line_num + 1, new_version_line)
      file.insert(unreleased_line_num + 1, '', '')

      File.open('changelog.md', 'w') {|f| f.write(file.join("\n"))}

      unless Dir.glob("*.gemspec").empty?
        api_gemspec_file = RAILS_ROOT.split('/').last + '.gemspec'
        if Dir.glob("*.gemspec").include?(api_gemspec_file)
          file = File.open(directory + api_gemspec_file).read.split("\n")

          file.each_with_index do |line, line_num|
            if line.match("")
          end


        end
      end

    end

    private

    def self.question
      puts 'Is this a major, minor, or patch release? 
      major: when you make incompatible API changes
      minor: when you add functionality in a backwards-compatible manner
      patch: when you make backwards-compatible bug fixes'
      answer = gets.chomp
      answer.downcase!

      if ! ['major', 'minor', 'patch'].include?(answer)
        puts "Make sure you chose 'major', 'minor', or 'patch' "
        question
      end
    end

  end
