How to build Gray486linux with podman
======================================

You need to have `podman` installed on your system.

Change working directory to `docker`.

Then just run `containerbuild.sh`. This going to compile whole Gray486linux and
create image. You can find results of compilation (kernel with userspace) into `src/results`
directory, because `src` directory is propagated to container into `/build` directory.

You can access build environment by using `containerrun.sh`.
