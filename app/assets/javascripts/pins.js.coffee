# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

 $("#pins").imagesLoaded ->
    $("#pins").masonry itemSelector: '.box'

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Fetching more pins...")
        $.getScript(url)
    $(window).scroll()

$(document).ready ->
  $(".jumbotron").backstretch ["http://img825.imageshack.us/img825/3486/churchu.jpg", "http://img21.imageshack.us/img21/5606/86154183571e2bf4d128h.jpg"],
    duration: 6000
    fade: 750