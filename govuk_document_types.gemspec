# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'govuk_document_types/version'

Gem::Specification.new do |spec|
  spec.name          = "govuk_document_types"
  spec.version       = GovukDocumentTypes::VERSION
  spec.authors       = ["GOV.UK Dev"]
  spec.email         = ["govuk-dev@digital.cabinet-office.gov.uk"]
  spec.summary       = "Gem to share document type groupings"
  spec.description   = "Gem to share document type groupings"
  spec.homepage      = "https://github.com/alphagov/govuk_document_types"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "govuk-lint", "~> 3.0"
  spec.add_development_dependency "i18n-spec"
  spec.add_development_dependency "pry-byebug"
end
