$(document).ready ()->
  #foundation init
  $(document).foundation(
    reveal:
      animation_speed: 500
  )

  #enable Owl Carousel
  jowl = $(".owl-carousel");
  if jowl.length
    jSlider = jowl.closest('.slider');
    owl = $(".owl-carousel").owlCarousel
      items: 1
      dots: false
      loop: true
    owl.on "translate.owl.carousel", -> owl.find('img.figure').addClass('notransition').removeClass('inView')
    owl.on "translated.owl.carousel", -> owl.find('img.figure').removeClass('notransition').addClass('inView')
    jSlider.find(".navleft").click (e) -> owl.trigger("prev.owl.carousel")
    jSlider.find(".navright").click (e) -> owl.trigger("next.owl.carousel")
    owl.find('img.figure').addClass('inView')
    jSlider.data('owl', owl)

    resizeSlider = () -> jSlider.css('height', ($(window).height() - jSlider.offset().top) + 'px');
    window.onresize = resizeSlider
    resizeSlider()
