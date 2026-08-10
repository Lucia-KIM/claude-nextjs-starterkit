export default function Docs() {
  return (
    <main className="flex flex-col items-center justify-center min-h-screen px-4 py-12">
      <div className="max-w-2xl">
        <h1 className="text-4xl font-bold mb-4">문서</h1>
        <p className="text-lg text-muted-foreground mb-6">
          Next Kit 개발 가이드 및 API 문서입니다.
        </p>
        <div className="space-y-4">
          <p className="text-base leading-relaxed">
            프로젝트 구조, 컴포넌트 사용법, 스타일링 가이드 등을 확인할 수 있습니다.
          </p>
        </div>
      </div>
    </main>
  );
}
