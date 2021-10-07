; ModuleID = 'grayscale0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @grayscale(i64 %num_elems, i8 zeroext %spm_part) #0 {
entry:
  %cmp = icmp eq i8 %spm_part, 1
  %. = select i1 %cmp, float* inttoptr (i64 620871712 to float*), float* inttoptr (i64 620806176 to float*)
  %cmp31 = icmp eq i64 %num_elems, 0
  br i1 %cmp31, label %for.end, label %for.body.preheader

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
  %arrayidx6.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %3
  %4 = load i8, i8* %arrayidx6.prol, align 1
  %5 = add nuw nsw i64 %1, 2
  %arrayidx9.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %5
  %6 = load i8, i8* %arrayidx9.prol, align 1
  %conv11.prol = uitofp i8 %2 to float
  %mul12.prol = fmul float %conv11.prol, 0x3FCB367A00000000
  %conv14.prol = uitofp i8 %4 to float
  %mul15.prol = fmul float %conv14.prol, 0x3FE6E2EB20000000
  %add16.prol = fadd float %mul12.prol, %mul15.prol
  %conv18.prol = uitofp i8 %6 to float
  %mul19.prol = fmul float %conv18.prol, 0x3FB27BB300000000
  %add20.prol = fadd float %add16.prol, %mul19.prol
  %conv21.prol = fptoui float %add20.prol to i8
  %conv22.prol = uitofp i8 %conv21.prol to float
  %arrayidx24.prol = getelementptr inbounds float, float* %., i64 %indvars.iv.prol
  store float %conv22.prol, float* %arrayidx24.prol, align 4
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
  %arrayidx6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %10
  %11 = load i8, i8* %arrayidx6, align 1
  %12 = add nuw nsw i64 %8, 2
  %arrayidx9 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %12
  %13 = load i8, i8* %arrayidx9, align 1
  %conv11 = uitofp i8 %9 to float
  %mul12 = fmul float %conv11, 0x3FCB367A00000000
  %conv14 = uitofp i8 %11 to float
  %mul15 = fmul float %conv14, 0x3FE6E2EB20000000
  %add16 = fadd float %mul12, %mul15
  %conv18 = uitofp i8 %13 to float
  %mul19 = fmul float %conv18, 0x3FB27BB300000000
  %add20 = fadd float %add16, %mul19
  %conv21 = fptoui float %add20 to i8
  %conv22 = uitofp i8 %conv21 to float
  %arrayidx24 = getelementptr inbounds float, float* %., i64 %indvars.iv
  store float %conv22, float* %arrayidx24, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %14 = mul nuw nsw i64 %indvars.iv.next, 3
  %arrayidx.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %14
  %15 = load i8, i8* %arrayidx.1, align 1
  %16 = add nuw nsw i64 %14, 1
  %arrayidx6.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %16
  %17 = load i8, i8* %arrayidx6.1, align 1
  %18 = add nuw nsw i64 %14, 2
  %arrayidx9.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %18
  %19 = load i8, i8* %arrayidx9.1, align 1
  %conv11.1 = uitofp i8 %15 to float
  %mul12.1 = fmul float %conv11.1, 0x3FCB367A00000000
  %conv14.1 = uitofp i8 %17 to float
  %mul15.1 = fmul float %conv14.1, 0x3FE6E2EB20000000
  %add16.1 = fadd float %mul12.1, %mul15.1
  %conv18.1 = uitofp i8 %19 to float
  %mul19.1 = fmul float %conv18.1, 0x3FB27BB300000000
  %add20.1 = fadd float %add16.1, %mul19.1
  %conv21.1 = fptoui float %add20.1 to i8
  %conv22.1 = uitofp i8 %conv21.1 to float
  %arrayidx24.1 = getelementptr inbounds float, float* %., i64 %indvars.iv.next
  store float %conv22.1, float* %arrayidx24.1, align 4
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %20 = mul nuw nsw i64 %indvars.iv.next.1, 3
  %arrayidx.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %20
  %21 = load i8, i8* %arrayidx.2, align 1
  %22 = add nuw nsw i64 %20, 1
  %arrayidx6.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %22
  %23 = load i8, i8* %arrayidx6.2, align 1
  %24 = add nuw nsw i64 %20, 2
  %arrayidx9.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %24
  %25 = load i8, i8* %arrayidx9.2, align 1
  %conv11.2 = uitofp i8 %21 to float
  %mul12.2 = fmul float %conv11.2, 0x3FCB367A00000000
  %conv14.2 = uitofp i8 %23 to float
  %mul15.2 = fmul float %conv14.2, 0x3FE6E2EB20000000
  %add16.2 = fadd float %mul12.2, %mul15.2
  %conv18.2 = uitofp i8 %25 to float
  %mul19.2 = fmul float %conv18.2, 0x3FB27BB300000000
  %add20.2 = fadd float %add16.2, %mul19.2
  %conv21.2 = fptoui float %add20.2 to i8
  %conv22.2 = uitofp i8 %conv21.2 to float
  %arrayidx24.2 = getelementptr inbounds float, float* %., i64 %indvars.iv.next.1
  store float %conv22.2, float* %arrayidx24.2, align 4
  %indvars.iv.next.2 = add nsw i64 %indvars.iv, 3
  %26 = mul nuw nsw i64 %indvars.iv.next.2, 3
  %arrayidx.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %26
  %27 = load i8, i8* %arrayidx.3, align 1
  %28 = add nuw nsw i64 %26, 1
  %arrayidx6.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %28
  %29 = load i8, i8* %arrayidx6.3, align 1
  %30 = add nuw nsw i64 %26, 2
  %arrayidx9.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %30
  %31 = load i8, i8* %arrayidx9.3, align 1
  %conv11.3 = uitofp i8 %27 to float
  %mul12.3 = fmul float %conv11.3, 0x3FCB367A00000000
  %conv14.3 = uitofp i8 %29 to float
  %mul15.3 = fmul float %conv14.3, 0x3FE6E2EB20000000
  %add16.3 = fadd float %mul12.3, %mul15.3
  %conv18.3 = uitofp i8 %31 to float
  %mul19.3 = fmul float %conv18.3, 0x3FB27BB300000000
  %add20.3 = fadd float %add16.3, %mul19.3
  %conv21.3 = fptoui float %add20.3 to i8
  %conv22.3 = uitofp i8 %conv21.3 to float
  %arrayidx24.3 = getelementptr inbounds float, float* %., i64 %indvars.iv.next.2
  store float %conv22.3, float* %arrayidx24.3, align 4
  %indvars.iv.next.3 = add nsw i64 %indvars.iv, 4
  %32 = mul nuw nsw i64 %indvars.iv.next.3, 3
  %arrayidx.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %32
  %33 = load i8, i8* %arrayidx.4, align 1
  %34 = add nuw nsw i64 %32, 1
  %arrayidx6.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %34
  %35 = load i8, i8* %arrayidx6.4, align 1
  %36 = add nuw nsw i64 %32, 2
  %arrayidx9.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %36
  %37 = load i8, i8* %arrayidx9.4, align 1
  %conv11.4 = uitofp i8 %33 to float
  %mul12.4 = fmul float %conv11.4, 0x3FCB367A00000000
  %conv14.4 = uitofp i8 %35 to float
  %mul15.4 = fmul float %conv14.4, 0x3FE6E2EB20000000
  %add16.4 = fadd float %mul12.4, %mul15.4
  %conv18.4 = uitofp i8 %37 to float
  %mul19.4 = fmul float %conv18.4, 0x3FB27BB300000000
  %add20.4 = fadd float %add16.4, %mul19.4
  %conv21.4 = fptoui float %add20.4 to i8
  %conv22.4 = uitofp i8 %conv21.4 to float
  %arrayidx24.4 = getelementptr inbounds float, float* %., i64 %indvars.iv.next.3
  store float %conv22.4, float* %arrayidx24.4, align 4
  %indvars.iv.next.4 = add nsw i64 %indvars.iv, 5
  %38 = mul nuw nsw i64 %indvars.iv.next.4, 3
  %arrayidx.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %38
  %39 = load i8, i8* %arrayidx.5, align 1
  %40 = add nuw nsw i64 %38, 1
  %arrayidx6.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %40
  %41 = load i8, i8* %arrayidx6.5, align 1
  %42 = add nuw nsw i64 %38, 2
  %arrayidx9.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %42
  %43 = load i8, i8* %arrayidx9.5, align 1
  %conv11.5 = uitofp i8 %39 to float
  %mul12.5 = fmul float %conv11.5, 0x3FCB367A00000000
  %conv14.5 = uitofp i8 %41 to float
  %mul15.5 = fmul float %conv14.5, 0x3FE6E2EB20000000
  %add16.5 = fadd float %mul12.5, %mul15.5
  %conv18.5 = uitofp i8 %43 to float
  %mul19.5 = fmul float %conv18.5, 0x3FB27BB300000000
  %add20.5 = fadd float %add16.5, %mul19.5
  %conv21.5 = fptoui float %add20.5 to i8
  %conv22.5 = uitofp i8 %conv21.5 to float
  %arrayidx24.5 = getelementptr inbounds float, float* %., i64 %indvars.iv.next.4
  store float %conv22.5, float* %arrayidx24.5, align 4
  %indvars.iv.next.5 = add nsw i64 %indvars.iv, 6
  %44 = mul nuw nsw i64 %indvars.iv.next.5, 3
  %arrayidx.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %44
  %45 = load i8, i8* %arrayidx.6, align 1
  %46 = add nuw nsw i64 %44, 1
  %arrayidx6.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %46
  %47 = load i8, i8* %arrayidx6.6, align 1
  %48 = add nuw nsw i64 %44, 2
  %arrayidx9.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %48
  %49 = load i8, i8* %arrayidx9.6, align 1
  %conv11.6 = uitofp i8 %45 to float
  %mul12.6 = fmul float %conv11.6, 0x3FCB367A00000000
  %conv14.6 = uitofp i8 %47 to float
  %mul15.6 = fmul float %conv14.6, 0x3FE6E2EB20000000
  %add16.6 = fadd float %mul12.6, %mul15.6
  %conv18.6 = uitofp i8 %49 to float
  %mul19.6 = fmul float %conv18.6, 0x3FB27BB300000000
  %add20.6 = fadd float %add16.6, %mul19.6
  %conv21.6 = fptoui float %add20.6 to i8
  %conv22.6 = uitofp i8 %conv21.6 to float
  %arrayidx24.6 = getelementptr inbounds float, float* %., i64 %indvars.iv.next.5
  store float %conv22.6, float* %arrayidx24.6, align 4
  %indvars.iv.next.6 = add nsw i64 %indvars.iv, 7
  %50 = mul nuw nsw i64 %indvars.iv.next.6, 3
  %arrayidx.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %50
  %51 = load i8, i8* %arrayidx.7, align 1
  %52 = add nuw nsw i64 %50, 1
  %arrayidx6.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %52
  %53 = load i8, i8* %arrayidx6.7, align 1
  %54 = add nuw nsw i64 %50, 2
  %arrayidx9.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %54
  %55 = load i8, i8* %arrayidx9.7, align 1
  %conv11.7 = uitofp i8 %51 to float
  %mul12.7 = fmul float %conv11.7, 0x3FCB367A00000000
  %conv14.7 = uitofp i8 %53 to float
  %mul15.7 = fmul float %conv14.7, 0x3FE6E2EB20000000
  %add16.7 = fadd float %mul12.7, %mul15.7
  %conv18.7 = uitofp i8 %55 to float
  %mul19.7 = fmul float %conv18.7, 0x3FB27BB300000000
  %add20.7 = fadd float %add16.7, %mul19.7
  %conv21.7 = fptoui float %add20.7 to i8
  %conv22.7 = uitofp i8 %conv21.7 to float
  %arrayidx24.7 = getelementptr inbounds float, float* %., i64 %indvars.iv.next.6
  store float %conv22.7, float* %arrayidx24.7, align 4
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
