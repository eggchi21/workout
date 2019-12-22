$(function(){
  if(document.URL.match(/\/foods\/new/)) {
    function appendPreview(blobUrl){
      var preview =`<div class="common-form__upload-image--pic"><img src="${blobUrl}"></div>`
      $('.common-form__upload-image').append(preview)
    }
    $(document).on('change', 'input[type= "file"]',function(e) {
      var file = $(this).prop('files')[0];
      if (file.name.match(/.(jpg|jpeg|png)$/i)){
        var blobUrl = window.URL.createObjectURL(file);
        $('.common-form__upload-image--pic').remove()
        appendPreview(blobUrl)
        $('#food_protein').val('')
        $('#food_fat').val('')
        $('#food_carbo').val('')
      }
      e.preventDefault();
      var formData = new FormData();
      formData.append("image",$('input[type=file]')[0].files[0]);
      $.ajax({
        type:'POST',
        url: '/foods/upload',
        data: formData,
        dataType:'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        $('#food_protein').val(data.data.protein)
        $('#food_fat').val(data.data.fat)
        $('#food_carbo').val(data.data.carbo)
        alert(`画像の読み込みに成功しました! たんぱく質:${data.data.protein}g 脂質:${data.data.fat}g 炭水化物:${data.data.carbo}g`)
      })
      .fail(function(){
        alert('画像の読み込みに失敗しました')
      })
    })
  }
})