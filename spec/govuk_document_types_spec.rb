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

  describe '.supergroup_subgroups' do
    it 'returns subgroups registered to the specified supergroups' do
      subgroups = GovukDocumentTypes.supergroup_subgroups('policy_and_engagement')

      expect(subgroups).to contain_exactly('policy', 'consultations')
    end
  end

  describe '.supergroup_document_types' do
    it 'returns document types registered to the specified supergroups' do
      document_types = GovukDocumentTypes.supergroup_document_types('transparency')

      expect(document_types)
        .to contain_exactly(
          'aaib_report',
          'corporate_report',
          'foi_release',
          'maib_report',
          'raib_report',
          'transparency',
        )
    end
  end

  describe '.subgroup_document_types' do
    it 'returns document types registered to the specified subgroups' do
      document_types = GovukDocumentTypes.subgroup_document_types('policy', 'research')

      expect(document_types)
        .to contain_exactly(
          'case_study',
          'dfid_research_output',
          'impact_assessment',
          'independent_report',
          'policy_paper',
          'research',
        )
    end
  end
end
