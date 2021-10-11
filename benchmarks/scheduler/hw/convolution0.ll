; ModuleID = 'convolution0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @convolution0(i32 %img_height, i32 %img_width, i32 %kern_height, i32 %kern_width, i8 zeroext %mod_and_floor, i32 %input_spm_addr, i32 %output_spm_addr) #0 {
entry:
  %conv = zext i32 %input_spm_addr to i64
  %0 = inttoptr i64 %conv to float*
  %conv1 = zext i32 %output_spm_addr to i64
  %1 = inttoptr i64 %conv1 to float*
  %sub3 = add i32 %kern_width, -1
  %div4 = lshr i32 %sub3, 1
  %sub5 = sub nsw i32 0, %div4
  %cmp14 = icmp eq i32 %img_height, 0
  br i1 %cmp14, label %for.end71, label %for.cond7.preheader.lr.ph

for.cond7.preheader.lr.ph:                        ; preds = %entry
  %sub = add i32 %kern_height, -1
  %div = lshr i32 %sub, 1
  %sub2 = sub nsw i32 0, %div
  %cmp810 = icmp eq i32 %img_width, 0
  %cmp124 = icmp eq i32 %kern_height, 0
  %tobool48 = icmp eq i8 %mod_and_floor, 0
  %2 = add i32 %img_width, -1
  %xtraiter = and i32 %img_width, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  %3 = icmp ult i32 %2, 31
  %cmp211.not.31 = icmp eq i32 %kern_width, 0
  %cmp211.not.30 = icmp eq i32 %kern_width, 0
  %cmp211.not.29 = icmp eq i32 %kern_width, 0
  %cmp211.not.28 = icmp eq i32 %kern_width, 0
  %cmp211.not.27 = icmp eq i32 %kern_width, 0
  %cmp211.not.26 = icmp eq i32 %kern_width, 0
  %cmp211.not.25 = icmp eq i32 %kern_width, 0
  %cmp211.not.24 = icmp eq i32 %kern_width, 0
  %cmp211.not.23 = icmp eq i32 %kern_width, 0
  %cmp211.not.22 = icmp eq i32 %kern_width, 0
  %cmp211.not.21 = icmp eq i32 %kern_width, 0
  %cmp211.not.20 = icmp eq i32 %kern_width, 0
  %cmp211.not.19 = icmp eq i32 %kern_width, 0
  %cmp211.not.18 = icmp eq i32 %kern_width, 0
  %cmp211.not.17 = icmp eq i32 %kern_width, 0
  %cmp211.not.16 = icmp eq i32 %kern_width, 0
  %cmp211.not.15 = icmp eq i32 %kern_width, 0
  %cmp211.not.14 = icmp eq i32 %kern_width, 0
  %cmp211.not.13 = icmp eq i32 %kern_width, 0
  %cmp211.not.12 = icmp eq i32 %kern_width, 0
  %cmp211.not.11 = icmp eq i32 %kern_width, 0
  %cmp211.not.10 = icmp eq i32 %kern_width, 0
  %cmp211.not.9 = icmp eq i32 %kern_width, 0
  %cmp211.not.8 = icmp eq i32 %kern_width, 0
  %cmp211.not.7 = icmp eq i32 %kern_width, 0
  %cmp211.not.6 = icmp eq i32 %kern_width, 0
  %cmp211.not.5 = icmp eq i32 %kern_width, 0
  %cmp211.not.4 = icmp eq i32 %kern_width, 0
  %cmp211.not.3 = icmp eq i32 %kern_width, 0
  %cmp211.not.2 = icmp eq i32 %kern_width, 0
  %cmp211.not.1 = icmp eq i32 %kern_width, 0
  %cmp211.not = icmp eq i32 %kern_width, 0
  %cmp211.not.prol = icmp eq i32 %kern_width, 0
  br label %for.cond7.preheader

for.cond7.preheader:                              ; preds = %for.inc68, %for.cond7.preheader.lr.ph
  %indvars.iv26 = phi i64 [ 0, %for.cond7.preheader.lr.ph ], [ %indvars.iv.next27, %for.inc68 ]
  %in_i.015 = phi i32 [ %sub2, %for.cond7.preheader.lr.ph ], [ %inc69, %for.inc68 ]
  br i1 %cmp810, label %for.inc68, label %for.cond11.preheader.lr.ph

for.cond11.preheader.lr.ph:                       ; preds = %for.cond7.preheader
  %4 = trunc i64 %indvars.iv26 to i32
  %mul59 = shl i32 %4, 7
  %5 = trunc i64 %indvars.iv26 to i32
  %mul55 = shl i32 %5, 7
  %6 = sext i32 %mul59 to i64
  %7 = sext i32 %mul55 to i64
  br i1 %lcmp.mod, label %for.cond11.preheader.lr.ph.split, label %for.cond11.preheader.prol.preheader

for.cond11.preheader.prol.preheader:              ; preds = %for.cond11.preheader.lr.ph
  br label %for.cond11.preheader.prol

for.cond11.preheader.prol:                        ; preds = %for.cond11.preheader.prol.preheader, %for.inc64.prol
  %indvars.iv20.prol = phi i64 [ %indvars.iv.next21.prol, %for.inc64.prol ], [ 0, %for.cond11.preheader.prol.preheader ]
  %in_j.011.prol = phi i32 [ %inc65.prol, %for.inc64.prol ], [ %sub5, %for.cond11.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc64.prol ], [ %xtraiter, %for.cond11.preheader.prol.preheader ]
  br i1 %cmp124, label %for.end47.prol, label %for.body14.prol.preheader

for.body14.prol.preheader:                        ; preds = %for.cond11.preheader.prol
  br label %for.body14.prol

for.body14.prol:                                  ; preds = %for.body14.prol.preheader, %for.inc45.prol
  %ki.06.prol = phi i32 [ %inc46.prol, %for.inc45.prol ], [ 0, %for.body14.prol.preheader ]
  %partial_sum.05.prol = phi float [ %partial_sum.3.prol, %for.inc45.prol ], [ 0.000000e+00, %for.body14.prol.preheader ]
  %add.prol = add nsw i32 %ki.06.prol, %in_i.015
  %notlhs.prol = icmp slt i32 %add.prol, 0
  %notrhs.prol = icmp uge i32 %add.prol, %img_height
  %.not.prol = or i1 %notrhs.prol, %notlhs.prol
  %brmerge.prol = or i1 %.not.prol, %cmp211.not.prol
  br i1 %brmerge.prol, label %for.inc45.prol, label %for.body23.lr.ph.prol

for.body23.lr.ph.prol:                            ; preds = %for.body14.prol
  %mul.prol = shl i32 %add.prol, 7
  %mul39.prol = mul i32 %ki.06.prol, %kern_width
  br label %for.body23.prol

for.body23.prol:                                  ; preds = %for.inc.prol, %for.body23.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body23.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc.prol ]
  %partial_sum.12.prol = phi float [ %partial_sum.05.prol, %for.body23.lr.ph.prol ], [ %partial_sum.2.prol, %for.inc.prol ]
  %8 = trunc i64 %indvars.iv.prol to i32
  %add24.prol = add nsw i32 %8, %in_j.011.prol
  %cmp25.prol = icmp sgt i32 %add24.prol, -1
  %cmp29.prol = icmp ult i32 %add24.prol, %img_width
  %9 = and i1 %cmp25.prol, %cmp29.prol
  br i1 %9, label %if.end35.prol, label %for.inc.prol

if.end35.prol:                                    ; preds = %for.body23.prol
  %add38.prol = add nsw i32 %add24.prol, %mul.prol
  %idxprom.prol = sext i32 %add38.prol to i64
  %arrayidx.prol = getelementptr inbounds float, float* %0, i64 %idxprom.prol
  %10 = load float, float* %arrayidx.prol, align 4
  %11 = trunc i64 %indvars.iv.prol to i32
  %add40.prol = add i32 %11, %mul39.prol
  %idxprom41.prol = zext i32 %add40.prol to i64
  %arrayidx42.prol = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.prol
  %12 = load float, float* %arrayidx42.prol, align 4
  %mul43.prol = fmul float %10, %12
  %add44.prol = fadd float %partial_sum.12.prol, %mul43.prol
  br label %for.inc.prol

for.inc.prol:                                     ; preds = %if.end35.prol, %for.body23.prol
  %partial_sum.2.prol = phi float [ %add44.prol, %if.end35.prol ], [ %partial_sum.12.prol, %for.body23.prol ]
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %kern_width
  br i1 %exitcond.prol, label %for.inc45.prol.loopexit, label %for.body23.prol, !llvm.loop !1

for.inc45.prol.loopexit:                          ; preds = %for.inc.prol
  %partial_sum.2.prol.lcssa = phi float [ %partial_sum.2.prol, %for.inc.prol ]
  br label %for.inc45.prol

for.inc45.prol:                                   ; preds = %for.inc45.prol.loopexit, %for.body14.prol
  %partial_sum.3.prol = phi float [ %partial_sum.05.prol, %for.body14.prol ], [ %partial_sum.2.prol.lcssa, %for.inc45.prol.loopexit ]
  %inc46.prol = add nuw nsw i32 %ki.06.prol, 1
  %exitcond19.prol = icmp eq i32 %inc46.prol, %kern_height
  br i1 %exitcond19.prol, label %for.end47.prol.loopexit, label %for.body14.prol, !llvm.loop !3

for.end47.prol.loopexit:                          ; preds = %for.inc45.prol
  %partial_sum.3.prol.lcssa = phi float [ %partial_sum.3.prol, %for.inc45.prol ]
  br label %for.end47.prol

for.end47.prol:                                   ; preds = %for.end47.prol.loopexit, %for.cond11.preheader.prol
  %partial_sum.0.lcssa.prol = phi float [ 0.000000e+00, %for.cond11.preheader.prol ], [ %partial_sum.3.prol.lcssa, %for.end47.prol.loopexit ]
  br i1 %tobool48, label %if.else.prol, label %if.then49.prol

if.then49.prol:                                   ; preds = %for.end47.prol
  %cmp50.prol = fcmp olt float %partial_sum.0.lcssa.prol, 0.000000e+00
  %sub52.prol = fsub float -0.000000e+00, %partial_sum.0.lcssa.prol
  %cond.prol = select i1 %cmp50.prol, float %sub52.prol, float %partial_sum.0.lcssa.prol
  %conv53.prol = fptoui float %cond.prol to i8
  %conv54.prol = uitofp i8 %conv53.prol to float
  %13 = add nsw i64 %indvars.iv20.prol, %7
  %arrayidx58.prol = getelementptr inbounds float, float* %1, i64 %13
  store float %conv54.prol, float* %arrayidx58.prol, align 4
  br label %for.inc64.prol

if.else.prol:                                     ; preds = %for.end47.prol
  %14 = add nsw i64 %indvars.iv20.prol, %6
  %arrayidx62.prol = getelementptr inbounds float, float* %1, i64 %14
  store float %partial_sum.0.lcssa.prol, float* %arrayidx62.prol, align 4
  br label %for.inc64.prol

for.inc64.prol:                                   ; preds = %if.else.prol, %if.then49.prol
  %inc65.prol = add nsw i32 %in_j.011.prol, 1
  %indvars.iv.next21.prol = add nuw nsw i64 %indvars.iv20.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond11.preheader.lr.ph.split.loopexit, label %for.cond11.preheader.prol, !llvm.loop !4

for.cond11.preheader.lr.ph.split.loopexit:        ; preds = %for.inc64.prol
  %indvars.iv.next21.prol.lcssa = phi i64 [ %indvars.iv.next21.prol, %for.inc64.prol ]
  %inc65.prol.lcssa = phi i32 [ %inc65.prol, %for.inc64.prol ]
  br label %for.cond11.preheader.lr.ph.split

for.cond11.preheader.lr.ph.split:                 ; preds = %for.cond11.preheader.lr.ph.split.loopexit, %for.cond11.preheader.lr.ph
  %indvars.iv20.unr = phi i64 [ 0, %for.cond11.preheader.lr.ph ], [ %indvars.iv.next21.prol.lcssa, %for.cond11.preheader.lr.ph.split.loopexit ]
  %in_j.011.unr = phi i32 [ %sub5, %for.cond11.preheader.lr.ph ], [ %inc65.prol.lcssa, %for.cond11.preheader.lr.ph.split.loopexit ]
  br i1 %3, label %for.inc68, label %for.cond11.preheader.preheader

for.cond11.preheader.preheader:                   ; preds = %for.cond11.preheader.lr.ph.split
  br label %for.cond11.preheader

for.cond11.preheader:                             ; preds = %for.cond11.preheader.preheader, %for.inc64.31
  %indvars.iv20 = phi i64 [ %indvars.iv.next21.31, %for.inc64.31 ], [ %indvars.iv20.unr, %for.cond11.preheader.preheader ]
  %in_j.011 = phi i32 [ %inc65.31, %for.inc64.31 ], [ %in_j.011.unr, %for.cond11.preheader.preheader ]
  br i1 %cmp124, label %for.end47, label %for.body14.preheader

for.body14.preheader:                             ; preds = %for.cond11.preheader
  br label %for.body14

for.body14:                                       ; preds = %for.body14.preheader, %for.inc45
  %ki.06 = phi i32 [ %inc46, %for.inc45 ], [ 0, %for.body14.preheader ]
  %partial_sum.05 = phi float [ %partial_sum.3, %for.inc45 ], [ 0.000000e+00, %for.body14.preheader ]
  %add = add nsw i32 %ki.06, %in_i.015
  %notlhs = icmp slt i32 %add, 0
  %notrhs = icmp uge i32 %add, %img_height
  %.not = or i1 %notrhs, %notlhs
  %brmerge = or i1 %.not, %cmp211.not
  br i1 %brmerge, label %for.inc45, label %for.body23.lr.ph

for.body23.lr.ph:                                 ; preds = %for.body14
  %mul = shl i32 %add, 7
  %mul39 = mul i32 %ki.06, %kern_width
  br label %for.body23

for.body23:                                       ; preds = %for.inc, %for.body23.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body23.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %partial_sum.12 = phi float [ %partial_sum.05, %for.body23.lr.ph ], [ %partial_sum.2, %for.inc ]
  %15 = trunc i64 %indvars.iv to i32
  %add24 = add nsw i32 %15, %in_j.011
  %cmp25 = icmp sgt i32 %add24, -1
  %cmp29 = icmp ult i32 %add24, %img_width
  %16 = and i1 %cmp25, %cmp29
  br i1 %16, label %if.end35, label %for.inc

if.end35:                                         ; preds = %for.body23
  %add38 = add nsw i32 %add24, %mul
  %idxprom = sext i32 %add38 to i64
  %arrayidx = getelementptr inbounds float, float* %0, i64 %idxprom
  %17 = load float, float* %arrayidx, align 4
  %18 = trunc i64 %indvars.iv to i32
  %add40 = add i32 %18, %mul39
  %idxprom41 = zext i32 %add40 to i64
  %arrayidx42 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41
  %19 = load float, float* %arrayidx42, align 4
  %mul43 = fmul float %17, %19
  %add44 = fadd float %partial_sum.12, %mul43
  br label %for.inc

for.inc:                                          ; preds = %for.body23, %if.end35
  %partial_sum.2 = phi float [ %add44, %if.end35 ], [ %partial_sum.12, %for.body23 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %kern_width
  br i1 %exitcond, label %for.inc45.loopexit, label %for.body23, !llvm.loop !1

for.inc45.loopexit:                               ; preds = %for.inc
  %partial_sum.2.lcssa = phi float [ %partial_sum.2, %for.inc ]
  br label %for.inc45

for.inc45:                                        ; preds = %for.inc45.loopexit, %for.body14
  %partial_sum.3 = phi float [ %partial_sum.05, %for.body14 ], [ %partial_sum.2.lcssa, %for.inc45.loopexit ]
  %inc46 = add nuw nsw i32 %ki.06, 1
  %exitcond19 = icmp eq i32 %inc46, %kern_height
  br i1 %exitcond19, label %for.end47.loopexit, label %for.body14, !llvm.loop !3

for.end47.loopexit:                               ; preds = %for.inc45
  %partial_sum.3.lcssa = phi float [ %partial_sum.3, %for.inc45 ]
  br label %for.end47

for.end47:                                        ; preds = %for.end47.loopexit, %for.cond11.preheader
  %partial_sum.0.lcssa = phi float [ 0.000000e+00, %for.cond11.preheader ], [ %partial_sum.3.lcssa, %for.end47.loopexit ]
  br i1 %tobool48, label %if.else, label %if.then49

if.then49:                                        ; preds = %for.end47
  %cmp50 = fcmp olt float %partial_sum.0.lcssa, 0.000000e+00
  %sub52 = fsub float -0.000000e+00, %partial_sum.0.lcssa
  %cond = select i1 %cmp50, float %sub52, float %partial_sum.0.lcssa
  %conv53 = fptoui float %cond to i8
  %conv54 = uitofp i8 %conv53 to float
  %20 = add nsw i64 %indvars.iv20, %7
  %arrayidx58 = getelementptr inbounds float, float* %1, i64 %20
  store float %conv54, float* %arrayidx58, align 4
  br label %for.inc64

if.else:                                          ; preds = %for.end47
  %21 = add nsw i64 %indvars.iv20, %6
  %arrayidx62 = getelementptr inbounds float, float* %1, i64 %21
  store float %partial_sum.0.lcssa, float* %arrayidx62, align 4
  br label %for.inc64

for.inc64:                                        ; preds = %if.then49, %if.else
  %inc65 = add nsw i32 %in_j.011, 1
  %indvars.iv.next21 = add nuw nsw i64 %indvars.iv20, 1
  br i1 %cmp124, label %for.end47.1, label %for.body14.1.preheader

for.body14.1.preheader:                           ; preds = %for.inc64
  br label %for.body14.1

for.inc68.loopexit:                               ; preds = %for.inc64.31
  br label %for.inc68

for.inc68:                                        ; preds = %for.inc68.loopexit, %for.cond11.preheader.lr.ph.split, %for.cond7.preheader
  %inc69 = add nsw i32 %in_i.015, 1
  %indvars.iv.next27 = add nuw nsw i64 %indvars.iv26, 1
  %lftr.wideiv28 = trunc i64 %indvars.iv.next27 to i32
  %exitcond29 = icmp eq i32 %lftr.wideiv28, %img_height
  br i1 %exitcond29, label %for.end71.loopexit, label %for.cond7.preheader, !llvm.loop !5

for.end71.loopexit:                               ; preds = %for.inc68
  br label %for.end71

for.end71:                                        ; preds = %for.end71.loopexit, %entry
  ret void

for.body14.1:                                     ; preds = %for.body14.1.preheader, %for.inc45.1
  %ki.06.1 = phi i32 [ %inc46.1, %for.inc45.1 ], [ 0, %for.body14.1.preheader ]
  %partial_sum.05.1 = phi float [ %partial_sum.3.1, %for.inc45.1 ], [ 0.000000e+00, %for.body14.1.preheader ]
  %add.1 = add nsw i32 %ki.06.1, %in_i.015
  %notlhs.1 = icmp slt i32 %add.1, 0
  %notrhs.1 = icmp uge i32 %add.1, %img_height
  %.not.1 = or i1 %notrhs.1, %notlhs.1
  %brmerge.1 = or i1 %.not.1, %cmp211.not.1
  br i1 %brmerge.1, label %for.inc45.1, label %for.body23.lr.ph.1

for.body23.lr.ph.1:                               ; preds = %for.body14.1
  %mul.1 = shl i32 %add.1, 7
  %mul39.1 = mul i32 %ki.06.1, %kern_width
  br label %for.body23.1

for.body23.1:                                     ; preds = %for.inc.1, %for.body23.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body23.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc.1 ]
  %partial_sum.12.1 = phi float [ %partial_sum.05.1, %for.body23.lr.ph.1 ], [ %partial_sum.2.1, %for.inc.1 ]
  %22 = trunc i64 %indvars.iv.1 to i32
  %add24.1 = add nsw i32 %22, %inc65
  %cmp25.1 = icmp sgt i32 %add24.1, -1
  %cmp29.1 = icmp ult i32 %add24.1, %img_width
  %23 = and i1 %cmp25.1, %cmp29.1
  br i1 %23, label %if.end35.1, label %for.inc.1

if.end35.1:                                       ; preds = %for.body23.1
  %add38.1 = add nsw i32 %add24.1, %mul.1
  %idxprom.1 = sext i32 %add38.1 to i64
  %arrayidx.1 = getelementptr inbounds float, float* %0, i64 %idxprom.1
  %24 = load float, float* %arrayidx.1, align 4
  %25 = trunc i64 %indvars.iv.1 to i32
  %add40.1 = add i32 %25, %mul39.1
  %idxprom41.1 = zext i32 %add40.1 to i64
  %arrayidx42.1 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.1
  %26 = load float, float* %arrayidx42.1, align 4
  %mul43.1 = fmul float %24, %26
  %add44.1 = fadd float %partial_sum.12.1, %mul43.1
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.end35.1, %for.body23.1
  %partial_sum.2.1 = phi float [ %add44.1, %if.end35.1 ], [ %partial_sum.12.1, %for.body23.1 ]
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %kern_width
  br i1 %exitcond.1, label %for.inc45.1.loopexit, label %for.body23.1, !llvm.loop !1

for.inc45.1.loopexit:                             ; preds = %for.inc.1
  %partial_sum.2.1.lcssa = phi float [ %partial_sum.2.1, %for.inc.1 ]
  br label %for.inc45.1

for.inc45.1:                                      ; preds = %for.inc45.1.loopexit, %for.body14.1
  %partial_sum.3.1 = phi float [ %partial_sum.05.1, %for.body14.1 ], [ %partial_sum.2.1.lcssa, %for.inc45.1.loopexit ]
  %inc46.1 = add nuw nsw i32 %ki.06.1, 1
  %exitcond19.1 = icmp eq i32 %inc46.1, %kern_height
  br i1 %exitcond19.1, label %for.end47.1.loopexit, label %for.body14.1, !llvm.loop !3

for.end47.1.loopexit:                             ; preds = %for.inc45.1
  %partial_sum.3.1.lcssa = phi float [ %partial_sum.3.1, %for.inc45.1 ]
  br label %for.end47.1

for.end47.1:                                      ; preds = %for.end47.1.loopexit, %for.inc64
  %partial_sum.0.lcssa.1 = phi float [ 0.000000e+00, %for.inc64 ], [ %partial_sum.3.1.lcssa, %for.end47.1.loopexit ]
  br i1 %tobool48, label %if.else.1, label %if.then49.1

if.then49.1:                                      ; preds = %for.end47.1
  %cmp50.1 = fcmp olt float %partial_sum.0.lcssa.1, 0.000000e+00
  %sub52.1 = fsub float -0.000000e+00, %partial_sum.0.lcssa.1
  %cond.1 = select i1 %cmp50.1, float %sub52.1, float %partial_sum.0.lcssa.1
  %conv53.1 = fptoui float %cond.1 to i8
  %conv54.1 = uitofp i8 %conv53.1 to float
  %27 = add nsw i64 %indvars.iv.next21, %7
  %arrayidx58.1 = getelementptr inbounds float, float* %1, i64 %27
  store float %conv54.1, float* %arrayidx58.1, align 4
  br label %for.inc64.1

if.else.1:                                        ; preds = %for.end47.1
  %28 = add nsw i64 %indvars.iv.next21, %6
  %arrayidx62.1 = getelementptr inbounds float, float* %1, i64 %28
  store float %partial_sum.0.lcssa.1, float* %arrayidx62.1, align 4
  br label %for.inc64.1

