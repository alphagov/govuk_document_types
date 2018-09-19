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

  def self.display_name(supertype:, group:)
    supertype_group(supertype: supertype, group: group)["display_name"]
  end

  def self.document_types(supertype:, group:)
    supertype_group(supertype: supertype, group: group)["document_types"]
  end

  private_class_method def self.supertype_group(supertype:, group:)
    supertype_groups = DATA[supertype]["items"]
    supertype_groups.detect { |item| item["id"] == group }
  end
end
