# given a collection of hashes with key value pairs, return a data 
# structure that shows what keys has duplicate values. 

# Ex: 
# shipments = [{"RBM263575"=>"31236270002605"}, {"RBM264349"=>"31236280009905"}, {"RBM264282"=>"31236280009902"}, {"RBM264317"=>"31236280009884"}, {"RBM263562"=>"31236280009881"}, {"RBM263596"=>"31236280009894"}, {"RBM264396"=>"31236280009714"}, {"RBM264383"=>"31236280009695"}, {"RBM263541"=>"31236280006247"}, {"RBM263529"=>"31236280008221"}, {"RBM263519"=>"31236280008589"}, {"RBM263536"=>"31236280008901"}, {"RBM263575"=>"31236270002605"} ]


tallies = {}

shipments.each do |s|
  if ! tallies.has_key?(s.keys)
    tallies[s.keys] = []
  end
    
  tallies[s.keys].push(s.values).flatten
end

# At this point, 'tallies' should look like this: {"RBM263575" => [31236270002605, 31236270002605], "RBM263575" => ["31236270002605"]}
counts = {}

tallies.each do |k, v|
  if ! counts.has_key?(k)
    counts[k] = {}
    
    v.each do |i|

    end
  else
    v.map {|i| v.count(i)}
  end
end