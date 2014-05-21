var gulp = require('gulp');


// ============================================================================
// Styles

var csso = require('gulp-csso'),
  sass = require('gulp-sass');

var styles = {
  paths: {
    file: 'styles.scss',
    src: './static/scss/',
    dist: './static/css/',
  },
  bundle: function() {
    return gulp.src(this.paths.src + this.paths.file)
    .pipe(sass())
    .pipe(gulp.dest(this.paths.dist));
  },
  minify: function(stream) {
    return stream
    .pipe(csso())
    .pipe(gulp.dest(this.paths.dist));
  },
  watch: function() {
    gulp.watch(this.paths.src + '**', ['styles']);
  }
};

gulp.task('styles', function() {
  styles.bundle();
});

gulp.task('styles:build', function() {
  var bundle = styles.bundle.bind(styles),
    minify = styles.minify.bind(styles);

  minify(bundle());
});


// ============================================================================
// Tasks

gulp.task('watch', function() {
  styles.watch.call(styles);
});

gulp.task('default', ['styles', 'watch']);
gulp.task('build', ['styles:build']);
