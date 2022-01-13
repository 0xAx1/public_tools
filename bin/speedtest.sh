#! /bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

python3 --version | grep -q 'not found' && ./install_python.sh

curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