for.inc64.1:                                      ; preds = %if.else.1, %if.then49.1
  %inc65.1 = add nsw i32 %in_j.011, 2
  %indvars.iv.next21.1 = add nsw i64 %indvars.iv20, 2
  br i1 %cmp124, label %for.end47.2, label %for.body14.2.preheader

for.body14.2.preheader:                           ; preds = %for.inc64.1
  br label %for.body14.2

for.body14.2:                                     ; preds = %for.body14.2.preheader, %for.inc45.2
  %ki.06.2 = phi i32 [ %inc46.2, %for.inc45.2 ], [ 0, %for.body14.2.preheader ]
  %partial_sum.05.2 = phi float [ %partial_sum.3.2, %for.inc45.2 ], [ 0.000000e+00, %for.body14.2.preheader ]
  %add.2 = add nsw i32 %ki.06.2, %in_i.015
  %notlhs.2 = icmp slt i32 %add.2, 0
  %notrhs.2 = icmp uge i32 %add.2, %img_height
  %.not.2 = or i1 %notrhs.2, %notlhs.2
  %brmerge.2 = or i1 %.not.2, %cmp211.not.2
  br i1 %brmerge.2, label %for.inc45.2, label %for.body23.lr.ph.2

for.body23.lr.ph.2:                               ; preds = %for.body14.2
  %mul.2 = shl i32 %add.2, 7
  %mul39.2 = mul i32 %ki.06.2, %kern_width
  br label %for.body23.2

for.body23.2:                                     ; preds = %for.inc.2, %for.body23.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body23.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc.2 ]
  %partial_sum.12.2 = phi float [ %partial_sum.05.2, %for.body23.lr.ph.2 ], [ %partial_sum.2.2, %for.inc.2 ]
  %29 = trunc i64 %indvars.iv.2 to i32
  %add24.2 = add nsw i32 %29, %inc65.1
  %cmp25.2 = icmp sgt i32 %add24.2, -1
  %cmp29.2 = icmp ult i32 %add24.2, %img_width
  %30 = and i1 %cmp25.2, %cmp29.2
  br i1 %30, label %if.end35.2, label %for.inc.2

if.end35.2:                                       ; preds = %for.body23.2
  %add38.2 = add nsw i32 %add24.2, %mul.2
  %idxprom.2 = sext i32 %add38.2 to i64
  %arrayidx.2 = getelementptr inbounds float, float* %0, i64 %idxprom.2
  %31 = load float, float* %arrayidx.2, align 4
  %32 = trunc i64 %indvars.iv.2 to i32
  %add40.2 = add i32 %32, %mul39.2
  %idxprom41.2 = zext i32 %add40.2 to i64
  %arrayidx42.2 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.2
  %33 = load float, float* %arrayidx42.2, align 4
  %mul43.2 = fmul float %31, %33
  %add44.2 = fadd float %partial_sum.12.2, %mul43.2
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.end35.2, %for.body23.2
  %partial_sum.2.2 = phi float [ %add44.2, %if.end35.2 ], [ %partial_sum.12.2, %for.body23.2 ]
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %kern_width
  br i1 %exitcond.2, label %for.inc45.2.loopexit, label %for.body23.2, !llvm.loop !1

for.inc45.2.loopexit:                             ; preds = %for.inc.2
  %partial_sum.2.2.lcssa = phi float [ %partial_sum.2.2, %for.inc.2 ]
  br label %for.inc45.2

for.inc45.2:                                      ; preds = %for.inc45.2.loopexit, %for.body14.2
  %partial_sum.3.2 = phi float [ %partial_sum.05.2, %for.body14.2 ], [ %partial_sum.2.2.lcssa, %for.inc45.2.loopexit ]
  %inc46.2 = add nuw nsw i32 %ki.06.2, 1
  %exitcond19.2 = icmp eq i32 %inc46.2, %kern_height
  br i1 %exitcond19.2, label %for.end47.2.loopexit, label %for.body14.2, !llvm.loop !3

for.end47.2.loopexit:                             ; preds = %for.inc45.2
  %partial_sum.3.2.lcssa = phi float [ %partial_sum.3.2, %for.inc45.2 ]
  br label %for.end47.2

for.end47.2:                                      ; preds = %for.end47.2.loopexit, %for.inc64.1
  %partial_sum.0.lcssa.2 = phi float [ 0.000000e+00, %for.inc64.1 ], [ %partial_sum.3.2.lcssa, %for.end47.2.loopexit ]
  br i1 %tobool48, label %if.else.2, label %if.then49.2

if.then49.2:                                      ; preds = %for.end47.2
  %cmp50.2 = fcmp olt float %partial_sum.0.lcssa.2, 0.000000e+00
  %sub52.2 = fsub float -0.000000e+00, %partial_sum.0.lcssa.2
  %cond.2 = select i1 %cmp50.2, float %sub52.2, float %partial_sum.0.lcssa.2
  %conv53.2 = fptoui float %cond.2 to i8
  %conv54.2 = uitofp i8 %conv53.2 to float
  %34 = add nsw i64 %indvars.iv.next21.1, %7
  %arrayidx58.2 = getelementptr inbounds float, float* %1, i64 %34
  store float %conv54.2, float* %arrayidx58.2, align 4
  br label %for.inc64.2

if.else.2:                                        ; preds = %for.end47.2
  %35 = add nsw i64 %indvars.iv.next21.1, %6
  %arrayidx62.2 = getelementptr inbounds float, float* %1, i64 %35
  store float %partial_sum.0.lcssa.2, float* %arrayidx62.2, align 4
  br label %for.inc64.2

for.inc64.2:                                      ; preds = %if.else.2, %if.then49.2
  %inc65.2 = add nsw i32 %in_j.011, 3
  %indvars.iv.next21.2 = add nsw i64 %indvars.iv20, 3
  br i1 %cmp124, label %for.end47.3, label %for.body14.3.preheader

for.body14.3.preheader:                           ; preds = %for.inc64.2
  br label %for.body14.3

for.body14.3:                                     ; preds = %for.body14.3.preheader, %for.inc45.3
  %ki.06.3 = phi i32 [ %inc46.3, %for.inc45.3 ], [ 0, %for.body14.3.preheader ]
  %partial_sum.05.3 = phi float [ %partial_sum.3.3, %for.inc45.3 ], [ 0.000000e+00, %for.body14.3.preheader ]
  %add.3 = add nsw i32 %ki.06.3, %in_i.015
  %notlhs.3 = icmp slt i32 %add.3, 0
  %notrhs.3 = icmp uge i32 %add.3, %img_height
  %.not.3 = or i1 %notrhs.3, %notlhs.3
  %brmerge.3 = or i1 %.not.3, %cmp211.not.3
  br i1 %brmerge.3, label %for.inc45.3, label %for.body23.lr.ph.3

for.body23.lr.ph.3:                               ; preds = %for.body14.3
  %mul.3 = shl i32 %add.3, 7
  %mul39.3 = mul i32 %ki.06.3, %kern_width
  br label %for.body23.3

for.body23.3:                                     ; preds = %for.inc.3, %for.body23.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body23.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc.3 ]
  %partial_sum.12.3 = phi float [ %partial_sum.05.3, %for.body23.lr.ph.3 ], [ %partial_sum.2.3, %for.inc.3 ]
  %36 = trunc i64 %indvars.iv.3 to i32
  %add24.3 = add nsw i32 %36, %inc65.2
  %cmp25.3 = icmp sgt i32 %add24.3, -1
  %cmp29.3 = icmp ult i32 %add24.3, %img_width
  %37 = and i1 %cmp25.3, %cmp29.3
  br i1 %37, label %if.end35.3, label %for.inc.3

if.end35.3:                                       ; preds = %for.body23.3
  %add38.3 = add nsw i32 %add24.3, %mul.3
  %idxprom.3 = sext i32 %add38.3 to i64
  %arrayidx.3 = getelementptr inbounds float, float* %0, i64 %idxprom.3
  %38 = load float, float* %arrayidx.3, align 4
  %39 = trunc i64 %indvars.iv.3 to i32
  %add40.3 = add i32 %39, %mul39.3
  %idxprom41.3 = zext i32 %add40.3 to i64
  %arrayidx42.3 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.3
  %40 = load float, float* %arrayidx42.3, align 4
  %mul43.3 = fmul float %38, %40
  %add44.3 = fadd float %partial_sum.12.3, %mul43.3
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.end35.3, %for.body23.3
  %partial_sum.2.3 = phi float [ %add44.3, %if.end35.3 ], [ %partial_sum.12.3, %for.body23.3 ]
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %kern_width
  br i1 %exitcond.3, label %for.inc45.3.loopexit, label %for.body23.3, !llvm.loop !1

for.inc45.3.loopexit:                             ; preds = %for.inc.3
  %partial_sum.2.3.lcssa = phi float [ %partial_sum.2.3, %for.inc.3 ]
  br label %for.inc45.3

for.inc45.3:                                      ; preds = %for.inc45.3.loopexit, %for.body14.3
  %partial_sum.3.3 = phi float [ %partial_sum.05.3, %for.body14.3 ], [ %partial_sum.2.3.lcssa, %for.inc45.3.loopexit ]
  %inc46.3 = add nuw nsw i32 %ki.06.3, 1
  %exitcond19.3 = icmp eq i32 %inc46.3, %kern_height
  br i1 %exitcond19.3, label %for.end47.3.loopexit, label %for.body14.3, !llvm.loop !3

for.end47.3.loopexit:                             ; preds = %for.inc45.3
  %partial_sum.3.3.lcssa = phi float [ %partial_sum.3.3, %for.inc45.3 ]
  br label %for.end47.3

for.end47.3:                                      ; preds = %for.end47.3.loopexit, %for.inc64.2
  %partial_sum.0.lcssa.3 = phi float [ 0.000000e+00, %for.inc64.2 ], [ %partial_sum.3.3.lcssa, %for.end47.3.loopexit ]
  br i1 %tobool48, label %if.else.3, label %if.then49.3

if.then49.3:                                      ; preds = %for.end47.3
  %cmp50.3 = fcmp olt float %partial_sum.0.lcssa.3, 0.000000e+00
  %sub52.3 = fsub float -0.000000e+00, %partial_sum.0.lcssa.3
  %cond.3 = select i1 %cmp50.3, float %sub52.3, float %partial_sum.0.lcssa.3
  %conv53.3 = fptoui float %cond.3 to i8
  %conv54.3 = uitofp i8 %conv53.3 to float
  %41 = add nsw i64 %indvars.iv.next21.2, %7
  %arrayidx58.3 = getelementptr inbounds float, float* %1, i64 %41
  store float %conv54.3, float* %arrayidx58.3, align 4
  br label %for.inc64.3

if.else.3:                                        ; preds = %for.end47.3
  %42 = add nsw i64 %indvars.iv.next21.2, %6
  %arrayidx62.3 = getelementptr inbounds float, float* %1, i64 %42
  store float %partial_sum.0.lcssa.3, float* %arrayidx62.3, align 4
  br label %for.inc64.3

for.inc64.3:                                      ; preds = %if.else.3, %if.then49.3
  %inc65.3 = add nsw i32 %in_j.011, 4
  %indvars.iv.next21.3 = add nsw i64 %indvars.iv20, 4
  br i1 %cmp124, label %for.end47.4, label %for.body14.4.preheader

for.body14.4.preheader:                           ; preds = %for.inc64.3
  br label %for.body14.4

for.body14.4:                                     ; preds = %for.body14.4.preheader, %for.inc45.4
  %ki.06.4 = phi i32 [ %inc46.4, %for.inc45.4 ], [ 0, %for.body14.4.preheader ]
  %partial_sum.05.4 = phi float [ %partial_sum.3.4, %for.inc45.4 ], [ 0.000000e+00, %for.body14.4.preheader ]
  %add.4 = add nsw i32 %ki.06.4, %in_i.015
  %notlhs.4 = icmp slt i32 %add.4, 0
  %notrhs.4 = icmp uge i32 %add.4, %img_height
  %.not.4 = or i1 %notrhs.4, %notlhs.4
  %brmerge.4 = or i1 %.not.4, %cmp211.not.4
  br i1 %brmerge.4, label %for.inc45.4, label %for.body23.lr.ph.4

for.body23.lr.ph.4:                               ; preds = %for.body14.4
  %mul.4 = shl i32 %add.4, 7
  %mul39.4 = mul i32 %ki.06.4, %kern_width
  br label %for.body23.4

for.body23.4:                                     ; preds = %for.inc.4, %for.body23.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body23.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc.4 ]
  %partial_sum.12.4 = phi float [ %partial_sum.05.4, %for.body23.lr.ph.4 ], [ %partial_sum.2.4, %for.inc.4 ]
  %43 = trunc i64 %indvars.iv.4 to i32
  %add24.4 = add nsw i32 %43, %inc65.3
  %cmp25.4 = icmp sgt i32 %add24.4, -1
  %cmp29.4 = icmp ult i32 %add24.4, %img_width
  %44 = and i1 %cmp25.4, %cmp29.4
  br i1 %44, label %if.end35.4, label %for.inc.4

if.end35.4:                                       ; preds = %for.body23.4
  %add38.4 = add nsw i32 %add24.4, %mul.4
  %idxprom.4 = sext i32 %add38.4 to i64
  %arrayidx.4 = getelementptr inbounds float, float* %0, i64 %idxprom.4
  %45 = load float, float* %arrayidx.4, align 4
  %46 = trunc i64 %indvars.iv.4 to i32
  %add40.4 = add i32 %46, %mul39.4
  %idxprom41.4 = zext i32 %add40.4 to i64
  %arrayidx42.4 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.4
  %47 = load float, float* %arrayidx42.4, align 4
  %mul43.4 = fmul float %45, %47
  %add44.4 = fadd float %partial_sum.12.4, %mul43.4
  br label %for.inc.4

for.inc.4:                                        ; preds = %if.end35.4, %for.body23.4
  %partial_sum.2.4 = phi float [ %add44.4, %if.end35.4 ], [ %partial_sum.12.4, %for.body23.4 ]
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %kern_width
  br i1 %exitcond.4, label %for.inc45.4.loopexit, label %for.body23.4, !llvm.loop !1

for.inc45.4.loopexit:                             ; preds = %for.inc.4
  %partial_sum.2.4.lcssa = phi float [ %partial_sum.2.4, %for.inc.4 ]
  br label %for.inc45.4

for.inc45.4:                                      ; preds = %for.inc45.4.loopexit, %for.body14.4
  %partial_sum.3.4 = phi float [ %partial_sum.05.4, %for.body14.4 ], [ %partial_sum.2.4.lcssa, %for.inc45.4.loopexit ]
  %inc46.4 = add nuw nsw i32 %ki.06.4, 1
  %exitcond19.4 = icmp eq i32 %inc46.4, %kern_height
  br i1 %exitcond19.4, label %for.end47.4.loopexit, label %for.body14.4, !llvm.loop !3

for.end47.4.loopexit:                             ; preds = %for.inc45.4
  %partial_sum.3.4.lcssa = phi float [ %partial_sum.3.4, %for.inc45.4 ]
  br label %for.end47.4

for.end47.4:                                      ; preds = %for.end47.4.loopexit, %for.inc64.3
  %partial_sum.0.lcssa.4 = phi float [ 0.000000e+00, %for.inc64.3 ], [ %partial_sum.3.4.lcssa, %for.end47.4.loopexit ]
  br i1 %tobool48, label %if.else.4, label %if.then49.4

if.then49.4:                                      ; preds = %for.end47.4
  %cmp50.4 = fcmp olt float %partial_sum.0.lcssa.4, 0.000000e+00
  %sub52.4 = fsub float -0.000000e+00, %partial_sum.0.lcssa.4
  %cond.4 = select i1 %cmp50.4, float %sub52.4, float %partial_sum.0.lcssa.4
  %conv53.4 = fptoui float %cond.4 to i8
  %conv54.4 = uitofp i8 %conv53.4 to float
  %48 = add nsw i64 %indvars.iv.next21.3, %7
  %arrayidx58.4 = getelementptr inbounds float, float* %1, i64 %48
  store float %conv54.4, float* %arrayidx58.4, align 4
  br label %for.inc64.4

if.else.4:                                        ; preds = %for.end47.4
  %49 = add nsw i64 %indvars.iv.next21.3, %6
  %arrayidx62.4 = getelementptr inbounds float, float* %1, i64 %49
  store float %partial_sum.0.lcssa.4, float* %arrayidx62.4, align 4
  br label %for.inc64.4

for.inc64.4:                                      ; preds = %if.else.4, %if.then49.4
  %inc65.4 = add nsw i32 %in_j.011, 5
  %indvars.iv.next21.4 = add nsw i64 %indvars.iv20, 5
  br i1 %cmp124, label %for.end47.5, label %for.body14.5.preheader

for.body14.5.preheader:                           ; preds = %for.inc64.4
  br label %for.body14.5

for.body14.5:                                     ; preds = %for.body14.5.preheader, %for.inc45.5
  %ki.06.5 = phi i32 [ %inc46.5, %for.inc45.5 ], [ 0, %for.body14.5.preheader ]
  %partial_sum.05.5 = phi float [ %partial_sum.3.5, %for.inc45.5 ], [ 0.000000e+00, %for.body14.5.preheader ]
  %add.5 = add nsw i32 %ki.06.5, %in_i.015
  %notlhs.5 = icmp slt i32 %add.5, 0
  %notrhs.5 = icmp uge i32 %add.5, %img_height
  %.not.5 = or i1 %notrhs.5, %notlhs.5
  %brmerge.5 = or i1 %.not.5, %cmp211.not.5
  br i1 %brmerge.5, label %for.inc45.5, label %for.body23.lr.ph.5

for.body23.lr.ph.5:                               ; preds = %for.body14.5
  %mul.5 = shl i32 %add.5, 7
  %mul39.5 = mul i32 %ki.06.5, %kern_width
  br label %for.body23.5

for.body23.5:                                     ; preds = %for.inc.5, %for.body23.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body23.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc.5 ]
  %partial_sum.12.5 = phi float [ %partial_sum.05.5, %for.body23.lr.ph.5 ], [ %partial_sum.2.5, %for.inc.5 ]
  %50 = trunc i64 %indvars.iv.5 to i32
  %add24.5 = add nsw i32 %50, %inc65.4
  %cmp25.5 = icmp sgt i32 %add24.5, -1
  %cmp29.5 = icmp ult i32 %add24.5, %img_width
  %51 = and i1 %cmp25.5, %cmp29.5
  br i1 %51, label %if.end35.5, label %for.inc.5

if.end35.5:                                       ; preds = %for.body23.5
  %add38.5 = add nsw i32 %add24.5, %mul.5
  %idxprom.5 = sext i32 %add38.5 to i64
  %arrayidx.5 = getelementptr inbounds float, float* %0, i64 %idxprom.5
  %52 = load float, float* %arrayidx.5, align 4
  %53 = trunc i64 %indvars.iv.5 to i32
  %add40.5 = add i32 %53, %mul39.5
  %idxprom41.5 = zext i32 %add40.5 to i64
  %arrayidx42.5 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.5
  %54 = load float, float* %arrayidx42.5, align 4
  %mul43.5 = fmul float %52, %54
  %add44.5 = fadd float %partial_sum.12.5, %mul43.5
  br label %for.inc.5

for.inc.5:                                        ; preds = %if.end35.5, %for.body23.5
  %partial_sum.2.5 = phi float [ %add44.5, %if.end35.5 ], [ %partial_sum.12.5, %for.body23.5 ]
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %kern_width
  br i1 %exitcond.5, label %for.inc45.5.loopexit, label %for.body23.5, !llvm.loop !1

for.inc45.5.loopexit:                             ; preds = %for.inc.5
  %partial_sum.2.5.lcssa = phi float [ %partial_sum.2.5, %for.inc.5 ]
  br label %for.inc45.5

for.inc45.5:                                      ; preds = %for.inc45.5.loopexit, %for.body14.5
  %partial_sum.3.5 = phi float [ %partial_sum.05.5, %for.body14.5 ], [ %partial_sum.2.5.lcssa, %for.inc45.5.loopexit ]
  %inc46.5 = add nuw nsw i32 %ki.06.5, 1
  %exitcond19.5 = icmp eq i32 %inc46.5, %kern_height
  br i1 %exitcond19.5, label %for.end47.5.loopexit, label %for.body14.5, !llvm.loop !3

for.end47.5.loopexit:                             ; preds = %for.inc45.5
  %partial_sum.3.5.lcssa = phi float [ %partial_sum.3.5, %for.inc45.5 ]
  br label %for.end47.5

for.end47.5:                                      ; preds = %for.end47.5.loopexit, %for.inc64.4
  %partial_sum.0.lcssa.5 = phi float [ 0.000000e+00, %for.inc64.4 ], [ %partial_sum.3.5.lcssa, %for.end47.5.loopexit ]
  br i1 %tobool48, label %if.else.5, label %if.then49.5

if.then49.5:                                      ; preds = %for.end47.5
  %cmp50.5 = fcmp olt float %partial_sum.0.lcssa.5, 0.000000e+00
  %sub52.5 = fsub float -0.000000e+00, %partial_sum.0.lcssa.5
  %cond.5 = select i1 %cmp50.5, float %sub52.5, float %partial_sum.0.lcssa.5
  %conv53.5 = fptoui float %cond.5 to i8
  %conv54.5 = uitofp i8 %conv53.5 to float
  %55 = add nsw i64 %indvars.iv.next21.4, %7
  %arrayidx58.5 = getelementptr inbounds float, float* %1, i64 %55
  store float %conv54.5, float* %arrayidx58.5, align 4
  br label %for.inc64.5

if.else.5:                                        ; preds = %for.end47.5
  %56 = add nsw i64 %indvars.iv.next21.4, %6
  %arrayidx62.5 = getelementptr inbounds float, float* %1, i64 %56
  store float %partial_sum.0.lcssa.5, float* %arrayidx62.5, align 4
  br label %for.inc64.5

for.inc64.5:                                      ; preds = %if.else.5, %if.then49.5
  %inc65.5 = add nsw i32 %in_j.011, 6
  %indvars.iv.next21.5 = add nsw i64 %indvars.iv20, 6
  br i1 %cmp124, label %for.end47.6, label %for.body14.6.preheader

for.body14.6.preheader:                           ; preds = %for.inc64.5
  br label %for.body14.6

for.body14.6:                                     ; preds = %for.body14.6.preheader, %for.inc45.6
  %ki.06.6 = phi i32 [ %inc46.6, %for.inc45.6 ], [ 0, %for.body14.6.preheader ]
  %partial_sum.05.6 = phi float [ %partial_sum.3.6, %for.inc45.6 ], [ 0.000000e+00, %for.body14.6.preheader ]
  %add.6 = add nsw i32 %ki.06.6, %in_i.015
  %notlhs.6 = icmp slt i32 %add.6, 0
  %notrhs.6 = icmp uge i32 %add.6, %img_height
  %.not.6 = or i1 %notrhs.6, %notlhs.6
  %brmerge.6 = or i1 %.not.6, %cmp211.not.6
  br i1 %brmerge.6, label %for.inc45.6, label %for.body23.lr.ph.6

for.body23.lr.ph.6:                               ; preds = %for.body14.6
  %mul.6 = shl i32 %add.6, 7
  %mul39.6 = mul i32 %ki.06.6, %kern_width
  br label %for.body23.6

for.body23.6:                                     ; preds = %for.inc.6, %for.body23.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body23.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc.6 ]
  %partial_sum.12.6 = phi float [ %partial_sum.05.6, %for.body23.lr.ph.6 ], [ %partial_sum.2.6, %for.inc.6 ]
  %57 = trunc i64 %indvars.iv.6 to i32
  %add24.6 = add nsw i32 %57, %inc65.5
  %cmp25.6 = icmp sgt i32 %add24.6, -1
  %cmp29.6 = icmp ult i32 %add24.6, %img_width
  %58 = and i1 %cmp25.6, %cmp29.6
  br i1 %58, label %if.end35.6, label %for.inc.6

