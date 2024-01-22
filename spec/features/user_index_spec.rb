require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { User.create(name: 'Steve', photo: 'https://unsplash.com/photos/F_-0000BxGuVvo', bio: 'Tester') }
  let(:post) { Post.create(author: user, title: 'Test', text: 'Test post') }

  context 'displays' do
    it 'I can see the username of all other users' do
      visit users_path
      users = User.all
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'I can see the profile picture for each user' do
      visit users_path
      users = User.all
      users.each do |user|
        expect(page).to have_selector("img[src='#{user.photo}']")
      end
    end

    it 'I can see the number of posts each user has written' do
      visit users_path
      users = User.all
      users.each do |user|
        expect(page).to have_content("Number of posts: #{user.post_counter}")
      end
    end

    it 'When I click on a user, I am redirected to that user\'s show page' do
      visit users_path
      users = User.all
      users.each do |user|
        click_link(user.name)
        expect(page).to have_current_path(user_path(user))
        visit users_path
      end
    end
  end
end
