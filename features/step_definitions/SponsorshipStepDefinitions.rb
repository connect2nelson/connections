require "selenium-webdriver"

CONSULTANT_URL = "http://localhost:3000/consultants"
driver = nil

Before do
  driver = Selenium::WebDriver.for :firefox
  Consultant.destroy_all
  Sponsorship.destroy_all
end

After do
  driver.quit
end

Given(/^there is a consultant named "([^"]*)" with employee ID "([^"]*)" who wants to learn "([^"]*)"$/) do |full_name, employee_id, wants_to_learn|
  Consultant.create!(employee_id: employee_id, full_name: full_name, primary_role: 'Dev', home_office: 'San Francisco',
      working_office: 'San Francisco', skills: {wants_to_learn=>'1'})
end

Given(/^there is a "([^"]*)" expert named "([^"]*)" with employee ID "([^"]*)"$/) do |can_teach, full_name, employee_id|
  Consultant.create!(employee_id: employee_id, full_name: full_name, primary_role: 'Dev', home_office: 'San Francisco',
      working_office: 'San Francisco', skills: {can_teach=>'5'})
end

Given(/^I am on the consultant page for employee ID "([^"]*)"$/) do |employee_id|
  driver.navigate.to CONSULTANT_URL + "/" + employee_id
end

When(/^I click on the sponsorship tab$/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 3) # seconds
  begin
    wait.until {driver.find_element(:id, "sponsorship-tab")}
  end
  driver.find_element(:id, "sponsorship-tab").click
end

When(/^I click on the mentees tab$/) do
  mentee_tab = driver.find_element(:id, "mentees-tab")
  mentee_tab.click
end

When(/^I click on the mentors tab$/) do
  mentor_tab = driver.find_element(:id, "mentors-tab")
  mentor_tab.click
end

And(/^I click on the add sponsee button for "([^"]*)"$/) do |sponsee_name|
  add_sponsee_button = driver.find_element(:id, sponsee_name)
  add_sponsee_button.click
end

And(/^I click on the add sponsor button for "([^"]*)"$/) do |sponsor_name|
  add_sponsee_button = driver.find_element(:id, sponsor_name)
  add_sponsee_button.click
end

And(/^I add "([^"]*)" as a new sponsee$/) do |sponsee_name|
  sponsee_name = "" if sponsee_name.blank?
  nameInput = driver.find_element(:css, "#sponsee_full_name.sponsee_search")
  nameInput.send_keys sponsee_name
  nameInput.click
  addButton = driver.find_element(:class, "submit_sponsee")
  addButton.click
end

And(/^I add "([^"]*)" as a new sponsor$/) do |sponsor_name|
  sponsor_name = "" if sponsor_name.blank?
  nameInput = driver.find_element(:css, "#sponsor_full_name.sponsor_search")
  nameInput.send_keys sponsor_name
  nameInput.click
  addButton = driver.find_element(:id, "add_sponsor")
  addButton.click
end

Then(/^I should see "([^"]*)" show up as a sponsee on the page$/) do |sponsee|
  wait = Selenium::WebDriver::Wait.new(:timeout => 3) # seconds
  begin
    wait.until {driver.find_element(:css, "#panel-sponsorship .name > a")}
  end
  expect(driver.find_element(:css, "#panel-sponsorship .name > a").attribute("innerHTML")).to eq(sponsee)

end

Then(/^I should see "([^"]*)" show up as a mentor on the page$/) do |mentor|
  wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
  begin
    wait.until {driver.find_element(:css, "#panel-mentors .name > a")}
  end
  expect(driver.find_element(:css, "#panel-mentors .name > a").attribute("innerHTML")).to eq(mentor)

end

Given(/^there is a sponsorship between employee IDs "([^"]*)" and "([^"]*)"$/) do |sponsor_id, sponsee_id|
  Sponsorship.create(:sponsee_id => sponsee_id, :sponsor_id => sponsor_id)
end

Then(/^I should see "([^"]*)" in the list of sponsees$/) do |sponseeName|
  sponsee = Consultant.where(:full_name => sponseeName).first
  sponsee_element = driver.find_element(:css, "#consultant_#{sponsee.employee_id} .name > a")
  expect(sponsee_element.attribute("innerHTML")).to include(sponseeName)
end

And(/^I delete "([^"]*)"$/) do |sponseeName|
  sponsee = Consultant.where(:full_name => sponseeName).first
  deleteButton = driver.find_element(:id, "delete_sponsee_#{sponsee.employee_id}")
  deleteButton.click
end

Then(/^I should not see "([^"]*)" in the list of sponsees$/) do |sponseeName|
  wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  begin
    element = wait.until { !driver.find_element(:id, "panel-mentees").text.include?(sponseeName) }
  ensure
    sponsorshipPanel = driver.find_element(:id, "panel-mentees")
  end
  expect(sponsorshipPanel.text).to_not include(sponseeName)
end

Then(/^I should see an error on the page$/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 1) # seconds
  begin
    wait.until { driver.find_element(:class, "alert") }
  end
end

When(/^I click on "([^"]*)"'s name$/) do |sponsor|
  sponsor = driver.find_element(:link, sponsor)
  sponsor.click
end