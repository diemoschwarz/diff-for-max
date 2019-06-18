# diff-for-max
Attempts to get version control to work for Max patches

## Description

The Perl-script ``diffmaxmunge.pl`` filters the [Max](https://cycling74.com/) patch json file format and removes everything that's not about the definition of objects in the patch (visual appearance, layout, bookkeeping data).
Usually, only the object text and class remain, and all the connections at the end (which are impossible to make sense of for a human).

The Shell-script ``diffmax -m`` can be used as a replacement for ``diff``, filtering two arguments through ``diffmaxmunge.pl``.

## Shortcomings

This is a ridiculously brute force attempt to get a human-readable idea of what changed in a patch. _It is not even parsing the json!_ I put this up to provoke a proper solution...

## Interfacing with git

- in local or global ``.gitconfig``, add:

```
[diff "max"]
  textconv = /Users/schwarz/bin/diffmaxmunge.pl
```
  
- in local ``.gitattributes``, add

```
*.maxpat diff=max
*.maxhelp diff=max
*.amxd -text diff=max
```
