; ModuleID = 'harris_non_max0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @harris_non_max(i32 %img_height, i32 %img_width, i8 zeroext %spm_part) #0 {
entry:
  %cmp = icmp eq i8 %spm_part, 1
  %. = select i1 %cmp, i8* inttoptr (i64 637665312 to i8*), i8* inttoptr (i64 637599776 to i8*)
  %cmp215 = icmp eq i32 %img_height, 0
  br i1 %cmp215, label %for.end77, label %for.cond4.preheader.lr.ph

for.cond4.preheader.lr.ph:                        ; preds = %entry
  %cmp513 = icmp eq i32 %img_width, 0
  %0 = zext i32 %img_width to i64
  %1 = zext i32 %img_height to i64
  br label %for.cond4.preheader

for.cond4.preheader:                              ; preds = %for.cond4.preheader.lr.ph, %for.inc75
  %indvars.iv35 = phi i64 [ 0, %for.cond4.preheader.lr.ph ], [ %indvars.iv.next36, %for.inc75 ]
  br i1 %cmp513, label %for.inc75, label %for.cond8.preheader.preheader

for.cond8.preheader.preheader:                    ; preds = %for.cond4.preheader
  %2 = trunc i64 %indvars.iv35 to i32
  %cmp45 = icmp ult i32 %2, %img_height
  %3 = trunc i64 %indvars.iv35 to i32
  %mul51 = shl i32 %3, 7
  %4 = sext i32 %mul51 to i64
  %5 = add nuw nsw i64 %indvars.iv35, 1
  %6 = trunc i64 %5 to i32
  %cmp45.1 = icmp ult i32 %6, %img_height
  %7 = trunc i64 %5 to i32
  %mul51.1 = shl i32 %7, 7
  %8 = sext i32 %mul51.1 to i64
  %9 = add nuw nsw i64 %indvars.iv35, 2
  %10 = trunc i64 %9 to i32
  %cmp45.2 = icmp ult i32 %10, %img_height
  %11 = trunc i64 %9 to i32
  %mul51.2 = shl i32 %11, 7
  %12 = sext i32 %mul51.2 to i64
  br label %for.cond8.preheader

for.cond8.preheader:                              ; preds = %for.cond8.preheader.preheader, %for.inc66.2.2
  %indvars.iv33 = phi i64 [ %indvars.iv.next34, %for.inc66.2.2 ], [ 0, %for.cond8.preheader.preheader ]
  br label %for.cond12.preheader

for.cond12.preheader:                             ; preds = %for.inc28, %for.cond8.preheader
  %indvars.iv20 = phi i64 [ 0, %for.cond8.preheader ], [ %indvars.iv.next21, %for.inc28 ]
  %max_i.09 = phi i32 [ -1, %for.cond8.preheader ], [ %max_i.3.lcssa, %for.inc28 ]
  %max_j.08 = phi i32 [ -1, %for.cond8.preheader ], [ %max_j.3.lcssa, %for.inc28 ]
  %max_value.07 = phi float [ -1.000000e+00, %for.cond8.preheader ], [ %max_value.3.lcssa, %for.inc28 ]
  %13 = add nuw nsw i64 %indvars.iv20, %indvars.iv35
  %14 = trunc i64 %13 to i32
  %cmp17 = icmp ult i32 %14, %img_height
  %15 = trunc i64 %13 to i32
  %mul = shl i32 %15, 7
  %16 = sext i32 %mul to i64
  %17 = trunc i64 %indvars.iv20 to i32
  br label %for.body15

for.body15:                                       ; preds = %for.inc, %for.cond12.preheader
  %indvars.iv = phi i64 [ 0, %for.cond12.preheader ], [ %indvars.iv.next, %for.inc ]
  %max_i.15 = phi i32 [ %max_i.09, %for.cond12.preheader ], [ %max_i.3, %for.inc ]
  %max_j.14 = phi i32 [ %max_j.08, %for.cond12.preheader ], [ %max_j.3, %for.inc ]
  %max_value.13 = phi float [ %max_value.07, %for.cond12.preheader ], [ %max_value.3, %for.inc ]
  %18 = add nuw nsw i64 %indvars.iv, %indvars.iv33
  %19 = trunc i64 %18 to i32
  %cmp19 = icmp ult i32 %19, %img_width
  %or.cond = and i1 %cmp17, %cmp19
  br i1 %or.cond, label %if.then21, label %for.inc

