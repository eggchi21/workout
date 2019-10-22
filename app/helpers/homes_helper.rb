module HomesHelper
  def contents
    titles = [{title: "ログイン",url:step1_signup_index_path},
              {title: "アプリについて",url:about_homes_path},
              {title: "ログアウト",url:logout_homes_path},
              {title: "item4",url:"#4"},
              {title: "item5",url:"#5"},
              {title: "item6",url:"#6"},
              {title: "item7",url:"#7"},
              {title: "item8",url:"#8"},
              {title: "aaaaa",url:"#9"},
              {title: "GitHub",url:"https://github.com/eggchi21"}]
  end
end
