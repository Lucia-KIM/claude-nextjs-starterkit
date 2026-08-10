# Next.js Starter Kit

웹 개발을 빠르게 시작할 수 있는 완전하게 구성된 Next.js starter kit입니다. 최신 기술 스택이 미리 설정되어 있어 즉시 개발을 시작할 수 있습니다.

## 🚀 기술 스택

- **Next.js 16** - React 기반 프레임워크 (App Router, Turbopack)
- **TypeScript** - 정적 타입 체크
- **Tailwind CSS v4** - CSS-first 유틸리티 프레임워크 (설정 파일 불필요)
- **shadcn/ui** - 고급 UI 컴포넌트 라이브러리 (접근성 우선)
- **lucide-react** - 아이콘 라이브러리
- **next-themes** - 다크모드 지원

## 📂 프로젝트 구조

```
src/
├── app/
│   ├── layout.tsx          # Root layout (ThemeProvider, Header, Footer 포함)
│   ├── page.tsx            # 홈페이지 (스타터킷 소개)
│   ├── about/page.tsx      # 소개 페이지
│   ├── docs/page.tsx       # 문서 페이지
│   ├── blog/page.tsx       # 블로그 페이지
│   ├── globals.css         # 전역 스타일 & Tailwind 설정
│   └── favicon.ico
├── components/
│   ├── ui/                 # shadcn/ui 컴포넌트들
│   │   ├── button.tsx
│   │   ├── card.tsx
│   │   ├── input.tsx
│   │   └── label.tsx
│   ├── layout/
│   │   ├── header.tsx      # 상단 네비게이션 (데스크톱/모바일)
│   │   ├── footer.tsx      # 푸터
│   │   ├── section.tsx
│   │   └── main-container.tsx
│   ├── theme-provider.tsx  # next-themes 설정 (다크모드)
│   └── theme-toggle.tsx    # 다크모드 토글 버튼
└── lib/
    └── utils.ts            # cn() 유틸리티 함수 (clsx + tailwind-merge)
```

## 🎯 시작하기

### 1. 의존성 설치 (이미 완료됨)
```bash
npm install
```

### 2. 개발 서버 실행
```bash
npm run dev
```

