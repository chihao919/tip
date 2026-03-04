#!/bin/bash

# =============================================================================
# TIP (The Intelligent Prompt) - One-Click Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/chihao919/tip/main/install.sh | bash
# =============================================================================

set -euo pipefail

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
readonly REPO_OWNER="chihao919"
readonly REPO_NAME="tip"
readonly REPO_BRANCH="main"
readonly RAW_BASE_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/${REPO_BRANCH}"

readonly SKILLS_DIR="${HOME}/.claude/skills"
readonly CLAUDE_MD_SOURCE_URL="${RAW_BASE_URL}/CLAUDE.md"

readonly SKILL_FILES=(
    "vibe-coding-workflow.md"
    "security-check.md"
    "debugging-guide.md"
    "code-review.md"
    "project-kickoff.md"
)

# ---------------------------------------------------------------------------
# Color codes (with fallback for terminals that don't support colors)
# ---------------------------------------------------------------------------
if [ -t 1 ] && command -v tput &>/dev/null && tput colors &>/dev/null; then
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    CYAN=$(tput setaf 6)
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    CYAN=""
    BOLD=""
    RESET=""
fi

# ---------------------------------------------------------------------------
# Logging helpers
# ---------------------------------------------------------------------------
log_info()    { printf "%s[資訊]%s %s\n" "${BLUE}"   "${RESET}" "$*"; }
log_success() { printf "%s[成功]%s %s\n" "${GREEN}"  "${RESET}" "$*"; }
log_warn()    { printf "%s[警告]%s %s\n" "${YELLOW}" "${RESET}" "$*"; }
log_error()   { printf "%s[錯誤]%s %s\n" "${RED}"    "${RESET}" "$*" >&2; }

# ---------------------------------------------------------------------------
# Track installation results for the final report
# ---------------------------------------------------------------------------
declare -a INSTALLED_FILES=()
declare -a FAILED_FILES=()
CLAUDE_MD_STATUS="跳過"

# ---------------------------------------------------------------------------
# Print banner
# ---------------------------------------------------------------------------
print_banner() {
    printf "\n"
    printf "%s%s" "${CYAN}" "${BOLD}"
    printf "╔══════════════════════════════════════════════════════════╗\n"
    printf "║                                                          ║\n"
    printf "║   TIP — The Intelligent Prompt  ·  快速安裝程式         ║\n"
    printf "║                                                          ║\n"
    printf "║   GitHub : github.com/%s/%-28s║\n" "${REPO_OWNER}" "${REPO_NAME}"
    printf "╚══════════════════════════════════════════════════════════╝\n"
    printf "%s" "${RESET}"
    printf "\n"
}

# ---------------------------------------------------------------------------
# Verify required tools are available
# ---------------------------------------------------------------------------
check_dependencies() {
    local missing=0
    for cmd in curl mkdir; do
        if ! command -v "${cmd}" &>/dev/null; then
            log_error "找不到必要工具：${cmd}"
            missing=1
        fi
    done
    if [ "${missing}" -eq 1 ]; then
        log_error "請安裝缺少的工具後再重新執行安裝程式。"
        exit 1
    fi
}

# ---------------------------------------------------------------------------
# Create the skills directory if it doesn't exist
# ---------------------------------------------------------------------------
ensure_skills_dir() {
    if [ -d "${SKILLS_DIR}" ]; then
        log_info "技能目錄已存在：${SKILLS_DIR}"
        return 0
    fi

    log_info "建立技能目錄：${SKILLS_DIR}"
    if mkdir -p "${SKILLS_DIR}"; then
        log_success "技能目錄建立完成。"
    else
        log_error "無法建立目錄：${SKILLS_DIR}（請確認您有足夠的寫入權限）"
        exit 1
    fi
}

# ---------------------------------------------------------------------------
# Download a single skill file
# Returns 0 on success, 1 on failure
# ---------------------------------------------------------------------------
download_skill() {
    local filename="$1"
    local url="${RAW_BASE_URL}/skills/${filename}"
    local dest="${SKILLS_DIR}/${filename}"
    local tmp_file
    tmp_file="$(mktemp)"

    # Clean up the temp file on exit regardless of outcome
    trap 'rm -f "${tmp_file}"' RETURN

    if curl -fsSL --connect-timeout 10 --max-time 30 \
            -o "${tmp_file}" "${url}" 2>/dev/null; then
        # Verify we actually got content, not an empty file or GitHub 404 page
        if [ -s "${tmp_file}" ]; then
            mv "${tmp_file}" "${dest}"
            log_success "已下載：${filename}"
            INSTALLED_FILES+=("${filename}")
            return 0
        else
            log_warn "檔案內容為空，跳過：${filename}"
            FAILED_FILES+=("${filename} (回應為空)")
            return 1
        fi
    else
        log_warn "下載失敗：${filename}（網路錯誤或檔案不存在）"
        FAILED_FILES+=("${filename} (下載失敗)")
        return 1
    fi
}