if.end35.6:                                       ; preds = %for.body23.6
  %add38.6 = add nsw i32 %add24.6, %mul.6
  %idxprom.6 = sext i32 %add38.6 to i64
  %arrayidx.6 = getelementptr inbounds float, float* %0, i64 %idxprom.6
  %59 = load float, float* %arrayidx.6, align 4
  %60 = trunc i64 %indvars.iv.6 to i32
  %add40.6 = add i32 %60, %mul39.6
  %idxprom41.6 = zext i32 %add40.6 to i64
  %arrayidx42.6 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.6
  %61 = load float, float* %arrayidx42.6, align 4
  %mul43.6 = fmul float %59, %61
  %add44.6 = fadd float %partial_sum.12.6, %mul43.6
  br label %for.inc.6

for.inc.6:                                        ; preds = %if.end35.6, %for.body23.6
  %partial_sum.2.6 = phi float [ %add44.6, %if.end35.6 ], [ %partial_sum.12.6, %for.body23.6 ]
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %kern_width
  br i1 %exitcond.6, label %for.inc45.6.loopexit, label %for.body23.6, !llvm.loop !1

for.inc45.6.loopexit:                             ; preds = %for.inc.6
  %partial_sum.2.6.lcssa = phi float [ %partial_sum.2.6, %for.inc.6 ]
  br label %for.inc45.6

for.inc45.6:                                      ; preds = %for.inc45.6.loopexit, %for.body14.6
  %partial_sum.3.6 = phi float [ %partial_sum.05.6, %for.body14.6 ], [ %partial_sum.2.6.lcssa, %for.inc45.6.loopexit ]
  %inc46.6 = add nuw nsw i32 %ki.06.6, 1
  %exitcond19.6 = icmp eq i32 %inc46.6, %kern_height
  br i1 %exitcond19.6, label %for.end47.6.loopexit, label %for.body14.6, !llvm.loop !3

for.end47.6.loopexit:                             ; preds = %for.inc45.6
  %partial_sum.3.6.lcssa = phi float [ %partial_sum.3.6, %for.inc45.6 ]
  br label %for.end47.6

for.end47.6:                                      ; preds = %for.end47.6.loopexit, %for.inc64.5
  %partial_sum.0.lcssa.6 = phi float [ 0.000000e+00, %for.inc64.5 ], [ %partial_sum.3.6.lcssa, %for.end47.6.loopexit ]
  br i1 %tobool48, label %if.else.6, label %if.then49.6

if.then49.6:                                      ; preds = %for.end47.6
  %cmp50.6 = fcmp olt float %partial_sum.0.lcssa.6, 0.000000e+00
  %sub52.6 = fsub float -0.000000e+00, %partial_sum.0.lcssa.6
  %cond.6 = select i1 %cmp50.6, float %sub52.6, float %partial_sum.0.lcssa.6
  %conv53.6 = fptoui float %cond.6 to i8
  %conv54.6 = uitofp i8 %conv53.6 to float
  %62 = add nsw i64 %indvars.iv.next21.5, %7
  %arrayidx58.6 = getelementptr inbounds float, float* %1, i64 %62
  store float %conv54.6, float* %arrayidx58.6, align 4
  br label %for.inc64.6

if.else.6:                                        ; preds = %for.end47.6
  %63 = add nsw i64 %indvars.iv.next21.5, %6
  %arrayidx62.6 = getelementptr inbounds float, float* %1, i64 %63
  store float %partial_sum.0.lcssa.6, float* %arrayidx62.6, align 4
  br label %for.inc64.6

for.inc64.6:                                      ; preds = %if.else.6, %if.then49.6
  %inc65.6 = add nsw i32 %in_j.011, 7
  %indvars.iv.next21.6 = add nsw i64 %indvars.iv20, 7
  br i1 %cmp124, label %for.end47.7, label %for.body14.7.preheader

for.body14.7.preheader:                           ; preds = %for.inc64.6
  br label %for.body14.7

for.body14.7:                                     ; preds = %for.body14.7.preheader, %for.inc45.7
  %ki.06.7 = phi i32 [ %inc46.7, %for.inc45.7 ], [ 0, %for.body14.7.preheader ]
  %partial_sum.05.7 = phi float [ %partial_sum.3.7, %for.inc45.7 ], [ 0.000000e+00, %for.body14.7.preheader ]
  %add.7 = add nsw i32 %ki.06.7, %in_i.015
  %notlhs.7 = icmp slt i32 %add.7, 0
  %notrhs.7 = icmp uge i32 %add.7, %img_height
  %.not.7 = or i1 %notrhs.7, %notlhs.7
  %brmerge.7 = or i1 %.not.7, %cmp211.not.7
  br i1 %brmerge.7, label %for.inc45.7, label %for.body23.lr.ph.7

for.body23.lr.ph.7:                               ; preds = %for.body14.7
  %mul.7 = shl i32 %add.7, 7
  %mul39.7 = mul i32 %ki.06.7, %kern_width
  br label %for.body23.7

for.body23.7:                                     ; preds = %for.inc.7, %for.body23.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body23.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc.7 ]
  %partial_sum.12.7 = phi float [ %partial_sum.05.7, %for.body23.lr.ph.7 ], [ %partial_sum.2.7, %for.inc.7 ]
  %64 = trunc i64 %indvars.iv.7 to i32
  %add24.7 = add nsw i32 %64, %inc65.6
  %cmp25.7 = icmp sgt i32 %add24.7, -1
  %cmp29.7 = icmp ult i32 %add24.7, %img_width
  %65 = and i1 %cmp25.7, %cmp29.7
  br i1 %65, label %if.end35.7, label %for.inc.7

if.end35.7:                                       ; preds = %for.body23.7
  %add38.7 = add nsw i32 %add24.7, %mul.7
  %idxprom.7 = sext i32 %add38.7 to i64
  %arrayidx.7 = getelementptr inbounds float, float* %0, i64 %idxprom.7
  %66 = load float, float* %arrayidx.7, align 4
  %67 = trunc i64 %indvars.iv.7 to i32
  %add40.7 = add i32 %67, %mul39.7
  %idxprom41.7 = zext i32 %add40.7 to i64
  %arrayidx42.7 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.7
  %68 = load float, float* %arrayidx42.7, align 4
  %mul43.7 = fmul float %66, %68
  %add44.7 = fadd float %partial_sum.12.7, %mul43.7
  br label %for.inc.7

for.inc.7:                                        ; preds = %if.end35.7, %for.body23.7
  %partial_sum.2.7 = phi float [ %add44.7, %if.end35.7 ], [ %partial_sum.12.7, %for.body23.7 ]
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %kern_width
  br i1 %exitcond.7, label %for.inc45.7.loopexit, label %for.body23.7, !llvm.loop !1

for.inc45.7.loopexit:                             ; preds = %for.inc.7
  %partial_sum.2.7.lcssa = phi float [ %partial_sum.2.7, %for.inc.7 ]
  br label %for.inc45.7

for.inc45.7:                                      ; preds = %for.inc45.7.loopexit, %for.body14.7
  %partial_sum.3.7 = phi float [ %partial_sum.05.7, %for.body14.7 ], [ %partial_sum.2.7.lcssa, %for.inc45.7.loopexit ]
  %inc46.7 = add nuw nsw i32 %ki.06.7, 1
  %exitcond19.7 = icmp eq i32 %inc46.7, %kern_height
  br i1 %exitcond19.7, label %for.end47.7.loopexit, label %for.body14.7, !llvm.loop !3

for.end47.7.loopexit:                             ; preds = %for.inc45.7
  %partial_sum.3.7.lcssa = phi float [ %partial_sum.3.7, %for.inc45.7 ]
  br label %for.end47.7

for.end47.7:                                      ; preds = %for.end47.7.loopexit, %for.inc64.6
  %partial_sum.0.lcssa.7 = phi float [ 0.000000e+00, %for.inc64.6 ], [ %partial_sum.3.7.lcssa, %for.end47.7.loopexit ]
  br i1 %tobool48, label %if.else.7, label %if.then49.7

if.then49.7:                                      ; preds = %for.end47.7
  %cmp50.7 = fcmp olt float %partial_sum.0.lcssa.7, 0.000000e+00
  %sub52.7 = fsub float -0.000000e+00, %partial_sum.0.lcssa.7
  %cond.7 = select i1 %cmp50.7, float %sub52.7, float %partial_sum.0.lcssa.7
  %conv53.7 = fptoui float %cond.7 to i8
  %conv54.7 = uitofp i8 %conv53.7 to float
  %69 = add nsw i64 %indvars.iv.next21.6, %7
  %arrayidx58.7 = getelementptr inbounds float, float* %1, i64 %69
  store float %conv54.7, float* %arrayidx58.7, align 4
  br label %for.inc64.7

if.else.7:                                        ; preds = %for.end47.7
  %70 = add nsw i64 %indvars.iv.next21.6, %6
  %arrayidx62.7 = getelementptr inbounds float, float* %1, i64 %70
  store float %partial_sum.0.lcssa.7, float* %arrayidx62.7, align 4
  br label %for.inc64.7

for.inc64.7:                                      ; preds = %if.else.7, %if.then49.7
  %inc65.7 = add nsw i32 %in_j.011, 8
  %indvars.iv.next21.7 = add nsw i64 %indvars.iv20, 8
  br i1 %cmp124, label %for.end47.8, label %for.body14.8.preheader

for.body14.8.preheader:                           ; preds = %for.inc64.7
  br label %for.body14.8

for.body14.8:                                     ; preds = %for.body14.8.preheader, %for.inc45.8
  %ki.06.8 = phi i32 [ %inc46.8, %for.inc45.8 ], [ 0, %for.body14.8.preheader ]
  %partial_sum.05.8 = phi float [ %partial_sum.3.8, %for.inc45.8 ], [ 0.000000e+00, %for.body14.8.preheader ]
  %add.8 = add nsw i32 %ki.06.8, %in_i.015
  %notlhs.8 = icmp slt i32 %add.8, 0
  %notrhs.8 = icmp uge i32 %add.8, %img_height
  %.not.8 = or i1 %notrhs.8, %notlhs.8
  %brmerge.8 = or i1 %.not.8, %cmp211.not.8
  br i1 %brmerge.8, label %for.inc45.8, label %for.body23.lr.ph.8

for.body23.lr.ph.8:                               ; preds = %for.body14.8
  %mul.8 = shl i32 %add.8, 7
  %mul39.8 = mul i32 %ki.06.8, %kern_width
  br label %for.body23.8

for.body23.8:                                     ; preds = %for.inc.8, %for.body23.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body23.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc.8 ]
  %partial_sum.12.8 = phi float [ %partial_sum.05.8, %for.body23.lr.ph.8 ], [ %partial_sum.2.8, %for.inc.8 ]
  %71 = trunc i64 %indvars.iv.8 to i32
  %add24.8 = add nsw i32 %71, %inc65.7
  %cmp25.8 = icmp sgt i32 %add24.8, -1
  %cmp29.8 = icmp ult i32 %add24.8, %img_width
  %72 = and i1 %cmp25.8, %cmp29.8
  br i1 %72, label %if.end35.8, label %for.inc.8

if.end35.8:                                       ; preds = %for.body23.8
  %add38.8 = add nsw i32 %add24.8, %mul.8
  %idxprom.8 = sext i32 %add38.8 to i64
  %arrayidx.8 = getelementptr inbounds float, float* %0, i64 %idxprom.8
  %73 = load float, float* %arrayidx.8, align 4
  %74 = trunc i64 %indvars.iv.8 to i32
  %add40.8 = add i32 %74, %mul39.8
  %idxprom41.8 = zext i32 %add40.8 to i64
  %arrayidx42.8 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.8
  %75 = load float, float* %arrayidx42.8, align 4
  %mul43.8 = fmul float %73, %75
  %add44.8 = fadd float %partial_sum.12.8, %mul43.8
  br label %for.inc.8

for.inc.8:                                        ; preds = %if.end35.8, %for.body23.8
  %partial_sum.2.8 = phi float [ %add44.8, %if.end35.8 ], [ %partial_sum.12.8, %for.body23.8 ]
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %kern_width
  br i1 %exitcond.8, label %for.inc45.8.loopexit, label %for.body23.8, !llvm.loop !1

for.inc45.8.loopexit:                             ; preds = %for.inc.8
  %partial_sum.2.8.lcssa = phi float [ %partial_sum.2.8, %for.inc.8 ]
  br label %for.inc45.8

for.inc45.8:                                      ; preds = %for.inc45.8.loopexit, %for.body14.8
  %partial_sum.3.8 = phi float [ %partial_sum.05.8, %for.body14.8 ], [ %partial_sum.2.8.lcssa, %for.inc45.8.loopexit ]
  %inc46.8 = add nuw nsw i32 %ki.06.8, 1
  %exitcond19.8 = icmp eq i32 %inc46.8, %kern_height
  br i1 %exitcond19.8, label %for.end47.8.loopexit, label %for.body14.8, !llvm.loop !3

for.end47.8.loopexit:                             ; preds = %for.inc45.8
  %partial_sum.3.8.lcssa = phi float [ %partial_sum.3.8, %for.inc45.8 ]
  br label %for.end47.8

for.end47.8:                                      ; preds = %for.end47.8.loopexit, %for.inc64.7
  %partial_sum.0.lcssa.8 = phi float [ 0.000000e+00, %for.inc64.7 ], [ %partial_sum.3.8.lcssa, %for.end47.8.loopexit ]
  br i1 %tobool48, label %if.else.8, label %if.then49.8

if.then49.8:                                      ; preds = %for.end47.8
  %cmp50.8 = fcmp olt float %partial_sum.0.lcssa.8, 0.000000e+00
  %sub52.8 = fsub float -0.000000e+00, %partial_sum.0.lcssa.8
  %cond.8 = select i1 %cmp50.8, float %sub52.8, float %partial_sum.0.lcssa.8
  %conv53.8 = fptoui float %cond.8 to i8
  %conv54.8 = uitofp i8 %conv53.8 to float
  %76 = add nsw i64 %indvars.iv.next21.7, %7
  %arrayidx58.8 = getelementptr inbounds float, float* %1, i64 %76
  store float %conv54.8, float* %arrayidx58.8, align 4
  br label %for.inc64.8

if.else.8:                                        ; preds = %for.end47.8
  %77 = add nsw i64 %indvars.iv.next21.7, %6
  %arrayidx62.8 = getelementptr inbounds float, float* %1, i64 %77
  store float %partial_sum.0.lcssa.8, float* %arrayidx62.8, align 4
  br label %for.inc64.8

for.inc64.8:                                      ; preds = %if.else.8, %if.then49.8
  %inc65.8 = add nsw i32 %in_j.011, 9
  %indvars.iv.next21.8 = add nsw i64 %indvars.iv20, 9
  br i1 %cmp124, label %for.end47.9, label %for.body14.9.preheader

for.body14.9.preheader:                           ; preds = %for.inc64.8
  br label %for.body14.9

for.body14.9:                                     ; preds = %for.body14.9.preheader, %for.inc45.9
  %ki.06.9 = phi i32 [ %inc46.9, %for.inc45.9 ], [ 0, %for.body14.9.preheader ]
  %partial_sum.05.9 = phi float [ %partial_sum.3.9, %for.inc45.9 ], [ 0.000000e+00, %for.body14.9.preheader ]
  %add.9 = add nsw i32 %ki.06.9, %in_i.015
  %notlhs.9 = icmp slt i32 %add.9, 0
  %notrhs.9 = icmp uge i32 %add.9, %img_height
  %.not.9 = or i1 %notrhs.9, %notlhs.9
  %brmerge.9 = or i1 %.not.9, %cmp211.not.9
  br i1 %brmerge.9, label %for.inc45.9, label %for.body23.lr.ph.9

for.body23.lr.ph.9:                               ; preds = %for.body14.9
  %mul.9 = shl i32 %add.9, 7
  %mul39.9 = mul i32 %ki.06.9, %kern_width
  br label %for.body23.9

for.body23.9:                                     ; preds = %for.inc.9, %for.body23.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body23.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc.9 ]
  %partial_sum.12.9 = phi float [ %partial_sum.05.9, %for.body23.lr.ph.9 ], [ %partial_sum.2.9, %for.inc.9 ]
  %78 = trunc i64 %indvars.iv.9 to i32
  %add24.9 = add nsw i32 %78, %inc65.8
  %cmp25.9 = icmp sgt i32 %add24.9, -1
  %cmp29.9 = icmp ult i32 %add24.9, %img_width
  %79 = and i1 %cmp25.9, %cmp29.9
  br i1 %79, label %if.end35.9, label %for.inc.9

if.end35.9:                                       ; preds = %for.body23.9
  %add38.9 = add nsw i32 %add24.9, %mul.9
  %idxprom.9 = sext i32 %add38.9 to i64
  %arrayidx.9 = getelementptr inbounds float, float* %0, i64 %idxprom.9
  %80 = load float, float* %arrayidx.9, align 4
  %81 = trunc i64 %indvars.iv.9 to i32
  %add40.9 = add i32 %81, %mul39.9
  %idxprom41.9 = zext i32 %add40.9 to i64
  %arrayidx42.9 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.9
  %82 = load float, float* %arrayidx42.9, align 4
  %mul43.9 = fmul float %80, %82
  %add44.9 = fadd float %partial_sum.12.9, %mul43.9
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.end35.9, %for.body23.9
  %partial_sum.2.9 = phi float [ %add44.9, %if.end35.9 ], [ %partial_sum.12.9, %for.body23.9 ]
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %kern_width
  br i1 %exitcond.9, label %for.inc45.9.loopexit, label %for.body23.9, !llvm.loop !1

for.inc45.9.loopexit:                             ; preds = %for.inc.9
  %partial_sum.2.9.lcssa = phi float [ %partial_sum.2.9, %for.inc.9 ]
  br label %for.inc45.9

for.inc45.9:                                      ; preds = %for.inc45.9.loopexit, %for.body14.9
  %partial_sum.3.9 = phi float [ %partial_sum.05.9, %for.body14.9 ], [ %partial_sum.2.9.lcssa, %for.inc45.9.loopexit ]
  %inc46.9 = add nuw nsw i32 %ki.06.9, 1
  %exitcond19.9 = icmp eq i32 %inc46.9, %kern_height
  br i1 %exitcond19.9, label %for.end47.9.loopexit, label %for.body14.9, !llvm.loop !3

for.end47.9.loopexit:                             ; preds = %for.inc45.9
  %partial_sum.3.9.lcssa = phi float [ %partial_sum.3.9, %for.inc45.9 ]
  br label %for.end47.9

for.end47.9:                                      ; preds = %for.end47.9.loopexit, %for.inc64.8
  %partial_sum.0.lcssa.9 = phi float [ 0.000000e+00, %for.inc64.8 ], [ %partial_sum.3.9.lcssa, %for.end47.9.loopexit ]
  br i1 %tobool48, label %if.else.9, label %if.then49.9

if.then49.9:                                      ; preds = %for.end47.9
  %cmp50.9 = fcmp olt float %partial_sum.0.lcssa.9, 0.000000e+00
  %sub52.9 = fsub float -0.000000e+00, %partial_sum.0.lcssa.9
  %cond.9 = select i1 %cmp50.9, float %sub52.9, float %partial_sum.0.lcssa.9
  %conv53.9 = fptoui float %cond.9 to i8
  %conv54.9 = uitofp i8 %conv53.9 to float
  %83 = add nsw i64 %indvars.iv.next21.8, %7
  %arrayidx58.9 = getelementptr inbounds float, float* %1, i64 %83
  store float %conv54.9, float* %arrayidx58.9, align 4
  br label %for.inc64.9

if.else.9:                                        ; preds = %for.end47.9
  %84 = add nsw i64 %indvars.iv.next21.8, %6
  %arrayidx62.9 = getelementptr inbounds float, float* %1, i64 %84
  store float %partial_sum.0.lcssa.9, float* %arrayidx62.9, align 4
  br label %for.inc64.9

for.inc64.9:                                      ; preds = %if.else.9, %if.then49.9
  %inc65.9 = add nsw i32 %in_j.011, 10
  %indvars.iv.next21.9 = add nsw i64 %indvars.iv20, 10
  br i1 %cmp124, label %for.end47.10, label %for.body14.10.preheader

for.body14.10.preheader:                          ; preds = %for.inc64.9
  br label %for.body14.10

for.body14.10:                                    ; preds = %for.body14.10.preheader, %for.inc45.10
  %ki.06.10 = phi i32 [ %inc46.10, %for.inc45.10 ], [ 0, %for.body14.10.preheader ]
  %partial_sum.05.10 = phi float [ %partial_sum.3.10, %for.inc45.10 ], [ 0.000000e+00, %for.body14.10.preheader ]
  %add.10 = add nsw i32 %ki.06.10, %in_i.015
  %notlhs.10 = icmp slt i32 %add.10, 0
  %notrhs.10 = icmp uge i32 %add.10, %img_height
  %.not.10 = or i1 %notrhs.10, %notlhs.10
  %brmerge.10 = or i1 %.not.10, %cmp211.not.10
  br i1 %brmerge.10, label %for.inc45.10, label %for.body23.lr.ph.10

for.body23.lr.ph.10:                              ; preds = %for.body14.10
  %mul.10 = shl i32 %add.10, 7
  %mul39.10 = mul i32 %ki.06.10, %kern_width
  br label %for.body23.10

for.body23.10:                                    ; preds = %for.inc.10, %for.body23.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body23.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc.10 ]
  %partial_sum.12.10 = phi float [ %partial_sum.05.10, %for.body23.lr.ph.10 ], [ %partial_sum.2.10, %for.inc.10 ]
  %85 = trunc i64 %indvars.iv.10 to i32
  %add24.10 = add nsw i32 %85, %inc65.9
  %cmp25.10 = icmp sgt i32 %add24.10, -1
  %cmp29.10 = icmp ult i32 %add24.10, %img_width
  %86 = and i1 %cmp25.10, %cmp29.10
  br i1 %86, label %if.end35.10, label %for.inc.10

if.end35.10:                                      ; preds = %for.body23.10
  %add38.10 = add nsw i32 %add24.10, %mul.10
  %idxprom.10 = sext i32 %add38.10 to i64
  %arrayidx.10 = getelementptr inbounds float, float* %0, i64 %idxprom.10
  %87 = load float, float* %arrayidx.10, align 4
  %88 = trunc i64 %indvars.iv.10 to i32
  %add40.10 = add i32 %88, %mul39.10
  %idxprom41.10 = zext i32 %add40.10 to i64
  %arrayidx42.10 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.10
  %89 = load float, float* %arrayidx42.10, align 4
  %mul43.10 = fmul float %87, %89
  %add44.10 = fadd float %partial_sum.12.10, %mul43.10
  br label %for.inc.10

for.inc.10:                                       ; preds = %if.end35.10, %for.body23.10
  %partial_sum.2.10 = phi float [ %add44.10, %if.end35.10 ], [ %partial_sum.12.10, %for.body23.10 ]
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %kern_width
  br i1 %exitcond.10, label %for.inc45.10.loopexit, label %for.body23.10, !llvm.loop !1

for.inc45.10.loopexit:                            ; preds = %for.inc.10
  %partial_sum.2.10.lcssa = phi float [ %partial_sum.2.10, %for.inc.10 ]
  br label %for.inc45.10

