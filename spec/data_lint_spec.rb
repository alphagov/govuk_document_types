require "spec_helper"

describe GovukDocumentTypes do
  describe "supertypes.yml" do
    it "does not have duplicates across supertypes" do
      GovukDocumentTypes::SUPERTYPES.each do |supertype_name, definition|
        all_supertypes = definition["items"].reduce([]) do |a, supertype|
          a + supertype["document_types"]
        end

        all_supertypes.uniq.each do |e|
          next if all_supertypes.count(e) == 1

          raise "The document type '#{e}' occurs in multiple groups in #{supertype_name}"
        end
      end
    end

    it "defines a default supertype for all document types" do
      GovukDocumentTypes::SUPERTYPES.each do |name, definition|
        expect(definition["default"]).not_to be_nil, "No default value provided for '#{name}'"
      end
    end

    it "reserves the default supertype for document types without a group" do
      GovukDocumentTypes::SUPERTYPES.each do |name, definition|
        default = definition["default"]
        definition["items"].each do |supertype|
          expect(supertype.fetch("id")).not_to eql(default),
                                               "'#{name}' defines a supertype name '#{default}', which clashes " \
                                                 "with the default supertype name"
        end
      end
    end

    it "contains only valid document types" do
      schema_directory = ENV["GOVUK_CONTENT_SCHEMAS_PATH"] || "../govuk-content-schemas"
      allowed_document_types = YAML.load_file("#{schema_directory}/lib/govuk_content_schemas/allowed_document_types.yml")

      document_types = GovukDocumentTypes::SUPERTYPES.flat_map do |_name, definition|
        definition["items"].flat_map do |supertype|
          supertype["document_types"]
        end
      end

      expect(document_types - allowed_document_types).to eql([])
    end
  end

  describe "supergroups and subgroup document types" do
    supergroups_data = YAML.load_file("#{File.dirname(__FILE__)}/../data/supergroups.yml")
    supertypes_data = GovukDocumentTypes::SUPERTYPES

    it "tests that a supergroup contains the same document types as it's collective subgroups" do
      supergroups_with_subgroup_data(supergroups_data).each do |supergroup|
        supergroup_document_types = document_types_in_supergroup(supertypes_data, supergroup["id"])

        subgroups_document_types = document_types_for_subgroups_in_supergroup(supergroup, supertypes_data)

        expect(supergroup_document_types).to match_array(subgroups_document_types)
      end
    end
  end

  def supergroups_with_subgroup_data(data)
    data["content_purpose_supergroup"]["items"]
  end

  def document_types_in_supergroup(supertype_data_from_file, supergroup_id)
    supergroup_info = supertype_data_from_file["content_purpose_supergroup"]["items"].find do |supergroup|
      supergroup["id"] == supergroup_id
    end
    supergroup_info["document_types"]
  end

  def document_types_for_subgroups_in_supergroup(supergroup, supertypes_data)
    document_types = []
    supergroup["subgroups"].flat_map do |subgroup|
      subgroup = subgroup_data_from_supertypes(supertypes_data, subgroup)
      document_types.push(subgroup["document_types"])
    end
    document_types.flatten
  end

  def subgroup_data_from_supertypes(supertypes_data, subgroup_id)
    supertypes_data["content_purpose_subgroup"]["items"].find do |subgroup|
      subgroup["id"] == subgroup_id
    end
  end
end
