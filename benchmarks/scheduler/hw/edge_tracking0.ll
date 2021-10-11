; ModuleID = 'edge_tracking0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @edge_tracking(i32 %img_height, i32 %img_width, float %thr_weak_ratio, float %thr_strong_ratio, i32 %output_spm_addr) #0 {
entry:
  %conv = zext i32 %output_spm_addr to i64
  %0 = inttoptr i64 %conv to i8*
  %sub = add i32 %img_height, -1
  %sub1 = add i32 %img_width, -1
  %mul = mul i32 %img_width, %img_height
  %cmp13 = icmp sgt i32 %mul, 0
  br i1 %cmp13, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %1 = mul i32 %img_width, %img_height
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %indvars.iv32 = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next33, %for.body ]
  %img_max.014 = phi i32 [ 0, %for.body.preheader ], [ %.img_max.0, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %indvars.iv32
  %2 = load i32, i32* %arrayidx, align 4
  %cmp3 = icmp ugt i32 %2, %img_max.014
  %.img_max.0 = select i1 %cmp3, i32 %2, i32 %img_max.014
  %indvars.iv.next33 = add nuw nsw i64 %indvars.iv32, 1
  %lftr.wideiv34 = trunc i64 %indvars.iv.next33 to i32
  %exitcond35 = icmp eq i32 %lftr.wideiv34, %1
  br i1 %exitcond35, label %for.end.loopexit, label %for.body, !llvm.loop !1

for.end.loopexit:                                 ; preds = %for.body
  %.img_max.0.lcssa = phi i32 [ %.img_max.0, %for.body ]
  %phitmp = uitofp i32 %.img_max.0.lcssa to float
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %img_max.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %phitmp, %for.end.loopexit ]
  %mul8 = fmul float %img_max.0.lcssa, %thr_strong_ratio
  %mul9 = fmul float %mul8, %thr_weak_ratio
  %cmp1210 = icmp eq i32 %img_height, 0
  br i1 %cmp1210, label %for.end166, label %for.cond15.preheader.lr.ph

for.cond15.preheader.lr.ph:                       ; preds = %for.end
  %cmp168 = icmp eq i32 %img_width, 0
  %3 = add i32 %img_height, -1
  %xtraiter36 = and i32 %img_height, 31
  %lcmp.mod37 = icmp eq i32 %xtraiter36, 0
  br i1 %lcmp.mod37, label %for.cond15.preheader.lr.ph.split, label %for.cond15.preheader.prol.preheader

for.cond15.preheader.prol.preheader:              ; preds = %for.cond15.preheader.lr.ph
  br label %for.cond15.preheader.prol

for.cond15.preheader.prol:                        ; preds = %for.cond15.preheader.prol.preheader, %for.inc44.prol
  %indvars.iv28.prol = phi i64 [ %indvars.iv.next29.prol, %for.inc44.prol ], [ 0, %for.cond15.preheader.prol.preheader ]
  %prol.iter38 = phi i32 [ %prol.iter38.sub, %for.inc44.prol ], [ %xtraiter36, %for.cond15.preheader.prol.preheader ]
  br i1 %cmp168, label %for.inc44.prol, label %for.body18.lr.ph.prol

for.body18.lr.ph.prol:                            ; preds = %for.cond15.preheader.prol
  %4 = trunc i64 %indvars.iv28.prol to i32
  %mul19.prol = shl i32 %4, 7
  %5 = sext i32 %mul19.prol to i64
  br label %for.body18.prol

for.body18.prol:                                  ; preds = %for.inc41.prol, %for.body18.lr.ph.prol
  %indvars.iv23.prol = phi i64 [ 0, %for.body18.lr.ph.prol ], [ %indvars.iv.next24.prol, %for.inc41.prol ]
  %6 = add nsw i64 %indvars.iv23.prol, %5
  %arrayidx21.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %6
  %7 = load i32, i32* %arrayidx21.prol, align 4
  %conv22.prol = uitofp i32 %7 to float
  %cmp23.prol = fcmp olt float %conv22.prol, %mul9
  br i1 %cmp23.prol, label %if.then25.prol, label %if.else.prol

if.else.prol:                                     ; preds = %for.body18.prol
  %cmp31.prol = fcmp ult float %conv22.prol, %mul8
  br i1 %cmp31.prol, label %if.else36.prol, label %if.then33.prol

if.then33.prol:                                   ; preds = %if.else.prol
  store i32 255, i32* %arrayidx21.prol, align 4
  br label %for.inc41.prol

if.else36.prol:                                   ; preds = %if.else.prol
  store i32 75, i32* %arrayidx21.prol, align 4
  br label %for.inc41.prol

if.then25.prol:                                   ; preds = %for.body18.prol
  store i32 0, i32* %arrayidx21.prol, align 4
  br label %for.inc41.prol

for.inc41.prol:                                   ; preds = %if.then25.prol, %if.else36.prol, %if.then33.prol
  %indvars.iv.next24.prol = add nuw nsw i64 %indvars.iv23.prol, 1
  %lftr.wideiv26.prol = trunc i64 %indvars.iv.next24.prol to i32
  %exitcond27.prol = icmp eq i32 %lftr.wideiv26.prol, %img_width
  br i1 %exitcond27.prol, label %for.inc44.prol.loopexit, label %for.body18.prol, !llvm.loop !3

for.inc44.prol.loopexit:                          ; preds = %for.inc41.prol
  br label %for.inc44.prol

for.inc44.prol:                                   ; preds = %for.inc44.prol.loopexit, %for.cond15.preheader.prol
  %indvars.iv.next29.prol = add nuw nsw i64 %indvars.iv28.prol, 1
  %prol.iter38.sub = add i32 %prol.iter38, -1
  %prol.iter38.cmp = icmp eq i32 %prol.iter38.sub, 0
  br i1 %prol.iter38.cmp, label %for.cond15.preheader.lr.ph.split.loopexit, label %for.cond15.preheader.prol, !llvm.loop !4

for.cond15.preheader.lr.ph.split.loopexit:        ; preds = %for.inc44.prol
  %indvars.iv.next29.prol.lcssa = phi i64 [ %indvars.iv.next29.prol, %for.inc44.prol ]
  br label %for.cond15.preheader.lr.ph.split

for.cond15.preheader.lr.ph.split:                 ; preds = %for.cond15.preheader.lr.ph.split.loopexit, %for.cond15.preheader.lr.ph
  %indvars.iv28.unr = phi i64 [ 0, %for.cond15.preheader.lr.ph ], [ %indvars.iv.next29.prol.lcssa, %for.cond15.preheader.lr.ph.split.loopexit ]
  %8 = icmp ult i32 %3, 31
  br i1 %8, label %for.cond53.preheader.lr.ph, label %for.cond15.preheader.preheader

for.cond15.preheader.preheader:                   ; preds = %for.cond15.preheader.lr.ph.split
  br label %for.cond15.preheader

for.cond15.preheader:                             ; preds = %for.cond15.preheader.preheader, %for.inc44.31
  %indvars.iv28 = phi i64 [ %indvars.iv.next29.31, %for.inc44.31 ], [ %indvars.iv28.unr, %for.cond15.preheader.preheader ]
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph

for.body18.lr.ph:                                 ; preds = %for.cond15.preheader
  %9 = trunc i64 %indvars.iv28 to i32
  %mul19 = shl i32 %9, 7
  %10 = sext i32 %mul19 to i64
  br label %for.body18

for.cond48.preheader:                             ; preds = %for.inc44.31
  %cmp495 = icmp eq i32 %img_height, 0
  br i1 %cmp495, label %for.end166, label %for.cond53.preheader.lr.ph

for.cond53.preheader.lr.ph:                       ; preds = %for.cond15.preheader.lr.ph.split, %for.cond48.preheader
  %cmp543 = icmp eq i32 %img_width, 0
  %11 = zext i32 %sub1 to i64
  %12 = zext i32 %sub to i64
  %13 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond53.preheader.lr.ph.split, label %for.cond53.preheader.prol.preheader

for.cond53.preheader.prol.preheader:              ; preds = %for.cond53.preheader.lr.ph
  br label %for.cond53.preheader.prol

for.cond53.preheader.prol:                        ; preds = %for.cond53.preheader.prol.preheader, %for.inc164.prol
  %indvars.iv19.prol = phi i64 [ %indvars.iv.next20.prol, %for.inc164.prol ], [ 0, %for.cond53.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc164.prol ], [ %xtraiter, %for.cond53.preheader.prol.preheader ]
  br i1 %cmp543, label %for.inc164.prol, label %for.body56.lr.ph.prol

for.body56.lr.ph.prol:                            ; preds = %for.cond53.preheader.prol
  %14 = trunc i64 %indvars.iv19.prol to i32
  %mul58.prol = shl nsw i32 %14, 7
  %cmp60.prol = icmp eq i64 %indvars.iv19.prol, 0
  %cmp62.prol = icmp eq i64 %indvars.iv19.prol, %12
  %or.cond.prol = or i1 %cmp60.prol, %cmp62.prol
  %15 = trunc i64 %indvars.iv19.prol to i32
  %sub79.prol = shl i32 %15, 7
  %mul89.prol = add i32 %sub79.prol, -128
  %sub106.prol = add i32 %mul58.prol, -1
  %add114.prol = or i32 %mul58.prol, 1
  %mul131.prol = add i32 %sub79.prol, 128
  %16 = sext i32 %mul58.prol to i64
  %17 = sext i32 %mul131.prol to i64
  %18 = sext i32 %mul89.prol to i64
  br label %for.body56.prol

for.body56.prol:                                  ; preds = %for.inc161.prol, %for.body56.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body56.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc161.prol ]
  %19 = add nsw i64 %indvars.iv.prol, %16
  %cmp65.prol = icmp eq i64 %indvars.iv.prol, 0
  %or.cond1.prol = or i1 %or.cond.prol, %cmp65.prol
  %cmp68.prol = icmp eq i64 %indvars.iv.prol, %11
  %or.cond2.prol = or i1 %cmp68.prol, %or.cond1.prol
  br i1 %or.cond2.prol, label %if.then70.prol, label %if.else73.prol

if.else73.prol:                                   ; preds = %for.body56.prol
  %arrayidx75.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %19
  %20 = load i32, i32* %arrayidx75.prol, align 4
  %cmp76.prol = icmp eq i32 %20, 75
  br i1 %cmp76.prol, label %if.then78.prol, label %if.else153.prol

if.else153.prol:                                  ; preds = %if.else73.prol
  %conv156.prol = trunc i32 %20 to i8
  %arrayidx158.prol = getelementptr inbounds i8, i8* %0, i64 %19
  store i8 %conv156.prol, i8* %arrayidx158.prol, align 1
  br label %for.inc161.prol

if.then78.prol:                                   ; preds = %if.else73.prol
  %21 = trunc i64 %indvars.iv.prol to i32
  %sub81.prol = add i32 %21, %sub79.prol
  %add82.prol = add i32 %sub81.prol, -129
  %idxprom83.prol = sext i32 %add82.prol to i64
  %arrayidx84.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.prol
  %22 = load i32, i32* %arrayidx84.prol, align 4
  %cmp85.prol = icmp eq i32 %22, 255
  br i1 %cmp85.prol, label %if.then146.prol, label %lor.lhs.false87.prol

lor.lhs.false87.prol:                             ; preds = %if.then78.prol
  %23 = add nsw i64 %18, %indvars.iv.prol
  %arrayidx92.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %23
  %24 = load i32, i32* %arrayidx92.prol, align 4
  %cmp93.prol = icmp eq i32 %24, 255
  br i1 %cmp93.prol, label %if.then146.prol, label %lor.lhs.false95.prol

lor.lhs.false95.prol:                             ; preds = %lor.lhs.false87.prol
  %add99.prol = add i32 %sub81.prol, -127
  %idxprom100.prol = sext i32 %add99.prol to i64
  %arrayidx101.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.prol
  %25 = load i32, i32* %arrayidx101.prol, align 4
  %cmp102.prol = icmp eq i32 %25, 255
  br i1 %cmp102.prol, label %if.then146.prol, label %lor.lhs.false104.prol

lor.lhs.false104.prol:                            ; preds = %lor.lhs.false95.prol
  %26 = trunc i64 %indvars.iv.prol to i32
  %add107.prol = add i32 %sub106.prol, %26
  %idxprom108.prol = sext i32 %add107.prol to i64
  %arrayidx109.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.prol
  %27 = load i32, i32* %arrayidx109.prol, align 4
  %cmp110.prol = icmp eq i32 %27, 255
  br i1 %cmp110.prol, label %if.then146.prol, label %lor.lhs.false112.prol

lor.lhs.false112.prol:                            ; preds = %lor.lhs.false104.prol
  %28 = trunc i64 %indvars.iv.prol to i32
  %add115.prol = add i32 %add114.prol, %28
  %idxprom116.prol = sext i32 %add115.prol to i64
  %arrayidx117.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.prol
  %29 = load i32, i32* %arrayidx117.prol, align 4
  %cmp118.prol = icmp eq i32 %29, 255
  br i1 %cmp118.prol, label %if.then146.prol, label %lor.lhs.false120.prol

lor.lhs.false120.prol:                            ; preds = %lor.lhs.false112.prol
  %add124.prol = add i32 %sub81.prol, 127
  %idxprom125.prol = sext i32 %add124.prol to i64
  %arrayidx126.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.prol
  %30 = load i32, i32* %arrayidx126.prol, align 4
  %cmp127.prol = icmp eq i32 %30, 255
  br i1 %cmp127.prol, label %if.then146.prol, label %lor.lhs.false129.prol

lor.lhs.false129.prol:                            ; preds = %lor.lhs.false120.prol
  %31 = add nsw i64 %17, %indvars.iv.prol
  %arrayidx134.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %31
  %32 = load i32, i32* %arrayidx134.prol, align 4
  %cmp135.prol = icmp eq i32 %32, 255
  br i1 %cmp135.prol, label %if.then146.prol, label %lor.lhs.false137.prol

lor.lhs.false137.prol:                            ; preds = %lor.lhs.false129.prol
  %add141.prol = add i32 %sub81.prol, 129
  %idxprom142.prol = sext i32 %add141.prol to i64
  %arrayidx143.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.prol
  %33 = load i32, i32* %arrayidx143.prol, align 4
  %cmp144.prol = icmp eq i32 %33, 255
  br i1 %cmp144.prol, label %if.then146.prol, label %if.else149.prol

if.else149.prol:                                  ; preds = %lor.lhs.false137.prol
  %arrayidx151.prol = getelementptr inbounds i8, i8* %0, i64 %19
  store i8 0, i8* %arrayidx151.prol, align 1
  br label %for.inc161.prol

if.then146.prol:                                  ; preds = %lor.lhs.false137.prol, %lor.lhs.false129.prol, %lor.lhs.false120.prol, %lor.lhs.false112.prol, %lor.lhs.false104.prol, %lor.lhs.false95.prol, %lor.lhs.false87.prol, %if.then78.prol
  %arrayidx148.prol = getelementptr inbounds i8, i8* %0, i64 %19
  store i8 -1, i8* %arrayidx148.prol, align 1
  br label %for.inc161.prol

if.then70.prol:                                   ; preds = %for.body56.prol
  %arrayidx72.prol = getelementptr inbounds i8, i8* %0, i64 %19
  store i8 0, i8* %arrayidx72.prol, align 1
  br label %for.inc161.prol

for.inc161.prol:                                  ; preds = %if.then70.prol, %if.then146.prol, %if.else149.prol, %if.else153.prol
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %img_width
  br i1 %exitcond.prol, label %for.inc164.prol.loopexit, label %for.body56.prol, !llvm.loop !5

for.inc164.prol.loopexit:                         ; preds = %for.inc161.prol
  br label %for.inc164.prol

for.inc164.prol:                                  ; preds = %for.inc164.prol.loopexit, %for.cond53.preheader.prol
  %indvars.iv.next20.prol = add nuw nsw i64 %indvars.iv19.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond53.preheader.lr.ph.split.loopexit, label %for.cond53.preheader.prol, !llvm.loop !6

for.cond53.preheader.lr.ph.split.loopexit:        ; preds = %for.inc164.prol
  %indvars.iv.next20.prol.lcssa = phi i64 [ %indvars.iv.next20.prol, %for.inc164.prol ]
  br label %for.cond53.preheader.lr.ph.split

for.cond53.preheader.lr.ph.split:                 ; preds = %for.cond53.preheader.lr.ph.split.loopexit, %for.cond53.preheader.lr.ph
  %indvars.iv19.unr = phi i64 [ 0, %for.cond53.preheader.lr.ph ], [ %indvars.iv.next20.prol.lcssa, %for.cond53.preheader.lr.ph.split.loopexit ]
  %34 = icmp ult i32 %13, 31
  br i1 %34, label %for.end166, label %for.cond53.preheader.preheader

for.cond53.preheader.preheader:                   ; preds = %for.cond53.preheader.lr.ph.split
  br label %for.cond53.preheader

for.body18:                                       ; preds = %for.inc41, %for.body18.lr.ph
  %indvars.iv23 = phi i64 [ 0, %for.body18.lr.ph ], [ %indvars.iv.next24, %for.inc41 ]
  %35 = add nsw i64 %indvars.iv23, %10
  %arrayidx21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %35
  %36 = load i32, i32* %arrayidx21, align 4
  %conv22 = uitofp i32 %36 to float
  %cmp23 = fcmp olt float %conv22, %mul9
  br i1 %cmp23, label %if.then25, label %if.else

if.then25:                                        ; preds = %for.body18
  store i32 0, i32* %arrayidx21, align 4
  br label %for.inc41

if.else:                                          ; preds = %for.body18
  %cmp31 = fcmp ult float %conv22, %mul8
  br i1 %cmp31, label %if.else36, label %if.then33

if.then33:                                        ; preds = %if.else
  store i32 255, i32* %arrayidx21, align 4
  br label %for.inc41

if.else36:                                        ; preds = %if.else
  store i32 75, i32* %arrayidx21, align 4
  br label %for.inc41

for.inc41:                                        ; preds = %if.then25, %if.else36, %if.then33
  %indvars.iv.next24 = add nuw nsw i64 %indvars.iv23, 1
  %lftr.wideiv26 = trunc i64 %indvars.iv.next24 to i32
  %exitcond27 = icmp eq i32 %lftr.wideiv26, %img_width
  br i1 %exitcond27, label %for.inc44, label %for.body18, !llvm.loop !3

for.inc44:                                        ; preds = %for.inc41
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.1

for.cond53.preheader:                             ; preds = %for.cond53.preheader.preheader, %for.inc164.31
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.31, %for.inc164.31 ], [ %indvars.iv19.unr, %for.cond53.preheader.preheader ]
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph

for.body56.lr.ph:                                 ; preds = %for.cond53.preheader
  %37 = trunc i64 %indvars.iv19 to i32
  %mul58 = shl nsw i32 %37, 7
  %cmp60 = icmp eq i64 %indvars.iv19, 0
  %cmp62 = icmp eq i64 %indvars.iv19, %12
  %or.cond = or i1 %cmp60, %cmp62
  %38 = trunc i64 %indvars.iv19 to i32
  %sub79 = shl i32 %38, 7
  %mul89 = add i32 %sub79, -128
  %sub106 = add i32 %mul58, -1
  %add114 = or i32 %mul58, 1
  %mul131 = add i32 %sub79, 128
  %39 = sext i32 %mul58 to i64
  %40 = sext i32 %mul131 to i64
  %41 = sext i32 %mul89 to i64
  br label %for.body56

for.body56:                                       ; preds = %for.inc161, %for.body56.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body56.lr.ph ], [ %indvars.iv.next, %for.inc161 ]
  %42 = add nsw i64 %indvars.iv, %39
  %cmp65 = icmp eq i64 %indvars.iv, 0
  %or.cond1 = or i1 %or.cond, %cmp65
  %cmp68 = icmp eq i64 %indvars.iv, %11
  %or.cond2 = or i1 %cmp68, %or.cond1
  br i1 %or.cond2, label %if.then70, label %if.else73

if.then70:                                        ; preds = %for.body56
  %arrayidx72 = getelementptr inbounds i8, i8* %0, i64 %42
  store i8 0, i8* %arrayidx72, align 1
  br label %for.inc161

if.else73:                                        ; preds = %for.body56
  %arrayidx75 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %42
  %43 = load i32, i32* %arrayidx75, align 4
  %cmp76 = icmp eq i32 %43, 75
  br i1 %cmp76, label %if.then78, label %if.else153

if.then78:                                        ; preds = %if.else73
  %44 = trunc i64 %indvars.iv to i32
  %sub81 = add i32 %44, %sub79
  %add82 = add i32 %sub81, -129
  %idxprom83 = sext i32 %add82 to i64
  %arrayidx84 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83
  %45 = load i32, i32* %arrayidx84, align 4
  %cmp85 = icmp eq i32 %45, 255
  br i1 %cmp85, label %if.then146, label %lor.lhs.false87

lor.lhs.false87:                                  ; preds = %if.then78
  %46 = add nsw i64 %41, %indvars.iv
  %arrayidx92 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %46
  %47 = load i32, i32* %arrayidx92, align 4
  %cmp93 = icmp eq i32 %47, 255
  br i1 %cmp93, label %if.then146, label %lor.lhs.false95

lor.lhs.false95:                                  ; preds = %lor.lhs.false87
  %add99 = add i32 %sub81, -127
  %idxprom100 = sext i32 %add99 to i64
  %arrayidx101 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100
  %48 = load i32, i32* %arrayidx101, align 4
  %cmp102 = icmp eq i32 %48, 255
  br i1 %cmp102, label %if.then146, label %lor.lhs.false104

lor.lhs.false104:                                 ; preds = %lor.lhs.false95
  %49 = trunc i64 %indvars.iv to i32
  %add107 = add i32 %sub106, %49
  %idxprom108 = sext i32 %add107 to i64
  %arrayidx109 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108
  %50 = load i32, i32* %arrayidx109, align 4
  %cmp110 = icmp eq i32 %50, 255
  br i1 %cmp110, label %if.then146, label %lor.lhs.false112

lor.lhs.false112:                                 ; preds = %lor.lhs.false104
  %51 = trunc i64 %indvars.iv to i32
  %add115 = add i32 %add114, %51
  %idxprom116 = sext i32 %add115 to i64
  %arrayidx117 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116
  %52 = load i32, i32* %arrayidx117, align 4
  %cmp118 = icmp eq i32 %52, 255
  br i1 %cmp118, label %if.then146, label %lor.lhs.false120

lor.lhs.false120:                                 ; preds = %lor.lhs.false112
  %add124 = add i32 %sub81, 127
  %idxprom125 = sext i32 %add124 to i64
  %arrayidx126 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125
  %53 = load i32, i32* %arrayidx126, align 4
  %cmp127 = icmp eq i32 %53, 255
  br i1 %cmp127, label %if.then146, label %lor.lhs.false129

lor.lhs.false129:                                 ; preds = %lor.lhs.false120
  %54 = add nsw i64 %40, %indvars.iv
  %arrayidx134 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %54
  %55 = load i32, i32* %arrayidx134, align 4
  %cmp135 = icmp eq i32 %55, 255
  br i1 %cmp135, label %if.then146, label %lor.lhs.false137

lor.lhs.false137:                                 ; preds = %lor.lhs.false129
  %add141 = add i32 %sub81, 129
  %idxprom142 = sext i32 %add141 to i64
  %arrayidx143 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142
  %56 = load i32, i32* %arrayidx143, align 4
  %cmp144 = icmp eq i32 %56, 255
  br i1 %cmp144, label %if.then146, label %if.else149

if.then146:                                       ; preds = %lor.lhs.false137, %lor.lhs.false129, %lor.lhs.false120, %lor.lhs.false112, %lor.lhs.false104, %lor.lhs.false95, %lor.lhs.false87, %if.then78
  %arrayidx148 = getelementptr inbounds i8, i8* %0, i64 %42
  store i8 -1, i8* %arrayidx148, align 1
  br label %for.inc161

if.else149:                                       ; preds = %lor.lhs.false137
  %arrayidx151 = getelementptr inbounds i8, i8* %0, i64 %42
  store i8 0, i8* %arrayidx151, align 1
  br label %for.inc161

if.else153:                                       ; preds = %if.else73
  %conv156 = trunc i32 %43 to i8
  %arrayidx158 = getelementptr inbounds i8, i8* %0, i64 %42
  store i8 %conv156, i8* %arrayidx158, align 1
  br label %for.inc161

for.inc161:                                       ; preds = %if.then70, %if.then146, %if.else149, %if.else153
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %img_width
  br i1 %exitcond, label %for.inc164, label %for.body56, !llvm.loop !5

for.inc164:                                       ; preds = %for.inc161
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.1

for.end166.loopexit:                              ; preds = %for.inc164.31
  br label %for.end166

for.end166:                                       ; preds = %for.end166.loopexit, %for.end, %for.cond53.preheader.lr.ph.split, %for.cond48.preheader
  ret void

for.body56.lr.ph.1:                               ; preds = %for.inc164
  %57 = trunc i64 %indvars.iv.next20 to i32
  %mul58.1 = shl nsw i32 %57, 7
  %cmp62.1 = icmp eq i64 %indvars.iv.next20, %12
  %58 = trunc i64 %indvars.iv.next20 to i32
  %sub79.1 = shl i32 %58, 7
  %mul89.1 = add i32 %sub79.1, -128
  %sub106.1 = add i32 %mul58.1, -1
  %add114.1 = or i32 %mul58.1, 1
  %mul131.1 = add i32 %sub79.1, 128
  %59 = sext i32 %mul58.1 to i64
  %60 = sext i32 %mul131.1 to i64
  %61 = sext i32 %mul89.1 to i64
  br label %for.body56.1

for.body56.1:                                     ; preds = %for.inc161.1, %for.body56.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body56.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc161.1 ]
  %62 = add nsw i64 %indvars.iv.1, %59
  %cmp65.1 = icmp eq i64 %indvars.iv.1, 0
  %or.cond1.1 = or i1 %cmp62.1, %cmp65.1
  %cmp68.1 = icmp eq i64 %indvars.iv.1, %11
  %or.cond2.1 = or i1 %cmp68.1, %or.cond1.1
  br i1 %or.cond2.1, label %if.then70.1, label %if.else73.1

if.else73.1:                                      ; preds = %for.body56.1
  %arrayidx75.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %62
  %63 = load i32, i32* %arrayidx75.1, align 4
  %cmp76.1 = icmp eq i32 %63, 75
  br i1 %cmp76.1, label %if.then78.1, label %if.else153.1

if.else153.1:                                     ; preds = %if.else73.1
  %conv156.1 = trunc i32 %63 to i8
  %arrayidx158.1 = getelementptr inbounds i8, i8* %0, i64 %62
  store i8 %conv156.1, i8* %arrayidx158.1, align 1
  br label %for.inc161.1

if.then78.1:                                      ; preds = %if.else73.1
  %64 = trunc i64 %indvars.iv.1 to i32
  %sub81.1 = add i32 %64, %sub79.1
  %add82.1 = add i32 %sub81.1, -129
  %idxprom83.1 = sext i32 %add82.1 to i64
  %arrayidx84.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.1
  %65 = load i32, i32* %arrayidx84.1, align 4
  %cmp85.1 = icmp eq i32 %65, 255
  br i1 %cmp85.1, label %if.then146.1, label %lor.lhs.false87.1

lor.lhs.false87.1:                                ; preds = %if.then78.1
  %66 = add nsw i64 %61, %indvars.iv.1
  %arrayidx92.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %66
  %67 = load i32, i32* %arrayidx92.1, align 4
  %cmp93.1 = icmp eq i32 %67, 255
  br i1 %cmp93.1, label %if.then146.1, label %lor.lhs.false95.1

lor.lhs.false95.1:                                ; preds = %lor.lhs.false87.1
  %add99.1 = add i32 %sub81.1, -127
  %idxprom100.1 = sext i32 %add99.1 to i64
  %arrayidx101.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.1
  %68 = load i32, i32* %arrayidx101.1, align 4
  %cmp102.1 = icmp eq i32 %68, 255
  br i1 %cmp102.1, label %if.then146.1, label %lor.lhs.false104.1

lor.lhs.false104.1:                               ; preds = %lor.lhs.false95.1
  %69 = trunc i64 %indvars.iv.1 to i32
  %add107.1 = add i32 %sub106.1, %69
  %idxprom108.1 = sext i32 %add107.1 to i64
  %arrayidx109.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.1
  %70 = load i32, i32* %arrayidx109.1, align 4
  %cmp110.1 = icmp eq i32 %70, 255
  br i1 %cmp110.1, label %if.then146.1, label %lor.lhs.false112.1

lor.lhs.false112.1:                               ; preds = %lor.lhs.false104.1
  %71 = trunc i64 %indvars.iv.1 to i32
  %add115.1 = add i32 %add114.1, %71
  %idxprom116.1 = sext i32 %add115.1 to i64
  %arrayidx117.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.1
  %72 = load i32, i32* %arrayidx117.1, align 4
  %cmp118.1 = icmp eq i32 %72, 255
  br i1 %cmp118.1, label %if.then146.1, label %lor.lhs.false120.1

lor.lhs.false120.1:                               ; preds = %lor.lhs.false112.1
  %add124.1 = add i32 %sub81.1, 127
  %idxprom125.1 = sext i32 %add124.1 to i64
  %arrayidx126.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.1
  %73 = load i32, i32* %arrayidx126.1, align 4
  %cmp127.1 = icmp eq i32 %73, 255
  br i1 %cmp127.1, label %if.then146.1, label %lor.lhs.false129.1

lor.lhs.false129.1:                               ; preds = %lor.lhs.false120.1
  %74 = add nsw i64 %60, %indvars.iv.1
  %arrayidx134.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %74
  %75 = load i32, i32* %arrayidx134.1, align 4
  %cmp135.1 = icmp eq i32 %75, 255
  br i1 %cmp135.1, label %if.then146.1, label %lor.lhs.false137.1

lor.lhs.false137.1:                               ; preds = %lor.lhs.false129.1
  %add141.1 = add i32 %sub81.1, 129
  %idxprom142.1 = sext i32 %add141.1 to i64
  %arrayidx143.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.1
  %76 = load i32, i32* %arrayidx143.1, align 4
  %cmp144.1 = icmp eq i32 %76, 255
  br i1 %cmp144.1, label %if.then146.1, label %if.else149.1

if.else149.1:                                     ; preds = %lor.lhs.false137.1
  %arrayidx151.1 = getelementptr inbounds i8, i8* %0, i64 %62
  store i8 0, i8* %arrayidx151.1, align 1
  br label %for.inc161.1

if.then146.1:                                     ; preds = %lor.lhs.false137.1, %lor.lhs.false129.1, %lor.lhs.false120.1, %lor.lhs.false112.1, %lor.lhs.false104.1, %lor.lhs.false95.1, %lor.lhs.false87.1, %if.then78.1
  %arrayidx148.1 = getelementptr inbounds i8, i8* %0, i64 %62
  store i8 -1, i8* %arrayidx148.1, align 1
  br label %for.inc161.1

if.then70.1:                                      ; preds = %for.body56.1
  %arrayidx72.1 = getelementptr inbounds i8, i8* %0, i64 %62
  store i8 0, i8* %arrayidx72.1, align 1
  br label %for.inc161.1

for.inc161.1:                                     ; preds = %if.then70.1, %if.then146.1, %if.else149.1, %if.else153.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %img_width
  br i1 %exitcond.1, label %for.inc164.1, label %for.body56.1, !llvm.loop !5

for.inc164.1:                                     ; preds = %for.inc161.1
  %indvars.iv.next20.1 = add nsw i64 %indvars.iv19, 2
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.2

for.body56.lr.ph.2:                               ; preds = %for.inc164.1
  %77 = trunc i64 %indvars.iv.next20.1 to i32
  %mul58.2 = shl nsw i32 %77, 7
  %cmp62.2 = icmp eq i64 %indvars.iv.next20.1, %12
  %78 = trunc i64 %indvars.iv.next20.1 to i32
  %sub79.2 = shl i32 %78, 7
  %mul89.2 = add i32 %sub79.2, -128
  %sub106.2 = add i32 %mul58.2, -1
  %add114.2 = or i32 %mul58.2, 1
  %mul131.2 = add i32 %sub79.2, 128
  %79 = sext i32 %mul58.2 to i64
  %80 = sext i32 %mul131.2 to i64
  %81 = sext i32 %mul89.2 to i64
  br label %for.body56.2

for.body56.2:                                     ; preds = %for.inc161.2, %for.body56.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body56.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc161.2 ]
  %82 = add nsw i64 %indvars.iv.2, %79
  %cmp65.2 = icmp eq i64 %indvars.iv.2, 0
  %or.cond1.2 = or i1 %cmp62.2, %cmp65.2
  %cmp68.2 = icmp eq i64 %indvars.iv.2, %11
  %or.cond2.2 = or i1 %cmp68.2, %or.cond1.2
  br i1 %or.cond2.2, label %if.then70.2, label %if.else73.2

if.else73.2:                                      ; preds = %for.body56.2
  %arrayidx75.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %82
  %83 = load i32, i32* %arrayidx75.2, align 4
  %cmp76.2 = icmp eq i32 %83, 75
  br i1 %cmp76.2, label %if.then78.2, label %if.else153.2

if.else153.2:                                     ; preds = %if.else73.2
  %conv156.2 = trunc i32 %83 to i8
  %arrayidx158.2 = getelementptr inbounds i8, i8* %0, i64 %82
  store i8 %conv156.2, i8* %arrayidx158.2, align 1
  br label %for.inc161.2

if.then78.2:                                      ; preds = %if.else73.2
  %84 = trunc i64 %indvars.iv.2 to i32
  %sub81.2 = add i32 %84, %sub79.2
  %add82.2 = add i32 %sub81.2, -129
  %idxprom83.2 = sext i32 %add82.2 to i64
  %arrayidx84.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.2
  %85 = load i32, i32* %arrayidx84.2, align 4
  %cmp85.2 = icmp eq i32 %85, 255
  br i1 %cmp85.2, label %if.then146.2, label %lor.lhs.false87.2

lor.lhs.false87.2:                                ; preds = %if.then78.2
  %86 = add nsw i64 %81, %indvars.iv.2
  %arrayidx92.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %86
  %87 = load i32, i32* %arrayidx92.2, align 4
  %cmp93.2 = icmp eq i32 %87, 255
  br i1 %cmp93.2, label %if.then146.2, label %lor.lhs.false95.2

lor.lhs.false95.2:                                ; preds = %lor.lhs.false87.2
  %add99.2 = add i32 %sub81.2, -127
  %idxprom100.2 = sext i32 %add99.2 to i64
  %arrayidx101.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.2
  %88 = load i32, i32* %arrayidx101.2, align 4
  %cmp102.2 = icmp eq i32 %88, 255
  br i1 %cmp102.2, label %if.then146.2, label %lor.lhs.false104.2

lor.lhs.false104.2:                               ; preds = %lor.lhs.false95.2
  %89 = trunc i64 %indvars.iv.2 to i32
  %add107.2 = add i32 %sub106.2, %89
  %idxprom108.2 = sext i32 %add107.2 to i64
  %arrayidx109.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.2
  %90 = load i32, i32* %arrayidx109.2, align 4
  %cmp110.2 = icmp eq i32 %90, 255
  br i1 %cmp110.2, label %if.then146.2, label %lor.lhs.false112.2

lor.lhs.false112.2:                               ; preds = %lor.lhs.false104.2
  %91 = trunc i64 %indvars.iv.2 to i32
  %add115.2 = add i32 %add114.2, %91
  %idxprom116.2 = sext i32 %add115.2 to i64
  %arrayidx117.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.2
  %92 = load i32, i32* %arrayidx117.2, align 4
  %cmp118.2 = icmp eq i32 %92, 255
  br i1 %cmp118.2, label %if.then146.2, label %lor.lhs.false120.2

lor.lhs.false120.2:                               ; preds = %lor.lhs.false112.2
  %add124.2 = add i32 %sub81.2, 127
  %idxprom125.2 = sext i32 %add124.2 to i64
  %arrayidx126.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.2
  %93 = load i32, i32* %arrayidx126.2, align 4
  %cmp127.2 = icmp eq i32 %93, 255
  br i1 %cmp127.2, label %if.then146.2, label %lor.lhs.false129.2

lor.lhs.false129.2:                               ; preds = %lor.lhs.false120.2
  %94 = add nsw i64 %80, %indvars.iv.2
  %arrayidx134.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %94
  %95 = load i32, i32* %arrayidx134.2, align 4
  %cmp135.2 = icmp eq i32 %95, 255
  br i1 %cmp135.2, label %if.then146.2, label %lor.lhs.false137.2

lor.lhs.false137.2:                               ; preds = %lor.lhs.false129.2
  %add141.2 = add i32 %sub81.2, 129
  %idxprom142.2 = sext i32 %add141.2 to i64
  %arrayidx143.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.2
  %96 = load i32, i32* %arrayidx143.2, align 4
  %cmp144.2 = icmp eq i32 %96, 255
  br i1 %cmp144.2, label %if.then146.2, label %if.else149.2

if.else149.2:                                     ; preds = %lor.lhs.false137.2
  %arrayidx151.2 = getelementptr inbounds i8, i8* %0, i64 %82
  store i8 0, i8* %arrayidx151.2, align 1
  br label %for.inc161.2

if.then146.2:                                     ; preds = %lor.lhs.false137.2, %lor.lhs.false129.2, %lor.lhs.false120.2, %lor.lhs.false112.2, %lor.lhs.false104.2, %lor.lhs.false95.2, %lor.lhs.false87.2, %if.then78.2
  %arrayidx148.2 = getelementptr inbounds i8, i8* %0, i64 %82
  store i8 -1, i8* %arrayidx148.2, align 1
  br label %for.inc161.2

if.then70.2:                                      ; preds = %for.body56.2
  %arrayidx72.2 = getelementptr inbounds i8, i8* %0, i64 %82
  store i8 0, i8* %arrayidx72.2, align 1
  br label %for.inc161.2

