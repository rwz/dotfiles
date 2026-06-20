#!/usr/bin/env bash
# yt-dlp-docker — transparent, always-latest yt-dlp in Docker.
#
# Install: chmod +x, then symlink onto your PATH as `yt-dlp` (and, optionally,
# as `yt-dlp-scoped` for the least-privilege variant). It runs from ANY shell
# (bash/zsh/fish/…) because it executes under its own bash shebang — there is no
# per-shell function to define.
#
# Invocation name selects the mode (multi-call, via basename "$0"):
#   yt-dlp         → max fidelity: mounts $HOME so it behaves like a local install
#   yt-dlp-scoped  → least privilege: mounts only the current dir (+ ro config)
#
# Env overrides:
#   YTDLP_DOCKER_IMAGE  override the image ref (e.g. …:stable) — defaults to :nightly
#   YTDLP_DOCKER_DRY_RUN if set, print the docker argv instead of running (test seam)
#   YTDLP_DOCKER_OS      override the detected OS (test seam; defaults to `uname -s`)
set -u

img="${YTDLP_DOCKER_IMAGE:-ghcr.io/rwz/yt-dlp-docker:nightly}"

# Best-effort, non-fatal auto-update on every call (stateless); then reclaim our
# previous dangling nightly (label-scoped, dangling-only — never -a). Skipped in dry-run.
# Progress is shown live (not silenced) so a slow pull never looks like a hang; it is
# sent to stderr so it can't corrupt a stdout stream (e.g. `yt-dlp -o - … | player`).
if [ -z "${YTDLP_DOCKER_DRY_RUN:-}" ]; then
  docker pull "$img" >&2 || true
  docker image prune -f --filter "label=dev.rwz.yt-dlp-docker=true" >&2 || true
fi

# Allocate a TTY only when BOTH stdin and stdout are terminals.
tty=(); { [ -t 0 ] && [ -t 1 ]; } && tty=(-t)

# Map files to the host user on Linux only (macOS/Windows Docker VM maps ownership itself).
user=()
[ "${YTDLP_DOCKER_OS:-$(uname -s)}" = "Linux" ] && user=(--user "$(id -u):$(id -g)")

# Note: "${arr[@]+"${arr[@]}"}" expands to nothing when the array is empty — required so
# an empty array doesn't trip "unbound variable" under `set -u` on bash 3.2 (stock macOS).
case "$(basename "$0")" in
  *scoped*)
    # Least privilege: mount only the current dir (rw) + yt-dlp config (ro, if it exists).
    # The [ -d ] guard avoids Docker auto-creating a missing ~/.config/yt-dlp as root.
    cfg=()
    [ -d "$HOME/.config/yt-dlp" ] && cfg=(-v "$HOME/.config/yt-dlp:/cfg:ro" --config-locations /cfg)
    args=(run --rm -i "${tty[@]+"${tty[@]}"}" "${user[@]+"${user[@]}"}"
          -e HOME="$PWD" -v "$PWD:$PWD" -w "$PWD" "${cfg[@]+"${cfg[@]}"}"
          --cap-drop=ALL --security-opt=no-new-privileges "$img" "$@")
    ;;
  *)
    # Max fidelity: behave like a local yt-dlp — mount $HOME (+ $PWD if it is outside $HOME).
    [ "$PWD" = "/" ] && { echo "yt-dlp: refusing to run from /" >&2; exit 1; }
    mounts=(-v "$HOME:$HOME")
    case "$PWD/" in
      "$HOME/"*) ;;
      *)         mounts+=(-v "$PWD:$PWD") ;;
    esac
    args=(run --rm -i "${tty[@]+"${tty[@]}"}" "${user[@]+"${user[@]}"}"
          -e HOME="$HOME" "${mounts[@]}" -w "$PWD"
          --cap-drop=ALL --security-opt=no-new-privileges "$img" "$@")
    ;;
esac

if [ -n "${YTDLP_DOCKER_DRY_RUN:-}" ]; then
  printf 'docker %s\n' "${args[*]}"
  exit 0
fi
exec docker "${args[@]}"
