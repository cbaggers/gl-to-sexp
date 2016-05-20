# gl-to-sexp

Making tools that understand GLSL are generally a pain as there is no up to date, machine readable version of the spec.

This is here to fix that problem.

This project has been supersceded by [glsl-spec](https://github.com/cbaggers/glsl-spec). The reason for this was two fold.

- Even as a data-structure the version data from the man pages was essentially human readable. This was because it's specification was inconsistent and it was non-trivial to pick the correct version for each function

- The function specfications used generic return type shorthand. For example `GenType` meant `float`, `vec2`, `vec3` & `vec4`, however the function actually returned a particular one of these depending on the argument types. This was fustrating as it required extra work from the programmer to work out the correct return type.

This was enough for me to decide to expand all the definition of the glsl spec and attach the correct version info to every one.

And that is [glsl-spec](https://github.com/cbaggers/glsl-spec).

The files here are the output from that effort.

If you want to contribute an addition or correction please do so on the [glsl-spec](https://github.com/cbaggers/glsl-spec) project.

I really hopes this saves some of you some time. Happy coding.
