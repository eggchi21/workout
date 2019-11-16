$(function(){
  function appendFoodSuggest(food){
    var html =`<li id = "${food.id}" class="food-search__select" value="${food.name}">${food.name}
                <div class="form-suggest-list__attributes">
                  <div class="protein">${food.protein}</div>
                  <div class="fat">${food.fat}</div>
                  <div class="carbo">${food.carbo}</div>
                  <div class="unit">${food.unit}</div>
                  <div class="gram">${food.gram}</div>
                  <div class="image_url">${food.image_url}</div>
                  <div class="kcal">${food.kcal}</div>
                </div>
              </li>`
    return html;
  }
  function appendFoodList(food){
    var html =`<tr class="food-record" data-id="${food.id_count + 1}" >
                <th>
                  ${food.name}<input id="" class="" value="${food.id}" type="hidden" name="diary[diaryfoods_attributes][${food.id_count}][food_id]">
                </th>
                <td>${food.unit}</td>
                <td>
                  <input class="unit-calc" step="0.1" type="number" name="diary[diaryfoods_attributes][${food.id_count}][amount]" id="diary_diaryfoods_attributes_${food.id_count}_amount" value ="1.0" ,width ="20px">個
                </td>
                <td>
                  <input class="gram-calc" step="0.1" type="number" name="diary[diaryfoods_attributes][${food.id_count}][amount]" id="diary_diaryfoods_attributes_${food.id_count}_amount" value ="${food.gram}" data-unitgram="${food.gram}">g
                </td>
                <td value="${food.kcal}">${food.kcal}kcal</td>
                <td value="${food.protein}">${food.protein}g</td>
                <td value="${food.fat}">${food.fat}g</td>
                <td value="${food.carbo}">${food.carbo}g</td>
                <td>
                  <input type="button" value="削除" class="record-delete"/>
                </td>
              </tr>`
    return html;
  }
  function calcPfcKcal(){
    var totalprotein = 0
    var totalfat = 0
    var totalcarbo = 0
    var totalkcal = 0

    var targetkcal = Number($(".kcal-calc__table").find("td").eq(0).text().replace(/[^\d+\.\d+]/g, ''))
    $(".food-record").each(function(index,elem){
      totalkcal += Number($(elem).children("td").eq(3).text().replace(/[^\d+\.\d+]/g, ''))
      totalprotein += Number($(elem).children("td").eq(4).text().replace(/[^\d+\.\d+]/g, ''))
      totalfat += Number($(elem).children("td").eq(5).text().replace(/[^\d+\.\d+]/g, ''))
      totalcarbo += Number($(elem).children("td").eq(6).text().replace(/[^\d+\.\d+]/g, ''))
    })
    var pfc = [totalprotein,totalfat,totalcarbo]
    $(".kcal-calc__table").find("td").eq(1).text(totalkcal +'kcal')
    $(".pfc-calc__table").find("td").eq(3).text(Math.round(totalprotein* 100) / 100  +'g')
    $(".pfc-calc__table").find("td").eq(4).text(Math.round(totalfat* 100) / 100  +'g')
    $(".pfc-calc__table").find("td").eq(5).text(Math.round(totalcarbo* 100) / 100  +'g')
    for (var i = 0; i < 3; i++){
      if (Number($(".pfc-calc__table").find("td").eq(i).attr('value')) < pfc[i]) {
        $(".pfc-calc__table").find("td").eq(i+3).css({
          'font-weight':'bold',
          'color':'red'
        })
      } else{
        $(".pfc-calc__table").find("td").eq(i+3).css({
          'font-weight':'bold',
          'color':'bule'
        })
      }
    }
    if(totalkcal > targetkcal){
      $(".kcal-calc__table").find("td").eq(2).text(totalkcal - targetkcal + 'kcalオーバーしてます')
      $(".kcal-calc__table").find("td").eq(2).css({
        'font-weight':'bold',
        'color':'red'
      })
    }else{
      $(".kcal-calc__table").find("td").eq(2).text(targetkcal - totalkcal + 'kcal分まだ余裕があります')
      $(".kcal-calc__table").find("td").eq(2).css({
        'font-weight':'bold',
        'color':'blue'
      })
    }
  }

  $(document).on('keyup', "#food-search__field",function() {
    var input = $(this).val();
    $.ajax({
      type:'GET',
      url: '/foods/search',
      data: { keyword: input},
      dataType:'json'
    })
    .done(function(foods){
      $(".food-search__suggest").empty();
      var insertHTML = '';
      if (input.length != 0 && foods.length !== 0 ){
        foods.forEach(function(food){
          insertHTML += appendFoodSuggest(food);
        });
      } else{
        insertHTML = `<li>一致するフードはありません</li>`
      }
      $('.food-search__suggest').append(insertHTML)
    })
    .fail(function(){
      alert('失敗しました')
    })
  })
  $(document).on('click',".food-search__select",function(){
    var id = $(this).attr('id')
    var name = $(this).attr('value')
    var protein = $(this).find('.protein').text()
    var fat = $(this).find('.fat').text()
    var carbo = $(this).find('.carbo').text()
    var unit = $(this).find('.unit').text()
    var gram = $(this).find('.gram').text()
    var image_url = $(this).find('.image_url').text()
    var kcal = $(this).find('.kcal').text()
    var id_count = $(".food-record").last().data("id")
    var food = {id: id,
                name: name,
                protein: protein,
                fat: fat,
                carbo: carbo,
                unit: unit,
                gram: gram,
                image_url: image_url,
                kcal: kcal,
                id_count: id_count
                }
    $(".food-search__suggest").children().remove()
    insertList = appendFoodList(food)
    $(".food-added__table").append(insertList)
    calcPfcKcal()
  })
  $(document).on('click',".record-delete",function(){
    $(this).parent().parent().remove()
    calcPfcKcal()
  })
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
    calcPfcKcal()
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
    calcPfcKcal()
  })
})