for.inc161.2:                                     ; preds = %if.then70.2, %if.then146.2, %if.else149.2, %if.else153.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %img_width
  br i1 %exitcond.2, label %for.inc164.2, label %for.body56.2, !llvm.loop !5

for.inc164.2:                                     ; preds = %for.inc161.2
  %indvars.iv.next20.2 = add nsw i64 %indvars.iv19, 3
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.3

for.body56.lr.ph.3:                               ; preds = %for.inc164.2
  %97 = trunc i64 %indvars.iv.next20.2 to i32
  %mul58.3 = shl nsw i32 %97, 7
  %cmp62.3 = icmp eq i64 %indvars.iv.next20.2, %12
  %98 = trunc i64 %indvars.iv.next20.2 to i32
  %sub79.3 = shl i32 %98, 7
  %mul89.3 = add i32 %sub79.3, -128
  %sub106.3 = add i32 %mul58.3, -1
  %add114.3 = or i32 %mul58.3, 1
  %mul131.3 = add i32 %sub79.3, 128
  %99 = sext i32 %mul58.3 to i64
  %100 = sext i32 %mul131.3 to i64
  %101 = sext i32 %mul89.3 to i64
  br label %for.body56.3

for.body56.3:                                     ; preds = %for.inc161.3, %for.body56.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body56.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc161.3 ]
  %102 = add nsw i64 %indvars.iv.3, %99
  %cmp65.3 = icmp eq i64 %indvars.iv.3, 0
  %or.cond1.3 = or i1 %cmp62.3, %cmp65.3
  %cmp68.3 = icmp eq i64 %indvars.iv.3, %11
  %or.cond2.3 = or i1 %cmp68.3, %or.cond1.3
  br i1 %or.cond2.3, label %if.then70.3, label %if.else73.3

if.else73.3:                                      ; preds = %for.body56.3
  %arrayidx75.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %102
  %103 = load i32, i32* %arrayidx75.3, align 4
  %cmp76.3 = icmp eq i32 %103, 75
  br i1 %cmp76.3, label %if.then78.3, label %if.else153.3

if.else153.3:                                     ; preds = %if.else73.3
  %conv156.3 = trunc i32 %103 to i8
  %arrayidx158.3 = getelementptr inbounds i8, i8* %0, i64 %102
  store i8 %conv156.3, i8* %arrayidx158.3, align 1
  br label %for.inc161.3

if.then78.3:                                      ; preds = %if.else73.3
  %104 = trunc i64 %indvars.iv.3 to i32
  %sub81.3 = add i32 %104, %sub79.3
  %add82.3 = add i32 %sub81.3, -129
  %idxprom83.3 = sext i32 %add82.3 to i64
  %arrayidx84.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.3
  %105 = load i32, i32* %arrayidx84.3, align 4
  %cmp85.3 = icmp eq i32 %105, 255
  br i1 %cmp85.3, label %if.then146.3, label %lor.lhs.false87.3

lor.lhs.false87.3:                                ; preds = %if.then78.3
  %106 = add nsw i64 %101, %indvars.iv.3
  %arrayidx92.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %106
  %107 = load i32, i32* %arrayidx92.3, align 4
  %cmp93.3 = icmp eq i32 %107, 255
  br i1 %cmp93.3, label %if.then146.3, label %lor.lhs.false95.3

lor.lhs.false95.3:                                ; preds = %lor.lhs.false87.3
  %add99.3 = add i32 %sub81.3, -127
  %idxprom100.3 = sext i32 %add99.3 to i64
  %arrayidx101.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.3
  %108 = load i32, i32* %arrayidx101.3, align 4
  %cmp102.3 = icmp eq i32 %108, 255
  br i1 %cmp102.3, label %if.then146.3, label %lor.lhs.false104.3

lor.lhs.false104.3:                               ; preds = %lor.lhs.false95.3
  %109 = trunc i64 %indvars.iv.3 to i32
  %add107.3 = add i32 %sub106.3, %109
  %idxprom108.3 = sext i32 %add107.3 to i64
  %arrayidx109.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.3
  %110 = load i32, i32* %arrayidx109.3, align 4
  %cmp110.3 = icmp eq i32 %110, 255
  br i1 %cmp110.3, label %if.then146.3, label %lor.lhs.false112.3

lor.lhs.false112.3:                               ; preds = %lor.lhs.false104.3
  %111 = trunc i64 %indvars.iv.3 to i32
  %add115.3 = add i32 %add114.3, %111
  %idxprom116.3 = sext i32 %add115.3 to i64
  %arrayidx117.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.3
  %112 = load i32, i32* %arrayidx117.3, align 4
  %cmp118.3 = icmp eq i32 %112, 255
  br i1 %cmp118.3, label %if.then146.3, label %lor.lhs.false120.3

lor.lhs.false120.3:                               ; preds = %lor.lhs.false112.3
  %add124.3 = add i32 %sub81.3, 127
  %idxprom125.3 = sext i32 %add124.3 to i64
  %arrayidx126.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.3
  %113 = load i32, i32* %arrayidx126.3, align 4
  %cmp127.3 = icmp eq i32 %113, 255
  br i1 %cmp127.3, label %if.then146.3, label %lor.lhs.false129.3

lor.lhs.false129.3:                               ; preds = %lor.lhs.false120.3
  %114 = add nsw i64 %100, %indvars.iv.3
  %arrayidx134.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %114
  %115 = load i32, i32* %arrayidx134.3, align 4
  %cmp135.3 = icmp eq i32 %115, 255
  br i1 %cmp135.3, label %if.then146.3, label %lor.lhs.false137.3

lor.lhs.false137.3:                               ; preds = %lor.lhs.false129.3
  %add141.3 = add i32 %sub81.3, 129
  %idxprom142.3 = sext i32 %add141.3 to i64
  %arrayidx143.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.3
  %116 = load i32, i32* %arrayidx143.3, align 4
  %cmp144.3 = icmp eq i32 %116, 255
  br i1 %cmp144.3, label %if.then146.3, label %if.else149.3

if.else149.3:                                     ; preds = %lor.lhs.false137.3
  %arrayidx151.3 = getelementptr inbounds i8, i8* %0, i64 %102
  store i8 0, i8* %arrayidx151.3, align 1
  br label %for.inc161.3

if.then146.3:                                     ; preds = %lor.lhs.false137.3, %lor.lhs.false129.3, %lor.lhs.false120.3, %lor.lhs.false112.3, %lor.lhs.false104.3, %lor.lhs.false95.3, %lor.lhs.false87.3, %if.then78.3
  %arrayidx148.3 = getelementptr inbounds i8, i8* %0, i64 %102
  store i8 -1, i8* %arrayidx148.3, align 1
  br label %for.inc161.3

if.then70.3:                                      ; preds = %for.body56.3
  %arrayidx72.3 = getelementptr inbounds i8, i8* %0, i64 %102
  store i8 0, i8* %arrayidx72.3, align 1
  br label %for.inc161.3

for.inc161.3:                                     ; preds = %if.then70.3, %if.then146.3, %if.else149.3, %if.else153.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %img_width
  br i1 %exitcond.3, label %for.inc164.3, label %for.body56.3, !llvm.loop !5

for.inc164.3:                                     ; preds = %for.inc161.3
  %indvars.iv.next20.3 = add nsw i64 %indvars.iv19, 4
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.4

for.body56.lr.ph.4:                               ; preds = %for.inc164.3
  %117 = trunc i64 %indvars.iv.next20.3 to i32
  %mul58.4 = shl nsw i32 %117, 7
  %cmp62.4 = icmp eq i64 %indvars.iv.next20.3, %12
  %118 = trunc i64 %indvars.iv.next20.3 to i32
  %sub79.4 = shl i32 %118, 7
  %mul89.4 = add i32 %sub79.4, -128
  %sub106.4 = add i32 %mul58.4, -1
  %add114.4 = or i32 %mul58.4, 1
  %mul131.4 = add i32 %sub79.4, 128
  %119 = sext i32 %mul58.4 to i64
  %120 = sext i32 %mul131.4 to i64
  %121 = sext i32 %mul89.4 to i64
  br label %for.body56.4

for.body56.4:                                     ; preds = %for.inc161.4, %for.body56.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body56.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc161.4 ]
  %122 = add nsw i64 %indvars.iv.4, %119
  %cmp65.4 = icmp eq i64 %indvars.iv.4, 0
  %or.cond1.4 = or i1 %cmp62.4, %cmp65.4
  %cmp68.4 = icmp eq i64 %indvars.iv.4, %11
  %or.cond2.4 = or i1 %cmp68.4, %or.cond1.4
  br i1 %or.cond2.4, label %if.then70.4, label %if.else73.4

if.else73.4:                                      ; preds = %for.body56.4
  %arrayidx75.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %122
  %123 = load i32, i32* %arrayidx75.4, align 4
  %cmp76.4 = icmp eq i32 %123, 75
  br i1 %cmp76.4, label %if.then78.4, label %if.else153.4

if.else153.4:                                     ; preds = %if.else73.4
  %conv156.4 = trunc i32 %123 to i8
  %arrayidx158.4 = getelementptr inbounds i8, i8* %0, i64 %122
  store i8 %conv156.4, i8* %arrayidx158.4, align 1
  br label %for.inc161.4

if.then78.4:                                      ; preds = %if.else73.4
  %124 = trunc i64 %indvars.iv.4 to i32
  %sub81.4 = add i32 %124, %sub79.4
  %add82.4 = add i32 %sub81.4, -129
  %idxprom83.4 = sext i32 %add82.4 to i64
  %arrayidx84.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.4
  %125 = load i32, i32* %arrayidx84.4, align 4
  %cmp85.4 = icmp eq i32 %125, 255
  br i1 %cmp85.4, label %if.then146.4, label %lor.lhs.false87.4

lor.lhs.false87.4:                                ; preds = %if.then78.4
  %126 = add nsw i64 %121, %indvars.iv.4
  %arrayidx92.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %126
  %127 = load i32, i32* %arrayidx92.4, align 4
  %cmp93.4 = icmp eq i32 %127, 255
  br i1 %cmp93.4, label %if.then146.4, label %lor.lhs.false95.4

lor.lhs.false95.4:                                ; preds = %lor.lhs.false87.4
  %add99.4 = add i32 %sub81.4, -127
  %idxprom100.4 = sext i32 %add99.4 to i64
  %arrayidx101.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.4
  %128 = load i32, i32* %arrayidx101.4, align 4
  %cmp102.4 = icmp eq i32 %128, 255
  br i1 %cmp102.4, label %if.then146.4, label %lor.lhs.false104.4

lor.lhs.false104.4:                               ; preds = %lor.lhs.false95.4
  %129 = trunc i64 %indvars.iv.4 to i32
  %add107.4 = add i32 %sub106.4, %129
  %idxprom108.4 = sext i32 %add107.4 to i64
  %arrayidx109.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.4
  %130 = load i32, i32* %arrayidx109.4, align 4
  %cmp110.4 = icmp eq i32 %130, 255
  br i1 %cmp110.4, label %if.then146.4, label %lor.lhs.false112.4

lor.lhs.false112.4:                               ; preds = %lor.lhs.false104.4
  %131 = trunc i64 %indvars.iv.4 to i32
  %add115.4 = add i32 %add114.4, %131
  %idxprom116.4 = sext i32 %add115.4 to i64
  %arrayidx117.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.4
  %132 = load i32, i32* %arrayidx117.4, align 4
  %cmp118.4 = icmp eq i32 %132, 255
  br i1 %cmp118.4, label %if.then146.4, label %lor.lhs.false120.4

lor.lhs.false120.4:                               ; preds = %lor.lhs.false112.4
  %add124.4 = add i32 %sub81.4, 127
  %idxprom125.4 = sext i32 %add124.4 to i64
  %arrayidx126.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.4
  %133 = load i32, i32* %arrayidx126.4, align 4
  %cmp127.4 = icmp eq i32 %133, 255
  br i1 %cmp127.4, label %if.then146.4, label %lor.lhs.false129.4

lor.lhs.false129.4:                               ; preds = %lor.lhs.false120.4
  %134 = add nsw i64 %120, %indvars.iv.4
  %arrayidx134.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %134
  %135 = load i32, i32* %arrayidx134.4, align 4
  %cmp135.4 = icmp eq i32 %135, 255
  br i1 %cmp135.4, label %if.then146.4, label %lor.lhs.false137.4

lor.lhs.false137.4:                               ; preds = %lor.lhs.false129.4
  %add141.4 = add i32 %sub81.4, 129
  %idxprom142.4 = sext i32 %add141.4 to i64
  %arrayidx143.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.4
  %136 = load i32, i32* %arrayidx143.4, align 4
  %cmp144.4 = icmp eq i32 %136, 255
  br i1 %cmp144.4, label %if.then146.4, label %if.else149.4

if.else149.4:                                     ; preds = %lor.lhs.false137.4
  %arrayidx151.4 = getelementptr inbounds i8, i8* %0, i64 %122
  store i8 0, i8* %arrayidx151.4, align 1
  br label %for.inc161.4

if.then146.4:                                     ; preds = %lor.lhs.false137.4, %lor.lhs.false129.4, %lor.lhs.false120.4, %lor.lhs.false112.4, %lor.lhs.false104.4, %lor.lhs.false95.4, %lor.lhs.false87.4, %if.then78.4
  %arrayidx148.4 = getelementptr inbounds i8, i8* %0, i64 %122
  store i8 -1, i8* %arrayidx148.4, align 1
  br label %for.inc161.4

if.then70.4:                                      ; preds = %for.body56.4
  %arrayidx72.4 = getelementptr inbounds i8, i8* %0, i64 %122
  store i8 0, i8* %arrayidx72.4, align 1
  br label %for.inc161.4

for.inc161.4:                                     ; preds = %if.then70.4, %if.then146.4, %if.else149.4, %if.else153.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %img_width
  br i1 %exitcond.4, label %for.inc164.4, label %for.body56.4, !llvm.loop !5

for.inc164.4:                                     ; preds = %for.inc161.4
  %indvars.iv.next20.4 = add nsw i64 %indvars.iv19, 5
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.5

for.body56.lr.ph.5:                               ; preds = %for.inc164.4
  %137 = trunc i64 %indvars.iv.next20.4 to i32
  %mul58.5 = shl nsw i32 %137, 7
  %cmp62.5 = icmp eq i64 %indvars.iv.next20.4, %12
  %138 = trunc i64 %indvars.iv.next20.4 to i32
  %sub79.5 = shl i32 %138, 7
  %mul89.5 = add i32 %sub79.5, -128
  %sub106.5 = add i32 %mul58.5, -1
  %add114.5 = or i32 %mul58.5, 1
  %mul131.5 = add i32 %sub79.5, 128
  %139 = sext i32 %mul58.5 to i64
  %140 = sext i32 %mul131.5 to i64
  %141 = sext i32 %mul89.5 to i64
  br label %for.body56.5

for.body56.5:                                     ; preds = %for.inc161.5, %for.body56.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body56.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc161.5 ]
  %142 = add nsw i64 %indvars.iv.5, %139
  %cmp65.5 = icmp eq i64 %indvars.iv.5, 0
  %or.cond1.5 = or i1 %cmp62.5, %cmp65.5
  %cmp68.5 = icmp eq i64 %indvars.iv.5, %11
  %or.cond2.5 = or i1 %cmp68.5, %or.cond1.5
  br i1 %or.cond2.5, label %if.then70.5, label %if.else73.5

if.else73.5:                                      ; preds = %for.body56.5
  %arrayidx75.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %142
  %143 = load i32, i32* %arrayidx75.5, align 4
  %cmp76.5 = icmp eq i32 %143, 75
  br i1 %cmp76.5, label %if.then78.5, label %if.else153.5

if.else153.5:                                     ; preds = %if.else73.5
  %conv156.5 = trunc i32 %143 to i8
  %arrayidx158.5 = getelementptr inbounds i8, i8* %0, i64 %142
  store i8 %conv156.5, i8* %arrayidx158.5, align 1
  br label %for.inc161.5

if.then78.5:                                      ; preds = %if.else73.5
  %144 = trunc i64 %indvars.iv.5 to i32
  %sub81.5 = add i32 %144, %sub79.5
  %add82.5 = add i32 %sub81.5, -129
  %idxprom83.5 = sext i32 %add82.5 to i64
  %arrayidx84.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.5
  %145 = load i32, i32* %arrayidx84.5, align 4
  %cmp85.5 = icmp eq i32 %145, 255
  br i1 %cmp85.5, label %if.then146.5, label %lor.lhs.false87.5

lor.lhs.false87.5:                                ; preds = %if.then78.5
  %146 = add nsw i64 %141, %indvars.iv.5
  %arrayidx92.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %146
  %147 = load i32, i32* %arrayidx92.5, align 4
  %cmp93.5 = icmp eq i32 %147, 255
  br i1 %cmp93.5, label %if.then146.5, label %lor.lhs.false95.5

lor.lhs.false95.5:                                ; preds = %lor.lhs.false87.5
  %add99.5 = add i32 %sub81.5, -127
  %idxprom100.5 = sext i32 %add99.5 to i64
  %arrayidx101.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.5
  %148 = load i32, i32* %arrayidx101.5, align 4
  %cmp102.5 = icmp eq i32 %148, 255
  br i1 %cmp102.5, label %if.then146.5, label %lor.lhs.false104.5

lor.lhs.false104.5:                               ; preds = %lor.lhs.false95.5
  %149 = trunc i64 %indvars.iv.5 to i32
  %add107.5 = add i32 %sub106.5, %149
  %idxprom108.5 = sext i32 %add107.5 to i64
  %arrayidx109.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.5
  %150 = load i32, i32* %arrayidx109.5, align 4
  %cmp110.5 = icmp eq i32 %150, 255
  br i1 %cmp110.5, label %if.then146.5, label %lor.lhs.false112.5

lor.lhs.false112.5:                               ; preds = %lor.lhs.false104.5
  %151 = trunc i64 %indvars.iv.5 to i32
  %add115.5 = add i32 %add114.5, %151
  %idxprom116.5 = sext i32 %add115.5 to i64
  %arrayidx117.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.5
  %152 = load i32, i32* %arrayidx117.5, align 4
  %cmp118.5 = icmp eq i32 %152, 255
  br i1 %cmp118.5, label %if.then146.5, label %lor.lhs.false120.5

lor.lhs.false120.5:                               ; preds = %lor.lhs.false112.5
  %add124.5 = add i32 %sub81.5, 127
  %idxprom125.5 = sext i32 %add124.5 to i64
  %arrayidx126.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.5
  %153 = load i32, i32* %arrayidx126.5, align 4
  %cmp127.5 = icmp eq i32 %153, 255
  br i1 %cmp127.5, label %if.then146.5, label %lor.lhs.false129.5

lor.lhs.false129.5:                               ; preds = %lor.lhs.false120.5
  %154 = add nsw i64 %140, %indvars.iv.5
  %arrayidx134.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %154
  %155 = load i32, i32* %arrayidx134.5, align 4
  %cmp135.5 = icmp eq i32 %155, 255
  br i1 %cmp135.5, label %if.then146.5, label %lor.lhs.false137.5

lor.lhs.false137.5:                               ; preds = %lor.lhs.false129.5
  %add141.5 = add i32 %sub81.5, 129
  %idxprom142.5 = sext i32 %add141.5 to i64
  %arrayidx143.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.5
  %156 = load i32, i32* %arrayidx143.5, align 4
  %cmp144.5 = icmp eq i32 %156, 255
  br i1 %cmp144.5, label %if.then146.5, label %if.else149.5

if.else149.5:                                     ; preds = %lor.lhs.false137.5
  %arrayidx151.5 = getelementptr inbounds i8, i8* %0, i64 %142
  store i8 0, i8* %arrayidx151.5, align 1
  br label %for.inc161.5

if.then146.5:                                     ; preds = %lor.lhs.false137.5, %lor.lhs.false129.5, %lor.lhs.false120.5, %lor.lhs.false112.5, %lor.lhs.false104.5, %lor.lhs.false95.5, %lor.lhs.false87.5, %if.then78.5
  %arrayidx148.5 = getelementptr inbounds i8, i8* %0, i64 %142
  store i8 -1, i8* %arrayidx148.5, align 1
  br label %for.inc161.5

if.then70.5:                                      ; preds = %for.body56.5
  %arrayidx72.5 = getelementptr inbounds i8, i8* %0, i64 %142
  store i8 0, i8* %arrayidx72.5, align 1
  br label %for.inc161.5

for.inc161.5:                                     ; preds = %if.then70.5, %if.then146.5, %if.else149.5, %if.else153.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %img_width
  br i1 %exitcond.5, label %for.inc164.5, label %for.body56.5, !llvm.loop !5

for.inc164.5:                                     ; preds = %for.inc161.5
  %indvars.iv.next20.5 = add nsw i64 %indvars.iv19, 6
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.6

for.body56.lr.ph.6:                               ; preds = %for.inc164.5
  %157 = trunc i64 %indvars.iv.next20.5 to i32
  %mul58.6 = shl nsw i32 %157, 7
  %cmp62.6 = icmp eq i64 %indvars.iv.next20.5, %12
  %158 = trunc i64 %indvars.iv.next20.5 to i32
  %sub79.6 = shl i32 %158, 7
  %mul89.6 = add i32 %sub79.6, -128
  %sub106.6 = add i32 %mul58.6, -1
  %add114.6 = or i32 %mul58.6, 1
  %mul131.6 = add i32 %sub79.6, 128
  %159 = sext i32 %mul58.6 to i64
  %160 = sext i32 %mul131.6 to i64
  %161 = sext i32 %mul89.6 to i64
  br label %for.body56.6

for.body56.6:                                     ; preds = %for.inc161.6, %for.body56.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body56.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc161.6 ]
  %162 = add nsw i64 %indvars.iv.6, %159
  %cmp65.6 = icmp eq i64 %indvars.iv.6, 0
  %or.cond1.6 = or i1 %cmp62.6, %cmp65.6
  %cmp68.6 = icmp eq i64 %indvars.iv.6, %11
  %or.cond2.6 = or i1 %cmp68.6, %or.cond1.6
  br i1 %or.cond2.6, label %if.then70.6, label %if.else73.6

if.else73.6:                                      ; preds = %for.body56.6
  %arrayidx75.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %162
  %163 = load i32, i32* %arrayidx75.6, align 4
  %cmp76.6 = icmp eq i32 %163, 75
  br i1 %cmp76.6, label %if.then78.6, label %if.else153.6

if.else153.6:                                     ; preds = %if.else73.6
  %conv156.6 = trunc i32 %163 to i8
  %arrayidx158.6 = getelementptr inbounds i8, i8* %0, i64 %162
  store i8 %conv156.6, i8* %arrayidx158.6, align 1
  br label %for.inc161.6

if.then78.6:                                      ; preds = %if.else73.6
  %164 = trunc i64 %indvars.iv.6 to i32
  %sub81.6 = add i32 %164, %sub79.6
  %add82.6 = add i32 %sub81.6, -129
  %idxprom83.6 = sext i32 %add82.6 to i64
  %arrayidx84.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.6
  %165 = load i32, i32* %arrayidx84.6, align 4
  %cmp85.6 = icmp eq i32 %165, 255
  br i1 %cmp85.6, label %if.then146.6, label %lor.lhs.false87.6

lor.lhs.false87.6:                                ; preds = %if.then78.6
  %166 = add nsw i64 %161, %indvars.iv.6
  %arrayidx92.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %166
  %167 = load i32, i32* %arrayidx92.6, align 4
  %cmp93.6 = icmp eq i32 %167, 255
  br i1 %cmp93.6, label %if.then146.6, label %lor.lhs.false95.6

lor.lhs.false95.6:                                ; preds = %lor.lhs.false87.6
  %add99.6 = add i32 %sub81.6, -127
  %idxprom100.6 = sext i32 %add99.6 to i64
  %arrayidx101.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.6
  %168 = load i32, i32* %arrayidx101.6, align 4
  %cmp102.6 = icmp eq i32 %168, 255
  br i1 %cmp102.6, label %if.then146.6, label %lor.lhs.false104.6

lor.lhs.false104.6:                               ; preds = %lor.lhs.false95.6
  %169 = trunc i64 %indvars.iv.6 to i32
  %add107.6 = add i32 %sub106.6, %169
  %idxprom108.6 = sext i32 %add107.6 to i64
  %arrayidx109.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.6
  %170 = load i32, i32* %arrayidx109.6, align 4
  %cmp110.6 = icmp eq i32 %170, 255
  br i1 %cmp110.6, label %if.then146.6, label %lor.lhs.false112.6

lor.lhs.false112.6:                               ; preds = %lor.lhs.false104.6
  %171 = trunc i64 %indvars.iv.6 to i32
  %add115.6 = add i32 %add114.6, %171
  %idxprom116.6 = sext i32 %add115.6 to i64
  %arrayidx117.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.6
  %172 = load i32, i32* %arrayidx117.6, align 4
  %cmp118.6 = icmp eq i32 %172, 255
  br i1 %cmp118.6, label %if.then146.6, label %lor.lhs.false120.6

lor.lhs.false120.6:                               ; preds = %lor.lhs.false112.6
  %add124.6 = add i32 %sub81.6, 127
  %idxprom125.6 = sext i32 %add124.6 to i64
  %arrayidx126.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.6
  %173 = load i32, i32* %arrayidx126.6, align 4
  %cmp127.6 = icmp eq i32 %173, 255
  br i1 %cmp127.6, label %if.then146.6, label %lor.lhs.false129.6

lor.lhs.false129.6:                               ; preds = %lor.lhs.false120.6
  %174 = add nsw i64 %160, %indvars.iv.6
  %arrayidx134.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %174
  %175 = load i32, i32* %arrayidx134.6, align 4
  %cmp135.6 = icmp eq i32 %175, 255
  br i1 %cmp135.6, label %if.then146.6, label %lor.lhs.false137.6

lor.lhs.false137.6:                               ; preds = %lor.lhs.false129.6
  %add141.6 = add i32 %sub81.6, 129
  %idxprom142.6 = sext i32 %add141.6 to i64
  %arrayidx143.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.6
  %176 = load i32, i32* %arrayidx143.6, align 4
  %cmp144.6 = icmp eq i32 %176, 255
  br i1 %cmp144.6, label %if.then146.6, label %if.else149.6

if.else149.6:                                     ; preds = %lor.lhs.false137.6
  %arrayidx151.6 = getelementptr inbounds i8, i8* %0, i64 %162
  store i8 0, i8* %arrayidx151.6, align 1
  br label %for.inc161.6

if.then146.6:                                     ; preds = %lor.lhs.false137.6, %lor.lhs.false129.6, %lor.lhs.false120.6, %lor.lhs.false112.6, %lor.lhs.false104.6, %lor.lhs.false95.6, %lor.lhs.false87.6, %if.then78.6
  %arrayidx148.6 = getelementptr inbounds i8, i8* %0, i64 %162
  store i8 -1, i8* %arrayidx148.6, align 1
  br label %for.inc161.6

if.then70.6:                                      ; preds = %for.body56.6
  %arrayidx72.6 = getelementptr inbounds i8, i8* %0, i64 %162
  store i8 0, i8* %arrayidx72.6, align 1
  br label %for.inc161.6

for.inc161.6:                                     ; preds = %if.then70.6, %if.then146.6, %if.else149.6, %if.else153.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %img_width
  br i1 %exitcond.6, label %for.inc164.6, label %for.body56.6, !llvm.loop !5

for.inc164.6:                                     ; preds = %for.inc161.6
  %indvars.iv.next20.6 = add nsw i64 %indvars.iv19, 7
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.7

for.body56.lr.ph.7:                               ; preds = %for.inc164.6
  %177 = trunc i64 %indvars.iv.next20.6 to i32
  %mul58.7 = shl nsw i32 %177, 7
  %cmp62.7 = icmp eq i64 %indvars.iv.next20.6, %12
  %178 = trunc i64 %indvars.iv.next20.6 to i32
  %sub79.7 = shl i32 %178, 7
  %mul89.7 = add i32 %sub79.7, -128
  %sub106.7 = add i32 %mul58.7, -1
  %add114.7 = or i32 %mul58.7, 1
  %mul131.7 = add i32 %sub79.7, 128
  %179 = sext i32 %mul58.7 to i64
  %180 = sext i32 %mul131.7 to i64
  %181 = sext i32 %mul89.7 to i64
  br label %for.body56.7

for.body56.7:                                     ; preds = %for.inc161.7, %for.body56.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body56.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc161.7 ]
  %182 = add nsw i64 %indvars.iv.7, %179
  %cmp65.7 = icmp eq i64 %indvars.iv.7, 0
  %or.cond1.7 = or i1 %cmp62.7, %cmp65.7
  %cmp68.7 = icmp eq i64 %indvars.iv.7, %11
  %or.cond2.7 = or i1 %cmp68.7, %or.cond1.7
  br i1 %or.cond2.7, label %if.then70.7, label %if.else73.7

if.else73.7:                                      ; preds = %for.body56.7
  %arrayidx75.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %182
  %183 = load i32, i32* %arrayidx75.7, align 4
  %cmp76.7 = icmp eq i32 %183, 75
  br i1 %cmp76.7, label %if.then78.7, label %if.else153.7

if.else153.7:                                     ; preds = %if.else73.7
  %conv156.7 = trunc i32 %183 to i8
  %arrayidx158.7 = getelementptr inbounds i8, i8* %0, i64 %182
  store i8 %conv156.7, i8* %arrayidx158.7, align 1
  br label %for.inc161.7

if.then78.7:                                      ; preds = %if.else73.7
  %184 = trunc i64 %indvars.iv.7 to i32
  %sub81.7 = add i32 %184, %sub79.7
  %add82.7 = add i32 %sub81.7, -129
  %idxprom83.7 = sext i32 %add82.7 to i64
  %arrayidx84.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.7
  %185 = load i32, i32* %arrayidx84.7, align 4
  %cmp85.7 = icmp eq i32 %185, 255
  br i1 %cmp85.7, label %if.then146.7, label %lor.lhs.false87.7

lor.lhs.false87.7:                                ; preds = %if.then78.7
  %186 = add nsw i64 %181, %indvars.iv.7
  %arrayidx92.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %186
  %187 = load i32, i32* %arrayidx92.7, align 4
  %cmp93.7 = icmp eq i32 %187, 255
  br i1 %cmp93.7, label %if.then146.7, label %lor.lhs.false95.7

lor.lhs.false95.7:                                ; preds = %lor.lhs.false87.7
  %add99.7 = add i32 %sub81.7, -127
  %idxprom100.7 = sext i32 %add99.7 to i64
  %arrayidx101.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.7
  %188 = load i32, i32* %arrayidx101.7, align 4
  %cmp102.7 = icmp eq i32 %188, 255
  br i1 %cmp102.7, label %if.then146.7, label %lor.lhs.false104.7

lor.lhs.false104.7:                               ; preds = %lor.lhs.false95.7
  %189 = trunc i64 %indvars.iv.7 to i32
  %add107.7 = add i32 %sub106.7, %189
  %idxprom108.7 = sext i32 %add107.7 to i64
  %arrayidx109.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.7
  %190 = load i32, i32* %arrayidx109.7, align 4
  %cmp110.7 = icmp eq i32 %190, 255
  br i1 %cmp110.7, label %if.then146.7, label %lor.lhs.false112.7

lor.lhs.false112.7:                               ; preds = %lor.lhs.false104.7
  %191 = trunc i64 %indvars.iv.7 to i32
  %add115.7 = add i32 %add114.7, %191
  %idxprom116.7 = sext i32 %add115.7 to i64
  %arrayidx117.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.7
  %192 = load i32, i32* %arrayidx117.7, align 4
  %cmp118.7 = icmp eq i32 %192, 255
  br i1 %cmp118.7, label %if.then146.7, label %lor.lhs.false120.7

lor.lhs.false120.7:                               ; preds = %lor.lhs.false112.7
  %add124.7 = add i32 %sub81.7, 127
  %idxprom125.7 = sext i32 %add124.7 to i64
  %arrayidx126.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.7
  %193 = load i32, i32* %arrayidx126.7, align 4
  %cmp127.7 = icmp eq i32 %193, 255
  br i1 %cmp127.7, label %if.then146.7, label %lor.lhs.false129.7

lor.lhs.false129.7:                               ; preds = %lor.lhs.false120.7
  %194 = add nsw i64 %180, %indvars.iv.7
  %arrayidx134.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %194
  %195 = load i32, i32* %arrayidx134.7, align 4
  %cmp135.7 = icmp eq i32 %195, 255
  br i1 %cmp135.7, label %if.then146.7, label %lor.lhs.false137.7

lor.lhs.false137.7:                               ; preds = %lor.lhs.false129.7
  %add141.7 = add i32 %sub81.7, 129
  %idxprom142.7 = sext i32 %add141.7 to i64
  %arrayidx143.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.7
  %196 = load i32, i32* %arrayidx143.7, align 4
  %cmp144.7 = icmp eq i32 %196, 255
  br i1 %cmp144.7, label %if.then146.7, label %if.else149.7

if.else149.7:                                     ; preds = %lor.lhs.false137.7
  %arrayidx151.7 = getelementptr inbounds i8, i8* %0, i64 %182
  store i8 0, i8* %arrayidx151.7, align 1
  br label %for.inc161.7

if.then146.7:                                     ; preds = %lor.lhs.false137.7, %lor.lhs.false129.7, %lor.lhs.false120.7, %lor.lhs.false112.7, %lor.lhs.false104.7, %lor.lhs.false95.7, %lor.lhs.false87.7, %if.then78.7
  %arrayidx148.7 = getelementptr inbounds i8, i8* %0, i64 %182
  store i8 -1, i8* %arrayidx148.7, align 1
  br label %for.inc161.7

if.then70.7:                                      ; preds = %for.body56.7
  %arrayidx72.7 = getelementptr inbounds i8, i8* %0, i64 %182
  store i8 0, i8* %arrayidx72.7, align 1
  br label %for.inc161.7

for.inc161.7:                                     ; preds = %if.then70.7, %if.then146.7, %if.else149.7, %if.else153.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %img_width
  br i1 %exitcond.7, label %for.inc164.7, label %for.body56.7, !llvm.loop !5

for.inc164.7:                                     ; preds = %for.inc161.7
  %indvars.iv.next20.7 = add nsw i64 %indvars.iv19, 8
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.8

for.body56.lr.ph.8:                               ; preds = %for.inc164.7
  %197 = trunc i64 %indvars.iv.next20.7 to i32
  %mul58.8 = shl nsw i32 %197, 7
  %cmp62.8 = icmp eq i64 %indvars.iv.next20.7, %12
  %198 = trunc i64 %indvars.iv.next20.7 to i32
  %sub79.8 = shl i32 %198, 7
  %mul89.8 = add i32 %sub79.8, -128
  %sub106.8 = add i32 %mul58.8, -1
  %add114.8 = or i32 %mul58.8, 1
  %mul131.8 = add i32 %sub79.8, 128
  %199 = sext i32 %mul58.8 to i64
  %200 = sext i32 %mul131.8 to i64
  %201 = sext i32 %mul89.8 to i64
  br label %for.body56.8

for.body56.8:                                     ; preds = %for.inc161.8, %for.body56.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body56.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc161.8 ]
  %202 = add nsw i64 %indvars.iv.8, %199
  %cmp65.8 = icmp eq i64 %indvars.iv.8, 0
  %or.cond1.8 = or i1 %cmp62.8, %cmp65.8
  %cmp68.8 = icmp eq i64 %indvars.iv.8, %11
  %or.cond2.8 = or i1 %cmp68.8, %or.cond1.8
  br i1 %or.cond2.8, label %if.then70.8, label %if.else73.8

if.else73.8:                                      ; preds = %for.body56.8
  %arrayidx75.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %202
  %203 = load i32, i32* %arrayidx75.8, align 4
  %cmp76.8 = icmp eq i32 %203, 75
  br i1 %cmp76.8, label %if.then78.8, label %if.else153.8

if.else153.8:                                     ; preds = %if.else73.8
  %conv156.8 = trunc i32 %203 to i8
  %arrayidx158.8 = getelementptr inbounds i8, i8* %0, i64 %202
  store i8 %conv156.8, i8* %arrayidx158.8, align 1
  br label %for.inc161.8

if.then78.8:                                      ; preds = %if.else73.8
  %204 = trunc i64 %indvars.iv.8 to i32
  %sub81.8 = add i32 %204, %sub79.8
  %add82.8 = add i32 %sub81.8, -129
  %idxprom83.8 = sext i32 %add82.8 to i64
  %arrayidx84.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.8
  %205 = load i32, i32* %arrayidx84.8, align 4
  %cmp85.8 = icmp eq i32 %205, 255
  br i1 %cmp85.8, label %if.then146.8, label %lor.lhs.false87.8

lor.lhs.false87.8:                                ; preds = %if.then78.8
  %206 = add nsw i64 %201, %indvars.iv.8
  %arrayidx92.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %206
  %207 = load i32, i32* %arrayidx92.8, align 4
  %cmp93.8 = icmp eq i32 %207, 255
  br i1 %cmp93.8, label %if.then146.8, label %lor.lhs.false95.8

lor.lhs.false95.8:                                ; preds = %lor.lhs.false87.8
  %add99.8 = add i32 %sub81.8, -127
  %idxprom100.8 = sext i32 %add99.8 to i64
  %arrayidx101.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.8
  %208 = load i32, i32* %arrayidx101.8, align 4
  %cmp102.8 = icmp eq i32 %208, 255
  br i1 %cmp102.8, label %if.then146.8, label %lor.lhs.false104.8

lor.lhs.false104.8:                               ; preds = %lor.lhs.false95.8
  %209 = trunc i64 %indvars.iv.8 to i32
  %add107.8 = add i32 %sub106.8, %209
  %idxprom108.8 = sext i32 %add107.8 to i64
  %arrayidx109.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.8
  %210 = load i32, i32* %arrayidx109.8, align 4
  %cmp110.8 = icmp eq i32 %210, 255
  br i1 %cmp110.8, label %if.then146.8, label %lor.lhs.false112.8

