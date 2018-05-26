// window.onscroll = function() {myFunction()};
//
// var header = document.getElementById("wrap");
// var sticky = header.offsetTop;
//
// function myFunction() {
//   if (window.pageYOffset >= sticky) {
//     header.classList.add("sticky");
//   } else {
//     header.classList.remove("sticky");
//   }
// }


$(document).ready(function() {
  var $infobox = $("#infobox");
  $infobox.hide();

  setTimeout(function(){
    $infobox.fadeIn("medium");
  }, 3000);

  $infobox.first().click(function(){
    $infobox[0].classList.add("off");
  })

});
