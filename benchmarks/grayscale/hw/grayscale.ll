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
  %0 = load volatile i8, i8* inttoptr (i64 541065248 to i8*), align 32
  %1 = load volatile i8, i8* inttoptr (i64 541065248 to i8*), align 32
  %2 = load volatile i8, i8* inttoptr (i64 541065248 to i8*), align 32
  %conv2 = uitofp i8 %0 to float
  %conv3 = fpext float %conv2 to double
  %mul = fmul double %conv3, 2.126000e-01
  %conv4 = uitofp i8 %1 to float
  %conv5 = fpext float %conv4 to double
  %mul6 = fmul double %conv5, 7.152000e-01
  %add = fadd double %mul, %mul6
  %conv7 = uitofp i8 %2 to float
  %conv8 = fpext float %conv7 to double
  %mul9 = fmul double %conv8, 7.220000e-02
  %add10 = fadd double %add, %mul9
  %conv11 = fptoui double %add10 to i8
  %conv12 = uitofp i8 %conv11 to float
  store volatile float %conv12, float* inttoptr (i64 541065248 to float*), align 32
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
