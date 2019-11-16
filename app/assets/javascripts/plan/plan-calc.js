$(function(){
  var diff = 0
  var tdei = 0
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
  function lowfatPfcCalc(){
    $.when(
    $('#plan_protein').val(Math.round(tdei * 0.4 / 4)),
    $('#plan_fat').val(Math.round(tdei * 0.1 / 9)),
    $('#plan_carbo').val(Math.round(tdei * 0.5 / 4))
    ).done(function(){
      $('.initial-none--pfc').fadeIn("slow"),
      pieChartMake()
    })
  }
  function lowcarboPfcCalc(){
    $.when(
    $('#plan_protein').val(Math.round(tdei * 0.3 / 4)),
    $('#plan_fat').val(Math.round(tdei * 0.6 / 9)),
    $('#plan_carbo').val(Math.round(tdei * 0.1 / 4))
    ).done(function(){
      $('.initial-none--pfc').fadeIn("slow"),
      pieChartMake()
    })
  }

  function pieChartMake(){
    var protein =$('#plan_protein').val() * 4
    var fat =$('#plan_fat').val() * 9
    var carbo =$('#plan_carbo').val() * 4
    $('.plan-form__calorie--numeric').text(`${protein + fat + carbo}kcal`),
    // Themes begin
    am4core.useTheme(am4themes_animated);
    // Themes end

    // Create chart instance
    var chart = am4core.create("chartdiv", am4charts.PieChart);

    // Add and configure Series
    var pieSeries = chart.series.push(new am4charts.PieSeries());
    pieSeries.dataFields.value = "calorie";
    pieSeries.dataFields.category = "nutrient";

    // Let's cut a hole in our Pie chart the size of 30% the radius
    chart.innerRadius = am4core.percent(30);

    // Put a thick white border around each Slice
    pieSeries.slices.template.stroke = am4core.color("#fff");
    pieSeries.slices.template.strokeWidth = 2;
    pieSeries.slices.template.strokeOpacity = 1;
    pieSeries.slices.template
      // change the cursor on hover to make it apparent the object can be interacted with
      .cursorOverStyle = [
        {
          "property": "cursor",
          "value": "pointer"
        }
      ];

    pieSeries.alignLabels = false;
    pieSeries.labels.template.bent = true;
    pieSeries.labels.template.radius = 3;
    pieSeries.labels.template.padding(0,0,0,0);

    pieSeries.ticks.template.disabled = true;

    // Create a base filter effect (as if it's not there) for the hover to return to
    var shadow = pieSeries.slices.template.filters.push(new am4core.DropShadowFilter);
    shadow.opacity = 0;

    // Create hover state
    var hoverState = pieSeries.slices.template.states.getKey("hover"); // normally we have to create the hover state, in this case it already exists

    // Slightly shift the shadow and make it more prominent on hover
    var hoverShadow = hoverState.filters.push(new am4core.DropShadowFilter);
    hoverShadow.opacity = 0.7;
    hoverShadow.blur = 5;

    // Add a legend
    chart.legend = new am4charts.Legend();

    chart.data = [{
      "nutrient": "たんぱく質",
      "calorie": protein
    },{
      "nutrient": "脂質",
      "calorie": fat
    }, {
      "nutrient": "炭水化物",
      "calorie": carbo
    }];
  }
  $(document).on('change keyup', '#start-weight',function() {
    var user = gon.user
    var weight = $(this).val()
    $('.caution--start_weight').css({
      'display':'none'
    })
    if (weight < 40 ){
      $('.caution--start_weight').fadeIn("slow")
      $('.initial-none--weight').fadeOut("slow")
      $('.initial-none--date').fadeOut("slow")
      $('.initial-none--pfc').fadeOut("slow")
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
    var user = gon.user
    var startWeight =  $('#start-weight').val()
    var startOn = new Date($('#start_on_datepicker').val())
    var targetOn = new Date($('#target_on_datepicker').val())
    resetCalorieCalc()
    if (targetOn > startOn  && startWeight >= 40){
      var term = (targetOn - startOn ) / 86400000 + 1
      var startWeight =  $('#start-weight').val()
      var targetWeight =  $('#target-weight').val()
      var bmr = bmrCalc(user,startWeight)
      var tdee = Math.round(tdeeCalc(bmr,user))
      var volume = startWeight - targetWeight
      tdei = tdee - Math.round(termOrCalorieCalc(term,volume))
      diff =  tdei - 1200
      $('.initial-none--date').fadeIn("slow")
      if (diff > 0){
        $('.plan-form__tdei--numeric').text(`${tdei}kcal`)
      }else{
        var lowestdiff = tdee - 1200
        var lowestOn = startOn
        lowestOn.setDate(lowestOn.getDate() + Math.floor(termOrCalorieCalc(lowestdiff,volume)))
        var lowestterm = [lowestOn.getFullYear(), lowestOn.getMonth() + 1, lowestOn.getDate()].join('/');
        $('.plan-form__tdei--numeric').html(`1日の最低摂取カロリーまで<br/>${-diff}kcal足りません。<br/>目標体重を変更するか、<br/>目標日を${lowestterm}以降に変更してください`)
        $('.initial-none--pfc').fadeOut("slow")
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
      $('.initial-none--pfc').fadeOut("slow")
    }
  })
  $(document).on('change keyup', '.calc-pfc',function() {
    var startOn = new Date($('#start_on_datepicker').val())
    var targetOn = new Date($('#target_on_datepicker').val())
    var startWeight =  $('#start-weight').val()
    if (diff > 0 && startWeight >= 40 && targetOn > startOn){
      if($('#lowfat_method').prop('checked')){
        lowfatPfcCalc()
      }else if($('#lowcarbo_method').prop('checked')){
        lowcarboPfcCalc()
      }
    }
  })
  $(document).on('change keyup', '.pfc-num',function() {
    pieChartMake()
  })
  $(window).bind("load", function(){
    if(document.URL.match(/\/plans\/\d+\/edit/)) {
      var user = gon.user
      var startWeight =  $('#start-weight').val()
      var startOn = new Date($('#start_on_datepicker').val())
      var targetOn = new Date($('#target_on_datepicker').val())
      resetCalorieCalc()
      var term = (targetOn - startOn ) / 86400000 + 1
      var startWeight =  $('#start-weight').val()
      var targetWeight =  $('#target-weight').val()
      var bmr = bmrCalc(user,startWeight)
      var tdee = Math.round(tdeeCalc(bmr,user))
      var volume = startWeight - targetWeight
      tdei = tdee - Math.round(termOrCalorieCalc(term,volume))
      diff =  tdei - 1200
      $('.plan-form__tdee--numeric').text(`${tdee}kcal`)
      $('.plan-form__tdei--numeric').text(`${tdei}kcal`)
      $('.initial-none--weight').fadeIn("slow")
      $('.initial-none--date').fadeIn("slow")
      $('.initial-none--pfc').fadeIn("slow")
      pieChartMake()
      }

  });
})
