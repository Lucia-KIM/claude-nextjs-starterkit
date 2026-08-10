export default function Blog() {
  return (
    <main className="flex flex-col items-center justify-center min-h-screen px-4 py-12">
      <div className="max-w-2xl">
        <h1 className="text-4xl font-bold mb-4">블로그</h1>
        <p className="text-lg text-muted-foreground mb-6">
          Next Kit 개발 과정과 기술 이야기를 공유합니다.
        </p>
        <div className="space-y-4">
          <p className="text-base leading-relaxed">
            최신 웹 개발 기술, 성능 최적화, 모범 사례 등 다양한 주제의
            글들을 게시할 예정입니다.
          </p>
        </div>
      </div>
    </main>
  );
}
