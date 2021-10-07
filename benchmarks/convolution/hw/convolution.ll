; ModuleID = 'convolution.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @convolution(i32 %img_height, i32 %img_width, i32 %kern_height, i32 %kern_width, i8 zeroext %mod_and_floor) #0 {
entry:
  %sub2 = add i32 %kern_width, -1
  %div3 = lshr i32 %sub2, 1
  %sub4 = sub nsw i32 0, %div3
  %cmp14 = icmp eq i32 %img_height, 0
  br i1 %cmp14, label %for.end60, label %for.cond5.preheader.lr.ph

for.cond5.preheader.lr.ph:                        ; preds = %entry
  %sub = add i32 %kern_height, -1
  %div = lshr i32 %sub, 1
  %sub1 = sub nsw i32 0, %div
  %cmp610 = icmp eq i32 %img_width, 0
  %cmp94 = icmp eq i32 %kern_height, 0
  %tobool39 = icmp eq i8 %mod_and_floor, 0
  %0 = add i32 %img_width, -1
  %xtraiter = and i32 %img_width, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  %1 = icmp ult i32 %0, 31
  %cmp151.not.31 = icmp eq i32 %kern_width, 0
  %cmp151.not.30 = icmp eq i32 %kern_width, 0
  %cmp151.not.29 = icmp eq i32 %kern_width, 0
  %cmp151.not.28 = icmp eq i32 %kern_width, 0
  %cmp151.not.27 = icmp eq i32 %kern_width, 0
  %cmp151.not.26 = icmp eq i32 %kern_width, 0
  %cmp151.not.25 = icmp eq i32 %kern_width, 0
  %cmp151.not.24 = icmp eq i32 %kern_width, 0
  %cmp151.not.23 = icmp eq i32 %kern_width, 0
  %cmp151.not.22 = icmp eq i32 %kern_width, 0
  %cmp151.not.21 = icmp eq i32 %kern_width, 0
  %cmp151.not.20 = icmp eq i32 %kern_width, 0
  %cmp151.not.19 = icmp eq i32 %kern_width, 0
  %cmp151.not.18 = icmp eq i32 %kern_width, 0
  %cmp151.not.17 = icmp eq i32 %kern_width, 0
  %cmp151.not.16 = icmp eq i32 %kern_width, 0
  %cmp151.not.15 = icmp eq i32 %kern_width, 0
  %cmp151.not.14 = icmp eq i32 %kern_width, 0
  %cmp151.not.13 = icmp eq i32 %kern_width, 0
  %cmp151.not.12 = icmp eq i32 %kern_width, 0
  %cmp151.not.11 = icmp eq i32 %kern_width, 0
  %cmp151.not.10 = icmp eq i32 %kern_width, 0
  %cmp151.not.9 = icmp eq i32 %kern_width, 0
  %cmp151.not.8 = icmp eq i32 %kern_width, 0
  %cmp151.not.7 = icmp eq i32 %kern_width, 0
  %cmp151.not.6 = icmp eq i32 %kern_width, 0
  %cmp151.not.5 = icmp eq i32 %kern_width, 0
  %cmp151.not.4 = icmp eq i32 %kern_width, 0
  %cmp151.not.3 = icmp eq i32 %kern_width, 0
  %cmp151.not.2 = icmp eq i32 %kern_width, 0
  %cmp151.not.1 = icmp eq i32 %kern_width, 0
  %cmp151.not = icmp eq i32 %kern_width, 0
  %cmp151.not.prol = icmp eq i32 %kern_width, 0
  br label %for.cond5.preheader

for.cond5.preheader:                              ; preds = %for.inc57, %for.cond5.preheader.lr.ph
  %indvars.iv26 = phi i64 [ 0, %for.cond5.preheader.lr.ph ], [ %indvars.iv.next27, %for.inc57 ]
  %in_i.015 = phi i32 [ %sub1, %for.cond5.preheader.lr.ph ], [ %inc58, %for.inc57 ]
  br i1 %cmp610, label %for.inc57, label %for.cond8.preheader.lr.ph

for.cond8.preheader.lr.ph:                        ; preds = %for.cond5.preheader
  %2 = trunc i64 %indvars.iv26 to i32
  %mul48 = shl i32 %2, 7
  %3 = trunc i64 %indvars.iv26 to i32
  %mul44 = shl i32 %3, 7
  %4 = sext i32 %mul48 to i64
  %5 = sext i32 %mul44 to i64
  br i1 %lcmp.mod, label %for.cond8.preheader.lr.ph.split, label %for.cond8.preheader.prol.preheader

for.cond8.preheader.prol.preheader:               ; preds = %for.cond8.preheader.lr.ph
  br label %for.cond8.preheader.prol

for.cond8.preheader.prol:                         ; preds = %for.cond8.preheader.prol.preheader, %for.inc53.prol
  %indvars.iv20.prol = phi i64 [ %indvars.iv.next21.prol, %for.inc53.prol ], [ 0, %for.cond8.preheader.prol.preheader ]
  %in_j.011.prol = phi i32 [ %inc54.prol, %for.inc53.prol ], [ %sub4, %for.cond8.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc53.prol ], [ %xtraiter, %for.cond8.preheader.prol.preheader ]
  br i1 %cmp94, label %for.end38.prol, label %for.body10.prol.preheader

for.body10.prol.preheader:                        ; preds = %for.cond8.preheader.prol
  br label %for.body10.prol

for.body10.prol:                                  ; preds = %for.body10.prol.preheader, %for.inc36.prol
  %ki.06.prol = phi i32 [ %inc37.prol, %for.inc36.prol ], [ 0, %for.body10.prol.preheader ]
  %partial_sum.05.prol = phi float [ %partial_sum.3.prol, %for.inc36.prol ], [ 0.000000e+00, %for.body10.prol.preheader ]
  %add.prol = add nsw i32 %ki.06.prol, %in_i.015
  %notlhs.prol = icmp slt i32 %add.prol, 0
  %notrhs.prol = icmp uge i32 %add.prol, %img_height
  %.not.prol = or i1 %notrhs.prol, %notlhs.prol
  %brmerge.prol = or i1 %.not.prol, %cmp151.not.prol
  br i1 %brmerge.prol, label %for.inc36.prol, label %for.body16.lr.ph.prol

for.body16.lr.ph.prol:                            ; preds = %for.body10.prol
  %mul.prol = shl i32 %add.prol, 7
  %mul30.prol = mul i32 %ki.06.prol, %kern_width
  br label %for.body16.prol

for.body16.prol:                                  ; preds = %for.inc.prol, %for.body16.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body16.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc.prol ]
  %partial_sum.12.prol = phi float [ %partial_sum.05.prol, %for.body16.lr.ph.prol ], [ %partial_sum.2.prol, %for.inc.prol ]
  %6 = trunc i64 %indvars.iv.prol to i32
  %add17.prol = add nsw i32 %6, %in_j.011.prol
  %cmp18.prol = icmp sgt i32 %add17.prol, -1
  %cmp21.prol = icmp ult i32 %add17.prol, %img_width
  %7 = and i1 %cmp18.prol, %cmp21.prol
  br i1 %7, label %if.end26.prol, label %for.inc.prol

if.end26.prol:                                    ; preds = %for.body16.prol
  %add29.prol = add nsw i32 %add17.prol, %mul.prol
  %idxprom.prol = sext i32 %add29.prol to i64
  %arrayidx.prol = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.prol
  %8 = load float, float* %arrayidx.prol, align 4
  %9 = trunc i64 %indvars.iv.prol to i32
  %add31.prol = add i32 %9, %mul30.prol
  %idxprom32.prol = zext i32 %add31.prol to i64
  %arrayidx33.prol = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.prol
  %10 = load float, float* %arrayidx33.prol, align 4
  %mul34.prol = fmul float %8, %10
  %add35.prol = fadd float %partial_sum.12.prol, %mul34.prol
  br label %for.inc.prol

for.inc.prol:                                     ; preds = %if.end26.prol, %for.body16.prol
  %partial_sum.2.prol = phi float [ %add35.prol, %if.end26.prol ], [ %partial_sum.12.prol, %for.body16.prol ]
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %kern_width
  br i1 %exitcond.prol, label %for.inc36.prol.loopexit, label %for.body16.prol, !llvm.loop !1

for.inc36.prol.loopexit:                          ; preds = %for.inc.prol
  %partial_sum.2.prol.lcssa = phi float [ %partial_sum.2.prol, %for.inc.prol ]
  br label %for.inc36.prol

for.inc36.prol:                                   ; preds = %for.inc36.prol.loopexit, %for.body10.prol
  %partial_sum.3.prol = phi float [ %partial_sum.05.prol, %for.body10.prol ], [ %partial_sum.2.prol.lcssa, %for.inc36.prol.loopexit ]
  %inc37.prol = add nuw nsw i32 %ki.06.prol, 1
  %exitcond19.prol = icmp eq i32 %inc37.prol, %kern_height
  br i1 %exitcond19.prol, label %for.end38.prol.loopexit, label %for.body10.prol, !llvm.loop !3

for.end38.prol.loopexit:                          ; preds = %for.inc36.prol
  %partial_sum.3.prol.lcssa = phi float [ %partial_sum.3.prol, %for.inc36.prol ]
  br label %for.end38.prol

for.end38.prol:                                   ; preds = %for.end38.prol.loopexit, %for.cond8.preheader.prol
  %partial_sum.0.lcssa.prol = phi float [ 0.000000e+00, %for.cond8.preheader.prol ], [ %partial_sum.3.prol.lcssa, %for.end38.prol.loopexit ]
  br i1 %tobool39, label %if.else.prol, label %if.then40.prol

if.then40.prol:                                   ; preds = %for.end38.prol
  %cmp41.prol = fcmp olt float %partial_sum.0.lcssa.prol, 0.000000e+00
  %sub42.prol = fsub float -0.000000e+00, %partial_sum.0.lcssa.prol
  %cond.prol = select i1 %cmp41.prol, float %sub42.prol, float %partial_sum.0.lcssa.prol
  %conv.prol = fptoui float %cond.prol to i8
  %conv43.prol = uitofp i8 %conv.prol to float
  %11 = add nsw i64 %indvars.iv20.prol, %5
  %arrayidx47.prol = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %11
  store float %conv43.prol, float* %arrayidx47.prol, align 4
  br label %for.inc53.prol

if.else.prol:                                     ; preds = %for.end38.prol
  %12 = add nsw i64 %indvars.iv20.prol, %4
  %arrayidx51.prol = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %12
  store float %partial_sum.0.lcssa.prol, float* %arrayidx51.prol, align 4
  br label %for.inc53.prol

for.inc53.prol:                                   ; preds = %if.else.prol, %if.then40.prol
  %inc54.prol = add nsw i32 %in_j.011.prol, 1
  %indvars.iv.next21.prol = add nuw nsw i64 %indvars.iv20.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond8.preheader.lr.ph.split.loopexit, label %for.cond8.preheader.prol, !llvm.loop !4

for.cond8.preheader.lr.ph.split.loopexit:         ; preds = %for.inc53.prol
  %indvars.iv.next21.prol.lcssa = phi i64 [ %indvars.iv.next21.prol, %for.inc53.prol ]
  %inc54.prol.lcssa = phi i32 [ %inc54.prol, %for.inc53.prol ]
  br label %for.cond8.preheader.lr.ph.split

for.cond8.preheader.lr.ph.split:                  ; preds = %for.cond8.preheader.lr.ph.split.loopexit, %for.cond8.preheader.lr.ph
  %indvars.iv20.unr = phi i64 [ 0, %for.cond8.preheader.lr.ph ], [ %indvars.iv.next21.prol.lcssa, %for.cond8.preheader.lr.ph.split.loopexit ]
  %in_j.011.unr = phi i32 [ %sub4, %for.cond8.preheader.lr.ph ], [ %inc54.prol.lcssa, %for.cond8.preheader.lr.ph.split.loopexit ]
  br i1 %1, label %for.inc57, label %for.cond8.preheader.preheader

for.cond8.preheader.preheader:                    ; preds = %for.cond8.preheader.lr.ph.split
  br label %for.cond8.preheader

for.cond8.preheader:                              ; preds = %for.cond8.preheader.preheader, %for.inc53.31
  %indvars.iv20 = phi i64 [ %indvars.iv.next21.31, %for.inc53.31 ], [ %indvars.iv20.unr, %for.cond8.preheader.preheader ]
  %in_j.011 = phi i32 [ %inc54.31, %for.inc53.31 ], [ %in_j.011.unr, %for.cond8.preheader.preheader ]
  br i1 %cmp94, label %for.end38, label %for.body10.preheader

for.body10.preheader:                             ; preds = %for.cond8.preheader
  br label %for.body10

for.body10:                                       ; preds = %for.body10.preheader, %for.inc36
  %ki.06 = phi i32 [ %inc37, %for.inc36 ], [ 0, %for.body10.preheader ]
  %partial_sum.05 = phi float [ %partial_sum.3, %for.inc36 ], [ 0.000000e+00, %for.body10.preheader ]
  %add = add nsw i32 %ki.06, %in_i.015
  %notlhs = icmp slt i32 %add, 0
  %notrhs = icmp uge i32 %add, %img_height
  %.not = or i1 %notrhs, %notlhs
  %brmerge = or i1 %.not, %cmp151.not
  br i1 %brmerge, label %for.inc36, label %for.body16.lr.ph

for.body16.lr.ph:                                 ; preds = %for.body10
  %mul = shl i32 %add, 7
  %mul30 = mul i32 %ki.06, %kern_width
  br label %for.body16

for.body16:                                       ; preds = %for.inc, %for.body16.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body16.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %partial_sum.12 = phi float [ %partial_sum.05, %for.body16.lr.ph ], [ %partial_sum.2, %for.inc ]
  %13 = trunc i64 %indvars.iv to i32
  %add17 = add nsw i32 %13, %in_j.011
  %cmp18 = icmp sgt i32 %add17, -1
  %cmp21 = icmp ult i32 %add17, %img_width
  %14 = and i1 %cmp18, %cmp21
  br i1 %14, label %if.end26, label %for.inc

if.end26:                                         ; preds = %for.body16
  %add29 = add nsw i32 %add17, %mul
  %idxprom = sext i32 %add29 to i64
  %arrayidx = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom
  %15 = load float, float* %arrayidx, align 4
  %16 = trunc i64 %indvars.iv to i32
  %add31 = add i32 %16, %mul30
  %idxprom32 = zext i32 %add31 to i64
  %arrayidx33 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32
  %17 = load float, float* %arrayidx33, align 4
  %mul34 = fmul float %15, %17
  %add35 = fadd float %partial_sum.12, %mul34
  br label %for.inc

for.inc:                                          ; preds = %for.body16, %if.end26
  %partial_sum.2 = phi float [ %add35, %if.end26 ], [ %partial_sum.12, %for.body16 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %kern_width
  br i1 %exitcond, label %for.inc36.loopexit, label %for.body16, !llvm.loop !1

for.inc36.loopexit:                               ; preds = %for.inc
  %partial_sum.2.lcssa = phi float [ %partial_sum.2, %for.inc ]
  br label %for.inc36

for.inc36:                                        ; preds = %for.inc36.loopexit, %for.body10
  %partial_sum.3 = phi float [ %partial_sum.05, %for.body10 ], [ %partial_sum.2.lcssa, %for.inc36.loopexit ]
  %inc37 = add nuw nsw i32 %ki.06, 1
  %exitcond19 = icmp eq i32 %inc37, %kern_height
  br i1 %exitcond19, label %for.end38.loopexit, label %for.body10, !llvm.loop !3

for.end38.loopexit:                               ; preds = %for.inc36
  %partial_sum.3.lcssa = phi float [ %partial_sum.3, %for.inc36 ]
  br label %for.end38

for.end38:                                        ; preds = %for.end38.loopexit, %for.cond8.preheader
  %partial_sum.0.lcssa = phi float [ 0.000000e+00, %for.cond8.preheader ], [ %partial_sum.3.lcssa, %for.end38.loopexit ]
  br i1 %tobool39, label %if.else, label %if.then40

if.then40:                                        ; preds = %for.end38
  %cmp41 = fcmp olt float %partial_sum.0.lcssa, 0.000000e+00
  %sub42 = fsub float -0.000000e+00, %partial_sum.0.lcssa
  %cond = select i1 %cmp41, float %sub42, float %partial_sum.0.lcssa
  %conv = fptoui float %cond to i8
  %conv43 = uitofp i8 %conv to float
  %18 = add nsw i64 %indvars.iv20, %5
  %arrayidx47 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %18
  store float %conv43, float* %arrayidx47, align 4
  br label %for.inc53

if.else:                                          ; preds = %for.end38
  %19 = add nsw i64 %indvars.iv20, %4
  %arrayidx51 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %19
  store float %partial_sum.0.lcssa, float* %arrayidx51, align 4
  br label %for.inc53

for.inc53:                                        ; preds = %if.then40, %if.else
  %inc54 = add nsw i32 %in_j.011, 1
  %indvars.iv.next21 = add nuw nsw i64 %indvars.iv20, 1
  br i1 %cmp94, label %for.end38.1, label %for.body10.1.preheader

for.body10.1.preheader:                           ; preds = %for.inc53
  br label %for.body10.1

for.inc57.loopexit:                               ; preds = %for.inc53.31
  br label %for.inc57

for.inc57:                                        ; preds = %for.inc57.loopexit, %for.cond8.preheader.lr.ph.split, %for.cond5.preheader
  %inc58 = add nsw i32 %in_i.015, 1
  %indvars.iv.next27 = add nuw nsw i64 %indvars.iv26, 1
  %lftr.wideiv28 = trunc i64 %indvars.iv.next27 to i32
  %exitcond29 = icmp eq i32 %lftr.wideiv28, %img_height
  br i1 %exitcond29, label %for.end60.loopexit, label %for.cond5.preheader, !llvm.loop !5

for.end60.loopexit:                               ; preds = %for.inc57
  br label %for.end60

for.end60:                                        ; preds = %for.end60.loopexit, %entry
  ret void

for.body10.1:                                     ; preds = %for.body10.1.preheader, %for.inc36.1
  %ki.06.1 = phi i32 [ %inc37.1, %for.inc36.1 ], [ 0, %for.body10.1.preheader ]
  %partial_sum.05.1 = phi float [ %partial_sum.3.1, %for.inc36.1 ], [ 0.000000e+00, %for.body10.1.preheader ]
  %add.1 = add nsw i32 %ki.06.1, %in_i.015
  %notlhs.1 = icmp slt i32 %add.1, 0
  %notrhs.1 = icmp uge i32 %add.1, %img_height
  %.not.1 = or i1 %notrhs.1, %notlhs.1
  %brmerge.1 = or i1 %.not.1, %cmp151.not.1
  br i1 %brmerge.1, label %for.inc36.1, label %for.body16.lr.ph.1

for.body16.lr.ph.1:                               ; preds = %for.body10.1
  %mul.1 = shl i32 %add.1, 7
  %mul30.1 = mul i32 %ki.06.1, %kern_width
  br label %for.body16.1

for.body16.1:                                     ; preds = %for.inc.1, %for.body16.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body16.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc.1 ]
  %partial_sum.12.1 = phi float [ %partial_sum.05.1, %for.body16.lr.ph.1 ], [ %partial_sum.2.1, %for.inc.1 ]
  %20 = trunc i64 %indvars.iv.1 to i32
  %add17.1 = add nsw i32 %20, %inc54
  %cmp18.1 = icmp sgt i32 %add17.1, -1
  %cmp21.1 = icmp ult i32 %add17.1, %img_width
  %21 = and i1 %cmp18.1, %cmp21.1
  br i1 %21, label %if.end26.1, label %for.inc.1

if.end26.1:                                       ; preds = %for.body16.1
  %add29.1 = add nsw i32 %add17.1, %mul.1
  %idxprom.1 = sext i32 %add29.1 to i64
  %arrayidx.1 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.1
  %22 = load float, float* %arrayidx.1, align 4
  %23 = trunc i64 %indvars.iv.1 to i32
  %add31.1 = add i32 %23, %mul30.1
  %idxprom32.1 = zext i32 %add31.1 to i64
  %arrayidx33.1 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.1
  %24 = load float, float* %arrayidx33.1, align 4
  %mul34.1 = fmul float %22, %24
  %add35.1 = fadd float %partial_sum.12.1, %mul34.1
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.end26.1, %for.body16.1
  %partial_sum.2.1 = phi float [ %add35.1, %if.end26.1 ], [ %partial_sum.12.1, %for.body16.1 ]
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %kern_width
  br i1 %exitcond.1, label %for.inc36.1.loopexit, label %for.body16.1, !llvm.loop !1

for.inc36.1.loopexit:                             ; preds = %for.inc.1
  %partial_sum.2.1.lcssa = phi float [ %partial_sum.2.1, %for.inc.1 ]
  br label %for.inc36.1

for.inc36.1:                                      ; preds = %for.inc36.1.loopexit, %for.body10.1
  %partial_sum.3.1 = phi float [ %partial_sum.05.1, %for.body10.1 ], [ %partial_sum.2.1.lcssa, %for.inc36.1.loopexit ]
  %inc37.1 = add nuw nsw i32 %ki.06.1, 1
  %exitcond19.1 = icmp eq i32 %inc37.1, %kern_height
  br i1 %exitcond19.1, label %for.end38.1.loopexit, label %for.body10.1, !llvm.loop !3

for.end38.1.loopexit:                             ; preds = %for.inc36.1
  %partial_sum.3.1.lcssa = phi float [ %partial_sum.3.1, %for.inc36.1 ]
  br label %for.end38.1

for.end38.1:                                      ; preds = %for.end38.1.loopexit, %for.inc53
  %partial_sum.0.lcssa.1 = phi float [ 0.000000e+00, %for.inc53 ], [ %partial_sum.3.1.lcssa, %for.end38.1.loopexit ]
  br i1 %tobool39, label %if.else.1, label %if.then40.1

if.then40.1:                                      ; preds = %for.end38.1
  %cmp41.1 = fcmp olt float %partial_sum.0.lcssa.1, 0.000000e+00
  %sub42.1 = fsub float -0.000000e+00, %partial_sum.0.lcssa.1
  %cond.1 = select i1 %cmp41.1, float %sub42.1, float %partial_sum.0.lcssa.1
  %conv.1 = fptoui float %cond.1 to i8
  %conv43.1 = uitofp i8 %conv.1 to float
  %25 = add nsw i64 %indvars.iv.next21, %5
  %arrayidx47.1 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %25
  store float %conv43.1, float* %arrayidx47.1, align 4
  br label %for.inc53.1

if.else.1:                                        ; preds = %for.end38.1
  %26 = add nsw i64 %indvars.iv.next21, %4
  %arrayidx51.1 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %26
  store float %partial_sum.0.lcssa.1, float* %arrayidx51.1, align 4
  br label %for.inc53.1

for.inc53.1:                                      ; preds = %if.else.1, %if.then40.1
  %inc54.1 = add nsw i32 %in_j.011, 2
  %indvars.iv.next21.1 = add nsw i64 %indvars.iv20, 2
  br i1 %cmp94, label %for.end38.2, label %for.body10.2.preheader

