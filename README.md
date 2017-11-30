# GOV.UK document types

This gem contains the "document supertypes" for GOV.UK. Supertypes are groupings
of document types.

https://docs.publishing.service.gov.uk/document-types.html

This gem is only to be used in [publishing-api][publishing-api] and
[rummager][rummager]. **Don't use it in your project**.

## Long term vision

This gem is used to share the canonical list of supertypes between rummager and publishing-api. We're currently migrating to a new system of indexing where rummager gets all data from the publishing-api (via a message queue). Once that work is completed this repo should be retired and the canonical list should be moved to either [govuk-content-schemas][] for use in the publishing-api, or be moved into publishing-api directly.

## How to add a supertype

1. Add it to [data/supertypes.yml](data/supertypes.yml) in this gem and release a new version
2. [Add the supertype][rummager-pr] in Rummager so that it can be indexed and searched with. Bump the gem in Rummager.
3. [Add the type to content-schemas][schemas-pr]
4. [Add the type to the content-store][content-store-pr]
5. Bump the gem version in [publishing-api][publishing-api]

## How to update a supertype

1. Update [data/supertypes.yml](data/supertypes.yml) in this gem and release a new version.
2. Bump the gem version in [rummager][rummager]. Rummager's nightly re-indexing will pick up your changes.
3. Bump the gem version in [publishing-api][publishing-api]. All documents have to be sent to the content-store again for your changes to be picked up.

## Running the test suite

```
bundle exec rake
```

## License

[MIT License](LICENSE.txt)

[rummager-pr]: https://github.com/alphagov/rummager/pull/756
[govuk-content-schemas]: https://github.com/alphagov/govuk-content-schemas
[schemas-pr]: https://github.com/alphagov/govuk-content-schemas/pull/551
[content-store-pr]: https://github.com/alphagov/content-store/pull/268

[publishing-api]: https://github.com/alphagov/publishing-api
[rummager]: https://github.com/alphagov/rummager