for.inc45.10:                                     ; preds = %for.inc45.10.loopexit, %for.body14.10
  %partial_sum.3.10 = phi float [ %partial_sum.05.10, %for.body14.10 ], [ %partial_sum.2.10.lcssa, %for.inc45.10.loopexit ]
  %inc46.10 = add nuw nsw i32 %ki.06.10, 1
  %exitcond19.10 = icmp eq i32 %inc46.10, %kern_height
  br i1 %exitcond19.10, label %for.end47.10.loopexit, label %for.body14.10, !llvm.loop !3

for.end47.10.loopexit:                            ; preds = %for.inc45.10
  %partial_sum.3.10.lcssa = phi float [ %partial_sum.3.10, %for.inc45.10 ]
  br label %for.end47.10

for.end47.10:                                     ; preds = %for.end47.10.loopexit, %for.inc64.9
  %partial_sum.0.lcssa.10 = phi float [ 0.000000e+00, %for.inc64.9 ], [ %partial_sum.3.10.lcssa, %for.end47.10.loopexit ]
  br i1 %tobool48, label %if.else.10, label %if.then49.10

if.then49.10:                                     ; preds = %for.end47.10
  %cmp50.10 = fcmp olt float %partial_sum.0.lcssa.10, 0.000000e+00
  %sub52.10 = fsub float -0.000000e+00, %partial_sum.0.lcssa.10
  %cond.10 = select i1 %cmp50.10, float %sub52.10, float %partial_sum.0.lcssa.10
  %conv53.10 = fptoui float %cond.10 to i8
  %conv54.10 = uitofp i8 %conv53.10 to float
  %90 = add nsw i64 %indvars.iv.next21.9, %7
  %arrayidx58.10 = getelementptr inbounds float, float* %1, i64 %90
  store float %conv54.10, float* %arrayidx58.10, align 4
  br label %for.inc64.10

if.else.10:                                       ; preds = %for.end47.10
  %91 = add nsw i64 %indvars.iv.next21.9, %6
  %arrayidx62.10 = getelementptr inbounds float, float* %1, i64 %91
  store float %partial_sum.0.lcssa.10, float* %arrayidx62.10, align 4
  br label %for.inc64.10

for.inc64.10:                                     ; preds = %if.else.10, %if.then49.10
  %inc65.10 = add nsw i32 %in_j.011, 11
  %indvars.iv.next21.10 = add nsw i64 %indvars.iv20, 11
  br i1 %cmp124, label %for.end47.11, label %for.body14.11.preheader

for.body14.11.preheader:                          ; preds = %for.inc64.10
  br label %for.body14.11

for.body14.11:                                    ; preds = %for.body14.11.preheader, %for.inc45.11
  %ki.06.11 = phi i32 [ %inc46.11, %for.inc45.11 ], [ 0, %for.body14.11.preheader ]
  %partial_sum.05.11 = phi float [ %partial_sum.3.11, %for.inc45.11 ], [ 0.000000e+00, %for.body14.11.preheader ]
  %add.11 = add nsw i32 %ki.06.11, %in_i.015
  %notlhs.11 = icmp slt i32 %add.11, 0
  %notrhs.11 = icmp uge i32 %add.11, %img_height
  %.not.11 = or i1 %notrhs.11, %notlhs.11
  %brmerge.11 = or i1 %.not.11, %cmp211.not.11
  br i1 %brmerge.11, label %for.inc45.11, label %for.body23.lr.ph.11

for.body23.lr.ph.11:                              ; preds = %for.body14.11
  %mul.11 = shl i32 %add.11, 7
  %mul39.11 = mul i32 %ki.06.11, %kern_width
  br label %for.body23.11

for.body23.11:                                    ; preds = %for.inc.11, %for.body23.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body23.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc.11 ]
  %partial_sum.12.11 = phi float [ %partial_sum.05.11, %for.body23.lr.ph.11 ], [ %partial_sum.2.11, %for.inc.11 ]
  %92 = trunc i64 %indvars.iv.11 to i32
  %add24.11 = add nsw i32 %92, %inc65.10
  %cmp25.11 = icmp sgt i32 %add24.11, -1
  %cmp29.11 = icmp ult i32 %add24.11, %img_width
  %93 = and i1 %cmp25.11, %cmp29.11
  br i1 %93, label %if.end35.11, label %for.inc.11

if.end35.11:                                      ; preds = %for.body23.11
  %add38.11 = add nsw i32 %add24.11, %mul.11
  %idxprom.11 = sext i32 %add38.11 to i64
  %arrayidx.11 = getelementptr inbounds float, float* %0, i64 %idxprom.11
  %94 = load float, float* %arrayidx.11, align 4
  %95 = trunc i64 %indvars.iv.11 to i32
  %add40.11 = add i32 %95, %mul39.11
  %idxprom41.11 = zext i32 %add40.11 to i64
  %arrayidx42.11 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.11
  %96 = load float, float* %arrayidx42.11, align 4
  %mul43.11 = fmul float %94, %96
  %add44.11 = fadd float %partial_sum.12.11, %mul43.11
  br label %for.inc.11

for.inc.11:                                       ; preds = %if.end35.11, %for.body23.11
  %partial_sum.2.11 = phi float [ %add44.11, %if.end35.11 ], [ %partial_sum.12.11, %for.body23.11 ]
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %kern_width
  br i1 %exitcond.11, label %for.inc45.11.loopexit, label %for.body23.11, !llvm.loop !1

for.inc45.11.loopexit:                            ; preds = %for.inc.11
  %partial_sum.2.11.lcssa = phi float [ %partial_sum.2.11, %for.inc.11 ]
  br label %for.inc45.11

for.inc45.11:                                     ; preds = %for.inc45.11.loopexit, %for.body14.11
  %partial_sum.3.11 = phi float [ %partial_sum.05.11, %for.body14.11 ], [ %partial_sum.2.11.lcssa, %for.inc45.11.loopexit ]
  %inc46.11 = add nuw nsw i32 %ki.06.11, 1
  %exitcond19.11 = icmp eq i32 %inc46.11, %kern_height
  br i1 %exitcond19.11, label %for.end47.11.loopexit, label %for.body14.11, !llvm.loop !3

for.end47.11.loopexit:                            ; preds = %for.inc45.11
  %partial_sum.3.11.lcssa = phi float [ %partial_sum.3.11, %for.inc45.11 ]
  br label %for.end47.11

for.end47.11:                                     ; preds = %for.end47.11.loopexit, %for.inc64.10
  %partial_sum.0.lcssa.11 = phi float [ 0.000000e+00, %for.inc64.10 ], [ %partial_sum.3.11.lcssa, %for.end47.11.loopexit ]
  br i1 %tobool48, label %if.else.11, label %if.then49.11

if.then49.11:                                     ; preds = %for.end47.11
  %cmp50.11 = fcmp olt float %partial_sum.0.lcssa.11, 0.000000e+00
  %sub52.11 = fsub float -0.000000e+00, %partial_sum.0.lcssa.11
  %cond.11 = select i1 %cmp50.11, float %sub52.11, float %partial_sum.0.lcssa.11
  %conv53.11 = fptoui float %cond.11 to i8
  %conv54.11 = uitofp i8 %conv53.11 to float
  %97 = add nsw i64 %indvars.iv.next21.10, %7
  %arrayidx58.11 = getelementptr inbounds float, float* %1, i64 %97
  store float %conv54.11, float* %arrayidx58.11, align 4
  br label %for.inc64.11

if.else.11:                                       ; preds = %for.end47.11
  %98 = add nsw i64 %indvars.iv.next21.10, %6
  %arrayidx62.11 = getelementptr inbounds float, float* %1, i64 %98
  store float %partial_sum.0.lcssa.11, float* %arrayidx62.11, align 4
  br label %for.inc64.11

for.inc64.11:                                     ; preds = %if.else.11, %if.then49.11
  %inc65.11 = add nsw i32 %in_j.011, 12
  %indvars.iv.next21.11 = add nsw i64 %indvars.iv20, 12
  br i1 %cmp124, label %for.end47.12, label %for.body14.12.preheader

for.body14.12.preheader:                          ; preds = %for.inc64.11
  br label %for.body14.12

for.body14.12:                                    ; preds = %for.body14.12.preheader, %for.inc45.12
  %ki.06.12 = phi i32 [ %inc46.12, %for.inc45.12 ], [ 0, %for.body14.12.preheader ]
  %partial_sum.05.12 = phi float [ %partial_sum.3.12, %for.inc45.12 ], [ 0.000000e+00, %for.body14.12.preheader ]
  %add.12 = add nsw i32 %ki.06.12, %in_i.015
  %notlhs.12 = icmp slt i32 %add.12, 0
  %notrhs.12 = icmp uge i32 %add.12, %img_height
  %.not.12 = or i1 %notrhs.12, %notlhs.12
  %brmerge.12 = or i1 %.not.12, %cmp211.not.12
  br i1 %brmerge.12, label %for.inc45.12, label %for.body23.lr.ph.12

for.body23.lr.ph.12:                              ; preds = %for.body14.12
  %mul.12 = shl i32 %add.12, 7
  %mul39.12 = mul i32 %ki.06.12, %kern_width
  br label %for.body23.12

for.body23.12:                                    ; preds = %for.inc.12, %for.body23.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body23.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc.12 ]
  %partial_sum.12.12 = phi float [ %partial_sum.05.12, %for.body23.lr.ph.12 ], [ %partial_sum.2.12, %for.inc.12 ]
  %99 = trunc i64 %indvars.iv.12 to i32
  %add24.12 = add nsw i32 %99, %inc65.11
  %cmp25.12 = icmp sgt i32 %add24.12, -1
  %cmp29.12 = icmp ult i32 %add24.12, %img_width
  %100 = and i1 %cmp25.12, %cmp29.12
  br i1 %100, label %if.end35.12, label %for.inc.12

if.end35.12:                                      ; preds = %for.body23.12
  %add38.12 = add nsw i32 %add24.12, %mul.12
  %idxprom.12 = sext i32 %add38.12 to i64
  %arrayidx.12 = getelementptr inbounds float, float* %0, i64 %idxprom.12
  %101 = load float, float* %arrayidx.12, align 4
  %102 = trunc i64 %indvars.iv.12 to i32
  %add40.12 = add i32 %102, %mul39.12
  %idxprom41.12 = zext i32 %add40.12 to i64
  %arrayidx42.12 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.12
  %103 = load float, float* %arrayidx42.12, align 4
  %mul43.12 = fmul float %101, %103
  %add44.12 = fadd float %partial_sum.12.12, %mul43.12
  br label %for.inc.12

for.inc.12:                                       ; preds = %if.end35.12, %for.body23.12
  %partial_sum.2.12 = phi float [ %add44.12, %if.end35.12 ], [ %partial_sum.12.12, %for.body23.12 ]
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %kern_width
  br i1 %exitcond.12, label %for.inc45.12.loopexit, label %for.body23.12, !llvm.loop !1

for.inc45.12.loopexit:                            ; preds = %for.inc.12
  %partial_sum.2.12.lcssa = phi float [ %partial_sum.2.12, %for.inc.12 ]
  br label %for.inc45.12

for.inc45.12:                                     ; preds = %for.inc45.12.loopexit, %for.body14.12
  %partial_sum.3.12 = phi float [ %partial_sum.05.12, %for.body14.12 ], [ %partial_sum.2.12.lcssa, %for.inc45.12.loopexit ]
  %inc46.12 = add nuw nsw i32 %ki.06.12, 1
  %exitcond19.12 = icmp eq i32 %inc46.12, %kern_height
  br i1 %exitcond19.12, label %for.end47.12.loopexit, label %for.body14.12, !llvm.loop !3

for.end47.12.loopexit:                            ; preds = %for.inc45.12
  %partial_sum.3.12.lcssa = phi float [ %partial_sum.3.12, %for.inc45.12 ]
  br label %for.end47.12

for.end47.12:                                     ; preds = %for.end47.12.loopexit, %for.inc64.11
  %partial_sum.0.lcssa.12 = phi float [ 0.000000e+00, %for.inc64.11 ], [ %partial_sum.3.12.lcssa, %for.end47.12.loopexit ]
  br i1 %tobool48, label %if.else.12, label %if.then49.12

if.then49.12:                                     ; preds = %for.end47.12
  %cmp50.12 = fcmp olt float %partial_sum.0.lcssa.12, 0.000000e+00
  %sub52.12 = fsub float -0.000000e+00, %partial_sum.0.lcssa.12
  %cond.12 = select i1 %cmp50.12, float %sub52.12, float %partial_sum.0.lcssa.12
  %conv53.12 = fptoui float %cond.12 to i8
  %conv54.12 = uitofp i8 %conv53.12 to float
  %104 = add nsw i64 %indvars.iv.next21.11, %7
  %arrayidx58.12 = getelementptr inbounds float, float* %1, i64 %104
  store float %conv54.12, float* %arrayidx58.12, align 4
  br label %for.inc64.12

if.else.12:                                       ; preds = %for.end47.12
  %105 = add nsw i64 %indvars.iv.next21.11, %6
  %arrayidx62.12 = getelementptr inbounds float, float* %1, i64 %105
  store float %partial_sum.0.lcssa.12, float* %arrayidx62.12, align 4
  br label %for.inc64.12

for.inc64.12:                                     ; preds = %if.else.12, %if.then49.12
  %inc65.12 = add nsw i32 %in_j.011, 13
  %indvars.iv.next21.12 = add nsw i64 %indvars.iv20, 13
  br i1 %cmp124, label %for.end47.13, label %for.body14.13.preheader

for.body14.13.preheader:                          ; preds = %for.inc64.12
  br label %for.body14.13

for.body14.13:                                    ; preds = %for.body14.13.preheader, %for.inc45.13
  %ki.06.13 = phi i32 [ %inc46.13, %for.inc45.13 ], [ 0, %for.body14.13.preheader ]
  %partial_sum.05.13 = phi float [ %partial_sum.3.13, %for.inc45.13 ], [ 0.000000e+00, %for.body14.13.preheader ]
  %add.13 = add nsw i32 %ki.06.13, %in_i.015
  %notlhs.13 = icmp slt i32 %add.13, 0
  %notrhs.13 = icmp uge i32 %add.13, %img_height
  %.not.13 = or i1 %notrhs.13, %notlhs.13
  %brmerge.13 = or i1 %.not.13, %cmp211.not.13
  br i1 %brmerge.13, label %for.inc45.13, label %for.body23.lr.ph.13

for.body23.lr.ph.13:                              ; preds = %for.body14.13
  %mul.13 = shl i32 %add.13, 7
  %mul39.13 = mul i32 %ki.06.13, %kern_width
  br label %for.body23.13

for.body23.13:                                    ; preds = %for.inc.13, %for.body23.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body23.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc.13 ]
  %partial_sum.12.13 = phi float [ %partial_sum.05.13, %for.body23.lr.ph.13 ], [ %partial_sum.2.13, %for.inc.13 ]
  %106 = trunc i64 %indvars.iv.13 to i32
  %add24.13 = add nsw i32 %106, %inc65.12
  %cmp25.13 = icmp sgt i32 %add24.13, -1
  %cmp29.13 = icmp ult i32 %add24.13, %img_width
  %107 = and i1 %cmp25.13, %cmp29.13
  br i1 %107, label %if.end35.13, label %for.inc.13

if.end35.13:                                      ; preds = %for.body23.13
  %add38.13 = add nsw i32 %add24.13, %mul.13
  %idxprom.13 = sext i32 %add38.13 to i64
  %arrayidx.13 = getelementptr inbounds float, float* %0, i64 %idxprom.13
  %108 = load float, float* %arrayidx.13, align 4
  %109 = trunc i64 %indvars.iv.13 to i32
  %add40.13 = add i32 %109, %mul39.13
  %idxprom41.13 = zext i32 %add40.13 to i64
  %arrayidx42.13 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.13
  %110 = load float, float* %arrayidx42.13, align 4
  %mul43.13 = fmul float %108, %110
  %add44.13 = fadd float %partial_sum.12.13, %mul43.13
  br label %for.inc.13

for.inc.13:                                       ; preds = %if.end35.13, %for.body23.13
  %partial_sum.2.13 = phi float [ %add44.13, %if.end35.13 ], [ %partial_sum.12.13, %for.body23.13 ]
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %kern_width
  br i1 %exitcond.13, label %for.inc45.13.loopexit, label %for.body23.13, !llvm.loop !1

for.inc45.13.loopexit:                            ; preds = %for.inc.13
  %partial_sum.2.13.lcssa = phi float [ %partial_sum.2.13, %for.inc.13 ]
  br label %for.inc45.13

for.inc45.13:                                     ; preds = %for.inc45.13.loopexit, %for.body14.13
  %partial_sum.3.13 = phi float [ %partial_sum.05.13, %for.body14.13 ], [ %partial_sum.2.13.lcssa, %for.inc45.13.loopexit ]
  %inc46.13 = add nuw nsw i32 %ki.06.13, 1
  %exitcond19.13 = icmp eq i32 %inc46.13, %kern_height
  br i1 %exitcond19.13, label %for.end47.13.loopexit, label %for.body14.13, !llvm.loop !3

for.end47.13.loopexit:                            ; preds = %for.inc45.13
  %partial_sum.3.13.lcssa = phi float [ %partial_sum.3.13, %for.inc45.13 ]
  br label %for.end47.13

for.end47.13:                                     ; preds = %for.end47.13.loopexit, %for.inc64.12
  %partial_sum.0.lcssa.13 = phi float [ 0.000000e+00, %for.inc64.12 ], [ %partial_sum.3.13.lcssa, %for.end47.13.loopexit ]
  br i1 %tobool48, label %if.else.13, label %if.then49.13

if.then49.13:                                     ; preds = %for.end47.13
  %cmp50.13 = fcmp olt float %partial_sum.0.lcssa.13, 0.000000e+00
  %sub52.13 = fsub float -0.000000e+00, %partial_sum.0.lcssa.13
  %cond.13 = select i1 %cmp50.13, float %sub52.13, float %partial_sum.0.lcssa.13
  %conv53.13 = fptoui float %cond.13 to i8
  %conv54.13 = uitofp i8 %conv53.13 to float
  %111 = add nsw i64 %indvars.iv.next21.12, %7
  %arrayidx58.13 = getelementptr inbounds float, float* %1, i64 %111
  store float %conv54.13, float* %arrayidx58.13, align 4
  br label %for.inc64.13

if.else.13:                                       ; preds = %for.end47.13
  %112 = add nsw i64 %indvars.iv.next21.12, %6
  %arrayidx62.13 = getelementptr inbounds float, float* %1, i64 %112
  store float %partial_sum.0.lcssa.13, float* %arrayidx62.13, align 4
  br label %for.inc64.13

for.inc64.13:                                     ; preds = %if.else.13, %if.then49.13
  %inc65.13 = add nsw i32 %in_j.011, 14
  %indvars.iv.next21.13 = add nsw i64 %indvars.iv20, 14
  br i1 %cmp124, label %for.end47.14, label %for.body14.14.preheader

for.body14.14.preheader:                          ; preds = %for.inc64.13
  br label %for.body14.14

for.body14.14:                                    ; preds = %for.body14.14.preheader, %for.inc45.14
  %ki.06.14 = phi i32 [ %inc46.14, %for.inc45.14 ], [ 0, %for.body14.14.preheader ]
  %partial_sum.05.14 = phi float [ %partial_sum.3.14, %for.inc45.14 ], [ 0.000000e+00, %for.body14.14.preheader ]
  %add.14 = add nsw i32 %ki.06.14, %in_i.015
  %notlhs.14 = icmp slt i32 %add.14, 0
  %notrhs.14 = icmp uge i32 %add.14, %img_height
  %.not.14 = or i1 %notrhs.14, %notlhs.14
  %brmerge.14 = or i1 %.not.14, %cmp211.not.14
  br i1 %brmerge.14, label %for.inc45.14, label %for.body23.lr.ph.14

for.body23.lr.ph.14:                              ; preds = %for.body14.14
  %mul.14 = shl i32 %add.14, 7
  %mul39.14 = mul i32 %ki.06.14, %kern_width
  br label %for.body23.14

for.body23.14:                                    ; preds = %for.inc.14, %for.body23.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body23.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc.14 ]
  %partial_sum.12.14 = phi float [ %partial_sum.05.14, %for.body23.lr.ph.14 ], [ %partial_sum.2.14, %for.inc.14 ]
  %113 = trunc i64 %indvars.iv.14 to i32
  %add24.14 = add nsw i32 %113, %inc65.13
  %cmp25.14 = icmp sgt i32 %add24.14, -1
  %cmp29.14 = icmp ult i32 %add24.14, %img_width
  %114 = and i1 %cmp25.14, %cmp29.14
  br i1 %114, label %if.end35.14, label %for.inc.14

if.end35.14:                                      ; preds = %for.body23.14
  %add38.14 = add nsw i32 %add24.14, %mul.14
  %idxprom.14 = sext i32 %add38.14 to i64
  %arrayidx.14 = getelementptr inbounds float, float* %0, i64 %idxprom.14
  %115 = load float, float* %arrayidx.14, align 4
  %116 = trunc i64 %indvars.iv.14 to i32
  %add40.14 = add i32 %116, %mul39.14
  %idxprom41.14 = zext i32 %add40.14 to i64
  %arrayidx42.14 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.14
  %117 = load float, float* %arrayidx42.14, align 4
  %mul43.14 = fmul float %115, %117
  %add44.14 = fadd float %partial_sum.12.14, %mul43.14
  br label %for.inc.14

for.inc.14:                                       ; preds = %if.end35.14, %for.body23.14
  %partial_sum.2.14 = phi float [ %add44.14, %if.end35.14 ], [ %partial_sum.12.14, %for.body23.14 ]
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %kern_width
  br i1 %exitcond.14, label %for.inc45.14.loopexit, label %for.body23.14, !llvm.loop !1

for.inc45.14.loopexit:                            ; preds = %for.inc.14
  %partial_sum.2.14.lcssa = phi float [ %partial_sum.2.14, %for.inc.14 ]
  br label %for.inc45.14

for.inc45.14:                                     ; preds = %for.inc45.14.loopexit, %for.body14.14
  %partial_sum.3.14 = phi float [ %partial_sum.05.14, %for.body14.14 ], [ %partial_sum.2.14.lcssa, %for.inc45.14.loopexit ]
  %inc46.14 = add nuw nsw i32 %ki.06.14, 1
  %exitcond19.14 = icmp eq i32 %inc46.14, %kern_height
  br i1 %exitcond19.14, label %for.end47.14.loopexit, label %for.body14.14, !llvm.loop !3

for.end47.14.loopexit:                            ; preds = %for.inc45.14
  %partial_sum.3.14.lcssa = phi float [ %partial_sum.3.14, %for.inc45.14 ]
  br label %for.end47.14

for.end47.14:                                     ; preds = %for.end47.14.loopexit, %for.inc64.13
  %partial_sum.0.lcssa.14 = phi float [ 0.000000e+00, %for.inc64.13 ], [ %partial_sum.3.14.lcssa, %for.end47.14.loopexit ]
  br i1 %tobool48, label %if.else.14, label %if.then49.14

if.then49.14:                                     ; preds = %for.end47.14
  %cmp50.14 = fcmp olt float %partial_sum.0.lcssa.14, 0.000000e+00
  %sub52.14 = fsub float -0.000000e+00, %partial_sum.0.lcssa.14
  %cond.14 = select i1 %cmp50.14, float %sub52.14, float %partial_sum.0.lcssa.14
  %conv53.14 = fptoui float %cond.14 to i8
  %conv54.14 = uitofp i8 %conv53.14 to float
  %118 = add nsw i64 %indvars.iv.next21.13, %7
  %arrayidx58.14 = getelementptr inbounds float, float* %1, i64 %118
  store float %conv54.14, float* %arrayidx58.14, align 4
  br label %for.inc64.14

