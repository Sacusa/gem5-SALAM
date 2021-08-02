; ModuleID = 'edge_tracking0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @edge_tracking(i32 %img_height, i32 %img_width, float %thr_weak_ratio, float %thr_strong_ratio, i8 zeroext %spm_part) #0 {
entry:
  %cmp = icmp eq i8 %spm_part, 1
  %. = select i1 %cmp, i8* inttoptr (i64 587284512 to i8*), i8* inttoptr (i64 587268128 to i8*)
  %sub = add i32 %img_height, -1
  %sub2 = add i32 %img_width, -1
  %mul = mul i32 %img_width, %img_height
  %cmp313 = icmp sgt i32 %mul, 0
  br i1 %cmp313, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %0 = mul i32 %img_width, %img_height
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %indvars.iv32 = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next33, %for.body ]
  %img_max.014 = phi i32 [ 0, %for.body.preheader ], [ %.img_max.0, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %indvars.iv32
  %1 = load i32, i32* %arrayidx, align 4
  %cmp5 = icmp ugt i32 %1, %img_max.014
  %.img_max.0 = select i1 %cmp5, i32 %1, i32 %img_max.014
  %indvars.iv.next33 = add nuw nsw i64 %indvars.iv32, 1
  %lftr.wideiv34 = trunc i64 %indvars.iv.next33 to i32
  %exitcond35 = icmp eq i32 %lftr.wideiv34, %0
  br i1 %exitcond35, label %for.end.loopexit, label %for.body, !llvm.loop !1

for.end.loopexit:                                 ; preds = %for.body
  %.img_max.0.lcssa = phi i32 [ %.img_max.0, %for.body ]
  %phitmp = uitofp i32 %.img_max.0.lcssa to float
  %phitmp73 = fmul float %phitmp, 0x3FE0189380000000
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %img_max.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %phitmp73, %for.end.loopexit ]
  %mul13 = fmul float %img_max.0.lcssa, 5.000000e-01
  %cmp1610 = icmp eq i32 %img_height, 0
  br i1 %cmp1610, label %for.end171, label %for.cond19.preheader.lr.ph

for.cond19.preheader.lr.ph:                       ; preds = %for.end
  %cmp208 = icmp eq i32 %img_width, 0
  %2 = add i32 %img_height, -1
  %xtraiter36 = and i32 %img_height, 31
  %lcmp.mod37 = icmp eq i32 %xtraiter36, 0
  br i1 %lcmp.mod37, label %for.cond19.preheader.lr.ph.split, label %for.cond19.preheader.prol.preheader

for.cond19.preheader.prol.preheader:              ; preds = %for.cond19.preheader.lr.ph
  br label %for.cond19.preheader.prol

for.cond19.preheader.prol:                        ; preds = %for.cond19.preheader.prol.preheader, %for.inc49.prol
  %indvars.iv28.prol = phi i64 [ %indvars.iv.next29.prol, %for.inc49.prol ], [ 0, %for.cond19.preheader.prol.preheader ]
  %prol.iter38 = phi i32 [ %prol.iter38.sub, %for.inc49.prol ], [ %xtraiter36, %for.cond19.preheader.prol.preheader ]
  br i1 %cmp208, label %for.inc49.prol, label %for.body22.lr.ph.prol

for.body22.lr.ph.prol:                            ; preds = %for.cond19.preheader.prol
  %3 = trunc i64 %indvars.iv28.prol to i32
  %mul23.prol = shl i32 %3, 7
  %4 = sext i32 %mul23.prol to i64
  br label %for.body22.prol

for.body22.prol:                                  ; preds = %for.inc46.prol, %for.body22.lr.ph.prol
  %indvars.iv23.prol = phi i64 [ 0, %for.body22.lr.ph.prol ], [ %indvars.iv.next24.prol, %for.inc46.prol ]
  %5 = add nsw i64 %indvars.iv23.prol, %4
  %arrayidx25.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %5
  %6 = load i32, i32* %arrayidx25.prol, align 4
  %conv26.prol = uitofp i32 %6 to float
  %cmp27.prol = fcmp olt float %conv26.prol, %mul13
  br i1 %cmp27.prol, label %if.then29.prol, label %if.else32.prol

if.else32.prol:                                   ; preds = %for.body22.prol
  %cmp36.prol = fcmp ult float %conv26.prol, %img_max.0.lcssa
  br i1 %cmp36.prol, label %if.else41.prol, label %if.then38.prol

if.then38.prol:                                   ; preds = %if.else32.prol
  store i32 255, i32* %arrayidx25.prol, align 4
  br label %for.inc46.prol

if.else41.prol:                                   ; preds = %if.else32.prol
  store i32 75, i32* %arrayidx25.prol, align 4
  br label %for.inc46.prol

if.then29.prol:                                   ; preds = %for.body22.prol
  store i32 0, i32* %arrayidx25.prol, align 4
  br label %for.inc46.prol

for.inc46.prol:                                   ; preds = %if.then29.prol, %if.else41.prol, %if.then38.prol
  %indvars.iv.next24.prol = add nuw nsw i64 %indvars.iv23.prol, 1
  %lftr.wideiv26.prol = trunc i64 %indvars.iv.next24.prol to i32
  %exitcond27.prol = icmp eq i32 %lftr.wideiv26.prol, %img_width
  br i1 %exitcond27.prol, label %for.inc49.prol.loopexit, label %for.body22.prol, !llvm.loop !3

for.inc49.prol.loopexit:                          ; preds = %for.inc46.prol
  br label %for.inc49.prol

for.inc49.prol:                                   ; preds = %for.inc49.prol.loopexit, %for.cond19.preheader.prol
  %indvars.iv.next29.prol = add nuw nsw i64 %indvars.iv28.prol, 1
  %prol.iter38.sub = add i32 %prol.iter38, -1
  %prol.iter38.cmp = icmp eq i32 %prol.iter38.sub, 0
  br i1 %prol.iter38.cmp, label %for.cond19.preheader.lr.ph.split.loopexit, label %for.cond19.preheader.prol, !llvm.loop !4

for.cond19.preheader.lr.ph.split.loopexit:        ; preds = %for.inc49.prol
  %indvars.iv.next29.prol.lcssa = phi i64 [ %indvars.iv.next29.prol, %for.inc49.prol ]
  br label %for.cond19.preheader.lr.ph.split

for.cond19.preheader.lr.ph.split:                 ; preds = %for.cond19.preheader.lr.ph.split.loopexit, %for.cond19.preheader.lr.ph
  %indvars.iv28.unr = phi i64 [ 0, %for.cond19.preheader.lr.ph ], [ %indvars.iv.next29.prol.lcssa, %for.cond19.preheader.lr.ph.split.loopexit ]
  %7 = icmp ult i32 %2, 31
  br i1 %7, label %for.cond58.preheader.lr.ph, label %for.cond19.preheader.preheader

for.cond19.preheader.preheader:                   ; preds = %for.cond19.preheader.lr.ph.split
  br label %for.cond19.preheader

for.cond19.preheader:                             ; preds = %for.cond19.preheader.preheader, %for.inc49.31
  %indvars.iv28 = phi i64 [ %indvars.iv.next29.31, %for.inc49.31 ], [ %indvars.iv28.unr, %for.cond19.preheader.preheader ]
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph

for.body22.lr.ph:                                 ; preds = %for.cond19.preheader
  %8 = trunc i64 %indvars.iv28 to i32
  %mul23 = shl i32 %8, 7
  %9 = sext i32 %mul23 to i64
  br label %for.body22

for.cond53.preheader:                             ; preds = %for.inc49.31
  %cmp545 = icmp eq i32 %img_height, 0
  br i1 %cmp545, label %for.end171, label %for.cond58.preheader.lr.ph

for.cond58.preheader.lr.ph:                       ; preds = %for.cond19.preheader.lr.ph.split, %for.cond53.preheader
  %cmp593 = icmp eq i32 %img_width, 0
  %10 = zext i32 %sub2 to i64
  %11 = zext i32 %sub to i64
  %12 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond58.preheader.lr.ph.split, label %for.cond58.preheader.prol.preheader

for.cond58.preheader.prol.preheader:              ; preds = %for.cond58.preheader.lr.ph
  br label %for.cond58.preheader.prol

for.cond58.preheader.prol:                        ; preds = %for.cond58.preheader.prol.preheader, %for.inc169.prol
  %indvars.iv19.prol = phi i64 [ %indvars.iv.next20.prol, %for.inc169.prol ], [ 0, %for.cond58.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc169.prol ], [ %xtraiter, %for.cond58.preheader.prol.preheader ]
  br i1 %cmp593, label %for.inc169.prol, label %for.body61.lr.ph.prol

for.body61.lr.ph.prol:                            ; preds = %for.cond58.preheader.prol
  %13 = trunc i64 %indvars.iv19.prol to i32
  %mul63.prol = shl nsw i32 %13, 7
  %cmp65.prol = icmp eq i64 %indvars.iv19.prol, 0
  %cmp67.prol = icmp eq i64 %indvars.iv19.prol, %11
  %or.cond.prol = or i1 %cmp65.prol, %cmp67.prol
  %14 = trunc i64 %indvars.iv19.prol to i32
  %sub84.prol = shl i32 %14, 7
  %mul94.prol = add i32 %sub84.prol, -128
  %sub111.prol = add i32 %mul63.prol, -1
  %add119.prol = or i32 %mul63.prol, 1
  %mul136.prol = add i32 %sub84.prol, 128
  %15 = sext i32 %mul63.prol to i64
  %16 = sext i32 %mul136.prol to i64
  %17 = sext i32 %mul94.prol to i64
  br label %for.body61.prol

for.body61.prol:                                  ; preds = %for.inc166.prol, %for.body61.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body61.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc166.prol ]
  %18 = add nsw i64 %indvars.iv.prol, %15
  %cmp70.prol = icmp eq i64 %indvars.iv.prol, 0
  %or.cond1.prol = or i1 %or.cond.prol, %cmp70.prol
  %cmp73.prol = icmp eq i64 %indvars.iv.prol, %10
  %or.cond2.prol = or i1 %cmp73.prol, %or.cond1.prol
  br i1 %or.cond2.prol, label %if.then75.prol, label %if.else78.prol

if.else78.prol:                                   ; preds = %for.body61.prol
  %arrayidx80.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %18
  %19 = load i32, i32* %arrayidx80.prol, align 4
  %cmp81.prol = icmp eq i32 %19, 75
  br i1 %cmp81.prol, label %if.then83.prol, label %if.else158.prol

if.else158.prol:                                  ; preds = %if.else78.prol
  %conv161.prol = trunc i32 %19 to i8
  %arrayidx163.prol = getelementptr inbounds i8, i8* %., i64 %18
  store i8 %conv161.prol, i8* %arrayidx163.prol, align 1
  br label %for.inc166.prol

if.then83.prol:                                   ; preds = %if.else78.prol
  %20 = trunc i64 %indvars.iv.prol to i32
  %sub86.prol = add i32 %20, %sub84.prol
  %add87.prol = add i32 %sub86.prol, -129
  %idxprom88.prol = sext i32 %add87.prol to i64
  %arrayidx89.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.prol
  %21 = load i32, i32* %arrayidx89.prol, align 4
  %cmp90.prol = icmp eq i32 %21, 255
  br i1 %cmp90.prol, label %if.then151.prol, label %lor.lhs.false92.prol

lor.lhs.false92.prol:                             ; preds = %if.then83.prol
  %22 = add nsw i64 %17, %indvars.iv.prol
  %arrayidx97.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %22
  %23 = load i32, i32* %arrayidx97.prol, align 4
  %cmp98.prol = icmp eq i32 %23, 255
  br i1 %cmp98.prol, label %if.then151.prol, label %lor.lhs.false100.prol

lor.lhs.false100.prol:                            ; preds = %lor.lhs.false92.prol
  %add104.prol = add i32 %sub86.prol, -127
  %idxprom105.prol = sext i32 %add104.prol to i64
  %arrayidx106.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.prol
  %24 = load i32, i32* %arrayidx106.prol, align 4
  %cmp107.prol = icmp eq i32 %24, 255
  br i1 %cmp107.prol, label %if.then151.prol, label %lor.lhs.false109.prol

lor.lhs.false109.prol:                            ; preds = %lor.lhs.false100.prol
  %25 = trunc i64 %indvars.iv.prol to i32
  %add112.prol = add i32 %sub111.prol, %25
  %idxprom113.prol = sext i32 %add112.prol to i64
  %arrayidx114.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.prol
  %26 = load i32, i32* %arrayidx114.prol, align 4
  %cmp115.prol = icmp eq i32 %26, 255
  br i1 %cmp115.prol, label %if.then151.prol, label %lor.lhs.false117.prol

lor.lhs.false117.prol:                            ; preds = %lor.lhs.false109.prol
  %27 = trunc i64 %indvars.iv.prol to i32
  %add120.prol = add i32 %add119.prol, %27
  %idxprom121.prol = sext i32 %add120.prol to i64
  %arrayidx122.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.prol
  %28 = load i32, i32* %arrayidx122.prol, align 4
  %cmp123.prol = icmp eq i32 %28, 255
  br i1 %cmp123.prol, label %if.then151.prol, label %lor.lhs.false125.prol

lor.lhs.false125.prol:                            ; preds = %lor.lhs.false117.prol
  %add129.prol = add i32 %sub86.prol, 127
  %idxprom130.prol = sext i32 %add129.prol to i64
  %arrayidx131.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.prol
  %29 = load i32, i32* %arrayidx131.prol, align 4
  %cmp132.prol = icmp eq i32 %29, 255
  br i1 %cmp132.prol, label %if.then151.prol, label %lor.lhs.false134.prol

lor.lhs.false134.prol:                            ; preds = %lor.lhs.false125.prol
  %30 = add nsw i64 %16, %indvars.iv.prol
  %arrayidx139.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %30
  %31 = load i32, i32* %arrayidx139.prol, align 4
  %cmp140.prol = icmp eq i32 %31, 255
  br i1 %cmp140.prol, label %if.then151.prol, label %lor.lhs.false142.prol

lor.lhs.false142.prol:                            ; preds = %lor.lhs.false134.prol
  %add146.prol = add i32 %sub86.prol, 129
  %idxprom147.prol = sext i32 %add146.prol to i64
  %arrayidx148.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.prol
  %32 = load i32, i32* %arrayidx148.prol, align 4
  %cmp149.prol = icmp eq i32 %32, 255
  br i1 %cmp149.prol, label %if.then151.prol, label %if.else154.prol

if.else154.prol:                                  ; preds = %lor.lhs.false142.prol
  %arrayidx156.prol = getelementptr inbounds i8, i8* %., i64 %18
  store i8 0, i8* %arrayidx156.prol, align 1
  br label %for.inc166.prol

if.then151.prol:                                  ; preds = %lor.lhs.false142.prol, %lor.lhs.false134.prol, %lor.lhs.false125.prol, %lor.lhs.false117.prol, %lor.lhs.false109.prol, %lor.lhs.false100.prol, %lor.lhs.false92.prol, %if.then83.prol
  %arrayidx153.prol = getelementptr inbounds i8, i8* %., i64 %18
  store i8 -1, i8* %arrayidx153.prol, align 1
  br label %for.inc166.prol

if.then75.prol:                                   ; preds = %for.body61.prol
  %arrayidx77.prol = getelementptr inbounds i8, i8* %., i64 %18
  store i8 0, i8* %arrayidx77.prol, align 1
  br label %for.inc166.prol

for.inc166.prol:                                  ; preds = %if.then75.prol, %if.then151.prol, %if.else154.prol, %if.else158.prol
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %img_width
  br i1 %exitcond.prol, label %for.inc169.prol.loopexit, label %for.body61.prol, !llvm.loop !5

for.inc169.prol.loopexit:                         ; preds = %for.inc166.prol
  br label %for.inc169.prol

for.inc169.prol:                                  ; preds = %for.inc169.prol.loopexit, %for.cond58.preheader.prol
  %indvars.iv.next20.prol = add nuw nsw i64 %indvars.iv19.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond58.preheader.lr.ph.split.loopexit, label %for.cond58.preheader.prol, !llvm.loop !6

for.cond58.preheader.lr.ph.split.loopexit:        ; preds = %for.inc169.prol
  %indvars.iv.next20.prol.lcssa = phi i64 [ %indvars.iv.next20.prol, %for.inc169.prol ]
  br label %for.cond58.preheader.lr.ph.split

for.cond58.preheader.lr.ph.split:                 ; preds = %for.cond58.preheader.lr.ph.split.loopexit, %for.cond58.preheader.lr.ph
  %indvars.iv19.unr = phi i64 [ 0, %for.cond58.preheader.lr.ph ], [ %indvars.iv.next20.prol.lcssa, %for.cond58.preheader.lr.ph.split.loopexit ]
  %33 = icmp ult i32 %12, 31
  br i1 %33, label %for.end171, label %for.cond58.preheader.preheader

for.cond58.preheader.preheader:                   ; preds = %for.cond58.preheader.lr.ph.split
  br label %for.cond58.preheader

for.body22:                                       ; preds = %for.inc46, %for.body22.lr.ph
  %indvars.iv23 = phi i64 [ 0, %for.body22.lr.ph ], [ %indvars.iv.next24, %for.inc46 ]
  %34 = add nsw i64 %indvars.iv23, %9
  %arrayidx25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %34
  %35 = load i32, i32* %arrayidx25, align 4
  %conv26 = uitofp i32 %35 to float
  %cmp27 = fcmp olt float %conv26, %mul13
  br i1 %cmp27, label %if.then29, label %if.else32

if.then29:                                        ; preds = %for.body22
  store i32 0, i32* %arrayidx25, align 4
  br label %for.inc46

if.else32:                                        ; preds = %for.body22
  %cmp36 = fcmp ult float %conv26, %img_max.0.lcssa
  br i1 %cmp36, label %if.else41, label %if.then38

if.then38:                                        ; preds = %if.else32
  store i32 255, i32* %arrayidx25, align 4
  br label %for.inc46

if.else41:                                        ; preds = %if.else32
  store i32 75, i32* %arrayidx25, align 4
  br label %for.inc46

for.inc46:                                        ; preds = %if.then29, %if.else41, %if.then38
  %indvars.iv.next24 = add nuw nsw i64 %indvars.iv23, 1
  %lftr.wideiv26 = trunc i64 %indvars.iv.next24 to i32
  %exitcond27 = icmp eq i32 %lftr.wideiv26, %img_width
  br i1 %exitcond27, label %for.inc49, label %for.body22, !llvm.loop !3

for.inc49:                                        ; preds = %for.inc46
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.1

for.cond58.preheader:                             ; preds = %for.cond58.preheader.preheader, %for.inc169.31
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.31, %for.inc169.31 ], [ %indvars.iv19.unr, %for.cond58.preheader.preheader ]
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph

for.body61.lr.ph:                                 ; preds = %for.cond58.preheader
  %36 = trunc i64 %indvars.iv19 to i32
  %mul63 = shl nsw i32 %36, 7
  %cmp65 = icmp eq i64 %indvars.iv19, 0
  %cmp67 = icmp eq i64 %indvars.iv19, %11
  %or.cond = or i1 %cmp65, %cmp67
  %37 = trunc i64 %indvars.iv19 to i32
  %sub84 = shl i32 %37, 7
  %mul94 = add i32 %sub84, -128
  %sub111 = add i32 %mul63, -1
  %add119 = or i32 %mul63, 1
  %mul136 = add i32 %sub84, 128
  %38 = sext i32 %mul63 to i64
  %39 = sext i32 %mul136 to i64
  %40 = sext i32 %mul94 to i64
  br label %for.body61

for.body61:                                       ; preds = %for.inc166, %for.body61.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body61.lr.ph ], [ %indvars.iv.next, %for.inc166 ]
  %41 = add nsw i64 %indvars.iv, %38
  %cmp70 = icmp eq i64 %indvars.iv, 0
  %or.cond1 = or i1 %or.cond, %cmp70
  %cmp73 = icmp eq i64 %indvars.iv, %10
  %or.cond2 = or i1 %cmp73, %or.cond1
  br i1 %or.cond2, label %if.then75, label %if.else78

if.then75:                                        ; preds = %for.body61
  %arrayidx77 = getelementptr inbounds i8, i8* %., i64 %41
  store i8 0, i8* %arrayidx77, align 1
  br label %for.inc166

if.else78:                                        ; preds = %for.body61
  %arrayidx80 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %41
  %42 = load i32, i32* %arrayidx80, align 4
  %cmp81 = icmp eq i32 %42, 75
  br i1 %cmp81, label %if.then83, label %if.else158

if.then83:                                        ; preds = %if.else78
  %43 = trunc i64 %indvars.iv to i32
  %sub86 = add i32 %43, %sub84
  %add87 = add i32 %sub86, -129
  %idxprom88 = sext i32 %add87 to i64
  %arrayidx89 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88
  %44 = load i32, i32* %arrayidx89, align 4
  %cmp90 = icmp eq i32 %44, 255
  br i1 %cmp90, label %if.then151, label %lor.lhs.false92

lor.lhs.false92:                                  ; preds = %if.then83
  %45 = add nsw i64 %40, %indvars.iv
  %arrayidx97 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %45
  %46 = load i32, i32* %arrayidx97, align 4
  %cmp98 = icmp eq i32 %46, 255
  br i1 %cmp98, label %if.then151, label %lor.lhs.false100

lor.lhs.false100:                                 ; preds = %lor.lhs.false92
  %add104 = add i32 %sub86, -127
  %idxprom105 = sext i32 %add104 to i64
  %arrayidx106 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105
  %47 = load i32, i32* %arrayidx106, align 4
  %cmp107 = icmp eq i32 %47, 255
  br i1 %cmp107, label %if.then151, label %lor.lhs.false109

lor.lhs.false109:                                 ; preds = %lor.lhs.false100
  %48 = trunc i64 %indvars.iv to i32
  %add112 = add i32 %sub111, %48
  %idxprom113 = sext i32 %add112 to i64
  %arrayidx114 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113
  %49 = load i32, i32* %arrayidx114, align 4
  %cmp115 = icmp eq i32 %49, 255
  br i1 %cmp115, label %if.then151, label %lor.lhs.false117

lor.lhs.false117:                                 ; preds = %lor.lhs.false109
  %50 = trunc i64 %indvars.iv to i32
  %add120 = add i32 %add119, %50
  %idxprom121 = sext i32 %add120 to i64
  %arrayidx122 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121
  %51 = load i32, i32* %arrayidx122, align 4
  %cmp123 = icmp eq i32 %51, 255
  br i1 %cmp123, label %if.then151, label %lor.lhs.false125

lor.lhs.false125:                                 ; preds = %lor.lhs.false117
  %add129 = add i32 %sub86, 127
  %idxprom130 = sext i32 %add129 to i64
  %arrayidx131 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130
  %52 = load i32, i32* %arrayidx131, align 4
  %cmp132 = icmp eq i32 %52, 255
  br i1 %cmp132, label %if.then151, label %lor.lhs.false134

lor.lhs.false134:                                 ; preds = %lor.lhs.false125
  %53 = add nsw i64 %39, %indvars.iv
  %arrayidx139 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %53
  %54 = load i32, i32* %arrayidx139, align 4
  %cmp140 = icmp eq i32 %54, 255
  br i1 %cmp140, label %if.then151, label %lor.lhs.false142

lor.lhs.false142:                                 ; preds = %lor.lhs.false134
  %add146 = add i32 %sub86, 129
  %idxprom147 = sext i32 %add146 to i64
  %arrayidx148 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147
  %55 = load i32, i32* %arrayidx148, align 4
  %cmp149 = icmp eq i32 %55, 255
  br i1 %cmp149, label %if.then151, label %if.else154

if.then151:                                       ; preds = %lor.lhs.false142, %lor.lhs.false134, %lor.lhs.false125, %lor.lhs.false117, %lor.lhs.false109, %lor.lhs.false100, %lor.lhs.false92, %if.then83
  %arrayidx153 = getelementptr inbounds i8, i8* %., i64 %41
  store i8 -1, i8* %arrayidx153, align 1
  br label %for.inc166

if.else154:                                       ; preds = %lor.lhs.false142
  %arrayidx156 = getelementptr inbounds i8, i8* %., i64 %41
  store i8 0, i8* %arrayidx156, align 1
  br label %for.inc166

if.else158:                                       ; preds = %if.else78
  %conv161 = trunc i32 %42 to i8
  %arrayidx163 = getelementptr inbounds i8, i8* %., i64 %41
  store i8 %conv161, i8* %arrayidx163, align 1
  br label %for.inc166

for.inc166:                                       ; preds = %if.then75, %if.then151, %if.else154, %if.else158
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %img_width
  br i1 %exitcond, label %for.inc169, label %for.body61, !llvm.loop !5

for.inc169:                                       ; preds = %for.inc166
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.1

for.end171.loopexit:                              ; preds = %for.inc169.31
  br label %for.end171

for.end171:                                       ; preds = %for.end171.loopexit, %for.end, %for.cond58.preheader.lr.ph.split, %for.cond53.preheader
  ret void

for.body61.lr.ph.1:                               ; preds = %for.inc169
  %56 = trunc i64 %indvars.iv.next20 to i32
  %mul63.1 = shl nsw i32 %56, 7
  %cmp67.1 = icmp eq i64 %indvars.iv.next20, %11
  %57 = trunc i64 %indvars.iv.next20 to i32
  %sub84.1 = shl i32 %57, 7
  %mul94.1 = add i32 %sub84.1, -128
  %sub111.1 = add i32 %mul63.1, -1
  %add119.1 = or i32 %mul63.1, 1
  %mul136.1 = add i32 %sub84.1, 128
  %58 = sext i32 %mul63.1 to i64
  %59 = sext i32 %mul136.1 to i64
  %60 = sext i32 %mul94.1 to i64
  br label %for.body61.1

for.body61.1:                                     ; preds = %for.inc166.1, %for.body61.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body61.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc166.1 ]
  %61 = add nsw i64 %indvars.iv.1, %58
  %cmp70.1 = icmp eq i64 %indvars.iv.1, 0
  %or.cond1.1 = or i1 %cmp67.1, %cmp70.1
  %cmp73.1 = icmp eq i64 %indvars.iv.1, %10
  %or.cond2.1 = or i1 %cmp73.1, %or.cond1.1
  br i1 %or.cond2.1, label %if.then75.1, label %if.else78.1

if.else78.1:                                      ; preds = %for.body61.1
  %arrayidx80.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %61
  %62 = load i32, i32* %arrayidx80.1, align 4
  %cmp81.1 = icmp eq i32 %62, 75
  br i1 %cmp81.1, label %if.then83.1, label %if.else158.1

if.else158.1:                                     ; preds = %if.else78.1
  %conv161.1 = trunc i32 %62 to i8
  %arrayidx163.1 = getelementptr inbounds i8, i8* %., i64 %61
  store i8 %conv161.1, i8* %arrayidx163.1, align 1
  br label %for.inc166.1

if.then83.1:                                      ; preds = %if.else78.1
  %63 = trunc i64 %indvars.iv.1 to i32
  %sub86.1 = add i32 %63, %sub84.1
  %add87.1 = add i32 %sub86.1, -129
  %idxprom88.1 = sext i32 %add87.1 to i64
  %arrayidx89.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.1
  %64 = load i32, i32* %arrayidx89.1, align 4
  %cmp90.1 = icmp eq i32 %64, 255
  br i1 %cmp90.1, label %if.then151.1, label %lor.lhs.false92.1

lor.lhs.false92.1:                                ; preds = %if.then83.1
  %65 = add nsw i64 %60, %indvars.iv.1
  %arrayidx97.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %65
  %66 = load i32, i32* %arrayidx97.1, align 4
  %cmp98.1 = icmp eq i32 %66, 255
  br i1 %cmp98.1, label %if.then151.1, label %lor.lhs.false100.1

lor.lhs.false100.1:                               ; preds = %lor.lhs.false92.1
  %add104.1 = add i32 %sub86.1, -127
  %idxprom105.1 = sext i32 %add104.1 to i64
  %arrayidx106.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.1
  %67 = load i32, i32* %arrayidx106.1, align 4
  %cmp107.1 = icmp eq i32 %67, 255
  br i1 %cmp107.1, label %if.then151.1, label %lor.lhs.false109.1

lor.lhs.false109.1:                               ; preds = %lor.lhs.false100.1
  %68 = trunc i64 %indvars.iv.1 to i32
  %add112.1 = add i32 %sub111.1, %68
  %idxprom113.1 = sext i32 %add112.1 to i64
  %arrayidx114.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.1
  %69 = load i32, i32* %arrayidx114.1, align 4
  %cmp115.1 = icmp eq i32 %69, 255
  br i1 %cmp115.1, label %if.then151.1, label %lor.lhs.false117.1

lor.lhs.false117.1:                               ; preds = %lor.lhs.false109.1
  %70 = trunc i64 %indvars.iv.1 to i32
  %add120.1 = add i32 %add119.1, %70
  %idxprom121.1 = sext i32 %add120.1 to i64
  %arrayidx122.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.1
  %71 = load i32, i32* %arrayidx122.1, align 4
  %cmp123.1 = icmp eq i32 %71, 255
  br i1 %cmp123.1, label %if.then151.1, label %lor.lhs.false125.1

lor.lhs.false125.1:                               ; preds = %lor.lhs.false117.1
  %add129.1 = add i32 %sub86.1, 127
  %idxprom130.1 = sext i32 %add129.1 to i64
  %arrayidx131.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.1
  %72 = load i32, i32* %arrayidx131.1, align 4
  %cmp132.1 = icmp eq i32 %72, 255
  br i1 %cmp132.1, label %if.then151.1, label %lor.lhs.false134.1

lor.lhs.false134.1:                               ; preds = %lor.lhs.false125.1
  %73 = add nsw i64 %59, %indvars.iv.1
  %arrayidx139.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %73
  %74 = load i32, i32* %arrayidx139.1, align 4
  %cmp140.1 = icmp eq i32 %74, 255
  br i1 %cmp140.1, label %if.then151.1, label %lor.lhs.false142.1

lor.lhs.false142.1:                               ; preds = %lor.lhs.false134.1
  %add146.1 = add i32 %sub86.1, 129
  %idxprom147.1 = sext i32 %add146.1 to i64
  %arrayidx148.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.1
  %75 = load i32, i32* %arrayidx148.1, align 4
  %cmp149.1 = icmp eq i32 %75, 255
  br i1 %cmp149.1, label %if.then151.1, label %if.else154.1

if.else154.1:                                     ; preds = %lor.lhs.false142.1
  %arrayidx156.1 = getelementptr inbounds i8, i8* %., i64 %61
  store i8 0, i8* %arrayidx156.1, align 1
  br label %for.inc166.1

if.then151.1:                                     ; preds = %lor.lhs.false142.1, %lor.lhs.false134.1, %lor.lhs.false125.1, %lor.lhs.false117.1, %lor.lhs.false109.1, %lor.lhs.false100.1, %lor.lhs.false92.1, %if.then83.1
  %arrayidx153.1 = getelementptr inbounds i8, i8* %., i64 %61
  store i8 -1, i8* %arrayidx153.1, align 1
  br label %for.inc166.1

if.then75.1:                                      ; preds = %for.body61.1
  %arrayidx77.1 = getelementptr inbounds i8, i8* %., i64 %61
  store i8 0, i8* %arrayidx77.1, align 1
  br label %for.inc166.1

for.inc166.1:                                     ; preds = %if.then75.1, %if.then151.1, %if.else154.1, %if.else158.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %img_width
  br i1 %exitcond.1, label %for.inc169.1, label %for.body61.1, !llvm.loop !5

for.inc169.1:                                     ; preds = %for.inc166.1
  %indvars.iv.next20.1 = add nsw i64 %indvars.iv19, 2
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.2

for.body61.lr.ph.2:                               ; preds = %for.inc169.1
  %76 = trunc i64 %indvars.iv.next20.1 to i32
  %mul63.2 = shl nsw i32 %76, 7
  %cmp67.2 = icmp eq i64 %indvars.iv.next20.1, %11
  %77 = trunc i64 %indvars.iv.next20.1 to i32
  %sub84.2 = shl i32 %77, 7
  %mul94.2 = add i32 %sub84.2, -128
  %sub111.2 = add i32 %mul63.2, -1
  %add119.2 = or i32 %mul63.2, 1
  %mul136.2 = add i32 %sub84.2, 128
  %78 = sext i32 %mul63.2 to i64
  %79 = sext i32 %mul136.2 to i64
  %80 = sext i32 %mul94.2 to i64
  br label %for.body61.2

for.body61.2:                                     ; preds = %for.inc166.2, %for.body61.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body61.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc166.2 ]
  %81 = add nsw i64 %indvars.iv.2, %78
  %cmp70.2 = icmp eq i64 %indvars.iv.2, 0
  %or.cond1.2 = or i1 %cmp67.2, %cmp70.2
  %cmp73.2 = icmp eq i64 %indvars.iv.2, %10
  %or.cond2.2 = or i1 %cmp73.2, %or.cond1.2
  br i1 %or.cond2.2, label %if.then75.2, label %if.else78.2

if.else78.2:                                      ; preds = %for.body61.2
  %arrayidx80.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %81
  %82 = load i32, i32* %arrayidx80.2, align 4
  %cmp81.2 = icmp eq i32 %82, 75
  br i1 %cmp81.2, label %if.then83.2, label %if.else158.2

if.else158.2:                                     ; preds = %if.else78.2
  %conv161.2 = trunc i32 %82 to i8
  %arrayidx163.2 = getelementptr inbounds i8, i8* %., i64 %81
  store i8 %conv161.2, i8* %arrayidx163.2, align 1
  br label %for.inc166.2

if.then83.2:                                      ; preds = %if.else78.2
  %83 = trunc i64 %indvars.iv.2 to i32
  %sub86.2 = add i32 %83, %sub84.2
  %add87.2 = add i32 %sub86.2, -129
  %idxprom88.2 = sext i32 %add87.2 to i64
  %arrayidx89.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.2
  %84 = load i32, i32* %arrayidx89.2, align 4
  %cmp90.2 = icmp eq i32 %84, 255
  br i1 %cmp90.2, label %if.then151.2, label %lor.lhs.false92.2

lor.lhs.false92.2:                                ; preds = %if.then83.2
  %85 = add nsw i64 %80, %indvars.iv.2
  %arrayidx97.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %85
  %86 = load i32, i32* %arrayidx97.2, align 4
  %cmp98.2 = icmp eq i32 %86, 255
  br i1 %cmp98.2, label %if.then151.2, label %lor.lhs.false100.2

lor.lhs.false100.2:                               ; preds = %lor.lhs.false92.2
  %add104.2 = add i32 %sub86.2, -127
  %idxprom105.2 = sext i32 %add104.2 to i64
  %arrayidx106.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.2
  %87 = load i32, i32* %arrayidx106.2, align 4
  %cmp107.2 = icmp eq i32 %87, 255
  br i1 %cmp107.2, label %if.then151.2, label %lor.lhs.false109.2

lor.lhs.false109.2:                               ; preds = %lor.lhs.false100.2
  %88 = trunc i64 %indvars.iv.2 to i32
  %add112.2 = add i32 %sub111.2, %88
  %idxprom113.2 = sext i32 %add112.2 to i64
  %arrayidx114.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.2
  %89 = load i32, i32* %arrayidx114.2, align 4
  %cmp115.2 = icmp eq i32 %89, 255
  br i1 %cmp115.2, label %if.then151.2, label %lor.lhs.false117.2

lor.lhs.false117.2:                               ; preds = %lor.lhs.false109.2
  %90 = trunc i64 %indvars.iv.2 to i32
  %add120.2 = add i32 %add119.2, %90
  %idxprom121.2 = sext i32 %add120.2 to i64
  %arrayidx122.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.2
  %91 = load i32, i32* %arrayidx122.2, align 4
  %cmp123.2 = icmp eq i32 %91, 255
  br i1 %cmp123.2, label %if.then151.2, label %lor.lhs.false125.2

lor.lhs.false125.2:                               ; preds = %lor.lhs.false117.2
  %add129.2 = add i32 %sub86.2, 127
  %idxprom130.2 = sext i32 %add129.2 to i64
  %arrayidx131.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.2
  %92 = load i32, i32* %arrayidx131.2, align 4
  %cmp132.2 = icmp eq i32 %92, 255
  br i1 %cmp132.2, label %if.then151.2, label %lor.lhs.false134.2

lor.lhs.false134.2:                               ; preds = %lor.lhs.false125.2
  %93 = add nsw i64 %79, %indvars.iv.2
  %arrayidx139.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %93
  %94 = load i32, i32* %arrayidx139.2, align 4
  %cmp140.2 = icmp eq i32 %94, 255
  br i1 %cmp140.2, label %if.then151.2, label %lor.lhs.false142.2

lor.lhs.false142.2:                               ; preds = %lor.lhs.false134.2
  %add146.2 = add i32 %sub86.2, 129
  %idxprom147.2 = sext i32 %add146.2 to i64
  %arrayidx148.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.2
  %95 = load i32, i32* %arrayidx148.2, align 4
  %cmp149.2 = icmp eq i32 %95, 255
  br i1 %cmp149.2, label %if.then151.2, label %if.else154.2

if.else154.2:                                     ; preds = %lor.lhs.false142.2
  %arrayidx156.2 = getelementptr inbounds i8, i8* %., i64 %81
  store i8 0, i8* %arrayidx156.2, align 1
  br label %for.inc166.2

if.then151.2:                                     ; preds = %lor.lhs.false142.2, %lor.lhs.false134.2, %lor.lhs.false125.2, %lor.lhs.false117.2, %lor.lhs.false109.2, %lor.lhs.false100.2, %lor.lhs.false92.2, %if.then83.2
  %arrayidx153.2 = getelementptr inbounds i8, i8* %., i64 %81
  store i8 -1, i8* %arrayidx153.2, align 1
  br label %for.inc166.2

if.then75.2:                                      ; preds = %for.body61.2
  %arrayidx77.2 = getelementptr inbounds i8, i8* %., i64 %81
  store i8 0, i8* %arrayidx77.2, align 1
  br label %for.inc166.2

