var gulp = require("gulp");
var uglify = require("gulp-uglify");
var concat = require("gulp-concat");

gulp.task("concat-css", function(){
  return gulp.src([
    "out/styles/zurb-foundation.css",
    "out/styles/style.css",
    "out/styles/highlightjs-github.css",
    "bower_components/owl.carousel/dist/assets/owl.carousel.min.css",
    "bower_components/owl.carousel/dist/assets/owl.theme.default.min.css"
    ])
    .pipe(concat("all.css"))
    .pipe(gulp.dest("out/styles"));
});

gulp.task("uglify", function(){
  return gulp.src([
    "bower_components/modernizr/modernizr.js",
    "bower_components/jquery/dist/jquery.js",
    "bower_components/fastclick/lib/fastclick.js",
    "bower_components/foundation/js/foundation/foundation.js",
    "bower_components/foundation/js/foundation/foundation.topbar.js",
    "bower_components/owl.carousel/dist/owl.carousel.js",
    "out/scripts/app.js"
    ])
    .pipe(concat("all.js"))
    .pipe(uglify())
    .pipe(gulp.dest("out/scripts"));
});

gulp.task("default", ["uglify", "concat-css"]);
