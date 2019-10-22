$(function(){
  var exit_count = 0;
  var elems_count = 0;
  function repeat_show(elems$) {
    elems_count = elems$.length;
    elems$.eq(exit_count).show('fast', function() {
      exit_count ++;
      if(exit_count < elems_count) {
        repeat_show(elems$);
      }
    });
  }

  $(document).ready(function(){
    console.log("ok")
     repeat_show($(".contents__list-item"));
  });
  $("li").hover(
    function () {
      $(this).find("*").css({
        color: "#4dc0b2",
        backgroundColor: "#ffc042"
      });
    },
    function () {
      $(this).find("*").css({
        color: "",
        backgroundColor: ""
      });
    }
  );
})
