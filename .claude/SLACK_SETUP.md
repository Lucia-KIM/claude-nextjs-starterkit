# Slack 알림 설정 가이드

Claude Code에서 작업 진행 상황을 Slack으로 실시간 알림받을 수 있도록 설정했습니다.

## 설정 방법

### 1. Slack Webhook URL 생성

1. Slack 워크스페이스에서 앱 설정으로 이동
2. "Incoming Webhooks" 생성
3. 알림을 받을 채널 선택
4. Webhook URL 복사

### 2. 환경 변수 설정

프로젝트 루트 또는 `.claude/hooks/` 디렉토리에 `.env` 파일 생성:

```bash
# .claude/hooks/.env
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

### 3. 설정 확인

- `settings.json`: Notification 및 PostToolUse 훅 설정됨
- `hooks/notify-slack.sh`: 권한 요청 시 알림 (🔐)
- `hooks/stop-slack.sh`: 파일 저장 시 알림 (✅)

## 알림 종류

### 권한 요청 알림 (🔐)
- Claude Code에서 파일 쓰기, 명령 실행 등 권한이 필요할 때 발생
- Webhook URL만 설정하면 자동 작동

### 작업 완료 알림 (✅)
- Write 도구 사용 시 (파일 생성/수정)
- 프로젝트명, 경로, 상태, 완료 시간 포함

## 테스트

```bash
# 테스트 파일 생성 (자동으로 Slack 알림 발생)
echo "test" > test.md
```

## 환경 변수 없을 때

- Webhook URL이 없으면 훅이 자동으로 비활성화됨
- 에러 없이 정상 작동 (알림만 안 됨)

## 문제 해결

### 알림이 안 오는 경우

1. Webhook URL이 `.env`에 올바르게 설정되었는지 확인
2. 로그 파일 확인: `/tmp/claude-slack-hook.log`
3. Slack 채널의 알림 설정 확인

### 로그 확인

```bash
tail -20 /tmp/claude-slack-hook.log
```

## 더 알아보기

- `hooks/stop-slack.sh`: Slack 메시지 포맷 커스터마이징 가능
- `hooks/notify-slack.sh`: 권한 요청 알림 메시지 변경 가능
