# Edukasyon Style

Our internal Ruby code style configurations, enforced by Rubocop.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem "edukasyon-style"
end
```

And then execute:

    $ bundle

## Usage

Create a `.rubocop.yml` with the following directives:

```yaml
inherit_gem:
  edukasyon-style:
    - default.yml
```

There's no need to add the `rubocop` gem to your project's `Gemfile`; `rubocop`
is a dependency of `edukasyon-style`, to ensure we use a consistent minimum
version across all of our projects.

## Commands

Running for the whole directory
```
bundle exec edukasyon_style
```

Running for the current changes versus develop
```
bundle exec edukasyon_style current
```

## Credits

We are heavily influenced by:

- [Shopify Ruby Style Guide](http://shopify.github.io/ruby-style-guide/)
- [Rubocop](https://github.com/rubocop-hq/ruby-style-guide#crlf)


# Edukasyon Ruby Style Guide

## General

* Make all lines of your methods operate on the same level of abstraction. (Single Level of Abstraction Principle)
* Code in a functional way. Avoid mutation (side effects) when you can.
* Do not mess around in / monkeypatch core classes when writing libraries.
* Keep the code simple.
* Don’t overdesign.
* Don’t underdesign.
* Avoid bugs.
* Be consistent.
* Use common sense.
* Think for yourself.

### Formatting

* Use UTF-8 as the source file encoding.
* Use 2 space indent, no tabs.
* Use Unix-style line endings.
* Use spaces around operators, after commas, colons and semicolons, around { and before }.
* No spaces after (, [ and before ], ).
* No space after the ! operator.
* No space inside range literals.
* When assigning the result of a conditional expression to a variable, align its branches with the variable that receives the return value.

```
# bad
result =
  if some_cond
    # ...
    # ...
    calc_something
  else
    calc_something_else
  end

# good
result = if some_cond
  # ...
  # ...
  calc_something
else
  calc_something_else
end
```

* Use empty lines between method definitions and also to break up methods into logical paragraphs internally.
* Use spaces around the = operator when assigning default values to method parameters.
* Avoid line continuation \ where not required. In practice, avoid using line continuations for anything but string concatenation.
* Avoid long parameter lists. Align the parameters of a method call, if they span more than one line, with one level of indentation relative to the start of the line with the method call.

```
# starting point (line is too long)
def send_mail(source)
  Mailer.deliver(to: 'bob@example.com', from: 'us@example.com', subject: 'Important message', body: source.text)
end

# bad (double indent)
def send_mail(source)
  Mailer.deliver(
      to: 'bob@example.com',
      from: 'us@example.com',
      subject: 'Important message',
      body: source.text)
end

# good
def send_mail(source)
  Mailer.deliver(
    to: 'bob@example.com',
    from: 'us@example.com',
    subject: 'Important message',
    body: source.text,
  )
end
```

* When chaining methods on multiple lines, indent successive calls by one level of indentation. Use leading `.`.

```
# bad (indented to the previous call)
User.pluck(:name)
    .sort(&:casecmp)
    .chunk { |n| n[0] }

# good
User
  .pluck(:name)
  .sort(&:casecmp)
  .chunk { |n| n[0] }
```

* Align the elements of array literals spanning multiple lines.
* Limit lines to 120 characters.
* Avoid trailing whitespace.
* Avoid extra whitespace, except for alignment purposes.
* End each file with a newline.
* Avoid methods longer than 10 lines of code.
* Don’t use block comments:

```
# bad
=begin
comment line
another comment line
=end

# good
# comment line
# another comment line
```

* Closing method call brace must be on the line after the last argument when opening brace is on a separate line from the first argument.

```
# bad
method(
  arg_1,
  arg_2)

# good
method(
  arg_1,
  arg_2,
)
```

## Syntax

* Use :: only to reference constants (this includes classes and modules) and constructors (like Array() or Nokogiri::HTML()). Do not use :: for regular method invocation.
* Avoid using :: for defining class and modules, or for inheritance, since constant lookup will not search in parent classes/modules.

```
# bad
module A
  FOO = 'test'
end

class A::B
  puts FOO  # this will raise a NameError exception
end

# good
module A
  FOO = 'test'

  class B
    puts FOO
  end
end
```

* Use def with parentheses when there are parameters. Omit the parentheses when the method doesn’t accept any parameters.
* Never use for, unless you know exactly why.
* Never use then.
* Favour the ternary operator(?:) over if/then/else/end constructs.

```
# bad
result = if some_condition then something else something_else end