for.inc166.2:                                     ; preds = %if.then75.2, %if.then151.2, %if.else154.2, %if.else158.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %img_width
  br i1 %exitcond.2, label %for.inc169.2, label %for.body61.2, !llvm.loop !5

for.inc169.2:                                     ; preds = %for.inc166.2
  %indvars.iv.next20.2 = add nsw i64 %indvars.iv19, 3
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.3

for.body61.lr.ph.3:                               ; preds = %for.inc169.2
  %96 = trunc i64 %indvars.iv.next20.2 to i32
  %mul63.3 = shl nsw i32 %96, 7
  %cmp67.3 = icmp eq i64 %indvars.iv.next20.2, %11
  %97 = trunc i64 %indvars.iv.next20.2 to i32
  %sub84.3 = shl i32 %97, 7
  %mul94.3 = add i32 %sub84.3, -128
  %sub111.3 = add i32 %mul63.3, -1
  %add119.3 = or i32 %mul63.3, 1
  %mul136.3 = add i32 %sub84.3, 128
  %98 = sext i32 %mul63.3 to i64
  %99 = sext i32 %mul136.3 to i64
  %100 = sext i32 %mul94.3 to i64
  br label %for.body61.3

for.body61.3:                                     ; preds = %for.inc166.3, %for.body61.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body61.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc166.3 ]
  %101 = add nsw i64 %indvars.iv.3, %98
  %cmp70.3 = icmp eq i64 %indvars.iv.3, 0
  %or.cond1.3 = or i1 %cmp67.3, %cmp70.3
  %cmp73.3 = icmp eq i64 %indvars.iv.3, %10
  %or.cond2.3 = or i1 %cmp73.3, %or.cond1.3
  br i1 %or.cond2.3, label %if.then75.3, label %if.else78.3

if.else78.3:                                      ; preds = %for.body61.3
  %arrayidx80.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %101
  %102 = load i32, i32* %arrayidx80.3, align 4
  %cmp81.3 = icmp eq i32 %102, 75
  br i1 %cmp81.3, label %if.then83.3, label %if.else158.3

if.else158.3:                                     ; preds = %if.else78.3
  %conv161.3 = trunc i32 %102 to i8
  %arrayidx163.3 = getelementptr inbounds i8, i8* %., i64 %101
  store i8 %conv161.3, i8* %arrayidx163.3, align 1
  br label %for.inc166.3

if.then83.3:                                      ; preds = %if.else78.3
  %103 = trunc i64 %indvars.iv.3 to i32
  %sub86.3 = add i32 %103, %sub84.3
  %add87.3 = add i32 %sub86.3, -129
  %idxprom88.3 = sext i32 %add87.3 to i64
  %arrayidx89.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.3
  %104 = load i32, i32* %arrayidx89.3, align 4
  %cmp90.3 = icmp eq i32 %104, 255
  br i1 %cmp90.3, label %if.then151.3, label %lor.lhs.false92.3

lor.lhs.false92.3:                                ; preds = %if.then83.3
  %105 = add nsw i64 %100, %indvars.iv.3
  %arrayidx97.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %105
  %106 = load i32, i32* %arrayidx97.3, align 4
  %cmp98.3 = icmp eq i32 %106, 255
  br i1 %cmp98.3, label %if.then151.3, label %lor.lhs.false100.3

lor.lhs.false100.3:                               ; preds = %lor.lhs.false92.3
  %add104.3 = add i32 %sub86.3, -127
  %idxprom105.3 = sext i32 %add104.3 to i64
  %arrayidx106.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.3
  %107 = load i32, i32* %arrayidx106.3, align 4
  %cmp107.3 = icmp eq i32 %107, 255
  br i1 %cmp107.3, label %if.then151.3, label %lor.lhs.false109.3

lor.lhs.false109.3:                               ; preds = %lor.lhs.false100.3
  %108 = trunc i64 %indvars.iv.3 to i32
  %add112.3 = add i32 %sub111.3, %108
  %idxprom113.3 = sext i32 %add112.3 to i64
  %arrayidx114.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.3
  %109 = load i32, i32* %arrayidx114.3, align 4
  %cmp115.3 = icmp eq i32 %109, 255
  br i1 %cmp115.3, label %if.then151.3, label %lor.lhs.false117.3

lor.lhs.false117.3:                               ; preds = %lor.lhs.false109.3
  %110 = trunc i64 %indvars.iv.3 to i32
  %add120.3 = add i32 %add119.3, %110
  %idxprom121.3 = sext i32 %add120.3 to i64
  %arrayidx122.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.3
  %111 = load i32, i32* %arrayidx122.3, align 4
  %cmp123.3 = icmp eq i32 %111, 255
  br i1 %cmp123.3, label %if.then151.3, label %lor.lhs.false125.3

lor.lhs.false125.3:                               ; preds = %lor.lhs.false117.3
  %add129.3 = add i32 %sub86.3, 127
  %idxprom130.3 = sext i32 %add129.3 to i64
  %arrayidx131.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.3
  %112 = load i32, i32* %arrayidx131.3, align 4
  %cmp132.3 = icmp eq i32 %112, 255
  br i1 %cmp132.3, label %if.then151.3, label %lor.lhs.false134.3

lor.lhs.false134.3:                               ; preds = %lor.lhs.false125.3
  %113 = add nsw i64 %99, %indvars.iv.3
  %arrayidx139.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %113
  %114 = load i32, i32* %arrayidx139.3, align 4
  %cmp140.3 = icmp eq i32 %114, 255
  br i1 %cmp140.3, label %if.then151.3, label %lor.lhs.false142.3

lor.lhs.false142.3:                               ; preds = %lor.lhs.false134.3
  %add146.3 = add i32 %sub86.3, 129
  %idxprom147.3 = sext i32 %add146.3 to i64
  %arrayidx148.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.3
  %115 = load i32, i32* %arrayidx148.3, align 4
  %cmp149.3 = icmp eq i32 %115, 255
  br i1 %cmp149.3, label %if.then151.3, label %if.else154.3

if.else154.3:                                     ; preds = %lor.lhs.false142.3
  %arrayidx156.3 = getelementptr inbounds i8, i8* %., i64 %101
  store i8 0, i8* %arrayidx156.3, align 1
  br label %for.inc166.3

if.then151.3:                                     ; preds = %lor.lhs.false142.3, %lor.lhs.false134.3, %lor.lhs.false125.3, %lor.lhs.false117.3, %lor.lhs.false109.3, %lor.lhs.false100.3, %lor.lhs.false92.3, %if.then83.3
  %arrayidx153.3 = getelementptr inbounds i8, i8* %., i64 %101
  store i8 -1, i8* %arrayidx153.3, align 1
  br label %for.inc166.3

if.then75.3:                                      ; preds = %for.body61.3
  %arrayidx77.3 = getelementptr inbounds i8, i8* %., i64 %101
  store i8 0, i8* %arrayidx77.3, align 1
  br label %for.inc166.3

for.inc166.3:                                     ; preds = %if.then75.3, %if.then151.3, %if.else154.3, %if.else158.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %img_width
  br i1 %exitcond.3, label %for.inc169.3, label %for.body61.3, !llvm.loop !5

for.inc169.3:                                     ; preds = %for.inc166.3
  %indvars.iv.next20.3 = add nsw i64 %indvars.iv19, 4
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.4

for.body61.lr.ph.4:                               ; preds = %for.inc169.3
  %116 = trunc i64 %indvars.iv.next20.3 to i32
  %mul63.4 = shl nsw i32 %116, 7
  %cmp67.4 = icmp eq i64 %indvars.iv.next20.3, %11
  %117 = trunc i64 %indvars.iv.next20.3 to i32
  %sub84.4 = shl i32 %117, 7
  %mul94.4 = add i32 %sub84.4, -128
  %sub111.4 = add i32 %mul63.4, -1
  %add119.4 = or i32 %mul63.4, 1
  %mul136.4 = add i32 %sub84.4, 128
  %118 = sext i32 %mul63.4 to i64
  %119 = sext i32 %mul136.4 to i64
  %120 = sext i32 %mul94.4 to i64
  br label %for.body61.4

for.body61.4:                                     ; preds = %for.inc166.4, %for.body61.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body61.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc166.4 ]
  %121 = add nsw i64 %indvars.iv.4, %118
  %cmp70.4 = icmp eq i64 %indvars.iv.4, 0
  %or.cond1.4 = or i1 %cmp67.4, %cmp70.4
  %cmp73.4 = icmp eq i64 %indvars.iv.4, %10
  %or.cond2.4 = or i1 %cmp73.4, %or.cond1.4
  br i1 %or.cond2.4, label %if.then75.4, label %if.else78.4

if.else78.4:                                      ; preds = %for.body61.4
  %arrayidx80.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %121
  %122 = load i32, i32* %arrayidx80.4, align 4
  %cmp81.4 = icmp eq i32 %122, 75
  br i1 %cmp81.4, label %if.then83.4, label %if.else158.4

if.else158.4:                                     ; preds = %if.else78.4
  %conv161.4 = trunc i32 %122 to i8
  %arrayidx163.4 = getelementptr inbounds i8, i8* %., i64 %121
  store i8 %conv161.4, i8* %arrayidx163.4, align 1
  br label %for.inc166.4

if.then83.4:                                      ; preds = %if.else78.4
  %123 = trunc i64 %indvars.iv.4 to i32
  %sub86.4 = add i32 %123, %sub84.4
  %add87.4 = add i32 %sub86.4, -129
  %idxprom88.4 = sext i32 %add87.4 to i64
  %arrayidx89.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.4
  %124 = load i32, i32* %arrayidx89.4, align 4
  %cmp90.4 = icmp eq i32 %124, 255
  br i1 %cmp90.4, label %if.then151.4, label %lor.lhs.false92.4

lor.lhs.false92.4:                                ; preds = %if.then83.4
  %125 = add nsw i64 %120, %indvars.iv.4
  %arrayidx97.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %125
  %126 = load i32, i32* %arrayidx97.4, align 4
  %cmp98.4 = icmp eq i32 %126, 255
  br i1 %cmp98.4, label %if.then151.4, label %lor.lhs.false100.4

lor.lhs.false100.4:                               ; preds = %lor.lhs.false92.4
  %add104.4 = add i32 %sub86.4, -127
  %idxprom105.4 = sext i32 %add104.4 to i64
  %arrayidx106.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.4
  %127 = load i32, i32* %arrayidx106.4, align 4
  %cmp107.4 = icmp eq i32 %127, 255
  br i1 %cmp107.4, label %if.then151.4, label %lor.lhs.false109.4

lor.lhs.false109.4:                               ; preds = %lor.lhs.false100.4
  %128 = trunc i64 %indvars.iv.4 to i32
  %add112.4 = add i32 %sub111.4, %128
  %idxprom113.4 = sext i32 %add112.4 to i64
  %arrayidx114.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.4
  %129 = load i32, i32* %arrayidx114.4, align 4
  %cmp115.4 = icmp eq i32 %129, 255
  br i1 %cmp115.4, label %if.then151.4, label %lor.lhs.false117.4

lor.lhs.false117.4:                               ; preds = %lor.lhs.false109.4
  %130 = trunc i64 %indvars.iv.4 to i32
  %add120.4 = add i32 %add119.4, %130
  %idxprom121.4 = sext i32 %add120.4 to i64
  %arrayidx122.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.4
  %131 = load i32, i32* %arrayidx122.4, align 4
  %cmp123.4 = icmp eq i32 %131, 255
  br i1 %cmp123.4, label %if.then151.4, label %lor.lhs.false125.4

lor.lhs.false125.4:                               ; preds = %lor.lhs.false117.4
  %add129.4 = add i32 %sub86.4, 127
  %idxprom130.4 = sext i32 %add129.4 to i64
  %arrayidx131.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.4
  %132 = load i32, i32* %arrayidx131.4, align 4
  %cmp132.4 = icmp eq i32 %132, 255
  br i1 %cmp132.4, label %if.then151.4, label %lor.lhs.false134.4

lor.lhs.false134.4:                               ; preds = %lor.lhs.false125.4
  %133 = add nsw i64 %119, %indvars.iv.4
  %arrayidx139.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %133
  %134 = load i32, i32* %arrayidx139.4, align 4
  %cmp140.4 = icmp eq i32 %134, 255
  br i1 %cmp140.4, label %if.then151.4, label %lor.lhs.false142.4

lor.lhs.false142.4:                               ; preds = %lor.lhs.false134.4
  %add146.4 = add i32 %sub86.4, 129
  %idxprom147.4 = sext i32 %add146.4 to i64
  %arrayidx148.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.4
  %135 = load i32, i32* %arrayidx148.4, align 4
  %cmp149.4 = icmp eq i32 %135, 255
  br i1 %cmp149.4, label %if.then151.4, label %if.else154.4

if.else154.4:                                     ; preds = %lor.lhs.false142.4
  %arrayidx156.4 = getelementptr inbounds i8, i8* %., i64 %121
  store i8 0, i8* %arrayidx156.4, align 1
  br label %for.inc166.4

if.then151.4:                                     ; preds = %lor.lhs.false142.4, %lor.lhs.false134.4, %lor.lhs.false125.4, %lor.lhs.false117.4, %lor.lhs.false109.4, %lor.lhs.false100.4, %lor.lhs.false92.4, %if.then83.4
  %arrayidx153.4 = getelementptr inbounds i8, i8* %., i64 %121
  store i8 -1, i8* %arrayidx153.4, align 1
  br label %for.inc166.4

if.then75.4:                                      ; preds = %for.body61.4
  %arrayidx77.4 = getelementptr inbounds i8, i8* %., i64 %121
  store i8 0, i8* %arrayidx77.4, align 1
  br label %for.inc166.4

for.inc166.4:                                     ; preds = %if.then75.4, %if.then151.4, %if.else154.4, %if.else158.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %img_width
  br i1 %exitcond.4, label %for.inc169.4, label %for.body61.4, !llvm.loop !5

for.inc169.4:                                     ; preds = %for.inc166.4
  %indvars.iv.next20.4 = add nsw i64 %indvars.iv19, 5
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.5

for.body61.lr.ph.5:                               ; preds = %for.inc169.4
  %136 = trunc i64 %indvars.iv.next20.4 to i32
  %mul63.5 = shl nsw i32 %136, 7
  %cmp67.5 = icmp eq i64 %indvars.iv.next20.4, %11
  %137 = trunc i64 %indvars.iv.next20.4 to i32
  %sub84.5 = shl i32 %137, 7
  %mul94.5 = add i32 %sub84.5, -128
  %sub111.5 = add i32 %mul63.5, -1
  %add119.5 = or i32 %mul63.5, 1
  %mul136.5 = add i32 %sub84.5, 128
  %138 = sext i32 %mul63.5 to i64
  %139 = sext i32 %mul136.5 to i64
  %140 = sext i32 %mul94.5 to i64
  br label %for.body61.5

for.body61.5:                                     ; preds = %for.inc166.5, %for.body61.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body61.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc166.5 ]
  %141 = add nsw i64 %indvars.iv.5, %138
  %cmp70.5 = icmp eq i64 %indvars.iv.5, 0
  %or.cond1.5 = or i1 %cmp67.5, %cmp70.5
  %cmp73.5 = icmp eq i64 %indvars.iv.5, %10
  %or.cond2.5 = or i1 %cmp73.5, %or.cond1.5
  br i1 %or.cond2.5, label %if.then75.5, label %if.else78.5

if.else78.5:                                      ; preds = %for.body61.5
  %arrayidx80.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %141
  %142 = load i32, i32* %arrayidx80.5, align 4
  %cmp81.5 = icmp eq i32 %142, 75
  br i1 %cmp81.5, label %if.then83.5, label %if.else158.5

if.else158.5:                                     ; preds = %if.else78.5
  %conv161.5 = trunc i32 %142 to i8
  %arrayidx163.5 = getelementptr inbounds i8, i8* %., i64 %141
  store i8 %conv161.5, i8* %arrayidx163.5, align 1
  br label %for.inc166.5

if.then83.5:                                      ; preds = %if.else78.5
  %143 = trunc i64 %indvars.iv.5 to i32
  %sub86.5 = add i32 %143, %sub84.5
  %add87.5 = add i32 %sub86.5, -129
  %idxprom88.5 = sext i32 %add87.5 to i64
  %arrayidx89.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.5
  %144 = load i32, i32* %arrayidx89.5, align 4
  %cmp90.5 = icmp eq i32 %144, 255
  br i1 %cmp90.5, label %if.then151.5, label %lor.lhs.false92.5

lor.lhs.false92.5:                                ; preds = %if.then83.5
  %145 = add nsw i64 %140, %indvars.iv.5
  %arrayidx97.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %145
  %146 = load i32, i32* %arrayidx97.5, align 4
  %cmp98.5 = icmp eq i32 %146, 255
  br i1 %cmp98.5, label %if.then151.5, label %lor.lhs.false100.5

lor.lhs.false100.5:                               ; preds = %lor.lhs.false92.5
  %add104.5 = add i32 %sub86.5, -127
  %idxprom105.5 = sext i32 %add104.5 to i64
  %arrayidx106.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.5
  %147 = load i32, i32* %arrayidx106.5, align 4
  %cmp107.5 = icmp eq i32 %147, 255
  br i1 %cmp107.5, label %if.then151.5, label %lor.lhs.false109.5

lor.lhs.false109.5:                               ; preds = %lor.lhs.false100.5
  %148 = trunc i64 %indvars.iv.5 to i32
  %add112.5 = add i32 %sub111.5, %148
  %idxprom113.5 = sext i32 %add112.5 to i64
  %arrayidx114.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.5
  %149 = load i32, i32* %arrayidx114.5, align 4
  %cmp115.5 = icmp eq i32 %149, 255
  br i1 %cmp115.5, label %if.then151.5, label %lor.lhs.false117.5

lor.lhs.false117.5:                               ; preds = %lor.lhs.false109.5
  %150 = trunc i64 %indvars.iv.5 to i32
  %add120.5 = add i32 %add119.5, %150
  %idxprom121.5 = sext i32 %add120.5 to i64
  %arrayidx122.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.5
  %151 = load i32, i32* %arrayidx122.5, align 4
  %cmp123.5 = icmp eq i32 %151, 255
  br i1 %cmp123.5, label %if.then151.5, label %lor.lhs.false125.5

lor.lhs.false125.5:                               ; preds = %lor.lhs.false117.5
  %add129.5 = add i32 %sub86.5, 127
  %idxprom130.5 = sext i32 %add129.5 to i64
  %arrayidx131.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.5
  %152 = load i32, i32* %arrayidx131.5, align 4
  %cmp132.5 = icmp eq i32 %152, 255
  br i1 %cmp132.5, label %if.then151.5, label %lor.lhs.false134.5

lor.lhs.false134.5:                               ; preds = %lor.lhs.false125.5
  %153 = add nsw i64 %139, %indvars.iv.5
  %arrayidx139.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %153
  %154 = load i32, i32* %arrayidx139.5, align 4
  %cmp140.5 = icmp eq i32 %154, 255
  br i1 %cmp140.5, label %if.then151.5, label %lor.lhs.false142.5

lor.lhs.false142.5:                               ; preds = %lor.lhs.false134.5
  %add146.5 = add i32 %sub86.5, 129
  %idxprom147.5 = sext i32 %add146.5 to i64
  %arrayidx148.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.5
  %155 = load i32, i32* %arrayidx148.5, align 4
  %cmp149.5 = icmp eq i32 %155, 255
  br i1 %cmp149.5, label %if.then151.5, label %if.else154.5

if.else154.5:                                     ; preds = %lor.lhs.false142.5
  %arrayidx156.5 = getelementptr inbounds i8, i8* %., i64 %141
  store i8 0, i8* %arrayidx156.5, align 1
  br label %for.inc166.5

if.then151.5:                                     ; preds = %lor.lhs.false142.5, %lor.lhs.false134.5, %lor.lhs.false125.5, %lor.lhs.false117.5, %lor.lhs.false109.5, %lor.lhs.false100.5, %lor.lhs.false92.5, %if.then83.5
  %arrayidx153.5 = getelementptr inbounds i8, i8* %., i64 %141
  store i8 -1, i8* %arrayidx153.5, align 1
  br label %for.inc166.5

if.then75.5:                                      ; preds = %for.body61.5
  %arrayidx77.5 = getelementptr inbounds i8, i8* %., i64 %141
  store i8 0, i8* %arrayidx77.5, align 1
  br label %for.inc166.5

for.inc166.5:                                     ; preds = %if.then75.5, %if.then151.5, %if.else154.5, %if.else158.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %img_width
  br i1 %exitcond.5, label %for.inc169.5, label %for.body61.5, !llvm.loop !5

for.inc169.5:                                     ; preds = %for.inc166.5
  %indvars.iv.next20.5 = add nsw i64 %indvars.iv19, 6
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.6

for.body61.lr.ph.6:                               ; preds = %for.inc169.5
  %156 = trunc i64 %indvars.iv.next20.5 to i32
  %mul63.6 = shl nsw i32 %156, 7
  %cmp67.6 = icmp eq i64 %indvars.iv.next20.5, %11
  %157 = trunc i64 %indvars.iv.next20.5 to i32
  %sub84.6 = shl i32 %157, 7
  %mul94.6 = add i32 %sub84.6, -128
  %sub111.6 = add i32 %mul63.6, -1
  %add119.6 = or i32 %mul63.6, 1
  %mul136.6 = add i32 %sub84.6, 128
  %158 = sext i32 %mul63.6 to i64
  %159 = sext i32 %mul136.6 to i64
  %160 = sext i32 %mul94.6 to i64
  br label %for.body61.6

for.body61.6:                                     ; preds = %for.inc166.6, %for.body61.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body61.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc166.6 ]
  %161 = add nsw i64 %indvars.iv.6, %158
  %cmp70.6 = icmp eq i64 %indvars.iv.6, 0
  %or.cond1.6 = or i1 %cmp67.6, %cmp70.6
  %cmp73.6 = icmp eq i64 %indvars.iv.6, %10
  %or.cond2.6 = or i1 %cmp73.6, %or.cond1.6
  br i1 %or.cond2.6, label %if.then75.6, label %if.else78.6

if.else78.6:                                      ; preds = %for.body61.6
  %arrayidx80.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %161
  %162 = load i32, i32* %arrayidx80.6, align 4
  %cmp81.6 = icmp eq i32 %162, 75
  br i1 %cmp81.6, label %if.then83.6, label %if.else158.6

if.else158.6:                                     ; preds = %if.else78.6
  %conv161.6 = trunc i32 %162 to i8
  %arrayidx163.6 = getelementptr inbounds i8, i8* %., i64 %161
  store i8 %conv161.6, i8* %arrayidx163.6, align 1
  br label %for.inc166.6

if.then83.6:                                      ; preds = %if.else78.6
  %163 = trunc i64 %indvars.iv.6 to i32
  %sub86.6 = add i32 %163, %sub84.6
  %add87.6 = add i32 %sub86.6, -129
  %idxprom88.6 = sext i32 %add87.6 to i64
  %arrayidx89.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.6
  %164 = load i32, i32* %arrayidx89.6, align 4
  %cmp90.6 = icmp eq i32 %164, 255
  br i1 %cmp90.6, label %if.then151.6, label %lor.lhs.false92.6

lor.lhs.false92.6:                                ; preds = %if.then83.6
  %165 = add nsw i64 %160, %indvars.iv.6
  %arrayidx97.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %165
  %166 = load i32, i32* %arrayidx97.6, align 4
  %cmp98.6 = icmp eq i32 %166, 255
  br i1 %cmp98.6, label %if.then151.6, label %lor.lhs.false100.6

lor.lhs.false100.6:                               ; preds = %lor.lhs.false92.6
  %add104.6 = add i32 %sub86.6, -127
  %idxprom105.6 = sext i32 %add104.6 to i64
  %arrayidx106.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.6
  %167 = load i32, i32* %arrayidx106.6, align 4
  %cmp107.6 = icmp eq i32 %167, 255
  br i1 %cmp107.6, label %if.then151.6, label %lor.lhs.false109.6

lor.lhs.false109.6:                               ; preds = %lor.lhs.false100.6
  %168 = trunc i64 %indvars.iv.6 to i32
  %add112.6 = add i32 %sub111.6, %168
  %idxprom113.6 = sext i32 %add112.6 to i64
  %arrayidx114.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.6
  %169 = load i32, i32* %arrayidx114.6, align 4
  %cmp115.6 = icmp eq i32 %169, 255
  br i1 %cmp115.6, label %if.then151.6, label %lor.lhs.false117.6

lor.lhs.false117.6:                               ; preds = %lor.lhs.false109.6
  %170 = trunc i64 %indvars.iv.6 to i32
  %add120.6 = add i32 %add119.6, %170
  %idxprom121.6 = sext i32 %add120.6 to i64
  %arrayidx122.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.6
  %171 = load i32, i32* %arrayidx122.6, align 4
  %cmp123.6 = icmp eq i32 %171, 255
  br i1 %cmp123.6, label %if.then151.6, label %lor.lhs.false125.6

lor.lhs.false125.6:                               ; preds = %lor.lhs.false117.6
  %add129.6 = add i32 %sub86.6, 127
  %idxprom130.6 = sext i32 %add129.6 to i64
  %arrayidx131.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.6
  %172 = load i32, i32* %arrayidx131.6, align 4
  %cmp132.6 = icmp eq i32 %172, 255
  br i1 %cmp132.6, label %if.then151.6, label %lor.lhs.false134.6

lor.lhs.false134.6:                               ; preds = %lor.lhs.false125.6
  %173 = add nsw i64 %159, %indvars.iv.6
  %arrayidx139.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %173
  %174 = load i32, i32* %arrayidx139.6, align 4
  %cmp140.6 = icmp eq i32 %174, 255
  br i1 %cmp140.6, label %if.then151.6, label %lor.lhs.false142.6

lor.lhs.false142.6:                               ; preds = %lor.lhs.false134.6
  %add146.6 = add i32 %sub86.6, 129
  %idxprom147.6 = sext i32 %add146.6 to i64
  %arrayidx148.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.6
  %175 = load i32, i32* %arrayidx148.6, align 4
  %cmp149.6 = icmp eq i32 %175, 255
  br i1 %cmp149.6, label %if.then151.6, label %if.else154.6

if.else154.6:                                     ; preds = %lor.lhs.false142.6
  %arrayidx156.6 = getelementptr inbounds i8, i8* %., i64 %161
  store i8 0, i8* %arrayidx156.6, align 1
  br label %for.inc166.6

if.then151.6:                                     ; preds = %lor.lhs.false142.6, %lor.lhs.false134.6, %lor.lhs.false125.6, %lor.lhs.false117.6, %lor.lhs.false109.6, %lor.lhs.false100.6, %lor.lhs.false92.6, %if.then83.6
  %arrayidx153.6 = getelementptr inbounds i8, i8* %., i64 %161
  store i8 -1, i8* %arrayidx153.6, align 1
  br label %for.inc166.6

if.then75.6:                                      ; preds = %for.body61.6
  %arrayidx77.6 = getelementptr inbounds i8, i8* %., i64 %161
  store i8 0, i8* %arrayidx77.6, align 1
  br label %for.inc166.6

for.inc166.6:                                     ; preds = %if.then75.6, %if.then151.6, %if.else154.6, %if.else158.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %img_width
  br i1 %exitcond.6, label %for.inc169.6, label %for.body61.6, !llvm.loop !5

for.inc169.6:                                     ; preds = %for.inc166.6
  %indvars.iv.next20.6 = add nsw i64 %indvars.iv19, 7
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.7

for.body61.lr.ph.7:                               ; preds = %for.inc169.6
  %176 = trunc i64 %indvars.iv.next20.6 to i32
  %mul63.7 = shl nsw i32 %176, 7
  %cmp67.7 = icmp eq i64 %indvars.iv.next20.6, %11
  %177 = trunc i64 %indvars.iv.next20.6 to i32
  %sub84.7 = shl i32 %177, 7
  %mul94.7 = add i32 %sub84.7, -128
  %sub111.7 = add i32 %mul63.7, -1
  %add119.7 = or i32 %mul63.7, 1
  %mul136.7 = add i32 %sub84.7, 128
  %178 = sext i32 %mul63.7 to i64
  %179 = sext i32 %mul136.7 to i64
  %180 = sext i32 %mul94.7 to i64
  br label %for.body61.7

for.body61.7:                                     ; preds = %for.inc166.7, %for.body61.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body61.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc166.7 ]
  %181 = add nsw i64 %indvars.iv.7, %178
  %cmp70.7 = icmp eq i64 %indvars.iv.7, 0
  %or.cond1.7 = or i1 %cmp67.7, %cmp70.7
  %cmp73.7 = icmp eq i64 %indvars.iv.7, %10
  %or.cond2.7 = or i1 %cmp73.7, %or.cond1.7
  br i1 %or.cond2.7, label %if.then75.7, label %if.else78.7

if.else78.7:                                      ; preds = %for.body61.7
  %arrayidx80.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %181
  %182 = load i32, i32* %arrayidx80.7, align 4
  %cmp81.7 = icmp eq i32 %182, 75
  br i1 %cmp81.7, label %if.then83.7, label %if.else158.7

if.else158.7:                                     ; preds = %if.else78.7
  %conv161.7 = trunc i32 %182 to i8
  %arrayidx163.7 = getelementptr inbounds i8, i8* %., i64 %181
  store i8 %conv161.7, i8* %arrayidx163.7, align 1
  br label %for.inc166.7

if.then83.7:                                      ; preds = %if.else78.7
  %183 = trunc i64 %indvars.iv.7 to i32
  %sub86.7 = add i32 %183, %sub84.7
  %add87.7 = add i32 %sub86.7, -129
  %idxprom88.7 = sext i32 %add87.7 to i64
  %arrayidx89.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.7
  %184 = load i32, i32* %arrayidx89.7, align 4
  %cmp90.7 = icmp eq i32 %184, 255
  br i1 %cmp90.7, label %if.then151.7, label %lor.lhs.false92.7

lor.lhs.false92.7:                                ; preds = %if.then83.7
  %185 = add nsw i64 %180, %indvars.iv.7
  %arrayidx97.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %185
  %186 = load i32, i32* %arrayidx97.7, align 4
  %cmp98.7 = icmp eq i32 %186, 255
  br i1 %cmp98.7, label %if.then151.7, label %lor.lhs.false100.7

lor.lhs.false100.7:                               ; preds = %lor.lhs.false92.7
  %add104.7 = add i32 %sub86.7, -127
  %idxprom105.7 = sext i32 %add104.7 to i64
  %arrayidx106.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.7
  %187 = load i32, i32* %arrayidx106.7, align 4
  %cmp107.7 = icmp eq i32 %187, 255
  br i1 %cmp107.7, label %if.then151.7, label %lor.lhs.false109.7

lor.lhs.false109.7:                               ; preds = %lor.lhs.false100.7
  %188 = trunc i64 %indvars.iv.7 to i32
  %add112.7 = add i32 %sub111.7, %188
  %idxprom113.7 = sext i32 %add112.7 to i64
  %arrayidx114.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.7
  %189 = load i32, i32* %arrayidx114.7, align 4
  %cmp115.7 = icmp eq i32 %189, 255
  br i1 %cmp115.7, label %if.then151.7, label %lor.lhs.false117.7

lor.lhs.false117.7:                               ; preds = %lor.lhs.false109.7
  %190 = trunc i64 %indvars.iv.7 to i32
  %add120.7 = add i32 %add119.7, %190
  %idxprom121.7 = sext i32 %add120.7 to i64
  %arrayidx122.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.7
  %191 = load i32, i32* %arrayidx122.7, align 4
  %cmp123.7 = icmp eq i32 %191, 255
  br i1 %cmp123.7, label %if.then151.7, label %lor.lhs.false125.7

lor.lhs.false125.7:                               ; preds = %lor.lhs.false117.7
  %add129.7 = add i32 %sub86.7, 127
  %idxprom130.7 = sext i32 %add129.7 to i64
  %arrayidx131.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.7
  %192 = load i32, i32* %arrayidx131.7, align 4
  %cmp132.7 = icmp eq i32 %192, 255
  br i1 %cmp132.7, label %if.then151.7, label %lor.lhs.false134.7

lor.lhs.false134.7:                               ; preds = %lor.lhs.false125.7
  %193 = add nsw i64 %179, %indvars.iv.7
  %arrayidx139.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %193
  %194 = load i32, i32* %arrayidx139.7, align 4
  %cmp140.7 = icmp eq i32 %194, 255
  br i1 %cmp140.7, label %if.then151.7, label %lor.lhs.false142.7

lor.lhs.false142.7:                               ; preds = %lor.lhs.false134.7
  %add146.7 = add i32 %sub86.7, 129
  %idxprom147.7 = sext i32 %add146.7 to i64
  %arrayidx148.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.7
  %195 = load i32, i32* %arrayidx148.7, align 4
  %cmp149.7 = icmp eq i32 %195, 255
  br i1 %cmp149.7, label %if.then151.7, label %if.else154.7

if.else154.7:                                     ; preds = %lor.lhs.false142.7
  %arrayidx156.7 = getelementptr inbounds i8, i8* %., i64 %181
  store i8 0, i8* %arrayidx156.7, align 1
  br label %for.inc166.7

if.then151.7:                                     ; preds = %lor.lhs.false142.7, %lor.lhs.false134.7, %lor.lhs.false125.7, %lor.lhs.false117.7, %lor.lhs.false109.7, %lor.lhs.false100.7, %lor.lhs.false92.7, %if.then83.7
  %arrayidx153.7 = getelementptr inbounds i8, i8* %., i64 %181
  store i8 -1, i8* %arrayidx153.7, align 1
  br label %for.inc166.7

if.then75.7:                                      ; preds = %for.body61.7
  %arrayidx77.7 = getelementptr inbounds i8, i8* %., i64 %181
  store i8 0, i8* %arrayidx77.7, align 1
  br label %for.inc166.7

for.inc166.7:                                     ; preds = %if.then75.7, %if.then151.7, %if.else154.7, %if.else158.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %img_width
  br i1 %exitcond.7, label %for.inc169.7, label %for.body61.7, !llvm.loop !5

for.inc169.7:                                     ; preds = %for.inc166.7
  %indvars.iv.next20.7 = add nsw i64 %indvars.iv19, 8
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.8

for.body61.lr.ph.8:                               ; preds = %for.inc169.7
  %196 = trunc i64 %indvars.iv.next20.7 to i32
  %mul63.8 = shl nsw i32 %196, 7
  %cmp67.8 = icmp eq i64 %indvars.iv.next20.7, %11
  %197 = trunc i64 %indvars.iv.next20.7 to i32
  %sub84.8 = shl i32 %197, 7
  %mul94.8 = add i32 %sub84.8, -128
  %sub111.8 = add i32 %mul63.8, -1
  %add119.8 = or i32 %mul63.8, 1
  %mul136.8 = add i32 %sub84.8, 128
  %198 = sext i32 %mul63.8 to i64
  %199 = sext i32 %mul136.8 to i64
  %200 = sext i32 %mul94.8 to i64
  br label %for.body61.8

for.body61.8:                                     ; preds = %for.inc166.8, %for.body61.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body61.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc166.8 ]
  %201 = add nsw i64 %indvars.iv.8, %198
  %cmp70.8 = icmp eq i64 %indvars.iv.8, 0
  %or.cond1.8 = or i1 %cmp67.8, %cmp70.8
  %cmp73.8 = icmp eq i64 %indvars.iv.8, %10
  %or.cond2.8 = or i1 %cmp73.8, %or.cond1.8
  br i1 %or.cond2.8, label %if.then75.8, label %if.else78.8

if.else78.8:                                      ; preds = %for.body61.8
  %arrayidx80.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %201
  %202 = load i32, i32* %arrayidx80.8, align 4
  %cmp81.8 = icmp eq i32 %202, 75
  br i1 %cmp81.8, label %if.then83.8, label %if.else158.8

if.else158.8:                                     ; preds = %if.else78.8
  %conv161.8 = trunc i32 %202 to i8
  %arrayidx163.8 = getelementptr inbounds i8, i8* %., i64 %201
  store i8 %conv161.8, i8* %arrayidx163.8, align 1
  br label %for.inc166.8

if.then83.8:                                      ; preds = %if.else78.8
  %203 = trunc i64 %indvars.iv.8 to i32
  %sub86.8 = add i32 %203, %sub84.8
  %add87.8 = add i32 %sub86.8, -129
  %idxprom88.8 = sext i32 %add87.8 to i64
  %arrayidx89.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.8
  %204 = load i32, i32* %arrayidx89.8, align 4
  %cmp90.8 = icmp eq i32 %204, 255
  br i1 %cmp90.8, label %if.then151.8, label %lor.lhs.false92.8

lor.lhs.false92.8:                                ; preds = %if.then83.8
  %205 = add nsw i64 %200, %indvars.iv.8
  %arrayidx97.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %205
  %206 = load i32, i32* %arrayidx97.8, align 4
  %cmp98.8 = icmp eq i32 %206, 255
  br i1 %cmp98.8, label %if.then151.8, label %lor.lhs.false100.8

lor.lhs.false100.8:                               ; preds = %lor.lhs.false92.8
  %add104.8 = add i32 %sub86.8, -127
  %idxprom105.8 = sext i32 %add104.8 to i64
  %arrayidx106.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.8
  %207 = load i32, i32* %arrayidx106.8, align 4
  %cmp107.8 = icmp eq i32 %207, 255
  br i1 %cmp107.8, label %if.then151.8, label %lor.lhs.false109.8

lor.lhs.false109.8:                               ; preds = %lor.lhs.false100.8
  %208 = trunc i64 %indvars.iv.8 to i32
  %add112.8 = add i32 %sub111.8, %208
  %idxprom113.8 = sext i32 %add112.8 to i64
  %arrayidx114.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.8
  %209 = load i32, i32* %arrayidx114.8, align 4
  %cmp115.8 = icmp eq i32 %209, 255
  br i1 %cmp115.8, label %if.then151.8, label %lor.lhs.false117.8

