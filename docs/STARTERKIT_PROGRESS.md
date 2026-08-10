# Next.js Starter Kit 구축 진행 상황

> **마지막 업데이트**: 2026-08-09 (Phase 1 완료)  
> **현재 상태**: 필수 컴포넌트 설치 및 기본 레이아웃 구현 완료 ✅

---

## 📋 전체 로드맵

| 단계 | 제목 | 상태 | 설명 |
|------|------|------|------|
| **1단계** | 범용 컴포넌트 및 레이아웃 정리 | ✅ 완료 | 모든 웹사이트에 공통으로 필요한 요소들을 7개 카테고리로 정리 |
| **2단계** | 컴포넌트 계층 분류 | ✅ 완료 | 4단계 계층 아키텍처(Primitive→Composite→Layout→Pattern) 설계 및 폴더 구조 정의 |
| **3단계** | Phase 1 필수 컴포넌트 설치 및 레이아웃 구현 | ✅ 완료 | shadcn/ui 필수 컴포넌트 + 기본 레이아웃(Header/Footer) 구현 |
| **4단계** | Phase 2 권장 컴포넌트 설치 (다음 진행) | ⏳ 예정 | tabs, tooltip, popover, command, table, accordion, embla-carousel 설치 |
| **5단계** | Phase 3 고급 기능 추가 (향후) | ⏳ 예정 | context-menu, breadcrumb, skeleton, progress, dashboard layout, form patterns |

---

## 🎯 1단계 결과: 범용 컴포넌트 정리

**목표**: 어떤 웹사이트를 만들든 공통으로 필요한 요소들을 항목별로 정리

### 정리된 7개 카테고리

#### A. 레이아웃 골격 (6개)
- Header, Navigation, Sidebar, Main Container, Section, Footer

#### B. 인터랙션 요소 (15개)
- Button, Input, Form Field, Checkbox, Radio, Toggle, Select, Combobox, Modal, Drawer, Toast, Tab, Accordion, Popover, Command Palette

#### C. 정보 표현 요소 (13개)
- Card, Badge, Tag, Avatar, Table, List, Tree View, Tooltip, Alert/Banner, Progress Bar, Skeleton, Rating, Badge Counter

#### D. 상태 표현 요소 (10개)
- Loading State, Empty State, Error State, 404/500 Page, Unauthorized, Forbidden, Disabled, Success, In Progress

#### E. 테마 및 다크모드 (5개)
- Light/Dark Toggle, Color Palette, Typography Tokens, Spacing Tokens, Shadow Tokens

#### F. 접근성 및 반응형 (4개 분야)
- 의미론적 HTML, ARIA, 포커스 관리, 키보드 네비게이션, 반응형 디자인, 애니메이션 안전성

**우선순위별 분류:**
- ⭐⭐⭐ **필수** (100% 재사용도): Header, Footer, Button, Card, Input, Navigation, Dark Mode
- ⭐⭐ **권장** (85-95% 재사용도): Modal, Toast, Table, Avatar, Badge, Tabs, Loading/Error State
- ⭐ **선택** (60-75% 재사용도): Sidebar, Accordion, Tree View, Command Palette, Rating

---

## 🏗️ 2단계 결과: 4단계 계층 아키텍처

**목표**: 범용 요소들을 효과적으로 재사용할 수 있도록 계층 구조로 분류

### 계층 구조

#### 계층 1: Primitive (기본 원자) - 20+개
- **상호작용**: Button, Input, Checkbox, Radio, Toggle, Select, Textarea, Label
- **표시**: Badge, Avatar, Icon, Separator, Progress, Skeleton
- **레이아웃**: Flex, Grid, Spacer

#### 계층 2: Composite (조합 분자) - 20+개
- **폼**: FormField, FormFieldCheckbox, SearchInput, PasswordInput
- **메뉴**: DropdownMenu, ContextMenu, NavigationMenu, Combobox, CommandPalette
- **정보**: Card, Alert, Tabs, Accordion, Table, Tooltip, Popover
- **피드백**: Toast, Dialog, Drawer, Spinner, LoadingOverlay
- **테마**: ThemeToggle, ThemeProvider

