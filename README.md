# cdist-conf

This is the [community maintained](https://github.com/cdist-community)
fork of [ungleich](https://github.com/ungleich)'s [cdist](https://github.com/ungleich/cdist)
(after [f061fb1](https://github.com/ungleich/cdist/commit/f061fb168ddacc894cb6e9882ff5c8ba002fadd8)).

Work is mostly split between three main repositories:

* [cdist-core](https://github.com/cdist-community/cdist-core) - implementation of the **cdist core** and quick **getting started** bits.
* **cdist-conf** - **essential** explorers and types (this repository).
* [cdist-extra](https://github.com/cdist-community/cdist-extra) - **non-essential** explorers, types, scripts, tools etc.

## Essential vs non-essential?

Explorers and types, which are related to changing state of the operating
system and are not strictly related to some specific piece of software, are
considered essential.
