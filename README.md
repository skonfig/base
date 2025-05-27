# skonfig base set

[skonfig](https://skonfig.li) is a system configuration and automation framework
designed to work with all systems, from your toaster to the data centre.

skonfig uses three main repositories:

* [skonfig](https://github.com/skonfig/skonfig) - implementation of the **skonfig** executable,
* **base** - explorer and types for **general use**,
* [extra](https://github.com/skonfig/extra) - **special purpose** types and incubator for new types.

Check out the [skonfig](https://github.com/skonfig/skonfig) repository to learn
how to get started.

**Need support?** You can find us in `#skonfig:matrix.org` ([matrix?](https://matrix.org/faq/)).

## Documentation

Most parts of the [cdist documentation](https://www.cdi.st/manual/latest/) still
apply, but there are some differences:

* `skonfig` does only `config` (see `skonfig -h`),
* types are managed in sets (like this one),
* type manifests can be a directory of scripts,
* `gencode-*` can be a directory of scripts,
* some types behave differently and it's recommended to consult the `man.rst`
  files in *base* and *extra*.

## What are *base* and *extra*?

**Base** explorers and types are used to change the state of the operating
system or core components of it and are not for some specific piece of
software. Furthermore, the quality requirements for inclusion in base are
higher than for extra.

**Extra** contains types for specific purposes like configuring software or
services which don't belong to the operating system and also serves as an
incubator for new types.

Even more types can be found in sets specialised in helping you configure a
specific piece of software. Some of these sets can be found in this organization.

And being a fork of [cdist](https://cdis.st/) originally, your cdist manifests
and types will continue to work with skonfig with no or minimal adjustments.
