require "spec_helper"

describe GovukDocumentTypes do
  describe 'supertypes.yml' do
    it "does not have duplicates across supertypes" do
      GovukDocumentTypes::DATA.each do |supertype_name, supertypes|
        all_supertypes = supertypes.reduce([]) do |a, supertype|
          a + supertype['document_types']
        end

        all_supertypes.uniq.each do |e|
          next if all_supertypes.count(e) == 1

          raise "The document type '#{e}' occurs in multiple groups in #{supertype_name}"
        end
      end
    end

    it "reserves 'other' for document types without a group" do
      GovukDocumentTypes::DATA.each do |_, supertypes|
        supertypes.each do |supertype|
          expect(supertype.fetch("id")).not_to eql("other")
        end
      end
    end
  end
end
