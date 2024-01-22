RSpec.describe 'User', type: :feature do
  let(:user) { User.create(name: 'Steve', photo: 'https://unsplash.com/photos/F_-0000BxGuVvo', bio: 'Tester') }
  let!(:post1) { Post.create(author: user, title: 'Hey', text: 'This is my post') }
  let!(:post2) { Post.create(author: user, title: 'Hello', text: 'Another post') }
  let!(:post3) { Post.create(author: user, title: 'Greetings', text: 'Yet another post') }

  context 'show page' do
    it 'shows profile picture' do
      visit user_path(user)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it 'show user name' do
      visit user_path(user)
      expect(page).to have_content(user.name)
    end

    it 'show number of posts by the user' do
      visit user_path(user)
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it "shows a button that lets me view all of a user's posts." do
      visit user_path(user)
      expect(page).to have_selector('a', text: 'View All Posts')
    end
  end

  context 'show' do
    it 'show user bio' do
      visit user_path(user)
      expect(page).to have_content(user.bio.to_s)
    end

    it 'displays the first three posts and a "Show All" button' do
      visit user_path(user)
      posts = user.posts.order(created_at: :desc).limit(3)
      first_post = posts[0]
      second_post = posts[1]
      third_post = posts[2]
      if user.posts.any?
        expect(page).to have_content(first_post.title) if first_post
        expect(page).to have_content(second_post.title) if second_post
        expect(page).to have_content(third_post.title) if third_post
        expect(page).to have_selector('a', text: 'View All Posts')
      end
    end
  end

  context 'Clicks' do
    it "redirects me to that post's show page when I click on a post" do
      visit user_posts_path(user)
      if user.posts.any?
        first_recent_post = user.posts.order(created_at: :desc).first

        expect(page).to have_css('.post-container', count: user.posts.count)

        first(:link, first_recent_post.title).click

        expect(page).to have_current_path(post_path(first_recent_post))
      end
    end

    it "redirects me to the user's post clicking on View All Posts" do
      visit user_path(user)
      click_link 'View All Posts'
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
