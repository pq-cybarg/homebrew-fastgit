# homebrew-fastgit

Homebrew tap for [fastgit](https://github.com/pq-cybarg/fastgit) — baremetal C git, hash-agile.

```sh
brew tap pq-cybarg/fastgit
brew install fastgit
# or one-liner:
brew install pq-cybarg/fastgit/fastgit
```

Verifies:
```
fastgit --help
fastgit init /tmp/repo && echo hi > /tmp/repo/file.txt && fastgit hash-object -w /tmp/repo/file.txt
ctest --test-dir build   # 10/10
```
