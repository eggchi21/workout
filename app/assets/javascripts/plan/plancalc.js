$(function(){
  var user = gon.user

  function bmrCalc(user,weight){
    if (user.sex == 'man' ){
      return 66 + 13.7 * weight + 5.0 * user.height - 6.8 * user.age
    }else{
      return 665 + 9.6 * weight + 1.7 * user.height - 7.0 * user.age
    }
  }
  function tdeeCalc(bmr,user){
    if (user.activity == 'exercise0'){
      return bmr * 1.2
    }else if(user.activity == 'exercise1to2'){
      return bmr * 1.375
    }else if(user.activity == 'exercise2to3'){
      return bmr * 1.55
    }else if(user.activity == 'exercise3to4'){
      return bmr * 1.725
    }else if(user.activity == 'exercise7'){
      return bmr * 1.9
    }else{
      return 'ng'
    }
  }
  function termOrCalorieCalc(num,volume){
    return 7200 * volume / num
  }
  function resetCalorieCalc(){
    $('.initial-none--date').css({
      'display':'none'
    })
  }
  $(document).on('change keyup', '#start-weight',function() {
    var weight = $(this).val()
    $('.caution--start_weight').css({
      'display':'none'
    })
    if (weight < 40 ){
      $('.caution--start_weight').fadeIn("slow")
      $('.initial-none--weight').fadeOut("slow")
    } else{
      $('.plan-form__weight--caution').fadeOut("slow")
      var bmr = bmrCalc(user,weight)
      var tdee = Math.round(tdeeCalc(bmr,user))
      $('.initial-none--weight').fadeIn("slow")
      $('#target-weight').val(weight - 3)
      $('.plan-form__tdee--numeric').text(`${tdee}kcal`)
      var dt = new Date();
      var y = dt.getFullYear();
      var m = ("00" + (dt.getMonth()+1)).slice(-2);
      var d = ("00" + dt.getDate()).slice(-2);
      var startOn = y + "/" + m + "/" + d;
      $('#start_on_datepicker').val(startOn)
    }
  })
  $(document).on('change keyup', '#target-weight',function() {
    var startWeight =  $('#start-weight').val()
    var targetWeight =  $('#target-weight').val()
    $('.caution--target_weight').css({
      'display':'none'
    })
    if (targetWeight > startWeight){
      $('.caution--target_weight').fadeIn("slow").text('開始体重以上は設定できません')
    } else if (37 > targetWeight){
      $('.caution--target_weight').fadeIn("slow").text('37kg以下は設定できません')
    }
  })
  $(document).on('change keyup', '.calc-calorie',function() {
    var startOn = new Date($('#start_on_datepicker').val())
    var targetOn = new Date($('#target_on_datepicker').val())
    resetCalorieCalc()
    if (targetOn > startOn){
      var term = (targetOn - startOn ) / 86400000 + 1
      var startWeight =  $('#start-weight').val()
      var targetWeight =  $('#target-weight').val()
      var bmr = bmrCalc(user,startWeight)
      var tdee = Math.round(tdeeCalc(bmr,user))
      var volume = startWeight - targetWeight
      var tdei = tdee - Math.round(termOrCalorieCalc(term,volume))
      $('.initial-none--date').fadeIn("slow")
      if (tdei > 1200){
        $('.plan-form__tdei--numeric').text(`${tdei}kcal`)
      }else{
        var diff = 1200 - tdei
        var lowestdiff = tdee - 1200
        var lowestOn = startOn
        lowestOn.setDate(lowestOn.getDate() + Math.floor(termOrCalorieCalc(lowestdiff,volume)))
        var lowestterm = [lowestOn.getFullYear(), lowestOn.getMonth() + 1, lowestOn.getDate()].join('/');
        $('.plan-form__tdei--numeric').html(`1日の最低摂取カロリーまで<br/>${diff}kcal足りません。<br/>目標体重を変更するか、<br/>目標日を${lowestterm}以降に変更してください`)
      }
    }
  })
  $(document).on('change keyup', '#target_on_datepicker',function() {
    var startOn = new Date($('#start_on_datepicker').val())
    var targetOn = new Date($('#target_on_datepicker').val())
    $('.caution--target_date').css({
      'display':'none'
    })
    if (targetOn < startOn){
      $('.caution--target_date').fadeIn("slow")
    }
  })
})
