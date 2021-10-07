; ModuleID = 'convolution0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @convolution0(i32 %img_height, i32 %img_width, i32 %kern_height, i32 %kern_width, i8 zeroext %mod_and_floor, i8 zeroext %spm_part) #0 {
entry:
  %cmp = icmp eq i8 %spm_part, 1
  %. = select i1 %cmp, float* inttoptr (i64 570556448 to float*), float* inttoptr (i64 570490912 to float*)
  %sub3 = add i32 %kern_width, -1
  %div4 = lshr i32 %sub3, 1
  %sub5 = sub nsw i32 0, %div4
  %cmp614 = icmp eq i32 %img_height, 0
  br i1 %cmp614, label %for.end75, label %for.cond8.preheader.lr.ph

for.cond8.preheader.lr.ph:                        ; preds = %entry
  %sub = add i32 %kern_height, -1
  %div = lshr i32 %sub, 1
  %sub2 = sub nsw i32 0, %div
  %cmp910 = icmp eq i32 %img_width, 0
  %cmp134 = icmp eq i32 %kern_height, 0
  %tobool51 = icmp eq i8 %mod_and_floor, 0
  %0 = add i32 %img_width, -1
  %xtraiter = and i32 %img_width, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  %1 = icmp ult i32 %0, 31
  %cmp241.not.31 = icmp eq i32 %kern_width, 0
  %cmp241.not.30 = icmp eq i32 %kern_width, 0
  %cmp241.not.29 = icmp eq i32 %kern_width, 0
  %cmp241.not.28 = icmp eq i32 %kern_width, 0
  %cmp241.not.27 = icmp eq i32 %kern_width, 0
  %cmp241.not.26 = icmp eq i32 %kern_width, 0
  %cmp241.not.25 = icmp eq i32 %kern_width, 0
  %cmp241.not.24 = icmp eq i32 %kern_width, 0
  %cmp241.not.23 = icmp eq i32 %kern_width, 0
  %cmp241.not.22 = icmp eq i32 %kern_width, 0
  %cmp241.not.21 = icmp eq i32 %kern_width, 0
  %cmp241.not.20 = icmp eq i32 %kern_width, 0
  %cmp241.not.19 = icmp eq i32 %kern_width, 0
  %cmp241.not.18 = icmp eq i32 %kern_width, 0
  %cmp241.not.17 = icmp eq i32 %kern_width, 0
  %cmp241.not.16 = icmp eq i32 %kern_width, 0
  %cmp241.not.15 = icmp eq i32 %kern_width, 0
  %cmp241.not.14 = icmp eq i32 %kern_width, 0
  %cmp241.not.13 = icmp eq i32 %kern_width, 0
  %cmp241.not.12 = icmp eq i32 %kern_width, 0
  %cmp241.not.11 = icmp eq i32 %kern_width, 0
  %cmp241.not.10 = icmp eq i32 %kern_width, 0
  %cmp241.not.9 = icmp eq i32 %kern_width, 0
  %cmp241.not.8 = icmp eq i32 %kern_width, 0
  %cmp241.not.7 = icmp eq i32 %kern_width, 0
  %cmp241.not.6 = icmp eq i32 %kern_width, 0
  %cmp241.not.5 = icmp eq i32 %kern_width, 0
  %cmp241.not.4 = icmp eq i32 %kern_width, 0
  %cmp241.not.3 = icmp eq i32 %kern_width, 0
  %cmp241.not.2 = icmp eq i32 %kern_width, 0
  %cmp241.not.1 = icmp eq i32 %kern_width, 0
  %cmp241.not = icmp eq i32 %kern_width, 0
  %cmp241.not.prol = icmp eq i32 %kern_width, 0
  br label %for.cond8.preheader

for.cond8.preheader:                              ; preds = %for.inc72, %for.cond8.preheader.lr.ph
  %indvars.iv26 = phi i64 [ 0, %for.cond8.preheader.lr.ph ], [ %indvars.iv.next27, %for.inc72 ]
  %in_i.015 = phi i32 [ %sub2, %for.cond8.preheader.lr.ph ], [ %inc73, %for.inc72 ]
  br i1 %cmp910, label %for.inc72, label %for.cond12.preheader.lr.ph

for.cond12.preheader.lr.ph:                       ; preds = %for.cond8.preheader
  %2 = trunc i64 %indvars.iv26 to i32
  %mul63 = shl i32 %2, 7
  %3 = trunc i64 %indvars.iv26 to i32
  %mul58 = shl i32 %3, 7
  %4 = sext i32 %mul63 to i64
  %5 = sext i32 %mul58 to i64
  br i1 %lcmp.mod, label %for.cond12.preheader.lr.ph.split, label %for.cond12.preheader.prol.preheader

for.cond12.preheader.prol.preheader:              ; preds = %for.cond12.preheader.lr.ph
  br label %for.cond12.preheader.prol

for.cond12.preheader.prol:                        ; preds = %for.cond12.preheader.prol.preheader, %for.inc68.prol
  %indvars.iv20.prol = phi i64 [ %indvars.iv.next21.prol, %for.inc68.prol ], [ 0, %for.cond12.preheader.prol.preheader ]
  %in_j.011.prol = phi i32 [ %inc69.prol, %for.inc68.prol ], [ %sub5, %for.cond12.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc68.prol ], [ %xtraiter, %for.cond12.preheader.prol.preheader ]
  br i1 %cmp134, label %for.end50.prol, label %for.body15.prol.preheader

for.body15.prol.preheader:                        ; preds = %for.cond12.preheader.prol
  br label %for.body15.prol

for.body15.prol:                                  ; preds = %for.body15.prol.preheader, %for.inc48.prol
  %ki.06.prol = phi i32 [ %inc49.prol, %for.inc48.prol ], [ 0, %for.body15.prol.preheader ]
  %partial_sum.05.prol = phi float [ %partial_sum.3.prol, %for.inc48.prol ], [ 0.000000e+00, %for.body15.prol.preheader ]
  %add.prol = add nsw i32 %ki.06.prol, %in_i.015
  %notlhs.prol = icmp slt i32 %add.prol, 0
  %notrhs.prol = icmp uge i32 %add.prol, %img_height
  %.not.prol = or i1 %notrhs.prol, %notlhs.prol
  %brmerge.prol = or i1 %.not.prol, %cmp241.not.prol
  br i1 %brmerge.prol, label %for.inc48.prol, label %for.body26.lr.ph.prol

for.body26.lr.ph.prol:                            ; preds = %for.body15.prol
  %mul.prol = shl i32 %add.prol, 7
  %mul42.prol = mul i32 %ki.06.prol, %kern_width
  br label %for.body26.prol

for.body26.prol:                                  ; preds = %for.inc.prol, %for.body26.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body26.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc.prol ]
  %partial_sum.12.prol = phi float [ %partial_sum.05.prol, %for.body26.lr.ph.prol ], [ %partial_sum.2.prol, %for.inc.prol ]
  %6 = trunc i64 %indvars.iv.prol to i32
  %add27.prol = add nsw i32 %6, %in_j.011.prol
  %cmp28.prol = icmp sgt i32 %add27.prol, -1
  %cmp32.prol = icmp ult i32 %add27.prol, %img_width
  %7 = and i1 %cmp28.prol, %cmp32.prol
  br i1 %7, label %if.end38.prol, label %for.inc.prol

if.end38.prol:                                    ; preds = %for.body26.prol
  %add41.prol = add nsw i32 %add27.prol, %mul.prol
  %idxprom.prol = sext i32 %add41.prol to i64
  %arrayidx.prol = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.prol
  %8 = load float, float* %arrayidx.prol, align 4
  %9 = trunc i64 %indvars.iv.prol to i32
  %add43.prol = add i32 %9, %mul42.prol
  %idxprom44.prol = zext i32 %add43.prol to i64
  %arrayidx45.prol = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.prol
  %10 = load float, float* %arrayidx45.prol, align 4
  %mul46.prol = fmul float %8, %10
  %add47.prol = fadd float %partial_sum.12.prol, %mul46.prol
  br label %for.inc.prol

for.inc.prol:                                     ; preds = %if.end38.prol, %for.body26.prol
  %partial_sum.2.prol = phi float [ %add47.prol, %if.end38.prol ], [ %partial_sum.12.prol, %for.body26.prol ]
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %kern_width
  br i1 %exitcond.prol, label %for.inc48.prol.loopexit, label %for.body26.prol, !llvm.loop !1

for.inc48.prol.loopexit:                          ; preds = %for.inc.prol
  %partial_sum.2.prol.lcssa = phi float [ %partial_sum.2.prol, %for.inc.prol ]
  br label %for.inc48.prol

for.inc48.prol:                                   ; preds = %for.inc48.prol.loopexit, %for.body15.prol
  %partial_sum.3.prol = phi float [ %partial_sum.05.prol, %for.body15.prol ], [ %partial_sum.2.prol.lcssa, %for.inc48.prol.loopexit ]
  %inc49.prol = add nuw nsw i32 %ki.06.prol, 1
  %exitcond19.prol = icmp eq i32 %inc49.prol, %kern_height
  br i1 %exitcond19.prol, label %for.end50.prol.loopexit, label %for.body15.prol, !llvm.loop !3

for.end50.prol.loopexit:                          ; preds = %for.inc48.prol
  %partial_sum.3.prol.lcssa = phi float [ %partial_sum.3.prol, %for.inc48.prol ]
  br label %for.end50.prol

for.end50.prol:                                   ; preds = %for.end50.prol.loopexit, %for.cond12.preheader.prol
  %partial_sum.0.lcssa.prol = phi float [ 0.000000e+00, %for.cond12.preheader.prol ], [ %partial_sum.3.prol.lcssa, %for.end50.prol.loopexit ]
  br i1 %tobool51, label %if.else62.prol, label %if.then52.prol

if.then52.prol:                                   ; preds = %for.end50.prol
  %cmp53.prol = fcmp olt float %partial_sum.0.lcssa.prol, 0.000000e+00
  %sub55.prol = fsub float -0.000000e+00, %partial_sum.0.lcssa.prol
  %cond.prol = select i1 %cmp53.prol, float %sub55.prol, float %partial_sum.0.lcssa.prol
  %conv56.prol = fptoui float %cond.prol to i8
  %conv57.prol = uitofp i8 %conv56.prol to float
  %11 = add nsw i64 %indvars.iv20.prol, %5
  %arrayidx61.prol = getelementptr inbounds float, float* %., i64 %11
  store float %conv57.prol, float* %arrayidx61.prol, align 4
  br label %for.inc68.prol

if.else62.prol:                                   ; preds = %for.end50.prol
  %12 = add nsw i64 %indvars.iv20.prol, %4
  %arrayidx66.prol = getelementptr inbounds float, float* %., i64 %12
  store float %partial_sum.0.lcssa.prol, float* %arrayidx66.prol, align 4
  br label %for.inc68.prol

for.inc68.prol:                                   ; preds = %if.else62.prol, %if.then52.prol
  %inc69.prol = add nsw i32 %in_j.011.prol, 1
  %indvars.iv.next21.prol = add nuw nsw i64 %indvars.iv20.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond12.preheader.lr.ph.split.loopexit, label %for.cond12.preheader.prol, !llvm.loop !4

for.cond12.preheader.lr.ph.split.loopexit:        ; preds = %for.inc68.prol
  %indvars.iv.next21.prol.lcssa = phi i64 [ %indvars.iv.next21.prol, %for.inc68.prol ]
  %inc69.prol.lcssa = phi i32 [ %inc69.prol, %for.inc68.prol ]
  br label %for.cond12.preheader.lr.ph.split

for.cond12.preheader.lr.ph.split:                 ; preds = %for.cond12.preheader.lr.ph.split.loopexit, %for.cond12.preheader.lr.ph
  %indvars.iv20.unr = phi i64 [ 0, %for.cond12.preheader.lr.ph ], [ %indvars.iv.next21.prol.lcssa, %for.cond12.preheader.lr.ph.split.loopexit ]
  %in_j.011.unr = phi i32 [ %sub5, %for.cond12.preheader.lr.ph ], [ %inc69.prol.lcssa, %for.cond12.preheader.lr.ph.split.loopexit ]
  br i1 %1, label %for.inc72, label %for.cond12.preheader.preheader

for.cond12.preheader.preheader:                   ; preds = %for.cond12.preheader.lr.ph.split
  br label %for.cond12.preheader

for.cond12.preheader:                             ; preds = %for.cond12.preheader.preheader, %for.inc68.31
  %indvars.iv20 = phi i64 [ %indvars.iv.next21.31, %for.inc68.31 ], [ %indvars.iv20.unr, %for.cond12.preheader.preheader ]
  %in_j.011 = phi i32 [ %inc69.31, %for.inc68.31 ], [ %in_j.011.unr, %for.cond12.preheader.preheader ]
  br i1 %cmp134, label %for.end50, label %for.body15.preheader

for.body15.preheader:                             ; preds = %for.cond12.preheader
  br label %for.body15

for.body15:                                       ; preds = %for.body15.preheader, %for.inc48
  %ki.06 = phi i32 [ %inc49, %for.inc48 ], [ 0, %for.body15.preheader ]
  %partial_sum.05 = phi float [ %partial_sum.3, %for.inc48 ], [ 0.000000e+00, %for.body15.preheader ]
  %add = add nsw i32 %ki.06, %in_i.015
  %notlhs = icmp slt i32 %add, 0
  %notrhs = icmp uge i32 %add, %img_height
  %.not = or i1 %notrhs, %notlhs
  %brmerge = or i1 %.not, %cmp241.not
  br i1 %brmerge, label %for.inc48, label %for.body26.lr.ph

for.body26.lr.ph:                                 ; preds = %for.body15
  %mul = shl i32 %add, 7
  %mul42 = mul i32 %ki.06, %kern_width
  br label %for.body26

for.body26:                                       ; preds = %for.inc, %for.body26.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body26.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %partial_sum.12 = phi float [ %partial_sum.05, %for.body26.lr.ph ], [ %partial_sum.2, %for.inc ]
  %13 = trunc i64 %indvars.iv to i32
  %add27 = add nsw i32 %13, %in_j.011
  %cmp28 = icmp sgt i32 %add27, -1
  %cmp32 = icmp ult i32 %add27, %img_width
  %14 = and i1 %cmp28, %cmp32
  br i1 %14, label %if.end38, label %for.inc

if.end38:                                         ; preds = %for.body26
  %add41 = add nsw i32 %add27, %mul
  %idxprom = sext i32 %add41 to i64
  %arrayidx = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom
  %15 = load float, float* %arrayidx, align 4
  %16 = trunc i64 %indvars.iv to i32
  %add43 = add i32 %16, %mul42
  %idxprom44 = zext i32 %add43 to i64
  %arrayidx45 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44
  %17 = load float, float* %arrayidx45, align 4
  %mul46 = fmul float %15, %17
  %add47 = fadd float %partial_sum.12, %mul46
  br label %for.inc

for.inc:                                          ; preds = %for.body26, %if.end38
  %partial_sum.2 = phi float [ %add47, %if.end38 ], [ %partial_sum.12, %for.body26 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %kern_width
  br i1 %exitcond, label %for.inc48.loopexit, label %for.body26, !llvm.loop !1

for.inc48.loopexit:                               ; preds = %for.inc
  %partial_sum.2.lcssa = phi float [ %partial_sum.2, %for.inc ]
  br label %for.inc48

for.inc48:                                        ; preds = %for.inc48.loopexit, %for.body15
  %partial_sum.3 = phi float [ %partial_sum.05, %for.body15 ], [ %partial_sum.2.lcssa, %for.inc48.loopexit ]
  %inc49 = add nuw nsw i32 %ki.06, 1
  %exitcond19 = icmp eq i32 %inc49, %kern_height
  br i1 %exitcond19, label %for.end50.loopexit, label %for.body15, !llvm.loop !3

for.end50.loopexit:                               ; preds = %for.inc48
  %partial_sum.3.lcssa = phi float [ %partial_sum.3, %for.inc48 ]
  br label %for.end50

for.end50:                                        ; preds = %for.end50.loopexit, %for.cond12.preheader
  %partial_sum.0.lcssa = phi float [ 0.000000e+00, %for.cond12.preheader ], [ %partial_sum.3.lcssa, %for.end50.loopexit ]
  br i1 %tobool51, label %if.else62, label %if.then52

if.then52:                                        ; preds = %for.end50
  %cmp53 = fcmp olt float %partial_sum.0.lcssa, 0.000000e+00
  %sub55 = fsub float -0.000000e+00, %partial_sum.0.lcssa
  %cond = select i1 %cmp53, float %sub55, float %partial_sum.0.lcssa
  %conv56 = fptoui float %cond to i8
  %conv57 = uitofp i8 %conv56 to float
  %18 = add nsw i64 %indvars.iv20, %5
  %arrayidx61 = getelementptr inbounds float, float* %., i64 %18
  store float %conv57, float* %arrayidx61, align 4
  br label %for.inc68

if.else62:                                        ; preds = %for.end50
  %19 = add nsw i64 %indvars.iv20, %4
  %arrayidx66 = getelementptr inbounds float, float* %., i64 %19
  store float %partial_sum.0.lcssa, float* %arrayidx66, align 4
  br label %for.inc68

for.inc68:                                        ; preds = %if.then52, %if.else62
  %inc69 = add nsw i32 %in_j.011, 1
  %indvars.iv.next21 = add nuw nsw i64 %indvars.iv20, 1
  br i1 %cmp134, label %for.end50.1, label %for.body15.1.preheader

for.body15.1.preheader:                           ; preds = %for.inc68
  br label %for.body15.1

for.inc72.loopexit:                               ; preds = %for.inc68.31
  br label %for.inc72

for.inc72:                                        ; preds = %for.inc72.loopexit, %for.cond12.preheader.lr.ph.split, %for.cond8.preheader
  %inc73 = add nsw i32 %in_i.015, 1
  %indvars.iv.next27 = add nuw nsw i64 %indvars.iv26, 1
  %lftr.wideiv28 = trunc i64 %indvars.iv.next27 to i32
  %exitcond29 = icmp eq i32 %lftr.wideiv28, %img_height
  br i1 %exitcond29, label %for.end75.loopexit, label %for.cond8.preheader, !llvm.loop !5

for.end75.loopexit:                               ; preds = %for.inc72
  br label %for.end75

for.end75:                                        ; preds = %for.end75.loopexit, %entry
  ret void

for.body15.1:                                     ; preds = %for.body15.1.preheader, %for.inc48.1
  %ki.06.1 = phi i32 [ %inc49.1, %for.inc48.1 ], [ 0, %for.body15.1.preheader ]
  %partial_sum.05.1 = phi float [ %partial_sum.3.1, %for.inc48.1 ], [ 0.000000e+00, %for.body15.1.preheader ]
  %add.1 = add nsw i32 %ki.06.1, %in_i.015
  %notlhs.1 = icmp slt i32 %add.1, 0
  %notrhs.1 = icmp uge i32 %add.1, %img_height
  %.not.1 = or i1 %notrhs.1, %notlhs.1
  %brmerge.1 = or i1 %.not.1, %cmp241.not.1
  br i1 %brmerge.1, label %for.inc48.1, label %for.body26.lr.ph.1

for.body26.lr.ph.1:                               ; preds = %for.body15.1
  %mul.1 = shl i32 %add.1, 7
  %mul42.1 = mul i32 %ki.06.1, %kern_width
  br label %for.body26.1

for.body26.1:                                     ; preds = %for.inc.1, %for.body26.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body26.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc.1 ]
  %partial_sum.12.1 = phi float [ %partial_sum.05.1, %for.body26.lr.ph.1 ], [ %partial_sum.2.1, %for.inc.1 ]
  %20 = trunc i64 %indvars.iv.1 to i32
  %add27.1 = add nsw i32 %20, %inc69
  %cmp28.1 = icmp sgt i32 %add27.1, -1
  %cmp32.1 = icmp ult i32 %add27.1, %img_width
  %21 = and i1 %cmp28.1, %cmp32.1
  br i1 %21, label %if.end38.1, label %for.inc.1

if.end38.1:                                       ; preds = %for.body26.1
  %add41.1 = add nsw i32 %add27.1, %mul.1
  %idxprom.1 = sext i32 %add41.1 to i64
  %arrayidx.1 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.1
  %22 = load float, float* %arrayidx.1, align 4
  %23 = trunc i64 %indvars.iv.1 to i32
  %add43.1 = add i32 %23, %mul42.1
  %idxprom44.1 = zext i32 %add43.1 to i64
  %arrayidx45.1 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.1
  %24 = load float, float* %arrayidx45.1, align 4
  %mul46.1 = fmul float %22, %24
  %add47.1 = fadd float %partial_sum.12.1, %mul46.1
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.end38.1, %for.body26.1
  %partial_sum.2.1 = phi float [ %add47.1, %if.end38.1 ], [ %partial_sum.12.1, %for.body26.1 ]
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %kern_width
  br i1 %exitcond.1, label %for.inc48.1.loopexit, label %for.body26.1, !llvm.loop !1

for.inc48.1.loopexit:                             ; preds = %for.inc.1
  %partial_sum.2.1.lcssa = phi float [ %partial_sum.2.1, %for.inc.1 ]
  br label %for.inc48.1

for.inc48.1:                                      ; preds = %for.inc48.1.loopexit, %for.body15.1
  %partial_sum.3.1 = phi float [ %partial_sum.05.1, %for.body15.1 ], [ %partial_sum.2.1.lcssa, %for.inc48.1.loopexit ]
  %inc49.1 = add nuw nsw i32 %ki.06.1, 1
  %exitcond19.1 = icmp eq i32 %inc49.1, %kern_height
  br i1 %exitcond19.1, label %for.end50.1.loopexit, label %for.body15.1, !llvm.loop !3

for.end50.1.loopexit:                             ; preds = %for.inc48.1
  %partial_sum.3.1.lcssa = phi float [ %partial_sum.3.1, %for.inc48.1 ]
  br label %for.end50.1

for.end50.1:                                      ; preds = %for.end50.1.loopexit, %for.inc68
  %partial_sum.0.lcssa.1 = phi float [ 0.000000e+00, %for.inc68 ], [ %partial_sum.3.1.lcssa, %for.end50.1.loopexit ]
  br i1 %tobool51, label %if.else62.1, label %if.then52.1

if.then52.1:                                      ; preds = %for.end50.1
  %cmp53.1 = fcmp olt float %partial_sum.0.lcssa.1, 0.000000e+00
  %sub55.1 = fsub float -0.000000e+00, %partial_sum.0.lcssa.1
  %cond.1 = select i1 %cmp53.1, float %sub55.1, float %partial_sum.0.lcssa.1
  %conv56.1 = fptoui float %cond.1 to i8
  %conv57.1 = uitofp i8 %conv56.1 to float
  %25 = add nsw i64 %indvars.iv.next21, %5
  %arrayidx61.1 = getelementptr inbounds float, float* %., i64 %25
  store float %conv57.1, float* %arrayidx61.1, align 4
  br label %for.inc68.1

if.else62.1:                                      ; preds = %for.end50.1
  %26 = add nsw i64 %indvars.iv.next21, %4
  %arrayidx66.1 = getelementptr inbounds float, float* %., i64 %26
  store float %partial_sum.0.lcssa.1, float* %arrayidx66.1, align 4
  br label %for.inc68.1

