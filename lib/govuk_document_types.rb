require "govuk_document_types/translations_railtie" if defined?(Rails)
require "govuk_document_types/version"
require "yaml"

module GovukDocumentTypes
  SUPERTYPES = YAML.load_file("#{File.dirname(__FILE__)}/../data/supertypes.yml")
  SUPERGROUPS = YAML.load_file("#{File.dirname(__FILE__)}/../data/supergroups.yml")

  def self.supertypes(document_type:)
    types = {}

    SUPERTYPES.each do |name, definition|
      group_data = definition["items"].find do |supertype|
        supertype["document_types"].include?(document_type)
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

  def self.supergroup_subgroups(*supergroup_ids)
    SUPERGROUPS
      .dig("content_purpose_supergroup", "items")
      .select { |supergroup| supergroup_ids.include?(supergroup["id"]) }
      .map { |supergroup| supergroup["subgroups"] }
      .flatten
      .uniq
      .sort
  end

  def self.supergroup_document_types(*supergroup_ids)
    subgroup_document_types(*supergroup_subgroups(*supergroup_ids))
  end

  def self.subgroup_document_types(*subgroup_ids)
    SUPERTYPES
      .dig("content_purpose_subgroup", "items")
      .select { |subgroup| subgroup_ids.include?(subgroup["id"]) }
      .map { |subgroup| subgroup["document_types"] }
      .flatten
      .uniq
      .sort
  end
end
