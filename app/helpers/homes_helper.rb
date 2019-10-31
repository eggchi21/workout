module HomesHelper
  def contents
    titles = [
      {title: "アプリについて",url:about_homes_path},
      {title: "item7",url:"#7"},
      {title: "item8",url:"#8"},
    ]

    before_user_session = [
      {title: "ログイン",url:new_user_session_path},
      {title: "新規登録",url:step1_signup_index_path},
    ]
    after_user_session = [
      {title: "マイページ",url:edit_user_path(current_user)},
      {title: "投稿する",url:new_user_report_path(current_user)},
      {title: "投稿一覧",url:user_reports_path(current_user)},
    ] if user_signed_in?
    mycontents =[
      {title: "Qiita",url:"https://qiita.com/eggchi21"},
      {title: "GitHub",url:"https://github.com/eggchi21"}
    ]
    logout =[
      {title: "ログアウト",url:logout_homes_path},
    ]

    if user_signed_in?
      after_user_session.push(titles).push(mycontents).push(logout).flatten!
    else
      before_user_session.push(titles).push(mycontents).flatten!
    end
  end
end
