
$(document).ready(function() {
  var $infobox = $("#infobox");
//$infobox.css("visibility", "visible");
//  $infobox.animate({visibility: "visible"}, 1000);

  setTimeout(function(){
     $infobox.fadeIn('medium')
  }, 3000);

  console.log($infobox.children("fa.fa-times"));
  $infobox.children("i").click(function(){
    $infobox[0].classList.add("off");
  })

});
