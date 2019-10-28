// $(function(){
//   var picture_num = ""
// //---関数---drophere作成----------------------------------------------------------------------------------------------------------------------
//   function appendDropBox(image_count,picture_num){
//     var dropboxHtml = '';
//     dropboxHtml = `<li class="re__sell-upload-drop-box drophere">
//                     <input id="re__sell-upload-drop-box__file_${image_count}" class="re__sell-upload-drop-box__file" data-image="${image_count}" name="item[item_images_attributes][${picture_num}]][image_url]" type="file">
//                     <label class="re__sell-upload-drop-box__text" for="re__sell-upload-drop-box__file_${image_count}">
//                       <p >ドラッグアンドドラッグドロップ<br>またはクリックしてファイルをアップロード</p>
//                     </label>
//                   </li>`;
//     $('.drophere').remove()                                                         //削除した場合もdrophereを追加するので、既存のdrophereは削除
//     $('.re__sell-upload-items').append(dropboxHtml);                                //ul要素であるre__sell-upload-itemsクラスの子どもの最後尾追加
//     $('.drophere').css({
//           'width': `calc(620px - (134px * ${(image_count) % 5 }))`                  //drophereの幅をimage_countの数を5で割った余りで計算して適用
//     })
//     if (image_count == 4 ||image_count == 9 ){                                      //image_countが4か9(各行の最終画像)のときpaddingを変える
//       $('.re__sell-upload-drop-box__text').css({
//         'padding': '10px'
//       })
//     }
//   }
// //---関数---連番再作成----------------------------------------------------------------------------------------------------------------------
//   function renumbering(){
//     var i = 0;
//     $('.re__sell-upload-drop-box__file').each(function(i,elem){
//       $(elem).attr('id',`re__sell-upload-drop-box__file_${i}`);
//       $(elem).parent().attr('for',`re__sell-upload-drop-box__file_${i}`);
//       $(elem).attr('data-image',i);
//       i++;
//     })
//   }
// //---関数---アラート削除----------------------------------------------------------------------------------------------------------------------
//   function resetAlert(){
//     $('.has-error-text').css({
//       'display': 'none'
//     })
//   }
// //🔥発火点---Editビュー読み込み----------------------------------------------------------------------------------------------------------------------
//   $(window).bind("load", function(){
//     if(document.URL.match(/\/items\/\d+\/edit/)) {                                  //正規表現でeditのpathの場合発火する
//       var image_count = $('.re__sell-upload-drop-box__file').length   //既存5枚の場合,drophereはこの時点でないので"5" ※①
//       picture_num = image_count                                                     //Editビュー初期表示ではpicture_numとimage_countは揃える"5" ※②
//       if (image_count != 10){
//         appendDropBox(image_count , picture_num + 1)                               //※②,①を引数にDrophereを作成
//       }
//     }
//   });
// //🔥発火点---ファイル読み込み(編集ボタンor新規画像選択を押す)----------------------------------------------------------------------------------------------------------------------
//   $(document).on('change', 'input[type= "file"]',function() {
//     console.log('ok')
//     resetAlert()                                                                    //アラートを削除
//     var file = $(this).prop('files')[0];                                            //ファイルの情報取得
//     if (file.name.match(/.(jpg|jpeg|png)$/i)){                                      //正規表現でjpg,jpeg,pngに該当するとき実行
//       var blobUrl = window.URL.createObjectURL(file);                               //以下2行でプレビュー作成
//       var preview =`<img src="${blobUrl}" width="114" height="116">`
//       var image_count = $('.re__sell-upload-drop-box__file').last().data('image')   //既存5枚の場合,drophereも含めて"6"
//       picture_num += 1                                                              //inputに画像が１枚入ったのでpicture_numに+1する 既存5枚の場合"6" ※③
//       $(this).parent().parent().prev('img').replaceWith(preview)                    //inputタグの親の親の兄要素が"img"ならpreviewと差し替え(drophereの場合を除いてる)
//       if ($(this).parent().hasClass('drophere')){                                   //drophereのinputタグに写真データを入れたままゴリ押しでプレビュー表示まで成形(inputデータ自体を取得するのはできないらしい)
//         $('.re__sell-upload-drop-box__text').remove();
//         $(this).wrap(`<div class="re__btn_wrapper"><label class="btn re__edit" for="re__sell-upload-drop-box__file_${image_count-1}">編集</label><div class="btn re__delete">削除</div></div>`)
//         $('.re__sell-upload-drop-box').prepend(preview).removeAttr('style').removeClass("re__sell-upload-drop-box drophere").addClass("re__sell-upload-item")
//         $.when(
//           renumbering()                                                             //idとimage-data,親のlabelのforの連番を再配布
//         ).done(function(){
//           image_count = $('.re__sell-upload-drop-box__file').length                 //既存5枚の場合,成形した1枚も含めて"6" ※④
//           if (image_count != 10){
//             appendDropBox(image_count, picture_num + 1)                               //※④,③+1を引数にDrophereを作成
//           }
//         })
//       }
//     }else{
//       $(this).val('')                                                               //正規表現でjpg,jpeg,pngに該当しないとき値をクリア
//       $(this).parent().parent().next('.has-error-text').css({
//         'display': 'block'                                                          //アラート表示
//       })
//     }
//   })
// //🔥発火点---削除ボタンを押す----------------------------------------------------------------------------------------------------------------------
//   $(document).on('click', '.re__delete', function() {
//     resetAlert()                                                                    //アラートを削除
//     $(this).parent().parent().hide();                                               //削除ボタンの親の親ごと非表示 removeだと_destroyを設定してるcheck_boxも消えてしまうためNG
//     $(this).prev().remove()                                                         //削除ボタンの直上の編集ボタンを削除 '.re__sell-upload-drop-box__file'の数を削除の分だけ減らすため
//     $(this).find('.re__sell-upload-drop-box__delete-flag').prop('checked', true)    //削除対象のcheck_boxにチェックを入れる(updateで削除対象となる)
//     $.when(
//       renumbering()                                                                 //idとimage-data,親のlabelのforの連番を再配布
//     ).done(function(){
//       image_count = $('.re__sell-upload-drop-box__file').length                     //既存5枚で1枚削除した場合,drophereも含めて"5"
//       if (image_count == 9 && !$('.re__sell-upload-drop-box__file').last().parent().hasClass("drophere")){  //削除の後のimage_countが9かつdrophereがない(画像10枚がフル投入されてたとき)
//         appendDropBox(image_count , picture_num + 1)                                //削除後の写真の数 と 一度も追加したことない場合②+1,一度でも追加したら③+1を引数にDrophereを作成
//       }else{
//         appendDropBox(image_count -1 , picture_num + 1)                             //削除後の写真の数-1 と 一度も追加したことない場合②+1,一度でも追加したら③+1を引数にDrophereを作成
//       }
//     })
//   })
// })