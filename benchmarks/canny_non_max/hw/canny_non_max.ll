; ModuleID = 'canny_non_max.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @canny_non_max(i32 %img_height, i32 %img_width) #0 {
entry:
  %cmp13 = icmp eq i32 %img_height, 0
  br i1 %cmp13, label %for.end129, label %for.cond2.preheader.lr.ph

for.cond2.preheader.lr.ph:                        ; preds = %entry
  %sub1 = add i32 %img_width, -1
  %sub = add i32 %img_height, -1
  %cmp39 = icmp eq i32 %img_width, 0
  %0 = zext i32 %sub1 to i64
  %1 = zext i32 %sub to i64
  br label %for.cond2.preheader

for.cond2.preheader:                              ; preds = %for.inc127, %for.cond2.preheader.lr.ph
  %indvars.iv19 = phi i64 [ 0, %for.cond2.preheader.lr.ph ], [ %indvars.iv.next20, %for.inc127 ]
  br i1 %cmp39, label %for.inc127, label %for.body4.lr.ph

for.body4.lr.ph:                                  ; preds = %for.cond2.preheader
  %2 = trunc i64 %indvars.iv19 to i32
  %mul = shl nsw i32 %2, 6
  %cmp5 = icmp eq i64 %indvars.iv19, 0
  %cmp6 = icmp eq i64 %indvars.iv19, %1
  %or.cond = or i1 %cmp5, %cmp6
  %add33 = or i32 %mul, 1
  %sub38 = add i32 %mul, -1
  %3 = trunc i64 %indvars.iv19 to i32
  %add51 = shl i32 %3, 6
  %4 = trunc i64 %indvars.iv19 to i32
  %add72 = shl i32 %4, 6
  %mul73 = add i32 %add72, 64
  %mul78 = add i32 %add72, -64
  %5 = trunc i64 %indvars.iv19 to i32
  %sub91 = shl i32 %5, 6
  %6 = sext i32 %mul to i64
  %7 = sext i32 %mul78 to i64
  %8 = sext i32 %mul73 to i64
  br label %for.body4

for.body4:                                        ; preds = %for.inc, %for.body4.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body4.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %9 = add nsw i64 %indvars.iv, %6
  %cmp8 = icmp eq i64 %indvars.iv, 0
  %or.cond1 = or i1 %or.cond, %cmp8
  %cmp10 = icmp eq i64 %indvars.iv, %0
  %or.cond2 = or i1 %cmp10, %or.cond1
  br i1 %or.cond2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body4
  %arrayidx = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %9
  store i32 0, i32* %arrayidx, align 4
  br label %for.inc

if.else:                                          ; preds = %for.body4
  %arrayidx12 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %9
  %10 = load float, float* %arrayidx12, align 4
  %conv = fpext float %10 to double
  %mul13 = fmul double %conv, 0x404CA5DC1A63C1F8
  %conv14 = fptrunc double %mul13 to float
  %cmp15 = fcmp olt float %conv14, 0.000000e+00
  %add18 = fadd float %conv14, 1.800000e+02
  %angle.0 = select i1 %cmp15, float %add18, float %conv14
  %cmp19 = fcmp oge float %angle.0, 0.000000e+00
  %cmp22 = fcmp olt float %angle.0, 2.250000e+01
  %or.cond3 = and i1 %cmp19, %cmp22
  br i1 %or.cond3, label %if.then31, label %lor.lhs.false24

lor.lhs.false24:                                  ; preds = %if.else
  %cmp26 = fcmp ult float %angle.0, 1.575000e+02
  %cmp29 = fcmp ugt float %angle.0, 1.800000e+02
  %or.cond4 = or i1 %cmp26, %cmp29
  br i1 %or.cond4, label %if.else42, label %if.then31

if.then31:                                        ; preds = %lor.lhs.false24, %if.else
  %11 = trunc i64 %indvars.iv to i32
  %add34 = add i32 %add33, %11
  %idxprom35 = sext i32 %add34 to i64
  %arrayidx36 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35
  %12 = load float, float* %arrayidx36, align 4
  %13 = trunc i64 %indvars.iv to i32
  %add39 = add i32 %sub38, %13
  %idxprom40 = sext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40
  %14 = load float, float* %arrayidx41, align 4
  br label %if.end106

