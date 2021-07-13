; ModuleID = 'grayscale.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @grayscale(i64 %num_elems) #0 {
entry:
  %cmp1 = icmp eq i64 %num_elems, 0
  br i1 %cmp1, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %for.body.preheader ]
  %0 = mul nuw nsw i64 %indvars.iv, 3
  %arrayidx = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %0
  %1 = load i8, i8* %arrayidx, align 1
  %2 = add nuw nsw i64 %0, 1
  %arrayidx3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %2
  %3 = load i8, i8* %arrayidx3, align 1
  %4 = add nuw nsw i64 %0, 2
  %arrayidx6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %4
  %5 = load i8, i8* %arrayidx6, align 1
  %conv8 = uitofp i8 %1 to float
  %mul9 = fmul float %conv8, 0x3FCB367A00000000
  %conv11 = uitofp i8 %3 to float
  %mul12 = fmul float %conv11, 0x3FE6E2EB20000000
  %add13 = fadd float %mul9, %mul12
  %conv15 = uitofp i8 %5 to float
  %mul16 = fmul float %conv15, 0x3FB27BB300000000
  %add17 = fadd float %add13, %mul16
  %conv18 = fptoui float %add17 to i8
  %conv19 = uitofp i8 %conv18 to float
  %arrayidx21 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv
  store float %conv19, float* %arrayidx21, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %num_elems
  br i1 %exitcond, label %for.end.loopexit, label %for.body, !llvm.loop !1

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
