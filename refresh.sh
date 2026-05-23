#!/bin/bash
# T3C4 Context Refresh Script (Linux/Mac)
# Run this to check what changed since your last session.

PROJECT="[project-name]"

echo "===== $PROJECT — Context Refresh ====="
echo ""

echo "--- CURRENT.md ---"
if [ -f "CURRENT.md" ]; then
  ls -la CURRENT.md | awk '{print "Last modified:", $6, $7, $8}'
else
  echo "  (not found)"
fi

echo ""
echo "--- Recent Cards (last 5) ---"
if [ -d "docs/pm-kb/cards" ]; then
  ls -t docs/pm-kb/cards/2*.md 2>/dev/null | head -5 | while read f; do
    echo "  $(basename "$f")"
  done
  if [ $(ls docs/pm-kb/cards/2*.md 2>/dev/null | wc -l) -eq 0 ]; then
    echo "  (no cards yet)"
  fi
else
  echo "  (cards directory not found)"
fi

echo ""
echo "--- Running Processes ---"
ps aux | grep -E "(python|node)" | grep -v grep | head -5 || echo "  (no relevant processes)"

echo ""
echo "===== Refresh complete ====="
echo "Tip: say 'kickoff' to start work, 'wrap' to save progress"
