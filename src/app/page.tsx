import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { MainContainer } from "@/components/layout/main-container";
import { Section } from "@/components/layout/section";
import { GitBranch, Zap, Layers, Palette } from "lucide-react";

export default function Home() {
  return (
    <>
      {/* Hero Section */}
      <Section variant="default">
        <MainContainer>
          <div className="mb-16 text-center">
            <h1 className="text-4xl md:text-5xl font-bold tracking-tight mb-4">
              웹 개발을 빠르게 시작하세요
            </h1>
            <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
              최신 Next.js 16, TypeScript, Tailwind CSS v4, shadcn/ui가 미리 구성된
              완전한 starter kit으로 프로젝트를 즉시 시작할 수 있습니다.
            </p>
            <div className="flex gap-4 justify-center flex-wrap">
              <Button size="lg" className="gap-2">
                <GitBranch className="w-4 h-4" />
                GitHub에서 보기
              </Button>
              <Button size="lg" variant="outline">
                문서 읽기
              </Button>
            </div>
          </div>
        </MainContainer>
      </Section>

      {/* Features Section */}
      <Section variant="default">
        <MainContainer>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="pb-3">
              <Zap className="w-6 h-6 text-primary mb-2" />
              <CardTitle className="text-lg">빠른 성능</CardTitle>
            </CardHeader>
            <CardContent>
              <CardDescription>
                Turbopack 기반 번들링으로 개발 서버가 매우 빠릅니다.
              </CardDescription>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-3">
              <Layers className="w-6 h-6 text-primary mb-2" />
              <CardTitle className="text-lg">완전한 구성</CardTitle>
            </CardHeader>
            <CardContent>
              <CardDescription>
                TypeScript, ESLint, Tailwind CSS가 이미 설정되어 있습니다.
              </CardDescription>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-3">
              <Palette className="w-6 h-6 text-primary mb-2" />
              <CardTitle className="text-lg">UI 컴포넌트</CardTitle>
            </CardHeader>
            <CardContent>
              <CardDescription>
                shadcn/ui로 접근성 높은 UI 컴포넌트를 즉시 사용할 수 있습니다.
              </CardDescription>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-3">
              <div className="w-6 h-6 text-primary mb-2">🌓</div>
              <CardTitle className="text-lg">다크모드</CardTitle>
            </CardHeader>
            <CardContent>
              <CardDescription>
                내장된 다크모드 토글로 라이트/다크 테마를 지원합니다.
              </CardDescription>
            </CardContent>
          </Card>
          </div>
        </MainContainer>
      </Section>

      {/* Component Examples Section */}
      <Section variant="default">
        <MainContainer>
          <h2 className="text-3xl font-bold mb-8">컴포넌트 예시</h2>
          <div className="grid md:grid-cols-2 gap-8">
            {/* Button Examples */}
            <Card>
              <CardHeader>
                <CardTitle>Button 컴포넌트</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex flex-wrap gap-2">
                  <Button>기본 버튼</Button>
                  <Button variant="secondary">Secondary</Button>
                  <Button variant="outline">Outline</Button>
                  <Button variant="destructive">Delete</Button>
                  <Button variant="ghost">Ghost</Button>
                </div>
                <div className="flex flex-wrap gap-2">
                  <Button size="sm">Small</Button>
                  <Button>Default</Button>
                  <Button size="lg">Large</Button>
                </div>
              </CardContent>
            </Card>

            {/* Input Examples */}
            <Card>
              <CardHeader>
                <CardTitle>Form 컴포넌트</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="email">이메일</Label>
                  <Input id="email" placeholder="example@example.com" type="email" />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="message">메시지</Label>
                  <Input id="message" placeholder="메시지를 입력하세요" />
                </div>
                <Button className="w-full">전송</Button>
              </CardContent>
            </Card>
          </div>

          {/* Getting Started */}
          <Card className="bg-muted/50 mt-12">
            <CardHeader>
              <CardTitle>시작하기</CardTitle>
              <CardDescription>프로젝트 설정 및 다음 단계</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <h4 className="font-semibold mb-2">1️⃣ 프로젝트 구조</h4>
                <code className="block bg-background p-3 rounded text-sm overflow-x-auto">
                  {`src/
├── app/
│   ├── layout.tsx      # Root layout (ThemeProvider)
│   ├── page.tsx        # 홈페이지
│   └── globals.css     # 전역 스타일
├── components/
│   ├── ui/            # shadcn 컴포넌트
│   ├── layout/        # 레이아웃 컴포넌트
│   ├── feedback/      # 피드백 컴포넌트
│   ├── patterns/      # 페이지 패턴
│   ├── theme-provider.tsx
│   └── theme-toggle.tsx
└── lib/
    └── utils.ts        # cn() 헬퍼`}
                </code>
              </div>

              <div>
                <h4 className="font-semibold mb-2">2️⃣ 개발 서버 실행</h4>
                <code className="block bg-background p-3 rounded text-sm">
                  npm run dev
                </code>
              </div>

              <div>
                <h4 className="font-semibold mb-2">3️⃣ 컴포넌트 추가</h4>
                <code className="block bg-background p-3 rounded text-sm">
                  npx shadcn@latest add [component-name]
                </code>
              </div>

              <p className="text-sm text-muted-foreground">
                더 많은 shadcn/ui 컴포넌트는{" "}
                <a href="https://ui.shadcn.com" className="text-primary underline hover:no-underline">
                  ui.shadcn.com
                </a>
                에서 확인하세요.
              </p>
            </CardContent>
          </Card>
        </MainContainer>
      </Section>
    </>
  );
}