# good
result = some_condition ? something : something_else
```

* Use one expression per branch in a ternary operator. This also means that ternary operators must not be nested. Prefer if/else constructs in these cases.
* Use ! instead of not.
* Prefer &&/|| over and/or. More info on and/or for control flow.
* Avoid multiline ?: (the ternary operator); use if/unless instead.
* Favour unless over if for negative conditions.
* Do not use unless with else. Rewrite these with the positive case first.
* Use parentheses around the arguments of method invocations. Omit parentheses when not providing arguments. Also omit parentheses when the invocation is single-line and the method:
    * is part of an internal DSL (e.g. Rake, Rails, RSpec, etc., usually methods called in the class definition)
    * has “keyword” status in Ruby (e.g. attr_reader, puts)
    * is an attribute accessor
* Use class methods instead of a rails scope with a multi-line lambda

```
# bad
scope(:pending, -> do
  ...
  ...
end)

# good
def self.pending
  ...
  ...
end
```

* Omit the outer braces around an implicit options hash.
* Use the proc invocation shorthand when the invoked method is the only operation of a block.

```
# bad
names.map { |name| name.upcase }

# good
names.map(&:upcase)
```

* Prefer {...} over do...end for single-line blocks. Avoid using {...} for multi-line blocks. Always use do...end for “control flow” and “method definitions” (e.g. in Rakefiles and certain DSLs). Avoid do...end when chaining.
* Avoid return where not required for control flow.
* Avoid self where not required (it is only required when calling a self write accessor).
* Using the return value of = is okay:

```
if v = /foo/.match(string) ...
```

* Use ||= to initialize variables only if they’re not already initialized.
* Don’t use ||= to initialize boolean variables (consider what would happen if the current value happened to be false).

```
# bad - would set enabled to true even if it was false
@enabled ||= true

# good
@enabled = true if enabled.nil?

# also valid - defined? workaround
@enabled = true unless defined?(@enabled)
* Do not put a space between a method name and the opening parenthesis.
* Use the new lambda literal syntax.
# bad
l = lambda { |a, b| a + b }
l.call(1, 2)

l = lambda do |a, b|
  tmp = a * 7
  tmp * b / 50
end

# good
l = ->(a, b) { a + b }
l.call(1, 2)

l = ->(a, b) do
  tmp = a * 7
  tmp * b / 50
end
```

* Prefer proc over Proc.new.
* Prefix with _ unused block parameters and local variables. It’s also acceptable to use just _.
* Prefer a guard clause when you can assert invalid data. A guard clause is a conditional statement at the top of a function that bails out as soon as it can.

```
# bad
def compute_thing(thing)
  if thing[:foo]
    update_with_bar(thing)
    if thing[:foo][:bar]
      partial_compute(thing)
    else
      re_compute(thing)
    end
  end
end

# good
def compute_thing(thing)
  return unless thing[:foo]
  update_with_bar(thing[:foo])
  return re_compute(thing) unless thing[:foo][:bar]
  partial_compute(thing)
end
```

* Avoid hashes-as-optional-parameters in general. Does the method do too much?
* Prefer keyword arguments over options hash.
* Prefer map over collect, find over detect, select over find_all, size over length.
* Prefer Time over DateTime since it supports proper time zones instead of UTC offsets. More info.
* Prefer Time.iso8601(foo) instead of Time.parse(foo) when expecting ISO8601 formatted time strings like "2018-03-20T11:16:39-04:00".

* Don't do explicit non-nil checks unless you're dealing with boolean values
* Adopt a consistent string literal quoting style. There are two popular styles in the Ruby community, both of which are considered good—single quotes by default
* Indentation of when in a case/when/[else/]end.
* Prefer delegate method for delegations.

## Naming

* Use snake_case for symbols, methods and variables.
* Use CamelCase for classes and modules (keep acronyms like HTTP, RFC, XML uppercase).
* Use snake_case for naming files and directories, e.g. `hello_world.rb`.
* Aim to have just a single class/module per source file. Name the file name as the class/module, but replacing CamelCase with snake_case.
* Use `SCREAMING_SNAKE_CASE` for other constants.
* When using inject with short blocks, name the arguments according to what is being injected, e.g. |hash, e| (mnemonic: hash, element)
* When defining binary operators, name the parameter other(<< and [] are exceptions to the rule, since their semantics are different).
* The names of predicate methods (methods that return a boolean value) should end in a question mark (i.e. Array#empty?). Methods that don’t return a boolean, shouldn’t end in a question mark.
* Method names should not be prefixed with is_. E.g. prefer empty? over is_empty?.
* Avoid magic numbers. Use a constant and give it a useful name.

## Comments

* Good comments focus on the reader of the code, by helping them understand the code. The reader may not have the same understanding, experience and knowledge as you. As a writer, take this into account.
* A big problem with comments is that they can get out of sync with the code easily. When refactoring code, refactor the surrounding comments as well.
* Write good copy, and use proper capitalization and punctuation.
* Focus on why your code is the way it is if this is not obvious, not how your code works.
* Avoid superfluous comments. If they are about how your code works, should you clarify your code instead?
* For a good discussion on the costs and benefits of comments, see http://c2.com/cgi/wiki?CommentCostsAndBenefits.

## Classes & Modules

* Prefer modules to classes with only class methods. Classes should be used only when it makes sense to create instances out of them.
* Favour the use of extend self over module_function when you want to turn a module’s instance methods into class methods.

```
# bad
module SomeModule
  module_function

  def some_method
  end

  def some_other_method
  end