for.body10.2.preheader:                           ; preds = %for.inc53.1
  br label %for.body10.2

for.body10.2:                                     ; preds = %for.body10.2.preheader, %for.inc36.2
  %ki.06.2 = phi i32 [ %inc37.2, %for.inc36.2 ], [ 0, %for.body10.2.preheader ]
  %partial_sum.05.2 = phi float [ %partial_sum.3.2, %for.inc36.2 ], [ 0.000000e+00, %for.body10.2.preheader ]
  %add.2 = add nsw i32 %ki.06.2, %in_i.015
  %notlhs.2 = icmp slt i32 %add.2, 0
  %notrhs.2 = icmp uge i32 %add.2, %img_height
  %.not.2 = or i1 %notrhs.2, %notlhs.2
  %brmerge.2 = or i1 %.not.2, %cmp151.not.2
  br i1 %brmerge.2, label %for.inc36.2, label %for.body16.lr.ph.2

for.body16.lr.ph.2:                               ; preds = %for.body10.2
  %mul.2 = shl i32 %add.2, 7
  %mul30.2 = mul i32 %ki.06.2, %kern_width
  br label %for.body16.2

for.body16.2:                                     ; preds = %for.inc.2, %for.body16.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body16.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc.2 ]
  %partial_sum.12.2 = phi float [ %partial_sum.05.2, %for.body16.lr.ph.2 ], [ %partial_sum.2.2, %for.inc.2 ]
  %27 = trunc i64 %indvars.iv.2 to i32
  %add17.2 = add nsw i32 %27, %inc54.1
  %cmp18.2 = icmp sgt i32 %add17.2, -1
  %cmp21.2 = icmp ult i32 %add17.2, %img_width
  %28 = and i1 %cmp18.2, %cmp21.2
  br i1 %28, label %if.end26.2, label %for.inc.2

if.end26.2:                                       ; preds = %for.body16.2
  %add29.2 = add nsw i32 %add17.2, %mul.2
  %idxprom.2 = sext i32 %add29.2 to i64
  %arrayidx.2 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.2
  %29 = load float, float* %arrayidx.2, align 4
  %30 = trunc i64 %indvars.iv.2 to i32
  %add31.2 = add i32 %30, %mul30.2
  %idxprom32.2 = zext i32 %add31.2 to i64
  %arrayidx33.2 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.2
  %31 = load float, float* %arrayidx33.2, align 4
  %mul34.2 = fmul float %29, %31
  %add35.2 = fadd float %partial_sum.12.2, %mul34.2
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.end26.2, %for.body16.2
  %partial_sum.2.2 = phi float [ %add35.2, %if.end26.2 ], [ %partial_sum.12.2, %for.body16.2 ]
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %kern_width
  br i1 %exitcond.2, label %for.inc36.2.loopexit, label %for.body16.2, !llvm.loop !1

for.inc36.2.loopexit:                             ; preds = %for.inc.2
  %partial_sum.2.2.lcssa = phi float [ %partial_sum.2.2, %for.inc.2 ]
  br label %for.inc36.2

for.inc36.2:                                      ; preds = %for.inc36.2.loopexit, %for.body10.2
  %partial_sum.3.2 = phi float [ %partial_sum.05.2, %for.body10.2 ], [ %partial_sum.2.2.lcssa, %for.inc36.2.loopexit ]
  %inc37.2 = add nuw nsw i32 %ki.06.2, 1
  %exitcond19.2 = icmp eq i32 %inc37.2, %kern_height
  br i1 %exitcond19.2, label %for.end38.2.loopexit, label %for.body10.2, !llvm.loop !3

for.end38.2.loopexit:                             ; preds = %for.inc36.2
  %partial_sum.3.2.lcssa = phi float [ %partial_sum.3.2, %for.inc36.2 ]
  br label %for.end38.2

for.end38.2:                                      ; preds = %for.end38.2.loopexit, %for.inc53.1
  %partial_sum.0.lcssa.2 = phi float [ 0.000000e+00, %for.inc53.1 ], [ %partial_sum.3.2.lcssa, %for.end38.2.loopexit ]
  br i1 %tobool39, label %if.else.2, label %if.then40.2

if.then40.2:                                      ; preds = %for.end38.2
  %cmp41.2 = fcmp olt float %partial_sum.0.lcssa.2, 0.000000e+00
  %sub42.2 = fsub float -0.000000e+00, %partial_sum.0.lcssa.2
  %cond.2 = select i1 %cmp41.2, float %sub42.2, float %partial_sum.0.lcssa.2
  %conv.2 = fptoui float %cond.2 to i8
  %conv43.2 = uitofp i8 %conv.2 to float
  %32 = add nsw i64 %indvars.iv.next21.1, %5
  %arrayidx47.2 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %32
  store float %conv43.2, float* %arrayidx47.2, align 4
  br label %for.inc53.2

if.else.2:                                        ; preds = %for.end38.2
  %33 = add nsw i64 %indvars.iv.next21.1, %4
  %arrayidx51.2 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %33
  store float %partial_sum.0.lcssa.2, float* %arrayidx51.2, align 4
  br label %for.inc53.2

for.inc53.2:                                      ; preds = %if.else.2, %if.then40.2
  %inc54.2 = add nsw i32 %in_j.011, 3
  %indvars.iv.next21.2 = add nsw i64 %indvars.iv20, 3
  br i1 %cmp94, label %for.end38.3, label %for.body10.3.preheader

for.body10.3.preheader:                           ; preds = %for.inc53.2
  br label %for.body10.3

for.body10.3:                                     ; preds = %for.body10.3.preheader, %for.inc36.3
  %ki.06.3 = phi i32 [ %inc37.3, %for.inc36.3 ], [ 0, %for.body10.3.preheader ]
  %partial_sum.05.3 = phi float [ %partial_sum.3.3, %for.inc36.3 ], [ 0.000000e+00, %for.body10.3.preheader ]
  %add.3 = add nsw i32 %ki.06.3, %in_i.015
  %notlhs.3 = icmp slt i32 %add.3, 0
  %notrhs.3 = icmp uge i32 %add.3, %img_height
  %.not.3 = or i1 %notrhs.3, %notlhs.3
  %brmerge.3 = or i1 %.not.3, %cmp151.not.3
  br i1 %brmerge.3, label %for.inc36.3, label %for.body16.lr.ph.3

for.body16.lr.ph.3:                               ; preds = %for.body10.3
  %mul.3 = shl i32 %add.3, 7
  %mul30.3 = mul i32 %ki.06.3, %kern_width
  br label %for.body16.3

for.body16.3:                                     ; preds = %for.inc.3, %for.body16.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body16.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc.3 ]
  %partial_sum.12.3 = phi float [ %partial_sum.05.3, %for.body16.lr.ph.3 ], [ %partial_sum.2.3, %for.inc.3 ]
  %34 = trunc i64 %indvars.iv.3 to i32
  %add17.3 = add nsw i32 %34, %inc54.2
  %cmp18.3 = icmp sgt i32 %add17.3, -1
  %cmp21.3 = icmp ult i32 %add17.3, %img_width
  %35 = and i1 %cmp18.3, %cmp21.3
  br i1 %35, label %if.end26.3, label %for.inc.3

if.end26.3:                                       ; preds = %for.body16.3
  %add29.3 = add nsw i32 %add17.3, %mul.3
  %idxprom.3 = sext i32 %add29.3 to i64
  %arrayidx.3 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.3
  %36 = load float, float* %arrayidx.3, align 4
  %37 = trunc i64 %indvars.iv.3 to i32
  %add31.3 = add i32 %37, %mul30.3
  %idxprom32.3 = zext i32 %add31.3 to i64
  %arrayidx33.3 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.3
  %38 = load float, float* %arrayidx33.3, align 4
  %mul34.3 = fmul float %36, %38
  %add35.3 = fadd float %partial_sum.12.3, %mul34.3
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.end26.3, %for.body16.3
  %partial_sum.2.3 = phi float [ %add35.3, %if.end26.3 ], [ %partial_sum.12.3, %for.body16.3 ]
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %kern_width
  br i1 %exitcond.3, label %for.inc36.3.loopexit, label %for.body16.3, !llvm.loop !1

for.inc36.3.loopexit:                             ; preds = %for.inc.3
  %partial_sum.2.3.lcssa = phi float [ %partial_sum.2.3, %for.inc.3 ]
  br label %for.inc36.3

for.inc36.3:                                      ; preds = %for.inc36.3.loopexit, %for.body10.3
  %partial_sum.3.3 = phi float [ %partial_sum.05.3, %for.body10.3 ], [ %partial_sum.2.3.lcssa, %for.inc36.3.loopexit ]
  %inc37.3 = add nuw nsw i32 %ki.06.3, 1
  %exitcond19.3 = icmp eq i32 %inc37.3, %kern_height
  br i1 %exitcond19.3, label %for.end38.3.loopexit, label %for.body10.3, !llvm.loop !3

for.end38.3.loopexit:                             ; preds = %for.inc36.3
  %partial_sum.3.3.lcssa = phi float [ %partial_sum.3.3, %for.inc36.3 ]
  br label %for.end38.3

for.end38.3:                                      ; preds = %for.end38.3.loopexit, %for.inc53.2
  %partial_sum.0.lcssa.3 = phi float [ 0.000000e+00, %for.inc53.2 ], [ %partial_sum.3.3.lcssa, %for.end38.3.loopexit ]
  br i1 %tobool39, label %if.else.3, label %if.then40.3

if.then40.3:                                      ; preds = %for.end38.3
  %cmp41.3 = fcmp olt float %partial_sum.0.lcssa.3, 0.000000e+00
  %sub42.3 = fsub float -0.000000e+00, %partial_sum.0.lcssa.3
  %cond.3 = select i1 %cmp41.3, float %sub42.3, float %partial_sum.0.lcssa.3
  %conv.3 = fptoui float %cond.3 to i8
  %conv43.3 = uitofp i8 %conv.3 to float
  %39 = add nsw i64 %indvars.iv.next21.2, %5
  %arrayidx47.3 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %39
  store float %conv43.3, float* %arrayidx47.3, align 4
  br label %for.inc53.3

if.else.3:                                        ; preds = %for.end38.3
  %40 = add nsw i64 %indvars.iv.next21.2, %4
  %arrayidx51.3 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %40
  store float %partial_sum.0.lcssa.3, float* %arrayidx51.3, align 4
  br label %for.inc53.3

for.inc53.3:                                      ; preds = %if.else.3, %if.then40.3
  %inc54.3 = add nsw i32 %in_j.011, 4
  %indvars.iv.next21.3 = add nsw i64 %indvars.iv20, 4
  br i1 %cmp94, label %for.end38.4, label %for.body10.4.preheader

for.body10.4.preheader:                           ; preds = %for.inc53.3
  br label %for.body10.4

for.body10.4:                                     ; preds = %for.body10.4.preheader, %for.inc36.4
  %ki.06.4 = phi i32 [ %inc37.4, %for.inc36.4 ], [ 0, %for.body10.4.preheader ]
  %partial_sum.05.4 = phi float [ %partial_sum.3.4, %for.inc36.4 ], [ 0.000000e+00, %for.body10.4.preheader ]
  %add.4 = add nsw i32 %ki.06.4, %in_i.015
  %notlhs.4 = icmp slt i32 %add.4, 0
  %notrhs.4 = icmp uge i32 %add.4, %img_height
  %.not.4 = or i1 %notrhs.4, %notlhs.4
  %brmerge.4 = or i1 %.not.4, %cmp151.not.4
  br i1 %brmerge.4, label %for.inc36.4, label %for.body16.lr.ph.4

for.body16.lr.ph.4:                               ; preds = %for.body10.4
  %mul.4 = shl i32 %add.4, 7
  %mul30.4 = mul i32 %ki.06.4, %kern_width
  br label %for.body16.4

for.body16.4:                                     ; preds = %for.inc.4, %for.body16.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body16.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc.4 ]
  %partial_sum.12.4 = phi float [ %partial_sum.05.4, %for.body16.lr.ph.4 ], [ %partial_sum.2.4, %for.inc.4 ]
  %41 = trunc i64 %indvars.iv.4 to i32
  %add17.4 = add nsw i32 %41, %inc54.3
  %cmp18.4 = icmp sgt i32 %add17.4, -1
  %cmp21.4 = icmp ult i32 %add17.4, %img_width
  %42 = and i1 %cmp18.4, %cmp21.4
  br i1 %42, label %if.end26.4, label %for.inc.4

if.end26.4:                                       ; preds = %for.body16.4
  %add29.4 = add nsw i32 %add17.4, %mul.4
  %idxprom.4 = sext i32 %add29.4 to i64
  %arrayidx.4 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.4
  %43 = load float, float* %arrayidx.4, align 4
  %44 = trunc i64 %indvars.iv.4 to i32
  %add31.4 = add i32 %44, %mul30.4
  %idxprom32.4 = zext i32 %add31.4 to i64
  %arrayidx33.4 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.4
  %45 = load float, float* %arrayidx33.4, align 4
  %mul34.4 = fmul float %43, %45
  %add35.4 = fadd float %partial_sum.12.4, %mul34.4
  br label %for.inc.4

for.inc.4:                                        ; preds = %if.end26.4, %for.body16.4
  %partial_sum.2.4 = phi float [ %add35.4, %if.end26.4 ], [ %partial_sum.12.4, %for.body16.4 ]
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %kern_width
  br i1 %exitcond.4, label %for.inc36.4.loopexit, label %for.body16.4, !llvm.loop !1

for.inc36.4.loopexit:                             ; preds = %for.inc.4
  %partial_sum.2.4.lcssa = phi float [ %partial_sum.2.4, %for.inc.4 ]
  br label %for.inc36.4

for.inc36.4:                                      ; preds = %for.inc36.4.loopexit, %for.body10.4
  %partial_sum.3.4 = phi float [ %partial_sum.05.4, %for.body10.4 ], [ %partial_sum.2.4.lcssa, %for.inc36.4.loopexit ]
  %inc37.4 = add nuw nsw i32 %ki.06.4, 1
  %exitcond19.4 = icmp eq i32 %inc37.4, %kern_height
  br i1 %exitcond19.4, label %for.end38.4.loopexit, label %for.body10.4, !llvm.loop !3

for.end38.4.loopexit:                             ; preds = %for.inc36.4
  %partial_sum.3.4.lcssa = phi float [ %partial_sum.3.4, %for.inc36.4 ]
  br label %for.end38.4

for.end38.4:                                      ; preds = %for.end38.4.loopexit, %for.inc53.3
  %partial_sum.0.lcssa.4 = phi float [ 0.000000e+00, %for.inc53.3 ], [ %partial_sum.3.4.lcssa, %for.end38.4.loopexit ]
  br i1 %tobool39, label %if.else.4, label %if.then40.4

if.then40.4:                                      ; preds = %for.end38.4
  %cmp41.4 = fcmp olt float %partial_sum.0.lcssa.4, 0.000000e+00
  %sub42.4 = fsub float -0.000000e+00, %partial_sum.0.lcssa.4
  %cond.4 = select i1 %cmp41.4, float %sub42.4, float %partial_sum.0.lcssa.4
  %conv.4 = fptoui float %cond.4 to i8
  %conv43.4 = uitofp i8 %conv.4 to float
  %46 = add nsw i64 %indvars.iv.next21.3, %5
  %arrayidx47.4 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %46
  store float %conv43.4, float* %arrayidx47.4, align 4
  br label %for.inc53.4

if.else.4:                                        ; preds = %for.end38.4
  %47 = add nsw i64 %indvars.iv.next21.3, %4
  %arrayidx51.4 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %47
  store float %partial_sum.0.lcssa.4, float* %arrayidx51.4, align 4
  br label %for.inc53.4

for.inc53.4:                                      ; preds = %if.else.4, %if.then40.4
  %inc54.4 = add nsw i32 %in_j.011, 5
  %indvars.iv.next21.4 = add nsw i64 %indvars.iv20, 5
  br i1 %cmp94, label %for.end38.5, label %for.body10.5.preheader

for.body10.5.preheader:                           ; preds = %for.inc53.4
  br label %for.body10.5

for.body10.5:                                     ; preds = %for.body10.5.preheader, %for.inc36.5
  %ki.06.5 = phi i32 [ %inc37.5, %for.inc36.5 ], [ 0, %for.body10.5.preheader ]
  %partial_sum.05.5 = phi float [ %partial_sum.3.5, %for.inc36.5 ], [ 0.000000e+00, %for.body10.5.preheader ]
  %add.5 = add nsw i32 %ki.06.5, %in_i.015
  %notlhs.5 = icmp slt i32 %add.5, 0
  %notrhs.5 = icmp uge i32 %add.5, %img_height
  %.not.5 = or i1 %notrhs.5, %notlhs.5
  %brmerge.5 = or i1 %.not.5, %cmp151.not.5
  br i1 %brmerge.5, label %for.inc36.5, label %for.body16.lr.ph.5

for.body16.lr.ph.5:                               ; preds = %for.body10.5
  %mul.5 = shl i32 %add.5, 7
  %mul30.5 = mul i32 %ki.06.5, %kern_width
  br label %for.body16.5

for.body16.5:                                     ; preds = %for.inc.5, %for.body16.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body16.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc.5 ]
  %partial_sum.12.5 = phi float [ %partial_sum.05.5, %for.body16.lr.ph.5 ], [ %partial_sum.2.5, %for.inc.5 ]
  %48 = trunc i64 %indvars.iv.5 to i32
  %add17.5 = add nsw i32 %48, %inc54.4
  %cmp18.5 = icmp sgt i32 %add17.5, -1
  %cmp21.5 = icmp ult i32 %add17.5, %img_width
  %49 = and i1 %cmp18.5, %cmp21.5
  br i1 %49, label %if.end26.5, label %for.inc.5

if.end26.5:                                       ; preds = %for.body16.5
  %add29.5 = add nsw i32 %add17.5, %mul.5
  %idxprom.5 = sext i32 %add29.5 to i64
  %arrayidx.5 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.5
  %50 = load float, float* %arrayidx.5, align 4
  %51 = trunc i64 %indvars.iv.5 to i32
  %add31.5 = add i32 %51, %mul30.5
  %idxprom32.5 = zext i32 %add31.5 to i64
  %arrayidx33.5 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.5
  %52 = load float, float* %arrayidx33.5, align 4
  %mul34.5 = fmul float %50, %52
  %add35.5 = fadd float %partial_sum.12.5, %mul34.5
  br label %for.inc.5

for.inc.5:                                        ; preds = %if.end26.5, %for.body16.5
  %partial_sum.2.5 = phi float [ %add35.5, %if.end26.5 ], [ %partial_sum.12.5, %for.body16.5 ]
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %kern_width
  br i1 %exitcond.5, label %for.inc36.5.loopexit, label %for.body16.5, !llvm.loop !1

for.inc36.5.loopexit:                             ; preds = %for.inc.5
  %partial_sum.2.5.lcssa = phi float [ %partial_sum.2.5, %for.inc.5 ]
  br label %for.inc36.5

for.inc36.5:                                      ; preds = %for.inc36.5.loopexit, %for.body10.5
  %partial_sum.3.5 = phi float [ %partial_sum.05.5, %for.body10.5 ], [ %partial_sum.2.5.lcssa, %for.inc36.5.loopexit ]
  %inc37.5 = add nuw nsw i32 %ki.06.5, 1
  %exitcond19.5 = icmp eq i32 %inc37.5, %kern_height
  br i1 %exitcond19.5, label %for.end38.5.loopexit, label %for.body10.5, !llvm.loop !3

for.end38.5.loopexit:                             ; preds = %for.inc36.5
  %partial_sum.3.5.lcssa = phi float [ %partial_sum.3.5, %for.inc36.5 ]
  br label %for.end38.5

for.end38.5:                                      ; preds = %for.end38.5.loopexit, %for.inc53.4
  %partial_sum.0.lcssa.5 = phi float [ 0.000000e+00, %for.inc53.4 ], [ %partial_sum.3.5.lcssa, %for.end38.5.loopexit ]
  br i1 %tobool39, label %if.else.5, label %if.then40.5

if.then40.5:                                      ; preds = %for.end38.5
  %cmp41.5 = fcmp olt float %partial_sum.0.lcssa.5, 0.000000e+00
  %sub42.5 = fsub float -0.000000e+00, %partial_sum.0.lcssa.5
  %cond.5 = select i1 %cmp41.5, float %sub42.5, float %partial_sum.0.lcssa.5
  %conv.5 = fptoui float %cond.5 to i8
  %conv43.5 = uitofp i8 %conv.5 to float
  %53 = add nsw i64 %indvars.iv.next21.4, %5
  %arrayidx47.5 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %53
  store float %conv43.5, float* %arrayidx47.5, align 4
  br label %for.inc53.5

if.else.5:                                        ; preds = %for.end38.5
  %54 = add nsw i64 %indvars.iv.next21.4, %4
  %arrayidx51.5 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %54
  store float %partial_sum.0.lcssa.5, float* %arrayidx51.5, align 4
  br label %for.inc53.5

for.inc53.5:                                      ; preds = %if.else.5, %if.then40.5
  %inc54.5 = add nsw i32 %in_j.011, 6
  %indvars.iv.next21.5 = add nsw i64 %indvars.iv20, 6
  br i1 %cmp94, label %for.end38.6, label %for.body10.6.preheader

for.body10.6.preheader:                           ; preds = %for.inc53.5
  br label %for.body10.6

for.body10.6:                                     ; preds = %for.body10.6.preheader, %for.inc36.6
  %ki.06.6 = phi i32 [ %inc37.6, %for.inc36.6 ], [ 0, %for.body10.6.preheader ]
  %partial_sum.05.6 = phi float [ %partial_sum.3.6, %for.inc36.6 ], [ 0.000000e+00, %for.body10.6.preheader ]
  %add.6 = add nsw i32 %ki.06.6, %in_i.015
  %notlhs.6 = icmp slt i32 %add.6, 0
  %notrhs.6 = icmp uge i32 %add.6, %img_height
  %.not.6 = or i1 %notrhs.6, %notlhs.6
  %brmerge.6 = or i1 %.not.6, %cmp151.not.6
  br i1 %brmerge.6, label %for.inc36.6, label %for.body16.lr.ph.6

for.body16.lr.ph.6:                               ; preds = %for.body10.6
  %mul.6 = shl i32 %add.6, 7
  %mul30.6 = mul i32 %ki.06.6, %kern_width
  br label %for.body16.6

for.body16.6:                                     ; preds = %for.inc.6, %for.body16.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body16.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc.6 ]
  %partial_sum.12.6 = phi float [ %partial_sum.05.6, %for.body16.lr.ph.6 ], [ %partial_sum.2.6, %for.inc.6 ]
  %55 = trunc i64 %indvars.iv.6 to i32
  %add17.6 = add nsw i32 %55, %inc54.5
  %cmp18.6 = icmp sgt i32 %add17.6, -1
  %cmp21.6 = icmp ult i32 %add17.6, %img_width
  %56 = and i1 %cmp18.6, %cmp21.6
  br i1 %56, label %if.end26.6, label %for.inc.6

