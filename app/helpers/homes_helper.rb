module HomesHelper
  def contents
    titles = [{title: "ログイン",url:step1_signup_index_path},
              {title: "アプリについて",url:about_homes_path},
              {title: "ログアウト",url:logout_homes_path},
              {title: "投稿する",url:new_user_report_path(current_user)},
              {title: "投稿一覧",url:user_reports_path(current_user)},
              {title: "item6",url:"#6"},
              {title: "item7",url:"#7"},
              {title: "item8",url:"#8"},
              {title: "Qiita",url:"https://qiita.com/eggchi21"},
              {title: "GitHub",url:"https://github.com/eggchi21"}]
  end
end
