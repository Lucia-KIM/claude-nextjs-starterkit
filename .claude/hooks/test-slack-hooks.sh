#!/bin/bash

# Claude Code Slack Hooks 테스트 스크립트
# 권한 요청(Notification)과 작업 완료(Stop) 알림이 제대로 작동하는지 확인

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}════════════════════════════════════════════${NC}"
echo -e "${BLUE}Claude Code Slack Hooks 테스트${NC}"
echo -e "${BLUE}════════════════════════════════════════════${NC}\n"

# .env 파일에서 SLACK_WEBHOOK_URL 로드
ENV_FILE="$SCRIPT_DIR/.env"
if [ -f "$ENV_FILE" ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
  echo -e "${GREEN}✅${NC} .env 파일 로드 완료"
else
  echo -e "${RED}❌${NC} .env 파일을 찾을 수 없습니다: $ENV_FILE"
  exit 1
fi

# SLACK_WEBHOOK_URL 확인
if [ -z "$SLACK_WEBHOOK_URL" ]; then
  echo -e "${RED}❌${NC} SLACK_WEBHOOK_URL이 설정되지 않았습니다"
  exit 1
fi

echo -e "${GREEN}✅${NC} Webhook URL이 설정되어 있습니다 (길이: ${#SLACK_WEBHOOK_URL}자)\n"

# 필수 도구 확인
echo -e "${YELLOW}🔍 필수 도구 확인:${NC}"
for tool in curl jq; do
  if command -v $tool &> /dev/null; then
    echo -e "${GREEN}✅${NC} $tool 설치됨"
  else
    echo -e "${RED}❌${NC} $tool이 없습니다"
    exit 1
  fi
done

echo ""

# 테스트 1: Notification 훅 (권한 요청)
echo -e "${YELLOW}📋 테스트 1: Notification 훅 (권한 요청 알림)${NC}"
echo "시뮬레이션: Claude Code 파일 쓰기 권한 요청"

cat <<'EOF' | "$SCRIPT_DIR/notify-slack.sh"
{
  "session_id": "test-session-001",
  "cwd": "/Users/lucia/Developer/learning/my-workspace/claude-nextjs-starterkit",
  "notification_type": "permission_prompt",
  "message": "Allow write to src/app/page.tsx?",
  "hook_event_name": "Notification"
}
EOF

if [ $? -eq 0 ]; then
  echo -e "${GREEN}✅${NC} Notification 훅 스크립트 실행 성공"
  echo -e "   → Slack 채널을 확인하세요 (🔐 권한 요청 메시지)\n"
else
  echo -e "${RED}❌${NC} Notification 훅 스크립트 실행 실패"
  exit 1
fi

sleep 2  # API 처리 대기

# 테스트 2: Stop 훅 (작업 완료)
echo -e "${YELLOW}📋 테스트 2: Stop 훅 (작업 완료 알림)${NC}"
echo "시뮬레이션: Claude Code 턴 완료"

cat <<'EOF' | "$SCRIPT_DIR/stop-slack.sh"
{
  "session_id": "test-session-001",
  "prompt_id": "test-prompt-123",
  "cwd": "/Users/lucia/Developer/learning/my-workspace/claude-nextjs-starterkit",
  "last_assistant_message": "완료되었습니다! src/app/page.tsx 파일을 업데이트했습니다. 주요 변경 사항은 다음과 같습니다:\n\n1. 헤더 섹션 개선\n2. 반응형 디자인 강화\n3. 다크모드 대응\n\n변경 사항을 확인하고 필요하면 추가 수정을 요청해주세요.",
  "stop_reason": "end_turn",
  "hook_event_name": "Stop"
}
EOF

if [ $? -eq 0 ]; then
  echo -e "${GREEN}✅${NC} Stop 훅 스크립트 실행 성공"
  echo -e "   → Slack 채널을 확인하세요 (✅ 작업 완료 메시지)\n"
else
  echo -e "${RED}❌${NC} Stop 훅 스크립트 실행 실패"
  exit 1
fi

sleep 2  # API 처리 대기

# 테스트 3: 직접 curl로 Webhook 테스트
echo -e "${YELLOW}📋 테스트 3: Webhook URL 연결성 테스트${NC}"

test_payload=$(jq -n \
  '{
    "text": "🧪 Claude Code Slack Hooks 테스트 성공!",
    "blocks": [
      {
        "type": "header",
        "text": {
          "type": "plain_text",
          "text": "🧪 Slack Hooks 테스트 성공"
        }
      },
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "모든 훅이 정상적으로 작동합니다!\n\n✅ Notification 훅 (권한 요청)\n✅ Stop 훅 (작업 완료)\n✅ Webhook 연결성\n\n이제 Claude Code에서 작업할 때마다 모바일 Slack으로 알림을 받을 수 있습니다."
        }
      }
    ]
  }')

response=$(curl -s -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  -d "$test_payload" \
  -w "\n%{http_code}")

http_code=$(echo "$response" | tail -1)

if [ "$http_code" = "200" ]; then
  echo -e "${GREEN}✅${NC} Webhook 연결 성공 (HTTP 200)"
else
  echo -e "${RED}❌${NC} Webhook 연결 실패 (HTTP $http_code)"
  echo "응답: $(echo "$response" | head -n -1)"
  exit 1
fi

echo ""
echo -e "${BLUE}════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ 모든 테스트 완료!${NC}"
echo -e "${BLUE}════════════════════════════════════════════${NC}\n"

echo -e "${YELLOW}📱 다음 단계:${NC}"
echo "1. Slack 모바일 앱에서 알림이 도착했는지 확인하세요"
echo "2. 해당 채널의 알림 설정이 '모든 메시지' 또는 활성화 상태인지 확인하세요"
echo "3. Claude Code에서 실제 작업을 시작하면 권한 요청/완료 시 자동 알림이 옵니다\n"

echo -e "${YELLOW}🔗 Slack 채널:${NC}"
echo "웹훅 설정에서 지정한 채널에 메시지가 발송됩니다\n"

echo -e "${YELLOW}📝 참고:${NC}"
echo "• Notification 훅: Claude Code에서 파일 쓰기, 명령 실행 등 권한이 필요할 때"
echo "• Stop 훅: Claude Code에서 턴(대화 라운드)이 완료될 때마다"
echo "• 두 훅 모두 비동기(async)로 실행되므로 작업 흐름에 영향 없음\n"
