require 'rails_helper'

feature 'plan', type: :feature do
  let(:user) { create(:user) }

  scenario 'post plan' do
    # ログイン前には投稿ボタンがない
    visit plans_path
    expect(page).to have_no_content('目標を作成する')

    # ログイン処理
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    visit plans_path
    expect(page).to have_content('目標を作成する')

    # planの投稿
    expect {
      click_link('目標を作成する')
      expect(current_path).to eq "/users/#{user.id}/edit"
      fill_in 'user[nickname]', with: 'test'
      fill_in 'user[introduction]', with: 'testdayo'
      choose '男性'
      select '3回～4回/週 程度の運動', from: '活動レベル'
      fill_in 'user[age]', with: '27'
      fill_in 'user[height]', with: '170'
      find('input[type="submit"]').click
      expect(current_path).to eq new_plan_path
      fill_in 'plan[start_weight]', with: '80'
      fill_in 'plan[target_weight]', with: '77'
      fill_in 'plan[start_on]', with: '2019/12/02'
      fill_in 'plan[target_on]', with: '2020/01/25'
      choose 'ローファットダイエット'
      fill_in 'plan[protein]', with: '276'
      fill_in 'plan[fat]', with: '31'
      fill_in 'plan[carbo]', with: '345'
      find('input[type="submit"]').click
    }.to change(Plan, :count).by(1)
  end
end