if.else42:                                        ; preds = %lor.lhs.false24
  %cmp44 = fcmp oge float %angle.0, 2.250000e+01
  %cmp48 = fcmp olt float %angle.0, 6.750000e+01
  %or.cond5 = and i1 %cmp44, %cmp48
  br i1 %or.cond5, label %if.then50, label %if.else63

if.then50:                                        ; preds = %if.else42
  %15 = trunc i64 %indvars.iv to i32
  %sub53 = add i32 %15, %add51
  %add54 = add i32 %sub53, 63
  %idxprom55 = sext i32 %add54 to i64
  %arrayidx56 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55
  %16 = load float, float* %arrayidx56, align 4
  %add60 = add i32 %sub53, -63
  %idxprom61 = sext i32 %add60 to i64
  %arrayidx62 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61
  %17 = load float, float* %arrayidx62, align 4
  br label %if.end106

if.else63:                                        ; preds = %if.else42
  %cmp65 = fcmp oge float %angle.0, 6.750000e+01
  %cmp69 = fcmp olt float %angle.0, 1.125000e+02
  %or.cond6 = and i1 %cmp65, %cmp69
  br i1 %or.cond6, label %if.then71, label %if.else82

if.then71:                                        ; preds = %if.else63
  %18 = add nsw i64 %8, %indvars.iv
  %arrayidx76 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %18
  %19 = load float, float* %arrayidx76, align 4
  %20 = add nsw i64 %7, %indvars.iv
  %arrayidx81 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %20
  %21 = load float, float* %arrayidx81, align 4
  br label %if.end106

if.else82:                                        ; preds = %if.else63
  %cmp84 = fcmp oge float %angle.0, 1.125000e+02
  %cmp88 = fcmp olt float %angle.0, 1.575000e+02
  %or.cond7 = and i1 %cmp84, %cmp88
  br i1 %or.cond7, label %if.then90, label %if.end106

if.then90:                                        ; preds = %if.else82
  %22 = trunc i64 %indvars.iv to i32
  %sub93 = add i32 %22, %sub91
  %add94 = add i32 %sub93, -65
  %idxprom95 = sext i32 %add94 to i64
  %arrayidx96 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95
  %23 = load float, float* %arrayidx96, align 4
  %add100 = add i32 %sub93, 65
  %idxprom101 = sext i32 %add100 to i64
  %arrayidx102 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101
  %24 = load float, float* %arrayidx102, align 4
  br label %if.end106

if.end106:                                        ; preds = %if.then50, %if.then90, %if.else82, %if.then71, %if.then31
  %q.3 = phi float [ %12, %if.then31 ], [ %16, %if.then50 ], [ %19, %if.then71 ], [ %23, %if.then90 ], [ 2.550000e+02, %if.else82 ]
  %r.3 = phi float [ %14, %if.then31 ], [ %17, %if.then50 ], [ %21, %if.then71 ], [ %24, %if.then90 ], [ 2.550000e+02, %if.else82 ]
  %arrayidx108 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %9
  %25 = load float, float* %arrayidx108, align 4
  %cmp109 = fcmp ult float %25, %q.3
  %cmp114 = fcmp ult float %25, %r.3
  %or.cond8 = or i1 %cmp109, %cmp114
  br i1 %or.cond8, label %if.else122, label %if.then116

if.then116:                                       ; preds = %if.end106
  %conv119 = fptoui float %25 to i32
  %arrayidx121 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %9
  store i32 %conv119, i32* %arrayidx121, align 4
  br label %for.inc

if.else122:                                       ; preds = %if.end106
  %arrayidx124 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %9
  store i32 0, i32* %arrayidx124, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else122, %if.then116
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %img_width
  br i1 %exitcond, label %for.inc127.loopexit, label %for.body4, !llvm.loop !1

for.inc127.loopexit:                              ; preds = %for.inc
  br label %for.inc127

for.inc127:                                       ; preds = %for.inc127.loopexit, %for.cond2.preheader
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  %lftr.wideiv21 = trunc i64 %indvars.iv.next20 to i32
  %exitcond22 = icmp eq i32 %lftr.wideiv21, %img_height
  br i1 %exitcond22, label %for.end129.loopexit, label %for.cond2.preheader, !llvm.loop !3

for.end129.loopexit:                              ; preds = %for.inc127
  br label %for.end129

for.end129:                                       ; preds = %for.end129.loopexit, %entry
  ret void
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
