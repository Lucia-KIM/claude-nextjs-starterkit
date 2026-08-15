#!/bin/bash

# Claude Code Stop 훅 — 작업 완료 시 Slack 알림
# Stop hook은 Claude가 턴(대화 라운드)을 완료할 때마다 트리거됨
# stdin: JSON {session_id, cwd, last_assistant_message, stop_reason, ...}
# 출력: Slack Incoming Webhook으로 POST 요청

set -e

# .env 파일에서 SLACK_WEBHOOK_URL 로드
# .env 위치: 이 스크립트 디렉토리 또는 프로젝트 루트
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# .env 파일 경로 (우선순위: 훅 디렉토리 > 프로젝트 루트)
ENV_FILE=""
if [ -f "$SCRIPT_DIR/.env" ]; then
  ENV_FILE="$SCRIPT_DIR/.env"
elif [ -f "$PROJECT_ROOT/.env.local" ]; then
  ENV_FILE="$PROJECT_ROOT/.env.local"
elif [ -f "$PROJECT_ROOT/.env" ]; then
  ENV_FILE="$PROJECT_ROOT/.env"
fi

# .env 파일 로드
if [ -n "$ENV_FILE" ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
fi

# SLACK_WEBHOOK_URL이 없으면 조용히 종료 (알림 시스템 미구성 상태)
if [ -z "$SLACK_WEBHOOK_URL" ]; then
  exit 0
fi

# stdin에서 JSON 수신
input=$(cat)

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
  --arg reason "$stop_reason_text" \
  --arg preview "$message_preview" \
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
            "text": "*프로젝트:*\n'"'"'$project'"'"'"
          },
          {
            "type": "mrkdwn",
            "text": "*경로:*\n`'"$cwd"'`"
          },
          {
            "type": "mrkdwn",
            "text": "*상태:*\n$reason"
          },
          {
            "type": "mrkdwn",
            "text": "*완료:*\n'"$(date '+%Y-%m-%d %H:%M:%S')"'"
          }
        ]
      },
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "*응답:*\n```\n'"$preview"'\n```"
        }
      }
    ]
  }')

# Slack Incoming Webhook으로 전송 (비동기, 타임아웃 설정)
timeout 10 curl -s -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  -d "$payload" \
  > /dev/null 2>&1 || true

# 항상 성공 반환 (Stop은 차단하지 않음 — 단순 알림이므로)
exit 0