if.end26.6:                                       ; preds = %for.body16.6
  %add29.6 = add nsw i32 %add17.6, %mul.6
  %idxprom.6 = sext i32 %add29.6 to i64
  %arrayidx.6 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.6
  %57 = load float, float* %arrayidx.6, align 4
  %58 = trunc i64 %indvars.iv.6 to i32
  %add31.6 = add i32 %58, %mul30.6
  %idxprom32.6 = zext i32 %add31.6 to i64
  %arrayidx33.6 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.6
  %59 = load float, float* %arrayidx33.6, align 4
  %mul34.6 = fmul float %57, %59
  %add35.6 = fadd float %partial_sum.12.6, %mul34.6
  br label %for.inc.6

for.inc.6:                                        ; preds = %if.end26.6, %for.body16.6
  %partial_sum.2.6 = phi float [ %add35.6, %if.end26.6 ], [ %partial_sum.12.6, %for.body16.6 ]
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %kern_width
  br i1 %exitcond.6, label %for.inc36.6.loopexit, label %for.body16.6, !llvm.loop !1

for.inc36.6.loopexit:                             ; preds = %for.inc.6
  %partial_sum.2.6.lcssa = phi float [ %partial_sum.2.6, %for.inc.6 ]
  br label %for.inc36.6

for.inc36.6:                                      ; preds = %for.inc36.6.loopexit, %for.body10.6
  %partial_sum.3.6 = phi float [ %partial_sum.05.6, %for.body10.6 ], [ %partial_sum.2.6.lcssa, %for.inc36.6.loopexit ]
  %inc37.6 = add nuw nsw i32 %ki.06.6, 1
  %exitcond19.6 = icmp eq i32 %inc37.6, %kern_height
  br i1 %exitcond19.6, label %for.end38.6.loopexit, label %for.body10.6, !llvm.loop !3

for.end38.6.loopexit:                             ; preds = %for.inc36.6
  %partial_sum.3.6.lcssa = phi float [ %partial_sum.3.6, %for.inc36.6 ]
  br label %for.end38.6

for.end38.6:                                      ; preds = %for.end38.6.loopexit, %for.inc53.5
  %partial_sum.0.lcssa.6 = phi float [ 0.000000e+00, %for.inc53.5 ], [ %partial_sum.3.6.lcssa, %for.end38.6.loopexit ]
  br i1 %tobool39, label %if.else.6, label %if.then40.6

if.then40.6:                                      ; preds = %for.end38.6
  %cmp41.6 = fcmp olt float %partial_sum.0.lcssa.6, 0.000000e+00
  %sub42.6 = fsub float -0.000000e+00, %partial_sum.0.lcssa.6
  %cond.6 = select i1 %cmp41.6, float %sub42.6, float %partial_sum.0.lcssa.6
  %conv.6 = fptoui float %cond.6 to i8
  %conv43.6 = uitofp i8 %conv.6 to float
  %60 = add nsw i64 %indvars.iv.next21.5, %5
  %arrayidx47.6 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %60
  store float %conv43.6, float* %arrayidx47.6, align 4
  br label %for.inc53.6

if.else.6:                                        ; preds = %for.end38.6
  %61 = add nsw i64 %indvars.iv.next21.5, %4
  %arrayidx51.6 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %61
  store float %partial_sum.0.lcssa.6, float* %arrayidx51.6, align 4
  br label %for.inc53.6

for.inc53.6:                                      ; preds = %if.else.6, %if.then40.6
  %inc54.6 = add nsw i32 %in_j.011, 7
  %indvars.iv.next21.6 = add nsw i64 %indvars.iv20, 7
  br i1 %cmp94, label %for.end38.7, label %for.body10.7.preheader

for.body10.7.preheader:                           ; preds = %for.inc53.6
  br label %for.body10.7

for.body10.7:                                     ; preds = %for.body10.7.preheader, %for.inc36.7
  %ki.06.7 = phi i32 [ %inc37.7, %for.inc36.7 ], [ 0, %for.body10.7.preheader ]
  %partial_sum.05.7 = phi float [ %partial_sum.3.7, %for.inc36.7 ], [ 0.000000e+00, %for.body10.7.preheader ]
  %add.7 = add nsw i32 %ki.06.7, %in_i.015
  %notlhs.7 = icmp slt i32 %add.7, 0
  %notrhs.7 = icmp uge i32 %add.7, %img_height
  %.not.7 = or i1 %notrhs.7, %notlhs.7
  %brmerge.7 = or i1 %.not.7, %cmp151.not.7
  br i1 %brmerge.7, label %for.inc36.7, label %for.body16.lr.ph.7

for.body16.lr.ph.7:                               ; preds = %for.body10.7
  %mul.7 = shl i32 %add.7, 7
  %mul30.7 = mul i32 %ki.06.7, %kern_width
  br label %for.body16.7

for.body16.7:                                     ; preds = %for.inc.7, %for.body16.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body16.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc.7 ]
  %partial_sum.12.7 = phi float [ %partial_sum.05.7, %for.body16.lr.ph.7 ], [ %partial_sum.2.7, %for.inc.7 ]
  %62 = trunc i64 %indvars.iv.7 to i32
  %add17.7 = add nsw i32 %62, %inc54.6
  %cmp18.7 = icmp sgt i32 %add17.7, -1
  %cmp21.7 = icmp ult i32 %add17.7, %img_width
  %63 = and i1 %cmp18.7, %cmp21.7
  br i1 %63, label %if.end26.7, label %for.inc.7

if.end26.7:                                       ; preds = %for.body16.7
  %add29.7 = add nsw i32 %add17.7, %mul.7
  %idxprom.7 = sext i32 %add29.7 to i64
  %arrayidx.7 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.7
  %64 = load float, float* %arrayidx.7, align 4
  %65 = trunc i64 %indvars.iv.7 to i32
  %add31.7 = add i32 %65, %mul30.7
  %idxprom32.7 = zext i32 %add31.7 to i64
  %arrayidx33.7 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.7
  %66 = load float, float* %arrayidx33.7, align 4
  %mul34.7 = fmul float %64, %66
  %add35.7 = fadd float %partial_sum.12.7, %mul34.7
  br label %for.inc.7

for.inc.7:                                        ; preds = %if.end26.7, %for.body16.7
  %partial_sum.2.7 = phi float [ %add35.7, %if.end26.7 ], [ %partial_sum.12.7, %for.body16.7 ]
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %kern_width
  br i1 %exitcond.7, label %for.inc36.7.loopexit, label %for.body16.7, !llvm.loop !1

for.inc36.7.loopexit:                             ; preds = %for.inc.7
  %partial_sum.2.7.lcssa = phi float [ %partial_sum.2.7, %for.inc.7 ]
  br label %for.inc36.7

for.inc36.7:                                      ; preds = %for.inc36.7.loopexit, %for.body10.7
  %partial_sum.3.7 = phi float [ %partial_sum.05.7, %for.body10.7 ], [ %partial_sum.2.7.lcssa, %for.inc36.7.loopexit ]
  %inc37.7 = add nuw nsw i32 %ki.06.7, 1
  %exitcond19.7 = icmp eq i32 %inc37.7, %kern_height
  br i1 %exitcond19.7, label %for.end38.7.loopexit, label %for.body10.7, !llvm.loop !3

for.end38.7.loopexit:                             ; preds = %for.inc36.7
  %partial_sum.3.7.lcssa = phi float [ %partial_sum.3.7, %for.inc36.7 ]
  br label %for.end38.7

for.end38.7:                                      ; preds = %for.end38.7.loopexit, %for.inc53.6
  %partial_sum.0.lcssa.7 = phi float [ 0.000000e+00, %for.inc53.6 ], [ %partial_sum.3.7.lcssa, %for.end38.7.loopexit ]
  br i1 %tobool39, label %if.else.7, label %if.then40.7

if.then40.7:                                      ; preds = %for.end38.7
  %cmp41.7 = fcmp olt float %partial_sum.0.lcssa.7, 0.000000e+00
  %sub42.7 = fsub float -0.000000e+00, %partial_sum.0.lcssa.7
  %cond.7 = select i1 %cmp41.7, float %sub42.7, float %partial_sum.0.lcssa.7
  %conv.7 = fptoui float %cond.7 to i8
  %conv43.7 = uitofp i8 %conv.7 to float
  %67 = add nsw i64 %indvars.iv.next21.6, %5
  %arrayidx47.7 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %67
  store float %conv43.7, float* %arrayidx47.7, align 4
  br label %for.inc53.7

if.else.7:                                        ; preds = %for.end38.7
  %68 = add nsw i64 %indvars.iv.next21.6, %4
  %arrayidx51.7 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %68
  store float %partial_sum.0.lcssa.7, float* %arrayidx51.7, align 4
  br label %for.inc53.7

for.inc53.7:                                      ; preds = %if.else.7, %if.then40.7
  %inc54.7 = add nsw i32 %in_j.011, 8
  %indvars.iv.next21.7 = add nsw i64 %indvars.iv20, 8
  br i1 %cmp94, label %for.end38.8, label %for.body10.8.preheader

for.body10.8.preheader:                           ; preds = %for.inc53.7
  br label %for.body10.8

for.body10.8:                                     ; preds = %for.body10.8.preheader, %for.inc36.8
  %ki.06.8 = phi i32 [ %inc37.8, %for.inc36.8 ], [ 0, %for.body10.8.preheader ]
  %partial_sum.05.8 = phi float [ %partial_sum.3.8, %for.inc36.8 ], [ 0.000000e+00, %for.body10.8.preheader ]
  %add.8 = add nsw i32 %ki.06.8, %in_i.015
  %notlhs.8 = icmp slt i32 %add.8, 0
  %notrhs.8 = icmp uge i32 %add.8, %img_height
  %.not.8 = or i1 %notrhs.8, %notlhs.8
  %brmerge.8 = or i1 %.not.8, %cmp151.not.8
  br i1 %brmerge.8, label %for.inc36.8, label %for.body16.lr.ph.8

for.body16.lr.ph.8:                               ; preds = %for.body10.8
  %mul.8 = shl i32 %add.8, 7
  %mul30.8 = mul i32 %ki.06.8, %kern_width
  br label %for.body16.8

for.body16.8:                                     ; preds = %for.inc.8, %for.body16.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body16.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc.8 ]
  %partial_sum.12.8 = phi float [ %partial_sum.05.8, %for.body16.lr.ph.8 ], [ %partial_sum.2.8, %for.inc.8 ]
  %69 = trunc i64 %indvars.iv.8 to i32
  %add17.8 = add nsw i32 %69, %inc54.7
  %cmp18.8 = icmp sgt i32 %add17.8, -1
  %cmp21.8 = icmp ult i32 %add17.8, %img_width
  %70 = and i1 %cmp18.8, %cmp21.8
  br i1 %70, label %if.end26.8, label %for.inc.8

if.end26.8:                                       ; preds = %for.body16.8
  %add29.8 = add nsw i32 %add17.8, %mul.8
  %idxprom.8 = sext i32 %add29.8 to i64
  %arrayidx.8 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.8
  %71 = load float, float* %arrayidx.8, align 4
  %72 = trunc i64 %indvars.iv.8 to i32
  %add31.8 = add i32 %72, %mul30.8
  %idxprom32.8 = zext i32 %add31.8 to i64
  %arrayidx33.8 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.8
  %73 = load float, float* %arrayidx33.8, align 4
  %mul34.8 = fmul float %71, %73
  %add35.8 = fadd float %partial_sum.12.8, %mul34.8
  br label %for.inc.8

for.inc.8:                                        ; preds = %if.end26.8, %for.body16.8
  %partial_sum.2.8 = phi float [ %add35.8, %if.end26.8 ], [ %partial_sum.12.8, %for.body16.8 ]
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %kern_width
  br i1 %exitcond.8, label %for.inc36.8.loopexit, label %for.body16.8, !llvm.loop !1

for.inc36.8.loopexit:                             ; preds = %for.inc.8
  %partial_sum.2.8.lcssa = phi float [ %partial_sum.2.8, %for.inc.8 ]
  br label %for.inc36.8

for.inc36.8:                                      ; preds = %for.inc36.8.loopexit, %for.body10.8
  %partial_sum.3.8 = phi float [ %partial_sum.05.8, %for.body10.8 ], [ %partial_sum.2.8.lcssa, %for.inc36.8.loopexit ]
  %inc37.8 = add nuw nsw i32 %ki.06.8, 1
  %exitcond19.8 = icmp eq i32 %inc37.8, %kern_height
  br i1 %exitcond19.8, label %for.end38.8.loopexit, label %for.body10.8, !llvm.loop !3

for.end38.8.loopexit:                             ; preds = %for.inc36.8
  %partial_sum.3.8.lcssa = phi float [ %partial_sum.3.8, %for.inc36.8 ]
  br label %for.end38.8

for.end38.8:                                      ; preds = %for.end38.8.loopexit, %for.inc53.7
  %partial_sum.0.lcssa.8 = phi float [ 0.000000e+00, %for.inc53.7 ], [ %partial_sum.3.8.lcssa, %for.end38.8.loopexit ]
  br i1 %tobool39, label %if.else.8, label %if.then40.8

if.then40.8:                                      ; preds = %for.end38.8
  %cmp41.8 = fcmp olt float %partial_sum.0.lcssa.8, 0.000000e+00
  %sub42.8 = fsub float -0.000000e+00, %partial_sum.0.lcssa.8
  %cond.8 = select i1 %cmp41.8, float %sub42.8, float %partial_sum.0.lcssa.8
  %conv.8 = fptoui float %cond.8 to i8
  %conv43.8 = uitofp i8 %conv.8 to float
  %74 = add nsw i64 %indvars.iv.next21.7, %5
  %arrayidx47.8 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %74
  store float %conv43.8, float* %arrayidx47.8, align 4
  br label %for.inc53.8

if.else.8:                                        ; preds = %for.end38.8
  %75 = add nsw i64 %indvars.iv.next21.7, %4
  %arrayidx51.8 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %75
  store float %partial_sum.0.lcssa.8, float* %arrayidx51.8, align 4
  br label %for.inc53.8

for.inc53.8:                                      ; preds = %if.else.8, %if.then40.8
  %inc54.8 = add nsw i32 %in_j.011, 9
  %indvars.iv.next21.8 = add nsw i64 %indvars.iv20, 9
  br i1 %cmp94, label %for.end38.9, label %for.body10.9.preheader

for.body10.9.preheader:                           ; preds = %for.inc53.8
  br label %for.body10.9

for.body10.9:                                     ; preds = %for.body10.9.preheader, %for.inc36.9
  %ki.06.9 = phi i32 [ %inc37.9, %for.inc36.9 ], [ 0, %for.body10.9.preheader ]
  %partial_sum.05.9 = phi float [ %partial_sum.3.9, %for.inc36.9 ], [ 0.000000e+00, %for.body10.9.preheader ]
  %add.9 = add nsw i32 %ki.06.9, %in_i.015
  %notlhs.9 = icmp slt i32 %add.9, 0
  %notrhs.9 = icmp uge i32 %add.9, %img_height
  %.not.9 = or i1 %notrhs.9, %notlhs.9
  %brmerge.9 = or i1 %.not.9, %cmp151.not.9
  br i1 %brmerge.9, label %for.inc36.9, label %for.body16.lr.ph.9

for.body16.lr.ph.9:                               ; preds = %for.body10.9
  %mul.9 = shl i32 %add.9, 7
  %mul30.9 = mul i32 %ki.06.9, %kern_width
  br label %for.body16.9

for.body16.9:                                     ; preds = %for.inc.9, %for.body16.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body16.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc.9 ]
  %partial_sum.12.9 = phi float [ %partial_sum.05.9, %for.body16.lr.ph.9 ], [ %partial_sum.2.9, %for.inc.9 ]
  %76 = trunc i64 %indvars.iv.9 to i32
  %add17.9 = add nsw i32 %76, %inc54.8
  %cmp18.9 = icmp sgt i32 %add17.9, -1
  %cmp21.9 = icmp ult i32 %add17.9, %img_width
  %77 = and i1 %cmp18.9, %cmp21.9
  br i1 %77, label %if.end26.9, label %for.inc.9

if.end26.9:                                       ; preds = %for.body16.9
  %add29.9 = add nsw i32 %add17.9, %mul.9
  %idxprom.9 = sext i32 %add29.9 to i64
  %arrayidx.9 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.9
  %78 = load float, float* %arrayidx.9, align 4
  %79 = trunc i64 %indvars.iv.9 to i32
  %add31.9 = add i32 %79, %mul30.9
  %idxprom32.9 = zext i32 %add31.9 to i64
  %arrayidx33.9 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.9
  %80 = load float, float* %arrayidx33.9, align 4
  %mul34.9 = fmul float %78, %80
  %add35.9 = fadd float %partial_sum.12.9, %mul34.9
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.end26.9, %for.body16.9
  %partial_sum.2.9 = phi float [ %add35.9, %if.end26.9 ], [ %partial_sum.12.9, %for.body16.9 ]
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %kern_width
  br i1 %exitcond.9, label %for.inc36.9.loopexit, label %for.body16.9, !llvm.loop !1

for.inc36.9.loopexit:                             ; preds = %for.inc.9
  %partial_sum.2.9.lcssa = phi float [ %partial_sum.2.9, %for.inc.9 ]
  br label %for.inc36.9

for.inc36.9:                                      ; preds = %for.inc36.9.loopexit, %for.body10.9
  %partial_sum.3.9 = phi float [ %partial_sum.05.9, %for.body10.9 ], [ %partial_sum.2.9.lcssa, %for.inc36.9.loopexit ]
  %inc37.9 = add nuw nsw i32 %ki.06.9, 1
  %exitcond19.9 = icmp eq i32 %inc37.9, %kern_height
  br i1 %exitcond19.9, label %for.end38.9.loopexit, label %for.body10.9, !llvm.loop !3

for.end38.9.loopexit:                             ; preds = %for.inc36.9
  %partial_sum.3.9.lcssa = phi float [ %partial_sum.3.9, %for.inc36.9 ]
  br label %for.end38.9

for.end38.9:                                      ; preds = %for.end38.9.loopexit, %for.inc53.8
  %partial_sum.0.lcssa.9 = phi float [ 0.000000e+00, %for.inc53.8 ], [ %partial_sum.3.9.lcssa, %for.end38.9.loopexit ]
  br i1 %tobool39, label %if.else.9, label %if.then40.9

if.then40.9:                                      ; preds = %for.end38.9
  %cmp41.9 = fcmp olt float %partial_sum.0.lcssa.9, 0.000000e+00
  %sub42.9 = fsub float -0.000000e+00, %partial_sum.0.lcssa.9
  %cond.9 = select i1 %cmp41.9, float %sub42.9, float %partial_sum.0.lcssa.9
  %conv.9 = fptoui float %cond.9 to i8
  %conv43.9 = uitofp i8 %conv.9 to float
  %81 = add nsw i64 %indvars.iv.next21.8, %5
  %arrayidx47.9 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %81
  store float %conv43.9, float* %arrayidx47.9, align 4
  br label %for.inc53.9

if.else.9:                                        ; preds = %for.end38.9
  %82 = add nsw i64 %indvars.iv.next21.8, %4
  %arrayidx51.9 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %82
  store float %partial_sum.0.lcssa.9, float* %arrayidx51.9, align 4
  br label %for.inc53.9

for.inc53.9:                                      ; preds = %if.else.9, %if.then40.9
  %inc54.9 = add nsw i32 %in_j.011, 10
  %indvars.iv.next21.9 = add nsw i64 %indvars.iv20, 10
  br i1 %cmp94, label %for.end38.10, label %for.body10.10.preheader

for.body10.10.preheader:                          ; preds = %for.inc53.9
  br label %for.body10.10

for.body10.10:                                    ; preds = %for.body10.10.preheader, %for.inc36.10
  %ki.06.10 = phi i32 [ %inc37.10, %for.inc36.10 ], [ 0, %for.body10.10.preheader ]
  %partial_sum.05.10 = phi float [ %partial_sum.3.10, %for.inc36.10 ], [ 0.000000e+00, %for.body10.10.preheader ]
  %add.10 = add nsw i32 %ki.06.10, %in_i.015
  %notlhs.10 = icmp slt i32 %add.10, 0
  %notrhs.10 = icmp uge i32 %add.10, %img_height
  %.not.10 = or i1 %notrhs.10, %notlhs.10
  %brmerge.10 = or i1 %.not.10, %cmp151.not.10
  br i1 %brmerge.10, label %for.inc36.10, label %for.body16.lr.ph.10

for.body16.lr.ph.10:                              ; preds = %for.body10.10
  %mul.10 = shl i32 %add.10, 7
  %mul30.10 = mul i32 %ki.06.10, %kern_width
  br label %for.body16.10

for.body16.10:                                    ; preds = %for.inc.10, %for.body16.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body16.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc.10 ]
  %partial_sum.12.10 = phi float [ %partial_sum.05.10, %for.body16.lr.ph.10 ], [ %partial_sum.2.10, %for.inc.10 ]
  %83 = trunc i64 %indvars.iv.10 to i32
  %add17.10 = add nsw i32 %83, %inc54.9
  %cmp18.10 = icmp sgt i32 %add17.10, -1
  %cmp21.10 = icmp ult i32 %add17.10, %img_width
  %84 = and i1 %cmp18.10, %cmp21.10
  br i1 %84, label %if.end26.10, label %for.inc.10

if.end26.10:                                      ; preds = %for.body16.10
  %add29.10 = add nsw i32 %add17.10, %mul.10
  %idxprom.10 = sext i32 %add29.10 to i64
  %arrayidx.10 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.10
  %85 = load float, float* %arrayidx.10, align 4
  %86 = trunc i64 %indvars.iv.10 to i32
  %add31.10 = add i32 %86, %mul30.10
  %idxprom32.10 = zext i32 %add31.10 to i64
  %arrayidx33.10 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.10
  %87 = load float, float* %arrayidx33.10, align 4
  %mul34.10 = fmul float %85, %87
  %add35.10 = fadd float %partial_sum.12.10, %mul34.10
  br label %for.inc.10

for.inc.10:                                       ; preds = %if.end26.10, %for.body16.10
  %partial_sum.2.10 = phi float [ %add35.10, %if.end26.10 ], [ %partial_sum.12.10, %for.body16.10 ]
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %kern_width
  br i1 %exitcond.10, label %for.inc36.10.loopexit, label %for.body16.10, !llvm.loop !1

for.inc36.10.loopexit:                            ; preds = %for.inc.10
  %partial_sum.2.10.lcssa = phi float [ %partial_sum.2.10, %for.inc.10 ]
  br label %for.inc36.10

