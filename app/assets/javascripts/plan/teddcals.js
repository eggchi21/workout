$(function(){
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
  $(document).on('keyup', '#start-weight',function() {
    var weight = Number($(this).val())
    var user = gon.user
    if (user.sex == 'man' ){
      var bmr = 66 + 13.7 * weight + 5.0 * user.height - 6.8 * user.age
    }else{
      var bmr = 665 + 9.6 * weight + 1.7 * user.height - 7.0 * user.age
    }
    var tdee = tdeeCalc(bmr,user)
    console.log(bmr)
    console.log(tdee)

  })
})
