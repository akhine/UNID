// The build will inline common dependencies into this file
require.config({
  baseUrl: '/scripts',
  paths: {
    'Owl': '../../bower_components/OwlCarousel2/src/js'
  },
  shim: {
    'Owl': {
      exports: 'Owl'
    }
  }
});

// Bootstrap the app here
require(['modules/app'], function(App) {
  App.init();
});