if.else.14:                                       ; preds = %for.end47.14
  %119 = add nsw i64 %indvars.iv.next21.13, %6
  %arrayidx62.14 = getelementptr inbounds float, float* %1, i64 %119
  store float %partial_sum.0.lcssa.14, float* %arrayidx62.14, align 4
  br label %for.inc64.14

for.inc64.14:                                     ; preds = %if.else.14, %if.then49.14
  %inc65.14 = add nsw i32 %in_j.011, 15
  %indvars.iv.next21.14 = add nsw i64 %indvars.iv20, 15
  br i1 %cmp124, label %for.end47.15, label %for.body14.15.preheader

for.body14.15.preheader:                          ; preds = %for.inc64.14
  br label %for.body14.15

for.body14.15:                                    ; preds = %for.body14.15.preheader, %for.inc45.15
  %ki.06.15 = phi i32 [ %inc46.15, %for.inc45.15 ], [ 0, %for.body14.15.preheader ]
  %partial_sum.05.15 = phi float [ %partial_sum.3.15, %for.inc45.15 ], [ 0.000000e+00, %for.body14.15.preheader ]
  %add.15 = add nsw i32 %ki.06.15, %in_i.015
  %notlhs.15 = icmp slt i32 %add.15, 0
  %notrhs.15 = icmp uge i32 %add.15, %img_height
  %.not.15 = or i1 %notrhs.15, %notlhs.15
  %brmerge.15 = or i1 %.not.15, %cmp211.not.15
  br i1 %brmerge.15, label %for.inc45.15, label %for.body23.lr.ph.15

for.body23.lr.ph.15:                              ; preds = %for.body14.15
  %mul.15 = shl i32 %add.15, 7
  %mul39.15 = mul i32 %ki.06.15, %kern_width
  br label %for.body23.15

for.body23.15:                                    ; preds = %for.inc.15, %for.body23.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body23.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc.15 ]
  %partial_sum.12.15 = phi float [ %partial_sum.05.15, %for.body23.lr.ph.15 ], [ %partial_sum.2.15, %for.inc.15 ]
  %120 = trunc i64 %indvars.iv.15 to i32
  %add24.15 = add nsw i32 %120, %inc65.14
  %cmp25.15 = icmp sgt i32 %add24.15, -1
  %cmp29.15 = icmp ult i32 %add24.15, %img_width
  %121 = and i1 %cmp25.15, %cmp29.15
  br i1 %121, label %if.end35.15, label %for.inc.15

if.end35.15:                                      ; preds = %for.body23.15
  %add38.15 = add nsw i32 %add24.15, %mul.15
  %idxprom.15 = sext i32 %add38.15 to i64
  %arrayidx.15 = getelementptr inbounds float, float* %0, i64 %idxprom.15
  %122 = load float, float* %arrayidx.15, align 4
  %123 = trunc i64 %indvars.iv.15 to i32
  %add40.15 = add i32 %123, %mul39.15
  %idxprom41.15 = zext i32 %add40.15 to i64
  %arrayidx42.15 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.15
  %124 = load float, float* %arrayidx42.15, align 4
  %mul43.15 = fmul float %122, %124
  %add44.15 = fadd float %partial_sum.12.15, %mul43.15
  br label %for.inc.15

for.inc.15:                                       ; preds = %if.end35.15, %for.body23.15
  %partial_sum.2.15 = phi float [ %add44.15, %if.end35.15 ], [ %partial_sum.12.15, %for.body23.15 ]
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %kern_width
  br i1 %exitcond.15, label %for.inc45.15.loopexit, label %for.body23.15, !llvm.loop !1

for.inc45.15.loopexit:                            ; preds = %for.inc.15
  %partial_sum.2.15.lcssa = phi float [ %partial_sum.2.15, %for.inc.15 ]
  br label %for.inc45.15

for.inc45.15:                                     ; preds = %for.inc45.15.loopexit, %for.body14.15
  %partial_sum.3.15 = phi float [ %partial_sum.05.15, %for.body14.15 ], [ %partial_sum.2.15.lcssa, %for.inc45.15.loopexit ]
  %inc46.15 = add nuw nsw i32 %ki.06.15, 1
  %exitcond19.15 = icmp eq i32 %inc46.15, %kern_height
  br i1 %exitcond19.15, label %for.end47.15.loopexit, label %for.body14.15, !llvm.loop !3

for.end47.15.loopexit:                            ; preds = %for.inc45.15
  %partial_sum.3.15.lcssa = phi float [ %partial_sum.3.15, %for.inc45.15 ]
  br label %for.end47.15

for.end47.15:                                     ; preds = %for.end47.15.loopexit, %for.inc64.14
  %partial_sum.0.lcssa.15 = phi float [ 0.000000e+00, %for.inc64.14 ], [ %partial_sum.3.15.lcssa, %for.end47.15.loopexit ]
  br i1 %tobool48, label %if.else.15, label %if.then49.15

if.then49.15:                                     ; preds = %for.end47.15
  %cmp50.15 = fcmp olt float %partial_sum.0.lcssa.15, 0.000000e+00
  %sub52.15 = fsub float -0.000000e+00, %partial_sum.0.lcssa.15
  %cond.15 = select i1 %cmp50.15, float %sub52.15, float %partial_sum.0.lcssa.15
  %conv53.15 = fptoui float %cond.15 to i8
  %conv54.15 = uitofp i8 %conv53.15 to float
  %125 = add nsw i64 %indvars.iv.next21.14, %7
  %arrayidx58.15 = getelementptr inbounds float, float* %1, i64 %125
  store float %conv54.15, float* %arrayidx58.15, align 4
  br label %for.inc64.15

if.else.15:                                       ; preds = %for.end47.15
  %126 = add nsw i64 %indvars.iv.next21.14, %6
  %arrayidx62.15 = getelementptr inbounds float, float* %1, i64 %126
  store float %partial_sum.0.lcssa.15, float* %arrayidx62.15, align 4
  br label %for.inc64.15

for.inc64.15:                                     ; preds = %if.else.15, %if.then49.15
  %inc65.15 = add nsw i32 %in_j.011, 16
  %indvars.iv.next21.15 = add nsw i64 %indvars.iv20, 16
  br i1 %cmp124, label %for.end47.16, label %for.body14.16.preheader

for.body14.16.preheader:                          ; preds = %for.inc64.15
  br label %for.body14.16

for.body14.16:                                    ; preds = %for.body14.16.preheader, %for.inc45.16
  %ki.06.16 = phi i32 [ %inc46.16, %for.inc45.16 ], [ 0, %for.body14.16.preheader ]
  %partial_sum.05.16 = phi float [ %partial_sum.3.16, %for.inc45.16 ], [ 0.000000e+00, %for.body14.16.preheader ]
  %add.16 = add nsw i32 %ki.06.16, %in_i.015
  %notlhs.16 = icmp slt i32 %add.16, 0
  %notrhs.16 = icmp uge i32 %add.16, %img_height
  %.not.16 = or i1 %notrhs.16, %notlhs.16
  %brmerge.16 = or i1 %.not.16, %cmp211.not.16
  br i1 %brmerge.16, label %for.inc45.16, label %for.body23.lr.ph.16

for.body23.lr.ph.16:                              ; preds = %for.body14.16
  %mul.16 = shl i32 %add.16, 7
  %mul39.16 = mul i32 %ki.06.16, %kern_width
  br label %for.body23.16

for.body23.16:                                    ; preds = %for.inc.16, %for.body23.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body23.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc.16 ]
  %partial_sum.12.16 = phi float [ %partial_sum.05.16, %for.body23.lr.ph.16 ], [ %partial_sum.2.16, %for.inc.16 ]
  %127 = trunc i64 %indvars.iv.16 to i32
  %add24.16 = add nsw i32 %127, %inc65.15
  %cmp25.16 = icmp sgt i32 %add24.16, -1
  %cmp29.16 = icmp ult i32 %add24.16, %img_width
  %128 = and i1 %cmp25.16, %cmp29.16
  br i1 %128, label %if.end35.16, label %for.inc.16

if.end35.16:                                      ; preds = %for.body23.16
  %add38.16 = add nsw i32 %add24.16, %mul.16
  %idxprom.16 = sext i32 %add38.16 to i64
  %arrayidx.16 = getelementptr inbounds float, float* %0, i64 %idxprom.16
  %129 = load float, float* %arrayidx.16, align 4
  %130 = trunc i64 %indvars.iv.16 to i32
  %add40.16 = add i32 %130, %mul39.16
  %idxprom41.16 = zext i32 %add40.16 to i64
  %arrayidx42.16 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.16
  %131 = load float, float* %arrayidx42.16, align 4
  %mul43.16 = fmul float %129, %131
  %add44.16 = fadd float %partial_sum.12.16, %mul43.16
  br label %for.inc.16

for.inc.16:                                       ; preds = %if.end35.16, %for.body23.16
  %partial_sum.2.16 = phi float [ %add44.16, %if.end35.16 ], [ %partial_sum.12.16, %for.body23.16 ]
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %kern_width
  br i1 %exitcond.16, label %for.inc45.16.loopexit, label %for.body23.16, !llvm.loop !1

for.inc45.16.loopexit:                            ; preds = %for.inc.16
  %partial_sum.2.16.lcssa = phi float [ %partial_sum.2.16, %for.inc.16 ]
  br label %for.inc45.16

for.inc45.16:                                     ; preds = %for.inc45.16.loopexit, %for.body14.16
  %partial_sum.3.16 = phi float [ %partial_sum.05.16, %for.body14.16 ], [ %partial_sum.2.16.lcssa, %for.inc45.16.loopexit ]
  %inc46.16 = add nuw nsw i32 %ki.06.16, 1
  %exitcond19.16 = icmp eq i32 %inc46.16, %kern_height
  br i1 %exitcond19.16, label %for.end47.16.loopexit, label %for.body14.16, !llvm.loop !3

for.end47.16.loopexit:                            ; preds = %for.inc45.16
  %partial_sum.3.16.lcssa = phi float [ %partial_sum.3.16, %for.inc45.16 ]
  br label %for.end47.16

for.end47.16:                                     ; preds = %for.end47.16.loopexit, %for.inc64.15
  %partial_sum.0.lcssa.16 = phi float [ 0.000000e+00, %for.inc64.15 ], [ %partial_sum.3.16.lcssa, %for.end47.16.loopexit ]
  br i1 %tobool48, label %if.else.16, label %if.then49.16

if.then49.16:                                     ; preds = %for.end47.16
  %cmp50.16 = fcmp olt float %partial_sum.0.lcssa.16, 0.000000e+00
  %sub52.16 = fsub float -0.000000e+00, %partial_sum.0.lcssa.16
  %cond.16 = select i1 %cmp50.16, float %sub52.16, float %partial_sum.0.lcssa.16
  %conv53.16 = fptoui float %cond.16 to i8
  %conv54.16 = uitofp i8 %conv53.16 to float
  %132 = add nsw i64 %indvars.iv.next21.15, %7
  %arrayidx58.16 = getelementptr inbounds float, float* %1, i64 %132
  store float %conv54.16, float* %arrayidx58.16, align 4
  br label %for.inc64.16

if.else.16:                                       ; preds = %for.end47.16
  %133 = add nsw i64 %indvars.iv.next21.15, %6
  %arrayidx62.16 = getelementptr inbounds float, float* %1, i64 %133
  store float %partial_sum.0.lcssa.16, float* %arrayidx62.16, align 4
  br label %for.inc64.16

for.inc64.16:                                     ; preds = %if.else.16, %if.then49.16
  %inc65.16 = add nsw i32 %in_j.011, 17
  %indvars.iv.next21.16 = add nsw i64 %indvars.iv20, 17
  br i1 %cmp124, label %for.end47.17, label %for.body14.17.preheader

for.body14.17.preheader:                          ; preds = %for.inc64.16
  br label %for.body14.17

for.body14.17:                                    ; preds = %for.body14.17.preheader, %for.inc45.17
  %ki.06.17 = phi i32 [ %inc46.17, %for.inc45.17 ], [ 0, %for.body14.17.preheader ]
  %partial_sum.05.17 = phi float [ %partial_sum.3.17, %for.inc45.17 ], [ 0.000000e+00, %for.body14.17.preheader ]
  %add.17 = add nsw i32 %ki.06.17, %in_i.015
  %notlhs.17 = icmp slt i32 %add.17, 0
  %notrhs.17 = icmp uge i32 %add.17, %img_height
  %.not.17 = or i1 %notrhs.17, %notlhs.17
  %brmerge.17 = or i1 %.not.17, %cmp211.not.17
  br i1 %brmerge.17, label %for.inc45.17, label %for.body23.lr.ph.17

for.body23.lr.ph.17:                              ; preds = %for.body14.17
  %mul.17 = shl i32 %add.17, 7
  %mul39.17 = mul i32 %ki.06.17, %kern_width
  br label %for.body23.17

for.body23.17:                                    ; preds = %for.inc.17, %for.body23.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body23.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc.17 ]
  %partial_sum.12.17 = phi float [ %partial_sum.05.17, %for.body23.lr.ph.17 ], [ %partial_sum.2.17, %for.inc.17 ]
  %134 = trunc i64 %indvars.iv.17 to i32
  %add24.17 = add nsw i32 %134, %inc65.16
  %cmp25.17 = icmp sgt i32 %add24.17, -1
  %cmp29.17 = icmp ult i32 %add24.17, %img_width
  %135 = and i1 %cmp25.17, %cmp29.17
  br i1 %135, label %if.end35.17, label %for.inc.17

if.end35.17:                                      ; preds = %for.body23.17
  %add38.17 = add nsw i32 %add24.17, %mul.17
  %idxprom.17 = sext i32 %add38.17 to i64
  %arrayidx.17 = getelementptr inbounds float, float* %0, i64 %idxprom.17
  %136 = load float, float* %arrayidx.17, align 4
  %137 = trunc i64 %indvars.iv.17 to i32
  %add40.17 = add i32 %137, %mul39.17
  %idxprom41.17 = zext i32 %add40.17 to i64
  %arrayidx42.17 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.17
  %138 = load float, float* %arrayidx42.17, align 4
  %mul43.17 = fmul float %136, %138
  %add44.17 = fadd float %partial_sum.12.17, %mul43.17
  br label %for.inc.17

for.inc.17:                                       ; preds = %if.end35.17, %for.body23.17
  %partial_sum.2.17 = phi float [ %add44.17, %if.end35.17 ], [ %partial_sum.12.17, %for.body23.17 ]
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %kern_width
  br i1 %exitcond.17, label %for.inc45.17.loopexit, label %for.body23.17, !llvm.loop !1

for.inc45.17.loopexit:                            ; preds = %for.inc.17
  %partial_sum.2.17.lcssa = phi float [ %partial_sum.2.17, %for.inc.17 ]
  br label %for.inc45.17

for.inc45.17:                                     ; preds = %for.inc45.17.loopexit, %for.body14.17
  %partial_sum.3.17 = phi float [ %partial_sum.05.17, %for.body14.17 ], [ %partial_sum.2.17.lcssa, %for.inc45.17.loopexit ]
  %inc46.17 = add nuw nsw i32 %ki.06.17, 1
  %exitcond19.17 = icmp eq i32 %inc46.17, %kern_height
  br i1 %exitcond19.17, label %for.end47.17.loopexit, label %for.body14.17, !llvm.loop !3

for.end47.17.loopexit:                            ; preds = %for.inc45.17
  %partial_sum.3.17.lcssa = phi float [ %partial_sum.3.17, %for.inc45.17 ]
  br label %for.end47.17

for.end47.17:                                     ; preds = %for.end47.17.loopexit, %for.inc64.16
  %partial_sum.0.lcssa.17 = phi float [ 0.000000e+00, %for.inc64.16 ], [ %partial_sum.3.17.lcssa, %for.end47.17.loopexit ]
  br i1 %tobool48, label %if.else.17, label %if.then49.17

if.then49.17:                                     ; preds = %for.end47.17
  %cmp50.17 = fcmp olt float %partial_sum.0.lcssa.17, 0.000000e+00
  %sub52.17 = fsub float -0.000000e+00, %partial_sum.0.lcssa.17
  %cond.17 = select i1 %cmp50.17, float %sub52.17, float %partial_sum.0.lcssa.17
  %conv53.17 = fptoui float %cond.17 to i8
  %conv54.17 = uitofp i8 %conv53.17 to float
  %139 = add nsw i64 %indvars.iv.next21.16, %7
  %arrayidx58.17 = getelementptr inbounds float, float* %1, i64 %139
  store float %conv54.17, float* %arrayidx58.17, align 4
  br label %for.inc64.17

if.else.17:                                       ; preds = %for.end47.17
  %140 = add nsw i64 %indvars.iv.next21.16, %6
  %arrayidx62.17 = getelementptr inbounds float, float* %1, i64 %140
  store float %partial_sum.0.lcssa.17, float* %arrayidx62.17, align 4
  br label %for.inc64.17

for.inc64.17:                                     ; preds = %if.else.17, %if.then49.17
  %inc65.17 = add nsw i32 %in_j.011, 18
  %indvars.iv.next21.17 = add nsw i64 %indvars.iv20, 18
  br i1 %cmp124, label %for.end47.18, label %for.body14.18.preheader

for.body14.18.preheader:                          ; preds = %for.inc64.17
  br label %for.body14.18

for.body14.18:                                    ; preds = %for.body14.18.preheader, %for.inc45.18
  %ki.06.18 = phi i32 [ %inc46.18, %for.inc45.18 ], [ 0, %for.body14.18.preheader ]
  %partial_sum.05.18 = phi float [ %partial_sum.3.18, %for.inc45.18 ], [ 0.000000e+00, %for.body14.18.preheader ]
  %add.18 = add nsw i32 %ki.06.18, %in_i.015
  %notlhs.18 = icmp slt i32 %add.18, 0
  %notrhs.18 = icmp uge i32 %add.18, %img_height
  %.not.18 = or i1 %notrhs.18, %notlhs.18
  %brmerge.18 = or i1 %.not.18, %cmp211.not.18
  br i1 %brmerge.18, label %for.inc45.18, label %for.body23.lr.ph.18

for.body23.lr.ph.18:                              ; preds = %for.body14.18
  %mul.18 = shl i32 %add.18, 7
  %mul39.18 = mul i32 %ki.06.18, %kern_width
  br label %for.body23.18

for.body23.18:                                    ; preds = %for.inc.18, %for.body23.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body23.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc.18 ]
  %partial_sum.12.18 = phi float [ %partial_sum.05.18, %for.body23.lr.ph.18 ], [ %partial_sum.2.18, %for.inc.18 ]
  %141 = trunc i64 %indvars.iv.18 to i32
  %add24.18 = add nsw i32 %141, %inc65.17
  %cmp25.18 = icmp sgt i32 %add24.18, -1
  %cmp29.18 = icmp ult i32 %add24.18, %img_width
  %142 = and i1 %cmp25.18, %cmp29.18
  br i1 %142, label %if.end35.18, label %for.inc.18

if.end35.18:                                      ; preds = %for.body23.18
  %add38.18 = add nsw i32 %add24.18, %mul.18
  %idxprom.18 = sext i32 %add38.18 to i64
  %arrayidx.18 = getelementptr inbounds float, float* %0, i64 %idxprom.18
  %143 = load float, float* %arrayidx.18, align 4
  %144 = trunc i64 %indvars.iv.18 to i32
  %add40.18 = add i32 %144, %mul39.18
  %idxprom41.18 = zext i32 %add40.18 to i64
  %arrayidx42.18 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.18
  %145 = load float, float* %arrayidx42.18, align 4
  %mul43.18 = fmul float %143, %145
  %add44.18 = fadd float %partial_sum.12.18, %mul43.18
  br label %for.inc.18

for.inc.18:                                       ; preds = %if.end35.18, %for.body23.18
  %partial_sum.2.18 = phi float [ %add44.18, %if.end35.18 ], [ %partial_sum.12.18, %for.body23.18 ]
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %kern_width
  br i1 %exitcond.18, label %for.inc45.18.loopexit, label %for.body23.18, !llvm.loop !1

for.inc45.18.loopexit:                            ; preds = %for.inc.18
  %partial_sum.2.18.lcssa = phi float [ %partial_sum.2.18, %for.inc.18 ]
  br label %for.inc45.18

for.inc45.18:                                     ; preds = %for.inc45.18.loopexit, %for.body14.18
  %partial_sum.3.18 = phi float [ %partial_sum.05.18, %for.body14.18 ], [ %partial_sum.2.18.lcssa, %for.inc45.18.loopexit ]
  %inc46.18 = add nuw nsw i32 %ki.06.18, 1
  %exitcond19.18 = icmp eq i32 %inc46.18, %kern_height
  br i1 %exitcond19.18, label %for.end47.18.loopexit, label %for.body14.18, !llvm.loop !3

for.end47.18.loopexit:                            ; preds = %for.inc45.18
  %partial_sum.3.18.lcssa = phi float [ %partial_sum.3.18, %for.inc45.18 ]
  br label %for.end47.18

for.end47.18:                                     ; preds = %for.end47.18.loopexit, %for.inc64.17
  %partial_sum.0.lcssa.18 = phi float [ 0.000000e+00, %for.inc64.17 ], [ %partial_sum.3.18.lcssa, %for.end47.18.loopexit ]
  br i1 %tobool48, label %if.else.18, label %if.then49.18

if.then49.18:                                     ; preds = %for.end47.18
  %cmp50.18 = fcmp olt float %partial_sum.0.lcssa.18, 0.000000e+00
  %sub52.18 = fsub float -0.000000e+00, %partial_sum.0.lcssa.18
  %cond.18 = select i1 %cmp50.18, float %sub52.18, float %partial_sum.0.lcssa.18
  %conv53.18 = fptoui float %cond.18 to i8
  %conv54.18 = uitofp i8 %conv53.18 to float
  %146 = add nsw i64 %indvars.iv.next21.17, %7
  %arrayidx58.18 = getelementptr inbounds float, float* %1, i64 %146
  store float %conv54.18, float* %arrayidx58.18, align 4
  br label %for.inc64.18

if.else.18:                                       ; preds = %for.end47.18
  %147 = add nsw i64 %indvars.iv.next21.17, %6
  %arrayidx62.18 = getelementptr inbounds float, float* %1, i64 %147
  store float %partial_sum.0.lcssa.18, float* %arrayidx62.18, align 4
  br label %for.inc64.18

for.inc64.18:                                     ; preds = %if.else.18, %if.then49.18
  %inc65.18 = add nsw i32 %in_j.011, 19
  %indvars.iv.next21.18 = add nsw i64 %indvars.iv20, 19
  br i1 %cmp124, label %for.end47.19, label %for.body14.19.preheader

for.body14.19.preheader:                          ; preds = %for.inc64.18
  br label %for.body14.19

for.body14.19:                                    ; preds = %for.body14.19.preheader, %for.inc45.19
  %ki.06.19 = phi i32 [ %inc46.19, %for.inc45.19 ], [ 0, %for.body14.19.preheader ]
  %partial_sum.05.19 = phi float [ %partial_sum.3.19, %for.inc45.19 ], [ 0.000000e+00, %for.body14.19.preheader ]
  %add.19 = add nsw i32 %ki.06.19, %in_i.015
  %notlhs.19 = icmp slt i32 %add.19, 0
  %notrhs.19 = icmp uge i32 %add.19, %img_height
  %.not.19 = or i1 %notrhs.19, %notlhs.19
  %brmerge.19 = or i1 %.not.19, %cmp211.not.19
  br i1 %brmerge.19, label %for.inc45.19, label %for.body23.lr.ph.19