lor.lhs.false117.8:                               ; preds = %lor.lhs.false109.8
  %210 = trunc i64 %indvars.iv.8 to i32
  %add120.8 = add i32 %add119.8, %210
  %idxprom121.8 = sext i32 %add120.8 to i64
  %arrayidx122.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.8
  %211 = load i32, i32* %arrayidx122.8, align 4
  %cmp123.8 = icmp eq i32 %211, 255
  br i1 %cmp123.8, label %if.then151.8, label %lor.lhs.false125.8

lor.lhs.false125.8:                               ; preds = %lor.lhs.false117.8
  %add129.8 = add i32 %sub86.8, 127
  %idxprom130.8 = sext i32 %add129.8 to i64
  %arrayidx131.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.8
  %212 = load i32, i32* %arrayidx131.8, align 4
  %cmp132.8 = icmp eq i32 %212, 255
  br i1 %cmp132.8, label %if.then151.8, label %lor.lhs.false134.8

lor.lhs.false134.8:                               ; preds = %lor.lhs.false125.8
  %213 = add nsw i64 %199, %indvars.iv.8
  %arrayidx139.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %213
  %214 = load i32, i32* %arrayidx139.8, align 4
  %cmp140.8 = icmp eq i32 %214, 255
  br i1 %cmp140.8, label %if.then151.8, label %lor.lhs.false142.8

lor.lhs.false142.8:                               ; preds = %lor.lhs.false134.8
  %add146.8 = add i32 %sub86.8, 129
  %idxprom147.8 = sext i32 %add146.8 to i64
  %arrayidx148.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.8
  %215 = load i32, i32* %arrayidx148.8, align 4
  %cmp149.8 = icmp eq i32 %215, 255
  br i1 %cmp149.8, label %if.then151.8, label %if.else154.8

if.else154.8:                                     ; preds = %lor.lhs.false142.8
  %arrayidx156.8 = getelementptr inbounds i8, i8* %., i64 %201
  store i8 0, i8* %arrayidx156.8, align 1
  br label %for.inc166.8

if.then151.8:                                     ; preds = %lor.lhs.false142.8, %lor.lhs.false134.8, %lor.lhs.false125.8, %lor.lhs.false117.8, %lor.lhs.false109.8, %lor.lhs.false100.8, %lor.lhs.false92.8, %if.then83.8
  %arrayidx153.8 = getelementptr inbounds i8, i8* %., i64 %201
  store i8 -1, i8* %arrayidx153.8, align 1
  br label %for.inc166.8

if.then75.8:                                      ; preds = %for.body61.8
  %arrayidx77.8 = getelementptr inbounds i8, i8* %., i64 %201
  store i8 0, i8* %arrayidx77.8, align 1
  br label %for.inc166.8

for.inc166.8:                                     ; preds = %if.then75.8, %if.then151.8, %if.else154.8, %if.else158.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %img_width
  br i1 %exitcond.8, label %for.inc169.8, label %for.body61.8, !llvm.loop !5

for.inc169.8:                                     ; preds = %for.inc166.8
  %indvars.iv.next20.8 = add nsw i64 %indvars.iv19, 9
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.9

for.body61.lr.ph.9:                               ; preds = %for.inc169.8
  %216 = trunc i64 %indvars.iv.next20.8 to i32
  %mul63.9 = shl nsw i32 %216, 7
  %cmp67.9 = icmp eq i64 %indvars.iv.next20.8, %11
  %217 = trunc i64 %indvars.iv.next20.8 to i32
  %sub84.9 = shl i32 %217, 7
  %mul94.9 = add i32 %sub84.9, -128
  %sub111.9 = add i32 %mul63.9, -1
  %add119.9 = or i32 %mul63.9, 1
  %mul136.9 = add i32 %sub84.9, 128
  %218 = sext i32 %mul63.9 to i64
  %219 = sext i32 %mul136.9 to i64
  %220 = sext i32 %mul94.9 to i64
  br label %for.body61.9

for.body61.9:                                     ; preds = %for.inc166.9, %for.body61.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body61.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc166.9 ]
  %221 = add nsw i64 %indvars.iv.9, %218
  %cmp70.9 = icmp eq i64 %indvars.iv.9, 0
  %or.cond1.9 = or i1 %cmp67.9, %cmp70.9
  %cmp73.9 = icmp eq i64 %indvars.iv.9, %10
  %or.cond2.9 = or i1 %cmp73.9, %or.cond1.9
  br i1 %or.cond2.9, label %if.then75.9, label %if.else78.9

if.else78.9:                                      ; preds = %for.body61.9
  %arrayidx80.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %221
  %222 = load i32, i32* %arrayidx80.9, align 4
  %cmp81.9 = icmp eq i32 %222, 75
  br i1 %cmp81.9, label %if.then83.9, label %if.else158.9

if.else158.9:                                     ; preds = %if.else78.9
  %conv161.9 = trunc i32 %222 to i8
  %arrayidx163.9 = getelementptr inbounds i8, i8* %., i64 %221
  store i8 %conv161.9, i8* %arrayidx163.9, align 1
  br label %for.inc166.9

if.then83.9:                                      ; preds = %if.else78.9
  %223 = trunc i64 %indvars.iv.9 to i32
  %sub86.9 = add i32 %223, %sub84.9
  %add87.9 = add i32 %sub86.9, -129
  %idxprom88.9 = sext i32 %add87.9 to i64
  %arrayidx89.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.9
  %224 = load i32, i32* %arrayidx89.9, align 4
  %cmp90.9 = icmp eq i32 %224, 255
  br i1 %cmp90.9, label %if.then151.9, label %lor.lhs.false92.9

lor.lhs.false92.9:                                ; preds = %if.then83.9
  %225 = add nsw i64 %220, %indvars.iv.9
  %arrayidx97.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %225
  %226 = load i32, i32* %arrayidx97.9, align 4
  %cmp98.9 = icmp eq i32 %226, 255
  br i1 %cmp98.9, label %if.then151.9, label %lor.lhs.false100.9

lor.lhs.false100.9:                               ; preds = %lor.lhs.false92.9
  %add104.9 = add i32 %sub86.9, -127
  %idxprom105.9 = sext i32 %add104.9 to i64
  %arrayidx106.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.9
  %227 = load i32, i32* %arrayidx106.9, align 4
  %cmp107.9 = icmp eq i32 %227, 255
  br i1 %cmp107.9, label %if.then151.9, label %lor.lhs.false109.9

lor.lhs.false109.9:                               ; preds = %lor.lhs.false100.9
  %228 = trunc i64 %indvars.iv.9 to i32
  %add112.9 = add i32 %sub111.9, %228
  %idxprom113.9 = sext i32 %add112.9 to i64
  %arrayidx114.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.9
  %229 = load i32, i32* %arrayidx114.9, align 4
  %cmp115.9 = icmp eq i32 %229, 255
  br i1 %cmp115.9, label %if.then151.9, label %lor.lhs.false117.9

lor.lhs.false117.9:                               ; preds = %lor.lhs.false109.9
  %230 = trunc i64 %indvars.iv.9 to i32
  %add120.9 = add i32 %add119.9, %230
  %idxprom121.9 = sext i32 %add120.9 to i64
  %arrayidx122.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.9
  %231 = load i32, i32* %arrayidx122.9, align 4
  %cmp123.9 = icmp eq i32 %231, 255
  br i1 %cmp123.9, label %if.then151.9, label %lor.lhs.false125.9

lor.lhs.false125.9:                               ; preds = %lor.lhs.false117.9
  %add129.9 = add i32 %sub86.9, 127
  %idxprom130.9 = sext i32 %add129.9 to i64
  %arrayidx131.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.9
  %232 = load i32, i32* %arrayidx131.9, align 4
  %cmp132.9 = icmp eq i32 %232, 255
  br i1 %cmp132.9, label %if.then151.9, label %lor.lhs.false134.9

lor.lhs.false134.9:                               ; preds = %lor.lhs.false125.9
  %233 = add nsw i64 %219, %indvars.iv.9
  %arrayidx139.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %233
  %234 = load i32, i32* %arrayidx139.9, align 4
  %cmp140.9 = icmp eq i32 %234, 255
  br i1 %cmp140.9, label %if.then151.9, label %lor.lhs.false142.9

lor.lhs.false142.9:                               ; preds = %lor.lhs.false134.9
  %add146.9 = add i32 %sub86.9, 129
  %idxprom147.9 = sext i32 %add146.9 to i64
  %arrayidx148.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.9
  %235 = load i32, i32* %arrayidx148.9, align 4
  %cmp149.9 = icmp eq i32 %235, 255
  br i1 %cmp149.9, label %if.then151.9, label %if.else154.9

if.else154.9:                                     ; preds = %lor.lhs.false142.9
  %arrayidx156.9 = getelementptr inbounds i8, i8* %., i64 %221
  store i8 0, i8* %arrayidx156.9, align 1
  br label %for.inc166.9

if.then151.9:                                     ; preds = %lor.lhs.false142.9, %lor.lhs.false134.9, %lor.lhs.false125.9, %lor.lhs.false117.9, %lor.lhs.false109.9, %lor.lhs.false100.9, %lor.lhs.false92.9, %if.then83.9
  %arrayidx153.9 = getelementptr inbounds i8, i8* %., i64 %221
  store i8 -1, i8* %arrayidx153.9, align 1
  br label %for.inc166.9

if.then75.9:                                      ; preds = %for.body61.9
  %arrayidx77.9 = getelementptr inbounds i8, i8* %., i64 %221
  store i8 0, i8* %arrayidx77.9, align 1
  br label %for.inc166.9

for.inc166.9:                                     ; preds = %if.then75.9, %if.then151.9, %if.else154.9, %if.else158.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %img_width
  br i1 %exitcond.9, label %for.inc169.9, label %for.body61.9, !llvm.loop !5

for.inc169.9:                                     ; preds = %for.inc166.9
  %indvars.iv.next20.9 = add nsw i64 %indvars.iv19, 10
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.10

for.body61.lr.ph.10:                              ; preds = %for.inc169.9
  %236 = trunc i64 %indvars.iv.next20.9 to i32
  %mul63.10 = shl nsw i32 %236, 7
  %cmp67.10 = icmp eq i64 %indvars.iv.next20.9, %11
  %237 = trunc i64 %indvars.iv.next20.9 to i32
  %sub84.10 = shl i32 %237, 7
  %mul94.10 = add i32 %sub84.10, -128
  %sub111.10 = add i32 %mul63.10, -1
  %add119.10 = or i32 %mul63.10, 1
  %mul136.10 = add i32 %sub84.10, 128
  %238 = sext i32 %mul63.10 to i64
  %239 = sext i32 %mul136.10 to i64
  %240 = sext i32 %mul94.10 to i64
  br label %for.body61.10

for.body61.10:                                    ; preds = %for.inc166.10, %for.body61.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body61.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc166.10 ]
  %241 = add nsw i64 %indvars.iv.10, %238
  %cmp70.10 = icmp eq i64 %indvars.iv.10, 0
  %or.cond1.10 = or i1 %cmp67.10, %cmp70.10
  %cmp73.10 = icmp eq i64 %indvars.iv.10, %10
  %or.cond2.10 = or i1 %cmp73.10, %or.cond1.10
  br i1 %or.cond2.10, label %if.then75.10, label %if.else78.10

if.else78.10:                                     ; preds = %for.body61.10
  %arrayidx80.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %241
  %242 = load i32, i32* %arrayidx80.10, align 4
  %cmp81.10 = icmp eq i32 %242, 75
  br i1 %cmp81.10, label %if.then83.10, label %if.else158.10

if.else158.10:                                    ; preds = %if.else78.10
  %conv161.10 = trunc i32 %242 to i8
  %arrayidx163.10 = getelementptr inbounds i8, i8* %., i64 %241
  store i8 %conv161.10, i8* %arrayidx163.10, align 1
  br label %for.inc166.10

if.then83.10:                                     ; preds = %if.else78.10
  %243 = trunc i64 %indvars.iv.10 to i32
  %sub86.10 = add i32 %243, %sub84.10
  %add87.10 = add i32 %sub86.10, -129
  %idxprom88.10 = sext i32 %add87.10 to i64
  %arrayidx89.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.10
  %244 = load i32, i32* %arrayidx89.10, align 4
  %cmp90.10 = icmp eq i32 %244, 255
  br i1 %cmp90.10, label %if.then151.10, label %lor.lhs.false92.10

lor.lhs.false92.10:                               ; preds = %if.then83.10
  %245 = add nsw i64 %240, %indvars.iv.10
  %arrayidx97.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %245
  %246 = load i32, i32* %arrayidx97.10, align 4
  %cmp98.10 = icmp eq i32 %246, 255
  br i1 %cmp98.10, label %if.then151.10, label %lor.lhs.false100.10

lor.lhs.false100.10:                              ; preds = %lor.lhs.false92.10
  %add104.10 = add i32 %sub86.10, -127
  %idxprom105.10 = sext i32 %add104.10 to i64
  %arrayidx106.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.10
  %247 = load i32, i32* %arrayidx106.10, align 4
  %cmp107.10 = icmp eq i32 %247, 255
  br i1 %cmp107.10, label %if.then151.10, label %lor.lhs.false109.10

lor.lhs.false109.10:                              ; preds = %lor.lhs.false100.10
  %248 = trunc i64 %indvars.iv.10 to i32
  %add112.10 = add i32 %sub111.10, %248
  %idxprom113.10 = sext i32 %add112.10 to i64
  %arrayidx114.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.10
  %249 = load i32, i32* %arrayidx114.10, align 4
  %cmp115.10 = icmp eq i32 %249, 255
  br i1 %cmp115.10, label %if.then151.10, label %lor.lhs.false117.10

lor.lhs.false117.10:                              ; preds = %lor.lhs.false109.10
  %250 = trunc i64 %indvars.iv.10 to i32
  %add120.10 = add i32 %add119.10, %250
  %idxprom121.10 = sext i32 %add120.10 to i64
  %arrayidx122.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.10
  %251 = load i32, i32* %arrayidx122.10, align 4
  %cmp123.10 = icmp eq i32 %251, 255
  br i1 %cmp123.10, label %if.then151.10, label %lor.lhs.false125.10

lor.lhs.false125.10:                              ; preds = %lor.lhs.false117.10
  %add129.10 = add i32 %sub86.10, 127
  %idxprom130.10 = sext i32 %add129.10 to i64
  %arrayidx131.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.10
  %252 = load i32, i32* %arrayidx131.10, align 4
  %cmp132.10 = icmp eq i32 %252, 255
  br i1 %cmp132.10, label %if.then151.10, label %lor.lhs.false134.10

lor.lhs.false134.10:                              ; preds = %lor.lhs.false125.10
  %253 = add nsw i64 %239, %indvars.iv.10
  %arrayidx139.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %253
  %254 = load i32, i32* %arrayidx139.10, align 4
  %cmp140.10 = icmp eq i32 %254, 255
  br i1 %cmp140.10, label %if.then151.10, label %lor.lhs.false142.10

lor.lhs.false142.10:                              ; preds = %lor.lhs.false134.10
  %add146.10 = add i32 %sub86.10, 129
  %idxprom147.10 = sext i32 %add146.10 to i64
  %arrayidx148.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.10
  %255 = load i32, i32* %arrayidx148.10, align 4
  %cmp149.10 = icmp eq i32 %255, 255
  br i1 %cmp149.10, label %if.then151.10, label %if.else154.10

if.else154.10:                                    ; preds = %lor.lhs.false142.10
  %arrayidx156.10 = getelementptr inbounds i8, i8* %., i64 %241
  store i8 0, i8* %arrayidx156.10, align 1
  br label %for.inc166.10

if.then151.10:                                    ; preds = %lor.lhs.false142.10, %lor.lhs.false134.10, %lor.lhs.false125.10, %lor.lhs.false117.10, %lor.lhs.false109.10, %lor.lhs.false100.10, %lor.lhs.false92.10, %if.then83.10
  %arrayidx153.10 = getelementptr inbounds i8, i8* %., i64 %241
  store i8 -1, i8* %arrayidx153.10, align 1
  br label %for.inc166.10

if.then75.10:                                     ; preds = %for.body61.10
  %arrayidx77.10 = getelementptr inbounds i8, i8* %., i64 %241
  store i8 0, i8* %arrayidx77.10, align 1
  br label %for.inc166.10

for.inc166.10:                                    ; preds = %if.then75.10, %if.then151.10, %if.else154.10, %if.else158.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %img_width
  br i1 %exitcond.10, label %for.inc169.10, label %for.body61.10, !llvm.loop !5

for.inc169.10:                                    ; preds = %for.inc166.10
  %indvars.iv.next20.10 = add nsw i64 %indvars.iv19, 11
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.11

for.body61.lr.ph.11:                              ; preds = %for.inc169.10
  %256 = trunc i64 %indvars.iv.next20.10 to i32
  %mul63.11 = shl nsw i32 %256, 7
  %cmp67.11 = icmp eq i64 %indvars.iv.next20.10, %11
  %257 = trunc i64 %indvars.iv.next20.10 to i32
  %sub84.11 = shl i32 %257, 7
  %mul94.11 = add i32 %sub84.11, -128
  %sub111.11 = add i32 %mul63.11, -1
  %add119.11 = or i32 %mul63.11, 1
  %mul136.11 = add i32 %sub84.11, 128
  %258 = sext i32 %mul63.11 to i64
  %259 = sext i32 %mul136.11 to i64
  %260 = sext i32 %mul94.11 to i64
  br label %for.body61.11

for.body61.11:                                    ; preds = %for.inc166.11, %for.body61.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body61.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc166.11 ]
  %261 = add nsw i64 %indvars.iv.11, %258
  %cmp70.11 = icmp eq i64 %indvars.iv.11, 0
  %or.cond1.11 = or i1 %cmp67.11, %cmp70.11
  %cmp73.11 = icmp eq i64 %indvars.iv.11, %10
  %or.cond2.11 = or i1 %cmp73.11, %or.cond1.11
  br i1 %or.cond2.11, label %if.then75.11, label %if.else78.11

if.else78.11:                                     ; preds = %for.body61.11
  %arrayidx80.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %261
  %262 = load i32, i32* %arrayidx80.11, align 4
  %cmp81.11 = icmp eq i32 %262, 75
  br i1 %cmp81.11, label %if.then83.11, label %if.else158.11

if.else158.11:                                    ; preds = %if.else78.11
  %conv161.11 = trunc i32 %262 to i8
  %arrayidx163.11 = getelementptr inbounds i8, i8* %., i64 %261
  store i8 %conv161.11, i8* %arrayidx163.11, align 1
  br label %for.inc166.11

if.then83.11:                                     ; preds = %if.else78.11
  %263 = trunc i64 %indvars.iv.11 to i32
  %sub86.11 = add i32 %263, %sub84.11
  %add87.11 = add i32 %sub86.11, -129
  %idxprom88.11 = sext i32 %add87.11 to i64
  %arrayidx89.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.11
  %264 = load i32, i32* %arrayidx89.11, align 4
  %cmp90.11 = icmp eq i32 %264, 255
  br i1 %cmp90.11, label %if.then151.11, label %lor.lhs.false92.11

lor.lhs.false92.11:                               ; preds = %if.then83.11
  %265 = add nsw i64 %260, %indvars.iv.11
  %arrayidx97.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %265
  %266 = load i32, i32* %arrayidx97.11, align 4
  %cmp98.11 = icmp eq i32 %266, 255
  br i1 %cmp98.11, label %if.then151.11, label %lor.lhs.false100.11

lor.lhs.false100.11:                              ; preds = %lor.lhs.false92.11
  %add104.11 = add i32 %sub86.11, -127
  %idxprom105.11 = sext i32 %add104.11 to i64
  %arrayidx106.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.11
  %267 = load i32, i32* %arrayidx106.11, align 4
  %cmp107.11 = icmp eq i32 %267, 255
  br i1 %cmp107.11, label %if.then151.11, label %lor.lhs.false109.11

lor.lhs.false109.11:                              ; preds = %lor.lhs.false100.11
  %268 = trunc i64 %indvars.iv.11 to i32
  %add112.11 = add i32 %sub111.11, %268
  %idxprom113.11 = sext i32 %add112.11 to i64
  %arrayidx114.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.11
  %269 = load i32, i32* %arrayidx114.11, align 4
  %cmp115.11 = icmp eq i32 %269, 255
  br i1 %cmp115.11, label %if.then151.11, label %lor.lhs.false117.11

lor.lhs.false117.11:                              ; preds = %lor.lhs.false109.11
  %270 = trunc i64 %indvars.iv.11 to i32
  %add120.11 = add i32 %add119.11, %270
  %idxprom121.11 = sext i32 %add120.11 to i64
  %arrayidx122.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.11
  %271 = load i32, i32* %arrayidx122.11, align 4
  %cmp123.11 = icmp eq i32 %271, 255
  br i1 %cmp123.11, label %if.then151.11, label %lor.lhs.false125.11

lor.lhs.false125.11:                              ; preds = %lor.lhs.false117.11
  %add129.11 = add i32 %sub86.11, 127
  %idxprom130.11 = sext i32 %add129.11 to i64
  %arrayidx131.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.11
  %272 = load i32, i32* %arrayidx131.11, align 4
  %cmp132.11 = icmp eq i32 %272, 255
  br i1 %cmp132.11, label %if.then151.11, label %lor.lhs.false134.11

lor.lhs.false134.11:                              ; preds = %lor.lhs.false125.11
  %273 = add nsw i64 %259, %indvars.iv.11
  %arrayidx139.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %273
  %274 = load i32, i32* %arrayidx139.11, align 4
  %cmp140.11 = icmp eq i32 %274, 255
  br i1 %cmp140.11, label %if.then151.11, label %lor.lhs.false142.11

lor.lhs.false142.11:                              ; preds = %lor.lhs.false134.11
  %add146.11 = add i32 %sub86.11, 129
  %idxprom147.11 = sext i32 %add146.11 to i64
  %arrayidx148.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.11
  %275 = load i32, i32* %arrayidx148.11, align 4
  %cmp149.11 = icmp eq i32 %275, 255
  br i1 %cmp149.11, label %if.then151.11, label %if.else154.11

if.else154.11:                                    ; preds = %lor.lhs.false142.11
  %arrayidx156.11 = getelementptr inbounds i8, i8* %., i64 %261
  store i8 0, i8* %arrayidx156.11, align 1
  br label %for.inc166.11

if.then151.11:                                    ; preds = %lor.lhs.false142.11, %lor.lhs.false134.11, %lor.lhs.false125.11, %lor.lhs.false117.11, %lor.lhs.false109.11, %lor.lhs.false100.11, %lor.lhs.false92.11, %if.then83.11
  %arrayidx153.11 = getelementptr inbounds i8, i8* %., i64 %261
  store i8 -1, i8* %arrayidx153.11, align 1
  br label %for.inc166.11

if.then75.11:                                     ; preds = %for.body61.11
  %arrayidx77.11 = getelementptr inbounds i8, i8* %., i64 %261
  store i8 0, i8* %arrayidx77.11, align 1
  br label %for.inc166.11

for.inc166.11:                                    ; preds = %if.then75.11, %if.then151.11, %if.else154.11, %if.else158.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %img_width
  br i1 %exitcond.11, label %for.inc169.11, label %for.body61.11, !llvm.loop !5

for.inc169.11:                                    ; preds = %for.inc166.11
  %indvars.iv.next20.11 = add nsw i64 %indvars.iv19, 12
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.12

for.body61.lr.ph.12:                              ; preds = %for.inc169.11
  %276 = trunc i64 %indvars.iv.next20.11 to i32
  %mul63.12 = shl nsw i32 %276, 7
  %cmp67.12 = icmp eq i64 %indvars.iv.next20.11, %11
  %277 = trunc i64 %indvars.iv.next20.11 to i32
  %sub84.12 = shl i32 %277, 7
  %mul94.12 = add i32 %sub84.12, -128
  %sub111.12 = add i32 %mul63.12, -1
  %add119.12 = or i32 %mul63.12, 1
  %mul136.12 = add i32 %sub84.12, 128
  %278 = sext i32 %mul63.12 to i64
  %279 = sext i32 %mul136.12 to i64
  %280 = sext i32 %mul94.12 to i64
  br label %for.body61.12

for.body61.12:                                    ; preds = %for.inc166.12, %for.body61.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body61.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc166.12 ]
  %281 = add nsw i64 %indvars.iv.12, %278
  %cmp70.12 = icmp eq i64 %indvars.iv.12, 0
  %or.cond1.12 = or i1 %cmp67.12, %cmp70.12
  %cmp73.12 = icmp eq i64 %indvars.iv.12, %10
  %or.cond2.12 = or i1 %cmp73.12, %or.cond1.12
  br i1 %or.cond2.12, label %if.then75.12, label %if.else78.12

if.else78.12:                                     ; preds = %for.body61.12
  %arrayidx80.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %281
  %282 = load i32, i32* %arrayidx80.12, align 4
  %cmp81.12 = icmp eq i32 %282, 75
  br i1 %cmp81.12, label %if.then83.12, label %if.else158.12

if.else158.12:                                    ; preds = %if.else78.12
  %conv161.12 = trunc i32 %282 to i8
  %arrayidx163.12 = getelementptr inbounds i8, i8* %., i64 %281
  store i8 %conv161.12, i8* %arrayidx163.12, align 1
  br label %for.inc166.12

if.then83.12:                                     ; preds = %if.else78.12
  %283 = trunc i64 %indvars.iv.12 to i32
  %sub86.12 = add i32 %283, %sub84.12
  %add87.12 = add i32 %sub86.12, -129
  %idxprom88.12 = sext i32 %add87.12 to i64
  %arrayidx89.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.12
  %284 = load i32, i32* %arrayidx89.12, align 4
  %cmp90.12 = icmp eq i32 %284, 255
  br i1 %cmp90.12, label %if.then151.12, label %lor.lhs.false92.12

lor.lhs.false92.12:                               ; preds = %if.then83.12
  %285 = add nsw i64 %280, %indvars.iv.12
  %arrayidx97.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %285
  %286 = load i32, i32* %arrayidx97.12, align 4
  %cmp98.12 = icmp eq i32 %286, 255
  br i1 %cmp98.12, label %if.then151.12, label %lor.lhs.false100.12

lor.lhs.false100.12:                              ; preds = %lor.lhs.false92.12
  %add104.12 = add i32 %sub86.12, -127
  %idxprom105.12 = sext i32 %add104.12 to i64
  %arrayidx106.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.12
  %287 = load i32, i32* %arrayidx106.12, align 4
  %cmp107.12 = icmp eq i32 %287, 255
  br i1 %cmp107.12, label %if.then151.12, label %lor.lhs.false109.12

lor.lhs.false109.12:                              ; preds = %lor.lhs.false100.12
  %288 = trunc i64 %indvars.iv.12 to i32
  %add112.12 = add i32 %sub111.12, %288
  %idxprom113.12 = sext i32 %add112.12 to i64
  %arrayidx114.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.12
  %289 = load i32, i32* %arrayidx114.12, align 4
  %cmp115.12 = icmp eq i32 %289, 255
  br i1 %cmp115.12, label %if.then151.12, label %lor.lhs.false117.12

lor.lhs.false117.12:                              ; preds = %lor.lhs.false109.12
  %290 = trunc i64 %indvars.iv.12 to i32
  %add120.12 = add i32 %add119.12, %290
  %idxprom121.12 = sext i32 %add120.12 to i64
  %arrayidx122.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.12
  %291 = load i32, i32* %arrayidx122.12, align 4
  %cmp123.12 = icmp eq i32 %291, 255
  br i1 %cmp123.12, label %if.then151.12, label %lor.lhs.false125.12

lor.lhs.false125.12:                              ; preds = %lor.lhs.false117.12
  %add129.12 = add i32 %sub86.12, 127
  %idxprom130.12 = sext i32 %add129.12 to i64
  %arrayidx131.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.12
  %292 = load i32, i32* %arrayidx131.12, align 4
  %cmp132.12 = icmp eq i32 %292, 255
  br i1 %cmp132.12, label %if.then151.12, label %lor.lhs.false134.12

lor.lhs.false134.12:                              ; preds = %lor.lhs.false125.12
  %293 = add nsw i64 %279, %indvars.iv.12
  %arrayidx139.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %293
  %294 = load i32, i32* %arrayidx139.12, align 4
  %cmp140.12 = icmp eq i32 %294, 255
  br i1 %cmp140.12, label %if.then151.12, label %lor.lhs.false142.12

lor.lhs.false142.12:                              ; preds = %lor.lhs.false134.12
  %add146.12 = add i32 %sub86.12, 129
  %idxprom147.12 = sext i32 %add146.12 to i64
  %arrayidx148.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.12
  %295 = load i32, i32* %arrayidx148.12, align 4
  %cmp149.12 = icmp eq i32 %295, 255
  br i1 %cmp149.12, label %if.then151.12, label %if.else154.12

if.else154.12:                                    ; preds = %lor.lhs.false142.12
  %arrayidx156.12 = getelementptr inbounds i8, i8* %., i64 %281
  store i8 0, i8* %arrayidx156.12, align 1
  br label %for.inc166.12

if.then151.12:                                    ; preds = %lor.lhs.false142.12, %lor.lhs.false134.12, %lor.lhs.false125.12, %lor.lhs.false117.12, %lor.lhs.false109.12, %lor.lhs.false100.12, %lor.lhs.false92.12, %if.then83.12
  %arrayidx153.12 = getelementptr inbounds i8, i8* %., i64 %281
  store i8 -1, i8* %arrayidx153.12, align 1
  br label %for.inc166.12

if.then75.12:                                     ; preds = %for.body61.12
  %arrayidx77.12 = getelementptr inbounds i8, i8* %., i64 %281
  store i8 0, i8* %arrayidx77.12, align 1
  br label %for.inc166.12

for.inc166.12:                                    ; preds = %if.then75.12, %if.then151.12, %if.else154.12, %if.else158.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %img_width
  br i1 %exitcond.12, label %for.inc169.12, label %for.body61.12, !llvm.loop !5

for.inc169.12:                                    ; preds = %for.inc166.12
  %indvars.iv.next20.12 = add nsw i64 %indvars.iv19, 13
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.13

for.body61.lr.ph.13:                              ; preds = %for.inc169.12
  %296 = trunc i64 %indvars.iv.next20.12 to i32
  %mul63.13 = shl nsw i32 %296, 7
  %cmp67.13 = icmp eq i64 %indvars.iv.next20.12, %11
  %297 = trunc i64 %indvars.iv.next20.12 to i32
  %sub84.13 = shl i32 %297, 7
  %mul94.13 = add i32 %sub84.13, -128
  %sub111.13 = add i32 %mul63.13, -1
  %add119.13 = or i32 %mul63.13, 1
  %mul136.13 = add i32 %sub84.13, 128
  %298 = sext i32 %mul63.13 to i64
  %299 = sext i32 %mul136.13 to i64
  %300 = sext i32 %mul94.13 to i64
  br label %for.body61.13

for.body61.13:                                    ; preds = %for.inc166.13, %for.body61.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body61.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc166.13 ]
  %301 = add nsw i64 %indvars.iv.13, %298
  %cmp70.13 = icmp eq i64 %indvars.iv.13, 0
  %or.cond1.13 = or i1 %cmp67.13, %cmp70.13
  %cmp73.13 = icmp eq i64 %indvars.iv.13, %10
  %or.cond2.13 = or i1 %cmp73.13, %or.cond1.13
  br i1 %or.cond2.13, label %if.then75.13, label %if.else78.13

if.else78.13:                                     ; preds = %for.body61.13
  %arrayidx80.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %301
  %302 = load i32, i32* %arrayidx80.13, align 4
  %cmp81.13 = icmp eq i32 %302, 75
  br i1 %cmp81.13, label %if.then83.13, label %if.else158.13

if.else158.13:                                    ; preds = %if.else78.13
  %conv161.13 = trunc i32 %302 to i8
  %arrayidx163.13 = getelementptr inbounds i8, i8* %., i64 %301
  store i8 %conv161.13, i8* %arrayidx163.13, align 1
  br label %for.inc166.13

if.then83.13:                                     ; preds = %if.else78.13
  %303 = trunc i64 %indvars.iv.13 to i32
  %sub86.13 = add i32 %303, %sub84.13
  %add87.13 = add i32 %sub86.13, -129
  %idxprom88.13 = sext i32 %add87.13 to i64
  %arrayidx89.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.13
  %304 = load i32, i32* %arrayidx89.13, align 4
  %cmp90.13 = icmp eq i32 %304, 255
  br i1 %cmp90.13, label %if.then151.13, label %lor.lhs.false92.13

lor.lhs.false92.13:                               ; preds = %if.then83.13
  %305 = add nsw i64 %300, %indvars.iv.13
  %arrayidx97.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %305
  %306 = load i32, i32* %arrayidx97.13, align 4
  %cmp98.13 = icmp eq i32 %306, 255
  br i1 %cmp98.13, label %if.then151.13, label %lor.lhs.false100.13

lor.lhs.false100.13:                              ; preds = %lor.lhs.false92.13
  %add104.13 = add i32 %sub86.13, -127
  %idxprom105.13 = sext i32 %add104.13 to i64
  %arrayidx106.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.13
  %307 = load i32, i32* %arrayidx106.13, align 4
  %cmp107.13 = icmp eq i32 %307, 255
  br i1 %cmp107.13, label %if.then151.13, label %lor.lhs.false109.13

lor.lhs.false109.13:                              ; preds = %lor.lhs.false100.13
  %308 = trunc i64 %indvars.iv.13 to i32
  %add112.13 = add i32 %sub111.13, %308
  %idxprom113.13 = sext i32 %add112.13 to i64
  %arrayidx114.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.13
  %309 = load i32, i32* %arrayidx114.13, align 4
  %cmp115.13 = icmp eq i32 %309, 255
  br i1 %cmp115.13, label %if.then151.13, label %lor.lhs.false117.13

lor.lhs.false117.13:                              ; preds = %lor.lhs.false109.13
  %310 = trunc i64 %indvars.iv.13 to i32
  %add120.13 = add i32 %add119.13, %310
  %idxprom121.13 = sext i32 %add120.13 to i64
  %arrayidx122.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.13
  %311 = load i32, i32* %arrayidx122.13, align 4
  %cmp123.13 = icmp eq i32 %311, 255
  br i1 %cmp123.13, label %if.then151.13, label %lor.lhs.false125.13

lor.lhs.false125.13:                              ; preds = %lor.lhs.false117.13
  %add129.13 = add i32 %sub86.13, 127
  %idxprom130.13 = sext i32 %add129.13 to i64
  %arrayidx131.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.13
  %312 = load i32, i32* %arrayidx131.13, align 4
  %cmp132.13 = icmp eq i32 %312, 255
  br i1 %cmp132.13, label %if.then151.13, label %lor.lhs.false134.13

lor.lhs.false134.13:                              ; preds = %lor.lhs.false125.13
  %313 = add nsw i64 %299, %indvars.iv.13
  %arrayidx139.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %313
  %314 = load i32, i32* %arrayidx139.13, align 4
  %cmp140.13 = icmp eq i32 %314, 255
  br i1 %cmp140.13, label %if.then151.13, label %lor.lhs.false142.13

lor.lhs.false142.13:                              ; preds = %lor.lhs.false134.13
  %add146.13 = add i32 %sub86.13, 129
  %idxprom147.13 = sext i32 %add146.13 to i64
  %arrayidx148.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.13
  %315 = load i32, i32* %arrayidx148.13, align 4
  %cmp149.13 = icmp eq i32 %315, 255
  br i1 %cmp149.13, label %if.then151.13, label %if.else154.13

if.else154.13:                                    ; preds = %lor.lhs.false142.13
  %arrayidx156.13 = getelementptr inbounds i8, i8* %., i64 %301
  store i8 0, i8* %arrayidx156.13, align 1
  br label %for.inc166.13

if.then151.13:                                    ; preds = %lor.lhs.false142.13, %lor.lhs.false134.13, %lor.lhs.false125.13, %lor.lhs.false117.13, %lor.lhs.false109.13, %lor.lhs.false100.13, %lor.lhs.false92.13, %if.then83.13
  %arrayidx153.13 = getelementptr inbounds i8, i8* %., i64 %301
  store i8 -1, i8* %arrayidx153.13, align 1
  br label %for.inc166.13

if.then75.13:                                     ; preds = %for.body61.13
  %arrayidx77.13 = getelementptr inbounds i8, i8* %., i64 %301
  store i8 0, i8* %arrayidx77.13, align 1
  br label %for.inc166.13

for.inc166.13:                                    ; preds = %if.then75.13, %if.then151.13, %if.else154.13, %if.else158.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %img_width
  br i1 %exitcond.13, label %for.inc169.13, label %for.body61.13, !llvm.loop !5

for.inc169.13:                                    ; preds = %for.inc166.13
  %indvars.iv.next20.13 = add nsw i64 %indvars.iv19, 14
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.14

for.body61.lr.ph.14:                              ; preds = %for.inc169.13
  %316 = trunc i64 %indvars.iv.next20.13 to i32
  %mul63.14 = shl nsw i32 %316, 7
  %cmp67.14 = icmp eq i64 %indvars.iv.next20.13, %11
  %317 = trunc i64 %indvars.iv.next20.13 to i32
  %sub84.14 = shl i32 %317, 7
  %mul94.14 = add i32 %sub84.14, -128
  %sub111.14 = add i32 %mul63.14, -1
  %add119.14 = or i32 %mul63.14, 1
  %mul136.14 = add i32 %sub84.14, 128
  %318 = sext i32 %mul63.14 to i64
  %319 = sext i32 %mul136.14 to i64
  %320 = sext i32 %mul94.14 to i64
  br label %for.body61.14

