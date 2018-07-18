## Get on an Amazon Linux 2 Instance

We'll hop onto an EKS instance that has been used today, Amazon Linux 2 powers EKS,
so we have one available.


## Check Boot Time Info
```
$ systemd-analyze
$ systemd-analyze blame
```

## List available extras
```
$ amazon-linux-extras
```
## Enable Docker

On later editions of Amazon Linux 2, the docker extra is pre-enabled
```
$ amazon-linux-extras enable docker
```

## Install and start Docker
```
$ sudo yum install docker
$ sudo systemctl start docker
```

## Pull down docker image of Amazon Linux 2
Note: latest points to Amazon Linux 2
```
$ sudo docker run -i -t amazonlinux:latest
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