for.body23.lr.ph.19:                              ; preds = %for.body14.19
  %mul.19 = shl i32 %add.19, 7
  %mul39.19 = mul i32 %ki.06.19, %kern_width
  br label %for.body23.19

for.body23.19:                                    ; preds = %for.inc.19, %for.body23.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body23.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc.19 ]
  %partial_sum.12.19 = phi float [ %partial_sum.05.19, %for.body23.lr.ph.19 ], [ %partial_sum.2.19, %for.inc.19 ]
  %148 = trunc i64 %indvars.iv.19 to i32
  %add24.19 = add nsw i32 %148, %inc65.18
  %cmp25.19 = icmp sgt i32 %add24.19, -1
  %cmp29.19 = icmp ult i32 %add24.19, %img_width
  %149 = and i1 %cmp25.19, %cmp29.19
  br i1 %149, label %if.end35.19, label %for.inc.19

if.end35.19:                                      ; preds = %for.body23.19
  %add38.19 = add nsw i32 %add24.19, %mul.19
  %idxprom.19 = sext i32 %add38.19 to i64
  %arrayidx.19 = getelementptr inbounds float, float* %0, i64 %idxprom.19
  %150 = load float, float* %arrayidx.19, align 4
  %151 = trunc i64 %indvars.iv.19 to i32
  %add40.19 = add i32 %151, %mul39.19
  %idxprom41.19 = zext i32 %add40.19 to i64
  %arrayidx42.19 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.19
  %152 = load float, float* %arrayidx42.19, align 4
  %mul43.19 = fmul float %150, %152
  %add44.19 = fadd float %partial_sum.12.19, %mul43.19
  br label %for.inc.19

for.inc.19:                                       ; preds = %if.end35.19, %for.body23.19
  %partial_sum.2.19 = phi float [ %add44.19, %if.end35.19 ], [ %partial_sum.12.19, %for.body23.19 ]
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %kern_width
  br i1 %exitcond.19, label %for.inc45.19.loopexit, label %for.body23.19, !llvm.loop !1

for.inc45.19.loopexit:                            ; preds = %for.inc.19
  %partial_sum.2.19.lcssa = phi float [ %partial_sum.2.19, %for.inc.19 ]
  br label %for.inc45.19

for.inc45.19:                                     ; preds = %for.inc45.19.loopexit, %for.body14.19
  %partial_sum.3.19 = phi float [ %partial_sum.05.19, %for.body14.19 ], [ %partial_sum.2.19.lcssa, %for.inc45.19.loopexit ]
  %inc46.19 = add nuw nsw i32 %ki.06.19, 1
  %exitcond19.19 = icmp eq i32 %inc46.19, %kern_height
  br i1 %exitcond19.19, label %for.end47.19.loopexit, label %for.body14.19, !llvm.loop !3

for.end47.19.loopexit:                            ; preds = %for.inc45.19
  %partial_sum.3.19.lcssa = phi float [ %partial_sum.3.19, %for.inc45.19 ]
  br label %for.end47.19

for.end47.19:                                     ; preds = %for.end47.19.loopexit, %for.inc64.18
  %partial_sum.0.lcssa.19 = phi float [ 0.000000e+00, %for.inc64.18 ], [ %partial_sum.3.19.lcssa, %for.end47.19.loopexit ]
  br i1 %tobool48, label %if.else.19, label %if.then49.19

if.then49.19:                                     ; preds = %for.end47.19
  %cmp50.19 = fcmp olt float %partial_sum.0.lcssa.19, 0.000000e+00
  %sub52.19 = fsub float -0.000000e+00, %partial_sum.0.lcssa.19
  %cond.19 = select i1 %cmp50.19, float %sub52.19, float %partial_sum.0.lcssa.19
  %conv53.19 = fptoui float %cond.19 to i8
  %conv54.19 = uitofp i8 %conv53.19 to float
  %153 = add nsw i64 %indvars.iv.next21.18, %7
  %arrayidx58.19 = getelementptr inbounds float, float* %1, i64 %153
  store float %conv54.19, float* %arrayidx58.19, align 4
  br label %for.inc64.19

if.else.19:                                       ; preds = %for.end47.19
  %154 = add nsw i64 %indvars.iv.next21.18, %6
  %arrayidx62.19 = getelementptr inbounds float, float* %1, i64 %154
  store float %partial_sum.0.lcssa.19, float* %arrayidx62.19, align 4
  br label %for.inc64.19

for.inc64.19:                                     ; preds = %if.else.19, %if.then49.19
  %inc65.19 = add nsw i32 %in_j.011, 20
  %indvars.iv.next21.19 = add nsw i64 %indvars.iv20, 20
  br i1 %cmp124, label %for.end47.20, label %for.body14.20.preheader

for.body14.20.preheader:                          ; preds = %for.inc64.19
  br label %for.body14.20

for.body14.20:                                    ; preds = %for.body14.20.preheader, %for.inc45.20
  %ki.06.20 = phi i32 [ %inc46.20, %for.inc45.20 ], [ 0, %for.body14.20.preheader ]
  %partial_sum.05.20 = phi float [ %partial_sum.3.20, %for.inc45.20 ], [ 0.000000e+00, %for.body14.20.preheader ]
  %add.20 = add nsw i32 %ki.06.20, %in_i.015
  %notlhs.20 = icmp slt i32 %add.20, 0
  %notrhs.20 = icmp uge i32 %add.20, %img_height
  %.not.20 = or i1 %notrhs.20, %notlhs.20
  %brmerge.20 = or i1 %.not.20, %cmp211.not.20
  br i1 %brmerge.20, label %for.inc45.20, label %for.body23.lr.ph.20

for.body23.lr.ph.20:                              ; preds = %for.body14.20
  %mul.20 = shl i32 %add.20, 7
  %mul39.20 = mul i32 %ki.06.20, %kern_width
  br label %for.body23.20

for.body23.20:                                    ; preds = %for.inc.20, %for.body23.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body23.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc.20 ]
  %partial_sum.12.20 = phi float [ %partial_sum.05.20, %for.body23.lr.ph.20 ], [ %partial_sum.2.20, %for.inc.20 ]
  %155 = trunc i64 %indvars.iv.20 to i32
  %add24.20 = add nsw i32 %155, %inc65.19
  %cmp25.20 = icmp sgt i32 %add24.20, -1
  %cmp29.20 = icmp ult i32 %add24.20, %img_width
  %156 = and i1 %cmp25.20, %cmp29.20
  br i1 %156, label %if.end35.20, label %for.inc.20

if.end35.20:                                      ; preds = %for.body23.20
  %add38.20 = add nsw i32 %add24.20, %mul.20
  %idxprom.20 = sext i32 %add38.20 to i64
  %arrayidx.20 = getelementptr inbounds float, float* %0, i64 %idxprom.20
  %157 = load float, float* %arrayidx.20, align 4
  %158 = trunc i64 %indvars.iv.20 to i32
  %add40.20 = add i32 %158, %mul39.20
  %idxprom41.20 = zext i32 %add40.20 to i64
  %arrayidx42.20 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.20
  %159 = load float, float* %arrayidx42.20, align 4
  %mul43.20 = fmul float %157, %159
  %add44.20 = fadd float %partial_sum.12.20, %mul43.20
  br label %for.inc.20

for.inc.20:                                       ; preds = %if.end35.20, %for.body23.20
  %partial_sum.2.20 = phi float [ %add44.20, %if.end35.20 ], [ %partial_sum.12.20, %for.body23.20 ]
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %kern_width
  br i1 %exitcond.20, label %for.inc45.20.loopexit, label %for.body23.20, !llvm.loop !1

for.inc45.20.loopexit:                            ; preds = %for.inc.20
  %partial_sum.2.20.lcssa = phi float [ %partial_sum.2.20, %for.inc.20 ]
  br label %for.inc45.20

for.inc45.20:                                     ; preds = %for.inc45.20.loopexit, %for.body14.20
  %partial_sum.3.20 = phi float [ %partial_sum.05.20, %for.body14.20 ], [ %partial_sum.2.20.lcssa, %for.inc45.20.loopexit ]
  %inc46.20 = add nuw nsw i32 %ki.06.20, 1
  %exitcond19.20 = icmp eq i32 %inc46.20, %kern_height
  br i1 %exitcond19.20, label %for.end47.20.loopexit, label %for.body14.20, !llvm.loop !3

for.end47.20.loopexit:                            ; preds = %for.inc45.20
  %partial_sum.3.20.lcssa = phi float [ %partial_sum.3.20, %for.inc45.20 ]
  br label %for.end47.20

for.end47.20:                                     ; preds = %for.end47.20.loopexit, %for.inc64.19
  %partial_sum.0.lcssa.20 = phi float [ 0.000000e+00, %for.inc64.19 ], [ %partial_sum.3.20.lcssa, %for.end47.20.loopexit ]
  br i1 %tobool48, label %if.else.20, label %if.then49.20

if.then49.20:                                     ; preds = %for.end47.20
  %cmp50.20 = fcmp olt float %partial_sum.0.lcssa.20, 0.000000e+00
  %sub52.20 = fsub float -0.000000e+00, %partial_sum.0.lcssa.20
  %cond.20 = select i1 %cmp50.20, float %sub52.20, float %partial_sum.0.lcssa.20
  %conv53.20 = fptoui float %cond.20 to i8
  %conv54.20 = uitofp i8 %conv53.20 to float
  %160 = add nsw i64 %indvars.iv.next21.19, %7
  %arrayidx58.20 = getelementptr inbounds float, float* %1, i64 %160
  store float %conv54.20, float* %arrayidx58.20, align 4
  br label %for.inc64.20

if.else.20:                                       ; preds = %for.end47.20
  %161 = add nsw i64 %indvars.iv.next21.19, %6
  %arrayidx62.20 = getelementptr inbounds float, float* %1, i64 %161
  store float %partial_sum.0.lcssa.20, float* %arrayidx62.20, align 4
  br label %for.inc64.20

for.inc64.20:                                     ; preds = %if.else.20, %if.then49.20
  %inc65.20 = add nsw i32 %in_j.011, 21
  %indvars.iv.next21.20 = add nsw i64 %indvars.iv20, 21
  br i1 %cmp124, label %for.end47.21, label %for.body14.21.preheader

for.body14.21.preheader:                          ; preds = %for.inc64.20
  br label %for.body14.21

for.body14.21:                                    ; preds = %for.body14.21.preheader, %for.inc45.21
  %ki.06.21 = phi i32 [ %inc46.21, %for.inc45.21 ], [ 0, %for.body14.21.preheader ]
  %partial_sum.05.21 = phi float [ %partial_sum.3.21, %for.inc45.21 ], [ 0.000000e+00, %for.body14.21.preheader ]
  %add.21 = add nsw i32 %ki.06.21, %in_i.015
  %notlhs.21 = icmp slt i32 %add.21, 0
  %notrhs.21 = icmp uge i32 %add.21, %img_height
  %.not.21 = or i1 %notrhs.21, %notlhs.21
  %brmerge.21 = or i1 %.not.21, %cmp211.not.21
  br i1 %brmerge.21, label %for.inc45.21, label %for.body23.lr.ph.21

for.body23.lr.ph.21:                              ; preds = %for.body14.21
  %mul.21 = shl i32 %add.21, 7
  %mul39.21 = mul i32 %ki.06.21, %kern_width
  br label %for.body23.21

for.body23.21:                                    ; preds = %for.inc.21, %for.body23.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body23.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc.21 ]
  %partial_sum.12.21 = phi float [ %partial_sum.05.21, %for.body23.lr.ph.21 ], [ %partial_sum.2.21, %for.inc.21 ]
  %162 = trunc i64 %indvars.iv.21 to i32
  %add24.21 = add nsw i32 %162, %inc65.20
  %cmp25.21 = icmp sgt i32 %add24.21, -1
  %cmp29.21 = icmp ult i32 %add24.21, %img_width
  %163 = and i1 %cmp25.21, %cmp29.21
  br i1 %163, label %if.end35.21, label %for.inc.21

if.end35.21:                                      ; preds = %for.body23.21
  %add38.21 = add nsw i32 %add24.21, %mul.21
  %idxprom.21 = sext i32 %add38.21 to i64
  %arrayidx.21 = getelementptr inbounds float, float* %0, i64 %idxprom.21
  %164 = load float, float* %arrayidx.21, align 4
  %165 = trunc i64 %indvars.iv.21 to i32
  %add40.21 = add i32 %165, %mul39.21
  %idxprom41.21 = zext i32 %add40.21 to i64
  %arrayidx42.21 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.21
  %166 = load float, float* %arrayidx42.21, align 4
  %mul43.21 = fmul float %164, %166
  %add44.21 = fadd float %partial_sum.12.21, %mul43.21
  br label %for.inc.21

for.inc.21:                                       ; preds = %if.end35.21, %for.body23.21
  %partial_sum.2.21 = phi float [ %add44.21, %if.end35.21 ], [ %partial_sum.12.21, %for.body23.21 ]
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %kern_width
  br i1 %exitcond.21, label %for.inc45.21.loopexit, label %for.body23.21, !llvm.loop !1

for.inc45.21.loopexit:                            ; preds = %for.inc.21
  %partial_sum.2.21.lcssa = phi float [ %partial_sum.2.21, %for.inc.21 ]
  br label %for.inc45.21

for.inc45.21:                                     ; preds = %for.inc45.21.loopexit, %for.body14.21
  %partial_sum.3.21 = phi float [ %partial_sum.05.21, %for.body14.21 ], [ %partial_sum.2.21.lcssa, %for.inc45.21.loopexit ]
  %inc46.21 = add nuw nsw i32 %ki.06.21, 1
  %exitcond19.21 = icmp eq i32 %inc46.21, %kern_height
  br i1 %exitcond19.21, label %for.end47.21.loopexit, label %for.body14.21, !llvm.loop !3

for.end47.21.loopexit:                            ; preds = %for.inc45.21
  %partial_sum.3.21.lcssa = phi float [ %partial_sum.3.21, %for.inc45.21 ]
  br label %for.end47.21

for.end47.21:                                     ; preds = %for.end47.21.loopexit, %for.inc64.20
  %partial_sum.0.lcssa.21 = phi float [ 0.000000e+00, %for.inc64.20 ], [ %partial_sum.3.21.lcssa, %for.end47.21.loopexit ]
  br i1 %tobool48, label %if.else.21, label %if.then49.21

if.then49.21:                                     ; preds = %for.end47.21
  %cmp50.21 = fcmp olt float %partial_sum.0.lcssa.21, 0.000000e+00
  %sub52.21 = fsub float -0.000000e+00, %partial_sum.0.lcssa.21
  %cond.21 = select i1 %cmp50.21, float %sub52.21, float %partial_sum.0.lcssa.21
  %conv53.21 = fptoui float %cond.21 to i8
  %conv54.21 = uitofp i8 %conv53.21 to float
  %167 = add nsw i64 %indvars.iv.next21.20, %7
  %arrayidx58.21 = getelementptr inbounds float, float* %1, i64 %167
  store float %conv54.21, float* %arrayidx58.21, align 4
  br label %for.inc64.21

if.else.21:                                       ; preds = %for.end47.21
  %168 = add nsw i64 %indvars.iv.next21.20, %6
  %arrayidx62.21 = getelementptr inbounds float, float* %1, i64 %168
  store float %partial_sum.0.lcssa.21, float* %arrayidx62.21, align 4
  br label %for.inc64.21

for.inc64.21:                                     ; preds = %if.else.21, %if.then49.21
  %inc65.21 = add nsw i32 %in_j.011, 22
  %indvars.iv.next21.21 = add nsw i64 %indvars.iv20, 22
  br i1 %cmp124, label %for.end47.22, label %for.body14.22.preheader

for.body14.22.preheader:                          ; preds = %for.inc64.21
  br label %for.body14.22

for.body14.22:                                    ; preds = %for.body14.22.preheader, %for.inc45.22
  %ki.06.22 = phi i32 [ %inc46.22, %for.inc45.22 ], [ 0, %for.body14.22.preheader ]
  %partial_sum.05.22 = phi float [ %partial_sum.3.22, %for.inc45.22 ], [ 0.000000e+00, %for.body14.22.preheader ]
  %add.22 = add nsw i32 %ki.06.22, %in_i.015
  %notlhs.22 = icmp slt i32 %add.22, 0
  %notrhs.22 = icmp uge i32 %add.22, %img_height
  %.not.22 = or i1 %notrhs.22, %notlhs.22
  %brmerge.22 = or i1 %.not.22, %cmp211.not.22
  br i1 %brmerge.22, label %for.inc45.22, label %for.body23.lr.ph.22

for.body23.lr.ph.22:                              ; preds = %for.body14.22
  %mul.22 = shl i32 %add.22, 7
  %mul39.22 = mul i32 %ki.06.22, %kern_width
  br label %for.body23.22

for.body23.22:                                    ; preds = %for.inc.22, %for.body23.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body23.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc.22 ]
  %partial_sum.12.22 = phi float [ %partial_sum.05.22, %for.body23.lr.ph.22 ], [ %partial_sum.2.22, %for.inc.22 ]
  %169 = trunc i64 %indvars.iv.22 to i32
  %add24.22 = add nsw i32 %169, %inc65.21
  %cmp25.22 = icmp sgt i32 %add24.22, -1
  %cmp29.22 = icmp ult i32 %add24.22, %img_width
  %170 = and i1 %cmp25.22, %cmp29.22
  br i1 %170, label %if.end35.22, label %for.inc.22

if.end35.22:                                      ; preds = %for.body23.22
  %add38.22 = add nsw i32 %add24.22, %mul.22
  %idxprom.22 = sext i32 %add38.22 to i64
  %arrayidx.22 = getelementptr inbounds float, float* %0, i64 %idxprom.22
  %171 = load float, float* %arrayidx.22, align 4
  %172 = trunc i64 %indvars.iv.22 to i32
  %add40.22 = add i32 %172, %mul39.22
  %idxprom41.22 = zext i32 %add40.22 to i64
  %arrayidx42.22 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.22
  %173 = load float, float* %arrayidx42.22, align 4
  %mul43.22 = fmul float %171, %173
  %add44.22 = fadd float %partial_sum.12.22, %mul43.22
  br label %for.inc.22

for.inc.22:                                       ; preds = %if.end35.22, %for.body23.22
  %partial_sum.2.22 = phi float [ %add44.22, %if.end35.22 ], [ %partial_sum.12.22, %for.body23.22 ]
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %kern_width
  br i1 %exitcond.22, label %for.inc45.22.loopexit, label %for.body23.22, !llvm.loop !1

for.inc45.22.loopexit:                            ; preds = %for.inc.22
  %partial_sum.2.22.lcssa = phi float [ %partial_sum.2.22, %for.inc.22 ]
  br label %for.inc45.22

for.inc45.22:                                     ; preds = %for.inc45.22.loopexit, %for.body14.22
  %partial_sum.3.22 = phi float [ %partial_sum.05.22, %for.body14.22 ], [ %partial_sum.2.22.lcssa, %for.inc45.22.loopexit ]
  %inc46.22 = add nuw nsw i32 %ki.06.22, 1
  %exitcond19.22 = icmp eq i32 %inc46.22, %kern_height
  br i1 %exitcond19.22, label %for.end47.22.loopexit, label %for.body14.22, !llvm.loop !3

for.end47.22.loopexit:                            ; preds = %for.inc45.22
  %partial_sum.3.22.lcssa = phi float [ %partial_sum.3.22, %for.inc45.22 ]
  br label %for.end47.22

for.end47.22:                                     ; preds = %for.end47.22.loopexit, %for.inc64.21
  %partial_sum.0.lcssa.22 = phi float [ 0.000000e+00, %for.inc64.21 ], [ %partial_sum.3.22.lcssa, %for.end47.22.loopexit ]
  br i1 %tobool48, label %if.else.22, label %if.then49.22

if.then49.22:                                     ; preds = %for.end47.22
  %cmp50.22 = fcmp olt float %partial_sum.0.lcssa.22, 0.000000e+00
  %sub52.22 = fsub float -0.000000e+00, %partial_sum.0.lcssa.22
  %cond.22 = select i1 %cmp50.22, float %sub52.22, float %partial_sum.0.lcssa.22
  %conv53.22 = fptoui float %cond.22 to i8
  %conv54.22 = uitofp i8 %conv53.22 to float
  %174 = add nsw i64 %indvars.iv.next21.21, %7
  %arrayidx58.22 = getelementptr inbounds float, float* %1, i64 %174
  store float %conv54.22, float* %arrayidx58.22, align 4
  br label %for.inc64.22

if.else.22:                                       ; preds = %for.end47.22
  %175 = add nsw i64 %indvars.iv.next21.21, %6
  %arrayidx62.22 = getelementptr inbounds float, float* %1, i64 %175
  store float %partial_sum.0.lcssa.22, float* %arrayidx62.22, align 4
  br label %for.inc64.22

for.inc64.22:                                     ; preds = %if.else.22, %if.then49.22
  %inc65.22 = add nsw i32 %in_j.011, 23
  %indvars.iv.next21.22 = add nsw i64 %indvars.iv20, 23
  br i1 %cmp124, label %for.end47.23, label %for.body14.23.preheader

for.body14.23.preheader:                          ; preds = %for.inc64.22
  br label %for.body14.23

for.body14.23:                                    ; preds = %for.body14.23.preheader, %for.inc45.23
  %ki.06.23 = phi i32 [ %inc46.23, %for.inc45.23 ], [ 0, %for.body14.23.preheader ]
  %partial_sum.05.23 = phi float [ %partial_sum.3.23, %for.inc45.23 ], [ 0.000000e+00, %for.body14.23.preheader ]
  %add.23 = add nsw i32 %ki.06.23, %in_i.015
  %notlhs.23 = icmp slt i32 %add.23, 0
  %notrhs.23 = icmp uge i32 %add.23, %img_height
  %.not.23 = or i1 %notrhs.23, %notlhs.23
  %brmerge.23 = or i1 %.not.23, %cmp211.not.23
  br i1 %brmerge.23, label %for.inc45.23, label %for.body23.lr.ph.23

for.body23.lr.ph.23:                              ; preds = %for.body14.23
  %mul.23 = shl i32 %add.23, 7
  %mul39.23 = mul i32 %ki.06.23, %kern_width
  br label %for.body23.23

for.body23.23:                                    ; preds = %for.inc.23, %for.body23.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body23.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc.23 ]
  %partial_sum.12.23 = phi float [ %partial_sum.05.23, %for.body23.lr.ph.23 ], [ %partial_sum.2.23, %for.inc.23 ]
  %176 = trunc i64 %indvars.iv.23 to i32
  %add24.23 = add nsw i32 %176, %inc65.22
  %cmp25.23 = icmp sgt i32 %add24.23, -1
  %cmp29.23 = icmp ult i32 %add24.23, %img_width
  %177 = and i1 %cmp25.23, %cmp29.23
  br i1 %177, label %if.end35.23, label %for.inc.23

if.end35.23:                                      ; preds = %for.body23.23
  %add38.23 = add nsw i32 %add24.23, %mul.23
  %idxprom.23 = sext i32 %add38.23 to i64
  %arrayidx.23 = getelementptr inbounds float, float* %0, i64 %idxprom.23
  %178 = load float, float* %arrayidx.23, align 4
  %179 = trunc i64 %indvars.iv.23 to i32
  %add40.23 = add i32 %179, %mul39.23
  %idxprom41.23 = zext i32 %add40.23 to i64
  %arrayidx42.23 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.23
  %180 = load float, float* %arrayidx42.23, align 4
  %mul43.23 = fmul float %178, %180
  %add44.23 = fadd float %partial_sum.12.23, %mul43.23
  br label %for.inc.23

