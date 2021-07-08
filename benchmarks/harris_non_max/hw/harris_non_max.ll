; ModuleID = 'harris_non_max.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @harris_non_max(i32 %img_height, i32 %img_width) #0 {
entry:
  %cmp15 = icmp eq i32 %img_height, 0
  br i1 %cmp15, label %for.end59, label %for.cond1.preheader.lr.ph

for.cond1.preheader.lr.ph:                        ; preds = %entry
  %cmp213 = icmp eq i32 %img_width, 0
  %0 = zext i32 %img_width to i64
  %1 = zext i32 %img_height to i64
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond1.preheader.lr.ph, %for.inc57
  %indvars.iv35 = phi i64 [ 0, %for.cond1.preheader.lr.ph ], [ %indvars.iv.next36, %for.inc57 ]
  br i1 %cmp213, label %for.inc57, label %for.cond4.preheader.preheader

for.cond4.preheader.preheader:                    ; preds = %for.cond1.preheader
  %2 = trunc i64 %indvars.iv35 to i32
  %cmp32 = icmp ult i32 %2, %img_height
  %3 = trunc i64 %indvars.iv35 to i32
  %mul36 = shl i32 %3, 6
  %4 = sext i32 %mul36 to i64
  %5 = add nuw nsw i64 %indvars.iv35, 1
  %6 = trunc i64 %5 to i32
  %cmp32.1 = icmp ult i32 %6, %img_height
  %7 = trunc i64 %5 to i32
  %mul36.1 = shl i32 %7, 6
  %8 = sext i32 %mul36.1 to i64
  %9 = add nuw nsw i64 %indvars.iv35, 2
  %10 = trunc i64 %9 to i32
  %cmp32.2 = icmp ult i32 %10, %img_height
  %11 = trunc i64 %9 to i32
  %mul36.2 = shl i32 %11, 6
  %12 = sext i32 %mul36.2 to i64
  br label %for.cond4.preheader

for.cond4.preheader:                              ; preds = %for.cond4.preheader.preheader, %for.inc48.2.2
  %indvars.iv33 = phi i64 [ %indvars.iv.next34, %for.inc48.2.2 ], [ 0, %for.cond4.preheader.preheader ]
  br label %for.cond7.preheader

for.cond7.preheader:                              ; preds = %for.inc17, %for.cond4.preheader
  %indvars.iv20 = phi i64 [ 0, %for.cond4.preheader ], [ %indvars.iv.next21, %for.inc17 ]
  %max_value.09 = phi double [ -1.000000e+00, %for.cond4.preheader ], [ %max_value.3.lcssa, %for.inc17 ]
  %max_j.08 = phi i32 [ -1, %for.cond4.preheader ], [ %max_j.3.lcssa, %for.inc17 ]
  %max_i.07 = phi i32 [ -1, %for.cond4.preheader ], [ %max_i.3.lcssa, %for.inc17 ]
  %13 = add nuw nsw i64 %indvars.iv20, %indvars.iv35
  %14 = trunc i64 %13 to i32
  %cmp11 = icmp ult i32 %14, %img_height
  %15 = trunc i64 %13 to i32
  %mul = shl i32 %15, 6
  %16 = sext i32 %mul to i64
  %17 = trunc i64 %indvars.iv20 to i32
  br label %for.body9

for.body9:                                        ; preds = %for.inc, %for.cond7.preheader
  %indvars.iv = phi i64 [ 0, %for.cond7.preheader ], [ %indvars.iv.next, %for.inc ]
  %max_value.15 = phi double [ %max_value.09, %for.cond7.preheader ], [ %max_value.3, %for.inc ]
  %max_j.14 = phi i32 [ %max_j.08, %for.cond7.preheader ], [ %max_j.3, %for.inc ]
  %max_i.13 = phi i32 [ %max_i.07, %for.cond7.preheader ], [ %max_i.3, %for.inc ]
  %18 = add nuw nsw i64 %indvars.iv, %indvars.iv33
  %19 = trunc i64 %18 to i32
  %cmp12 = icmp ult i32 %19, %img_width
  %or.cond = and i1 %cmp11, %cmp12
  br i1 %or.cond, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body9
  %20 = add nsw i64 %18, %16
  %arrayidx = getelementptr inbounds double, double* inttoptr (i64 637534240 to double*), i64 %20
  %21 = load double, double* %arrayidx, align 8
  %cmp14 = fcmp ogt double %21, %max_value.15
  %max_i.2 = select i1 %cmp14, i32 %17, i32 %max_i.13
  %22 = trunc i64 %indvars.iv to i32
  %max_j.2 = select i1 %cmp14, i32 %22, i32 %max_j.14
  %max_value.2 = select i1 %cmp14, double %21, double %max_value.15
  br label %for.inc

