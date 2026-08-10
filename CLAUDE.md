# CLAUDE.md

이 파일은 Claude Code(claude.ai/code)에서 이 저장소의 코드를 작업할 때 필요한 지침을 제공합니다.

## 🚀 프로젝트 개요

**claude-nextjs-starterkit**은 최신 기술 스택으로 구성된 완전한 Next.js 프로젝트 템플릿입니다. Next.js 16의 App Router, TypeScript, Tailwind CSS v4, shadcn/ui를 포함하며 즉시 개발을 시작할 수 있도록 구성되어 있습니다.

## 📋 주요 명령어

| 명령어 | 설명 |
|--------|------|
| `npm run dev` | 개발 서버 실행 (http://localhost:3000) |
| `npm run build` | 프로덕션 빌드 생성 |
| `npm start` | 프로덕션 서버 실행 |
| `npm run lint` | ESLint로 코드 검사 |
| `npx shadcn@latest add [component]` | shadcn/ui 컴포넌트 추가 |

## 📁 프로젝트 구조

```
src/
├── app/
│   ├── layout.tsx          # Root layout (ThemeProvider 포함)
│   ├── page.tsx            # 홈페이지
│   ├── about/
│   │   └── page.tsx        # 소개 페이지 (placeholder)
│   ├── docs/
│   │   └── page.tsx        # 문서 페이지 (placeholder)
│   ├── blog/
│   │   └── page.tsx        # 블로그 페이지 (placeholder)
│   └── globals.css         # 전역 스타일 (Tailwind @imports)
├── components/
│   ├── ui/                 # shadcn/ui 컴포넌트 (Button, Card, Input, Label 등)
│   ├── layout/
│   │   ├── header.tsx      # 헤더 (데스크톱/모바일 네비게이션)
│   │   └── footer.tsx      # 푸터
│   ├── theme-provider.tsx  # next-themes를 이용한 테마 제공자
│   └── theme-toggle.tsx    # 다크모드 토글 버튼 컴포넌트
└── lib/
    └── utils.ts            # cn() 유틸리티 함수 (clsx + tailwind-merge)
```

## 🧭 라우트 및 페이지 현황

### 현재 라우트 목록

| 경로 | 파일 경로 | 상태 | 헤더 연결 | 비고 |
|------|---------|------|---------|------|
| `/` | `src/app/page.tsx` | ✅ 실제 콘텐츠 | — | 스타터킷 소개 페이지 |
| `/about` | `src/app/about/page.tsx` | 📝 Placeholder | ✅ | 소개 페이지 |
| `/docs` | `src/app/docs/page.tsx` | 📝 Placeholder | ✅ | 개발 문서 페이지 |
| `/blog` | `src/app/blog/page.tsx` | 📝 Placeholder | ✅ | 블로그 페이지 |

### Placeholder 페이지 패턴

각 `about`, `docs`, `blog` 페이지는 현재 다음 구조로 구성되어 있습니다:

```tsx
export default function PageName() {
  return (
    <main className="flex flex-col items-center justify-center min-h-screen px-4 py-12">
      <div className="max-w-2xl">
        <h1 className="text-4xl font-bold mb-4">페이지 제목</h1>
        <p className="text-lg text-muted-foreground mb-6">
          간단한 소개 텍스트
        </p>
        <div className="space-y-4">
          <p className="text-base leading-relaxed">
            상세 설명
          </p>
        </div>
      </div>
    </main>
  );
}
```

**특징:**
- Server Component 기본값 사용
- Tailwind CSS v4 클래스로 스타일링
- `text-muted-foreground` 등 시맨틱 색상으로 라이트/다크 모드 자동 대응
- 반응형 디자인 포함 (`px-4` 모바일 패딩)
- 헤더 및 푸터는 root `layout.tsx`에서 자동 상속

향후 실제 콘텐츠로 교체 시 이 구조를 참고하세요.

### 알려진 이슈

- **AGENTS.md 자동 관리 파일**: 저장소 루트의 `AGENTS.md`는 `npm run dev` 실행 중 Next.js 16에 의해 자동 생성/업데이트됩니다. 이 파일은 Next.js의 breaking change 경고 블록을 포함하고 있으며, git 커밋 시 포함되어야 합니다. 이 파일을 직접 수정하지 마세요.
  
- **푸터 임시 링크 (Placeholder)**: 푸터의 10개 링크 (`href="#"`)가 아직 구현되지 않은 페이지에 대한 임시 상태입니다. 실제 404 에러는 발생하지 않으며, 필요에 따라 향후 페이지를 생성하면 됩니다.
  - **미구현 페이지**: 기능, 가격, FAQ, 커뮤니티, 개인정보 보호, 이용약관, 라이선스, 소셜 링크
  - **이미 연결된 페이지**: 문서(`/docs`), 블로그(`/blog`)
  
- **커스텀 404 페이지 부재**: 현재 `src/app/not-found.tsx`가 없어 Next.js 기본 404 페이지가 표시됩니다. 필요에 따라 추가를 고려하세요.

### 핵심 아키텍처

**App Router 구조**
- Next.js 16의 App Router 사용 (Pages Router 아님)
- `src/app/` 디렉토리가 라우팅의 기본
- 파일 시스템 기반 자동 라우팅: `src/app/features/page.tsx` → `/features`
- `layout.tsx`는 모든 페이지의 기본 레이아웃 제공
- ThemeProvider(`src/components/theme-provider.tsx`)로 클라이언트 측 테마 관리 감싸기
- Root layout은 `suppressHydrationWarning`으로 테마 관련 hydration 경고 방지

**스타일링 시스템**
- Tailwind CSS v4: 설정 파일 불필요 (`@import "tailwindcss"` in globals.css)
- OKLch 색상 공간 기반 CSS 변수로 라이트/다크 모드 자동 전환
- `src/app/globals.css`에 `:root`와 `.dark` CSS 변수로 테마 정의
- Semantic 색상 변수 사용: `bg-primary`, `text-muted-foreground`, `border-input` 등
- `cn()` 유틸리티 함수로 Tailwind 클래스 충돌 자동 해결

**UI 컴포넌트 시스템**
- shadcn/ui 기반 접근성 높은 컴포넌트 (Button, Card, Input, Label, Dialog, Avatar, Badge, Alert 등)
- Base UI (`@base-ui/react`) 헤드리스 UI 라이브러리와 통합
- class-variance-authority로 컴포넌트 변형 정의
- 전체 컴포넌트는 `src/components/ui/`에 위치
- 레이아웃 컴포넌트 (Header, Footer)는 `src/components/layout/`에 위치

**데이터 입력 및 검증**
- `react-hook-form`: 폼 상태 관리 (성능 최적화, 유효성 검사)
- `zod`: TypeScript-first 스키마 유효성 검사 (form validation 권장)
- `sonner`: 사용자 피드백용 토스트 알림 (에러, 성공 메시지)

**레이아웃 구조**
```
Root Layout (layout.tsx)
├── ThemeProvider (클라이언트 측 테마 관리)
├── Header (고정 상단, 데스크톱/모바일 반응형)
├── Page Content (동적 라우트)
└── Footer (고정 하단, 반응형)
```

## 🎨 테마 및 스타일링

### 색상 커스터마이징

`src/app/globals.css`의 `:root`와 `.dark` 섹션에서 CSS 변수를 수정합니다:
```css
:root {
  --primary: oklch(0.205 0 0);  /* 라이트 모드 주요 색상 */
  --background: oklch(1 0 0);    /* 라이트 모드 배경 */
  /* ... */
}

.dark {
  --primary: oklch(0.922 0 0);   /* 다크 모드 주요 색상 */
  --background: oklch(0.145 0 0); /* 다크 모드 배경 */
  /* ... */
}
```

OKLch 색상 공간: `oklch(명도 채도 색상각도)`

### Tailwind 클래스 사용

```tsx
// ✅ 올바른 사용 - Tailwind 유틸리티 클래스
<div className="flex gap-4 px-4 py-8 rounded-lg bg-card text-card-foreground">
  {/* 콘텐츠 */}
</div>

// ✅ 다크모드 대응
<div className="bg-white dark:bg-slate-950">
  {/* 자동으로 라이트/다크 모드 전환 */}
</div>

// ❌ 피하기 - 인라인 스타일
<div style={{ padding: '2rem', backgroundColor: 'blue' }}>
  {/* 사용하지 말 것 */}
</div>
```

## 🧩 컴포넌트 개발 가이드

### shadcn/ui 컴포넌트 추가

```bash
# 특정 컴포넌트 추가
npx shadcn@latest add button

# 여러 컴포넌트 한 번에 추가
npx shadcn@latest add button card input label
```

### 새 컴포넌트 작성 (src/components/ 내)

```tsx
// src/components/my-component.tsx
import { cn } from "@/lib/utils";

interface MyComponentProps {
  className?: string;
  children: React.ReactNode;
}

export function MyComponent({ className, children }: MyComponentProps) {
  return (
    <div className={cn("flex gap-4 p-4", className)}>
      {children}
    </div>
  );
}
```

### 컴포넌트 내 클래스 병합

```tsx
// cn() 함수 사용 - Tailwind 클래스 충돌 해결
import { cn } from "@/lib/utils";

<Button className={cn("w-full", isActive && "bg-primary")} />
```

## 🌓 다크모드 구현

ThemeProvider(`src/components/theme-provider.tsx`)가 자동으로 관리합니다:
- 시스템 설정에 따라 초기 테마 결정
- localStorage에 사용자 선택 저장
- ThemeToggle 컴포넌트로 수동 전환 가능

```tsx
// 다크모드 토글 버튼 배치
import { ThemeToggle } from "@/components/theme-toggle";

export function Header() {
  return (
    <header>
      {/* 헤더 콘텐츠 */}
      <ThemeToggle />
    </header>
  );
}
```

## 📦 주요 의존성

| 패키지 | 버전 | 용도 |
|--------|------|------|
| `next` | 16.3.0 | React 프레임워크 (App Router, Turbopack) |
| `react` | 19.2.8 | UI 라이브러리 |
| `typescript` | ^5 | 타입 체크 |
| `tailwindcss` | ^4 | CSS-first 프레임워크 (설정 파일 불필요) |
| `@base-ui/react` | ^1.7.0 | 헤드리스 UI 컴포넌트 |
| `shadcn` | ^4.16.2 | UI 컴포넌트 라이브러리 |
| `next-themes` | ^0.4.6 | 테마 관리 (다크모드) |
| `lucide-react` | ^1.30.0 | 아이콘 라이브러리 |
| `react-hook-form` | ^7.85.0 | 폼 상태 관리 |
| `zod` | ^4.4.3 | TypeScript-first 유효성 검사 |
| `sonner` | ^2.0.8 | 토스트 알림 컴포넌트 |
| `tw-animate-css` | ^1.4.0 | Tailwind 애니메이션 |
| `class-variance-authority` | ^0.7.1 | 컴포넌트 변형 관리 |
| `clsx` | ^2.1.1 | 조건부 클래스명 |
| `tailwind-merge` | ^3.6.0 | Tailwind 클래스 병합 |

## 🔧 TypeScript 설정

`tsconfig.json`의 경로 별칭:
```json
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

`@/components`, `@/lib`, `@/app` 등으로 절대 경로 임포트 가능합니다.

## 🎯 개발 워크플로우

### 1. 새 페이지 추가
```tsx
// src/app/about/page.tsx
export default function About() {
  return <div>About 페이지</div>;
}
// → http://localhost:3000/about 자동 라우팅
```

### 2. 새 컴포넌트 추가
```tsx
// src/components/my-feature.tsx
export function MyFeature() { /* ... */ }

// src/app/page.tsx에서 사용
import { MyFeature } from "@/components/my-feature";
```

### 3. 클라이언트 컴포넌트 (상호작용 필요)
```tsx
"use client";  // 파일 맨 위에 추가

import { useState } from "react";

export function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

## ⚙️ ESLint 설정

프로젝트는 ESLint 9의 flat config (`eslint.config.mjs`) 형식을 사용하며, Next.js 공식 ESLint 구성이 적용되어 있습니다.

```bash
npm run lint
```

ESLint 경고/에러가 있으면 수정하고 커밋하기 전에 린트를 통과해야 합니다. 

**설정 파일**: `eslint.config.mjs`

## 🚀 빌드 및 배포

### 프로덕션 빌드
```bash
npm run build
npm start
```

### 배포 고려사항
- Next.js는 기본적으로 Vercel에 최적화되어 있음
- 다른 플랫폼(AWS, GCP, Docker)에서도 `next build` + `next start`로 실행 가능
- Standalone 모드: `next.config.js`에서 `output: 'standalone'` 설정

## ✅ 개발 시 체크리스트

새 기능을 추가하거나 수정할 때:
- [ ] 개발 서버(`npm run dev`)에서 정상 동작 확인
- [ ] 라이트/다크 모드 모두에서 UI 확인
- [ ] `npm run lint` 통과 확인
- [ ] 모바일 반응형 디자인 확인 (DevTools)
- [ ] 유형 오류 없음 (TypeScript)

## 📚 유용한 자료

- [Next.js 16 문서](https://nextjs.org/docs)
- [Tailwind CSS v4 문서](https://tailwindcss.com/docs)
- [shadcn/ui 컴포넌트](https://ui.shadcn.com)
- [lucide-react 아이콘](https://lucide.dev)
- [React 문서](https://react.dev)

## 🐛 문제 해결

### 스타일이 적용되지 않는 경우
- `cn()` 함수 사용 여부 확인 (Tailwind 클래스 병합)
- `globals.css`의 Tailwind import 확인
- 개발 서버 재시작

### 테마 전환이 작동하지 않는 경우
- `layout.tsx`에서 `ThemeProvider`로 감싸져 있는지 확인
- `suppressHydrationWarning` 속성 확인
- 브라우저 localStorage 확인

### 컴포넌트 추가 후 타입 오류
- `npm run lint` 실행
- `tsconfig.json`의 경로 별칭 확인
- IDE 캐시 새로고침

### 헤더/푸터 메뉴 클릭 시 404 발생
**원인:** 대부분 링크의 대상 페이지 파일(`src/app/[route]/page.tsx`)이 존재하지 않아 발생합니다.

**진단 방법:**
1. 개발 서버가 실행 중인지 확인 (`npm run dev`)
2. 브라우저의 개발자 도구로 실제 404 응답 확인
3. 링크의 `href` 속성과 `src/app/` 디렉토리의 라우트 구조가 일치하는지 확인
4. Playwright MCP 등을 통해 실제 브라우저 동작으로 검증

**해결책:**
- 링크의 `href`가 올바른지 확인
- 대상 라우트의 `page.tsx` 파일이 존재하는지 확인
- 라우트 구조가 Next.js App Router 컨벤션을 따르는지 확인