end

# good
module SomeModule
  extend self

  def some_method
  end

  def some_other_method
  end
end
```

* Use a class << self block over def self. when defining class methods, and group them together within a single block.

```
# bad
class SomeClass
  def self.method1
  end

  def method2
  end

  private

  def method3
  end

  def self.method4 # this is actually not private
  end
end

# good
class SomeClass
  class << self
    def method1
    end

    private

    def method4
    end
  end

  def method2
  end

  private

  def method3
  end
end
```

* When designing class hierarchies make sure that they conform to the Liskov Substitution Principle.
* Use the attr family of methods to define trivial accessors or mutators.

```
# bad
class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end
end

# good
class Person
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end
end
```

* Avoid the use of attr. Use attr_reader and attr_accessor instead.
* Avoid the usage of class (@@) variables due to their “nasty” behavior in inheritance.
* Indent the public, protected, and private methods as much as the method definitions they apply to. Leave one blank line above the visibility modifier and one blank line below in order to emphasize that it applies to all methods below it.

```
class SomeClass
  def public_method
    # ...
  end

  private

  def private_method
    # ...
  end

  def another_private_method
    # ...
  end
end
```

* Avoid alias when alias_method will do.

## Exceptions

* Signal exceptions using the raise method.
* Don’t specify RuntimeError explicitly in the two argument version of raise.

```
# bad
raise RuntimeError, 'message'

# good - signals a RuntimeError by default
raise 'message'
```

* Prefer supplying an exception class and a message as two separate arguments to raise, instead of an exception instance.

```
# bad
raise SomeException.new('message')
# Note that there is no way to do `raise SomeException.new('message'), backtrace`.

# good
raise SomeException, 'message'
# Consistent with `raise SomeException, 'message', backtrace`.
```

* Do not return from an ensure block. If you explicitly return from a method inside an ensure block, the return will take precedence over any exception being raised, and the method will return as if no exception had been raised at all. In effect, the exception will be silently thrown away.

```
def foo
  raise
ensure
  return 'very bad idea'
end
```

* Use implicit begin blocks where possible.

```
# bad
def foo
  begin
    # main logic goes here
  rescue
    # failure handling goes here
  end
end

# good
def foo
  # main logic goes here
rescue
  # failure handling goes here
end
```

* Don’t suppress exceptions.

```
# bad
begin
  # an exception occurs here
rescue SomeError
  # the rescue clause does absolutely nothing
end

# bad - `rescue nil` swallows all errors, including syntax errors, and
# makes them hard to track down.
do_something rescue nil
```

* Avoid using rescue in its modifier form.

```
# bad - this catches exceptions of StandardError class and its descendant classes
read_file rescue handle_error($!)

# good - this catches only the exceptions of Errno::ENOENT class and its descendant classes
def foo
  read_file
rescue Errno::ENOENT => error
  handle_error(error)
end
```

* Avoid rescuing the Exception class.

```
# bad
begin
  # calls to exit and kill signals will be caught (except kill -9)
  exit
rescue Exception
  puts "you didn't really want to exit, right?"
  # exception handling
end

# good
begin
  # a blind rescue rescues from StandardError, not Exception.
rescue => error
  # exception handling
end
```

* Favour the use of exceptions from the standard library over introducing new exception classes.
* Don’t use single letter variables for exceptions (error isn’t that hard to type).

```
# bad
begin
  # an exception occurs here
rescue => e
  # exception handling
end

# good
begin
  # an exception occurs here
rescue => error
  # exception handling
