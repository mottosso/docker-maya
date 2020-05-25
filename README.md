[![](https://images.microbadger.com/badges/image/mottosso/maya.svg)](https://microbadger.com/images/mottosso/maya "Get your own image badge on microbadger.com")

# Supported tags

- `2013sp1`, `2013sp2`, `2014sp1`, `2014sp2`, `2014sp3`, `2014sp4`, `2015sp1`, `2015sp2`, `2015sp3`, `2015sp4`, `2015sp5`, `2015sp6`, `2016sp1`, `2017`, `2018`, `2019`, `2020` and `2020sp1`

For more information about this image and its history, please see its the [GitHub repository][1].

[1]: https://github.com/mottosso/docker-maya/wiki

# Usage

To use this image and any of it's supported tags, use `docker run`.

```bash
$ docker run -ti --rm mottosso/maya
```

Without a "tag", this would download the latest available image of Maya. You can explicitly specify a version with a tag.


```bash
$ docker run -ti --rm mottosso/maya:2016sp1
```

Images occupy around **5 gb** of virtual disk space once installed, and about **1.5 gb** of bandwidth to download.

**Example**

This example will run the latest available version of Maya, create a new scene and save it in your current working directory.

```bash
$ docker run -ti -v $(pwd):/root/workdir --rm mottosso/maya
$ mayapy
>>> from maya import standalone, cmds
>>> standalone.initialize()
>>> cmds.file(new=True)
>>> cmds.polySphere(radius=2)
>>> cmds.file(rename="my_scene.ma")
>>> cmds.file(save=True, type="mayaAscii")
>>> exit()
$ cp /root/maya/projects/default/scenes/my_scene.ma workdir/my_scene.ma
$ exit
$ cat my_scene.ma
```

# What's in this image?

This image builds on [mayabase-centos][2] which has the following software installed.

- [git](https://git-scm.com/)
- [pip](https://pip.pypa.io/en/stable/)

Each tag represents a particular version of Maya, such as 2016 SP1. In this image, `python` is an alias to `maya/bin/mayapy` which has the following Python packages installed via `pip`.

- [nose](http://nose.readthedocs.org/en/latest/testing.html)

[2]: https://registry.hub.docker.com/u/mottosso/mayabase-centos/

# User Feedback

### Documentation

Documentation for this image is stored in the [GitHub wiki][1] for this project.

### Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue][3].

[3]: https://github.com/mottosso/docker-maya/issues

### Contributing

You are invited to contribute new features, fixes, or updates, large or small; I'm always thrilled to receive pull requests, and do my best to process them as fast as I can.

Before you start to code, we recommend discussing your plans through a GitHub issue, especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
