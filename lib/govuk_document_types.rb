require "govuk_document_types/version"
require "yaml"

module GovukDocumentTypes
  DATA = YAML.load_file(File.dirname(__FILE__) + "/../data/supertypes.yml")

  def self.supertypes(document_type:)
    types = {}

    DATA.each do |name, ary|
      group_data = ary.find do |supertype|
        supertype['document_types'].include?(document_type)
      end

      type = (group_data && group_data["id"]) || "other"
      types.merge!(name => type)
    end

    types
  end
end
