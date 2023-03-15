# skonfig base set

[skonfig](https://skonfig.li) is a configuration management system forked from [cdist](https://cdi.st)
(after [e250024](https://code.ungleich.ch/ungleich-public/cdist/commit/e2500248f2ddc83129e77f2e6b8dffb64904dbae)).

We have three main repositories:

* [skonfig](https://github.com/skonfig/skonfig) - implementation of the **skonfig tool** and quick **getting started** bits,
* **base** - explorer and types for **general use**,
* [extra](https://github.com/skonfig/extra) - **special purpose** types and incubator for new types.

You can find us in `#skonfig:matrix.org` ([matrix?](https://matrix.org/faq/)).

## Documentation

Most parts of [cdist documentation](https://www.cdi.st/manual/latest/) apply, but there are differences:

* `skonfig` does only `config` (see `skonfig -h`),
* some types behave differently and it's recommended to consult manuals in *base* and *extra*.

## Split between *base* and *extra*

**Base** explorers and types are used to change the state of the operating
system or core components of it and are not for some specific piece of
software. Furthermore, the quality requirements for inclusion in base are
higher than for extra.

**Extra** contains types for specific purposes like configuring software or
services which don't belong to the operating system and also serves as an
incubator for new types.