for.body61.14:                                    ; preds = %for.inc166.14, %for.body61.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body61.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc166.14 ]
  %321 = add nsw i64 %indvars.iv.14, %318
  %cmp70.14 = icmp eq i64 %indvars.iv.14, 0
  %or.cond1.14 = or i1 %cmp67.14, %cmp70.14
  %cmp73.14 = icmp eq i64 %indvars.iv.14, %10
  %or.cond2.14 = or i1 %cmp73.14, %or.cond1.14
  br i1 %or.cond2.14, label %if.then75.14, label %if.else78.14

if.else78.14:                                     ; preds = %for.body61.14
  %arrayidx80.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %321
  %322 = load i32, i32* %arrayidx80.14, align 4
  %cmp81.14 = icmp eq i32 %322, 75
  br i1 %cmp81.14, label %if.then83.14, label %if.else158.14

if.else158.14:                                    ; preds = %if.else78.14
  %conv161.14 = trunc i32 %322 to i8
  %arrayidx163.14 = getelementptr inbounds i8, i8* %., i64 %321
  store i8 %conv161.14, i8* %arrayidx163.14, align 1
  br label %for.inc166.14

if.then83.14:                                     ; preds = %if.else78.14
  %323 = trunc i64 %indvars.iv.14 to i32
  %sub86.14 = add i32 %323, %sub84.14
  %add87.14 = add i32 %sub86.14, -129
  %idxprom88.14 = sext i32 %add87.14 to i64
  %arrayidx89.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.14
  %324 = load i32, i32* %arrayidx89.14, align 4
  %cmp90.14 = icmp eq i32 %324, 255
  br i1 %cmp90.14, label %if.then151.14, label %lor.lhs.false92.14

lor.lhs.false92.14:                               ; preds = %if.then83.14
  %325 = add nsw i64 %320, %indvars.iv.14
  %arrayidx97.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %325
  %326 = load i32, i32* %arrayidx97.14, align 4
  %cmp98.14 = icmp eq i32 %326, 255
  br i1 %cmp98.14, label %if.then151.14, label %lor.lhs.false100.14

lor.lhs.false100.14:                              ; preds = %lor.lhs.false92.14
  %add104.14 = add i32 %sub86.14, -127
  %idxprom105.14 = sext i32 %add104.14 to i64
  %arrayidx106.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.14
  %327 = load i32, i32* %arrayidx106.14, align 4
  %cmp107.14 = icmp eq i32 %327, 255
  br i1 %cmp107.14, label %if.then151.14, label %lor.lhs.false109.14

lor.lhs.false109.14:                              ; preds = %lor.lhs.false100.14
  %328 = trunc i64 %indvars.iv.14 to i32
  %add112.14 = add i32 %sub111.14, %328
  %idxprom113.14 = sext i32 %add112.14 to i64
  %arrayidx114.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.14
  %329 = load i32, i32* %arrayidx114.14, align 4
  %cmp115.14 = icmp eq i32 %329, 255
  br i1 %cmp115.14, label %if.then151.14, label %lor.lhs.false117.14

lor.lhs.false117.14:                              ; preds = %lor.lhs.false109.14
  %330 = trunc i64 %indvars.iv.14 to i32
  %add120.14 = add i32 %add119.14, %330
  %idxprom121.14 = sext i32 %add120.14 to i64
  %arrayidx122.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.14
  %331 = load i32, i32* %arrayidx122.14, align 4
  %cmp123.14 = icmp eq i32 %331, 255
  br i1 %cmp123.14, label %if.then151.14, label %lor.lhs.false125.14

lor.lhs.false125.14:                              ; preds = %lor.lhs.false117.14
  %add129.14 = add i32 %sub86.14, 127
  %idxprom130.14 = sext i32 %add129.14 to i64
  %arrayidx131.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.14
  %332 = load i32, i32* %arrayidx131.14, align 4
  %cmp132.14 = icmp eq i32 %332, 255
  br i1 %cmp132.14, label %if.then151.14, label %lor.lhs.false134.14

lor.lhs.false134.14:                              ; preds = %lor.lhs.false125.14
  %333 = add nsw i64 %319, %indvars.iv.14
  %arrayidx139.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %333
  %334 = load i32, i32* %arrayidx139.14, align 4
  %cmp140.14 = icmp eq i32 %334, 255
  br i1 %cmp140.14, label %if.then151.14, label %lor.lhs.false142.14

lor.lhs.false142.14:                              ; preds = %lor.lhs.false134.14
  %add146.14 = add i32 %sub86.14, 129
  %idxprom147.14 = sext i32 %add146.14 to i64
  %arrayidx148.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.14
  %335 = load i32, i32* %arrayidx148.14, align 4
  %cmp149.14 = icmp eq i32 %335, 255
  br i1 %cmp149.14, label %if.then151.14, label %if.else154.14

if.else154.14:                                    ; preds = %lor.lhs.false142.14
  %arrayidx156.14 = getelementptr inbounds i8, i8* %., i64 %321
  store i8 0, i8* %arrayidx156.14, align 1
  br label %for.inc166.14

if.then151.14:                                    ; preds = %lor.lhs.false142.14, %lor.lhs.false134.14, %lor.lhs.false125.14, %lor.lhs.false117.14, %lor.lhs.false109.14, %lor.lhs.false100.14, %lor.lhs.false92.14, %if.then83.14
  %arrayidx153.14 = getelementptr inbounds i8, i8* %., i64 %321
  store i8 -1, i8* %arrayidx153.14, align 1
  br label %for.inc166.14

if.then75.14:                                     ; preds = %for.body61.14
  %arrayidx77.14 = getelementptr inbounds i8, i8* %., i64 %321
  store i8 0, i8* %arrayidx77.14, align 1
  br label %for.inc166.14

for.inc166.14:                                    ; preds = %if.then75.14, %if.then151.14, %if.else154.14, %if.else158.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %img_width
  br i1 %exitcond.14, label %for.inc169.14, label %for.body61.14, !llvm.loop !5

for.inc169.14:                                    ; preds = %for.inc166.14
  %indvars.iv.next20.14 = add nsw i64 %indvars.iv19, 15
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.15

for.body61.lr.ph.15:                              ; preds = %for.inc169.14
  %336 = trunc i64 %indvars.iv.next20.14 to i32
  %mul63.15 = shl nsw i32 %336, 7
  %cmp67.15 = icmp eq i64 %indvars.iv.next20.14, %11
  %337 = trunc i64 %indvars.iv.next20.14 to i32
  %sub84.15 = shl i32 %337, 7
  %mul94.15 = add i32 %sub84.15, -128
  %sub111.15 = add i32 %mul63.15, -1
  %add119.15 = or i32 %mul63.15, 1
  %mul136.15 = add i32 %sub84.15, 128
  %338 = sext i32 %mul63.15 to i64
  %339 = sext i32 %mul136.15 to i64
  %340 = sext i32 %mul94.15 to i64
  br label %for.body61.15

for.body61.15:                                    ; preds = %for.inc166.15, %for.body61.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body61.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc166.15 ]
  %341 = add nsw i64 %indvars.iv.15, %338
  %cmp70.15 = icmp eq i64 %indvars.iv.15, 0
  %or.cond1.15 = or i1 %cmp67.15, %cmp70.15
  %cmp73.15 = icmp eq i64 %indvars.iv.15, %10
  %or.cond2.15 = or i1 %cmp73.15, %or.cond1.15
  br i1 %or.cond2.15, label %if.then75.15, label %if.else78.15

if.else78.15:                                     ; preds = %for.body61.15
  %arrayidx80.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %341
  %342 = load i32, i32* %arrayidx80.15, align 4
  %cmp81.15 = icmp eq i32 %342, 75
  br i1 %cmp81.15, label %if.then83.15, label %if.else158.15

if.else158.15:                                    ; preds = %if.else78.15
  %conv161.15 = trunc i32 %342 to i8
  %arrayidx163.15 = getelementptr inbounds i8, i8* %., i64 %341
  store i8 %conv161.15, i8* %arrayidx163.15, align 1
  br label %for.inc166.15

if.then83.15:                                     ; preds = %if.else78.15
  %343 = trunc i64 %indvars.iv.15 to i32
  %sub86.15 = add i32 %343, %sub84.15
  %add87.15 = add i32 %sub86.15, -129
  %idxprom88.15 = sext i32 %add87.15 to i64
  %arrayidx89.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.15
  %344 = load i32, i32* %arrayidx89.15, align 4
  %cmp90.15 = icmp eq i32 %344, 255
  br i1 %cmp90.15, label %if.then151.15, label %lor.lhs.false92.15

lor.lhs.false92.15:                               ; preds = %if.then83.15
  %345 = add nsw i64 %340, %indvars.iv.15
  %arrayidx97.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %345
  %346 = load i32, i32* %arrayidx97.15, align 4
  %cmp98.15 = icmp eq i32 %346, 255
  br i1 %cmp98.15, label %if.then151.15, label %lor.lhs.false100.15

lor.lhs.false100.15:                              ; preds = %lor.lhs.false92.15
  %add104.15 = add i32 %sub86.15, -127
  %idxprom105.15 = sext i32 %add104.15 to i64
  %arrayidx106.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.15
  %347 = load i32, i32* %arrayidx106.15, align 4
  %cmp107.15 = icmp eq i32 %347, 255
  br i1 %cmp107.15, label %if.then151.15, label %lor.lhs.false109.15

lor.lhs.false109.15:                              ; preds = %lor.lhs.false100.15
  %348 = trunc i64 %indvars.iv.15 to i32
  %add112.15 = add i32 %sub111.15, %348
  %idxprom113.15 = sext i32 %add112.15 to i64
  %arrayidx114.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.15
  %349 = load i32, i32* %arrayidx114.15, align 4
  %cmp115.15 = icmp eq i32 %349, 255
  br i1 %cmp115.15, label %if.then151.15, label %lor.lhs.false117.15

lor.lhs.false117.15:                              ; preds = %lor.lhs.false109.15
  %350 = trunc i64 %indvars.iv.15 to i32
  %add120.15 = add i32 %add119.15, %350
  %idxprom121.15 = sext i32 %add120.15 to i64
  %arrayidx122.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.15
  %351 = load i32, i32* %arrayidx122.15, align 4
  %cmp123.15 = icmp eq i32 %351, 255
  br i1 %cmp123.15, label %if.then151.15, label %lor.lhs.false125.15

lor.lhs.false125.15:                              ; preds = %lor.lhs.false117.15
  %add129.15 = add i32 %sub86.15, 127
  %idxprom130.15 = sext i32 %add129.15 to i64
  %arrayidx131.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.15
  %352 = load i32, i32* %arrayidx131.15, align 4
  %cmp132.15 = icmp eq i32 %352, 255
  br i1 %cmp132.15, label %if.then151.15, label %lor.lhs.false134.15

lor.lhs.false134.15:                              ; preds = %lor.lhs.false125.15
  %353 = add nsw i64 %339, %indvars.iv.15
  %arrayidx139.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %353
  %354 = load i32, i32* %arrayidx139.15, align 4
  %cmp140.15 = icmp eq i32 %354, 255
  br i1 %cmp140.15, label %if.then151.15, label %lor.lhs.false142.15

lor.lhs.false142.15:                              ; preds = %lor.lhs.false134.15
  %add146.15 = add i32 %sub86.15, 129
  %idxprom147.15 = sext i32 %add146.15 to i64
  %arrayidx148.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.15
  %355 = load i32, i32* %arrayidx148.15, align 4
  %cmp149.15 = icmp eq i32 %355, 255
  br i1 %cmp149.15, label %if.then151.15, label %if.else154.15

if.else154.15:                                    ; preds = %lor.lhs.false142.15
  %arrayidx156.15 = getelementptr inbounds i8, i8* %., i64 %341
  store i8 0, i8* %arrayidx156.15, align 1
  br label %for.inc166.15

if.then151.15:                                    ; preds = %lor.lhs.false142.15, %lor.lhs.false134.15, %lor.lhs.false125.15, %lor.lhs.false117.15, %lor.lhs.false109.15, %lor.lhs.false100.15, %lor.lhs.false92.15, %if.then83.15
  %arrayidx153.15 = getelementptr inbounds i8, i8* %., i64 %341
  store i8 -1, i8* %arrayidx153.15, align 1
  br label %for.inc166.15

if.then75.15:                                     ; preds = %for.body61.15
  %arrayidx77.15 = getelementptr inbounds i8, i8* %., i64 %341
  store i8 0, i8* %arrayidx77.15, align 1
  br label %for.inc166.15

for.inc166.15:                                    ; preds = %if.then75.15, %if.then151.15, %if.else154.15, %if.else158.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %img_width
  br i1 %exitcond.15, label %for.inc169.15, label %for.body61.15, !llvm.loop !5

for.inc169.15:                                    ; preds = %for.inc166.15
  %indvars.iv.next20.15 = add nsw i64 %indvars.iv19, 16
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.16

for.body61.lr.ph.16:                              ; preds = %for.inc169.15
  %356 = trunc i64 %indvars.iv.next20.15 to i32
  %mul63.16 = shl nsw i32 %356, 7
  %cmp67.16 = icmp eq i64 %indvars.iv.next20.15, %11
  %357 = trunc i64 %indvars.iv.next20.15 to i32
  %sub84.16 = shl i32 %357, 7
  %mul94.16 = add i32 %sub84.16, -128
  %sub111.16 = add i32 %mul63.16, -1
  %add119.16 = or i32 %mul63.16, 1
  %mul136.16 = add i32 %sub84.16, 128
  %358 = sext i32 %mul63.16 to i64
  %359 = sext i32 %mul136.16 to i64
  %360 = sext i32 %mul94.16 to i64
  br label %for.body61.16

for.body61.16:                                    ; preds = %for.inc166.16, %for.body61.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body61.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc166.16 ]
  %361 = add nsw i64 %indvars.iv.16, %358
  %cmp70.16 = icmp eq i64 %indvars.iv.16, 0
  %or.cond1.16 = or i1 %cmp67.16, %cmp70.16
  %cmp73.16 = icmp eq i64 %indvars.iv.16, %10
  %or.cond2.16 = or i1 %cmp73.16, %or.cond1.16
  br i1 %or.cond2.16, label %if.then75.16, label %if.else78.16

if.else78.16:                                     ; preds = %for.body61.16
  %arrayidx80.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %361
  %362 = load i32, i32* %arrayidx80.16, align 4
  %cmp81.16 = icmp eq i32 %362, 75
  br i1 %cmp81.16, label %if.then83.16, label %if.else158.16

if.else158.16:                                    ; preds = %if.else78.16
  %conv161.16 = trunc i32 %362 to i8
  %arrayidx163.16 = getelementptr inbounds i8, i8* %., i64 %361
  store i8 %conv161.16, i8* %arrayidx163.16, align 1
  br label %for.inc166.16

if.then83.16:                                     ; preds = %if.else78.16
  %363 = trunc i64 %indvars.iv.16 to i32
  %sub86.16 = add i32 %363, %sub84.16
  %add87.16 = add i32 %sub86.16, -129
  %idxprom88.16 = sext i32 %add87.16 to i64
  %arrayidx89.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.16
  %364 = load i32, i32* %arrayidx89.16, align 4
  %cmp90.16 = icmp eq i32 %364, 255
  br i1 %cmp90.16, label %if.then151.16, label %lor.lhs.false92.16

lor.lhs.false92.16:                               ; preds = %if.then83.16
  %365 = add nsw i64 %360, %indvars.iv.16
  %arrayidx97.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %365
  %366 = load i32, i32* %arrayidx97.16, align 4
  %cmp98.16 = icmp eq i32 %366, 255
  br i1 %cmp98.16, label %if.then151.16, label %lor.lhs.false100.16

lor.lhs.false100.16:                              ; preds = %lor.lhs.false92.16
  %add104.16 = add i32 %sub86.16, -127
  %idxprom105.16 = sext i32 %add104.16 to i64
  %arrayidx106.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.16
  %367 = load i32, i32* %arrayidx106.16, align 4
  %cmp107.16 = icmp eq i32 %367, 255
  br i1 %cmp107.16, label %if.then151.16, label %lor.lhs.false109.16

lor.lhs.false109.16:                              ; preds = %lor.lhs.false100.16
  %368 = trunc i64 %indvars.iv.16 to i32
  %add112.16 = add i32 %sub111.16, %368
  %idxprom113.16 = sext i32 %add112.16 to i64
  %arrayidx114.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.16
  %369 = load i32, i32* %arrayidx114.16, align 4
  %cmp115.16 = icmp eq i32 %369, 255
  br i1 %cmp115.16, label %if.then151.16, label %lor.lhs.false117.16

lor.lhs.false117.16:                              ; preds = %lor.lhs.false109.16
  %370 = trunc i64 %indvars.iv.16 to i32
  %add120.16 = add i32 %add119.16, %370
  %idxprom121.16 = sext i32 %add120.16 to i64
  %arrayidx122.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.16
  %371 = load i32, i32* %arrayidx122.16, align 4
  %cmp123.16 = icmp eq i32 %371, 255
  br i1 %cmp123.16, label %if.then151.16, label %lor.lhs.false125.16

lor.lhs.false125.16:                              ; preds = %lor.lhs.false117.16
  %add129.16 = add i32 %sub86.16, 127
  %idxprom130.16 = sext i32 %add129.16 to i64
  %arrayidx131.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.16
  %372 = load i32, i32* %arrayidx131.16, align 4
  %cmp132.16 = icmp eq i32 %372, 255
  br i1 %cmp132.16, label %if.then151.16, label %lor.lhs.false134.16

lor.lhs.false134.16:                              ; preds = %lor.lhs.false125.16
  %373 = add nsw i64 %359, %indvars.iv.16
  %arrayidx139.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %373
  %374 = load i32, i32* %arrayidx139.16, align 4
  %cmp140.16 = icmp eq i32 %374, 255
  br i1 %cmp140.16, label %if.then151.16, label %lor.lhs.false142.16

lor.lhs.false142.16:                              ; preds = %lor.lhs.false134.16
  %add146.16 = add i32 %sub86.16, 129
  %idxprom147.16 = sext i32 %add146.16 to i64
  %arrayidx148.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.16
  %375 = load i32, i32* %arrayidx148.16, align 4
  %cmp149.16 = icmp eq i32 %375, 255
  br i1 %cmp149.16, label %if.then151.16, label %if.else154.16

if.else154.16:                                    ; preds = %lor.lhs.false142.16
  %arrayidx156.16 = getelementptr inbounds i8, i8* %., i64 %361
  store i8 0, i8* %arrayidx156.16, align 1
  br label %for.inc166.16

if.then151.16:                                    ; preds = %lor.lhs.false142.16, %lor.lhs.false134.16, %lor.lhs.false125.16, %lor.lhs.false117.16, %lor.lhs.false109.16, %lor.lhs.false100.16, %lor.lhs.false92.16, %if.then83.16
  %arrayidx153.16 = getelementptr inbounds i8, i8* %., i64 %361
  store i8 -1, i8* %arrayidx153.16, align 1
  br label %for.inc166.16

if.then75.16:                                     ; preds = %for.body61.16
  %arrayidx77.16 = getelementptr inbounds i8, i8* %., i64 %361
  store i8 0, i8* %arrayidx77.16, align 1
  br label %for.inc166.16

for.inc166.16:                                    ; preds = %if.then75.16, %if.then151.16, %if.else154.16, %if.else158.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %img_width
  br i1 %exitcond.16, label %for.inc169.16, label %for.body61.16, !llvm.loop !5

for.inc169.16:                                    ; preds = %for.inc166.16
  %indvars.iv.next20.16 = add nsw i64 %indvars.iv19, 17
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.17

for.body61.lr.ph.17:                              ; preds = %for.inc169.16
  %376 = trunc i64 %indvars.iv.next20.16 to i32
  %mul63.17 = shl nsw i32 %376, 7
  %cmp67.17 = icmp eq i64 %indvars.iv.next20.16, %11
  %377 = trunc i64 %indvars.iv.next20.16 to i32
  %sub84.17 = shl i32 %377, 7
  %mul94.17 = add i32 %sub84.17, -128
  %sub111.17 = add i32 %mul63.17, -1
  %add119.17 = or i32 %mul63.17, 1
  %mul136.17 = add i32 %sub84.17, 128
  %378 = sext i32 %mul63.17 to i64
  %379 = sext i32 %mul136.17 to i64
  %380 = sext i32 %mul94.17 to i64
  br label %for.body61.17

for.body61.17:                                    ; preds = %for.inc166.17, %for.body61.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body61.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc166.17 ]
  %381 = add nsw i64 %indvars.iv.17, %378
  %cmp70.17 = icmp eq i64 %indvars.iv.17, 0
  %or.cond1.17 = or i1 %cmp67.17, %cmp70.17
  %cmp73.17 = icmp eq i64 %indvars.iv.17, %10
  %or.cond2.17 = or i1 %cmp73.17, %or.cond1.17
  br i1 %or.cond2.17, label %if.then75.17, label %if.else78.17

if.else78.17:                                     ; preds = %for.body61.17
  %arrayidx80.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %381
  %382 = load i32, i32* %arrayidx80.17, align 4
  %cmp81.17 = icmp eq i32 %382, 75
  br i1 %cmp81.17, label %if.then83.17, label %if.else158.17

if.else158.17:                                    ; preds = %if.else78.17
  %conv161.17 = trunc i32 %382 to i8
  %arrayidx163.17 = getelementptr inbounds i8, i8* %., i64 %381
  store i8 %conv161.17, i8* %arrayidx163.17, align 1
  br label %for.inc166.17

if.then83.17:                                     ; preds = %if.else78.17
  %383 = trunc i64 %indvars.iv.17 to i32
  %sub86.17 = add i32 %383, %sub84.17
  %add87.17 = add i32 %sub86.17, -129
  %idxprom88.17 = sext i32 %add87.17 to i64
  %arrayidx89.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.17
  %384 = load i32, i32* %arrayidx89.17, align 4
  %cmp90.17 = icmp eq i32 %384, 255
  br i1 %cmp90.17, label %if.then151.17, label %lor.lhs.false92.17

lor.lhs.false92.17:                               ; preds = %if.then83.17
  %385 = add nsw i64 %380, %indvars.iv.17
  %arrayidx97.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %385
  %386 = load i32, i32* %arrayidx97.17, align 4
  %cmp98.17 = icmp eq i32 %386, 255
  br i1 %cmp98.17, label %if.then151.17, label %lor.lhs.false100.17

lor.lhs.false100.17:                              ; preds = %lor.lhs.false92.17
  %add104.17 = add i32 %sub86.17, -127
  %idxprom105.17 = sext i32 %add104.17 to i64
  %arrayidx106.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.17
  %387 = load i32, i32* %arrayidx106.17, align 4
  %cmp107.17 = icmp eq i32 %387, 255
  br i1 %cmp107.17, label %if.then151.17, label %lor.lhs.false109.17

lor.lhs.false109.17:                              ; preds = %lor.lhs.false100.17
  %388 = trunc i64 %indvars.iv.17 to i32
  %add112.17 = add i32 %sub111.17, %388
  %idxprom113.17 = sext i32 %add112.17 to i64
  %arrayidx114.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.17
  %389 = load i32, i32* %arrayidx114.17, align 4
  %cmp115.17 = icmp eq i32 %389, 255
  br i1 %cmp115.17, label %if.then151.17, label %lor.lhs.false117.17

lor.lhs.false117.17:                              ; preds = %lor.lhs.false109.17
  %390 = trunc i64 %indvars.iv.17 to i32
  %add120.17 = add i32 %add119.17, %390
  %idxprom121.17 = sext i32 %add120.17 to i64
  %arrayidx122.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.17
  %391 = load i32, i32* %arrayidx122.17, align 4
  %cmp123.17 = icmp eq i32 %391, 255
  br i1 %cmp123.17, label %if.then151.17, label %lor.lhs.false125.17

lor.lhs.false125.17:                              ; preds = %lor.lhs.false117.17
  %add129.17 = add i32 %sub86.17, 127
  %idxprom130.17 = sext i32 %add129.17 to i64
  %arrayidx131.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.17
  %392 = load i32, i32* %arrayidx131.17, align 4
  %cmp132.17 = icmp eq i32 %392, 255
  br i1 %cmp132.17, label %if.then151.17, label %lor.lhs.false134.17

lor.lhs.false134.17:                              ; preds = %lor.lhs.false125.17
  %393 = add nsw i64 %379, %indvars.iv.17
  %arrayidx139.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %393
  %394 = load i32, i32* %arrayidx139.17, align 4
  %cmp140.17 = icmp eq i32 %394, 255
  br i1 %cmp140.17, label %if.then151.17, label %lor.lhs.false142.17

lor.lhs.false142.17:                              ; preds = %lor.lhs.false134.17
  %add146.17 = add i32 %sub86.17, 129
  %idxprom147.17 = sext i32 %add146.17 to i64
  %arrayidx148.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.17
  %395 = load i32, i32* %arrayidx148.17, align 4
  %cmp149.17 = icmp eq i32 %395, 255
  br i1 %cmp149.17, label %if.then151.17, label %if.else154.17

if.else154.17:                                    ; preds = %lor.lhs.false142.17
  %arrayidx156.17 = getelementptr inbounds i8, i8* %., i64 %381
  store i8 0, i8* %arrayidx156.17, align 1
  br label %for.inc166.17

if.then151.17:                                    ; preds = %lor.lhs.false142.17, %lor.lhs.false134.17, %lor.lhs.false125.17, %lor.lhs.false117.17, %lor.lhs.false109.17, %lor.lhs.false100.17, %lor.lhs.false92.17, %if.then83.17
  %arrayidx153.17 = getelementptr inbounds i8, i8* %., i64 %381
  store i8 -1, i8* %arrayidx153.17, align 1
  br label %for.inc166.17

if.then75.17:                                     ; preds = %for.body61.17
  %arrayidx77.17 = getelementptr inbounds i8, i8* %., i64 %381
  store i8 0, i8* %arrayidx77.17, align 1
  br label %for.inc166.17

for.inc166.17:                                    ; preds = %if.then75.17, %if.then151.17, %if.else154.17, %if.else158.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %img_width
  br i1 %exitcond.17, label %for.inc169.17, label %for.body61.17, !llvm.loop !5

for.inc169.17:                                    ; preds = %for.inc166.17
  %indvars.iv.next20.17 = add nsw i64 %indvars.iv19, 18
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.18

for.body61.lr.ph.18:                              ; preds = %for.inc169.17
  %396 = trunc i64 %indvars.iv.next20.17 to i32
  %mul63.18 = shl nsw i32 %396, 7
  %cmp67.18 = icmp eq i64 %indvars.iv.next20.17, %11
  %397 = trunc i64 %indvars.iv.next20.17 to i32
  %sub84.18 = shl i32 %397, 7
  %mul94.18 = add i32 %sub84.18, -128
  %sub111.18 = add i32 %mul63.18, -1
  %add119.18 = or i32 %mul63.18, 1
  %mul136.18 = add i32 %sub84.18, 128
  %398 = sext i32 %mul63.18 to i64
  %399 = sext i32 %mul136.18 to i64
  %400 = sext i32 %mul94.18 to i64
  br label %for.body61.18

for.body61.18:                                    ; preds = %for.inc166.18, %for.body61.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body61.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc166.18 ]
  %401 = add nsw i64 %indvars.iv.18, %398
  %cmp70.18 = icmp eq i64 %indvars.iv.18, 0
  %or.cond1.18 = or i1 %cmp67.18, %cmp70.18
  %cmp73.18 = icmp eq i64 %indvars.iv.18, %10
  %or.cond2.18 = or i1 %cmp73.18, %or.cond1.18
  br i1 %or.cond2.18, label %if.then75.18, label %if.else78.18

if.else78.18:                                     ; preds = %for.body61.18
  %arrayidx80.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %401
  %402 = load i32, i32* %arrayidx80.18, align 4
  %cmp81.18 = icmp eq i32 %402, 75
  br i1 %cmp81.18, label %if.then83.18, label %if.else158.18

if.else158.18:                                    ; preds = %if.else78.18
  %conv161.18 = trunc i32 %402 to i8
  %arrayidx163.18 = getelementptr inbounds i8, i8* %., i64 %401
  store i8 %conv161.18, i8* %arrayidx163.18, align 1
  br label %for.inc166.18

if.then83.18:                                     ; preds = %if.else78.18
  %403 = trunc i64 %indvars.iv.18 to i32
  %sub86.18 = add i32 %403, %sub84.18
  %add87.18 = add i32 %sub86.18, -129
  %idxprom88.18 = sext i32 %add87.18 to i64
  %arrayidx89.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.18
  %404 = load i32, i32* %arrayidx89.18, align 4
  %cmp90.18 = icmp eq i32 %404, 255
  br i1 %cmp90.18, label %if.then151.18, label %lor.lhs.false92.18

lor.lhs.false92.18:                               ; preds = %if.then83.18
  %405 = add nsw i64 %400, %indvars.iv.18
  %arrayidx97.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %405
  %406 = load i32, i32* %arrayidx97.18, align 4
  %cmp98.18 = icmp eq i32 %406, 255
  br i1 %cmp98.18, label %if.then151.18, label %lor.lhs.false100.18

lor.lhs.false100.18:                              ; preds = %lor.lhs.false92.18
  %add104.18 = add i32 %sub86.18, -127
  %idxprom105.18 = sext i32 %add104.18 to i64
  %arrayidx106.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.18
  %407 = load i32, i32* %arrayidx106.18, align 4
  %cmp107.18 = icmp eq i32 %407, 255
  br i1 %cmp107.18, label %if.then151.18, label %lor.lhs.false109.18

lor.lhs.false109.18:                              ; preds = %lor.lhs.false100.18
  %408 = trunc i64 %indvars.iv.18 to i32
  %add112.18 = add i32 %sub111.18, %408
  %idxprom113.18 = sext i32 %add112.18 to i64
  %arrayidx114.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.18
  %409 = load i32, i32* %arrayidx114.18, align 4
  %cmp115.18 = icmp eq i32 %409, 255
  br i1 %cmp115.18, label %if.then151.18, label %lor.lhs.false117.18

lor.lhs.false117.18:                              ; preds = %lor.lhs.false109.18
  %410 = trunc i64 %indvars.iv.18 to i32
  %add120.18 = add i32 %add119.18, %410
  %idxprom121.18 = sext i32 %add120.18 to i64
  %arrayidx122.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.18
  %411 = load i32, i32* %arrayidx122.18, align 4
  %cmp123.18 = icmp eq i32 %411, 255
  br i1 %cmp123.18, label %if.then151.18, label %lor.lhs.false125.18

lor.lhs.false125.18:                              ; preds = %lor.lhs.false117.18
  %add129.18 = add i32 %sub86.18, 127
  %idxprom130.18 = sext i32 %add129.18 to i64
  %arrayidx131.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.18
  %412 = load i32, i32* %arrayidx131.18, align 4
  %cmp132.18 = icmp eq i32 %412, 255
  br i1 %cmp132.18, label %if.then151.18, label %lor.lhs.false134.18

lor.lhs.false134.18:                              ; preds = %lor.lhs.false125.18
  %413 = add nsw i64 %399, %indvars.iv.18
  %arrayidx139.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %413
  %414 = load i32, i32* %arrayidx139.18, align 4
  %cmp140.18 = icmp eq i32 %414, 255
  br i1 %cmp140.18, label %if.then151.18, label %lor.lhs.false142.18

lor.lhs.false142.18:                              ; preds = %lor.lhs.false134.18
  %add146.18 = add i32 %sub86.18, 129
  %idxprom147.18 = sext i32 %add146.18 to i64
  %arrayidx148.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.18
  %415 = load i32, i32* %arrayidx148.18, align 4
  %cmp149.18 = icmp eq i32 %415, 255
  br i1 %cmp149.18, label %if.then151.18, label %if.else154.18

if.else154.18:                                    ; preds = %lor.lhs.false142.18
  %arrayidx156.18 = getelementptr inbounds i8, i8* %., i64 %401
  store i8 0, i8* %arrayidx156.18, align 1
  br label %for.inc166.18

if.then151.18:                                    ; preds = %lor.lhs.false142.18, %lor.lhs.false134.18, %lor.lhs.false125.18, %lor.lhs.false117.18, %lor.lhs.false109.18, %lor.lhs.false100.18, %lor.lhs.false92.18, %if.then83.18
  %arrayidx153.18 = getelementptr inbounds i8, i8* %., i64 %401
  store i8 -1, i8* %arrayidx153.18, align 1
  br label %for.inc166.18

if.then75.18:                                     ; preds = %for.body61.18
  %arrayidx77.18 = getelementptr inbounds i8, i8* %., i64 %401
  store i8 0, i8* %arrayidx77.18, align 1
  br label %for.inc166.18

for.inc166.18:                                    ; preds = %if.then75.18, %if.then151.18, %if.else154.18, %if.else158.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %img_width
  br i1 %exitcond.18, label %for.inc169.18, label %for.body61.18, !llvm.loop !5

for.inc169.18:                                    ; preds = %for.inc166.18
  %indvars.iv.next20.18 = add nsw i64 %indvars.iv19, 19
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.19

for.body61.lr.ph.19:                              ; preds = %for.inc169.18
  %416 = trunc i64 %indvars.iv.next20.18 to i32
  %mul63.19 = shl nsw i32 %416, 7
  %cmp67.19 = icmp eq i64 %indvars.iv.next20.18, %11
  %417 = trunc i64 %indvars.iv.next20.18 to i32
  %sub84.19 = shl i32 %417, 7
  %mul94.19 = add i32 %sub84.19, -128
  %sub111.19 = add i32 %mul63.19, -1
  %add119.19 = or i32 %mul63.19, 1
  %mul136.19 = add i32 %sub84.19, 128
  %418 = sext i32 %mul63.19 to i64
  %419 = sext i32 %mul136.19 to i64
  %420 = sext i32 %mul94.19 to i64
  br label %for.body61.19

for.body61.19:                                    ; preds = %for.inc166.19, %for.body61.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body61.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc166.19 ]
  %421 = add nsw i64 %indvars.iv.19, %418
  %cmp70.19 = icmp eq i64 %indvars.iv.19, 0
  %or.cond1.19 = or i1 %cmp67.19, %cmp70.19
  %cmp73.19 = icmp eq i64 %indvars.iv.19, %10
  %or.cond2.19 = or i1 %cmp73.19, %or.cond1.19
  br i1 %or.cond2.19, label %if.then75.19, label %if.else78.19

if.else78.19:                                     ; preds = %for.body61.19
  %arrayidx80.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %421
  %422 = load i32, i32* %arrayidx80.19, align 4
  %cmp81.19 = icmp eq i32 %422, 75
  br i1 %cmp81.19, label %if.then83.19, label %if.else158.19

if.else158.19:                                    ; preds = %if.else78.19
  %conv161.19 = trunc i32 %422 to i8
  %arrayidx163.19 = getelementptr inbounds i8, i8* %., i64 %421
  store i8 %conv161.19, i8* %arrayidx163.19, align 1
  br label %for.inc166.19

if.then83.19:                                     ; preds = %if.else78.19
  %423 = trunc i64 %indvars.iv.19 to i32
  %sub86.19 = add i32 %423, %sub84.19
  %add87.19 = add i32 %sub86.19, -129
  %idxprom88.19 = sext i32 %add87.19 to i64
  %arrayidx89.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.19
  %424 = load i32, i32* %arrayidx89.19, align 4
  %cmp90.19 = icmp eq i32 %424, 255
  br i1 %cmp90.19, label %if.then151.19, label %lor.lhs.false92.19

lor.lhs.false92.19:                               ; preds = %if.then83.19
  %425 = add nsw i64 %420, %indvars.iv.19
  %arrayidx97.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %425
  %426 = load i32, i32* %arrayidx97.19, align 4
  %cmp98.19 = icmp eq i32 %426, 255
  br i1 %cmp98.19, label %if.then151.19, label %lor.lhs.false100.19

lor.lhs.false100.19:                              ; preds = %lor.lhs.false92.19
  %add104.19 = add i32 %sub86.19, -127
  %idxprom105.19 = sext i32 %add104.19 to i64
  %arrayidx106.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.19
  %427 = load i32, i32* %arrayidx106.19, align 4
  %cmp107.19 = icmp eq i32 %427, 255
  br i1 %cmp107.19, label %if.then151.19, label %lor.lhs.false109.19

lor.lhs.false109.19:                              ; preds = %lor.lhs.false100.19
  %428 = trunc i64 %indvars.iv.19 to i32
  %add112.19 = add i32 %sub111.19, %428
  %idxprom113.19 = sext i32 %add112.19 to i64
  %arrayidx114.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.19
  %429 = load i32, i32* %arrayidx114.19, align 4
  %cmp115.19 = icmp eq i32 %429, 255
  br i1 %cmp115.19, label %if.then151.19, label %lor.lhs.false117.19

lor.lhs.false117.19:                              ; preds = %lor.lhs.false109.19
  %430 = trunc i64 %indvars.iv.19 to i32
  %add120.19 = add i32 %add119.19, %430
  %idxprom121.19 = sext i32 %add120.19 to i64
  %arrayidx122.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.19
  %431 = load i32, i32* %arrayidx122.19, align 4
  %cmp123.19 = icmp eq i32 %431, 255
  br i1 %cmp123.19, label %if.then151.19, label %lor.lhs.false125.19

lor.lhs.false125.19:                              ; preds = %lor.lhs.false117.19
  %add129.19 = add i32 %sub86.19, 127
  %idxprom130.19 = sext i32 %add129.19 to i64
  %arrayidx131.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.19
  %432 = load i32, i32* %arrayidx131.19, align 4
  %cmp132.19 = icmp eq i32 %432, 255
  br i1 %cmp132.19, label %if.then151.19, label %lor.lhs.false134.19

lor.lhs.false134.19:                              ; preds = %lor.lhs.false125.19
  %433 = add nsw i64 %419, %indvars.iv.19
  %arrayidx139.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %433
  %434 = load i32, i32* %arrayidx139.19, align 4
  %cmp140.19 = icmp eq i32 %434, 255
  br i1 %cmp140.19, label %if.then151.19, label %lor.lhs.false142.19