for.inc36.10:                                     ; preds = %for.inc36.10.loopexit, %for.body10.10
  %partial_sum.3.10 = phi float [ %partial_sum.05.10, %for.body10.10 ], [ %partial_sum.2.10.lcssa, %for.inc36.10.loopexit ]
  %inc37.10 = add nuw nsw i32 %ki.06.10, 1
  %exitcond19.10 = icmp eq i32 %inc37.10, %kern_height
  br i1 %exitcond19.10, label %for.end38.10.loopexit, label %for.body10.10, !llvm.loop !3

for.end38.10.loopexit:                            ; preds = %for.inc36.10
  %partial_sum.3.10.lcssa = phi float [ %partial_sum.3.10, %for.inc36.10 ]
  br label %for.end38.10

for.end38.10:                                     ; preds = %for.end38.10.loopexit, %for.inc53.9
  %partial_sum.0.lcssa.10 = phi float [ 0.000000e+00, %for.inc53.9 ], [ %partial_sum.3.10.lcssa, %for.end38.10.loopexit ]
  br i1 %tobool39, label %if.else.10, label %if.then40.10

if.then40.10:                                     ; preds = %for.end38.10
  %cmp41.10 = fcmp olt float %partial_sum.0.lcssa.10, 0.000000e+00
  %sub42.10 = fsub float -0.000000e+00, %partial_sum.0.lcssa.10
  %cond.10 = select i1 %cmp41.10, float %sub42.10, float %partial_sum.0.lcssa.10
  %conv.10 = fptoui float %cond.10 to i8
  %conv43.10 = uitofp i8 %conv.10 to float
  %88 = add nsw i64 %indvars.iv.next21.9, %5
  %arrayidx47.10 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %88
  store float %conv43.10, float* %arrayidx47.10, align 4
  br label %for.inc53.10

if.else.10:                                       ; preds = %for.end38.10
  %89 = add nsw i64 %indvars.iv.next21.9, %4
  %arrayidx51.10 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %89
  store float %partial_sum.0.lcssa.10, float* %arrayidx51.10, align 4
  br label %for.inc53.10

for.inc53.10:                                     ; preds = %if.else.10, %if.then40.10
  %inc54.10 = add nsw i32 %in_j.011, 11
  %indvars.iv.next21.10 = add nsw i64 %indvars.iv20, 11
  br i1 %cmp94, label %for.end38.11, label %for.body10.11.preheader

for.body10.11.preheader:                          ; preds = %for.inc53.10
  br label %for.body10.11

for.body10.11:                                    ; preds = %for.body10.11.preheader, %for.inc36.11
  %ki.06.11 = phi i32 [ %inc37.11, %for.inc36.11 ], [ 0, %for.body10.11.preheader ]
  %partial_sum.05.11 = phi float [ %partial_sum.3.11, %for.inc36.11 ], [ 0.000000e+00, %for.body10.11.preheader ]
  %add.11 = add nsw i32 %ki.06.11, %in_i.015
  %notlhs.11 = icmp slt i32 %add.11, 0
  %notrhs.11 = icmp uge i32 %add.11, %img_height
  %.not.11 = or i1 %notrhs.11, %notlhs.11
  %brmerge.11 = or i1 %.not.11, %cmp151.not.11
  br i1 %brmerge.11, label %for.inc36.11, label %for.body16.lr.ph.11

for.body16.lr.ph.11:                              ; preds = %for.body10.11
  %mul.11 = shl i32 %add.11, 7
  %mul30.11 = mul i32 %ki.06.11, %kern_width
  br label %for.body16.11

for.body16.11:                                    ; preds = %for.inc.11, %for.body16.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body16.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc.11 ]
  %partial_sum.12.11 = phi float [ %partial_sum.05.11, %for.body16.lr.ph.11 ], [ %partial_sum.2.11, %for.inc.11 ]
  %90 = trunc i64 %indvars.iv.11 to i32
  %add17.11 = add nsw i32 %90, %inc54.10
  %cmp18.11 = icmp sgt i32 %add17.11, -1
  %cmp21.11 = icmp ult i32 %add17.11, %img_width
  %91 = and i1 %cmp18.11, %cmp21.11
  br i1 %91, label %if.end26.11, label %for.inc.11

if.end26.11:                                      ; preds = %for.body16.11
  %add29.11 = add nsw i32 %add17.11, %mul.11
  %idxprom.11 = sext i32 %add29.11 to i64
  %arrayidx.11 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.11
  %92 = load float, float* %arrayidx.11, align 4
  %93 = trunc i64 %indvars.iv.11 to i32
  %add31.11 = add i32 %93, %mul30.11
  %idxprom32.11 = zext i32 %add31.11 to i64
  %arrayidx33.11 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.11
  %94 = load float, float* %arrayidx33.11, align 4
  %mul34.11 = fmul float %92, %94
  %add35.11 = fadd float %partial_sum.12.11, %mul34.11
  br label %for.inc.11

for.inc.11:                                       ; preds = %if.end26.11, %for.body16.11
  %partial_sum.2.11 = phi float [ %add35.11, %if.end26.11 ], [ %partial_sum.12.11, %for.body16.11 ]
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %kern_width
  br i1 %exitcond.11, label %for.inc36.11.loopexit, label %for.body16.11, !llvm.loop !1

for.inc36.11.loopexit:                            ; preds = %for.inc.11
  %partial_sum.2.11.lcssa = phi float [ %partial_sum.2.11, %for.inc.11 ]
  br label %for.inc36.11

for.inc36.11:                                     ; preds = %for.inc36.11.loopexit, %for.body10.11
  %partial_sum.3.11 = phi float [ %partial_sum.05.11, %for.body10.11 ], [ %partial_sum.2.11.lcssa, %for.inc36.11.loopexit ]
  %inc37.11 = add nuw nsw i32 %ki.06.11, 1
  %exitcond19.11 = icmp eq i32 %inc37.11, %kern_height
  br i1 %exitcond19.11, label %for.end38.11.loopexit, label %for.body10.11, !llvm.loop !3

for.end38.11.loopexit:                            ; preds = %for.inc36.11
  %partial_sum.3.11.lcssa = phi float [ %partial_sum.3.11, %for.inc36.11 ]
  br label %for.end38.11

for.end38.11:                                     ; preds = %for.end38.11.loopexit, %for.inc53.10
  %partial_sum.0.lcssa.11 = phi float [ 0.000000e+00, %for.inc53.10 ], [ %partial_sum.3.11.lcssa, %for.end38.11.loopexit ]
  br i1 %tobool39, label %if.else.11, label %if.then40.11

if.then40.11:                                     ; preds = %for.end38.11
  %cmp41.11 = fcmp olt float %partial_sum.0.lcssa.11, 0.000000e+00
  %sub42.11 = fsub float -0.000000e+00, %partial_sum.0.lcssa.11
  %cond.11 = select i1 %cmp41.11, float %sub42.11, float %partial_sum.0.lcssa.11
  %conv.11 = fptoui float %cond.11 to i8
  %conv43.11 = uitofp i8 %conv.11 to float
  %95 = add nsw i64 %indvars.iv.next21.10, %5
  %arrayidx47.11 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %95
  store float %conv43.11, float* %arrayidx47.11, align 4
  br label %for.inc53.11

if.else.11:                                       ; preds = %for.end38.11
  %96 = add nsw i64 %indvars.iv.next21.10, %4
  %arrayidx51.11 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %96
  store float %partial_sum.0.lcssa.11, float* %arrayidx51.11, align 4
  br label %for.inc53.11

for.inc53.11:                                     ; preds = %if.else.11, %if.then40.11
  %inc54.11 = add nsw i32 %in_j.011, 12
  %indvars.iv.next21.11 = add nsw i64 %indvars.iv20, 12
  br i1 %cmp94, label %for.end38.12, label %for.body10.12.preheader

for.body10.12.preheader:                          ; preds = %for.inc53.11
  br label %for.body10.12

for.body10.12:                                    ; preds = %for.body10.12.preheader, %for.inc36.12
  %ki.06.12 = phi i32 [ %inc37.12, %for.inc36.12 ], [ 0, %for.body10.12.preheader ]
  %partial_sum.05.12 = phi float [ %partial_sum.3.12, %for.inc36.12 ], [ 0.000000e+00, %for.body10.12.preheader ]
  %add.12 = add nsw i32 %ki.06.12, %in_i.015
  %notlhs.12 = icmp slt i32 %add.12, 0
  %notrhs.12 = icmp uge i32 %add.12, %img_height
  %.not.12 = or i1 %notrhs.12, %notlhs.12
  %brmerge.12 = or i1 %.not.12, %cmp151.not.12
  br i1 %brmerge.12, label %for.inc36.12, label %for.body16.lr.ph.12

for.body16.lr.ph.12:                              ; preds = %for.body10.12
  %mul.12 = shl i32 %add.12, 7
  %mul30.12 = mul i32 %ki.06.12, %kern_width
  br label %for.body16.12

for.body16.12:                                    ; preds = %for.inc.12, %for.body16.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body16.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc.12 ]
  %partial_sum.12.12 = phi float [ %partial_sum.05.12, %for.body16.lr.ph.12 ], [ %partial_sum.2.12, %for.inc.12 ]
  %97 = trunc i64 %indvars.iv.12 to i32
  %add17.12 = add nsw i32 %97, %inc54.11
  %cmp18.12 = icmp sgt i32 %add17.12, -1
  %cmp21.12 = icmp ult i32 %add17.12, %img_width
  %98 = and i1 %cmp18.12, %cmp21.12
  br i1 %98, label %if.end26.12, label %for.inc.12

if.end26.12:                                      ; preds = %for.body16.12
  %add29.12 = add nsw i32 %add17.12, %mul.12
  %idxprom.12 = sext i32 %add29.12 to i64
  %arrayidx.12 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.12
  %99 = load float, float* %arrayidx.12, align 4
  %100 = trunc i64 %indvars.iv.12 to i32
  %add31.12 = add i32 %100, %mul30.12
  %idxprom32.12 = zext i32 %add31.12 to i64
  %arrayidx33.12 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.12
  %101 = load float, float* %arrayidx33.12, align 4
  %mul34.12 = fmul float %99, %101
  %add35.12 = fadd float %partial_sum.12.12, %mul34.12
  br label %for.inc.12

for.inc.12:                                       ; preds = %if.end26.12, %for.body16.12
  %partial_sum.2.12 = phi float [ %add35.12, %if.end26.12 ], [ %partial_sum.12.12, %for.body16.12 ]
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %kern_width
  br i1 %exitcond.12, label %for.inc36.12.loopexit, label %for.body16.12, !llvm.loop !1

for.inc36.12.loopexit:                            ; preds = %for.inc.12
  %partial_sum.2.12.lcssa = phi float [ %partial_sum.2.12, %for.inc.12 ]
  br label %for.inc36.12

for.inc36.12:                                     ; preds = %for.inc36.12.loopexit, %for.body10.12
  %partial_sum.3.12 = phi float [ %partial_sum.05.12, %for.body10.12 ], [ %partial_sum.2.12.lcssa, %for.inc36.12.loopexit ]
  %inc37.12 = add nuw nsw i32 %ki.06.12, 1
  %exitcond19.12 = icmp eq i32 %inc37.12, %kern_height
  br i1 %exitcond19.12, label %for.end38.12.loopexit, label %for.body10.12, !llvm.loop !3

for.end38.12.loopexit:                            ; preds = %for.inc36.12
  %partial_sum.3.12.lcssa = phi float [ %partial_sum.3.12, %for.inc36.12 ]
  br label %for.end38.12

for.end38.12:                                     ; preds = %for.end38.12.loopexit, %for.inc53.11
  %partial_sum.0.lcssa.12 = phi float [ 0.000000e+00, %for.inc53.11 ], [ %partial_sum.3.12.lcssa, %for.end38.12.loopexit ]
  br i1 %tobool39, label %if.else.12, label %if.then40.12

if.then40.12:                                     ; preds = %for.end38.12
  %cmp41.12 = fcmp olt float %partial_sum.0.lcssa.12, 0.000000e+00
  %sub42.12 = fsub float -0.000000e+00, %partial_sum.0.lcssa.12
  %cond.12 = select i1 %cmp41.12, float %sub42.12, float %partial_sum.0.lcssa.12
  %conv.12 = fptoui float %cond.12 to i8
  %conv43.12 = uitofp i8 %conv.12 to float
  %102 = add nsw i64 %indvars.iv.next21.11, %5
  %arrayidx47.12 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %102
  store float %conv43.12, float* %arrayidx47.12, align 4
  br label %for.inc53.12

if.else.12:                                       ; preds = %for.end38.12
  %103 = add nsw i64 %indvars.iv.next21.11, %4
  %arrayidx51.12 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %103
  store float %partial_sum.0.lcssa.12, float* %arrayidx51.12, align 4
  br label %for.inc53.12

for.inc53.12:                                     ; preds = %if.else.12, %if.then40.12
  %inc54.12 = add nsw i32 %in_j.011, 13
  %indvars.iv.next21.12 = add nsw i64 %indvars.iv20, 13
  br i1 %cmp94, label %for.end38.13, label %for.body10.13.preheader

for.body10.13.preheader:                          ; preds = %for.inc53.12
  br label %for.body10.13

for.body10.13:                                    ; preds = %for.body10.13.preheader, %for.inc36.13
  %ki.06.13 = phi i32 [ %inc37.13, %for.inc36.13 ], [ 0, %for.body10.13.preheader ]
  %partial_sum.05.13 = phi float [ %partial_sum.3.13, %for.inc36.13 ], [ 0.000000e+00, %for.body10.13.preheader ]
  %add.13 = add nsw i32 %ki.06.13, %in_i.015
  %notlhs.13 = icmp slt i32 %add.13, 0
  %notrhs.13 = icmp uge i32 %add.13, %img_height
  %.not.13 = or i1 %notrhs.13, %notlhs.13
  %brmerge.13 = or i1 %.not.13, %cmp151.not.13
  br i1 %brmerge.13, label %for.inc36.13, label %for.body16.lr.ph.13

for.body16.lr.ph.13:                              ; preds = %for.body10.13
  %mul.13 = shl i32 %add.13, 7
  %mul30.13 = mul i32 %ki.06.13, %kern_width
  br label %for.body16.13

for.body16.13:                                    ; preds = %for.inc.13, %for.body16.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body16.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc.13 ]
  %partial_sum.12.13 = phi float [ %partial_sum.05.13, %for.body16.lr.ph.13 ], [ %partial_sum.2.13, %for.inc.13 ]
  %104 = trunc i64 %indvars.iv.13 to i32
  %add17.13 = add nsw i32 %104, %inc54.12
  %cmp18.13 = icmp sgt i32 %add17.13, -1
  %cmp21.13 = icmp ult i32 %add17.13, %img_width
  %105 = and i1 %cmp18.13, %cmp21.13
  br i1 %105, label %if.end26.13, label %for.inc.13

if.end26.13:                                      ; preds = %for.body16.13
  %add29.13 = add nsw i32 %add17.13, %mul.13
  %idxprom.13 = sext i32 %add29.13 to i64
  %arrayidx.13 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.13
  %106 = load float, float* %arrayidx.13, align 4
  %107 = trunc i64 %indvars.iv.13 to i32
  %add31.13 = add i32 %107, %mul30.13
  %idxprom32.13 = zext i32 %add31.13 to i64
  %arrayidx33.13 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.13
  %108 = load float, float* %arrayidx33.13, align 4
  %mul34.13 = fmul float %106, %108
  %add35.13 = fadd float %partial_sum.12.13, %mul34.13
  br label %for.inc.13

for.inc.13:                                       ; preds = %if.end26.13, %for.body16.13
  %partial_sum.2.13 = phi float [ %add35.13, %if.end26.13 ], [ %partial_sum.12.13, %for.body16.13 ]
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %kern_width
  br i1 %exitcond.13, label %for.inc36.13.loopexit, label %for.body16.13, !llvm.loop !1

for.inc36.13.loopexit:                            ; preds = %for.inc.13
  %partial_sum.2.13.lcssa = phi float [ %partial_sum.2.13, %for.inc.13 ]
  br label %for.inc36.13

for.inc36.13:                                     ; preds = %for.inc36.13.loopexit, %for.body10.13
  %partial_sum.3.13 = phi float [ %partial_sum.05.13, %for.body10.13 ], [ %partial_sum.2.13.lcssa, %for.inc36.13.loopexit ]
  %inc37.13 = add nuw nsw i32 %ki.06.13, 1
  %exitcond19.13 = icmp eq i32 %inc37.13, %kern_height
  br i1 %exitcond19.13, label %for.end38.13.loopexit, label %for.body10.13, !llvm.loop !3

for.end38.13.loopexit:                            ; preds = %for.inc36.13
  %partial_sum.3.13.lcssa = phi float [ %partial_sum.3.13, %for.inc36.13 ]
  br label %for.end38.13

for.end38.13:                                     ; preds = %for.end38.13.loopexit, %for.inc53.12
  %partial_sum.0.lcssa.13 = phi float [ 0.000000e+00, %for.inc53.12 ], [ %partial_sum.3.13.lcssa, %for.end38.13.loopexit ]
  br i1 %tobool39, label %if.else.13, label %if.then40.13

if.then40.13:                                     ; preds = %for.end38.13
  %cmp41.13 = fcmp olt float %partial_sum.0.lcssa.13, 0.000000e+00
  %sub42.13 = fsub float -0.000000e+00, %partial_sum.0.lcssa.13
  %cond.13 = select i1 %cmp41.13, float %sub42.13, float %partial_sum.0.lcssa.13
  %conv.13 = fptoui float %cond.13 to i8
  %conv43.13 = uitofp i8 %conv.13 to float
  %109 = add nsw i64 %indvars.iv.next21.12, %5
  %arrayidx47.13 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %109
  store float %conv43.13, float* %arrayidx47.13, align 4
  br label %for.inc53.13

if.else.13:                                       ; preds = %for.end38.13
  %110 = add nsw i64 %indvars.iv.next21.12, %4
  %arrayidx51.13 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %110
  store float %partial_sum.0.lcssa.13, float* %arrayidx51.13, align 4
  br label %for.inc53.13

for.inc53.13:                                     ; preds = %if.else.13, %if.then40.13
  %inc54.13 = add nsw i32 %in_j.011, 14
  %indvars.iv.next21.13 = add nsw i64 %indvars.iv20, 14
  br i1 %cmp94, label %for.end38.14, label %for.body10.14.preheader

for.body10.14.preheader:                          ; preds = %for.inc53.13
  br label %for.body10.14

for.body10.14:                                    ; preds = %for.body10.14.preheader, %for.inc36.14
  %ki.06.14 = phi i32 [ %inc37.14, %for.inc36.14 ], [ 0, %for.body10.14.preheader ]
  %partial_sum.05.14 = phi float [ %partial_sum.3.14, %for.inc36.14 ], [ 0.000000e+00, %for.body10.14.preheader ]
  %add.14 = add nsw i32 %ki.06.14, %in_i.015
  %notlhs.14 = icmp slt i32 %add.14, 0
  %notrhs.14 = icmp uge i32 %add.14, %img_height
  %.not.14 = or i1 %notrhs.14, %notlhs.14
  %brmerge.14 = or i1 %.not.14, %cmp151.not.14
  br i1 %brmerge.14, label %for.inc36.14, label %for.body16.lr.ph.14

for.body16.lr.ph.14:                              ; preds = %for.body10.14
  %mul.14 = shl i32 %add.14, 7
  %mul30.14 = mul i32 %ki.06.14, %kern_width
  br label %for.body16.14

for.body16.14:                                    ; preds = %for.inc.14, %for.body16.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body16.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc.14 ]
  %partial_sum.12.14 = phi float [ %partial_sum.05.14, %for.body16.lr.ph.14 ], [ %partial_sum.2.14, %for.inc.14 ]
  %111 = trunc i64 %indvars.iv.14 to i32
  %add17.14 = add nsw i32 %111, %inc54.13
  %cmp18.14 = icmp sgt i32 %add17.14, -1
  %cmp21.14 = icmp ult i32 %add17.14, %img_width
  %112 = and i1 %cmp18.14, %cmp21.14
  br i1 %112, label %if.end26.14, label %for.inc.14

if.end26.14:                                      ; preds = %for.body16.14
  %add29.14 = add nsw i32 %add17.14, %mul.14
  %idxprom.14 = sext i32 %add29.14 to i64
  %arrayidx.14 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.14
  %113 = load float, float* %arrayidx.14, align 4
  %114 = trunc i64 %indvars.iv.14 to i32
  %add31.14 = add i32 %114, %mul30.14
  %idxprom32.14 = zext i32 %add31.14 to i64
  %arrayidx33.14 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.14
  %115 = load float, float* %arrayidx33.14, align 4
  %mul34.14 = fmul float %113, %115
  %add35.14 = fadd float %partial_sum.12.14, %mul34.14
  br label %for.inc.14

for.inc.14:                                       ; preds = %if.end26.14, %for.body16.14
  %partial_sum.2.14 = phi float [ %add35.14, %if.end26.14 ], [ %partial_sum.12.14, %for.body16.14 ]
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %kern_width
  br i1 %exitcond.14, label %for.inc36.14.loopexit, label %for.body16.14, !llvm.loop !1

for.inc36.14.loopexit:                            ; preds = %for.inc.14
  %partial_sum.2.14.lcssa = phi float [ %partial_sum.2.14, %for.inc.14 ]
  br label %for.inc36.14

for.inc36.14:                                     ; preds = %for.inc36.14.loopexit, %for.body10.14
  %partial_sum.3.14 = phi float [ %partial_sum.05.14, %for.body10.14 ], [ %partial_sum.2.14.lcssa, %for.inc36.14.loopexit ]
  %inc37.14 = add nuw nsw i32 %ki.06.14, 1
  %exitcond19.14 = icmp eq i32 %inc37.14, %kern_height
  br i1 %exitcond19.14, label %for.end38.14.loopexit, label %for.body10.14, !llvm.loop !3

for.end38.14.loopexit:                            ; preds = %for.inc36.14
  %partial_sum.3.14.lcssa = phi float [ %partial_sum.3.14, %for.inc36.14 ]
  br label %for.end38.14

for.end38.14:                                     ; preds = %for.end38.14.loopexit, %for.inc53.13
  %partial_sum.0.lcssa.14 = phi float [ 0.000000e+00, %for.inc53.13 ], [ %partial_sum.3.14.lcssa, %for.end38.14.loopexit ]
  br i1 %tobool39, label %if.else.14, label %if.then40.14

if.then40.14:                                     ; preds = %for.end38.14
  %cmp41.14 = fcmp olt float %partial_sum.0.lcssa.14, 0.000000e+00
  %sub42.14 = fsub float -0.000000e+00, %partial_sum.0.lcssa.14
  %cond.14 = select i1 %cmp41.14, float %sub42.14, float %partial_sum.0.lcssa.14
  %conv.14 = fptoui float %cond.14 to i8
  %conv43.14 = uitofp i8 %conv.14 to float
  %116 = add nsw i64 %indvars.iv.next21.13, %5
  %arrayidx47.14 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %116
  store float %conv43.14, float* %arrayidx47.14, align 4
  br label %for.inc53.14

