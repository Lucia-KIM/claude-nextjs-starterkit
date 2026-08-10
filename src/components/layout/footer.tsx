import Link from "next/link";
import { Mail, Share2, MessageCircle } from "lucide-react";

export function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="border-t border-border bg-card mt-auto">
      <div className="px-4 py-12 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 gap-8 md:grid-cols-4">
          {/* 브랜드 섹션 */}
          <div>
            <h3 className="flex items-center gap-2 font-semibold mb-4">
              <div className="h-6 w-6 rounded-lg bg-primary flex items-center justify-center">
                <span className="text-xs font-bold text-primary-foreground">NK</span>
              </div>
              <span>Next Kit</span>
            </h3>
            <p className="text-sm text-muted-foreground">
              웹 개발을 빠르게 시작할 수 있는 현대적인 Next.js 스타터킷
            </p>
          </div>

          {/* 제품 링크 */}
          <div>
            <h4 className="font-semibold text-sm mb-4">제품</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="#" className="text-muted-foreground hover:text-primary transition-colors">
                  기능
                </Link>
              </li>
              <li>
                <Link href="#" className="text-muted-foreground hover:text-primary transition-colors">
                  가격
                </Link>
              </li>
              <li>
                <Link href="#" className="text-muted-foreground hover:text-primary transition-colors">
                  FAQ
                </Link>
              </li>
            </ul>
          </div>

          {/* 리소스 링크 */}
          <div>
            <h4 className="font-semibold text-sm mb-4">리소스</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/docs" className="text-muted-foreground hover:text-primary transition-colors">
                  문서
                </Link>
              </li>
              <li>
                <Link href="/blog" className="text-muted-foreground hover:text-primary transition-colors">
                  블로그
                </Link>
              </li>
              <li>
                <Link href="#" className="text-muted-foreground hover:text-primary transition-colors">
                  커뮤니티
                </Link>
              </li>
            </ul>
          </div>

          {/* 법적 링크 */}
          <div>
            <h4 className="font-semibold text-sm mb-4">법적</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="#" className="text-muted-foreground hover:text-primary transition-colors">
                  개인정보 보호
                </Link>
              </li>
              <li>
                <Link href="#" className="text-muted-foreground hover:text-primary transition-colors">
                  이용약관
                </Link>
              </li>
              <li>
                <Link href="#" className="text-muted-foreground hover:text-primary transition-colors">
                  라이선스
                </Link>
              </li>
            </ul>
          </div>
        </div>

        {/* 하단 섹션 */}
        <div className="border-t border-border mt-8 pt-8 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-sm text-muted-foreground">
            © {currentYear} Next Kit. 모든 권리 보유.
          </p>

          {/* 소셜 링크 */}
          <div className="flex items-center gap-4">
            <Link
              href="#"
              className="inline-flex items-center justify-center p-2 rounded-md hover:bg-accent transition-colors"
              aria-label="Email"
            >
              <Mail className="h-4 w-4" />
            </Link>
            <Link
              href="#"
              className="inline-flex items-center justify-center p-2 rounded-md hover:bg-accent transition-colors"
              aria-label="Share"
            >
              <Share2 className="h-4 w-4" />
            </Link>
            <Link
              href="#"
              className="inline-flex items-center justify-center p-2 rounded-md hover:bg-accent transition-colors"
              aria-label="Contact"
            >
              <MessageCircle className="h-4 w-4" />
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