lor.lhs.false142.19:                              ; preds = %lor.lhs.false134.19
  %add146.19 = add i32 %sub86.19, 129
  %idxprom147.19 = sext i32 %add146.19 to i64
  %arrayidx148.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.19
  %435 = load i32, i32* %arrayidx148.19, align 4
  %cmp149.19 = icmp eq i32 %435, 255
  br i1 %cmp149.19, label %if.then151.19, label %if.else154.19

if.else154.19:                                    ; preds = %lor.lhs.false142.19
  %arrayidx156.19 = getelementptr inbounds i8, i8* %., i64 %421
  store i8 0, i8* %arrayidx156.19, align 1
  br label %for.inc166.19

if.then151.19:                                    ; preds = %lor.lhs.false142.19, %lor.lhs.false134.19, %lor.lhs.false125.19, %lor.lhs.false117.19, %lor.lhs.false109.19, %lor.lhs.false100.19, %lor.lhs.false92.19, %if.then83.19
  %arrayidx153.19 = getelementptr inbounds i8, i8* %., i64 %421
  store i8 -1, i8* %arrayidx153.19, align 1
  br label %for.inc166.19

if.then75.19:                                     ; preds = %for.body61.19
  %arrayidx77.19 = getelementptr inbounds i8, i8* %., i64 %421
  store i8 0, i8* %arrayidx77.19, align 1
  br label %for.inc166.19

for.inc166.19:                                    ; preds = %if.then75.19, %if.then151.19, %if.else154.19, %if.else158.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %img_width
  br i1 %exitcond.19, label %for.inc169.19, label %for.body61.19, !llvm.loop !5

for.inc169.19:                                    ; preds = %for.inc166.19
  %indvars.iv.next20.19 = add nsw i64 %indvars.iv19, 20
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.20

for.body61.lr.ph.20:                              ; preds = %for.inc169.19
  %436 = trunc i64 %indvars.iv.next20.19 to i32
  %mul63.20 = shl nsw i32 %436, 7
  %cmp67.20 = icmp eq i64 %indvars.iv.next20.19, %11
  %437 = trunc i64 %indvars.iv.next20.19 to i32
  %sub84.20 = shl i32 %437, 7
  %mul94.20 = add i32 %sub84.20, -128
  %sub111.20 = add i32 %mul63.20, -1
  %add119.20 = or i32 %mul63.20, 1
  %mul136.20 = add i32 %sub84.20, 128
  %438 = sext i32 %mul63.20 to i64
  %439 = sext i32 %mul136.20 to i64
  %440 = sext i32 %mul94.20 to i64
  br label %for.body61.20

for.body61.20:                                    ; preds = %for.inc166.20, %for.body61.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body61.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc166.20 ]
  %441 = add nsw i64 %indvars.iv.20, %438
  %cmp70.20 = icmp eq i64 %indvars.iv.20, 0
  %or.cond1.20 = or i1 %cmp67.20, %cmp70.20
  %cmp73.20 = icmp eq i64 %indvars.iv.20, %10
  %or.cond2.20 = or i1 %cmp73.20, %or.cond1.20
  br i1 %or.cond2.20, label %if.then75.20, label %if.else78.20

if.else78.20:                                     ; preds = %for.body61.20
  %arrayidx80.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %441
  %442 = load i32, i32* %arrayidx80.20, align 4
  %cmp81.20 = icmp eq i32 %442, 75
  br i1 %cmp81.20, label %if.then83.20, label %if.else158.20

if.else158.20:                                    ; preds = %if.else78.20
  %conv161.20 = trunc i32 %442 to i8
  %arrayidx163.20 = getelementptr inbounds i8, i8* %., i64 %441
  store i8 %conv161.20, i8* %arrayidx163.20, align 1
  br label %for.inc166.20

if.then83.20:                                     ; preds = %if.else78.20
  %443 = trunc i64 %indvars.iv.20 to i32
  %sub86.20 = add i32 %443, %sub84.20
  %add87.20 = add i32 %sub86.20, -129
  %idxprom88.20 = sext i32 %add87.20 to i64
  %arrayidx89.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.20
  %444 = load i32, i32* %arrayidx89.20, align 4
  %cmp90.20 = icmp eq i32 %444, 255
  br i1 %cmp90.20, label %if.then151.20, label %lor.lhs.false92.20

lor.lhs.false92.20:                               ; preds = %if.then83.20
  %445 = add nsw i64 %440, %indvars.iv.20
  %arrayidx97.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %445
  %446 = load i32, i32* %arrayidx97.20, align 4
  %cmp98.20 = icmp eq i32 %446, 255
  br i1 %cmp98.20, label %if.then151.20, label %lor.lhs.false100.20

lor.lhs.false100.20:                              ; preds = %lor.lhs.false92.20
  %add104.20 = add i32 %sub86.20, -127
  %idxprom105.20 = sext i32 %add104.20 to i64
  %arrayidx106.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.20
  %447 = load i32, i32* %arrayidx106.20, align 4
  %cmp107.20 = icmp eq i32 %447, 255
  br i1 %cmp107.20, label %if.then151.20, label %lor.lhs.false109.20

lor.lhs.false109.20:                              ; preds = %lor.lhs.false100.20
  %448 = trunc i64 %indvars.iv.20 to i32
  %add112.20 = add i32 %sub111.20, %448
  %idxprom113.20 = sext i32 %add112.20 to i64
  %arrayidx114.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.20
  %449 = load i32, i32* %arrayidx114.20, align 4
  %cmp115.20 = icmp eq i32 %449, 255
  br i1 %cmp115.20, label %if.then151.20, label %lor.lhs.false117.20

lor.lhs.false117.20:                              ; preds = %lor.lhs.false109.20
  %450 = trunc i64 %indvars.iv.20 to i32
  %add120.20 = add i32 %add119.20, %450
  %idxprom121.20 = sext i32 %add120.20 to i64
  %arrayidx122.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.20
  %451 = load i32, i32* %arrayidx122.20, align 4
  %cmp123.20 = icmp eq i32 %451, 255
  br i1 %cmp123.20, label %if.then151.20, label %lor.lhs.false125.20

lor.lhs.false125.20:                              ; preds = %lor.lhs.false117.20
  %add129.20 = add i32 %sub86.20, 127
  %idxprom130.20 = sext i32 %add129.20 to i64
  %arrayidx131.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.20
  %452 = load i32, i32* %arrayidx131.20, align 4
  %cmp132.20 = icmp eq i32 %452, 255
  br i1 %cmp132.20, label %if.then151.20, label %lor.lhs.false134.20

lor.lhs.false134.20:                              ; preds = %lor.lhs.false125.20
  %453 = add nsw i64 %439, %indvars.iv.20
  %arrayidx139.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %453
  %454 = load i32, i32* %arrayidx139.20, align 4
  %cmp140.20 = icmp eq i32 %454, 255
  br i1 %cmp140.20, label %if.then151.20, label %lor.lhs.false142.20

lor.lhs.false142.20:                              ; preds = %lor.lhs.false134.20
  %add146.20 = add i32 %sub86.20, 129
  %idxprom147.20 = sext i32 %add146.20 to i64
  %arrayidx148.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.20
  %455 = load i32, i32* %arrayidx148.20, align 4
  %cmp149.20 = icmp eq i32 %455, 255
  br i1 %cmp149.20, label %if.then151.20, label %if.else154.20

if.else154.20:                                    ; preds = %lor.lhs.false142.20
  %arrayidx156.20 = getelementptr inbounds i8, i8* %., i64 %441
  store i8 0, i8* %arrayidx156.20, align 1
  br label %for.inc166.20

if.then151.20:                                    ; preds = %lor.lhs.false142.20, %lor.lhs.false134.20, %lor.lhs.false125.20, %lor.lhs.false117.20, %lor.lhs.false109.20, %lor.lhs.false100.20, %lor.lhs.false92.20, %if.then83.20
  %arrayidx153.20 = getelementptr inbounds i8, i8* %., i64 %441
  store i8 -1, i8* %arrayidx153.20, align 1
  br label %for.inc166.20

if.then75.20:                                     ; preds = %for.body61.20
  %arrayidx77.20 = getelementptr inbounds i8, i8* %., i64 %441
  store i8 0, i8* %arrayidx77.20, align 1
  br label %for.inc166.20

for.inc166.20:                                    ; preds = %if.then75.20, %if.then151.20, %if.else154.20, %if.else158.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %img_width
  br i1 %exitcond.20, label %for.inc169.20, label %for.body61.20, !llvm.loop !5

for.inc169.20:                                    ; preds = %for.inc166.20
  %indvars.iv.next20.20 = add nsw i64 %indvars.iv19, 21
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.21

for.body61.lr.ph.21:                              ; preds = %for.inc169.20
  %456 = trunc i64 %indvars.iv.next20.20 to i32
  %mul63.21 = shl nsw i32 %456, 7
  %cmp67.21 = icmp eq i64 %indvars.iv.next20.20, %11
  %457 = trunc i64 %indvars.iv.next20.20 to i32
  %sub84.21 = shl i32 %457, 7
  %mul94.21 = add i32 %sub84.21, -128
  %sub111.21 = add i32 %mul63.21, -1
  %add119.21 = or i32 %mul63.21, 1
  %mul136.21 = add i32 %sub84.21, 128
  %458 = sext i32 %mul63.21 to i64
  %459 = sext i32 %mul136.21 to i64
  %460 = sext i32 %mul94.21 to i64
  br label %for.body61.21

for.body61.21:                                    ; preds = %for.inc166.21, %for.body61.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body61.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc166.21 ]
  %461 = add nsw i64 %indvars.iv.21, %458
  %cmp70.21 = icmp eq i64 %indvars.iv.21, 0
  %or.cond1.21 = or i1 %cmp67.21, %cmp70.21
  %cmp73.21 = icmp eq i64 %indvars.iv.21, %10
  %or.cond2.21 = or i1 %cmp73.21, %or.cond1.21
  br i1 %or.cond2.21, label %if.then75.21, label %if.else78.21

if.else78.21:                                     ; preds = %for.body61.21
  %arrayidx80.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %461
  %462 = load i32, i32* %arrayidx80.21, align 4
  %cmp81.21 = icmp eq i32 %462, 75
  br i1 %cmp81.21, label %if.then83.21, label %if.else158.21

if.else158.21:                                    ; preds = %if.else78.21
  %conv161.21 = trunc i32 %462 to i8
  %arrayidx163.21 = getelementptr inbounds i8, i8* %., i64 %461
  store i8 %conv161.21, i8* %arrayidx163.21, align 1
  br label %for.inc166.21

if.then83.21:                                     ; preds = %if.else78.21
  %463 = trunc i64 %indvars.iv.21 to i32
  %sub86.21 = add i32 %463, %sub84.21
  %add87.21 = add i32 %sub86.21, -129
  %idxprom88.21 = sext i32 %add87.21 to i64
  %arrayidx89.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.21
  %464 = load i32, i32* %arrayidx89.21, align 4
  %cmp90.21 = icmp eq i32 %464, 255
  br i1 %cmp90.21, label %if.then151.21, label %lor.lhs.false92.21

lor.lhs.false92.21:                               ; preds = %if.then83.21
  %465 = add nsw i64 %460, %indvars.iv.21
  %arrayidx97.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %465
  %466 = load i32, i32* %arrayidx97.21, align 4
  %cmp98.21 = icmp eq i32 %466, 255
  br i1 %cmp98.21, label %if.then151.21, label %lor.lhs.false100.21

lor.lhs.false100.21:                              ; preds = %lor.lhs.false92.21
  %add104.21 = add i32 %sub86.21, -127
  %idxprom105.21 = sext i32 %add104.21 to i64
  %arrayidx106.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.21
  %467 = load i32, i32* %arrayidx106.21, align 4
  %cmp107.21 = icmp eq i32 %467, 255
  br i1 %cmp107.21, label %if.then151.21, label %lor.lhs.false109.21

lor.lhs.false109.21:                              ; preds = %lor.lhs.false100.21
  %468 = trunc i64 %indvars.iv.21 to i32
  %add112.21 = add i32 %sub111.21, %468
  %idxprom113.21 = sext i32 %add112.21 to i64
  %arrayidx114.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.21
  %469 = load i32, i32* %arrayidx114.21, align 4
  %cmp115.21 = icmp eq i32 %469, 255
  br i1 %cmp115.21, label %if.then151.21, label %lor.lhs.false117.21

lor.lhs.false117.21:                              ; preds = %lor.lhs.false109.21
  %470 = trunc i64 %indvars.iv.21 to i32
  %add120.21 = add i32 %add119.21, %470
  %idxprom121.21 = sext i32 %add120.21 to i64
  %arrayidx122.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.21
  %471 = load i32, i32* %arrayidx122.21, align 4
  %cmp123.21 = icmp eq i32 %471, 255
  br i1 %cmp123.21, label %if.then151.21, label %lor.lhs.false125.21

lor.lhs.false125.21:                              ; preds = %lor.lhs.false117.21
  %add129.21 = add i32 %sub86.21, 127
  %idxprom130.21 = sext i32 %add129.21 to i64
  %arrayidx131.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.21
  %472 = load i32, i32* %arrayidx131.21, align 4
  %cmp132.21 = icmp eq i32 %472, 255
  br i1 %cmp132.21, label %if.then151.21, label %lor.lhs.false134.21

lor.lhs.false134.21:                              ; preds = %lor.lhs.false125.21
  %473 = add nsw i64 %459, %indvars.iv.21
  %arrayidx139.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %473
  %474 = load i32, i32* %arrayidx139.21, align 4
  %cmp140.21 = icmp eq i32 %474, 255
  br i1 %cmp140.21, label %if.then151.21, label %lor.lhs.false142.21

lor.lhs.false142.21:                              ; preds = %lor.lhs.false134.21
  %add146.21 = add i32 %sub86.21, 129
  %idxprom147.21 = sext i32 %add146.21 to i64
  %arrayidx148.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.21
  %475 = load i32, i32* %arrayidx148.21, align 4
  %cmp149.21 = icmp eq i32 %475, 255
  br i1 %cmp149.21, label %if.then151.21, label %if.else154.21

if.else154.21:                                    ; preds = %lor.lhs.false142.21
  %arrayidx156.21 = getelementptr inbounds i8, i8* %., i64 %461
  store i8 0, i8* %arrayidx156.21, align 1
  br label %for.inc166.21

if.then151.21:                                    ; preds = %lor.lhs.false142.21, %lor.lhs.false134.21, %lor.lhs.false125.21, %lor.lhs.false117.21, %lor.lhs.false109.21, %lor.lhs.false100.21, %lor.lhs.false92.21, %if.then83.21
  %arrayidx153.21 = getelementptr inbounds i8, i8* %., i64 %461
  store i8 -1, i8* %arrayidx153.21, align 1
  br label %for.inc166.21

if.then75.21:                                     ; preds = %for.body61.21
  %arrayidx77.21 = getelementptr inbounds i8, i8* %., i64 %461
  store i8 0, i8* %arrayidx77.21, align 1
  br label %for.inc166.21

for.inc166.21:                                    ; preds = %if.then75.21, %if.then151.21, %if.else154.21, %if.else158.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %img_width
  br i1 %exitcond.21, label %for.inc169.21, label %for.body61.21, !llvm.loop !5

for.inc169.21:                                    ; preds = %for.inc166.21
  %indvars.iv.next20.21 = add nsw i64 %indvars.iv19, 22
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.22

for.body61.lr.ph.22:                              ; preds = %for.inc169.21
  %476 = trunc i64 %indvars.iv.next20.21 to i32
  %mul63.22 = shl nsw i32 %476, 7
  %cmp67.22 = icmp eq i64 %indvars.iv.next20.21, %11
  %477 = trunc i64 %indvars.iv.next20.21 to i32
  %sub84.22 = shl i32 %477, 7
  %mul94.22 = add i32 %sub84.22, -128
  %sub111.22 = add i32 %mul63.22, -1
  %add119.22 = or i32 %mul63.22, 1
  %mul136.22 = add i32 %sub84.22, 128
  %478 = sext i32 %mul63.22 to i64
  %479 = sext i32 %mul136.22 to i64
  %480 = sext i32 %mul94.22 to i64
  br label %for.body61.22

for.body61.22:                                    ; preds = %for.inc166.22, %for.body61.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body61.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc166.22 ]
  %481 = add nsw i64 %indvars.iv.22, %478
  %cmp70.22 = icmp eq i64 %indvars.iv.22, 0
  %or.cond1.22 = or i1 %cmp67.22, %cmp70.22
  %cmp73.22 = icmp eq i64 %indvars.iv.22, %10
  %or.cond2.22 = or i1 %cmp73.22, %or.cond1.22
  br i1 %or.cond2.22, label %if.then75.22, label %if.else78.22

if.else78.22:                                     ; preds = %for.body61.22
  %arrayidx80.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %481
  %482 = load i32, i32* %arrayidx80.22, align 4
  %cmp81.22 = icmp eq i32 %482, 75
  br i1 %cmp81.22, label %if.then83.22, label %if.else158.22

if.else158.22:                                    ; preds = %if.else78.22
  %conv161.22 = trunc i32 %482 to i8
  %arrayidx163.22 = getelementptr inbounds i8, i8* %., i64 %481
  store i8 %conv161.22, i8* %arrayidx163.22, align 1
  br label %for.inc166.22

if.then83.22:                                     ; preds = %if.else78.22
  %483 = trunc i64 %indvars.iv.22 to i32
  %sub86.22 = add i32 %483, %sub84.22
  %add87.22 = add i32 %sub86.22, -129
  %idxprom88.22 = sext i32 %add87.22 to i64
  %arrayidx89.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.22
  %484 = load i32, i32* %arrayidx89.22, align 4
  %cmp90.22 = icmp eq i32 %484, 255
  br i1 %cmp90.22, label %if.then151.22, label %lor.lhs.false92.22

lor.lhs.false92.22:                               ; preds = %if.then83.22
  %485 = add nsw i64 %480, %indvars.iv.22
  %arrayidx97.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %485
  %486 = load i32, i32* %arrayidx97.22, align 4
  %cmp98.22 = icmp eq i32 %486, 255
  br i1 %cmp98.22, label %if.then151.22, label %lor.lhs.false100.22

lor.lhs.false100.22:                              ; preds = %lor.lhs.false92.22
  %add104.22 = add i32 %sub86.22, -127
  %idxprom105.22 = sext i32 %add104.22 to i64
  %arrayidx106.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.22
  %487 = load i32, i32* %arrayidx106.22, align 4
  %cmp107.22 = icmp eq i32 %487, 255
  br i1 %cmp107.22, label %if.then151.22, label %lor.lhs.false109.22

lor.lhs.false109.22:                              ; preds = %lor.lhs.false100.22
  %488 = trunc i64 %indvars.iv.22 to i32
  %add112.22 = add i32 %sub111.22, %488
  %idxprom113.22 = sext i32 %add112.22 to i64
  %arrayidx114.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.22
  %489 = load i32, i32* %arrayidx114.22, align 4
  %cmp115.22 = icmp eq i32 %489, 255
  br i1 %cmp115.22, label %if.then151.22, label %lor.lhs.false117.22

lor.lhs.false117.22:                              ; preds = %lor.lhs.false109.22
  %490 = trunc i64 %indvars.iv.22 to i32
  %add120.22 = add i32 %add119.22, %490
  %idxprom121.22 = sext i32 %add120.22 to i64
  %arrayidx122.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.22
  %491 = load i32, i32* %arrayidx122.22, align 4
  %cmp123.22 = icmp eq i32 %491, 255
  br i1 %cmp123.22, label %if.then151.22, label %lor.lhs.false125.22

lor.lhs.false125.22:                              ; preds = %lor.lhs.false117.22
  %add129.22 = add i32 %sub86.22, 127
  %idxprom130.22 = sext i32 %add129.22 to i64
  %arrayidx131.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.22
  %492 = load i32, i32* %arrayidx131.22, align 4
  %cmp132.22 = icmp eq i32 %492, 255
  br i1 %cmp132.22, label %if.then151.22, label %lor.lhs.false134.22

lor.lhs.false134.22:                              ; preds = %lor.lhs.false125.22
  %493 = add nsw i64 %479, %indvars.iv.22
  %arrayidx139.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %493
  %494 = load i32, i32* %arrayidx139.22, align 4
  %cmp140.22 = icmp eq i32 %494, 255
  br i1 %cmp140.22, label %if.then151.22, label %lor.lhs.false142.22

lor.lhs.false142.22:                              ; preds = %lor.lhs.false134.22
  %add146.22 = add i32 %sub86.22, 129
  %idxprom147.22 = sext i32 %add146.22 to i64
  %arrayidx148.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.22
  %495 = load i32, i32* %arrayidx148.22, align 4
  %cmp149.22 = icmp eq i32 %495, 255
  br i1 %cmp149.22, label %if.then151.22, label %if.else154.22

if.else154.22:                                    ; preds = %lor.lhs.false142.22
  %arrayidx156.22 = getelementptr inbounds i8, i8* %., i64 %481
  store i8 0, i8* %arrayidx156.22, align 1
  br label %for.inc166.22

if.then151.22:                                    ; preds = %lor.lhs.false142.22, %lor.lhs.false134.22, %lor.lhs.false125.22, %lor.lhs.false117.22, %lor.lhs.false109.22, %lor.lhs.false100.22, %lor.lhs.false92.22, %if.then83.22
  %arrayidx153.22 = getelementptr inbounds i8, i8* %., i64 %481
  store i8 -1, i8* %arrayidx153.22, align 1
  br label %for.inc166.22

if.then75.22:                                     ; preds = %for.body61.22
  %arrayidx77.22 = getelementptr inbounds i8, i8* %., i64 %481
  store i8 0, i8* %arrayidx77.22, align 1
  br label %for.inc166.22

for.inc166.22:                                    ; preds = %if.then75.22, %if.then151.22, %if.else154.22, %if.else158.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %img_width
  br i1 %exitcond.22, label %for.inc169.22, label %for.body61.22, !llvm.loop !5

for.inc169.22:                                    ; preds = %for.inc166.22
  %indvars.iv.next20.22 = add nsw i64 %indvars.iv19, 23
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.23

for.body61.lr.ph.23:                              ; preds = %for.inc169.22
  %496 = trunc i64 %indvars.iv.next20.22 to i32
  %mul63.23 = shl nsw i32 %496, 7
  %cmp67.23 = icmp eq i64 %indvars.iv.next20.22, %11
  %497 = trunc i64 %indvars.iv.next20.22 to i32
  %sub84.23 = shl i32 %497, 7
  %mul94.23 = add i32 %sub84.23, -128
  %sub111.23 = add i32 %mul63.23, -1
  %add119.23 = or i32 %mul63.23, 1
  %mul136.23 = add i32 %sub84.23, 128
  %498 = sext i32 %mul63.23 to i64
  %499 = sext i32 %mul136.23 to i64
  %500 = sext i32 %mul94.23 to i64
  br label %for.body61.23

for.body61.23:                                    ; preds = %for.inc166.23, %for.body61.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body61.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc166.23 ]
  %501 = add nsw i64 %indvars.iv.23, %498
  %cmp70.23 = icmp eq i64 %indvars.iv.23, 0
  %or.cond1.23 = or i1 %cmp67.23, %cmp70.23
  %cmp73.23 = icmp eq i64 %indvars.iv.23, %10
  %or.cond2.23 = or i1 %cmp73.23, %or.cond1.23
  br i1 %or.cond2.23, label %if.then75.23, label %if.else78.23

if.else78.23:                                     ; preds = %for.body61.23
  %arrayidx80.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %501
  %502 = load i32, i32* %arrayidx80.23, align 4
  %cmp81.23 = icmp eq i32 %502, 75
  br i1 %cmp81.23, label %if.then83.23, label %if.else158.23

if.else158.23:                                    ; preds = %if.else78.23
  %conv161.23 = trunc i32 %502 to i8
  %arrayidx163.23 = getelementptr inbounds i8, i8* %., i64 %501
  store i8 %conv161.23, i8* %arrayidx163.23, align 1
  br label %for.inc166.23

if.then83.23:                                     ; preds = %if.else78.23
  %503 = trunc i64 %indvars.iv.23 to i32
  %sub86.23 = add i32 %503, %sub84.23
  %add87.23 = add i32 %sub86.23, -129
  %idxprom88.23 = sext i32 %add87.23 to i64
  %arrayidx89.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.23
  %504 = load i32, i32* %arrayidx89.23, align 4
  %cmp90.23 = icmp eq i32 %504, 255
  br i1 %cmp90.23, label %if.then151.23, label %lor.lhs.false92.23

lor.lhs.false92.23:                               ; preds = %if.then83.23
  %505 = add nsw i64 %500, %indvars.iv.23
  %arrayidx97.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %505
  %506 = load i32, i32* %arrayidx97.23, align 4
  %cmp98.23 = icmp eq i32 %506, 255
  br i1 %cmp98.23, label %if.then151.23, label %lor.lhs.false100.23

lor.lhs.false100.23:                              ; preds = %lor.lhs.false92.23
  %add104.23 = add i32 %sub86.23, -127
  %idxprom105.23 = sext i32 %add104.23 to i64
  %arrayidx106.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.23
  %507 = load i32, i32* %arrayidx106.23, align 4
  %cmp107.23 = icmp eq i32 %507, 255
  br i1 %cmp107.23, label %if.then151.23, label %lor.lhs.false109.23

lor.lhs.false109.23:                              ; preds = %lor.lhs.false100.23
  %508 = trunc i64 %indvars.iv.23 to i32
  %add112.23 = add i32 %sub111.23, %508
  %idxprom113.23 = sext i32 %add112.23 to i64
  %arrayidx114.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.23
  %509 = load i32, i32* %arrayidx114.23, align 4
  %cmp115.23 = icmp eq i32 %509, 255
  br i1 %cmp115.23, label %if.then151.23, label %lor.lhs.false117.23

lor.lhs.false117.23:                              ; preds = %lor.lhs.false109.23
  %510 = trunc i64 %indvars.iv.23 to i32
  %add120.23 = add i32 %add119.23, %510
  %idxprom121.23 = sext i32 %add120.23 to i64
  %arrayidx122.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.23
  %511 = load i32, i32* %arrayidx122.23, align 4
  %cmp123.23 = icmp eq i32 %511, 255
  br i1 %cmp123.23, label %if.then151.23, label %lor.lhs.false125.23

lor.lhs.false125.23:                              ; preds = %lor.lhs.false117.23
  %add129.23 = add i32 %sub86.23, 127
  %idxprom130.23 = sext i32 %add129.23 to i64
  %arrayidx131.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.23
  %512 = load i32, i32* %arrayidx131.23, align 4
  %cmp132.23 = icmp eq i32 %512, 255
  br i1 %cmp132.23, label %if.then151.23, label %lor.lhs.false134.23

lor.lhs.false134.23:                              ; preds = %lor.lhs.false125.23
  %513 = add nsw i64 %499, %indvars.iv.23
  %arrayidx139.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %513
  %514 = load i32, i32* %arrayidx139.23, align 4
  %cmp140.23 = icmp eq i32 %514, 255
  br i1 %cmp140.23, label %if.then151.23, label %lor.lhs.false142.23

lor.lhs.false142.23:                              ; preds = %lor.lhs.false134.23
  %add146.23 = add i32 %sub86.23, 129
  %idxprom147.23 = sext i32 %add146.23 to i64
  %arrayidx148.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.23
  %515 = load i32, i32* %arrayidx148.23, align 4
  %cmp149.23 = icmp eq i32 %515, 255
  br i1 %cmp149.23, label %if.then151.23, label %if.else154.23

if.else154.23:                                    ; preds = %lor.lhs.false142.23
  %arrayidx156.23 = getelementptr inbounds i8, i8* %., i64 %501
  store i8 0, i8* %arrayidx156.23, align 1
  br label %for.inc166.23

if.then151.23:                                    ; preds = %lor.lhs.false142.23, %lor.lhs.false134.23, %lor.lhs.false125.23, %lor.lhs.false117.23, %lor.lhs.false109.23, %lor.lhs.false100.23, %lor.lhs.false92.23, %if.then83.23
  %arrayidx153.23 = getelementptr inbounds i8, i8* %., i64 %501
  store i8 -1, i8* %arrayidx153.23, align 1
  br label %for.inc166.23

if.then75.23:                                     ; preds = %for.body61.23
  %arrayidx77.23 = getelementptr inbounds i8, i8* %., i64 %501
  store i8 0, i8* %arrayidx77.23, align 1
  br label %for.inc166.23

for.inc166.23:                                    ; preds = %if.then75.23, %if.then151.23, %if.else154.23, %if.else158.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %img_width
  br i1 %exitcond.23, label %for.inc169.23, label %for.body61.23, !llvm.loop !5

for.inc169.23:                                    ; preds = %for.inc166.23
  %indvars.iv.next20.23 = add nsw i64 %indvars.iv19, 24
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.24

for.body61.lr.ph.24:                              ; preds = %for.inc169.23
  %516 = trunc i64 %indvars.iv.next20.23 to i32
  %mul63.24 = shl nsw i32 %516, 7
  %cmp67.24 = icmp eq i64 %indvars.iv.next20.23, %11
  %517 = trunc i64 %indvars.iv.next20.23 to i32
  %sub84.24 = shl i32 %517, 7
  %mul94.24 = add i32 %sub84.24, -128
  %sub111.24 = add i32 %mul63.24, -1
  %add119.24 = or i32 %mul63.24, 1
  %mul136.24 = add i32 %sub84.24, 128
  %518 = sext i32 %mul63.24 to i64
  %519 = sext i32 %mul136.24 to i64
  %520 = sext i32 %mul94.24 to i64
  br label %for.body61.24

for.body61.24:                                    ; preds = %for.inc166.24, %for.body61.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body61.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc166.24 ]
  %521 = add nsw i64 %indvars.iv.24, %518
  %cmp70.24 = icmp eq i64 %indvars.iv.24, 0
  %or.cond1.24 = or i1 %cmp67.24, %cmp70.24
  %cmp73.24 = icmp eq i64 %indvars.iv.24, %10
  %or.cond2.24 = or i1 %cmp73.24, %or.cond1.24
  br i1 %or.cond2.24, label %if.then75.24, label %if.else78.24

if.else78.24:                                     ; preds = %for.body61.24
  %arrayidx80.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %521
  %522 = load i32, i32* %arrayidx80.24, align 4
  %cmp81.24 = icmp eq i32 %522, 75
  br i1 %cmp81.24, label %if.then83.24, label %if.else158.24

if.else158.24:                                    ; preds = %if.else78.24
  %conv161.24 = trunc i32 %522 to i8
  %arrayidx163.24 = getelementptr inbounds i8, i8* %., i64 %521
  store i8 %conv161.24, i8* %arrayidx163.24, align 1
  br label %for.inc166.24

if.then83.24:                                     ; preds = %if.else78.24
  %523 = trunc i64 %indvars.iv.24 to i32
  %sub86.24 = add i32 %523, %sub84.24
  %add87.24 = add i32 %sub86.24, -129
  %idxprom88.24 = sext i32 %add87.24 to i64
  %arrayidx89.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.24
  %524 = load i32, i32* %arrayidx89.24, align 4
  %cmp90.24 = icmp eq i32 %524, 255
  br i1 %cmp90.24, label %if.then151.24, label %lor.lhs.false92.24

lor.lhs.false92.24:                               ; preds = %if.then83.24
  %525 = add nsw i64 %520, %indvars.iv.24
  %arrayidx97.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %525
  %526 = load i32, i32* %arrayidx97.24, align 4
  %cmp98.24 = icmp eq i32 %526, 255
  br i1 %cmp98.24, label %if.then151.24, label %lor.lhs.false100.24

lor.lhs.false100.24:                              ; preds = %lor.lhs.false92.24
  %add104.24 = add i32 %sub86.24, -127
  %idxprom105.24 = sext i32 %add104.24 to i64
  %arrayidx106.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.24
  %527 = load i32, i32* %arrayidx106.24, align 4
  %cmp107.24 = icmp eq i32 %527, 255
  br i1 %cmp107.24, label %if.then151.24, label %lor.lhs.false109.24

lor.lhs.false109.24:                              ; preds = %lor.lhs.false100.24
  %528 = trunc i64 %indvars.iv.24 to i32
  %add112.24 = add i32 %sub111.24, %528
  %idxprom113.24 = sext i32 %add112.24 to i64
  %arrayidx114.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.24
  %529 = load i32, i32* %arrayidx114.24, align 4
  %cmp115.24 = icmp eq i32 %529, 255
  br i1 %cmp115.24, label %if.then151.24, label %lor.lhs.false117.24

lor.lhs.false117.24:                              ; preds = %lor.lhs.false109.24
  %530 = trunc i64 %indvars.iv.24 to i32
  %add120.24 = add i32 %add119.24, %530
  %idxprom121.24 = sext i32 %add120.24 to i64
  %arrayidx122.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.24
  %531 = load i32, i32* %arrayidx122.24, align 4
  %cmp123.24 = icmp eq i32 %531, 255
  br i1 %cmp123.24, label %if.then151.24, label %lor.lhs.false125.24

lor.lhs.false125.24:                              ; preds = %lor.lhs.false117.24
  %add129.24 = add i32 %sub86.24, 127
  %idxprom130.24 = sext i32 %add129.24 to i64
  %arrayidx131.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.24
  %532 = load i32, i32* %arrayidx131.24, align 4
  %cmp132.24 = icmp eq i32 %532, 255
  br i1 %cmp132.24, label %if.then151.24, label %lor.lhs.false134.24

lor.lhs.false134.24:                              ; preds = %lor.lhs.false125.24
  %533 = add nsw i64 %519, %indvars.iv.24
  %arrayidx139.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %533
  %534 = load i32, i32* %arrayidx139.24, align 4
  %cmp140.24 = icmp eq i32 %534, 255
  br i1 %cmp140.24, label %if.then151.24, label %lor.lhs.false142.24

lor.lhs.false142.24:                              ; preds = %lor.lhs.false134.24
  %add146.24 = add i32 %sub86.24, 129
  %idxprom147.24 = sext i32 %add146.24 to i64
  %arrayidx148.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.24
  %535 = load i32, i32* %arrayidx148.24, align 4
  %cmp149.24 = icmp eq i32 %535, 255
  br i1 %cmp149.24, label %if.then151.24, label %if.else154.24

if.else154.24:                                    ; preds = %lor.lhs.false142.24
  %arrayidx156.24 = getelementptr inbounds i8, i8* %., i64 %521
  store i8 0, i8* %arrayidx156.24, align 1
  br label %for.inc166.24

if.then151.24:                                    ; preds = %lor.lhs.false142.24, %lor.lhs.false134.24, %lor.lhs.false125.24, %lor.lhs.false117.24, %lor.lhs.false109.24, %lor.lhs.false100.24, %lor.lhs.false92.24, %if.then83.24
  %arrayidx153.24 = getelementptr inbounds i8, i8* %., i64 %521
  store i8 -1, i8* %arrayidx153.24, align 1
  br label %for.inc166.24

if.then75.24:                                     ; preds = %for.body61.24
  %arrayidx77.24 = getelementptr inbounds i8, i8* %., i64 %521
  store i8 0, i8* %arrayidx77.24, align 1
  br label %for.inc166.24

for.inc166.24:                                    ; preds = %if.then75.24, %if.then151.24, %if.else154.24, %if.else158.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %img_width
  br i1 %exitcond.24, label %for.inc169.24, label %for.body61.24, !llvm.loop !5

for.inc169.24:                                    ; preds = %for.inc166.24
  %indvars.iv.next20.24 = add nsw i64 %indvars.iv19, 25
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.25

for.body61.lr.ph.25:                              ; preds = %for.inc169.24
  %536 = trunc i64 %indvars.iv.next20.24 to i32
  %mul63.25 = shl nsw i32 %536, 7
  %cmp67.25 = icmp eq i64 %indvars.iv.next20.24, %11
  %537 = trunc i64 %indvars.iv.next20.24 to i32
  %sub84.25 = shl i32 %537, 7
  %mul94.25 = add i32 %sub84.25, -128
  %sub111.25 = add i32 %mul63.25, -1
  %add119.25 = or i32 %mul63.25, 1
  %mul136.25 = add i32 %sub84.25, 128
  %538 = sext i32 %mul63.25 to i64
  %539 = sext i32 %mul136.25 to i64
  %540 = sext i32 %mul94.25 to i64
  br label %for.body61.25

for.body61.25:                                    ; preds = %for.inc166.25, %for.body61.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body61.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc166.25 ]
  %541 = add nsw i64 %indvars.iv.25, %538
  %cmp70.25 = icmp eq i64 %indvars.iv.25, 0
  %or.cond1.25 = or i1 %cmp67.25, %cmp70.25
  %cmp73.25 = icmp eq i64 %indvars.iv.25, %10
  %or.cond2.25 = or i1 %cmp73.25, %or.cond1.25
  br i1 %or.cond2.25, label %if.then75.25, label %if.else78.25

if.else78.25:                                     ; preds = %for.body61.25
  %arrayidx80.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %541
  %542 = load i32, i32* %arrayidx80.25, align 4
  %cmp81.25 = icmp eq i32 %542, 75
  br i1 %cmp81.25, label %if.then83.25, label %if.else158.25

if.else158.25:                                    ; preds = %if.else78.25
  %conv161.25 = trunc i32 %542 to i8
  %arrayidx163.25 = getelementptr inbounds i8, i8* %., i64 %541
  store i8 %conv161.25, i8* %arrayidx163.25, align 1
  br label %for.inc166.25

if.then83.25:                                     ; preds = %if.else78.25
  %543 = trunc i64 %indvars.iv.25 to i32
  %sub86.25 = add i32 %543, %sub84.25
  %add87.25 = add i32 %sub86.25, -129
  %idxprom88.25 = sext i32 %add87.25 to i64
  %arrayidx89.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.25
  %544 = load i32, i32* %arrayidx89.25, align 4
  %cmp90.25 = icmp eq i32 %544, 255
  br i1 %cmp90.25, label %if.then151.25, label %lor.lhs.false92.25