if.else.14:                                       ; preds = %for.end38.14
  %117 = add nsw i64 %indvars.iv.next21.13, %4
  %arrayidx51.14 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %117
  store float %partial_sum.0.lcssa.14, float* %arrayidx51.14, align 4
  br label %for.inc53.14

for.inc53.14:                                     ; preds = %if.else.14, %if.then40.14
  %inc54.14 = add nsw i32 %in_j.011, 15
  %indvars.iv.next21.14 = add nsw i64 %indvars.iv20, 15
  br i1 %cmp94, label %for.end38.15, label %for.body10.15.preheader

for.body10.15.preheader:                          ; preds = %for.inc53.14
  br label %for.body10.15

for.body10.15:                                    ; preds = %for.body10.15.preheader, %for.inc36.15
  %ki.06.15 = phi i32 [ %inc37.15, %for.inc36.15 ], [ 0, %for.body10.15.preheader ]
  %partial_sum.05.15 = phi float [ %partial_sum.3.15, %for.inc36.15 ], [ 0.000000e+00, %for.body10.15.preheader ]
  %add.15 = add nsw i32 %ki.06.15, %in_i.015
  %notlhs.15 = icmp slt i32 %add.15, 0
  %notrhs.15 = icmp uge i32 %add.15, %img_height
  %.not.15 = or i1 %notrhs.15, %notlhs.15
  %brmerge.15 = or i1 %.not.15, %cmp151.not.15
  br i1 %brmerge.15, label %for.inc36.15, label %for.body16.lr.ph.15

for.body16.lr.ph.15:                              ; preds = %for.body10.15
  %mul.15 = shl i32 %add.15, 7
  %mul30.15 = mul i32 %ki.06.15, %kern_width
  br label %for.body16.15

for.body16.15:                                    ; preds = %for.inc.15, %for.body16.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body16.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc.15 ]
  %partial_sum.12.15 = phi float [ %partial_sum.05.15, %for.body16.lr.ph.15 ], [ %partial_sum.2.15, %for.inc.15 ]
  %118 = trunc i64 %indvars.iv.15 to i32
  %add17.15 = add nsw i32 %118, %inc54.14
  %cmp18.15 = icmp sgt i32 %add17.15, -1
  %cmp21.15 = icmp ult i32 %add17.15, %img_width
  %119 = and i1 %cmp18.15, %cmp21.15
  br i1 %119, label %if.end26.15, label %for.inc.15

if.end26.15:                                      ; preds = %for.body16.15
  %add29.15 = add nsw i32 %add17.15, %mul.15
  %idxprom.15 = sext i32 %add29.15 to i64
  %arrayidx.15 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.15
  %120 = load float, float* %arrayidx.15, align 4
  %121 = trunc i64 %indvars.iv.15 to i32
  %add31.15 = add i32 %121, %mul30.15
  %idxprom32.15 = zext i32 %add31.15 to i64
  %arrayidx33.15 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.15
  %122 = load float, float* %arrayidx33.15, align 4
  %mul34.15 = fmul float %120, %122
  %add35.15 = fadd float %partial_sum.12.15, %mul34.15
  br label %for.inc.15

for.inc.15:                                       ; preds = %if.end26.15, %for.body16.15
  %partial_sum.2.15 = phi float [ %add35.15, %if.end26.15 ], [ %partial_sum.12.15, %for.body16.15 ]
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %kern_width
  br i1 %exitcond.15, label %for.inc36.15.loopexit, label %for.body16.15, !llvm.loop !1

for.inc36.15.loopexit:                            ; preds = %for.inc.15
  %partial_sum.2.15.lcssa = phi float [ %partial_sum.2.15, %for.inc.15 ]
  br label %for.inc36.15

for.inc36.15:                                     ; preds = %for.inc36.15.loopexit, %for.body10.15
  %partial_sum.3.15 = phi float [ %partial_sum.05.15, %for.body10.15 ], [ %partial_sum.2.15.lcssa, %for.inc36.15.loopexit ]
  %inc37.15 = add nuw nsw i32 %ki.06.15, 1
  %exitcond19.15 = icmp eq i32 %inc37.15, %kern_height
  br i1 %exitcond19.15, label %for.end38.15.loopexit, label %for.body10.15, !llvm.loop !3

for.end38.15.loopexit:                            ; preds = %for.inc36.15
  %partial_sum.3.15.lcssa = phi float [ %partial_sum.3.15, %for.inc36.15 ]
  br label %for.end38.15

for.end38.15:                                     ; preds = %for.end38.15.loopexit, %for.inc53.14
  %partial_sum.0.lcssa.15 = phi float [ 0.000000e+00, %for.inc53.14 ], [ %partial_sum.3.15.lcssa, %for.end38.15.loopexit ]
  br i1 %tobool39, label %if.else.15, label %if.then40.15

if.then40.15:                                     ; preds = %for.end38.15
  %cmp41.15 = fcmp olt float %partial_sum.0.lcssa.15, 0.000000e+00
  %sub42.15 = fsub float -0.000000e+00, %partial_sum.0.lcssa.15
  %cond.15 = select i1 %cmp41.15, float %sub42.15, float %partial_sum.0.lcssa.15
  %conv.15 = fptoui float %cond.15 to i8
  %conv43.15 = uitofp i8 %conv.15 to float
  %123 = add nsw i64 %indvars.iv.next21.14, %5
  %arrayidx47.15 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %123
  store float %conv43.15, float* %arrayidx47.15, align 4
  br label %for.inc53.15

if.else.15:                                       ; preds = %for.end38.15
  %124 = add nsw i64 %indvars.iv.next21.14, %4
  %arrayidx51.15 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %124
  store float %partial_sum.0.lcssa.15, float* %arrayidx51.15, align 4
  br label %for.inc53.15

for.inc53.15:                                     ; preds = %if.else.15, %if.then40.15
  %inc54.15 = add nsw i32 %in_j.011, 16
  %indvars.iv.next21.15 = add nsw i64 %indvars.iv20, 16
  br i1 %cmp94, label %for.end38.16, label %for.body10.16.preheader

for.body10.16.preheader:                          ; preds = %for.inc53.15
  br label %for.body10.16

for.body10.16:                                    ; preds = %for.body10.16.preheader, %for.inc36.16
  %ki.06.16 = phi i32 [ %inc37.16, %for.inc36.16 ], [ 0, %for.body10.16.preheader ]
  %partial_sum.05.16 = phi float [ %partial_sum.3.16, %for.inc36.16 ], [ 0.000000e+00, %for.body10.16.preheader ]
  %add.16 = add nsw i32 %ki.06.16, %in_i.015
  %notlhs.16 = icmp slt i32 %add.16, 0
  %notrhs.16 = icmp uge i32 %add.16, %img_height
  %.not.16 = or i1 %notrhs.16, %notlhs.16
  %brmerge.16 = or i1 %.not.16, %cmp151.not.16
  br i1 %brmerge.16, label %for.inc36.16, label %for.body16.lr.ph.16

for.body16.lr.ph.16:                              ; preds = %for.body10.16
  %mul.16 = shl i32 %add.16, 7
  %mul30.16 = mul i32 %ki.06.16, %kern_width
  br label %for.body16.16

for.body16.16:                                    ; preds = %for.inc.16, %for.body16.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body16.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc.16 ]
  %partial_sum.12.16 = phi float [ %partial_sum.05.16, %for.body16.lr.ph.16 ], [ %partial_sum.2.16, %for.inc.16 ]
  %125 = trunc i64 %indvars.iv.16 to i32
  %add17.16 = add nsw i32 %125, %inc54.15
  %cmp18.16 = icmp sgt i32 %add17.16, -1
  %cmp21.16 = icmp ult i32 %add17.16, %img_width
  %126 = and i1 %cmp18.16, %cmp21.16
  br i1 %126, label %if.end26.16, label %for.inc.16

if.end26.16:                                      ; preds = %for.body16.16
  %add29.16 = add nsw i32 %add17.16, %mul.16
  %idxprom.16 = sext i32 %add29.16 to i64
  %arrayidx.16 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.16
  %127 = load float, float* %arrayidx.16, align 4
  %128 = trunc i64 %indvars.iv.16 to i32
  %add31.16 = add i32 %128, %mul30.16
  %idxprom32.16 = zext i32 %add31.16 to i64
  %arrayidx33.16 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.16
  %129 = load float, float* %arrayidx33.16, align 4
  %mul34.16 = fmul float %127, %129
  %add35.16 = fadd float %partial_sum.12.16, %mul34.16
  br label %for.inc.16

for.inc.16:                                       ; preds = %if.end26.16, %for.body16.16
  %partial_sum.2.16 = phi float [ %add35.16, %if.end26.16 ], [ %partial_sum.12.16, %for.body16.16 ]
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %kern_width
  br i1 %exitcond.16, label %for.inc36.16.loopexit, label %for.body16.16, !llvm.loop !1

for.inc36.16.loopexit:                            ; preds = %for.inc.16
  %partial_sum.2.16.lcssa = phi float [ %partial_sum.2.16, %for.inc.16 ]
  br label %for.inc36.16

for.inc36.16:                                     ; preds = %for.inc36.16.loopexit, %for.body10.16
  %partial_sum.3.16 = phi float [ %partial_sum.05.16, %for.body10.16 ], [ %partial_sum.2.16.lcssa, %for.inc36.16.loopexit ]
  %inc37.16 = add nuw nsw i32 %ki.06.16, 1
  %exitcond19.16 = icmp eq i32 %inc37.16, %kern_height
  br i1 %exitcond19.16, label %for.end38.16.loopexit, label %for.body10.16, !llvm.loop !3

for.end38.16.loopexit:                            ; preds = %for.inc36.16
  %partial_sum.3.16.lcssa = phi float [ %partial_sum.3.16, %for.inc36.16 ]
  br label %for.end38.16

for.end38.16:                                     ; preds = %for.end38.16.loopexit, %for.inc53.15
  %partial_sum.0.lcssa.16 = phi float [ 0.000000e+00, %for.inc53.15 ], [ %partial_sum.3.16.lcssa, %for.end38.16.loopexit ]
  br i1 %tobool39, label %if.else.16, label %if.then40.16

if.then40.16:                                     ; preds = %for.end38.16
  %cmp41.16 = fcmp olt float %partial_sum.0.lcssa.16, 0.000000e+00
  %sub42.16 = fsub float -0.000000e+00, %partial_sum.0.lcssa.16
  %cond.16 = select i1 %cmp41.16, float %sub42.16, float %partial_sum.0.lcssa.16
  %conv.16 = fptoui float %cond.16 to i8
  %conv43.16 = uitofp i8 %conv.16 to float
  %130 = add nsw i64 %indvars.iv.next21.15, %5
  %arrayidx47.16 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %130
  store float %conv43.16, float* %arrayidx47.16, align 4
  br label %for.inc53.16

if.else.16:                                       ; preds = %for.end38.16
  %131 = add nsw i64 %indvars.iv.next21.15, %4
  %arrayidx51.16 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %131
  store float %partial_sum.0.lcssa.16, float* %arrayidx51.16, align 4
  br label %for.inc53.16

for.inc53.16:                                     ; preds = %if.else.16, %if.then40.16
  %inc54.16 = add nsw i32 %in_j.011, 17
  %indvars.iv.next21.16 = add nsw i64 %indvars.iv20, 17
  br i1 %cmp94, label %for.end38.17, label %for.body10.17.preheader

for.body10.17.preheader:                          ; preds = %for.inc53.16
  br label %for.body10.17

for.body10.17:                                    ; preds = %for.body10.17.preheader, %for.inc36.17
  %ki.06.17 = phi i32 [ %inc37.17, %for.inc36.17 ], [ 0, %for.body10.17.preheader ]
  %partial_sum.05.17 = phi float [ %partial_sum.3.17, %for.inc36.17 ], [ 0.000000e+00, %for.body10.17.preheader ]
  %add.17 = add nsw i32 %ki.06.17, %in_i.015
  %notlhs.17 = icmp slt i32 %add.17, 0
  %notrhs.17 = icmp uge i32 %add.17, %img_height
  %.not.17 = or i1 %notrhs.17, %notlhs.17
  %brmerge.17 = or i1 %.not.17, %cmp151.not.17
  br i1 %brmerge.17, label %for.inc36.17, label %for.body16.lr.ph.17

for.body16.lr.ph.17:                              ; preds = %for.body10.17
  %mul.17 = shl i32 %add.17, 7
  %mul30.17 = mul i32 %ki.06.17, %kern_width
  br label %for.body16.17

for.body16.17:                                    ; preds = %for.inc.17, %for.body16.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body16.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc.17 ]
  %partial_sum.12.17 = phi float [ %partial_sum.05.17, %for.body16.lr.ph.17 ], [ %partial_sum.2.17, %for.inc.17 ]
  %132 = trunc i64 %indvars.iv.17 to i32
  %add17.17 = add nsw i32 %132, %inc54.16
  %cmp18.17 = icmp sgt i32 %add17.17, -1
  %cmp21.17 = icmp ult i32 %add17.17, %img_width
  %133 = and i1 %cmp18.17, %cmp21.17
  br i1 %133, label %if.end26.17, label %for.inc.17

if.end26.17:                                      ; preds = %for.body16.17
  %add29.17 = add nsw i32 %add17.17, %mul.17
  %idxprom.17 = sext i32 %add29.17 to i64
  %arrayidx.17 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.17
  %134 = load float, float* %arrayidx.17, align 4
  %135 = trunc i64 %indvars.iv.17 to i32
  %add31.17 = add i32 %135, %mul30.17
  %idxprom32.17 = zext i32 %add31.17 to i64
  %arrayidx33.17 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.17
  %136 = load float, float* %arrayidx33.17, align 4
  %mul34.17 = fmul float %134, %136
  %add35.17 = fadd float %partial_sum.12.17, %mul34.17
  br label %for.inc.17

for.inc.17:                                       ; preds = %if.end26.17, %for.body16.17
  %partial_sum.2.17 = phi float [ %add35.17, %if.end26.17 ], [ %partial_sum.12.17, %for.body16.17 ]
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %kern_width
  br i1 %exitcond.17, label %for.inc36.17.loopexit, label %for.body16.17, !llvm.loop !1

for.inc36.17.loopexit:                            ; preds = %for.inc.17
  %partial_sum.2.17.lcssa = phi float [ %partial_sum.2.17, %for.inc.17 ]
  br label %for.inc36.17

for.inc36.17:                                     ; preds = %for.inc36.17.loopexit, %for.body10.17
  %partial_sum.3.17 = phi float [ %partial_sum.05.17, %for.body10.17 ], [ %partial_sum.2.17.lcssa, %for.inc36.17.loopexit ]
  %inc37.17 = add nuw nsw i32 %ki.06.17, 1
  %exitcond19.17 = icmp eq i32 %inc37.17, %kern_height
  br i1 %exitcond19.17, label %for.end38.17.loopexit, label %for.body10.17, !llvm.loop !3

for.end38.17.loopexit:                            ; preds = %for.inc36.17
  %partial_sum.3.17.lcssa = phi float [ %partial_sum.3.17, %for.inc36.17 ]
  br label %for.end38.17

for.end38.17:                                     ; preds = %for.end38.17.loopexit, %for.inc53.16
  %partial_sum.0.lcssa.17 = phi float [ 0.000000e+00, %for.inc53.16 ], [ %partial_sum.3.17.lcssa, %for.end38.17.loopexit ]
  br i1 %tobool39, label %if.else.17, label %if.then40.17

if.then40.17:                                     ; preds = %for.end38.17
  %cmp41.17 = fcmp olt float %partial_sum.0.lcssa.17, 0.000000e+00
  %sub42.17 = fsub float -0.000000e+00, %partial_sum.0.lcssa.17
  %cond.17 = select i1 %cmp41.17, float %sub42.17, float %partial_sum.0.lcssa.17
  %conv.17 = fptoui float %cond.17 to i8
  %conv43.17 = uitofp i8 %conv.17 to float
  %137 = add nsw i64 %indvars.iv.next21.16, %5
  %arrayidx47.17 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %137
  store float %conv43.17, float* %arrayidx47.17, align 4
  br label %for.inc53.17

if.else.17:                                       ; preds = %for.end38.17
  %138 = add nsw i64 %indvars.iv.next21.16, %4
  %arrayidx51.17 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %138
  store float %partial_sum.0.lcssa.17, float* %arrayidx51.17, align 4
  br label %for.inc53.17

for.inc53.17:                                     ; preds = %if.else.17, %if.then40.17
  %inc54.17 = add nsw i32 %in_j.011, 18
  %indvars.iv.next21.17 = add nsw i64 %indvars.iv20, 18
  br i1 %cmp94, label %for.end38.18, label %for.body10.18.preheader

for.body10.18.preheader:                          ; preds = %for.inc53.17
  br label %for.body10.18

for.body10.18:                                    ; preds = %for.body10.18.preheader, %for.inc36.18
  %ki.06.18 = phi i32 [ %inc37.18, %for.inc36.18 ], [ 0, %for.body10.18.preheader ]
  %partial_sum.05.18 = phi float [ %partial_sum.3.18, %for.inc36.18 ], [ 0.000000e+00, %for.body10.18.preheader ]
  %add.18 = add nsw i32 %ki.06.18, %in_i.015
  %notlhs.18 = icmp slt i32 %add.18, 0
  %notrhs.18 = icmp uge i32 %add.18, %img_height
  %.not.18 = or i1 %notrhs.18, %notlhs.18
  %brmerge.18 = or i1 %.not.18, %cmp151.not.18
  br i1 %brmerge.18, label %for.inc36.18, label %for.body16.lr.ph.18

for.body16.lr.ph.18:                              ; preds = %for.body10.18
  %mul.18 = shl i32 %add.18, 7
  %mul30.18 = mul i32 %ki.06.18, %kern_width
  br label %for.body16.18

for.body16.18:                                    ; preds = %for.inc.18, %for.body16.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body16.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc.18 ]
  %partial_sum.12.18 = phi float [ %partial_sum.05.18, %for.body16.lr.ph.18 ], [ %partial_sum.2.18, %for.inc.18 ]
  %139 = trunc i64 %indvars.iv.18 to i32
  %add17.18 = add nsw i32 %139, %inc54.17
  %cmp18.18 = icmp sgt i32 %add17.18, -1
  %cmp21.18 = icmp ult i32 %add17.18, %img_width
  %140 = and i1 %cmp18.18, %cmp21.18
  br i1 %140, label %if.end26.18, label %for.inc.18

if.end26.18:                                      ; preds = %for.body16.18
  %add29.18 = add nsw i32 %add17.18, %mul.18
  %idxprom.18 = sext i32 %add29.18 to i64
  %arrayidx.18 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.18
  %141 = load float, float* %arrayidx.18, align 4
  %142 = trunc i64 %indvars.iv.18 to i32
  %add31.18 = add i32 %142, %mul30.18
  %idxprom32.18 = zext i32 %add31.18 to i64
  %arrayidx33.18 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.18
  %143 = load float, float* %arrayidx33.18, align 4
  %mul34.18 = fmul float %141, %143
  %add35.18 = fadd float %partial_sum.12.18, %mul34.18
  br label %for.inc.18

for.inc.18:                                       ; preds = %if.end26.18, %for.body16.18
  %partial_sum.2.18 = phi float [ %add35.18, %if.end26.18 ], [ %partial_sum.12.18, %for.body16.18 ]
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %kern_width
  br i1 %exitcond.18, label %for.inc36.18.loopexit, label %for.body16.18, !llvm.loop !1

for.inc36.18.loopexit:                            ; preds = %for.inc.18
  %partial_sum.2.18.lcssa = phi float [ %partial_sum.2.18, %for.inc.18 ]
  br label %for.inc36.18

for.inc36.18:                                     ; preds = %for.inc36.18.loopexit, %for.body10.18
  %partial_sum.3.18 = phi float [ %partial_sum.05.18, %for.body10.18 ], [ %partial_sum.2.18.lcssa, %for.inc36.18.loopexit ]
  %inc37.18 = add nuw nsw i32 %ki.06.18, 1
  %exitcond19.18 = icmp eq i32 %inc37.18, %kern_height
  br i1 %exitcond19.18, label %for.end38.18.loopexit, label %for.body10.18, !llvm.loop !3

for.end38.18.loopexit:                            ; preds = %for.inc36.18
  %partial_sum.3.18.lcssa = phi float [ %partial_sum.3.18, %for.inc36.18 ]
  br label %for.end38.18

for.end38.18:                                     ; preds = %for.end38.18.loopexit, %for.inc53.17
  %partial_sum.0.lcssa.18 = phi float [ 0.000000e+00, %for.inc53.17 ], [ %partial_sum.3.18.lcssa, %for.end38.18.loopexit ]
  br i1 %tobool39, label %if.else.18, label %if.then40.18

if.then40.18:                                     ; preds = %for.end38.18
  %cmp41.18 = fcmp olt float %partial_sum.0.lcssa.18, 0.000000e+00
  %sub42.18 = fsub float -0.000000e+00, %partial_sum.0.lcssa.18
  %cond.18 = select i1 %cmp41.18, float %sub42.18, float %partial_sum.0.lcssa.18
  %conv.18 = fptoui float %cond.18 to i8
  %conv43.18 = uitofp i8 %conv.18 to float
  %144 = add nsw i64 %indvars.iv.next21.17, %5
  %arrayidx47.18 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %144
  store float %conv43.18, float* %arrayidx47.18, align 4
  br label %for.inc53.18

if.else.18:                                       ; preds = %for.end38.18
  %145 = add nsw i64 %indvars.iv.next21.17, %4
  %arrayidx51.18 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %145
  store float %partial_sum.0.lcssa.18, float* %arrayidx51.18, align 4
  br label %for.inc53.18

for.inc53.18:                                     ; preds = %if.else.18, %if.then40.18
  %inc54.18 = add nsw i32 %in_j.011, 19
  %indvars.iv.next21.18 = add nsw i64 %indvars.iv20, 19
  br i1 %cmp94, label %for.end38.19, label %for.body10.19.preheader

for.body10.19.preheader:                          ; preds = %for.inc53.18
  br label %for.body10.19

for.body10.19:                                    ; preds = %for.body10.19.preheader, %for.inc36.19
  %ki.06.19 = phi i32 [ %inc37.19, %for.inc36.19 ], [ 0, %for.body10.19.preheader ]
  %partial_sum.05.19 = phi float [ %partial_sum.3.19, %for.inc36.19 ], [ 0.000000e+00, %for.body10.19.preheader ]
  %add.19 = add nsw i32 %ki.06.19, %in_i.015
  %notlhs.19 = icmp slt i32 %add.19, 0
  %notrhs.19 = icmp uge i32 %add.19, %img_height
  %.not.19 = or i1 %notrhs.19, %notlhs.19
  %brmerge.19 = or i1 %.not.19, %cmp151.not.19
  br i1 %brmerge.19, label %for.inc36.19, label %for.body16.lr.ph.19

for.body16.lr.ph.19:                              ; preds = %for.body10.19
  %mul.19 = shl i32 %add.19, 7
  %mul30.19 = mul i32 %ki.06.19, %kern_width
  br label %for.body16.19