#### 계층 3: Layout (페이지 구조) - 8+개
- **기본**: RootLayout, Header, Footer, Sidebar, MainContainer, Section
- **네비게이션**: DesktopNav, MobileNav, Breadcrumb
- **대시보드**: DashboardLayout (3-컬럼)

#### 계층 4: Pattern/Template (완성된 페이지) - 15+개
- **상태**: EmptyState, ErrorState, LoadingState, NotFoundPage, ErrorPage
- **섹션**: HeroSection, CTASection, FeatureGrid, FAQSection, PricingTable
- **폼**: LoginForm, SignupForm, ContactForm, SettingsForm

### 폴더 구조

```
src/
├── components/
│   ├── ui/              # Primitives (shadcn/ui)
│   ├── form/            # Form Composites
│   ├── menu/            # Menu Composites
│   ├── feedback/        # Feedback Composites
│   ├── layout/          # Layout Components
│   ├── theme/           # Theme Components
│   └── patterns/        # Pattern/Template Components
├── app/
│   ├── layout.tsx       # RootLayout
│   ├── globals.css      # Tailwind + 테마
│   └── ...
└── lib/
```

---

## ✅ 3단계 결과: Phase 1 필수 컴포넌트 설치 및 레이아웃 구현

**목표**: 필수 컴포넌트 설치 및 기본 레이아웃 구현하여 모든 프로젝트의 기반 마련

### 설치된 Primitive 컴포넌트 (9개)

```bash
npx shadcn@latest add button input label badge avatar dropdown-menu card alert dialog --yes
```

| 컴포넌트 | 파일 | 용도 |
|---------|------|------|
| Button | `ui/button.tsx` | 클릭 액션 (Primary, Secondary, Destructive, Ghost) |
| Input | `ui/input.tsx` | 텍스트 입력 필드 |
| Label | `ui/label.tsx` | 폼 라벨 |
| Badge | `ui/badge.tsx` | 상태/라벨 표시 |
| Avatar | `ui/avatar.tsx` | 사용자/브랜드 아이콘 |
| Dropdown Menu | `ui/dropdown-menu.tsx` | 드롭다운 메뉴 |
| Card | `ui/card.tsx` | 정보 컨테이너 |
| Alert | `ui/alert.tsx` | 알림 박스 |
| Dialog | `ui/dialog.tsx` | 모달 윈도우 |

### 설치된 라이브러리

```bash
npm install sonner react-hook-form zod
npx shadcn@latest add form
```

| 패키지 | 버전 | 용도 |
|--------|------|------|
| sonner | 2.0.8 | Toast/알림 시스템 (자동 스택 + 테마 지원) |
| react-hook-form | 7.85.0 | 폼 상태 관리 (성능 최적화) |
| zod | 4.4.3 | 스키마 기반 유효성 검증 |
| @base-ui/react | 1.7.0 | 헤드리스 UI 컴포넌트 |
| next-themes | 0.4.6 | 테마 관리 (시스템/사용자 선택 감지) |

### 생성된 Layout 컴포넌트 (5개)

**파일 경로: `src/components/layout/`**

| 컴포넌트 | 파일 | 특징 |
|---------|------|------|
| **Header** | `header.tsx` | 반응형 헤더 (데스크톱 수평 메뉴 + 모바일 슬라이드 메뉴 + 테마 토글) |
| **Footer** | `footer.tsx` | 4-컬럼 푸터 (브랜드/링크/리소스/법적 + 소셜 아이콘) |
| **MainContainer** | `main-container.tsx` | 최대 너비 제어 (max-w-7xl + 반응형 패딩) |
| **Section** | `section.tsx` | 섹션 래퍼 (배경색 변형 + 반응형 여백) |

### 생성된 Feedback 컴포넌트 (1개)

**파일 경로: `src/components/feedback/`**

| 컴포넌트 | 파일 | 특징 |
|---------|------|------|
| **ToastProvider** | `toaster.tsx` | Sonner 알림 제공자 (우측 상단, 자동 색상, 닫기 버튼) |

### 생성된 Pattern 컴포넌트 (3개)

**파일 경로: `src/components/patterns/`**

| 패턴 | 파일 | 용도 |
|------|------|------|
| **LoadingState** | `loading-state.tsx` | 로딩 중 표시 (스피너 + 메시지) |
| **EmptyState** | `empty-state.tsx` | 데이터 없을 때 (아이콘 + 제목 + CTA 버튼) |
| **ErrorState** | `error-state.tsx` | 에러 표시 (알림 + 재시도 버튼) |