for.inc68.1:                                      ; preds = %if.else62.1, %if.then52.1
  %inc69.1 = add nsw i32 %in_j.011, 2
  %indvars.iv.next21.1 = add nsw i64 %indvars.iv20, 2
  br i1 %cmp134, label %for.end50.2, label %for.body15.2.preheader

for.body15.2.preheader:                           ; preds = %for.inc68.1
  br label %for.body15.2

for.body15.2:                                     ; preds = %for.body15.2.preheader, %for.inc48.2
  %ki.06.2 = phi i32 [ %inc49.2, %for.inc48.2 ], [ 0, %for.body15.2.preheader ]
  %partial_sum.05.2 = phi float [ %partial_sum.3.2, %for.inc48.2 ], [ 0.000000e+00, %for.body15.2.preheader ]
  %add.2 = add nsw i32 %ki.06.2, %in_i.015
  %notlhs.2 = icmp slt i32 %add.2, 0
  %notrhs.2 = icmp uge i32 %add.2, %img_height
  %.not.2 = or i1 %notrhs.2, %notlhs.2
  %brmerge.2 = or i1 %.not.2, %cmp241.not.2
  br i1 %brmerge.2, label %for.inc48.2, label %for.body26.lr.ph.2

for.body26.lr.ph.2:                               ; preds = %for.body15.2
  %mul.2 = shl i32 %add.2, 7
  %mul42.2 = mul i32 %ki.06.2, %kern_width
  br label %for.body26.2

for.body26.2:                                     ; preds = %for.inc.2, %for.body26.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body26.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc.2 ]
  %partial_sum.12.2 = phi float [ %partial_sum.05.2, %for.body26.lr.ph.2 ], [ %partial_sum.2.2, %for.inc.2 ]
  %27 = trunc i64 %indvars.iv.2 to i32
  %add27.2 = add nsw i32 %27, %inc69.1
  %cmp28.2 = icmp sgt i32 %add27.2, -1
  %cmp32.2 = icmp ult i32 %add27.2, %img_width
  %28 = and i1 %cmp28.2, %cmp32.2
  br i1 %28, label %if.end38.2, label %for.inc.2

if.end38.2:                                       ; preds = %for.body26.2
  %add41.2 = add nsw i32 %add27.2, %mul.2
  %idxprom.2 = sext i32 %add41.2 to i64
  %arrayidx.2 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.2
  %29 = load float, float* %arrayidx.2, align 4
  %30 = trunc i64 %indvars.iv.2 to i32
  %add43.2 = add i32 %30, %mul42.2
  %idxprom44.2 = zext i32 %add43.2 to i64
  %arrayidx45.2 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.2
  %31 = load float, float* %arrayidx45.2, align 4
  %mul46.2 = fmul float %29, %31
  %add47.2 = fadd float %partial_sum.12.2, %mul46.2
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.end38.2, %for.body26.2
  %partial_sum.2.2 = phi float [ %add47.2, %if.end38.2 ], [ %partial_sum.12.2, %for.body26.2 ]
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %kern_width
  br i1 %exitcond.2, label %for.inc48.2.loopexit, label %for.body26.2, !llvm.loop !1

for.inc48.2.loopexit:                             ; preds = %for.inc.2
  %partial_sum.2.2.lcssa = phi float [ %partial_sum.2.2, %for.inc.2 ]
  br label %for.inc48.2

for.inc48.2:                                      ; preds = %for.inc48.2.loopexit, %for.body15.2
  %partial_sum.3.2 = phi float [ %partial_sum.05.2, %for.body15.2 ], [ %partial_sum.2.2.lcssa, %for.inc48.2.loopexit ]
  %inc49.2 = add nuw nsw i32 %ki.06.2, 1
  %exitcond19.2 = icmp eq i32 %inc49.2, %kern_height
  br i1 %exitcond19.2, label %for.end50.2.loopexit, label %for.body15.2, !llvm.loop !3

for.end50.2.loopexit:                             ; preds = %for.inc48.2
  %partial_sum.3.2.lcssa = phi float [ %partial_sum.3.2, %for.inc48.2 ]
  br label %for.end50.2

for.end50.2:                                      ; preds = %for.end50.2.loopexit, %for.inc68.1
  %partial_sum.0.lcssa.2 = phi float [ 0.000000e+00, %for.inc68.1 ], [ %partial_sum.3.2.lcssa, %for.end50.2.loopexit ]
  br i1 %tobool51, label %if.else62.2, label %if.then52.2

if.then52.2:                                      ; preds = %for.end50.2
  %cmp53.2 = fcmp olt float %partial_sum.0.lcssa.2, 0.000000e+00
  %sub55.2 = fsub float -0.000000e+00, %partial_sum.0.lcssa.2
  %cond.2 = select i1 %cmp53.2, float %sub55.2, float %partial_sum.0.lcssa.2
  %conv56.2 = fptoui float %cond.2 to i8
  %conv57.2 = uitofp i8 %conv56.2 to float
  %32 = add nsw i64 %indvars.iv.next21.1, %5
  %arrayidx61.2 = getelementptr inbounds float, float* %., i64 %32
  store float %conv57.2, float* %arrayidx61.2, align 4
  br label %for.inc68.2

if.else62.2:                                      ; preds = %for.end50.2
  %33 = add nsw i64 %indvars.iv.next21.1, %4
  %arrayidx66.2 = getelementptr inbounds float, float* %., i64 %33
  store float %partial_sum.0.lcssa.2, float* %arrayidx66.2, align 4
  br label %for.inc68.2

for.inc68.2:                                      ; preds = %if.else62.2, %if.then52.2
  %inc69.2 = add nsw i32 %in_j.011, 3
  %indvars.iv.next21.2 = add nsw i64 %indvars.iv20, 3
  br i1 %cmp134, label %for.end50.3, label %for.body15.3.preheader

for.body15.3.preheader:                           ; preds = %for.inc68.2
  br label %for.body15.3

for.body15.3:                                     ; preds = %for.body15.3.preheader, %for.inc48.3
  %ki.06.3 = phi i32 [ %inc49.3, %for.inc48.3 ], [ 0, %for.body15.3.preheader ]
  %partial_sum.05.3 = phi float [ %partial_sum.3.3, %for.inc48.3 ], [ 0.000000e+00, %for.body15.3.preheader ]
  %add.3 = add nsw i32 %ki.06.3, %in_i.015
  %notlhs.3 = icmp slt i32 %add.3, 0
  %notrhs.3 = icmp uge i32 %add.3, %img_height
  %.not.3 = or i1 %notrhs.3, %notlhs.3
  %brmerge.3 = or i1 %.not.3, %cmp241.not.3
  br i1 %brmerge.3, label %for.inc48.3, label %for.body26.lr.ph.3

for.body26.lr.ph.3:                               ; preds = %for.body15.3
  %mul.3 = shl i32 %add.3, 7
  %mul42.3 = mul i32 %ki.06.3, %kern_width
  br label %for.body26.3

for.body26.3:                                     ; preds = %for.inc.3, %for.body26.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body26.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc.3 ]
  %partial_sum.12.3 = phi float [ %partial_sum.05.3, %for.body26.lr.ph.3 ], [ %partial_sum.2.3, %for.inc.3 ]
  %34 = trunc i64 %indvars.iv.3 to i32
  %add27.3 = add nsw i32 %34, %inc69.2
  %cmp28.3 = icmp sgt i32 %add27.3, -1
  %cmp32.3 = icmp ult i32 %add27.3, %img_width
  %35 = and i1 %cmp28.3, %cmp32.3
  br i1 %35, label %if.end38.3, label %for.inc.3

if.end38.3:                                       ; preds = %for.body26.3
  %add41.3 = add nsw i32 %add27.3, %mul.3
  %idxprom.3 = sext i32 %add41.3 to i64
  %arrayidx.3 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.3
  %36 = load float, float* %arrayidx.3, align 4
  %37 = trunc i64 %indvars.iv.3 to i32
  %add43.3 = add i32 %37, %mul42.3
  %idxprom44.3 = zext i32 %add43.3 to i64
  %arrayidx45.3 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.3
  %38 = load float, float* %arrayidx45.3, align 4
  %mul46.3 = fmul float %36, %38
  %add47.3 = fadd float %partial_sum.12.3, %mul46.3
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.end38.3, %for.body26.3
  %partial_sum.2.3 = phi float [ %add47.3, %if.end38.3 ], [ %partial_sum.12.3, %for.body26.3 ]
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %kern_width
  br i1 %exitcond.3, label %for.inc48.3.loopexit, label %for.body26.3, !llvm.loop !1

for.inc48.3.loopexit:                             ; preds = %for.inc.3
  %partial_sum.2.3.lcssa = phi float [ %partial_sum.2.3, %for.inc.3 ]
  br label %for.inc48.3

for.inc48.3:                                      ; preds = %for.inc48.3.loopexit, %for.body15.3
  %partial_sum.3.3 = phi float [ %partial_sum.05.3, %for.body15.3 ], [ %partial_sum.2.3.lcssa, %for.inc48.3.loopexit ]
  %inc49.3 = add nuw nsw i32 %ki.06.3, 1
  %exitcond19.3 = icmp eq i32 %inc49.3, %kern_height
  br i1 %exitcond19.3, label %for.end50.3.loopexit, label %for.body15.3, !llvm.loop !3

for.end50.3.loopexit:                             ; preds = %for.inc48.3
  %partial_sum.3.3.lcssa = phi float [ %partial_sum.3.3, %for.inc48.3 ]
  br label %for.end50.3

for.end50.3:                                      ; preds = %for.end50.3.loopexit, %for.inc68.2
  %partial_sum.0.lcssa.3 = phi float [ 0.000000e+00, %for.inc68.2 ], [ %partial_sum.3.3.lcssa, %for.end50.3.loopexit ]
  br i1 %tobool51, label %if.else62.3, label %if.then52.3

if.then52.3:                                      ; preds = %for.end50.3
  %cmp53.3 = fcmp olt float %partial_sum.0.lcssa.3, 0.000000e+00
  %sub55.3 = fsub float -0.000000e+00, %partial_sum.0.lcssa.3
  %cond.3 = select i1 %cmp53.3, float %sub55.3, float %partial_sum.0.lcssa.3
  %conv56.3 = fptoui float %cond.3 to i8
  %conv57.3 = uitofp i8 %conv56.3 to float
  %39 = add nsw i64 %indvars.iv.next21.2, %5
  %arrayidx61.3 = getelementptr inbounds float, float* %., i64 %39
  store float %conv57.3, float* %arrayidx61.3, align 4
  br label %for.inc68.3

if.else62.3:                                      ; preds = %for.end50.3
  %40 = add nsw i64 %indvars.iv.next21.2, %4
  %arrayidx66.3 = getelementptr inbounds float, float* %., i64 %40
  store float %partial_sum.0.lcssa.3, float* %arrayidx66.3, align 4
  br label %for.inc68.3

for.inc68.3:                                      ; preds = %if.else62.3, %if.then52.3
  %inc69.3 = add nsw i32 %in_j.011, 4
  %indvars.iv.next21.3 = add nsw i64 %indvars.iv20, 4
  br i1 %cmp134, label %for.end50.4, label %for.body15.4.preheader

for.body15.4.preheader:                           ; preds = %for.inc68.3
  br label %for.body15.4

for.body15.4:                                     ; preds = %for.body15.4.preheader, %for.inc48.4
  %ki.06.4 = phi i32 [ %inc49.4, %for.inc48.4 ], [ 0, %for.body15.4.preheader ]
  %partial_sum.05.4 = phi float [ %partial_sum.3.4, %for.inc48.4 ], [ 0.000000e+00, %for.body15.4.preheader ]
  %add.4 = add nsw i32 %ki.06.4, %in_i.015
  %notlhs.4 = icmp slt i32 %add.4, 0
  %notrhs.4 = icmp uge i32 %add.4, %img_height
  %.not.4 = or i1 %notrhs.4, %notlhs.4
  %brmerge.4 = or i1 %.not.4, %cmp241.not.4
  br i1 %brmerge.4, label %for.inc48.4, label %for.body26.lr.ph.4

for.body26.lr.ph.4:                               ; preds = %for.body15.4
  %mul.4 = shl i32 %add.4, 7
  %mul42.4 = mul i32 %ki.06.4, %kern_width
  br label %for.body26.4

for.body26.4:                                     ; preds = %for.inc.4, %for.body26.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body26.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc.4 ]
  %partial_sum.12.4 = phi float [ %partial_sum.05.4, %for.body26.lr.ph.4 ], [ %partial_sum.2.4, %for.inc.4 ]
  %41 = trunc i64 %indvars.iv.4 to i32
  %add27.4 = add nsw i32 %41, %inc69.3
  %cmp28.4 = icmp sgt i32 %add27.4, -1
  %cmp32.4 = icmp ult i32 %add27.4, %img_width
  %42 = and i1 %cmp28.4, %cmp32.4
  br i1 %42, label %if.end38.4, label %for.inc.4

if.end38.4:                                       ; preds = %for.body26.4
  %add41.4 = add nsw i32 %add27.4, %mul.4
  %idxprom.4 = sext i32 %add41.4 to i64
  %arrayidx.4 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.4
  %43 = load float, float* %arrayidx.4, align 4
  %44 = trunc i64 %indvars.iv.4 to i32
  %add43.4 = add i32 %44, %mul42.4
  %idxprom44.4 = zext i32 %add43.4 to i64
  %arrayidx45.4 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.4
  %45 = load float, float* %arrayidx45.4, align 4
  %mul46.4 = fmul float %43, %45
  %add47.4 = fadd float %partial_sum.12.4, %mul46.4
  br label %for.inc.4

for.inc.4:                                        ; preds = %if.end38.4, %for.body26.4
  %partial_sum.2.4 = phi float [ %add47.4, %if.end38.4 ], [ %partial_sum.12.4, %for.body26.4 ]
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %kern_width
  br i1 %exitcond.4, label %for.inc48.4.loopexit, label %for.body26.4, !llvm.loop !1

for.inc48.4.loopexit:                             ; preds = %for.inc.4
  %partial_sum.2.4.lcssa = phi float [ %partial_sum.2.4, %for.inc.4 ]
  br label %for.inc48.4

for.inc48.4:                                      ; preds = %for.inc48.4.loopexit, %for.body15.4
  %partial_sum.3.4 = phi float [ %partial_sum.05.4, %for.body15.4 ], [ %partial_sum.2.4.lcssa, %for.inc48.4.loopexit ]
  %inc49.4 = add nuw nsw i32 %ki.06.4, 1
  %exitcond19.4 = icmp eq i32 %inc49.4, %kern_height
  br i1 %exitcond19.4, label %for.end50.4.loopexit, label %for.body15.4, !llvm.loop !3

for.end50.4.loopexit:                             ; preds = %for.inc48.4
  %partial_sum.3.4.lcssa = phi float [ %partial_sum.3.4, %for.inc48.4 ]
  br label %for.end50.4

for.end50.4:                                      ; preds = %for.end50.4.loopexit, %for.inc68.3
  %partial_sum.0.lcssa.4 = phi float [ 0.000000e+00, %for.inc68.3 ], [ %partial_sum.3.4.lcssa, %for.end50.4.loopexit ]
  br i1 %tobool51, label %if.else62.4, label %if.then52.4

if.then52.4:                                      ; preds = %for.end50.4
  %cmp53.4 = fcmp olt float %partial_sum.0.lcssa.4, 0.000000e+00
  %sub55.4 = fsub float -0.000000e+00, %partial_sum.0.lcssa.4
  %cond.4 = select i1 %cmp53.4, float %sub55.4, float %partial_sum.0.lcssa.4
  %conv56.4 = fptoui float %cond.4 to i8
  %conv57.4 = uitofp i8 %conv56.4 to float
  %46 = add nsw i64 %indvars.iv.next21.3, %5
  %arrayidx61.4 = getelementptr inbounds float, float* %., i64 %46
  store float %conv57.4, float* %arrayidx61.4, align 4
  br label %for.inc68.4

if.else62.4:                                      ; preds = %for.end50.4
  %47 = add nsw i64 %indvars.iv.next21.3, %4
  %arrayidx66.4 = getelementptr inbounds float, float* %., i64 %47
  store float %partial_sum.0.lcssa.4, float* %arrayidx66.4, align 4
  br label %for.inc68.4

for.inc68.4:                                      ; preds = %if.else62.4, %if.then52.4
  %inc69.4 = add nsw i32 %in_j.011, 5
  %indvars.iv.next21.4 = add nsw i64 %indvars.iv20, 5
  br i1 %cmp134, label %for.end50.5, label %for.body15.5.preheader

for.body15.5.preheader:                           ; preds = %for.inc68.4
  br label %for.body15.5

for.body15.5:                                     ; preds = %for.body15.5.preheader, %for.inc48.5
  %ki.06.5 = phi i32 [ %inc49.5, %for.inc48.5 ], [ 0, %for.body15.5.preheader ]
  %partial_sum.05.5 = phi float [ %partial_sum.3.5, %for.inc48.5 ], [ 0.000000e+00, %for.body15.5.preheader ]
  %add.5 = add nsw i32 %ki.06.5, %in_i.015
  %notlhs.5 = icmp slt i32 %add.5, 0
  %notrhs.5 = icmp uge i32 %add.5, %img_height
  %.not.5 = or i1 %notrhs.5, %notlhs.5
  %brmerge.5 = or i1 %.not.5, %cmp241.not.5
  br i1 %brmerge.5, label %for.inc48.5, label %for.body26.lr.ph.5

for.body26.lr.ph.5:                               ; preds = %for.body15.5
  %mul.5 = shl i32 %add.5, 7
  %mul42.5 = mul i32 %ki.06.5, %kern_width
  br label %for.body26.5

for.body26.5:                                     ; preds = %for.inc.5, %for.body26.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body26.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc.5 ]
  %partial_sum.12.5 = phi float [ %partial_sum.05.5, %for.body26.lr.ph.5 ], [ %partial_sum.2.5, %for.inc.5 ]
  %48 = trunc i64 %indvars.iv.5 to i32
  %add27.5 = add nsw i32 %48, %inc69.4
  %cmp28.5 = icmp sgt i32 %add27.5, -1
  %cmp32.5 = icmp ult i32 %add27.5, %img_width
  %49 = and i1 %cmp28.5, %cmp32.5
  br i1 %49, label %if.end38.5, label %for.inc.5

if.end38.5:                                       ; preds = %for.body26.5
  %add41.5 = add nsw i32 %add27.5, %mul.5
  %idxprom.5 = sext i32 %add41.5 to i64
  %arrayidx.5 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.5
  %50 = load float, float* %arrayidx.5, align 4
  %51 = trunc i64 %indvars.iv.5 to i32
  %add43.5 = add i32 %51, %mul42.5
  %idxprom44.5 = zext i32 %add43.5 to i64
  %arrayidx45.5 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.5
  %52 = load float, float* %arrayidx45.5, align 4
  %mul46.5 = fmul float %50, %52
  %add47.5 = fadd float %partial_sum.12.5, %mul46.5
  br label %for.inc.5

for.inc.5:                                        ; preds = %if.end38.5, %for.body26.5
  %partial_sum.2.5 = phi float [ %add47.5, %if.end38.5 ], [ %partial_sum.12.5, %for.body26.5 ]
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %kern_width
  br i1 %exitcond.5, label %for.inc48.5.loopexit, label %for.body26.5, !llvm.loop !1

for.inc48.5.loopexit:                             ; preds = %for.inc.5
  %partial_sum.2.5.lcssa = phi float [ %partial_sum.2.5, %for.inc.5 ]
  br label %for.inc48.5

for.inc48.5:                                      ; preds = %for.inc48.5.loopexit, %for.body15.5
  %partial_sum.3.5 = phi float [ %partial_sum.05.5, %for.body15.5 ], [ %partial_sum.2.5.lcssa, %for.inc48.5.loopexit ]
  %inc49.5 = add nuw nsw i32 %ki.06.5, 1
  %exitcond19.5 = icmp eq i32 %inc49.5, %kern_height
  br i1 %exitcond19.5, label %for.end50.5.loopexit, label %for.body15.5, !llvm.loop !3

for.end50.5.loopexit:                             ; preds = %for.inc48.5
  %partial_sum.3.5.lcssa = phi float [ %partial_sum.3.5, %for.inc48.5 ]
  br label %for.end50.5

for.end50.5:                                      ; preds = %for.end50.5.loopexit, %for.inc68.4
  %partial_sum.0.lcssa.5 = phi float [ 0.000000e+00, %for.inc68.4 ], [ %partial_sum.3.5.lcssa, %for.end50.5.loopexit ]
  br i1 %tobool51, label %if.else62.5, label %if.then52.5

if.then52.5:                                      ; preds = %for.end50.5
  %cmp53.5 = fcmp olt float %partial_sum.0.lcssa.5, 0.000000e+00
  %sub55.5 = fsub float -0.000000e+00, %partial_sum.0.lcssa.5
  %cond.5 = select i1 %cmp53.5, float %sub55.5, float %partial_sum.0.lcssa.5
  %conv56.5 = fptoui float %cond.5 to i8
  %conv57.5 = uitofp i8 %conv56.5 to float
  %53 = add nsw i64 %indvars.iv.next21.4, %5
  %arrayidx61.5 = getelementptr inbounds float, float* %., i64 %53
  store float %conv57.5, float* %arrayidx61.5, align 4
  br label %for.inc68.5

if.else62.5:                                      ; preds = %for.end50.5
  %54 = add nsw i64 %indvars.iv.next21.4, %4
  %arrayidx66.5 = getelementptr inbounds float, float* %., i64 %54
  store float %partial_sum.0.lcssa.5, float* %arrayidx66.5, align 4
  br label %for.inc68.5

for.inc68.5:                                      ; preds = %if.else62.5, %if.then52.5
  %inc69.5 = add nsw i32 %in_j.011, 6
  %indvars.iv.next21.5 = add nsw i64 %indvars.iv20, 6
  br i1 %cmp134, label %for.end50.6, label %for.body15.6.preheader

for.body15.6.preheader:                           ; preds = %for.inc68.5
  br label %for.body15.6

for.body15.6:                                     ; preds = %for.body15.6.preheader, %for.inc48.6
  %ki.06.6 = phi i32 [ %inc49.6, %for.inc48.6 ], [ 0, %for.body15.6.preheader ]
  %partial_sum.05.6 = phi float [ %partial_sum.3.6, %for.inc48.6 ], [ 0.000000e+00, %for.body15.6.preheader ]
  %add.6 = add nsw i32 %ki.06.6, %in_i.015
  %notlhs.6 = icmp slt i32 %add.6, 0
  %notrhs.6 = icmp uge i32 %add.6, %img_height
  %.not.6 = or i1 %notrhs.6, %notlhs.6
  %brmerge.6 = or i1 %.not.6, %cmp241.not.6
  br i1 %brmerge.6, label %for.inc48.6, label %for.body26.lr.ph.6

for.body26.lr.ph.6:                               ; preds = %for.body15.6
  %mul.6 = shl i32 %add.6, 7
  %mul42.6 = mul i32 %ki.06.6, %kern_width
  br label %for.body26.6

for.body26.6:                                     ; preds = %for.inc.6, %for.body26.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body26.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc.6 ]
  %partial_sum.12.6 = phi float [ %partial_sum.05.6, %for.body26.lr.ph.6 ], [ %partial_sum.2.6, %for.inc.6 ]
  %55 = trunc i64 %indvars.iv.6 to i32
  %add27.6 = add nsw i32 %55, %inc69.5
  %cmp28.6 = icmp sgt i32 %add27.6, -1
  %cmp32.6 = icmp ult i32 %add27.6, %img_width
  %56 = and i1 %cmp28.6, %cmp32.6
  br i1 %56, label %if.end38.6, label %for.inc.6

