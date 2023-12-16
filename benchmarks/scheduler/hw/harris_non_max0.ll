; ModuleID = 'harris_non_max0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @harris_non_max(i32 %img_height, i32 %img_width, i32 %output_spm_addr) #0 {
entry:
  %conv = zext i32 %output_spm_addr to i64
  %0 = inttoptr i64 %conv to i8*
  %cmp16 = icmp eq i32 %img_height, 0
  br i1 %cmp16, label %for.end72, label %for.cond2.preheader.lr.ph

for.cond2.preheader.lr.ph:                        ; preds = %entry
  %cmp313 = icmp eq i32 %img_width, 0
  %1 = zext i32 %img_width to i64
  %2 = zext i32 %img_height to i64
  br label %for.cond2.preheader

for.cond2.preheader:                              ; preds = %for.cond2.preheader.lr.ph, %for.inc70
  %indvars.iv36 = phi i64 [ 0, %for.cond2.preheader.lr.ph ], [ %indvars.iv.next37, %for.inc70 ]
  br i1 %cmp313, label %for.inc70, label %for.cond6.preheader.preheader

for.cond6.preheader.preheader:                    ; preds = %for.cond2.preheader
  %3 = trunc i64 %indvars.iv36 to i32
  %cmp41 = icmp ult i32 %3, %img_height
  %4 = trunc i64 %indvars.iv36 to i32
  %mul47 = shl i32 %4, 7
  %5 = sext i32 %mul47 to i64
  %6 = add nuw nsw i64 %indvars.iv36, 1
  %7 = trunc i64 %6 to i32
  %cmp41.1 = icmp ult i32 %7, %img_height
  %8 = trunc i64 %6 to i32
  %mul47.1 = shl i32 %8, 7
  %9 = sext i32 %mul47.1 to i64
  %10 = add nuw nsw i64 %indvars.iv36, 2
  %11 = trunc i64 %10 to i32
  %cmp41.2 = icmp ult i32 %11, %img_height
  %12 = trunc i64 %10 to i32
  %mul47.2 = shl i32 %12, 7
  %13 = sext i32 %mul47.2 to i64
  br label %for.cond6.preheader

for.cond6.preheader:                              ; preds = %for.cond6.preheader.preheader, %for.inc61.2.2
  %indvars.iv34 = phi i64 [ %indvars.iv.next35, %for.inc61.2.2 ], [ 0, %for.cond6.preheader.preheader ]
  br label %for.cond10.preheader

for.cond10.preheader:                             ; preds = %for.inc24, %for.cond6.preheader
  %indvars.iv21 = phi i64 [ 0, %for.cond6.preheader ], [ %indvars.iv.next22, %for.inc24 ]
  %max_value.09 = phi float [ -1.000000e+00, %for.cond6.preheader ], [ %max_value.3.lcssa, %for.inc24 ]
  %max_i.08 = phi i32 [ -1, %for.cond6.preheader ], [ %max_i.3.lcssa, %for.inc24 ]
  %max_j.07 = phi i32 [ -1, %for.cond6.preheader ], [ %max_j.3.lcssa, %for.inc24 ]
  %14 = add nuw nsw i64 %indvars.iv21, %indvars.iv36
  %15 = trunc i64 %14 to i32
  %cmp15 = icmp ult i32 %15, %img_height
  %16 = trunc i64 %14 to i32
  %mul = shl i32 %16, 7
  %17 = sext i32 %mul to i64
  %18 = trunc i64 %indvars.iv21 to i32
  br label %for.body13

for.body13:                                       ; preds = %for.inc, %for.cond10.preheader
  %indvars.iv = phi i64 [ 0, %for.cond10.preheader ], [ %indvars.iv.next, %for.inc ]
  %max_value.15 = phi float [ %max_value.09, %for.cond10.preheader ], [ %max_value.3, %for.inc ]
  %max_i.14 = phi i32 [ %max_i.08, %for.cond10.preheader ], [ %max_i.3, %for.inc ]
  %max_j.13 = phi i32 [ %max_j.07, %for.cond10.preheader ], [ %max_j.3, %for.inc ]
  %19 = add nuw nsw i64 %indvars.iv, %indvars.iv34
  %20 = trunc i64 %19 to i32
  %cmp17 = icmp ult i32 %20, %img_width
  %or.cond = and i1 %cmp15, %cmp17
  br i1 %or.cond, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body13
  %21 = add nsw i64 %19, %17
  %arrayidx = getelementptr inbounds float, float* inttoptr (i64 637534240 to float*), i64 %21
  %22 = load float, float* %arrayidx, align 4
  %cmp20 = fcmp ogt float %22, %max_value.15
  %23 = trunc i64 %indvars.iv to i32
  %max_j.2 = select i1 %cmp20, i32 %23, i32 %max_j.13
  %max_i.2 = select i1 %cmp20, i32 %18, i32 %max_i.14
  %max_value.2 = select i1 %cmp20, float %22, float %max_value.15
  br label %for.inc