# ---------------------------------------------------------------------------
# Download all skill files
# ---------------------------------------------------------------------------
download_all_skills() {
    log_info "開始下載技能檔案到 ${SKILLS_DIR} ..."
    printf "\n"

    local success_count=0
    local fail_count=0

    for skill_file in "${SKILL_FILES[@]}"; do
        if download_skill "${skill_file}"; then
            (( success_count++ )) || true
        else
            (( fail_count++ )) || true
        fi
    done

    printf "\n"
    log_info "技能下載完畢：成功 ${success_count} 個，失敗 ${fail_count} 個。"
}

# ---------------------------------------------------------------------------
# Ask the user whether to copy CLAUDE.md to the current directory
# Defaults to No when stdin is not a terminal (e.g. piped from curl)
# ---------------------------------------------------------------------------
ask_copy_claude_md() {
    local copy_it=false

    if [ -t 0 ]; then
        # stdin is a terminal — we can ask interactively
        printf "\n"
        log_info "是否要將 CLAUDE.md 複製到目前目錄（$(pwd)）？"
        printf "%s  [y/N]：%s" "${YELLOW}" "${RESET}"
        read -r response </dev/tty
        case "${response}" in
            [yY] | [yY][eE][sS])
                copy_it=true
                ;;
            *)
                copy_it=false
                ;;
        esac
    else
        # Non-interactive (piped from curl) — skip without asking
        log_warn "偵測到非互動式執行模式，跳過 CLAUDE.md 複製步驟。"
        log_warn "如需手動複製，請執行："
        log_warn "  curl -fsSL ${CLAUDE_MD_SOURCE_URL} -o ./CLAUDE.md"
        return 0
    fi

    if [ "${copy_it}" = true ]; then
        copy_claude_md
    else
        log_info "跳過 CLAUDE.md 複製。"
        CLAUDE_MD_STATUS="跳過（使用者選擇不複製）"
    fi
}

# ---------------------------------------------------------------------------
# Download and copy CLAUDE.md to the current working directory
# ---------------------------------------------------------------------------
copy_claude_md() {
    local dest="$(pwd)/CLAUDE.md"
    local tmp_file
    tmp_file="$(mktemp)"
    trap 'rm -f "${tmp_file}"' RETURN

    log_info "正在下載 CLAUDE.md ..."

    if curl -fsSL --connect-timeout 10 --max-time 30 \
            -o "${tmp_file}" "${CLAUDE_MD_SOURCE_URL}" 2>/dev/null && [ -s "${tmp_file}" ]; then
        if [ -f "${dest}" ]; then
            local backup="${dest}.bak.$(date +%Y%m%d_%H%M%S)"
            log_warn "目標路徑已存在 CLAUDE.md，備份至：${backup}"
            cp "${dest}" "${backup}"
        fi
        mv "${tmp_file}" "${dest}"
        log_success "CLAUDE.md 已複製至：${dest}"
        CLAUDE_MD_STATUS="已複製至 ${dest}"
    else
        log_error "下載 CLAUDE.md 失敗。"
        CLAUDE_MD_STATUS="下載失敗"
    fi
}

# ---------------------------------------------------------------------------
# Print the installation summary report
# ---------------------------------------------------------------------------
print_report() {
    printf "\n"
    printf "%s%s" "${BOLD}" "${CYAN}"
    printf "══════════════════════════════════════════════════════════\n"
    printf "  安裝報告\n"
    printf "══════════════════════════════════════════════════════════%s\n" "${RESET}"

    printf "\n%s技能目錄%s\n" "${BOLD}" "${RESET}"
    printf "  %s\n" "${SKILLS_DIR}"

    printf "\n%s已安裝的技能檔案%s\n" "${BOLD}" "${RESET}"
    if [ ${#INSTALLED_FILES[@]} -eq 0 ]; then
        printf "  %s（無）%s\n" "${YELLOW}" "${RESET}"
    else
        for f in "${INSTALLED_FILES[@]}"; do
            printf "  %s✓%s  %s\n" "${GREEN}" "${RESET}" "${f}"
        done
    fi

    if [ ${#FAILED_FILES[@]} -gt 0 ]; then
        printf "\n%s失敗的檔案%s\n" "${BOLD}" "${RESET}"
        for f in "${FAILED_FILES[@]}"; do
            printf "  %s✗%s  %s\n" "${RED}" "${RESET}" "${f}"
        done
    fi

    printf "\n%sCLAUDE.md%s\n" "${BOLD}" "${RESET}"
    printf "  %s\n" "${CLAUDE_MD_STATUS}"

    printf "\n"
    if [ ${#INSTALLED_FILES[@]} -gt 0 ]; then
        printf "%s%s所有技能已就緒！重新啟動 Claude Code 即可使用。%s\n" \
               "${GREEN}" "${BOLD}" "${RESET}"
    else
        printf "%s%s安裝未完成，請檢查網路連線後重試。%s\n" \
               "${RED}" "${BOLD}" "${RESET}"
    fi
    printf "\n"
}

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------
main() {
    print_banner
    check_dependencies
    ensure_skills_dir
    download_all_skills
    ask_copy_claude_md
    print_report
}

main "$@"