lor.lhs.false112.8:                               ; preds = %lor.lhs.false104.8
  %211 = trunc i64 %indvars.iv.8 to i32
  %add115.8 = add i32 %add114.8, %211
  %idxprom116.8 = sext i32 %add115.8 to i64
  %arrayidx117.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.8
  %212 = load i32, i32* %arrayidx117.8, align 4
  %cmp118.8 = icmp eq i32 %212, 255
  br i1 %cmp118.8, label %if.then146.8, label %lor.lhs.false120.8

lor.lhs.false120.8:                               ; preds = %lor.lhs.false112.8
  %add124.8 = add i32 %sub81.8, 127
  %idxprom125.8 = sext i32 %add124.8 to i64
  %arrayidx126.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.8
  %213 = load i32, i32* %arrayidx126.8, align 4
  %cmp127.8 = icmp eq i32 %213, 255
  br i1 %cmp127.8, label %if.then146.8, label %lor.lhs.false129.8

lor.lhs.false129.8:                               ; preds = %lor.lhs.false120.8
  %214 = add nsw i64 %200, %indvars.iv.8
  %arrayidx134.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %214
  %215 = load i32, i32* %arrayidx134.8, align 4
  %cmp135.8 = icmp eq i32 %215, 255
  br i1 %cmp135.8, label %if.then146.8, label %lor.lhs.false137.8

lor.lhs.false137.8:                               ; preds = %lor.lhs.false129.8
  %add141.8 = add i32 %sub81.8, 129
  %idxprom142.8 = sext i32 %add141.8 to i64
  %arrayidx143.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.8
  %216 = load i32, i32* %arrayidx143.8, align 4
  %cmp144.8 = icmp eq i32 %216, 255
  br i1 %cmp144.8, label %if.then146.8, label %if.else149.8

if.else149.8:                                     ; preds = %lor.lhs.false137.8
  %arrayidx151.8 = getelementptr inbounds i8, i8* %0, i64 %202
  store i8 0, i8* %arrayidx151.8, align 1
  br label %for.inc161.8

if.then146.8:                                     ; preds = %lor.lhs.false137.8, %lor.lhs.false129.8, %lor.lhs.false120.8, %lor.lhs.false112.8, %lor.lhs.false104.8, %lor.lhs.false95.8, %lor.lhs.false87.8, %if.then78.8
  %arrayidx148.8 = getelementptr inbounds i8, i8* %0, i64 %202
  store i8 -1, i8* %arrayidx148.8, align 1
  br label %for.inc161.8

if.then70.8:                                      ; preds = %for.body56.8
  %arrayidx72.8 = getelementptr inbounds i8, i8* %0, i64 %202
  store i8 0, i8* %arrayidx72.8, align 1
  br label %for.inc161.8

for.inc161.8:                                     ; preds = %if.then70.8, %if.then146.8, %if.else149.8, %if.else153.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %img_width
  br i1 %exitcond.8, label %for.inc164.8, label %for.body56.8, !llvm.loop !5

for.inc164.8:                                     ; preds = %for.inc161.8
  %indvars.iv.next20.8 = add nsw i64 %indvars.iv19, 9
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.9

for.body56.lr.ph.9:                               ; preds = %for.inc164.8
  %217 = trunc i64 %indvars.iv.next20.8 to i32
  %mul58.9 = shl nsw i32 %217, 7
  %cmp62.9 = icmp eq i64 %indvars.iv.next20.8, %12
  %218 = trunc i64 %indvars.iv.next20.8 to i32
  %sub79.9 = shl i32 %218, 7
  %mul89.9 = add i32 %sub79.9, -128
  %sub106.9 = add i32 %mul58.9, -1
  %add114.9 = or i32 %mul58.9, 1
  %mul131.9 = add i32 %sub79.9, 128
  %219 = sext i32 %mul58.9 to i64
  %220 = sext i32 %mul131.9 to i64
  %221 = sext i32 %mul89.9 to i64
  br label %for.body56.9

for.body56.9:                                     ; preds = %for.inc161.9, %for.body56.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body56.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc161.9 ]
  %222 = add nsw i64 %indvars.iv.9, %219
  %cmp65.9 = icmp eq i64 %indvars.iv.9, 0
  %or.cond1.9 = or i1 %cmp62.9, %cmp65.9
  %cmp68.9 = icmp eq i64 %indvars.iv.9, %11
  %or.cond2.9 = or i1 %cmp68.9, %or.cond1.9
  br i1 %or.cond2.9, label %if.then70.9, label %if.else73.9

if.else73.9:                                      ; preds = %for.body56.9
  %arrayidx75.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %222
  %223 = load i32, i32* %arrayidx75.9, align 4
  %cmp76.9 = icmp eq i32 %223, 75
  br i1 %cmp76.9, label %if.then78.9, label %if.else153.9

if.else153.9:                                     ; preds = %if.else73.9
  %conv156.9 = trunc i32 %223 to i8
  %arrayidx158.9 = getelementptr inbounds i8, i8* %0, i64 %222
  store i8 %conv156.9, i8* %arrayidx158.9, align 1
  br label %for.inc161.9

if.then78.9:                                      ; preds = %if.else73.9
  %224 = trunc i64 %indvars.iv.9 to i32
  %sub81.9 = add i32 %224, %sub79.9
  %add82.9 = add i32 %sub81.9, -129
  %idxprom83.9 = sext i32 %add82.9 to i64
  %arrayidx84.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.9
  %225 = load i32, i32* %arrayidx84.9, align 4
  %cmp85.9 = icmp eq i32 %225, 255
  br i1 %cmp85.9, label %if.then146.9, label %lor.lhs.false87.9

lor.lhs.false87.9:                                ; preds = %if.then78.9
  %226 = add nsw i64 %221, %indvars.iv.9
  %arrayidx92.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %226
  %227 = load i32, i32* %arrayidx92.9, align 4
  %cmp93.9 = icmp eq i32 %227, 255
  br i1 %cmp93.9, label %if.then146.9, label %lor.lhs.false95.9

lor.lhs.false95.9:                                ; preds = %lor.lhs.false87.9
  %add99.9 = add i32 %sub81.9, -127
  %idxprom100.9 = sext i32 %add99.9 to i64
  %arrayidx101.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.9
  %228 = load i32, i32* %arrayidx101.9, align 4
  %cmp102.9 = icmp eq i32 %228, 255
  br i1 %cmp102.9, label %if.then146.9, label %lor.lhs.false104.9

lor.lhs.false104.9:                               ; preds = %lor.lhs.false95.9
  %229 = trunc i64 %indvars.iv.9 to i32
  %add107.9 = add i32 %sub106.9, %229
  %idxprom108.9 = sext i32 %add107.9 to i64
  %arrayidx109.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.9
  %230 = load i32, i32* %arrayidx109.9, align 4
  %cmp110.9 = icmp eq i32 %230, 255
  br i1 %cmp110.9, label %if.then146.9, label %lor.lhs.false112.9

lor.lhs.false112.9:                               ; preds = %lor.lhs.false104.9
  %231 = trunc i64 %indvars.iv.9 to i32
  %add115.9 = add i32 %add114.9, %231
  %idxprom116.9 = sext i32 %add115.9 to i64
  %arrayidx117.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.9
  %232 = load i32, i32* %arrayidx117.9, align 4
  %cmp118.9 = icmp eq i32 %232, 255
  br i1 %cmp118.9, label %if.then146.9, label %lor.lhs.false120.9

lor.lhs.false120.9:                               ; preds = %lor.lhs.false112.9
  %add124.9 = add i32 %sub81.9, 127
  %idxprom125.9 = sext i32 %add124.9 to i64
  %arrayidx126.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.9
  %233 = load i32, i32* %arrayidx126.9, align 4
  %cmp127.9 = icmp eq i32 %233, 255
  br i1 %cmp127.9, label %if.then146.9, label %lor.lhs.false129.9

lor.lhs.false129.9:                               ; preds = %lor.lhs.false120.9
  %234 = add nsw i64 %220, %indvars.iv.9
  %arrayidx134.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %234
  %235 = load i32, i32* %arrayidx134.9, align 4
  %cmp135.9 = icmp eq i32 %235, 255
  br i1 %cmp135.9, label %if.then146.9, label %lor.lhs.false137.9

lor.lhs.false137.9:                               ; preds = %lor.lhs.false129.9
  %add141.9 = add i32 %sub81.9, 129
  %idxprom142.9 = sext i32 %add141.9 to i64
  %arrayidx143.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.9
  %236 = load i32, i32* %arrayidx143.9, align 4
  %cmp144.9 = icmp eq i32 %236, 255
  br i1 %cmp144.9, label %if.then146.9, label %if.else149.9

if.else149.9:                                     ; preds = %lor.lhs.false137.9
  %arrayidx151.9 = getelementptr inbounds i8, i8* %0, i64 %222
  store i8 0, i8* %arrayidx151.9, align 1
  br label %for.inc161.9

if.then146.9:                                     ; preds = %lor.lhs.false137.9, %lor.lhs.false129.9, %lor.lhs.false120.9, %lor.lhs.false112.9, %lor.lhs.false104.9, %lor.lhs.false95.9, %lor.lhs.false87.9, %if.then78.9
  %arrayidx148.9 = getelementptr inbounds i8, i8* %0, i64 %222
  store i8 -1, i8* %arrayidx148.9, align 1
  br label %for.inc161.9

if.then70.9:                                      ; preds = %for.body56.9
  %arrayidx72.9 = getelementptr inbounds i8, i8* %0, i64 %222
  store i8 0, i8* %arrayidx72.9, align 1
  br label %for.inc161.9

for.inc161.9:                                     ; preds = %if.then70.9, %if.then146.9, %if.else149.9, %if.else153.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %img_width
  br i1 %exitcond.9, label %for.inc164.9, label %for.body56.9, !llvm.loop !5

for.inc164.9:                                     ; preds = %for.inc161.9
  %indvars.iv.next20.9 = add nsw i64 %indvars.iv19, 10
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.10

for.body56.lr.ph.10:                              ; preds = %for.inc164.9
  %237 = trunc i64 %indvars.iv.next20.9 to i32
  %mul58.10 = shl nsw i32 %237, 7
  %cmp62.10 = icmp eq i64 %indvars.iv.next20.9, %12
  %238 = trunc i64 %indvars.iv.next20.9 to i32
  %sub79.10 = shl i32 %238, 7
  %mul89.10 = add i32 %sub79.10, -128
  %sub106.10 = add i32 %mul58.10, -1
  %add114.10 = or i32 %mul58.10, 1
  %mul131.10 = add i32 %sub79.10, 128
  %239 = sext i32 %mul58.10 to i64
  %240 = sext i32 %mul131.10 to i64
  %241 = sext i32 %mul89.10 to i64
  br label %for.body56.10

for.body56.10:                                    ; preds = %for.inc161.10, %for.body56.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body56.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc161.10 ]
  %242 = add nsw i64 %indvars.iv.10, %239
  %cmp65.10 = icmp eq i64 %indvars.iv.10, 0
  %or.cond1.10 = or i1 %cmp62.10, %cmp65.10
  %cmp68.10 = icmp eq i64 %indvars.iv.10, %11
  %or.cond2.10 = or i1 %cmp68.10, %or.cond1.10
  br i1 %or.cond2.10, label %if.then70.10, label %if.else73.10

if.else73.10:                                     ; preds = %for.body56.10
  %arrayidx75.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %242
  %243 = load i32, i32* %arrayidx75.10, align 4
  %cmp76.10 = icmp eq i32 %243, 75
  br i1 %cmp76.10, label %if.then78.10, label %if.else153.10

if.else153.10:                                    ; preds = %if.else73.10
  %conv156.10 = trunc i32 %243 to i8
  %arrayidx158.10 = getelementptr inbounds i8, i8* %0, i64 %242
  store i8 %conv156.10, i8* %arrayidx158.10, align 1
  br label %for.inc161.10

if.then78.10:                                     ; preds = %if.else73.10
  %244 = trunc i64 %indvars.iv.10 to i32
  %sub81.10 = add i32 %244, %sub79.10
  %add82.10 = add i32 %sub81.10, -129
  %idxprom83.10 = sext i32 %add82.10 to i64
  %arrayidx84.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.10
  %245 = load i32, i32* %arrayidx84.10, align 4
  %cmp85.10 = icmp eq i32 %245, 255
  br i1 %cmp85.10, label %if.then146.10, label %lor.lhs.false87.10

lor.lhs.false87.10:                               ; preds = %if.then78.10
  %246 = add nsw i64 %241, %indvars.iv.10
  %arrayidx92.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %246
  %247 = load i32, i32* %arrayidx92.10, align 4
  %cmp93.10 = icmp eq i32 %247, 255
  br i1 %cmp93.10, label %if.then146.10, label %lor.lhs.false95.10

lor.lhs.false95.10:                               ; preds = %lor.lhs.false87.10
  %add99.10 = add i32 %sub81.10, -127
  %idxprom100.10 = sext i32 %add99.10 to i64
  %arrayidx101.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.10
  %248 = load i32, i32* %arrayidx101.10, align 4
  %cmp102.10 = icmp eq i32 %248, 255
  br i1 %cmp102.10, label %if.then146.10, label %lor.lhs.false104.10

lor.lhs.false104.10:                              ; preds = %lor.lhs.false95.10
  %249 = trunc i64 %indvars.iv.10 to i32
  %add107.10 = add i32 %sub106.10, %249
  %idxprom108.10 = sext i32 %add107.10 to i64
  %arrayidx109.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.10
  %250 = load i32, i32* %arrayidx109.10, align 4
  %cmp110.10 = icmp eq i32 %250, 255
  br i1 %cmp110.10, label %if.then146.10, label %lor.lhs.false112.10

lor.lhs.false112.10:                              ; preds = %lor.lhs.false104.10
  %251 = trunc i64 %indvars.iv.10 to i32
  %add115.10 = add i32 %add114.10, %251
  %idxprom116.10 = sext i32 %add115.10 to i64
  %arrayidx117.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.10
  %252 = load i32, i32* %arrayidx117.10, align 4
  %cmp118.10 = icmp eq i32 %252, 255
  br i1 %cmp118.10, label %if.then146.10, label %lor.lhs.false120.10

lor.lhs.false120.10:                              ; preds = %lor.lhs.false112.10
  %add124.10 = add i32 %sub81.10, 127
  %idxprom125.10 = sext i32 %add124.10 to i64
  %arrayidx126.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.10
  %253 = load i32, i32* %arrayidx126.10, align 4
  %cmp127.10 = icmp eq i32 %253, 255
  br i1 %cmp127.10, label %if.then146.10, label %lor.lhs.false129.10

lor.lhs.false129.10:                              ; preds = %lor.lhs.false120.10
  %254 = add nsw i64 %240, %indvars.iv.10
  %arrayidx134.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %254
  %255 = load i32, i32* %arrayidx134.10, align 4
  %cmp135.10 = icmp eq i32 %255, 255
  br i1 %cmp135.10, label %if.then146.10, label %lor.lhs.false137.10

lor.lhs.false137.10:                              ; preds = %lor.lhs.false129.10
  %add141.10 = add i32 %sub81.10, 129
  %idxprom142.10 = sext i32 %add141.10 to i64
  %arrayidx143.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.10
  %256 = load i32, i32* %arrayidx143.10, align 4
  %cmp144.10 = icmp eq i32 %256, 255
  br i1 %cmp144.10, label %if.then146.10, label %if.else149.10

if.else149.10:                                    ; preds = %lor.lhs.false137.10
  %arrayidx151.10 = getelementptr inbounds i8, i8* %0, i64 %242
  store i8 0, i8* %arrayidx151.10, align 1
  br label %for.inc161.10

if.then146.10:                                    ; preds = %lor.lhs.false137.10, %lor.lhs.false129.10, %lor.lhs.false120.10, %lor.lhs.false112.10, %lor.lhs.false104.10, %lor.lhs.false95.10, %lor.lhs.false87.10, %if.then78.10
  %arrayidx148.10 = getelementptr inbounds i8, i8* %0, i64 %242
  store i8 -1, i8* %arrayidx148.10, align 1
  br label %for.inc161.10

if.then70.10:                                     ; preds = %for.body56.10
  %arrayidx72.10 = getelementptr inbounds i8, i8* %0, i64 %242
  store i8 0, i8* %arrayidx72.10, align 1
  br label %for.inc161.10

for.inc161.10:                                    ; preds = %if.then70.10, %if.then146.10, %if.else149.10, %if.else153.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %img_width
  br i1 %exitcond.10, label %for.inc164.10, label %for.body56.10, !llvm.loop !5

for.inc164.10:                                    ; preds = %for.inc161.10
  %indvars.iv.next20.10 = add nsw i64 %indvars.iv19, 11
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.11

for.body56.lr.ph.11:                              ; preds = %for.inc164.10
  %257 = trunc i64 %indvars.iv.next20.10 to i32
  %mul58.11 = shl nsw i32 %257, 7
  %cmp62.11 = icmp eq i64 %indvars.iv.next20.10, %12
  %258 = trunc i64 %indvars.iv.next20.10 to i32
  %sub79.11 = shl i32 %258, 7
  %mul89.11 = add i32 %sub79.11, -128
  %sub106.11 = add i32 %mul58.11, -1
  %add114.11 = or i32 %mul58.11, 1
  %mul131.11 = add i32 %sub79.11, 128
  %259 = sext i32 %mul58.11 to i64
  %260 = sext i32 %mul131.11 to i64
  %261 = sext i32 %mul89.11 to i64
  br label %for.body56.11

for.body56.11:                                    ; preds = %for.inc161.11, %for.body56.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body56.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc161.11 ]
  %262 = add nsw i64 %indvars.iv.11, %259
  %cmp65.11 = icmp eq i64 %indvars.iv.11, 0
  %or.cond1.11 = or i1 %cmp62.11, %cmp65.11
  %cmp68.11 = icmp eq i64 %indvars.iv.11, %11
  %or.cond2.11 = or i1 %cmp68.11, %or.cond1.11
  br i1 %or.cond2.11, label %if.then70.11, label %if.else73.11

if.else73.11:                                     ; preds = %for.body56.11
  %arrayidx75.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %262
  %263 = load i32, i32* %arrayidx75.11, align 4
  %cmp76.11 = icmp eq i32 %263, 75
  br i1 %cmp76.11, label %if.then78.11, label %if.else153.11

if.else153.11:                                    ; preds = %if.else73.11
  %conv156.11 = trunc i32 %263 to i8
  %arrayidx158.11 = getelementptr inbounds i8, i8* %0, i64 %262
  store i8 %conv156.11, i8* %arrayidx158.11, align 1
  br label %for.inc161.11

if.then78.11:                                     ; preds = %if.else73.11
  %264 = trunc i64 %indvars.iv.11 to i32
  %sub81.11 = add i32 %264, %sub79.11
  %add82.11 = add i32 %sub81.11, -129
  %idxprom83.11 = sext i32 %add82.11 to i64
  %arrayidx84.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.11
  %265 = load i32, i32* %arrayidx84.11, align 4
  %cmp85.11 = icmp eq i32 %265, 255
  br i1 %cmp85.11, label %if.then146.11, label %lor.lhs.false87.11

lor.lhs.false87.11:                               ; preds = %if.then78.11
  %266 = add nsw i64 %261, %indvars.iv.11
  %arrayidx92.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %266
  %267 = load i32, i32* %arrayidx92.11, align 4
  %cmp93.11 = icmp eq i32 %267, 255
  br i1 %cmp93.11, label %if.then146.11, label %lor.lhs.false95.11

lor.lhs.false95.11:                               ; preds = %lor.lhs.false87.11
  %add99.11 = add i32 %sub81.11, -127
  %idxprom100.11 = sext i32 %add99.11 to i64
  %arrayidx101.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.11
  %268 = load i32, i32* %arrayidx101.11, align 4
  %cmp102.11 = icmp eq i32 %268, 255
  br i1 %cmp102.11, label %if.then146.11, label %lor.lhs.false104.11

lor.lhs.false104.11:                              ; preds = %lor.lhs.false95.11
  %269 = trunc i64 %indvars.iv.11 to i32
  %add107.11 = add i32 %sub106.11, %269
  %idxprom108.11 = sext i32 %add107.11 to i64
  %arrayidx109.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.11
  %270 = load i32, i32* %arrayidx109.11, align 4
  %cmp110.11 = icmp eq i32 %270, 255
  br i1 %cmp110.11, label %if.then146.11, label %lor.lhs.false112.11

lor.lhs.false112.11:                              ; preds = %lor.lhs.false104.11
  %271 = trunc i64 %indvars.iv.11 to i32
  %add115.11 = add i32 %add114.11, %271
  %idxprom116.11 = sext i32 %add115.11 to i64
  %arrayidx117.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.11
  %272 = load i32, i32* %arrayidx117.11, align 4
  %cmp118.11 = icmp eq i32 %272, 255
  br i1 %cmp118.11, label %if.then146.11, label %lor.lhs.false120.11

lor.lhs.false120.11:                              ; preds = %lor.lhs.false112.11
  %add124.11 = add i32 %sub81.11, 127
  %idxprom125.11 = sext i32 %add124.11 to i64
  %arrayidx126.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.11
  %273 = load i32, i32* %arrayidx126.11, align 4
  %cmp127.11 = icmp eq i32 %273, 255
  br i1 %cmp127.11, label %if.then146.11, label %lor.lhs.false129.11

lor.lhs.false129.11:                              ; preds = %lor.lhs.false120.11
  %274 = add nsw i64 %260, %indvars.iv.11
  %arrayidx134.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %274
  %275 = load i32, i32* %arrayidx134.11, align 4
  %cmp135.11 = icmp eq i32 %275, 255
  br i1 %cmp135.11, label %if.then146.11, label %lor.lhs.false137.11

lor.lhs.false137.11:                              ; preds = %lor.lhs.false129.11
  %add141.11 = add i32 %sub81.11, 129
  %idxprom142.11 = sext i32 %add141.11 to i64
  %arrayidx143.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.11
  %276 = load i32, i32* %arrayidx143.11, align 4
  %cmp144.11 = icmp eq i32 %276, 255
  br i1 %cmp144.11, label %if.then146.11, label %if.else149.11

if.else149.11:                                    ; preds = %lor.lhs.false137.11
  %arrayidx151.11 = getelementptr inbounds i8, i8* %0, i64 %262
  store i8 0, i8* %arrayidx151.11, align 1
  br label %for.inc161.11

if.then146.11:                                    ; preds = %lor.lhs.false137.11, %lor.lhs.false129.11, %lor.lhs.false120.11, %lor.lhs.false112.11, %lor.lhs.false104.11, %lor.lhs.false95.11, %lor.lhs.false87.11, %if.then78.11
  %arrayidx148.11 = getelementptr inbounds i8, i8* %0, i64 %262
  store i8 -1, i8* %arrayidx148.11, align 1
  br label %for.inc161.11

if.then70.11:                                     ; preds = %for.body56.11
  %arrayidx72.11 = getelementptr inbounds i8, i8* %0, i64 %262
  store i8 0, i8* %arrayidx72.11, align 1
  br label %for.inc161.11

for.inc161.11:                                    ; preds = %if.then70.11, %if.then146.11, %if.else149.11, %if.else153.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %img_width
  br i1 %exitcond.11, label %for.inc164.11, label %for.body56.11, !llvm.loop !5

for.inc164.11:                                    ; preds = %for.inc161.11
  %indvars.iv.next20.11 = add nsw i64 %indvars.iv19, 12
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.12

for.body56.lr.ph.12:                              ; preds = %for.inc164.11
  %277 = trunc i64 %indvars.iv.next20.11 to i32
  %mul58.12 = shl nsw i32 %277, 7
  %cmp62.12 = icmp eq i64 %indvars.iv.next20.11, %12
  %278 = trunc i64 %indvars.iv.next20.11 to i32
  %sub79.12 = shl i32 %278, 7
  %mul89.12 = add i32 %sub79.12, -128
  %sub106.12 = add i32 %mul58.12, -1
  %add114.12 = or i32 %mul58.12, 1
  %mul131.12 = add i32 %sub79.12, 128
  %279 = sext i32 %mul58.12 to i64
  %280 = sext i32 %mul131.12 to i64
  %281 = sext i32 %mul89.12 to i64
  br label %for.body56.12

for.body56.12:                                    ; preds = %for.inc161.12, %for.body56.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body56.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc161.12 ]
  %282 = add nsw i64 %indvars.iv.12, %279
  %cmp65.12 = icmp eq i64 %indvars.iv.12, 0
  %or.cond1.12 = or i1 %cmp62.12, %cmp65.12
  %cmp68.12 = icmp eq i64 %indvars.iv.12, %11
  %or.cond2.12 = or i1 %cmp68.12, %or.cond1.12
  br i1 %or.cond2.12, label %if.then70.12, label %if.else73.12

if.else73.12:                                     ; preds = %for.body56.12
  %arrayidx75.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %282
  %283 = load i32, i32* %arrayidx75.12, align 4
  %cmp76.12 = icmp eq i32 %283, 75
  br i1 %cmp76.12, label %if.then78.12, label %if.else153.12

if.else153.12:                                    ; preds = %if.else73.12
  %conv156.12 = trunc i32 %283 to i8
  %arrayidx158.12 = getelementptr inbounds i8, i8* %0, i64 %282
  store i8 %conv156.12, i8* %arrayidx158.12, align 1
  br label %for.inc161.12

if.then78.12:                                     ; preds = %if.else73.12
  %284 = trunc i64 %indvars.iv.12 to i32
  %sub81.12 = add i32 %284, %sub79.12
  %add82.12 = add i32 %sub81.12, -129
  %idxprom83.12 = sext i32 %add82.12 to i64
  %arrayidx84.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.12
  %285 = load i32, i32* %arrayidx84.12, align 4
  %cmp85.12 = icmp eq i32 %285, 255
  br i1 %cmp85.12, label %if.then146.12, label %lor.lhs.false87.12

lor.lhs.false87.12:                               ; preds = %if.then78.12
  %286 = add nsw i64 %281, %indvars.iv.12
  %arrayidx92.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %286
  %287 = load i32, i32* %arrayidx92.12, align 4
  %cmp93.12 = icmp eq i32 %287, 255
  br i1 %cmp93.12, label %if.then146.12, label %lor.lhs.false95.12

lor.lhs.false95.12:                               ; preds = %lor.lhs.false87.12
  %add99.12 = add i32 %sub81.12, -127
  %idxprom100.12 = sext i32 %add99.12 to i64
  %arrayidx101.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.12
  %288 = load i32, i32* %arrayidx101.12, align 4
  %cmp102.12 = icmp eq i32 %288, 255
  br i1 %cmp102.12, label %if.then146.12, label %lor.lhs.false104.12

lor.lhs.false104.12:                              ; preds = %lor.lhs.false95.12
  %289 = trunc i64 %indvars.iv.12 to i32
  %add107.12 = add i32 %sub106.12, %289
  %idxprom108.12 = sext i32 %add107.12 to i64
  %arrayidx109.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.12
  %290 = load i32, i32* %arrayidx109.12, align 4
  %cmp110.12 = icmp eq i32 %290, 255
  br i1 %cmp110.12, label %if.then146.12, label %lor.lhs.false112.12

lor.lhs.false112.12:                              ; preds = %lor.lhs.false104.12
  %291 = trunc i64 %indvars.iv.12 to i32
  %add115.12 = add i32 %add114.12, %291
  %idxprom116.12 = sext i32 %add115.12 to i64
  %arrayidx117.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.12
  %292 = load i32, i32* %arrayidx117.12, align 4
  %cmp118.12 = icmp eq i32 %292, 255
  br i1 %cmp118.12, label %if.then146.12, label %lor.lhs.false120.12

lor.lhs.false120.12:                              ; preds = %lor.lhs.false112.12
  %add124.12 = add i32 %sub81.12, 127
  %idxprom125.12 = sext i32 %add124.12 to i64
  %arrayidx126.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.12
  %293 = load i32, i32* %arrayidx126.12, align 4
  %cmp127.12 = icmp eq i32 %293, 255
  br i1 %cmp127.12, label %if.then146.12, label %lor.lhs.false129.12

lor.lhs.false129.12:                              ; preds = %lor.lhs.false120.12
  %294 = add nsw i64 %280, %indvars.iv.12
  %arrayidx134.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %294
  %295 = load i32, i32* %arrayidx134.12, align 4
  %cmp135.12 = icmp eq i32 %295, 255
  br i1 %cmp135.12, label %if.then146.12, label %lor.lhs.false137.12

lor.lhs.false137.12:                              ; preds = %lor.lhs.false129.12
  %add141.12 = add i32 %sub81.12, 129
  %idxprom142.12 = sext i32 %add141.12 to i64
  %arrayidx143.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.12
  %296 = load i32, i32* %arrayidx143.12, align 4
  %cmp144.12 = icmp eq i32 %296, 255
  br i1 %cmp144.12, label %if.then146.12, label %if.else149.12

if.else149.12:                                    ; preds = %lor.lhs.false137.12
  %arrayidx151.12 = getelementptr inbounds i8, i8* %0, i64 %282
  store i8 0, i8* %arrayidx151.12, align 1
  br label %for.inc161.12

if.then146.12:                                    ; preds = %lor.lhs.false137.12, %lor.lhs.false129.12, %lor.lhs.false120.12, %lor.lhs.false112.12, %lor.lhs.false104.12, %lor.lhs.false95.12, %lor.lhs.false87.12, %if.then78.12
  %arrayidx148.12 = getelementptr inbounds i8, i8* %0, i64 %282
  store i8 -1, i8* %arrayidx148.12, align 1
  br label %for.inc161.12

if.then70.12:                                     ; preds = %for.body56.12
  %arrayidx72.12 = getelementptr inbounds i8, i8* %0, i64 %282
  store i8 0, i8* %arrayidx72.12, align 1
  br label %for.inc161.12

for.inc161.12:                                    ; preds = %if.then70.12, %if.then146.12, %if.else149.12, %if.else153.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %img_width
  br i1 %exitcond.12, label %for.inc164.12, label %for.body56.12, !llvm.loop !5

for.inc164.12:                                    ; preds = %for.inc161.12
  %indvars.iv.next20.12 = add nsw i64 %indvars.iv19, 13
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.13

for.body56.lr.ph.13:                              ; preds = %for.inc164.12
  %297 = trunc i64 %indvars.iv.next20.12 to i32
  %mul58.13 = shl nsw i32 %297, 7
  %cmp62.13 = icmp eq i64 %indvars.iv.next20.12, %12
  %298 = trunc i64 %indvars.iv.next20.12 to i32
  %sub79.13 = shl i32 %298, 7
  %mul89.13 = add i32 %sub79.13, -128
  %sub106.13 = add i32 %mul58.13, -1
  %add114.13 = or i32 %mul58.13, 1
  %mul131.13 = add i32 %sub79.13, 128
  %299 = sext i32 %mul58.13 to i64
  %300 = sext i32 %mul131.13 to i64
  %301 = sext i32 %mul89.13 to i64
  br label %for.body56.13

for.body56.13:                                    ; preds = %for.inc161.13, %for.body56.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body56.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc161.13 ]
  %302 = add nsw i64 %indvars.iv.13, %299
  %cmp65.13 = icmp eq i64 %indvars.iv.13, 0
  %or.cond1.13 = or i1 %cmp62.13, %cmp65.13
  %cmp68.13 = icmp eq i64 %indvars.iv.13, %11
  %or.cond2.13 = or i1 %cmp68.13, %or.cond1.13
  br i1 %or.cond2.13, label %if.then70.13, label %if.else73.13

if.else73.13:                                     ; preds = %for.body56.13
  %arrayidx75.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %302
  %303 = load i32, i32* %arrayidx75.13, align 4
  %cmp76.13 = icmp eq i32 %303, 75
  br i1 %cmp76.13, label %if.then78.13, label %if.else153.13

if.else153.13:                                    ; preds = %if.else73.13
  %conv156.13 = trunc i32 %303 to i8
  %arrayidx158.13 = getelementptr inbounds i8, i8* %0, i64 %302
  store i8 %conv156.13, i8* %arrayidx158.13, align 1
  br label %for.inc161.13

if.then78.13:                                     ; preds = %if.else73.13
  %304 = trunc i64 %indvars.iv.13 to i32
  %sub81.13 = add i32 %304, %sub79.13
  %add82.13 = add i32 %sub81.13, -129
  %idxprom83.13 = sext i32 %add82.13 to i64
  %arrayidx84.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.13
  %305 = load i32, i32* %arrayidx84.13, align 4
  %cmp85.13 = icmp eq i32 %305, 255
  br i1 %cmp85.13, label %if.then146.13, label %lor.lhs.false87.13

lor.lhs.false87.13:                               ; preds = %if.then78.13
  %306 = add nsw i64 %301, %indvars.iv.13
  %arrayidx92.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %306
  %307 = load i32, i32* %arrayidx92.13, align 4
  %cmp93.13 = icmp eq i32 %307, 255
  br i1 %cmp93.13, label %if.then146.13, label %lor.lhs.false95.13

lor.lhs.false95.13:                               ; preds = %lor.lhs.false87.13
  %add99.13 = add i32 %sub81.13, -127
  %idxprom100.13 = sext i32 %add99.13 to i64
  %arrayidx101.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.13
  %308 = load i32, i32* %arrayidx101.13, align 4
  %cmp102.13 = icmp eq i32 %308, 255
  br i1 %cmp102.13, label %if.then146.13, label %lor.lhs.false104.13

lor.lhs.false104.13:                              ; preds = %lor.lhs.false95.13
  %309 = trunc i64 %indvars.iv.13 to i32
  %add107.13 = add i32 %sub106.13, %309
  %idxprom108.13 = sext i32 %add107.13 to i64
  %arrayidx109.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.13
  %310 = load i32, i32* %arrayidx109.13, align 4
  %cmp110.13 = icmp eq i32 %310, 255
  br i1 %cmp110.13, label %if.then146.13, label %lor.lhs.false112.13

lor.lhs.false112.13:                              ; preds = %lor.lhs.false104.13
  %311 = trunc i64 %indvars.iv.13 to i32
  %add115.13 = add i32 %add114.13, %311
  %idxprom116.13 = sext i32 %add115.13 to i64
  %arrayidx117.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.13
  %312 = load i32, i32* %arrayidx117.13, align 4
  %cmp118.13 = icmp eq i32 %312, 255
  br i1 %cmp118.13, label %if.then146.13, label %lor.lhs.false120.13

lor.lhs.false120.13:                              ; preds = %lor.lhs.false112.13
  %add124.13 = add i32 %sub81.13, 127
  %idxprom125.13 = sext i32 %add124.13 to i64
  %arrayidx126.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.13
  %313 = load i32, i32* %arrayidx126.13, align 4
  %cmp127.13 = icmp eq i32 %313, 255
  br i1 %cmp127.13, label %if.then146.13, label %lor.lhs.false129.13

lor.lhs.false129.13:                              ; preds = %lor.lhs.false120.13
  %314 = add nsw i64 %300, %indvars.iv.13
  %arrayidx134.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %314
  %315 = load i32, i32* %arrayidx134.13, align 4
  %cmp135.13 = icmp eq i32 %315, 255
  br i1 %cmp135.13, label %if.then146.13, label %lor.lhs.false137.13

lor.lhs.false137.13:                              ; preds = %lor.lhs.false129.13
  %add141.13 = add i32 %sub81.13, 129
  %idxprom142.13 = sext i32 %add141.13 to i64
  %arrayidx143.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.13
  %316 = load i32, i32* %arrayidx143.13, align 4
  %cmp144.13 = icmp eq i32 %316, 255
  br i1 %cmp144.13, label %if.then146.13, label %if.else149.13

if.else149.13:                                    ; preds = %lor.lhs.false137.13
  %arrayidx151.13 = getelementptr inbounds i8, i8* %0, i64 %302
  store i8 0, i8* %arrayidx151.13, align 1
  br label %for.inc161.13

if.then146.13:                                    ; preds = %lor.lhs.false137.13, %lor.lhs.false129.13, %lor.lhs.false120.13, %lor.lhs.false112.13, %lor.lhs.false104.13, %lor.lhs.false95.13, %lor.lhs.false87.13, %if.then78.13
  %arrayidx148.13 = getelementptr inbounds i8, i8* %0, i64 %302
  store i8 -1, i8* %arrayidx148.13, align 1
  br label %for.inc161.13

if.then70.13:                                     ; preds = %for.body56.13
  %arrayidx72.13 = getelementptr inbounds i8, i8* %0, i64 %302
  store i8 0, i8* %arrayidx72.13, align 1
  br label %for.inc161.13

for.inc161.13:                                    ; preds = %if.then70.13, %if.then146.13, %if.else149.13, %if.else153.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %img_width
  br i1 %exitcond.13, label %for.inc164.13, label %for.body56.13, !llvm.loop !5

for.inc164.13:                                    ; preds = %for.inc161.13
  %indvars.iv.next20.13 = add nsw i64 %indvars.iv19, 14
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.14

for.body56.lr.ph.14:                              ; preds = %for.inc164.13
  %317 = trunc i64 %indvars.iv.next20.13 to i32
  %mul58.14 = shl nsw i32 %317, 7
  %cmp62.14 = icmp eq i64 %indvars.iv.next20.13, %12
  %318 = trunc i64 %indvars.iv.next20.13 to i32
  %sub79.14 = shl i32 %318, 7
  %mul89.14 = add i32 %sub79.14, -128
  %sub106.14 = add i32 %mul58.14, -1
  %add114.14 = or i32 %mul58.14, 1
  %mul131.14 = add i32 %sub79.14, 128
  %319 = sext i32 %mul58.14 to i64
  %320 = sext i32 %mul131.14 to i64
  %321 = sext i32 %mul89.14 to i64
  br label %for.body56.14