for.inc:                                          ; preds = %for.body13, %if.then
  %max_j.3 = phi i32 [ %max_j.13, %for.body13 ], [ %max_j.2, %if.then ]
  %max_i.3 = phi i32 [ %max_i.14, %for.body13 ], [ %max_i.2, %if.then ]
  %max_value.3 = phi float [ %max_value.15, %for.body13 ], [ %max_value.2, %if.then ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 3
  br i1 %exitcond, label %for.inc24, label %for.body13, !llvm.loop !1

for.inc24:                                        ; preds = %for.inc
  %max_value.3.lcssa = phi float [ %max_value.3, %for.inc ]
  %max_i.3.lcssa = phi i32 [ %max_i.3, %for.inc ]
  %max_j.3.lcssa = phi i32 [ %max_j.3, %for.inc ]
  %indvars.iv.next22 = add nuw nsw i64 %indvars.iv21, 1
  %exitcond24 = icmp eq i64 %indvars.iv.next22, 3
  br i1 %exitcond24, label %for.body36, label %for.cond10.preheader, !llvm.loop !3

for.body36:                                       ; preds = %for.inc24
  %max_i.3.lcssa.lcssa = phi i32 [ %max_i.3.lcssa, %for.inc24 ]
  %max_j.3.lcssa.lcssa = phi i32 [ %max_j.3.lcssa, %for.inc24 ]
  %cmp49 = icmp eq i32 %max_i.3.lcssa.lcssa, 0
  %24 = trunc i64 %indvars.iv34 to i32
  %cmp44 = icmp ult i32 %24, %img_width
  %or.cond1 = and i1 %cmp41, %cmp44
  br i1 %or.cond1, label %if.then46, label %for.inc61

if.then46:                                        ; preds = %for.body36
  %25 = add nsw i64 %indvars.iv34, %5
  %26 = or i32 %max_i.3.lcssa.lcssa, %max_j.3.lcssa.lcssa
  %27 = icmp eq i32 %26, 0
  %arrayidx56 = getelementptr inbounds i8, i8* %0, i64 %25
  br i1 %27, label %if.then54, label %if.else

if.then54:                                        ; preds = %if.then46
  store i8 -1, i8* %arrayidx56, align 1
  br label %for.inc61

if.else:                                          ; preds = %if.then46
  store i8 0, i8* %arrayidx56, align 1
  br label %for.inc61

for.inc61:                                        ; preds = %for.body36, %if.else, %if.then54
  %28 = add nuw nsw i64 %indvars.iv34, 1
  %29 = trunc i64 %28 to i32
  %cmp44.1 = icmp ult i32 %29, %img_width
  %or.cond1.1 = and i1 %cmp41, %cmp44.1
  br i1 %or.cond1.1, label %if.then46.1, label %for.inc61.1

for.inc70.loopexit:                               ; preds = %for.inc61.2.2
  br label %for.inc70

for.inc70:                                        ; preds = %for.inc70.loopexit, %for.cond2.preheader
  %indvars.iv.next37 = add nuw nsw i64 %indvars.iv36, 3
  %cmp = icmp ult i64 %indvars.iv.next37, %2
  br i1 %cmp, label %for.cond2.preheader, label %for.end72.loopexit, !llvm.loop !4

for.end72.loopexit:                               ; preds = %for.inc70
  br label %for.end72

for.end72:                                        ; preds = %for.end72.loopexit, %entry
  ret void

if.then46.1:                                      ; preds = %for.inc61
  %30 = add nsw i64 %28, %5
  %cmp52.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1 = and i1 %cmp49, %cmp52.1
  %arrayidx56.1 = getelementptr inbounds i8, i8* %0, i64 %30
  br i1 %or.cond2.1, label %if.then54.1, label %if.else.1

if.else.1:                                        ; preds = %if.then46.1
  store i8 0, i8* %arrayidx56.1, align 1
  br label %for.inc61.1

if.then54.1:                                      ; preds = %if.then46.1
  store i8 -1, i8* %arrayidx56.1, align 1
  br label %for.inc61.1

for.inc61.1:                                      ; preds = %if.then54.1, %if.else.1, %for.inc61
  %31 = add nuw nsw i64 %indvars.iv34, 2
  %32 = trunc i64 %31 to i32
  %cmp44.2 = icmp ult i32 %32, %img_width
  %or.cond1.2 = and i1 %cmp41, %cmp44.2
  br i1 %or.cond1.2, label %if.then46.2, label %for.body36.1

if.then46.2:                                      ; preds = %for.inc61.1
  %33 = add nsw i64 %31, %5
  %cmp52.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2 = and i1 %cmp49, %cmp52.2
  %arrayidx56.2 = getelementptr inbounds i8, i8* %0, i64 %33
  br i1 %or.cond2.2, label %if.then54.2, label %if.else.2

if.else.2:                                        ; preds = %if.then46.2
  store i8 0, i8* %arrayidx56.2, align 1
  br label %for.body36.1

if.then54.2:                                      ; preds = %if.then46.2
  store i8 -1, i8* %arrayidx56.2, align 1
  br label %for.body36.1

for.body36.1:                                     ; preds = %for.inc61.1, %if.else.2, %if.then54.2
  %cmp49.1 = icmp eq i32 %max_i.3.lcssa.lcssa, 1
  %34 = trunc i64 %indvars.iv34 to i32
  %cmp44.138 = icmp ult i32 %34, %img_width
  %or.cond1.139 = and i1 %cmp41.1, %cmp44.138
  br i1 %or.cond1.139, label %if.then46.143, label %for.inc61.146

if.then46.143:                                    ; preds = %for.body36.1
  %35 = add nsw i64 %indvars.iv34, %9
  %cmp52.140 = icmp eq i32 %max_j.3.lcssa.lcssa, 0
  %or.cond2.141 = and i1 %cmp49.1, %cmp52.140
  %arrayidx56.142 = getelementptr inbounds i8, i8* %0, i64 %35
  br i1 %or.cond2.141, label %if.then54.145, label %if.else.144

if.else.144:                                      ; preds = %if.then46.143
  store i8 0, i8* %arrayidx56.142, align 1
  br label %for.inc61.146

if.then54.145:                                    ; preds = %if.then46.143
  store i8 -1, i8* %arrayidx56.142, align 1
  br label %for.inc61.146

for.inc61.146:                                    ; preds = %if.then54.145, %if.else.144, %for.body36.1
  %36 = add nuw nsw i64 %indvars.iv34, 1
  %37 = trunc i64 %36 to i32
  %cmp44.1.1 = icmp ult i32 %37, %img_width
  %or.cond1.1.1 = and i1 %cmp41.1, %cmp44.1.1
  br i1 %or.cond1.1.1, label %if.then46.1.1, label %for.inc61.1.1

if.then46.1.1:                                    ; preds = %for.inc61.146
  %38 = add nsw i64 %36, %9
  %cmp52.1.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1.1 = and i1 %cmp49.1, %cmp52.1.1
  %arrayidx56.1.1 = getelementptr inbounds i8, i8* %0, i64 %38
  br i1 %or.cond2.1.1, label %if.then54.1.1, label %if.else.1.1

if.else.1.1:                                      ; preds = %if.then46.1.1
  store i8 0, i8* %arrayidx56.1.1, align 1
  br label %for.inc61.1.1

if.then54.1.1:                                    ; preds = %if.then46.1.1
  store i8 -1, i8* %arrayidx56.1.1, align 1
  br label %for.inc61.1.1

for.inc61.1.1:                                    ; preds = %if.then54.1.1, %if.else.1.1, %for.inc61.146
  %39 = add nuw nsw i64 %indvars.iv34, 2
  %40 = trunc i64 %39 to i32
  %cmp44.2.1 = icmp ult i32 %40, %img_width
  %or.cond1.2.1 = and i1 %cmp41.1, %cmp44.2.1
  br i1 %or.cond1.2.1, label %if.then46.2.1, label %for.body36.2

if.then46.2.1:                                    ; preds = %for.inc61.1.1
  %41 = add nsw i64 %39, %9
  %cmp52.2.1 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2.1 = and i1 %cmp49.1, %cmp52.2.1
  %arrayidx56.2.1 = getelementptr inbounds i8, i8* %0, i64 %41
  br i1 %or.cond2.2.1, label %if.then54.2.1, label %if.else.2.1

if.else.2.1:                                      ; preds = %if.then46.2.1
  store i8 0, i8* %arrayidx56.2.1, align 1
  br label %for.body36.2

if.then54.2.1:                                    ; preds = %if.then46.2.1
  store i8 -1, i8* %arrayidx56.2.1, align 1
  br label %for.body36.2

for.body36.2:                                     ; preds = %for.inc61.1.1, %if.else.2.1, %if.then54.2.1
  %cmp49.2 = icmp eq i32 %max_i.3.lcssa.lcssa, 2
  %42 = trunc i64 %indvars.iv34 to i32
  %cmp44.247 = icmp ult i32 %42, %img_width
  %or.cond1.248 = and i1 %cmp41.2, %cmp44.247
  br i1 %or.cond1.248, label %if.then46.252, label %for.inc61.255

if.then46.252:                                    ; preds = %for.body36.2
  %43 = add nsw i64 %indvars.iv34, %13
  %cmp52.249 = icmp eq i32 %max_j.3.lcssa.lcssa, 0
  %or.cond2.250 = and i1 %cmp49.2, %cmp52.249
  %arrayidx56.251 = getelementptr inbounds i8, i8* %0, i64 %43
  br i1 %or.cond2.250, label %if.then54.254, label %if.else.253

if.else.253:                                      ; preds = %if.then46.252
  store i8 0, i8* %arrayidx56.251, align 1
  br label %for.inc61.255

if.then54.254:                                    ; preds = %if.then46.252
  store i8 -1, i8* %arrayidx56.251, align 1
  br label %for.inc61.255

for.inc61.255:                                    ; preds = %if.then54.254, %if.else.253, %for.body36.2
  %44 = add nuw nsw i64 %indvars.iv34, 1
  %45 = trunc i64 %44 to i32
  %cmp44.1.2 = icmp ult i32 %45, %img_width
  %or.cond1.1.2 = and i1 %cmp41.2, %cmp44.1.2
  br i1 %or.cond1.1.2, label %if.then46.1.2, label %for.inc61.1.2

if.then46.1.2:                                    ; preds = %for.inc61.255
  %46 = add nsw i64 %44, %13
  %cmp52.1.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 1
  %or.cond2.1.2 = and i1 %cmp49.2, %cmp52.1.2
  %arrayidx56.1.2 = getelementptr inbounds i8, i8* %0, i64 %46
  br i1 %or.cond2.1.2, label %if.then54.1.2, label %if.else.1.2

if.else.1.2:                                      ; preds = %if.then46.1.2
  store i8 0, i8* %arrayidx56.1.2, align 1
  br label %for.inc61.1.2

if.then54.1.2:                                    ; preds = %if.then46.1.2
  store i8 -1, i8* %arrayidx56.1.2, align 1
  br label %for.inc61.1.2

for.inc61.1.2:                                    ; preds = %if.then54.1.2, %if.else.1.2, %for.inc61.255
  %47 = add nuw nsw i64 %indvars.iv34, 2
  %48 = trunc i64 %47 to i32
  %cmp44.2.2 = icmp ult i32 %48, %img_width
  %or.cond1.2.2 = and i1 %cmp41.2, %cmp44.2.2
  br i1 %or.cond1.2.2, label %if.then46.2.2, label %for.inc61.2.2

if.then46.2.2:                                    ; preds = %for.inc61.1.2
  %49 = add nsw i64 %47, %13
  %cmp52.2.2 = icmp eq i32 %max_j.3.lcssa.lcssa, 2
  %or.cond2.2.2 = and i1 %cmp49.2, %cmp52.2.2
  %arrayidx56.2.2 = getelementptr inbounds i8, i8* %0, i64 %49
  br i1 %or.cond2.2.2, label %if.then54.2.2, label %if.else.2.2

if.else.2.2:                                      ; preds = %if.then46.2.2
  store i8 0, i8* %arrayidx56.2.2, align 1
  br label %for.inc61.2.2

if.then54.2.2:                                    ; preds = %if.then46.2.2
  store i8 -1, i8* %arrayidx56.2.2, align 1
  br label %for.inc61.2.2

for.inc61.2.2:                                    ; preds = %if.then54.2.2, %if.else.2.2, %for.inc61.1.2
  %indvars.iv.next35 = add nuw nsw i64 %indvars.iv34, 3
  %cmp3 = icmp ult i64 %indvars.iv.next35, %1
  br i1 %cmp3, label %for.cond6.preheader, label %for.inc70.loopexit, !llvm.loop !5
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !2}
