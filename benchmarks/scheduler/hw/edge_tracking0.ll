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
  %xtraiter36 = and i32 %img_height, 3
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
  %8 = icmp ult i32 %3, 3
  br i1 %8, label %for.cond53.preheader.lr.ph, label %for.cond15.preheader.preheader

for.cond15.preheader.preheader:                   ; preds = %for.cond15.preheader.lr.ph.split
  br label %for.cond15.preheader

for.cond15.preheader:                             ; preds = %for.cond15.preheader.preheader, %for.inc44.3
  %indvars.iv28 = phi i64 [ %indvars.iv.next29.3, %for.inc44.3 ], [ %indvars.iv28.unr, %for.cond15.preheader.preheader ]
  br i1 %cmp168, label %for.inc44.3, label %for.body18.lr.ph

for.body18.lr.ph:                                 ; preds = %for.cond15.preheader
  %9 = trunc i64 %indvars.iv28 to i32
  %mul19 = shl i32 %9, 7
  %10 = sext i32 %mul19 to i64
  br label %for.body18

for.cond48.preheader:                             ; preds = %for.inc44.3
  %cmp495 = icmp eq i32 %img_height, 0
  br i1 %cmp495, label %for.end166, label %for.cond53.preheader.lr.ph

for.cond53.preheader.lr.ph:                       ; preds = %for.cond15.preheader.lr.ph.split, %for.cond48.preheader
  %cmp543 = icmp eq i32 %img_width, 0
  %11 = zext i32 %sub1 to i64
  %12 = zext i32 %sub to i64
  %13 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 3
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
  %34 = icmp ult i32 %13, 3
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
  br i1 %cmp168, label %for.inc44.3, label %for.body18.lr.ph.1

for.cond53.preheader:                             ; preds = %for.cond53.preheader.preheader, %for.inc164.3
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.3, %for.inc164.3 ], [ %indvars.iv19.unr, %for.cond53.preheader.preheader ]
  br i1 %cmp543, label %for.inc164.3, label %for.body56.lr.ph

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
  br i1 %cmp543, label %for.inc164.3, label %for.body56.lr.ph.1

for.end166.loopexit:                              ; preds = %for.inc164.3
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
  br i1 %cmp543, label %for.inc164.3, label %for.body56.lr.ph.2

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
  br i1 %cmp543, label %for.inc164.3, label %for.body56.lr.ph.3

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
  br i1 %exitcond.3, label %for.inc164.3.loopexit, label %for.body56.3, !llvm.loop !5

for.inc164.3.loopexit:                            ; preds = %for.inc161.3
  br label %for.inc164.3

for.inc164.3:                                     ; preds = %for.inc164.3.loopexit, %for.cond53.preheader, %for.inc164, %for.inc164.1, %for.inc164.2
  %indvars.iv.next20.3 = add nsw i64 %indvars.iv19, 4
  %lftr.wideiv21.3 = trunc i64 %indvars.iv.next20.3 to i32
  %exitcond22.3 = icmp eq i32 %lftr.wideiv21.3, %img_height
  br i1 %exitcond22.3, label %for.end166.loopexit, label %for.cond53.preheader, !llvm.loop !7

for.body18.lr.ph.1:                               ; preds = %for.inc44
  %indvars.iv.next29 = add nuw nsw i64 %indvars.iv28, 1
  %117 = trunc i64 %indvars.iv.next29 to i32
  %mul19.1 = shl i32 %117, 7
  %118 = sext i32 %mul19.1 to i64
  br label %for.body18.1

for.body18.1:                                     ; preds = %for.inc41.1, %for.body18.lr.ph.1
  %indvars.iv23.1 = phi i64 [ 0, %for.body18.lr.ph.1 ], [ %indvars.iv.next24.1, %for.inc41.1 ]
  %119 = add nsw i64 %indvars.iv23.1, %118
  %arrayidx21.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %119
  %120 = load i32, i32* %arrayidx21.1, align 4
  %conv22.1 = uitofp i32 %120 to float
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
  br i1 %cmp168, label %for.inc44.3, label %for.body18.lr.ph.2

for.body18.lr.ph.2:                               ; preds = %for.inc44.1
  %indvars.iv.next29.1 = add nsw i64 %indvars.iv28, 2
  %121 = trunc i64 %indvars.iv.next29.1 to i32
  %mul19.2 = shl i32 %121, 7
  %122 = sext i32 %mul19.2 to i64
  br label %for.body18.2

for.body18.2:                                     ; preds = %for.inc41.2, %for.body18.lr.ph.2
  %indvars.iv23.2 = phi i64 [ 0, %for.body18.lr.ph.2 ], [ %indvars.iv.next24.2, %for.inc41.2 ]
  %123 = add nsw i64 %indvars.iv23.2, %122
  %arrayidx21.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %123
  %124 = load i32, i32* %arrayidx21.2, align 4
  %conv22.2 = uitofp i32 %124 to float
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
  br i1 %cmp168, label %for.inc44.3, label %for.body18.lr.ph.3

for.body18.lr.ph.3:                               ; preds = %for.inc44.2
  %indvars.iv.next29.2 = add nsw i64 %indvars.iv28, 3
  %125 = trunc i64 %indvars.iv.next29.2 to i32
  %mul19.3 = shl i32 %125, 7
  %126 = sext i32 %mul19.3 to i64
  br label %for.body18.3

for.body18.3:                                     ; preds = %for.inc41.3, %for.body18.lr.ph.3
  %indvars.iv23.3 = phi i64 [ 0, %for.body18.lr.ph.3 ], [ %indvars.iv.next24.3, %for.inc41.3 ]
  %127 = add nsw i64 %indvars.iv23.3, %126
  %arrayidx21.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %127
  %128 = load i32, i32* %arrayidx21.3, align 4
  %conv22.3 = uitofp i32 %128 to float
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
  br i1 %exitcond27.3, label %for.inc44.3.loopexit, label %for.body18.3, !llvm.loop !3

for.inc44.3.loopexit:                             ; preds = %for.inc41.3
  br label %for.inc44.3

for.inc44.3:                                      ; preds = %for.inc44.3.loopexit, %for.cond15.preheader, %for.inc44, %for.inc44.1, %for.inc44.2
  %indvars.iv.next29.3 = add nsw i64 %indvars.iv28, 4
  %lftr.wideiv30.3 = trunc i64 %indvars.iv.next29.3 to i32
  %exitcond31.3 = icmp eq i32 %lftr.wideiv30.3, %img_height
  br i1 %exitcond31.3, label %for.cond48.preheader, label %for.cond15.preheader, !llvm.loop !8
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