end
```

## Collections

* Prefer literal array and hash creation notation (unless you need to pass parameters to their constructors, that is).

```
# bad
arr = Array.new
hash = Hash.new

# good
arr = []
hash = {}
```

* Prefer %w to the literal array syntax when you need an array of words (non-empty strings without spaces and special characters in them).

```
# bad
STATES = ['draft', 'open', 'closed']

# good
STATES = %w(draft open closed)
```

* Usage of trailing comma in multi-line collection literals is encouraged. It makes diffs smaller and more meaningful.

```
# not encouraged
{
  foo: :bar,
  baz: :toto
}

# encouraged
{
  foo: :bar,
  baz: :toto,
}
```

* Prefer %i to the literal array syntax when you need an array of symbols. Apply this rule only to arrays with two or more elements.

```
# bad
STATES = [:draft, :open, :closed]

# good
STATES = %i(draft open closed)
```

* When accessing the first or last element from an array, prefer first or last over [0] or [-1].
* Avoid the use of mutable objects as hash keys.
* Use the Ruby 1.9 hash literal syntax when your hash keys are symbols.
* Don’t mix the Ruby 1.9 hash syntax with hash rockets in the same hash literal. When you’ve got keys that are not symbols stick to the hash rockets syntax.

```
# bad
{ a: 1, 'b' => 2 }

# good
{ :a => 1, 'b' => 2 }
```

* Use Hash#key? instead of Hash#has_key? and Hash#value? instead of Hash#has_value?. As noted here by Matz, the longer forms are considered deprecated.

```
# bad
hash.has_key?(:test)
hash.has_value?(value)

# good
hash.key?(:test)
hash.value?(value)
```

* Use Hash#fetch when dealing with hash keys that should be present.

```
heroes = { batman: 'Bruce Wayne', superman: 'Clark Kent' }
# bad - if we make a mistake we might not spot it right away
heroes[:batman] # => "Bruce Wayne"
heroes[:supermann] # => nil

# good - fetch raises a KeyError making the problem obvious
heroes.fetch(:supermann)
```
* Introduce default values for hash keys via Hash#fetch as opposed to using custom logic.

```
batman = { name: 'Bruce Wayne', is_evil: false }

# bad - if we just use || operator with falsy value we won't get the expected result
batman[:is_evil] || true # => true

# good - fetch work correctly with falsy values
batman.fetch(:is_evil, true) # => false
```

* Closing ] and } must be on the line after the last element when opening brace is on a separate line from the first element.

```
# bad
[
  1,
  2]

{
  a: 1,
  b: 2}

# good
[
  1,
  2,
]

{
  a: 1,
  b: 2,
}
Strings
```

* Prefer string interpolation and string formatting instead of string concatenation:

```
# bad
email_with_name = user.name + ' <' + user.email + '>'

# good
email_with_name = "#{user.name} <#{user.email}>"

# good
email_with_name = format('%s <%s>', user.name, user.email)
```

* With interpolated expressions, there should be no padded-spacing inside the braces.

```
# bad
"From: #{ user.first_name }, #{ user.last_name }"

# good
"From: #{user.first_name}, #{user.last_name}"
```

* Adopt a consistent string literal quoting style.
* Don’t use the character literal syntax ?x. Since Ruby 1.9 it’s basically redundant - ?x would interpreted as 'x' (a string with a single character in it).
* Don’t leave out {} around instance and global variables being interpolated into a string.

```
class Person
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  # bad - valid, but awkward
  def to_s
    "#@first_name #@last_name"
  end

  # good
  def to_s
    "#{@first_name} #{@last_name}"
  end
end

$global = 0
# bad
puts "$global = #$global"

# fine, but don't use globals
puts "$global = #{$global}"
```

* Don’t use Object#to_s on interpolated objects. It’s invoked on them automatically.

```
# bad
message = "This is the #{result.to_s}."

# good
message = "This is the #{result}."
```

* Don’t use String#gsub in scenarios in which you can use a faster more specialized alternative.

```
url = 'http://example.com'
str = 'lisp-case-rules'

# bad
url.gsub('http://', 'https://')
str.gsub('-', '_')
str.gsub(/[aeiou]/, '')

# good
url.sub('http://', 'https://')
str.tr('-', '_')
str.delete('aeiou')
```

* When using heredocs for multi-line strings keep in mind the fact that they preserve leading whitespace. It’s a good practice to employ some margin based on which to trim the excessive whitespace.

```
code = <<-END.gsub(/^\s+\|/, '')
  |def test
  |  some_method
  |  other_method
  |end
END
# => "def test\n  some_method\n  other_method\nend\n"

