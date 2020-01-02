require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com' )}

    describe 'ユーザー登録機能' do
        # context '登録に必要な入力をした時' do
        #     before do
        #         visit signup_path
        #         fill_in '名前', with: user_a.name
        #         fill_in 'メールアドレス', with: user_a.email
        #         fill_in 'パスワード', with: user_a.password
        #         fill_in 'パスワード再確認', with: user_a.password
        #         click_button 'サインイン'
        #     end

        #     it 'ユーザー登録される' do
        #         expect(response).to redirect_to root_path
        #         expect(flash[:success]).not_to be_empty
        #     end
        # end
    end
end