#!/bin/bash

# Claude Code Stop 훅 — 작업 완료 시 Slack 알림
# Stop hook은 Claude가 턴(대화 라운드)을 완료할 때마다 트리거됨
# stdin: JSON {session_id, cwd, last_assistant_message, stop_reason, ...}
# 출력: Slack Incoming Webhook으로 POST 요청

set -e

# 디버깅: 훅이 실행되었는지 로그 남기기
LOG_FILE="/tmp/claude-slack-hook.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Hook executed - UserPromptSubmit" >> "$LOG_FILE"

# .env 파일에서 SLACK_WEBHOOK_URL 로드
# .env 위치: 이 스크립트 디렉토리 또는 프로젝트 루트
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] SCRIPT_DIR: $SCRIPT_DIR" >> "$LOG_FILE"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] PROJECT_ROOT: $PROJECT_ROOT" >> "$LOG_FILE"

# .env 파일 경로 (우선순위: 훅 디렉토리 > 프로젝트 루트)
ENV_FILE=""
if [ -f "$SCRIPT_DIR/.env" ]; then
  ENV_FILE="$SCRIPT_DIR/.env"
elif [ -f "$PROJECT_ROOT/.env.local" ]; then
  ENV_FILE="$PROJECT_ROOT/.env.local"
elif [ -f "$PROJECT_ROOT/.env" ]; then
  ENV_FILE="$PROJECT_ROOT/.env"
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] ENV_FILE: $ENV_FILE" >> "$LOG_FILE"

# .env 파일 로드
if [ -n "$ENV_FILE" ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] .env 로드됨" >> "$LOG_FILE"
fi

# SLACK_WEBHOOK_URL 확인
echo "[$(date '+%Y-%m-%d %H:%M:%S')] SLACK_WEBHOOK_URL: ${SLACK_WEBHOOK_URL:0:50}..." >> "$LOG_FILE"

# SLACK_WEBHOOK_URL이 없으면 조용히 종료 (알림 시스템 미구성 상태)
if [ -z "$SLACK_WEBHOOK_URL" ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] WEBHOOK_URL이 없어 종료" >> "$LOG_FILE"
  exit 0
fi

# stdin에서 JSON 수신
input=$(cat)
echo "[$(date '+%Y-%m-%d %H:%M:%S')] stdin 수신됨, 길이: ${#input}" >> "$LOG_FILE"

# jq로 필드 추출
last_message=$(echo "$input" | jq -r '.last_assistant_message // "No message"')
stop_reason=$(echo "$input" | jq -r '.stop_reason // "unknown"')
cwd=$(echo "$input" | jq -r '.cwd // "Unknown"')

# 프로젝트명 추출 (디렉토리 이름)
project_name=$(basename "$cwd")

# 마지막 메시지 요약 (첫 300자 이하)
message_preview="${last_message:0:300}"
if [ ${#last_message} -gt 300 ]; then
  message_preview="${message_preview}…"
fi

# 종료 이유를 사람 친화적인 텍스트로 변환
case "$stop_reason" in
  "end_turn")
    stop_reason_text="정상 완료"
    ;;
  "max_tokens")
    stop_reason_text="토큰 한도 도달"
    ;;
  "tool_use")
    stop_reason_text="도구 호출 진행 중"
    ;;
  *)
    stop_reason_text="$stop_reason"
    ;;
esac

# Slack 메시지 본문 구성
slack_text="✅ Claude Code 작업 완료\nProject: $project_name\n\n$message_preview"

# Slack Incoming Webhook 포맷으로 JSON 구성
payload=$(jq -n \
  --arg text "$slack_text" \
  --arg project "$project_name" \
  --arg cwd "$cwd" \
  --arg reason "$stop_reason_text" \
  --arg preview "$message_preview" \
  --arg timestamp "$(date '+%Y-%m-%d %H:%M:%S')" \
  '{
    "text": $text,
    "blocks": [
      {
        "type": "header",
        "text": {
          "type": "plain_text",
          "text": "✅ Claude Code 작업 완료"
        }
      },
      {
        "type": "section",
        "fields": [
          {
            "type": "mrkdwn",
            "text": "*프로젝트:*\n" + $project
          },
          {
            "type": "mrkdwn",
            "text": "*경로:*\n`" + $cwd + "`"
          },
          {
            "type": "mrkdwn",
            "text": "*상태:*\n" + $reason
          },
          {
            "type": "mrkdwn",
            "text": "*완료:*\n" + $timestamp
          }
        ]
      },
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "*응답:*\n```\n" + $preview + "\n```"
        }
      }
    ]
  }')

# Slack Incoming Webhook으로 전송 (비동기, 타임아웃 설정)
echo "[$(date '+%Y-%m-%d %H:%M:%S')] curl 실행 시작..." >> "$LOG_FILE"

# curl 실행 (stderr도 stdout으로 리다이렉트)
(
  curl -X POST "$SLACK_WEBHOOK_URL" \
    -H 'Content-Type: application/json' \
    -d "$payload" 2>&1
) >> "$LOG_FILE" 2>&1 &

echo "[$(date '+%Y-%m-%d %H:%M:%S')] curl 백그라운드 실행됨 (PID: $!)" >> "$LOG_FILE"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] ===== 훅 종료 =====" >> "$LOG_FILE"

# 항상 성공 반환 (Stop은 차단하지 않음 — 단순 알림이므로)
exit 0
