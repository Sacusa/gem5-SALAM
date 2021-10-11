; ModuleID = 'grayscale0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @grayscale(i64 %num_elems, i32 %output_spm_addr) #0 {
entry:
  %conv = zext i32 %output_spm_addr to i64
  %0 = inttoptr i64 %conv to float*
  %cmp1 = icmp eq i64 %num_elems, 0
  br i1 %cmp1, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  %1 = add i64 %num_elems, -1
  %xtraiter = and i64 %num_elems, 7
  %lcmp.mod = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod, label %for.body.preheader.split, label %for.body.prol.preheader

for.body.prol.preheader:                          ; preds = %for.body.preheader
  br label %for.body.prol

for.body.prol:                                    ; preds = %for.body.prol.preheader, %for.body.prol
  %indvars.iv.prol = phi i64 [ %indvars.iv.next.prol, %for.body.prol ], [ 0, %for.body.prol.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %for.body.prol ], [ %xtraiter, %for.body.prol.preheader ]
  %2 = mul nuw nsw i64 %indvars.iv.prol, 3
  %arrayidx.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %2
  %3 = load i8, i8* %arrayidx.prol, align 1
  %4 = add nuw nsw i64 %2, 1
  %arrayidx4.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %4
  %5 = load i8, i8* %arrayidx4.prol, align 1
  %6 = add nuw nsw i64 %2, 2
  %arrayidx7.prol = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %6
  %7 = load i8, i8* %arrayidx7.prol, align 1
  %conv9.prol = uitofp i8 %3 to float
  %mul10.prol = fmul float %conv9.prol, 0x3FCB367A00000000
  %conv12.prol = uitofp i8 %5 to float
  %mul13.prol = fmul float %conv12.prol, 0x3FE6E2EB20000000
  %add14.prol = fadd float %mul10.prol, %mul13.prol
  %conv16.prol = uitofp i8 %7 to float
  %mul17.prol = fmul float %conv16.prol, 0x3FB27BB300000000
  %add18.prol = fadd float %add14.prol, %mul17.prol
  %conv19.prol = fptoui float %add18.prol to i8
  %conv20.prol = uitofp i8 %conv19.prol to float
  %arrayidx22.prol = getelementptr inbounds float, float* %0, i64 %indvars.iv.prol
  store float %conv20.prol, float* %arrayidx22.prol, align 4
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.body.preheader.split.loopexit, label %for.body.prol, !llvm.loop !1

for.body.preheader.split.loopexit:                ; preds = %for.body.prol
  %indvars.iv.next.prol.lcssa = phi i64 [ %indvars.iv.next.prol, %for.body.prol ]
  br label %for.body.preheader.split

for.body.preheader.split:                         ; preds = %for.body.preheader.split.loopexit, %for.body.preheader
  %indvars.iv.unr = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next.prol.lcssa, %for.body.preheader.split.loopexit ]
  %8 = icmp ult i64 %1, 7
  br i1 %8, label %for.end, label %for.body.preheader10

for.body.preheader10:                             ; preds = %for.body.preheader.split
  br label %for.body