if.end38.6:                                       ; preds = %for.body26.6
  %add41.6 = add nsw i32 %add27.6, %mul.6
  %idxprom.6 = sext i32 %add41.6 to i64
  %arrayidx.6 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.6
  %57 = load float, float* %arrayidx.6, align 4
  %58 = trunc i64 %indvars.iv.6 to i32
  %add43.6 = add i32 %58, %mul42.6
  %idxprom44.6 = zext i32 %add43.6 to i64
  %arrayidx45.6 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.6
  %59 = load float, float* %arrayidx45.6, align 4
  %mul46.6 = fmul float %57, %59
  %add47.6 = fadd float %partial_sum.12.6, %mul46.6
  br label %for.inc.6

for.inc.6:                                        ; preds = %if.end38.6, %for.body26.6
  %partial_sum.2.6 = phi float [ %add47.6, %if.end38.6 ], [ %partial_sum.12.6, %for.body26.6 ]
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %kern_width
  br i1 %exitcond.6, label %for.inc48.6.loopexit, label %for.body26.6, !llvm.loop !1

for.inc48.6.loopexit:                             ; preds = %for.inc.6
  %partial_sum.2.6.lcssa = phi float [ %partial_sum.2.6, %for.inc.6 ]
  br label %for.inc48.6

for.inc48.6:                                      ; preds = %for.inc48.6.loopexit, %for.body15.6
  %partial_sum.3.6 = phi float [ %partial_sum.05.6, %for.body15.6 ], [ %partial_sum.2.6.lcssa, %for.inc48.6.loopexit ]
  %inc49.6 = add nuw nsw i32 %ki.06.6, 1
  %exitcond19.6 = icmp eq i32 %inc49.6, %kern_height
  br i1 %exitcond19.6, label %for.end50.6.loopexit, label %for.body15.6, !llvm.loop !3

for.end50.6.loopexit:                             ; preds = %for.inc48.6
  %partial_sum.3.6.lcssa = phi float [ %partial_sum.3.6, %for.inc48.6 ]
  br label %for.end50.6

for.end50.6:                                      ; preds = %for.end50.6.loopexit, %for.inc68.5
  %partial_sum.0.lcssa.6 = phi float [ 0.000000e+00, %for.inc68.5 ], [ %partial_sum.3.6.lcssa, %for.end50.6.loopexit ]
  br i1 %tobool51, label %if.else62.6, label %if.then52.6

if.then52.6:                                      ; preds = %for.end50.6
  %cmp53.6 = fcmp olt float %partial_sum.0.lcssa.6, 0.000000e+00
  %sub55.6 = fsub float -0.000000e+00, %partial_sum.0.lcssa.6
  %cond.6 = select i1 %cmp53.6, float %sub55.6, float %partial_sum.0.lcssa.6
  %conv56.6 = fptoui float %cond.6 to i8
  %conv57.6 = uitofp i8 %conv56.6 to float
  %60 = add nsw i64 %indvars.iv.next21.5, %5
  %arrayidx61.6 = getelementptr inbounds float, float* %., i64 %60
  store float %conv57.6, float* %arrayidx61.6, align 4
  br label %for.inc68.6

if.else62.6:                                      ; preds = %for.end50.6
  %61 = add nsw i64 %indvars.iv.next21.5, %4
  %arrayidx66.6 = getelementptr inbounds float, float* %., i64 %61
  store float %partial_sum.0.lcssa.6, float* %arrayidx66.6, align 4
  br label %for.inc68.6

for.inc68.6:                                      ; preds = %if.else62.6, %if.then52.6
  %inc69.6 = add nsw i32 %in_j.011, 7
  %indvars.iv.next21.6 = add nsw i64 %indvars.iv20, 7
  br i1 %cmp134, label %for.end50.7, label %for.body15.7.preheader

for.body15.7.preheader:                           ; preds = %for.inc68.6
  br label %for.body15.7

for.body15.7:                                     ; preds = %for.body15.7.preheader, %for.inc48.7
  %ki.06.7 = phi i32 [ %inc49.7, %for.inc48.7 ], [ 0, %for.body15.7.preheader ]
  %partial_sum.05.7 = phi float [ %partial_sum.3.7, %for.inc48.7 ], [ 0.000000e+00, %for.body15.7.preheader ]
  %add.7 = add nsw i32 %ki.06.7, %in_i.015
  %notlhs.7 = icmp slt i32 %add.7, 0
  %notrhs.7 = icmp uge i32 %add.7, %img_height
  %.not.7 = or i1 %notrhs.7, %notlhs.7
  %brmerge.7 = or i1 %.not.7, %cmp241.not.7
  br i1 %brmerge.7, label %for.inc48.7, label %for.body26.lr.ph.7

for.body26.lr.ph.7:                               ; preds = %for.body15.7
  %mul.7 = shl i32 %add.7, 7
  %mul42.7 = mul i32 %ki.06.7, %kern_width
  br label %for.body26.7

for.body26.7:                                     ; preds = %for.inc.7, %for.body26.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body26.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc.7 ]
  %partial_sum.12.7 = phi float [ %partial_sum.05.7, %for.body26.lr.ph.7 ], [ %partial_sum.2.7, %for.inc.7 ]
  %62 = trunc i64 %indvars.iv.7 to i32
  %add27.7 = add nsw i32 %62, %inc69.6
  %cmp28.7 = icmp sgt i32 %add27.7, -1
  %cmp32.7 = icmp ult i32 %add27.7, %img_width
  %63 = and i1 %cmp28.7, %cmp32.7
  br i1 %63, label %if.end38.7, label %for.inc.7

if.end38.7:                                       ; preds = %for.body26.7
  %add41.7 = add nsw i32 %add27.7, %mul.7
  %idxprom.7 = sext i32 %add41.7 to i64
  %arrayidx.7 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.7
  %64 = load float, float* %arrayidx.7, align 4
  %65 = trunc i64 %indvars.iv.7 to i32
  %add43.7 = add i32 %65, %mul42.7
  %idxprom44.7 = zext i32 %add43.7 to i64
  %arrayidx45.7 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.7
  %66 = load float, float* %arrayidx45.7, align 4
  %mul46.7 = fmul float %64, %66
  %add47.7 = fadd float %partial_sum.12.7, %mul46.7
  br label %for.inc.7

for.inc.7:                                        ; preds = %if.end38.7, %for.body26.7
  %partial_sum.2.7 = phi float [ %add47.7, %if.end38.7 ], [ %partial_sum.12.7, %for.body26.7 ]
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %kern_width
  br i1 %exitcond.7, label %for.inc48.7.loopexit, label %for.body26.7, !llvm.loop !1

for.inc48.7.loopexit:                             ; preds = %for.inc.7
  %partial_sum.2.7.lcssa = phi float [ %partial_sum.2.7, %for.inc.7 ]
  br label %for.inc48.7

for.inc48.7:                                      ; preds = %for.inc48.7.loopexit, %for.body15.7
  %partial_sum.3.7 = phi float [ %partial_sum.05.7, %for.body15.7 ], [ %partial_sum.2.7.lcssa, %for.inc48.7.loopexit ]
  %inc49.7 = add nuw nsw i32 %ki.06.7, 1
  %exitcond19.7 = icmp eq i32 %inc49.7, %kern_height
  br i1 %exitcond19.7, label %for.end50.7.loopexit, label %for.body15.7, !llvm.loop !3

for.end50.7.loopexit:                             ; preds = %for.inc48.7
  %partial_sum.3.7.lcssa = phi float [ %partial_sum.3.7, %for.inc48.7 ]
  br label %for.end50.7

for.end50.7:                                      ; preds = %for.end50.7.loopexit, %for.inc68.6
  %partial_sum.0.lcssa.7 = phi float [ 0.000000e+00, %for.inc68.6 ], [ %partial_sum.3.7.lcssa, %for.end50.7.loopexit ]
  br i1 %tobool51, label %if.else62.7, label %if.then52.7

if.then52.7:                                      ; preds = %for.end50.7
  %cmp53.7 = fcmp olt float %partial_sum.0.lcssa.7, 0.000000e+00
  %sub55.7 = fsub float -0.000000e+00, %partial_sum.0.lcssa.7
  %cond.7 = select i1 %cmp53.7, float %sub55.7, float %partial_sum.0.lcssa.7
  %conv56.7 = fptoui float %cond.7 to i8
  %conv57.7 = uitofp i8 %conv56.7 to float
  %67 = add nsw i64 %indvars.iv.next21.6, %5
  %arrayidx61.7 = getelementptr inbounds float, float* %., i64 %67
  store float %conv57.7, float* %arrayidx61.7, align 4
  br label %for.inc68.7

if.else62.7:                                      ; preds = %for.end50.7
  %68 = add nsw i64 %indvars.iv.next21.6, %4
  %arrayidx66.7 = getelementptr inbounds float, float* %., i64 %68
  store float %partial_sum.0.lcssa.7, float* %arrayidx66.7, align 4
  br label %for.inc68.7

for.inc68.7:                                      ; preds = %if.else62.7, %if.then52.7
  %inc69.7 = add nsw i32 %in_j.011, 8
  %indvars.iv.next21.7 = add nsw i64 %indvars.iv20, 8
  br i1 %cmp134, label %for.end50.8, label %for.body15.8.preheader

for.body15.8.preheader:                           ; preds = %for.inc68.7
  br label %for.body15.8

for.body15.8:                                     ; preds = %for.body15.8.preheader, %for.inc48.8
  %ki.06.8 = phi i32 [ %inc49.8, %for.inc48.8 ], [ 0, %for.body15.8.preheader ]
  %partial_sum.05.8 = phi float [ %partial_sum.3.8, %for.inc48.8 ], [ 0.000000e+00, %for.body15.8.preheader ]
  %add.8 = add nsw i32 %ki.06.8, %in_i.015
  %notlhs.8 = icmp slt i32 %add.8, 0
  %notrhs.8 = icmp uge i32 %add.8, %img_height
  %.not.8 = or i1 %notrhs.8, %notlhs.8
  %brmerge.8 = or i1 %.not.8, %cmp241.not.8
  br i1 %brmerge.8, label %for.inc48.8, label %for.body26.lr.ph.8

for.body26.lr.ph.8:                               ; preds = %for.body15.8
  %mul.8 = shl i32 %add.8, 7
  %mul42.8 = mul i32 %ki.06.8, %kern_width
  br label %for.body26.8

for.body26.8:                                     ; preds = %for.inc.8, %for.body26.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body26.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc.8 ]
  %partial_sum.12.8 = phi float [ %partial_sum.05.8, %for.body26.lr.ph.8 ], [ %partial_sum.2.8, %for.inc.8 ]
  %69 = trunc i64 %indvars.iv.8 to i32
  %add27.8 = add nsw i32 %69, %inc69.7
  %cmp28.8 = icmp sgt i32 %add27.8, -1
  %cmp32.8 = icmp ult i32 %add27.8, %img_width
  %70 = and i1 %cmp28.8, %cmp32.8
  br i1 %70, label %if.end38.8, label %for.inc.8

if.end38.8:                                       ; preds = %for.body26.8
  %add41.8 = add nsw i32 %add27.8, %mul.8
  %idxprom.8 = sext i32 %add41.8 to i64
  %arrayidx.8 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.8
  %71 = load float, float* %arrayidx.8, align 4
  %72 = trunc i64 %indvars.iv.8 to i32
  %add43.8 = add i32 %72, %mul42.8
  %idxprom44.8 = zext i32 %add43.8 to i64
  %arrayidx45.8 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.8
  %73 = load float, float* %arrayidx45.8, align 4
  %mul46.8 = fmul float %71, %73
  %add47.8 = fadd float %partial_sum.12.8, %mul46.8
  br label %for.inc.8

for.inc.8:                                        ; preds = %if.end38.8, %for.body26.8
  %partial_sum.2.8 = phi float [ %add47.8, %if.end38.8 ], [ %partial_sum.12.8, %for.body26.8 ]
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %kern_width
  br i1 %exitcond.8, label %for.inc48.8.loopexit, label %for.body26.8, !llvm.loop !1

for.inc48.8.loopexit:                             ; preds = %for.inc.8
  %partial_sum.2.8.lcssa = phi float [ %partial_sum.2.8, %for.inc.8 ]
  br label %for.inc48.8

for.inc48.8:                                      ; preds = %for.inc48.8.loopexit, %for.body15.8
  %partial_sum.3.8 = phi float [ %partial_sum.05.8, %for.body15.8 ], [ %partial_sum.2.8.lcssa, %for.inc48.8.loopexit ]
  %inc49.8 = add nuw nsw i32 %ki.06.8, 1
  %exitcond19.8 = icmp eq i32 %inc49.8, %kern_height
  br i1 %exitcond19.8, label %for.end50.8.loopexit, label %for.body15.8, !llvm.loop !3

for.end50.8.loopexit:                             ; preds = %for.inc48.8
  %partial_sum.3.8.lcssa = phi float [ %partial_sum.3.8, %for.inc48.8 ]
  br label %for.end50.8

for.end50.8:                                      ; preds = %for.end50.8.loopexit, %for.inc68.7
  %partial_sum.0.lcssa.8 = phi float [ 0.000000e+00, %for.inc68.7 ], [ %partial_sum.3.8.lcssa, %for.end50.8.loopexit ]
  br i1 %tobool51, label %if.else62.8, label %if.then52.8

if.then52.8:                                      ; preds = %for.end50.8
  %cmp53.8 = fcmp olt float %partial_sum.0.lcssa.8, 0.000000e+00
  %sub55.8 = fsub float -0.000000e+00, %partial_sum.0.lcssa.8
  %cond.8 = select i1 %cmp53.8, float %sub55.8, float %partial_sum.0.lcssa.8
  %conv56.8 = fptoui float %cond.8 to i8
  %conv57.8 = uitofp i8 %conv56.8 to float
  %74 = add nsw i64 %indvars.iv.next21.7, %5
  %arrayidx61.8 = getelementptr inbounds float, float* %., i64 %74
  store float %conv57.8, float* %arrayidx61.8, align 4
  br label %for.inc68.8

if.else62.8:                                      ; preds = %for.end50.8
  %75 = add nsw i64 %indvars.iv.next21.7, %4
  %arrayidx66.8 = getelementptr inbounds float, float* %., i64 %75
  store float %partial_sum.0.lcssa.8, float* %arrayidx66.8, align 4
  br label %for.inc68.8

for.inc68.8:                                      ; preds = %if.else62.8, %if.then52.8
  %inc69.8 = add nsw i32 %in_j.011, 9
  %indvars.iv.next21.8 = add nsw i64 %indvars.iv20, 9
  br i1 %cmp134, label %for.end50.9, label %for.body15.9.preheader

for.body15.9.preheader:                           ; preds = %for.inc68.8
  br label %for.body15.9

for.body15.9:                                     ; preds = %for.body15.9.preheader, %for.inc48.9
  %ki.06.9 = phi i32 [ %inc49.9, %for.inc48.9 ], [ 0, %for.body15.9.preheader ]
  %partial_sum.05.9 = phi float [ %partial_sum.3.9, %for.inc48.9 ], [ 0.000000e+00, %for.body15.9.preheader ]
  %add.9 = add nsw i32 %ki.06.9, %in_i.015
  %notlhs.9 = icmp slt i32 %add.9, 0
  %notrhs.9 = icmp uge i32 %add.9, %img_height
  %.not.9 = or i1 %notrhs.9, %notlhs.9
  %brmerge.9 = or i1 %.not.9, %cmp241.not.9
  br i1 %brmerge.9, label %for.inc48.9, label %for.body26.lr.ph.9

for.body26.lr.ph.9:                               ; preds = %for.body15.9
  %mul.9 = shl i32 %add.9, 7
  %mul42.9 = mul i32 %ki.06.9, %kern_width
  br label %for.body26.9

for.body26.9:                                     ; preds = %for.inc.9, %for.body26.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body26.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc.9 ]
  %partial_sum.12.9 = phi float [ %partial_sum.05.9, %for.body26.lr.ph.9 ], [ %partial_sum.2.9, %for.inc.9 ]
  %76 = trunc i64 %indvars.iv.9 to i32
  %add27.9 = add nsw i32 %76, %inc69.8
  %cmp28.9 = icmp sgt i32 %add27.9, -1
  %cmp32.9 = icmp ult i32 %add27.9, %img_width
  %77 = and i1 %cmp28.9, %cmp32.9
  br i1 %77, label %if.end38.9, label %for.inc.9

if.end38.9:                                       ; preds = %for.body26.9
  %add41.9 = add nsw i32 %add27.9, %mul.9
  %idxprom.9 = sext i32 %add41.9 to i64
  %arrayidx.9 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.9
  %78 = load float, float* %arrayidx.9, align 4
  %79 = trunc i64 %indvars.iv.9 to i32
  %add43.9 = add i32 %79, %mul42.9
  %idxprom44.9 = zext i32 %add43.9 to i64
  %arrayidx45.9 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.9
  %80 = load float, float* %arrayidx45.9, align 4
  %mul46.9 = fmul float %78, %80
  %add47.9 = fadd float %partial_sum.12.9, %mul46.9
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.end38.9, %for.body26.9
  %partial_sum.2.9 = phi float [ %add47.9, %if.end38.9 ], [ %partial_sum.12.9, %for.body26.9 ]
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %kern_width
  br i1 %exitcond.9, label %for.inc48.9.loopexit, label %for.body26.9, !llvm.loop !1

for.inc48.9.loopexit:                             ; preds = %for.inc.9
  %partial_sum.2.9.lcssa = phi float [ %partial_sum.2.9, %for.inc.9 ]
  br label %for.inc48.9

for.inc48.9:                                      ; preds = %for.inc48.9.loopexit, %for.body15.9
  %partial_sum.3.9 = phi float [ %partial_sum.05.9, %for.body15.9 ], [ %partial_sum.2.9.lcssa, %for.inc48.9.loopexit ]
  %inc49.9 = add nuw nsw i32 %ki.06.9, 1
  %exitcond19.9 = icmp eq i32 %inc49.9, %kern_height
  br i1 %exitcond19.9, label %for.end50.9.loopexit, label %for.body15.9, !llvm.loop !3

for.end50.9.loopexit:                             ; preds = %for.inc48.9
  %partial_sum.3.9.lcssa = phi float [ %partial_sum.3.9, %for.inc48.9 ]
  br label %for.end50.9

for.end50.9:                                      ; preds = %for.end50.9.loopexit, %for.inc68.8
  %partial_sum.0.lcssa.9 = phi float [ 0.000000e+00, %for.inc68.8 ], [ %partial_sum.3.9.lcssa, %for.end50.9.loopexit ]
  br i1 %tobool51, label %if.else62.9, label %if.then52.9

if.then52.9:                                      ; preds = %for.end50.9
  %cmp53.9 = fcmp olt float %partial_sum.0.lcssa.9, 0.000000e+00
  %sub55.9 = fsub float -0.000000e+00, %partial_sum.0.lcssa.9
  %cond.9 = select i1 %cmp53.9, float %sub55.9, float %partial_sum.0.lcssa.9
  %conv56.9 = fptoui float %cond.9 to i8
  %conv57.9 = uitofp i8 %conv56.9 to float
  %81 = add nsw i64 %indvars.iv.next21.8, %5
  %arrayidx61.9 = getelementptr inbounds float, float* %., i64 %81
  store float %conv57.9, float* %arrayidx61.9, align 4
  br label %for.inc68.9

if.else62.9:                                      ; preds = %for.end50.9
  %82 = add nsw i64 %indvars.iv.next21.8, %4
  %arrayidx66.9 = getelementptr inbounds float, float* %., i64 %82
  store float %partial_sum.0.lcssa.9, float* %arrayidx66.9, align 4
  br label %for.inc68.9

for.inc68.9:                                      ; preds = %if.else62.9, %if.then52.9
  %inc69.9 = add nsw i32 %in_j.011, 10
  %indvars.iv.next21.9 = add nsw i64 %indvars.iv20, 10
  br i1 %cmp134, label %for.end50.10, label %for.body15.10.preheader

for.body15.10.preheader:                          ; preds = %for.inc68.9
  br label %for.body15.10

for.body15.10:                                    ; preds = %for.body15.10.preheader, %for.inc48.10
  %ki.06.10 = phi i32 [ %inc49.10, %for.inc48.10 ], [ 0, %for.body15.10.preheader ]
  %partial_sum.05.10 = phi float [ %partial_sum.3.10, %for.inc48.10 ], [ 0.000000e+00, %for.body15.10.preheader ]
  %add.10 = add nsw i32 %ki.06.10, %in_i.015
  %notlhs.10 = icmp slt i32 %add.10, 0
  %notrhs.10 = icmp uge i32 %add.10, %img_height
  %.not.10 = or i1 %notrhs.10, %notlhs.10
  %brmerge.10 = or i1 %.not.10, %cmp241.not.10
  br i1 %brmerge.10, label %for.inc48.10, label %for.body26.lr.ph.10

for.body26.lr.ph.10:                              ; preds = %for.body15.10
  %mul.10 = shl i32 %add.10, 7
  %mul42.10 = mul i32 %ki.06.10, %kern_width
  br label %for.body26.10

for.body26.10:                                    ; preds = %for.inc.10, %for.body26.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body26.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc.10 ]
  %partial_sum.12.10 = phi float [ %partial_sum.05.10, %for.body26.lr.ph.10 ], [ %partial_sum.2.10, %for.inc.10 ]
  %83 = trunc i64 %indvars.iv.10 to i32
  %add27.10 = add nsw i32 %83, %inc69.9
  %cmp28.10 = icmp sgt i32 %add27.10, -1
  %cmp32.10 = icmp ult i32 %add27.10, %img_width
  %84 = and i1 %cmp28.10, %cmp32.10
  br i1 %84, label %if.end38.10, label %for.inc.10

if.end38.10:                                      ; preds = %for.body26.10
  %add41.10 = add nsw i32 %add27.10, %mul.10
  %idxprom.10 = sext i32 %add41.10 to i64
  %arrayidx.10 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.10
  %85 = load float, float* %arrayidx.10, align 4
  %86 = trunc i64 %indvars.iv.10 to i32
  %add43.10 = add i32 %86, %mul42.10
  %idxprom44.10 = zext i32 %add43.10 to i64
  %arrayidx45.10 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.10
  %87 = load float, float* %arrayidx45.10, align 4
  %mul46.10 = fmul float %85, %87
  %add47.10 = fadd float %partial_sum.12.10, %mul46.10
  br label %for.inc.10

for.inc.10:                                       ; preds = %if.end38.10, %for.body26.10
  %partial_sum.2.10 = phi float [ %add47.10, %if.end38.10 ], [ %partial_sum.12.10, %for.body26.10 ]
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %kern_width
  br i1 %exitcond.10, label %for.inc48.10.loopexit, label %for.body26.10, !llvm.loop !1

for.inc48.10.loopexit:                            ; preds = %for.inc.10
  %partial_sum.2.10.lcssa = phi float [ %partial_sum.2.10, %for.inc.10 ]
  br label %for.inc48.10

