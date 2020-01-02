require 'rails_helper'

describe '投稿管理機能', type: :system do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com' ) }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com' ) }
    let!(:shop_a) { FactoryBot.create(:shop, name: 'ショップA')}
    let!(:post_a) { FactoryBot.create(:post, title: '最初の投稿', content: '美味しかった',  :image => File.open(File.join(Rails.root,'/spec/bread-2796393_1920_2.jpg')), user: user_a, shop: shop_a)}

    before do
        #ユーザーAを作成しておく
        #ショップAを作成しておく
        #作成者がユーザーAであり、ショップAのものである投稿を作成しておく
        visit login_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログイン'
    end

    describe '投稿一覧表示機能' do
        context 'タイムラインページに行った時' do
            let(:login_user) { user_a }

            before do
                visit posts_path
            end

            it 'タイムラインの投稿が表示される' do
                expect(page).to have_content '最初の投稿'
            end
        end
    end

    describe 'ユーザー詳細ページ表示機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user) { user_a }

            before do
                visit post_path(post_a)
            end
            it 'ユーザーAが作成した投稿が表示される' do
                # ユーザーAが作成した投稿にボタンが画面上に表示されていることを確認
                expect(page).to have_content '最初の投稿'
                expect(page).to have_content '削除'
                expect(page).to have_content '編集'
            end
        end

        context 'ユーザーBがログインしている時' do
            let(:login_user) { user_b }
            before do
                # ユーザーBを作成しておく
                visit post_path(post_a)
            end

            it 'ユーザーAが作成した投稿に削除、編集ボタンが表示されない' do
                # ユーザーAが作成した投稿にボタンが画面上に表示されていないことを確認
                expect(page).to have_content '最初の投稿'
                expect(page).to have_no_content '削除'
                expect(page).to have_no_content '編集'
            end
        end
    end

    # describe '新規作成機能' do
    #     let (:login_user){user_a}

    #     before do
    #         visit new_shop_post_path(shop_a)
    #         attach_file 'Image', "/spec/bread-2796393_1920_2.jpg"
    #         fill_in '料理名', with: post_title
    #         fill_in 'コメント', with: post_a.content
    #         click_button '投稿'
    #     end

    #     context '新規作成画面で名称を入力した時' do
    #         let(:post_title){ '新規作成のテストを書く' }

    #         it '正常に登録される' do
    #             expect(page).to have_content '投稿しました'
    #         end
    #     end

    #     context '新規作成画面で名称を入力しなかった時' do
    #         let(:post_title){''}

    #         it 'エラーとなる' do
    #             expect(page).to have_content '投稿に失敗しました'
    #         end
    #     end
    # end
end