for.body:                                         ; preds = %for.body.preheader10, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next.7, %for.body ], [ %indvars.iv.unr, %for.body.preheader10 ]
  %9 = mul nuw nsw i64 %indvars.iv, 3
  %arrayidx = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %9
  %10 = load i8, i8* %arrayidx, align 1
  %11 = add nuw nsw i64 %9, 1
  %arrayidx4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %11
  %12 = load i8, i8* %arrayidx4, align 1
  %13 = add nuw nsw i64 %9, 2
  %arrayidx7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %13
  %14 = load i8, i8* %arrayidx7, align 1
  %conv9 = uitofp i8 %10 to float
  %mul10 = fmul float %conv9, 0x3FCB367A00000000
  %conv12 = uitofp i8 %12 to float
  %mul13 = fmul float %conv12, 0x3FE6E2EB20000000
  %add14 = fadd float %mul10, %mul13
  %conv16 = uitofp i8 %14 to float
  %mul17 = fmul float %conv16, 0x3FB27BB300000000
  %add18 = fadd float %add14, %mul17
  %conv19 = fptoui float %add18 to i8
  %conv20 = uitofp i8 %conv19 to float
  %arrayidx22 = getelementptr inbounds float, float* %0, i64 %indvars.iv
  store float %conv20, float* %arrayidx22, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %15 = mul nuw nsw i64 %indvars.iv.next, 3
  %arrayidx.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %15
  %16 = load i8, i8* %arrayidx.1, align 1
  %17 = add nuw nsw i64 %15, 1
  %arrayidx4.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %17
  %18 = load i8, i8* %arrayidx4.1, align 1
  %19 = add nuw nsw i64 %15, 2
  %arrayidx7.1 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %19
  %20 = load i8, i8* %arrayidx7.1, align 1
  %conv9.1 = uitofp i8 %16 to float
  %mul10.1 = fmul float %conv9.1, 0x3FCB367A00000000
  %conv12.1 = uitofp i8 %18 to float
  %mul13.1 = fmul float %conv12.1, 0x3FE6E2EB20000000
  %add14.1 = fadd float %mul10.1, %mul13.1
  %conv16.1 = uitofp i8 %20 to float
  %mul17.1 = fmul float %conv16.1, 0x3FB27BB300000000
  %add18.1 = fadd float %add14.1, %mul17.1
  %conv19.1 = fptoui float %add18.1 to i8
  %conv20.1 = uitofp i8 %conv19.1 to float
  %arrayidx22.1 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next
  store float %conv20.1, float* %arrayidx22.1, align 4
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %21 = mul nuw nsw i64 %indvars.iv.next.1, 3
  %arrayidx.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %21
  %22 = load i8, i8* %arrayidx.2, align 1
  %23 = add nuw nsw i64 %21, 1
  %arrayidx4.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %23
  %24 = load i8, i8* %arrayidx4.2, align 1
  %25 = add nuw nsw i64 %21, 2
  %arrayidx7.2 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %25
  %26 = load i8, i8* %arrayidx7.2, align 1
  %conv9.2 = uitofp i8 %22 to float
  %mul10.2 = fmul float %conv9.2, 0x3FCB367A00000000
  %conv12.2 = uitofp i8 %24 to float
  %mul13.2 = fmul float %conv12.2, 0x3FE6E2EB20000000
  %add14.2 = fadd float %mul10.2, %mul13.2
  %conv16.2 = uitofp i8 %26 to float
  %mul17.2 = fmul float %conv16.2, 0x3FB27BB300000000
  %add18.2 = fadd float %add14.2, %mul17.2
  %conv19.2 = fptoui float %add18.2 to i8
  %conv20.2 = uitofp i8 %conv19.2 to float
  %arrayidx22.2 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.1
  store float %conv20.2, float* %arrayidx22.2, align 4
  %indvars.iv.next.2 = add nsw i64 %indvars.iv, 3
  %27 = mul nuw nsw i64 %indvars.iv.next.2, 3
  %arrayidx.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %27
  %28 = load i8, i8* %arrayidx.3, align 1
  %29 = add nuw nsw i64 %27, 1
  %arrayidx4.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %29
  %30 = load i8, i8* %arrayidx4.3, align 1
  %31 = add nuw nsw i64 %27, 2
  %arrayidx7.3 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %31
  %32 = load i8, i8* %arrayidx7.3, align 1
  %conv9.3 = uitofp i8 %28 to float
  %mul10.3 = fmul float %conv9.3, 0x3FCB367A00000000
  %conv12.3 = uitofp i8 %30 to float
  %mul13.3 = fmul float %conv12.3, 0x3FE6E2EB20000000
  %add14.3 = fadd float %mul10.3, %mul13.3
  %conv16.3 = uitofp i8 %32 to float
  %mul17.3 = fmul float %conv16.3, 0x3FB27BB300000000
  %add18.3 = fadd float %add14.3, %mul17.3
  %conv19.3 = fptoui float %add18.3 to i8
  %conv20.3 = uitofp i8 %conv19.3 to float
  %arrayidx22.3 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.2
  store float %conv20.3, float* %arrayidx22.3, align 4
  %indvars.iv.next.3 = add nsw i64 %indvars.iv, 4
  %33 = mul nuw nsw i64 %indvars.iv.next.3, 3
  %arrayidx.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %33
  %34 = load i8, i8* %arrayidx.4, align 1
  %35 = add nuw nsw i64 %33, 1
  %arrayidx4.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %35
  %36 = load i8, i8* %arrayidx4.4, align 1
  %37 = add nuw nsw i64 %33, 2
  %arrayidx7.4 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %37
  %38 = load i8, i8* %arrayidx7.4, align 1
  %conv9.4 = uitofp i8 %34 to float
  %mul10.4 = fmul float %conv9.4, 0x3FCB367A00000000
  %conv12.4 = uitofp i8 %36 to float
  %mul13.4 = fmul float %conv12.4, 0x3FE6E2EB20000000
  %add14.4 = fadd float %mul10.4, %mul13.4
  %conv16.4 = uitofp i8 %38 to float
  %mul17.4 = fmul float %conv16.4, 0x3FB27BB300000000
  %add18.4 = fadd float %add14.4, %mul17.4
  %conv19.4 = fptoui float %add18.4 to i8
  %conv20.4 = uitofp i8 %conv19.4 to float
  %arrayidx22.4 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.3
  store float %conv20.4, float* %arrayidx22.4, align 4
  %indvars.iv.next.4 = add nsw i64 %indvars.iv, 5
  %39 = mul nuw nsw i64 %indvars.iv.next.4, 3
  %arrayidx.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %39
  %40 = load i8, i8* %arrayidx.5, align 1
  %41 = add nuw nsw i64 %39, 1
  %arrayidx4.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %41
  %42 = load i8, i8* %arrayidx4.5, align 1
  %43 = add nuw nsw i64 %39, 2
  %arrayidx7.5 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %43
  %44 = load i8, i8* %arrayidx7.5, align 1
  %conv9.5 = uitofp i8 %40 to float
  %mul10.5 = fmul float %conv9.5, 0x3FCB367A00000000
  %conv12.5 = uitofp i8 %42 to float
  %mul13.5 = fmul float %conv12.5, 0x3FE6E2EB20000000
  %add14.5 = fadd float %mul10.5, %mul13.5
  %conv16.5 = uitofp i8 %44 to float
  %mul17.5 = fmul float %conv16.5, 0x3FB27BB300000000
  %add18.5 = fadd float %add14.5, %mul17.5
  %conv19.5 = fptoui float %add18.5 to i8
  %conv20.5 = uitofp i8 %conv19.5 to float
  %arrayidx22.5 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.4
  store float %conv20.5, float* %arrayidx22.5, align 4
  %indvars.iv.next.5 = add nsw i64 %indvars.iv, 6
  %45 = mul nuw nsw i64 %indvars.iv.next.5, 3
  %arrayidx.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %45
  %46 = load i8, i8* %arrayidx.6, align 1
  %47 = add nuw nsw i64 %45, 1
  %arrayidx4.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %47
  %48 = load i8, i8* %arrayidx4.6, align 1
  %49 = add nuw nsw i64 %45, 2
  %arrayidx7.6 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %49
  %50 = load i8, i8* %arrayidx7.6, align 1
  %conv9.6 = uitofp i8 %46 to float
  %mul10.6 = fmul float %conv9.6, 0x3FCB367A00000000
  %conv12.6 = uitofp i8 %48 to float
  %mul13.6 = fmul float %conv12.6, 0x3FE6E2EB20000000
  %add14.6 = fadd float %mul10.6, %mul13.6
  %conv16.6 = uitofp i8 %50 to float
  %mul17.6 = fmul float %conv16.6, 0x3FB27BB300000000
  %add18.6 = fadd float %add14.6, %mul17.6
  %conv19.6 = fptoui float %add18.6 to i8
  %conv20.6 = uitofp i8 %conv19.6 to float
  %arrayidx22.6 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.5
  store float %conv20.6, float* %arrayidx22.6, align 4
  %indvars.iv.next.6 = add nsw i64 %indvars.iv, 7
  %51 = mul nuw nsw i64 %indvars.iv.next.6, 3
  %arrayidx.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %51
  %52 = load i8, i8* %arrayidx.7, align 1
  %53 = add nuw nsw i64 %51, 1
  %arrayidx4.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %53
  %54 = load i8, i8* %arrayidx4.7, align 1
  %55 = add nuw nsw i64 %51, 2
  %arrayidx7.7 = getelementptr inbounds i8, i8* inttoptr (i64 620757024 to i8*), i64 %55
  %56 = load i8, i8* %arrayidx7.7, align 1
  %conv9.7 = uitofp i8 %52 to float
  %mul10.7 = fmul float %conv9.7, 0x3FCB367A00000000
  %conv12.7 = uitofp i8 %54 to float
  %mul13.7 = fmul float %conv12.7, 0x3FE6E2EB20000000
  %add14.7 = fadd float %mul10.7, %mul13.7
  %conv16.7 = uitofp i8 %56 to float
  %mul17.7 = fmul float %conv16.7, 0x3FB27BB300000000
  %add18.7 = fadd float %add14.7, %mul17.7
  %conv19.7 = fptoui float %add18.7 to i8
  %conv20.7 = uitofp i8 %conv19.7 to float
  %arrayidx22.7 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.6
  store float %conv20.7, float* %arrayidx22.7, align 4
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