for.inc48.10:                                     ; preds = %for.inc48.10.loopexit, %for.body15.10
  %partial_sum.3.10 = phi float [ %partial_sum.05.10, %for.body15.10 ], [ %partial_sum.2.10.lcssa, %for.inc48.10.loopexit ]
  %inc49.10 = add nuw nsw i32 %ki.06.10, 1
  %exitcond19.10 = icmp eq i32 %inc49.10, %kern_height
  br i1 %exitcond19.10, label %for.end50.10.loopexit, label %for.body15.10, !llvm.loop !3

for.end50.10.loopexit:                            ; preds = %for.inc48.10
  %partial_sum.3.10.lcssa = phi float [ %partial_sum.3.10, %for.inc48.10 ]
  br label %for.end50.10

for.end50.10:                                     ; preds = %for.end50.10.loopexit, %for.inc68.9
  %partial_sum.0.lcssa.10 = phi float [ 0.000000e+00, %for.inc68.9 ], [ %partial_sum.3.10.lcssa, %for.end50.10.loopexit ]
  br i1 %tobool51, label %if.else62.10, label %if.then52.10

if.then52.10:                                     ; preds = %for.end50.10
  %cmp53.10 = fcmp olt float %partial_sum.0.lcssa.10, 0.000000e+00
  %sub55.10 = fsub float -0.000000e+00, %partial_sum.0.lcssa.10
  %cond.10 = select i1 %cmp53.10, float %sub55.10, float %partial_sum.0.lcssa.10
  %conv56.10 = fptoui float %cond.10 to i8
  %conv57.10 = uitofp i8 %conv56.10 to float
  %88 = add nsw i64 %indvars.iv.next21.9, %5
  %arrayidx61.10 = getelementptr inbounds float, float* %., i64 %88
  store float %conv57.10, float* %arrayidx61.10, align 4
  br label %for.inc68.10

if.else62.10:                                     ; preds = %for.end50.10
  %89 = add nsw i64 %indvars.iv.next21.9, %4
  %arrayidx66.10 = getelementptr inbounds float, float* %., i64 %89
  store float %partial_sum.0.lcssa.10, float* %arrayidx66.10, align 4
  br label %for.inc68.10

for.inc68.10:                                     ; preds = %if.else62.10, %if.then52.10
  %inc69.10 = add nsw i32 %in_j.011, 11
  %indvars.iv.next21.10 = add nsw i64 %indvars.iv20, 11
  br i1 %cmp134, label %for.end50.11, label %for.body15.11.preheader

for.body15.11.preheader:                          ; preds = %for.inc68.10
  br label %for.body15.11

for.body15.11:                                    ; preds = %for.body15.11.preheader, %for.inc48.11
  %ki.06.11 = phi i32 [ %inc49.11, %for.inc48.11 ], [ 0, %for.body15.11.preheader ]
  %partial_sum.05.11 = phi float [ %partial_sum.3.11, %for.inc48.11 ], [ 0.000000e+00, %for.body15.11.preheader ]
  %add.11 = add nsw i32 %ki.06.11, %in_i.015
  %notlhs.11 = icmp slt i32 %add.11, 0
  %notrhs.11 = icmp uge i32 %add.11, %img_height
  %.not.11 = or i1 %notrhs.11, %notlhs.11
  %brmerge.11 = or i1 %.not.11, %cmp241.not.11
  br i1 %brmerge.11, label %for.inc48.11, label %for.body26.lr.ph.11

for.body26.lr.ph.11:                              ; preds = %for.body15.11
  %mul.11 = shl i32 %add.11, 7
  %mul42.11 = mul i32 %ki.06.11, %kern_width
  br label %for.body26.11

for.body26.11:                                    ; preds = %for.inc.11, %for.body26.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body26.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc.11 ]
  %partial_sum.12.11 = phi float [ %partial_sum.05.11, %for.body26.lr.ph.11 ], [ %partial_sum.2.11, %for.inc.11 ]
  %90 = trunc i64 %indvars.iv.11 to i32
  %add27.11 = add nsw i32 %90, %inc69.10
  %cmp28.11 = icmp sgt i32 %add27.11, -1
  %cmp32.11 = icmp ult i32 %add27.11, %img_width
  %91 = and i1 %cmp28.11, %cmp32.11
  br i1 %91, label %if.end38.11, label %for.inc.11

if.end38.11:                                      ; preds = %for.body26.11
  %add41.11 = add nsw i32 %add27.11, %mul.11
  %idxprom.11 = sext i32 %add41.11 to i64
  %arrayidx.11 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.11
  %92 = load float, float* %arrayidx.11, align 4
  %93 = trunc i64 %indvars.iv.11 to i32
  %add43.11 = add i32 %93, %mul42.11
  %idxprom44.11 = zext i32 %add43.11 to i64
  %arrayidx45.11 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.11
  %94 = load float, float* %arrayidx45.11, align 4
  %mul46.11 = fmul float %92, %94
  %add47.11 = fadd float %partial_sum.12.11, %mul46.11
  br label %for.inc.11

for.inc.11:                                       ; preds = %if.end38.11, %for.body26.11
  %partial_sum.2.11 = phi float [ %add47.11, %if.end38.11 ], [ %partial_sum.12.11, %for.body26.11 ]
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %kern_width
  br i1 %exitcond.11, label %for.inc48.11.loopexit, label %for.body26.11, !llvm.loop !1

for.inc48.11.loopexit:                            ; preds = %for.inc.11
  %partial_sum.2.11.lcssa = phi float [ %partial_sum.2.11, %for.inc.11 ]
  br label %for.inc48.11

for.inc48.11:                                     ; preds = %for.inc48.11.loopexit, %for.body15.11
  %partial_sum.3.11 = phi float [ %partial_sum.05.11, %for.body15.11 ], [ %partial_sum.2.11.lcssa, %for.inc48.11.loopexit ]
  %inc49.11 = add nuw nsw i32 %ki.06.11, 1
  %exitcond19.11 = icmp eq i32 %inc49.11, %kern_height
  br i1 %exitcond19.11, label %for.end50.11.loopexit, label %for.body15.11, !llvm.loop !3

for.end50.11.loopexit:                            ; preds = %for.inc48.11
  %partial_sum.3.11.lcssa = phi float [ %partial_sum.3.11, %for.inc48.11 ]
  br label %for.end50.11

for.end50.11:                                     ; preds = %for.end50.11.loopexit, %for.inc68.10
  %partial_sum.0.lcssa.11 = phi float [ 0.000000e+00, %for.inc68.10 ], [ %partial_sum.3.11.lcssa, %for.end50.11.loopexit ]
  br i1 %tobool51, label %if.else62.11, label %if.then52.11

if.then52.11:                                     ; preds = %for.end50.11
  %cmp53.11 = fcmp olt float %partial_sum.0.lcssa.11, 0.000000e+00
  %sub55.11 = fsub float -0.000000e+00, %partial_sum.0.lcssa.11
  %cond.11 = select i1 %cmp53.11, float %sub55.11, float %partial_sum.0.lcssa.11
  %conv56.11 = fptoui float %cond.11 to i8
  %conv57.11 = uitofp i8 %conv56.11 to float
  %95 = add nsw i64 %indvars.iv.next21.10, %5
  %arrayidx61.11 = getelementptr inbounds float, float* %., i64 %95
  store float %conv57.11, float* %arrayidx61.11, align 4
  br label %for.inc68.11

if.else62.11:                                     ; preds = %for.end50.11
  %96 = add nsw i64 %indvars.iv.next21.10, %4
  %arrayidx66.11 = getelementptr inbounds float, float* %., i64 %96
  store float %partial_sum.0.lcssa.11, float* %arrayidx66.11, align 4
  br label %for.inc68.11

for.inc68.11:                                     ; preds = %if.else62.11, %if.then52.11
  %inc69.11 = add nsw i32 %in_j.011, 12
  %indvars.iv.next21.11 = add nsw i64 %indvars.iv20, 12
  br i1 %cmp134, label %for.end50.12, label %for.body15.12.preheader

for.body15.12.preheader:                          ; preds = %for.inc68.11
  br label %for.body15.12

for.body15.12:                                    ; preds = %for.body15.12.preheader, %for.inc48.12
  %ki.06.12 = phi i32 [ %inc49.12, %for.inc48.12 ], [ 0, %for.body15.12.preheader ]
  %partial_sum.05.12 = phi float [ %partial_sum.3.12, %for.inc48.12 ], [ 0.000000e+00, %for.body15.12.preheader ]
  %add.12 = add nsw i32 %ki.06.12, %in_i.015
  %notlhs.12 = icmp slt i32 %add.12, 0
  %notrhs.12 = icmp uge i32 %add.12, %img_height
  %.not.12 = or i1 %notrhs.12, %notlhs.12
  %brmerge.12 = or i1 %.not.12, %cmp241.not.12
  br i1 %brmerge.12, label %for.inc48.12, label %for.body26.lr.ph.12

for.body26.lr.ph.12:                              ; preds = %for.body15.12
  %mul.12 = shl i32 %add.12, 7
  %mul42.12 = mul i32 %ki.06.12, %kern_width
  br label %for.body26.12

for.body26.12:                                    ; preds = %for.inc.12, %for.body26.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body26.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc.12 ]
  %partial_sum.12.12 = phi float [ %partial_sum.05.12, %for.body26.lr.ph.12 ], [ %partial_sum.2.12, %for.inc.12 ]
  %97 = trunc i64 %indvars.iv.12 to i32
  %add27.12 = add nsw i32 %97, %inc69.11
  %cmp28.12 = icmp sgt i32 %add27.12, -1
  %cmp32.12 = icmp ult i32 %add27.12, %img_width
  %98 = and i1 %cmp28.12, %cmp32.12
  br i1 %98, label %if.end38.12, label %for.inc.12

if.end38.12:                                      ; preds = %for.body26.12
  %add41.12 = add nsw i32 %add27.12, %mul.12
  %idxprom.12 = sext i32 %add41.12 to i64
  %arrayidx.12 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.12
  %99 = load float, float* %arrayidx.12, align 4
  %100 = trunc i64 %indvars.iv.12 to i32
  %add43.12 = add i32 %100, %mul42.12
  %idxprom44.12 = zext i32 %add43.12 to i64
  %arrayidx45.12 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.12
  %101 = load float, float* %arrayidx45.12, align 4
  %mul46.12 = fmul float %99, %101
  %add47.12 = fadd float %partial_sum.12.12, %mul46.12
  br label %for.inc.12

for.inc.12:                                       ; preds = %if.end38.12, %for.body26.12
  %partial_sum.2.12 = phi float [ %add47.12, %if.end38.12 ], [ %partial_sum.12.12, %for.body26.12 ]
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %kern_width
  br i1 %exitcond.12, label %for.inc48.12.loopexit, label %for.body26.12, !llvm.loop !1

for.inc48.12.loopexit:                            ; preds = %for.inc.12
  %partial_sum.2.12.lcssa = phi float [ %partial_sum.2.12, %for.inc.12 ]
  br label %for.inc48.12

for.inc48.12:                                     ; preds = %for.inc48.12.loopexit, %for.body15.12
  %partial_sum.3.12 = phi float [ %partial_sum.05.12, %for.body15.12 ], [ %partial_sum.2.12.lcssa, %for.inc48.12.loopexit ]
  %inc49.12 = add nuw nsw i32 %ki.06.12, 1
  %exitcond19.12 = icmp eq i32 %inc49.12, %kern_height
  br i1 %exitcond19.12, label %for.end50.12.loopexit, label %for.body15.12, !llvm.loop !3

for.end50.12.loopexit:                            ; preds = %for.inc48.12
  %partial_sum.3.12.lcssa = phi float [ %partial_sum.3.12, %for.inc48.12 ]
  br label %for.end50.12

for.end50.12:                                     ; preds = %for.end50.12.loopexit, %for.inc68.11
  %partial_sum.0.lcssa.12 = phi float [ 0.000000e+00, %for.inc68.11 ], [ %partial_sum.3.12.lcssa, %for.end50.12.loopexit ]
  br i1 %tobool51, label %if.else62.12, label %if.then52.12

if.then52.12:                                     ; preds = %for.end50.12
  %cmp53.12 = fcmp olt float %partial_sum.0.lcssa.12, 0.000000e+00
  %sub55.12 = fsub float -0.000000e+00, %partial_sum.0.lcssa.12
  %cond.12 = select i1 %cmp53.12, float %sub55.12, float %partial_sum.0.lcssa.12
  %conv56.12 = fptoui float %cond.12 to i8
  %conv57.12 = uitofp i8 %conv56.12 to float
  %102 = add nsw i64 %indvars.iv.next21.11, %5
  %arrayidx61.12 = getelementptr inbounds float, float* %., i64 %102
  store float %conv57.12, float* %arrayidx61.12, align 4
  br label %for.inc68.12

if.else62.12:                                     ; preds = %for.end50.12
  %103 = add nsw i64 %indvars.iv.next21.11, %4
  %arrayidx66.12 = getelementptr inbounds float, float* %., i64 %103
  store float %partial_sum.0.lcssa.12, float* %arrayidx66.12, align 4
  br label %for.inc68.12

for.inc68.12:                                     ; preds = %if.else62.12, %if.then52.12
  %inc69.12 = add nsw i32 %in_j.011, 13
  %indvars.iv.next21.12 = add nsw i64 %indvars.iv20, 13
  br i1 %cmp134, label %for.end50.13, label %for.body15.13.preheader

for.body15.13.preheader:                          ; preds = %for.inc68.12
  br label %for.body15.13

for.body15.13:                                    ; preds = %for.body15.13.preheader, %for.inc48.13
  %ki.06.13 = phi i32 [ %inc49.13, %for.inc48.13 ], [ 0, %for.body15.13.preheader ]
  %partial_sum.05.13 = phi float [ %partial_sum.3.13, %for.inc48.13 ], [ 0.000000e+00, %for.body15.13.preheader ]
  %add.13 = add nsw i32 %ki.06.13, %in_i.015
  %notlhs.13 = icmp slt i32 %add.13, 0
  %notrhs.13 = icmp uge i32 %add.13, %img_height
  %.not.13 = or i1 %notrhs.13, %notlhs.13
  %brmerge.13 = or i1 %.not.13, %cmp241.not.13
  br i1 %brmerge.13, label %for.inc48.13, label %for.body26.lr.ph.13

for.body26.lr.ph.13:                              ; preds = %for.body15.13
  %mul.13 = shl i32 %add.13, 7
  %mul42.13 = mul i32 %ki.06.13, %kern_width
  br label %for.body26.13

for.body26.13:                                    ; preds = %for.inc.13, %for.body26.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body26.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc.13 ]
  %partial_sum.12.13 = phi float [ %partial_sum.05.13, %for.body26.lr.ph.13 ], [ %partial_sum.2.13, %for.inc.13 ]
  %104 = trunc i64 %indvars.iv.13 to i32
  %add27.13 = add nsw i32 %104, %inc69.12
  %cmp28.13 = icmp sgt i32 %add27.13, -1
  %cmp32.13 = icmp ult i32 %add27.13, %img_width
  %105 = and i1 %cmp28.13, %cmp32.13
  br i1 %105, label %if.end38.13, label %for.inc.13

if.end38.13:                                      ; preds = %for.body26.13
  %add41.13 = add nsw i32 %add27.13, %mul.13
  %idxprom.13 = sext i32 %add41.13 to i64
  %arrayidx.13 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.13
  %106 = load float, float* %arrayidx.13, align 4
  %107 = trunc i64 %indvars.iv.13 to i32
  %add43.13 = add i32 %107, %mul42.13
  %idxprom44.13 = zext i32 %add43.13 to i64
  %arrayidx45.13 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.13
  %108 = load float, float* %arrayidx45.13, align 4
  %mul46.13 = fmul float %106, %108
  %add47.13 = fadd float %partial_sum.12.13, %mul46.13
  br label %for.inc.13

for.inc.13:                                       ; preds = %if.end38.13, %for.body26.13
  %partial_sum.2.13 = phi float [ %add47.13, %if.end38.13 ], [ %partial_sum.12.13, %for.body26.13 ]
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %kern_width
  br i1 %exitcond.13, label %for.inc48.13.loopexit, label %for.body26.13, !llvm.loop !1

for.inc48.13.loopexit:                            ; preds = %for.inc.13
  %partial_sum.2.13.lcssa = phi float [ %partial_sum.2.13, %for.inc.13 ]
  br label %for.inc48.13

for.inc48.13:                                     ; preds = %for.inc48.13.loopexit, %for.body15.13
  %partial_sum.3.13 = phi float [ %partial_sum.05.13, %for.body15.13 ], [ %partial_sum.2.13.lcssa, %for.inc48.13.loopexit ]
  %inc49.13 = add nuw nsw i32 %ki.06.13, 1
  %exitcond19.13 = icmp eq i32 %inc49.13, %kern_height
  br i1 %exitcond19.13, label %for.end50.13.loopexit, label %for.body15.13, !llvm.loop !3

for.end50.13.loopexit:                            ; preds = %for.inc48.13
  %partial_sum.3.13.lcssa = phi float [ %partial_sum.3.13, %for.inc48.13 ]
  br label %for.end50.13

for.end50.13:                                     ; preds = %for.end50.13.loopexit, %for.inc68.12
  %partial_sum.0.lcssa.13 = phi float [ 0.000000e+00, %for.inc68.12 ], [ %partial_sum.3.13.lcssa, %for.end50.13.loopexit ]
  br i1 %tobool51, label %if.else62.13, label %if.then52.13

if.then52.13:                                     ; preds = %for.end50.13
  %cmp53.13 = fcmp olt float %partial_sum.0.lcssa.13, 0.000000e+00
  %sub55.13 = fsub float -0.000000e+00, %partial_sum.0.lcssa.13
  %cond.13 = select i1 %cmp53.13, float %sub55.13, float %partial_sum.0.lcssa.13
  %conv56.13 = fptoui float %cond.13 to i8
  %conv57.13 = uitofp i8 %conv56.13 to float
  %109 = add nsw i64 %indvars.iv.next21.12, %5
  %arrayidx61.13 = getelementptr inbounds float, float* %., i64 %109
  store float %conv57.13, float* %arrayidx61.13, align 4
  br label %for.inc68.13

if.else62.13:                                     ; preds = %for.end50.13
  %110 = add nsw i64 %indvars.iv.next21.12, %4
  %arrayidx66.13 = getelementptr inbounds float, float* %., i64 %110
  store float %partial_sum.0.lcssa.13, float* %arrayidx66.13, align 4
  br label %for.inc68.13

for.inc68.13:                                     ; preds = %if.else62.13, %if.then52.13
  %inc69.13 = add nsw i32 %in_j.011, 14
  %indvars.iv.next21.13 = add nsw i64 %indvars.iv20, 14
  br i1 %cmp134, label %for.end50.14, label %for.body15.14.preheader

for.body15.14.preheader:                          ; preds = %for.inc68.13
  br label %for.body15.14

for.body15.14:                                    ; preds = %for.body15.14.preheader, %for.inc48.14
  %ki.06.14 = phi i32 [ %inc49.14, %for.inc48.14 ], [ 0, %for.body15.14.preheader ]
  %partial_sum.05.14 = phi float [ %partial_sum.3.14, %for.inc48.14 ], [ 0.000000e+00, %for.body15.14.preheader ]
  %add.14 = add nsw i32 %ki.06.14, %in_i.015
  %notlhs.14 = icmp slt i32 %add.14, 0
  %notrhs.14 = icmp uge i32 %add.14, %img_height
  %.not.14 = or i1 %notrhs.14, %notlhs.14
  %brmerge.14 = or i1 %.not.14, %cmp241.not.14
  br i1 %brmerge.14, label %for.inc48.14, label %for.body26.lr.ph.14

for.body26.lr.ph.14:                              ; preds = %for.body15.14
  %mul.14 = shl i32 %add.14, 7
  %mul42.14 = mul i32 %ki.06.14, %kern_width
  br label %for.body26.14

for.body26.14:                                    ; preds = %for.inc.14, %for.body26.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body26.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc.14 ]
  %partial_sum.12.14 = phi float [ %partial_sum.05.14, %for.body26.lr.ph.14 ], [ %partial_sum.2.14, %for.inc.14 ]
  %111 = trunc i64 %indvars.iv.14 to i32
  %add27.14 = add nsw i32 %111, %inc69.13
  %cmp28.14 = icmp sgt i32 %add27.14, -1
  %cmp32.14 = icmp ult i32 %add27.14, %img_width
  %112 = and i1 %cmp28.14, %cmp32.14
  br i1 %112, label %if.end38.14, label %for.inc.14

if.end38.14:                                      ; preds = %for.body26.14
  %add41.14 = add nsw i32 %add27.14, %mul.14
  %idxprom.14 = sext i32 %add41.14 to i64
  %arrayidx.14 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.14
  %113 = load float, float* %arrayidx.14, align 4
  %114 = trunc i64 %indvars.iv.14 to i32
  %add43.14 = add i32 %114, %mul42.14
  %idxprom44.14 = zext i32 %add43.14 to i64
  %arrayidx45.14 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.14
  %115 = load float, float* %arrayidx45.14, align 4
  %mul46.14 = fmul float %113, %115
  %add47.14 = fadd float %partial_sum.12.14, %mul46.14
  br label %for.inc.14

for.inc.14:                                       ; preds = %if.end38.14, %for.body26.14
  %partial_sum.2.14 = phi float [ %add47.14, %if.end38.14 ], [ %partial_sum.12.14, %for.body26.14 ]
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %kern_width
  br i1 %exitcond.14, label %for.inc48.14.loopexit, label %for.body26.14, !llvm.loop !1

for.inc48.14.loopexit:                            ; preds = %for.inc.14
  %partial_sum.2.14.lcssa = phi float [ %partial_sum.2.14, %for.inc.14 ]
  br label %for.inc48.14

for.inc48.14:                                     ; preds = %for.inc48.14.loopexit, %for.body15.14
  %partial_sum.3.14 = phi float [ %partial_sum.05.14, %for.body15.14 ], [ %partial_sum.2.14.lcssa, %for.inc48.14.loopexit ]
  %inc49.14 = add nuw nsw i32 %ki.06.14, 1
  %exitcond19.14 = icmp eq i32 %inc49.14, %kern_height
  br i1 %exitcond19.14, label %for.end50.14.loopexit, label %for.body15.14, !llvm.loop !3

for.end50.14.loopexit:                            ; preds = %for.inc48.14
  %partial_sum.3.14.lcssa = phi float [ %partial_sum.3.14, %for.inc48.14 ]
  br label %for.end50.14

for.end50.14:                                     ; preds = %for.end50.14.loopexit, %for.inc68.13
  %partial_sum.0.lcssa.14 = phi float [ 0.000000e+00, %for.inc68.13 ], [ %partial_sum.3.14.lcssa, %for.end50.14.loopexit ]
  br i1 %tobool51, label %if.else62.14, label %if.then52.14

if.then52.14:                                     ; preds = %for.end50.14
  %cmp53.14 = fcmp olt float %partial_sum.0.lcssa.14, 0.000000e+00
  %sub55.14 = fsub float -0.000000e+00, %partial_sum.0.lcssa.14
  %cond.14 = select i1 %cmp53.14, float %sub55.14, float %partial_sum.0.lcssa.14
  %conv56.14 = fptoui float %cond.14 to i8
  %conv57.14 = uitofp i8 %conv56.14 to float
  %116 = add nsw i64 %indvars.iv.next21.13, %5
  %arrayidx61.14 = getelementptr inbounds float, float* %., i64 %116
  store float %conv57.14, float* %arrayidx61.14, align 4
  br label %for.inc68.14

