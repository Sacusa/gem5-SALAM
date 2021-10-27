; ModuleID = 'grayscale.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @grayscale(i64 %num_elems) #0 {
entry:
  %cmp1 = icmp eq i64 %num_elems, 0
  br i1 %cmp1, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  %0 = add i64 %num_elems, -1
  %xtraiter = and i64 %num_elems, 7
  %lcmp.mod = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.body.preheader.split, label %for.body.prol.preheader

for.body.prol.preheader:                          ; preds = %for.body.preheader
  br label %for.body.prol

for.body.prol:                                    ; preds = %for.body.prol.preheader, %for.body.prol
  %indvars.iv.prol = phi i64 [ %indvars.iv.next.prol, %for.body.prol ], [ 0, %for.body.prol.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %for.body.prol ], [ %xtraiter, %for.body.prol.preheader ]
  %1 = mul nuw nsw i64 %indvars.iv.prol, 3
  %arrayidx.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %1
  %2 = load i8, i8* %arrayidx.prol, align 1
  %3 = add nuw nsw i64 %1, 1
  %arrayidx3.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %3
  %4 = load i8, i8* %arrayidx3.prol, align 1
  %5 = add nuw nsw i64 %1, 2
  %arrayidx6.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %5
  %6 = load i8, i8* %arrayidx6.prol, align 1
  %conv8.prol = uitofp i8 %2 to float
  %mul9.prol = fmul float %conv8.prol, 0x3FCB367A00000000
  %conv11.prol = uitofp i8 %4 to float
  %mul12.prol = fmul float %conv11.prol, 0x3FE6E2EB20000000
  %add13.prol = fadd float %mul9.prol, %mul12.prol
  %conv15.prol = uitofp i8 %6 to float
  %mul16.prol = fmul float %conv15.prol, 0x3FB27BB300000000
  %add17.prol = fadd float %add13.prol, %mul16.prol
  %conv18.prol = fptoui float %add17.prol to i8
  %conv19.prol = uitofp i8 %conv18.prol to float
  %arrayidx21.prol = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.prol
  store float %conv19.prol, float* %arrayidx21.prol, align 4
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.body.preheader.split.loopexit, label %for.body.prol, !llvm.loop !1

for.body.preheader.split.loopexit:                ; preds = %for.body.prol
  %indvars.iv.next.prol.lcssa = phi i64 [ %indvars.iv.next.prol, %for.body.prol ]
  br label %for.body.preheader.split

for.body.preheader.split:                         ; preds = %for.body.preheader.split.loopexit, %for.body.preheader
  %indvars.iv.unr = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next.prol.lcssa, %for.body.preheader.split.loopexit ]
  %7 = icmp ult i64 %0, 7
  br i1 %7, label %for.end, label %for.body.preheader10

for.body.preheader10:                             ; preds = %for.body.preheader.split
  br label %for.body