for.body56.14:                                    ; preds = %for.inc161.14, %for.body56.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body56.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc161.14 ]
  %322 = add nsw i64 %indvars.iv.14, %319
  %cmp65.14 = icmp eq i64 %indvars.iv.14, 0
  %or.cond1.14 = or i1 %cmp62.14, %cmp65.14
  %cmp68.14 = icmp eq i64 %indvars.iv.14, %11
  %or.cond2.14 = or i1 %cmp68.14, %or.cond1.14
  br i1 %or.cond2.14, label %if.then70.14, label %if.else73.14

if.else73.14:                                     ; preds = %for.body56.14
  %arrayidx75.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %322
  %323 = load i32, i32* %arrayidx75.14, align 4
  %cmp76.14 = icmp eq i32 %323, 75
  br i1 %cmp76.14, label %if.then78.14, label %if.else153.14

if.else153.14:                                    ; preds = %if.else73.14
  %conv156.14 = trunc i32 %323 to i8
  %arrayidx158.14 = getelementptr inbounds i8, i8* %0, i64 %322
  store i8 %conv156.14, i8* %arrayidx158.14, align 1
  br label %for.inc161.14

if.then78.14:                                     ; preds = %if.else73.14
  %324 = trunc i64 %indvars.iv.14 to i32
  %sub81.14 = add i32 %324, %sub79.14
  %add82.14 = add i32 %sub81.14, -129
  %idxprom83.14 = sext i32 %add82.14 to i64
  %arrayidx84.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.14
  %325 = load i32, i32* %arrayidx84.14, align 4
  %cmp85.14 = icmp eq i32 %325, 255
  br i1 %cmp85.14, label %if.then146.14, label %lor.lhs.false87.14

lor.lhs.false87.14:                               ; preds = %if.then78.14
  %326 = add nsw i64 %321, %indvars.iv.14
  %arrayidx92.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %326
  %327 = load i32, i32* %arrayidx92.14, align 4
  %cmp93.14 = icmp eq i32 %327, 255
  br i1 %cmp93.14, label %if.then146.14, label %lor.lhs.false95.14

lor.lhs.false95.14:                               ; preds = %lor.lhs.false87.14
  %add99.14 = add i32 %sub81.14, -127
  %idxprom100.14 = sext i32 %add99.14 to i64
  %arrayidx101.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.14
  %328 = load i32, i32* %arrayidx101.14, align 4
  %cmp102.14 = icmp eq i32 %328, 255
  br i1 %cmp102.14, label %if.then146.14, label %lor.lhs.false104.14

lor.lhs.false104.14:                              ; preds = %lor.lhs.false95.14
  %329 = trunc i64 %indvars.iv.14 to i32
  %add107.14 = add i32 %sub106.14, %329
  %idxprom108.14 = sext i32 %add107.14 to i64
  %arrayidx109.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.14
  %330 = load i32, i32* %arrayidx109.14, align 4
  %cmp110.14 = icmp eq i32 %330, 255
  br i1 %cmp110.14, label %if.then146.14, label %lor.lhs.false112.14

lor.lhs.false112.14:                              ; preds = %lor.lhs.false104.14
  %331 = trunc i64 %indvars.iv.14 to i32
  %add115.14 = add i32 %add114.14, %331
  %idxprom116.14 = sext i32 %add115.14 to i64
  %arrayidx117.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.14
  %332 = load i32, i32* %arrayidx117.14, align 4
  %cmp118.14 = icmp eq i32 %332, 255
  br i1 %cmp118.14, label %if.then146.14, label %lor.lhs.false120.14

lor.lhs.false120.14:                              ; preds = %lor.lhs.false112.14
  %add124.14 = add i32 %sub81.14, 127
  %idxprom125.14 = sext i32 %add124.14 to i64
  %arrayidx126.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.14
  %333 = load i32, i32* %arrayidx126.14, align 4
  %cmp127.14 = icmp eq i32 %333, 255
  br i1 %cmp127.14, label %if.then146.14, label %lor.lhs.false129.14

lor.lhs.false129.14:                              ; preds = %lor.lhs.false120.14
  %334 = add nsw i64 %320, %indvars.iv.14
  %arrayidx134.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %334
  %335 = load i32, i32* %arrayidx134.14, align 4
  %cmp135.14 = icmp eq i32 %335, 255
  br i1 %cmp135.14, label %if.then146.14, label %lor.lhs.false137.14

lor.lhs.false137.14:                              ; preds = %lor.lhs.false129.14
  %add141.14 = add i32 %sub81.14, 129
  %idxprom142.14 = sext i32 %add141.14 to i64
  %arrayidx143.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.14
  %336 = load i32, i32* %arrayidx143.14, align 4
  %cmp144.14 = icmp eq i32 %336, 255
  br i1 %cmp144.14, label %if.then146.14, label %if.else149.14

if.else149.14:                                    ; preds = %lor.lhs.false137.14
  %arrayidx151.14 = getelementptr inbounds i8, i8* %0, i64 %322
  store i8 0, i8* %arrayidx151.14, align 1
  br label %for.inc161.14

if.then146.14:                                    ; preds = %lor.lhs.false137.14, %lor.lhs.false129.14, %lor.lhs.false120.14, %lor.lhs.false112.14, %lor.lhs.false104.14, %lor.lhs.false95.14, %lor.lhs.false87.14, %if.then78.14
  %arrayidx148.14 = getelementptr inbounds i8, i8* %0, i64 %322
  store i8 -1, i8* %arrayidx148.14, align 1
  br label %for.inc161.14

if.then70.14:                                     ; preds = %for.body56.14
  %arrayidx72.14 = getelementptr inbounds i8, i8* %0, i64 %322
  store i8 0, i8* %arrayidx72.14, align 1
  br label %for.inc161.14

for.inc161.14:                                    ; preds = %if.then70.14, %if.then146.14, %if.else149.14, %if.else153.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %img_width
  br i1 %exitcond.14, label %for.inc164.14, label %for.body56.14, !llvm.loop !5

for.inc164.14:                                    ; preds = %for.inc161.14
  %indvars.iv.next20.14 = add nsw i64 %indvars.iv19, 15
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.15

for.body56.lr.ph.15:                              ; preds = %for.inc164.14
  %337 = trunc i64 %indvars.iv.next20.14 to i32
  %mul58.15 = shl nsw i32 %337, 7
  %cmp62.15 = icmp eq i64 %indvars.iv.next20.14, %12
  %338 = trunc i64 %indvars.iv.next20.14 to i32
  %sub79.15 = shl i32 %338, 7
  %mul89.15 = add i32 %sub79.15, -128
  %sub106.15 = add i32 %mul58.15, -1
  %add114.15 = or i32 %mul58.15, 1
  %mul131.15 = add i32 %sub79.15, 128
  %339 = sext i32 %mul58.15 to i64
  %340 = sext i32 %mul131.15 to i64
  %341 = sext i32 %mul89.15 to i64
  br label %for.body56.15

for.body56.15:                                    ; preds = %for.inc161.15, %for.body56.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body56.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc161.15 ]
  %342 = add nsw i64 %indvars.iv.15, %339
  %cmp65.15 = icmp eq i64 %indvars.iv.15, 0
  %or.cond1.15 = or i1 %cmp62.15, %cmp65.15
  %cmp68.15 = icmp eq i64 %indvars.iv.15, %11
  %or.cond2.15 = or i1 %cmp68.15, %or.cond1.15
  br i1 %or.cond2.15, label %if.then70.15, label %if.else73.15

if.else73.15:                                     ; preds = %for.body56.15
  %arrayidx75.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %342
  %343 = load i32, i32* %arrayidx75.15, align 4
  %cmp76.15 = icmp eq i32 %343, 75
  br i1 %cmp76.15, label %if.then78.15, label %if.else153.15

if.else153.15:                                    ; preds = %if.else73.15
  %conv156.15 = trunc i32 %343 to i8
  %arrayidx158.15 = getelementptr inbounds i8, i8* %0, i64 %342
  store i8 %conv156.15, i8* %arrayidx158.15, align 1
  br label %for.inc161.15

if.then78.15:                                     ; preds = %if.else73.15
  %344 = trunc i64 %indvars.iv.15 to i32
  %sub81.15 = add i32 %344, %sub79.15
  %add82.15 = add i32 %sub81.15, -129
  %idxprom83.15 = sext i32 %add82.15 to i64
  %arrayidx84.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.15
  %345 = load i32, i32* %arrayidx84.15, align 4
  %cmp85.15 = icmp eq i32 %345, 255
  br i1 %cmp85.15, label %if.then146.15, label %lor.lhs.false87.15

lor.lhs.false87.15:                               ; preds = %if.then78.15
  %346 = add nsw i64 %341, %indvars.iv.15
  %arrayidx92.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %346
  %347 = load i32, i32* %arrayidx92.15, align 4
  %cmp93.15 = icmp eq i32 %347, 255
  br i1 %cmp93.15, label %if.then146.15, label %lor.lhs.false95.15

lor.lhs.false95.15:                               ; preds = %lor.lhs.false87.15
  %add99.15 = add i32 %sub81.15, -127
  %idxprom100.15 = sext i32 %add99.15 to i64
  %arrayidx101.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.15
  %348 = load i32, i32* %arrayidx101.15, align 4
  %cmp102.15 = icmp eq i32 %348, 255
  br i1 %cmp102.15, label %if.then146.15, label %lor.lhs.false104.15

lor.lhs.false104.15:                              ; preds = %lor.lhs.false95.15
  %349 = trunc i64 %indvars.iv.15 to i32
  %add107.15 = add i32 %sub106.15, %349
  %idxprom108.15 = sext i32 %add107.15 to i64
  %arrayidx109.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.15
  %350 = load i32, i32* %arrayidx109.15, align 4
  %cmp110.15 = icmp eq i32 %350, 255
  br i1 %cmp110.15, label %if.then146.15, label %lor.lhs.false112.15

lor.lhs.false112.15:                              ; preds = %lor.lhs.false104.15
  %351 = trunc i64 %indvars.iv.15 to i32
  %add115.15 = add i32 %add114.15, %351
  %idxprom116.15 = sext i32 %add115.15 to i64
  %arrayidx117.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.15
  %352 = load i32, i32* %arrayidx117.15, align 4
  %cmp118.15 = icmp eq i32 %352, 255
  br i1 %cmp118.15, label %if.then146.15, label %lor.lhs.false120.15

lor.lhs.false120.15:                              ; preds = %lor.lhs.false112.15
  %add124.15 = add i32 %sub81.15, 127
  %idxprom125.15 = sext i32 %add124.15 to i64
  %arrayidx126.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.15
  %353 = load i32, i32* %arrayidx126.15, align 4
  %cmp127.15 = icmp eq i32 %353, 255
  br i1 %cmp127.15, label %if.then146.15, label %lor.lhs.false129.15

lor.lhs.false129.15:                              ; preds = %lor.lhs.false120.15
  %354 = add nsw i64 %340, %indvars.iv.15
  %arrayidx134.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %354
  %355 = load i32, i32* %arrayidx134.15, align 4
  %cmp135.15 = icmp eq i32 %355, 255
  br i1 %cmp135.15, label %if.then146.15, label %lor.lhs.false137.15

lor.lhs.false137.15:                              ; preds = %lor.lhs.false129.15
  %add141.15 = add i32 %sub81.15, 129
  %idxprom142.15 = sext i32 %add141.15 to i64
  %arrayidx143.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.15
  %356 = load i32, i32* %arrayidx143.15, align 4
  %cmp144.15 = icmp eq i32 %356, 255
  br i1 %cmp144.15, label %if.then146.15, label %if.else149.15

if.else149.15:                                    ; preds = %lor.lhs.false137.15
  %arrayidx151.15 = getelementptr inbounds i8, i8* %0, i64 %342
  store i8 0, i8* %arrayidx151.15, align 1
  br label %for.inc161.15

if.then146.15:                                    ; preds = %lor.lhs.false137.15, %lor.lhs.false129.15, %lor.lhs.false120.15, %lor.lhs.false112.15, %lor.lhs.false104.15, %lor.lhs.false95.15, %lor.lhs.false87.15, %if.then78.15
  %arrayidx148.15 = getelementptr inbounds i8, i8* %0, i64 %342
  store i8 -1, i8* %arrayidx148.15, align 1
  br label %for.inc161.15

if.then70.15:                                     ; preds = %for.body56.15
  %arrayidx72.15 = getelementptr inbounds i8, i8* %0, i64 %342
  store i8 0, i8* %arrayidx72.15, align 1
  br label %for.inc161.15

for.inc161.15:                                    ; preds = %if.then70.15, %if.then146.15, %if.else149.15, %if.else153.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %img_width
  br i1 %exitcond.15, label %for.inc164.15, label %for.body56.15, !llvm.loop !5

for.inc164.15:                                    ; preds = %for.inc161.15
  %indvars.iv.next20.15 = add nsw i64 %indvars.iv19, 16
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.16

for.body56.lr.ph.16:                              ; preds = %for.inc164.15
  %357 = trunc i64 %indvars.iv.next20.15 to i32
  %mul58.16 = shl nsw i32 %357, 7
  %cmp62.16 = icmp eq i64 %indvars.iv.next20.15, %12
  %358 = trunc i64 %indvars.iv.next20.15 to i32
  %sub79.16 = shl i32 %358, 7
  %mul89.16 = add i32 %sub79.16, -128
  %sub106.16 = add i32 %mul58.16, -1
  %add114.16 = or i32 %mul58.16, 1
  %mul131.16 = add i32 %sub79.16, 128
  %359 = sext i32 %mul58.16 to i64
  %360 = sext i32 %mul131.16 to i64
  %361 = sext i32 %mul89.16 to i64
  br label %for.body56.16

for.body56.16:                                    ; preds = %for.inc161.16, %for.body56.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body56.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc161.16 ]
  %362 = add nsw i64 %indvars.iv.16, %359
  %cmp65.16 = icmp eq i64 %indvars.iv.16, 0
  %or.cond1.16 = or i1 %cmp62.16, %cmp65.16
  %cmp68.16 = icmp eq i64 %indvars.iv.16, %11
  %or.cond2.16 = or i1 %cmp68.16, %or.cond1.16
  br i1 %or.cond2.16, label %if.then70.16, label %if.else73.16

if.else73.16:                                     ; preds = %for.body56.16
  %arrayidx75.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %362
  %363 = load i32, i32* %arrayidx75.16, align 4
  %cmp76.16 = icmp eq i32 %363, 75
  br i1 %cmp76.16, label %if.then78.16, label %if.else153.16

if.else153.16:                                    ; preds = %if.else73.16
  %conv156.16 = trunc i32 %363 to i8
  %arrayidx158.16 = getelementptr inbounds i8, i8* %0, i64 %362
  store i8 %conv156.16, i8* %arrayidx158.16, align 1
  br label %for.inc161.16

if.then78.16:                                     ; preds = %if.else73.16
  %364 = trunc i64 %indvars.iv.16 to i32
  %sub81.16 = add i32 %364, %sub79.16
  %add82.16 = add i32 %sub81.16, -129
  %idxprom83.16 = sext i32 %add82.16 to i64
  %arrayidx84.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.16
  %365 = load i32, i32* %arrayidx84.16, align 4
  %cmp85.16 = icmp eq i32 %365, 255
  br i1 %cmp85.16, label %if.then146.16, label %lor.lhs.false87.16

lor.lhs.false87.16:                               ; preds = %if.then78.16
  %366 = add nsw i64 %361, %indvars.iv.16
  %arrayidx92.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %366
  %367 = load i32, i32* %arrayidx92.16, align 4
  %cmp93.16 = icmp eq i32 %367, 255
  br i1 %cmp93.16, label %if.then146.16, label %lor.lhs.false95.16

lor.lhs.false95.16:                               ; preds = %lor.lhs.false87.16
  %add99.16 = add i32 %sub81.16, -127
  %idxprom100.16 = sext i32 %add99.16 to i64
  %arrayidx101.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.16
  %368 = load i32, i32* %arrayidx101.16, align 4
  %cmp102.16 = icmp eq i32 %368, 255
  br i1 %cmp102.16, label %if.then146.16, label %lor.lhs.false104.16

lor.lhs.false104.16:                              ; preds = %lor.lhs.false95.16
  %369 = trunc i64 %indvars.iv.16 to i32
  %add107.16 = add i32 %sub106.16, %369
  %idxprom108.16 = sext i32 %add107.16 to i64
  %arrayidx109.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.16
  %370 = load i32, i32* %arrayidx109.16, align 4
  %cmp110.16 = icmp eq i32 %370, 255
  br i1 %cmp110.16, label %if.then146.16, label %lor.lhs.false112.16

lor.lhs.false112.16:                              ; preds = %lor.lhs.false104.16
  %371 = trunc i64 %indvars.iv.16 to i32
  %add115.16 = add i32 %add114.16, %371
  %idxprom116.16 = sext i32 %add115.16 to i64
  %arrayidx117.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.16
  %372 = load i32, i32* %arrayidx117.16, align 4
  %cmp118.16 = icmp eq i32 %372, 255
  br i1 %cmp118.16, label %if.then146.16, label %lor.lhs.false120.16

lor.lhs.false120.16:                              ; preds = %lor.lhs.false112.16
  %add124.16 = add i32 %sub81.16, 127
  %idxprom125.16 = sext i32 %add124.16 to i64
  %arrayidx126.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.16
  %373 = load i32, i32* %arrayidx126.16, align 4
  %cmp127.16 = icmp eq i32 %373, 255
  br i1 %cmp127.16, label %if.then146.16, label %lor.lhs.false129.16

lor.lhs.false129.16:                              ; preds = %lor.lhs.false120.16
  %374 = add nsw i64 %360, %indvars.iv.16
  %arrayidx134.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %374
  %375 = load i32, i32* %arrayidx134.16, align 4
  %cmp135.16 = icmp eq i32 %375, 255
  br i1 %cmp135.16, label %if.then146.16, label %lor.lhs.false137.16

lor.lhs.false137.16:                              ; preds = %lor.lhs.false129.16
  %add141.16 = add i32 %sub81.16, 129
  %idxprom142.16 = sext i32 %add141.16 to i64
  %arrayidx143.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.16
  %376 = load i32, i32* %arrayidx143.16, align 4
  %cmp144.16 = icmp eq i32 %376, 255
  br i1 %cmp144.16, label %if.then146.16, label %if.else149.16

if.else149.16:                                    ; preds = %lor.lhs.false137.16
  %arrayidx151.16 = getelementptr inbounds i8, i8* %0, i64 %362
  store i8 0, i8* %arrayidx151.16, align 1
  br label %for.inc161.16

if.then146.16:                                    ; preds = %lor.lhs.false137.16, %lor.lhs.false129.16, %lor.lhs.false120.16, %lor.lhs.false112.16, %lor.lhs.false104.16, %lor.lhs.false95.16, %lor.lhs.false87.16, %if.then78.16
  %arrayidx148.16 = getelementptr inbounds i8, i8* %0, i64 %362
  store i8 -1, i8* %arrayidx148.16, align 1
  br label %for.inc161.16

if.then70.16:                                     ; preds = %for.body56.16
  %arrayidx72.16 = getelementptr inbounds i8, i8* %0, i64 %362
  store i8 0, i8* %arrayidx72.16, align 1
  br label %for.inc161.16

for.inc161.16:                                    ; preds = %if.then70.16, %if.then146.16, %if.else149.16, %if.else153.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %img_width
  br i1 %exitcond.16, label %for.inc164.16, label %for.body56.16, !llvm.loop !5

for.inc164.16:                                    ; preds = %for.inc161.16
  %indvars.iv.next20.16 = add nsw i64 %indvars.iv19, 17
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.17

for.body56.lr.ph.17:                              ; preds = %for.inc164.16
  %377 = trunc i64 %indvars.iv.next20.16 to i32
  %mul58.17 = shl nsw i32 %377, 7
  %cmp62.17 = icmp eq i64 %indvars.iv.next20.16, %12
  %378 = trunc i64 %indvars.iv.next20.16 to i32
  %sub79.17 = shl i32 %378, 7
  %mul89.17 = add i32 %sub79.17, -128
  %sub106.17 = add i32 %mul58.17, -1
  %add114.17 = or i32 %mul58.17, 1
  %mul131.17 = add i32 %sub79.17, 128
  %379 = sext i32 %mul58.17 to i64
  %380 = sext i32 %mul131.17 to i64
  %381 = sext i32 %mul89.17 to i64
  br label %for.body56.17

for.body56.17:                                    ; preds = %for.inc161.17, %for.body56.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body56.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc161.17 ]
  %382 = add nsw i64 %indvars.iv.17, %379
  %cmp65.17 = icmp eq i64 %indvars.iv.17, 0
  %or.cond1.17 = or i1 %cmp62.17, %cmp65.17
  %cmp68.17 = icmp eq i64 %indvars.iv.17, %11
  %or.cond2.17 = or i1 %cmp68.17, %or.cond1.17
  br i1 %or.cond2.17, label %if.then70.17, label %if.else73.17

if.else73.17:                                     ; preds = %for.body56.17
  %arrayidx75.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %382
  %383 = load i32, i32* %arrayidx75.17, align 4
  %cmp76.17 = icmp eq i32 %383, 75
  br i1 %cmp76.17, label %if.then78.17, label %if.else153.17

if.else153.17:                                    ; preds = %if.else73.17
  %conv156.17 = trunc i32 %383 to i8
  %arrayidx158.17 = getelementptr inbounds i8, i8* %0, i64 %382
  store i8 %conv156.17, i8* %arrayidx158.17, align 1
  br label %for.inc161.17

if.then78.17:                                     ; preds = %if.else73.17
  %384 = trunc i64 %indvars.iv.17 to i32
  %sub81.17 = add i32 %384, %sub79.17
  %add82.17 = add i32 %sub81.17, -129
  %idxprom83.17 = sext i32 %add82.17 to i64
  %arrayidx84.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.17
  %385 = load i32, i32* %arrayidx84.17, align 4
  %cmp85.17 = icmp eq i32 %385, 255
  br i1 %cmp85.17, label %if.then146.17, label %lor.lhs.false87.17

lor.lhs.false87.17:                               ; preds = %if.then78.17
  %386 = add nsw i64 %381, %indvars.iv.17
  %arrayidx92.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %386
  %387 = load i32, i32* %arrayidx92.17, align 4
  %cmp93.17 = icmp eq i32 %387, 255
  br i1 %cmp93.17, label %if.then146.17, label %lor.lhs.false95.17

lor.lhs.false95.17:                               ; preds = %lor.lhs.false87.17
  %add99.17 = add i32 %sub81.17, -127
  %idxprom100.17 = sext i32 %add99.17 to i64
  %arrayidx101.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.17
  %388 = load i32, i32* %arrayidx101.17, align 4
  %cmp102.17 = icmp eq i32 %388, 255
  br i1 %cmp102.17, label %if.then146.17, label %lor.lhs.false104.17

lor.lhs.false104.17:                              ; preds = %lor.lhs.false95.17
  %389 = trunc i64 %indvars.iv.17 to i32
  %add107.17 = add i32 %sub106.17, %389
  %idxprom108.17 = sext i32 %add107.17 to i64
  %arrayidx109.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.17
  %390 = load i32, i32* %arrayidx109.17, align 4
  %cmp110.17 = icmp eq i32 %390, 255
  br i1 %cmp110.17, label %if.then146.17, label %lor.lhs.false112.17

lor.lhs.false112.17:                              ; preds = %lor.lhs.false104.17
  %391 = trunc i64 %indvars.iv.17 to i32
  %add115.17 = add i32 %add114.17, %391
  %idxprom116.17 = sext i32 %add115.17 to i64
  %arrayidx117.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.17
  %392 = load i32, i32* %arrayidx117.17, align 4
  %cmp118.17 = icmp eq i32 %392, 255
  br i1 %cmp118.17, label %if.then146.17, label %lor.lhs.false120.17

lor.lhs.false120.17:                              ; preds = %lor.lhs.false112.17
  %add124.17 = add i32 %sub81.17, 127
  %idxprom125.17 = sext i32 %add124.17 to i64
  %arrayidx126.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.17
  %393 = load i32, i32* %arrayidx126.17, align 4
  %cmp127.17 = icmp eq i32 %393, 255
  br i1 %cmp127.17, label %if.then146.17, label %lor.lhs.false129.17

lor.lhs.false129.17:                              ; preds = %lor.lhs.false120.17
  %394 = add nsw i64 %380, %indvars.iv.17
  %arrayidx134.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %394
  %395 = load i32, i32* %arrayidx134.17, align 4
  %cmp135.17 = icmp eq i32 %395, 255
  br i1 %cmp135.17, label %if.then146.17, label %lor.lhs.false137.17

lor.lhs.false137.17:                              ; preds = %lor.lhs.false129.17
  %add141.17 = add i32 %sub81.17, 129
  %idxprom142.17 = sext i32 %add141.17 to i64
  %arrayidx143.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.17
  %396 = load i32, i32* %arrayidx143.17, align 4
  %cmp144.17 = icmp eq i32 %396, 255
  br i1 %cmp144.17, label %if.then146.17, label %if.else149.17

if.else149.17:                                    ; preds = %lor.lhs.false137.17
  %arrayidx151.17 = getelementptr inbounds i8, i8* %0, i64 %382
  store i8 0, i8* %arrayidx151.17, align 1
  br label %for.inc161.17

if.then146.17:                                    ; preds = %lor.lhs.false137.17, %lor.lhs.false129.17, %lor.lhs.false120.17, %lor.lhs.false112.17, %lor.lhs.false104.17, %lor.lhs.false95.17, %lor.lhs.false87.17, %if.then78.17
  %arrayidx148.17 = getelementptr inbounds i8, i8* %0, i64 %382
  store i8 -1, i8* %arrayidx148.17, align 1
  br label %for.inc161.17

if.then70.17:                                     ; preds = %for.body56.17
  %arrayidx72.17 = getelementptr inbounds i8, i8* %0, i64 %382
  store i8 0, i8* %arrayidx72.17, align 1
  br label %for.inc161.17

for.inc161.17:                                    ; preds = %if.then70.17, %if.then146.17, %if.else149.17, %if.else153.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %img_width
  br i1 %exitcond.17, label %for.inc164.17, label %for.body56.17, !llvm.loop !5

for.inc164.17:                                    ; preds = %for.inc161.17
  %indvars.iv.next20.17 = add nsw i64 %indvars.iv19, 18
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.18

for.body56.lr.ph.18:                              ; preds = %for.inc164.17
  %397 = trunc i64 %indvars.iv.next20.17 to i32
  %mul58.18 = shl nsw i32 %397, 7
  %cmp62.18 = icmp eq i64 %indvars.iv.next20.17, %12
  %398 = trunc i64 %indvars.iv.next20.17 to i32
  %sub79.18 = shl i32 %398, 7
  %mul89.18 = add i32 %sub79.18, -128
  %sub106.18 = add i32 %mul58.18, -1
  %add114.18 = or i32 %mul58.18, 1
  %mul131.18 = add i32 %sub79.18, 128
  %399 = sext i32 %mul58.18 to i64
  %400 = sext i32 %mul131.18 to i64
  %401 = sext i32 %mul89.18 to i64
  br label %for.body56.18

for.body56.18:                                    ; preds = %for.inc161.18, %for.body56.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body56.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc161.18 ]
  %402 = add nsw i64 %indvars.iv.18, %399
  %cmp65.18 = icmp eq i64 %indvars.iv.18, 0
  %or.cond1.18 = or i1 %cmp62.18, %cmp65.18
  %cmp68.18 = icmp eq i64 %indvars.iv.18, %11
  %or.cond2.18 = or i1 %cmp68.18, %or.cond1.18
  br i1 %or.cond2.18, label %if.then70.18, label %if.else73.18

if.else73.18:                                     ; preds = %for.body56.18
  %arrayidx75.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %402
  %403 = load i32, i32* %arrayidx75.18, align 4
  %cmp76.18 = icmp eq i32 %403, 75
  br i1 %cmp76.18, label %if.then78.18, label %if.else153.18

if.else153.18:                                    ; preds = %if.else73.18
  %conv156.18 = trunc i32 %403 to i8
  %arrayidx158.18 = getelementptr inbounds i8, i8* %0, i64 %402
  store i8 %conv156.18, i8* %arrayidx158.18, align 1
  br label %for.inc161.18

if.then78.18:                                     ; preds = %if.else73.18
  %404 = trunc i64 %indvars.iv.18 to i32
  %sub81.18 = add i32 %404, %sub79.18
  %add82.18 = add i32 %sub81.18, -129
  %idxprom83.18 = sext i32 %add82.18 to i64
  %arrayidx84.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.18
  %405 = load i32, i32* %arrayidx84.18, align 4
  %cmp85.18 = icmp eq i32 %405, 255
  br i1 %cmp85.18, label %if.then146.18, label %lor.lhs.false87.18

lor.lhs.false87.18:                               ; preds = %if.then78.18
  %406 = add nsw i64 %401, %indvars.iv.18
  %arrayidx92.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %406
  %407 = load i32, i32* %arrayidx92.18, align 4
  %cmp93.18 = icmp eq i32 %407, 255
  br i1 %cmp93.18, label %if.then146.18, label %lor.lhs.false95.18

lor.lhs.false95.18:                               ; preds = %lor.lhs.false87.18
  %add99.18 = add i32 %sub81.18, -127
  %idxprom100.18 = sext i32 %add99.18 to i64
  %arrayidx101.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.18
  %408 = load i32, i32* %arrayidx101.18, align 4
  %cmp102.18 = icmp eq i32 %408, 255
  br i1 %cmp102.18, label %if.then146.18, label %lor.lhs.false104.18

lor.lhs.false104.18:                              ; preds = %lor.lhs.false95.18
  %409 = trunc i64 %indvars.iv.18 to i32
  %add107.18 = add i32 %sub106.18, %409
  %idxprom108.18 = sext i32 %add107.18 to i64
  %arrayidx109.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.18
  %410 = load i32, i32* %arrayidx109.18, align 4
  %cmp110.18 = icmp eq i32 %410, 255
  br i1 %cmp110.18, label %if.then146.18, label %lor.lhs.false112.18

lor.lhs.false112.18:                              ; preds = %lor.lhs.false104.18
  %411 = trunc i64 %indvars.iv.18 to i32
  %add115.18 = add i32 %add114.18, %411
  %idxprom116.18 = sext i32 %add115.18 to i64
  %arrayidx117.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.18
  %412 = load i32, i32* %arrayidx117.18, align 4
  %cmp118.18 = icmp eq i32 %412, 255
  br i1 %cmp118.18, label %if.then146.18, label %lor.lhs.false120.18

lor.lhs.false120.18:                              ; preds = %lor.lhs.false112.18
  %add124.18 = add i32 %sub81.18, 127
  %idxprom125.18 = sext i32 %add124.18 to i64
  %arrayidx126.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.18
  %413 = load i32, i32* %arrayidx126.18, align 4
  %cmp127.18 = icmp eq i32 %413, 255
  br i1 %cmp127.18, label %if.then146.18, label %lor.lhs.false129.18

lor.lhs.false129.18:                              ; preds = %lor.lhs.false120.18
  %414 = add nsw i64 %400, %indvars.iv.18
  %arrayidx134.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %414
  %415 = load i32, i32* %arrayidx134.18, align 4
  %cmp135.18 = icmp eq i32 %415, 255
  br i1 %cmp135.18, label %if.then146.18, label %lor.lhs.false137.18

lor.lhs.false137.18:                              ; preds = %lor.lhs.false129.18
  %add141.18 = add i32 %sub81.18, 129
  %idxprom142.18 = sext i32 %add141.18 to i64
  %arrayidx143.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.18
  %416 = load i32, i32* %arrayidx143.18, align 4
  %cmp144.18 = icmp eq i32 %416, 255
  br i1 %cmp144.18, label %if.then146.18, label %if.else149.18

if.else149.18:                                    ; preds = %lor.lhs.false137.18
  %arrayidx151.18 = getelementptr inbounds i8, i8* %0, i64 %402
  store i8 0, i8* %arrayidx151.18, align 1
  br label %for.inc161.18

if.then146.18:                                    ; preds = %lor.lhs.false137.18, %lor.lhs.false129.18, %lor.lhs.false120.18, %lor.lhs.false112.18, %lor.lhs.false104.18, %lor.lhs.false95.18, %lor.lhs.false87.18, %if.then78.18
  %arrayidx148.18 = getelementptr inbounds i8, i8* %0, i64 %402
  store i8 -1, i8* %arrayidx148.18, align 1
  br label %for.inc161.18

if.then70.18:                                     ; preds = %for.body56.18
  %arrayidx72.18 = getelementptr inbounds i8, i8* %0, i64 %402
  store i8 0, i8* %arrayidx72.18, align 1
  br label %for.inc161.18

for.inc161.18:                                    ; preds = %if.then70.18, %if.then146.18, %if.else149.18, %if.else153.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %img_width
  br i1 %exitcond.18, label %for.inc164.18, label %for.body56.18, !llvm.loop !5

for.inc164.18:                                    ; preds = %for.inc161.18
  %indvars.iv.next20.18 = add nsw i64 %indvars.iv19, 19
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.19

for.body56.lr.ph.19:                              ; preds = %for.inc164.18
  %417 = trunc i64 %indvars.iv.next20.18 to i32
  %mul58.19 = shl nsw i32 %417, 7
  %cmp62.19 = icmp eq i64 %indvars.iv.next20.18, %12
  %418 = trunc i64 %indvars.iv.next20.18 to i32
  %sub79.19 = shl i32 %418, 7
  %mul89.19 = add i32 %sub79.19, -128
  %sub106.19 = add i32 %mul58.19, -1
  %add114.19 = or i32 %mul58.19, 1
  %mul131.19 = add i32 %sub79.19, 128
  %419 = sext i32 %mul58.19 to i64
  %420 = sext i32 %mul131.19 to i64
  %421 = sext i32 %mul89.19 to i64
  br label %for.body56.19

for.body56.19:                                    ; preds = %for.inc161.19, %for.body56.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body56.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc161.19 ]
  %422 = add nsw i64 %indvars.iv.19, %419
  %cmp65.19 = icmp eq i64 %indvars.iv.19, 0
  %or.cond1.19 = or i1 %cmp62.19, %cmp65.19
  %cmp68.19 = icmp eq i64 %indvars.iv.19, %11
  %or.cond2.19 = or i1 %cmp68.19, %or.cond1.19
  br i1 %or.cond2.19, label %if.then70.19, label %if.else73.19

if.else73.19:                                     ; preds = %for.body56.19
  %arrayidx75.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %422
  %423 = load i32, i32* %arrayidx75.19, align 4
  %cmp76.19 = icmp eq i32 %423, 75
  br i1 %cmp76.19, label %if.then78.19, label %if.else153.19

if.else153.19:                                    ; preds = %if.else73.19
  %conv156.19 = trunc i32 %423 to i8
  %arrayidx158.19 = getelementptr inbounds i8, i8* %0, i64 %422
  store i8 %conv156.19, i8* %arrayidx158.19, align 1
  br label %for.inc161.19

if.then78.19:                                     ; preds = %if.else73.19
  %424 = trunc i64 %indvars.iv.19 to i32
  %sub81.19 = add i32 %424, %sub79.19
  %add82.19 = add i32 %sub81.19, -129
  %idxprom83.19 = sext i32 %add82.19 to i64
  %arrayidx84.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.19
  %425 = load i32, i32* %arrayidx84.19, align 4
  %cmp85.19 = icmp eq i32 %425, 255
  br i1 %cmp85.19, label %if.then146.19, label %lor.lhs.false87.19

lor.lhs.false87.19:                               ; preds = %if.then78.19
  %426 = add nsw i64 %421, %indvars.iv.19
  %arrayidx92.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %426
  %427 = load i32, i32* %arrayidx92.19, align 4
  %cmp93.19 = icmp eq i32 %427, 255
  br i1 %cmp93.19, label %if.then146.19, label %lor.lhs.false95.19

lor.lhs.false95.19:                               ; preds = %lor.lhs.false87.19
  %add99.19 = add i32 %sub81.19, -127
  %idxprom100.19 = sext i32 %add99.19 to i64
  %arrayidx101.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.19
  %428 = load i32, i32* %arrayidx101.19, align 4
  %cmp102.19 = icmp eq i32 %428, 255
  br i1 %cmp102.19, label %if.then146.19, label %lor.lhs.false104.19

lor.lhs.false104.19:                              ; preds = %lor.lhs.false95.19
  %429 = trunc i64 %indvars.iv.19 to i32
  %add107.19 = add i32 %sub106.19, %429
  %idxprom108.19 = sext i32 %add107.19 to i64
  %arrayidx109.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.19
  %430 = load i32, i32* %arrayidx109.19, align 4
  %cmp110.19 = icmp eq i32 %430, 255
  br i1 %cmp110.19, label %if.then146.19, label %lor.lhs.false112.19

lor.lhs.false112.19:                              ; preds = %lor.lhs.false104.19
  %431 = trunc i64 %indvars.iv.19 to i32
  %add115.19 = add i32 %add114.19, %431
  %idxprom116.19 = sext i32 %add115.19 to i64
  %arrayidx117.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.19
  %432 = load i32, i32* %arrayidx117.19, align 4
  %cmp118.19 = icmp eq i32 %432, 255
  br i1 %cmp118.19, label %if.then146.19, label %lor.lhs.false120.19

lor.lhs.false120.19:                              ; preds = %lor.lhs.false112.19
  %add124.19 = add i32 %sub81.19, 127
  %idxprom125.19 = sext i32 %add124.19 to i64
  %arrayidx126.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.19
  %433 = load i32, i32* %arrayidx126.19, align 4
  %cmp127.19 = icmp eq i32 %433, 255
  br i1 %cmp127.19, label %if.then146.19, label %lor.lhs.false129.19

lor.lhs.false129.19:                              ; preds = %lor.lhs.false120.19
  %434 = add nsw i64 %420, %indvars.iv.19
  %arrayidx134.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %434
  %435 = load i32, i32* %arrayidx134.19, align 4
  %cmp135.19 = icmp eq i32 %435, 255
  br i1 %cmp135.19, label %if.then146.19, label %lor.lhs.false137.19

