'use strict';
 
var gulp = require('gulp');
var sass = require('gulp-sass');
 
gulp.task('sass', function () {
  return gulp.src('./blog/static/*.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./blog/static'));
});
 
gulp.task('sass:watch', function () {
  gulp.watch('./blog/static/*.scss', ['sass']);
});

gulp.task('default', ['sass','sass:watch']);