for.body:                                         ; preds = %for.body.preheader10, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next.7, %for.body ], [ %indvars.iv.unr, %for.body.preheader10 ]
  %8 = mul nuw nsw i64 %indvars.iv, 3
  %arrayidx = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %8
  %9 = load i8, i8* %arrayidx, align 1
  %10 = add nuw nsw i64 %8, 1
  %arrayidx3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %10
  %11 = load i8, i8* %arrayidx3, align 1
  %12 = add nuw nsw i64 %8, 2
  %arrayidx6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %12
  %13 = load i8, i8* %arrayidx6, align 1
  %conv8 = uitofp i8 %9 to float
  %mul9 = fmul float %conv8, 0x3FCB367A00000000
  %conv11 = uitofp i8 %11 to float
  %mul12 = fmul float %conv11, 0x3FE6E2EB20000000
  %add13 = fadd float %mul9, %mul12
  %conv15 = uitofp i8 %13 to float
  %mul16 = fmul float %conv15, 0x3FB27BB300000000
  %add17 = fadd float %add13, %mul16
  %conv18 = fptoui float %add17 to i8
  %conv19 = uitofp i8 %conv18 to float
  %arrayidx21 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv
  store float %conv19, float* %arrayidx21, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %14 = mul nuw nsw i64 %indvars.iv.next, 3
  %arrayidx.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %14
  %15 = load i8, i8* %arrayidx.1, align 1
  %16 = add nuw nsw i64 %14, 1
  %arrayidx3.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %16
  %17 = load i8, i8* %arrayidx3.1, align 1
  %18 = add nuw nsw i64 %14, 2
  %arrayidx6.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %18
  %19 = load i8, i8* %arrayidx6.1, align 1
  %conv8.1 = uitofp i8 %15 to float
  %mul9.1 = fmul float %conv8.1, 0x3FCB367A00000000
  %conv11.1 = uitofp i8 %17 to float
  %mul12.1 = fmul float %conv11.1, 0x3FE6E2EB20000000
  %add13.1 = fadd float %mul9.1, %mul12.1
  %conv15.1 = uitofp i8 %19 to float
  %mul16.1 = fmul float %conv15.1, 0x3FB27BB300000000
  %add17.1 = fadd float %add13.1, %mul16.1
  %conv18.1 = fptoui float %add17.1 to i8
  %conv19.1 = uitofp i8 %conv18.1 to float
  %arrayidx21.1 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.next
  store float %conv19.1, float* %arrayidx21.1, align 4
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %20 = mul nuw nsw i64 %indvars.iv.next.1, 3
  %arrayidx.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %20
  %21 = load i8, i8* %arrayidx.2, align 1
  %22 = add nuw nsw i64 %20, 1
  %arrayidx3.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %22
  %23 = load i8, i8* %arrayidx3.2, align 1
  %24 = add nuw nsw i64 %20, 2
  %arrayidx6.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %24
  %25 = load i8, i8* %arrayidx6.2, align 1
  %conv8.2 = uitofp i8 %21 to float
  %mul9.2 = fmul float %conv8.2, 0x3FCB367A00000000
  %conv11.2 = uitofp i8 %23 to float
  %mul12.2 = fmul float %conv11.2, 0x3FE6E2EB20000000
  %add13.2 = fadd float %mul9.2, %mul12.2
  %conv15.2 = uitofp i8 %25 to float
  %mul16.2 = fmul float %conv15.2, 0x3FB27BB300000000
  %add17.2 = fadd float %add13.2, %mul16.2
  %conv18.2 = fptoui float %add17.2 to i8
  %conv19.2 = uitofp i8 %conv18.2 to float
  %arrayidx21.2 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.next.1
  store float %conv19.2, float* %arrayidx21.2, align 4
  %indvars.iv.next.2 = add nsw i64 %indvars.iv, 3
  %26 = mul nuw nsw i64 %indvars.iv.next.2, 3
  %arrayidx.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %26
  %27 = load i8, i8* %arrayidx.3, align 1
  %28 = add nuw nsw i64 %26, 1
  %arrayidx3.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %28
  %29 = load i8, i8* %arrayidx3.3, align 1
  %30 = add nuw nsw i64 %26, 2
  %arrayidx6.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %30
  %31 = load i8, i8* %arrayidx6.3, align 1
  %conv8.3 = uitofp i8 %27 to float
  %mul9.3 = fmul float %conv8.3, 0x3FCB367A00000000
  %conv11.3 = uitofp i8 %29 to float
  %mul12.3 = fmul float %conv11.3, 0x3FE6E2EB20000000
  %add13.3 = fadd float %mul9.3, %mul12.3
  %conv15.3 = uitofp i8 %31 to float
  %mul16.3 = fmul float %conv15.3, 0x3FB27BB300000000
  %add17.3 = fadd float %add13.3, %mul16.3
  %conv18.3 = fptoui float %add17.3 to i8
  %conv19.3 = uitofp i8 %conv18.3 to float
  %arrayidx21.3 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.next.2
  store float %conv19.3, float* %arrayidx21.3, align 4
  %indvars.iv.next.3 = add nsw i64 %indvars.iv, 4
  %32 = mul nuw nsw i64 %indvars.iv.next.3, 3
  %arrayidx.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %32
  %33 = load i8, i8* %arrayidx.4, align 1
  %34 = add nuw nsw i64 %32, 1
  %arrayidx3.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %34
  %35 = load i8, i8* %arrayidx3.4, align 1
  %36 = add nuw nsw i64 %32, 2
  %arrayidx6.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %36
  %37 = load i8, i8* %arrayidx6.4, align 1
  %conv8.4 = uitofp i8 %33 to float
  %mul9.4 = fmul float %conv8.4, 0x3FCB367A00000000
  %conv11.4 = uitofp i8 %35 to float
  %mul12.4 = fmul float %conv11.4, 0x3FE6E2EB20000000
  %add13.4 = fadd float %mul9.4, %mul12.4
  %conv15.4 = uitofp i8 %37 to float
  %mul16.4 = fmul float %conv15.4, 0x3FB27BB300000000
  %add17.4 = fadd float %add13.4, %mul16.4
  %conv18.4 = fptoui float %add17.4 to i8
  %conv19.4 = uitofp i8 %conv18.4 to float
  %arrayidx21.4 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.next.3
  store float %conv19.4, float* %arrayidx21.4, align 4
  %indvars.iv.next.4 = add nsw i64 %indvars.iv, 5
  %38 = mul nuw nsw i64 %indvars.iv.next.4, 3
  %arrayidx.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %38
  %39 = load i8, i8* %arrayidx.5, align 1
  %40 = add nuw nsw i64 %38, 1
  %arrayidx3.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %40
  %41 = load i8, i8* %arrayidx3.5, align 1
  %42 = add nuw nsw i64 %38, 2
  %arrayidx6.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %42
  %43 = load i8, i8* %arrayidx6.5, align 1
  %conv8.5 = uitofp i8 %39 to float
  %mul9.5 = fmul float %conv8.5, 0x3FCB367A00000000
  %conv11.5 = uitofp i8 %41 to float
  %mul12.5 = fmul float %conv11.5, 0x3FE6E2EB20000000
  %add13.5 = fadd float %mul9.5, %mul12.5
  %conv15.5 = uitofp i8 %43 to float
  %mul16.5 = fmul float %conv15.5, 0x3FB27BB300000000
  %add17.5 = fadd float %add13.5, %mul16.5
  %conv18.5 = fptoui float %add17.5 to i8
  %conv19.5 = uitofp i8 %conv18.5 to float
  %arrayidx21.5 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.next.4
  store float %conv19.5, float* %arrayidx21.5, align 4
  %indvars.iv.next.5 = add nsw i64 %indvars.iv, 6
  %44 = mul nuw nsw i64 %indvars.iv.next.5, 3
  %arrayidx.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %44
  %45 = load i8, i8* %arrayidx.6, align 1
  %46 = add nuw nsw i64 %44, 1
  %arrayidx3.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %46
  %47 = load i8, i8* %arrayidx3.6, align 1
  %48 = add nuw nsw i64 %44, 2
  %arrayidx6.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %48
  %49 = load i8, i8* %arrayidx6.6, align 1
  %conv8.6 = uitofp i8 %45 to float
  %mul9.6 = fmul float %conv8.6, 0x3FCB367A00000000
  %conv11.6 = uitofp i8 %47 to float
  %mul12.6 = fmul float %conv11.6, 0x3FE6E2EB20000000
  %add13.6 = fadd float %mul9.6, %mul12.6
  %conv15.6 = uitofp i8 %49 to float
  %mul16.6 = fmul float %conv15.6, 0x3FB27BB300000000
  %add17.6 = fadd float %add13.6, %mul16.6
  %conv18.6 = fptoui float %add17.6 to i8
  %conv19.6 = uitofp i8 %conv18.6 to float
  %arrayidx21.6 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.next.5
  store float %conv19.6, float* %arrayidx21.6, align 4
  %indvars.iv.next.6 = add nsw i64 %indvars.iv, 7
  %50 = mul nuw nsw i64 %indvars.iv.next.6, 3
  %arrayidx.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %50
  %51 = load i8, i8* %arrayidx.7, align 1
  %52 = add nuw nsw i64 %50, 1
  %arrayidx3.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %52
  %53 = load i8, i8* %arrayidx3.7, align 1
  %54 = add nuw nsw i64 %50, 2
  %arrayidx6.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %54
  %55 = load i8, i8* %arrayidx6.7, align 1
  %conv8.7 = uitofp i8 %51 to float
  %mul9.7 = fmul float %conv8.7, 0x3FCB367A00000000
  %conv11.7 = uitofp i8 %53 to float
  %mul12.7 = fmul float %conv11.7, 0x3FE6E2EB20000000
  %add13.7 = fadd float %mul9.7, %mul12.7
  %conv15.7 = uitofp i8 %55 to float
  %mul16.7 = fmul float %conv15.7, 0x3FB27BB300000000
  %add17.7 = fadd float %add13.7, %mul16.7
  %conv18.7 = fptoui float %add17.7 to i8
  %conv19.7 = uitofp i8 %conv18.7 to float
  %arrayidx21.7 = getelementptr inbounds float, float* inttoptr (i64 620806176 to float*), i64 %indvars.iv.next.6
  store float %conv19.7, float* %arrayidx21.7, align 4
  %indvars.iv.next.7 = add nsw i64 %indvars.iv, 8
  %exitcond.7 = icmp eq i64 %indvars.iv.next.7, %num_elems
  br i1 %exitcond.7, label %for.end.loopexit, label %for.body, !llvm.loop !3

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %for.body.preheader.split, %entry
  ret void
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
