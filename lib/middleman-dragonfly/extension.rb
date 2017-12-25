# Require core library
require 'middleman-core'

# Extension namespace
class MiddlemanDragonfly < ::Middleman::Extension
  cattr_accessor :images

  class << self

    def images
      @images ||= []
    end

  end

  # option :my_option, 'default', 'An example option'

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    # Require libraries only when activated
    # require 'necessary/library'
    require 'dragonfly'

    # set up your extension
    # puts options.my_option
    configure_dragonfly
  end

  def after_configuration
    # Do something
  end

  def after_build
  end

  def build_path image
    dir = File.dirname(image.meta['original_path'])
    subdir = image.meta['geometry'].gsub(/[^a-zA-Z0-9\-]/, '')
    File.join(subdir, image.name)
  end

  def thumb path, geometry
    absolute_path = absolute_source_path path
    return unless File.exist?(absolute_path)

    image = ::Dragonfly.app.fetch_file(absolute_path)
    image.meta['original_path'] = path
    image.meta['geometry'] = geometry
    image = image.thumb(geometry)
    MiddlemanDragonfly.images << image
    image
  end

  def absolute_source_path(path)
    File.join(app.config[:source], app.config[:images_dir], path)
  end

  def absolute_build_path(image)
    File.join(app.config[:build_dir], app.config[:images_dir], build_path(image))
  end

  # A Sitemap Manipulator
  # def manipulate_resource_list(resources)
  # end

  helpers do

    def thumb_url path, geometry
      image = extensions[:dragonfly].thumb(path, geometry)
      return unless image

      if environment == :development
        image.b64_data
      else
        path = extensions[:dragonfly].absolute_build_path(image)
        image.to_file(path).close
        "/#{app.config[:images_dir]}/#{extensions[:dragonfly].build_path(image)}"
      end
    end

    def thumb_tag path, geometry, options={}
      image = extensions[:dragonfly].thumb(path, geometry)
      return unless image

      url = if environment == :development
        image.b64_data
      else
        path = extensions[:dragonfly].absolute_build_path(image)
        image.to_file(path).close
        extensions[:dragonfly].build_path(image)
      end

      image_tag url, options
    end

  end

  private

    def configure_dragonfly
      ::Dragonfly.app.configure do
        datastore :memory
        plugin :imagemagick
      end
    end

end