for.body16.19:                                    ; preds = %for.inc.19, %for.body16.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body16.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc.19 ]
  %partial_sum.12.19 = phi float [ %partial_sum.05.19, %for.body16.lr.ph.19 ], [ %partial_sum.2.19, %for.inc.19 ]
  %146 = trunc i64 %indvars.iv.19 to i32
  %add17.19 = add nsw i32 %146, %inc54.18
  %cmp18.19 = icmp sgt i32 %add17.19, -1
  %cmp21.19 = icmp ult i32 %add17.19, %img_width
  %147 = and i1 %cmp18.19, %cmp21.19
  br i1 %147, label %if.end26.19, label %for.inc.19

if.end26.19:                                      ; preds = %for.body16.19
  %add29.19 = add nsw i32 %add17.19, %mul.19
  %idxprom.19 = sext i32 %add29.19 to i64
  %arrayidx.19 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.19
  %148 = load float, float* %arrayidx.19, align 4
  %149 = trunc i64 %indvars.iv.19 to i32
  %add31.19 = add i32 %149, %mul30.19
  %idxprom32.19 = zext i32 %add31.19 to i64
  %arrayidx33.19 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.19
  %150 = load float, float* %arrayidx33.19, align 4
  %mul34.19 = fmul float %148, %150
  %add35.19 = fadd float %partial_sum.12.19, %mul34.19
  br label %for.inc.19

for.inc.19:                                       ; preds = %if.end26.19, %for.body16.19
  %partial_sum.2.19 = phi float [ %add35.19, %if.end26.19 ], [ %partial_sum.12.19, %for.body16.19 ]
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %kern_width
  br i1 %exitcond.19, label %for.inc36.19.loopexit, label %for.body16.19, !llvm.loop !1

for.inc36.19.loopexit:                            ; preds = %for.inc.19
  %partial_sum.2.19.lcssa = phi float [ %partial_sum.2.19, %for.inc.19 ]
  br label %for.inc36.19

for.inc36.19:                                     ; preds = %for.inc36.19.loopexit, %for.body10.19
  %partial_sum.3.19 = phi float [ %partial_sum.05.19, %for.body10.19 ], [ %partial_sum.2.19.lcssa, %for.inc36.19.loopexit ]
  %inc37.19 = add nuw nsw i32 %ki.06.19, 1
  %exitcond19.19 = icmp eq i32 %inc37.19, %kern_height
  br i1 %exitcond19.19, label %for.end38.19.loopexit, label %for.body10.19, !llvm.loop !3

for.end38.19.loopexit:                            ; preds = %for.inc36.19
  %partial_sum.3.19.lcssa = phi float [ %partial_sum.3.19, %for.inc36.19 ]
  br label %for.end38.19

for.end38.19:                                     ; preds = %for.end38.19.loopexit, %for.inc53.18
  %partial_sum.0.lcssa.19 = phi float [ 0.000000e+00, %for.inc53.18 ], [ %partial_sum.3.19.lcssa, %for.end38.19.loopexit ]
  br i1 %tobool39, label %if.else.19, label %if.then40.19

if.then40.19:                                     ; preds = %for.end38.19
  %cmp41.19 = fcmp olt float %partial_sum.0.lcssa.19, 0.000000e+00
  %sub42.19 = fsub float -0.000000e+00, %partial_sum.0.lcssa.19
  %cond.19 = select i1 %cmp41.19, float %sub42.19, float %partial_sum.0.lcssa.19
  %conv.19 = fptoui float %cond.19 to i8
  %conv43.19 = uitofp i8 %conv.19 to float
  %151 = add nsw i64 %indvars.iv.next21.18, %5
  %arrayidx47.19 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %151
  store float %conv43.19, float* %arrayidx47.19, align 4
  br label %for.inc53.19

if.else.19:                                       ; preds = %for.end38.19
  %152 = add nsw i64 %indvars.iv.next21.18, %4
  %arrayidx51.19 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %152
  store float %partial_sum.0.lcssa.19, float* %arrayidx51.19, align 4
  br label %for.inc53.19

for.inc53.19:                                     ; preds = %if.else.19, %if.then40.19
  %inc54.19 = add nsw i32 %in_j.011, 20
  %indvars.iv.next21.19 = add nsw i64 %indvars.iv20, 20
  br i1 %cmp94, label %for.end38.20, label %for.body10.20.preheader

for.body10.20.preheader:                          ; preds = %for.inc53.19
  br label %for.body10.20

for.body10.20:                                    ; preds = %for.body10.20.preheader, %for.inc36.20
  %ki.06.20 = phi i32 [ %inc37.20, %for.inc36.20 ], [ 0, %for.body10.20.preheader ]
  %partial_sum.05.20 = phi float [ %partial_sum.3.20, %for.inc36.20 ], [ 0.000000e+00, %for.body10.20.preheader ]
  %add.20 = add nsw i32 %ki.06.20, %in_i.015
  %notlhs.20 = icmp slt i32 %add.20, 0
  %notrhs.20 = icmp uge i32 %add.20, %img_height
  %.not.20 = or i1 %notrhs.20, %notlhs.20
  %brmerge.20 = or i1 %.not.20, %cmp151.not.20
  br i1 %brmerge.20, label %for.inc36.20, label %for.body16.lr.ph.20

for.body16.lr.ph.20:                              ; preds = %for.body10.20
  %mul.20 = shl i32 %add.20, 7
  %mul30.20 = mul i32 %ki.06.20, %kern_width
  br label %for.body16.20

for.body16.20:                                    ; preds = %for.inc.20, %for.body16.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body16.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc.20 ]
  %partial_sum.12.20 = phi float [ %partial_sum.05.20, %for.body16.lr.ph.20 ], [ %partial_sum.2.20, %for.inc.20 ]
  %153 = trunc i64 %indvars.iv.20 to i32
  %add17.20 = add nsw i32 %153, %inc54.19
  %cmp18.20 = icmp sgt i32 %add17.20, -1
  %cmp21.20 = icmp ult i32 %add17.20, %img_width
  %154 = and i1 %cmp18.20, %cmp21.20
  br i1 %154, label %if.end26.20, label %for.inc.20

if.end26.20:                                      ; preds = %for.body16.20
  %add29.20 = add nsw i32 %add17.20, %mul.20
  %idxprom.20 = sext i32 %add29.20 to i64
  %arrayidx.20 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.20
  %155 = load float, float* %arrayidx.20, align 4
  %156 = trunc i64 %indvars.iv.20 to i32
  %add31.20 = add i32 %156, %mul30.20
  %idxprom32.20 = zext i32 %add31.20 to i64
  %arrayidx33.20 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.20
  %157 = load float, float* %arrayidx33.20, align 4
  %mul34.20 = fmul float %155, %157
  %add35.20 = fadd float %partial_sum.12.20, %mul34.20
  br label %for.inc.20

for.inc.20:                                       ; preds = %if.end26.20, %for.body16.20
  %partial_sum.2.20 = phi float [ %add35.20, %if.end26.20 ], [ %partial_sum.12.20, %for.body16.20 ]
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %kern_width
  br i1 %exitcond.20, label %for.inc36.20.loopexit, label %for.body16.20, !llvm.loop !1

for.inc36.20.loopexit:                            ; preds = %for.inc.20
  %partial_sum.2.20.lcssa = phi float [ %partial_sum.2.20, %for.inc.20 ]
  br label %for.inc36.20

for.inc36.20:                                     ; preds = %for.inc36.20.loopexit, %for.body10.20
  %partial_sum.3.20 = phi float [ %partial_sum.05.20, %for.body10.20 ], [ %partial_sum.2.20.lcssa, %for.inc36.20.loopexit ]
  %inc37.20 = add nuw nsw i32 %ki.06.20, 1
  %exitcond19.20 = icmp eq i32 %inc37.20, %kern_height
  br i1 %exitcond19.20, label %for.end38.20.loopexit, label %for.body10.20, !llvm.loop !3

for.end38.20.loopexit:                            ; preds = %for.inc36.20
  %partial_sum.3.20.lcssa = phi float [ %partial_sum.3.20, %for.inc36.20 ]
  br label %for.end38.20

for.end38.20:                                     ; preds = %for.end38.20.loopexit, %for.inc53.19
  %partial_sum.0.lcssa.20 = phi float [ 0.000000e+00, %for.inc53.19 ], [ %partial_sum.3.20.lcssa, %for.end38.20.loopexit ]
  br i1 %tobool39, label %if.else.20, label %if.then40.20

if.then40.20:                                     ; preds = %for.end38.20
  %cmp41.20 = fcmp olt float %partial_sum.0.lcssa.20, 0.000000e+00
  %sub42.20 = fsub float -0.000000e+00, %partial_sum.0.lcssa.20
  %cond.20 = select i1 %cmp41.20, float %sub42.20, float %partial_sum.0.lcssa.20
  %conv.20 = fptoui float %cond.20 to i8
  %conv43.20 = uitofp i8 %conv.20 to float
  %158 = add nsw i64 %indvars.iv.next21.19, %5
  %arrayidx47.20 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %158
  store float %conv43.20, float* %arrayidx47.20, align 4
  br label %for.inc53.20

if.else.20:                                       ; preds = %for.end38.20
  %159 = add nsw i64 %indvars.iv.next21.19, %4
  %arrayidx51.20 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %159
  store float %partial_sum.0.lcssa.20, float* %arrayidx51.20, align 4
  br label %for.inc53.20

for.inc53.20:                                     ; preds = %if.else.20, %if.then40.20
  %inc54.20 = add nsw i32 %in_j.011, 21
  %indvars.iv.next21.20 = add nsw i64 %indvars.iv20, 21
  br i1 %cmp94, label %for.end38.21, label %for.body10.21.preheader

for.body10.21.preheader:                          ; preds = %for.inc53.20
  br label %for.body10.21

for.body10.21:                                    ; preds = %for.body10.21.preheader, %for.inc36.21
  %ki.06.21 = phi i32 [ %inc37.21, %for.inc36.21 ], [ 0, %for.body10.21.preheader ]
  %partial_sum.05.21 = phi float [ %partial_sum.3.21, %for.inc36.21 ], [ 0.000000e+00, %for.body10.21.preheader ]
  %add.21 = add nsw i32 %ki.06.21, %in_i.015
  %notlhs.21 = icmp slt i32 %add.21, 0
  %notrhs.21 = icmp uge i32 %add.21, %img_height
  %.not.21 = or i1 %notrhs.21, %notlhs.21
  %brmerge.21 = or i1 %.not.21, %cmp151.not.21
  br i1 %brmerge.21, label %for.inc36.21, label %for.body16.lr.ph.21

for.body16.lr.ph.21:                              ; preds = %for.body10.21
  %mul.21 = shl i32 %add.21, 7
  %mul30.21 = mul i32 %ki.06.21, %kern_width
  br label %for.body16.21

for.body16.21:                                    ; preds = %for.inc.21, %for.body16.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body16.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc.21 ]
  %partial_sum.12.21 = phi float [ %partial_sum.05.21, %for.body16.lr.ph.21 ], [ %partial_sum.2.21, %for.inc.21 ]
  %160 = trunc i64 %indvars.iv.21 to i32
  %add17.21 = add nsw i32 %160, %inc54.20
  %cmp18.21 = icmp sgt i32 %add17.21, -1
  %cmp21.21 = icmp ult i32 %add17.21, %img_width
  %161 = and i1 %cmp18.21, %cmp21.21
  br i1 %161, label %if.end26.21, label %for.inc.21

if.end26.21:                                      ; preds = %for.body16.21
  %add29.21 = add nsw i32 %add17.21, %mul.21
  %idxprom.21 = sext i32 %add29.21 to i64
  %arrayidx.21 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.21
  %162 = load float, float* %arrayidx.21, align 4
  %163 = trunc i64 %indvars.iv.21 to i32
  %add31.21 = add i32 %163, %mul30.21
  %idxprom32.21 = zext i32 %add31.21 to i64
  %arrayidx33.21 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.21
  %164 = load float, float* %arrayidx33.21, align 4
  %mul34.21 = fmul float %162, %164
  %add35.21 = fadd float %partial_sum.12.21, %mul34.21
  br label %for.inc.21

for.inc.21:                                       ; preds = %if.end26.21, %for.body16.21
  %partial_sum.2.21 = phi float [ %add35.21, %if.end26.21 ], [ %partial_sum.12.21, %for.body16.21 ]
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %kern_width
  br i1 %exitcond.21, label %for.inc36.21.loopexit, label %for.body16.21, !llvm.loop !1

for.inc36.21.loopexit:                            ; preds = %for.inc.21
  %partial_sum.2.21.lcssa = phi float [ %partial_sum.2.21, %for.inc.21 ]
  br label %for.inc36.21

for.inc36.21:                                     ; preds = %for.inc36.21.loopexit, %for.body10.21
  %partial_sum.3.21 = phi float [ %partial_sum.05.21, %for.body10.21 ], [ %partial_sum.2.21.lcssa, %for.inc36.21.loopexit ]
  %inc37.21 = add nuw nsw i32 %ki.06.21, 1
  %exitcond19.21 = icmp eq i32 %inc37.21, %kern_height
  br i1 %exitcond19.21, label %for.end38.21.loopexit, label %for.body10.21, !llvm.loop !3

for.end38.21.loopexit:                            ; preds = %for.inc36.21
  %partial_sum.3.21.lcssa = phi float [ %partial_sum.3.21, %for.inc36.21 ]
  br label %for.end38.21

for.end38.21:                                     ; preds = %for.end38.21.loopexit, %for.inc53.20
  %partial_sum.0.lcssa.21 = phi float [ 0.000000e+00, %for.inc53.20 ], [ %partial_sum.3.21.lcssa, %for.end38.21.loopexit ]
  br i1 %tobool39, label %if.else.21, label %if.then40.21

if.then40.21:                                     ; preds = %for.end38.21
  %cmp41.21 = fcmp olt float %partial_sum.0.lcssa.21, 0.000000e+00
  %sub42.21 = fsub float -0.000000e+00, %partial_sum.0.lcssa.21
  %cond.21 = select i1 %cmp41.21, float %sub42.21, float %partial_sum.0.lcssa.21
  %conv.21 = fptoui float %cond.21 to i8
  %conv43.21 = uitofp i8 %conv.21 to float
  %165 = add nsw i64 %indvars.iv.next21.20, %5
  %arrayidx47.21 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %165
  store float %conv43.21, float* %arrayidx47.21, align 4
  br label %for.inc53.21

if.else.21:                                       ; preds = %for.end38.21
  %166 = add nsw i64 %indvars.iv.next21.20, %4
  %arrayidx51.21 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %166
  store float %partial_sum.0.lcssa.21, float* %arrayidx51.21, align 4
  br label %for.inc53.21

for.inc53.21:                                     ; preds = %if.else.21, %if.then40.21
  %inc54.21 = add nsw i32 %in_j.011, 22
  %indvars.iv.next21.21 = add nsw i64 %indvars.iv20, 22
  br i1 %cmp94, label %for.end38.22, label %for.body10.22.preheader

for.body10.22.preheader:                          ; preds = %for.inc53.21
  br label %for.body10.22

for.body10.22:                                    ; preds = %for.body10.22.preheader, %for.inc36.22
  %ki.06.22 = phi i32 [ %inc37.22, %for.inc36.22 ], [ 0, %for.body10.22.preheader ]
  %partial_sum.05.22 = phi float [ %partial_sum.3.22, %for.inc36.22 ], [ 0.000000e+00, %for.body10.22.preheader ]
  %add.22 = add nsw i32 %ki.06.22, %in_i.015
  %notlhs.22 = icmp slt i32 %add.22, 0
  %notrhs.22 = icmp uge i32 %add.22, %img_height
  %.not.22 = or i1 %notrhs.22, %notlhs.22
  %brmerge.22 = or i1 %.not.22, %cmp151.not.22
  br i1 %brmerge.22, label %for.inc36.22, label %for.body16.lr.ph.22

for.body16.lr.ph.22:                              ; preds = %for.body10.22
  %mul.22 = shl i32 %add.22, 7
  %mul30.22 = mul i32 %ki.06.22, %kern_width
  br label %for.body16.22

for.body16.22:                                    ; preds = %for.inc.22, %for.body16.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body16.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc.22 ]
  %partial_sum.12.22 = phi float [ %partial_sum.05.22, %for.body16.lr.ph.22 ], [ %partial_sum.2.22, %for.inc.22 ]
  %167 = trunc i64 %indvars.iv.22 to i32
  %add17.22 = add nsw i32 %167, %inc54.21
  %cmp18.22 = icmp sgt i32 %add17.22, -1
  %cmp21.22 = icmp ult i32 %add17.22, %img_width
  %168 = and i1 %cmp18.22, %cmp21.22
  br i1 %168, label %if.end26.22, label %for.inc.22

if.end26.22:                                      ; preds = %for.body16.22
  %add29.22 = add nsw i32 %add17.22, %mul.22
  %idxprom.22 = sext i32 %add29.22 to i64
  %arrayidx.22 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.22
  %169 = load float, float* %arrayidx.22, align 4
  %170 = trunc i64 %indvars.iv.22 to i32
  %add31.22 = add i32 %170, %mul30.22
  %idxprom32.22 = zext i32 %add31.22 to i64
  %arrayidx33.22 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.22
  %171 = load float, float* %arrayidx33.22, align 4
  %mul34.22 = fmul float %169, %171
  %add35.22 = fadd float %partial_sum.12.22, %mul34.22
  br label %for.inc.22

for.inc.22:                                       ; preds = %if.end26.22, %for.body16.22
  %partial_sum.2.22 = phi float [ %add35.22, %if.end26.22 ], [ %partial_sum.12.22, %for.body16.22 ]
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %kern_width
  br i1 %exitcond.22, label %for.inc36.22.loopexit, label %for.body16.22, !llvm.loop !1

for.inc36.22.loopexit:                            ; preds = %for.inc.22
  %partial_sum.2.22.lcssa = phi float [ %partial_sum.2.22, %for.inc.22 ]
  br label %for.inc36.22

for.inc36.22:                                     ; preds = %for.inc36.22.loopexit, %for.body10.22
  %partial_sum.3.22 = phi float [ %partial_sum.05.22, %for.body10.22 ], [ %partial_sum.2.22.lcssa, %for.inc36.22.loopexit ]
  %inc37.22 = add nuw nsw i32 %ki.06.22, 1
  %exitcond19.22 = icmp eq i32 %inc37.22, %kern_height
  br i1 %exitcond19.22, label %for.end38.22.loopexit, label %for.body10.22, !llvm.loop !3

for.end38.22.loopexit:                            ; preds = %for.inc36.22
  %partial_sum.3.22.lcssa = phi float [ %partial_sum.3.22, %for.inc36.22 ]
  br label %for.end38.22

for.end38.22:                                     ; preds = %for.end38.22.loopexit, %for.inc53.21
  %partial_sum.0.lcssa.22 = phi float [ 0.000000e+00, %for.inc53.21 ], [ %partial_sum.3.22.lcssa, %for.end38.22.loopexit ]
  br i1 %tobool39, label %if.else.22, label %if.then40.22

if.then40.22:                                     ; preds = %for.end38.22
  %cmp41.22 = fcmp olt float %partial_sum.0.lcssa.22, 0.000000e+00
  %sub42.22 = fsub float -0.000000e+00, %partial_sum.0.lcssa.22
  %cond.22 = select i1 %cmp41.22, float %sub42.22, float %partial_sum.0.lcssa.22
  %conv.22 = fptoui float %cond.22 to i8
  %conv43.22 = uitofp i8 %conv.22 to float
  %172 = add nsw i64 %indvars.iv.next21.21, %5
  %arrayidx47.22 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %172
  store float %conv43.22, float* %arrayidx47.22, align 4
  br label %for.inc53.22

if.else.22:                                       ; preds = %for.end38.22
  %173 = add nsw i64 %indvars.iv.next21.21, %4
  %arrayidx51.22 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %173
  store float %partial_sum.0.lcssa.22, float* %arrayidx51.22, align 4
  br label %for.inc53.22

for.inc53.22:                                     ; preds = %if.else.22, %if.then40.22
  %inc54.22 = add nsw i32 %in_j.011, 23
  %indvars.iv.next21.22 = add nsw i64 %indvars.iv20, 23
  br i1 %cmp94, label %for.end38.23, label %for.body10.23.preheader

for.body10.23.preheader:                          ; preds = %for.inc53.22
  br label %for.body10.23

for.body10.23:                                    ; preds = %for.body10.23.preheader, %for.inc36.23
  %ki.06.23 = phi i32 [ %inc37.23, %for.inc36.23 ], [ 0, %for.body10.23.preheader ]
  %partial_sum.05.23 = phi float [ %partial_sum.3.23, %for.inc36.23 ], [ 0.000000e+00, %for.body10.23.preheader ]
  %add.23 = add nsw i32 %ki.06.23, %in_i.015
  %notlhs.23 = icmp slt i32 %add.23, 0
  %notrhs.23 = icmp uge i32 %add.23, %img_height
  %.not.23 = or i1 %notrhs.23, %notlhs.23
  %brmerge.23 = or i1 %.not.23, %cmp151.not.23
  br i1 %brmerge.23, label %for.inc36.23, label %for.body16.lr.ph.23

for.body16.lr.ph.23:                              ; preds = %for.body10.23
  %mul.23 = shl i32 %add.23, 7
  %mul30.23 = mul i32 %ki.06.23, %kern_width
  br label %for.body16.23

for.body16.23:                                    ; preds = %for.inc.23, %for.body16.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body16.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc.23 ]
  %partial_sum.12.23 = phi float [ %partial_sum.05.23, %for.body16.lr.ph.23 ], [ %partial_sum.2.23, %for.inc.23 ]
  %174 = trunc i64 %indvars.iv.23 to i32
  %add17.23 = add nsw i32 %174, %inc54.22
  %cmp18.23 = icmp sgt i32 %add17.23, -1
  %cmp21.23 = icmp ult i32 %add17.23, %img_width
  %175 = and i1 %cmp18.23, %cmp21.23
  br i1 %175, label %if.end26.23, label %for.inc.23

if.end26.23:                                      ; preds = %for.body16.23
  %add29.23 = add nsw i32 %add17.23, %mul.23
  %idxprom.23 = sext i32 %add29.23 to i64
  %arrayidx.23 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.23
  %176 = load float, float* %arrayidx.23, align 4
  %177 = trunc i64 %indvars.iv.23 to i32
  %add31.23 = add i32 %177, %mul30.23
  %idxprom32.23 = zext i32 %add31.23 to i64
  %arrayidx33.23 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.23
  %178 = load float, float* %arrayidx33.23, align 4
  %mul34.23 = fmul float %176, %178
  %add35.23 = fadd float %partial_sum.12.23, %mul34.23
  br label %for.inc.23

for.inc.23:                                       ; preds = %if.end26.23, %for.body16.23
  %partial_sum.2.23 = phi float [ %add35.23, %if.end26.23 ], [ %partial_sum.12.23, %for.body16.23 ]
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %kern_width
  br i1 %exitcond.23, label %for.inc36.23.loopexit, label %for.body16.23, !llvm.loop !1

