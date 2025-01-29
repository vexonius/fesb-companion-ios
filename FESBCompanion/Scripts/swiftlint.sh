export PATH="$PATH:/opt/homebrew/bin"

if which five-swiftlint > /dev/null; then
    five-swiftlint --strict "$(pwd)"
else
    echo "warning: Five-SwiftLint not installed, install it by running:"
    echo "brew tap fiveagency/five-swiftlint"
    echo "brew install five-swiftlint"
fi
