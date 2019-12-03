$(function(){
  $(document).on('click','.unliked',function(e){
    e.preventDefault();
    var plan_id = Number($(this).data('plan'))
    var target = $(this)
    $.ajax({
      type:'get',
      url:`/likes/${plan_id}/create`,
      data:{id: plan_id},
      dataType:'json'
    })
    .done(function(likes){
      target.addClass('liked').removeClass('unliked');
      target.find('.like_count').text(" いいね " + likes.length)
    })
    .fail(function(){
      alert('失敗しました')
    })
  })
  $(document).on('click','.liked',function(e){
    e.preventDefault();
    var plan_id = Number($(this).data('plan'))
    var target = $(this)
    $.ajax({
      type:'get',
      url:`/likes/${plan_id}/destroy`,
      data:{id: plan_id},
      dataType:'json'
    })
    .done(function(likes){
      $('.liked').addClass('unliked').removeClass('liked');
      target.find('.like_count').text(" いいね " + likes.length)
    })
    .fail(function(){
      alert('失敗しました')
    })
  })
})