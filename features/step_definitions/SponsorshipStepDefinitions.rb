require "selenium-webdriver"

CONSULTANT_URL = "http://localhost:3000/consultants"
driver = nil

Before do
  driver = Selenium::WebDriver.for :firefox
end

After do
  driver.quit
  # Consultant.where("employee_id > 99990").delete
end

Given(/^there is a consultant named "([^"]*)" with employee ID "([^"]*)"$/) do |full_name, employee_id|
  Consultant.create!(employee_id: employee_id, full_name: full_name, primary_role: 'Dev', home_office: 'San Francisco', working_office: 'San Francisco', skills: Hash['Ruby'=>'1', 'Cat'=>'5'])

end

Given(/^I am on the consultant page for employee ID "([^"]*)"$/) do |employee_id|
  driver.navigate.to CONSULTANT_URL + "/" + employee_id
end

When(/^I click on the sponsorship tab$/) do
  sponsorship_tab = driver.find_element(:id, "sponsorship-tab")
  sponsorship_tab.click
end

And(/^I add "([^"]*)" as a new sponsee$/) do |sponsee_name|
  nameInput = driver.find_element(:id, "sponsee_full_name")
  nameInput.send_keys sponsee_name
  nameInput.click
  addButton = driver.find_element(:id, "add_sponsee")
  addButton.click
end

Then(/^I should see "([^"]*)" show up as a sponsee on the page$/) do |sponsee|
#   TODO: implement once the autocomplete bug is fixed
end