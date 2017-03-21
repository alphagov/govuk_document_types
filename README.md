# GOV.UK document types

This gem contains the "document supertypes" for GOV.UK. Supertypes are groupings
of document types.

https://docs.publishing.service.gov.uk/document-types.html

This gem is only to be used in [publishing-api][publishing-api] and
[rummager][rummager]. **Don't use it in your project**.

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
[schemas-pr]: https://github.com/alphagov/govuk-content-schemas/pull/551
[content-store-pr]: https://github.com/alphagov/content-store/pull/268

[publishing-api]: https://github.com/alphagov/publishing-api
[rummager]: https://github.com/alphagov/rummager
