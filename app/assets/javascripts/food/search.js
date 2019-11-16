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
  function calcKcal(){
    var totalkcal = 0
    var targetkcal = Number($(".kcal-calc__table").find("td").eq(0).text().replace(/[^0-9]/g, ''))
    $(".food-record").each(function(index,elem){
      totalkcal += Number($(elem).children("td").eq(3).text().replace(/[^0-9]/g, ''))
    })
    $(".kcal-calc__table").find("td").eq(1).text(totalkcal +'kcal')
    if(totalkcal > targetkcal){
      $(".kcal-calc__table").find("td").eq(2).text(totalkcal - targetkcal + 'kcalオーバーしてます')
    }else{
      $(".kcal-calc__table").find("td").eq(2).text(targetkcal - totalkcal + 'kcal分まだ余裕があります')
    }
  }

  $(document).on('keyup', "#food-search__field",function() {
    var input=$(this).val();
    $.ajax({
      type:'GET',
      url: '/foods/search',
      data: { keyword: input},
      dataType:'json'
    })
    .done(function(foods){
      $(".food-search__suggest").empty();
      var insertHTML = '';
      if (input.length != 0 ){
        foods.forEach(function(food){
          insertHTML += appendFoodSuggest(food);
        });
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
    calcKcal()
  })
  $(document).on('click',".record-delete",function(){
    $(this).parent().parent().remove()
    calcKcal()
  })
})