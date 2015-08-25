$(document).ready ()->
  #foundation init
  $(document).foundation(
    reveal:
      animation_speed: 500
  )

  #enable Owl Carousel
  jowl = $(".owl-carousel");
  if jowl.length
    owl = jowl.owlCarousel
      items:1
      dots:true
      loop:true
      autoPlay:true
      autoplayTimeout:5000
      autoplayHoverPause:true
    owl.on "translate.owl.carousel", -> owl.find('img.figure').addClass('notransition').removeClass('inView')
    owl.on "translated.owl.carousel", -> owl.find('img.figure').removeClass('notransition').addClass('inView')
    owl.find('img.figure').addClass('inView')
 