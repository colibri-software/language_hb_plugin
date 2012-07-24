
module LanguagePlugin
  class LanguageDrop < ::Liquid::Drop

    # TODO: make this forbidden
    def initialize(source)
      @source = source
    end

    def current_language
      self.source.accept_language.to_s
    end

    protected

    attr_reader :source

  end
end
