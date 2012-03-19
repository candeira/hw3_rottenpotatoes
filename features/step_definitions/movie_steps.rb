# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_movie = Movie.create!(movie)
    assert Movie.find_by_id(new_movie[:id]) == new_movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(",").collect { |s| s.strip }    
  ratings.each do |rating|
    if uncheck == "un"
      step %{I uncheck "#{rating}"}
    else
      step %{I check "#{rating}"}
    end
  end
end

Then /I should see the following movies/ do |movies_table|
  movies_table.hashes.each do |movie|
    regex = /#{movie[:title]}.*#{movie[:rating]}/m
    assert_match(regex, page.body)
  end
end

And /I should not see the following movies/ do |movies_table|
  movies_table.hashes.each do |movie|
    regex = /#{movie[:title]}.*#{movie[:rating]}/m
    assert_no_match(regex, page.body)
  end
end
