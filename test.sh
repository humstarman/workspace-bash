#!/bin/bash
set -e
show_help () {
cat << USAGE
usage: $0 [ -U UPPERCASE-TERM ] [ -L LOWERCASE-TERM ]
    -u : Specify the uppercase term to change.
    -l : Specify the lowercase term to change.
USAGE
exit 0
}
# Get Opts
while getopts "hu:l:" opt; do # 选项后面的冒号表示该选项需要参数
    case "$opt" in
    h)  show_help
        ;;
    u)  UPPER=$OPTARG
        ;;
    l)  LOWER=$OPTARG
        ;;
    ?)  # 当有不认识的选项的时候arg为?
        echo "unkonw argument"
        exit 1
        ;;
    esac
done
[[ -z $* ]] && show_help
TMP=$(mktemp /tmp/tmp.XXX)
echo $TMP
if [[ -n $UPPER ]]; then
  echo $UPPER > $TMP
  cat $TMP
  sed -i s?"{{."?""?g $TMP 
  cat $TMP
  sed -i s?"}}"?""?g $TMP 
  cat $TMP
  sed -i s?"\."?"_"?g $TMP 
  cat $TMP
  cat $TMP | tr 'a-z' 'A-Z'
  exit 0
fi
if [[ -n $LOWER ]]; then
  echo $LOWER > $TMP
  cat $TMP
  sed -i s?"{{."?""?g $TMP 
  cat $TMP
  sed -i s?"}}"?""?g $TMP 
  cat $TMP
  sed -i s?"\."?"_"?g $TMP 
  cat $TMP
  cat $TMP | tr 'a-z' 'A-Z'
  exit 0
fi
