require "spec_helper"

describe GovukDocumentTypes do
  it "has a version number" do
    expect(GovukDocumentTypes::VERSION).not_to be nil
  end

  describe '.supertypes' do
    it 'returns a supertype for a known document type' do
      supertypes = GovukDocumentTypes.supertypes(document_type: 'detailed_guide')

      expect(supertypes).to include("navigation_document_supertype" => "guidance")
    end

    it 'returns the default supertype for an unknown document type' do
      supertypes = GovukDocumentTypes.supertypes(document_type: 'something_not_there')

      expect(supertypes).to include("navigation_document_supertype" => "other")
    end
  end

  describe '.supergroup' do
    it 'returns supergroups with matching ids' do
      ids = %w(news_and_communications services)
      supergroups = GovukDocumentTypes.supergroups(ids: ids)

      expect(supergroups.map { |g| g["id"] }).to eq(ids)
    end
  end

  describe '.display_name' do
    it 'returns a configured display name' do
      supertype = "content_purpose_supergroup"
      group = "policy_and_engagement"

      name = GovukDocumentTypes.display_name(supertype: supertype, group: group)
      expect("Policy papers and consultations").to eq(name)
    end

    it 'returns nil if the display name is not configured' do
      supertype = "content_purpose_document_supertype"
      group = "updates-and-alerts"

      name = GovukDocumentTypes.display_name(supertype: supertype, group: group)
      expect(nil).to eq(name)
    end
  end
end
