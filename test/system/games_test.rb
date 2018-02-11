require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Fill the form with a random word, click play button, and get a message that the word is not in the grid" do
    visit new_url
    fill_in 'word', with: 'TEST'
    click_on 'Play'
    page.has_content?("Sorry but TEST can't be built out of")

  end

  test "Fill the form with a one-letter consonant word, click play, and get a message it's not a valid English word" do
    visit new_url
    fill_in 'word', with: 'e'
    click_on 'Play'
    page.has_content?("Sorry but e does not seem to be a valid English word...")

  end

  test "Fill the form with a valid English word, click play and get a Congratulations message" do
    visit new_url
    fill_in 'word', with: 'a'
    click_on 'Play'
    page.has_content?("Congratulations! a is a valid English word!")
  end

end
