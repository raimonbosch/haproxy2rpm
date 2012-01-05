# CHANGELOG

## v 0.2.0

* Introducing default route

## v 0.1.1

* BUGFIX: hostnames with hyphens e.g s-app-1 break the syslog parser

## v 0.1.0

* Make Syslog parsing independent from haproxy
* Examples on how to use it with node.js and connect including a simple
  node.js profiler

## v 0.0.10

* Do not crash when an exception occurs during URI parsing (Knut
  Nesheim)

## v 0.0.9

* Support syslog message format (Knut Nesheim)

## v 0.0.8

* config file similar to unicorn.rb
* support for custom parsers
* support for custom recorders
* simple router
* improved test suite

### Known issues

* daemonize mode is still broken

## v 0.0.7

* support for pid file in normal mode (not daemonized)
* daemonize mode is broken
