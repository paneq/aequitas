This library provides external validations for any Ruby class.

It originates from [emmanuels aequitas repository](https://github.com/emmanuel/aequitas) 
with the following changes:

* Only support for external validators
* No contextual validators anymore (use additional external validators)
* Use dkubb/equalizer and dkubb/adamantium where possible.

Once these changes are mature they will hopefully be accepted and used as the base for a release.

## Specifying Validations

```ruby
require 'aequitas'

class ProgrammingLanguage
  attr_reader :name

  def initialize(name)
    @name = name
  end
end


VALIDATOR = Aequitas::Validator.build do
  validates_presence_of :name
end

ruby = ProgrammingLanguage.new('ruby')

result = VALIDATOR.new(ruby)
result.valid? # => true
result.errors # => []

other = ProgrammingLanguage.new('')

result = VALIDATOR.new(other)
result.valid? # => false
result.errors # => [<Aequitas::Rule::Violation ....>]

```

See Aequitas::Macros to learn about the complete collection of validation rules available.

## Validating

Aequitas validations may be manually evaluated against a resource using the
`#valid?` method, which will return true if the resource is valid,
and false if it is invalid.

## Working with Validation Errors

If an instance fails one or more validation rules, Aequitas::Violation instances
will populate the Aequitas::ViolationSet object that is available through
the #errors method.

For example:

```ruby
result = YOUR_VALIDATOR.validte(Account.new(:name => "Jose"))
if result.valid?
  # my_account is valid and can be saved
else
  result.errors.each do |e|
    puts e
  end
end
```

See Aequitas::ViolationSet for all you can do with the #errors method.

##Contextual Validation

Aequitas does not provide a means of grouping your validations into
contexts. Define a validator per context for this. 