for.inc:                                          ; preds = %for.body9, %if.then
  %max_i.3 = phi i32 [ %max_i.13, %for.body9 ], [ %max_i.2, %if.then ]
  %max_j.3 = phi i32 [ %max_j.14, %for.body9 ], [ %max_j.2, %if.then ]
  %max_value.3 = phi double [ %max_value.15, %for.body9 ], [ %max_value.2, %if.then ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 3
  br i1 %exitcond, label %for.inc17, label %for.body9, !llvm.loop !1

for.inc17:                                        ; preds = %for.inc
  %max_value.3.lcssa = phi double [ %max_value.3, %for.inc ]
  %max_j.3.lcssa = phi i32 [ %max_j.3, %for.inc ]
  %max_i.3.lcssa = phi i32 [ %max_i.3, %for.inc ]
  %indvars.iv.next21 = add nuw nsw i64 %indvars.iv20, 1
  %exitcond23 = icmp eq i64 %indvars.iv.next21, 3
  br i1 %exitcond23, label %for.body27, label %for.cond7.preheader, !llvm.loop !3

for.body27:                                       ; preds = %for.inc17
  %max_j.3.lcssa.lcssa = phi i32 [ %max_j.3.lcssa, %for.inc17 ]
  %max_i.3.lcssa.lcssa = phi i32 [ %max_i.3.lcssa, %for.inc17 ]
  %cmp38 = icmp eq i32 %max_i.3.lcssa.lcssa, 0
  %23 = trunc i64 %indvars.iv33 to i32
  %cmp34 = icmp ult i32 %23, %img_width
  %or.cond1 = and i1 %cmp32, %cmp34
  br i1 %or.cond1, label %if.then35, label %for.inc48

if.then35:                                        ; preds = %for.body27
  %24 = add nsw i64 %indvars.iv33, %4
  %25 = or i32 %max_i.3.lcssa.lcssa, %max_j.3.lcssa.lcssa
  %26 = icmp eq i32 %25, 0
  %arrayidx43 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %24
  br i1 %26, label %if.then41, label %if.else

if.then41:                                        ; preds = %if.then35
  store i64 255, i64* %arrayidx43, align 8
  br label %for.inc48

if.else:                                          ; preds = %if.then35
  store i64 0, i64* %arrayidx43, align 8
  br label %for.inc48

for.inc48:                                        ; preds = %for.body27, %if.else, %if.then41
  %27 = add nuw nsw i64 %indvars.iv33, 1
  %28 = trunc i64 %27 to i32
  %cmp34.1 = icmp ult i32 %28, %img_width
  %or.cond1.1 = and i1 %cmp32, %cmp34.1
  br i1 %or.cond1.1, label %if.then35.1, label %for.inc48.1

for.inc57.loopexit:                               ; preds = %for.inc48.2.2
  br label %for.inc57

for.inc57:                                        ; preds = %for.inc57.loopexit, %for.cond1.preheader
  %indvars.iv.next36 = add nuw nsw i64 %indvars.iv35, 3
  %cmp = icmp ult i64 %indvars.iv.next36, %1
  br i1 %cmp, label %for.cond1.preheader, label %for.end59.loopexit, !llvm.loop !4

for.end59.loopexit:                               ; preds = %for.inc57
  br label %for.end59

for.end59:                                        ; preds = %for.end59.loopexit, %entry
  ret void

if.then35.1:                                      ; preds = %for.inc48
  %29 = add nsw i64 %27, %4
  %cmp40.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1 = and i1 %cmp38, %cmp40.1
  %arrayidx43.1 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %29
  br i1 %or.cond2.1, label %if.then41.1, label %if.else.1

if.else.1:                                        ; preds = %if.then35.1
  store i64 0, i64* %arrayidx43.1, align 8
  br label %for.inc48.1

if.then41.1:                                      ; preds = %if.then35.1
  store i64 255, i64* %arrayidx43.1, align 8
  br label %for.inc48.1

for.inc48.1:                                      ; preds = %if.then41.1, %if.else.1, %for.inc48
  %30 = add nuw nsw i64 %indvars.iv33, 2
  %31 = trunc i64 %30 to i32
  %cmp34.2 = icmp ult i32 %31, %img_width
  %or.cond1.2 = and i1 %cmp32, %cmp34.2
  br i1 %or.cond1.2, label %if.then35.2, label %for.body27.1

if.then35.2:                                      ; preds = %for.inc48.1
  %32 = add nsw i64 %30, %4
  %cmp40.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2 = and i1 %cmp38, %cmp40.2
  %arrayidx43.2 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %32
  br i1 %or.cond2.2, label %if.then41.2, label %if.else.2

if.else.2:                                        ; preds = %if.then35.2
  store i64 0, i64* %arrayidx43.2, align 8
  br label %for.body27.1

if.then41.2:                                      ; preds = %if.then35.2
  store i64 255, i64* %arrayidx43.2, align 8
  br label %for.body27.1

for.body27.1:                                     ; preds = %for.inc48.1, %if.else.2, %if.then41.2
  %cmp38.1 = icmp eq i32 %max_i.3.lcssa.lcssa, 1
  %33 = trunc i64 %indvars.iv33 to i32
  %cmp34.137 = icmp ult i32 %33, %img_width
  %or.cond1.138 = and i1 %cmp32.1, %cmp34.137
  br i1 %or.cond1.138, label %if.then35.142, label %for.inc48.145

if.then35.142:                                    ; preds = %for.body27.1
  %34 = add nsw i64 %indvars.iv33, %8
  %cmp40.139 = icmp eq i32 %max_j.3.lcssa.lcssa, 0
  %or.cond2.140 = and i1 %cmp38.1, %cmp40.139
  %arrayidx43.141 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %34
  br i1 %or.cond2.140, label %if.then41.144, label %if.else.143

if.else.143:                                      ; preds = %if.then35.142
  store i64 0, i64* %arrayidx43.141, align 8
  br label %for.inc48.145

if.then41.144:                                    ; preds = %if.then35.142
  store i64 255, i64* %arrayidx43.141, align 8
  br label %for.inc48.145

for.inc48.145:                                    ; preds = %if.then41.144, %if.else.143, %for.body27.1
  %35 = add nuw nsw i64 %indvars.iv33, 1
  %36 = trunc i64 %35 to i32
  %cmp34.1.1 = icmp ult i32 %36, %img_width
  %or.cond1.1.1 = and i1 %cmp32.1, %cmp34.1.1
  br i1 %or.cond1.1.1, label %if.then35.1.1, label %for.inc48.1.1

if.then35.1.1:                                    ; preds = %for.inc48.145
  %37 = add nsw i64 %35, %8
  %cmp40.1.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1.1 = and i1 %cmp38.1, %cmp40.1.1
  %arrayidx43.1.1 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %37
  br i1 %or.cond2.1.1, label %if.then41.1.1, label %if.else.1.1

if.else.1.1:                                      ; preds = %if.then35.1.1
  store i64 0, i64* %arrayidx43.1.1, align 8
  br label %for.inc48.1.1

if.then41.1.1:                                    ; preds = %if.then35.1.1
  store i64 255, i64* %arrayidx43.1.1, align 8
  br label %for.inc48.1.1

for.inc48.1.1:                                    ; preds = %if.then41.1.1, %if.else.1.1, %for.inc48.145
  %38 = add nuw nsw i64 %indvars.iv33, 2
  %39 = trunc i64 %38 to i32
  %cmp34.2.1 = icmp ult i32 %39, %img_width
  %or.cond1.2.1 = and i1 %cmp32.1, %cmp34.2.1
  br i1 %or.cond1.2.1, label %if.then35.2.1, label %for.body27.2

if.then35.2.1:                                    ; preds = %for.inc48.1.1
  %40 = add nsw i64 %38, %8
  %cmp40.2.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2.1 = and i1 %cmp38.1, %cmp40.2.1
  %arrayidx43.2.1 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %40
  br i1 %or.cond2.2.1, label %if.then41.2.1, label %if.else.2.1

if.else.2.1:                                      ; preds = %if.then35.2.1
  store i64 0, i64* %arrayidx43.2.1, align 8
  br label %for.body27.2

if.then41.2.1:                                    ; preds = %if.then35.2.1
  store i64 255, i64* %arrayidx43.2.1, align 8
  br label %for.body27.2

for.body27.2:                                     ; preds = %for.inc48.1.1, %if.else.2.1, %if.then41.2.1
  %cmp38.2 = icmp eq i32 %max_i.3.lcssa.lcssa, 2
  %41 = trunc i64 %indvars.iv33 to i32
  %cmp34.246 = icmp ult i32 %41, %img_width
  %or.cond1.247 = and i1 %cmp32.2, %cmp34.246
  br i1 %or.cond1.247, label %if.then35.251, label %for.inc48.254

if.then35.251:                                    ; preds = %for.body27.2
  %42 = add nsw i64 %indvars.iv33, %12
  %cmp40.248 = icmp eq i32 %max_j.3.lcssa.lcssa, 0
  %or.cond2.249 = and i1 %cmp38.2, %cmp40.248
  %arrayidx43.250 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %42
  br i1 %or.cond2.249, label %if.then41.253, label %if.else.252

if.else.252:                                      ; preds = %if.then35.251
  store i64 0, i64* %arrayidx43.250, align 8
  br label %for.inc48.254

if.then41.253:                                    ; preds = %if.then35.251
  store i64 255, i64* %arrayidx43.250, align 8
  br label %for.inc48.254

for.inc48.254:                                    ; preds = %if.then41.253, %if.else.252, %for.body27.2
  %43 = add nuw nsw i64 %indvars.iv33, 1
  %44 = trunc i64 %43 to i32
  %cmp34.1.2 = icmp ult i32 %44, %img_width
  %or.cond1.1.2 = and i1 %cmp32.2, %cmp34.1.2
  br i1 %or.cond1.1.2, label %if.then35.1.2, label %for.inc48.1.2

if.then35.1.2:                                    ; preds = %for.inc48.254
  %45 = add nsw i64 %43, %12
  %cmp40.1.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1.2 = and i1 %cmp38.2, %cmp40.1.2
  %arrayidx43.1.2 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %45
  br i1 %or.cond2.1.2, label %if.then41.1.2, label %if.else.1.2

if.else.1.2:                                      ; preds = %if.then35.1.2
  store i64 0, i64* %arrayidx43.1.2, align 8
  br label %for.inc48.1.2

if.then41.1.2:                                    ; preds = %if.then35.1.2
  store i64 255, i64* %arrayidx43.1.2, align 8
  br label %for.inc48.1.2

for.inc48.1.2:                                    ; preds = %if.then41.1.2, %if.else.1.2, %for.inc48.254
  %46 = add nuw nsw i64 %indvars.iv33, 2
  %47 = trunc i64 %46 to i32
  %cmp34.2.2 = icmp ult i32 %47, %img_width
  %or.cond1.2.2 = and i1 %cmp32.2, %cmp34.2.2
  br i1 %or.cond1.2.2, label %if.then35.2.2, label %for.inc48.2.2

if.then35.2.2:                                    ; preds = %for.inc48.1.2
  %48 = add nsw i64 %46, %12
  %cmp40.2.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2.2 = and i1 %cmp38.2, %cmp40.2.2
  %arrayidx43.2.2 = getelementptr inbounds i64, i64* inttoptr (i64 637665312 to i64*), i64 %48
  br i1 %or.cond2.2.2, label %if.then41.2.2, label %if.else.2.2

if.else.2.2:                                      ; preds = %if.then35.2.2
  store i64 0, i64* %arrayidx43.2.2, align 8
  br label %for.inc48.2.2

if.then41.2.2:                                    ; preds = %if.then35.2.2
  store i64 255, i64* %arrayidx43.2.2, align 8
  br label %for.inc48.2.2

for.inc48.2.2:                                    ; preds = %if.then41.2.2, %if.else.2.2, %for.inc48.1.2
  %indvars.iv.next34 = add nuw nsw i64 %indvars.iv33, 3
  %cmp2 = icmp ult i64 %indvars.iv.next34, %0
  br i1 %cmp2, label %for.cond4.preheader, label %for.inc57.loopexit, !llvm.loop !5
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !2}
