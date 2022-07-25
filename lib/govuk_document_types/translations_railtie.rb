require "rails"
module GovukDocumentTypes
  class TranslationsRailtie < ::Rails::Railtie
    initializer "govuk_document_types" do |app|
      GovukDocumentTypes::TranslationsRailtie.instance_eval do
        pattern = pattern_from app.config.i18n.available_locales
        add("rails/locale/#{pattern}.yml")
      end
    end

    def self.add(pattern)
      files = Dir[File.join(File.dirname(__FILE__), "../..", pattern)]
      I18n.load_path.concat(files)
    end

    def self.pattern_from(args)
      array = Array(args || [])
      array.blank? ? "*" : "{#{array.join ','}}"
    end
  end
end
