## Get on an Amazon Linux 2 Instance

We'll hop onto an EKS node that has been used today, Amazon Linux 2 powers EKS,
so we have one available.

## Pull down docker image of Amazon Linux 2
Note: latest points to Amazon Linux 2
```
$ sudo docker run -i -t amazonlinux:latest
```

## Show new System Release
Previously, our system-release said "Amazon Linux release 2 (2017.12) LTS Release Candidate"
```
$ cat /etc/system-release
```

## Check updated versions of Python in core
```
$ python --version
$ yum list --show-duplicates python3
```

## List Amazon Linux Extras
```
$ amazon-linux-extras
```

## Check version of emacs available in core
```
$ yum list --show-duplicates emacs
$ yum install emacs-nox
```

## Pull down SpaceMacs emacs config. A relatively popular emacs configuration
```
$ sudo yum install git
$ git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```

## Check SpaceMacs with core version of emacs
```
$ emacs
```

## Enable emacs extra and upgrade via yum
```
$ amazon-linux-extras enable emacs
$ yum list --show-duplicates emacs
$ yum upgrade emacs-nox
$ emacs-nox
```
