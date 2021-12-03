# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Sprockets.export_concurrent = false
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts", "images")

Rails.application.config.assets.precompile += %w(
                                                application.js
                                                application_for_new_admin.js
                                                home_references.css 
                                                home_references.js 
                                                ace_admin_references.js
                                                ace_admin_extras_references.js
                                                ace_admin_references.css 
                                                ace_admin_plugins/dataTables.js
                                                ace_admin_plugins/date-time/bootstrap-datepicker.min.js
                                                ace_admin_plugins/date-time/bootstrap-datepicker.min.css
                                                ace_admin_plugins/jquery.raty/jquery.raty.js
                                                ace_admin_plugins/colorbox.css
                                                ace_admin_plugins/select2.min.css
                                                ace_admin_plugins/select2/select2.js
                                                ace_admin_plugins/colorbox.js
                                                plugins/jquery-autosize/jquery.autosize.min.js
                                                plugin/ace-spinner.js
                                                plugin/rs-slider.js
                                                plugin/rs-slider.css
                                                plugins/parallax.js
                                                plugins/magnific-popup.css
                                                plugin/appear.js 
                                                plugin/carousel.js 
                                                plugin/magnific-popup.js 
                                                plugin/carousel.css
                                                plugin/wysihtml5.css
                                                plugin/wysihtml5.js
                                                plugin/jquery-te.css
                                                plugin/jquery-te.js
                                                plugin/raptor.css
                                                plugin/raptor.js
                                                plugin/chosen.css
                                                plugin/chosen.js
                                                plugin/color.css
                                                plugin/color.js
                                                blog/jquery.sharrre.js
                                                searchin_references.js
                                                searchin_references.css
                                                plugin/redactor.js
                                                plugin/redactor.css
                                                blog_references.css
                                                blog_references.js
                                                maps/style.css
                                                maps/google_map_config.js  
                                                plugin/rs-slider_extras.js
                                                plugin/rs-slider_extras.css
                                            )