lor.lhs.false92.25:                               ; preds = %if.then83.25
  %545 = add nsw i64 %540, %indvars.iv.25
  %arrayidx97.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %545
  %546 = load i32, i32* %arrayidx97.25, align 4
  %cmp98.25 = icmp eq i32 %546, 255
  br i1 %cmp98.25, label %if.then151.25, label %lor.lhs.false100.25

lor.lhs.false100.25:                              ; preds = %lor.lhs.false92.25
  %add104.25 = add i32 %sub86.25, -127
  %idxprom105.25 = sext i32 %add104.25 to i64
  %arrayidx106.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.25
  %547 = load i32, i32* %arrayidx106.25, align 4
  %cmp107.25 = icmp eq i32 %547, 255
  br i1 %cmp107.25, label %if.then151.25, label %lor.lhs.false109.25

lor.lhs.false109.25:                              ; preds = %lor.lhs.false100.25
  %548 = trunc i64 %indvars.iv.25 to i32
  %add112.25 = add i32 %sub111.25, %548
  %idxprom113.25 = sext i32 %add112.25 to i64
  %arrayidx114.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.25
  %549 = load i32, i32* %arrayidx114.25, align 4
  %cmp115.25 = icmp eq i32 %549, 255
  br i1 %cmp115.25, label %if.then151.25, label %lor.lhs.false117.25

lor.lhs.false117.25:                              ; preds = %lor.lhs.false109.25
  %550 = trunc i64 %indvars.iv.25 to i32
  %add120.25 = add i32 %add119.25, %550
  %idxprom121.25 = sext i32 %add120.25 to i64
  %arrayidx122.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.25
  %551 = load i32, i32* %arrayidx122.25, align 4
  %cmp123.25 = icmp eq i32 %551, 255
  br i1 %cmp123.25, label %if.then151.25, label %lor.lhs.false125.25

lor.lhs.false125.25:                              ; preds = %lor.lhs.false117.25
  %add129.25 = add i32 %sub86.25, 127
  %idxprom130.25 = sext i32 %add129.25 to i64
  %arrayidx131.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.25
  %552 = load i32, i32* %arrayidx131.25, align 4
  %cmp132.25 = icmp eq i32 %552, 255
  br i1 %cmp132.25, label %if.then151.25, label %lor.lhs.false134.25

lor.lhs.false134.25:                              ; preds = %lor.lhs.false125.25
  %553 = add nsw i64 %539, %indvars.iv.25
  %arrayidx139.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %553
  %554 = load i32, i32* %arrayidx139.25, align 4
  %cmp140.25 = icmp eq i32 %554, 255
  br i1 %cmp140.25, label %if.then151.25, label %lor.lhs.false142.25

lor.lhs.false142.25:                              ; preds = %lor.lhs.false134.25
  %add146.25 = add i32 %sub86.25, 129
  %idxprom147.25 = sext i32 %add146.25 to i64
  %arrayidx148.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.25
  %555 = load i32, i32* %arrayidx148.25, align 4
  %cmp149.25 = icmp eq i32 %555, 255
  br i1 %cmp149.25, label %if.then151.25, label %if.else154.25

if.else154.25:                                    ; preds = %lor.lhs.false142.25
  %arrayidx156.25 = getelementptr inbounds i8, i8* %., i64 %541
  store i8 0, i8* %arrayidx156.25, align 1
  br label %for.inc166.25

if.then151.25:                                    ; preds = %lor.lhs.false142.25, %lor.lhs.false134.25, %lor.lhs.false125.25, %lor.lhs.false117.25, %lor.lhs.false109.25, %lor.lhs.false100.25, %lor.lhs.false92.25, %if.then83.25
  %arrayidx153.25 = getelementptr inbounds i8, i8* %., i64 %541
  store i8 -1, i8* %arrayidx153.25, align 1
  br label %for.inc166.25

if.then75.25:                                     ; preds = %for.body61.25
  %arrayidx77.25 = getelementptr inbounds i8, i8* %., i64 %541
  store i8 0, i8* %arrayidx77.25, align 1
  br label %for.inc166.25

for.inc166.25:                                    ; preds = %if.then75.25, %if.then151.25, %if.else154.25, %if.else158.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %img_width
  br i1 %exitcond.25, label %for.inc169.25, label %for.body61.25, !llvm.loop !5

for.inc169.25:                                    ; preds = %for.inc166.25
  %indvars.iv.next20.25 = add nsw i64 %indvars.iv19, 26
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.26

for.body61.lr.ph.26:                              ; preds = %for.inc169.25
  %556 = trunc i64 %indvars.iv.next20.25 to i32
  %mul63.26 = shl nsw i32 %556, 7
  %cmp67.26 = icmp eq i64 %indvars.iv.next20.25, %11
  %557 = trunc i64 %indvars.iv.next20.25 to i32
  %sub84.26 = shl i32 %557, 7
  %mul94.26 = add i32 %sub84.26, -128
  %sub111.26 = add i32 %mul63.26, -1
  %add119.26 = or i32 %mul63.26, 1
  %mul136.26 = add i32 %sub84.26, 128
  %558 = sext i32 %mul63.26 to i64
  %559 = sext i32 %mul136.26 to i64
  %560 = sext i32 %mul94.26 to i64
  br label %for.body61.26

for.body61.26:                                    ; preds = %for.inc166.26, %for.body61.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body61.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc166.26 ]
  %561 = add nsw i64 %indvars.iv.26, %558
  %cmp70.26 = icmp eq i64 %indvars.iv.26, 0
  %or.cond1.26 = or i1 %cmp67.26, %cmp70.26
  %cmp73.26 = icmp eq i64 %indvars.iv.26, %10
  %or.cond2.26 = or i1 %cmp73.26, %or.cond1.26
  br i1 %or.cond2.26, label %if.then75.26, label %if.else78.26

if.else78.26:                                     ; preds = %for.body61.26
  %arrayidx80.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %561
  %562 = load i32, i32* %arrayidx80.26, align 4
  %cmp81.26 = icmp eq i32 %562, 75
  br i1 %cmp81.26, label %if.then83.26, label %if.else158.26

if.else158.26:                                    ; preds = %if.else78.26
  %conv161.26 = trunc i32 %562 to i8
  %arrayidx163.26 = getelementptr inbounds i8, i8* %., i64 %561
  store i8 %conv161.26, i8* %arrayidx163.26, align 1
  br label %for.inc166.26

if.then83.26:                                     ; preds = %if.else78.26
  %563 = trunc i64 %indvars.iv.26 to i32
  %sub86.26 = add i32 %563, %sub84.26
  %add87.26 = add i32 %sub86.26, -129
  %idxprom88.26 = sext i32 %add87.26 to i64
  %arrayidx89.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.26
  %564 = load i32, i32* %arrayidx89.26, align 4
  %cmp90.26 = icmp eq i32 %564, 255
  br i1 %cmp90.26, label %if.then151.26, label %lor.lhs.false92.26

lor.lhs.false92.26:                               ; preds = %if.then83.26
  %565 = add nsw i64 %560, %indvars.iv.26
  %arrayidx97.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %565
  %566 = load i32, i32* %arrayidx97.26, align 4
  %cmp98.26 = icmp eq i32 %566, 255
  br i1 %cmp98.26, label %if.then151.26, label %lor.lhs.false100.26

lor.lhs.false100.26:                              ; preds = %lor.lhs.false92.26
  %add104.26 = add i32 %sub86.26, -127
  %idxprom105.26 = sext i32 %add104.26 to i64
  %arrayidx106.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.26
  %567 = load i32, i32* %arrayidx106.26, align 4
  %cmp107.26 = icmp eq i32 %567, 255
  br i1 %cmp107.26, label %if.then151.26, label %lor.lhs.false109.26

lor.lhs.false109.26:                              ; preds = %lor.lhs.false100.26
  %568 = trunc i64 %indvars.iv.26 to i32
  %add112.26 = add i32 %sub111.26, %568
  %idxprom113.26 = sext i32 %add112.26 to i64
  %arrayidx114.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.26
  %569 = load i32, i32* %arrayidx114.26, align 4
  %cmp115.26 = icmp eq i32 %569, 255
  br i1 %cmp115.26, label %if.then151.26, label %lor.lhs.false117.26

lor.lhs.false117.26:                              ; preds = %lor.lhs.false109.26
  %570 = trunc i64 %indvars.iv.26 to i32
  %add120.26 = add i32 %add119.26, %570
  %idxprom121.26 = sext i32 %add120.26 to i64
  %arrayidx122.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.26
  %571 = load i32, i32* %arrayidx122.26, align 4
  %cmp123.26 = icmp eq i32 %571, 255
  br i1 %cmp123.26, label %if.then151.26, label %lor.lhs.false125.26

lor.lhs.false125.26:                              ; preds = %lor.lhs.false117.26
  %add129.26 = add i32 %sub86.26, 127
  %idxprom130.26 = sext i32 %add129.26 to i64
  %arrayidx131.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.26
  %572 = load i32, i32* %arrayidx131.26, align 4
  %cmp132.26 = icmp eq i32 %572, 255
  br i1 %cmp132.26, label %if.then151.26, label %lor.lhs.false134.26

lor.lhs.false134.26:                              ; preds = %lor.lhs.false125.26
  %573 = add nsw i64 %559, %indvars.iv.26
  %arrayidx139.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %573
  %574 = load i32, i32* %arrayidx139.26, align 4
  %cmp140.26 = icmp eq i32 %574, 255
  br i1 %cmp140.26, label %if.then151.26, label %lor.lhs.false142.26

lor.lhs.false142.26:                              ; preds = %lor.lhs.false134.26
  %add146.26 = add i32 %sub86.26, 129
  %idxprom147.26 = sext i32 %add146.26 to i64
  %arrayidx148.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.26
  %575 = load i32, i32* %arrayidx148.26, align 4
  %cmp149.26 = icmp eq i32 %575, 255
  br i1 %cmp149.26, label %if.then151.26, label %if.else154.26

if.else154.26:                                    ; preds = %lor.lhs.false142.26
  %arrayidx156.26 = getelementptr inbounds i8, i8* %., i64 %561
  store i8 0, i8* %arrayidx156.26, align 1
  br label %for.inc166.26

if.then151.26:                                    ; preds = %lor.lhs.false142.26, %lor.lhs.false134.26, %lor.lhs.false125.26, %lor.lhs.false117.26, %lor.lhs.false109.26, %lor.lhs.false100.26, %lor.lhs.false92.26, %if.then83.26
  %arrayidx153.26 = getelementptr inbounds i8, i8* %., i64 %561
  store i8 -1, i8* %arrayidx153.26, align 1
  br label %for.inc166.26

if.then75.26:                                     ; preds = %for.body61.26
  %arrayidx77.26 = getelementptr inbounds i8, i8* %., i64 %561
  store i8 0, i8* %arrayidx77.26, align 1
  br label %for.inc166.26

for.inc166.26:                                    ; preds = %if.then75.26, %if.then151.26, %if.else154.26, %if.else158.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %img_width
  br i1 %exitcond.26, label %for.inc169.26, label %for.body61.26, !llvm.loop !5

for.inc169.26:                                    ; preds = %for.inc166.26
  %indvars.iv.next20.26 = add nsw i64 %indvars.iv19, 27
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.27

for.body61.lr.ph.27:                              ; preds = %for.inc169.26
  %576 = trunc i64 %indvars.iv.next20.26 to i32
  %mul63.27 = shl nsw i32 %576, 7
  %cmp67.27 = icmp eq i64 %indvars.iv.next20.26, %11
  %577 = trunc i64 %indvars.iv.next20.26 to i32
  %sub84.27 = shl i32 %577, 7
  %mul94.27 = add i32 %sub84.27, -128
  %sub111.27 = add i32 %mul63.27, -1
  %add119.27 = or i32 %mul63.27, 1
  %mul136.27 = add i32 %sub84.27, 128
  %578 = sext i32 %mul63.27 to i64
  %579 = sext i32 %mul136.27 to i64
  %580 = sext i32 %mul94.27 to i64
  br label %for.body61.27

for.body61.27:                                    ; preds = %for.inc166.27, %for.body61.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body61.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc166.27 ]
  %581 = add nsw i64 %indvars.iv.27, %578
  %cmp70.27 = icmp eq i64 %indvars.iv.27, 0
  %or.cond1.27 = or i1 %cmp67.27, %cmp70.27
  %cmp73.27 = icmp eq i64 %indvars.iv.27, %10
  %or.cond2.27 = or i1 %cmp73.27, %or.cond1.27
  br i1 %or.cond2.27, label %if.then75.27, label %if.else78.27

if.else78.27:                                     ; preds = %for.body61.27
  %arrayidx80.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %581
  %582 = load i32, i32* %arrayidx80.27, align 4
  %cmp81.27 = icmp eq i32 %582, 75
  br i1 %cmp81.27, label %if.then83.27, label %if.else158.27

if.else158.27:                                    ; preds = %if.else78.27
  %conv161.27 = trunc i32 %582 to i8
  %arrayidx163.27 = getelementptr inbounds i8, i8* %., i64 %581
  store i8 %conv161.27, i8* %arrayidx163.27, align 1
  br label %for.inc166.27

if.then83.27:                                     ; preds = %if.else78.27
  %583 = trunc i64 %indvars.iv.27 to i32
  %sub86.27 = add i32 %583, %sub84.27
  %add87.27 = add i32 %sub86.27, -129
  %idxprom88.27 = sext i32 %add87.27 to i64
  %arrayidx89.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.27
  %584 = load i32, i32* %arrayidx89.27, align 4
  %cmp90.27 = icmp eq i32 %584, 255
  br i1 %cmp90.27, label %if.then151.27, label %lor.lhs.false92.27

lor.lhs.false92.27:                               ; preds = %if.then83.27
  %585 = add nsw i64 %580, %indvars.iv.27
  %arrayidx97.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %585
  %586 = load i32, i32* %arrayidx97.27, align 4
  %cmp98.27 = icmp eq i32 %586, 255
  br i1 %cmp98.27, label %if.then151.27, label %lor.lhs.false100.27

lor.lhs.false100.27:                              ; preds = %lor.lhs.false92.27
  %add104.27 = add i32 %sub86.27, -127
  %idxprom105.27 = sext i32 %add104.27 to i64
  %arrayidx106.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.27
  %587 = load i32, i32* %arrayidx106.27, align 4
  %cmp107.27 = icmp eq i32 %587, 255
  br i1 %cmp107.27, label %if.then151.27, label %lor.lhs.false109.27

lor.lhs.false109.27:                              ; preds = %lor.lhs.false100.27
  %588 = trunc i64 %indvars.iv.27 to i32
  %add112.27 = add i32 %sub111.27, %588
  %idxprom113.27 = sext i32 %add112.27 to i64
  %arrayidx114.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.27
  %589 = load i32, i32* %arrayidx114.27, align 4
  %cmp115.27 = icmp eq i32 %589, 255
  br i1 %cmp115.27, label %if.then151.27, label %lor.lhs.false117.27

lor.lhs.false117.27:                              ; preds = %lor.lhs.false109.27
  %590 = trunc i64 %indvars.iv.27 to i32
  %add120.27 = add i32 %add119.27, %590
  %idxprom121.27 = sext i32 %add120.27 to i64
  %arrayidx122.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.27
  %591 = load i32, i32* %arrayidx122.27, align 4
  %cmp123.27 = icmp eq i32 %591, 255
  br i1 %cmp123.27, label %if.then151.27, label %lor.lhs.false125.27

lor.lhs.false125.27:                              ; preds = %lor.lhs.false117.27
  %add129.27 = add i32 %sub86.27, 127
  %idxprom130.27 = sext i32 %add129.27 to i64
  %arrayidx131.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.27
  %592 = load i32, i32* %arrayidx131.27, align 4
  %cmp132.27 = icmp eq i32 %592, 255
  br i1 %cmp132.27, label %if.then151.27, label %lor.lhs.false134.27

lor.lhs.false134.27:                              ; preds = %lor.lhs.false125.27
  %593 = add nsw i64 %579, %indvars.iv.27
  %arrayidx139.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %593
  %594 = load i32, i32* %arrayidx139.27, align 4
  %cmp140.27 = icmp eq i32 %594, 255
  br i1 %cmp140.27, label %if.then151.27, label %lor.lhs.false142.27

lor.lhs.false142.27:                              ; preds = %lor.lhs.false134.27
  %add146.27 = add i32 %sub86.27, 129
  %idxprom147.27 = sext i32 %add146.27 to i64
  %arrayidx148.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.27
  %595 = load i32, i32* %arrayidx148.27, align 4
  %cmp149.27 = icmp eq i32 %595, 255
  br i1 %cmp149.27, label %if.then151.27, label %if.else154.27

if.else154.27:                                    ; preds = %lor.lhs.false142.27
  %arrayidx156.27 = getelementptr inbounds i8, i8* %., i64 %581
  store i8 0, i8* %arrayidx156.27, align 1
  br label %for.inc166.27

if.then151.27:                                    ; preds = %lor.lhs.false142.27, %lor.lhs.false134.27, %lor.lhs.false125.27, %lor.lhs.false117.27, %lor.lhs.false109.27, %lor.lhs.false100.27, %lor.lhs.false92.27, %if.then83.27
  %arrayidx153.27 = getelementptr inbounds i8, i8* %., i64 %581
  store i8 -1, i8* %arrayidx153.27, align 1
  br label %for.inc166.27

if.then75.27:                                     ; preds = %for.body61.27
  %arrayidx77.27 = getelementptr inbounds i8, i8* %., i64 %581
  store i8 0, i8* %arrayidx77.27, align 1
  br label %for.inc166.27

for.inc166.27:                                    ; preds = %if.then75.27, %if.then151.27, %if.else154.27, %if.else158.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %img_width
  br i1 %exitcond.27, label %for.inc169.27, label %for.body61.27, !llvm.loop !5

for.inc169.27:                                    ; preds = %for.inc166.27
  %indvars.iv.next20.27 = add nsw i64 %indvars.iv19, 28
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.28

for.body61.lr.ph.28:                              ; preds = %for.inc169.27
  %596 = trunc i64 %indvars.iv.next20.27 to i32
  %mul63.28 = shl nsw i32 %596, 7
  %cmp67.28 = icmp eq i64 %indvars.iv.next20.27, %11
  %597 = trunc i64 %indvars.iv.next20.27 to i32
  %sub84.28 = shl i32 %597, 7
  %mul94.28 = add i32 %sub84.28, -128
  %sub111.28 = add i32 %mul63.28, -1
  %add119.28 = or i32 %mul63.28, 1
  %mul136.28 = add i32 %sub84.28, 128
  %598 = sext i32 %mul63.28 to i64
  %599 = sext i32 %mul136.28 to i64
  %600 = sext i32 %mul94.28 to i64
  br label %for.body61.28

for.body61.28:                                    ; preds = %for.inc166.28, %for.body61.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body61.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc166.28 ]
  %601 = add nsw i64 %indvars.iv.28, %598
  %cmp70.28 = icmp eq i64 %indvars.iv.28, 0
  %or.cond1.28 = or i1 %cmp67.28, %cmp70.28
  %cmp73.28 = icmp eq i64 %indvars.iv.28, %10
  %or.cond2.28 = or i1 %cmp73.28, %or.cond1.28
  br i1 %or.cond2.28, label %if.then75.28, label %if.else78.28

if.else78.28:                                     ; preds = %for.body61.28
  %arrayidx80.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %601
  %602 = load i32, i32* %arrayidx80.28, align 4
  %cmp81.28 = icmp eq i32 %602, 75
  br i1 %cmp81.28, label %if.then83.28, label %if.else158.28

if.else158.28:                                    ; preds = %if.else78.28
  %conv161.28 = trunc i32 %602 to i8
  %arrayidx163.28 = getelementptr inbounds i8, i8* %., i64 %601
  store i8 %conv161.28, i8* %arrayidx163.28, align 1
  br label %for.inc166.28

if.then83.28:                                     ; preds = %if.else78.28
  %603 = trunc i64 %indvars.iv.28 to i32
  %sub86.28 = add i32 %603, %sub84.28
  %add87.28 = add i32 %sub86.28, -129
  %idxprom88.28 = sext i32 %add87.28 to i64
  %arrayidx89.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.28
  %604 = load i32, i32* %arrayidx89.28, align 4
  %cmp90.28 = icmp eq i32 %604, 255
  br i1 %cmp90.28, label %if.then151.28, label %lor.lhs.false92.28

lor.lhs.false92.28:                               ; preds = %if.then83.28
  %605 = add nsw i64 %600, %indvars.iv.28
  %arrayidx97.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %605
  %606 = load i32, i32* %arrayidx97.28, align 4
  %cmp98.28 = icmp eq i32 %606, 255
  br i1 %cmp98.28, label %if.then151.28, label %lor.lhs.false100.28

lor.lhs.false100.28:                              ; preds = %lor.lhs.false92.28
  %add104.28 = add i32 %sub86.28, -127
  %idxprom105.28 = sext i32 %add104.28 to i64
  %arrayidx106.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.28
  %607 = load i32, i32* %arrayidx106.28, align 4
  %cmp107.28 = icmp eq i32 %607, 255
  br i1 %cmp107.28, label %if.then151.28, label %lor.lhs.false109.28

lor.lhs.false109.28:                              ; preds = %lor.lhs.false100.28
  %608 = trunc i64 %indvars.iv.28 to i32
  %add112.28 = add i32 %sub111.28, %608
  %idxprom113.28 = sext i32 %add112.28 to i64
  %arrayidx114.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.28
  %609 = load i32, i32* %arrayidx114.28, align 4
  %cmp115.28 = icmp eq i32 %609, 255
  br i1 %cmp115.28, label %if.then151.28, label %lor.lhs.false117.28

lor.lhs.false117.28:                              ; preds = %lor.lhs.false109.28
  %610 = trunc i64 %indvars.iv.28 to i32
  %add120.28 = add i32 %add119.28, %610
  %idxprom121.28 = sext i32 %add120.28 to i64
  %arrayidx122.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.28
  %611 = load i32, i32* %arrayidx122.28, align 4
  %cmp123.28 = icmp eq i32 %611, 255
  br i1 %cmp123.28, label %if.then151.28, label %lor.lhs.false125.28

lor.lhs.false125.28:                              ; preds = %lor.lhs.false117.28
  %add129.28 = add i32 %sub86.28, 127
  %idxprom130.28 = sext i32 %add129.28 to i64
  %arrayidx131.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.28
  %612 = load i32, i32* %arrayidx131.28, align 4
  %cmp132.28 = icmp eq i32 %612, 255
  br i1 %cmp132.28, label %if.then151.28, label %lor.lhs.false134.28

lor.lhs.false134.28:                              ; preds = %lor.lhs.false125.28
  %613 = add nsw i64 %599, %indvars.iv.28
  %arrayidx139.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %613
  %614 = load i32, i32* %arrayidx139.28, align 4
  %cmp140.28 = icmp eq i32 %614, 255
  br i1 %cmp140.28, label %if.then151.28, label %lor.lhs.false142.28

lor.lhs.false142.28:                              ; preds = %lor.lhs.false134.28
  %add146.28 = add i32 %sub86.28, 129
  %idxprom147.28 = sext i32 %add146.28 to i64
  %arrayidx148.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.28
  %615 = load i32, i32* %arrayidx148.28, align 4
  %cmp149.28 = icmp eq i32 %615, 255
  br i1 %cmp149.28, label %if.then151.28, label %if.else154.28

if.else154.28:                                    ; preds = %lor.lhs.false142.28
  %arrayidx156.28 = getelementptr inbounds i8, i8* %., i64 %601
  store i8 0, i8* %arrayidx156.28, align 1
  br label %for.inc166.28

if.then151.28:                                    ; preds = %lor.lhs.false142.28, %lor.lhs.false134.28, %lor.lhs.false125.28, %lor.lhs.false117.28, %lor.lhs.false109.28, %lor.lhs.false100.28, %lor.lhs.false92.28, %if.then83.28
  %arrayidx153.28 = getelementptr inbounds i8, i8* %., i64 %601
  store i8 -1, i8* %arrayidx153.28, align 1
  br label %for.inc166.28

if.then75.28:                                     ; preds = %for.body61.28
  %arrayidx77.28 = getelementptr inbounds i8, i8* %., i64 %601
  store i8 0, i8* %arrayidx77.28, align 1
  br label %for.inc166.28

for.inc166.28:                                    ; preds = %if.then75.28, %if.then151.28, %if.else154.28, %if.else158.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %img_width
  br i1 %exitcond.28, label %for.inc169.28, label %for.body61.28, !llvm.loop !5

for.inc169.28:                                    ; preds = %for.inc166.28
  %indvars.iv.next20.28 = add nsw i64 %indvars.iv19, 29
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.29

for.body61.lr.ph.29:                              ; preds = %for.inc169.28
  %616 = trunc i64 %indvars.iv.next20.28 to i32
  %mul63.29 = shl nsw i32 %616, 7
  %cmp67.29 = icmp eq i64 %indvars.iv.next20.28, %11
  %617 = trunc i64 %indvars.iv.next20.28 to i32
  %sub84.29 = shl i32 %617, 7
  %mul94.29 = add i32 %sub84.29, -128
  %sub111.29 = add i32 %mul63.29, -1
  %add119.29 = or i32 %mul63.29, 1
  %mul136.29 = add i32 %sub84.29, 128
  %618 = sext i32 %mul63.29 to i64
  %619 = sext i32 %mul136.29 to i64
  %620 = sext i32 %mul94.29 to i64
  br label %for.body61.29

for.body61.29:                                    ; preds = %for.inc166.29, %for.body61.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body61.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc166.29 ]
  %621 = add nsw i64 %indvars.iv.29, %618
  %cmp70.29 = icmp eq i64 %indvars.iv.29, 0
  %or.cond1.29 = or i1 %cmp67.29, %cmp70.29
  %cmp73.29 = icmp eq i64 %indvars.iv.29, %10
  %or.cond2.29 = or i1 %cmp73.29, %or.cond1.29
  br i1 %or.cond2.29, label %if.then75.29, label %if.else78.29

if.else78.29:                                     ; preds = %for.body61.29
  %arrayidx80.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %621
  %622 = load i32, i32* %arrayidx80.29, align 4
  %cmp81.29 = icmp eq i32 %622, 75
  br i1 %cmp81.29, label %if.then83.29, label %if.else158.29

if.else158.29:                                    ; preds = %if.else78.29
  %conv161.29 = trunc i32 %622 to i8
  %arrayidx163.29 = getelementptr inbounds i8, i8* %., i64 %621
  store i8 %conv161.29, i8* %arrayidx163.29, align 1
  br label %for.inc166.29

if.then83.29:                                     ; preds = %if.else78.29
  %623 = trunc i64 %indvars.iv.29 to i32
  %sub86.29 = add i32 %623, %sub84.29
  %add87.29 = add i32 %sub86.29, -129
  %idxprom88.29 = sext i32 %add87.29 to i64
  %arrayidx89.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.29
  %624 = load i32, i32* %arrayidx89.29, align 4
  %cmp90.29 = icmp eq i32 %624, 255
  br i1 %cmp90.29, label %if.then151.29, label %lor.lhs.false92.29

lor.lhs.false92.29:                               ; preds = %if.then83.29
  %625 = add nsw i64 %620, %indvars.iv.29
  %arrayidx97.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %625
  %626 = load i32, i32* %arrayidx97.29, align 4
  %cmp98.29 = icmp eq i32 %626, 255
  br i1 %cmp98.29, label %if.then151.29, label %lor.lhs.false100.29

lor.lhs.false100.29:                              ; preds = %lor.lhs.false92.29
  %add104.29 = add i32 %sub86.29, -127
  %idxprom105.29 = sext i32 %add104.29 to i64
  %arrayidx106.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.29
  %627 = load i32, i32* %arrayidx106.29, align 4
  %cmp107.29 = icmp eq i32 %627, 255
  br i1 %cmp107.29, label %if.then151.29, label %lor.lhs.false109.29

lor.lhs.false109.29:                              ; preds = %lor.lhs.false100.29
  %628 = trunc i64 %indvars.iv.29 to i32
  %add112.29 = add i32 %sub111.29, %628
  %idxprom113.29 = sext i32 %add112.29 to i64
  %arrayidx114.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.29
  %629 = load i32, i32* %arrayidx114.29, align 4
  %cmp115.29 = icmp eq i32 %629, 255
  br i1 %cmp115.29, label %if.then151.29, label %lor.lhs.false117.29

lor.lhs.false117.29:                              ; preds = %lor.lhs.false109.29
  %630 = trunc i64 %indvars.iv.29 to i32
  %add120.29 = add i32 %add119.29, %630
  %idxprom121.29 = sext i32 %add120.29 to i64
  %arrayidx122.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.29
  %631 = load i32, i32* %arrayidx122.29, align 4
  %cmp123.29 = icmp eq i32 %631, 255
  br i1 %cmp123.29, label %if.then151.29, label %lor.lhs.false125.29

lor.lhs.false125.29:                              ; preds = %lor.lhs.false117.29
  %add129.29 = add i32 %sub86.29, 127
  %idxprom130.29 = sext i32 %add129.29 to i64
  %arrayidx131.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.29
  %632 = load i32, i32* %arrayidx131.29, align 4
  %cmp132.29 = icmp eq i32 %632, 255
  br i1 %cmp132.29, label %if.then151.29, label %lor.lhs.false134.29

lor.lhs.false134.29:                              ; preds = %lor.lhs.false125.29
  %633 = add nsw i64 %619, %indvars.iv.29
  %arrayidx139.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %633
  %634 = load i32, i32* %arrayidx139.29, align 4
  %cmp140.29 = icmp eq i32 %634, 255
  br i1 %cmp140.29, label %if.then151.29, label %lor.lhs.false142.29

lor.lhs.false142.29:                              ; preds = %lor.lhs.false134.29
  %add146.29 = add i32 %sub86.29, 129
  %idxprom147.29 = sext i32 %add146.29 to i64
  %arrayidx148.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.29
  %635 = load i32, i32* %arrayidx148.29, align 4
  %cmp149.29 = icmp eq i32 %635, 255
  br i1 %cmp149.29, label %if.then151.29, label %if.else154.29

if.else154.29:                                    ; preds = %lor.lhs.false142.29
  %arrayidx156.29 = getelementptr inbounds i8, i8* %., i64 %621
  store i8 0, i8* %arrayidx156.29, align 1
  br label %for.inc166.29

if.then151.29:                                    ; preds = %lor.lhs.false142.29, %lor.lhs.false134.29, %lor.lhs.false125.29, %lor.lhs.false117.29, %lor.lhs.false109.29, %lor.lhs.false100.29, %lor.lhs.false92.29, %if.then83.29
  %arrayidx153.29 = getelementptr inbounds i8, i8* %., i64 %621
  store i8 -1, i8* %arrayidx153.29, align 1
  br label %for.inc166.29

if.then75.29:                                     ; preds = %for.body61.29
  %arrayidx77.29 = getelementptr inbounds i8, i8* %., i64 %621
  store i8 0, i8* %arrayidx77.29, align 1
  br label %for.inc166.29

for.inc166.29:                                    ; preds = %if.then75.29, %if.then151.29, %if.else154.29, %if.else158.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %img_width
  br i1 %exitcond.29, label %for.inc169.29, label %for.body61.29, !llvm.loop !5

for.inc169.29:                                    ; preds = %for.inc166.29
  %indvars.iv.next20.29 = add nsw i64 %indvars.iv19, 30
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.30

for.body61.lr.ph.30:                              ; preds = %for.inc169.29
  %636 = trunc i64 %indvars.iv.next20.29 to i32
  %mul63.30 = shl nsw i32 %636, 7
  %cmp67.30 = icmp eq i64 %indvars.iv.next20.29, %11
  %637 = trunc i64 %indvars.iv.next20.29 to i32
  %sub84.30 = shl i32 %637, 7
  %mul94.30 = add i32 %sub84.30, -128
  %sub111.30 = add i32 %mul63.30, -1
  %add119.30 = or i32 %mul63.30, 1
  %mul136.30 = add i32 %sub84.30, 128
  %638 = sext i32 %mul63.30 to i64
  %639 = sext i32 %mul136.30 to i64
  %640 = sext i32 %mul94.30 to i64
  br label %for.body61.30

for.body61.30:                                    ; preds = %for.inc166.30, %for.body61.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body61.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc166.30 ]
  %641 = add nsw i64 %indvars.iv.30, %638
  %cmp70.30 = icmp eq i64 %indvars.iv.30, 0
  %or.cond1.30 = or i1 %cmp67.30, %cmp70.30
  %cmp73.30 = icmp eq i64 %indvars.iv.30, %10
  %or.cond2.30 = or i1 %cmp73.30, %or.cond1.30
  br i1 %or.cond2.30, label %if.then75.30, label %if.else78.30

if.else78.30:                                     ; preds = %for.body61.30
  %arrayidx80.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %641
  %642 = load i32, i32* %arrayidx80.30, align 4
  %cmp81.30 = icmp eq i32 %642, 75
  br i1 %cmp81.30, label %if.then83.30, label %if.else158.30

if.else158.30:                                    ; preds = %if.else78.30
  %conv161.30 = trunc i32 %642 to i8
  %arrayidx163.30 = getelementptr inbounds i8, i8* %., i64 %641
  store i8 %conv161.30, i8* %arrayidx163.30, align 1
  br label %for.inc166.30

if.then83.30:                                     ; preds = %if.else78.30
  %643 = trunc i64 %indvars.iv.30 to i32
  %sub86.30 = add i32 %643, %sub84.30
  %add87.30 = add i32 %sub86.30, -129
  %idxprom88.30 = sext i32 %add87.30 to i64
  %arrayidx89.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.30
  %644 = load i32, i32* %arrayidx89.30, align 4
  %cmp90.30 = icmp eq i32 %644, 255
  br i1 %cmp90.30, label %if.then151.30, label %lor.lhs.false92.30

lor.lhs.false92.30:                               ; preds = %if.then83.30
  %645 = add nsw i64 %640, %indvars.iv.30
  %arrayidx97.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %645
  %646 = load i32, i32* %arrayidx97.30, align 4
  %cmp98.30 = icmp eq i32 %646, 255
  br i1 %cmp98.30, label %if.then151.30, label %lor.lhs.false100.30

lor.lhs.false100.30:                              ; preds = %lor.lhs.false92.30
  %add104.30 = add i32 %sub86.30, -127
  %idxprom105.30 = sext i32 %add104.30 to i64
  %arrayidx106.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.30
  %647 = load i32, i32* %arrayidx106.30, align 4
  %cmp107.30 = icmp eq i32 %647, 255
  br i1 %cmp107.30, label %if.then151.30, label %lor.lhs.false109.30

lor.lhs.false109.30:                              ; preds = %lor.lhs.false100.30
  %648 = trunc i64 %indvars.iv.30 to i32
  %add112.30 = add i32 %sub111.30, %648
  %idxprom113.30 = sext i32 %add112.30 to i64
  %arrayidx114.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.30
  %649 = load i32, i32* %arrayidx114.30, align 4
  %cmp115.30 = icmp eq i32 %649, 255
  br i1 %cmp115.30, label %if.then151.30, label %lor.lhs.false117.30

lor.lhs.false117.30:                              ; preds = %lor.lhs.false109.30
  %650 = trunc i64 %indvars.iv.30 to i32
  %add120.30 = add i32 %add119.30, %650
  %idxprom121.30 = sext i32 %add120.30 to i64
  %arrayidx122.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.30
  %651 = load i32, i32* %arrayidx122.30, align 4
  %cmp123.30 = icmp eq i32 %651, 255
  br i1 %cmp123.30, label %if.then151.30, label %lor.lhs.false125.30

lor.lhs.false125.30:                              ; preds = %lor.lhs.false117.30
  %add129.30 = add i32 %sub86.30, 127
  %idxprom130.30 = sext i32 %add129.30 to i64
  %arrayidx131.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.30
  %652 = load i32, i32* %arrayidx131.30, align 4
  %cmp132.30 = icmp eq i32 %652, 255
  br i1 %cmp132.30, label %if.then151.30, label %lor.lhs.false134.30

lor.lhs.false134.30:                              ; preds = %lor.lhs.false125.30
  %653 = add nsw i64 %639, %indvars.iv.30
  %arrayidx139.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %653
  %654 = load i32, i32* %arrayidx139.30, align 4
  %cmp140.30 = icmp eq i32 %654, 255
  br i1 %cmp140.30, label %if.then151.30, label %lor.lhs.false142.30

lor.lhs.false142.30:                              ; preds = %lor.lhs.false134.30
  %add146.30 = add i32 %sub86.30, 129
  %idxprom147.30 = sext i32 %add146.30 to i64
  %arrayidx148.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.30
  %655 = load i32, i32* %arrayidx148.30, align 4
  %cmp149.30 = icmp eq i32 %655, 255
  br i1 %cmp149.30, label %if.then151.30, label %if.else154.30

if.else154.30:                                    ; preds = %lor.lhs.false142.30
  %arrayidx156.30 = getelementptr inbounds i8, i8* %., i64 %641
  store i8 0, i8* %arrayidx156.30, align 1
  br label %for.inc166.30

if.then151.30:                                    ; preds = %lor.lhs.false142.30, %lor.lhs.false134.30, %lor.lhs.false125.30, %lor.lhs.false117.30, %lor.lhs.false109.30, %lor.lhs.false100.30, %lor.lhs.false92.30, %if.then83.30
  %arrayidx153.30 = getelementptr inbounds i8, i8* %., i64 %641
  store i8 -1, i8* %arrayidx153.30, align 1
  br label %for.inc166.30

if.then75.30:                                     ; preds = %for.body61.30
  %arrayidx77.30 = getelementptr inbounds i8, i8* %., i64 %641
  store i8 0, i8* %arrayidx77.30, align 1
  br label %for.inc166.30

for.inc166.30:                                    ; preds = %if.then75.30, %if.then151.30, %if.else154.30, %if.else158.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %img_width
  br i1 %exitcond.30, label %for.inc169.30, label %for.body61.30, !llvm.loop !5

for.inc169.30:                                    ; preds = %for.inc166.30
  %indvars.iv.next20.30 = add nsw i64 %indvars.iv19, 31
  br i1 %cmp593, label %for.inc169.31, label %for.body61.lr.ph.31

