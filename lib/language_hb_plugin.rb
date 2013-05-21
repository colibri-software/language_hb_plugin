
require 'locomotive_plugins'
require 'rack/accept'

require 'language_hb_plugin/language_drop'

module LanguageHBPlugin
  class Language

    include Locomotive::Plugin

    attr_reader :accept_language

    def self.plugin_loaded
      Locomotive::Extensions::Site::Locales.class_eval do
        def default_locale
          language_object = nil
          enabled_plugin_objects_by_id.each do |id,object|
            if object.class == Language
              language_object = object
              break
            end
          end
          locale = language_object.try(:default_locale)
          if locale && self.locales.include?(locale)
            locale
          else
            self.locales.first || Locomotive.config.site_locales.first
          end
        end
      end
    end

    def accept_language
      return @accept_language if @accept_language
      return nil unless self.controller
      @accept_language = Rack::Accept::Language.new(self.controller.request.env['HTTP_ACCEPT_LANGUAGE'])
    end

    def default_locale
      lang = accept_language
      locale = lang.sort(lang.values).first[0..1] if lang
    end

    before_page_render :reset_accept_language

    before_page_render :set_locale

    def reset_accept_language
      @accept_language = nil
    end

    def set_locale
      self.controller.send(:set_locale)
    end

    def to_liquid
      LanguageDrop.new(self)
    end

  end
end
