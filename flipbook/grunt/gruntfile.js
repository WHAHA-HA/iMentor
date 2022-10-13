module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
        build: {
            options: { force: true },
            src: ['<%= pkg.build %>', '<%= pkg.temp %>']
        },
        production: {
            options: { force: true },
            src: ['<%= pkg.production %>']
        }
    },
    ngAnnotate: {
        options: {
            singleQuotes: true,
            sourceMap: true
        },
        app: {
            files: [
                {
                    expand: true,
                    cwd: '<%= pkg.approot %>static/flipbook/js',
                    src: ['**/*.js','!production/*.js'],
                    dest: '<%= pkg.temp %>annotated',
                    ext: '.js', // Dest filepaths will have this extension.
                    extDot: 'last',       // Extensions in filenames begin after the last dot
                },
                {
                    expand: true,
                    cwd: '<%= pkg.webroot %>',
                    src: [
                        'static/canvas/js/upload.service.js',
                        'static/canvas/js/embed.service.js',
                        'static/canvas/js/upload.service.js',
                        'static/canvas/js/helper.js',
                        'static/canvas/js/blockui.directive.js',
                        'static/canvas/js/image.selector.directive.js',
                        'static/conversations/scripts/chatModule-admin.js',
                        'static/conversations/scripts/conv_obo.js',
                    ],
                    dest: '<%= pkg.temp %>annotated',
                    ext: '.js', // Dest filepaths will have this extension.
                    extDot: 'last',       // Extensions in filenames begin after the last dot
                    flatten: false
                }
            ]
        }
    },
    uglify: {
        options: {
            sourceMap : false,
            sourceMapIncludeSources : false
        },
      build: {
        files: [
            {
                expand: true,
                cwd: '<%= pkg.temp %>annotated',
                src: ['**/*.js'],
                dest: '<%= pkg.temp %>js',
                ext: '.js',
                extDot: 'last'
            }
        ]
      }
    },
    cssmin: {
      options: {
        shorthandCompacting: false,
        roundingPrecision: -1,
        cleancss: false,
        keepSpecialComments: '*',
        advanced: false
        },
      build: {
        files: [{
                expand: true,
                cwd: '<%= pkg.approot %>static/flipbook/css',
                src: ['./**/*.css','!./production/*'],
                dest: '<%= pkg.temp %>css',
                ext: '.css',
                extDot: 'last',       // Extensions in filenames begin after the last dot
            },
            {
                expand: true,
                cwd: '<%= pkg.webroot %>',
                src: [
                    'static/conversations/css/themes.css',
                    'static/conversations/css/custom.css',
                    'static/conversations/css/style.css',
                ],
                dest: '<%= pkg.temp %>css',
                ext: '.css', // Dest filepaths will have this extension.
                extDot: 'last',       // Extensions in filenames begin after the last dot
            }
        ]
      }, 
      production: {
        files: [{
                '<%= pkg.approot %>static/flipbook/css/production/libs.min.css': [
                    //'<%= pkg.libs %>bootstrap/css/bootstrap.min.css',
                    //'<%= pkg.libs %>font-awesome/css/font-awesome.min.css',
                    '<%= pkg.libs %>bootstrap-toggle/css/bootstrap-toggle.min.css',
                    '<%= pkg.libs %>nvd3-1.1.15-beta/nv.d3.min.css',
                    '<%= pkg.libs %>angular-hamburger/angular-hamburger-toggle.css',
                    '<%= pkg.libs %>angular-multi-select/isteven-multi-select.css',
                    '<%= pkg.libs %>angular-datepicker/angular-datepicker.css',
                    '<%= pkg.libs %>textAngular/textAngular.css',
                    '<%= pkg.libs %>ngDialog/lib/ngDialog.min.css',
                    '<%= pkg.libs %>ngDialog/lib/ngDialog-theme-plain.min.css',
                ]
            },{
                '<%= pkg.approot %>static/flipbook/css/production/app.min.css': [
                    '<%= pkg.temp %>css/header-bar.css',
                    '<%= pkg.temp %>css/flipbook.css',
                    '<%= pkg.temp %>css/static/conversations/css/style.css',
                    '<%= pkg.temp %>css/static/conversations/css/themes.css',
                    '<%= pkg.temp %>css/static/conversations/css/custom.css',
                ]
            }
        ]
      }
    },
    ngtemplates:  {
      app:        {
        cwd:      '<%= pkg.templates %>',
        src:      './**.html',
        dest:     '<%= pkg.temp %>annotated/templates.js'
      }, options:  {
          /*htmlmin: {
              collapseBooleanAttributes:      false,
              collapseWhitespace:             false,
              removeAttributeQuotes:          false,
              removeComments:                 false, // Only if you don't use comment directives! 
              removeEmptyAttributes:          false,
              removeRedundantAttributes:      false,
              removeScriptTypeAttributes:     false,
              removeStyleLinkTypeAttributes:  false
            },*/
            prefix: '<%= pkg.templatePrefix %>',
            module: '<%= pkg.angularModuleName %>',
            url:    function(url) { return url.replace('./', ''); }
        }
    },
    concat: {
        options: {
            
            separator: ';' + grunt.util.linefeed,
            stripBanners: false,
            banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
                '<%= grunt.template.today("yyyy-mm-dd") %> */',
            sourceMap: true
        },
        production:{
            files: {
                '<%= pkg.approot %>static/flipbook/js/production/libs.min.js': [
                    '<%= pkg.libs %>postal/lodash.min.js',
                    '<%= pkg.libs %>jquery/jquery.min.js',
                    '<%= pkg.libs %>exif/exif.js',
                    '<%= pkg.libs %>angular/angular.min.js',
                    '<%= pkg.libs %>angular-ui-bootstrap/ui-bootstrap-tpls.min.js',
                    '<%= pkg.libs %>angular-cookies/angular-cookies.min.js',
                    '<%= pkg.libs %>angular-ui-router/angular-ui-router.min.js',
                    '<%= pkg.libs %>angular-resource/angular-resource.js',
                    '<%= pkg.libs %>angular-ui-utils/ui-utils.min.js',
                    '<%= pkg.libs %>bootstrap/js/bootstrap.min.js',
                    '<%= pkg.libs %>d3-3.3.13/d3.min.js',
                    '<%= pkg.libs %>nvd3-1.1.15-beta/nv.d3.min.js',
                    '<%= pkg.libs %>angular-scroll/angular-scroll.min.js',
                    '<%= pkg.libs %>bootstrap-toggle/js/bootstrap-toggle.min.js',
                    '<%= pkg.libs %>bootstrap-toggle/js/bootstrap-toggle.directive.min.js',
                    '<%= pkg.libs %>angular-nvd3/angular-nvd3.min.js',
                    '<%= pkg.libs %>angular-hamburger/angular-hamburger-toggle.js',
                    '<%= pkg.libs %>angular-multi-select/isteven-multi-select.js',
                    '<%= pkg.libs %>underscore/underscore-min.js',
                    '<%= pkg.libs %>ngDialog/lib/ngDialog.min.js',
                    '<%= pkg.libs %>angular-datepicker/angular-datepicker.js',
                    '<%= pkg.libs %>angular-route/angular-route.min.js',
                    '<%= pkg.libs %>textAngular/textAngular-dropdownToggle.js',
                    '<%= pkg.libs %>textAngular/bootstrap-colorpicker-module.js',
                    '<%= pkg.libs %>textAngular/textAngular-rangy.min.js',
                    '<%= pkg.libs %>textAngular/textAngular-sanitize.custom.js',
                    '<%= pkg.libs %>textAngular/textAngular.js',
                    '<%= pkg.libs %>ngDialog/lib/ngDialog.min.js',
                    '<%= pkg.libs %>isMobile/isMobile.min.js',
                    '<%= pkg.libs %>autolinker/Autolinker.js',
                    '<%= pkg.libs %>exif/angular-fix-image-orientation.js',
                    '<%= pkg.libs %>angular-animate/angular-animate.min.js',
                    '<%= pkg.libs %>textAngular/textAngularSetup.js',
                    '<%= pkg.libs %>ment.io/mentio.custom.js',
                    '<%= pkg.libs %>ng-file-upload/ng-file-upload-shim.js',
                    '<%= pkg.libs %>ng-file-upload/ng-file-upload.js',
                    '<%= pkg.libs %>angular-notifications/angular-notification-icons.min.js',
                    '<%= pkg.libs %>fsm-sticky-header/fsm-sticky-header.js',                    
                ],
                '<%= pkg.approot %>static/flipbook/js/production/app.min.js': [
                    '<%= pkg.temp %>js/static/canvas/js/upload.service.js',
                    '<%= pkg.temp %>js/static/canvas/js/embed.service.js',
                    '<%= pkg.temp %>js/static/canvas/js/upload.service.js',
                    '<%= pkg.temp %>js/static/canvas/js/helper.js',
                    '<%= pkg.temp %>js/static/canvas/js/blockui.directive.js',
                    '<%= pkg.temp %>js/static/canvas/js/image.selector.directive.js',
                    '<%= pkg.temp %>js/app.js',
                    '<%= pkg.temp %>js/datacontext.service.js',
                    '<%= pkg.temp %>js/flipbook.controller.js',
                    '<%= pkg.temp %>js/templates.js',
                    '<%= pkg.temp %>js/static/conversations/scripts/chatModule-admin.js',
                    '<%= pkg.temp %>js/static/conversations/scripts/conv_obo.js',
                ]
            }
        }
    },
    jshint: {
        dev: {
            src: [
                'gruntfile.js',
                '<%= pkg.approot %>static/flipbook/js/*.js', 
                '<%= pkg.approot %>static/flipbook/test/*.js',
                '!<%= pkg.approot %>static/flipbook/js/production/*'
            ],
            options: {
                //jshintrc: 'jshint.json'
            }
        }
    },
    watch: {
        options: {
            livereload: true
        },
        scripts: {
            files: '<%= pkg.approot %>static/flipbook/js/**/*.js',
            tasks: ['jshint'],
            options: {
              spawn: false
            }
        },
        livereload: {
            options: {
                livereload: '<%= connect.options.livereload %>'
            },
            files: ['*.html']
        }
    },
    connect: {
        options: {
            port: 9000,
            livereload: 35729,
            hostname: '*' // * = accessible from anywhere ; default: localhost
        },
        livereload: {
            options: {
                open: true,
                base: [''] // '.tmp',
            }
        }
    },


    //*** Unused task, for future enhancement ***/
    htmlmin: {                                     // Task
        production: {                                      // Target
          options: {                                 // Target options
            removeComments: false,
            collapseWhitespace: false,
            minifyJS: false,
            minifyCSS: false
          },
          files:  [{
                expand: true,
                cwd: '<%= pkg.production %>',
                src: ['./**/*.html'],
                dest: '<%= pkg.production %>',
                ext: '.html'
            }]
        }
    },
    filerev: {
        options: {
          algorithm: 'md5',
          length: 8
        },
        production: {
          src: ['<%= pkg.production %>/js/*.{js}','<%= pkg.production %>/css/*.{css}']
        }
    },
    useminPrepare: {
        html: '<%= pkg.temp %>index.html',
        options: {
          dest: '<%= pkg.production %>'
        }
    },
    usemin: {
        html: '<%= pkg.production %>index.html',
        options: {
            assetsDirs: ['<%= pkg.production %>']
        }
    },
    htmlbuild: {
        build: {
            src: '<%= pkg.approot %>templates/index.html',
            dest: '<%= pkg.temp %>',
            options: {
                sections: {
                    css: '<%= pkg.approot %>templates/build.css.html',
                    js: '<%= pkg.approot %>templates/build.js.html'
                }
            }
        }
    },
    copy: {
        build: {
            files: [
                // Get all css js
                {
                    cwd: '<%= pkg.temp %>',
                    src: [
                        './js/**/*.*', './css/**/*.*'
                    ],
                    dest: '<%= pkg.build %>',
                    expand: true,
                    flatten: false,
                    filter: 'isFile'
                },
                // Get all the HTML
                {
                    cwd: '<%= pkg.approot %>templates',
                    src: ['./**/*.html'],
                    dest: '<%= pkg.build %>app',
                    expand: true,
                    flatten: false,
                    filter: 'isFile',
                    extDot: 'last'
                },
                // Get main HTML
                {
                    src: ['<%= pkg.temp %>index.html'],
                    dest: '<%= pkg.build %>index.html',
                    expand: false,
                    flatten: false,
                    filter: 'isFile'
                },
                // Get data
                {
                    cwd: '<%= pkg.approot %>static/flipbook/data/',
                    src: ['./**/*.*'],
                    dest: '<%= pkg.build %>data/',
                    expand: true,
                    flatten: false,
                    filter: 'isFile'
                }
            ]
        },
        production: {
            files: [
                // Get all the HTML
                {
                    cwd: '<%= pkg.approot %>',
                    src: ['./**/*.html'],
                    dest: '<%= pkg.production %>app',
                    expand: true,
                    flatten: false,
                    filter: 'isFile',
                    extDot: 'last'
                },
                // Get main HTML
                {
                    cwd: '<%= pkg.approot %>templates',
                    src: ['./index-build.html'],
                    dest: '<%= pkg.production %>index.html',
                    expand: false,
                    flatten: false,
                    filter: 'isFile'
                }
            ]
        }
    }
    //*** --Unused task, for future enhancement-- ***/
    
  });

    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-ng-annotate');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-filerev');
    grunt.loadNpmTasks('grunt-usemin');
    grunt.loadNpmTasks('grunt-contrib-htmlmin');
    grunt.loadNpmTasks('grunt-html-build');
    grunt.loadNpmTasks('grunt-angular-templates');
    

    grunt.registerTask('build', [
        'clean:build',
        //'htmlbuild:build',
        'ngtemplates',
        //'jshint',
        'ngAnnotate', 
        'uglify:build',
        'cssmin:build'
        //'copy:build'
    ]);

    grunt.registerTask('production', [
        'build',
        'clean:production',
        //'useminPrepare',
        'cssmin:production',
        'concat:production'
        //'copy:production',
        //'filerev',
        //'usemin',
        //'htmlmin'
    ]);

    grunt.registerTask('server', function (target) {
        if (target === '/') {
            return grunt.task.run(['default', 'connect:development:keepalive']);
        }

        grunt.task.run([
            'connect:livereload',
            'watch'
        ]);
    });

    grunt.registerTask('default', ['build']);

};

    