for.body61.lr.ph.31:                              ; preds = %for.inc169.30
  %656 = trunc i64 %indvars.iv.next20.30 to i32
  %mul63.31 = shl nsw i32 %656, 7
  %cmp67.31 = icmp eq i64 %indvars.iv.next20.30, %11
  %657 = trunc i64 %indvars.iv.next20.30 to i32
  %sub84.31 = shl i32 %657, 7
  %mul94.31 = add i32 %sub84.31, -128
  %sub111.31 = add i32 %mul63.31, -1
  %add119.31 = or i32 %mul63.31, 1
  %mul136.31 = add i32 %sub84.31, 128
  %658 = sext i32 %mul63.31 to i64
  %659 = sext i32 %mul136.31 to i64
  %660 = sext i32 %mul94.31 to i64
  br label %for.body61.31

for.body61.31:                                    ; preds = %for.inc166.31, %for.body61.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body61.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc166.31 ]
  %661 = add nsw i64 %indvars.iv.31, %658
  %cmp70.31 = icmp eq i64 %indvars.iv.31, 0
  %or.cond1.31 = or i1 %cmp67.31, %cmp70.31
  %cmp73.31 = icmp eq i64 %indvars.iv.31, %10
  %or.cond2.31 = or i1 %cmp73.31, %or.cond1.31
  br i1 %or.cond2.31, label %if.then75.31, label %if.else78.31

if.else78.31:                                     ; preds = %for.body61.31
  %arrayidx80.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %661
  %662 = load i32, i32* %arrayidx80.31, align 4
  %cmp81.31 = icmp eq i32 %662, 75
  br i1 %cmp81.31, label %if.then83.31, label %if.else158.31

if.else158.31:                                    ; preds = %if.else78.31
  %conv161.31 = trunc i32 %662 to i8
  %arrayidx163.31 = getelementptr inbounds i8, i8* %., i64 %661
  store i8 %conv161.31, i8* %arrayidx163.31, align 1
  br label %for.inc166.31

if.then83.31:                                     ; preds = %if.else78.31
  %663 = trunc i64 %indvars.iv.31 to i32
  %sub86.31 = add i32 %663, %sub84.31
  %add87.31 = add i32 %sub86.31, -129
  %idxprom88.31 = sext i32 %add87.31 to i64
  %arrayidx89.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom88.31
  %664 = load i32, i32* %arrayidx89.31, align 4
  %cmp90.31 = icmp eq i32 %664, 255
  br i1 %cmp90.31, label %if.then151.31, label %lor.lhs.false92.31

lor.lhs.false92.31:                               ; preds = %if.then83.31
  %665 = add nsw i64 %660, %indvars.iv.31
  %arrayidx97.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %665
  %666 = load i32, i32* %arrayidx97.31, align 4
  %cmp98.31 = icmp eq i32 %666, 255
  br i1 %cmp98.31, label %if.then151.31, label %lor.lhs.false100.31

lor.lhs.false100.31:                              ; preds = %lor.lhs.false92.31
  %add104.31 = add i32 %sub86.31, -127
  %idxprom105.31 = sext i32 %add104.31 to i64
  %arrayidx106.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.31
  %667 = load i32, i32* %arrayidx106.31, align 4
  %cmp107.31 = icmp eq i32 %667, 255
  br i1 %cmp107.31, label %if.then151.31, label %lor.lhs.false109.31

lor.lhs.false109.31:                              ; preds = %lor.lhs.false100.31
  %668 = trunc i64 %indvars.iv.31 to i32
  %add112.31 = add i32 %sub111.31, %668
  %idxprom113.31 = sext i32 %add112.31 to i64
  %arrayidx114.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.31
  %669 = load i32, i32* %arrayidx114.31, align 4
  %cmp115.31 = icmp eq i32 %669, 255
  br i1 %cmp115.31, label %if.then151.31, label %lor.lhs.false117.31

lor.lhs.false117.31:                              ; preds = %lor.lhs.false109.31
  %670 = trunc i64 %indvars.iv.31 to i32
  %add120.31 = add i32 %add119.31, %670
  %idxprom121.31 = sext i32 %add120.31 to i64
  %arrayidx122.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom121.31
  %671 = load i32, i32* %arrayidx122.31, align 4
  %cmp123.31 = icmp eq i32 %671, 255
  br i1 %cmp123.31, label %if.then151.31, label %lor.lhs.false125.31

lor.lhs.false125.31:                              ; preds = %lor.lhs.false117.31
  %add129.31 = add i32 %sub86.31, 127
  %idxprom130.31 = sext i32 %add129.31 to i64
  %arrayidx131.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom130.31
  %672 = load i32, i32* %arrayidx131.31, align 4
  %cmp132.31 = icmp eq i32 %672, 255
  br i1 %cmp132.31, label %if.then151.31, label %lor.lhs.false134.31

lor.lhs.false134.31:                              ; preds = %lor.lhs.false125.31
  %673 = add nsw i64 %659, %indvars.iv.31
  %arrayidx139.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %673
  %674 = load i32, i32* %arrayidx139.31, align 4
  %cmp140.31 = icmp eq i32 %674, 255
  br i1 %cmp140.31, label %if.then151.31, label %lor.lhs.false142.31

lor.lhs.false142.31:                              ; preds = %lor.lhs.false134.31
  %add146.31 = add i32 %sub86.31, 129
  %idxprom147.31 = sext i32 %add146.31 to i64
  %arrayidx148.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom147.31
  %675 = load i32, i32* %arrayidx148.31, align 4
  %cmp149.31 = icmp eq i32 %675, 255
  br i1 %cmp149.31, label %if.then151.31, label %if.else154.31

if.else154.31:                                    ; preds = %lor.lhs.false142.31
  %arrayidx156.31 = getelementptr inbounds i8, i8* %., i64 %661
  store i8 0, i8* %arrayidx156.31, align 1
  br label %for.inc166.31

if.then151.31:                                    ; preds = %lor.lhs.false142.31, %lor.lhs.false134.31, %lor.lhs.false125.31, %lor.lhs.false117.31, %lor.lhs.false109.31, %lor.lhs.false100.31, %lor.lhs.false92.31, %if.then83.31
  %arrayidx153.31 = getelementptr inbounds i8, i8* %., i64 %661
  store i8 -1, i8* %arrayidx153.31, align 1
  br label %for.inc166.31

if.then75.31:                                     ; preds = %for.body61.31
  %arrayidx77.31 = getelementptr inbounds i8, i8* %., i64 %661
  store i8 0, i8* %arrayidx77.31, align 1
  br label %for.inc166.31

for.inc166.31:                                    ; preds = %if.then75.31, %if.then151.31, %if.else154.31, %if.else158.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %img_width
  br i1 %exitcond.31, label %for.inc169.31.loopexit, label %for.body61.31, !llvm.loop !5

for.inc169.31.loopexit:                           ; preds = %for.inc166.31
  br label %for.inc169.31

for.inc169.31:                                    ; preds = %for.inc169.31.loopexit, %for.cond58.preheader, %for.inc169, %for.inc169.1, %for.inc169.2, %for.inc169.3, %for.inc169.4, %for.inc169.5, %for.inc169.6, %for.inc169.7, %for.inc169.8, %for.inc169.9, %for.inc169.10, %for.inc169.11, %for.inc169.12, %for.inc169.13, %for.inc169.14, %for.inc169.15, %for.inc169.16, %for.inc169.17, %for.inc169.18, %for.inc169.19, %for.inc169.20, %for.inc169.21, %for.inc169.22, %for.inc169.23, %for.inc169.24, %for.inc169.25, %for.inc169.26, %for.inc169.27, %for.inc169.28, %for.inc169.29, %for.inc169.30
  %indvars.iv.next20.31 = add nsw i64 %indvars.iv19, 32
  %lftr.wideiv21.31 = trunc i64 %indvars.iv.next20.31 to i32
  %exitcond22.31 = icmp eq i32 %lftr.wideiv21.31, %img_height
  br i1 %exitcond22.31, label %for.end171.loopexit, label %for.cond58.preheader, !llvm.loop !7

for.body22.lr.ph.1:                               ; preds = %for.inc49
  %indvars.iv.next29 = add nuw nsw i64 %indvars.iv28, 1
  %676 = trunc i64 %indvars.iv.next29 to i32
  %mul23.1 = shl i32 %676, 7
  %677 = sext i32 %mul23.1 to i64
  br label %for.body22.1

for.body22.1:                                     ; preds = %for.inc46.1, %for.body22.lr.ph.1
  %indvars.iv23.1 = phi i64 [ 0, %for.body22.lr.ph.1 ], [ %indvars.iv.next24.1, %for.inc46.1 ]
  %678 = add nsw i64 %indvars.iv23.1, %677
  %arrayidx25.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %678
  %679 = load i32, i32* %arrayidx25.1, align 4
  %conv26.1 = uitofp i32 %679 to float
  %cmp27.1 = fcmp olt float %conv26.1, %mul13
  br i1 %cmp27.1, label %if.then29.1, label %if.else32.1

if.else32.1:                                      ; preds = %for.body22.1
  %cmp36.1 = fcmp ult float %conv26.1, %img_max.0.lcssa
  br i1 %cmp36.1, label %if.else41.1, label %if.then38.1

if.then38.1:                                      ; preds = %if.else32.1
  store i32 255, i32* %arrayidx25.1, align 4
  br label %for.inc46.1

if.else41.1:                                      ; preds = %if.else32.1
  store i32 75, i32* %arrayidx25.1, align 4
  br label %for.inc46.1

if.then29.1:                                      ; preds = %for.body22.1
  store i32 0, i32* %arrayidx25.1, align 4
  br label %for.inc46.1

for.inc46.1:                                      ; preds = %if.then29.1, %if.else41.1, %if.then38.1
  %indvars.iv.next24.1 = add nuw nsw i64 %indvars.iv23.1, 1
  %lftr.wideiv26.1 = trunc i64 %indvars.iv.next24.1 to i32
  %exitcond27.1 = icmp eq i32 %lftr.wideiv26.1, %img_width
  br i1 %exitcond27.1, label %for.inc49.1, label %for.body22.1, !llvm.loop !3

for.inc49.1:                                      ; preds = %for.inc46.1
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.2

for.body22.lr.ph.2:                               ; preds = %for.inc49.1
  %indvars.iv.next29.1 = add nsw i64 %indvars.iv28, 2
  %680 = trunc i64 %indvars.iv.next29.1 to i32
  %mul23.2 = shl i32 %680, 7
  %681 = sext i32 %mul23.2 to i64
  br label %for.body22.2

for.body22.2:                                     ; preds = %for.inc46.2, %for.body22.lr.ph.2
  %indvars.iv23.2 = phi i64 [ 0, %for.body22.lr.ph.2 ], [ %indvars.iv.next24.2, %for.inc46.2 ]
  %682 = add nsw i64 %indvars.iv23.2, %681
  %arrayidx25.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %682
  %683 = load i32, i32* %arrayidx25.2, align 4
  %conv26.2 = uitofp i32 %683 to float
  %cmp27.2 = fcmp olt float %conv26.2, %mul13
  br i1 %cmp27.2, label %if.then29.2, label %if.else32.2

if.else32.2:                                      ; preds = %for.body22.2
  %cmp36.2 = fcmp ult float %conv26.2, %img_max.0.lcssa
  br i1 %cmp36.2, label %if.else41.2, label %if.then38.2

if.then38.2:                                      ; preds = %if.else32.2
  store i32 255, i32* %arrayidx25.2, align 4
  br label %for.inc46.2

if.else41.2:                                      ; preds = %if.else32.2
  store i32 75, i32* %arrayidx25.2, align 4
  br label %for.inc46.2

if.then29.2:                                      ; preds = %for.body22.2
  store i32 0, i32* %arrayidx25.2, align 4
  br label %for.inc46.2

for.inc46.2:                                      ; preds = %if.then29.2, %if.else41.2, %if.then38.2
  %indvars.iv.next24.2 = add nuw nsw i64 %indvars.iv23.2, 1
  %lftr.wideiv26.2 = trunc i64 %indvars.iv.next24.2 to i32
  %exitcond27.2 = icmp eq i32 %lftr.wideiv26.2, %img_width
  br i1 %exitcond27.2, label %for.inc49.2, label %for.body22.2, !llvm.loop !3

for.inc49.2:                                      ; preds = %for.inc46.2
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.3

for.body22.lr.ph.3:                               ; preds = %for.inc49.2
  %indvars.iv.next29.2 = add nsw i64 %indvars.iv28, 3
  %684 = trunc i64 %indvars.iv.next29.2 to i32
  %mul23.3 = shl i32 %684, 7
  %685 = sext i32 %mul23.3 to i64
  br label %for.body22.3

for.body22.3:                                     ; preds = %for.inc46.3, %for.body22.lr.ph.3
  %indvars.iv23.3 = phi i64 [ 0, %for.body22.lr.ph.3 ], [ %indvars.iv.next24.3, %for.inc46.3 ]
  %686 = add nsw i64 %indvars.iv23.3, %685
  %arrayidx25.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %686
  %687 = load i32, i32* %arrayidx25.3, align 4
  %conv26.3 = uitofp i32 %687 to float
  %cmp27.3 = fcmp olt float %conv26.3, %mul13
  br i1 %cmp27.3, label %if.then29.3, label %if.else32.3

if.else32.3:                                      ; preds = %for.body22.3
  %cmp36.3 = fcmp ult float %conv26.3, %img_max.0.lcssa
  br i1 %cmp36.3, label %if.else41.3, label %if.then38.3

if.then38.3:                                      ; preds = %if.else32.3
  store i32 255, i32* %arrayidx25.3, align 4
  br label %for.inc46.3

if.else41.3:                                      ; preds = %if.else32.3
  store i32 75, i32* %arrayidx25.3, align 4
  br label %for.inc46.3

if.then29.3:                                      ; preds = %for.body22.3
  store i32 0, i32* %arrayidx25.3, align 4
  br label %for.inc46.3

for.inc46.3:                                      ; preds = %if.then29.3, %if.else41.3, %if.then38.3
  %indvars.iv.next24.3 = add nuw nsw i64 %indvars.iv23.3, 1
  %lftr.wideiv26.3 = trunc i64 %indvars.iv.next24.3 to i32
  %exitcond27.3 = icmp eq i32 %lftr.wideiv26.3, %img_width
  br i1 %exitcond27.3, label %for.inc49.3, label %for.body22.3, !llvm.loop !3

for.inc49.3:                                      ; preds = %for.inc46.3
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.4

for.body22.lr.ph.4:                               ; preds = %for.inc49.3
  %indvars.iv.next29.3 = add nsw i64 %indvars.iv28, 4
  %688 = trunc i64 %indvars.iv.next29.3 to i32
  %mul23.4 = shl i32 %688, 7
  %689 = sext i32 %mul23.4 to i64
  br label %for.body22.4

for.body22.4:                                     ; preds = %for.inc46.4, %for.body22.lr.ph.4
  %indvars.iv23.4 = phi i64 [ 0, %for.body22.lr.ph.4 ], [ %indvars.iv.next24.4, %for.inc46.4 ]
  %690 = add nsw i64 %indvars.iv23.4, %689
  %arrayidx25.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %690
  %691 = load i32, i32* %arrayidx25.4, align 4
  %conv26.4 = uitofp i32 %691 to float
  %cmp27.4 = fcmp olt float %conv26.4, %mul13
  br i1 %cmp27.4, label %if.then29.4, label %if.else32.4

if.else32.4:                                      ; preds = %for.body22.4
  %cmp36.4 = fcmp ult float %conv26.4, %img_max.0.lcssa
  br i1 %cmp36.4, label %if.else41.4, label %if.then38.4

if.then38.4:                                      ; preds = %if.else32.4
  store i32 255, i32* %arrayidx25.4, align 4
  br label %for.inc46.4

if.else41.4:                                      ; preds = %if.else32.4
  store i32 75, i32* %arrayidx25.4, align 4
  br label %for.inc46.4

if.then29.4:                                      ; preds = %for.body22.4
  store i32 0, i32* %arrayidx25.4, align 4
  br label %for.inc46.4

for.inc46.4:                                      ; preds = %if.then29.4, %if.else41.4, %if.then38.4
  %indvars.iv.next24.4 = add nuw nsw i64 %indvars.iv23.4, 1
  %lftr.wideiv26.4 = trunc i64 %indvars.iv.next24.4 to i32
  %exitcond27.4 = icmp eq i32 %lftr.wideiv26.4, %img_width
  br i1 %exitcond27.4, label %for.inc49.4, label %for.body22.4, !llvm.loop !3

for.inc49.4:                                      ; preds = %for.inc46.4
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.5

for.body22.lr.ph.5:                               ; preds = %for.inc49.4
  %indvars.iv.next29.4 = add nsw i64 %indvars.iv28, 5
  %692 = trunc i64 %indvars.iv.next29.4 to i32
  %mul23.5 = shl i32 %692, 7
  %693 = sext i32 %mul23.5 to i64
  br label %for.body22.5

for.body22.5:                                     ; preds = %for.inc46.5, %for.body22.lr.ph.5
  %indvars.iv23.5 = phi i64 [ 0, %for.body22.lr.ph.5 ], [ %indvars.iv.next24.5, %for.inc46.5 ]
  %694 = add nsw i64 %indvars.iv23.5, %693
  %arrayidx25.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %694
  %695 = load i32, i32* %arrayidx25.5, align 4
  %conv26.5 = uitofp i32 %695 to float
  %cmp27.5 = fcmp olt float %conv26.5, %mul13
  br i1 %cmp27.5, label %if.then29.5, label %if.else32.5

if.else32.5:                                      ; preds = %for.body22.5
  %cmp36.5 = fcmp ult float %conv26.5, %img_max.0.lcssa
  br i1 %cmp36.5, label %if.else41.5, label %if.then38.5

if.then38.5:                                      ; preds = %if.else32.5
  store i32 255, i32* %arrayidx25.5, align 4
  br label %for.inc46.5

if.else41.5:                                      ; preds = %if.else32.5
  store i32 75, i32* %arrayidx25.5, align 4
  br label %for.inc46.5

if.then29.5:                                      ; preds = %for.body22.5
  store i32 0, i32* %arrayidx25.5, align 4
  br label %for.inc46.5

for.inc46.5:                                      ; preds = %if.then29.5, %if.else41.5, %if.then38.5
  %indvars.iv.next24.5 = add nuw nsw i64 %indvars.iv23.5, 1
  %lftr.wideiv26.5 = trunc i64 %indvars.iv.next24.5 to i32
  %exitcond27.5 = icmp eq i32 %lftr.wideiv26.5, %img_width
  br i1 %exitcond27.5, label %for.inc49.5, label %for.body22.5, !llvm.loop !3

for.inc49.5:                                      ; preds = %for.inc46.5
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.6

for.body22.lr.ph.6:                               ; preds = %for.inc49.5
  %indvars.iv.next29.5 = add nsw i64 %indvars.iv28, 6
  %696 = trunc i64 %indvars.iv.next29.5 to i32
  %mul23.6 = shl i32 %696, 7
  %697 = sext i32 %mul23.6 to i64
  br label %for.body22.6

for.body22.6:                                     ; preds = %for.inc46.6, %for.body22.lr.ph.6
  %indvars.iv23.6 = phi i64 [ 0, %for.body22.lr.ph.6 ], [ %indvars.iv.next24.6, %for.inc46.6 ]
  %698 = add nsw i64 %indvars.iv23.6, %697
  %arrayidx25.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %698
  %699 = load i32, i32* %arrayidx25.6, align 4
  %conv26.6 = uitofp i32 %699 to float
  %cmp27.6 = fcmp olt float %conv26.6, %mul13
  br i1 %cmp27.6, label %if.then29.6, label %if.else32.6

if.else32.6:                                      ; preds = %for.body22.6
  %cmp36.6 = fcmp ult float %conv26.6, %img_max.0.lcssa
  br i1 %cmp36.6, label %if.else41.6, label %if.then38.6

if.then38.6:                                      ; preds = %if.else32.6
  store i32 255, i32* %arrayidx25.6, align 4
  br label %for.inc46.6

if.else41.6:                                      ; preds = %if.else32.6
  store i32 75, i32* %arrayidx25.6, align 4
  br label %for.inc46.6

if.then29.6:                                      ; preds = %for.body22.6
  store i32 0, i32* %arrayidx25.6, align 4
  br label %for.inc46.6

for.inc46.6:                                      ; preds = %if.then29.6, %if.else41.6, %if.then38.6
  %indvars.iv.next24.6 = add nuw nsw i64 %indvars.iv23.6, 1
  %lftr.wideiv26.6 = trunc i64 %indvars.iv.next24.6 to i32
  %exitcond27.6 = icmp eq i32 %lftr.wideiv26.6, %img_width
  br i1 %exitcond27.6, label %for.inc49.6, label %for.body22.6, !llvm.loop !3

for.inc49.6:                                      ; preds = %for.inc46.6
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.7

for.body22.lr.ph.7:                               ; preds = %for.inc49.6
  %indvars.iv.next29.6 = add nsw i64 %indvars.iv28, 7
  %700 = trunc i64 %indvars.iv.next29.6 to i32
  %mul23.7 = shl i32 %700, 7
  %701 = sext i32 %mul23.7 to i64
  br label %for.body22.7

for.body22.7:                                     ; preds = %for.inc46.7, %for.body22.lr.ph.7
  %indvars.iv23.7 = phi i64 [ 0, %for.body22.lr.ph.7 ], [ %indvars.iv.next24.7, %for.inc46.7 ]
  %702 = add nsw i64 %indvars.iv23.7, %701
  %arrayidx25.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %702
  %703 = load i32, i32* %arrayidx25.7, align 4
  %conv26.7 = uitofp i32 %703 to float
  %cmp27.7 = fcmp olt float %conv26.7, %mul13
  br i1 %cmp27.7, label %if.then29.7, label %if.else32.7

if.else32.7:                                      ; preds = %for.body22.7
  %cmp36.7 = fcmp ult float %conv26.7, %img_max.0.lcssa
  br i1 %cmp36.7, label %if.else41.7, label %if.then38.7

if.then38.7:                                      ; preds = %if.else32.7
  store i32 255, i32* %arrayidx25.7, align 4
  br label %for.inc46.7

if.else41.7:                                      ; preds = %if.else32.7
  store i32 75, i32* %arrayidx25.7, align 4
  br label %for.inc46.7

if.then29.7:                                      ; preds = %for.body22.7
  store i32 0, i32* %arrayidx25.7, align 4
  br label %for.inc46.7

for.inc46.7:                                      ; preds = %if.then29.7, %if.else41.7, %if.then38.7
  %indvars.iv.next24.7 = add nuw nsw i64 %indvars.iv23.7, 1
  %lftr.wideiv26.7 = trunc i64 %indvars.iv.next24.7 to i32
  %exitcond27.7 = icmp eq i32 %lftr.wideiv26.7, %img_width
  br i1 %exitcond27.7, label %for.inc49.7, label %for.body22.7, !llvm.loop !3

for.inc49.7:                                      ; preds = %for.inc46.7
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.8

for.body22.lr.ph.8:                               ; preds = %for.inc49.7
  %indvars.iv.next29.7 = add nsw i64 %indvars.iv28, 8
  %704 = trunc i64 %indvars.iv.next29.7 to i32
  %mul23.8 = shl i32 %704, 7
  %705 = sext i32 %mul23.8 to i64
  br label %for.body22.8

for.body22.8:                                     ; preds = %for.inc46.8, %for.body22.lr.ph.8
  %indvars.iv23.8 = phi i64 [ 0, %for.body22.lr.ph.8 ], [ %indvars.iv.next24.8, %for.inc46.8 ]
  %706 = add nsw i64 %indvars.iv23.8, %705
  %arrayidx25.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %706
  %707 = load i32, i32* %arrayidx25.8, align 4
  %conv26.8 = uitofp i32 %707 to float
  %cmp27.8 = fcmp olt float %conv26.8, %mul13
  br i1 %cmp27.8, label %if.then29.8, label %if.else32.8

if.else32.8:                                      ; preds = %for.body22.8
  %cmp36.8 = fcmp ult float %conv26.8, %img_max.0.lcssa
  br i1 %cmp36.8, label %if.else41.8, label %if.then38.8

if.then38.8:                                      ; preds = %if.else32.8
  store i32 255, i32* %arrayidx25.8, align 4
  br label %for.inc46.8

if.else41.8:                                      ; preds = %if.else32.8
  store i32 75, i32* %arrayidx25.8, align 4
  br label %for.inc46.8

if.then29.8:                                      ; preds = %for.body22.8
  store i32 0, i32* %arrayidx25.8, align 4
  br label %for.inc46.8

for.inc46.8:                                      ; preds = %if.then29.8, %if.else41.8, %if.then38.8
  %indvars.iv.next24.8 = add nuw nsw i64 %indvars.iv23.8, 1
  %lftr.wideiv26.8 = trunc i64 %indvars.iv.next24.8 to i32
  %exitcond27.8 = icmp eq i32 %lftr.wideiv26.8, %img_width
  br i1 %exitcond27.8, label %for.inc49.8, label %for.body22.8, !llvm.loop !3

for.inc49.8:                                      ; preds = %for.inc46.8
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.9

for.body22.lr.ph.9:                               ; preds = %for.inc49.8
  %indvars.iv.next29.8 = add nsw i64 %indvars.iv28, 9
  %708 = trunc i64 %indvars.iv.next29.8 to i32
  %mul23.9 = shl i32 %708, 7
  %709 = sext i32 %mul23.9 to i64
  br label %for.body22.9

for.body22.9:                                     ; preds = %for.inc46.9, %for.body22.lr.ph.9
  %indvars.iv23.9 = phi i64 [ 0, %for.body22.lr.ph.9 ], [ %indvars.iv.next24.9, %for.inc46.9 ]
  %710 = add nsw i64 %indvars.iv23.9, %709
  %arrayidx25.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %710
  %711 = load i32, i32* %arrayidx25.9, align 4
  %conv26.9 = uitofp i32 %711 to float
  %cmp27.9 = fcmp olt float %conv26.9, %mul13
  br i1 %cmp27.9, label %if.then29.9, label %if.else32.9

if.else32.9:                                      ; preds = %for.body22.9
  %cmp36.9 = fcmp ult float %conv26.9, %img_max.0.lcssa
  br i1 %cmp36.9, label %if.else41.9, label %if.then38.9

if.then38.9:                                      ; preds = %if.else32.9
  store i32 255, i32* %arrayidx25.9, align 4
  br label %for.inc46.9

if.else41.9:                                      ; preds = %if.else32.9
  store i32 75, i32* %arrayidx25.9, align 4
  br label %for.inc46.9

if.then29.9:                                      ; preds = %for.body22.9
  store i32 0, i32* %arrayidx25.9, align 4
  br label %for.inc46.9

for.inc46.9:                                      ; preds = %if.then29.9, %if.else41.9, %if.then38.9
  %indvars.iv.next24.9 = add nuw nsw i64 %indvars.iv23.9, 1
  %lftr.wideiv26.9 = trunc i64 %indvars.iv.next24.9 to i32
  %exitcond27.9 = icmp eq i32 %lftr.wideiv26.9, %img_width
  br i1 %exitcond27.9, label %for.inc49.9, label %for.body22.9, !llvm.loop !3

for.inc49.9:                                      ; preds = %for.inc46.9
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.10

for.body22.lr.ph.10:                              ; preds = %for.inc49.9
  %indvars.iv.next29.9 = add nsw i64 %indvars.iv28, 10
  %712 = trunc i64 %indvars.iv.next29.9 to i32
  %mul23.10 = shl i32 %712, 7
  %713 = sext i32 %mul23.10 to i64
  br label %for.body22.10

for.body22.10:                                    ; preds = %for.inc46.10, %for.body22.lr.ph.10
  %indvars.iv23.10 = phi i64 [ 0, %for.body22.lr.ph.10 ], [ %indvars.iv.next24.10, %for.inc46.10 ]
  %714 = add nsw i64 %indvars.iv23.10, %713
  %arrayidx25.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %714
  %715 = load i32, i32* %arrayidx25.10, align 4
  %conv26.10 = uitofp i32 %715 to float
  %cmp27.10 = fcmp olt float %conv26.10, %mul13
  br i1 %cmp27.10, label %if.then29.10, label %if.else32.10

if.else32.10:                                     ; preds = %for.body22.10
  %cmp36.10 = fcmp ult float %conv26.10, %img_max.0.lcssa
  br i1 %cmp36.10, label %if.else41.10, label %if.then38.10

if.then38.10:                                     ; preds = %if.else32.10
  store i32 255, i32* %arrayidx25.10, align 4
  br label %for.inc46.10

if.else41.10:                                     ; preds = %if.else32.10
  store i32 75, i32* %arrayidx25.10, align 4
  br label %for.inc46.10

if.then29.10:                                     ; preds = %for.body22.10
  store i32 0, i32* %arrayidx25.10, align 4
  br label %for.inc46.10

for.inc46.10:                                     ; preds = %if.then29.10, %if.else41.10, %if.then38.10
  %indvars.iv.next24.10 = add nuw nsw i64 %indvars.iv23.10, 1
  %lftr.wideiv26.10 = trunc i64 %indvars.iv.next24.10 to i32
  %exitcond27.10 = icmp eq i32 %lftr.wideiv26.10, %img_width
  br i1 %exitcond27.10, label %for.inc49.10, label %for.body22.10, !llvm.loop !3

for.inc49.10:                                     ; preds = %for.inc46.10
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.11

for.body22.lr.ph.11:                              ; preds = %for.inc49.10
  %indvars.iv.next29.10 = add nsw i64 %indvars.iv28, 11
  %716 = trunc i64 %indvars.iv.next29.10 to i32
  %mul23.11 = shl i32 %716, 7
  %717 = sext i32 %mul23.11 to i64
  br label %for.body22.11

for.body22.11:                                    ; preds = %for.inc46.11, %for.body22.lr.ph.11
  %indvars.iv23.11 = phi i64 [ 0, %for.body22.lr.ph.11 ], [ %indvars.iv.next24.11, %for.inc46.11 ]
  %718 = add nsw i64 %indvars.iv23.11, %717
  %arrayidx25.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %718
  %719 = load i32, i32* %arrayidx25.11, align 4
  %conv26.11 = uitofp i32 %719 to float
  %cmp27.11 = fcmp olt float %conv26.11, %mul13
  br i1 %cmp27.11, label %if.then29.11, label %if.else32.11

if.else32.11:                                     ; preds = %for.body22.11
  %cmp36.11 = fcmp ult float %conv26.11, %img_max.0.lcssa
  br i1 %cmp36.11, label %if.else41.11, label %if.then38.11

if.then38.11:                                     ; preds = %if.else32.11
  store i32 255, i32* %arrayidx25.11, align 4
  br label %for.inc46.11

if.else41.11:                                     ; preds = %if.else32.11
  store i32 75, i32* %arrayidx25.11, align 4
  br label %for.inc46.11

if.then29.11:                                     ; preds = %for.body22.11
  store i32 0, i32* %arrayidx25.11, align 4
  br label %for.inc46.11

for.inc46.11:                                     ; preds = %if.then29.11, %if.else41.11, %if.then38.11
  %indvars.iv.next24.11 = add nuw nsw i64 %indvars.iv23.11, 1
  %lftr.wideiv26.11 = trunc i64 %indvars.iv.next24.11 to i32
  %exitcond27.11 = icmp eq i32 %lftr.wideiv26.11, %img_width
  br i1 %exitcond27.11, label %for.inc49.11, label %for.body22.11, !llvm.loop !3

for.inc49.11:                                     ; preds = %for.inc46.11
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.12

for.body22.lr.ph.12:                              ; preds = %for.inc49.11
  %indvars.iv.next29.11 = add nsw i64 %indvars.iv28, 12
  %720 = trunc i64 %indvars.iv.next29.11 to i32
  %mul23.12 = shl i32 %720, 7
  %721 = sext i32 %mul23.12 to i64
  br label %for.body22.12

for.body22.12:                                    ; preds = %for.inc46.12, %for.body22.lr.ph.12
  %indvars.iv23.12 = phi i64 [ 0, %for.body22.lr.ph.12 ], [ %indvars.iv.next24.12, %for.inc46.12 ]
  %722 = add nsw i64 %indvars.iv23.12, %721
  %arrayidx25.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %722
  %723 = load i32, i32* %arrayidx25.12, align 4
  %conv26.12 = uitofp i32 %723 to float
  %cmp27.12 = fcmp olt float %conv26.12, %mul13
  br i1 %cmp27.12, label %if.then29.12, label %if.else32.12

if.else32.12:                                     ; preds = %for.body22.12
  %cmp36.12 = fcmp ult float %conv26.12, %img_max.0.lcssa
  br i1 %cmp36.12, label %if.else41.12, label %if.then38.12

if.then38.12:                                     ; preds = %if.else32.12
  store i32 255, i32* %arrayidx25.12, align 4
  br label %for.inc46.12

if.else41.12:                                     ; preds = %if.else32.12
  store i32 75, i32* %arrayidx25.12, align 4
  br label %for.inc46.12

if.then29.12:                                     ; preds = %for.body22.12
  store i32 0, i32* %arrayidx25.12, align 4
  br label %for.inc46.12

for.inc46.12:                                     ; preds = %if.then29.12, %if.else41.12, %if.then38.12
  %indvars.iv.next24.12 = add nuw nsw i64 %indvars.iv23.12, 1
  %lftr.wideiv26.12 = trunc i64 %indvars.iv.next24.12 to i32
  %exitcond27.12 = icmp eq i32 %lftr.wideiv26.12, %img_width
  br i1 %exitcond27.12, label %for.inc49.12, label %for.body22.12, !llvm.loop !3

for.inc49.12:                                     ; preds = %for.inc46.12
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.13

for.body22.lr.ph.13:                              ; preds = %for.inc49.12
  %indvars.iv.next29.12 = add nsw i64 %indvars.iv28, 13
  %724 = trunc i64 %indvars.iv.next29.12 to i32
  %mul23.13 = shl i32 %724, 7
  %725 = sext i32 %mul23.13 to i64
  br label %for.body22.13

for.body22.13:                                    ; preds = %for.inc46.13, %for.body22.lr.ph.13
  %indvars.iv23.13 = phi i64 [ 0, %for.body22.lr.ph.13 ], [ %indvars.iv.next24.13, %for.inc46.13 ]
  %726 = add nsw i64 %indvars.iv23.13, %725
  %arrayidx25.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %726
  %727 = load i32, i32* %arrayidx25.13, align 4
  %conv26.13 = uitofp i32 %727 to float
  %cmp27.13 = fcmp olt float %conv26.13, %mul13
  br i1 %cmp27.13, label %if.then29.13, label %if.else32.13

if.else32.13:                                     ; preds = %for.body22.13
  %cmp36.13 = fcmp ult float %conv26.13, %img_max.0.lcssa
  br i1 %cmp36.13, label %if.else41.13, label %if.then38.13

if.then38.13:                                     ; preds = %if.else32.13
  store i32 255, i32* %arrayidx25.13, align 4
  br label %for.inc46.13

if.else41.13:                                     ; preds = %if.else32.13
  store i32 75, i32* %arrayidx25.13, align 4
  br label %for.inc46.13

if.then29.13:                                     ; preds = %for.body22.13
  store i32 0, i32* %arrayidx25.13, align 4
  br label %for.inc46.13

for.inc46.13:                                     ; preds = %if.then29.13, %if.else41.13, %if.then38.13
  %indvars.iv.next24.13 = add nuw nsw i64 %indvars.iv23.13, 1
  %lftr.wideiv26.13 = trunc i64 %indvars.iv.next24.13 to i32
  %exitcond27.13 = icmp eq i32 %lftr.wideiv26.13, %img_width
  br i1 %exitcond27.13, label %for.inc49.13, label %for.body22.13, !llvm.loop !3

for.inc49.13:                                     ; preds = %for.inc46.13
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.14

for.body22.lr.ph.14:                              ; preds = %for.inc49.13
  %indvars.iv.next29.13 = add nsw i64 %indvars.iv28, 14
  %728 = trunc i64 %indvars.iv.next29.13 to i32
  %mul23.14 = shl i32 %728, 7
  %729 = sext i32 %mul23.14 to i64
  br label %for.body22.14

for.body22.14:                                    ; preds = %for.inc46.14, %for.body22.lr.ph.14
  %indvars.iv23.14 = phi i64 [ 0, %for.body22.lr.ph.14 ], [ %indvars.iv.next24.14, %for.inc46.14 ]
  %730 = add nsw i64 %indvars.iv23.14, %729
  %arrayidx25.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %730
  %731 = load i32, i32* %arrayidx25.14, align 4
  %conv26.14 = uitofp i32 %731 to float
  %cmp27.14 = fcmp olt float %conv26.14, %mul13
  br i1 %cmp27.14, label %if.then29.14, label %if.else32.14

if.else32.14:                                     ; preds = %for.body22.14
  %cmp36.14 = fcmp ult float %conv26.14, %img_max.0.lcssa
  br i1 %cmp36.14, label %if.else41.14, label %if.then38.14

if.then38.14:                                     ; preds = %if.else32.14
  store i32 255, i32* %arrayidx25.14, align 4
  br label %for.inc46.14

if.else41.14:                                     ; preds = %if.else32.14
  store i32 75, i32* %arrayidx25.14, align 4
  br label %for.inc46.14

if.then29.14:                                     ; preds = %for.body22.14
  store i32 0, i32* %arrayidx25.14, align 4
  br label %for.inc46.14

for.inc46.14:                                     ; preds = %if.then29.14, %if.else41.14, %if.then38.14
  %indvars.iv.next24.14 = add nuw nsw i64 %indvars.iv23.14, 1
  %lftr.wideiv26.14 = trunc i64 %indvars.iv.next24.14 to i32
  %exitcond27.14 = icmp eq i32 %lftr.wideiv26.14, %img_width
  br i1 %exitcond27.14, label %for.inc49.14, label %for.body22.14, !llvm.loop !3

