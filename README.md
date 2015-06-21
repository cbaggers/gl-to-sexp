# gl-to-sexp

Making tools that understand GL are generally a pain as there is no up to date, machine readable version of the spec.

This is a wip fix to that problem.

Thanks to docs.gl it is now easy to get hold of version of the spec with a single file for each function.

The goal is to write simple scripts to extract all this data into an s-expression that can then be used by other languages and tools.

So far I am focused on glsl but would appreciate any help getting the gl files parsed too.

Requirements
============
If you just want to use the result, look in the spec folder :)

If you want to regenerate the spec files:

- Required lisp libraries will be automatically installed when you `quickload` this library
- docs.gl repo cloned locally.
