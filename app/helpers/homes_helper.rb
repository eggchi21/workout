module HomesHelper
  def contents
    homes =[
      {title: "HOME",url:root_path},
    ]

    common_contents = [
      {title: "みんなの目標",url:plans_path},
      {title: "アプリについて",url:about_homes_path},
    ]

    before_user_session = [
      {title: "ログイン",url:new_user_session_path},
      {title: "新規登録",url:step1_signup_index_path},
      {title: "たべもの図鑑",url:foods_path},
    ]
    after_user_session = [
      {title: "ユーザー情報",url:edit_user_path(current_user)},
      {title: "体重表",url:user_reports_path(current_user)},
      {title: "体重を記録する",url:new_user_report_path(current_user)},
      {title: "食事記録表",url:diaries_path},
      {title: "食事を記録する",url:new_diary_path},
      {title: "たべもの図鑑",url:foods_path},
      {title: "たべもの登録",url:new_food_path},


    ] if user_signed_in?
    mycontents =[
      {title: "Qiita",url:"https://qiita.com/eggchi21"},
      {title: "GitHub",url:"https://github.com/eggchi21/workout"}
    ]
    logout =[
      {title: "ログアウト",url:logout_homes_path},
    ]

    if user_signed_in?
      homes.push(after_user_session).push(common_contents).push(mycontents).push(logout).flatten!
    else
      homes.push(before_user_session).push(common_contents).push(mycontents).flatten!
    end
  end
end