for.inc36.23.loopexit:                            ; preds = %for.inc.23
  %partial_sum.2.23.lcssa = phi float [ %partial_sum.2.23, %for.inc.23 ]
  br label %for.inc36.23

for.inc36.23:                                     ; preds = %for.inc36.23.loopexit, %for.body10.23
  %partial_sum.3.23 = phi float [ %partial_sum.05.23, %for.body10.23 ], [ %partial_sum.2.23.lcssa, %for.inc36.23.loopexit ]
  %inc37.23 = add nuw nsw i32 %ki.06.23, 1
  %exitcond19.23 = icmp eq i32 %inc37.23, %kern_height
  br i1 %exitcond19.23, label %for.end38.23.loopexit, label %for.body10.23, !llvm.loop !3

for.end38.23.loopexit:                            ; preds = %for.inc36.23
  %partial_sum.3.23.lcssa = phi float [ %partial_sum.3.23, %for.inc36.23 ]
  br label %for.end38.23

for.end38.23:                                     ; preds = %for.end38.23.loopexit, %for.inc53.22
  %partial_sum.0.lcssa.23 = phi float [ 0.000000e+00, %for.inc53.22 ], [ %partial_sum.3.23.lcssa, %for.end38.23.loopexit ]
  br i1 %tobool39, label %if.else.23, label %if.then40.23

if.then40.23:                                     ; preds = %for.end38.23
  %cmp41.23 = fcmp olt float %partial_sum.0.lcssa.23, 0.000000e+00
  %sub42.23 = fsub float -0.000000e+00, %partial_sum.0.lcssa.23
  %cond.23 = select i1 %cmp41.23, float %sub42.23, float %partial_sum.0.lcssa.23
  %conv.23 = fptoui float %cond.23 to i8
  %conv43.23 = uitofp i8 %conv.23 to float
  %179 = add nsw i64 %indvars.iv.next21.22, %5
  %arrayidx47.23 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %179
  store float %conv43.23, float* %arrayidx47.23, align 4
  br label %for.inc53.23

if.else.23:                                       ; preds = %for.end38.23
  %180 = add nsw i64 %indvars.iv.next21.22, %4
  %arrayidx51.23 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %180
  store float %partial_sum.0.lcssa.23, float* %arrayidx51.23, align 4
  br label %for.inc53.23

for.inc53.23:                                     ; preds = %if.else.23, %if.then40.23
  %inc54.23 = add nsw i32 %in_j.011, 24
  %indvars.iv.next21.23 = add nsw i64 %indvars.iv20, 24
  br i1 %cmp94, label %for.end38.24, label %for.body10.24.preheader

for.body10.24.preheader:                          ; preds = %for.inc53.23
  br label %for.body10.24

for.body10.24:                                    ; preds = %for.body10.24.preheader, %for.inc36.24
  %ki.06.24 = phi i32 [ %inc37.24, %for.inc36.24 ], [ 0, %for.body10.24.preheader ]
  %partial_sum.05.24 = phi float [ %partial_sum.3.24, %for.inc36.24 ], [ 0.000000e+00, %for.body10.24.preheader ]
  %add.24 = add nsw i32 %ki.06.24, %in_i.015
  %notlhs.24 = icmp slt i32 %add.24, 0
  %notrhs.24 = icmp uge i32 %add.24, %img_height
  %.not.24 = or i1 %notrhs.24, %notlhs.24
  %brmerge.24 = or i1 %.not.24, %cmp151.not.24
  br i1 %brmerge.24, label %for.inc36.24, label %for.body16.lr.ph.24

for.body16.lr.ph.24:                              ; preds = %for.body10.24
  %mul.24 = shl i32 %add.24, 7
  %mul30.24 = mul i32 %ki.06.24, %kern_width
  br label %for.body16.24

for.body16.24:                                    ; preds = %for.inc.24, %for.body16.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body16.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc.24 ]
  %partial_sum.12.24 = phi float [ %partial_sum.05.24, %for.body16.lr.ph.24 ], [ %partial_sum.2.24, %for.inc.24 ]
  %181 = trunc i64 %indvars.iv.24 to i32
  %add17.24 = add nsw i32 %181, %inc54.23
  %cmp18.24 = icmp sgt i32 %add17.24, -1
  %cmp21.24 = icmp ult i32 %add17.24, %img_width
  %182 = and i1 %cmp18.24, %cmp21.24
  br i1 %182, label %if.end26.24, label %for.inc.24

if.end26.24:                                      ; preds = %for.body16.24
  %add29.24 = add nsw i32 %add17.24, %mul.24
  %idxprom.24 = sext i32 %add29.24 to i64
  %arrayidx.24 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.24
  %183 = load float, float* %arrayidx.24, align 4
  %184 = trunc i64 %indvars.iv.24 to i32
  %add31.24 = add i32 %184, %mul30.24
  %idxprom32.24 = zext i32 %add31.24 to i64
  %arrayidx33.24 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.24
  %185 = load float, float* %arrayidx33.24, align 4
  %mul34.24 = fmul float %183, %185
  %add35.24 = fadd float %partial_sum.12.24, %mul34.24
  br label %for.inc.24

for.inc.24:                                       ; preds = %if.end26.24, %for.body16.24
  %partial_sum.2.24 = phi float [ %add35.24, %if.end26.24 ], [ %partial_sum.12.24, %for.body16.24 ]
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %kern_width
  br i1 %exitcond.24, label %for.inc36.24.loopexit, label %for.body16.24, !llvm.loop !1

for.inc36.24.loopexit:                            ; preds = %for.inc.24
  %partial_sum.2.24.lcssa = phi float [ %partial_sum.2.24, %for.inc.24 ]
  br label %for.inc36.24

for.inc36.24:                                     ; preds = %for.inc36.24.loopexit, %for.body10.24
  %partial_sum.3.24 = phi float [ %partial_sum.05.24, %for.body10.24 ], [ %partial_sum.2.24.lcssa, %for.inc36.24.loopexit ]
  %inc37.24 = add nuw nsw i32 %ki.06.24, 1
  %exitcond19.24 = icmp eq i32 %inc37.24, %kern_height
  br i1 %exitcond19.24, label %for.end38.24.loopexit, label %for.body10.24, !llvm.loop !3

for.end38.24.loopexit:                            ; preds = %for.inc36.24
  %partial_sum.3.24.lcssa = phi float [ %partial_sum.3.24, %for.inc36.24 ]
  br label %for.end38.24

for.end38.24:                                     ; preds = %for.end38.24.loopexit, %for.inc53.23
  %partial_sum.0.lcssa.24 = phi float [ 0.000000e+00, %for.inc53.23 ], [ %partial_sum.3.24.lcssa, %for.end38.24.loopexit ]
  br i1 %tobool39, label %if.else.24, label %if.then40.24

if.then40.24:                                     ; preds = %for.end38.24
  %cmp41.24 = fcmp olt float %partial_sum.0.lcssa.24, 0.000000e+00
  %sub42.24 = fsub float -0.000000e+00, %partial_sum.0.lcssa.24
  %cond.24 = select i1 %cmp41.24, float %sub42.24, float %partial_sum.0.lcssa.24
  %conv.24 = fptoui float %cond.24 to i8
  %conv43.24 = uitofp i8 %conv.24 to float
  %186 = add nsw i64 %indvars.iv.next21.23, %5
  %arrayidx47.24 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %186
  store float %conv43.24, float* %arrayidx47.24, align 4
  br label %for.inc53.24

if.else.24:                                       ; preds = %for.end38.24
  %187 = add nsw i64 %indvars.iv.next21.23, %4
  %arrayidx51.24 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %187
  store float %partial_sum.0.lcssa.24, float* %arrayidx51.24, align 4
  br label %for.inc53.24

for.inc53.24:                                     ; preds = %if.else.24, %if.then40.24
  %inc54.24 = add nsw i32 %in_j.011, 25
  %indvars.iv.next21.24 = add nsw i64 %indvars.iv20, 25
  br i1 %cmp94, label %for.end38.25, label %for.body10.25.preheader

for.body10.25.preheader:                          ; preds = %for.inc53.24
  br label %for.body10.25

for.body10.25:                                    ; preds = %for.body10.25.preheader, %for.inc36.25
  %ki.06.25 = phi i32 [ %inc37.25, %for.inc36.25 ], [ 0, %for.body10.25.preheader ]
  %partial_sum.05.25 = phi float [ %partial_sum.3.25, %for.inc36.25 ], [ 0.000000e+00, %for.body10.25.preheader ]
  %add.25 = add nsw i32 %ki.06.25, %in_i.015
  %notlhs.25 = icmp slt i32 %add.25, 0
  %notrhs.25 = icmp uge i32 %add.25, %img_height
  %.not.25 = or i1 %notrhs.25, %notlhs.25
  %brmerge.25 = or i1 %.not.25, %cmp151.not.25
  br i1 %brmerge.25, label %for.inc36.25, label %for.body16.lr.ph.25

for.body16.lr.ph.25:                              ; preds = %for.body10.25
  %mul.25 = shl i32 %add.25, 7
  %mul30.25 = mul i32 %ki.06.25, %kern_width
  br label %for.body16.25

for.body16.25:                                    ; preds = %for.inc.25, %for.body16.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body16.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc.25 ]
  %partial_sum.12.25 = phi float [ %partial_sum.05.25, %for.body16.lr.ph.25 ], [ %partial_sum.2.25, %for.inc.25 ]
  %188 = trunc i64 %indvars.iv.25 to i32
  %add17.25 = add nsw i32 %188, %inc54.24
  %cmp18.25 = icmp sgt i32 %add17.25, -1
  %cmp21.25 = icmp ult i32 %add17.25, %img_width
  %189 = and i1 %cmp18.25, %cmp21.25
  br i1 %189, label %if.end26.25, label %for.inc.25

if.end26.25:                                      ; preds = %for.body16.25
  %add29.25 = add nsw i32 %add17.25, %mul.25
  %idxprom.25 = sext i32 %add29.25 to i64
  %arrayidx.25 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.25
  %190 = load float, float* %arrayidx.25, align 4
  %191 = trunc i64 %indvars.iv.25 to i32
  %add31.25 = add i32 %191, %mul30.25
  %idxprom32.25 = zext i32 %add31.25 to i64
  %arrayidx33.25 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.25
  %192 = load float, float* %arrayidx33.25, align 4
  %mul34.25 = fmul float %190, %192
  %add35.25 = fadd float %partial_sum.12.25, %mul34.25
  br label %for.inc.25

for.inc.25:                                       ; preds = %if.end26.25, %for.body16.25
  %partial_sum.2.25 = phi float [ %add35.25, %if.end26.25 ], [ %partial_sum.12.25, %for.body16.25 ]
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %kern_width
  br i1 %exitcond.25, label %for.inc36.25.loopexit, label %for.body16.25, !llvm.loop !1

for.inc36.25.loopexit:                            ; preds = %for.inc.25
  %partial_sum.2.25.lcssa = phi float [ %partial_sum.2.25, %for.inc.25 ]
  br label %for.inc36.25

for.inc36.25:                                     ; preds = %for.inc36.25.loopexit, %for.body10.25
  %partial_sum.3.25 = phi float [ %partial_sum.05.25, %for.body10.25 ], [ %partial_sum.2.25.lcssa, %for.inc36.25.loopexit ]
  %inc37.25 = add nuw nsw i32 %ki.06.25, 1
  %exitcond19.25 = icmp eq i32 %inc37.25, %kern_height
  br i1 %exitcond19.25, label %for.end38.25.loopexit, label %for.body10.25, !llvm.loop !3

for.end38.25.loopexit:                            ; preds = %for.inc36.25
  %partial_sum.3.25.lcssa = phi float [ %partial_sum.3.25, %for.inc36.25 ]
  br label %for.end38.25

for.end38.25:                                     ; preds = %for.end38.25.loopexit, %for.inc53.24
  %partial_sum.0.lcssa.25 = phi float [ 0.000000e+00, %for.inc53.24 ], [ %partial_sum.3.25.lcssa, %for.end38.25.loopexit ]
  br i1 %tobool39, label %if.else.25, label %if.then40.25

if.then40.25:                                     ; preds = %for.end38.25
  %cmp41.25 = fcmp olt float %partial_sum.0.lcssa.25, 0.000000e+00
  %sub42.25 = fsub float -0.000000e+00, %partial_sum.0.lcssa.25
  %cond.25 = select i1 %cmp41.25, float %sub42.25, float %partial_sum.0.lcssa.25
  %conv.25 = fptoui float %cond.25 to i8
  %conv43.25 = uitofp i8 %conv.25 to float
  %193 = add nsw i64 %indvars.iv.next21.24, %5
  %arrayidx47.25 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %193
  store float %conv43.25, float* %arrayidx47.25, align 4
  br label %for.inc53.25

if.else.25:                                       ; preds = %for.end38.25
  %194 = add nsw i64 %indvars.iv.next21.24, %4
  %arrayidx51.25 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %194
  store float %partial_sum.0.lcssa.25, float* %arrayidx51.25, align 4
  br label %for.inc53.25

for.inc53.25:                                     ; preds = %if.else.25, %if.then40.25
  %inc54.25 = add nsw i32 %in_j.011, 26
  %indvars.iv.next21.25 = add nsw i64 %indvars.iv20, 26
  br i1 %cmp94, label %for.end38.26, label %for.body10.26.preheader

for.body10.26.preheader:                          ; preds = %for.inc53.25
  br label %for.body10.26

for.body10.26:                                    ; preds = %for.body10.26.preheader, %for.inc36.26
  %ki.06.26 = phi i32 [ %inc37.26, %for.inc36.26 ], [ 0, %for.body10.26.preheader ]
  %partial_sum.05.26 = phi float [ %partial_sum.3.26, %for.inc36.26 ], [ 0.000000e+00, %for.body10.26.preheader ]
  %add.26 = add nsw i32 %ki.06.26, %in_i.015
  %notlhs.26 = icmp slt i32 %add.26, 0
  %notrhs.26 = icmp uge i32 %add.26, %img_height
  %.not.26 = or i1 %notrhs.26, %notlhs.26
  %brmerge.26 = or i1 %.not.26, %cmp151.not.26
  br i1 %brmerge.26, label %for.inc36.26, label %for.body16.lr.ph.26

for.body16.lr.ph.26:                              ; preds = %for.body10.26
  %mul.26 = shl i32 %add.26, 7
  %mul30.26 = mul i32 %ki.06.26, %kern_width
  br label %for.body16.26

for.body16.26:                                    ; preds = %for.inc.26, %for.body16.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body16.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc.26 ]
  %partial_sum.12.26 = phi float [ %partial_sum.05.26, %for.body16.lr.ph.26 ], [ %partial_sum.2.26, %for.inc.26 ]
  %195 = trunc i64 %indvars.iv.26 to i32
  %add17.26 = add nsw i32 %195, %inc54.25
  %cmp18.26 = icmp sgt i32 %add17.26, -1
  %cmp21.26 = icmp ult i32 %add17.26, %img_width
  %196 = and i1 %cmp18.26, %cmp21.26
  br i1 %196, label %if.end26.26, label %for.inc.26

if.end26.26:                                      ; preds = %for.body16.26
  %add29.26 = add nsw i32 %add17.26, %mul.26
  %idxprom.26 = sext i32 %add29.26 to i64
  %arrayidx.26 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.26
  %197 = load float, float* %arrayidx.26, align 4
  %198 = trunc i64 %indvars.iv.26 to i32
  %add31.26 = add i32 %198, %mul30.26
  %idxprom32.26 = zext i32 %add31.26 to i64
  %arrayidx33.26 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.26
  %199 = load float, float* %arrayidx33.26, align 4
  %mul34.26 = fmul float %197, %199
  %add35.26 = fadd float %partial_sum.12.26, %mul34.26
  br label %for.inc.26

for.inc.26:                                       ; preds = %if.end26.26, %for.body16.26
  %partial_sum.2.26 = phi float [ %add35.26, %if.end26.26 ], [ %partial_sum.12.26, %for.body16.26 ]
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %kern_width
  br i1 %exitcond.26, label %for.inc36.26.loopexit, label %for.body16.26, !llvm.loop !1

for.inc36.26.loopexit:                            ; preds = %for.inc.26
  %partial_sum.2.26.lcssa = phi float [ %partial_sum.2.26, %for.inc.26 ]
  br label %for.inc36.26

for.inc36.26:                                     ; preds = %for.inc36.26.loopexit, %for.body10.26
  %partial_sum.3.26 = phi float [ %partial_sum.05.26, %for.body10.26 ], [ %partial_sum.2.26.lcssa, %for.inc36.26.loopexit ]
  %inc37.26 = add nuw nsw i32 %ki.06.26, 1
  %exitcond19.26 = icmp eq i32 %inc37.26, %kern_height
  br i1 %exitcond19.26, label %for.end38.26.loopexit, label %for.body10.26, !llvm.loop !3

for.end38.26.loopexit:                            ; preds = %for.inc36.26
  %partial_sum.3.26.lcssa = phi float [ %partial_sum.3.26, %for.inc36.26 ]
  br label %for.end38.26

for.end38.26:                                     ; preds = %for.end38.26.loopexit, %for.inc53.25
  %partial_sum.0.lcssa.26 = phi float [ 0.000000e+00, %for.inc53.25 ], [ %partial_sum.3.26.lcssa, %for.end38.26.loopexit ]
  br i1 %tobool39, label %if.else.26, label %if.then40.26

if.then40.26:                                     ; preds = %for.end38.26
  %cmp41.26 = fcmp olt float %partial_sum.0.lcssa.26, 0.000000e+00
  %sub42.26 = fsub float -0.000000e+00, %partial_sum.0.lcssa.26
  %cond.26 = select i1 %cmp41.26, float %sub42.26, float %partial_sum.0.lcssa.26
  %conv.26 = fptoui float %cond.26 to i8
  %conv43.26 = uitofp i8 %conv.26 to float
  %200 = add nsw i64 %indvars.iv.next21.25, %5
  %arrayidx47.26 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %200
  store float %conv43.26, float* %arrayidx47.26, align 4
  br label %for.inc53.26

if.else.26:                                       ; preds = %for.end38.26
  %201 = add nsw i64 %indvars.iv.next21.25, %4
  %arrayidx51.26 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %201
  store float %partial_sum.0.lcssa.26, float* %arrayidx51.26, align 4
  br label %for.inc53.26

for.inc53.26:                                     ; preds = %if.else.26, %if.then40.26
  %inc54.26 = add nsw i32 %in_j.011, 27
  %indvars.iv.next21.26 = add nsw i64 %indvars.iv20, 27
  br i1 %cmp94, label %for.end38.27, label %for.body10.27.preheader

for.body10.27.preheader:                          ; preds = %for.inc53.26
  br label %for.body10.27

for.body10.27:                                    ; preds = %for.body10.27.preheader, %for.inc36.27
  %ki.06.27 = phi i32 [ %inc37.27, %for.inc36.27 ], [ 0, %for.body10.27.preheader ]
  %partial_sum.05.27 = phi float [ %partial_sum.3.27, %for.inc36.27 ], [ 0.000000e+00, %for.body10.27.preheader ]
  %add.27 = add nsw i32 %ki.06.27, %in_i.015
  %notlhs.27 = icmp slt i32 %add.27, 0
  %notrhs.27 = icmp uge i32 %add.27, %img_height
  %.not.27 = or i1 %notrhs.27, %notlhs.27
  %brmerge.27 = or i1 %.not.27, %cmp151.not.27
  br i1 %brmerge.27, label %for.inc36.27, label %for.body16.lr.ph.27

for.body16.lr.ph.27:                              ; preds = %for.body10.27
  %mul.27 = shl i32 %add.27, 7
  %mul30.27 = mul i32 %ki.06.27, %kern_width
  br label %for.body16.27

for.body16.27:                                    ; preds = %for.inc.27, %for.body16.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body16.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc.27 ]
  %partial_sum.12.27 = phi float [ %partial_sum.05.27, %for.body16.lr.ph.27 ], [ %partial_sum.2.27, %for.inc.27 ]
  %202 = trunc i64 %indvars.iv.27 to i32
  %add17.27 = add nsw i32 %202, %inc54.26
  %cmp18.27 = icmp sgt i32 %add17.27, -1
  %cmp21.27 = icmp ult i32 %add17.27, %img_width
  %203 = and i1 %cmp18.27, %cmp21.27
  br i1 %203, label %if.end26.27, label %for.inc.27

if.end26.27:                                      ; preds = %for.body16.27
  %add29.27 = add nsw i32 %add17.27, %mul.27
  %idxprom.27 = sext i32 %add29.27 to i64
  %arrayidx.27 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.27
  %204 = load float, float* %arrayidx.27, align 4
  %205 = trunc i64 %indvars.iv.27 to i32
  %add31.27 = add i32 %205, %mul30.27
  %idxprom32.27 = zext i32 %add31.27 to i64
  %arrayidx33.27 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.27
  %206 = load float, float* %arrayidx33.27, align 4
  %mul34.27 = fmul float %204, %206
  %add35.27 = fadd float %partial_sum.12.27, %mul34.27
  br label %for.inc.27

for.inc.27:                                       ; preds = %if.end26.27, %for.body16.27
  %partial_sum.2.27 = phi float [ %add35.27, %if.end26.27 ], [ %partial_sum.12.27, %for.body16.27 ]
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %kern_width
  br i1 %exitcond.27, label %for.inc36.27.loopexit, label %for.body16.27, !llvm.loop !1

for.inc36.27.loopexit:                            ; preds = %for.inc.27
  %partial_sum.2.27.lcssa = phi float [ %partial_sum.2.27, %for.inc.27 ]
  br label %for.inc36.27

for.inc36.27:                                     ; preds = %for.inc36.27.loopexit, %for.body10.27
  %partial_sum.3.27 = phi float [ %partial_sum.05.27, %for.body10.27 ], [ %partial_sum.2.27.lcssa, %for.inc36.27.loopexit ]
  %inc37.27 = add nuw nsw i32 %ki.06.27, 1
  %exitcond19.27 = icmp eq i32 %inc37.27, %kern_height
  br i1 %exitcond19.27, label %for.end38.27.loopexit, label %for.body10.27, !llvm.loop !3

for.end38.27.loopexit:                            ; preds = %for.inc36.27
  %partial_sum.3.27.lcssa = phi float [ %partial_sum.3.27, %for.inc36.27 ]
  br label %for.end38.27

for.end38.27:                                     ; preds = %for.end38.27.loopexit, %for.inc53.26
  %partial_sum.0.lcssa.27 = phi float [ 0.000000e+00, %for.inc53.26 ], [ %partial_sum.3.27.lcssa, %for.end38.27.loopexit ]
  br i1 %tobool39, label %if.else.27, label %if.then40.27

