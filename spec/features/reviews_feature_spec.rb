require 'rails_helper'

feature 'reviewing' do
  before do
    Restaurant.create name: 'KFC'
    User.create(email: 'test@test.com', password: 12345678)
    visit '/users/sign_in'
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: '12345678'
    click_button 'Log in'
  end

  scenario 'allows users to leave a review using a form' do
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  scenario 'deletes review when restaurant is deleted' do
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'
     click_link 'Delete KFC'
     expect(current_path).to eq '/restaurants'
     expect(page).not_to have_content('so so')
  end

end
