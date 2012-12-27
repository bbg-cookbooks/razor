## 0.3.1 (unreleased)


## 0.3.0 (December 27, 2012)

## Bug fixes

* Add postgresql cookbook for new Gemfile dependency (pg gem). ([@fnichol][])

### Improvements

* Updates to README. ([@fnichol][])
* Use an underscore in recipe names that are composed in razor::default.
  ([@fnichol][])
* [FC044]: Avoid bare attribute keys. ([@fnichol][])


## 0.2.2 (November 15, 2012)

## Bug fixes

* Ensure tftp files are group/world readable. ([@fnichol][])


## 0.2.0 (November 7, 2012)

### Attribute default updates

* razor/app/git\_rev now defaults to `"master"` (previously `"0.7.0"`).
  ([@fnichol][])

### Improvements

* Add foodcritic testing and make TravisCI ready. ([@fnichol][])
* Run bundler with `--without test` to exclude testing dependencies.
  ([@fnichol][])


## 0.1.0 (October 4, 2012)

The initial release.

[@fnichol]: https://github.com/fnichol