if.else62.14:                                     ; preds = %for.end50.14
  %117 = add nsw i64 %indvars.iv.next21.13, %4
  %arrayidx66.14 = getelementptr inbounds float, float* %., i64 %117
  store float %partial_sum.0.lcssa.14, float* %arrayidx66.14, align 4
  br label %for.inc68.14

for.inc68.14:                                     ; preds = %if.else62.14, %if.then52.14
  %inc69.14 = add nsw i32 %in_j.011, 15
  %indvars.iv.next21.14 = add nsw i64 %indvars.iv20, 15
  br i1 %cmp134, label %for.end50.15, label %for.body15.15.preheader

for.body15.15.preheader:                          ; preds = %for.inc68.14
  br label %for.body15.15

for.body15.15:                                    ; preds = %for.body15.15.preheader, %for.inc48.15
  %ki.06.15 = phi i32 [ %inc49.15, %for.inc48.15 ], [ 0, %for.body15.15.preheader ]
  %partial_sum.05.15 = phi float [ %partial_sum.3.15, %for.inc48.15 ], [ 0.000000e+00, %for.body15.15.preheader ]
  %add.15 = add nsw i32 %ki.06.15, %in_i.015
  %notlhs.15 = icmp slt i32 %add.15, 0
  %notrhs.15 = icmp uge i32 %add.15, %img_height
  %.not.15 = or i1 %notrhs.15, %notlhs.15
  %brmerge.15 = or i1 %.not.15, %cmp241.not.15
  br i1 %brmerge.15, label %for.inc48.15, label %for.body26.lr.ph.15

for.body26.lr.ph.15:                              ; preds = %for.body15.15
  %mul.15 = shl i32 %add.15, 7
  %mul42.15 = mul i32 %ki.06.15, %kern_width
  br label %for.body26.15

for.body26.15:                                    ; preds = %for.inc.15, %for.body26.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body26.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc.15 ]
  %partial_sum.12.15 = phi float [ %partial_sum.05.15, %for.body26.lr.ph.15 ], [ %partial_sum.2.15, %for.inc.15 ]
  %118 = trunc i64 %indvars.iv.15 to i32
  %add27.15 = add nsw i32 %118, %inc69.14
  %cmp28.15 = icmp sgt i32 %add27.15, -1
  %cmp32.15 = icmp ult i32 %add27.15, %img_width
  %119 = and i1 %cmp28.15, %cmp32.15
  br i1 %119, label %if.end38.15, label %for.inc.15

if.end38.15:                                      ; preds = %for.body26.15
  %add41.15 = add nsw i32 %add27.15, %mul.15
  %idxprom.15 = sext i32 %add41.15 to i64
  %arrayidx.15 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.15
  %120 = load float, float* %arrayidx.15, align 4
  %121 = trunc i64 %indvars.iv.15 to i32
  %add43.15 = add i32 %121, %mul42.15
  %idxprom44.15 = zext i32 %add43.15 to i64
  %arrayidx45.15 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.15
  %122 = load float, float* %arrayidx45.15, align 4
  %mul46.15 = fmul float %120, %122
  %add47.15 = fadd float %partial_sum.12.15, %mul46.15
  br label %for.inc.15

for.inc.15:                                       ; preds = %if.end38.15, %for.body26.15
  %partial_sum.2.15 = phi float [ %add47.15, %if.end38.15 ], [ %partial_sum.12.15, %for.body26.15 ]
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %kern_width
  br i1 %exitcond.15, label %for.inc48.15.loopexit, label %for.body26.15, !llvm.loop !1

for.inc48.15.loopexit:                            ; preds = %for.inc.15
  %partial_sum.2.15.lcssa = phi float [ %partial_sum.2.15, %for.inc.15 ]
  br label %for.inc48.15

for.inc48.15:                                     ; preds = %for.inc48.15.loopexit, %for.body15.15
  %partial_sum.3.15 = phi float [ %partial_sum.05.15, %for.body15.15 ], [ %partial_sum.2.15.lcssa, %for.inc48.15.loopexit ]
  %inc49.15 = add nuw nsw i32 %ki.06.15, 1
  %exitcond19.15 = icmp eq i32 %inc49.15, %kern_height
  br i1 %exitcond19.15, label %for.end50.15.loopexit, label %for.body15.15, !llvm.loop !3

for.end50.15.loopexit:                            ; preds = %for.inc48.15
  %partial_sum.3.15.lcssa = phi float [ %partial_sum.3.15, %for.inc48.15 ]
  br label %for.end50.15

for.end50.15:                                     ; preds = %for.end50.15.loopexit, %for.inc68.14
  %partial_sum.0.lcssa.15 = phi float [ 0.000000e+00, %for.inc68.14 ], [ %partial_sum.3.15.lcssa, %for.end50.15.loopexit ]
  br i1 %tobool51, label %if.else62.15, label %if.then52.15

if.then52.15:                                     ; preds = %for.end50.15
  %cmp53.15 = fcmp olt float %partial_sum.0.lcssa.15, 0.000000e+00
  %sub55.15 = fsub float -0.000000e+00, %partial_sum.0.lcssa.15
  %cond.15 = select i1 %cmp53.15, float %sub55.15, float %partial_sum.0.lcssa.15
  %conv56.15 = fptoui float %cond.15 to i8
  %conv57.15 = uitofp i8 %conv56.15 to float
  %123 = add nsw i64 %indvars.iv.next21.14, %5
  %arrayidx61.15 = getelementptr inbounds float, float* %., i64 %123
  store float %conv57.15, float* %arrayidx61.15, align 4
  br label %for.inc68.15

if.else62.15:                                     ; preds = %for.end50.15
  %124 = add nsw i64 %indvars.iv.next21.14, %4
  %arrayidx66.15 = getelementptr inbounds float, float* %., i64 %124
  store float %partial_sum.0.lcssa.15, float* %arrayidx66.15, align 4
  br label %for.inc68.15

for.inc68.15:                                     ; preds = %if.else62.15, %if.then52.15
  %inc69.15 = add nsw i32 %in_j.011, 16
  %indvars.iv.next21.15 = add nsw i64 %indvars.iv20, 16
  br i1 %cmp134, label %for.end50.16, label %for.body15.16.preheader

for.body15.16.preheader:                          ; preds = %for.inc68.15
  br label %for.body15.16

for.body15.16:                                    ; preds = %for.body15.16.preheader, %for.inc48.16
  %ki.06.16 = phi i32 [ %inc49.16, %for.inc48.16 ], [ 0, %for.body15.16.preheader ]
  %partial_sum.05.16 = phi float [ %partial_sum.3.16, %for.inc48.16 ], [ 0.000000e+00, %for.body15.16.preheader ]
  %add.16 = add nsw i32 %ki.06.16, %in_i.015
  %notlhs.16 = icmp slt i32 %add.16, 0
  %notrhs.16 = icmp uge i32 %add.16, %img_height
  %.not.16 = or i1 %notrhs.16, %notlhs.16
  %brmerge.16 = or i1 %.not.16, %cmp241.not.16
  br i1 %brmerge.16, label %for.inc48.16, label %for.body26.lr.ph.16

for.body26.lr.ph.16:                              ; preds = %for.body15.16
  %mul.16 = shl i32 %add.16, 7
  %mul42.16 = mul i32 %ki.06.16, %kern_width
  br label %for.body26.16

for.body26.16:                                    ; preds = %for.inc.16, %for.body26.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body26.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc.16 ]
  %partial_sum.12.16 = phi float [ %partial_sum.05.16, %for.body26.lr.ph.16 ], [ %partial_sum.2.16, %for.inc.16 ]
  %125 = trunc i64 %indvars.iv.16 to i32
  %add27.16 = add nsw i32 %125, %inc69.15
  %cmp28.16 = icmp sgt i32 %add27.16, -1
  %cmp32.16 = icmp ult i32 %add27.16, %img_width
  %126 = and i1 %cmp28.16, %cmp32.16
  br i1 %126, label %if.end38.16, label %for.inc.16

if.end38.16:                                      ; preds = %for.body26.16
  %add41.16 = add nsw i32 %add27.16, %mul.16
  %idxprom.16 = sext i32 %add41.16 to i64
  %arrayidx.16 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.16
  %127 = load float, float* %arrayidx.16, align 4
  %128 = trunc i64 %indvars.iv.16 to i32
  %add43.16 = add i32 %128, %mul42.16
  %idxprom44.16 = zext i32 %add43.16 to i64
  %arrayidx45.16 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.16
  %129 = load float, float* %arrayidx45.16, align 4
  %mul46.16 = fmul float %127, %129
  %add47.16 = fadd float %partial_sum.12.16, %mul46.16
  br label %for.inc.16

for.inc.16:                                       ; preds = %if.end38.16, %for.body26.16
  %partial_sum.2.16 = phi float [ %add47.16, %if.end38.16 ], [ %partial_sum.12.16, %for.body26.16 ]
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %kern_width
  br i1 %exitcond.16, label %for.inc48.16.loopexit, label %for.body26.16, !llvm.loop !1

for.inc48.16.loopexit:                            ; preds = %for.inc.16
  %partial_sum.2.16.lcssa = phi float [ %partial_sum.2.16, %for.inc.16 ]
  br label %for.inc48.16

for.inc48.16:                                     ; preds = %for.inc48.16.loopexit, %for.body15.16
  %partial_sum.3.16 = phi float [ %partial_sum.05.16, %for.body15.16 ], [ %partial_sum.2.16.lcssa, %for.inc48.16.loopexit ]
  %inc49.16 = add nuw nsw i32 %ki.06.16, 1
  %exitcond19.16 = icmp eq i32 %inc49.16, %kern_height
  br i1 %exitcond19.16, label %for.end50.16.loopexit, label %for.body15.16, !llvm.loop !3

for.end50.16.loopexit:                            ; preds = %for.inc48.16
  %partial_sum.3.16.lcssa = phi float [ %partial_sum.3.16, %for.inc48.16 ]
  br label %for.end50.16

for.end50.16:                                     ; preds = %for.end50.16.loopexit, %for.inc68.15
  %partial_sum.0.lcssa.16 = phi float [ 0.000000e+00, %for.inc68.15 ], [ %partial_sum.3.16.lcssa, %for.end50.16.loopexit ]
  br i1 %tobool51, label %if.else62.16, label %if.then52.16

if.then52.16:                                     ; preds = %for.end50.16
  %cmp53.16 = fcmp olt float %partial_sum.0.lcssa.16, 0.000000e+00
  %sub55.16 = fsub float -0.000000e+00, %partial_sum.0.lcssa.16
  %cond.16 = select i1 %cmp53.16, float %sub55.16, float %partial_sum.0.lcssa.16
  %conv56.16 = fptoui float %cond.16 to i8
  %conv57.16 = uitofp i8 %conv56.16 to float
  %130 = add nsw i64 %indvars.iv.next21.15, %5
  %arrayidx61.16 = getelementptr inbounds float, float* %., i64 %130
  store float %conv57.16, float* %arrayidx61.16, align 4
  br label %for.inc68.16

if.else62.16:                                     ; preds = %for.end50.16
  %131 = add nsw i64 %indvars.iv.next21.15, %4
  %arrayidx66.16 = getelementptr inbounds float, float* %., i64 %131
  store float %partial_sum.0.lcssa.16, float* %arrayidx66.16, align 4
  br label %for.inc68.16

for.inc68.16:                                     ; preds = %if.else62.16, %if.then52.16
  %inc69.16 = add nsw i32 %in_j.011, 17
  %indvars.iv.next21.16 = add nsw i64 %indvars.iv20, 17
  br i1 %cmp134, label %for.end50.17, label %for.body15.17.preheader

for.body15.17.preheader:                          ; preds = %for.inc68.16
  br label %for.body15.17

for.body15.17:                                    ; preds = %for.body15.17.preheader, %for.inc48.17
  %ki.06.17 = phi i32 [ %inc49.17, %for.inc48.17 ], [ 0, %for.body15.17.preheader ]
  %partial_sum.05.17 = phi float [ %partial_sum.3.17, %for.inc48.17 ], [ 0.000000e+00, %for.body15.17.preheader ]
  %add.17 = add nsw i32 %ki.06.17, %in_i.015
  %notlhs.17 = icmp slt i32 %add.17, 0
  %notrhs.17 = icmp uge i32 %add.17, %img_height
  %.not.17 = or i1 %notrhs.17, %notlhs.17
  %brmerge.17 = or i1 %.not.17, %cmp241.not.17
  br i1 %brmerge.17, label %for.inc48.17, label %for.body26.lr.ph.17

for.body26.lr.ph.17:                              ; preds = %for.body15.17
  %mul.17 = shl i32 %add.17, 7
  %mul42.17 = mul i32 %ki.06.17, %kern_width
  br label %for.body26.17

for.body26.17:                                    ; preds = %for.inc.17, %for.body26.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body26.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc.17 ]
  %partial_sum.12.17 = phi float [ %partial_sum.05.17, %for.body26.lr.ph.17 ], [ %partial_sum.2.17, %for.inc.17 ]
  %132 = trunc i64 %indvars.iv.17 to i32
  %add27.17 = add nsw i32 %132, %inc69.16
  %cmp28.17 = icmp sgt i32 %add27.17, -1
  %cmp32.17 = icmp ult i32 %add27.17, %img_width
  %133 = and i1 %cmp28.17, %cmp32.17
  br i1 %133, label %if.end38.17, label %for.inc.17

if.end38.17:                                      ; preds = %for.body26.17
  %add41.17 = add nsw i32 %add27.17, %mul.17
  %idxprom.17 = sext i32 %add41.17 to i64
  %arrayidx.17 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.17
  %134 = load float, float* %arrayidx.17, align 4
  %135 = trunc i64 %indvars.iv.17 to i32
  %add43.17 = add i32 %135, %mul42.17
  %idxprom44.17 = zext i32 %add43.17 to i64
  %arrayidx45.17 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.17
  %136 = load float, float* %arrayidx45.17, align 4
  %mul46.17 = fmul float %134, %136
  %add47.17 = fadd float %partial_sum.12.17, %mul46.17
  br label %for.inc.17

for.inc.17:                                       ; preds = %if.end38.17, %for.body26.17
  %partial_sum.2.17 = phi float [ %add47.17, %if.end38.17 ], [ %partial_sum.12.17, %for.body26.17 ]
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %kern_width
  br i1 %exitcond.17, label %for.inc48.17.loopexit, label %for.body26.17, !llvm.loop !1

for.inc48.17.loopexit:                            ; preds = %for.inc.17
  %partial_sum.2.17.lcssa = phi float [ %partial_sum.2.17, %for.inc.17 ]
  br label %for.inc48.17

for.inc48.17:                                     ; preds = %for.inc48.17.loopexit, %for.body15.17
  %partial_sum.3.17 = phi float [ %partial_sum.05.17, %for.body15.17 ], [ %partial_sum.2.17.lcssa, %for.inc48.17.loopexit ]
  %inc49.17 = add nuw nsw i32 %ki.06.17, 1
  %exitcond19.17 = icmp eq i32 %inc49.17, %kern_height
  br i1 %exitcond19.17, label %for.end50.17.loopexit, label %for.body15.17, !llvm.loop !3

for.end50.17.loopexit:                            ; preds = %for.inc48.17
  %partial_sum.3.17.lcssa = phi float [ %partial_sum.3.17, %for.inc48.17 ]
  br label %for.end50.17

for.end50.17:                                     ; preds = %for.end50.17.loopexit, %for.inc68.16
  %partial_sum.0.lcssa.17 = phi float [ 0.000000e+00, %for.inc68.16 ], [ %partial_sum.3.17.lcssa, %for.end50.17.loopexit ]
  br i1 %tobool51, label %if.else62.17, label %if.then52.17

if.then52.17:                                     ; preds = %for.end50.17
  %cmp53.17 = fcmp olt float %partial_sum.0.lcssa.17, 0.000000e+00
  %sub55.17 = fsub float -0.000000e+00, %partial_sum.0.lcssa.17
  %cond.17 = select i1 %cmp53.17, float %sub55.17, float %partial_sum.0.lcssa.17
  %conv56.17 = fptoui float %cond.17 to i8
  %conv57.17 = uitofp i8 %conv56.17 to float
  %137 = add nsw i64 %indvars.iv.next21.16, %5
  %arrayidx61.17 = getelementptr inbounds float, float* %., i64 %137
  store float %conv57.17, float* %arrayidx61.17, align 4
  br label %for.inc68.17

if.else62.17:                                     ; preds = %for.end50.17
  %138 = add nsw i64 %indvars.iv.next21.16, %4
  %arrayidx66.17 = getelementptr inbounds float, float* %., i64 %138
  store float %partial_sum.0.lcssa.17, float* %arrayidx66.17, align 4
  br label %for.inc68.17

for.inc68.17:                                     ; preds = %if.else62.17, %if.then52.17
  %inc69.17 = add nsw i32 %in_j.011, 18
  %indvars.iv.next21.17 = add nsw i64 %indvars.iv20, 18
  br i1 %cmp134, label %for.end50.18, label %for.body15.18.preheader

for.body15.18.preheader:                          ; preds = %for.inc68.17
  br label %for.body15.18

for.body15.18:                                    ; preds = %for.body15.18.preheader, %for.inc48.18
  %ki.06.18 = phi i32 [ %inc49.18, %for.inc48.18 ], [ 0, %for.body15.18.preheader ]
  %partial_sum.05.18 = phi float [ %partial_sum.3.18, %for.inc48.18 ], [ 0.000000e+00, %for.body15.18.preheader ]
  %add.18 = add nsw i32 %ki.06.18, %in_i.015
  %notlhs.18 = icmp slt i32 %add.18, 0
  %notrhs.18 = icmp uge i32 %add.18, %img_height
  %.not.18 = or i1 %notrhs.18, %notlhs.18
  %brmerge.18 = or i1 %.not.18, %cmp241.not.18
  br i1 %brmerge.18, label %for.inc48.18, label %for.body26.lr.ph.18

for.body26.lr.ph.18:                              ; preds = %for.body15.18
  %mul.18 = shl i32 %add.18, 7
  %mul42.18 = mul i32 %ki.06.18, %kern_width
  br label %for.body26.18

for.body26.18:                                    ; preds = %for.inc.18, %for.body26.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body26.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc.18 ]
  %partial_sum.12.18 = phi float [ %partial_sum.05.18, %for.body26.lr.ph.18 ], [ %partial_sum.2.18, %for.inc.18 ]
  %139 = trunc i64 %indvars.iv.18 to i32
  %add27.18 = add nsw i32 %139, %inc69.17
  %cmp28.18 = icmp sgt i32 %add27.18, -1
  %cmp32.18 = icmp ult i32 %add27.18, %img_width
  %140 = and i1 %cmp28.18, %cmp32.18
  br i1 %140, label %if.end38.18, label %for.inc.18

if.end38.18:                                      ; preds = %for.body26.18
  %add41.18 = add nsw i32 %add27.18, %mul.18
  %idxprom.18 = sext i32 %add41.18 to i64
  %arrayidx.18 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.18
  %141 = load float, float* %arrayidx.18, align 4
  %142 = trunc i64 %indvars.iv.18 to i32
  %add43.18 = add i32 %142, %mul42.18
  %idxprom44.18 = zext i32 %add43.18 to i64
  %arrayidx45.18 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.18
  %143 = load float, float* %arrayidx45.18, align 4
  %mul46.18 = fmul float %141, %143
  %add47.18 = fadd float %partial_sum.12.18, %mul46.18
  br label %for.inc.18

for.inc.18:                                       ; preds = %if.end38.18, %for.body26.18
  %partial_sum.2.18 = phi float [ %add47.18, %if.end38.18 ], [ %partial_sum.12.18, %for.body26.18 ]
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %kern_width
  br i1 %exitcond.18, label %for.inc48.18.loopexit, label %for.body26.18, !llvm.loop !1

for.inc48.18.loopexit:                            ; preds = %for.inc.18
  %partial_sum.2.18.lcssa = phi float [ %partial_sum.2.18, %for.inc.18 ]
  br label %for.inc48.18

for.inc48.18:                                     ; preds = %for.inc48.18.loopexit, %for.body15.18
  %partial_sum.3.18 = phi float [ %partial_sum.05.18, %for.body15.18 ], [ %partial_sum.2.18.lcssa, %for.inc48.18.loopexit ]
  %inc49.18 = add nuw nsw i32 %ki.06.18, 1
  %exitcond19.18 = icmp eq i32 %inc49.18, %kern_height
  br i1 %exitcond19.18, label %for.end50.18.loopexit, label %for.body15.18, !llvm.loop !3

for.end50.18.loopexit:                            ; preds = %for.inc48.18
  %partial_sum.3.18.lcssa = phi float [ %partial_sum.3.18, %for.inc48.18 ]
  br label %for.end50.18

for.end50.18:                                     ; preds = %for.end50.18.loopexit, %for.inc68.17
  %partial_sum.0.lcssa.18 = phi float [ 0.000000e+00, %for.inc68.17 ], [ %partial_sum.3.18.lcssa, %for.end50.18.loopexit ]
  br i1 %tobool51, label %if.else62.18, label %if.then52.18

if.then52.18:                                     ; preds = %for.end50.18
  %cmp53.18 = fcmp olt float %partial_sum.0.lcssa.18, 0.000000e+00
  %sub55.18 = fsub float -0.000000e+00, %partial_sum.0.lcssa.18
  %cond.18 = select i1 %cmp53.18, float %sub55.18, float %partial_sum.0.lcssa.18
  %conv56.18 = fptoui float %cond.18 to i8
  %conv57.18 = uitofp i8 %conv56.18 to float
  %144 = add nsw i64 %indvars.iv.next21.17, %5
  %arrayidx61.18 = getelementptr inbounds float, float* %., i64 %144
  store float %conv57.18, float* %arrayidx61.18, align 4
  br label %for.inc68.18

if.else62.18:                                     ; preds = %for.end50.18
  %145 = add nsw i64 %indvars.iv.next21.17, %4
  %arrayidx66.18 = getelementptr inbounds float, float* %., i64 %145
  store float %partial_sum.0.lcssa.18, float* %arrayidx66.18, align 4
  br label %for.inc68.18

for.inc68.18:                                     ; preds = %if.else62.18, %if.then52.18
  %inc69.18 = add nsw i32 %in_j.011, 19
  %indvars.iv.next21.18 = add nsw i64 %indvars.iv20, 19
  br i1 %cmp134, label %for.end50.19, label %for.body15.19.preheader

for.body15.19.preheader:                          ; preds = %for.inc68.18
  br label %for.body15.19

for.body15.19:                                    ; preds = %for.body15.19.preheader, %for.inc48.19
  %ki.06.19 = phi i32 [ %inc49.19, %for.inc48.19 ], [ 0, %for.body15.19.preheader ]
  %partial_sum.05.19 = phi float [ %partial_sum.3.19, %for.inc48.19 ], [ 0.000000e+00, %for.body15.19.preheader ]
  %add.19 = add nsw i32 %ki.06.19, %in_i.015
  %notlhs.19 = icmp slt i32 %add.19, 0
  %notrhs.19 = icmp uge i32 %add.19, %img_height
  %.not.19 = or i1 %notrhs.19, %notlhs.19
  %brmerge.19 = or i1 %.not.19, %cmp241.not.19
  br i1 %brmerge.19, label %for.inc48.19, label %for.body26.lr.ph.19

