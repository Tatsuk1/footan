FactoryBot.define do
    factory :post do
        image { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/bread-2796393_1920_2.jpg')) }
        title { 'テストを書く' }
        content {'美味'}
        user
        shop
    end
end