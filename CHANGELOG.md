# Unreleased

* Configure display names for content_purpose supertypes
* Lookup of document types that belong to a group within a supertype

# 0.7.1

* Add `hrmc_manual` format to `guidance` `content_purpose_subgroup`

# 0.7.0

* Move `decisions` `content_purpose_subgroup` from `transparency` to `news_and_communications`
* Add new `research_and_statistics` `content_purpose_supergroup`
* Splits `transparency` `content_purpose_supergroup` into `incidents`, `freedom_of_information_releases`, and `transparency_data`
* Move some document types around between `content_purpose_subgroups`

# 0.6.0

* Adds `corporate_report` document type to `content_purpose_subgroup`
  research_and_data and `content_purpose_supergroup` transparency

# 0.5.0

* Adds `statutory_instrument` document type to `content_purpose_subgroup`
  policy and `content_purpose_supergroup` policy_and_engagement

# 0.4.0

* Adds `GovukDocumentTypes.supergroups(:ids)` as a way to retrieve
  supergroups by ID.

# 0.3.0

* Add `content_purpose_supergroup` and `content_purpose_subgroup`

# 0.2.0

* Replace `user_need_document_supertype` by `content_purpose_document_supertype`
* Updates to `content_purpose_document_supertype`

# 0.1.11

* Add travel_advice_index document type to search_user_need_document_supertype
* Add user_need_document_supertype
* Remove calendar document type from navigation_document_supertype
* Remove calendar document type from search_user_need_document_supertype
* Remove business_support_finder document type from user_journey_document_supertype

# 0.1.10

* Add calendar document type to search_user_need_document_supertype
* Add calendar document type to navigation_document_supertype

# 0.1.9

* Add search_user_need_document_supertype for boosting search results for certain document types

# 0.1.8

* Include authored_article in announcements email_super_type

# 0.1.7

* Include authored_article in statements government_super_type

# 0.1.6

* Move all consultation document types under the same email_document_supertype
to resolve a problem with subscriber lists we've never emailed from Whitehall

# 0.1.5

* Add email_document_supertype > announcements > world_news_story to fix some
subscriber list matching problems between govuk-delivery and email-alert-api.

# 0.1.4

* Add "email" and "government" supertypes to help with the whitehall email migration to EmailAlertApi

# 0.1.3

* Remove `notice` from list of guidance document types

# 0.1.2

* Allow users to specify a default group
* Add a "user journey" supertype to indicate whether a page is "finding" or "thing"
* Add names & descriptions to the supertypes

# 0.1.1

* Initial release.
