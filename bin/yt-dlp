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
#   YTDLP_DOCKER_RUN_ARGS  extra `docker run` flags spliced in before the image
#                          (word-split; e.g. "--read-only --tmpfs /tmp" to harden)
#   YTDLP_DOCKER_NO_PULL if set, skip the per-run image pull + prune (cached/offline)
#   YTDLP_DOCKER_DRY_RUN if set, print the docker argv instead of running (test seam)
#   YTDLP_DOCKER_OS      override the detected OS (test seam; defaults to `uname -s`)
set -u

# HOME drives the mounts and config path; fail clearly rather than with a bare
# "unbound variable" if it is somehow unset (e.g. `env -i`).
: "${HOME:?must be set (export HOME or run from a normal shell)}"

img="${YTDLP_DOCKER_IMAGE:-ghcr.io/rwz/yt-dlp-docker:nightly}"

# Optional extra `docker run` flags, spliced in before the image. Word-split on
# purpose (read -ra avoids the SC2206 quoting warning); empty when the var is unset.
read -ra run_args <<< "${YTDLP_DOCKER_RUN_ARGS:-}"

# Everything below talks to docker; the dry-run seam prints argv and never does, so skip
# it all under dry-run. Fail early with a clear message when docker isn't available.
if [ -z "${YTDLP_DOCKER_DRY_RUN:-}" ]; then
  command -v docker >/dev/null 2>&1 || {
    echo "$(basename "$0"): docker not found on PATH — install Docker (Desktop/Engine) and make sure it is running" >&2
    exit 127
  }
  # Best-effort, non-fatal auto-update (stateless); then reclaim our previous dangling
  # nightly (label-scoped, dangling-only — never -a). Skipped when YTDLP_DOCKER_NO_PULL is
  # set (cached/offline/tight-loop use). Progress is shown live (not silenced) so a slow
  # pull never looks like a hang; it goes to stderr so it can't corrupt a stdout stream.
  if [ -z "${YTDLP_DOCKER_NO_PULL:-}" ]; then
    docker pull "$img" >&2 || true
    docker image prune -f --filter "label=dev.rwz.yt-dlp-docker=true" >&2 || true
  fi
fi

# Allocate a TTY only when BOTH stdin and stdout are terminals.
tty=(); { [ -t 0 ] && [ -t 1 ]; } && tty=(-t)

# Map files to the host user on Linux only (macOS/Windows Docker VM maps ownership itself).
user=()
[ "${YTDLP_DOCKER_OS:-$(uname -s)}" = "Linux" ] && user=(--user "$(id -u):$(id -g)")

# Note: "${arr[@]+"${arr[@]}"}" expands to nothing when the array is empty — required so
# an empty array doesn't trip "unbound variable" under `set -u` on bash 3.2 (stock macOS).
case "$(basename "$0")" in
  *-scoped)
    # Least privilege: mount only the current dir (rw) + yt-dlp config (ro, if it exists).
    # The [ -d ] guard avoids Docker auto-creating a missing ~/.config/yt-dlp as root.
    # The /cfg mount is a docker flag (before the image); --config-locations and --no-config
    # are yt-dlp flags and must go AFTER the image. HOME=$PWD would otherwise let yt-dlp scan
    # the untrusted working dir for config, so --no-config leaves /cfg as the only config.
    cfgmount=(); cfgargs=()
    [ -d "$HOME/.config/yt-dlp" ] && { cfgmount=(-v "$HOME/.config/yt-dlp:/cfg:ro"); cfgargs=(--config-locations /cfg); }
    args=(run --rm -i "${tty[@]+"${tty[@]}"}" "${user[@]+"${user[@]}"}"
          -e HOME="$PWD" -v "$PWD:$PWD" -w "$PWD" "${cfgmount[@]+"${cfgmount[@]}"}"
          --cap-drop=ALL --security-opt=no-new-privileges
          "${run_args[@]+"${run_args[@]}"}" "$img"
          --no-config "${cfgargs[@]+"${cfgargs[@]}"}" "$@")
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
          --cap-drop=ALL --security-opt=no-new-privileges
          "${run_args[@]+"${run_args[@]}"}" "$img" "$@")
    ;;
esac

if [ -n "${YTDLP_DOCKER_DRY_RUN:-}" ]; then
  # %q so the printed line is copy-paste-safe for args with spaces/globs/quotes.
  printf 'docker'; printf ' %q' "${args[@]}"; printf '\n'
  exit 0
fi
exec docker "${args[@]}"