for.body26.lr.ph.19:                              ; preds = %for.body15.19
  %mul.19 = shl i32 %add.19, 7
  %mul42.19 = mul i32 %ki.06.19, %kern_width
  br label %for.body26.19

for.body26.19:                                    ; preds = %for.inc.19, %for.body26.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body26.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc.19 ]
  %partial_sum.12.19 = phi float [ %partial_sum.05.19, %for.body26.lr.ph.19 ], [ %partial_sum.2.19, %for.inc.19 ]
  %146 = trunc i64 %indvars.iv.19 to i32
  %add27.19 = add nsw i32 %146, %inc69.18
  %cmp28.19 = icmp sgt i32 %add27.19, -1
  %cmp32.19 = icmp ult i32 %add27.19, %img_width
  %147 = and i1 %cmp28.19, %cmp32.19
  br i1 %147, label %if.end38.19, label %for.inc.19

if.end38.19:                                      ; preds = %for.body26.19
  %add41.19 = add nsw i32 %add27.19, %mul.19
  %idxprom.19 = sext i32 %add41.19 to i64
  %arrayidx.19 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.19
  %148 = load float, float* %arrayidx.19, align 4
  %149 = trunc i64 %indvars.iv.19 to i32
  %add43.19 = add i32 %149, %mul42.19
  %idxprom44.19 = zext i32 %add43.19 to i64
  %arrayidx45.19 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.19
  %150 = load float, float* %arrayidx45.19, align 4
  %mul46.19 = fmul float %148, %150
  %add47.19 = fadd float %partial_sum.12.19, %mul46.19
  br label %for.inc.19

for.inc.19:                                       ; preds = %if.end38.19, %for.body26.19
  %partial_sum.2.19 = phi float [ %add47.19, %if.end38.19 ], [ %partial_sum.12.19, %for.body26.19 ]
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %kern_width
  br i1 %exitcond.19, label %for.inc48.19.loopexit, label %for.body26.19, !llvm.loop !1

for.inc48.19.loopexit:                            ; preds = %for.inc.19
  %partial_sum.2.19.lcssa = phi float [ %partial_sum.2.19, %for.inc.19 ]
  br label %for.inc48.19

for.inc48.19:                                     ; preds = %for.inc48.19.loopexit, %for.body15.19
  %partial_sum.3.19 = phi float [ %partial_sum.05.19, %for.body15.19 ], [ %partial_sum.2.19.lcssa, %for.inc48.19.loopexit ]
  %inc49.19 = add nuw nsw i32 %ki.06.19, 1
  %exitcond19.19 = icmp eq i32 %inc49.19, %kern_height
  br i1 %exitcond19.19, label %for.end50.19.loopexit, label %for.body15.19, !llvm.loop !3

for.end50.19.loopexit:                            ; preds = %for.inc48.19
  %partial_sum.3.19.lcssa = phi float [ %partial_sum.3.19, %for.inc48.19 ]
  br label %for.end50.19

for.end50.19:                                     ; preds = %for.end50.19.loopexit, %for.inc68.18
  %partial_sum.0.lcssa.19 = phi float [ 0.000000e+00, %for.inc68.18 ], [ %partial_sum.3.19.lcssa, %for.end50.19.loopexit ]
  br i1 %tobool51, label %if.else62.19, label %if.then52.19

if.then52.19:                                     ; preds = %for.end50.19
  %cmp53.19 = fcmp olt float %partial_sum.0.lcssa.19, 0.000000e+00
  %sub55.19 = fsub float -0.000000e+00, %partial_sum.0.lcssa.19
  %cond.19 = select i1 %cmp53.19, float %sub55.19, float %partial_sum.0.lcssa.19
  %conv56.19 = fptoui float %cond.19 to i8
  %conv57.19 = uitofp i8 %conv56.19 to float
  %151 = add nsw i64 %indvars.iv.next21.18, %5
  %arrayidx61.19 = getelementptr inbounds float, float* %., i64 %151
  store float %conv57.19, float* %arrayidx61.19, align 4
  br label %for.inc68.19

if.else62.19:                                     ; preds = %for.end50.19
  %152 = add nsw i64 %indvars.iv.next21.18, %4
  %arrayidx66.19 = getelementptr inbounds float, float* %., i64 %152
  store float %partial_sum.0.lcssa.19, float* %arrayidx66.19, align 4
  br label %for.inc68.19

for.inc68.19:                                     ; preds = %if.else62.19, %if.then52.19
  %inc69.19 = add nsw i32 %in_j.011, 20
  %indvars.iv.next21.19 = add nsw i64 %indvars.iv20, 20
  br i1 %cmp134, label %for.end50.20, label %for.body15.20.preheader

for.body15.20.preheader:                          ; preds = %for.inc68.19
  br label %for.body15.20

for.body15.20:                                    ; preds = %for.body15.20.preheader, %for.inc48.20
  %ki.06.20 = phi i32 [ %inc49.20, %for.inc48.20 ], [ 0, %for.body15.20.preheader ]
  %partial_sum.05.20 = phi float [ %partial_sum.3.20, %for.inc48.20 ], [ 0.000000e+00, %for.body15.20.preheader ]
  %add.20 = add nsw i32 %ki.06.20, %in_i.015
  %notlhs.20 = icmp slt i32 %add.20, 0
  %notrhs.20 = icmp uge i32 %add.20, %img_height
  %.not.20 = or i1 %notrhs.20, %notlhs.20
  %brmerge.20 = or i1 %.not.20, %cmp241.not.20
  br i1 %brmerge.20, label %for.inc48.20, label %for.body26.lr.ph.20

for.body26.lr.ph.20:                              ; preds = %for.body15.20
  %mul.20 = shl i32 %add.20, 7
  %mul42.20 = mul i32 %ki.06.20, %kern_width
  br label %for.body26.20

for.body26.20:                                    ; preds = %for.inc.20, %for.body26.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body26.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc.20 ]
  %partial_sum.12.20 = phi float [ %partial_sum.05.20, %for.body26.lr.ph.20 ], [ %partial_sum.2.20, %for.inc.20 ]
  %153 = trunc i64 %indvars.iv.20 to i32
  %add27.20 = add nsw i32 %153, %inc69.19
  %cmp28.20 = icmp sgt i32 %add27.20, -1
  %cmp32.20 = icmp ult i32 %add27.20, %img_width
  %154 = and i1 %cmp28.20, %cmp32.20
  br i1 %154, label %if.end38.20, label %for.inc.20

if.end38.20:                                      ; preds = %for.body26.20
  %add41.20 = add nsw i32 %add27.20, %mul.20
  %idxprom.20 = sext i32 %add41.20 to i64
  %arrayidx.20 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.20
  %155 = load float, float* %arrayidx.20, align 4
  %156 = trunc i64 %indvars.iv.20 to i32
  %add43.20 = add i32 %156, %mul42.20
  %idxprom44.20 = zext i32 %add43.20 to i64
  %arrayidx45.20 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.20
  %157 = load float, float* %arrayidx45.20, align 4
  %mul46.20 = fmul float %155, %157
  %add47.20 = fadd float %partial_sum.12.20, %mul46.20
  br label %for.inc.20

for.inc.20:                                       ; preds = %if.end38.20, %for.body26.20
  %partial_sum.2.20 = phi float [ %add47.20, %if.end38.20 ], [ %partial_sum.12.20, %for.body26.20 ]
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %kern_width
  br i1 %exitcond.20, label %for.inc48.20.loopexit, label %for.body26.20, !llvm.loop !1

for.inc48.20.loopexit:                            ; preds = %for.inc.20
  %partial_sum.2.20.lcssa = phi float [ %partial_sum.2.20, %for.inc.20 ]
  br label %for.inc48.20

for.inc48.20:                                     ; preds = %for.inc48.20.loopexit, %for.body15.20
  %partial_sum.3.20 = phi float [ %partial_sum.05.20, %for.body15.20 ], [ %partial_sum.2.20.lcssa, %for.inc48.20.loopexit ]
  %inc49.20 = add nuw nsw i32 %ki.06.20, 1
  %exitcond19.20 = icmp eq i32 %inc49.20, %kern_height
  br i1 %exitcond19.20, label %for.end50.20.loopexit, label %for.body15.20, !llvm.loop !3

for.end50.20.loopexit:                            ; preds = %for.inc48.20
  %partial_sum.3.20.lcssa = phi float [ %partial_sum.3.20, %for.inc48.20 ]
  br label %for.end50.20

for.end50.20:                                     ; preds = %for.end50.20.loopexit, %for.inc68.19
  %partial_sum.0.lcssa.20 = phi float [ 0.000000e+00, %for.inc68.19 ], [ %partial_sum.3.20.lcssa, %for.end50.20.loopexit ]
  br i1 %tobool51, label %if.else62.20, label %if.then52.20

if.then52.20:                                     ; preds = %for.end50.20
  %cmp53.20 = fcmp olt float %partial_sum.0.lcssa.20, 0.000000e+00
  %sub55.20 = fsub float -0.000000e+00, %partial_sum.0.lcssa.20
  %cond.20 = select i1 %cmp53.20, float %sub55.20, float %partial_sum.0.lcssa.20
  %conv56.20 = fptoui float %cond.20 to i8
  %conv57.20 = uitofp i8 %conv56.20 to float
  %158 = add nsw i64 %indvars.iv.next21.19, %5
  %arrayidx61.20 = getelementptr inbounds float, float* %., i64 %158
  store float %conv57.20, float* %arrayidx61.20, align 4
  br label %for.inc68.20

if.else62.20:                                     ; preds = %for.end50.20
  %159 = add nsw i64 %indvars.iv.next21.19, %4
  %arrayidx66.20 = getelementptr inbounds float, float* %., i64 %159
  store float %partial_sum.0.lcssa.20, float* %arrayidx66.20, align 4
  br label %for.inc68.20

for.inc68.20:                                     ; preds = %if.else62.20, %if.then52.20
  %inc69.20 = add nsw i32 %in_j.011, 21
  %indvars.iv.next21.20 = add nsw i64 %indvars.iv20, 21
  br i1 %cmp134, label %for.end50.21, label %for.body15.21.preheader

for.body15.21.preheader:                          ; preds = %for.inc68.20
  br label %for.body15.21

for.body15.21:                                    ; preds = %for.body15.21.preheader, %for.inc48.21
  %ki.06.21 = phi i32 [ %inc49.21, %for.inc48.21 ], [ 0, %for.body15.21.preheader ]
  %partial_sum.05.21 = phi float [ %partial_sum.3.21, %for.inc48.21 ], [ 0.000000e+00, %for.body15.21.preheader ]
  %add.21 = add nsw i32 %ki.06.21, %in_i.015
  %notlhs.21 = icmp slt i32 %add.21, 0
  %notrhs.21 = icmp uge i32 %add.21, %img_height
  %.not.21 = or i1 %notrhs.21, %notlhs.21
  %brmerge.21 = or i1 %.not.21, %cmp241.not.21
  br i1 %brmerge.21, label %for.inc48.21, label %for.body26.lr.ph.21

for.body26.lr.ph.21:                              ; preds = %for.body15.21
  %mul.21 = shl i32 %add.21, 7
  %mul42.21 = mul i32 %ki.06.21, %kern_width
  br label %for.body26.21

for.body26.21:                                    ; preds = %for.inc.21, %for.body26.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body26.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc.21 ]
  %partial_sum.12.21 = phi float [ %partial_sum.05.21, %for.body26.lr.ph.21 ], [ %partial_sum.2.21, %for.inc.21 ]
  %160 = trunc i64 %indvars.iv.21 to i32
  %add27.21 = add nsw i32 %160, %inc69.20
  %cmp28.21 = icmp sgt i32 %add27.21, -1
  %cmp32.21 = icmp ult i32 %add27.21, %img_width
  %161 = and i1 %cmp28.21, %cmp32.21
  br i1 %161, label %if.end38.21, label %for.inc.21

if.end38.21:                                      ; preds = %for.body26.21
  %add41.21 = add nsw i32 %add27.21, %mul.21
  %idxprom.21 = sext i32 %add41.21 to i64
  %arrayidx.21 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.21
  %162 = load float, float* %arrayidx.21, align 4
  %163 = trunc i64 %indvars.iv.21 to i32
  %add43.21 = add i32 %163, %mul42.21
  %idxprom44.21 = zext i32 %add43.21 to i64
  %arrayidx45.21 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.21
  %164 = load float, float* %arrayidx45.21, align 4
  %mul46.21 = fmul float %162, %164
  %add47.21 = fadd float %partial_sum.12.21, %mul46.21
  br label %for.inc.21

for.inc.21:                                       ; preds = %if.end38.21, %for.body26.21
  %partial_sum.2.21 = phi float [ %add47.21, %if.end38.21 ], [ %partial_sum.12.21, %for.body26.21 ]
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %kern_width
  br i1 %exitcond.21, label %for.inc48.21.loopexit, label %for.body26.21, !llvm.loop !1

for.inc48.21.loopexit:                            ; preds = %for.inc.21
  %partial_sum.2.21.lcssa = phi float [ %partial_sum.2.21, %for.inc.21 ]
  br label %for.inc48.21

for.inc48.21:                                     ; preds = %for.inc48.21.loopexit, %for.body15.21
  %partial_sum.3.21 = phi float [ %partial_sum.05.21, %for.body15.21 ], [ %partial_sum.2.21.lcssa, %for.inc48.21.loopexit ]
  %inc49.21 = add nuw nsw i32 %ki.06.21, 1
  %exitcond19.21 = icmp eq i32 %inc49.21, %kern_height
  br i1 %exitcond19.21, label %for.end50.21.loopexit, label %for.body15.21, !llvm.loop !3

for.end50.21.loopexit:                            ; preds = %for.inc48.21
  %partial_sum.3.21.lcssa = phi float [ %partial_sum.3.21, %for.inc48.21 ]
  br label %for.end50.21

for.end50.21:                                     ; preds = %for.end50.21.loopexit, %for.inc68.20
  %partial_sum.0.lcssa.21 = phi float [ 0.000000e+00, %for.inc68.20 ], [ %partial_sum.3.21.lcssa, %for.end50.21.loopexit ]
  br i1 %tobool51, label %if.else62.21, label %if.then52.21

if.then52.21:                                     ; preds = %for.end50.21
  %cmp53.21 = fcmp olt float %partial_sum.0.lcssa.21, 0.000000e+00
  %sub55.21 = fsub float -0.000000e+00, %partial_sum.0.lcssa.21
  %cond.21 = select i1 %cmp53.21, float %sub55.21, float %partial_sum.0.lcssa.21
  %conv56.21 = fptoui float %cond.21 to i8
  %conv57.21 = uitofp i8 %conv56.21 to float
  %165 = add nsw i64 %indvars.iv.next21.20, %5
  %arrayidx61.21 = getelementptr inbounds float, float* %., i64 %165
  store float %conv57.21, float* %arrayidx61.21, align 4
  br label %for.inc68.21

if.else62.21:                                     ; preds = %for.end50.21
  %166 = add nsw i64 %indvars.iv.next21.20, %4
  %arrayidx66.21 = getelementptr inbounds float, float* %., i64 %166
  store float %partial_sum.0.lcssa.21, float* %arrayidx66.21, align 4
  br label %for.inc68.21

for.inc68.21:                                     ; preds = %if.else62.21, %if.then52.21
  %inc69.21 = add nsw i32 %in_j.011, 22
  %indvars.iv.next21.21 = add nsw i64 %indvars.iv20, 22
  br i1 %cmp134, label %for.end50.22, label %for.body15.22.preheader

for.body15.22.preheader:                          ; preds = %for.inc68.21
  br label %for.body15.22

for.body15.22:                                    ; preds = %for.body15.22.preheader, %for.inc48.22
  %ki.06.22 = phi i32 [ %inc49.22, %for.inc48.22 ], [ 0, %for.body15.22.preheader ]
  %partial_sum.05.22 = phi float [ %partial_sum.3.22, %for.inc48.22 ], [ 0.000000e+00, %for.body15.22.preheader ]
  %add.22 = add nsw i32 %ki.06.22, %in_i.015
  %notlhs.22 = icmp slt i32 %add.22, 0
  %notrhs.22 = icmp uge i32 %add.22, %img_height
  %.not.22 = or i1 %notrhs.22, %notlhs.22
  %brmerge.22 = or i1 %.not.22, %cmp241.not.22
  br i1 %brmerge.22, label %for.inc48.22, label %for.body26.lr.ph.22

for.body26.lr.ph.22:                              ; preds = %for.body15.22
  %mul.22 = shl i32 %add.22, 7
  %mul42.22 = mul i32 %ki.06.22, %kern_width
  br label %for.body26.22

for.body26.22:                                    ; preds = %for.inc.22, %for.body26.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body26.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc.22 ]
  %partial_sum.12.22 = phi float [ %partial_sum.05.22, %for.body26.lr.ph.22 ], [ %partial_sum.2.22, %for.inc.22 ]
  %167 = trunc i64 %indvars.iv.22 to i32
  %add27.22 = add nsw i32 %167, %inc69.21
  %cmp28.22 = icmp sgt i32 %add27.22, -1
  %cmp32.22 = icmp ult i32 %add27.22, %img_width
  %168 = and i1 %cmp28.22, %cmp32.22
  br i1 %168, label %if.end38.22, label %for.inc.22

if.end38.22:                                      ; preds = %for.body26.22
  %add41.22 = add nsw i32 %add27.22, %mul.22
  %idxprom.22 = sext i32 %add41.22 to i64
  %arrayidx.22 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.22
  %169 = load float, float* %arrayidx.22, align 4
  %170 = trunc i64 %indvars.iv.22 to i32
  %add43.22 = add i32 %170, %mul42.22
  %idxprom44.22 = zext i32 %add43.22 to i64
  %arrayidx45.22 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.22
  %171 = load float, float* %arrayidx45.22, align 4
  %mul46.22 = fmul float %169, %171
  %add47.22 = fadd float %partial_sum.12.22, %mul46.22
  br label %for.inc.22

for.inc.22:                                       ; preds = %if.end38.22, %for.body26.22
  %partial_sum.2.22 = phi float [ %add47.22, %if.end38.22 ], [ %partial_sum.12.22, %for.body26.22 ]
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %kern_width
  br i1 %exitcond.22, label %for.inc48.22.loopexit, label %for.body26.22, !llvm.loop !1

for.inc48.22.loopexit:                            ; preds = %for.inc.22
  %partial_sum.2.22.lcssa = phi float [ %partial_sum.2.22, %for.inc.22 ]
  br label %for.inc48.22

for.inc48.22:                                     ; preds = %for.inc48.22.loopexit, %for.body15.22
  %partial_sum.3.22 = phi float [ %partial_sum.05.22, %for.body15.22 ], [ %partial_sum.2.22.lcssa, %for.inc48.22.loopexit ]
  %inc49.22 = add nuw nsw i32 %ki.06.22, 1
  %exitcond19.22 = icmp eq i32 %inc49.22, %kern_height
  br i1 %exitcond19.22, label %for.end50.22.loopexit, label %for.body15.22, !llvm.loop !3

for.end50.22.loopexit:                            ; preds = %for.inc48.22
  %partial_sum.3.22.lcssa = phi float [ %partial_sum.3.22, %for.inc48.22 ]
  br label %for.end50.22

for.end50.22:                                     ; preds = %for.end50.22.loopexit, %for.inc68.21
  %partial_sum.0.lcssa.22 = phi float [ 0.000000e+00, %for.inc68.21 ], [ %partial_sum.3.22.lcssa, %for.end50.22.loopexit ]
  br i1 %tobool51, label %if.else62.22, label %if.then52.22

if.then52.22:                                     ; preds = %for.end50.22
  %cmp53.22 = fcmp olt float %partial_sum.0.lcssa.22, 0.000000e+00
  %sub55.22 = fsub float -0.000000e+00, %partial_sum.0.lcssa.22
  %cond.22 = select i1 %cmp53.22, float %sub55.22, float %partial_sum.0.lcssa.22
  %conv56.22 = fptoui float %cond.22 to i8
  %conv57.22 = uitofp i8 %conv56.22 to float
  %172 = add nsw i64 %indvars.iv.next21.21, %5
  %arrayidx61.22 = getelementptr inbounds float, float* %., i64 %172
  store float %conv57.22, float* %arrayidx61.22, align 4
  br label %for.inc68.22

if.else62.22:                                     ; preds = %for.end50.22
  %173 = add nsw i64 %indvars.iv.next21.21, %4
  %arrayidx66.22 = getelementptr inbounds float, float* %., i64 %173
  store float %partial_sum.0.lcssa.22, float* %arrayidx66.22, align 4
  br label %for.inc68.22

for.inc68.22:                                     ; preds = %if.else62.22, %if.then52.22
  %inc69.22 = add nsw i32 %in_j.011, 23
  %indvars.iv.next21.22 = add nsw i64 %indvars.iv20, 23
  br i1 %cmp134, label %for.end50.23, label %for.body15.23.preheader

for.body15.23.preheader:                          ; preds = %for.inc68.22
  br label %for.body15.23

for.body15.23:                                    ; preds = %for.body15.23.preheader, %for.inc48.23
  %ki.06.23 = phi i32 [ %inc49.23, %for.inc48.23 ], [ 0, %for.body15.23.preheader ]
  %partial_sum.05.23 = phi float [ %partial_sum.3.23, %for.inc48.23 ], [ 0.000000e+00, %for.body15.23.preheader ]
  %add.23 = add nsw i32 %ki.06.23, %in_i.015
  %notlhs.23 = icmp slt i32 %add.23, 0
  %notrhs.23 = icmp uge i32 %add.23, %img_height
  %.not.23 = or i1 %notrhs.23, %notlhs.23
  %brmerge.23 = or i1 %.not.23, %cmp241.not.23
  br i1 %brmerge.23, label %for.inc48.23, label %for.body26.lr.ph.23

for.body26.lr.ph.23:                              ; preds = %for.body15.23
  %mul.23 = shl i32 %add.23, 7
  %mul42.23 = mul i32 %ki.06.23, %kern_width
  br label %for.body26.23

for.body26.23:                                    ; preds = %for.inc.23, %for.body26.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body26.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc.23 ]
  %partial_sum.12.23 = phi float [ %partial_sum.05.23, %for.body26.lr.ph.23 ], [ %partial_sum.2.23, %for.inc.23 ]
  %174 = trunc i64 %indvars.iv.23 to i32
  %add27.23 = add nsw i32 %174, %inc69.22
  %cmp28.23 = icmp sgt i32 %add27.23, -1
  %cmp32.23 = icmp ult i32 %add27.23, %img_width
  %175 = and i1 %cmp28.23, %cmp32.23
  br i1 %175, label %if.end38.23, label %for.inc.23

if.end38.23:                                      ; preds = %for.body26.23
  %add41.23 = add nsw i32 %add27.23, %mul.23
  %idxprom.23 = sext i32 %add41.23 to i64
  %arrayidx.23 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.23
  %176 = load float, float* %arrayidx.23, align 4
  %177 = trunc i64 %indvars.iv.23 to i32
  %add43.23 = add i32 %177, %mul42.23
  %idxprom44.23 = zext i32 %add43.23 to i64
  %arrayidx45.23 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.23
  %178 = load float, float* %arrayidx45.23, align 4
  %mul46.23 = fmul float %176, %178
  %add47.23 = fadd float %partial_sum.12.23, %mul46.23
  br label %for.inc.23

