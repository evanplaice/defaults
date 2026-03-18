#!/bin/bash
# =============================================================================
# restore.sh
# Restore (ie clone or update) all GitHub clones
# 
# Requirements:
#   - git
#   - gh
#   - A GitHub Personal Access Token (PAT) with the `repo` and 'read:org scopes 
#
# Usage:
#   chmod +x restore.sh
#   ./restore.sh
#
# Or pass arguments directly:
#   GITHUB_TOKEN=ghp_xxx ./restore.sh
# =============================================================================

set -euo pipefail

# ── Configuration ─────────────────────────────────────────────────────────────

GITHUB_TOKEN="${GITHUB_TOKEN: }"   # Personal Access Token (repo scope)

# ── Prompt for missing values ─────────────────────────────────────────────────

if [[ -z "$GITHUB_TOKEN" ]]; then
  read -rp "GitHub Personal Access Token: " GITHUB_TOKEN
fi

# ── Functions ─────────────────────────────────────────────────────────────────

clone_or_pull() {
  local github_user="$1"
  local clone_dir="$2"

  echo $GITHUB_TOKEN | GITHUB_USER=$github_user CLONE_DIR=$clone_dir ./scripts/clone.sh 
}

clone_or_pull_forks() {
  local github_user="$1"
  local clone_dir="$2"

  echo $GITHUB_TOKEN | GITHUB_USER=$github_user CLONE_DIR=$clone_dir FORKS_ONLY=true ./scripts/clone.sh 
}

# ── Main loop ─────────────────────────────────────────────────────────────────

echo
echo "Restoring Personal repositories"
echo "-----------------------------------------------"
clone_or_pull evanplaice ~/Code/personal
echo

echo
echo "Restoring Contrib repositories"
echo "-----------------------------------------------"
clone_or_pull_forks evanplaice ~/Code/contrib
echo

echo
echo "Restoring Interpreters repositories"
echo "-----------------------------------------------"
clone_or_pull interpreters ~/Code/interpreters
echo

echo
echo "Restoring VanillaES repositories"
echo "-----------------------------------------------"
clone_or_pull vanillaes ~/Code/vanillaes
echo

echo
echo "Restoring VanillaPWA repositories"
echo "-----------------------------------------------"
clone_or_pull vanillapwa ~/Code/vanillapwa
echo

echo
echo "Restoring VanillaWC repositories"
echo "-----------------------------------------------"
clone_or_pull vanillawc ~/Code/vanillawc
echo
