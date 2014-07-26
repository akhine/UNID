(function() {
  $(document).ready(function() {
    var jowl, owl;
    $(document).foundation({
      reveal: {
        animation_speed: 500
      }
    });
    jowl = $(".owl-carousel");
    if (jowl.length) {
      owl = jowl.owlCarousel({
        items: 1,
        dots: true,
        loop: true,
        autoPlay: true,
        autoplayTimeout: 5000,
        autoplayHoverPause: true
      });
      owl.on("translate.owl.carousel", function() {
        return owl.find('img.figure').addClass('notransition').removeClass('inView');
      });
      owl.on("translated.owl.carousel", function() {
        return owl.find('img.figure').removeClass('notransition').addClass('inView');
      });
      return owl.find('img.figure').addClass('inView');
    }
  });

}).call(this);
