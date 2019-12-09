$(function(){
  $(document).on('change', 'input[type= "file"]',function(e) {
    e.preventDefault();
    // var formData = new FormData(this);
    var image = $(this).prop('files')[0];                                            //ファイルの情報取得
    console.log(image)
    $.ajax({
      type:'GET',
      url: '/foods/upload',
      data: {file: image},
      dataType:'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      console.log('ok')
      console.log(data)
    })
    .fail(function(){
      alert('失敗しました')
    })
  })
})