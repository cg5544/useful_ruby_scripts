require 'rubygems'
require 'fastercsv'

namespace :content do
  desc "find contents older than 90 days and have no planograms"
  task :find_old_contents, [:file_path]  => :setup do |t, arg|

    cg = User.where(:email => "jmeola@rbmtechnologies.com").first
    raise "I'am lacking cg!" unless cg
    User.current = cg

    def planogram_count(content)
      ts = content.fixture_templates.accessible(User.current).select('id, is_active')
      ts.select(&:is_active).size.to_s + " / " + ts.size.to_s
    end

    find_content_sql =<<-SQL
      SELECT id
      FROM contents
      WHERE deleted_at IS NULL
      AND created_at < NOW() - INTERVAL '90 days'
      AND NOT is_active
    SQL

    content_ids = ActiveRecord::Base.connection.select_values(find_content_sql)

    puts "There are #{content_ids.size} content."

    count = 0
    contents = Content.find(content_ids).map{ |c|
      # A check to make sure script is making progress
      count += 1
      puts "Now at #{count}" if count % 10 == 0
      
      {:vmm_id => c.id,
        :item_number => c.item_number,
        :name => c.name,
        :created_at => c.created_at,
        # calculate count per piece of content
        :planogram_count => planogram_count(c)
      }
    }.select { |c| c[:planogram_count] == '0 / 0'}

    FasterCSV.open(arg.file_path, "wb") do |csv|
      csv << ["vmm_id", "item_number", "name", "created_at", "planogram_count"]
      contents.each do |c|
        csv << c.values_at(:vmm_id, :item_number, :name, :created_at, :planogram_count )
      end
    end
  end
  
end