lor.lhs.false137.19:                              ; preds = %lor.lhs.false129.19
  %add141.19 = add i32 %sub81.19, 129
  %idxprom142.19 = sext i32 %add141.19 to i64
  %arrayidx143.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.19
  %436 = load i32, i32* %arrayidx143.19, align 4
  %cmp144.19 = icmp eq i32 %436, 255
  br i1 %cmp144.19, label %if.then146.19, label %if.else149.19

if.else149.19:                                    ; preds = %lor.lhs.false137.19
  %arrayidx151.19 = getelementptr inbounds i8, i8* %0, i64 %422
  store i8 0, i8* %arrayidx151.19, align 1
  br label %for.inc161.19

if.then146.19:                                    ; preds = %lor.lhs.false137.19, %lor.lhs.false129.19, %lor.lhs.false120.19, %lor.lhs.false112.19, %lor.lhs.false104.19, %lor.lhs.false95.19, %lor.lhs.false87.19, %if.then78.19
  %arrayidx148.19 = getelementptr inbounds i8, i8* %0, i64 %422
  store i8 -1, i8* %arrayidx148.19, align 1
  br label %for.inc161.19

if.then70.19:                                     ; preds = %for.body56.19
  %arrayidx72.19 = getelementptr inbounds i8, i8* %0, i64 %422
  store i8 0, i8* %arrayidx72.19, align 1
  br label %for.inc161.19

for.inc161.19:                                    ; preds = %if.then70.19, %if.then146.19, %if.else149.19, %if.else153.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %img_width
  br i1 %exitcond.19, label %for.inc164.19, label %for.body56.19, !llvm.loop !5

for.inc164.19:                                    ; preds = %for.inc161.19
  %indvars.iv.next20.19 = add nsw i64 %indvars.iv19, 20
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.20

for.body56.lr.ph.20:                              ; preds = %for.inc164.19
  %437 = trunc i64 %indvars.iv.next20.19 to i32
  %mul58.20 = shl nsw i32 %437, 7
  %cmp62.20 = icmp eq i64 %indvars.iv.next20.19, %12
  %438 = trunc i64 %indvars.iv.next20.19 to i32
  %sub79.20 = shl i32 %438, 7
  %mul89.20 = add i32 %sub79.20, -128
  %sub106.20 = add i32 %mul58.20, -1
  %add114.20 = or i32 %mul58.20, 1
  %mul131.20 = add i32 %sub79.20, 128
  %439 = sext i32 %mul58.20 to i64
  %440 = sext i32 %mul131.20 to i64
  %441 = sext i32 %mul89.20 to i64
  br label %for.body56.20

for.body56.20:                                    ; preds = %for.inc161.20, %for.body56.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body56.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc161.20 ]
  %442 = add nsw i64 %indvars.iv.20, %439
  %cmp65.20 = icmp eq i64 %indvars.iv.20, 0
  %or.cond1.20 = or i1 %cmp62.20, %cmp65.20
  %cmp68.20 = icmp eq i64 %indvars.iv.20, %11
  %or.cond2.20 = or i1 %cmp68.20, %or.cond1.20
  br i1 %or.cond2.20, label %if.then70.20, label %if.else73.20

if.else73.20:                                     ; preds = %for.body56.20
  %arrayidx75.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %442
  %443 = load i32, i32* %arrayidx75.20, align 4
  %cmp76.20 = icmp eq i32 %443, 75
  br i1 %cmp76.20, label %if.then78.20, label %if.else153.20

if.else153.20:                                    ; preds = %if.else73.20
  %conv156.20 = trunc i32 %443 to i8
  %arrayidx158.20 = getelementptr inbounds i8, i8* %0, i64 %442
  store i8 %conv156.20, i8* %arrayidx158.20, align 1
  br label %for.inc161.20

if.then78.20:                                     ; preds = %if.else73.20
  %444 = trunc i64 %indvars.iv.20 to i32
  %sub81.20 = add i32 %444, %sub79.20
  %add82.20 = add i32 %sub81.20, -129
  %idxprom83.20 = sext i32 %add82.20 to i64
  %arrayidx84.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.20
  %445 = load i32, i32* %arrayidx84.20, align 4
  %cmp85.20 = icmp eq i32 %445, 255
  br i1 %cmp85.20, label %if.then146.20, label %lor.lhs.false87.20

lor.lhs.false87.20:                               ; preds = %if.then78.20
  %446 = add nsw i64 %441, %indvars.iv.20
  %arrayidx92.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %446
  %447 = load i32, i32* %arrayidx92.20, align 4
  %cmp93.20 = icmp eq i32 %447, 255
  br i1 %cmp93.20, label %if.then146.20, label %lor.lhs.false95.20

lor.lhs.false95.20:                               ; preds = %lor.lhs.false87.20
  %add99.20 = add i32 %sub81.20, -127
  %idxprom100.20 = sext i32 %add99.20 to i64
  %arrayidx101.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.20
  %448 = load i32, i32* %arrayidx101.20, align 4
  %cmp102.20 = icmp eq i32 %448, 255
  br i1 %cmp102.20, label %if.then146.20, label %lor.lhs.false104.20

lor.lhs.false104.20:                              ; preds = %lor.lhs.false95.20
  %449 = trunc i64 %indvars.iv.20 to i32
  %add107.20 = add i32 %sub106.20, %449
  %idxprom108.20 = sext i32 %add107.20 to i64
  %arrayidx109.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.20
  %450 = load i32, i32* %arrayidx109.20, align 4
  %cmp110.20 = icmp eq i32 %450, 255
  br i1 %cmp110.20, label %if.then146.20, label %lor.lhs.false112.20

lor.lhs.false112.20:                              ; preds = %lor.lhs.false104.20
  %451 = trunc i64 %indvars.iv.20 to i32
  %add115.20 = add i32 %add114.20, %451
  %idxprom116.20 = sext i32 %add115.20 to i64
  %arrayidx117.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.20
  %452 = load i32, i32* %arrayidx117.20, align 4
  %cmp118.20 = icmp eq i32 %452, 255
  br i1 %cmp118.20, label %if.then146.20, label %lor.lhs.false120.20

lor.lhs.false120.20:                              ; preds = %lor.lhs.false112.20
  %add124.20 = add i32 %sub81.20, 127
  %idxprom125.20 = sext i32 %add124.20 to i64
  %arrayidx126.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.20
  %453 = load i32, i32* %arrayidx126.20, align 4
  %cmp127.20 = icmp eq i32 %453, 255
  br i1 %cmp127.20, label %if.then146.20, label %lor.lhs.false129.20

lor.lhs.false129.20:                              ; preds = %lor.lhs.false120.20
  %454 = add nsw i64 %440, %indvars.iv.20
  %arrayidx134.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %454
  %455 = load i32, i32* %arrayidx134.20, align 4
  %cmp135.20 = icmp eq i32 %455, 255
  br i1 %cmp135.20, label %if.then146.20, label %lor.lhs.false137.20

lor.lhs.false137.20:                              ; preds = %lor.lhs.false129.20
  %add141.20 = add i32 %sub81.20, 129
  %idxprom142.20 = sext i32 %add141.20 to i64
  %arrayidx143.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.20
  %456 = load i32, i32* %arrayidx143.20, align 4
  %cmp144.20 = icmp eq i32 %456, 255
  br i1 %cmp144.20, label %if.then146.20, label %if.else149.20

if.else149.20:                                    ; preds = %lor.lhs.false137.20
  %arrayidx151.20 = getelementptr inbounds i8, i8* %0, i64 %442
  store i8 0, i8* %arrayidx151.20, align 1
  br label %for.inc161.20

if.then146.20:                                    ; preds = %lor.lhs.false137.20, %lor.lhs.false129.20, %lor.lhs.false120.20, %lor.lhs.false112.20, %lor.lhs.false104.20, %lor.lhs.false95.20, %lor.lhs.false87.20, %if.then78.20
  %arrayidx148.20 = getelementptr inbounds i8, i8* %0, i64 %442
  store i8 -1, i8* %arrayidx148.20, align 1
  br label %for.inc161.20

if.then70.20:                                     ; preds = %for.body56.20
  %arrayidx72.20 = getelementptr inbounds i8, i8* %0, i64 %442
  store i8 0, i8* %arrayidx72.20, align 1
  br label %for.inc161.20

for.inc161.20:                                    ; preds = %if.then70.20, %if.then146.20, %if.else149.20, %if.else153.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %img_width
  br i1 %exitcond.20, label %for.inc164.20, label %for.body56.20, !llvm.loop !5

for.inc164.20:                                    ; preds = %for.inc161.20
  %indvars.iv.next20.20 = add nsw i64 %indvars.iv19, 21
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.21

for.body56.lr.ph.21:                              ; preds = %for.inc164.20
  %457 = trunc i64 %indvars.iv.next20.20 to i32
  %mul58.21 = shl nsw i32 %457, 7
  %cmp62.21 = icmp eq i64 %indvars.iv.next20.20, %12
  %458 = trunc i64 %indvars.iv.next20.20 to i32
  %sub79.21 = shl i32 %458, 7
  %mul89.21 = add i32 %sub79.21, -128
  %sub106.21 = add i32 %mul58.21, -1
  %add114.21 = or i32 %mul58.21, 1
  %mul131.21 = add i32 %sub79.21, 128
  %459 = sext i32 %mul58.21 to i64
  %460 = sext i32 %mul131.21 to i64
  %461 = sext i32 %mul89.21 to i64
  br label %for.body56.21

for.body56.21:                                    ; preds = %for.inc161.21, %for.body56.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body56.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc161.21 ]
  %462 = add nsw i64 %indvars.iv.21, %459
  %cmp65.21 = icmp eq i64 %indvars.iv.21, 0
  %or.cond1.21 = or i1 %cmp62.21, %cmp65.21
  %cmp68.21 = icmp eq i64 %indvars.iv.21, %11
  %or.cond2.21 = or i1 %cmp68.21, %or.cond1.21
  br i1 %or.cond2.21, label %if.then70.21, label %if.else73.21

if.else73.21:                                     ; preds = %for.body56.21
  %arrayidx75.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %462
  %463 = load i32, i32* %arrayidx75.21, align 4
  %cmp76.21 = icmp eq i32 %463, 75
  br i1 %cmp76.21, label %if.then78.21, label %if.else153.21

if.else153.21:                                    ; preds = %if.else73.21
  %conv156.21 = trunc i32 %463 to i8
  %arrayidx158.21 = getelementptr inbounds i8, i8* %0, i64 %462
  store i8 %conv156.21, i8* %arrayidx158.21, align 1
  br label %for.inc161.21

if.then78.21:                                     ; preds = %if.else73.21
  %464 = trunc i64 %indvars.iv.21 to i32
  %sub81.21 = add i32 %464, %sub79.21
  %add82.21 = add i32 %sub81.21, -129
  %idxprom83.21 = sext i32 %add82.21 to i64
  %arrayidx84.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.21
  %465 = load i32, i32* %arrayidx84.21, align 4
  %cmp85.21 = icmp eq i32 %465, 255
  br i1 %cmp85.21, label %if.then146.21, label %lor.lhs.false87.21

lor.lhs.false87.21:                               ; preds = %if.then78.21
  %466 = add nsw i64 %461, %indvars.iv.21
  %arrayidx92.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %466
  %467 = load i32, i32* %arrayidx92.21, align 4
  %cmp93.21 = icmp eq i32 %467, 255
  br i1 %cmp93.21, label %if.then146.21, label %lor.lhs.false95.21

lor.lhs.false95.21:                               ; preds = %lor.lhs.false87.21
  %add99.21 = add i32 %sub81.21, -127
  %idxprom100.21 = sext i32 %add99.21 to i64
  %arrayidx101.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.21
  %468 = load i32, i32* %arrayidx101.21, align 4
  %cmp102.21 = icmp eq i32 %468, 255
  br i1 %cmp102.21, label %if.then146.21, label %lor.lhs.false104.21

lor.lhs.false104.21:                              ; preds = %lor.lhs.false95.21
  %469 = trunc i64 %indvars.iv.21 to i32
  %add107.21 = add i32 %sub106.21, %469
  %idxprom108.21 = sext i32 %add107.21 to i64
  %arrayidx109.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.21
  %470 = load i32, i32* %arrayidx109.21, align 4
  %cmp110.21 = icmp eq i32 %470, 255
  br i1 %cmp110.21, label %if.then146.21, label %lor.lhs.false112.21

lor.lhs.false112.21:                              ; preds = %lor.lhs.false104.21
  %471 = trunc i64 %indvars.iv.21 to i32
  %add115.21 = add i32 %add114.21, %471
  %idxprom116.21 = sext i32 %add115.21 to i64
  %arrayidx117.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.21
  %472 = load i32, i32* %arrayidx117.21, align 4
  %cmp118.21 = icmp eq i32 %472, 255
  br i1 %cmp118.21, label %if.then146.21, label %lor.lhs.false120.21

lor.lhs.false120.21:                              ; preds = %lor.lhs.false112.21
  %add124.21 = add i32 %sub81.21, 127
  %idxprom125.21 = sext i32 %add124.21 to i64
  %arrayidx126.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.21
  %473 = load i32, i32* %arrayidx126.21, align 4
  %cmp127.21 = icmp eq i32 %473, 255
  br i1 %cmp127.21, label %if.then146.21, label %lor.lhs.false129.21

lor.lhs.false129.21:                              ; preds = %lor.lhs.false120.21
  %474 = add nsw i64 %460, %indvars.iv.21
  %arrayidx134.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %474
  %475 = load i32, i32* %arrayidx134.21, align 4
  %cmp135.21 = icmp eq i32 %475, 255
  br i1 %cmp135.21, label %if.then146.21, label %lor.lhs.false137.21

lor.lhs.false137.21:                              ; preds = %lor.lhs.false129.21
  %add141.21 = add i32 %sub81.21, 129
  %idxprom142.21 = sext i32 %add141.21 to i64
  %arrayidx143.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.21
  %476 = load i32, i32* %arrayidx143.21, align 4
  %cmp144.21 = icmp eq i32 %476, 255
  br i1 %cmp144.21, label %if.then146.21, label %if.else149.21

if.else149.21:                                    ; preds = %lor.lhs.false137.21
  %arrayidx151.21 = getelementptr inbounds i8, i8* %0, i64 %462
  store i8 0, i8* %arrayidx151.21, align 1
  br label %for.inc161.21

if.then146.21:                                    ; preds = %lor.lhs.false137.21, %lor.lhs.false129.21, %lor.lhs.false120.21, %lor.lhs.false112.21, %lor.lhs.false104.21, %lor.lhs.false95.21, %lor.lhs.false87.21, %if.then78.21
  %arrayidx148.21 = getelementptr inbounds i8, i8* %0, i64 %462
  store i8 -1, i8* %arrayidx148.21, align 1
  br label %for.inc161.21

if.then70.21:                                     ; preds = %for.body56.21
  %arrayidx72.21 = getelementptr inbounds i8, i8* %0, i64 %462
  store i8 0, i8* %arrayidx72.21, align 1
  br label %for.inc161.21

for.inc161.21:                                    ; preds = %if.then70.21, %if.then146.21, %if.else149.21, %if.else153.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %img_width
  br i1 %exitcond.21, label %for.inc164.21, label %for.body56.21, !llvm.loop !5

for.inc164.21:                                    ; preds = %for.inc161.21
  %indvars.iv.next20.21 = add nsw i64 %indvars.iv19, 22
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.22

for.body56.lr.ph.22:                              ; preds = %for.inc164.21
  %477 = trunc i64 %indvars.iv.next20.21 to i32
  %mul58.22 = shl nsw i32 %477, 7
  %cmp62.22 = icmp eq i64 %indvars.iv.next20.21, %12
  %478 = trunc i64 %indvars.iv.next20.21 to i32
  %sub79.22 = shl i32 %478, 7
  %mul89.22 = add i32 %sub79.22, -128
  %sub106.22 = add i32 %mul58.22, -1
  %add114.22 = or i32 %mul58.22, 1
  %mul131.22 = add i32 %sub79.22, 128
  %479 = sext i32 %mul58.22 to i64
  %480 = sext i32 %mul131.22 to i64
  %481 = sext i32 %mul89.22 to i64
  br label %for.body56.22

for.body56.22:                                    ; preds = %for.inc161.22, %for.body56.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body56.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc161.22 ]
  %482 = add nsw i64 %indvars.iv.22, %479
  %cmp65.22 = icmp eq i64 %indvars.iv.22, 0
  %or.cond1.22 = or i1 %cmp62.22, %cmp65.22
  %cmp68.22 = icmp eq i64 %indvars.iv.22, %11
  %or.cond2.22 = or i1 %cmp68.22, %or.cond1.22
  br i1 %or.cond2.22, label %if.then70.22, label %if.else73.22

if.else73.22:                                     ; preds = %for.body56.22
  %arrayidx75.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %482
  %483 = load i32, i32* %arrayidx75.22, align 4
  %cmp76.22 = icmp eq i32 %483, 75
  br i1 %cmp76.22, label %if.then78.22, label %if.else153.22

if.else153.22:                                    ; preds = %if.else73.22
  %conv156.22 = trunc i32 %483 to i8
  %arrayidx158.22 = getelementptr inbounds i8, i8* %0, i64 %482
  store i8 %conv156.22, i8* %arrayidx158.22, align 1
  br label %for.inc161.22

if.then78.22:                                     ; preds = %if.else73.22
  %484 = trunc i64 %indvars.iv.22 to i32
  %sub81.22 = add i32 %484, %sub79.22
  %add82.22 = add i32 %sub81.22, -129
  %idxprom83.22 = sext i32 %add82.22 to i64
  %arrayidx84.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.22
  %485 = load i32, i32* %arrayidx84.22, align 4
  %cmp85.22 = icmp eq i32 %485, 255
  br i1 %cmp85.22, label %if.then146.22, label %lor.lhs.false87.22

lor.lhs.false87.22:                               ; preds = %if.then78.22
  %486 = add nsw i64 %481, %indvars.iv.22
  %arrayidx92.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %486
  %487 = load i32, i32* %arrayidx92.22, align 4
  %cmp93.22 = icmp eq i32 %487, 255
  br i1 %cmp93.22, label %if.then146.22, label %lor.lhs.false95.22

lor.lhs.false95.22:                               ; preds = %lor.lhs.false87.22
  %add99.22 = add i32 %sub81.22, -127
  %idxprom100.22 = sext i32 %add99.22 to i64
  %arrayidx101.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.22
  %488 = load i32, i32* %arrayidx101.22, align 4
  %cmp102.22 = icmp eq i32 %488, 255
  br i1 %cmp102.22, label %if.then146.22, label %lor.lhs.false104.22

lor.lhs.false104.22:                              ; preds = %lor.lhs.false95.22
  %489 = trunc i64 %indvars.iv.22 to i32
  %add107.22 = add i32 %sub106.22, %489
  %idxprom108.22 = sext i32 %add107.22 to i64
  %arrayidx109.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.22
  %490 = load i32, i32* %arrayidx109.22, align 4
  %cmp110.22 = icmp eq i32 %490, 255
  br i1 %cmp110.22, label %if.then146.22, label %lor.lhs.false112.22

lor.lhs.false112.22:                              ; preds = %lor.lhs.false104.22
  %491 = trunc i64 %indvars.iv.22 to i32
  %add115.22 = add i32 %add114.22, %491
  %idxprom116.22 = sext i32 %add115.22 to i64
  %arrayidx117.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.22
  %492 = load i32, i32* %arrayidx117.22, align 4
  %cmp118.22 = icmp eq i32 %492, 255
  br i1 %cmp118.22, label %if.then146.22, label %lor.lhs.false120.22

lor.lhs.false120.22:                              ; preds = %lor.lhs.false112.22
  %add124.22 = add i32 %sub81.22, 127
  %idxprom125.22 = sext i32 %add124.22 to i64
  %arrayidx126.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.22
  %493 = load i32, i32* %arrayidx126.22, align 4
  %cmp127.22 = icmp eq i32 %493, 255
  br i1 %cmp127.22, label %if.then146.22, label %lor.lhs.false129.22

lor.lhs.false129.22:                              ; preds = %lor.lhs.false120.22
  %494 = add nsw i64 %480, %indvars.iv.22
  %arrayidx134.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %494
  %495 = load i32, i32* %arrayidx134.22, align 4
  %cmp135.22 = icmp eq i32 %495, 255
  br i1 %cmp135.22, label %if.then146.22, label %lor.lhs.false137.22

lor.lhs.false137.22:                              ; preds = %lor.lhs.false129.22
  %add141.22 = add i32 %sub81.22, 129
  %idxprom142.22 = sext i32 %add141.22 to i64
  %arrayidx143.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.22
  %496 = load i32, i32* %arrayidx143.22, align 4
  %cmp144.22 = icmp eq i32 %496, 255
  br i1 %cmp144.22, label %if.then146.22, label %if.else149.22

if.else149.22:                                    ; preds = %lor.lhs.false137.22
  %arrayidx151.22 = getelementptr inbounds i8, i8* %0, i64 %482
  store i8 0, i8* %arrayidx151.22, align 1
  br label %for.inc161.22

if.then146.22:                                    ; preds = %lor.lhs.false137.22, %lor.lhs.false129.22, %lor.lhs.false120.22, %lor.lhs.false112.22, %lor.lhs.false104.22, %lor.lhs.false95.22, %lor.lhs.false87.22, %if.then78.22
  %arrayidx148.22 = getelementptr inbounds i8, i8* %0, i64 %482
  store i8 -1, i8* %arrayidx148.22, align 1
  br label %for.inc161.22

if.then70.22:                                     ; preds = %for.body56.22
  %arrayidx72.22 = getelementptr inbounds i8, i8* %0, i64 %482
  store i8 0, i8* %arrayidx72.22, align 1
  br label %for.inc161.22

for.inc161.22:                                    ; preds = %if.then70.22, %if.then146.22, %if.else149.22, %if.else153.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %img_width
  br i1 %exitcond.22, label %for.inc164.22, label %for.body56.22, !llvm.loop !5

for.inc164.22:                                    ; preds = %for.inc161.22
  %indvars.iv.next20.22 = add nsw i64 %indvars.iv19, 23
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.23

for.body56.lr.ph.23:                              ; preds = %for.inc164.22
  %497 = trunc i64 %indvars.iv.next20.22 to i32
  %mul58.23 = shl nsw i32 %497, 7
  %cmp62.23 = icmp eq i64 %indvars.iv.next20.22, %12
  %498 = trunc i64 %indvars.iv.next20.22 to i32
  %sub79.23 = shl i32 %498, 7
  %mul89.23 = add i32 %sub79.23, -128
  %sub106.23 = add i32 %mul58.23, -1
  %add114.23 = or i32 %mul58.23, 1
  %mul131.23 = add i32 %sub79.23, 128
  %499 = sext i32 %mul58.23 to i64
  %500 = sext i32 %mul131.23 to i64
  %501 = sext i32 %mul89.23 to i64
  br label %for.body56.23

for.body56.23:                                    ; preds = %for.inc161.23, %for.body56.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body56.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc161.23 ]
  %502 = add nsw i64 %indvars.iv.23, %499
  %cmp65.23 = icmp eq i64 %indvars.iv.23, 0
  %or.cond1.23 = or i1 %cmp62.23, %cmp65.23
  %cmp68.23 = icmp eq i64 %indvars.iv.23, %11
  %or.cond2.23 = or i1 %cmp68.23, %or.cond1.23
  br i1 %or.cond2.23, label %if.then70.23, label %if.else73.23

if.else73.23:                                     ; preds = %for.body56.23
  %arrayidx75.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %502
  %503 = load i32, i32* %arrayidx75.23, align 4
  %cmp76.23 = icmp eq i32 %503, 75
  br i1 %cmp76.23, label %if.then78.23, label %if.else153.23

if.else153.23:                                    ; preds = %if.else73.23
  %conv156.23 = trunc i32 %503 to i8
  %arrayidx158.23 = getelementptr inbounds i8, i8* %0, i64 %502
  store i8 %conv156.23, i8* %arrayidx158.23, align 1
  br label %for.inc161.23

if.then78.23:                                     ; preds = %if.else73.23
  %504 = trunc i64 %indvars.iv.23 to i32
  %sub81.23 = add i32 %504, %sub79.23
  %add82.23 = add i32 %sub81.23, -129
  %idxprom83.23 = sext i32 %add82.23 to i64
  %arrayidx84.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.23
  %505 = load i32, i32* %arrayidx84.23, align 4
  %cmp85.23 = icmp eq i32 %505, 255
  br i1 %cmp85.23, label %if.then146.23, label %lor.lhs.false87.23

lor.lhs.false87.23:                               ; preds = %if.then78.23
  %506 = add nsw i64 %501, %indvars.iv.23
  %arrayidx92.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %506
  %507 = load i32, i32* %arrayidx92.23, align 4
  %cmp93.23 = icmp eq i32 %507, 255
  br i1 %cmp93.23, label %if.then146.23, label %lor.lhs.false95.23

lor.lhs.false95.23:                               ; preds = %lor.lhs.false87.23
  %add99.23 = add i32 %sub81.23, -127
  %idxprom100.23 = sext i32 %add99.23 to i64
  %arrayidx101.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.23
  %508 = load i32, i32* %arrayidx101.23, align 4
  %cmp102.23 = icmp eq i32 %508, 255
  br i1 %cmp102.23, label %if.then146.23, label %lor.lhs.false104.23

lor.lhs.false104.23:                              ; preds = %lor.lhs.false95.23
  %509 = trunc i64 %indvars.iv.23 to i32
  %add107.23 = add i32 %sub106.23, %509
  %idxprom108.23 = sext i32 %add107.23 to i64
  %arrayidx109.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.23
  %510 = load i32, i32* %arrayidx109.23, align 4
  %cmp110.23 = icmp eq i32 %510, 255
  br i1 %cmp110.23, label %if.then146.23, label %lor.lhs.false112.23

lor.lhs.false112.23:                              ; preds = %lor.lhs.false104.23
  %511 = trunc i64 %indvars.iv.23 to i32
  %add115.23 = add i32 %add114.23, %511
  %idxprom116.23 = sext i32 %add115.23 to i64
  %arrayidx117.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.23
  %512 = load i32, i32* %arrayidx117.23, align 4
  %cmp118.23 = icmp eq i32 %512, 255
  br i1 %cmp118.23, label %if.then146.23, label %lor.lhs.false120.23

lor.lhs.false120.23:                              ; preds = %lor.lhs.false112.23
  %add124.23 = add i32 %sub81.23, 127
  %idxprom125.23 = sext i32 %add124.23 to i64
  %arrayidx126.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.23
  %513 = load i32, i32* %arrayidx126.23, align 4
  %cmp127.23 = icmp eq i32 %513, 255
  br i1 %cmp127.23, label %if.then146.23, label %lor.lhs.false129.23

lor.lhs.false129.23:                              ; preds = %lor.lhs.false120.23
  %514 = add nsw i64 %500, %indvars.iv.23
  %arrayidx134.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %514
  %515 = load i32, i32* %arrayidx134.23, align 4
  %cmp135.23 = icmp eq i32 %515, 255
  br i1 %cmp135.23, label %if.then146.23, label %lor.lhs.false137.23

lor.lhs.false137.23:                              ; preds = %lor.lhs.false129.23
  %add141.23 = add i32 %sub81.23, 129
  %idxprom142.23 = sext i32 %add141.23 to i64
  %arrayidx143.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.23
  %516 = load i32, i32* %arrayidx143.23, align 4
  %cmp144.23 = icmp eq i32 %516, 255
  br i1 %cmp144.23, label %if.then146.23, label %if.else149.23

if.else149.23:                                    ; preds = %lor.lhs.false137.23
  %arrayidx151.23 = getelementptr inbounds i8, i8* %0, i64 %502
  store i8 0, i8* %arrayidx151.23, align 1
  br label %for.inc161.23

if.then146.23:                                    ; preds = %lor.lhs.false137.23, %lor.lhs.false129.23, %lor.lhs.false120.23, %lor.lhs.false112.23, %lor.lhs.false104.23, %lor.lhs.false95.23, %lor.lhs.false87.23, %if.then78.23
  %arrayidx148.23 = getelementptr inbounds i8, i8* %0, i64 %502
  store i8 -1, i8* %arrayidx148.23, align 1
  br label %for.inc161.23

if.then70.23:                                     ; preds = %for.body56.23
  %arrayidx72.23 = getelementptr inbounds i8, i8* %0, i64 %502
  store i8 0, i8* %arrayidx72.23, align 1
  br label %for.inc161.23

for.inc161.23:                                    ; preds = %if.then70.23, %if.then146.23, %if.else149.23, %if.else153.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %img_width
  br i1 %exitcond.23, label %for.inc164.23, label %for.body56.23, !llvm.loop !5

for.inc164.23:                                    ; preds = %for.inc161.23
  %indvars.iv.next20.23 = add nsw i64 %indvars.iv19, 24
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.24

for.body56.lr.ph.24:                              ; preds = %for.inc164.23
  %517 = trunc i64 %indvars.iv.next20.23 to i32
  %mul58.24 = shl nsw i32 %517, 7
  %cmp62.24 = icmp eq i64 %indvars.iv.next20.23, %12
  %518 = trunc i64 %indvars.iv.next20.23 to i32
  %sub79.24 = shl i32 %518, 7
  %mul89.24 = add i32 %sub79.24, -128
  %sub106.24 = add i32 %mul58.24, -1
  %add114.24 = or i32 %mul58.24, 1
  %mul131.24 = add i32 %sub79.24, 128
  %519 = sext i32 %mul58.24 to i64
  %520 = sext i32 %mul131.24 to i64
  %521 = sext i32 %mul89.24 to i64
  br label %for.body56.24

for.body56.24:                                    ; preds = %for.inc161.24, %for.body56.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body56.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc161.24 ]
  %522 = add nsw i64 %indvars.iv.24, %519
  %cmp65.24 = icmp eq i64 %indvars.iv.24, 0
  %or.cond1.24 = or i1 %cmp62.24, %cmp65.24
  %cmp68.24 = icmp eq i64 %indvars.iv.24, %11
  %or.cond2.24 = or i1 %cmp68.24, %or.cond1.24
  br i1 %or.cond2.24, label %if.then70.24, label %if.else73.24

if.else73.24:                                     ; preds = %for.body56.24
  %arrayidx75.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %522
  %523 = load i32, i32* %arrayidx75.24, align 4
  %cmp76.24 = icmp eq i32 %523, 75
  br i1 %cmp76.24, label %if.then78.24, label %if.else153.24

if.else153.24:                                    ; preds = %if.else73.24
  %conv156.24 = trunc i32 %523 to i8
  %arrayidx158.24 = getelementptr inbounds i8, i8* %0, i64 %522
  store i8 %conv156.24, i8* %arrayidx158.24, align 1
  br label %for.inc161.24

if.then78.24:                                     ; preds = %if.else73.24
  %524 = trunc i64 %indvars.iv.24 to i32
  %sub81.24 = add i32 %524, %sub79.24
  %add82.24 = add i32 %sub81.24, -129
  %idxprom83.24 = sext i32 %add82.24 to i64
  %arrayidx84.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.24
  %525 = load i32, i32* %arrayidx84.24, align 4
  %cmp85.24 = icmp eq i32 %525, 255
  br i1 %cmp85.24, label %if.then146.24, label %lor.lhs.false87.24

lor.lhs.false87.24:                               ; preds = %if.then78.24
  %526 = add nsw i64 %521, %indvars.iv.24
  %arrayidx92.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %526
  %527 = load i32, i32* %arrayidx92.24, align 4
  %cmp93.24 = icmp eq i32 %527, 255
  br i1 %cmp93.24, label %if.then146.24, label %lor.lhs.false95.24

lor.lhs.false95.24:                               ; preds = %lor.lhs.false87.24
  %add99.24 = add i32 %sub81.24, -127
  %idxprom100.24 = sext i32 %add99.24 to i64
  %arrayidx101.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.24
  %528 = load i32, i32* %arrayidx101.24, align 4
  %cmp102.24 = icmp eq i32 %528, 255
  br i1 %cmp102.24, label %if.then146.24, label %lor.lhs.false104.24

lor.lhs.false104.24:                              ; preds = %lor.lhs.false95.24
  %529 = trunc i64 %indvars.iv.24 to i32
  %add107.24 = add i32 %sub106.24, %529
  %idxprom108.24 = sext i32 %add107.24 to i64
  %arrayidx109.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.24
  %530 = load i32, i32* %arrayidx109.24, align 4
  %cmp110.24 = icmp eq i32 %530, 255
  br i1 %cmp110.24, label %if.then146.24, label %lor.lhs.false112.24

lor.lhs.false112.24:                              ; preds = %lor.lhs.false104.24
  %531 = trunc i64 %indvars.iv.24 to i32
  %add115.24 = add i32 %add114.24, %531
  %idxprom116.24 = sext i32 %add115.24 to i64
  %arrayidx117.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.24
  %532 = load i32, i32* %arrayidx117.24, align 4
  %cmp118.24 = icmp eq i32 %532, 255
  br i1 %cmp118.24, label %if.then146.24, label %lor.lhs.false120.24

lor.lhs.false120.24:                              ; preds = %lor.lhs.false112.24
  %add124.24 = add i32 %sub81.24, 127
  %idxprom125.24 = sext i32 %add124.24 to i64
  %arrayidx126.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.24
  %533 = load i32, i32* %arrayidx126.24, align 4
  %cmp127.24 = icmp eq i32 %533, 255
  br i1 %cmp127.24, label %if.then146.24, label %lor.lhs.false129.24

lor.lhs.false129.24:                              ; preds = %lor.lhs.false120.24
  %534 = add nsw i64 %520, %indvars.iv.24
  %arrayidx134.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %534
  %535 = load i32, i32* %arrayidx134.24, align 4
  %cmp135.24 = icmp eq i32 %535, 255
  br i1 %cmp135.24, label %if.then146.24, label %lor.lhs.false137.24

lor.lhs.false137.24:                              ; preds = %lor.lhs.false129.24
  %add141.24 = add i32 %sub81.24, 129
  %idxprom142.24 = sext i32 %add141.24 to i64
  %arrayidx143.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.24
  %536 = load i32, i32* %arrayidx143.24, align 4
  %cmp144.24 = icmp eq i32 %536, 255
  br i1 %cmp144.24, label %if.then146.24, label %if.else149.24

if.else149.24:                                    ; preds = %lor.lhs.false137.24
  %arrayidx151.24 = getelementptr inbounds i8, i8* %0, i64 %522
  store i8 0, i8* %arrayidx151.24, align 1
  br label %for.inc161.24

if.then146.24:                                    ; preds = %lor.lhs.false137.24, %lor.lhs.false129.24, %lor.lhs.false120.24, %lor.lhs.false112.24, %lor.lhs.false104.24, %lor.lhs.false95.24, %lor.lhs.false87.24, %if.then78.24
  %arrayidx148.24 = getelementptr inbounds i8, i8* %0, i64 %522
  store i8 -1, i8* %arrayidx148.24, align 1
  br label %for.inc161.24

if.then70.24:                                     ; preds = %for.body56.24
  %arrayidx72.24 = getelementptr inbounds i8, i8* %0, i64 %522
  store i8 0, i8* %arrayidx72.24, align 1
  br label %for.inc161.24

for.inc161.24:                                    ; preds = %if.then70.24, %if.then146.24, %if.else149.24, %if.else153.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %img_width
  br i1 %exitcond.24, label %for.inc164.24, label %for.body56.24, !llvm.loop !5

for.inc164.24:                                    ; preds = %for.inc161.24
  %indvars.iv.next20.24 = add nsw i64 %indvars.iv19, 25
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.25

for.body56.lr.ph.25:                              ; preds = %for.inc164.24
  %537 = trunc i64 %indvars.iv.next20.24 to i32
  %mul58.25 = shl nsw i32 %537, 7
  %cmp62.25 = icmp eq i64 %indvars.iv.next20.24, %12
  %538 = trunc i64 %indvars.iv.next20.24 to i32
  %sub79.25 = shl i32 %538, 7
  %mul89.25 = add i32 %sub79.25, -128
  %sub106.25 = add i32 %mul58.25, -1
  %add114.25 = or i32 %mul58.25, 1
  %mul131.25 = add i32 %sub79.25, 128
  %539 = sext i32 %mul58.25 to i64
  %540 = sext i32 %mul131.25 to i64
  %541 = sext i32 %mul89.25 to i64
  br label %for.body56.25

for.body56.25:                                    ; preds = %for.inc161.25, %for.body56.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body56.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc161.25 ]
  %542 = add nsw i64 %indvars.iv.25, %539
  %cmp65.25 = icmp eq i64 %indvars.iv.25, 0
  %or.cond1.25 = or i1 %cmp62.25, %cmp65.25
  %cmp68.25 = icmp eq i64 %indvars.iv.25, %11
  %or.cond2.25 = or i1 %cmp68.25, %or.cond1.25
  br i1 %or.cond2.25, label %if.then70.25, label %if.else73.25

if.else73.25:                                     ; preds = %for.body56.25
  %arrayidx75.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %542
  %543 = load i32, i32* %arrayidx75.25, align 4
  %cmp76.25 = icmp eq i32 %543, 75
  br i1 %cmp76.25, label %if.then78.25, label %if.else153.25

if.else153.25:                                    ; preds = %if.else73.25
  %conv156.25 = trunc i32 %543 to i8
  %arrayidx158.25 = getelementptr inbounds i8, i8* %0, i64 %542
  store i8 %conv156.25, i8* %arrayidx158.25, align 1
  br label %for.inc161.25

