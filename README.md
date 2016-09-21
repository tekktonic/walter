Walter is a quick little pluggable user agent for fun. It works by defining a set of verbs, which correspond to handlers defined in modules. Based on the verb, Walter calls the handler with the remainder of argv as the arguments to the verb.

Usage: `walter [verb] [verb arguments]`

# Installation
Walter assumes you have a working Perl install of a version >= 5.10. It also assumes that you have CPAN installed and configured, and requires the following modules: File::Slurp, Module::Load, Module::Installed::Tiny.

When those CPAN modules are installed, you can run the installer, which sets up Walter's configuration directory and modules: `perl install.pl`.

# Current modules built in:
## Firefox
Open a web page using Firefox

`walter browse [url...]`

## Emacs
Open a file using Emacs

`walter edit [file...]`

## DuckDuckGo
Perform a search on DuckDuckGo using the chosen browser (Firefox by default)

`walter search [search_query]`

## Template
Most complicated of the bunch. Given a list of templates, copy the contents of those template directories (stored in $HOME/.walter/Templates) into the current directory. Template is disabled by default because it requires a 3rd party module (File::Copy::Recursive);

`walter template [template_directory...]`

## Weather
Fetch current weather and temperature via OpenWeather.
`walter weather [location]`

## Perl
Look up something via perldoc
`walter perl [thing]`

## OxfordDictionary
Pull the definition of a word from the Oxford English Dictionary.
`walter define [word]`

## Python2
Look up the Python 2 documentation on the web.
`walter py2 [query]`

## Python3
Look up the Python 3 documentation on the web.
`walter py3 [query]`

# The walter.mod Format
As it stands now, the format is incredibly simple: it is a single line with all the modules to be used separated by spaces.

This method provides no granularity, so it is too easy to have verb conflicts. At some point in the future the file format will be something more like this:
```
Module: verb1 verb2
Module2: verb3 verb4
```

A well-behaved module will only export the verbs it is told to export, and if two modules using this format are both invoked for the same verb, the one defined later wins, just as now.

# Developing Modules
Developing a module is trivial; the smallest possible module is nothing more than a perl5 package declaration using Exporter and stubs for the `init` and `needs` functions.

A useful module is one which defines at least one verb, which corresponds to a perl handler; this can be arbitrary code which depends any module available via CPAN. The one restriction here is that you can not require/use modules in the normal way, they must be loaded at runtime via the `Modules::Load `module. Instead of calling `use module`, you will call `autoload "module"`. `use module qw(foo bar)` becomes `autoload "module","foo","bar"`.

## The Init Subroutine
These handlers are made known to Walter via the `init` subroutine, which must be exported from your module. The subroutine is passed a reference to Walter's dictionary, which your init subroutine overrides like this: `$hashref->{"verb"} = \&Module::handler;`. A module can define multiple verbs simply by putting multiple entries in the dictionary; aliases work the same way, just inject the same handler via multiple verbs.

***NOTE***: The interface of this function will be changing at some point. See the walter.mods section.

## The Needs Subroutine
The second required function to be exported is `needs`: this is what drives the dependency management. When a module is loaded by Walter, it calls the module's `needs`, which returns a list of the modules required by the module. These modules are then installed automatically if allowed by the user. Any given `needs` should only be one line: `return qw();`, with the modules being depended on put into the qw.