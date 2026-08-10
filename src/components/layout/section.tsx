import { cn } from "@/lib/utils";

interface SectionProps {
  children: React.ReactNode;
  className?: string;
  variant?: "default" | "accent" | "muted";
}

export function Section({ children, className, variant = "default" }: SectionProps) {
  return (
    <section
      className={cn(
        "py-12 sm:py-16 lg:py-20",
        {
          "bg-background": variant === "default",
          "bg-accent": variant === "accent",
          "bg-muted": variant === "muted",
        },
        className
      )}
    >
      {children}
    </section>
  );
}
