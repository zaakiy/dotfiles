echo brew install $(brew list -l --formula | awk '{print $9}' | tr '\n' ' ') >brewInstalls.sh
echo brew install --cask $(brew list -l --cask | awk '{print $9}' | tr '\n' ' ') >>brewInstalls.sh
