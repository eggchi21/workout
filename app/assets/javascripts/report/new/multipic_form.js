$(function(){
//---関数---プレビュー作成----------------------------------------------------------------------------------------------------------------------
  function appendPreview(blobUrl,image_count){
    var preview =`<div class="common-form__image--pic" id="report-preview-${image_count}"><img src="${blobUrl}"></div>`
    $('.common-form__image').append(preview)
  }
//---関数---プレビューリサイズ----------------------------------------------------------------------------------------------------------------------
  function　resizePreviews(image_count){
    if (image_count == 0){
        $('#report-preview-0').find('img').css({
        'width':'400px',
        'height':'400px'
      })
    }else if (image_count == 1){
      $('#report-preview-0').find('img').css({
      'width':'200px',
      'height':'400px'
    })
    $('#report-preview-1').find('img').css({
      'width':'200px',
      'height':'400px'
    })
    }else if(image_count == 2){
      $('#report-preview-0').find('img').css({
        'width':'200px',
        'height':'400px'
      })
      $('#report-preview-1').find('img').css({
        'width':'200px',
        'height':'200px'
      })
      $('#report-preview-2').find('img').css({
        'width':'200px',
        'height':'200px'
      })
    }else if(image_count == 3){
      $('#report-preview-0').find('img').css({
        'width':'200px',
        'height':'200px'
      })
      $('#report-preview-1').find('img').css({
        'width':'200px',
        'height':'200px'
      })
      $('#report-preview-2').find('img').css({
        'width':'200px',
        'height':'200px'
      })
      $('#report-preview-3').find('img').css({
        'width':'200px',
        'height':'200px'
      })
    }
  }
//---関数---投稿ボタン作成----------------------------------------------------------------------------------------------------------------------
  function appendPicBox(image_count){
    var picboxHtml = '';
    picboxHtml = `<input multiple="multiple" id="image-input" class="common-form__image--input" type="file" name="report[images][]">
    <label class="common-form__image--icon-${image_count+1}" for="image-input"><div class="common-form__image--icon-wrap">
    <i class="fas fa-image"></i>
    <div class="common-form__image--icon-text">画像</div>
    </div>
    </label>`;
    $('.common-form__image').prepend(picboxHtml);
    $('.common-form__image').css({
      'width':'400px',
      'height':'440px'
    })
    $('.common-form__image--icon-wrap').css({
      'width':'400px'
    })
    $('.common-form__image--description').css({
      'left':'410px'
    })
  }
//---関数---画像追加済みの投稿ボタン非表示----------------------------------------------------------------------------------------------------------------------
  function hidePicBox(image_count){
    $('.common-form__image--icon-'+image_count).addClass('inactive')
  }
//---関数---連番再作成----------------------------------------------------------------------------------------------------------------------
  function renumbering(){
    var i = 0;
    $('.re__sell-upload-drop-box__file').each(function(i,elem){
      $(elem).attr('id',`re__sell-upload-drop-box__file_${i}`);
      $(elem).parent().attr('for',`re__sell-upload-drop-box__file_${i}`);
      $(elem).attr('data-image',i);
      i++;
    })
  }
//---関数---アラート削除----------------------------------------------------------------------------------------------------------------------
  function resetAlert(){
    $('.has-error-text').css({
      'display': 'none'
    })
  }
//🔥発火点---Editビュー読み込み----------------------------------------------------------------------------------------------------------------------
  $(window).bind("load", function(){
    if(document.URL.match(/\/items\/\d+\/edit/)) {                                  //正規表現でeditのpathの場合発火する
      var image_count = $('.re__sell-upload-drop-box__file').length   //既存5枚の場合,drophereはこの時点でないので"5" ※①
      picture_num = image_count                                                     //Editビュー初期表示ではpicture_numとimage_countは揃える"5" ※②
      if (image_count != 10){
        appendDropBox(image_count , picture_num + 1)                               //※②,①を引数にDrophereを作成
      }
    }
  });
//🔥発火点---ファイル読み込み(編集ボタンor新規画像選択を押す)----------------------------------------------------------------------------------------------------------------------
  $(document).on('change', 'input[type= "file"]',function() {
    resetAlert()                                                                    //アラートを削除
    var file = $(this).prop('files')[0];                                            //ファイルの情報取得
    if (file.name.match(/.(jpg|jpeg|png)$/i)){
      var blobUrl = window.URL.createObjectURL(file);
      var image_count = $('.common-form__image--pic').length;
      appendPreview(blobUrl,image_count)
      appendPicBox(image_count)
      resizePreviews(image_count)
      hidePicBox(image_count)
    }
  })
//🔥発火点---削除ボタンを押す----------------------------------------------------------------------------------------------------------------------
  $(document).on('click', '.re__delete', function() {
    resetAlert()                                                                    //アラートを削除
    $(this).parent().parent().hide();                                               //削除ボタンの親の親ごと非表示 removeだと_destroyを設定してるcheck_boxも消えてしまうためNG
    $(this).prev().remove()                                                         //削除ボタンの直上の編集ボタンを削除 '.re__sell-upload-drop-box__file'の数を削除の分だけ減らすため
    $(this).find('.re__sell-upload-drop-box__delete-flag').prop('checked', true)    //削除対象のcheck_boxにチェックを入れる(updateで削除対象となる)
    $.when(
      renumbering()                                                                 //idとimage-data,親のlabelのforの連番を再配布
    ).done(function(){
      image_count = $('.re__sell-upload-drop-box__file').length                     //既存5枚で1枚削除した場合,drophereも含めて"5"
      if (image_count == 9 && !$('.re__sell-upload-drop-box__file').last().parent().hasClass("drophere")){  //削除の後のimage_countが9かつdrophereがない(画像10枚がフル投入されてたとき)
        appendDropBox(image_count , picture_num + 1)                                //削除後の写真の数 と 一度も追加したことない場合②+1,一度でも追加したら③+1を引数にDrophereを作成
      }else{
        appendDropBox(image_count -1 , picture_num + 1)                             //削除後の写真の数-1 と 一度も追加したことない場合②+1,一度でも追加したら③+1を引数にDrophereを作成
      }
    })
  })
})