#!/bin/bash

# Claude Code Notification 훅 — 권한 요청 시 Slack 알림
# Notification hook은 permission_prompt 등의 이벤트에서 트리거됨
# stdin: JSON {session_id, cwd, notification_type, message, ...}
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
notification_type=$(echo "$input" | jq -r '.notification_type // "unknown"')
message=$(echo "$input" | jq -r '.message // "No message"')
cwd=$(echo "$input" | jq -r '.cwd // "Unknown"')

# 프로젝트명 추출 (디렉토리 이름)
project_name=$(basename "$cwd")

# Slack 메시지 본문 구성
slack_text="🔐 Claude Code 권한 요청\nProject: $project_name\n\n$message"

# Slack Incoming Webhook 포맷으로 JSON 구성
payload=$(jq -n \
  --arg text "$slack_text" \
  '{
    "text": $text,
    "blocks": [
      {
        "type": "header",
        "text": {
          "type": "plain_text",
          "text": "🔐 Claude Code 권한 요청"
        }
      },
      {
        "type": "section",
        "fields": [
          {
            "type": "mrkdwn",
            "text": "*프로젝트:*\n'"'"'$HOSTNAME'"'"'"
          },
          {
            "type": "mrkdwn",
            "text": "*경로:*\n`'"$cwd"'`"
          }
        ]
      },
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "'"$message"'"
        }
      }
    ]
  }')

# Slack Incoming Webhook으로 전송 (비동기, 타임아웃 설정)
timeout 10 curl -s -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  -d "$payload" \
  > /dev/null 2>&1 || true

# 항상 성공 반환 (차단 불가 이벤트이므로 실패해도 영향 없어야 함)
exit 0
