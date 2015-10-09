module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "elm.js": ["ProductTable.elm", "Model.elm"]
        }
      }
    },
    watch: {
      elm: {
        files: [ "ProductTable.elm", "Model.elm" ],
        tasks: ["elm"]
      }
    },
    clean: ["elm-stuff/build-artifacts"]
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-elm');

  grunt.registerTask('default', ['elm']);

};