for.inc.23:                                       ; preds = %if.end35.23, %for.body23.23
  %partial_sum.2.23 = phi float [ %add44.23, %if.end35.23 ], [ %partial_sum.12.23, %for.body23.23 ]
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %kern_width
  br i1 %exitcond.23, label %for.inc45.23.loopexit, label %for.body23.23, !llvm.loop !1

for.inc45.23.loopexit:                            ; preds = %for.inc.23
  %partial_sum.2.23.lcssa = phi float [ %partial_sum.2.23, %for.inc.23 ]
  br label %for.inc45.23

for.inc45.23:                                     ; preds = %for.inc45.23.loopexit, %for.body14.23
  %partial_sum.3.23 = phi float [ %partial_sum.05.23, %for.body14.23 ], [ %partial_sum.2.23.lcssa, %for.inc45.23.loopexit ]
  %inc46.23 = add nuw nsw i32 %ki.06.23, 1
  %exitcond19.23 = icmp eq i32 %inc46.23, %kern_height
  br i1 %exitcond19.23, label %for.end47.23.loopexit, label %for.body14.23, !llvm.loop !3

for.end47.23.loopexit:                            ; preds = %for.inc45.23
  %partial_sum.3.23.lcssa = phi float [ %partial_sum.3.23, %for.inc45.23 ]
  br label %for.end47.23

for.end47.23:                                     ; preds = %for.end47.23.loopexit, %for.inc64.22
  %partial_sum.0.lcssa.23 = phi float [ 0.000000e+00, %for.inc64.22 ], [ %partial_sum.3.23.lcssa, %for.end47.23.loopexit ]
  br i1 %tobool48, label %if.else.23, label %if.then49.23

if.then49.23:                                     ; preds = %for.end47.23
  %cmp50.23 = fcmp olt float %partial_sum.0.lcssa.23, 0.000000e+00
  %sub52.23 = fsub float -0.000000e+00, %partial_sum.0.lcssa.23
  %cond.23 = select i1 %cmp50.23, float %sub52.23, float %partial_sum.0.lcssa.23
  %conv53.23 = fptoui float %cond.23 to i8
  %conv54.23 = uitofp i8 %conv53.23 to float
  %181 = add nsw i64 %indvars.iv.next21.22, %7
  %arrayidx58.23 = getelementptr inbounds float, float* %1, i64 %181
  store float %conv54.23, float* %arrayidx58.23, align 4
  br label %for.inc64.23

if.else.23:                                       ; preds = %for.end47.23
  %182 = add nsw i64 %indvars.iv.next21.22, %6
  %arrayidx62.23 = getelementptr inbounds float, float* %1, i64 %182
  store float %partial_sum.0.lcssa.23, float* %arrayidx62.23, align 4
  br label %for.inc64.23

for.inc64.23:                                     ; preds = %if.else.23, %if.then49.23
  %inc65.23 = add nsw i32 %in_j.011, 24
  %indvars.iv.next21.23 = add nsw i64 %indvars.iv20, 24
  br i1 %cmp124, label %for.end47.24, label %for.body14.24.preheader

for.body14.24.preheader:                          ; preds = %for.inc64.23
  br label %for.body14.24

for.body14.24:                                    ; preds = %for.body14.24.preheader, %for.inc45.24
  %ki.06.24 = phi i32 [ %inc46.24, %for.inc45.24 ], [ 0, %for.body14.24.preheader ]
  %partial_sum.05.24 = phi float [ %partial_sum.3.24, %for.inc45.24 ], [ 0.000000e+00, %for.body14.24.preheader ]
  %add.24 = add nsw i32 %ki.06.24, %in_i.015
  %notlhs.24 = icmp slt i32 %add.24, 0
  %notrhs.24 = icmp uge i32 %add.24, %img_height
  %.not.24 = or i1 %notrhs.24, %notlhs.24
  %brmerge.24 = or i1 %.not.24, %cmp211.not.24
  br i1 %brmerge.24, label %for.inc45.24, label %for.body23.lr.ph.24

for.body23.lr.ph.24:                              ; preds = %for.body14.24
  %mul.24 = shl i32 %add.24, 7
  %mul39.24 = mul i32 %ki.06.24, %kern_width
  br label %for.body23.24

for.body23.24:                                    ; preds = %for.inc.24, %for.body23.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body23.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc.24 ]
  %partial_sum.12.24 = phi float [ %partial_sum.05.24, %for.body23.lr.ph.24 ], [ %partial_sum.2.24, %for.inc.24 ]
  %183 = trunc i64 %indvars.iv.24 to i32
  %add24.24 = add nsw i32 %183, %inc65.23
  %cmp25.24 = icmp sgt i32 %add24.24, -1
  %cmp29.24 = icmp ult i32 %add24.24, %img_width
  %184 = and i1 %cmp25.24, %cmp29.24
  br i1 %184, label %if.end35.24, label %for.inc.24

if.end35.24:                                      ; preds = %for.body23.24
  %add38.24 = add nsw i32 %add24.24, %mul.24
  %idxprom.24 = sext i32 %add38.24 to i64
  %arrayidx.24 = getelementptr inbounds float, float* %0, i64 %idxprom.24
  %185 = load float, float* %arrayidx.24, align 4
  %186 = trunc i64 %indvars.iv.24 to i32
  %add40.24 = add i32 %186, %mul39.24
  %idxprom41.24 = zext i32 %add40.24 to i64
  %arrayidx42.24 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.24
  %187 = load float, float* %arrayidx42.24, align 4
  %mul43.24 = fmul float %185, %187
  %add44.24 = fadd float %partial_sum.12.24, %mul43.24
  br label %for.inc.24

for.inc.24:                                       ; preds = %if.end35.24, %for.body23.24
  %partial_sum.2.24 = phi float [ %add44.24, %if.end35.24 ], [ %partial_sum.12.24, %for.body23.24 ]
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %kern_width
  br i1 %exitcond.24, label %for.inc45.24.loopexit, label %for.body23.24, !llvm.loop !1

for.inc45.24.loopexit:                            ; preds = %for.inc.24
  %partial_sum.2.24.lcssa = phi float [ %partial_sum.2.24, %for.inc.24 ]
  br label %for.inc45.24

for.inc45.24:                                     ; preds = %for.inc45.24.loopexit, %for.body14.24
  %partial_sum.3.24 = phi float [ %partial_sum.05.24, %for.body14.24 ], [ %partial_sum.2.24.lcssa, %for.inc45.24.loopexit ]
  %inc46.24 = add nuw nsw i32 %ki.06.24, 1
  %exitcond19.24 = icmp eq i32 %inc46.24, %kern_height
  br i1 %exitcond19.24, label %for.end47.24.loopexit, label %for.body14.24, !llvm.loop !3

for.end47.24.loopexit:                            ; preds = %for.inc45.24
  %partial_sum.3.24.lcssa = phi float [ %partial_sum.3.24, %for.inc45.24 ]
  br label %for.end47.24

for.end47.24:                                     ; preds = %for.end47.24.loopexit, %for.inc64.23
  %partial_sum.0.lcssa.24 = phi float [ 0.000000e+00, %for.inc64.23 ], [ %partial_sum.3.24.lcssa, %for.end47.24.loopexit ]
  br i1 %tobool48, label %if.else.24, label %if.then49.24

if.then49.24:                                     ; preds = %for.end47.24
  %cmp50.24 = fcmp olt float %partial_sum.0.lcssa.24, 0.000000e+00
  %sub52.24 = fsub float -0.000000e+00, %partial_sum.0.lcssa.24
  %cond.24 = select i1 %cmp50.24, float %sub52.24, float %partial_sum.0.lcssa.24
  %conv53.24 = fptoui float %cond.24 to i8
  %conv54.24 = uitofp i8 %conv53.24 to float
  %188 = add nsw i64 %indvars.iv.next21.23, %7
  %arrayidx58.24 = getelementptr inbounds float, float* %1, i64 %188
  store float %conv54.24, float* %arrayidx58.24, align 4
  br label %for.inc64.24

if.else.24:                                       ; preds = %for.end47.24
  %189 = add nsw i64 %indvars.iv.next21.23, %6
  %arrayidx62.24 = getelementptr inbounds float, float* %1, i64 %189
  store float %partial_sum.0.lcssa.24, float* %arrayidx62.24, align 4
  br label %for.inc64.24

for.inc64.24:                                     ; preds = %if.else.24, %if.then49.24
  %inc65.24 = add nsw i32 %in_j.011, 25
  %indvars.iv.next21.24 = add nsw i64 %indvars.iv20, 25
  br i1 %cmp124, label %for.end47.25, label %for.body14.25.preheader

for.body14.25.preheader:                          ; preds = %for.inc64.24
  br label %for.body14.25

for.body14.25:                                    ; preds = %for.body14.25.preheader, %for.inc45.25
  %ki.06.25 = phi i32 [ %inc46.25, %for.inc45.25 ], [ 0, %for.body14.25.preheader ]
  %partial_sum.05.25 = phi float [ %partial_sum.3.25, %for.inc45.25 ], [ 0.000000e+00, %for.body14.25.preheader ]
  %add.25 = add nsw i32 %ki.06.25, %in_i.015
  %notlhs.25 = icmp slt i32 %add.25, 0
  %notrhs.25 = icmp uge i32 %add.25, %img_height
  %.not.25 = or i1 %notrhs.25, %notlhs.25
  %brmerge.25 = or i1 %.not.25, %cmp211.not.25
  br i1 %brmerge.25, label %for.inc45.25, label %for.body23.lr.ph.25

for.body23.lr.ph.25:                              ; preds = %for.body14.25
  %mul.25 = shl i32 %add.25, 7
  %mul39.25 = mul i32 %ki.06.25, %kern_width
  br label %for.body23.25

for.body23.25:                                    ; preds = %for.inc.25, %for.body23.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body23.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc.25 ]
  %partial_sum.12.25 = phi float [ %partial_sum.05.25, %for.body23.lr.ph.25 ], [ %partial_sum.2.25, %for.inc.25 ]
  %190 = trunc i64 %indvars.iv.25 to i32
  %add24.25 = add nsw i32 %190, %inc65.24
  %cmp25.25 = icmp sgt i32 %add24.25, -1
  %cmp29.25 = icmp ult i32 %add24.25, %img_width
  %191 = and i1 %cmp25.25, %cmp29.25
  br i1 %191, label %if.end35.25, label %for.inc.25

if.end35.25:                                      ; preds = %for.body23.25
  %add38.25 = add nsw i32 %add24.25, %mul.25
  %idxprom.25 = sext i32 %add38.25 to i64
  %arrayidx.25 = getelementptr inbounds float, float* %0, i64 %idxprom.25
  %192 = load float, float* %arrayidx.25, align 4
  %193 = trunc i64 %indvars.iv.25 to i32
  %add40.25 = add i32 %193, %mul39.25
  %idxprom41.25 = zext i32 %add40.25 to i64
  %arrayidx42.25 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.25
  %194 = load float, float* %arrayidx42.25, align 4
  %mul43.25 = fmul float %192, %194
  %add44.25 = fadd float %partial_sum.12.25, %mul43.25
  br label %for.inc.25

for.inc.25:                                       ; preds = %if.end35.25, %for.body23.25
  %partial_sum.2.25 = phi float [ %add44.25, %if.end35.25 ], [ %partial_sum.12.25, %for.body23.25 ]
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %kern_width
  br i1 %exitcond.25, label %for.inc45.25.loopexit, label %for.body23.25, !llvm.loop !1

for.inc45.25.loopexit:                            ; preds = %for.inc.25
  %partial_sum.2.25.lcssa = phi float [ %partial_sum.2.25, %for.inc.25 ]
  br label %for.inc45.25

for.inc45.25:                                     ; preds = %for.inc45.25.loopexit, %for.body14.25
  %partial_sum.3.25 = phi float [ %partial_sum.05.25, %for.body14.25 ], [ %partial_sum.2.25.lcssa, %for.inc45.25.loopexit ]
  %inc46.25 = add nuw nsw i32 %ki.06.25, 1
  %exitcond19.25 = icmp eq i32 %inc46.25, %kern_height
  br i1 %exitcond19.25, label %for.end47.25.loopexit, label %for.body14.25, !llvm.loop !3

for.end47.25.loopexit:                            ; preds = %for.inc45.25
  %partial_sum.3.25.lcssa = phi float [ %partial_sum.3.25, %for.inc45.25 ]
  br label %for.end47.25

for.end47.25:                                     ; preds = %for.end47.25.loopexit, %for.inc64.24
  %partial_sum.0.lcssa.25 = phi float [ 0.000000e+00, %for.inc64.24 ], [ %partial_sum.3.25.lcssa, %for.end47.25.loopexit ]
  br i1 %tobool48, label %if.else.25, label %if.then49.25

if.then49.25:                                     ; preds = %for.end47.25
  %cmp50.25 = fcmp olt float %partial_sum.0.lcssa.25, 0.000000e+00
  %sub52.25 = fsub float -0.000000e+00, %partial_sum.0.lcssa.25
  %cond.25 = select i1 %cmp50.25, float %sub52.25, float %partial_sum.0.lcssa.25
  %conv53.25 = fptoui float %cond.25 to i8
  %conv54.25 = uitofp i8 %conv53.25 to float
  %195 = add nsw i64 %indvars.iv.next21.24, %7
  %arrayidx58.25 = getelementptr inbounds float, float* %1, i64 %195
  store float %conv54.25, float* %arrayidx58.25, align 4
  br label %for.inc64.25

if.else.25:                                       ; preds = %for.end47.25
  %196 = add nsw i64 %indvars.iv.next21.24, %6
  %arrayidx62.25 = getelementptr inbounds float, float* %1, i64 %196
  store float %partial_sum.0.lcssa.25, float* %arrayidx62.25, align 4
  br label %for.inc64.25

for.inc64.25:                                     ; preds = %if.else.25, %if.then49.25
  %inc65.25 = add nsw i32 %in_j.011, 26
  %indvars.iv.next21.25 = add nsw i64 %indvars.iv20, 26
  br i1 %cmp124, label %for.end47.26, label %for.body14.26.preheader

for.body14.26.preheader:                          ; preds = %for.inc64.25
  br label %for.body14.26

for.body14.26:                                    ; preds = %for.body14.26.preheader, %for.inc45.26
  %ki.06.26 = phi i32 [ %inc46.26, %for.inc45.26 ], [ 0, %for.body14.26.preheader ]
  %partial_sum.05.26 = phi float [ %partial_sum.3.26, %for.inc45.26 ], [ 0.000000e+00, %for.body14.26.preheader ]
  %add.26 = add nsw i32 %ki.06.26, %in_i.015
  %notlhs.26 = icmp slt i32 %add.26, 0
  %notrhs.26 = icmp uge i32 %add.26, %img_height
  %.not.26 = or i1 %notrhs.26, %notlhs.26
  %brmerge.26 = or i1 %.not.26, %cmp211.not.26
  br i1 %brmerge.26, label %for.inc45.26, label %for.body23.lr.ph.26

for.body23.lr.ph.26:                              ; preds = %for.body14.26
  %mul.26 = shl i32 %add.26, 7
  %mul39.26 = mul i32 %ki.06.26, %kern_width
  br label %for.body23.26

for.body23.26:                                    ; preds = %for.inc.26, %for.body23.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body23.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc.26 ]
  %partial_sum.12.26 = phi float [ %partial_sum.05.26, %for.body23.lr.ph.26 ], [ %partial_sum.2.26, %for.inc.26 ]
  %197 = trunc i64 %indvars.iv.26 to i32
  %add24.26 = add nsw i32 %197, %inc65.25
  %cmp25.26 = icmp sgt i32 %add24.26, -1
  %cmp29.26 = icmp ult i32 %add24.26, %img_width
  %198 = and i1 %cmp25.26, %cmp29.26
  br i1 %198, label %if.end35.26, label %for.inc.26

if.end35.26:                                      ; preds = %for.body23.26
  %add38.26 = add nsw i32 %add24.26, %mul.26
  %idxprom.26 = sext i32 %add38.26 to i64
  %arrayidx.26 = getelementptr inbounds float, float* %0, i64 %idxprom.26
  %199 = load float, float* %arrayidx.26, align 4
  %200 = trunc i64 %indvars.iv.26 to i32
  %add40.26 = add i32 %200, %mul39.26
  %idxprom41.26 = zext i32 %add40.26 to i64
  %arrayidx42.26 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.26
  %201 = load float, float* %arrayidx42.26, align 4
  %mul43.26 = fmul float %199, %201
  %add44.26 = fadd float %partial_sum.12.26, %mul43.26
  br label %for.inc.26

for.inc.26:                                       ; preds = %if.end35.26, %for.body23.26
  %partial_sum.2.26 = phi float [ %add44.26, %if.end35.26 ], [ %partial_sum.12.26, %for.body23.26 ]
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %kern_width
  br i1 %exitcond.26, label %for.inc45.26.loopexit, label %for.body23.26, !llvm.loop !1

for.inc45.26.loopexit:                            ; preds = %for.inc.26
  %partial_sum.2.26.lcssa = phi float [ %partial_sum.2.26, %for.inc.26 ]
  br label %for.inc45.26

for.inc45.26:                                     ; preds = %for.inc45.26.loopexit, %for.body14.26
  %partial_sum.3.26 = phi float [ %partial_sum.05.26, %for.body14.26 ], [ %partial_sum.2.26.lcssa, %for.inc45.26.loopexit ]
  %inc46.26 = add nuw nsw i32 %ki.06.26, 1
  %exitcond19.26 = icmp eq i32 %inc46.26, %kern_height
  br i1 %exitcond19.26, label %for.end47.26.loopexit, label %for.body14.26, !llvm.loop !3

for.end47.26.loopexit:                            ; preds = %for.inc45.26
  %partial_sum.3.26.lcssa = phi float [ %partial_sum.3.26, %for.inc45.26 ]
  br label %for.end47.26

for.end47.26:                                     ; preds = %for.end47.26.loopexit, %for.inc64.25
  %partial_sum.0.lcssa.26 = phi float [ 0.000000e+00, %for.inc64.25 ], [ %partial_sum.3.26.lcssa, %for.end47.26.loopexit ]
  br i1 %tobool48, label %if.else.26, label %if.then49.26

if.then49.26:                                     ; preds = %for.end47.26
  %cmp50.26 = fcmp olt float %partial_sum.0.lcssa.26, 0.000000e+00
  %sub52.26 = fsub float -0.000000e+00, %partial_sum.0.lcssa.26
  %cond.26 = select i1 %cmp50.26, float %sub52.26, float %partial_sum.0.lcssa.26
  %conv53.26 = fptoui float %cond.26 to i8
  %conv54.26 = uitofp i8 %conv53.26 to float
  %202 = add nsw i64 %indvars.iv.next21.25, %7
  %arrayidx58.26 = getelementptr inbounds float, float* %1, i64 %202
  store float %conv54.26, float* %arrayidx58.26, align 4
  br label %for.inc64.26

if.else.26:                                       ; preds = %for.end47.26
  %203 = add nsw i64 %indvars.iv.next21.25, %6
  %arrayidx62.26 = getelementptr inbounds float, float* %1, i64 %203
  store float %partial_sum.0.lcssa.26, float* %arrayidx62.26, align 4
  br label %for.inc64.26

for.inc64.26:                                     ; preds = %if.else.26, %if.then49.26
  %inc65.26 = add nsw i32 %in_j.011, 27
  %indvars.iv.next21.26 = add nsw i64 %indvars.iv20, 27
  br i1 %cmp124, label %for.end47.27, label %for.body14.27.preheader

for.body14.27.preheader:                          ; preds = %for.inc64.26
  br label %for.body14.27

for.body14.27:                                    ; preds = %for.body14.27.preheader, %for.inc45.27
  %ki.06.27 = phi i32 [ %inc46.27, %for.inc45.27 ], [ 0, %for.body14.27.preheader ]
  %partial_sum.05.27 = phi float [ %partial_sum.3.27, %for.inc45.27 ], [ 0.000000e+00, %for.body14.27.preheader ]
  %add.27 = add nsw i32 %ki.06.27, %in_i.015
  %notlhs.27 = icmp slt i32 %add.27, 0
  %notrhs.27 = icmp uge i32 %add.27, %img_height
  %.not.27 = or i1 %notrhs.27, %notlhs.27
  %brmerge.27 = or i1 %.not.27, %cmp211.not.27
  br i1 %brmerge.27, label %for.inc45.27, label %for.body23.lr.ph.27

for.body23.lr.ph.27:                              ; preds = %for.body14.27
  %mul.27 = shl i32 %add.27, 7
  %mul39.27 = mul i32 %ki.06.27, %kern_width
  br label %for.body23.27

for.body23.27:                                    ; preds = %for.inc.27, %for.body23.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body23.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc.27 ]
  %partial_sum.12.27 = phi float [ %partial_sum.05.27, %for.body23.lr.ph.27 ], [ %partial_sum.2.27, %for.inc.27 ]
  %204 = trunc i64 %indvars.iv.27 to i32
  %add24.27 = add nsw i32 %204, %inc65.26
  %cmp25.27 = icmp sgt i32 %add24.27, -1
  %cmp29.27 = icmp ult i32 %add24.27, %img_width
  %205 = and i1 %cmp25.27, %cmp29.27
  br i1 %205, label %if.end35.27, label %for.inc.27

if.end35.27:                                      ; preds = %for.body23.27
  %add38.27 = add nsw i32 %add24.27, %mul.27
  %idxprom.27 = sext i32 %add38.27 to i64
  %arrayidx.27 = getelementptr inbounds float, float* %0, i64 %idxprom.27
  %206 = load float, float* %arrayidx.27, align 4
  %207 = trunc i64 %indvars.iv.27 to i32
  %add40.27 = add i32 %207, %mul39.27
  %idxprom41.27 = zext i32 %add40.27 to i64
  %arrayidx42.27 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.27
  %208 = load float, float* %arrayidx42.27, align 4
  %mul43.27 = fmul float %206, %208
  %add44.27 = fadd float %partial_sum.12.27, %mul43.27
  br label %for.inc.27

for.inc.27:                                       ; preds = %if.end35.27, %for.body23.27
  %partial_sum.2.27 = phi float [ %add44.27, %if.end35.27 ], [ %partial_sum.12.27, %for.body23.27 ]
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %kern_width
  br i1 %exitcond.27, label %for.inc45.27.loopexit, label %for.body23.27, !llvm.loop !1

for.inc45.27.loopexit:                            ; preds = %for.inc.27
  %partial_sum.2.27.lcssa = phi float [ %partial_sum.2.27, %for.inc.27 ]
  br label %for.inc45.27

for.inc45.27:                                     ; preds = %for.inc45.27.loopexit, %for.body14.27
  %partial_sum.3.27 = phi float [ %partial_sum.05.27, %for.body14.27 ], [ %partial_sum.2.27.lcssa, %for.inc45.27.loopexit ]
  %inc46.27 = add nuw nsw i32 %ki.06.27, 1
  %exitcond19.27 = icmp eq i32 %inc46.27, %kern_height
  br i1 %exitcond19.27, label %for.end47.27.loopexit, label %for.body14.27, !llvm.loop !3

for.end47.27.loopexit:                            ; preds = %for.inc45.27
  %partial_sum.3.27.lcssa = phi float [ %partial_sum.3.27, %for.inc45.27 ]
  br label %for.end47.27

for.end47.27:                                     ; preds = %for.end47.27.loopexit, %for.inc64.26
  %partial_sum.0.lcssa.27 = phi float [ 0.000000e+00, %for.inc64.26 ], [ %partial_sum.3.27.lcssa, %for.end47.27.loopexit ]
  br i1 %tobool48, label %if.else.27, label %if.then49.27