[http://localhost:3000](http://localhost:3000)에서 결과를 확인하세요.

### 3. 새 컴포넌트 추가

shadcn/ui의 사용 가능한 컴포넌트를 추가합니다:
```bash
npx shadcn@latest add [component-name]
```

예: `alert`, `dialog`, `dropdown-menu`, `tabs`, `modal` 등

더 많은 컴포넌트는 [ui.shadcn.com](https://ui.shadcn.com)에서 확인하세요.

### 4. 빌드 및 배포

개발 환경에서 테스트 후 프로덕션 빌드:
```bash
npm run build
npm start
```

## 📄 포함된 페이지

이 starter kit에는 다음 페이지들이 미리 설정되어 있습니다:

| 경로 | 페이지 | 설명 |
|------|--------|------|
| `/` | 홈페이지 | 스타터킷 소개 및 주요 기능 안내 |
| `/about` | 소개 | 프로젝트 소개 페이지 |
| `/docs` | 문서 | 개발 가이드 및 API 문서 |
| `/blog` | 블로그 | 기술 이야기 및 업데이트 |

각 페이지는 `src/app/[route]/page.tsx` 파일로 구성되며, root layout에서 자동으로 **헤더**와 **푸터**가 포함됩니다.

## 🧭 네비게이션 구조

### 헤더 (상단)
- **데스크톱**: 수평 네비게이션 메뉴 (소개, 문서, 블로그)
- **모바일**: 햄버거 메뉴로 동일한 항목 제공
- **우측 상단**: 다크모드 토글 버튼

### 푸터 (하단)
- **리소스 섹션**: 문서, 블로그, 커뮤니티
- **제품 섹션**: 기능, 가격, FAQ (향후 추가 예정)
- **법적 섹션**: 개인정보 보호, 이용약관, 라이선스 (향후 추가 예정)
- **소셜 링크**: Email, Share, Contact (향후 구현 예정)

## 📦 주요 기능

### ✅ 즉시 사용 가능한 컴포넌트
- `Button` - 다양한 스타일 변형 (primary, secondary, outline, destructive, ghost)
- `Card` - 콘텐츠 그룹화
- `Input` - 폼 입력 필드
- `Label` - 폼 레이블

### ✅ 다크모드 지원
- `ThemeProvider`로 다크모드 자동 관리
- `ThemeToggle` 컴포넌트로 사용자가 테마 전환 가능
- CSS 변수 기반 테마 (OKLch 색상 공간)

### ✅ TypeScript 지원
- 완전한 타입 안정성
- 자동 완성 지원

### ✅ Tailwind CSS v4
- config 파일 없이 CSS-first 방식 (`@import "tailwindcss"`)
- 모든 유틸리티 클래스 사용 가능
- 반응형 디자인 지원

## 🔧 주요 npm 스크립트

| 명령어 | 설명 |
|--------|------|
| `npm run dev` | 개발 서버 실행 (자동 리로드) |
| `npm run build` | 프로덕션 빌드 |
| `npm start` | 프로덕션 서버 실행 |
| `npm run lint` | ESLint로 코드 검사 |

## ✨ 프로젝트 상태

### 완성된 기능 ✅
- 기본 레이아웃 (헤더, 푸터, 반응형 메뉴)
- 라우팅 (홈, 소개, 문서, 블로그 페이지)
- 다크모드 지원 (next-themes 통합)
- 반응형 디자인 (모바일 ≤640px / 태블릿 ≤1024px / 데스크톱)
- TypeScript 설정 및 타입 안정성
- Tailwind CSS v4 (설정 파일 불필요)
- shadcn/ui 컴포넌트 시스템

### 향후 계획 📝
- 추가 페이지 콘텐츠 작성 (기능, 가격, FAQ 등)
- 폼 컴포넌트 확장 (TextArea, Select, Checkbox 등)
- 데이터 시각화 컴포넌트
- 블로그 포스트 시스템
- 검색 기능

## 📝 예시 코드

### Button 컴포넌트 사용
```tsx
import { Button } from "@/components/ui/button";

export default function Example() {
  return (
    <div className="flex gap-2">
      <Button>기본 버튼</Button>
      <Button variant="outline">Outline</Button>
      <Button variant="destructive">Delete</Button>
    </div>
  );
}
```

### Card 컴포넌트 사용
```tsx
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function Example() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>제목</CardTitle>
      </CardHeader>
      <CardContent>콘텐츠</CardContent>
    </Card>
  );
}
```

### Form 컴포넌트 사용
```tsx
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

export default function Example() {
  return (
    <div className="space-y-2">
      <Label htmlFor="email">이메일</Label>
      <Input id="email" type="email" placeholder="example@example.com" />
    </div>
  );
}
```

### 아이콘 사용 (lucide-react)
```tsx
import { Zap, Moon, Sun } from "lucide-react";

export default function Example() {
  return (
    <div className="flex gap-4">
      <Zap className="w-6 h-6" />
      <Moon className="w-6 h-6" />
      <Sun className="w-6 h-6" />
    </div>
  );
}
```

## 📚 추가 자료

- [Next.js 문서](https://nextjs.org/docs)
- [Tailwind CSS 문서](https://tailwindcss.com/docs)
- [shadcn/ui 컴포넌트](https://ui.shadcn.com)
- [lucide-react 아이콘](https://lucide.dev)

## 🎨 커스터마이징

### Tailwind CSS 커스터마이징
`src/app/globals.css`의 `:root` CSS 변수를 편집하여 색상, 폰트 등을 커스터마이즈할 수 있습니다.

```css
:root {
  --primary: oklch(0.205 0 0);        /* 라이트 모드 주요 색상 */
  --background: oklch(1 0 0);         /* 라이트 모드 배경 */
  /* ... */
}

.dark {
  --primary: oklch(0.922 0 0);        /* 다크 모드 주요 색상 */
  --background: oklch(0.145 0 0);     /* 다크 모드 배경 */
  /* ... */
}
```

### 다크모드 토글 위치 변경
`ThemeToggle` 컴포넌트를 원하는 위치에 배치하면 됩니다. 현재는 헤더의 우측 상단에 위치하고 있습니다.

## 📚 페이지 추가 및 라우팅

### 새 페이지 추가하기

Next.js App Router를 사용하므로, 새 페이지 추가는 간단합니다:

```bash
# /features 페이지 추가
mkdir -p src/app/features
echo 'export default function Features() { return <div>Features</div>; }' > src/app/features/page.tsx
```

그러면 자동으로 `http://localhost:3000/features`에서 접근 가능합니다.

### 헤더/푸터에 새 링크 추가

헤더 메뉴를 수정하려면 `src/components/layout/header.tsx`를 편집:

```tsx
<Link href="/features" className="text-sm font-medium hover:text-primary">
  기능
</Link>
```

푸터 링크를 수정하려면 `src/components/layout/footer.tsx`를 편집합니다.

## 📄 라이선스

MIT

## 🤝 기여

이 starter kit을 개선하려면 이슈나 PR을 제출해주세요.