if.then40.27:                                     ; preds = %for.end38.27
  %cmp41.27 = fcmp olt float %partial_sum.0.lcssa.27, 0.000000e+00
  %sub42.27 = fsub float -0.000000e+00, %partial_sum.0.lcssa.27
  %cond.27 = select i1 %cmp41.27, float %sub42.27, float %partial_sum.0.lcssa.27
  %conv.27 = fptoui float %cond.27 to i8
  %conv43.27 = uitofp i8 %conv.27 to float
  %207 = add nsw i64 %indvars.iv.next21.26, %5
  %arrayidx47.27 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %207
  store float %conv43.27, float* %arrayidx47.27, align 4
  br label %for.inc53.27

if.else.27:                                       ; preds = %for.end38.27
  %208 = add nsw i64 %indvars.iv.next21.26, %4
  %arrayidx51.27 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %208
  store float %partial_sum.0.lcssa.27, float* %arrayidx51.27, align 4
  br label %for.inc53.27

for.inc53.27:                                     ; preds = %if.else.27, %if.then40.27
  %inc54.27 = add nsw i32 %in_j.011, 28
  %indvars.iv.next21.27 = add nsw i64 %indvars.iv20, 28
  br i1 %cmp94, label %for.end38.28, label %for.body10.28.preheader

for.body10.28.preheader:                          ; preds = %for.inc53.27
  br label %for.body10.28

for.body10.28:                                    ; preds = %for.body10.28.preheader, %for.inc36.28
  %ki.06.28 = phi i32 [ %inc37.28, %for.inc36.28 ], [ 0, %for.body10.28.preheader ]
  %partial_sum.05.28 = phi float [ %partial_sum.3.28, %for.inc36.28 ], [ 0.000000e+00, %for.body10.28.preheader ]
  %add.28 = add nsw i32 %ki.06.28, %in_i.015
  %notlhs.28 = icmp slt i32 %add.28, 0
  %notrhs.28 = icmp uge i32 %add.28, %img_height
  %.not.28 = or i1 %notrhs.28, %notlhs.28
  %brmerge.28 = or i1 %.not.28, %cmp151.not.28
  br i1 %brmerge.28, label %for.inc36.28, label %for.body16.lr.ph.28

for.body16.lr.ph.28:                              ; preds = %for.body10.28
  %mul.28 = shl i32 %add.28, 7
  %mul30.28 = mul i32 %ki.06.28, %kern_width
  br label %for.body16.28

for.body16.28:                                    ; preds = %for.inc.28, %for.body16.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body16.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc.28 ]
  %partial_sum.12.28 = phi float [ %partial_sum.05.28, %for.body16.lr.ph.28 ], [ %partial_sum.2.28, %for.inc.28 ]
  %209 = trunc i64 %indvars.iv.28 to i32
  %add17.28 = add nsw i32 %209, %inc54.27
  %cmp18.28 = icmp sgt i32 %add17.28, -1
  %cmp21.28 = icmp ult i32 %add17.28, %img_width
  %210 = and i1 %cmp18.28, %cmp21.28
  br i1 %210, label %if.end26.28, label %for.inc.28

if.end26.28:                                      ; preds = %for.body16.28
  %add29.28 = add nsw i32 %add17.28, %mul.28
  %idxprom.28 = sext i32 %add29.28 to i64
  %arrayidx.28 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.28
  %211 = load float, float* %arrayidx.28, align 4
  %212 = trunc i64 %indvars.iv.28 to i32
  %add31.28 = add i32 %212, %mul30.28
  %idxprom32.28 = zext i32 %add31.28 to i64
  %arrayidx33.28 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.28
  %213 = load float, float* %arrayidx33.28, align 4
  %mul34.28 = fmul float %211, %213
  %add35.28 = fadd float %partial_sum.12.28, %mul34.28
  br label %for.inc.28

for.inc.28:                                       ; preds = %if.end26.28, %for.body16.28
  %partial_sum.2.28 = phi float [ %add35.28, %if.end26.28 ], [ %partial_sum.12.28, %for.body16.28 ]
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %kern_width
  br i1 %exitcond.28, label %for.inc36.28.loopexit, label %for.body16.28, !llvm.loop !1

for.inc36.28.loopexit:                            ; preds = %for.inc.28
  %partial_sum.2.28.lcssa = phi float [ %partial_sum.2.28, %for.inc.28 ]
  br label %for.inc36.28

for.inc36.28:                                     ; preds = %for.inc36.28.loopexit, %for.body10.28
  %partial_sum.3.28 = phi float [ %partial_sum.05.28, %for.body10.28 ], [ %partial_sum.2.28.lcssa, %for.inc36.28.loopexit ]
  %inc37.28 = add nuw nsw i32 %ki.06.28, 1
  %exitcond19.28 = icmp eq i32 %inc37.28, %kern_height
  br i1 %exitcond19.28, label %for.end38.28.loopexit, label %for.body10.28, !llvm.loop !3

for.end38.28.loopexit:                            ; preds = %for.inc36.28
  %partial_sum.3.28.lcssa = phi float [ %partial_sum.3.28, %for.inc36.28 ]
  br label %for.end38.28

for.end38.28:                                     ; preds = %for.end38.28.loopexit, %for.inc53.27
  %partial_sum.0.lcssa.28 = phi float [ 0.000000e+00, %for.inc53.27 ], [ %partial_sum.3.28.lcssa, %for.end38.28.loopexit ]
  br i1 %tobool39, label %if.else.28, label %if.then40.28

if.then40.28:                                     ; preds = %for.end38.28
  %cmp41.28 = fcmp olt float %partial_sum.0.lcssa.28, 0.000000e+00
  %sub42.28 = fsub float -0.000000e+00, %partial_sum.0.lcssa.28
  %cond.28 = select i1 %cmp41.28, float %sub42.28, float %partial_sum.0.lcssa.28
  %conv.28 = fptoui float %cond.28 to i8
  %conv43.28 = uitofp i8 %conv.28 to float
  %214 = add nsw i64 %indvars.iv.next21.27, %5
  %arrayidx47.28 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %214
  store float %conv43.28, float* %arrayidx47.28, align 4
  br label %for.inc53.28

if.else.28:                                       ; preds = %for.end38.28
  %215 = add nsw i64 %indvars.iv.next21.27, %4
  %arrayidx51.28 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %215
  store float %partial_sum.0.lcssa.28, float* %arrayidx51.28, align 4
  br label %for.inc53.28

for.inc53.28:                                     ; preds = %if.else.28, %if.then40.28
  %inc54.28 = add nsw i32 %in_j.011, 29
  %indvars.iv.next21.28 = add nsw i64 %indvars.iv20, 29
  br i1 %cmp94, label %for.end38.29, label %for.body10.29.preheader

for.body10.29.preheader:                          ; preds = %for.inc53.28
  br label %for.body10.29

for.body10.29:                                    ; preds = %for.body10.29.preheader, %for.inc36.29
  %ki.06.29 = phi i32 [ %inc37.29, %for.inc36.29 ], [ 0, %for.body10.29.preheader ]
  %partial_sum.05.29 = phi float [ %partial_sum.3.29, %for.inc36.29 ], [ 0.000000e+00, %for.body10.29.preheader ]
  %add.29 = add nsw i32 %ki.06.29, %in_i.015
  %notlhs.29 = icmp slt i32 %add.29, 0
  %notrhs.29 = icmp uge i32 %add.29, %img_height
  %.not.29 = or i1 %notrhs.29, %notlhs.29
  %brmerge.29 = or i1 %.not.29, %cmp151.not.29
  br i1 %brmerge.29, label %for.inc36.29, label %for.body16.lr.ph.29

for.body16.lr.ph.29:                              ; preds = %for.body10.29
  %mul.29 = shl i32 %add.29, 7
  %mul30.29 = mul i32 %ki.06.29, %kern_width
  br label %for.body16.29

for.body16.29:                                    ; preds = %for.inc.29, %for.body16.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body16.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc.29 ]
  %partial_sum.12.29 = phi float [ %partial_sum.05.29, %for.body16.lr.ph.29 ], [ %partial_sum.2.29, %for.inc.29 ]
  %216 = trunc i64 %indvars.iv.29 to i32
  %add17.29 = add nsw i32 %216, %inc54.28
  %cmp18.29 = icmp sgt i32 %add17.29, -1
  %cmp21.29 = icmp ult i32 %add17.29, %img_width
  %217 = and i1 %cmp18.29, %cmp21.29
  br i1 %217, label %if.end26.29, label %for.inc.29

if.end26.29:                                      ; preds = %for.body16.29
  %add29.29 = add nsw i32 %add17.29, %mul.29
  %idxprom.29 = sext i32 %add29.29 to i64
  %arrayidx.29 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.29
  %218 = load float, float* %arrayidx.29, align 4
  %219 = trunc i64 %indvars.iv.29 to i32
  %add31.29 = add i32 %219, %mul30.29
  %idxprom32.29 = zext i32 %add31.29 to i64
  %arrayidx33.29 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.29
  %220 = load float, float* %arrayidx33.29, align 4
  %mul34.29 = fmul float %218, %220
  %add35.29 = fadd float %partial_sum.12.29, %mul34.29
  br label %for.inc.29

for.inc.29:                                       ; preds = %if.end26.29, %for.body16.29
  %partial_sum.2.29 = phi float [ %add35.29, %if.end26.29 ], [ %partial_sum.12.29, %for.body16.29 ]
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %kern_width
  br i1 %exitcond.29, label %for.inc36.29.loopexit, label %for.body16.29, !llvm.loop !1

for.inc36.29.loopexit:                            ; preds = %for.inc.29
  %partial_sum.2.29.lcssa = phi float [ %partial_sum.2.29, %for.inc.29 ]
  br label %for.inc36.29

for.inc36.29:                                     ; preds = %for.inc36.29.loopexit, %for.body10.29
  %partial_sum.3.29 = phi float [ %partial_sum.05.29, %for.body10.29 ], [ %partial_sum.2.29.lcssa, %for.inc36.29.loopexit ]
  %inc37.29 = add nuw nsw i32 %ki.06.29, 1
  %exitcond19.29 = icmp eq i32 %inc37.29, %kern_height
  br i1 %exitcond19.29, label %for.end38.29.loopexit, label %for.body10.29, !llvm.loop !3

for.end38.29.loopexit:                            ; preds = %for.inc36.29
  %partial_sum.3.29.lcssa = phi float [ %partial_sum.3.29, %for.inc36.29 ]
  br label %for.end38.29

for.end38.29:                                     ; preds = %for.end38.29.loopexit, %for.inc53.28
  %partial_sum.0.lcssa.29 = phi float [ 0.000000e+00, %for.inc53.28 ], [ %partial_sum.3.29.lcssa, %for.end38.29.loopexit ]
  br i1 %tobool39, label %if.else.29, label %if.then40.29

if.then40.29:                                     ; preds = %for.end38.29
  %cmp41.29 = fcmp olt float %partial_sum.0.lcssa.29, 0.000000e+00
  %sub42.29 = fsub float -0.000000e+00, %partial_sum.0.lcssa.29
  %cond.29 = select i1 %cmp41.29, float %sub42.29, float %partial_sum.0.lcssa.29
  %conv.29 = fptoui float %cond.29 to i8
  %conv43.29 = uitofp i8 %conv.29 to float
  %221 = add nsw i64 %indvars.iv.next21.28, %5
  %arrayidx47.29 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %221
  store float %conv43.29, float* %arrayidx47.29, align 4
  br label %for.inc53.29

if.else.29:                                       ; preds = %for.end38.29
  %222 = add nsw i64 %indvars.iv.next21.28, %4
  %arrayidx51.29 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %222
  store float %partial_sum.0.lcssa.29, float* %arrayidx51.29, align 4
  br label %for.inc53.29

for.inc53.29:                                     ; preds = %if.else.29, %if.then40.29
  %inc54.29 = add nsw i32 %in_j.011, 30
  %indvars.iv.next21.29 = add nsw i64 %indvars.iv20, 30
  br i1 %cmp94, label %for.end38.30, label %for.body10.30.preheader

for.body10.30.preheader:                          ; preds = %for.inc53.29
  br label %for.body10.30

for.body10.30:                                    ; preds = %for.body10.30.preheader, %for.inc36.30
  %ki.06.30 = phi i32 [ %inc37.30, %for.inc36.30 ], [ 0, %for.body10.30.preheader ]
  %partial_sum.05.30 = phi float [ %partial_sum.3.30, %for.inc36.30 ], [ 0.000000e+00, %for.body10.30.preheader ]
  %add.30 = add nsw i32 %ki.06.30, %in_i.015
  %notlhs.30 = icmp slt i32 %add.30, 0
  %notrhs.30 = icmp uge i32 %add.30, %img_height
  %.not.30 = or i1 %notrhs.30, %notlhs.30
  %brmerge.30 = or i1 %.not.30, %cmp151.not.30
  br i1 %brmerge.30, label %for.inc36.30, label %for.body16.lr.ph.30

for.body16.lr.ph.30:                              ; preds = %for.body10.30
  %mul.30 = shl i32 %add.30, 7
  %mul30.30 = mul i32 %ki.06.30, %kern_width
  br label %for.body16.30

for.body16.30:                                    ; preds = %for.inc.30, %for.body16.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body16.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc.30 ]
  %partial_sum.12.30 = phi float [ %partial_sum.05.30, %for.body16.lr.ph.30 ], [ %partial_sum.2.30, %for.inc.30 ]
  %223 = trunc i64 %indvars.iv.30 to i32
  %add17.30 = add nsw i32 %223, %inc54.29
  %cmp18.30 = icmp sgt i32 %add17.30, -1
  %cmp21.30 = icmp ult i32 %add17.30, %img_width
  %224 = and i1 %cmp18.30, %cmp21.30
  br i1 %224, label %if.end26.30, label %for.inc.30

if.end26.30:                                      ; preds = %for.body16.30
  %add29.30 = add nsw i32 %add17.30, %mul.30
  %idxprom.30 = sext i32 %add29.30 to i64
  %arrayidx.30 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.30
  %225 = load float, float* %arrayidx.30, align 4
  %226 = trunc i64 %indvars.iv.30 to i32
  %add31.30 = add i32 %226, %mul30.30
  %idxprom32.30 = zext i32 %add31.30 to i64
  %arrayidx33.30 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.30
  %227 = load float, float* %arrayidx33.30, align 4
  %mul34.30 = fmul float %225, %227
  %add35.30 = fadd float %partial_sum.12.30, %mul34.30
  br label %for.inc.30

for.inc.30:                                       ; preds = %if.end26.30, %for.body16.30
  %partial_sum.2.30 = phi float [ %add35.30, %if.end26.30 ], [ %partial_sum.12.30, %for.body16.30 ]
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %kern_width
  br i1 %exitcond.30, label %for.inc36.30.loopexit, label %for.body16.30, !llvm.loop !1

for.inc36.30.loopexit:                            ; preds = %for.inc.30
  %partial_sum.2.30.lcssa = phi float [ %partial_sum.2.30, %for.inc.30 ]
  br label %for.inc36.30

for.inc36.30:                                     ; preds = %for.inc36.30.loopexit, %for.body10.30
  %partial_sum.3.30 = phi float [ %partial_sum.05.30, %for.body10.30 ], [ %partial_sum.2.30.lcssa, %for.inc36.30.loopexit ]
  %inc37.30 = add nuw nsw i32 %ki.06.30, 1
  %exitcond19.30 = icmp eq i32 %inc37.30, %kern_height
  br i1 %exitcond19.30, label %for.end38.30.loopexit, label %for.body10.30, !llvm.loop !3

for.end38.30.loopexit:                            ; preds = %for.inc36.30
  %partial_sum.3.30.lcssa = phi float [ %partial_sum.3.30, %for.inc36.30 ]
  br label %for.end38.30

for.end38.30:                                     ; preds = %for.end38.30.loopexit, %for.inc53.29
  %partial_sum.0.lcssa.30 = phi float [ 0.000000e+00, %for.inc53.29 ], [ %partial_sum.3.30.lcssa, %for.end38.30.loopexit ]
  br i1 %tobool39, label %if.else.30, label %if.then40.30

if.then40.30:                                     ; preds = %for.end38.30
  %cmp41.30 = fcmp olt float %partial_sum.0.lcssa.30, 0.000000e+00
  %sub42.30 = fsub float -0.000000e+00, %partial_sum.0.lcssa.30
  %cond.30 = select i1 %cmp41.30, float %sub42.30, float %partial_sum.0.lcssa.30
  %conv.30 = fptoui float %cond.30 to i8
  %conv43.30 = uitofp i8 %conv.30 to float
  %228 = add nsw i64 %indvars.iv.next21.29, %5
  %arrayidx47.30 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %228
  store float %conv43.30, float* %arrayidx47.30, align 4
  br label %for.inc53.30

if.else.30:                                       ; preds = %for.end38.30
  %229 = add nsw i64 %indvars.iv.next21.29, %4
  %arrayidx51.30 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %229
  store float %partial_sum.0.lcssa.30, float* %arrayidx51.30, align 4
  br label %for.inc53.30

for.inc53.30:                                     ; preds = %if.else.30, %if.then40.30
  %inc54.30 = add nsw i32 %in_j.011, 31
  %indvars.iv.next21.30 = add nsw i64 %indvars.iv20, 31
  br i1 %cmp94, label %for.end38.31, label %for.body10.31.preheader

for.body10.31.preheader:                          ; preds = %for.inc53.30
  br label %for.body10.31

for.body10.31:                                    ; preds = %for.body10.31.preheader, %for.inc36.31
  %ki.06.31 = phi i32 [ %inc37.31, %for.inc36.31 ], [ 0, %for.body10.31.preheader ]
  %partial_sum.05.31 = phi float [ %partial_sum.3.31, %for.inc36.31 ], [ 0.000000e+00, %for.body10.31.preheader ]
  %add.31 = add nsw i32 %ki.06.31, %in_i.015
  %notlhs.31 = icmp slt i32 %add.31, 0
  %notrhs.31 = icmp uge i32 %add.31, %img_height
  %.not.31 = or i1 %notrhs.31, %notlhs.31
  %brmerge.31 = or i1 %.not.31, %cmp151.not.31
  br i1 %brmerge.31, label %for.inc36.31, label %for.body16.lr.ph.31

for.body16.lr.ph.31:                              ; preds = %for.body10.31
  %mul.31 = shl i32 %add.31, 7
  %mul30.31 = mul i32 %ki.06.31, %kern_width
  br label %for.body16.31

for.body16.31:                                    ; preds = %for.inc.31, %for.body16.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body16.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc.31 ]
  %partial_sum.12.31 = phi float [ %partial_sum.05.31, %for.body16.lr.ph.31 ], [ %partial_sum.2.31, %for.inc.31 ]
  %230 = trunc i64 %indvars.iv.31 to i32
  %add17.31 = add nsw i32 %230, %inc54.30
  %cmp18.31 = icmp sgt i32 %add17.31, -1
  %cmp21.31 = icmp ult i32 %add17.31, %img_width
  %231 = and i1 %cmp18.31, %cmp21.31
  br i1 %231, label %if.end26.31, label %for.inc.31

if.end26.31:                                      ; preds = %for.body16.31
  %add29.31 = add nsw i32 %add17.31, %mul.31
  %idxprom.31 = sext i32 %add29.31 to i64
  %arrayidx.31 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.31
  %232 = load float, float* %arrayidx.31, align 4
  %233 = trunc i64 %indvars.iv.31 to i32
  %add31.31 = add i32 %233, %mul30.31
  %idxprom32.31 = zext i32 %add31.31 to i64
  %arrayidx33.31 = getelementptr inbounds float, float* inttoptr (i64 570556448 to float*), i64 %idxprom32.31
  %234 = load float, float* %arrayidx33.31, align 4
  %mul34.31 = fmul float %232, %234
  %add35.31 = fadd float %partial_sum.12.31, %mul34.31
  br label %for.inc.31

for.inc.31:                                       ; preds = %if.end26.31, %for.body16.31
  %partial_sum.2.31 = phi float [ %add35.31, %if.end26.31 ], [ %partial_sum.12.31, %for.body16.31 ]
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %kern_width
  br i1 %exitcond.31, label %for.inc36.31.loopexit, label %for.body16.31, !llvm.loop !1

for.inc36.31.loopexit:                            ; preds = %for.inc.31
  %partial_sum.2.31.lcssa = phi float [ %partial_sum.2.31, %for.inc.31 ]
  br label %for.inc36.31

for.inc36.31:                                     ; preds = %for.inc36.31.loopexit, %for.body10.31
  %partial_sum.3.31 = phi float [ %partial_sum.05.31, %for.body10.31 ], [ %partial_sum.2.31.lcssa, %for.inc36.31.loopexit ]
  %inc37.31 = add nuw nsw i32 %ki.06.31, 1
  %exitcond19.31 = icmp eq i32 %inc37.31, %kern_height
  br i1 %exitcond19.31, label %for.end38.31.loopexit, label %for.body10.31, !llvm.loop !3

for.end38.31.loopexit:                            ; preds = %for.inc36.31
  %partial_sum.3.31.lcssa = phi float [ %partial_sum.3.31, %for.inc36.31 ]
  br label %for.end38.31

for.end38.31:                                     ; preds = %for.end38.31.loopexit, %for.inc53.30
  %partial_sum.0.lcssa.31 = phi float [ 0.000000e+00, %for.inc53.30 ], [ %partial_sum.3.31.lcssa, %for.end38.31.loopexit ]
  br i1 %tobool39, label %if.else.31, label %if.then40.31

if.then40.31:                                     ; preds = %for.end38.31
  %cmp41.31 = fcmp olt float %partial_sum.0.lcssa.31, 0.000000e+00
  %sub42.31 = fsub float -0.000000e+00, %partial_sum.0.lcssa.31
  %cond.31 = select i1 %cmp41.31, float %sub42.31, float %partial_sum.0.lcssa.31
  %conv.31 = fptoui float %cond.31 to i8
  %conv43.31 = uitofp i8 %conv.31 to float
  %235 = add nsw i64 %indvars.iv.next21.30, %5
  %arrayidx47.31 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %235
  store float %conv43.31, float* %arrayidx47.31, align 4
  br label %for.inc53.31

if.else.31:                                       ; preds = %for.end38.31
  %236 = add nsw i64 %indvars.iv.next21.30, %4
  %arrayidx51.31 = getelementptr inbounds float, float* inttoptr (i64 570490912 to float*), i64 %236
  store float %partial_sum.0.lcssa.31, float* %arrayidx51.31, align 4
  br label %for.inc53.31

for.inc53.31:                                     ; preds = %if.else.31, %if.then40.31
  %inc54.31 = add nsw i32 %in_j.011, 32
  %indvars.iv.next21.31 = add nsw i64 %indvars.iv20, 32
  %lftr.wideiv24.31 = trunc i64 %indvars.iv.next21.31 to i32
  %exitcond25.31 = icmp eq i32 %lftr.wideiv24.31, %img_width
  br i1 %exitcond25.31, label %for.inc57.loopexit, label %for.cond8.preheader, !llvm.loop !6
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
!5 = distinct !{!5, !2}
!6 = distinct !{!6, !2}
