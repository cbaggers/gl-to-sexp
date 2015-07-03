# gl-to-sexp

Making tools that understand GLSL are generally a pain as there is no up to date, machine readable version of the spec.

This is a wip fix to that problem.

Thanks to docs.gl it is now easy to get hold of version of the spec with a single file for each function.

This rough script extract data from the spec into sexp and json formats.

Requirements
============
If you just want to use the result, look in the spec folder :)

If you want to regenerate the spec files:

- Required lisp libraries will be automatically installed when you `quickload` this library
- docs.gl repo cloned locally.

Layout
======

each element looks something like this

    (((("EmitStreamVertex" "void") (("stream" "int"))))
    (("EmitStreamVertex" 400 410 420 430 440 450)))

Each item has two elements:

    A list of function definitions
    A list of information on which version are supported

Function definition:

Each function definitions is laid out as follows:

    The first element is a pair of the function name as a string and the return type as a string.
    The rest of the list are pairs of the argument name as a string and the argument type as a string

Version Information:

Each element in the version info list is laid out as follows:

    The first element is the name of the function and in some cases enough arg info to differentiate it from other incarnations of the same function. This is one string which sucks, so I need to parse this so we can apply the version info directly.
    The rest of the elements are the versions supported.


So it ends up looking like this

    (((("funcName" "returnType") (("first-arg-name" "first-arg-type") ("second-arg-name" "second-arg-type") ... more args))
      (("funcName" "returnType") (...differenτ signature...))
      ....more signatures with different signatures...)
     (("funcNameDefaultCase" 130 140 150 330 400 .. other versions supported ..)
      ("funcNameDifferentCase (differentArgType)" 140 150 330 400 410 420 430 440 450)
      ... more version info for other signatures))


    [[[["funcName", "returnType"], [["first-arg-name", "first-arg-type"], ["second-arg-name", "second-arg-type"], ... more args]],
      [["funcName", "returnType"], [...differenτ signature...]],
      ....more signatures with different signatures...],
     [["funcNameDefaultCase", 130, 140, 150, 330, 400, .. other versions supported ..],
      ["funcNameDifferentCase [differentArgType]", 140, 150, 330, 400, 410, 420, 430, 440, 450],
      ... more version info for other signatures... ]]

What Ι dont like is that the versions signature is a string. I need to parse this but havent done yet.
