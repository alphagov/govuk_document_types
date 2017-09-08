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
