# Gibson

Tool used to build all Moa projects

#### Usage
```Shell
$ git clone https://github.com/moa/rifraf-build.git
$ cd rifraf-build
$ chmod 0755 ./build.sh
$ ./build.sh --build -n atmega256rfr2 -a avr -t 256RFR2XPRO
```

#### Subrepo
Dependencies are managed by the awesome [`git-subrepo`](https://github.com/ingydotnet/git-subrepo) so none of the [`git-submodule`](http://somethingsinistral.net/blog/git-submodules-are-probably-not-the-answer/) drama is required while cloning. However you can pull the most recent commmit of a [`git-subrepo`](https://github.com/ingydotnet/git-subrepo) with...
```Shell
$ git subrepo pull <subdir>|--all [-b <branch>] [-r <remote>] [-u]
```

#### Output

  ```
├── rifraf-build/
│   ├── index.md
│   ├── en
│   │   ├── 00_Getting_Started.md
│   │   ├── 01_Examples
│   │   │   ├── 01_GitHub_Flavored_Markdown.md
│   │   │   ├── 05_Code_Highlighting.md
│   │   ├── 05_More_Examples
│   │   │   ├── Hello_World.md
│   │   │   ├── 05_Code_Highlighting.md
│   ├── de
│   │   ├── 00_Getting_Started.md
│   │   ├── 01_Examples
│   │   │   ├── 01_GitHub_Flavored_Markdown.md
│   │   │   ├── 05_Code_Highlighting.md
│   │   ├── 05_More_Examples
│   │   │   ├── Hello_World.md
│   │   │   ├── 05_Code_Highlighting.md
```


#### License

**`Apache 2.0`**
