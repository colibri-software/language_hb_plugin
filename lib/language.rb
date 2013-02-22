
require 'rack/accept'

require 'language/language_drop'

module LanguagePlugin
  class Language

    include Locomotive::Plugin

    attr_reader :accept_language

    def accept_language
      return @accept_language if @accept_language

      @accept_language = Rack::Accept::Language.new(self.controller.request.env['HTTP_ACCEPT_LANGUAGE'])
    end

    before_page_render :reset_accept_language

    before_page_render :set_locale

    def reset_accept_language
      @accept_language = nil
    end

    def set_locale
      locale = accept_language.sort(accept_language.values).first[0..1]
      if !self.controller.params[:locale] \
        && self.controller.send(:current_site).locales.include?(locale)
        self.controller.params[:locale] = locale
        self.controller.send(:set_locale)
      end
    end

    def to_liquid
      LanguageDrop.new(self)
    end

  end
end
