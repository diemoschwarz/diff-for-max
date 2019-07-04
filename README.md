# diff-for-max
Attempts to improve the usabaility of version control for [Cycling74](https://cycling74.com/) Max patch files by filtering the diff output to leave only the semantically meaningful parts.

## Description

The Perl-script ``diffmaxmunge.pl`` filters the [Max](https://cycling74.com/) patch json file format and removes everything that's not about the definition of objects in the patch (visual appearance, layout, bookkeeping data).
Usually, only the object text and class remain, and all the connections at the end (which are impossible to make sense of for a human).

The shell command ``diffmax -m <file1> <file2>`` can be used as a replacement for ``diff``, filtering the two files through ``diffmaxmunge.pl``.

## Shortcomings

This is a ridiculously brute force attempt to get a human-readable idea of what changed in a patch. _It is not even parsing the json!_ I put this up to provoke a proper solution...

Of course this also does not make it possible to merge two files. It is still inevitable to do this by hand in Max, but at least, one can now see quickly what changed semantically. (However, we can't know in which subpatch, because of the stupidity of this approach, the filtered diff output has lost the subpatch heararchy.)

## Interfacing with git

- in local or global ``.gitconfig``, add:

```
[diff "max"]
  textconv = <absolute executable path>/diffmaxmunge.pl
```
  
- in local ``.gitattributes``, add

```
*.maxpat diff=max
*.maxhelp diff=max
*.amxd -text diff=max
```