if.then49.27:                                     ; preds = %for.end47.27
  %cmp50.27 = fcmp olt float %partial_sum.0.lcssa.27, 0.000000e+00
  %sub52.27 = fsub float -0.000000e+00, %partial_sum.0.lcssa.27
  %cond.27 = select i1 %cmp50.27, float %sub52.27, float %partial_sum.0.lcssa.27
  %conv53.27 = fptoui float %cond.27 to i8
  %conv54.27 = uitofp i8 %conv53.27 to float
  %209 = add nsw i64 %indvars.iv.next21.26, %7
  %arrayidx58.27 = getelementptr inbounds float, float* %1, i64 %209
  store float %conv54.27, float* %arrayidx58.27, align 4
  br label %for.inc64.27

if.else.27:                                       ; preds = %for.end47.27
  %210 = add nsw i64 %indvars.iv.next21.26, %6
  %arrayidx62.27 = getelementptr inbounds float, float* %1, i64 %210
  store float %partial_sum.0.lcssa.27, float* %arrayidx62.27, align 4
  br label %for.inc64.27

for.inc64.27:                                     ; preds = %if.else.27, %if.then49.27
  %inc65.27 = add nsw i32 %in_j.011, 28
  %indvars.iv.next21.27 = add nsw i64 %indvars.iv20, 28
  br i1 %cmp124, label %for.end47.28, label %for.body14.28.preheader

for.body14.28.preheader:                          ; preds = %for.inc64.27
  br label %for.body14.28

for.body14.28:                                    ; preds = %for.body14.28.preheader, %for.inc45.28
  %ki.06.28 = phi i32 [ %inc46.28, %for.inc45.28 ], [ 0, %for.body14.28.preheader ]
  %partial_sum.05.28 = phi float [ %partial_sum.3.28, %for.inc45.28 ], [ 0.000000e+00, %for.body14.28.preheader ]
  %add.28 = add nsw i32 %ki.06.28, %in_i.015
  %notlhs.28 = icmp slt i32 %add.28, 0
  %notrhs.28 = icmp uge i32 %add.28, %img_height
  %.not.28 = or i1 %notrhs.28, %notlhs.28
  %brmerge.28 = or i1 %.not.28, %cmp211.not.28
  br i1 %brmerge.28, label %for.inc45.28, label %for.body23.lr.ph.28

for.body23.lr.ph.28:                              ; preds = %for.body14.28
  %mul.28 = shl i32 %add.28, 7
  %mul39.28 = mul i32 %ki.06.28, %kern_width
  br label %for.body23.28

for.body23.28:                                    ; preds = %for.inc.28, %for.body23.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body23.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc.28 ]
  %partial_sum.12.28 = phi float [ %partial_sum.05.28, %for.body23.lr.ph.28 ], [ %partial_sum.2.28, %for.inc.28 ]
  %211 = trunc i64 %indvars.iv.28 to i32
  %add24.28 = add nsw i32 %211, %inc65.27
  %cmp25.28 = icmp sgt i32 %add24.28, -1
  %cmp29.28 = icmp ult i32 %add24.28, %img_width
  %212 = and i1 %cmp25.28, %cmp29.28
  br i1 %212, label %if.end35.28, label %for.inc.28

if.end35.28:                                      ; preds = %for.body23.28
  %add38.28 = add nsw i32 %add24.28, %mul.28
  %idxprom.28 = sext i32 %add38.28 to i64
  %arrayidx.28 = getelementptr inbounds float, float* %0, i64 %idxprom.28
  %213 = load float, float* %arrayidx.28, align 4
  %214 = trunc i64 %indvars.iv.28 to i32
  %add40.28 = add i32 %214, %mul39.28
  %idxprom41.28 = zext i32 %add40.28 to i64
  %arrayidx42.28 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.28
  %215 = load float, float* %arrayidx42.28, align 4
  %mul43.28 = fmul float %213, %215
  %add44.28 = fadd float %partial_sum.12.28, %mul43.28
  br label %for.inc.28

for.inc.28:                                       ; preds = %if.end35.28, %for.body23.28
  %partial_sum.2.28 = phi float [ %add44.28, %if.end35.28 ], [ %partial_sum.12.28, %for.body23.28 ]
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %kern_width
  br i1 %exitcond.28, label %for.inc45.28.loopexit, label %for.body23.28, !llvm.loop !1

for.inc45.28.loopexit:                            ; preds = %for.inc.28
  %partial_sum.2.28.lcssa = phi float [ %partial_sum.2.28, %for.inc.28 ]
  br label %for.inc45.28

for.inc45.28:                                     ; preds = %for.inc45.28.loopexit, %for.body14.28
  %partial_sum.3.28 = phi float [ %partial_sum.05.28, %for.body14.28 ], [ %partial_sum.2.28.lcssa, %for.inc45.28.loopexit ]
  %inc46.28 = add nuw nsw i32 %ki.06.28, 1
  %exitcond19.28 = icmp eq i32 %inc46.28, %kern_height
  br i1 %exitcond19.28, label %for.end47.28.loopexit, label %for.body14.28, !llvm.loop !3

for.end47.28.loopexit:                            ; preds = %for.inc45.28
  %partial_sum.3.28.lcssa = phi float [ %partial_sum.3.28, %for.inc45.28 ]
  br label %for.end47.28

for.end47.28:                                     ; preds = %for.end47.28.loopexit, %for.inc64.27
  %partial_sum.0.lcssa.28 = phi float [ 0.000000e+00, %for.inc64.27 ], [ %partial_sum.3.28.lcssa, %for.end47.28.loopexit ]
  br i1 %tobool48, label %if.else.28, label %if.then49.28

if.then49.28:                                     ; preds = %for.end47.28
  %cmp50.28 = fcmp olt float %partial_sum.0.lcssa.28, 0.000000e+00
  %sub52.28 = fsub float -0.000000e+00, %partial_sum.0.lcssa.28
  %cond.28 = select i1 %cmp50.28, float %sub52.28, float %partial_sum.0.lcssa.28
  %conv53.28 = fptoui float %cond.28 to i8
  %conv54.28 = uitofp i8 %conv53.28 to float
  %216 = add nsw i64 %indvars.iv.next21.27, %7
  %arrayidx58.28 = getelementptr inbounds float, float* %1, i64 %216
  store float %conv54.28, float* %arrayidx58.28, align 4
  br label %for.inc64.28

if.else.28:                                       ; preds = %for.end47.28
  %217 = add nsw i64 %indvars.iv.next21.27, %6
  %arrayidx62.28 = getelementptr inbounds float, float* %1, i64 %217
  store float %partial_sum.0.lcssa.28, float* %arrayidx62.28, align 4
  br label %for.inc64.28

for.inc64.28:                                     ; preds = %if.else.28, %if.then49.28
  %inc65.28 = add nsw i32 %in_j.011, 29
  %indvars.iv.next21.28 = add nsw i64 %indvars.iv20, 29
  br i1 %cmp124, label %for.end47.29, label %for.body14.29.preheader

for.body14.29.preheader:                          ; preds = %for.inc64.28
  br label %for.body14.29

for.body14.29:                                    ; preds = %for.body14.29.preheader, %for.inc45.29
  %ki.06.29 = phi i32 [ %inc46.29, %for.inc45.29 ], [ 0, %for.body14.29.preheader ]
  %partial_sum.05.29 = phi float [ %partial_sum.3.29, %for.inc45.29 ], [ 0.000000e+00, %for.body14.29.preheader ]
  %add.29 = add nsw i32 %ki.06.29, %in_i.015
  %notlhs.29 = icmp slt i32 %add.29, 0
  %notrhs.29 = icmp uge i32 %add.29, %img_height
  %.not.29 = or i1 %notrhs.29, %notlhs.29
  %brmerge.29 = or i1 %.not.29, %cmp211.not.29
  br i1 %brmerge.29, label %for.inc45.29, label %for.body23.lr.ph.29

for.body23.lr.ph.29:                              ; preds = %for.body14.29
  %mul.29 = shl i32 %add.29, 7
  %mul39.29 = mul i32 %ki.06.29, %kern_width
  br label %for.body23.29

for.body23.29:                                    ; preds = %for.inc.29, %for.body23.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body23.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc.29 ]
  %partial_sum.12.29 = phi float [ %partial_sum.05.29, %for.body23.lr.ph.29 ], [ %partial_sum.2.29, %for.inc.29 ]
  %218 = trunc i64 %indvars.iv.29 to i32
  %add24.29 = add nsw i32 %218, %inc65.28
  %cmp25.29 = icmp sgt i32 %add24.29, -1
  %cmp29.29 = icmp ult i32 %add24.29, %img_width
  %219 = and i1 %cmp25.29, %cmp29.29
  br i1 %219, label %if.end35.29, label %for.inc.29

if.end35.29:                                      ; preds = %for.body23.29
  %add38.29 = add nsw i32 %add24.29, %mul.29
  %idxprom.29 = sext i32 %add38.29 to i64
  %arrayidx.29 = getelementptr inbounds float, float* %0, i64 %idxprom.29
  %220 = load float, float* %arrayidx.29, align 4
  %221 = trunc i64 %indvars.iv.29 to i32
  %add40.29 = add i32 %221, %mul39.29
  %idxprom41.29 = zext i32 %add40.29 to i64
  %arrayidx42.29 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.29
  %222 = load float, float* %arrayidx42.29, align 4
  %mul43.29 = fmul float %220, %222
  %add44.29 = fadd float %partial_sum.12.29, %mul43.29
  br label %for.inc.29

for.inc.29:                                       ; preds = %if.end35.29, %for.body23.29
  %partial_sum.2.29 = phi float [ %add44.29, %if.end35.29 ], [ %partial_sum.12.29, %for.body23.29 ]
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %kern_width
  br i1 %exitcond.29, label %for.inc45.29.loopexit, label %for.body23.29, !llvm.loop !1

for.inc45.29.loopexit:                            ; preds = %for.inc.29
  %partial_sum.2.29.lcssa = phi float [ %partial_sum.2.29, %for.inc.29 ]
  br label %for.inc45.29

for.inc45.29:                                     ; preds = %for.inc45.29.loopexit, %for.body14.29
  %partial_sum.3.29 = phi float [ %partial_sum.05.29, %for.body14.29 ], [ %partial_sum.2.29.lcssa, %for.inc45.29.loopexit ]
  %inc46.29 = add nuw nsw i32 %ki.06.29, 1
  %exitcond19.29 = icmp eq i32 %inc46.29, %kern_height
  br i1 %exitcond19.29, label %for.end47.29.loopexit, label %for.body14.29, !llvm.loop !3

for.end47.29.loopexit:                            ; preds = %for.inc45.29
  %partial_sum.3.29.lcssa = phi float [ %partial_sum.3.29, %for.inc45.29 ]
  br label %for.end47.29

for.end47.29:                                     ; preds = %for.end47.29.loopexit, %for.inc64.28
  %partial_sum.0.lcssa.29 = phi float [ 0.000000e+00, %for.inc64.28 ], [ %partial_sum.3.29.lcssa, %for.end47.29.loopexit ]
  br i1 %tobool48, label %if.else.29, label %if.then49.29

if.then49.29:                                     ; preds = %for.end47.29
  %cmp50.29 = fcmp olt float %partial_sum.0.lcssa.29, 0.000000e+00
  %sub52.29 = fsub float -0.000000e+00, %partial_sum.0.lcssa.29
  %cond.29 = select i1 %cmp50.29, float %sub52.29, float %partial_sum.0.lcssa.29
  %conv53.29 = fptoui float %cond.29 to i8
  %conv54.29 = uitofp i8 %conv53.29 to float
  %223 = add nsw i64 %indvars.iv.next21.28, %7
  %arrayidx58.29 = getelementptr inbounds float, float* %1, i64 %223
  store float %conv54.29, float* %arrayidx58.29, align 4
  br label %for.inc64.29

if.else.29:                                       ; preds = %for.end47.29
  %224 = add nsw i64 %indvars.iv.next21.28, %6
  %arrayidx62.29 = getelementptr inbounds float, float* %1, i64 %224
  store float %partial_sum.0.lcssa.29, float* %arrayidx62.29, align 4
  br label %for.inc64.29

for.inc64.29:                                     ; preds = %if.else.29, %if.then49.29
  %inc65.29 = add nsw i32 %in_j.011, 30
  %indvars.iv.next21.29 = add nsw i64 %indvars.iv20, 30
  br i1 %cmp124, label %for.end47.30, label %for.body14.30.preheader

for.body14.30.preheader:                          ; preds = %for.inc64.29
  br label %for.body14.30

for.body14.30:                                    ; preds = %for.body14.30.preheader, %for.inc45.30
  %ki.06.30 = phi i32 [ %inc46.30, %for.inc45.30 ], [ 0, %for.body14.30.preheader ]
  %partial_sum.05.30 = phi float [ %partial_sum.3.30, %for.inc45.30 ], [ 0.000000e+00, %for.body14.30.preheader ]
  %add.30 = add nsw i32 %ki.06.30, %in_i.015
  %notlhs.30 = icmp slt i32 %add.30, 0
  %notrhs.30 = icmp uge i32 %add.30, %img_height
  %.not.30 = or i1 %notrhs.30, %notlhs.30
  %brmerge.30 = or i1 %.not.30, %cmp211.not.30
  br i1 %brmerge.30, label %for.inc45.30, label %for.body23.lr.ph.30

for.body23.lr.ph.30:                              ; preds = %for.body14.30
  %mul.30 = shl i32 %add.30, 7
  %mul39.30 = mul i32 %ki.06.30, %kern_width
  br label %for.body23.30

for.body23.30:                                    ; preds = %for.inc.30, %for.body23.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body23.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc.30 ]
  %partial_sum.12.30 = phi float [ %partial_sum.05.30, %for.body23.lr.ph.30 ], [ %partial_sum.2.30, %for.inc.30 ]
  %225 = trunc i64 %indvars.iv.30 to i32
  %add24.30 = add nsw i32 %225, %inc65.29
  %cmp25.30 = icmp sgt i32 %add24.30, -1
  %cmp29.30 = icmp ult i32 %add24.30, %img_width
  %226 = and i1 %cmp25.30, %cmp29.30
  br i1 %226, label %if.end35.30, label %for.inc.30

if.end35.30:                                      ; preds = %for.body23.30
  %add38.30 = add nsw i32 %add24.30, %mul.30
  %idxprom.30 = sext i32 %add38.30 to i64
  %arrayidx.30 = getelementptr inbounds float, float* %0, i64 %idxprom.30
  %227 = load float, float* %arrayidx.30, align 4
  %228 = trunc i64 %indvars.iv.30 to i32
  %add40.30 = add i32 %228, %mul39.30
  %idxprom41.30 = zext i32 %add40.30 to i64
  %arrayidx42.30 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.30
  %229 = load float, float* %arrayidx42.30, align 4
  %mul43.30 = fmul float %227, %229
  %add44.30 = fadd float %partial_sum.12.30, %mul43.30
  br label %for.inc.30

for.inc.30:                                       ; preds = %if.end35.30, %for.body23.30
  %partial_sum.2.30 = phi float [ %add44.30, %if.end35.30 ], [ %partial_sum.12.30, %for.body23.30 ]
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %kern_width
  br i1 %exitcond.30, label %for.inc45.30.loopexit, label %for.body23.30, !llvm.loop !1

for.inc45.30.loopexit:                            ; preds = %for.inc.30
  %partial_sum.2.30.lcssa = phi float [ %partial_sum.2.30, %for.inc.30 ]
  br label %for.inc45.30

for.inc45.30:                                     ; preds = %for.inc45.30.loopexit, %for.body14.30
  %partial_sum.3.30 = phi float [ %partial_sum.05.30, %for.body14.30 ], [ %partial_sum.2.30.lcssa, %for.inc45.30.loopexit ]
  %inc46.30 = add nuw nsw i32 %ki.06.30, 1
  %exitcond19.30 = icmp eq i32 %inc46.30, %kern_height
  br i1 %exitcond19.30, label %for.end47.30.loopexit, label %for.body14.30, !llvm.loop !3

for.end47.30.loopexit:                            ; preds = %for.inc45.30
  %partial_sum.3.30.lcssa = phi float [ %partial_sum.3.30, %for.inc45.30 ]
  br label %for.end47.30

for.end47.30:                                     ; preds = %for.end47.30.loopexit, %for.inc64.29
  %partial_sum.0.lcssa.30 = phi float [ 0.000000e+00, %for.inc64.29 ], [ %partial_sum.3.30.lcssa, %for.end47.30.loopexit ]
  br i1 %tobool48, label %if.else.30, label %if.then49.30

if.then49.30:                                     ; preds = %for.end47.30
  %cmp50.30 = fcmp olt float %partial_sum.0.lcssa.30, 0.000000e+00
  %sub52.30 = fsub float -0.000000e+00, %partial_sum.0.lcssa.30
  %cond.30 = select i1 %cmp50.30, float %sub52.30, float %partial_sum.0.lcssa.30
  %conv53.30 = fptoui float %cond.30 to i8
  %conv54.30 = uitofp i8 %conv53.30 to float
  %230 = add nsw i64 %indvars.iv.next21.29, %7
  %arrayidx58.30 = getelementptr inbounds float, float* %1, i64 %230
  store float %conv54.30, float* %arrayidx58.30, align 4
  br label %for.inc64.30

if.else.30:                                       ; preds = %for.end47.30
  %231 = add nsw i64 %indvars.iv.next21.29, %6
  %arrayidx62.30 = getelementptr inbounds float, float* %1, i64 %231
  store float %partial_sum.0.lcssa.30, float* %arrayidx62.30, align 4
  br label %for.inc64.30

for.inc64.30:                                     ; preds = %if.else.30, %if.then49.30
  %inc65.30 = add nsw i32 %in_j.011, 31
  %indvars.iv.next21.30 = add nsw i64 %indvars.iv20, 31
  br i1 %cmp124, label %for.end47.31, label %for.body14.31.preheader

for.body14.31.preheader:                          ; preds = %for.inc64.30
  br label %for.body14.31

for.body14.31:                                    ; preds = %for.body14.31.preheader, %for.inc45.31
  %ki.06.31 = phi i32 [ %inc46.31, %for.inc45.31 ], [ 0, %for.body14.31.preheader ]
  %partial_sum.05.31 = phi float [ %partial_sum.3.31, %for.inc45.31 ], [ 0.000000e+00, %for.body14.31.preheader ]
  %add.31 = add nsw i32 %ki.06.31, %in_i.015
  %notlhs.31 = icmp slt i32 %add.31, 0
  %notrhs.31 = icmp uge i32 %add.31, %img_height
  %.not.31 = or i1 %notrhs.31, %notlhs.31
  %brmerge.31 = or i1 %.not.31, %cmp211.not.31
  br i1 %brmerge.31, label %for.inc45.31, label %for.body23.lr.ph.31

for.body23.lr.ph.31:                              ; preds = %for.body14.31
  %mul.31 = shl i32 %add.31, 7
  %mul39.31 = mul i32 %ki.06.31, %kern_width
  br label %for.body23.31

for.body23.31:                                    ; preds = %for.inc.31, %for.body23.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body23.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc.31 ]
  %partial_sum.12.31 = phi float [ %partial_sum.05.31, %for.body23.lr.ph.31 ], [ %partial_sum.2.31, %for.inc.31 ]
  %232 = trunc i64 %indvars.iv.31 to i32
  %add24.31 = add nsw i32 %232, %inc65.30
  %cmp25.31 = icmp sgt i32 %add24.31, -1
  %cmp29.31 = icmp ult i32 %add24.31, %img_width
  %233 = and i1 %cmp25.31, %cmp29.31
  br i1 %233, label %if.end35.31, label %for.inc.31

if.end35.31:                                      ; preds = %for.body23.31
  %add38.31 = add nsw i32 %add24.31, %mul.31
  %idxprom.31 = sext i32 %add38.31 to i64
  %arrayidx.31 = getelementptr inbounds float, float* %0, i64 %idxprom.31
  %234 = load float, float* %arrayidx.31, align 4
  %235 = trunc i64 %indvars.iv.31 to i32
  %add40.31 = add i32 %235, %mul39.31
  %idxprom41.31 = zext i32 %add40.31 to i64
  %arrayidx42.31 = getelementptr inbounds float, float* inttoptr (i64 570621984 to float*), i64 %idxprom41.31
  %236 = load float, float* %arrayidx42.31, align 4
  %mul43.31 = fmul float %234, %236
  %add44.31 = fadd float %partial_sum.12.31, %mul43.31
  br label %for.inc.31

for.inc.31:                                       ; preds = %if.end35.31, %for.body23.31
  %partial_sum.2.31 = phi float [ %add44.31, %if.end35.31 ], [ %partial_sum.12.31, %for.body23.31 ]
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %kern_width
  br i1 %exitcond.31, label %for.inc45.31.loopexit, label %for.body23.31, !llvm.loop !1

for.inc45.31.loopexit:                            ; preds = %for.inc.31
  %partial_sum.2.31.lcssa = phi float [ %partial_sum.2.31, %for.inc.31 ]
  br label %for.inc45.31

for.inc45.31:                                     ; preds = %for.inc45.31.loopexit, %for.body14.31
  %partial_sum.3.31 = phi float [ %partial_sum.05.31, %for.body14.31 ], [ %partial_sum.2.31.lcssa, %for.inc45.31.loopexit ]
  %inc46.31 = add nuw nsw i32 %ki.06.31, 1
  %exitcond19.31 = icmp eq i32 %inc46.31, %kern_height
  br i1 %exitcond19.31, label %for.end47.31.loopexit, label %for.body14.31, !llvm.loop !3

for.end47.31.loopexit:                            ; preds = %for.inc45.31
  %partial_sum.3.31.lcssa = phi float [ %partial_sum.3.31, %for.inc45.31 ]
  br label %for.end47.31

for.end47.31:                                     ; preds = %for.end47.31.loopexit, %for.inc64.30
  %partial_sum.0.lcssa.31 = phi float [ 0.000000e+00, %for.inc64.30 ], [ %partial_sum.3.31.lcssa, %for.end47.31.loopexit ]
  br i1 %tobool48, label %if.else.31, label %if.then49.31

if.then49.31:                                     ; preds = %for.end47.31
  %cmp50.31 = fcmp olt float %partial_sum.0.lcssa.31, 0.000000e+00
  %sub52.31 = fsub float -0.000000e+00, %partial_sum.0.lcssa.31
  %cond.31 = select i1 %cmp50.31, float %sub52.31, float %partial_sum.0.lcssa.31
  %conv53.31 = fptoui float %cond.31 to i8
  %conv54.31 = uitofp i8 %conv53.31 to float
  %237 = add nsw i64 %indvars.iv.next21.30, %7
  %arrayidx58.31 = getelementptr inbounds float, float* %1, i64 %237
  store float %conv54.31, float* %arrayidx58.31, align 4
  br label %for.inc64.31

if.else.31:                                       ; preds = %for.end47.31
  %238 = add nsw i64 %indvars.iv.next21.30, %6
  %arrayidx62.31 = getelementptr inbounds float, float* %1, i64 %238
  store float %partial_sum.0.lcssa.31, float* %arrayidx62.31, align 4
  br label %for.inc64.31

for.inc64.31:                                     ; preds = %if.else.31, %if.then49.31
  %inc65.31 = add nsw i32 %in_j.011, 32
  %indvars.iv.next21.31 = add nsw i64 %indvars.iv20, 32
  %lftr.wideiv24.31 = trunc i64 %indvars.iv.next21.31 to i32
  %exitcond25.31 = icmp eq i32 %lftr.wideiv24.31, %img_width
  br i1 %exitcond25.31, label %for.inc68.loopexit, label %for.cond11.preheader, !llvm.loop !6
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