for.inc49.14:                                     ; preds = %for.inc46.14
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.15

for.body22.lr.ph.15:                              ; preds = %for.inc49.14
  %indvars.iv.next29.14 = add nsw i64 %indvars.iv28, 15
  %732 = trunc i64 %indvars.iv.next29.14 to i32
  %mul23.15 = shl i32 %732, 7
  %733 = sext i32 %mul23.15 to i64
  br label %for.body22.15

for.body22.15:                                    ; preds = %for.inc46.15, %for.body22.lr.ph.15
  %indvars.iv23.15 = phi i64 [ 0, %for.body22.lr.ph.15 ], [ %indvars.iv.next24.15, %for.inc46.15 ]
  %734 = add nsw i64 %indvars.iv23.15, %733
  %arrayidx25.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %734
  %735 = load i32, i32* %arrayidx25.15, align 4
  %conv26.15 = uitofp i32 %735 to float
  %cmp27.15 = fcmp olt float %conv26.15, %mul13
  br i1 %cmp27.15, label %if.then29.15, label %if.else32.15

if.else32.15:                                     ; preds = %for.body22.15
  %cmp36.15 = fcmp ult float %conv26.15, %img_max.0.lcssa
  br i1 %cmp36.15, label %if.else41.15, label %if.then38.15

if.then38.15:                                     ; preds = %if.else32.15
  store i32 255, i32* %arrayidx25.15, align 4
  br label %for.inc46.15

if.else41.15:                                     ; preds = %if.else32.15
  store i32 75, i32* %arrayidx25.15, align 4
  br label %for.inc46.15

if.then29.15:                                     ; preds = %for.body22.15
  store i32 0, i32* %arrayidx25.15, align 4
  br label %for.inc46.15

for.inc46.15:                                     ; preds = %if.then29.15, %if.else41.15, %if.then38.15
  %indvars.iv.next24.15 = add nuw nsw i64 %indvars.iv23.15, 1
  %lftr.wideiv26.15 = trunc i64 %indvars.iv.next24.15 to i32
  %exitcond27.15 = icmp eq i32 %lftr.wideiv26.15, %img_width
  br i1 %exitcond27.15, label %for.inc49.15, label %for.body22.15, !llvm.loop !3

for.inc49.15:                                     ; preds = %for.inc46.15
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.16

for.body22.lr.ph.16:                              ; preds = %for.inc49.15
  %indvars.iv.next29.15 = add nsw i64 %indvars.iv28, 16
  %736 = trunc i64 %indvars.iv.next29.15 to i32
  %mul23.16 = shl i32 %736, 7
  %737 = sext i32 %mul23.16 to i64
  br label %for.body22.16

for.body22.16:                                    ; preds = %for.inc46.16, %for.body22.lr.ph.16
  %indvars.iv23.16 = phi i64 [ 0, %for.body22.lr.ph.16 ], [ %indvars.iv.next24.16, %for.inc46.16 ]
  %738 = add nsw i64 %indvars.iv23.16, %737
  %arrayidx25.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %738
  %739 = load i32, i32* %arrayidx25.16, align 4
  %conv26.16 = uitofp i32 %739 to float
  %cmp27.16 = fcmp olt float %conv26.16, %mul13
  br i1 %cmp27.16, label %if.then29.16, label %if.else32.16

if.else32.16:                                     ; preds = %for.body22.16
  %cmp36.16 = fcmp ult float %conv26.16, %img_max.0.lcssa
  br i1 %cmp36.16, label %if.else41.16, label %if.then38.16

if.then38.16:                                     ; preds = %if.else32.16
  store i32 255, i32* %arrayidx25.16, align 4
  br label %for.inc46.16

if.else41.16:                                     ; preds = %if.else32.16
  store i32 75, i32* %arrayidx25.16, align 4
  br label %for.inc46.16

if.then29.16:                                     ; preds = %for.body22.16
  store i32 0, i32* %arrayidx25.16, align 4
  br label %for.inc46.16

for.inc46.16:                                     ; preds = %if.then29.16, %if.else41.16, %if.then38.16
  %indvars.iv.next24.16 = add nuw nsw i64 %indvars.iv23.16, 1
  %lftr.wideiv26.16 = trunc i64 %indvars.iv.next24.16 to i32
  %exitcond27.16 = icmp eq i32 %lftr.wideiv26.16, %img_width
  br i1 %exitcond27.16, label %for.inc49.16, label %for.body22.16, !llvm.loop !3

for.inc49.16:                                     ; preds = %for.inc46.16
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.17

for.body22.lr.ph.17:                              ; preds = %for.inc49.16
  %indvars.iv.next29.16 = add nsw i64 %indvars.iv28, 17
  %740 = trunc i64 %indvars.iv.next29.16 to i32
  %mul23.17 = shl i32 %740, 7
  %741 = sext i32 %mul23.17 to i64
  br label %for.body22.17

for.body22.17:                                    ; preds = %for.inc46.17, %for.body22.lr.ph.17
  %indvars.iv23.17 = phi i64 [ 0, %for.body22.lr.ph.17 ], [ %indvars.iv.next24.17, %for.inc46.17 ]
  %742 = add nsw i64 %indvars.iv23.17, %741
  %arrayidx25.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %742
  %743 = load i32, i32* %arrayidx25.17, align 4
  %conv26.17 = uitofp i32 %743 to float
  %cmp27.17 = fcmp olt float %conv26.17, %mul13
  br i1 %cmp27.17, label %if.then29.17, label %if.else32.17

if.else32.17:                                     ; preds = %for.body22.17
  %cmp36.17 = fcmp ult float %conv26.17, %img_max.0.lcssa
  br i1 %cmp36.17, label %if.else41.17, label %if.then38.17

if.then38.17:                                     ; preds = %if.else32.17
  store i32 255, i32* %arrayidx25.17, align 4
  br label %for.inc46.17

if.else41.17:                                     ; preds = %if.else32.17
  store i32 75, i32* %arrayidx25.17, align 4
  br label %for.inc46.17

if.then29.17:                                     ; preds = %for.body22.17
  store i32 0, i32* %arrayidx25.17, align 4
  br label %for.inc46.17

for.inc46.17:                                     ; preds = %if.then29.17, %if.else41.17, %if.then38.17
  %indvars.iv.next24.17 = add nuw nsw i64 %indvars.iv23.17, 1
  %lftr.wideiv26.17 = trunc i64 %indvars.iv.next24.17 to i32
  %exitcond27.17 = icmp eq i32 %lftr.wideiv26.17, %img_width
  br i1 %exitcond27.17, label %for.inc49.17, label %for.body22.17, !llvm.loop !3

for.inc49.17:                                     ; preds = %for.inc46.17
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.18

for.body22.lr.ph.18:                              ; preds = %for.inc49.17
  %indvars.iv.next29.17 = add nsw i64 %indvars.iv28, 18
  %744 = trunc i64 %indvars.iv.next29.17 to i32
  %mul23.18 = shl i32 %744, 7
  %745 = sext i32 %mul23.18 to i64
  br label %for.body22.18

for.body22.18:                                    ; preds = %for.inc46.18, %for.body22.lr.ph.18
  %indvars.iv23.18 = phi i64 [ 0, %for.body22.lr.ph.18 ], [ %indvars.iv.next24.18, %for.inc46.18 ]
  %746 = add nsw i64 %indvars.iv23.18, %745
  %arrayidx25.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %746
  %747 = load i32, i32* %arrayidx25.18, align 4
  %conv26.18 = uitofp i32 %747 to float
  %cmp27.18 = fcmp olt float %conv26.18, %mul13
  br i1 %cmp27.18, label %if.then29.18, label %if.else32.18

if.else32.18:                                     ; preds = %for.body22.18
  %cmp36.18 = fcmp ult float %conv26.18, %img_max.0.lcssa
  br i1 %cmp36.18, label %if.else41.18, label %if.then38.18

if.then38.18:                                     ; preds = %if.else32.18
  store i32 255, i32* %arrayidx25.18, align 4
  br label %for.inc46.18

if.else41.18:                                     ; preds = %if.else32.18
  store i32 75, i32* %arrayidx25.18, align 4
  br label %for.inc46.18

if.then29.18:                                     ; preds = %for.body22.18
  store i32 0, i32* %arrayidx25.18, align 4
  br label %for.inc46.18

for.inc46.18:                                     ; preds = %if.then29.18, %if.else41.18, %if.then38.18
  %indvars.iv.next24.18 = add nuw nsw i64 %indvars.iv23.18, 1
  %lftr.wideiv26.18 = trunc i64 %indvars.iv.next24.18 to i32
  %exitcond27.18 = icmp eq i32 %lftr.wideiv26.18, %img_width
  br i1 %exitcond27.18, label %for.inc49.18, label %for.body22.18, !llvm.loop !3

for.inc49.18:                                     ; preds = %for.inc46.18
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.19

for.body22.lr.ph.19:                              ; preds = %for.inc49.18
  %indvars.iv.next29.18 = add nsw i64 %indvars.iv28, 19
  %748 = trunc i64 %indvars.iv.next29.18 to i32
  %mul23.19 = shl i32 %748, 7
  %749 = sext i32 %mul23.19 to i64
  br label %for.body22.19

for.body22.19:                                    ; preds = %for.inc46.19, %for.body22.lr.ph.19
  %indvars.iv23.19 = phi i64 [ 0, %for.body22.lr.ph.19 ], [ %indvars.iv.next24.19, %for.inc46.19 ]
  %750 = add nsw i64 %indvars.iv23.19, %749
  %arrayidx25.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %750
  %751 = load i32, i32* %arrayidx25.19, align 4
  %conv26.19 = uitofp i32 %751 to float
  %cmp27.19 = fcmp olt float %conv26.19, %mul13
  br i1 %cmp27.19, label %if.then29.19, label %if.else32.19

if.else32.19:                                     ; preds = %for.body22.19
  %cmp36.19 = fcmp ult float %conv26.19, %img_max.0.lcssa
  br i1 %cmp36.19, label %if.else41.19, label %if.then38.19

if.then38.19:                                     ; preds = %if.else32.19
  store i32 255, i32* %arrayidx25.19, align 4
  br label %for.inc46.19

if.else41.19:                                     ; preds = %if.else32.19
  store i32 75, i32* %arrayidx25.19, align 4
  br label %for.inc46.19

if.then29.19:                                     ; preds = %for.body22.19
  store i32 0, i32* %arrayidx25.19, align 4
  br label %for.inc46.19

for.inc46.19:                                     ; preds = %if.then29.19, %if.else41.19, %if.then38.19
  %indvars.iv.next24.19 = add nuw nsw i64 %indvars.iv23.19, 1
  %lftr.wideiv26.19 = trunc i64 %indvars.iv.next24.19 to i32
  %exitcond27.19 = icmp eq i32 %lftr.wideiv26.19, %img_width
  br i1 %exitcond27.19, label %for.inc49.19, label %for.body22.19, !llvm.loop !3

for.inc49.19:                                     ; preds = %for.inc46.19
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.20

for.body22.lr.ph.20:                              ; preds = %for.inc49.19
  %indvars.iv.next29.19 = add nsw i64 %indvars.iv28, 20
  %752 = trunc i64 %indvars.iv.next29.19 to i32
  %mul23.20 = shl i32 %752, 7
  %753 = sext i32 %mul23.20 to i64
  br label %for.body22.20

for.body22.20:                                    ; preds = %for.inc46.20, %for.body22.lr.ph.20
  %indvars.iv23.20 = phi i64 [ 0, %for.body22.lr.ph.20 ], [ %indvars.iv.next24.20, %for.inc46.20 ]
  %754 = add nsw i64 %indvars.iv23.20, %753
  %arrayidx25.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %754
  %755 = load i32, i32* %arrayidx25.20, align 4
  %conv26.20 = uitofp i32 %755 to float
  %cmp27.20 = fcmp olt float %conv26.20, %mul13
  br i1 %cmp27.20, label %if.then29.20, label %if.else32.20

if.else32.20:                                     ; preds = %for.body22.20
  %cmp36.20 = fcmp ult float %conv26.20, %img_max.0.lcssa
  br i1 %cmp36.20, label %if.else41.20, label %if.then38.20

if.then38.20:                                     ; preds = %if.else32.20
  store i32 255, i32* %arrayidx25.20, align 4
  br label %for.inc46.20

if.else41.20:                                     ; preds = %if.else32.20
  store i32 75, i32* %arrayidx25.20, align 4
  br label %for.inc46.20

if.then29.20:                                     ; preds = %for.body22.20
  store i32 0, i32* %arrayidx25.20, align 4
  br label %for.inc46.20

for.inc46.20:                                     ; preds = %if.then29.20, %if.else41.20, %if.then38.20
  %indvars.iv.next24.20 = add nuw nsw i64 %indvars.iv23.20, 1
  %lftr.wideiv26.20 = trunc i64 %indvars.iv.next24.20 to i32
  %exitcond27.20 = icmp eq i32 %lftr.wideiv26.20, %img_width
  br i1 %exitcond27.20, label %for.inc49.20, label %for.body22.20, !llvm.loop !3

for.inc49.20:                                     ; preds = %for.inc46.20
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.21

for.body22.lr.ph.21:                              ; preds = %for.inc49.20
  %indvars.iv.next29.20 = add nsw i64 %indvars.iv28, 21
  %756 = trunc i64 %indvars.iv.next29.20 to i32
  %mul23.21 = shl i32 %756, 7
  %757 = sext i32 %mul23.21 to i64
  br label %for.body22.21

for.body22.21:                                    ; preds = %for.inc46.21, %for.body22.lr.ph.21
  %indvars.iv23.21 = phi i64 [ 0, %for.body22.lr.ph.21 ], [ %indvars.iv.next24.21, %for.inc46.21 ]
  %758 = add nsw i64 %indvars.iv23.21, %757
  %arrayidx25.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %758
  %759 = load i32, i32* %arrayidx25.21, align 4
  %conv26.21 = uitofp i32 %759 to float
  %cmp27.21 = fcmp olt float %conv26.21, %mul13
  br i1 %cmp27.21, label %if.then29.21, label %if.else32.21

if.else32.21:                                     ; preds = %for.body22.21
  %cmp36.21 = fcmp ult float %conv26.21, %img_max.0.lcssa
  br i1 %cmp36.21, label %if.else41.21, label %if.then38.21

if.then38.21:                                     ; preds = %if.else32.21
  store i32 255, i32* %arrayidx25.21, align 4
  br label %for.inc46.21

if.else41.21:                                     ; preds = %if.else32.21
  store i32 75, i32* %arrayidx25.21, align 4
  br label %for.inc46.21

if.then29.21:                                     ; preds = %for.body22.21
  store i32 0, i32* %arrayidx25.21, align 4
  br label %for.inc46.21

for.inc46.21:                                     ; preds = %if.then29.21, %if.else41.21, %if.then38.21
  %indvars.iv.next24.21 = add nuw nsw i64 %indvars.iv23.21, 1
  %lftr.wideiv26.21 = trunc i64 %indvars.iv.next24.21 to i32
  %exitcond27.21 = icmp eq i32 %lftr.wideiv26.21, %img_width
  br i1 %exitcond27.21, label %for.inc49.21, label %for.body22.21, !llvm.loop !3

for.inc49.21:                                     ; preds = %for.inc46.21
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.22

for.body22.lr.ph.22:                              ; preds = %for.inc49.21
  %indvars.iv.next29.21 = add nsw i64 %indvars.iv28, 22
  %760 = trunc i64 %indvars.iv.next29.21 to i32
  %mul23.22 = shl i32 %760, 7
  %761 = sext i32 %mul23.22 to i64
  br label %for.body22.22

for.body22.22:                                    ; preds = %for.inc46.22, %for.body22.lr.ph.22
  %indvars.iv23.22 = phi i64 [ 0, %for.body22.lr.ph.22 ], [ %indvars.iv.next24.22, %for.inc46.22 ]
  %762 = add nsw i64 %indvars.iv23.22, %761
  %arrayidx25.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %762
  %763 = load i32, i32* %arrayidx25.22, align 4
  %conv26.22 = uitofp i32 %763 to float
  %cmp27.22 = fcmp olt float %conv26.22, %mul13
  br i1 %cmp27.22, label %if.then29.22, label %if.else32.22

if.else32.22:                                     ; preds = %for.body22.22
  %cmp36.22 = fcmp ult float %conv26.22, %img_max.0.lcssa
  br i1 %cmp36.22, label %if.else41.22, label %if.then38.22

if.then38.22:                                     ; preds = %if.else32.22
  store i32 255, i32* %arrayidx25.22, align 4
  br label %for.inc46.22

if.else41.22:                                     ; preds = %if.else32.22
  store i32 75, i32* %arrayidx25.22, align 4
  br label %for.inc46.22

if.then29.22:                                     ; preds = %for.body22.22
  store i32 0, i32* %arrayidx25.22, align 4
  br label %for.inc46.22

for.inc46.22:                                     ; preds = %if.then29.22, %if.else41.22, %if.then38.22
  %indvars.iv.next24.22 = add nuw nsw i64 %indvars.iv23.22, 1
  %lftr.wideiv26.22 = trunc i64 %indvars.iv.next24.22 to i32
  %exitcond27.22 = icmp eq i32 %lftr.wideiv26.22, %img_width
  br i1 %exitcond27.22, label %for.inc49.22, label %for.body22.22, !llvm.loop !3

for.inc49.22:                                     ; preds = %for.inc46.22
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.23

for.body22.lr.ph.23:                              ; preds = %for.inc49.22
  %indvars.iv.next29.22 = add nsw i64 %indvars.iv28, 23
  %764 = trunc i64 %indvars.iv.next29.22 to i32
  %mul23.23 = shl i32 %764, 7
  %765 = sext i32 %mul23.23 to i64
  br label %for.body22.23

for.body22.23:                                    ; preds = %for.inc46.23, %for.body22.lr.ph.23
  %indvars.iv23.23 = phi i64 [ 0, %for.body22.lr.ph.23 ], [ %indvars.iv.next24.23, %for.inc46.23 ]
  %766 = add nsw i64 %indvars.iv23.23, %765
  %arrayidx25.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %766
  %767 = load i32, i32* %arrayidx25.23, align 4
  %conv26.23 = uitofp i32 %767 to float
  %cmp27.23 = fcmp olt float %conv26.23, %mul13
  br i1 %cmp27.23, label %if.then29.23, label %if.else32.23

if.else32.23:                                     ; preds = %for.body22.23
  %cmp36.23 = fcmp ult float %conv26.23, %img_max.0.lcssa
  br i1 %cmp36.23, label %if.else41.23, label %if.then38.23

if.then38.23:                                     ; preds = %if.else32.23
  store i32 255, i32* %arrayidx25.23, align 4
  br label %for.inc46.23

if.else41.23:                                     ; preds = %if.else32.23
  store i32 75, i32* %arrayidx25.23, align 4
  br label %for.inc46.23

if.then29.23:                                     ; preds = %for.body22.23
  store i32 0, i32* %arrayidx25.23, align 4
  br label %for.inc46.23

for.inc46.23:                                     ; preds = %if.then29.23, %if.else41.23, %if.then38.23
  %indvars.iv.next24.23 = add nuw nsw i64 %indvars.iv23.23, 1
  %lftr.wideiv26.23 = trunc i64 %indvars.iv.next24.23 to i32
  %exitcond27.23 = icmp eq i32 %lftr.wideiv26.23, %img_width
  br i1 %exitcond27.23, label %for.inc49.23, label %for.body22.23, !llvm.loop !3

for.inc49.23:                                     ; preds = %for.inc46.23
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.24

for.body22.lr.ph.24:                              ; preds = %for.inc49.23
  %indvars.iv.next29.23 = add nsw i64 %indvars.iv28, 24
  %768 = trunc i64 %indvars.iv.next29.23 to i32
  %mul23.24 = shl i32 %768, 7
  %769 = sext i32 %mul23.24 to i64
  br label %for.body22.24

for.body22.24:                                    ; preds = %for.inc46.24, %for.body22.lr.ph.24
  %indvars.iv23.24 = phi i64 [ 0, %for.body22.lr.ph.24 ], [ %indvars.iv.next24.24, %for.inc46.24 ]
  %770 = add nsw i64 %indvars.iv23.24, %769
  %arrayidx25.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %770
  %771 = load i32, i32* %arrayidx25.24, align 4
  %conv26.24 = uitofp i32 %771 to float
  %cmp27.24 = fcmp olt float %conv26.24, %mul13
  br i1 %cmp27.24, label %if.then29.24, label %if.else32.24

if.else32.24:                                     ; preds = %for.body22.24
  %cmp36.24 = fcmp ult float %conv26.24, %img_max.0.lcssa
  br i1 %cmp36.24, label %if.else41.24, label %if.then38.24

if.then38.24:                                     ; preds = %if.else32.24
  store i32 255, i32* %arrayidx25.24, align 4
  br label %for.inc46.24

if.else41.24:                                     ; preds = %if.else32.24
  store i32 75, i32* %arrayidx25.24, align 4
  br label %for.inc46.24

if.then29.24:                                     ; preds = %for.body22.24
  store i32 0, i32* %arrayidx25.24, align 4
  br label %for.inc46.24

for.inc46.24:                                     ; preds = %if.then29.24, %if.else41.24, %if.then38.24
  %indvars.iv.next24.24 = add nuw nsw i64 %indvars.iv23.24, 1
  %lftr.wideiv26.24 = trunc i64 %indvars.iv.next24.24 to i32
  %exitcond27.24 = icmp eq i32 %lftr.wideiv26.24, %img_width
  br i1 %exitcond27.24, label %for.inc49.24, label %for.body22.24, !llvm.loop !3

for.inc49.24:                                     ; preds = %for.inc46.24
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.25

for.body22.lr.ph.25:                              ; preds = %for.inc49.24
  %indvars.iv.next29.24 = add nsw i64 %indvars.iv28, 25
  %772 = trunc i64 %indvars.iv.next29.24 to i32
  %mul23.25 = shl i32 %772, 7
  %773 = sext i32 %mul23.25 to i64
  br label %for.body22.25

for.body22.25:                                    ; preds = %for.inc46.25, %for.body22.lr.ph.25
  %indvars.iv23.25 = phi i64 [ 0, %for.body22.lr.ph.25 ], [ %indvars.iv.next24.25, %for.inc46.25 ]
  %774 = add nsw i64 %indvars.iv23.25, %773
  %arrayidx25.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %774
  %775 = load i32, i32* %arrayidx25.25, align 4
  %conv26.25 = uitofp i32 %775 to float
  %cmp27.25 = fcmp olt float %conv26.25, %mul13
  br i1 %cmp27.25, label %if.then29.25, label %if.else32.25

if.else32.25:                                     ; preds = %for.body22.25
  %cmp36.25 = fcmp ult float %conv26.25, %img_max.0.lcssa
  br i1 %cmp36.25, label %if.else41.25, label %if.then38.25

if.then38.25:                                     ; preds = %if.else32.25
  store i32 255, i32* %arrayidx25.25, align 4
  br label %for.inc46.25

if.else41.25:                                     ; preds = %if.else32.25
  store i32 75, i32* %arrayidx25.25, align 4
  br label %for.inc46.25

if.then29.25:                                     ; preds = %for.body22.25
  store i32 0, i32* %arrayidx25.25, align 4
  br label %for.inc46.25

for.inc46.25:                                     ; preds = %if.then29.25, %if.else41.25, %if.then38.25
  %indvars.iv.next24.25 = add nuw nsw i64 %indvars.iv23.25, 1
  %lftr.wideiv26.25 = trunc i64 %indvars.iv.next24.25 to i32
  %exitcond27.25 = icmp eq i32 %lftr.wideiv26.25, %img_width
  br i1 %exitcond27.25, label %for.inc49.25, label %for.body22.25, !llvm.loop !3

for.inc49.25:                                     ; preds = %for.inc46.25
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.26

for.body22.lr.ph.26:                              ; preds = %for.inc49.25
  %indvars.iv.next29.25 = add nsw i64 %indvars.iv28, 26
  %776 = trunc i64 %indvars.iv.next29.25 to i32
  %mul23.26 = shl i32 %776, 7
  %777 = sext i32 %mul23.26 to i64
  br label %for.body22.26

for.body22.26:                                    ; preds = %for.inc46.26, %for.body22.lr.ph.26
  %indvars.iv23.26 = phi i64 [ 0, %for.body22.lr.ph.26 ], [ %indvars.iv.next24.26, %for.inc46.26 ]
  %778 = add nsw i64 %indvars.iv23.26, %777
  %arrayidx25.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %778
  %779 = load i32, i32* %arrayidx25.26, align 4
  %conv26.26 = uitofp i32 %779 to float
  %cmp27.26 = fcmp olt float %conv26.26, %mul13
  br i1 %cmp27.26, label %if.then29.26, label %if.else32.26

if.else32.26:                                     ; preds = %for.body22.26
  %cmp36.26 = fcmp ult float %conv26.26, %img_max.0.lcssa
  br i1 %cmp36.26, label %if.else41.26, label %if.then38.26

if.then38.26:                                     ; preds = %if.else32.26
  store i32 255, i32* %arrayidx25.26, align 4
  br label %for.inc46.26

if.else41.26:                                     ; preds = %if.else32.26
  store i32 75, i32* %arrayidx25.26, align 4
  br label %for.inc46.26

if.then29.26:                                     ; preds = %for.body22.26
  store i32 0, i32* %arrayidx25.26, align 4
  br label %for.inc46.26

for.inc46.26:                                     ; preds = %if.then29.26, %if.else41.26, %if.then38.26
  %indvars.iv.next24.26 = add nuw nsw i64 %indvars.iv23.26, 1
  %lftr.wideiv26.26 = trunc i64 %indvars.iv.next24.26 to i32
  %exitcond27.26 = icmp eq i32 %lftr.wideiv26.26, %img_width
  br i1 %exitcond27.26, label %for.inc49.26, label %for.body22.26, !llvm.loop !3

for.inc49.26:                                     ; preds = %for.inc46.26
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.27

for.body22.lr.ph.27:                              ; preds = %for.inc49.26
  %indvars.iv.next29.26 = add nsw i64 %indvars.iv28, 27
  %780 = trunc i64 %indvars.iv.next29.26 to i32
  %mul23.27 = shl i32 %780, 7
  %781 = sext i32 %mul23.27 to i64
  br label %for.body22.27

for.body22.27:                                    ; preds = %for.inc46.27, %for.body22.lr.ph.27
  %indvars.iv23.27 = phi i64 [ 0, %for.body22.lr.ph.27 ], [ %indvars.iv.next24.27, %for.inc46.27 ]
  %782 = add nsw i64 %indvars.iv23.27, %781
  %arrayidx25.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %782
  %783 = load i32, i32* %arrayidx25.27, align 4
  %conv26.27 = uitofp i32 %783 to float
  %cmp27.27 = fcmp olt float %conv26.27, %mul13
  br i1 %cmp27.27, label %if.then29.27, label %if.else32.27

if.else32.27:                                     ; preds = %for.body22.27
  %cmp36.27 = fcmp ult float %conv26.27, %img_max.0.lcssa
  br i1 %cmp36.27, label %if.else41.27, label %if.then38.27

if.then38.27:                                     ; preds = %if.else32.27
  store i32 255, i32* %arrayidx25.27, align 4
  br label %for.inc46.27

if.else41.27:                                     ; preds = %if.else32.27
  store i32 75, i32* %arrayidx25.27, align 4
  br label %for.inc46.27

if.then29.27:                                     ; preds = %for.body22.27
  store i32 0, i32* %arrayidx25.27, align 4
  br label %for.inc46.27

for.inc46.27:                                     ; preds = %if.then29.27, %if.else41.27, %if.then38.27
  %indvars.iv.next24.27 = add nuw nsw i64 %indvars.iv23.27, 1
  %lftr.wideiv26.27 = trunc i64 %indvars.iv.next24.27 to i32
  %exitcond27.27 = icmp eq i32 %lftr.wideiv26.27, %img_width
  br i1 %exitcond27.27, label %for.inc49.27, label %for.body22.27, !llvm.loop !3

for.inc49.27:                                     ; preds = %for.inc46.27
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.28

for.body22.lr.ph.28:                              ; preds = %for.inc49.27
  %indvars.iv.next29.27 = add nsw i64 %indvars.iv28, 28
  %784 = trunc i64 %indvars.iv.next29.27 to i32
  %mul23.28 = shl i32 %784, 7
  %785 = sext i32 %mul23.28 to i64
  br label %for.body22.28

for.body22.28:                                    ; preds = %for.inc46.28, %for.body22.lr.ph.28
  %indvars.iv23.28 = phi i64 [ 0, %for.body22.lr.ph.28 ], [ %indvars.iv.next24.28, %for.inc46.28 ]
  %786 = add nsw i64 %indvars.iv23.28, %785
  %arrayidx25.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %786
  %787 = load i32, i32* %arrayidx25.28, align 4
  %conv26.28 = uitofp i32 %787 to float
  %cmp27.28 = fcmp olt float %conv26.28, %mul13
  br i1 %cmp27.28, label %if.then29.28, label %if.else32.28

if.else32.28:                                     ; preds = %for.body22.28
  %cmp36.28 = fcmp ult float %conv26.28, %img_max.0.lcssa
  br i1 %cmp36.28, label %if.else41.28, label %if.then38.28

if.then38.28:                                     ; preds = %if.else32.28
  store i32 255, i32* %arrayidx25.28, align 4
  br label %for.inc46.28

if.else41.28:                                     ; preds = %if.else32.28
  store i32 75, i32* %arrayidx25.28, align 4
  br label %for.inc46.28

if.then29.28:                                     ; preds = %for.body22.28
  store i32 0, i32* %arrayidx25.28, align 4
  br label %for.inc46.28

for.inc46.28:                                     ; preds = %if.then29.28, %if.else41.28, %if.then38.28
  %indvars.iv.next24.28 = add nuw nsw i64 %indvars.iv23.28, 1
  %lftr.wideiv26.28 = trunc i64 %indvars.iv.next24.28 to i32
  %exitcond27.28 = icmp eq i32 %lftr.wideiv26.28, %img_width
  br i1 %exitcond27.28, label %for.inc49.28, label %for.body22.28, !llvm.loop !3

for.inc49.28:                                     ; preds = %for.inc46.28
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.29

for.body22.lr.ph.29:                              ; preds = %for.inc49.28
  %indvars.iv.next29.28 = add nsw i64 %indvars.iv28, 29
  %788 = trunc i64 %indvars.iv.next29.28 to i32
  %mul23.29 = shl i32 %788, 7
  %789 = sext i32 %mul23.29 to i64
  br label %for.body22.29

for.body22.29:                                    ; preds = %for.inc46.29, %for.body22.lr.ph.29
  %indvars.iv23.29 = phi i64 [ 0, %for.body22.lr.ph.29 ], [ %indvars.iv.next24.29, %for.inc46.29 ]
  %790 = add nsw i64 %indvars.iv23.29, %789
  %arrayidx25.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %790
  %791 = load i32, i32* %arrayidx25.29, align 4
  %conv26.29 = uitofp i32 %791 to float
  %cmp27.29 = fcmp olt float %conv26.29, %mul13
  br i1 %cmp27.29, label %if.then29.29, label %if.else32.29

if.else32.29:                                     ; preds = %for.body22.29
  %cmp36.29 = fcmp ult float %conv26.29, %img_max.0.lcssa
  br i1 %cmp36.29, label %if.else41.29, label %if.then38.29

if.then38.29:                                     ; preds = %if.else32.29
  store i32 255, i32* %arrayidx25.29, align 4
  br label %for.inc46.29

if.else41.29:                                     ; preds = %if.else32.29
  store i32 75, i32* %arrayidx25.29, align 4
  br label %for.inc46.29

if.then29.29:                                     ; preds = %for.body22.29
  store i32 0, i32* %arrayidx25.29, align 4
  br label %for.inc46.29

for.inc46.29:                                     ; preds = %if.then29.29, %if.else41.29, %if.then38.29
  %indvars.iv.next24.29 = add nuw nsw i64 %indvars.iv23.29, 1
  %lftr.wideiv26.29 = trunc i64 %indvars.iv.next24.29 to i32
  %exitcond27.29 = icmp eq i32 %lftr.wideiv26.29, %img_width
  br i1 %exitcond27.29, label %for.inc49.29, label %for.body22.29, !llvm.loop !3

for.inc49.29:                                     ; preds = %for.inc46.29
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.30

for.body22.lr.ph.30:                              ; preds = %for.inc49.29
  %indvars.iv.next29.29 = add nsw i64 %indvars.iv28, 30
  %792 = trunc i64 %indvars.iv.next29.29 to i32
  %mul23.30 = shl i32 %792, 7
  %793 = sext i32 %mul23.30 to i64
  br label %for.body22.30

for.body22.30:                                    ; preds = %for.inc46.30, %for.body22.lr.ph.30
  %indvars.iv23.30 = phi i64 [ 0, %for.body22.lr.ph.30 ], [ %indvars.iv.next24.30, %for.inc46.30 ]
  %794 = add nsw i64 %indvars.iv23.30, %793
  %arrayidx25.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %794
  %795 = load i32, i32* %arrayidx25.30, align 4
  %conv26.30 = uitofp i32 %795 to float
  %cmp27.30 = fcmp olt float %conv26.30, %mul13
  br i1 %cmp27.30, label %if.then29.30, label %if.else32.30

if.else32.30:                                     ; preds = %for.body22.30
  %cmp36.30 = fcmp ult float %conv26.30, %img_max.0.lcssa
  br i1 %cmp36.30, label %if.else41.30, label %if.then38.30

if.then38.30:                                     ; preds = %if.else32.30
  store i32 255, i32* %arrayidx25.30, align 4
  br label %for.inc46.30

if.else41.30:                                     ; preds = %if.else32.30
  store i32 75, i32* %arrayidx25.30, align 4
  br label %for.inc46.30

if.then29.30:                                     ; preds = %for.body22.30
  store i32 0, i32* %arrayidx25.30, align 4
  br label %for.inc46.30

for.inc46.30:                                     ; preds = %if.then29.30, %if.else41.30, %if.then38.30
  %indvars.iv.next24.30 = add nuw nsw i64 %indvars.iv23.30, 1
  %lftr.wideiv26.30 = trunc i64 %indvars.iv.next24.30 to i32
  %exitcond27.30 = icmp eq i32 %lftr.wideiv26.30, %img_width
  br i1 %exitcond27.30, label %for.inc49.30, label %for.body22.30, !llvm.loop !3

for.inc49.30:                                     ; preds = %for.inc46.30
  br i1 %cmp208, label %for.inc49.31, label %for.body22.lr.ph.31

for.body22.lr.ph.31:                              ; preds = %for.inc49.30
  %indvars.iv.next29.30 = add nsw i64 %indvars.iv28, 31
  %796 = trunc i64 %indvars.iv.next29.30 to i32
  %mul23.31 = shl i32 %796, 7
  %797 = sext i32 %mul23.31 to i64
  br label %for.body22.31

for.body22.31:                                    ; preds = %for.inc46.31, %for.body22.lr.ph.31
  %indvars.iv23.31 = phi i64 [ 0, %for.body22.lr.ph.31 ], [ %indvars.iv.next24.31, %for.inc46.31 ]
  %798 = add nsw i64 %indvars.iv23.31, %797
  %arrayidx25.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %798
  %799 = load i32, i32* %arrayidx25.31, align 4
  %conv26.31 = uitofp i32 %799 to float
  %cmp27.31 = fcmp olt float %conv26.31, %mul13
  br i1 %cmp27.31, label %if.then29.31, label %if.else32.31

if.else32.31:                                     ; preds = %for.body22.31
  %cmp36.31 = fcmp ult float %conv26.31, %img_max.0.lcssa
  br i1 %cmp36.31, label %if.else41.31, label %if.then38.31

if.then38.31:                                     ; preds = %if.else32.31
  store i32 255, i32* %arrayidx25.31, align 4
  br label %for.inc46.31

if.else41.31:                                     ; preds = %if.else32.31
  store i32 75, i32* %arrayidx25.31, align 4
  br label %for.inc46.31

if.then29.31:                                     ; preds = %for.body22.31
  store i32 0, i32* %arrayidx25.31, align 4
  br label %for.inc46.31

for.inc46.31:                                     ; preds = %if.then29.31, %if.else41.31, %if.then38.31
  %indvars.iv.next24.31 = add nuw nsw i64 %indvars.iv23.31, 1
  %lftr.wideiv26.31 = trunc i64 %indvars.iv.next24.31 to i32
  %exitcond27.31 = icmp eq i32 %lftr.wideiv26.31, %img_width
  br i1 %exitcond27.31, label %for.inc49.31.loopexit, label %for.body22.31, !llvm.loop !3

for.inc49.31.loopexit:                            ; preds = %for.inc46.31
  br label %for.inc49.31

for.inc49.31:                                     ; preds = %for.inc49.31.loopexit, %for.cond19.preheader, %for.inc49, %for.inc49.1, %for.inc49.2, %for.inc49.3, %for.inc49.4, %for.inc49.5, %for.inc49.6, %for.inc49.7, %for.inc49.8, %for.inc49.9, %for.inc49.10, %for.inc49.11, %for.inc49.12, %for.inc49.13, %for.inc49.14, %for.inc49.15, %for.inc49.16, %for.inc49.17, %for.inc49.18, %for.inc49.19, %for.inc49.20, %for.inc49.21, %for.inc49.22, %for.inc49.23, %for.inc49.24, %for.inc49.25, %for.inc49.26, %for.inc49.27, %for.inc49.28, %for.inc49.29, %for.inc49.30
  %indvars.iv.next29.31 = add nsw i64 %indvars.iv28, 32
  %lftr.wideiv30.31 = trunc i64 %indvars.iv.next29.31 to i32
  %exitcond31.31 = icmp eq i32 %lftr.wideiv30.31, %img_height
  br i1 %exitcond31.31, label %for.cond53.preheader, label %for.cond19.preheader, !llvm.loop !8
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