if.then78.25:                                     ; preds = %if.else73.25
  %544 = trunc i64 %indvars.iv.25 to i32
  %sub81.25 = add i32 %544, %sub79.25
  %add82.25 = add i32 %sub81.25, -129
  %idxprom83.25 = sext i32 %add82.25 to i64
  %arrayidx84.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.25
  %545 = load i32, i32* %arrayidx84.25, align 4
  %cmp85.25 = icmp eq i32 %545, 255
  br i1 %cmp85.25, label %if.then146.25, label %lor.lhs.false87.25

lor.lhs.false87.25:                               ; preds = %if.then78.25
  %546 = add nsw i64 %541, %indvars.iv.25
  %arrayidx92.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %546
  %547 = load i32, i32* %arrayidx92.25, align 4
  %cmp93.25 = icmp eq i32 %547, 255
  br i1 %cmp93.25, label %if.then146.25, label %lor.lhs.false95.25

lor.lhs.false95.25:                               ; preds = %lor.lhs.false87.25
  %add99.25 = add i32 %sub81.25, -127
  %idxprom100.25 = sext i32 %add99.25 to i64
  %arrayidx101.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.25
  %548 = load i32, i32* %arrayidx101.25, align 4
  %cmp102.25 = icmp eq i32 %548, 255
  br i1 %cmp102.25, label %if.then146.25, label %lor.lhs.false104.25

lor.lhs.false104.25:                              ; preds = %lor.lhs.false95.25
  %549 = trunc i64 %indvars.iv.25 to i32
  %add107.25 = add i32 %sub106.25, %549
  %idxprom108.25 = sext i32 %add107.25 to i64
  %arrayidx109.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.25
  %550 = load i32, i32* %arrayidx109.25, align 4
  %cmp110.25 = icmp eq i32 %550, 255
  br i1 %cmp110.25, label %if.then146.25, label %lor.lhs.false112.25

lor.lhs.false112.25:                              ; preds = %lor.lhs.false104.25
  %551 = trunc i64 %indvars.iv.25 to i32
  %add115.25 = add i32 %add114.25, %551
  %idxprom116.25 = sext i32 %add115.25 to i64
  %arrayidx117.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.25
  %552 = load i32, i32* %arrayidx117.25, align 4
  %cmp118.25 = icmp eq i32 %552, 255
  br i1 %cmp118.25, label %if.then146.25, label %lor.lhs.false120.25

lor.lhs.false120.25:                              ; preds = %lor.lhs.false112.25
  %add124.25 = add i32 %sub81.25, 127
  %idxprom125.25 = sext i32 %add124.25 to i64
  %arrayidx126.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.25
  %553 = load i32, i32* %arrayidx126.25, align 4
  %cmp127.25 = icmp eq i32 %553, 255
  br i1 %cmp127.25, label %if.then146.25, label %lor.lhs.false129.25

lor.lhs.false129.25:                              ; preds = %lor.lhs.false120.25
  %554 = add nsw i64 %540, %indvars.iv.25
  %arrayidx134.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %554
  %555 = load i32, i32* %arrayidx134.25, align 4
  %cmp135.25 = icmp eq i32 %555, 255
  br i1 %cmp135.25, label %if.then146.25, label %lor.lhs.false137.25

lor.lhs.false137.25:                              ; preds = %lor.lhs.false129.25
  %add141.25 = add i32 %sub81.25, 129
  %idxprom142.25 = sext i32 %add141.25 to i64
  %arrayidx143.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.25
  %556 = load i32, i32* %arrayidx143.25, align 4
  %cmp144.25 = icmp eq i32 %556, 255
  br i1 %cmp144.25, label %if.then146.25, label %if.else149.25

if.else149.25:                                    ; preds = %lor.lhs.false137.25
  %arrayidx151.25 = getelementptr inbounds i8, i8* %0, i64 %542
  store i8 0, i8* %arrayidx151.25, align 1
  br label %for.inc161.25

if.then146.25:                                    ; preds = %lor.lhs.false137.25, %lor.lhs.false129.25, %lor.lhs.false120.25, %lor.lhs.false112.25, %lor.lhs.false104.25, %lor.lhs.false95.25, %lor.lhs.false87.25, %if.then78.25
  %arrayidx148.25 = getelementptr inbounds i8, i8* %0, i64 %542
  store i8 -1, i8* %arrayidx148.25, align 1
  br label %for.inc161.25

if.then70.25:                                     ; preds = %for.body56.25
  %arrayidx72.25 = getelementptr inbounds i8, i8* %0, i64 %542
  store i8 0, i8* %arrayidx72.25, align 1
  br label %for.inc161.25

for.inc161.25:                                    ; preds = %if.then70.25, %if.then146.25, %if.else149.25, %if.else153.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %img_width
  br i1 %exitcond.25, label %for.inc164.25, label %for.body56.25, !llvm.loop !5

for.inc164.25:                                    ; preds = %for.inc161.25
  %indvars.iv.next20.25 = add nsw i64 %indvars.iv19, 26
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.26

for.body56.lr.ph.26:                              ; preds = %for.inc164.25
  %557 = trunc i64 %indvars.iv.next20.25 to i32
  %mul58.26 = shl nsw i32 %557, 7
  %cmp62.26 = icmp eq i64 %indvars.iv.next20.25, %12
  %558 = trunc i64 %indvars.iv.next20.25 to i32
  %sub79.26 = shl i32 %558, 7
  %mul89.26 = add i32 %sub79.26, -128
  %sub106.26 = add i32 %mul58.26, -1
  %add114.26 = or i32 %mul58.26, 1
  %mul131.26 = add i32 %sub79.26, 128
  %559 = sext i32 %mul58.26 to i64
  %560 = sext i32 %mul131.26 to i64
  %561 = sext i32 %mul89.26 to i64
  br label %for.body56.26

for.body56.26:                                    ; preds = %for.inc161.26, %for.body56.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body56.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc161.26 ]
  %562 = add nsw i64 %indvars.iv.26, %559
  %cmp65.26 = icmp eq i64 %indvars.iv.26, 0
  %or.cond1.26 = or i1 %cmp62.26, %cmp65.26
  %cmp68.26 = icmp eq i64 %indvars.iv.26, %11
  %or.cond2.26 = or i1 %cmp68.26, %or.cond1.26
  br i1 %or.cond2.26, label %if.then70.26, label %if.else73.26

if.else73.26:                                     ; preds = %for.body56.26
  %arrayidx75.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %562
  %563 = load i32, i32* %arrayidx75.26, align 4
  %cmp76.26 = icmp eq i32 %563, 75
  br i1 %cmp76.26, label %if.then78.26, label %if.else153.26

if.else153.26:                                    ; preds = %if.else73.26
  %conv156.26 = trunc i32 %563 to i8
  %arrayidx158.26 = getelementptr inbounds i8, i8* %0, i64 %562
  store i8 %conv156.26, i8* %arrayidx158.26, align 1
  br label %for.inc161.26

if.then78.26:                                     ; preds = %if.else73.26
  %564 = trunc i64 %indvars.iv.26 to i32
  %sub81.26 = add i32 %564, %sub79.26
  %add82.26 = add i32 %sub81.26, -129
  %idxprom83.26 = sext i32 %add82.26 to i64
  %arrayidx84.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.26
  %565 = load i32, i32* %arrayidx84.26, align 4
  %cmp85.26 = icmp eq i32 %565, 255
  br i1 %cmp85.26, label %if.then146.26, label %lor.lhs.false87.26

lor.lhs.false87.26:                               ; preds = %if.then78.26
  %566 = add nsw i64 %561, %indvars.iv.26
  %arrayidx92.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %566
  %567 = load i32, i32* %arrayidx92.26, align 4
  %cmp93.26 = icmp eq i32 %567, 255
  br i1 %cmp93.26, label %if.then146.26, label %lor.lhs.false95.26

lor.lhs.false95.26:                               ; preds = %lor.lhs.false87.26
  %add99.26 = add i32 %sub81.26, -127
  %idxprom100.26 = sext i32 %add99.26 to i64
  %arrayidx101.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.26
  %568 = load i32, i32* %arrayidx101.26, align 4
  %cmp102.26 = icmp eq i32 %568, 255
  br i1 %cmp102.26, label %if.then146.26, label %lor.lhs.false104.26

lor.lhs.false104.26:                              ; preds = %lor.lhs.false95.26
  %569 = trunc i64 %indvars.iv.26 to i32
  %add107.26 = add i32 %sub106.26, %569
  %idxprom108.26 = sext i32 %add107.26 to i64
  %arrayidx109.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.26
  %570 = load i32, i32* %arrayidx109.26, align 4
  %cmp110.26 = icmp eq i32 %570, 255
  br i1 %cmp110.26, label %if.then146.26, label %lor.lhs.false112.26

lor.lhs.false112.26:                              ; preds = %lor.lhs.false104.26
  %571 = trunc i64 %indvars.iv.26 to i32
  %add115.26 = add i32 %add114.26, %571
  %idxprom116.26 = sext i32 %add115.26 to i64
  %arrayidx117.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.26
  %572 = load i32, i32* %arrayidx117.26, align 4
  %cmp118.26 = icmp eq i32 %572, 255
  br i1 %cmp118.26, label %if.then146.26, label %lor.lhs.false120.26

lor.lhs.false120.26:                              ; preds = %lor.lhs.false112.26
  %add124.26 = add i32 %sub81.26, 127
  %idxprom125.26 = sext i32 %add124.26 to i64
  %arrayidx126.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.26
  %573 = load i32, i32* %arrayidx126.26, align 4
  %cmp127.26 = icmp eq i32 %573, 255
  br i1 %cmp127.26, label %if.then146.26, label %lor.lhs.false129.26

lor.lhs.false129.26:                              ; preds = %lor.lhs.false120.26
  %574 = add nsw i64 %560, %indvars.iv.26
  %arrayidx134.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %574
  %575 = load i32, i32* %arrayidx134.26, align 4
  %cmp135.26 = icmp eq i32 %575, 255
  br i1 %cmp135.26, label %if.then146.26, label %lor.lhs.false137.26

lor.lhs.false137.26:                              ; preds = %lor.lhs.false129.26
  %add141.26 = add i32 %sub81.26, 129
  %idxprom142.26 = sext i32 %add141.26 to i64
  %arrayidx143.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.26
  %576 = load i32, i32* %arrayidx143.26, align 4
  %cmp144.26 = icmp eq i32 %576, 255
  br i1 %cmp144.26, label %if.then146.26, label %if.else149.26

if.else149.26:                                    ; preds = %lor.lhs.false137.26
  %arrayidx151.26 = getelementptr inbounds i8, i8* %0, i64 %562
  store i8 0, i8* %arrayidx151.26, align 1
  br label %for.inc161.26

if.then146.26:                                    ; preds = %lor.lhs.false137.26, %lor.lhs.false129.26, %lor.lhs.false120.26, %lor.lhs.false112.26, %lor.lhs.false104.26, %lor.lhs.false95.26, %lor.lhs.false87.26, %if.then78.26
  %arrayidx148.26 = getelementptr inbounds i8, i8* %0, i64 %562
  store i8 -1, i8* %arrayidx148.26, align 1
  br label %for.inc161.26

if.then70.26:                                     ; preds = %for.body56.26
  %arrayidx72.26 = getelementptr inbounds i8, i8* %0, i64 %562
  store i8 0, i8* %arrayidx72.26, align 1
  br label %for.inc161.26

for.inc161.26:                                    ; preds = %if.then70.26, %if.then146.26, %if.else149.26, %if.else153.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %img_width
  br i1 %exitcond.26, label %for.inc164.26, label %for.body56.26, !llvm.loop !5

for.inc164.26:                                    ; preds = %for.inc161.26
  %indvars.iv.next20.26 = add nsw i64 %indvars.iv19, 27
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.27

for.body56.lr.ph.27:                              ; preds = %for.inc164.26
  %577 = trunc i64 %indvars.iv.next20.26 to i32
  %mul58.27 = shl nsw i32 %577, 7
  %cmp62.27 = icmp eq i64 %indvars.iv.next20.26, %12
  %578 = trunc i64 %indvars.iv.next20.26 to i32
  %sub79.27 = shl i32 %578, 7
  %mul89.27 = add i32 %sub79.27, -128
  %sub106.27 = add i32 %mul58.27, -1
  %add114.27 = or i32 %mul58.27, 1
  %mul131.27 = add i32 %sub79.27, 128
  %579 = sext i32 %mul58.27 to i64
  %580 = sext i32 %mul131.27 to i64
  %581 = sext i32 %mul89.27 to i64
  br label %for.body56.27

for.body56.27:                                    ; preds = %for.inc161.27, %for.body56.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body56.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc161.27 ]
  %582 = add nsw i64 %indvars.iv.27, %579
  %cmp65.27 = icmp eq i64 %indvars.iv.27, 0
  %or.cond1.27 = or i1 %cmp62.27, %cmp65.27
  %cmp68.27 = icmp eq i64 %indvars.iv.27, %11
  %or.cond2.27 = or i1 %cmp68.27, %or.cond1.27
  br i1 %or.cond2.27, label %if.then70.27, label %if.else73.27

if.else73.27:                                     ; preds = %for.body56.27
  %arrayidx75.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %582
  %583 = load i32, i32* %arrayidx75.27, align 4
  %cmp76.27 = icmp eq i32 %583, 75
  br i1 %cmp76.27, label %if.then78.27, label %if.else153.27

if.else153.27:                                    ; preds = %if.else73.27
  %conv156.27 = trunc i32 %583 to i8
  %arrayidx158.27 = getelementptr inbounds i8, i8* %0, i64 %582
  store i8 %conv156.27, i8* %arrayidx158.27, align 1
  br label %for.inc161.27

if.then78.27:                                     ; preds = %if.else73.27
  %584 = trunc i64 %indvars.iv.27 to i32
  %sub81.27 = add i32 %584, %sub79.27
  %add82.27 = add i32 %sub81.27, -129
  %idxprom83.27 = sext i32 %add82.27 to i64
  %arrayidx84.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.27
  %585 = load i32, i32* %arrayidx84.27, align 4
  %cmp85.27 = icmp eq i32 %585, 255
  br i1 %cmp85.27, label %if.then146.27, label %lor.lhs.false87.27

lor.lhs.false87.27:                               ; preds = %if.then78.27
  %586 = add nsw i64 %581, %indvars.iv.27
  %arrayidx92.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %586
  %587 = load i32, i32* %arrayidx92.27, align 4
  %cmp93.27 = icmp eq i32 %587, 255
  br i1 %cmp93.27, label %if.then146.27, label %lor.lhs.false95.27

lor.lhs.false95.27:                               ; preds = %lor.lhs.false87.27
  %add99.27 = add i32 %sub81.27, -127
  %idxprom100.27 = sext i32 %add99.27 to i64
  %arrayidx101.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.27
  %588 = load i32, i32* %arrayidx101.27, align 4
  %cmp102.27 = icmp eq i32 %588, 255
  br i1 %cmp102.27, label %if.then146.27, label %lor.lhs.false104.27

lor.lhs.false104.27:                              ; preds = %lor.lhs.false95.27
  %589 = trunc i64 %indvars.iv.27 to i32
  %add107.27 = add i32 %sub106.27, %589
  %idxprom108.27 = sext i32 %add107.27 to i64
  %arrayidx109.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.27
  %590 = load i32, i32* %arrayidx109.27, align 4
  %cmp110.27 = icmp eq i32 %590, 255
  br i1 %cmp110.27, label %if.then146.27, label %lor.lhs.false112.27

lor.lhs.false112.27:                              ; preds = %lor.lhs.false104.27
  %591 = trunc i64 %indvars.iv.27 to i32
  %add115.27 = add i32 %add114.27, %591
  %idxprom116.27 = sext i32 %add115.27 to i64
  %arrayidx117.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.27
  %592 = load i32, i32* %arrayidx117.27, align 4
  %cmp118.27 = icmp eq i32 %592, 255
  br i1 %cmp118.27, label %if.then146.27, label %lor.lhs.false120.27

lor.lhs.false120.27:                              ; preds = %lor.lhs.false112.27
  %add124.27 = add i32 %sub81.27, 127
  %idxprom125.27 = sext i32 %add124.27 to i64
  %arrayidx126.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.27
  %593 = load i32, i32* %arrayidx126.27, align 4
  %cmp127.27 = icmp eq i32 %593, 255
  br i1 %cmp127.27, label %if.then146.27, label %lor.lhs.false129.27

lor.lhs.false129.27:                              ; preds = %lor.lhs.false120.27
  %594 = add nsw i64 %580, %indvars.iv.27
  %arrayidx134.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %594
  %595 = load i32, i32* %arrayidx134.27, align 4
  %cmp135.27 = icmp eq i32 %595, 255
  br i1 %cmp135.27, label %if.then146.27, label %lor.lhs.false137.27

lor.lhs.false137.27:                              ; preds = %lor.lhs.false129.27
  %add141.27 = add i32 %sub81.27, 129
  %idxprom142.27 = sext i32 %add141.27 to i64
  %arrayidx143.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.27
  %596 = load i32, i32* %arrayidx143.27, align 4
  %cmp144.27 = icmp eq i32 %596, 255
  br i1 %cmp144.27, label %if.then146.27, label %if.else149.27

if.else149.27:                                    ; preds = %lor.lhs.false137.27
  %arrayidx151.27 = getelementptr inbounds i8, i8* %0, i64 %582
  store i8 0, i8* %arrayidx151.27, align 1
  br label %for.inc161.27

if.then146.27:                                    ; preds = %lor.lhs.false137.27, %lor.lhs.false129.27, %lor.lhs.false120.27, %lor.lhs.false112.27, %lor.lhs.false104.27, %lor.lhs.false95.27, %lor.lhs.false87.27, %if.then78.27
  %arrayidx148.27 = getelementptr inbounds i8, i8* %0, i64 %582
  store i8 -1, i8* %arrayidx148.27, align 1
  br label %for.inc161.27

if.then70.27:                                     ; preds = %for.body56.27
  %arrayidx72.27 = getelementptr inbounds i8, i8* %0, i64 %582
  store i8 0, i8* %arrayidx72.27, align 1
  br label %for.inc161.27

for.inc161.27:                                    ; preds = %if.then70.27, %if.then146.27, %if.else149.27, %if.else153.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %img_width
  br i1 %exitcond.27, label %for.inc164.27, label %for.body56.27, !llvm.loop !5

for.inc164.27:                                    ; preds = %for.inc161.27
  %indvars.iv.next20.27 = add nsw i64 %indvars.iv19, 28
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.28

for.body56.lr.ph.28:                              ; preds = %for.inc164.27
  %597 = trunc i64 %indvars.iv.next20.27 to i32
  %mul58.28 = shl nsw i32 %597, 7
  %cmp62.28 = icmp eq i64 %indvars.iv.next20.27, %12
  %598 = trunc i64 %indvars.iv.next20.27 to i32
  %sub79.28 = shl i32 %598, 7
  %mul89.28 = add i32 %sub79.28, -128
  %sub106.28 = add i32 %mul58.28, -1
  %add114.28 = or i32 %mul58.28, 1
  %mul131.28 = add i32 %sub79.28, 128
  %599 = sext i32 %mul58.28 to i64
  %600 = sext i32 %mul131.28 to i64
  %601 = sext i32 %mul89.28 to i64
  br label %for.body56.28

for.body56.28:                                    ; preds = %for.inc161.28, %for.body56.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body56.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc161.28 ]
  %602 = add nsw i64 %indvars.iv.28, %599
  %cmp65.28 = icmp eq i64 %indvars.iv.28, 0
  %or.cond1.28 = or i1 %cmp62.28, %cmp65.28
  %cmp68.28 = icmp eq i64 %indvars.iv.28, %11
  %or.cond2.28 = or i1 %cmp68.28, %or.cond1.28
  br i1 %or.cond2.28, label %if.then70.28, label %if.else73.28

if.else73.28:                                     ; preds = %for.body56.28
  %arrayidx75.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %602
  %603 = load i32, i32* %arrayidx75.28, align 4
  %cmp76.28 = icmp eq i32 %603, 75
  br i1 %cmp76.28, label %if.then78.28, label %if.else153.28

if.else153.28:                                    ; preds = %if.else73.28
  %conv156.28 = trunc i32 %603 to i8
  %arrayidx158.28 = getelementptr inbounds i8, i8* %0, i64 %602
  store i8 %conv156.28, i8* %arrayidx158.28, align 1
  br label %for.inc161.28

if.then78.28:                                     ; preds = %if.else73.28
  %604 = trunc i64 %indvars.iv.28 to i32
  %sub81.28 = add i32 %604, %sub79.28
  %add82.28 = add i32 %sub81.28, -129
  %idxprom83.28 = sext i32 %add82.28 to i64
  %arrayidx84.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.28
  %605 = load i32, i32* %arrayidx84.28, align 4
  %cmp85.28 = icmp eq i32 %605, 255
  br i1 %cmp85.28, label %if.then146.28, label %lor.lhs.false87.28

lor.lhs.false87.28:                               ; preds = %if.then78.28
  %606 = add nsw i64 %601, %indvars.iv.28
  %arrayidx92.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %606
  %607 = load i32, i32* %arrayidx92.28, align 4
  %cmp93.28 = icmp eq i32 %607, 255
  br i1 %cmp93.28, label %if.then146.28, label %lor.lhs.false95.28

lor.lhs.false95.28:                               ; preds = %lor.lhs.false87.28
  %add99.28 = add i32 %sub81.28, -127
  %idxprom100.28 = sext i32 %add99.28 to i64
  %arrayidx101.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.28
  %608 = load i32, i32* %arrayidx101.28, align 4
  %cmp102.28 = icmp eq i32 %608, 255
  br i1 %cmp102.28, label %if.then146.28, label %lor.lhs.false104.28

lor.lhs.false104.28:                              ; preds = %lor.lhs.false95.28
  %609 = trunc i64 %indvars.iv.28 to i32
  %add107.28 = add i32 %sub106.28, %609
  %idxprom108.28 = sext i32 %add107.28 to i64
  %arrayidx109.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.28
  %610 = load i32, i32* %arrayidx109.28, align 4
  %cmp110.28 = icmp eq i32 %610, 255
  br i1 %cmp110.28, label %if.then146.28, label %lor.lhs.false112.28

lor.lhs.false112.28:                              ; preds = %lor.lhs.false104.28
  %611 = trunc i64 %indvars.iv.28 to i32
  %add115.28 = add i32 %add114.28, %611
  %idxprom116.28 = sext i32 %add115.28 to i64
  %arrayidx117.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.28
  %612 = load i32, i32* %arrayidx117.28, align 4
  %cmp118.28 = icmp eq i32 %612, 255
  br i1 %cmp118.28, label %if.then146.28, label %lor.lhs.false120.28

lor.lhs.false120.28:                              ; preds = %lor.lhs.false112.28
  %add124.28 = add i32 %sub81.28, 127
  %idxprom125.28 = sext i32 %add124.28 to i64
  %arrayidx126.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.28
  %613 = load i32, i32* %arrayidx126.28, align 4
  %cmp127.28 = icmp eq i32 %613, 255
  br i1 %cmp127.28, label %if.then146.28, label %lor.lhs.false129.28

lor.lhs.false129.28:                              ; preds = %lor.lhs.false120.28
  %614 = add nsw i64 %600, %indvars.iv.28
  %arrayidx134.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %614
  %615 = load i32, i32* %arrayidx134.28, align 4
  %cmp135.28 = icmp eq i32 %615, 255
  br i1 %cmp135.28, label %if.then146.28, label %lor.lhs.false137.28

lor.lhs.false137.28:                              ; preds = %lor.lhs.false129.28
  %add141.28 = add i32 %sub81.28, 129
  %idxprom142.28 = sext i32 %add141.28 to i64
  %arrayidx143.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.28
  %616 = load i32, i32* %arrayidx143.28, align 4
  %cmp144.28 = icmp eq i32 %616, 255
  br i1 %cmp144.28, label %if.then146.28, label %if.else149.28

if.else149.28:                                    ; preds = %lor.lhs.false137.28
  %arrayidx151.28 = getelementptr inbounds i8, i8* %0, i64 %602
  store i8 0, i8* %arrayidx151.28, align 1
  br label %for.inc161.28

if.then146.28:                                    ; preds = %lor.lhs.false137.28, %lor.lhs.false129.28, %lor.lhs.false120.28, %lor.lhs.false112.28, %lor.lhs.false104.28, %lor.lhs.false95.28, %lor.lhs.false87.28, %if.then78.28
  %arrayidx148.28 = getelementptr inbounds i8, i8* %0, i64 %602
  store i8 -1, i8* %arrayidx148.28, align 1
  br label %for.inc161.28

if.then70.28:                                     ; preds = %for.body56.28
  %arrayidx72.28 = getelementptr inbounds i8, i8* %0, i64 %602
  store i8 0, i8* %arrayidx72.28, align 1
  br label %for.inc161.28

for.inc161.28:                                    ; preds = %if.then70.28, %if.then146.28, %if.else149.28, %if.else153.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %img_width
  br i1 %exitcond.28, label %for.inc164.28, label %for.body56.28, !llvm.loop !5

for.inc164.28:                                    ; preds = %for.inc161.28
  %indvars.iv.next20.28 = add nsw i64 %indvars.iv19, 29
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.29

for.body56.lr.ph.29:                              ; preds = %for.inc164.28
  %617 = trunc i64 %indvars.iv.next20.28 to i32
  %mul58.29 = shl nsw i32 %617, 7
  %cmp62.29 = icmp eq i64 %indvars.iv.next20.28, %12
  %618 = trunc i64 %indvars.iv.next20.28 to i32
  %sub79.29 = shl i32 %618, 7
  %mul89.29 = add i32 %sub79.29, -128
  %sub106.29 = add i32 %mul58.29, -1
  %add114.29 = or i32 %mul58.29, 1
  %mul131.29 = add i32 %sub79.29, 128
  %619 = sext i32 %mul58.29 to i64
  %620 = sext i32 %mul131.29 to i64
  %621 = sext i32 %mul89.29 to i64
  br label %for.body56.29

for.body56.29:                                    ; preds = %for.inc161.29, %for.body56.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body56.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc161.29 ]
  %622 = add nsw i64 %indvars.iv.29, %619
  %cmp65.29 = icmp eq i64 %indvars.iv.29, 0
  %or.cond1.29 = or i1 %cmp62.29, %cmp65.29
  %cmp68.29 = icmp eq i64 %indvars.iv.29, %11
  %or.cond2.29 = or i1 %cmp68.29, %or.cond1.29
  br i1 %or.cond2.29, label %if.then70.29, label %if.else73.29

if.else73.29:                                     ; preds = %for.body56.29
  %arrayidx75.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %622
  %623 = load i32, i32* %arrayidx75.29, align 4
  %cmp76.29 = icmp eq i32 %623, 75
  br i1 %cmp76.29, label %if.then78.29, label %if.else153.29

if.else153.29:                                    ; preds = %if.else73.29
  %conv156.29 = trunc i32 %623 to i8
  %arrayidx158.29 = getelementptr inbounds i8, i8* %0, i64 %622
  store i8 %conv156.29, i8* %arrayidx158.29, align 1
  br label %for.inc161.29

if.then78.29:                                     ; preds = %if.else73.29
  %624 = trunc i64 %indvars.iv.29 to i32
  %sub81.29 = add i32 %624, %sub79.29
  %add82.29 = add i32 %sub81.29, -129
  %idxprom83.29 = sext i32 %add82.29 to i64
  %arrayidx84.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.29
  %625 = load i32, i32* %arrayidx84.29, align 4
  %cmp85.29 = icmp eq i32 %625, 255
  br i1 %cmp85.29, label %if.then146.29, label %lor.lhs.false87.29

lor.lhs.false87.29:                               ; preds = %if.then78.29
  %626 = add nsw i64 %621, %indvars.iv.29
  %arrayidx92.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %626
  %627 = load i32, i32* %arrayidx92.29, align 4
  %cmp93.29 = icmp eq i32 %627, 255
  br i1 %cmp93.29, label %if.then146.29, label %lor.lhs.false95.29

lor.lhs.false95.29:                               ; preds = %lor.lhs.false87.29
  %add99.29 = add i32 %sub81.29, -127
  %idxprom100.29 = sext i32 %add99.29 to i64
  %arrayidx101.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.29
  %628 = load i32, i32* %arrayidx101.29, align 4
  %cmp102.29 = icmp eq i32 %628, 255
  br i1 %cmp102.29, label %if.then146.29, label %lor.lhs.false104.29

lor.lhs.false104.29:                              ; preds = %lor.lhs.false95.29
  %629 = trunc i64 %indvars.iv.29 to i32
  %add107.29 = add i32 %sub106.29, %629
  %idxprom108.29 = sext i32 %add107.29 to i64
  %arrayidx109.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.29
  %630 = load i32, i32* %arrayidx109.29, align 4
  %cmp110.29 = icmp eq i32 %630, 255
  br i1 %cmp110.29, label %if.then146.29, label %lor.lhs.false112.29

lor.lhs.false112.29:                              ; preds = %lor.lhs.false104.29
  %631 = trunc i64 %indvars.iv.29 to i32
  %add115.29 = add i32 %add114.29, %631
  %idxprom116.29 = sext i32 %add115.29 to i64
  %arrayidx117.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.29
  %632 = load i32, i32* %arrayidx117.29, align 4
  %cmp118.29 = icmp eq i32 %632, 255
  br i1 %cmp118.29, label %if.then146.29, label %lor.lhs.false120.29

lor.lhs.false120.29:                              ; preds = %lor.lhs.false112.29
  %add124.29 = add i32 %sub81.29, 127
  %idxprom125.29 = sext i32 %add124.29 to i64
  %arrayidx126.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.29
  %633 = load i32, i32* %arrayidx126.29, align 4
  %cmp127.29 = icmp eq i32 %633, 255
  br i1 %cmp127.29, label %if.then146.29, label %lor.lhs.false129.29

lor.lhs.false129.29:                              ; preds = %lor.lhs.false120.29
  %634 = add nsw i64 %620, %indvars.iv.29
  %arrayidx134.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %634
  %635 = load i32, i32* %arrayidx134.29, align 4
  %cmp135.29 = icmp eq i32 %635, 255
  br i1 %cmp135.29, label %if.then146.29, label %lor.lhs.false137.29

lor.lhs.false137.29:                              ; preds = %lor.lhs.false129.29
  %add141.29 = add i32 %sub81.29, 129
  %idxprom142.29 = sext i32 %add141.29 to i64
  %arrayidx143.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.29
  %636 = load i32, i32* %arrayidx143.29, align 4
  %cmp144.29 = icmp eq i32 %636, 255
  br i1 %cmp144.29, label %if.then146.29, label %if.else149.29

if.else149.29:                                    ; preds = %lor.lhs.false137.29
  %arrayidx151.29 = getelementptr inbounds i8, i8* %0, i64 %622
  store i8 0, i8* %arrayidx151.29, align 1
  br label %for.inc161.29

if.then146.29:                                    ; preds = %lor.lhs.false137.29, %lor.lhs.false129.29, %lor.lhs.false120.29, %lor.lhs.false112.29, %lor.lhs.false104.29, %lor.lhs.false95.29, %lor.lhs.false87.29, %if.then78.29
  %arrayidx148.29 = getelementptr inbounds i8, i8* %0, i64 %622
  store i8 -1, i8* %arrayidx148.29, align 1
  br label %for.inc161.29

if.then70.29:                                     ; preds = %for.body56.29
  %arrayidx72.29 = getelementptr inbounds i8, i8* %0, i64 %622
  store i8 0, i8* %arrayidx72.29, align 1
  br label %for.inc161.29

for.inc161.29:                                    ; preds = %if.then70.29, %if.then146.29, %if.else149.29, %if.else153.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %img_width
  br i1 %exitcond.29, label %for.inc164.29, label %for.body56.29, !llvm.loop !5

for.inc164.29:                                    ; preds = %for.inc161.29
  %indvars.iv.next20.29 = add nsw i64 %indvars.iv19, 30
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.30

for.body56.lr.ph.30:                              ; preds = %for.inc164.29
  %637 = trunc i64 %indvars.iv.next20.29 to i32
  %mul58.30 = shl nsw i32 %637, 7
  %cmp62.30 = icmp eq i64 %indvars.iv.next20.29, %12
  %638 = trunc i64 %indvars.iv.next20.29 to i32
  %sub79.30 = shl i32 %638, 7
  %mul89.30 = add i32 %sub79.30, -128
  %sub106.30 = add i32 %mul58.30, -1
  %add114.30 = or i32 %mul58.30, 1
  %mul131.30 = add i32 %sub79.30, 128
  %639 = sext i32 %mul58.30 to i64
  %640 = sext i32 %mul131.30 to i64
  %641 = sext i32 %mul89.30 to i64
  br label %for.body56.30

for.body56.30:                                    ; preds = %for.inc161.30, %for.body56.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body56.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc161.30 ]
  %642 = add nsw i64 %indvars.iv.30, %639
  %cmp65.30 = icmp eq i64 %indvars.iv.30, 0
  %or.cond1.30 = or i1 %cmp62.30, %cmp65.30
  %cmp68.30 = icmp eq i64 %indvars.iv.30, %11
  %or.cond2.30 = or i1 %cmp68.30, %or.cond1.30
  br i1 %or.cond2.30, label %if.then70.30, label %if.else73.30

if.else73.30:                                     ; preds = %for.body56.30
  %arrayidx75.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %642
  %643 = load i32, i32* %arrayidx75.30, align 4
  %cmp76.30 = icmp eq i32 %643, 75
  br i1 %cmp76.30, label %if.then78.30, label %if.else153.30

if.else153.30:                                    ; preds = %if.else73.30
  %conv156.30 = trunc i32 %643 to i8
  %arrayidx158.30 = getelementptr inbounds i8, i8* %0, i64 %642
  store i8 %conv156.30, i8* %arrayidx158.30, align 1
  br label %for.inc161.30

if.then78.30:                                     ; preds = %if.else73.30
  %644 = trunc i64 %indvars.iv.30 to i32
  %sub81.30 = add i32 %644, %sub79.30
  %add82.30 = add i32 %sub81.30, -129
  %idxprom83.30 = sext i32 %add82.30 to i64
  %arrayidx84.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.30
  %645 = load i32, i32* %arrayidx84.30, align 4
  %cmp85.30 = icmp eq i32 %645, 255
  br i1 %cmp85.30, label %if.then146.30, label %lor.lhs.false87.30

lor.lhs.false87.30:                               ; preds = %if.then78.30
  %646 = add nsw i64 %641, %indvars.iv.30
  %arrayidx92.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %646
  %647 = load i32, i32* %arrayidx92.30, align 4
  %cmp93.30 = icmp eq i32 %647, 255
  br i1 %cmp93.30, label %if.then146.30, label %lor.lhs.false95.30

lor.lhs.false95.30:                               ; preds = %lor.lhs.false87.30
  %add99.30 = add i32 %sub81.30, -127
  %idxprom100.30 = sext i32 %add99.30 to i64
  %arrayidx101.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.30
  %648 = load i32, i32* %arrayidx101.30, align 4
  %cmp102.30 = icmp eq i32 %648, 255
  br i1 %cmp102.30, label %if.then146.30, label %lor.lhs.false104.30

lor.lhs.false104.30:                              ; preds = %lor.lhs.false95.30
  %649 = trunc i64 %indvars.iv.30 to i32
  %add107.30 = add i32 %sub106.30, %649
  %idxprom108.30 = sext i32 %add107.30 to i64
  %arrayidx109.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.30
  %650 = load i32, i32* %arrayidx109.30, align 4
  %cmp110.30 = icmp eq i32 %650, 255
  br i1 %cmp110.30, label %if.then146.30, label %lor.lhs.false112.30

lor.lhs.false112.30:                              ; preds = %lor.lhs.false104.30
  %651 = trunc i64 %indvars.iv.30 to i32
  %add115.30 = add i32 %add114.30, %651
  %idxprom116.30 = sext i32 %add115.30 to i64
  %arrayidx117.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.30
  %652 = load i32, i32* %arrayidx117.30, align 4
  %cmp118.30 = icmp eq i32 %652, 255
  br i1 %cmp118.30, label %if.then146.30, label %lor.lhs.false120.30

lor.lhs.false120.30:                              ; preds = %lor.lhs.false112.30
  %add124.30 = add i32 %sub81.30, 127
  %idxprom125.30 = sext i32 %add124.30 to i64
  %arrayidx126.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.30
  %653 = load i32, i32* %arrayidx126.30, align 4
  %cmp127.30 = icmp eq i32 %653, 255
  br i1 %cmp127.30, label %if.then146.30, label %lor.lhs.false129.30

lor.lhs.false129.30:                              ; preds = %lor.lhs.false120.30
  %654 = add nsw i64 %640, %indvars.iv.30
  %arrayidx134.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %654
  %655 = load i32, i32* %arrayidx134.30, align 4
  %cmp135.30 = icmp eq i32 %655, 255
  br i1 %cmp135.30, label %if.then146.30, label %lor.lhs.false137.30

lor.lhs.false137.30:                              ; preds = %lor.lhs.false129.30
  %add141.30 = add i32 %sub81.30, 129
  %idxprom142.30 = sext i32 %add141.30 to i64
  %arrayidx143.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.30
  %656 = load i32, i32* %arrayidx143.30, align 4
  %cmp144.30 = icmp eq i32 %656, 255
  br i1 %cmp144.30, label %if.then146.30, label %if.else149.30

if.else149.30:                                    ; preds = %lor.lhs.false137.30
  %arrayidx151.30 = getelementptr inbounds i8, i8* %0, i64 %642
  store i8 0, i8* %arrayidx151.30, align 1
  br label %for.inc161.30

if.then146.30:                                    ; preds = %lor.lhs.false137.30, %lor.lhs.false129.30, %lor.lhs.false120.30, %lor.lhs.false112.30, %lor.lhs.false104.30, %lor.lhs.false95.30, %lor.lhs.false87.30, %if.then78.30
  %arrayidx148.30 = getelementptr inbounds i8, i8* %0, i64 %642
  store i8 -1, i8* %arrayidx148.30, align 1
  br label %for.inc161.30

