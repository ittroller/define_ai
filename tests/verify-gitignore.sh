#!/bin/bash
set -e

echo "=== VERIFYING GITIGNORE UPDATE FEATURE ==="

TEST_DIR="test_verify_env"
rm -rf "$TEST_DIR"
mkdir "$TEST_DIR"
cd "$TEST_DIR"

echo "--- Case 1: No .gitignore exists ---"
node ../../bin/cli.js
echo "Contents of .gitignore:"
cat .gitignore
echo "-------------------------------------"

echo "--- Case 2: Existing .gitignore without .ai ---"
rm -rf .ai .gitignore
echo "node_modules" > .gitignore
echo "Before:"
cat .gitignore
node ../../bin/cli.js
echo "After:"
cat .gitignore
echo "-------------------------------------"

echo "--- Case 3: Existing .gitignore with .ai ---"
echo "Before:"
cat .gitignore
node ../../bin/cli.js --force
echo "After:"
cat .gitignore
echo "-------------------------------------"

echo "--- Case 4: Existing .gitignore without trailing newline ---"
rm -rf .ai .gitignore
printf "dist" > .gitignore
echo "Before (hex dump):"
hexdump -C .gitignore
node ../../bin/cli.js
echo "After:"
cat .gitignore
echo "-------------------------------------"

cd ..
rm -rf "$TEST_DIR"
echo "=== VERIFICATION COMPLETE ==="
