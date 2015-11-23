[![GemVersion](https://badge.fury.io/rb/yaml-lint.svg)](http://badge.fury.io/rb/yaml-lint)
[![TravisBuild](https://travis-ci.org/Pryz/yaml-lint.svg?branch=master)](https://travis-ci.org/Pryz/yaml-lint.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/Pryz/yaml-lint/badge.svg?branch=master)](https://coveralls.io/r/Pryz/yaml-lint?branch=master)

yaml-lint
=========

Simple yaml check tool that checks some more things than the original version. yaml-lint still tries to load the YAML file with the
built-in Ruby yaml library and performs some additional checks afterwards.

What it checks
--------------

* correct indentation
* OK: "key": (or single quotes)
* NOK: "key:" (or single quotes)
* OK: key: 'value' (or double quotes)
* NOK: key: value' (or double quotes)

Install
-------

```shell
gem install yaml-lint
```

Usage
-----

Check a file

```shell
yaml-lint filename.yaml
```

Check a complete folder

```shell
yaml-lint hiera/
```