for.inc.23:                                       ; preds = %if.end38.23, %for.body26.23
  %partial_sum.2.23 = phi float [ %add47.23, %if.end38.23 ], [ %partial_sum.12.23, %for.body26.23 ]
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %kern_width
  br i1 %exitcond.23, label %for.inc48.23.loopexit, label %for.body26.23, !llvm.loop !1

for.inc48.23.loopexit:                            ; preds = %for.inc.23
  %partial_sum.2.23.lcssa = phi float [ %partial_sum.2.23, %for.inc.23 ]
  br label %for.inc48.23

for.inc48.23:                                     ; preds = %for.inc48.23.loopexit, %for.body15.23
  %partial_sum.3.23 = phi float [ %partial_sum.05.23, %for.body15.23 ], [ %partial_sum.2.23.lcssa, %for.inc48.23.loopexit ]
  %inc49.23 = add nuw nsw i32 %ki.06.23, 1
  %exitcond19.23 = icmp eq i32 %inc49.23, %kern_height
  br i1 %exitcond19.23, label %for.end50.23.loopexit, label %for.body15.23, !llvm.loop !3

for.end50.23.loopexit:                            ; preds = %for.inc48.23
  %partial_sum.3.23.lcssa = phi float [ %partial_sum.3.23, %for.inc48.23 ]
  br label %for.end50.23

for.end50.23:                                     ; preds = %for.end50.23.loopexit, %for.inc68.22
  %partial_sum.0.lcssa.23 = phi float [ 0.000000e+00, %for.inc68.22 ], [ %partial_sum.3.23.lcssa, %for.end50.23.loopexit ]
  br i1 %tobool51, label %if.else62.23, label %if.then52.23

if.then52.23:                                     ; preds = %for.end50.23
  %cmp53.23 = fcmp olt float %partial_sum.0.lcssa.23, 0.000000e+00
  %sub55.23 = fsub float -0.000000e+00, %partial_sum.0.lcssa.23
  %cond.23 = select i1 %cmp53.23, float %sub55.23, float %partial_sum.0.lcssa.23
  %conv56.23 = fptoui float %cond.23 to i8
  %conv57.23 = uitofp i8 %conv56.23 to float
  %179 = add nsw i64 %indvars.iv.next21.22, %5
  %arrayidx61.23 = getelementptr inbounds float, float* %., i64 %179
  store float %conv57.23, float* %arrayidx61.23, align 4
  br label %for.inc68.23

if.else62.23:                                     ; preds = %for.end50.23
  %180 = add nsw i64 %indvars.iv.next21.22, %4
  %arrayidx66.23 = getelementptr inbounds float, float* %., i64 %180
  store float %partial_sum.0.lcssa.23, float* %arrayidx66.23, align 4
  br label %for.inc68.23

for.inc68.23:                                     ; preds = %if.else62.23, %if.then52.23
  %inc69.23 = add nsw i32 %in_j.011, 24
  %indvars.iv.next21.23 = add nsw i64 %indvars.iv20, 24
  br i1 %cmp134, label %for.end50.24, label %for.body15.24.preheader

for.body15.24.preheader:                          ; preds = %for.inc68.23
  br label %for.body15.24

for.body15.24:                                    ; preds = %for.body15.24.preheader, %for.inc48.24
  %ki.06.24 = phi i32 [ %inc49.24, %for.inc48.24 ], [ 0, %for.body15.24.preheader ]
  %partial_sum.05.24 = phi float [ %partial_sum.3.24, %for.inc48.24 ], [ 0.000000e+00, %for.body15.24.preheader ]
  %add.24 = add nsw i32 %ki.06.24, %in_i.015
  %notlhs.24 = icmp slt i32 %add.24, 0
  %notrhs.24 = icmp uge i32 %add.24, %img_height
  %.not.24 = or i1 %notrhs.24, %notlhs.24
  %brmerge.24 = or i1 %.not.24, %cmp241.not.24
  br i1 %brmerge.24, label %for.inc48.24, label %for.body26.lr.ph.24

for.body26.lr.ph.24:                              ; preds = %for.body15.24
  %mul.24 = shl i32 %add.24, 7
  %mul42.24 = mul i32 %ki.06.24, %kern_width
  br label %for.body26.24

for.body26.24:                                    ; preds = %for.inc.24, %for.body26.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body26.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc.24 ]
  %partial_sum.12.24 = phi float [ %partial_sum.05.24, %for.body26.lr.ph.24 ], [ %partial_sum.2.24, %for.inc.24 ]
  %181 = trunc i64 %indvars.iv.24 to i32
  %add27.24 = add nsw i32 %181, %inc69.23
  %cmp28.24 = icmp sgt i32 %add27.24, -1
  %cmp32.24 = icmp ult i32 %add27.24, %img_width
  %182 = and i1 %cmp28.24, %cmp32.24
  br i1 %182, label %if.end38.24, label %for.inc.24

if.end38.24:                                      ; preds = %for.body26.24
  %add41.24 = add nsw i32 %add27.24, %mul.24
  %idxprom.24 = sext i32 %add41.24 to i64
  %arrayidx.24 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.24
  %183 = load float, float* %arrayidx.24, align 4
  %184 = trunc i64 %indvars.iv.24 to i32
  %add43.24 = add i32 %184, %mul42.24
  %idxprom44.24 = zext i32 %add43.24 to i64
  %arrayidx45.24 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.24
  %185 = load float, float* %arrayidx45.24, align 4
  %mul46.24 = fmul float %183, %185
  %add47.24 = fadd float %partial_sum.12.24, %mul46.24
  br label %for.inc.24

for.inc.24:                                       ; preds = %if.end38.24, %for.body26.24
  %partial_sum.2.24 = phi float [ %add47.24, %if.end38.24 ], [ %partial_sum.12.24, %for.body26.24 ]
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %kern_width
  br i1 %exitcond.24, label %for.inc48.24.loopexit, label %for.body26.24, !llvm.loop !1

for.inc48.24.loopexit:                            ; preds = %for.inc.24
  %partial_sum.2.24.lcssa = phi float [ %partial_sum.2.24, %for.inc.24 ]
  br label %for.inc48.24

for.inc48.24:                                     ; preds = %for.inc48.24.loopexit, %for.body15.24
  %partial_sum.3.24 = phi float [ %partial_sum.05.24, %for.body15.24 ], [ %partial_sum.2.24.lcssa, %for.inc48.24.loopexit ]
  %inc49.24 = add nuw nsw i32 %ki.06.24, 1
  %exitcond19.24 = icmp eq i32 %inc49.24, %kern_height
  br i1 %exitcond19.24, label %for.end50.24.loopexit, label %for.body15.24, !llvm.loop !3

for.end50.24.loopexit:                            ; preds = %for.inc48.24
  %partial_sum.3.24.lcssa = phi float [ %partial_sum.3.24, %for.inc48.24 ]
  br label %for.end50.24

for.end50.24:                                     ; preds = %for.end50.24.loopexit, %for.inc68.23
  %partial_sum.0.lcssa.24 = phi float [ 0.000000e+00, %for.inc68.23 ], [ %partial_sum.3.24.lcssa, %for.end50.24.loopexit ]
  br i1 %tobool51, label %if.else62.24, label %if.then52.24

if.then52.24:                                     ; preds = %for.end50.24
  %cmp53.24 = fcmp olt float %partial_sum.0.lcssa.24, 0.000000e+00
  %sub55.24 = fsub float -0.000000e+00, %partial_sum.0.lcssa.24
  %cond.24 = select i1 %cmp53.24, float %sub55.24, float %partial_sum.0.lcssa.24
  %conv56.24 = fptoui float %cond.24 to i8
  %conv57.24 = uitofp i8 %conv56.24 to float
  %186 = add nsw i64 %indvars.iv.next21.23, %5
  %arrayidx61.24 = getelementptr inbounds float, float* %., i64 %186
  store float %conv57.24, float* %arrayidx61.24, align 4
  br label %for.inc68.24

if.else62.24:                                     ; preds = %for.end50.24
  %187 = add nsw i64 %indvars.iv.next21.23, %4
  %arrayidx66.24 = getelementptr inbounds float, float* %., i64 %187
  store float %partial_sum.0.lcssa.24, float* %arrayidx66.24, align 4
  br label %for.inc68.24

for.inc68.24:                                     ; preds = %if.else62.24, %if.then52.24
  %inc69.24 = add nsw i32 %in_j.011, 25
  %indvars.iv.next21.24 = add nsw i64 %indvars.iv20, 25
  br i1 %cmp134, label %for.end50.25, label %for.body15.25.preheader

for.body15.25.preheader:                          ; preds = %for.inc68.24
  br label %for.body15.25

for.body15.25:                                    ; preds = %for.body15.25.preheader, %for.inc48.25
  %ki.06.25 = phi i32 [ %inc49.25, %for.inc48.25 ], [ 0, %for.body15.25.preheader ]
  %partial_sum.05.25 = phi float [ %partial_sum.3.25, %for.inc48.25 ], [ 0.000000e+00, %for.body15.25.preheader ]
  %add.25 = add nsw i32 %ki.06.25, %in_i.015
  %notlhs.25 = icmp slt i32 %add.25, 0
  %notrhs.25 = icmp uge i32 %add.25, %img_height
  %.not.25 = or i1 %notrhs.25, %notlhs.25
  %brmerge.25 = or i1 %.not.25, %cmp241.not.25
  br i1 %brmerge.25, label %for.inc48.25, label %for.body26.lr.ph.25

for.body26.lr.ph.25:                              ; preds = %for.body15.25
  %mul.25 = shl i32 %add.25, 7
  %mul42.25 = mul i32 %ki.06.25, %kern_width
  br label %for.body26.25

for.body26.25:                                    ; preds = %for.inc.25, %for.body26.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body26.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc.25 ]
  %partial_sum.12.25 = phi float [ %partial_sum.05.25, %for.body26.lr.ph.25 ], [ %partial_sum.2.25, %for.inc.25 ]
  %188 = trunc i64 %indvars.iv.25 to i32
  %add27.25 = add nsw i32 %188, %inc69.24
  %cmp28.25 = icmp sgt i32 %add27.25, -1
  %cmp32.25 = icmp ult i32 %add27.25, %img_width
  %189 = and i1 %cmp28.25, %cmp32.25
  br i1 %189, label %if.end38.25, label %for.inc.25

if.end38.25:                                      ; preds = %for.body26.25
  %add41.25 = add nsw i32 %add27.25, %mul.25
  %idxprom.25 = sext i32 %add41.25 to i64
  %arrayidx.25 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.25
  %190 = load float, float* %arrayidx.25, align 4
  %191 = trunc i64 %indvars.iv.25 to i32
  %add43.25 = add i32 %191, %mul42.25
  %idxprom44.25 = zext i32 %add43.25 to i64
  %arrayidx45.25 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.25
  %192 = load float, float* %arrayidx45.25, align 4
  %mul46.25 = fmul float %190, %192
  %add47.25 = fadd float %partial_sum.12.25, %mul46.25
  br label %for.inc.25

for.inc.25:                                       ; preds = %if.end38.25, %for.body26.25
  %partial_sum.2.25 = phi float [ %add47.25, %if.end38.25 ], [ %partial_sum.12.25, %for.body26.25 ]
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %kern_width
  br i1 %exitcond.25, label %for.inc48.25.loopexit, label %for.body26.25, !llvm.loop !1

for.inc48.25.loopexit:                            ; preds = %for.inc.25
  %partial_sum.2.25.lcssa = phi float [ %partial_sum.2.25, %for.inc.25 ]
  br label %for.inc48.25

for.inc48.25:                                     ; preds = %for.inc48.25.loopexit, %for.body15.25
  %partial_sum.3.25 = phi float [ %partial_sum.05.25, %for.body15.25 ], [ %partial_sum.2.25.lcssa, %for.inc48.25.loopexit ]
  %inc49.25 = add nuw nsw i32 %ki.06.25, 1
  %exitcond19.25 = icmp eq i32 %inc49.25, %kern_height
  br i1 %exitcond19.25, label %for.end50.25.loopexit, label %for.body15.25, !llvm.loop !3

for.end50.25.loopexit:                            ; preds = %for.inc48.25
  %partial_sum.3.25.lcssa = phi float [ %partial_sum.3.25, %for.inc48.25 ]
  br label %for.end50.25

for.end50.25:                                     ; preds = %for.end50.25.loopexit, %for.inc68.24
  %partial_sum.0.lcssa.25 = phi float [ 0.000000e+00, %for.inc68.24 ], [ %partial_sum.3.25.lcssa, %for.end50.25.loopexit ]
  br i1 %tobool51, label %if.else62.25, label %if.then52.25

if.then52.25:                                     ; preds = %for.end50.25
  %cmp53.25 = fcmp olt float %partial_sum.0.lcssa.25, 0.000000e+00
  %sub55.25 = fsub float -0.000000e+00, %partial_sum.0.lcssa.25
  %cond.25 = select i1 %cmp53.25, float %sub55.25, float %partial_sum.0.lcssa.25
  %conv56.25 = fptoui float %cond.25 to i8
  %conv57.25 = uitofp i8 %conv56.25 to float
  %193 = add nsw i64 %indvars.iv.next21.24, %5
  %arrayidx61.25 = getelementptr inbounds float, float* %., i64 %193
  store float %conv57.25, float* %arrayidx61.25, align 4
  br label %for.inc68.25

if.else62.25:                                     ; preds = %for.end50.25
  %194 = add nsw i64 %indvars.iv.next21.24, %4
  %arrayidx66.25 = getelementptr inbounds float, float* %., i64 %194
  store float %partial_sum.0.lcssa.25, float* %arrayidx66.25, align 4
  br label %for.inc68.25

for.inc68.25:                                     ; preds = %if.else62.25, %if.then52.25
  %inc69.25 = add nsw i32 %in_j.011, 26
  %indvars.iv.next21.25 = add nsw i64 %indvars.iv20, 26
  br i1 %cmp134, label %for.end50.26, label %for.body15.26.preheader

for.body15.26.preheader:                          ; preds = %for.inc68.25
  br label %for.body15.26

for.body15.26:                                    ; preds = %for.body15.26.preheader, %for.inc48.26
  %ki.06.26 = phi i32 [ %inc49.26, %for.inc48.26 ], [ 0, %for.body15.26.preheader ]
  %partial_sum.05.26 = phi float [ %partial_sum.3.26, %for.inc48.26 ], [ 0.000000e+00, %for.body15.26.preheader ]
  %add.26 = add nsw i32 %ki.06.26, %in_i.015
  %notlhs.26 = icmp slt i32 %add.26, 0
  %notrhs.26 = icmp uge i32 %add.26, %img_height
  %.not.26 = or i1 %notrhs.26, %notlhs.26
  %brmerge.26 = or i1 %.not.26, %cmp241.not.26
  br i1 %brmerge.26, label %for.inc48.26, label %for.body26.lr.ph.26

for.body26.lr.ph.26:                              ; preds = %for.body15.26
  %mul.26 = shl i32 %add.26, 7
  %mul42.26 = mul i32 %ki.06.26, %kern_width
  br label %for.body26.26

for.body26.26:                                    ; preds = %for.inc.26, %for.body26.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body26.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc.26 ]
  %partial_sum.12.26 = phi float [ %partial_sum.05.26, %for.body26.lr.ph.26 ], [ %partial_sum.2.26, %for.inc.26 ]
  %195 = trunc i64 %indvars.iv.26 to i32
  %add27.26 = add nsw i32 %195, %inc69.25
  %cmp28.26 = icmp sgt i32 %add27.26, -1
  %cmp32.26 = icmp ult i32 %add27.26, %img_width
  %196 = and i1 %cmp28.26, %cmp32.26
  br i1 %196, label %if.end38.26, label %for.inc.26

if.end38.26:                                      ; preds = %for.body26.26
  %add41.26 = add nsw i32 %add27.26, %mul.26
  %idxprom.26 = sext i32 %add41.26 to i64
  %arrayidx.26 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.26
  %197 = load float, float* %arrayidx.26, align 4
  %198 = trunc i64 %indvars.iv.26 to i32
  %add43.26 = add i32 %198, %mul42.26
  %idxprom44.26 = zext i32 %add43.26 to i64
  %arrayidx45.26 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.26
  %199 = load float, float* %arrayidx45.26, align 4
  %mul46.26 = fmul float %197, %199
  %add47.26 = fadd float %partial_sum.12.26, %mul46.26
  br label %for.inc.26

for.inc.26:                                       ; preds = %if.end38.26, %for.body26.26
  %partial_sum.2.26 = phi float [ %add47.26, %if.end38.26 ], [ %partial_sum.12.26, %for.body26.26 ]
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %kern_width
  br i1 %exitcond.26, label %for.inc48.26.loopexit, label %for.body26.26, !llvm.loop !1

for.inc48.26.loopexit:                            ; preds = %for.inc.26
  %partial_sum.2.26.lcssa = phi float [ %partial_sum.2.26, %for.inc.26 ]
  br label %for.inc48.26

for.inc48.26:                                     ; preds = %for.inc48.26.loopexit, %for.body15.26
  %partial_sum.3.26 = phi float [ %partial_sum.05.26, %for.body15.26 ], [ %partial_sum.2.26.lcssa, %for.inc48.26.loopexit ]
  %inc49.26 = add nuw nsw i32 %ki.06.26, 1
  %exitcond19.26 = icmp eq i32 %inc49.26, %kern_height
  br i1 %exitcond19.26, label %for.end50.26.loopexit, label %for.body15.26, !llvm.loop !3

for.end50.26.loopexit:                            ; preds = %for.inc48.26
  %partial_sum.3.26.lcssa = phi float [ %partial_sum.3.26, %for.inc48.26 ]
  br label %for.end50.26

for.end50.26:                                     ; preds = %for.end50.26.loopexit, %for.inc68.25
  %partial_sum.0.lcssa.26 = phi float [ 0.000000e+00, %for.inc68.25 ], [ %partial_sum.3.26.lcssa, %for.end50.26.loopexit ]
  br i1 %tobool51, label %if.else62.26, label %if.then52.26

if.then52.26:                                     ; preds = %for.end50.26
  %cmp53.26 = fcmp olt float %partial_sum.0.lcssa.26, 0.000000e+00
  %sub55.26 = fsub float -0.000000e+00, %partial_sum.0.lcssa.26
  %cond.26 = select i1 %cmp53.26, float %sub55.26, float %partial_sum.0.lcssa.26
  %conv56.26 = fptoui float %cond.26 to i8
  %conv57.26 = uitofp i8 %conv56.26 to float
  %200 = add nsw i64 %indvars.iv.next21.25, %5
  %arrayidx61.26 = getelementptr inbounds float, float* %., i64 %200
  store float %conv57.26, float* %arrayidx61.26, align 4
  br label %for.inc68.26

if.else62.26:                                     ; preds = %for.end50.26
  %201 = add nsw i64 %indvars.iv.next21.25, %4
  %arrayidx66.26 = getelementptr inbounds float, float* %., i64 %201
  store float %partial_sum.0.lcssa.26, float* %arrayidx66.26, align 4
  br label %for.inc68.26

for.inc68.26:                                     ; preds = %if.else62.26, %if.then52.26
  %inc69.26 = add nsw i32 %in_j.011, 27
  %indvars.iv.next21.26 = add nsw i64 %indvars.iv20, 27
  br i1 %cmp134, label %for.end50.27, label %for.body15.27.preheader

for.body15.27.preheader:                          ; preds = %for.inc68.26
  br label %for.body15.27

for.body15.27:                                    ; preds = %for.body15.27.preheader, %for.inc48.27
  %ki.06.27 = phi i32 [ %inc49.27, %for.inc48.27 ], [ 0, %for.body15.27.preheader ]
  %partial_sum.05.27 = phi float [ %partial_sum.3.27, %for.inc48.27 ], [ 0.000000e+00, %for.body15.27.preheader ]
  %add.27 = add nsw i32 %ki.06.27, %in_i.015
  %notlhs.27 = icmp slt i32 %add.27, 0
  %notrhs.27 = icmp uge i32 %add.27, %img_height
  %.not.27 = or i1 %notrhs.27, %notlhs.27
  %brmerge.27 = or i1 %.not.27, %cmp241.not.27
  br i1 %brmerge.27, label %for.inc48.27, label %for.body26.lr.ph.27

for.body26.lr.ph.27:                              ; preds = %for.body15.27
  %mul.27 = shl i32 %add.27, 7
  %mul42.27 = mul i32 %ki.06.27, %kern_width
  br label %for.body26.27

for.body26.27:                                    ; preds = %for.inc.27, %for.body26.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body26.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc.27 ]
  %partial_sum.12.27 = phi float [ %partial_sum.05.27, %for.body26.lr.ph.27 ], [ %partial_sum.2.27, %for.inc.27 ]
  %202 = trunc i64 %indvars.iv.27 to i32
  %add27.27 = add nsw i32 %202, %inc69.26
  %cmp28.27 = icmp sgt i32 %add27.27, -1
  %cmp32.27 = icmp ult i32 %add27.27, %img_width
  %203 = and i1 %cmp28.27, %cmp32.27
  br i1 %203, label %if.end38.27, label %for.inc.27

if.end38.27:                                      ; preds = %for.body26.27
  %add41.27 = add nsw i32 %add27.27, %mul.27
  %idxprom.27 = sext i32 %add41.27 to i64
  %arrayidx.27 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.27
  %204 = load float, float* %arrayidx.27, align 4
  %205 = trunc i64 %indvars.iv.27 to i32
  %add43.27 = add i32 %205, %mul42.27
  %idxprom44.27 = zext i32 %add43.27 to i64
  %arrayidx45.27 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.27
  %206 = load float, float* %arrayidx45.27, align 4
  %mul46.27 = fmul float %204, %206
  %add47.27 = fadd float %partial_sum.12.27, %mul46.27
  br label %for.inc.27

for.inc.27:                                       ; preds = %if.end38.27, %for.body26.27
  %partial_sum.2.27 = phi float [ %add47.27, %if.end38.27 ], [ %partial_sum.12.27, %for.body26.27 ]
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %kern_width
  br i1 %exitcond.27, label %for.inc48.27.loopexit, label %for.body26.27, !llvm.loop !1

for.inc48.27.loopexit:                            ; preds = %for.inc.27
  %partial_sum.2.27.lcssa = phi float [ %partial_sum.2.27, %for.inc.27 ]
  br label %for.inc48.27

for.inc48.27:                                     ; preds = %for.inc48.27.loopexit, %for.body15.27
  %partial_sum.3.27 = phi float [ %partial_sum.05.27, %for.body15.27 ], [ %partial_sum.2.27.lcssa, %for.inc48.27.loopexit ]
  %inc49.27 = add nuw nsw i32 %ki.06.27, 1
  %exitcond19.27 = icmp eq i32 %inc49.27, %kern_height
  br i1 %exitcond19.27, label %for.end50.27.loopexit, label %for.body15.27, !llvm.loop !3

for.end50.27.loopexit:                            ; preds = %for.inc48.27
  %partial_sum.3.27.lcssa = phi float [ %partial_sum.3.27, %for.inc48.27 ]
  br label %for.end50.27

for.end50.27:                                     ; preds = %for.end50.27.loopexit, %for.inc68.26
  %partial_sum.0.lcssa.27 = phi float [ 0.000000e+00, %for.inc68.26 ], [ %partial_sum.3.27.lcssa, %for.end50.27.loopexit ]
  br i1 %tobool51, label %if.else62.27, label %if.then52.27

