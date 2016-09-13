Walter is a quick little pluggable user agent for fun. It works by defining a set of verbs, which correspond to handlers defined in modules. Based on the verb, Walter calls the handler with the remainder of argv as the arguments to the verb.

Current modules built in:
# Firefox
Open a web page using Firefox

# Emacs
Open a file using Emacs

# DuckDuckGo
Perform a search on DuckDuckGo using the chosen browser (Firefox by default)

# Template
Most complicated of the bunch. Given a list of templates, copy the contents of those template directories (stored in $HOME/.walter/Templates) into the current directory. Template is disabled by default because it requires a 3rd party module (File::Copy::Recursive);