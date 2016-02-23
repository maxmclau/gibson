# Gibson

Tool used to build all Moa projects

#### Installation
```Shell
$ git clone git@github.com:moa/gibson.git
$ cd gibson
$ gibson --install
```
#### Update
```Shell
$ gibson --update
```
#### Build
```Shell
$ gibson --build -n atmega256rfr2 -a avr -t 256RFR2XPRO -f main.cpp
```

#### Subrepo
Dependencies are managed by the awesome [`git-subrepo`](https://github.com/ingydotnet/git-subrepo) so none of the [`git-submodule`](http://somethingsinistral.net/blog/git-submodules-are-probably-not-the-answer/) drama is required while cloning. However you can pull the most recent commmit of a [`git-subrepo`](https://github.com/ingydotnet/git-subrepo) with...
```Shell
$ git subrepo pull <subdir>|--all [-b <branch>] [-r <remote>] [-u]
```

#### TODO
  + `Fix screenshot shadows`
  + `Support .gibson build files`
  + `Better error-handling`
  + `Compile less-gangster executable`
  + `Rewrite in Go`

#### Output
  ```
├── rifraf-build/
│   ├── index.md
│   ├── en
│   │   ├── 00_Getting_Started.md
```


#### License

**`Apache 2.0`**
