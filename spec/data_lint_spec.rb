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
        definition["items"].each do |supertype|
          expect(supertype.fetch("id")).not_to eql(definition["default"]),
            "'#{name}' defines a supertype name '#{definition["default"]}', " +
              "which clashes with the default supertype name"
        end
      end
    end
  end
end
