# see https://stackoverflow.com/a/3812238/1641112 for reference
git_push_all () {
  GIT_DIR_="$(git rev-parse --git-dir)"
  BRANCH="$(git rev-parse --symbolic --abbrev-ref $(git symbolic-ref HEAD))"

  # not using pre-push hook
  #PRE_PUSH="$GIT_DIR_/hooks/pre-push"
  #test -x "$PRE_PUSH" &&
  #"$PRE_PUSH" "$BRANCH" "$@"

  git push "$@"

  POST_PUSH="$GIT_DIR_/../hooks/post-push"
  test $? -eq 0 && test -x "$POST_PUSH" &&
  "$POST_PUSH" "$BRANCH" "$@"
}

gcpush () {
  if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Aborting."
    return;
  fi

  git add $@
  if [ $? -eq 0 ]; then
    read "desc?Commit description: "
    git commit -m "$desc"
    git_push_all
  fi
}


diff_num () {
  line=$1
  git diff $(git status -s | awk 'FNR == '$line' {print $2}');
}

git_diff () {
  if [ $# -eq 0 ]
  then
    git diff
  else
    line=$1
    git diff $(git status -s | awk 'FNR == '$line' {print $2}')
  fi
}

git_diff_head () {
  if [ $# -eq 0 ]
  then
    git diff
  else
    line=${1:-1}
    git diff head $(git status -s | awk 'FNR == '$line' {print $2}')
  fi
}

git_short_status () {
  git status -s | nl -s:
}

git_edit () {
  if [[ $# -eq 0 || ( $# -gt 1 ) ]]
    then
    echo "Supply only one value when choosing a file to edit." && return;
  fi

  var=${1:-1};
  ! [[ $var =~ ^[0-9]+$ ]] && { echo "Enter an integer value from the menu." && return; }

  menu="$(git status -s | awk 'FNR == '$var' {print $2}')";

  vim $menu;
}

git_add () {
  if [[ $# -eq 0 || ( $# -eq 1 && $1 == '.' ) ]]
  then
    git add .
  else
    add_string=''
    for var in "$@"
    do
      ! [[ $var =~ ^[0-9]+$ ]] && { echo "Supply integer values from the menu only. Nothing added." && return; }
      add_string+="$(git status -s | awk 'FNR == '$var' {print $2}')";
      #add_string+=' ';
    done
        #trimmed=${add_string%%+( )} #Remove longest matching series of spaces from the back
    git add $add_string
  fi
  git_short_status
}

git_commit () {
  if [[ $# -eq 0 || ( $# -eq 1 && $1 == '.' ) ]]
  then
    git commit .
  else
    commit_string=''
    for var in "$@"
    do
      ! [[ $var =~ ^[0-9]+$ ]] && { echo "Supply integer values from the menu only. Nothing added." && return; }
#     commit_string+="$(git status -s | awk 'FNR == '$var' {print $2 $3}') ";
      file=$(git status -s|awk 'FNR == '$var' {$1="";print $0}');
      file=$(sed -e 's/^[[:space:]]*//' <<<"$file")
      new_file=" '${file}'"
      commit_string+=${new_file}

    done
    commit_string=${commit_string##*( )}
    commit_string="${commit_string//\"}"
    echo $commit_string;
    read "desc?Commit description: "
    bash -c "git commit -m \"$desc\" ${commit_string}"
  fi
  git_short_status
}
