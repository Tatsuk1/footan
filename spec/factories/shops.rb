FactoryBot.define do
    factory :shop do
        name {'test_shop'}
        shop_url {'http://www.yahoo.co.jp'}
        image_url {'aaaaaa'}
        address {'tokyo'}
        tel {'000-0000-0000'}
        opentime {'10:00'}
        holiday {'Wednesday'}
        shop_code {'111111'}
        pr {'aaaaaaa'}
        budget {'1000'}
        line {'yamanote'}
        station {'tokyo'}
        station_exit {'higashi'}
        walk {'10'}
        category_name_l {'meat'}
        category_l {'111111'}
        category_s{'bird'}
        latitude {'100'}
        longitude {'100'}
        freeword {"焼肉"}
        wifi {'true'}
        outret {'true'}
        takeout {'true'}
    end
end