### RootLayout 통합

**파일: `src/app/layout.tsx`**

```tsx
<ThemeProvider>
  <Header />
  <main className="flex-1">{children}</main>
  <Footer />
  <ToastProvider />
</ThemeProvider>
```

- Flexbox 레이아웃으로 footer가 항상 하단에 위치
- Header는 sticky (상단 고정)
- main은 flex-1로 남은 공간 채움
- ToastProvider로 모든 페이지에서 toast 사용 가능

### 다크모드 구현

**방식**: Tailwind v4 CSS 변수 + next-themes

**파일: `src/app/globals.css`**

```css
:root {
  /* 라이트 모드 (기본) */
  --background: oklch(1 0 0);           /* 흰색 */
  --foreground: oklch(0.145 0 0);       /* 거의 검정 */
  --primary: oklch(0.205 0 0);          /* 검정 (주요 색상 - 커스터마이징 가능) */
  /* ... 다른 색상 */
}

.dark {
  /* 다크 모드 */
  --background: oklch(0.145 0 0);       /* 거의 검정 */
  --foreground: oklch(0.985 0 0);       /* 거의 흰색 */
  --primary: oklch(0.922 0 0);          /* 거의 흰색 */
  /* ... 다른 색상 */
}
```

**특징**:
- OKLch 색상 공간 (라이트/다크 모드 자동 전환)
- localStorage에 사용자 선택 저장
- 시스템 설정 자동 감지 (prefers-color-scheme)
- ThemeToggle 버튼으로 수동 전환

### 커밋 정보

**커밋 해시**: `c85d96e`  
**브랜치**: `develop`  
**변경 파일**: 18개  
**변경 라인**: +1166, -85

```
3단계: 필수 shadcn/ui 컴포넌트 설치 및 기본 레이아웃 구현
```

---

## 🚀 4단계 계획: Phase 2 권장 컴포넌트 설치

### 설치할 컴포넌트

```bash
npx shadcn@latest add tabs tooltip popover command table accordion --yes
npm install embla-carousel-react
```

**추가 Primitive** (3개):
- `progress` - 진행률 표시
- `skeleton` - 로딩 플레이스홀더
- `separator` - 시각적 구분선

**추가 Composite** (10+개):
- **Form Variants**: FormFieldCheckbox, FormFieldRadio, FormFieldSelect, FormFieldTextarea, SearchInput, PasswordInput
- **Menu Variants**: NavigationMenu, Combobox, CommandPalette
- **Information**: Tabs, Tooltip, Popover, Table, Accordion
- **Media**: Carousel (embla-carousel)

### 생성할 Composite 컴포넌트

**폴더: `src/components/form/`**
- `form-field-checkbox.tsx`
- `form-field-radio.tsx`
- `form-field-select.tsx`
- `form-field-textarea.tsx`
- `search-input.tsx`
- `password-input.tsx`

**폴더: `src/components/menu/`**
- `navigation-menu.tsx`
- `combobox.tsx`
- `command-palette.tsx`

**폴더: `src/components/data/`**
- `data-table.tsx` (Table 컴포넌트 래퍼)
- `carousel.tsx` (embla-carousel 래퍼)

### 예상 작업량
- shadcn/ui 컴포넌트 설치: ~5분
- 라이브러리 설치: ~2분
- Composite 컴포넌트 작성: ~30분
- 테스트 및 커밋: ~10분
- **총 예상 시간**: ~1시간

---

## 🔮 5단계 계획: Phase 3 고급 기능 (향후)

### 설치할 컴포넌트

```bash
npx shadcn@latest add context-menu breadcrumb
npx shadcn@latest add progress spinner
npx shadcn@latest add resizable sonner
```

### 생성할 Pattern 컴포넌트

**폴더: `src/components/patterns/`**
- `dashboard-layout.tsx` - 3-컬럼 대시보드 (Sidebar + Main + RightPanel)
- `hero-section.tsx` - 홈페이지 상단
- `cta-section.tsx` - Call-to-Action 섹션
- `feature-grid.tsx` - 기능 소개 그리드
- `faq-section.tsx` - FAQ 아코디언 섹션
- `pricing-table.tsx` - 요금 비교 테이블

