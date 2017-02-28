require "spec_helper"

describe GovukDocumentTypes do
  it "has a version number" do
    expect(GovukDocumentTypes::VERSION).not_to be nil
  end

  describe '.supertypes' do
    it 'returns a supertype for a known document type' do
      supertypes = GovukDocumentTypes.supertypes(document_type: 'detailed_guide')

      expect(supertypes).to eql({ "navigation_document_supertype" => "guidance" })
    end

    it 'returns nil for a known document type' do
      supertypes = GovukDocumentTypes.supertypes(document_type: 'something_not_there')

      expect(supertypes).to eql({ "navigation_document_supertype" => nil })
    end
  end
end
