"use client";

import Link from "next/link";
import { useState } from "react";
import { Menu, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { ThemeToggle } from "@/components/theme-toggle";

export function Header() {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  const toggleMobileMenu = () => {
    setIsMobileMenuOpen(!isMobileMenuOpen);
  };

  return (
    <header className="sticky top-0 z-50 border-b border-border bg-background/95 backdrop-blur">
      <div className="flex h-16 items-center justify-between px-4 sm:px-6 lg:px-8">
        {/* 로고 */}
        <Link href="/" className="flex items-center gap-2">
          <div className="h-8 w-8 rounded-lg bg-primary flex items-center justify-center">
            <span className="text-sm font-bold text-primary-foreground">NK</span>
          </div>
          <span className="hidden sm:inline font-semibold">Next Kit</span>
        </Link>

        {/* 데스크톱 네비게이션 */}
        <nav className="hidden md:flex items-center gap-8">
          <Link
            href="/about"
            className="text-sm font-medium transition-colors hover:text-primary"
          >
            소개
          </Link>
          <Link
            href="/docs"
            className="text-sm font-medium transition-colors hover:text-primary"
          >
            문서
          </Link>
          <Link
            href="/blog"
            className="text-sm font-medium transition-colors hover:text-primary"
          >
            블로그
          </Link>
        </nav>

        {/* 우측 액션 */}
        <div className="flex items-center gap-4">
          <ThemeToggle />

          {/* 모바일 메뉴 토글 */}
          <button
            onClick={toggleMobileMenu}
            className="md:hidden inline-flex items-center justify-center p-2 rounded-md hover:bg-accent"
            aria-label="메뉴 토글"
          >
            {isMobileMenuOpen ? (
              <X className="h-5 w-5" />
            ) : (
              <Menu className="h-5 w-5" />
            )}
          </button>
        </div>
      </div>

      {/* 모바일 네비게이션 */}
      {isMobileMenuOpen && (
        <nav className="md:hidden border-t border-border bg-card">
          <div className="flex flex-col gap-2 px-4 py-4">
            <Link
              href="/about"
              className="px-4 py-2 text-sm font-medium rounded-md hover:bg-accent transition-colors"
            >
              소개
            </Link>
            <Link
              href="/docs"
              className="px-4 py-2 text-sm font-medium rounded-md hover:bg-accent transition-colors"
            >
              문서
            </Link>
            <Link
              href="/blog"
              className="px-4 py-2 text-sm font-medium rounded-md hover:bg-accent transition-colors"
            >
              블로그
            </Link>
          </div>
        </nav>
      )}
    </header>
  );
}