**폴더: `src/components/patterns/forms/`**
- `login-form.tsx` - 로그인 폼
- `signup-form.tsx` - 회원가입 폼
- `contact-form.tsx` - 연락처 폼
- `settings-form.tsx` - 설정 폼

---

## 🎓 현재 프로젝트 상태

### 생성된 파일 구조

```
src/components/
├── ui/                          # Primitives (shadcn/ui 설치)
│   ├── button.tsx
│   ├── input.tsx
│   ├── label.tsx
│   ├── badge.tsx
│   ├── avatar.tsx
│   ├── dropdown-menu.tsx
│   ├── card.tsx
│   ├── alert.tsx
│   └── dialog.tsx
│
├── layout/                      # Layout Components (구현됨)
│   ├── header.tsx              ✅
│   ├── footer.tsx              ✅
│   ├── main-container.tsx      ✅
│   └── section.tsx             ✅
│
├── feedback/                    # Feedback Components (구현됨)
│   └── toaster.tsx             ✅
│
├── patterns/                    # Pattern/Template (구현됨)
│   ├── loading-state.tsx       ✅
│   ├── empty-state.tsx         ✅
│   └── error-state.tsx         ✅
│
├── theme-provider.tsx           # Theme (기존)
└── theme-toggle.tsx             # Theme (기존)
```

### 개발 서버 확인

```bash
npm run dev
# http://localhost:3000 에서 정상 작동 확인 ✅
```

### 현재 기능

- ✅ 반응형 헤더 (데스크톱/모바일)
- ✅ 4-컬럼 푸터 (소셜 링크 포함)
- ✅ 다크모드 토글 (시스템/사용자 선택)
- ✅ 홈페이지 (Hero + Features + Component Examples)
- ✅ Toast 알림 시스템 (sonner)
- ✅ 로딩/빈/에러 상태 표시

---

## 📖 다음에 이어서 시작하는 법

### 1. 오늘 작업 내용 확인

이 문서(`docs/STARTERKIT_PROGRESS.md`)를 읽어서 현재까지의 진행 상황을 파악합니다.

### 2. git 커밋 확인

```bash
git log --oneline -5
# c85d96e 3단계: 필수 shadcn/ui 컴포넌트 설치 및 기본 레이아웃 구현 (가장 최신)
```

### 3. 4단계 시작 (Phase 2 권장 컴포넌트 설치)

위 "4단계 계획"을 참고하여 다음 명령어를 실행합니다:

```bash
npx shadcn@latest add tabs tooltip popover command table accordion --yes
npm install embla-carousel-react
```

그 다음 `src/components/form/`, `src/components/menu/`, `src/components/data/` 폴더를 생성하고 Composite 컴포넌트들을 구현합니다.

### 4. 현재 프로젝트 구조 확인

```bash
ls -la src/components/
# ✅ ui/, layout/, feedback/, patterns/ 디렉토리 확인
```

### 5. 개발 서버 실행 (필요시)

```bash
npm run dev
# 브라우저에서 http://localhost:3000 접속하여 동작 확인
```

---

## 📚 참고 자료

### 공식 문서
- [Tailwind CSS v4](https://tailwindcss.com/docs)
- [shadcn/ui 컴포넌트](https://ui.shadcn.com)
- [Next.js 16 App Router](https://nextjs.org/docs)
- [React 19](https://react.dev)

### 설치된 라이브러리
- [React Hook Form](https://react-hook-form.com)
- [Zod 유효성 검증](https://zod.dev)
- [Sonner Toast](https://sonner.emilkowal.ski)
- [next-themes](https://github.com/pacocoursey/next-themes)
- [lucide-react 아이콘](https://lucide.dev)

### 프로젝트 설정 파일
- `tsconfig.json` - TypeScript 경로 별칭 (`@/*`)
- `.eslintrc.json` - Next.js ESLint 설정
- `tailwind.config.ts` - Tailwind v4 설정
- `next.config.ts` - Next.js 설정

---

**마지막 업데이트**: 2026-08-09  
**다음 예정**: Phase 2 권장 컴포넌트 설치 및 Composite 컴포넌트 구현
