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

## Credits

We are heavily influenced by:

[Shopify Ruby Style Guide](http://shopify.github.io/ruby-style-guide/)
[Rubocop](https://github.com/rubocop-hq/ruby-style-guide#crlf)
