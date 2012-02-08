Given /^the following apps have been created$/ do |table|
  table.hashes.map do |hash|
    Factory(:application_with_tasks_and_brigades, name: hash['Name'])
  end
end

Then /^I see a directory of the following apps$/ do |table|
  table.hashes.map do |hash|
    page.should have_content hash['Name']
  end
end

Then /^I can see the "([^"]*)" page after followwing the "([^"]*)" link$/ do |app_name, link|
  step 'I am on the homepage'
  step "I follow the \"#{link}\" link"

  find_link(app_name).click

  page.should have_content app_name
  find_link('Github')[:href].should match /github/
  page.should have_content '#brigade-channel'
  page.should have_content '#brigade-hashtag'
  page.should have_content 'Long winded description of application'
  page.should have_content 'Brigades that have deployed this app: '
  page.should have_content '1 Brigade Name'
end
