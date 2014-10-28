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
  # Consultant.where("employee_id > 99990").delete
end

Given(/^there is a consultant named "([^"]*)" with employee ID "([^"]*)"$/) do |full_name, employee_id|
  Consultant.create!(employee_id: employee_id, full_name: full_name, primary_role: 'Dev', home_office: 'San Francisco', working_office: 'San Francisco', skills: Hash['Ruby'=>'1'])
end

Given(/^there is a Ruby expert named "([^"]*)" with employee ID "([^"]*)"$/) do |full_name, employee_id|
  Consultant.create!(employee_id: employee_id, full_name: full_name, primary_role: 'Dev', home_office: 'San Francisco', working_office: 'San Francisco', skills: Hash['Ruby'=>'5'])
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

Then(/^I should see "([^"]*)" show up as a sponsee on the page$/) do |sponsee|
  wait = Selenium::WebDriver::Wait.new(:timeout => 3) # seconds
  begin
    wait.until {driver.find_element(:css, "#panel-sponsorship .name > a")}
  end
  expect(driver.find_element(:css, "#panel-sponsorship .name > a").attribute("innerHTML")).to eq(sponsee)

end

Given(/^there is a sponsorship between employee IDs "([^"]*)" and "([^"]*)"$/) do |sponsor_id, sponsee_id|
  Sponsorship.create(:sponsee_id => sponsee_id, :sponsor_id => sponsor_id)
end

Then(/^I should see "([^"]*)" in the list of sponsees$/) do |sponseeName|
  sponsorPerson = Consultant.where(:full_name => sponseeName).first
  sponsor = driver.find_element(:id, "consultant_" + sponsorPerson.employee_id)
  expect(sponsor.text).to include(sponseeName)
end

And(/^I remove the first sponsee on their list of sponsees$/) do
  deleteButton = driver.find_element(:id, "delete_sponsee")
  deleteButton.click
end

Then(/^I should not see "([^"]*)" in the list of sponsees$/) do |sponseeName|
  wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  begin
    element = wait.until { !driver.find_element(:id, "panel-sponsorship").text.include?(sponseeName) }
  ensure
    sponsorshipPanel = driver.find_element(:id, "panel-sponsorship")
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