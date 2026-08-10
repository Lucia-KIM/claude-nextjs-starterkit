export default function About() {
  return (
    <main className="flex flex-col items-center justify-center min-h-screen px-4 py-12">
      <div className="max-w-2xl">
        <h1 className="text-4xl font-bold mb-4">소개</h1>
        <p className="text-lg text-muted-foreground mb-6">
          Next Kit은 최신 기술 스택으로 구성된 완전한 Next.js 프로젝트 템플릿입니다.
        </p>
        <div className="space-y-4">
          <p className="text-base leading-relaxed">
            Next.js 16, TypeScript, Tailwind CSS v4, shadcn/ui를 포함하여
            즉시 개발을 시작할 수 있도록 구성되어 있습니다.
          </p>
        </div>
      </div>
    </main>
  );
}
