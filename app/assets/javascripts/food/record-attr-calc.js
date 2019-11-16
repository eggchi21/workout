$(function(){
  $(document).on('change keyup', '.unit-calc',function() {
    var unit = $(this).val()
    var record = $(this).parent().parent(".food-record")
    for (var i = 3; i < record.children("td").length - 1; i++){
      if (i == 3) {
        record.children("td").eq(i).text(Math.round(Number(record.children("td").eq(i).attr('value')) * unit ) + "kcal")
      } else{
        record.children("td").eq(i).text(Math.round(Number(record.children("td").eq(i).attr('value')) * unit * 100) / 100 + "g")
      }
    }
    var unitgram = record.find(".gram-calc").data("unitgram")
    record.find(".gram-calc").val(Math.round(unit * unitgram * 10)/ 10)
  })
  $(document).on('change keyup', '.gram-calc',function() {
    var gram = $(this).val()
    var record = $(this).parent().parent(".food-record")
    var unitgram = $(this).data("unitgram")
    Number(record.find(".unit-calc").val(Math.round(gram / unitgram * 10)/ 10))
    for (var i = 3; i < record.children("td").length - 1; i++){
      if (i == 3) {
        record.children("td").eq(i).text(Math.round(Number(record.children("td").eq(i).attr('value')) * gram / unitgram ) + "kcal")
      } else{
        record.children("td").eq(i).text(Math.round(Number(record.children("td").eq(i).attr('value')) * gram / unitgram * 100) / 100 + "g")
      }
    }
  })
})
