
$(document).ready(function() {
  var $infobox = $("#infobox");
//$infobox.css("visibility", "visible");
//  $infobox.animate({visibility: "visible"}, 1000);

  setTimeout(function(){
     $infobox.fadeIn('medium')
  }, 3000);


  $infobox.children("i").click(function(){
    $infobox[0].classList.add("off");
  })

});
