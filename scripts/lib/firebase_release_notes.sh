#!/bin/bash
# Auto-generates Firebase App Distribution release notes from git history
# since the previous "chore: deploy" commit.

FIREBASE_RELEASE_NOTES_MAX_CHARS="${FIREBASE_RELEASE_NOTES_MAX_CHARS:-4000}"

# Prints release notes for the given version to stdout.
# Usage: build_firebase_release_notes "1.0.0+1"
build_firebase_release_notes() {
  local version="${1:-}"
  local latest_deploy=""
  local prev_deploy=""
  local range=""
  local changelog=""
  local head_sha=""

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf 'Kornia App - Version %s\n' "$version"
    return 0
  fi

  head_sha="$(git rev-parse HEAD 2>/dev/null || true)"
  latest_deploy="$(
    git log -1 --grep='^chore: deploy ' --pretty=format:'%H' 2>/dev/null || true
  )"

  if [ -n "$latest_deploy" ] && [ "$head_sha" = "$latest_deploy" ]; then
    # HEAD is the deploy commit just created: take commits since the previous deploy.
    prev_deploy="$(
      git log -1 --skip=1 --grep='^chore: deploy ' --pretty=format:'%H' 2>/dev/null || true
    )"
    if [ -n "$prev_deploy" ]; then
      range="${prev_deploy}..HEAD"
    else
      range="HEAD~30..HEAD"
    fi
  elif [ -n "$latest_deploy" ]; then
    # Publishing without a new bump: commits after the last deploy.
    range="${latest_deploy}..HEAD"
  else
    range="HEAD~30..HEAD"
  fi

  changelog="$(
    git log "$range" \
      --reverse \
      --pretty=format:'- %s' \
      --no-merges \
      --grep='^chore: deploy ' \
      --invert-grep \
      2>/dev/null || true
  )"

  {
    printf 'Kornia App - Version %s\n' "$version"
    if [ -n "$changelog" ]; then
      printf '\n%s\n' "$changelog"
    else
      printf '\n- Release build %s\n' "$version"
    fi
  } | awk -v max="$FIREBASE_RELEASE_NOTES_MAX_CHARS" '
    {
      lines[NR] = $0
    }
    END {
      out = ""
      for (i = 1; i <= NR; i++) {
        candidate = (out == "" ? lines[i] : out "\n" lines[i])
        if (length(candidate) > max) {
          printf "%s\n\n… (truncated)\n", out
          exit
        }
        out = candidate
      }
      printf "%s\n", out
    }
  '
}
