# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    m = Movie.create!(movie)
    if not m.nil?
      assert true
    else
      assert false, "Failed to add a movie to DB"
    end
  end
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end


When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do |rating|
    rating.strip!
    if uncheck
      step "I uncheck \"ratings[#{rating}]\""
    else
      step "I check \"ratings[#{rating}]\""
    end
  end
end

Then /I should see (.*) in (.*) column of the table (.*)/ do |values_list, column_id, table_id|
    values = values_list.split(",")
    values.map! {|value| value.strip}
    values_hash = Hash.new(false)
    rows = find("table##{table_id}").all("tr td:nth-child(#{column_id})").each do |rating|
      values_hash[rating.text] = values.include?(rating.text)
      if not values.include?(rating.text)
        assert false, "#{rating.text} is not in the #{values}"
      end
    end
    assert_equal values.sort, values_hash.keys.sort
end

Then /I should see (.*) column of (.*) table sorted/ do |column_id, table_id|
  prev_title = ""
  rows = find("table##{table_id}").all("tr td:nth-child(#{column_id})").each do |title|
      p prev_title
      p title.text
      p prev_title <=> title.text
        if (prev_title <=> title.text) > 0
          assert false, "#{title.text} should be after #{prev_title}"
        end
        prev_title = title.text
  end
  assert true
end