if.then52.27:                                     ; preds = %for.end50.27
  %cmp53.27 = fcmp olt float %partial_sum.0.lcssa.27, 0.000000e+00
  %sub55.27 = fsub float -0.000000e+00, %partial_sum.0.lcssa.27
  %cond.27 = select i1 %cmp53.27, float %sub55.27, float %partial_sum.0.lcssa.27
  %conv56.27 = fptoui float %cond.27 to i8
  %conv57.27 = uitofp i8 %conv56.27 to float
  %207 = add nsw i64 %indvars.iv.next21.26, %5
  %arrayidx61.27 = getelementptr inbounds float, float* %., i64 %207
  store float %conv57.27, float* %arrayidx61.27, align 4
  br label %for.inc68.27

if.else62.27:                                     ; preds = %for.end50.27
  %208 = add nsw i64 %indvars.iv.next21.26, %4
  %arrayidx66.27 = getelementptr inbounds float, float* %., i64 %208
  store float %partial_sum.0.lcssa.27, float* %arrayidx66.27, align 4
  br label %for.inc68.27

for.inc68.27:                                     ; preds = %if.else62.27, %if.then52.27
  %inc69.27 = add nsw i32 %in_j.011, 28
  %indvars.iv.next21.27 = add nsw i64 %indvars.iv20, 28
  br i1 %cmp134, label %for.end50.28, label %for.body15.28.preheader

for.body15.28.preheader:                          ; preds = %for.inc68.27
  br label %for.body15.28

for.body15.28:                                    ; preds = %for.body15.28.preheader, %for.inc48.28
  %ki.06.28 = phi i32 [ %inc49.28, %for.inc48.28 ], [ 0, %for.body15.28.preheader ]
  %partial_sum.05.28 = phi float [ %partial_sum.3.28, %for.inc48.28 ], [ 0.000000e+00, %for.body15.28.preheader ]
  %add.28 = add nsw i32 %ki.06.28, %in_i.015
  %notlhs.28 = icmp slt i32 %add.28, 0
  %notrhs.28 = icmp uge i32 %add.28, %img_height
  %.not.28 = or i1 %notrhs.28, %notlhs.28
  %brmerge.28 = or i1 %.not.28, %cmp241.not.28
  br i1 %brmerge.28, label %for.inc48.28, label %for.body26.lr.ph.28

for.body26.lr.ph.28:                              ; preds = %for.body15.28
  %mul.28 = shl i32 %add.28, 7
  %mul42.28 = mul i32 %ki.06.28, %kern_width
  br label %for.body26.28

for.body26.28:                                    ; preds = %for.inc.28, %for.body26.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body26.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc.28 ]
  %partial_sum.12.28 = phi float [ %partial_sum.05.28, %for.body26.lr.ph.28 ], [ %partial_sum.2.28, %for.inc.28 ]
  %209 = trunc i64 %indvars.iv.28 to i32
  %add27.28 = add nsw i32 %209, %inc69.27
  %cmp28.28 = icmp sgt i32 %add27.28, -1
  %cmp32.28 = icmp ult i32 %add27.28, %img_width
  %210 = and i1 %cmp28.28, %cmp32.28
  br i1 %210, label %if.end38.28, label %for.inc.28

if.end38.28:                                      ; preds = %for.body26.28
  %add41.28 = add nsw i32 %add27.28, %mul.28
  %idxprom.28 = sext i32 %add41.28 to i64
  %arrayidx.28 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.28
  %211 = load float, float* %arrayidx.28, align 4
  %212 = trunc i64 %indvars.iv.28 to i32
  %add43.28 = add i32 %212, %mul42.28
  %idxprom44.28 = zext i32 %add43.28 to i64
  %arrayidx45.28 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.28
  %213 = load float, float* %arrayidx45.28, align 4
  %mul46.28 = fmul float %211, %213
  %add47.28 = fadd float %partial_sum.12.28, %mul46.28
  br label %for.inc.28

for.inc.28:                                       ; preds = %if.end38.28, %for.body26.28
  %partial_sum.2.28 = phi float [ %add47.28, %if.end38.28 ], [ %partial_sum.12.28, %for.body26.28 ]
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %kern_width
  br i1 %exitcond.28, label %for.inc48.28.loopexit, label %for.body26.28, !llvm.loop !1

for.inc48.28.loopexit:                            ; preds = %for.inc.28
  %partial_sum.2.28.lcssa = phi float [ %partial_sum.2.28, %for.inc.28 ]
  br label %for.inc48.28

for.inc48.28:                                     ; preds = %for.inc48.28.loopexit, %for.body15.28
  %partial_sum.3.28 = phi float [ %partial_sum.05.28, %for.body15.28 ], [ %partial_sum.2.28.lcssa, %for.inc48.28.loopexit ]
  %inc49.28 = add nuw nsw i32 %ki.06.28, 1
  %exitcond19.28 = icmp eq i32 %inc49.28, %kern_height
  br i1 %exitcond19.28, label %for.end50.28.loopexit, label %for.body15.28, !llvm.loop !3

for.end50.28.loopexit:                            ; preds = %for.inc48.28
  %partial_sum.3.28.lcssa = phi float [ %partial_sum.3.28, %for.inc48.28 ]
  br label %for.end50.28

for.end50.28:                                     ; preds = %for.end50.28.loopexit, %for.inc68.27
  %partial_sum.0.lcssa.28 = phi float [ 0.000000e+00, %for.inc68.27 ], [ %partial_sum.3.28.lcssa, %for.end50.28.loopexit ]
  br i1 %tobool51, label %if.else62.28, label %if.then52.28

if.then52.28:                                     ; preds = %for.end50.28
  %cmp53.28 = fcmp olt float %partial_sum.0.lcssa.28, 0.000000e+00
  %sub55.28 = fsub float -0.000000e+00, %partial_sum.0.lcssa.28
  %cond.28 = select i1 %cmp53.28, float %sub55.28, float %partial_sum.0.lcssa.28
  %conv56.28 = fptoui float %cond.28 to i8
  %conv57.28 = uitofp i8 %conv56.28 to float
  %214 = add nsw i64 %indvars.iv.next21.27, %5
  %arrayidx61.28 = getelementptr inbounds float, float* %., i64 %214
  store float %conv57.28, float* %arrayidx61.28, align 4
  br label %for.inc68.28

if.else62.28:                                     ; preds = %for.end50.28
  %215 = add nsw i64 %indvars.iv.next21.27, %4
  %arrayidx66.28 = getelementptr inbounds float, float* %., i64 %215
  store float %partial_sum.0.lcssa.28, float* %arrayidx66.28, align 4
  br label %for.inc68.28

for.inc68.28:                                     ; preds = %if.else62.28, %if.then52.28
  %inc69.28 = add nsw i32 %in_j.011, 29
  %indvars.iv.next21.28 = add nsw i64 %indvars.iv20, 29
  br i1 %cmp134, label %for.end50.29, label %for.body15.29.preheader

for.body15.29.preheader:                          ; preds = %for.inc68.28
  br label %for.body15.29

for.body15.29:                                    ; preds = %for.body15.29.preheader, %for.inc48.29
  %ki.06.29 = phi i32 [ %inc49.29, %for.inc48.29 ], [ 0, %for.body15.29.preheader ]
  %partial_sum.05.29 = phi float [ %partial_sum.3.29, %for.inc48.29 ], [ 0.000000e+00, %for.body15.29.preheader ]
  %add.29 = add nsw i32 %ki.06.29, %in_i.015
  %notlhs.29 = icmp slt i32 %add.29, 0
  %notrhs.29 = icmp uge i32 %add.29, %img_height
  %.not.29 = or i1 %notrhs.29, %notlhs.29
  %brmerge.29 = or i1 %.not.29, %cmp241.not.29
  br i1 %brmerge.29, label %for.inc48.29, label %for.body26.lr.ph.29

for.body26.lr.ph.29:                              ; preds = %for.body15.29
  %mul.29 = shl i32 %add.29, 7
  %mul42.29 = mul i32 %ki.06.29, %kern_width
  br label %for.body26.29

for.body26.29:                                    ; preds = %for.inc.29, %for.body26.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body26.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc.29 ]
  %partial_sum.12.29 = phi float [ %partial_sum.05.29, %for.body26.lr.ph.29 ], [ %partial_sum.2.29, %for.inc.29 ]
  %216 = trunc i64 %indvars.iv.29 to i32
  %add27.29 = add nsw i32 %216, %inc69.28
  %cmp28.29 = icmp sgt i32 %add27.29, -1
  %cmp32.29 = icmp ult i32 %add27.29, %img_width
  %217 = and i1 %cmp28.29, %cmp32.29
  br i1 %217, label %if.end38.29, label %for.inc.29

if.end38.29:                                      ; preds = %for.body26.29
  %add41.29 = add nsw i32 %add27.29, %mul.29
  %idxprom.29 = sext i32 %add41.29 to i64
  %arrayidx.29 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.29
  %218 = load float, float* %arrayidx.29, align 4
  %219 = trunc i64 %indvars.iv.29 to i32
  %add43.29 = add i32 %219, %mul42.29
  %idxprom44.29 = zext i32 %add43.29 to i64
  %arrayidx45.29 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.29
  %220 = load float, float* %arrayidx45.29, align 4
  %mul46.29 = fmul float %218, %220
  %add47.29 = fadd float %partial_sum.12.29, %mul46.29
  br label %for.inc.29

for.inc.29:                                       ; preds = %if.end38.29, %for.body26.29
  %partial_sum.2.29 = phi float [ %add47.29, %if.end38.29 ], [ %partial_sum.12.29, %for.body26.29 ]
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %kern_width
  br i1 %exitcond.29, label %for.inc48.29.loopexit, label %for.body26.29, !llvm.loop !1

for.inc48.29.loopexit:                            ; preds = %for.inc.29
  %partial_sum.2.29.lcssa = phi float [ %partial_sum.2.29, %for.inc.29 ]
  br label %for.inc48.29

for.inc48.29:                                     ; preds = %for.inc48.29.loopexit, %for.body15.29
  %partial_sum.3.29 = phi float [ %partial_sum.05.29, %for.body15.29 ], [ %partial_sum.2.29.lcssa, %for.inc48.29.loopexit ]
  %inc49.29 = add nuw nsw i32 %ki.06.29, 1
  %exitcond19.29 = icmp eq i32 %inc49.29, %kern_height
  br i1 %exitcond19.29, label %for.end50.29.loopexit, label %for.body15.29, !llvm.loop !3

for.end50.29.loopexit:                            ; preds = %for.inc48.29
  %partial_sum.3.29.lcssa = phi float [ %partial_sum.3.29, %for.inc48.29 ]
  br label %for.end50.29

for.end50.29:                                     ; preds = %for.end50.29.loopexit, %for.inc68.28
  %partial_sum.0.lcssa.29 = phi float [ 0.000000e+00, %for.inc68.28 ], [ %partial_sum.3.29.lcssa, %for.end50.29.loopexit ]
  br i1 %tobool51, label %if.else62.29, label %if.then52.29

if.then52.29:                                     ; preds = %for.end50.29
  %cmp53.29 = fcmp olt float %partial_sum.0.lcssa.29, 0.000000e+00
  %sub55.29 = fsub float -0.000000e+00, %partial_sum.0.lcssa.29
  %cond.29 = select i1 %cmp53.29, float %sub55.29, float %partial_sum.0.lcssa.29
  %conv56.29 = fptoui float %cond.29 to i8
  %conv57.29 = uitofp i8 %conv56.29 to float
  %221 = add nsw i64 %indvars.iv.next21.28, %5
  %arrayidx61.29 = getelementptr inbounds float, float* %., i64 %221
  store float %conv57.29, float* %arrayidx61.29, align 4
  br label %for.inc68.29

if.else62.29:                                     ; preds = %for.end50.29
  %222 = add nsw i64 %indvars.iv.next21.28, %4
  %arrayidx66.29 = getelementptr inbounds float, float* %., i64 %222
  store float %partial_sum.0.lcssa.29, float* %arrayidx66.29, align 4
  br label %for.inc68.29

for.inc68.29:                                     ; preds = %if.else62.29, %if.then52.29
  %inc69.29 = add nsw i32 %in_j.011, 30
  %indvars.iv.next21.29 = add nsw i64 %indvars.iv20, 30
  br i1 %cmp134, label %for.end50.30, label %for.body15.30.preheader

for.body15.30.preheader:                          ; preds = %for.inc68.29
  br label %for.body15.30

for.body15.30:                                    ; preds = %for.body15.30.preheader, %for.inc48.30
  %ki.06.30 = phi i32 [ %inc49.30, %for.inc48.30 ], [ 0, %for.body15.30.preheader ]
  %partial_sum.05.30 = phi float [ %partial_sum.3.30, %for.inc48.30 ], [ 0.000000e+00, %for.body15.30.preheader ]
  %add.30 = add nsw i32 %ki.06.30, %in_i.015
  %notlhs.30 = icmp slt i32 %add.30, 0
  %notrhs.30 = icmp uge i32 %add.30, %img_height
  %.not.30 = or i1 %notrhs.30, %notlhs.30
  %brmerge.30 = or i1 %.not.30, %cmp241.not.30
  br i1 %brmerge.30, label %for.inc48.30, label %for.body26.lr.ph.30

for.body26.lr.ph.30:                              ; preds = %for.body15.30
  %mul.30 = shl i32 %add.30, 7
  %mul42.30 = mul i32 %ki.06.30, %kern_width
  br label %for.body26.30

for.body26.30:                                    ; preds = %for.inc.30, %for.body26.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body26.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc.30 ]
  %partial_sum.12.30 = phi float [ %partial_sum.05.30, %for.body26.lr.ph.30 ], [ %partial_sum.2.30, %for.inc.30 ]
  %223 = trunc i64 %indvars.iv.30 to i32
  %add27.30 = add nsw i32 %223, %inc69.29
  %cmp28.30 = icmp sgt i32 %add27.30, -1
  %cmp32.30 = icmp ult i32 %add27.30, %img_width
  %224 = and i1 %cmp28.30, %cmp32.30
  br i1 %224, label %if.end38.30, label %for.inc.30

if.end38.30:                                      ; preds = %for.body26.30
  %add41.30 = add nsw i32 %add27.30, %mul.30
  %idxprom.30 = sext i32 %add41.30 to i64
  %arrayidx.30 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.30
  %225 = load float, float* %arrayidx.30, align 4
  %226 = trunc i64 %indvars.iv.30 to i32
  %add43.30 = add i32 %226, %mul42.30
  %idxprom44.30 = zext i32 %add43.30 to i64
  %arrayidx45.30 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.30
  %227 = load float, float* %arrayidx45.30, align 4
  %mul46.30 = fmul float %225, %227
  %add47.30 = fadd float %partial_sum.12.30, %mul46.30
  br label %for.inc.30

for.inc.30:                                       ; preds = %if.end38.30, %for.body26.30
  %partial_sum.2.30 = phi float [ %add47.30, %if.end38.30 ], [ %partial_sum.12.30, %for.body26.30 ]
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %kern_width
  br i1 %exitcond.30, label %for.inc48.30.loopexit, label %for.body26.30, !llvm.loop !1

for.inc48.30.loopexit:                            ; preds = %for.inc.30
  %partial_sum.2.30.lcssa = phi float [ %partial_sum.2.30, %for.inc.30 ]
  br label %for.inc48.30

for.inc48.30:                                     ; preds = %for.inc48.30.loopexit, %for.body15.30
  %partial_sum.3.30 = phi float [ %partial_sum.05.30, %for.body15.30 ], [ %partial_sum.2.30.lcssa, %for.inc48.30.loopexit ]
  %inc49.30 = add nuw nsw i32 %ki.06.30, 1
  %exitcond19.30 = icmp eq i32 %inc49.30, %kern_height
  br i1 %exitcond19.30, label %for.end50.30.loopexit, label %for.body15.30, !llvm.loop !3

for.end50.30.loopexit:                            ; preds = %for.inc48.30
  %partial_sum.3.30.lcssa = phi float [ %partial_sum.3.30, %for.inc48.30 ]
  br label %for.end50.30

for.end50.30:                                     ; preds = %for.end50.30.loopexit, %for.inc68.29
  %partial_sum.0.lcssa.30 = phi float [ 0.000000e+00, %for.inc68.29 ], [ %partial_sum.3.30.lcssa, %for.end50.30.loopexit ]
  br i1 %tobool51, label %if.else62.30, label %if.then52.30

if.then52.30:                                     ; preds = %for.end50.30
  %cmp53.30 = fcmp olt float %partial_sum.0.lcssa.30, 0.000000e+00
  %sub55.30 = fsub float -0.000000e+00, %partial_sum.0.lcssa.30
  %cond.30 = select i1 %cmp53.30, float %sub55.30, float %partial_sum.0.lcssa.30
  %conv56.30 = fptoui float %cond.30 to i8
  %conv57.30 = uitofp i8 %conv56.30 to float
  %228 = add nsw i64 %indvars.iv.next21.29, %5
  %arrayidx61.30 = getelementptr inbounds float, float* %., i64 %228
  store float %conv57.30, float* %arrayidx61.30, align 4
  br label %for.inc68.30

if.else62.30:                                     ; preds = %for.end50.30
  %229 = add nsw i64 %indvars.iv.next21.29, %4
  %arrayidx66.30 = getelementptr inbounds float, float* %., i64 %229
  store float %partial_sum.0.lcssa.30, float* %arrayidx66.30, align 4
  br label %for.inc68.30

for.inc68.30:                                     ; preds = %if.else62.30, %if.then52.30
  %inc69.30 = add nsw i32 %in_j.011, 31
  %indvars.iv.next21.30 = add nsw i64 %indvars.iv20, 31
  br i1 %cmp134, label %for.end50.31, label %for.body15.31.preheader

for.body15.31.preheader:                          ; preds = %for.inc68.30
  br label %for.body15.31

for.body15.31:                                    ; preds = %for.body15.31.preheader, %for.inc48.31
  %ki.06.31 = phi i32 [ %inc49.31, %for.inc48.31 ], [ 0, %for.body15.31.preheader ]
  %partial_sum.05.31 = phi float [ %partial_sum.3.31, %for.inc48.31 ], [ 0.000000e+00, %for.body15.31.preheader ]
  %add.31 = add nsw i32 %ki.06.31, %in_i.015
  %notlhs.31 = icmp slt i32 %add.31, 0
  %notrhs.31 = icmp uge i32 %add.31, %img_height
  %.not.31 = or i1 %notrhs.31, %notlhs.31
  %brmerge.31 = or i1 %.not.31, %cmp241.not.31
  br i1 %brmerge.31, label %for.inc48.31, label %for.body26.lr.ph.31

for.body26.lr.ph.31:                              ; preds = %for.body15.31
  %mul.31 = shl i32 %add.31, 7
  %mul42.31 = mul i32 %ki.06.31, %kern_width
  br label %for.body26.31

for.body26.31:                                    ; preds = %for.inc.31, %for.body26.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body26.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc.31 ]
  %partial_sum.12.31 = phi float [ %partial_sum.05.31, %for.body26.lr.ph.31 ], [ %partial_sum.2.31, %for.inc.31 ]
  %230 = trunc i64 %indvars.iv.31 to i32
  %add27.31 = add nsw i32 %230, %inc69.30
  %cmp28.31 = icmp sgt i32 %add27.31, -1
  %cmp32.31 = icmp ult i32 %add27.31, %img_width
  %231 = and i1 %cmp28.31, %cmp32.31
  br i1 %231, label %if.end38.31, label %for.inc.31

if.end38.31:                                      ; preds = %for.body26.31
  %add41.31 = add nsw i32 %add27.31, %mul.31
  %idxprom.31 = sext i32 %add41.31 to i64
  %arrayidx.31 = getelementptr inbounds float, float* inttoptr (i64 570425376 to float*), i64 %idxprom.31
  %232 = load float, float* %arrayidx.31, align 4
  %233 = trunc i64 %indvars.iv.31 to i32
  %add43.31 = add i32 %233, %mul42.31
  %idxprom44.31 = zext i32 %add43.31 to i64
  %arrayidx45.31 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom44.31
  %234 = load float, float* %arrayidx45.31, align 4
  %mul46.31 = fmul float %232, %234
  %add47.31 = fadd float %partial_sum.12.31, %mul46.31
  br label %for.inc.31

for.inc.31:                                       ; preds = %if.end38.31, %for.body26.31
  %partial_sum.2.31 = phi float [ %add47.31, %if.end38.31 ], [ %partial_sum.12.31, %for.body26.31 ]
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %kern_width
  br i1 %exitcond.31, label %for.inc48.31.loopexit, label %for.body26.31, !llvm.loop !1

for.inc48.31.loopexit:                            ; preds = %for.inc.31
  %partial_sum.2.31.lcssa = phi float [ %partial_sum.2.31, %for.inc.31 ]
  br label %for.inc48.31

for.inc48.31:                                     ; preds = %for.inc48.31.loopexit, %for.body15.31
  %partial_sum.3.31 = phi float [ %partial_sum.05.31, %for.body15.31 ], [ %partial_sum.2.31.lcssa, %for.inc48.31.loopexit ]
  %inc49.31 = add nuw nsw i32 %ki.06.31, 1
  %exitcond19.31 = icmp eq i32 %inc49.31, %kern_height
  br i1 %exitcond19.31, label %for.end50.31.loopexit, label %for.body15.31, !llvm.loop !3

for.end50.31.loopexit:                            ; preds = %for.inc48.31
  %partial_sum.3.31.lcssa = phi float [ %partial_sum.3.31, %for.inc48.31 ]
  br label %for.end50.31

for.end50.31:                                     ; preds = %for.end50.31.loopexit, %for.inc68.30
  %partial_sum.0.lcssa.31 = phi float [ 0.000000e+00, %for.inc68.30 ], [ %partial_sum.3.31.lcssa, %for.end50.31.loopexit ]
  br i1 %tobool51, label %if.else62.31, label %if.then52.31

if.then52.31:                                     ; preds = %for.end50.31
  %cmp53.31 = fcmp olt float %partial_sum.0.lcssa.31, 0.000000e+00
  %sub55.31 = fsub float -0.000000e+00, %partial_sum.0.lcssa.31
  %cond.31 = select i1 %cmp53.31, float %sub55.31, float %partial_sum.0.lcssa.31
  %conv56.31 = fptoui float %cond.31 to i8
  %conv57.31 = uitofp i8 %conv56.31 to float
  %235 = add nsw i64 %indvars.iv.next21.30, %5
  %arrayidx61.31 = getelementptr inbounds float, float* %., i64 %235
  store float %conv57.31, float* %arrayidx61.31, align 4
  br label %for.inc68.31

if.else62.31:                                     ; preds = %for.end50.31
  %236 = add nsw i64 %indvars.iv.next21.30, %4
  %arrayidx66.31 = getelementptr inbounds float, float* %., i64 %236
  store float %partial_sum.0.lcssa.31, float* %arrayidx66.31, align 4
  br label %for.inc68.31

for.inc68.31:                                     ; preds = %if.else62.31, %if.then52.31
  %inc69.31 = add nsw i32 %in_j.011, 32
  %indvars.iv.next21.31 = add nsw i64 %indvars.iv20, 32
  %lftr.wideiv24.31 = trunc i64 %indvars.iv.next21.31 to i32
  %exitcond25.31 = icmp eq i32 %lftr.wideiv24.31, %img_width
  br i1 %exitcond25.31, label %for.inc72.loopexit, label %for.cond12.preheader, !llvm.loop !6
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