if.then70.30:                                     ; preds = %for.body56.30
  %arrayidx72.30 = getelementptr inbounds i8, i8* %0, i64 %642
  store i8 0, i8* %arrayidx72.30, align 1
  br label %for.inc161.30

for.inc161.30:                                    ; preds = %if.then70.30, %if.then146.30, %if.else149.30, %if.else153.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %img_width
  br i1 %exitcond.30, label %for.inc164.30, label %for.body56.30, !llvm.loop !5

for.inc164.30:                                    ; preds = %for.inc161.30
  %indvars.iv.next20.30 = add nsw i64 %indvars.iv19, 31
  br i1 %cmp543, label %for.inc164.31, label %for.body56.lr.ph.31

for.body56.lr.ph.31:                              ; preds = %for.inc164.30
  %657 = trunc i64 %indvars.iv.next20.30 to i32
  %mul58.31 = shl nsw i32 %657, 7
  %cmp62.31 = icmp eq i64 %indvars.iv.next20.30, %12
  %658 = trunc i64 %indvars.iv.next20.30 to i32
  %sub79.31 = shl i32 %658, 7
  %mul89.31 = add i32 %sub79.31, -128
  %sub106.31 = add i32 %mul58.31, -1
  %add114.31 = or i32 %mul58.31, 1
  %mul131.31 = add i32 %sub79.31, 128
  %659 = sext i32 %mul58.31 to i64
  %660 = sext i32 %mul131.31 to i64
  %661 = sext i32 %mul89.31 to i64
  br label %for.body56.31

for.body56.31:                                    ; preds = %for.inc161.31, %for.body56.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body56.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc161.31 ]
  %662 = add nsw i64 %indvars.iv.31, %659
  %cmp65.31 = icmp eq i64 %indvars.iv.31, 0
  %or.cond1.31 = or i1 %cmp62.31, %cmp65.31
  %cmp68.31 = icmp eq i64 %indvars.iv.31, %11
  %or.cond2.31 = or i1 %cmp68.31, %or.cond1.31
  br i1 %or.cond2.31, label %if.then70.31, label %if.else73.31

if.else73.31:                                     ; preds = %for.body56.31
  %arrayidx75.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %662
  %663 = load i32, i32* %arrayidx75.31, align 4
  %cmp76.31 = icmp eq i32 %663, 75
  br i1 %cmp76.31, label %if.then78.31, label %if.else153.31

if.else153.31:                                    ; preds = %if.else73.31
  %conv156.31 = trunc i32 %663 to i8
  %arrayidx158.31 = getelementptr inbounds i8, i8* %0, i64 %662
  store i8 %conv156.31, i8* %arrayidx158.31, align 1
  br label %for.inc161.31

if.then78.31:                                     ; preds = %if.else73.31
  %664 = trunc i64 %indvars.iv.31 to i32
  %sub81.31 = add i32 %664, %sub79.31
  %add82.31 = add i32 %sub81.31, -129
  %idxprom83.31 = sext i32 %add82.31 to i64
  %arrayidx84.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom83.31
  %665 = load i32, i32* %arrayidx84.31, align 4
  %cmp85.31 = icmp eq i32 %665, 255
  br i1 %cmp85.31, label %if.then146.31, label %lor.lhs.false87.31

lor.lhs.false87.31:                               ; preds = %if.then78.31
  %666 = add nsw i64 %661, %indvars.iv.31
  %arrayidx92.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %666
  %667 = load i32, i32* %arrayidx92.31, align 4
  %cmp93.31 = icmp eq i32 %667, 255
  br i1 %cmp93.31, label %if.then146.31, label %lor.lhs.false95.31

lor.lhs.false95.31:                               ; preds = %lor.lhs.false87.31
  %add99.31 = add i32 %sub81.31, -127
  %idxprom100.31 = sext i32 %add99.31 to i64
  %arrayidx101.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom100.31
  %668 = load i32, i32* %arrayidx101.31, align 4
  %cmp102.31 = icmp eq i32 %668, 255
  br i1 %cmp102.31, label %if.then146.31, label %lor.lhs.false104.31

lor.lhs.false104.31:                              ; preds = %lor.lhs.false95.31
  %669 = trunc i64 %indvars.iv.31 to i32
  %add107.31 = add i32 %sub106.31, %669
  %idxprom108.31 = sext i32 %add107.31 to i64
  %arrayidx109.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom108.31
  %670 = load i32, i32* %arrayidx109.31, align 4
  %cmp110.31 = icmp eq i32 %670, 255
  br i1 %cmp110.31, label %if.then146.31, label %lor.lhs.false112.31

lor.lhs.false112.31:                              ; preds = %lor.lhs.false104.31
  %671 = trunc i64 %indvars.iv.31 to i32
  %add115.31 = add i32 %add114.31, %671
  %idxprom116.31 = sext i32 %add115.31 to i64
  %arrayidx117.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom116.31
  %672 = load i32, i32* %arrayidx117.31, align 4
  %cmp118.31 = icmp eq i32 %672, 255
  br i1 %cmp118.31, label %if.then146.31, label %lor.lhs.false120.31

lor.lhs.false120.31:                              ; preds = %lor.lhs.false112.31
  %add124.31 = add i32 %sub81.31, 127
  %idxprom125.31 = sext i32 %add124.31 to i64
  %arrayidx126.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom125.31
  %673 = load i32, i32* %arrayidx126.31, align 4
  %cmp127.31 = icmp eq i32 %673, 255
  br i1 %cmp127.31, label %if.then146.31, label %lor.lhs.false129.31

lor.lhs.false129.31:                              ; preds = %lor.lhs.false120.31
  %674 = add nsw i64 %660, %indvars.iv.31
  %arrayidx134.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %674
  %675 = load i32, i32* %arrayidx134.31, align 4
  %cmp135.31 = icmp eq i32 %675, 255
  br i1 %cmp135.31, label %if.then146.31, label %lor.lhs.false137.31

lor.lhs.false137.31:                              ; preds = %lor.lhs.false129.31
  %add141.31 = add i32 %sub81.31, 129
  %idxprom142.31 = sext i32 %add141.31 to i64
  %arrayidx143.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom142.31
  %676 = load i32, i32* %arrayidx143.31, align 4
  %cmp144.31 = icmp eq i32 %676, 255
  br i1 %cmp144.31, label %if.then146.31, label %if.else149.31

if.else149.31:                                    ; preds = %lor.lhs.false137.31
  %arrayidx151.31 = getelementptr inbounds i8, i8* %0, i64 %662
  store i8 0, i8* %arrayidx151.31, align 1
  br label %for.inc161.31

if.then146.31:                                    ; preds = %lor.lhs.false137.31, %lor.lhs.false129.31, %lor.lhs.false120.31, %lor.lhs.false112.31, %lor.lhs.false104.31, %lor.lhs.false95.31, %lor.lhs.false87.31, %if.then78.31
  %arrayidx148.31 = getelementptr inbounds i8, i8* %0, i64 %662
  store i8 -1, i8* %arrayidx148.31, align 1
  br label %for.inc161.31

if.then70.31:                                     ; preds = %for.body56.31
  %arrayidx72.31 = getelementptr inbounds i8, i8* %0, i64 %662
  store i8 0, i8* %arrayidx72.31, align 1
  br label %for.inc161.31

for.inc161.31:                                    ; preds = %if.then70.31, %if.then146.31, %if.else149.31, %if.else153.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %img_width
  br i1 %exitcond.31, label %for.inc164.31.loopexit, label %for.body56.31, !llvm.loop !5

for.inc164.31.loopexit:                           ; preds = %for.inc161.31
  br label %for.inc164.31

for.inc164.31:                                    ; preds = %for.inc164.31.loopexit, %for.cond53.preheader, %for.inc164, %for.inc164.1, %for.inc164.2, %for.inc164.3, %for.inc164.4, %for.inc164.5, %for.inc164.6, %for.inc164.7, %for.inc164.8, %for.inc164.9, %for.inc164.10, %for.inc164.11, %for.inc164.12, %for.inc164.13, %for.inc164.14, %for.inc164.15, %for.inc164.16, %for.inc164.17, %for.inc164.18, %for.inc164.19, %for.inc164.20, %for.inc164.21, %for.inc164.22, %for.inc164.23, %for.inc164.24, %for.inc164.25, %for.inc164.26, %for.inc164.27, %for.inc164.28, %for.inc164.29, %for.inc164.30
  %indvars.iv.next20.31 = add nsw i64 %indvars.iv19, 32
  %lftr.wideiv21.31 = trunc i64 %indvars.iv.next20.31 to i32
  %exitcond22.31 = icmp eq i32 %lftr.wideiv21.31, %img_height
  br i1 %exitcond22.31, label %for.end166.loopexit, label %for.cond53.preheader, !llvm.loop !7

for.body18.lr.ph.1:                               ; preds = %for.inc44
  %indvars.iv.next29 = add nuw nsw i64 %indvars.iv28, 1
  %677 = trunc i64 %indvars.iv.next29 to i32
  %mul19.1 = shl i32 %677, 7
  %678 = sext i32 %mul19.1 to i64
  br label %for.body18.1

for.body18.1:                                     ; preds = %for.inc41.1, %for.body18.lr.ph.1
  %indvars.iv23.1 = phi i64 [ 0, %for.body18.lr.ph.1 ], [ %indvars.iv.next24.1, %for.inc41.1 ]
  %679 = add nsw i64 %indvars.iv23.1, %678
  %arrayidx21.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %679
  %680 = load i32, i32* %arrayidx21.1, align 4
  %conv22.1 = uitofp i32 %680 to float
  %cmp23.1 = fcmp olt float %conv22.1, %mul9
  br i1 %cmp23.1, label %if.then25.1, label %if.else.1

if.else.1:                                        ; preds = %for.body18.1
  %cmp31.1 = fcmp ult float %conv22.1, %mul8
  br i1 %cmp31.1, label %if.else36.1, label %if.then33.1

if.then33.1:                                      ; preds = %if.else.1
  store i32 255, i32* %arrayidx21.1, align 4
  br label %for.inc41.1

if.else36.1:                                      ; preds = %if.else.1
  store i32 75, i32* %arrayidx21.1, align 4
  br label %for.inc41.1

if.then25.1:                                      ; preds = %for.body18.1
  store i32 0, i32* %arrayidx21.1, align 4
  br label %for.inc41.1

for.inc41.1:                                      ; preds = %if.then25.1, %if.else36.1, %if.then33.1
  %indvars.iv.next24.1 = add nuw nsw i64 %indvars.iv23.1, 1
  %lftr.wideiv26.1 = trunc i64 %indvars.iv.next24.1 to i32
  %exitcond27.1 = icmp eq i32 %lftr.wideiv26.1, %img_width
  br i1 %exitcond27.1, label %for.inc44.1, label %for.body18.1, !llvm.loop !3

for.inc44.1:                                      ; preds = %for.inc41.1
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.2

for.body18.lr.ph.2:                               ; preds = %for.inc44.1
  %indvars.iv.next29.1 = add nsw i64 %indvars.iv28, 2
  %681 = trunc i64 %indvars.iv.next29.1 to i32
  %mul19.2 = shl i32 %681, 7
  %682 = sext i32 %mul19.2 to i64
  br label %for.body18.2

for.body18.2:                                     ; preds = %for.inc41.2, %for.body18.lr.ph.2
  %indvars.iv23.2 = phi i64 [ 0, %for.body18.lr.ph.2 ], [ %indvars.iv.next24.2, %for.inc41.2 ]
  %683 = add nsw i64 %indvars.iv23.2, %682
  %arrayidx21.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %683
  %684 = load i32, i32* %arrayidx21.2, align 4
  %conv22.2 = uitofp i32 %684 to float
  %cmp23.2 = fcmp olt float %conv22.2, %mul9
  br i1 %cmp23.2, label %if.then25.2, label %if.else.2

if.else.2:                                        ; preds = %for.body18.2
  %cmp31.2 = fcmp ult float %conv22.2, %mul8
  br i1 %cmp31.2, label %if.else36.2, label %if.then33.2

if.then33.2:                                      ; preds = %if.else.2
  store i32 255, i32* %arrayidx21.2, align 4
  br label %for.inc41.2

if.else36.2:                                      ; preds = %if.else.2
  store i32 75, i32* %arrayidx21.2, align 4
  br label %for.inc41.2

if.then25.2:                                      ; preds = %for.body18.2
  store i32 0, i32* %arrayidx21.2, align 4
  br label %for.inc41.2

for.inc41.2:                                      ; preds = %if.then25.2, %if.else36.2, %if.then33.2
  %indvars.iv.next24.2 = add nuw nsw i64 %indvars.iv23.2, 1
  %lftr.wideiv26.2 = trunc i64 %indvars.iv.next24.2 to i32
  %exitcond27.2 = icmp eq i32 %lftr.wideiv26.2, %img_width
  br i1 %exitcond27.2, label %for.inc44.2, label %for.body18.2, !llvm.loop !3

for.inc44.2:                                      ; preds = %for.inc41.2
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.3

for.body18.lr.ph.3:                               ; preds = %for.inc44.2
  %indvars.iv.next29.2 = add nsw i64 %indvars.iv28, 3
  %685 = trunc i64 %indvars.iv.next29.2 to i32
  %mul19.3 = shl i32 %685, 7
  %686 = sext i32 %mul19.3 to i64
  br label %for.body18.3

for.body18.3:                                     ; preds = %for.inc41.3, %for.body18.lr.ph.3
  %indvars.iv23.3 = phi i64 [ 0, %for.body18.lr.ph.3 ], [ %indvars.iv.next24.3, %for.inc41.3 ]
  %687 = add nsw i64 %indvars.iv23.3, %686
  %arrayidx21.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %687
  %688 = load i32, i32* %arrayidx21.3, align 4
  %conv22.3 = uitofp i32 %688 to float
  %cmp23.3 = fcmp olt float %conv22.3, %mul9
  br i1 %cmp23.3, label %if.then25.3, label %if.else.3

if.else.3:                                        ; preds = %for.body18.3
  %cmp31.3 = fcmp ult float %conv22.3, %mul8
  br i1 %cmp31.3, label %if.else36.3, label %if.then33.3

if.then33.3:                                      ; preds = %if.else.3
  store i32 255, i32* %arrayidx21.3, align 4
  br label %for.inc41.3

if.else36.3:                                      ; preds = %if.else.3
  store i32 75, i32* %arrayidx21.3, align 4
  br label %for.inc41.3

if.then25.3:                                      ; preds = %for.body18.3
  store i32 0, i32* %arrayidx21.3, align 4
  br label %for.inc41.3

for.inc41.3:                                      ; preds = %if.then25.3, %if.else36.3, %if.then33.3
  %indvars.iv.next24.3 = add nuw nsw i64 %indvars.iv23.3, 1
  %lftr.wideiv26.3 = trunc i64 %indvars.iv.next24.3 to i32
  %exitcond27.3 = icmp eq i32 %lftr.wideiv26.3, %img_width
  br i1 %exitcond27.3, label %for.inc44.3, label %for.body18.3, !llvm.loop !3

for.inc44.3:                                      ; preds = %for.inc41.3
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.4

for.body18.lr.ph.4:                               ; preds = %for.inc44.3
  %indvars.iv.next29.3 = add nsw i64 %indvars.iv28, 4
  %689 = trunc i64 %indvars.iv.next29.3 to i32
  %mul19.4 = shl i32 %689, 7
  %690 = sext i32 %mul19.4 to i64
  br label %for.body18.4

for.body18.4:                                     ; preds = %for.inc41.4, %for.body18.lr.ph.4
  %indvars.iv23.4 = phi i64 [ 0, %for.body18.lr.ph.4 ], [ %indvars.iv.next24.4, %for.inc41.4 ]
  %691 = add nsw i64 %indvars.iv23.4, %690
  %arrayidx21.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %691
  %692 = load i32, i32* %arrayidx21.4, align 4
  %conv22.4 = uitofp i32 %692 to float
  %cmp23.4 = fcmp olt float %conv22.4, %mul9
  br i1 %cmp23.4, label %if.then25.4, label %if.else.4

if.else.4:                                        ; preds = %for.body18.4
  %cmp31.4 = fcmp ult float %conv22.4, %mul8
  br i1 %cmp31.4, label %if.else36.4, label %if.then33.4

if.then33.4:                                      ; preds = %if.else.4
  store i32 255, i32* %arrayidx21.4, align 4
  br label %for.inc41.4

if.else36.4:                                      ; preds = %if.else.4
  store i32 75, i32* %arrayidx21.4, align 4
  br label %for.inc41.4

if.then25.4:                                      ; preds = %for.body18.4
  store i32 0, i32* %arrayidx21.4, align 4
  br label %for.inc41.4

for.inc41.4:                                      ; preds = %if.then25.4, %if.else36.4, %if.then33.4
  %indvars.iv.next24.4 = add nuw nsw i64 %indvars.iv23.4, 1
  %lftr.wideiv26.4 = trunc i64 %indvars.iv.next24.4 to i32
  %exitcond27.4 = icmp eq i32 %lftr.wideiv26.4, %img_width
  br i1 %exitcond27.4, label %for.inc44.4, label %for.body18.4, !llvm.loop !3

for.inc44.4:                                      ; preds = %for.inc41.4
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.5

for.body18.lr.ph.5:                               ; preds = %for.inc44.4
  %indvars.iv.next29.4 = add nsw i64 %indvars.iv28, 5
  %693 = trunc i64 %indvars.iv.next29.4 to i32
  %mul19.5 = shl i32 %693, 7
  %694 = sext i32 %mul19.5 to i64
  br label %for.body18.5

for.body18.5:                                     ; preds = %for.inc41.5, %for.body18.lr.ph.5
  %indvars.iv23.5 = phi i64 [ 0, %for.body18.lr.ph.5 ], [ %indvars.iv.next24.5, %for.inc41.5 ]
  %695 = add nsw i64 %indvars.iv23.5, %694
  %arrayidx21.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %695
  %696 = load i32, i32* %arrayidx21.5, align 4
  %conv22.5 = uitofp i32 %696 to float
  %cmp23.5 = fcmp olt float %conv22.5, %mul9
  br i1 %cmp23.5, label %if.then25.5, label %if.else.5

if.else.5:                                        ; preds = %for.body18.5
  %cmp31.5 = fcmp ult float %conv22.5, %mul8
  br i1 %cmp31.5, label %if.else36.5, label %if.then33.5

if.then33.5:                                      ; preds = %if.else.5
  store i32 255, i32* %arrayidx21.5, align 4
  br label %for.inc41.5

if.else36.5:                                      ; preds = %if.else.5
  store i32 75, i32* %arrayidx21.5, align 4
  br label %for.inc41.5

if.then25.5:                                      ; preds = %for.body18.5
  store i32 0, i32* %arrayidx21.5, align 4
  br label %for.inc41.5

for.inc41.5:                                      ; preds = %if.then25.5, %if.else36.5, %if.then33.5
  %indvars.iv.next24.5 = add nuw nsw i64 %indvars.iv23.5, 1
  %lftr.wideiv26.5 = trunc i64 %indvars.iv.next24.5 to i32
  %exitcond27.5 = icmp eq i32 %lftr.wideiv26.5, %img_width
  br i1 %exitcond27.5, label %for.inc44.5, label %for.body18.5, !llvm.loop !3

for.inc44.5:                                      ; preds = %for.inc41.5
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.6

for.body18.lr.ph.6:                               ; preds = %for.inc44.5
  %indvars.iv.next29.5 = add nsw i64 %indvars.iv28, 6
  %697 = trunc i64 %indvars.iv.next29.5 to i32
  %mul19.6 = shl i32 %697, 7
  %698 = sext i32 %mul19.6 to i64
  br label %for.body18.6

for.body18.6:                                     ; preds = %for.inc41.6, %for.body18.lr.ph.6
  %indvars.iv23.6 = phi i64 [ 0, %for.body18.lr.ph.6 ], [ %indvars.iv.next24.6, %for.inc41.6 ]
  %699 = add nsw i64 %indvars.iv23.6, %698
  %arrayidx21.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %699
  %700 = load i32, i32* %arrayidx21.6, align 4
  %conv22.6 = uitofp i32 %700 to float
  %cmp23.6 = fcmp olt float %conv22.6, %mul9
  br i1 %cmp23.6, label %if.then25.6, label %if.else.6

if.else.6:                                        ; preds = %for.body18.6
  %cmp31.6 = fcmp ult float %conv22.6, %mul8
  br i1 %cmp31.6, label %if.else36.6, label %if.then33.6

if.then33.6:                                      ; preds = %if.else.6
  store i32 255, i32* %arrayidx21.6, align 4
  br label %for.inc41.6

if.else36.6:                                      ; preds = %if.else.6
  store i32 75, i32* %arrayidx21.6, align 4
  br label %for.inc41.6

if.then25.6:                                      ; preds = %for.body18.6
  store i32 0, i32* %arrayidx21.6, align 4
  br label %for.inc41.6

for.inc41.6:                                      ; preds = %if.then25.6, %if.else36.6, %if.then33.6
  %indvars.iv.next24.6 = add nuw nsw i64 %indvars.iv23.6, 1
  %lftr.wideiv26.6 = trunc i64 %indvars.iv.next24.6 to i32
  %exitcond27.6 = icmp eq i32 %lftr.wideiv26.6, %img_width
  br i1 %exitcond27.6, label %for.inc44.6, label %for.body18.6, !llvm.loop !3

for.inc44.6:                                      ; preds = %for.inc41.6
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.7

for.body18.lr.ph.7:                               ; preds = %for.inc44.6
  %indvars.iv.next29.6 = add nsw i64 %indvars.iv28, 7
  %701 = trunc i64 %indvars.iv.next29.6 to i32
  %mul19.7 = shl i32 %701, 7
  %702 = sext i32 %mul19.7 to i64
  br label %for.body18.7

for.body18.7:                                     ; preds = %for.inc41.7, %for.body18.lr.ph.7
  %indvars.iv23.7 = phi i64 [ 0, %for.body18.lr.ph.7 ], [ %indvars.iv.next24.7, %for.inc41.7 ]
  %703 = add nsw i64 %indvars.iv23.7, %702
  %arrayidx21.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %703
  %704 = load i32, i32* %arrayidx21.7, align 4
  %conv22.7 = uitofp i32 %704 to float
  %cmp23.7 = fcmp olt float %conv22.7, %mul9
  br i1 %cmp23.7, label %if.then25.7, label %if.else.7

if.else.7:                                        ; preds = %for.body18.7
  %cmp31.7 = fcmp ult float %conv22.7, %mul8
  br i1 %cmp31.7, label %if.else36.7, label %if.then33.7

if.then33.7:                                      ; preds = %if.else.7
  store i32 255, i32* %arrayidx21.7, align 4
  br label %for.inc41.7

if.else36.7:                                      ; preds = %if.else.7
  store i32 75, i32* %arrayidx21.7, align 4
  br label %for.inc41.7

if.then25.7:                                      ; preds = %for.body18.7
  store i32 0, i32* %arrayidx21.7, align 4
  br label %for.inc41.7

for.inc41.7:                                      ; preds = %if.then25.7, %if.else36.7, %if.then33.7
  %indvars.iv.next24.7 = add nuw nsw i64 %indvars.iv23.7, 1
  %lftr.wideiv26.7 = trunc i64 %indvars.iv.next24.7 to i32
  %exitcond27.7 = icmp eq i32 %lftr.wideiv26.7, %img_width
  br i1 %exitcond27.7, label %for.inc44.7, label %for.body18.7, !llvm.loop !3

for.inc44.7:                                      ; preds = %for.inc41.7
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.8

for.body18.lr.ph.8:                               ; preds = %for.inc44.7
  %indvars.iv.next29.7 = add nsw i64 %indvars.iv28, 8
  %705 = trunc i64 %indvars.iv.next29.7 to i32
  %mul19.8 = shl i32 %705, 7
  %706 = sext i32 %mul19.8 to i64
  br label %for.body18.8

for.body18.8:                                     ; preds = %for.inc41.8, %for.body18.lr.ph.8
  %indvars.iv23.8 = phi i64 [ 0, %for.body18.lr.ph.8 ], [ %indvars.iv.next24.8, %for.inc41.8 ]
  %707 = add nsw i64 %indvars.iv23.8, %706
  %arrayidx21.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %707
  %708 = load i32, i32* %arrayidx21.8, align 4
  %conv22.8 = uitofp i32 %708 to float
  %cmp23.8 = fcmp olt float %conv22.8, %mul9
  br i1 %cmp23.8, label %if.then25.8, label %if.else.8

if.else.8:                                        ; preds = %for.body18.8
  %cmp31.8 = fcmp ult float %conv22.8, %mul8
  br i1 %cmp31.8, label %if.else36.8, label %if.then33.8

if.then33.8:                                      ; preds = %if.else.8
  store i32 255, i32* %arrayidx21.8, align 4
  br label %for.inc41.8

if.else36.8:                                      ; preds = %if.else.8
  store i32 75, i32* %arrayidx21.8, align 4
  br label %for.inc41.8

if.then25.8:                                      ; preds = %for.body18.8
  store i32 0, i32* %arrayidx21.8, align 4
  br label %for.inc41.8

for.inc41.8:                                      ; preds = %if.then25.8, %if.else36.8, %if.then33.8
  %indvars.iv.next24.8 = add nuw nsw i64 %indvars.iv23.8, 1
  %lftr.wideiv26.8 = trunc i64 %indvars.iv.next24.8 to i32
  %exitcond27.8 = icmp eq i32 %lftr.wideiv26.8, %img_width
  br i1 %exitcond27.8, label %for.inc44.8, label %for.body18.8, !llvm.loop !3

for.inc44.8:                                      ; preds = %for.inc41.8
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.9

for.body18.lr.ph.9:                               ; preds = %for.inc44.8
  %indvars.iv.next29.8 = add nsw i64 %indvars.iv28, 9
  %709 = trunc i64 %indvars.iv.next29.8 to i32
  %mul19.9 = shl i32 %709, 7
  %710 = sext i32 %mul19.9 to i64
  br label %for.body18.9

for.body18.9:                                     ; preds = %for.inc41.9, %for.body18.lr.ph.9
  %indvars.iv23.9 = phi i64 [ 0, %for.body18.lr.ph.9 ], [ %indvars.iv.next24.9, %for.inc41.9 ]
  %711 = add nsw i64 %indvars.iv23.9, %710
  %arrayidx21.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %711
  %712 = load i32, i32* %arrayidx21.9, align 4
  %conv22.9 = uitofp i32 %712 to float
  %cmp23.9 = fcmp olt float %conv22.9, %mul9
  br i1 %cmp23.9, label %if.then25.9, label %if.else.9

if.else.9:                                        ; preds = %for.body18.9
  %cmp31.9 = fcmp ult float %conv22.9, %mul8
  br i1 %cmp31.9, label %if.else36.9, label %if.then33.9

if.then33.9:                                      ; preds = %if.else.9
  store i32 255, i32* %arrayidx21.9, align 4
  br label %for.inc41.9

if.else36.9:                                      ; preds = %if.else.9
  store i32 75, i32* %arrayidx21.9, align 4
  br label %for.inc41.9

if.then25.9:                                      ; preds = %for.body18.9
  store i32 0, i32* %arrayidx21.9, align 4
  br label %for.inc41.9

for.inc41.9:                                      ; preds = %if.then25.9, %if.else36.9, %if.then33.9
  %indvars.iv.next24.9 = add nuw nsw i64 %indvars.iv23.9, 1
  %lftr.wideiv26.9 = trunc i64 %indvars.iv.next24.9 to i32
  %exitcond27.9 = icmp eq i32 %lftr.wideiv26.9, %img_width
  br i1 %exitcond27.9, label %for.inc44.9, label %for.body18.9, !llvm.loop !3

for.inc44.9:                                      ; preds = %for.inc41.9
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.10

for.body18.lr.ph.10:                              ; preds = %for.inc44.9
  %indvars.iv.next29.9 = add nsw i64 %indvars.iv28, 10
  %713 = trunc i64 %indvars.iv.next29.9 to i32
  %mul19.10 = shl i32 %713, 7
  %714 = sext i32 %mul19.10 to i64
  br label %for.body18.10

for.body18.10:                                    ; preds = %for.inc41.10, %for.body18.lr.ph.10
  %indvars.iv23.10 = phi i64 [ 0, %for.body18.lr.ph.10 ], [ %indvars.iv.next24.10, %for.inc41.10 ]
  %715 = add nsw i64 %indvars.iv23.10, %714
  %arrayidx21.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %715
  %716 = load i32, i32* %arrayidx21.10, align 4
  %conv22.10 = uitofp i32 %716 to float
  %cmp23.10 = fcmp olt float %conv22.10, %mul9
  br i1 %cmp23.10, label %if.then25.10, label %if.else.10

if.else.10:                                       ; preds = %for.body18.10
  %cmp31.10 = fcmp ult float %conv22.10, %mul8
  br i1 %cmp31.10, label %if.else36.10, label %if.then33.10

if.then33.10:                                     ; preds = %if.else.10
  store i32 255, i32* %arrayidx21.10, align 4
  br label %for.inc41.10

if.else36.10:                                     ; preds = %if.else.10
  store i32 75, i32* %arrayidx21.10, align 4
  br label %for.inc41.10

if.then25.10:                                     ; preds = %for.body18.10
  store i32 0, i32* %arrayidx21.10, align 4
  br label %for.inc41.10

for.inc41.10:                                     ; preds = %if.then25.10, %if.else36.10, %if.then33.10
  %indvars.iv.next24.10 = add nuw nsw i64 %indvars.iv23.10, 1
  %lftr.wideiv26.10 = trunc i64 %indvars.iv.next24.10 to i32
  %exitcond27.10 = icmp eq i32 %lftr.wideiv26.10, %img_width
  br i1 %exitcond27.10, label %for.inc44.10, label %for.body18.10, !llvm.loop !3

for.inc44.10:                                     ; preds = %for.inc41.10
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.11

for.body18.lr.ph.11:                              ; preds = %for.inc44.10
  %indvars.iv.next29.10 = add nsw i64 %indvars.iv28, 11
  %717 = trunc i64 %indvars.iv.next29.10 to i32
  %mul19.11 = shl i32 %717, 7
  %718 = sext i32 %mul19.11 to i64
  br label %for.body18.11

for.body18.11:                                    ; preds = %for.inc41.11, %for.body18.lr.ph.11
  %indvars.iv23.11 = phi i64 [ 0, %for.body18.lr.ph.11 ], [ %indvars.iv.next24.11, %for.inc41.11 ]
  %719 = add nsw i64 %indvars.iv23.11, %718
  %arrayidx21.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %719
  %720 = load i32, i32* %arrayidx21.11, align 4
  %conv22.11 = uitofp i32 %720 to float
  %cmp23.11 = fcmp olt float %conv22.11, %mul9
  br i1 %cmp23.11, label %if.then25.11, label %if.else.11

if.else.11:                                       ; preds = %for.body18.11
  %cmp31.11 = fcmp ult float %conv22.11, %mul8
  br i1 %cmp31.11, label %if.else36.11, label %if.then33.11

if.then33.11:                                     ; preds = %if.else.11
  store i32 255, i32* %arrayidx21.11, align 4
  br label %for.inc41.11

if.else36.11:                                     ; preds = %if.else.11
  store i32 75, i32* %arrayidx21.11, align 4
  br label %for.inc41.11

if.then25.11:                                     ; preds = %for.body18.11
  store i32 0, i32* %arrayidx21.11, align 4
  br label %for.inc41.11

for.inc41.11:                                     ; preds = %if.then25.11, %if.else36.11, %if.then33.11
  %indvars.iv.next24.11 = add nuw nsw i64 %indvars.iv23.11, 1
  %lftr.wideiv26.11 = trunc i64 %indvars.iv.next24.11 to i32
  %exitcond27.11 = icmp eq i32 %lftr.wideiv26.11, %img_width
  br i1 %exitcond27.11, label %for.inc44.11, label %for.body18.11, !llvm.loop !3

for.inc44.11:                                     ; preds = %for.inc41.11
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.12

for.body18.lr.ph.12:                              ; preds = %for.inc44.11
  %indvars.iv.next29.11 = add nsw i64 %indvars.iv28, 12
  %721 = trunc i64 %indvars.iv.next29.11 to i32
  %mul19.12 = shl i32 %721, 7
  %722 = sext i32 %mul19.12 to i64
  br label %for.body18.12

for.body18.12:                                    ; preds = %for.inc41.12, %for.body18.lr.ph.12
  %indvars.iv23.12 = phi i64 [ 0, %for.body18.lr.ph.12 ], [ %indvars.iv.next24.12, %for.inc41.12 ]
  %723 = add nsw i64 %indvars.iv23.12, %722
  %arrayidx21.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %723
  %724 = load i32, i32* %arrayidx21.12, align 4
  %conv22.12 = uitofp i32 %724 to float
  %cmp23.12 = fcmp olt float %conv22.12, %mul9
  br i1 %cmp23.12, label %if.then25.12, label %if.else.12

if.else.12:                                       ; preds = %for.body18.12
  %cmp31.12 = fcmp ult float %conv22.12, %mul8
  br i1 %cmp31.12, label %if.else36.12, label %if.then33.12

if.then33.12:                                     ; preds = %if.else.12
  store i32 255, i32* %arrayidx21.12, align 4
  br label %for.inc41.12

if.else36.12:                                     ; preds = %if.else.12
  store i32 75, i32* %arrayidx21.12, align 4
  br label %for.inc41.12

if.then25.12:                                     ; preds = %for.body18.12
  store i32 0, i32* %arrayidx21.12, align 4
  br label %for.inc41.12

for.inc41.12:                                     ; preds = %if.then25.12, %if.else36.12, %if.then33.12
  %indvars.iv.next24.12 = add nuw nsw i64 %indvars.iv23.12, 1
  %lftr.wideiv26.12 = trunc i64 %indvars.iv.next24.12 to i32
  %exitcond27.12 = icmp eq i32 %lftr.wideiv26.12, %img_width
  br i1 %exitcond27.12, label %for.inc44.12, label %for.body18.12, !llvm.loop !3

for.inc44.12:                                     ; preds = %for.inc41.12
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.13

for.body18.lr.ph.13:                              ; preds = %for.inc44.12
  %indvars.iv.next29.12 = add nsw i64 %indvars.iv28, 13
  %725 = trunc i64 %indvars.iv.next29.12 to i32
  %mul19.13 = shl i32 %725, 7
  %726 = sext i32 %mul19.13 to i64
  br label %for.body18.13

for.body18.13:                                    ; preds = %for.inc41.13, %for.body18.lr.ph.13
  %indvars.iv23.13 = phi i64 [ 0, %for.body18.lr.ph.13 ], [ %indvars.iv.next24.13, %for.inc41.13 ]
  %727 = add nsw i64 %indvars.iv23.13, %726
  %arrayidx21.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %727
  %728 = load i32, i32* %arrayidx21.13, align 4
  %conv22.13 = uitofp i32 %728 to float
  %cmp23.13 = fcmp olt float %conv22.13, %mul9
  br i1 %cmp23.13, label %if.then25.13, label %if.else.13

if.else.13:                                       ; preds = %for.body18.13
  %cmp31.13 = fcmp ult float %conv22.13, %mul8
  br i1 %cmp31.13, label %if.else36.13, label %if.then33.13

if.then33.13:                                     ; preds = %if.else.13
  store i32 255, i32* %arrayidx21.13, align 4
  br label %for.inc41.13

if.else36.13:                                     ; preds = %if.else.13
  store i32 75, i32* %arrayidx21.13, align 4
  br label %for.inc41.13

if.then25.13:                                     ; preds = %for.body18.13
  store i32 0, i32* %arrayidx21.13, align 4
  br label %for.inc41.13

for.inc41.13:                                     ; preds = %if.then25.13, %if.else36.13, %if.then33.13
  %indvars.iv.next24.13 = add nuw nsw i64 %indvars.iv23.13, 1
  %lftr.wideiv26.13 = trunc i64 %indvars.iv.next24.13 to i32
  %exitcond27.13 = icmp eq i32 %lftr.wideiv26.13, %img_width
  br i1 %exitcond27.13, label %for.inc44.13, label %for.body18.13, !llvm.loop !3

for.inc44.13:                                     ; preds = %for.inc41.13
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.14

for.body18.lr.ph.14:                              ; preds = %for.inc44.13
  %indvars.iv.next29.13 = add nsw i64 %indvars.iv28, 14
  %729 = trunc i64 %indvars.iv.next29.13 to i32
  %mul19.14 = shl i32 %729, 7
  %730 = sext i32 %mul19.14 to i64
  br label %for.body18.14

for.body18.14:                                    ; preds = %for.inc41.14, %for.body18.lr.ph.14
  %indvars.iv23.14 = phi i64 [ 0, %for.body18.lr.ph.14 ], [ %indvars.iv.next24.14, %for.inc41.14 ]
  %731 = add nsw i64 %indvars.iv23.14, %730
  %arrayidx21.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %731
  %732 = load i32, i32* %arrayidx21.14, align 4
  %conv22.14 = uitofp i32 %732 to float
  %cmp23.14 = fcmp olt float %conv22.14, %mul9
  br i1 %cmp23.14, label %if.then25.14, label %if.else.14

if.else.14:                                       ; preds = %for.body18.14
  %cmp31.14 = fcmp ult float %conv22.14, %mul8
  br i1 %cmp31.14, label %if.else36.14, label %if.then33.14

if.then33.14:                                     ; preds = %if.else.14
  store i32 255, i32* %arrayidx21.14, align 4
  br label %for.inc41.14

if.else36.14:                                     ; preds = %if.else.14
  store i32 75, i32* %arrayidx21.14, align 4
  br label %for.inc41.14

if.then25.14:                                     ; preds = %for.body18.14
  store i32 0, i32* %arrayidx21.14, align 4
  br label %for.inc41.14

