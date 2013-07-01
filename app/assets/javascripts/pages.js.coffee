# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(".jumbotron").backstretch ["http://img268.imageshack.us/img268/6011/girlrunning.png", "http://img812.imageshack.us/img812/5082/sunsetlr.jpg","http://imageshack.us/a/img41/9122/churchn.jpg"],
    duration: 6000
    fade: 750

$(document).ready ->
  $("body").mouseenter ->
    $(".live").slideDown "slow"
  