

Given(/^we have a candidate$/) do
  @alice = Candidate.create(name: 'Alice')
end

Given(/^we have some candidates$/) do
  Candidate.create(name: 'Alice')
  Candidate.create(name: 'Bob')
end

Given(/^we have some questions$/) do
  @red_or_blue = Question.create(ask_text: 'Would you rather red pill or blue pill?')
  Question.create(ask_text: 'Would you rather war or famine?')
  Question.create(ask_text: 'Would you rather beef or chicken?')
end

Given(/^we have a constituency$/) do
  @constituency = Constituency.create(name: 'Bethnal Green and Bow')
end

When(/^I visit the candidate api$/) do
  visit "/candidates/#{@alice.id}"
end

When(/^I visit the candidate questions api$/) do
  visit "/candidates/#{@alice.id}/questions"
end

When(/^I visit the constituency api$/) do
  visit "/constituencies/#{@constituency.id}"
end

When(/^I visit the constituency candidates api$/) do
  visit "/constituencies/#{@constituency.id}/candidates"
end

Then(/^I get JSON candidate name$/) do
  expect(page).to have_content 'Alice'
end

Then(/^I get JSON question text$/) do
  expect(page).to have_content 'beef or chicken'
end

Then(/^I get JSON constituency name$/) do
  expect(page).to have_content 'Bethnal Green'
end 

Then(/^I get JSON candidate names for constituency$/) do
  expect(page).to have_content 'Bob'
end

Given(/^we have some questions for a candidate$/) do
  step('we have some questions')
  step('we have a candidate')
end

Given(/^I answer a question$/) do
  @red_or_blue.create_answer(@alice.id,@red_or_blue.id,'whatever')
end

When(/^I visit the unanswered candidate questions api$/) do
  visit "/candidates/#{@alice.id}/questions/unanswered"
end

Then(/^I get JSON unanswered questions only$/) do
  expect(page).to_not have_content('red pill')
end