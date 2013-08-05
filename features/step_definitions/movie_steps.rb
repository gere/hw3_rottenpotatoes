# Add a declarative step here for populating the DB with movies.
#movies_table = Movie.all

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  # debugger
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #debugger
  assert (not page.body.match(/#{e1}.*#{e2}/m).nil?)
  #assert (not page.body.match("Amelie(.|\s)*Chocolat").nil?)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
    if uncheck
      step %Q{I uncheck "ratings[#{rating}]"}
    else
      step %Q{I check "ratings[#{rating}]"}
    end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  end
end

Then /I should (not )?see the following movies:/ do | n, movies_table |
  if n
    movies_table.hashes.each do |movie|
      step %Q{I should not see "#{movie[:title]}"}
      #debugger

    end
  else
    movies_table.hashes.each do |movie|
      #debugger
      step %Q{I should see "#{movie[:title]}"}
    end
  end
end

Then /I should see all of the movies/ do
  movies = Movie.all
  movies.each do |movie|
    step %Q{I should see "#{movie[:title]}"}
  end
end

