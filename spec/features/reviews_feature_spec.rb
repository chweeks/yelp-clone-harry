require 'rails_helper'

feature 'reviewing' do

  before do
    Restaurant.create name: 'KFC'
    @user = create(:user)
    sign_in(@user)
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

  scenario "Doesn't allow a user to post more than one review per restaurant" do
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     click_link 'Review KFC'
     fill_in "Thoughts", with: "awful"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('You have already reviewed this restaurant')
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
