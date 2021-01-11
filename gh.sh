#!/bin/bash

# from i8ramin - http://getintothis.com/blog/2012/04/02/git-grep-and-blame-bash-function/
# runs git grep on a pattern, and then uses git blame to who did it
# small modification for git egrep bash
geb() {
    git grep -E -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
}

echo "-----------------------------------------------"
echo "1. git egrep + blame(geb)"
echo "-----------------------------------------------"

read -p "choose function " num

case $num in
  1)
  read -p "enter string: " line
  git grep -E -n $line | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
  ;;
esac