for.inc41.14:                                     ; preds = %if.then25.14, %if.else36.14, %if.then33.14
  %indvars.iv.next24.14 = add nuw nsw i64 %indvars.iv23.14, 1
  %lftr.wideiv26.14 = trunc i64 %indvars.iv.next24.14 to i32
  %exitcond27.14 = icmp eq i32 %lftr.wideiv26.14, %img_width
  br i1 %exitcond27.14, label %for.inc44.14, label %for.body18.14, !llvm.loop !3

for.inc44.14:                                     ; preds = %for.inc41.14
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.15

for.body18.lr.ph.15:                              ; preds = %for.inc44.14
  %indvars.iv.next29.14 = add nsw i64 %indvars.iv28, 15
  %733 = trunc i64 %indvars.iv.next29.14 to i32
  %mul19.15 = shl i32 %733, 7
  %734 = sext i32 %mul19.15 to i64
  br label %for.body18.15

for.body18.15:                                    ; preds = %for.inc41.15, %for.body18.lr.ph.15
  %indvars.iv23.15 = phi i64 [ 0, %for.body18.lr.ph.15 ], [ %indvars.iv.next24.15, %for.inc41.15 ]
  %735 = add nsw i64 %indvars.iv23.15, %734
  %arrayidx21.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %735
  %736 = load i32, i32* %arrayidx21.15, align 4
  %conv22.15 = uitofp i32 %736 to float
  %cmp23.15 = fcmp olt float %conv22.15, %mul9
  br i1 %cmp23.15, label %if.then25.15, label %if.else.15

if.else.15:                                       ; preds = %for.body18.15
  %cmp31.15 = fcmp ult float %conv22.15, %mul8
  br i1 %cmp31.15, label %if.else36.15, label %if.then33.15

if.then33.15:                                     ; preds = %if.else.15
  store i32 255, i32* %arrayidx21.15, align 4
  br label %for.inc41.15

if.else36.15:                                     ; preds = %if.else.15
  store i32 75, i32* %arrayidx21.15, align 4
  br label %for.inc41.15

if.then25.15:                                     ; preds = %for.body18.15
  store i32 0, i32* %arrayidx21.15, align 4
  br label %for.inc41.15

for.inc41.15:                                     ; preds = %if.then25.15, %if.else36.15, %if.then33.15
  %indvars.iv.next24.15 = add nuw nsw i64 %indvars.iv23.15, 1
  %lftr.wideiv26.15 = trunc i64 %indvars.iv.next24.15 to i32
  %exitcond27.15 = icmp eq i32 %lftr.wideiv26.15, %img_width
  br i1 %exitcond27.15, label %for.inc44.15, label %for.body18.15, !llvm.loop !3

for.inc44.15:                                     ; preds = %for.inc41.15
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.16

for.body18.lr.ph.16:                              ; preds = %for.inc44.15
  %indvars.iv.next29.15 = add nsw i64 %indvars.iv28, 16
  %737 = trunc i64 %indvars.iv.next29.15 to i32
  %mul19.16 = shl i32 %737, 7
  %738 = sext i32 %mul19.16 to i64
  br label %for.body18.16

for.body18.16:                                    ; preds = %for.inc41.16, %for.body18.lr.ph.16
  %indvars.iv23.16 = phi i64 [ 0, %for.body18.lr.ph.16 ], [ %indvars.iv.next24.16, %for.inc41.16 ]
  %739 = add nsw i64 %indvars.iv23.16, %738
  %arrayidx21.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %739
  %740 = load i32, i32* %arrayidx21.16, align 4
  %conv22.16 = uitofp i32 %740 to float
  %cmp23.16 = fcmp olt float %conv22.16, %mul9
  br i1 %cmp23.16, label %if.then25.16, label %if.else.16

if.else.16:                                       ; preds = %for.body18.16
  %cmp31.16 = fcmp ult float %conv22.16, %mul8
  br i1 %cmp31.16, label %if.else36.16, label %if.then33.16

if.then33.16:                                     ; preds = %if.else.16
  store i32 255, i32* %arrayidx21.16, align 4
  br label %for.inc41.16

if.else36.16:                                     ; preds = %if.else.16
  store i32 75, i32* %arrayidx21.16, align 4
  br label %for.inc41.16

if.then25.16:                                     ; preds = %for.body18.16
  store i32 0, i32* %arrayidx21.16, align 4
  br label %for.inc41.16

for.inc41.16:                                     ; preds = %if.then25.16, %if.else36.16, %if.then33.16
  %indvars.iv.next24.16 = add nuw nsw i64 %indvars.iv23.16, 1
  %lftr.wideiv26.16 = trunc i64 %indvars.iv.next24.16 to i32
  %exitcond27.16 = icmp eq i32 %lftr.wideiv26.16, %img_width
  br i1 %exitcond27.16, label %for.inc44.16, label %for.body18.16, !llvm.loop !3

for.inc44.16:                                     ; preds = %for.inc41.16
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.17

for.body18.lr.ph.17:                              ; preds = %for.inc44.16
  %indvars.iv.next29.16 = add nsw i64 %indvars.iv28, 17
  %741 = trunc i64 %indvars.iv.next29.16 to i32
  %mul19.17 = shl i32 %741, 7
  %742 = sext i32 %mul19.17 to i64
  br label %for.body18.17

for.body18.17:                                    ; preds = %for.inc41.17, %for.body18.lr.ph.17
  %indvars.iv23.17 = phi i64 [ 0, %for.body18.lr.ph.17 ], [ %indvars.iv.next24.17, %for.inc41.17 ]
  %743 = add nsw i64 %indvars.iv23.17, %742
  %arrayidx21.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %743
  %744 = load i32, i32* %arrayidx21.17, align 4
  %conv22.17 = uitofp i32 %744 to float
  %cmp23.17 = fcmp olt float %conv22.17, %mul9
  br i1 %cmp23.17, label %if.then25.17, label %if.else.17

if.else.17:                                       ; preds = %for.body18.17
  %cmp31.17 = fcmp ult float %conv22.17, %mul8
  br i1 %cmp31.17, label %if.else36.17, label %if.then33.17

if.then33.17:                                     ; preds = %if.else.17
  store i32 255, i32* %arrayidx21.17, align 4
  br label %for.inc41.17

if.else36.17:                                     ; preds = %if.else.17
  store i32 75, i32* %arrayidx21.17, align 4
  br label %for.inc41.17

if.then25.17:                                     ; preds = %for.body18.17
  store i32 0, i32* %arrayidx21.17, align 4
  br label %for.inc41.17

for.inc41.17:                                     ; preds = %if.then25.17, %if.else36.17, %if.then33.17
  %indvars.iv.next24.17 = add nuw nsw i64 %indvars.iv23.17, 1
  %lftr.wideiv26.17 = trunc i64 %indvars.iv.next24.17 to i32
  %exitcond27.17 = icmp eq i32 %lftr.wideiv26.17, %img_width
  br i1 %exitcond27.17, label %for.inc44.17, label %for.body18.17, !llvm.loop !3

for.inc44.17:                                     ; preds = %for.inc41.17
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.18

for.body18.lr.ph.18:                              ; preds = %for.inc44.17
  %indvars.iv.next29.17 = add nsw i64 %indvars.iv28, 18
  %745 = trunc i64 %indvars.iv.next29.17 to i32
  %mul19.18 = shl i32 %745, 7
  %746 = sext i32 %mul19.18 to i64
  br label %for.body18.18

for.body18.18:                                    ; preds = %for.inc41.18, %for.body18.lr.ph.18
  %indvars.iv23.18 = phi i64 [ 0, %for.body18.lr.ph.18 ], [ %indvars.iv.next24.18, %for.inc41.18 ]
  %747 = add nsw i64 %indvars.iv23.18, %746
  %arrayidx21.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %747
  %748 = load i32, i32* %arrayidx21.18, align 4
  %conv22.18 = uitofp i32 %748 to float
  %cmp23.18 = fcmp olt float %conv22.18, %mul9
  br i1 %cmp23.18, label %if.then25.18, label %if.else.18

if.else.18:                                       ; preds = %for.body18.18
  %cmp31.18 = fcmp ult float %conv22.18, %mul8
  br i1 %cmp31.18, label %if.else36.18, label %if.then33.18

if.then33.18:                                     ; preds = %if.else.18
  store i32 255, i32* %arrayidx21.18, align 4
  br label %for.inc41.18

if.else36.18:                                     ; preds = %if.else.18
  store i32 75, i32* %arrayidx21.18, align 4
  br label %for.inc41.18

if.then25.18:                                     ; preds = %for.body18.18
  store i32 0, i32* %arrayidx21.18, align 4
  br label %for.inc41.18

for.inc41.18:                                     ; preds = %if.then25.18, %if.else36.18, %if.then33.18
  %indvars.iv.next24.18 = add nuw nsw i64 %indvars.iv23.18, 1
  %lftr.wideiv26.18 = trunc i64 %indvars.iv.next24.18 to i32
  %exitcond27.18 = icmp eq i32 %lftr.wideiv26.18, %img_width
  br i1 %exitcond27.18, label %for.inc44.18, label %for.body18.18, !llvm.loop !3

for.inc44.18:                                     ; preds = %for.inc41.18
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.19

for.body18.lr.ph.19:                              ; preds = %for.inc44.18
  %indvars.iv.next29.18 = add nsw i64 %indvars.iv28, 19
  %749 = trunc i64 %indvars.iv.next29.18 to i32
  %mul19.19 = shl i32 %749, 7
  %750 = sext i32 %mul19.19 to i64
  br label %for.body18.19

for.body18.19:                                    ; preds = %for.inc41.19, %for.body18.lr.ph.19
  %indvars.iv23.19 = phi i64 [ 0, %for.body18.lr.ph.19 ], [ %indvars.iv.next24.19, %for.inc41.19 ]
  %751 = add nsw i64 %indvars.iv23.19, %750
  %arrayidx21.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %751
  %752 = load i32, i32* %arrayidx21.19, align 4
  %conv22.19 = uitofp i32 %752 to float
  %cmp23.19 = fcmp olt float %conv22.19, %mul9
  br i1 %cmp23.19, label %if.then25.19, label %if.else.19

if.else.19:                                       ; preds = %for.body18.19
  %cmp31.19 = fcmp ult float %conv22.19, %mul8
  br i1 %cmp31.19, label %if.else36.19, label %if.then33.19

if.then33.19:                                     ; preds = %if.else.19
  store i32 255, i32* %arrayidx21.19, align 4
  br label %for.inc41.19

if.else36.19:                                     ; preds = %if.else.19
  store i32 75, i32* %arrayidx21.19, align 4
  br label %for.inc41.19

if.then25.19:                                     ; preds = %for.body18.19
  store i32 0, i32* %arrayidx21.19, align 4
  br label %for.inc41.19

for.inc41.19:                                     ; preds = %if.then25.19, %if.else36.19, %if.then33.19
  %indvars.iv.next24.19 = add nuw nsw i64 %indvars.iv23.19, 1
  %lftr.wideiv26.19 = trunc i64 %indvars.iv.next24.19 to i32
  %exitcond27.19 = icmp eq i32 %lftr.wideiv26.19, %img_width
  br i1 %exitcond27.19, label %for.inc44.19, label %for.body18.19, !llvm.loop !3

for.inc44.19:                                     ; preds = %for.inc41.19
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.20

for.body18.lr.ph.20:                              ; preds = %for.inc44.19
  %indvars.iv.next29.19 = add nsw i64 %indvars.iv28, 20
  %753 = trunc i64 %indvars.iv.next29.19 to i32
  %mul19.20 = shl i32 %753, 7
  %754 = sext i32 %mul19.20 to i64
  br label %for.body18.20

for.body18.20:                                    ; preds = %for.inc41.20, %for.body18.lr.ph.20
  %indvars.iv23.20 = phi i64 [ 0, %for.body18.lr.ph.20 ], [ %indvars.iv.next24.20, %for.inc41.20 ]
  %755 = add nsw i64 %indvars.iv23.20, %754
  %arrayidx21.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %755
  %756 = load i32, i32* %arrayidx21.20, align 4
  %conv22.20 = uitofp i32 %756 to float
  %cmp23.20 = fcmp olt float %conv22.20, %mul9
  br i1 %cmp23.20, label %if.then25.20, label %if.else.20

if.else.20:                                       ; preds = %for.body18.20
  %cmp31.20 = fcmp ult float %conv22.20, %mul8
  br i1 %cmp31.20, label %if.else36.20, label %if.then33.20

if.then33.20:                                     ; preds = %if.else.20
  store i32 255, i32* %arrayidx21.20, align 4
  br label %for.inc41.20

if.else36.20:                                     ; preds = %if.else.20
  store i32 75, i32* %arrayidx21.20, align 4
  br label %for.inc41.20

if.then25.20:                                     ; preds = %for.body18.20
  store i32 0, i32* %arrayidx21.20, align 4
  br label %for.inc41.20

for.inc41.20:                                     ; preds = %if.then25.20, %if.else36.20, %if.then33.20
  %indvars.iv.next24.20 = add nuw nsw i64 %indvars.iv23.20, 1
  %lftr.wideiv26.20 = trunc i64 %indvars.iv.next24.20 to i32
  %exitcond27.20 = icmp eq i32 %lftr.wideiv26.20, %img_width
  br i1 %exitcond27.20, label %for.inc44.20, label %for.body18.20, !llvm.loop !3

for.inc44.20:                                     ; preds = %for.inc41.20
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.21

for.body18.lr.ph.21:                              ; preds = %for.inc44.20
  %indvars.iv.next29.20 = add nsw i64 %indvars.iv28, 21
  %757 = trunc i64 %indvars.iv.next29.20 to i32
  %mul19.21 = shl i32 %757, 7
  %758 = sext i32 %mul19.21 to i64
  br label %for.body18.21

for.body18.21:                                    ; preds = %for.inc41.21, %for.body18.lr.ph.21
  %indvars.iv23.21 = phi i64 [ 0, %for.body18.lr.ph.21 ], [ %indvars.iv.next24.21, %for.inc41.21 ]
  %759 = add nsw i64 %indvars.iv23.21, %758
  %arrayidx21.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %759
  %760 = load i32, i32* %arrayidx21.21, align 4
  %conv22.21 = uitofp i32 %760 to float
  %cmp23.21 = fcmp olt float %conv22.21, %mul9
  br i1 %cmp23.21, label %if.then25.21, label %if.else.21

if.else.21:                                       ; preds = %for.body18.21
  %cmp31.21 = fcmp ult float %conv22.21, %mul8
  br i1 %cmp31.21, label %if.else36.21, label %if.then33.21

if.then33.21:                                     ; preds = %if.else.21
  store i32 255, i32* %arrayidx21.21, align 4
  br label %for.inc41.21

if.else36.21:                                     ; preds = %if.else.21
  store i32 75, i32* %arrayidx21.21, align 4
  br label %for.inc41.21

if.then25.21:                                     ; preds = %for.body18.21
  store i32 0, i32* %arrayidx21.21, align 4
  br label %for.inc41.21

for.inc41.21:                                     ; preds = %if.then25.21, %if.else36.21, %if.then33.21
  %indvars.iv.next24.21 = add nuw nsw i64 %indvars.iv23.21, 1
  %lftr.wideiv26.21 = trunc i64 %indvars.iv.next24.21 to i32
  %exitcond27.21 = icmp eq i32 %lftr.wideiv26.21, %img_width
  br i1 %exitcond27.21, label %for.inc44.21, label %for.body18.21, !llvm.loop !3

for.inc44.21:                                     ; preds = %for.inc41.21
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.22

for.body18.lr.ph.22:                              ; preds = %for.inc44.21
  %indvars.iv.next29.21 = add nsw i64 %indvars.iv28, 22
  %761 = trunc i64 %indvars.iv.next29.21 to i32
  %mul19.22 = shl i32 %761, 7
  %762 = sext i32 %mul19.22 to i64
  br label %for.body18.22

for.body18.22:                                    ; preds = %for.inc41.22, %for.body18.lr.ph.22
  %indvars.iv23.22 = phi i64 [ 0, %for.body18.lr.ph.22 ], [ %indvars.iv.next24.22, %for.inc41.22 ]
  %763 = add nsw i64 %indvars.iv23.22, %762
  %arrayidx21.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %763
  %764 = load i32, i32* %arrayidx21.22, align 4
  %conv22.22 = uitofp i32 %764 to float
  %cmp23.22 = fcmp olt float %conv22.22, %mul9
  br i1 %cmp23.22, label %if.then25.22, label %if.else.22

if.else.22:                                       ; preds = %for.body18.22
  %cmp31.22 = fcmp ult float %conv22.22, %mul8
  br i1 %cmp31.22, label %if.else36.22, label %if.then33.22

if.then33.22:                                     ; preds = %if.else.22
  store i32 255, i32* %arrayidx21.22, align 4
  br label %for.inc41.22

if.else36.22:                                     ; preds = %if.else.22
  store i32 75, i32* %arrayidx21.22, align 4
  br label %for.inc41.22

if.then25.22:                                     ; preds = %for.body18.22
  store i32 0, i32* %arrayidx21.22, align 4
  br label %for.inc41.22

for.inc41.22:                                     ; preds = %if.then25.22, %if.else36.22, %if.then33.22
  %indvars.iv.next24.22 = add nuw nsw i64 %indvars.iv23.22, 1
  %lftr.wideiv26.22 = trunc i64 %indvars.iv.next24.22 to i32
  %exitcond27.22 = icmp eq i32 %lftr.wideiv26.22, %img_width
  br i1 %exitcond27.22, label %for.inc44.22, label %for.body18.22, !llvm.loop !3

for.inc44.22:                                     ; preds = %for.inc41.22
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.23

for.body18.lr.ph.23:                              ; preds = %for.inc44.22
  %indvars.iv.next29.22 = add nsw i64 %indvars.iv28, 23
  %765 = trunc i64 %indvars.iv.next29.22 to i32
  %mul19.23 = shl i32 %765, 7
  %766 = sext i32 %mul19.23 to i64
  br label %for.body18.23

for.body18.23:                                    ; preds = %for.inc41.23, %for.body18.lr.ph.23
  %indvars.iv23.23 = phi i64 [ 0, %for.body18.lr.ph.23 ], [ %indvars.iv.next24.23, %for.inc41.23 ]
  %767 = add nsw i64 %indvars.iv23.23, %766
  %arrayidx21.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %767
  %768 = load i32, i32* %arrayidx21.23, align 4
  %conv22.23 = uitofp i32 %768 to float
  %cmp23.23 = fcmp olt float %conv22.23, %mul9
  br i1 %cmp23.23, label %if.then25.23, label %if.else.23

if.else.23:                                       ; preds = %for.body18.23
  %cmp31.23 = fcmp ult float %conv22.23, %mul8
  br i1 %cmp31.23, label %if.else36.23, label %if.then33.23

if.then33.23:                                     ; preds = %if.else.23
  store i32 255, i32* %arrayidx21.23, align 4
  br label %for.inc41.23

if.else36.23:                                     ; preds = %if.else.23
  store i32 75, i32* %arrayidx21.23, align 4
  br label %for.inc41.23

if.then25.23:                                     ; preds = %for.body18.23
  store i32 0, i32* %arrayidx21.23, align 4
  br label %for.inc41.23

for.inc41.23:                                     ; preds = %if.then25.23, %if.else36.23, %if.then33.23
  %indvars.iv.next24.23 = add nuw nsw i64 %indvars.iv23.23, 1
  %lftr.wideiv26.23 = trunc i64 %indvars.iv.next24.23 to i32
  %exitcond27.23 = icmp eq i32 %lftr.wideiv26.23, %img_width
  br i1 %exitcond27.23, label %for.inc44.23, label %for.body18.23, !llvm.loop !3

for.inc44.23:                                     ; preds = %for.inc41.23
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.24

for.body18.lr.ph.24:                              ; preds = %for.inc44.23
  %indvars.iv.next29.23 = add nsw i64 %indvars.iv28, 24
  %769 = trunc i64 %indvars.iv.next29.23 to i32
  %mul19.24 = shl i32 %769, 7
  %770 = sext i32 %mul19.24 to i64
  br label %for.body18.24

for.body18.24:                                    ; preds = %for.inc41.24, %for.body18.lr.ph.24
  %indvars.iv23.24 = phi i64 [ 0, %for.body18.lr.ph.24 ], [ %indvars.iv.next24.24, %for.inc41.24 ]
  %771 = add nsw i64 %indvars.iv23.24, %770
  %arrayidx21.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %771
  %772 = load i32, i32* %arrayidx21.24, align 4
  %conv22.24 = uitofp i32 %772 to float
  %cmp23.24 = fcmp olt float %conv22.24, %mul9
  br i1 %cmp23.24, label %if.then25.24, label %if.else.24

if.else.24:                                       ; preds = %for.body18.24
  %cmp31.24 = fcmp ult float %conv22.24, %mul8
  br i1 %cmp31.24, label %if.else36.24, label %if.then33.24

if.then33.24:                                     ; preds = %if.else.24
  store i32 255, i32* %arrayidx21.24, align 4
  br label %for.inc41.24

if.else36.24:                                     ; preds = %if.else.24
  store i32 75, i32* %arrayidx21.24, align 4
  br label %for.inc41.24

if.then25.24:                                     ; preds = %for.body18.24
  store i32 0, i32* %arrayidx21.24, align 4
  br label %for.inc41.24

for.inc41.24:                                     ; preds = %if.then25.24, %if.else36.24, %if.then33.24
  %indvars.iv.next24.24 = add nuw nsw i64 %indvars.iv23.24, 1
  %lftr.wideiv26.24 = trunc i64 %indvars.iv.next24.24 to i32
  %exitcond27.24 = icmp eq i32 %lftr.wideiv26.24, %img_width
  br i1 %exitcond27.24, label %for.inc44.24, label %for.body18.24, !llvm.loop !3

for.inc44.24:                                     ; preds = %for.inc41.24
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.25

for.body18.lr.ph.25:                              ; preds = %for.inc44.24
  %indvars.iv.next29.24 = add nsw i64 %indvars.iv28, 25
  %773 = trunc i64 %indvars.iv.next29.24 to i32
  %mul19.25 = shl i32 %773, 7
  %774 = sext i32 %mul19.25 to i64
  br label %for.body18.25

for.body18.25:                                    ; preds = %for.inc41.25, %for.body18.lr.ph.25
  %indvars.iv23.25 = phi i64 [ 0, %for.body18.lr.ph.25 ], [ %indvars.iv.next24.25, %for.inc41.25 ]
  %775 = add nsw i64 %indvars.iv23.25, %774
  %arrayidx21.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %775
  %776 = load i32, i32* %arrayidx21.25, align 4
  %conv22.25 = uitofp i32 %776 to float
  %cmp23.25 = fcmp olt float %conv22.25, %mul9
  br i1 %cmp23.25, label %if.then25.25, label %if.else.25

if.else.25:                                       ; preds = %for.body18.25
  %cmp31.25 = fcmp ult float %conv22.25, %mul8
  br i1 %cmp31.25, label %if.else36.25, label %if.then33.25

if.then33.25:                                     ; preds = %if.else.25
  store i32 255, i32* %arrayidx21.25, align 4
  br label %for.inc41.25

if.else36.25:                                     ; preds = %if.else.25
  store i32 75, i32* %arrayidx21.25, align 4
  br label %for.inc41.25

if.then25.25:                                     ; preds = %for.body18.25
  store i32 0, i32* %arrayidx21.25, align 4
  br label %for.inc41.25

for.inc41.25:                                     ; preds = %if.then25.25, %if.else36.25, %if.then33.25
  %indvars.iv.next24.25 = add nuw nsw i64 %indvars.iv23.25, 1
  %lftr.wideiv26.25 = trunc i64 %indvars.iv.next24.25 to i32
  %exitcond27.25 = icmp eq i32 %lftr.wideiv26.25, %img_width
  br i1 %exitcond27.25, label %for.inc44.25, label %for.body18.25, !llvm.loop !3

for.inc44.25:                                     ; preds = %for.inc41.25
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.26

for.body18.lr.ph.26:                              ; preds = %for.inc44.25
  %indvars.iv.next29.25 = add nsw i64 %indvars.iv28, 26
  %777 = trunc i64 %indvars.iv.next29.25 to i32
  %mul19.26 = shl i32 %777, 7
  %778 = sext i32 %mul19.26 to i64
  br label %for.body18.26

for.body18.26:                                    ; preds = %for.inc41.26, %for.body18.lr.ph.26
  %indvars.iv23.26 = phi i64 [ 0, %for.body18.lr.ph.26 ], [ %indvars.iv.next24.26, %for.inc41.26 ]
  %779 = add nsw i64 %indvars.iv23.26, %778
  %arrayidx21.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %779
  %780 = load i32, i32* %arrayidx21.26, align 4
  %conv22.26 = uitofp i32 %780 to float
  %cmp23.26 = fcmp olt float %conv22.26, %mul9
  br i1 %cmp23.26, label %if.then25.26, label %if.else.26

if.else.26:                                       ; preds = %for.body18.26
  %cmp31.26 = fcmp ult float %conv22.26, %mul8
  br i1 %cmp31.26, label %if.else36.26, label %if.then33.26

if.then33.26:                                     ; preds = %if.else.26
  store i32 255, i32* %arrayidx21.26, align 4
  br label %for.inc41.26

if.else36.26:                                     ; preds = %if.else.26
  store i32 75, i32* %arrayidx21.26, align 4
  br label %for.inc41.26

if.then25.26:                                     ; preds = %for.body18.26
  store i32 0, i32* %arrayidx21.26, align 4
  br label %for.inc41.26

for.inc41.26:                                     ; preds = %if.then25.26, %if.else36.26, %if.then33.26
  %indvars.iv.next24.26 = add nuw nsw i64 %indvars.iv23.26, 1
  %lftr.wideiv26.26 = trunc i64 %indvars.iv.next24.26 to i32
  %exitcond27.26 = icmp eq i32 %lftr.wideiv26.26, %img_width
  br i1 %exitcond27.26, label %for.inc44.26, label %for.body18.26, !llvm.loop !3

for.inc44.26:                                     ; preds = %for.inc41.26
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.27

for.body18.lr.ph.27:                              ; preds = %for.inc44.26
  %indvars.iv.next29.26 = add nsw i64 %indvars.iv28, 27
  %781 = trunc i64 %indvars.iv.next29.26 to i32
  %mul19.27 = shl i32 %781, 7
  %782 = sext i32 %mul19.27 to i64
  br label %for.body18.27

for.body18.27:                                    ; preds = %for.inc41.27, %for.body18.lr.ph.27
  %indvars.iv23.27 = phi i64 [ 0, %for.body18.lr.ph.27 ], [ %indvars.iv.next24.27, %for.inc41.27 ]
  %783 = add nsw i64 %indvars.iv23.27, %782
  %arrayidx21.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %783
  %784 = load i32, i32* %arrayidx21.27, align 4
  %conv22.27 = uitofp i32 %784 to float
  %cmp23.27 = fcmp olt float %conv22.27, %mul9
  br i1 %cmp23.27, label %if.then25.27, label %if.else.27

if.else.27:                                       ; preds = %for.body18.27
  %cmp31.27 = fcmp ult float %conv22.27, %mul8
  br i1 %cmp31.27, label %if.else36.27, label %if.then33.27

if.then33.27:                                     ; preds = %if.else.27
  store i32 255, i32* %arrayidx21.27, align 4
  br label %for.inc41.27

if.else36.27:                                     ; preds = %if.else.27
  store i32 75, i32* %arrayidx21.27, align 4
  br label %for.inc41.27

if.then25.27:                                     ; preds = %for.body18.27
  store i32 0, i32* %arrayidx21.27, align 4
  br label %for.inc41.27

for.inc41.27:                                     ; preds = %if.then25.27, %if.else36.27, %if.then33.27
  %indvars.iv.next24.27 = add nuw nsw i64 %indvars.iv23.27, 1
  %lftr.wideiv26.27 = trunc i64 %indvars.iv.next24.27 to i32
  %exitcond27.27 = icmp eq i32 %lftr.wideiv26.27, %img_width
  br i1 %exitcond27.27, label %for.inc44.27, label %for.body18.27, !llvm.loop !3

for.inc44.27:                                     ; preds = %for.inc41.27
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.28

for.body18.lr.ph.28:                              ; preds = %for.inc44.27
  %indvars.iv.next29.27 = add nsw i64 %indvars.iv28, 28
  %785 = trunc i64 %indvars.iv.next29.27 to i32
  %mul19.28 = shl i32 %785, 7
  %786 = sext i32 %mul19.28 to i64
  br label %for.body18.28

for.body18.28:                                    ; preds = %for.inc41.28, %for.body18.lr.ph.28
  %indvars.iv23.28 = phi i64 [ 0, %for.body18.lr.ph.28 ], [ %indvars.iv.next24.28, %for.inc41.28 ]
  %787 = add nsw i64 %indvars.iv23.28, %786
  %arrayidx21.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %787
  %788 = load i32, i32* %arrayidx21.28, align 4
  %conv22.28 = uitofp i32 %788 to float
  %cmp23.28 = fcmp olt float %conv22.28, %mul9
  br i1 %cmp23.28, label %if.then25.28, label %if.else.28

if.else.28:                                       ; preds = %for.body18.28
  %cmp31.28 = fcmp ult float %conv22.28, %mul8
  br i1 %cmp31.28, label %if.else36.28, label %if.then33.28

if.then33.28:                                     ; preds = %if.else.28
  store i32 255, i32* %arrayidx21.28, align 4
  br label %for.inc41.28

if.else36.28:                                     ; preds = %if.else.28
  store i32 75, i32* %arrayidx21.28, align 4
  br label %for.inc41.28

if.then25.28:                                     ; preds = %for.body18.28
  store i32 0, i32* %arrayidx21.28, align 4
  br label %for.inc41.28

for.inc41.28:                                     ; preds = %if.then25.28, %if.else36.28, %if.then33.28
  %indvars.iv.next24.28 = add nuw nsw i64 %indvars.iv23.28, 1
  %lftr.wideiv26.28 = trunc i64 %indvars.iv.next24.28 to i32
  %exitcond27.28 = icmp eq i32 %lftr.wideiv26.28, %img_width
  br i1 %exitcond27.28, label %for.inc44.28, label %for.body18.28, !llvm.loop !3

for.inc44.28:                                     ; preds = %for.inc41.28
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.29

for.body18.lr.ph.29:                              ; preds = %for.inc44.28
  %indvars.iv.next29.28 = add nsw i64 %indvars.iv28, 29
  %789 = trunc i64 %indvars.iv.next29.28 to i32
  %mul19.29 = shl i32 %789, 7
  %790 = sext i32 %mul19.29 to i64
  br label %for.body18.29

for.body18.29:                                    ; preds = %for.inc41.29, %for.body18.lr.ph.29
  %indvars.iv23.29 = phi i64 [ 0, %for.body18.lr.ph.29 ], [ %indvars.iv.next24.29, %for.inc41.29 ]
  %791 = add nsw i64 %indvars.iv23.29, %790
  %arrayidx21.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %791
  %792 = load i32, i32* %arrayidx21.29, align 4
  %conv22.29 = uitofp i32 %792 to float
  %cmp23.29 = fcmp olt float %conv22.29, %mul9
  br i1 %cmp23.29, label %if.then25.29, label %if.else.29

if.else.29:                                       ; preds = %for.body18.29
  %cmp31.29 = fcmp ult float %conv22.29, %mul8
  br i1 %cmp31.29, label %if.else36.29, label %if.then33.29

if.then33.29:                                     ; preds = %if.else.29
  store i32 255, i32* %arrayidx21.29, align 4
  br label %for.inc41.29

if.else36.29:                                     ; preds = %if.else.29
  store i32 75, i32* %arrayidx21.29, align 4
  br label %for.inc41.29

if.then25.29:                                     ; preds = %for.body18.29
  store i32 0, i32* %arrayidx21.29, align 4
  br label %for.inc41.29

for.inc41.29:                                     ; preds = %if.then25.29, %if.else36.29, %if.then33.29
  %indvars.iv.next24.29 = add nuw nsw i64 %indvars.iv23.29, 1
  %lftr.wideiv26.29 = trunc i64 %indvars.iv.next24.29 to i32
  %exitcond27.29 = icmp eq i32 %lftr.wideiv26.29, %img_width
  br i1 %exitcond27.29, label %for.inc44.29, label %for.body18.29, !llvm.loop !3

for.inc44.29:                                     ; preds = %for.inc41.29
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.30

for.body18.lr.ph.30:                              ; preds = %for.inc44.29
  %indvars.iv.next29.29 = add nsw i64 %indvars.iv28, 30
  %793 = trunc i64 %indvars.iv.next29.29 to i32
  %mul19.30 = shl i32 %793, 7
  %794 = sext i32 %mul19.30 to i64
  br label %for.body18.30

for.body18.30:                                    ; preds = %for.inc41.30, %for.body18.lr.ph.30
  %indvars.iv23.30 = phi i64 [ 0, %for.body18.lr.ph.30 ], [ %indvars.iv.next24.30, %for.inc41.30 ]
  %795 = add nsw i64 %indvars.iv23.30, %794
  %arrayidx21.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %795
  %796 = load i32, i32* %arrayidx21.30, align 4
  %conv22.30 = uitofp i32 %796 to float
  %cmp23.30 = fcmp olt float %conv22.30, %mul9
  br i1 %cmp23.30, label %if.then25.30, label %if.else.30

if.else.30:                                       ; preds = %for.body18.30
  %cmp31.30 = fcmp ult float %conv22.30, %mul8
  br i1 %cmp31.30, label %if.else36.30, label %if.then33.30

if.then33.30:                                     ; preds = %if.else.30
  store i32 255, i32* %arrayidx21.30, align 4
  br label %for.inc41.30

if.else36.30:                                     ; preds = %if.else.30
  store i32 75, i32* %arrayidx21.30, align 4
  br label %for.inc41.30

if.then25.30:                                     ; preds = %for.body18.30
  store i32 0, i32* %arrayidx21.30, align 4
  br label %for.inc41.30

for.inc41.30:                                     ; preds = %if.then25.30, %if.else36.30, %if.then33.30
  %indvars.iv.next24.30 = add nuw nsw i64 %indvars.iv23.30, 1
  %lftr.wideiv26.30 = trunc i64 %indvars.iv.next24.30 to i32
  %exitcond27.30 = icmp eq i32 %lftr.wideiv26.30, %img_width
  br i1 %exitcond27.30, label %for.inc44.30, label %for.body18.30, !llvm.loop !3

for.inc44.30:                                     ; preds = %for.inc41.30
  br i1 %cmp168, label %for.inc44.31, label %for.body18.lr.ph.31

for.body18.lr.ph.31:                              ; preds = %for.inc44.30
  %indvars.iv.next29.30 = add nsw i64 %indvars.iv28, 31
  %797 = trunc i64 %indvars.iv.next29.30 to i32
  %mul19.31 = shl i32 %797, 7
  %798 = sext i32 %mul19.31 to i64
  br label %for.body18.31

for.body18.31:                                    ; preds = %for.inc41.31, %for.body18.lr.ph.31
  %indvars.iv23.31 = phi i64 [ 0, %for.body18.lr.ph.31 ], [ %indvars.iv.next24.31, %for.inc41.31 ]
  %799 = add nsw i64 %indvars.iv23.31, %798
  %arrayidx21.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %799
  %800 = load i32, i32* %arrayidx21.31, align 4
  %conv22.31 = uitofp i32 %800 to float
  %cmp23.31 = fcmp olt float %conv22.31, %mul9
  br i1 %cmp23.31, label %if.then25.31, label %if.else.31

if.else.31:                                       ; preds = %for.body18.31
  %cmp31.31 = fcmp ult float %conv22.31, %mul8
  br i1 %cmp31.31, label %if.else36.31, label %if.then33.31

if.then33.31:                                     ; preds = %if.else.31
  store i32 255, i32* %arrayidx21.31, align 4
  br label %for.inc41.31

if.else36.31:                                     ; preds = %if.else.31
  store i32 75, i32* %arrayidx21.31, align 4
  br label %for.inc41.31

if.then25.31:                                     ; preds = %for.body18.31
  store i32 0, i32* %arrayidx21.31, align 4
  br label %for.inc41.31

for.inc41.31:                                     ; preds = %if.then25.31, %if.else36.31, %if.then33.31
  %indvars.iv.next24.31 = add nuw nsw i64 %indvars.iv23.31, 1
  %lftr.wideiv26.31 = trunc i64 %indvars.iv.next24.31 to i32
  %exitcond27.31 = icmp eq i32 %lftr.wideiv26.31, %img_width
  br i1 %exitcond27.31, label %for.inc44.31.loopexit, label %for.body18.31, !llvm.loop !3

for.inc44.31.loopexit:                            ; preds = %for.inc41.31
  br label %for.inc44.31

for.inc44.31:                                     ; preds = %for.inc44.31.loopexit, %for.cond15.preheader, %for.inc44, %for.inc44.1, %for.inc44.2, %for.inc44.3, %for.inc44.4, %for.inc44.5, %for.inc44.6, %for.inc44.7, %for.inc44.8, %for.inc44.9, %for.inc44.10, %for.inc44.11, %for.inc44.12, %for.inc44.13, %for.inc44.14, %for.inc44.15, %for.inc44.16, %for.inc44.17, %for.inc44.18, %for.inc44.19, %for.inc44.20, %for.inc44.21, %for.inc44.22, %for.inc44.23, %for.inc44.24, %for.inc44.25, %for.inc44.26, %for.inc44.27, %for.inc44.28, %for.inc44.29, %for.inc44.30
  %indvars.iv.next29.31 = add nsw i64 %indvars.iv28, 32
  %lftr.wideiv30.31 = trunc i64 %indvars.iv.next29.31 to i32
  %exitcond31.31 = icmp eq i32 %lftr.wideiv30.31, %img_height
  br i1 %exitcond31.31, label %for.cond48.preheader, label %for.cond15.preheader, !llvm.loop !8
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
!7 = distinct !{!7, !2}
!8 = distinct !{!8, !2}