if.then21:                                        ; preds = %for.body15
  %20 = add nsw i64 %18, %16
  %arrayidx = getelementptr inbounds float, float* inttoptr (i64 637534240 to float*), i64 %20
  %21 = load float, float* %arrayidx, align 4
  %cmp23 = fcmp ogt float %21, %max_value.13
  %max_value.2 = select i1 %cmp23, float %21, float %max_value.13
  %22 = trunc i64 %indvars.iv to i32
  %max_j.2 = select i1 %cmp23, i32 %22, i32 %max_j.14
  %max_i.2 = select i1 %cmp23, i32 %17, i32 %max_i.15
  br label %for.inc

for.inc:                                          ; preds = %for.body15, %if.then21
  %max_value.3 = phi float [ %max_value.13, %for.body15 ], [ %max_value.2, %if.then21 ]
  %max_j.3 = phi i32 [ %max_j.14, %for.body15 ], [ %max_j.2, %if.then21 ]
  %max_i.3 = phi i32 [ %max_i.15, %for.body15 ], [ %max_i.2, %if.then21 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 3
  br i1 %exitcond, label %for.inc28, label %for.body15, !llvm.loop !1

for.inc28:                                        ; preds = %for.inc
  %max_i.3.lcssa = phi i32 [ %max_i.3, %for.inc ]
  %max_j.3.lcssa = phi i32 [ %max_j.3, %for.inc ]
  %max_value.3.lcssa = phi float [ %max_value.3, %for.inc ]
  %indvars.iv.next21 = add nuw nsw i64 %indvars.iv20, 1
  %exitcond23 = icmp eq i64 %indvars.iv.next21, 3
  br i1 %exitcond23, label %for.body40, label %for.cond12.preheader, !llvm.loop !3

for.body40:                                       ; preds = %for.inc28
  %max_i.3.lcssa.lcssa = phi i32 [ %max_i.3.lcssa, %for.inc28 ]
  %max_j.3.lcssa.lcssa = phi i32 [ %max_j.3.lcssa, %for.inc28 ]
  %cmp53 = icmp eq i32 %max_i.3.lcssa.lcssa, 0
  %23 = trunc i64 %indvars.iv33 to i32
  %cmp48 = icmp ult i32 %23, %img_width
  %or.cond1 = and i1 %cmp45, %cmp48
  br i1 %or.cond1, label %if.then50, label %for.inc66

if.then50:                                        ; preds = %for.body40
  %24 = add nsw i64 %indvars.iv33, %4
  %25 = or i32 %max_i.3.lcssa.lcssa, %max_j.3.lcssa.lcssa
  %26 = icmp eq i32 %25, 0
  %arrayidx60 = getelementptr inbounds i8, i8* %., i64 %24
  br i1 %26, label %if.then58, label %if.else61

if.then58:                                        ; preds = %if.then50
  store i8 -1, i8* %arrayidx60, align 1
  br label %for.inc66

if.else61:                                        ; preds = %if.then50
  store i8 0, i8* %arrayidx60, align 1
  br label %for.inc66

for.inc66:                                        ; preds = %for.body40, %if.else61, %if.then58
  %27 = add nuw nsw i64 %indvars.iv33, 1
  %28 = trunc i64 %27 to i32
  %cmp48.1 = icmp ult i32 %28, %img_width
  %or.cond1.1 = and i1 %cmp45, %cmp48.1
  br i1 %or.cond1.1, label %if.then50.1, label %for.inc66.1

for.inc75.loopexit:                               ; preds = %for.inc66.2.2
  br label %for.inc75

for.inc75:                                        ; preds = %for.inc75.loopexit, %for.cond4.preheader
  %indvars.iv.next36 = add nuw nsw i64 %indvars.iv35, 3
  %cmp2 = icmp ult i64 %indvars.iv.next36, %1
  br i1 %cmp2, label %for.cond4.preheader, label %for.end77.loopexit, !llvm.loop !4

for.end77.loopexit:                               ; preds = %for.inc75
  br label %for.end77

for.end77:                                        ; preds = %for.end77.loopexit, %entry
  ret void

if.then50.1:                                      ; preds = %for.inc66
  %29 = add nsw i64 %27, %4
  %cmp56.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1 = and i1 %cmp53, %cmp56.1
  %arrayidx60.1 = getelementptr inbounds i8, i8* %., i64 %29
  br i1 %or.cond2.1, label %if.then58.1, label %if.else61.1

if.else61.1:                                      ; preds = %if.then50.1
  store i8 0, i8* %arrayidx60.1, align 1
  br label %for.inc66.1

if.then58.1:                                      ; preds = %if.then50.1
  store i8 -1, i8* %arrayidx60.1, align 1
  br label %for.inc66.1

for.inc66.1:                                      ; preds = %if.then58.1, %if.else61.1, %for.inc66
  %30 = add nuw nsw i64 %indvars.iv33, 2
  %31 = trunc i64 %30 to i32
  %cmp48.2 = icmp ult i32 %31, %img_width
  %or.cond1.2 = and i1 %cmp45, %cmp48.2
  br i1 %or.cond1.2, label %if.then50.2, label %for.body40.1

if.then50.2:                                      ; preds = %for.inc66.1
  %32 = add nsw i64 %30, %4
  %cmp56.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2 = and i1 %cmp53, %cmp56.2
  %arrayidx60.2 = getelementptr inbounds i8, i8* %., i64 %32
  br i1 %or.cond2.2, label %if.then58.2, label %if.else61.2

if.else61.2:                                      ; preds = %if.then50.2
  store i8 0, i8* %arrayidx60.2, align 1
  br label %for.body40.1

if.then58.2:                                      ; preds = %if.then50.2
  store i8 -1, i8* %arrayidx60.2, align 1
  br label %for.body40.1

for.body40.1:                                     ; preds = %for.inc66.1, %if.else61.2, %if.then58.2
  %cmp53.1 = icmp eq i32 %max_i.3.lcssa.lcssa, 1
  %33 = trunc i64 %indvars.iv33 to i32
  %cmp48.137 = icmp ult i32 %33, %img_width
  %or.cond1.138 = and i1 %cmp45.1, %cmp48.137
  br i1 %or.cond1.138, label %if.then50.142, label %for.inc66.145

if.then50.142:                                    ; preds = %for.body40.1
  %34 = add nsw i64 %indvars.iv33, %8
  %cmp56.139 = icmp eq i32 %max_j.3.lcssa.lcssa, 0
  %or.cond2.140 = and i1 %cmp53.1, %cmp56.139
  %arrayidx60.141 = getelementptr inbounds i8, i8* %., i64 %34
  br i1 %or.cond2.140, label %if.then58.144, label %if.else61.143

if.else61.143:                                    ; preds = %if.then50.142
  store i8 0, i8* %arrayidx60.141, align 1
  br label %for.inc66.145

if.then58.144:                                    ; preds = %if.then50.142
  store i8 -1, i8* %arrayidx60.141, align 1
  br label %for.inc66.145

for.inc66.145:                                    ; preds = %if.then58.144, %if.else61.143, %for.body40.1
  %35 = add nuw nsw i64 %indvars.iv33, 1
  %36 = trunc i64 %35 to i32
  %cmp48.1.1 = icmp ult i32 %36, %img_width
  %or.cond1.1.1 = and i1 %cmp45.1, %cmp48.1.1
  br i1 %or.cond1.1.1, label %if.then50.1.1, label %for.inc66.1.1

if.then50.1.1:                                    ; preds = %for.inc66.145
  %37 = add nsw i64 %35, %8
  %cmp56.1.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1.1 = and i1 %cmp53.1, %cmp56.1.1
  %arrayidx60.1.1 = getelementptr inbounds i8, i8* %., i64 %37
  br i1 %or.cond2.1.1, label %if.then58.1.1, label %if.else61.1.1

if.else61.1.1:                                    ; preds = %if.then50.1.1
  store i8 0, i8* %arrayidx60.1.1, align 1
  br label %for.inc66.1.1

if.then58.1.1:                                    ; preds = %if.then50.1.1
  store i8 -1, i8* %arrayidx60.1.1, align 1
  br label %for.inc66.1.1

for.inc66.1.1:                                    ; preds = %if.then58.1.1, %if.else61.1.1, %for.inc66.145
  %38 = add nuw nsw i64 %indvars.iv33, 2
  %39 = trunc i64 %38 to i32
  %cmp48.2.1 = icmp ult i32 %39, %img_width
  %or.cond1.2.1 = and i1 %cmp45.1, %cmp48.2.1
  br i1 %or.cond1.2.1, label %if.then50.2.1, label %for.body40.2

if.then50.2.1:                                    ; preds = %for.inc66.1.1
  %40 = add nsw i64 %38, %8
  %cmp56.2.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2.1 = and i1 %cmp53.1, %cmp56.2.1
  %arrayidx60.2.1 = getelementptr inbounds i8, i8* %., i64 %40
  br i1 %or.cond2.2.1, label %if.then58.2.1, label %if.else61.2.1

if.else61.2.1:                                    ; preds = %if.then50.2.1
  store i8 0, i8* %arrayidx60.2.1, align 1
  br label %for.body40.2

if.then58.2.1:                                    ; preds = %if.then50.2.1
  store i8 -1, i8* %arrayidx60.2.1, align 1
  br label %for.body40.2

for.body40.2:                                     ; preds = %for.inc66.1.1, %if.else61.2.1, %if.then58.2.1
  %cmp53.2 = icmp eq i32 %max_i.3.lcssa.lcssa, 2
  %41 = trunc i64 %indvars.iv33 to i32
  %cmp48.246 = icmp ult i32 %41, %img_width
  %or.cond1.247 = and i1 %cmp45.2, %cmp48.246
  br i1 %or.cond1.247, label %if.then50.251, label %for.inc66.254

if.then50.251:                                    ; preds = %for.body40.2
  %42 = add nsw i64 %indvars.iv33, %12
  %cmp56.248 = icmp eq i32 %max_j.3.lcssa.lcssa, 0
  %or.cond2.249 = and i1 %cmp53.2, %cmp56.248
  %arrayidx60.250 = getelementptr inbounds i8, i8* %., i64 %42
  br i1 %or.cond2.249, label %if.then58.253, label %if.else61.252

if.else61.252:                                    ; preds = %if.then50.251
  store i8 0, i8* %arrayidx60.250, align 1
  br label %for.inc66.254

if.then58.253:                                    ; preds = %if.then50.251
  store i8 -1, i8* %arrayidx60.250, align 1
  br label %for.inc66.254

for.inc66.254:                                    ; preds = %if.then58.253, %if.else61.252, %for.body40.2
  %43 = add nuw nsw i64 %indvars.iv33, 1
  %44 = trunc i64 %43 to i32
  %cmp48.1.2 = icmp ult i32 %44, %img_width
  %or.cond1.1.2 = and i1 %cmp45.2, %cmp48.1.2
  br i1 %or.cond1.1.2, label %if.then50.1.2, label %for.inc66.1.2

if.then50.1.2:                                    ; preds = %for.inc66.254
  %45 = add nsw i64 %43, %12
  %cmp56.1.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1.2 = and i1 %cmp53.2, %cmp56.1.2
  %arrayidx60.1.2 = getelementptr inbounds i8, i8* %., i64 %45
  br i1 %or.cond2.1.2, label %if.then58.1.2, label %if.else61.1.2

if.else61.1.2:                                    ; preds = %if.then50.1.2
  store i8 0, i8* %arrayidx60.1.2, align 1
  br label %for.inc66.1.2

if.then58.1.2:                                    ; preds = %if.then50.1.2
  store i8 -1, i8* %arrayidx60.1.2, align 1
  br label %for.inc66.1.2

for.inc66.1.2:                                    ; preds = %if.then58.1.2, %if.else61.1.2, %for.inc66.254
  %46 = add nuw nsw i64 %indvars.iv33, 2
  %47 = trunc i64 %46 to i32
  %cmp48.2.2 = icmp ult i32 %47, %img_width
  %or.cond1.2.2 = and i1 %cmp45.2, %cmp48.2.2
  br i1 %or.cond1.2.2, label %if.then50.2.2, label %for.inc66.2.2

if.then50.2.2:                                    ; preds = %for.inc66.1.2
  %48 = add nsw i64 %46, %12
  %cmp56.2.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2.2 = and i1 %cmp53.2, %cmp56.2.2
  %arrayidx60.2.2 = getelementptr inbounds i8, i8* %., i64 %48
  br i1 %or.cond2.2.2, label %if.then58.2.2, label %if.else61.2.2

if.else61.2.2:                                    ; preds = %if.then50.2.2
  store i8 0, i8* %arrayidx60.2.2, align 1
  br label %for.inc66.2.2

if.then58.2.2:                                    ; preds = %if.then50.2.2
  store i8 -1, i8* %arrayidx60.2.2, align 1
  br label %for.inc66.2.2

for.inc66.2.2:                                    ; preds = %if.then58.2.2, %if.else61.2.2, %for.inc66.1.2
  %indvars.iv.next34 = add nuw nsw i64 %indvars.iv33, 3
  %cmp5 = icmp ult i64 %indvars.iv.next34, %0
  br i1 %cmp5, label %for.cond8.preheader, label %for.inc75.loopexit, !llvm.loop !5
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !2}
