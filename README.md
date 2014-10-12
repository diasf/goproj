goproj
======

Bash function to switch between Go projects.

# Configuration

#### 1. Clone it, somewhere


```
cd ~/scripts
git clone https://github.com/diasf/goproj
```

#### 2. Include it, in your .bashrc if you like, and add your projects to the GOPROJECTS bash array pointing to their location:


```
. ~/scripts/goproj/goproj.sh

# mapping of goproject to location
GOPROJECTS[kv]=~/go/src/github.com/cznic/kv
GOPROJECTS[camlistore]=~/proj/camlistore/src/camlistore.org
GOPROJECTS[mgo]=~/go/src/github.com/go-mgo/mgo
```

#### 3. Use it


Now you can type goproj followed by the projects key in the array to go to the projects directory and set the GOPATH variable:

```
goproj camlistore
```

The function supports autocompletion, so when typing `goproj c` and `TAB` it will autocomplete to `goproj camlistore`.


# Options

* -v: Open vim in the project directory
