require "govuk_document_types/version"
require "yaml"

module GovukDocumentTypes
  DATA = YAML.load_file(File.dirname(__FILE__) + "/../data/supertypes.yml")
  SUPERGROUPS = YAML.load_file(File.dirname(__FILE__) + "/../data/supergroups.yml")

  def self.supertypes(document_type:)
    types = {}

    DATA.each do |name, definition|
      group_data = definition["items"].find do |supertype|
        supertype['document_types'].include?(document_type)
      end

      type = (group_data && group_data["id"]) || definition["default"]
      types.merge!(name => type)
    end

    types
  end

  def self.supergroups(ids:)
    groups = SUPERGROUPS["content_purpose_supergroup"]["items"]
    groups.select { |g| ids.include?(g["id"]) }
  end
end
