require "spec_helper"

describe "Locale files" do
  Dir.glob("rails/locale/*.yml") do |locale_file|
    it_behaves_like "a valid locale file", locale_file

    translations = YAML.load_file(locale_file)

    %w[content_purpose_supergroup content_purpose_subgroup].each do |supertype|
      context "when the #{supertype} supertype in #{locale_file}" do
        group_ids = GovukDocumentTypes::SUPERTYPES[supertype]["items"].map { |item| item["id"] }

        group_ids.each do |group_id|
          it "has a title for the #{group_id} group" do
            group_title_translation = translations["en"][supertype][group_id]
            expect(group_title_translation).not_to be(nil), "Couldn't find translation for #{supertype}.#{group_id}"
          end
        end
      end
    end
  end
end
