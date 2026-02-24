# Mapping Pipeline

## The three-namespace problem

--8<-- "mapping-pipeline/three-namespace-problem.md"

## Qualifier-based mapping

--8<-- "mapping-pipeline/qualifier-based-mapping.md"

## Request mapping flow

--8<-- "mapping-pipeline/request-mapping-flow.md"

In Ruby, request mapping happens inside the private `mqsc_command` method
before the payload is sent. The `Mapping.map_request_attributes` module
method handles the translation:

```ruby
# Internal flow (simplified)
mapped = Mapping.map_request_attributes(
  qualifier, attributes,
  strict: @mapping_strict, mapping_data: @mapping_data
)
```

## Response mapping flow

--8<-- "mapping-pipeline/response-mapping-flow.md"

Response mapping happens after the HTTP response is parsed. The
`Mapping.map_response_list` module method handles batch translation:

```ruby
# Internal flow (simplified)
mapped = Mapping.map_response_list(
  qualifier, parameter_objects,
  strict: @mapping_strict, mapping_data: @mapping_data
)
```

## Custom mapping overrides

--8<-- "mapping-pipeline/custom-mapping-overrides.md"

In Ruby, overrides are passed when creating the session:

```ruby
overrides = {
  'qualifiers' => {
    'queue' => {
      'response_key_map' => {
        'CURDEPTH' => 'queue_depth'
      }
    }
  }
}

session = MQ::REST::Admin::Session.new(
  'https://localhost:9443/ibmmq/rest/v2', 'QM1',
  credentials: MQ::REST::Admin::BasicAuth.new(username: 'admin', password: 'admin'),
  mapping_overrides: overrides,
  mapping_overrides_mode: :merge  # or :replace
)
```

## Strict vs lenient mode

--8<-- "mapping-pipeline/strict-vs-lenient.md"

In Ruby, strict mode raises `MappingError` with an `issues` attribute
containing an array of `MappingIssue` objects:

```ruby
begin
  session.display_queue(name: 'MY.QUEUE', unknown_attr: 'value')
rescue MQ::REST::Admin::MappingError => e
  e.issues.each do |issue|
    puts "#{issue.direction}: #{issue.reason} for #{issue.attribute_name}"
  end
end
```
