; ModuleID = 'top.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @top(i64 %num_elems, i64 %input_addr, i64 %output_addr) #0 {
entry:
  store volatile i64 2160066560, i64* inttoptr (i64 537919521 to i64*), align 8
  store volatile i64 537923600, i64* inttoptr (i64 537919529 to i64*), align 8
  store volatile i32 4096, i32* inttoptr (i64 537919537 to i32*), align 4
  store volatile i8 1, i8* inttoptr (i64 537919520 to i8*), align 32
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %0 = load volatile i8, i8* inttoptr (i64 537919520 to i8*), align 32
  %and = and i8 %0, 4
  %cmp = icmp eq i8 %and, 0
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  store volatile i32 4096, i32* inttoptr (i64 537923585 to i32*), align 4
  store volatile i8 1, i8* inttoptr (i64 537923584 to i8*), align 4096
  br label %while.cond4

while.cond4:                                      ; preds = %while.cond4, %while.end
  %1 = load volatile i8, i8* inttoptr (i64 537923584 to i8*), align 4096
  %and6 = and i8 %1, 4
  %cmp7 = icmp eq i8 %and6, 0
  br i1 %cmp7, label %while.cond4, label %while.end10

while.end10:                                      ; preds = %while.cond4
  store volatile i64 537927696, i64* inttoptr (i64 537919521 to i64*), align 8
  store volatile i64 2160070656, i64* inttoptr (i64 537919529 to i64*), align 8
  store volatile i32 16384, i32* inttoptr (i64 537919537 to i32*), align 4
  store volatile i8 1, i8* inttoptr (i64 537919520 to i8*), align 32
  br label %while.cond12

while.cond12:                                     ; preds = %while.cond12, %while.end10
  %2 = load volatile i8, i8* inttoptr (i64 537919520 to i8*), align 32
  %and14 = and i8 %2, 4
  %cmp15 = icmp eq i8 %and14, 0
  br i1 %cmp15, label %while.cond12, label %while.end18

while.end18:                                      ; preds = %while.cond12
  ret void
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
