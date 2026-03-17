#!/usr/bin/env bash
# =============================================================================
# clone.sh
# Clones all GitHub repositories for a given user/org (public + private).
# 
# Requirements:
#   - git
#   - gh
#   - jq
#   - A GitHub Personal Access Token (PAT) with the `repo` and 'read:org scopes
#
# Usage:
#   chmod +x .sh
#   ./clone.sh
#
# Or pass arguments directly:
#   GITHUB_TOKEN=ghp_xxx GITHUB_USER=username CLONE_DIR=~/Code ./clone.sh
# =============================================================================

set -euo pipefail

# ── Configuration ─────────────────────────────────────────────────────────────

GITHUB_USER="${GITHUB_USER: }"     # Your GitHub username or org name
GITHUB_TOKEN="${GITHUB_TOKEN: }"   # Personal Access Token (repo scope)
CLONE_DIR="${CLONE_DIR: }"  # Destination directory
USE_SSH="${USE_SSH:-false}"        # Set to "true" to clone via SSH instead of HTTPS
INCLUDE_FORKS="${INCLUDE_FORKS:-false}"   # Set to "true" to include forks
INCLUDE_ARCHIVED="${INCLUDE_ARCHIVED:-false}" # Set to "true" to include archived repos

# ── Prompt for missing values ─────────────────────────────────────────────────

if [[ -z "$GITHUB_USER" ]]; then
  read -rp "GitHub username or org name: " GITHUB_USER
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  read -rp "GitHub Personal Access Token: " GITHUB_TOKEN
fi

if [[ -z "$CLONE_DIR" ]]; then
  read -rp "Clone Directory: " CLONE_DIR
fi

# ── Setup ─────────────────────────────────────────────────────────────────────

mkdir -p $(eval echo $CLONE_DIR)
echo
echo "Cloning repositories into: $(eval echo $CLONE_DIR)"
echo

export CLONED=0
export SKIPPED=0
export UPDATED=0

# ── Functions ─────────────────────────────────────────────────────────────────

gh_login() {
  echo $GITHUB_TOKEN | gh auth login --hostname github.com --with-token
}

gh_list_repos() {
  gh repo list $GITHUB_USER --limit 1000 --json name,isFork,isArchived,sshUrl,url
}

clone_or_pull() {
  local name="$1"
  local url="$2"
  local dest="$(eval echo $CLONE_DIR)/$name"

  if [[ -d "$dest/.git" ]]; then
    echo "↻  Updating     $name: $url"
    git -C "$dest" pull --ff-only --quiet
    ((UPDATED++)) || true
  else
    echo "↓  Cloning      $name: $url"
    git clone --quiet "$url" "$dest"
    ((CLONED++)) || true
   fi
}

# ── Main loop ─────────────────────────────────────────────────────────────────

# login using the GH_TOKEN
LOGIN=$(gh_login)

# get repo list and flatten to one repo per line
REPOS=$(gh_list_repos)

# process each repo
while read row; do
  NAME=$(echo "$row" | jq -r '.name')
  FORK=$(echo "$row" | jq -r '.isFork')
  ARCHIVED=$(echo "$row" | jq -r '.isArchived')
  SSH_URL=$(echo "$row" | jq -r '.sshUrl')
  HTTPS_URL=$(echo "$row" | jq -r '.url')

  # Choose clone URL
  if [[ "$USE_SSH" == "true" ]]; then
    CLONE_URL="$SSH_URL"
  else
    CLONE_URL="$HTTPS_URL"
  fi

  # Apply filters
  if [[ "$INCLUDE_FORKS" == "false" && "$FORK" == "true" ]]; then
    echo "⊘  Skip Fork    $NAME"
    ((SKIPPED++)) || true
    continue
  fi
  if [[ "$INCLUDE_ARCHIVED" == "false" && "$ARCHIVED" == "true" ]]; then
    echo "⊘  Skip Archive $NAME: $CLONE_URL"
    ((SKIPPED++)) || true
    continue
  fi

  clone_or_pull "$NAME" "$CLONE_URL"

done < <(echo "$REPOS" | jq -c -r '.[]')

# ── Summary ───────────────────────────────────────────────────────────────────

echo
echo "  Done!"
echo "────────────────────────────────"
echo "  Cloned:  $CLONED"
echo "  Updated: $UPDATED"
echo "  Skipped: $SKIPPED"
echo "────────────────────────────────"
