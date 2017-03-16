require "spec_helper"

describe GovukDocumentTypes do
  describe 'supertypes.yml' do
    it "does not have duplicates across supertypes" do
      GovukDocumentTypes::DATA.each do |supertype_name, definition|
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
      GovukDocumentTypes::DATA.each do |name, definition|
        expect(definition["default"]).not_to be_nil,
          "No default value provided for '#{name}'"
      end
    end

    it "reserves the default supertype for document types without a group" do
      GovukDocumentTypes::DATA.each do |name, definition|
        default = definition["default"]
        definition["items"].each do |supertype|
          expect(supertype.fetch("id")).not_to eql(default),
            "'#{name}' defines a supertype name '#{default}', which clashes " +
            "with the default supertype name"
        end
      end
    end

    it "contains only valid document types" do
      schema_directory = ENV["GOVUK_CONTENT_SCHEMAS_PATH"] || "../govuk-content-schemas"
      allowed_document_types = YAML.load_file("#{schema_directory}/lib/govuk_content_schemas/allowed_document_types.yml")

      document_types = GovukDocumentTypes::DATA.flat_map do |name, definition|
        definition["items"].flat_map do |supertype|
          supertype["document_types"]
        end
      end

      expect(document_types - allowed_document_types).to eql([])
    end
  end
end