# In Rails you can use `#strip_heredoc` to achieve the same result
code = <<-END.strip_heredoc
  def test
    some_method
    other_method
  end
END
# => "def test\n  some_method\n  other_method\nend\n"
```

* In Ruby 2.3, prefer “squiggly heredoc” syntax, which has the same semantics as strip_heredoc from Rails:

```
code = <<~END
  def test
    some_method
    other_method
  end
END
# => "def test\n  some_method\n  other_method\nend\n"
Regular expressions
```

* Don’t use regular expressions if you just need plain text search in string: string['text']
* Use non-capturing groups when you don’t use the captured result.

```
# bad
/(first|second)/

# good
/(?:first|second)/
```

* Don’t use the cryptic Perl-legacy variables denoting last regexp group matches ($1, $2, etc). Use Regexp#match instead.

```
# bad
/(regexp)/ =~ string
process $1

# good
/(regexp)/.match(string)[1]
```

* Avoid using numbered groups as it can be hard to track what they contain. Named groups can be used instead.

```
# bad
/(regexp)/ =~ string
...
process Regexp.last_match(1)

# good
/(?<meaningful_var>regexp)/ =~ string
...
process meaningful_var
```

* Be careful with ^ and $ as they match start/end of line, not string endings. If you want to match the whole string use: \A and \z (not to be confused with \Z which is the equivalent of /\n?\z/)

```
string = "some injection\nusername"
string[/^username$/]   # matches
string[/\Ausername\z/] # doesn't match
Percent Literals
```

* Use %()(it’s a shorthand for %Q) for single-line strings which require both interpolation and embedded double-quotes. For multi-line strings, prefer heredocs.
* Avoid %q unless you have a string with both ' and " in it. Regular string literals are more readable and should be preferred unless a lot of characters would have to be escaped in them.
* Use %r only for regular expressions matching at least one ‘/’ character.

```
# bad
%r{\s+}

# good
%r{^/(.*)$}
%r{^/blog/2011/(.*)$}
```

* Avoid the use of %s. Use :"some string" to create a symbol with spaces in it.
* Prefer () as delimiters for all % literals, except %r. Since parentheses often appear inside regular expressions in many scenarios a less common character like { might be a better choice for a delimiter, depending on the regexp’s content.

## Testing

* Treat test code like any other code you write. This means: keep readability, maintainability, complexity, etc. in mind.
* Minitest is the preferred test framework.
* A test case should only test a single aspect of your code.
* A good test case consists of three parts:
    1. Setup of the environment
    2. The action that is the subject of the test
    3. Asserting that the action did what you expect it do to.
Consider separating these parts by a newline for readability, especially when your environment setup is complicated and you want to run multiple assertions afterwards.

```
test 'sending a password reset email clears the password hash and set a reset token' do
  user = User.create!(email: 'bob@example.com')
  user.mark_as_verified

  user.send_password_reset_email

  assert_nil user.password_hash
  refute_nil user.reset_token
end
```

* A complex test should be split into multiple simpler tests that test functionality in isolation.
* Prefer using test 'foo'-style syntax to define test cases over def test_foo.
* Prefer using assertion methods that will yield a more descriptive error message.

```
# bad
assert user.valid?
assert user.name == 'tobi'


# good
assert_predicate user, :valid?
assert_equal 'tobi', user.name
```

* Avoid using assert_nothing_raised. Use a positive assertion instead.
* Prefer using assertions over expectations. Expectations lead to more brittle tests, especially in combination with singleton objects.

```
# bad
StatsD.expects(:increment).with('metric')
do_something

# good
assert_statsd_increment('metric') do
  do_something
end
```

## The rest

* Avoid long methods.
* Avoid long parameter lists.
* Avoid needless metaprogramming.
* Never start a method with get_.
* Never use a ! at the end of a method name if you have no equivalent method without the bang. Methods are expected to change internal object state; you don’t need a bang for that. Bangs are to mark a more dangerous version of a method, e.g. save returns a bool in ActiveRecord, whereas save! will throw an exception on failure.
* Avoid using update_all. If you do use it, use a scoped association (Shop.where(amount: nil).update_all(amount: 0)) instead of the two-argument version (Shop.update_all({amount: 0}, amount: nil)). But seriously, you probably shouldn’t be doing it in the first place.
* Prefer public_send over send so as not to circumvent private/protected visibility.
* Write ruby -w safe code.
* Avoid more than three levels of block nesting.
*

## Rails
* Use `before_action` over before filter
* Use validates :attribute, hash of validations
