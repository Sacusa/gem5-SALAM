; ModuleID = 'edge_tracking.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @edge_tracking(i32 %img_height, i32 %img_width, float %thr_weak_ratio, float %thr_strong_ratio) #0 {
entry:
  %sub = add i32 %img_height, -1
  %sub1 = add i32 %img_width, -1
  %mul = mul i32 %img_width, %img_height
  %cmp14 = icmp sgt i32 %mul, 0
  br i1 %cmp14, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %0 = mul i32 %img_width, %img_height
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %indvars.iv33 = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next34, %for.body ]
  %img_max.015 = phi i32 [ 0, %for.body.preheader ], [ %.img_max.0, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %indvars.iv33
  %1 = load i32, i32* %arrayidx, align 4
  %cmp2 = icmp ugt i32 %1, %img_max.015
  %.img_max.0 = select i1 %cmp2, i32 %1, i32 %img_max.015
  %indvars.iv.next34 = add nuw nsw i64 %indvars.iv33, 1
  %lftr.wideiv35 = trunc i64 %indvars.iv.next34 to i32
  %exitcond36 = icmp eq i32 %lftr.wideiv35, %0
  br i1 %exitcond36, label %for.end.loopexit, label %for.body, !llvm.loop !1

for.end.loopexit:                                 ; preds = %for.body
  %.img_max.0.lcssa = phi i32 [ %.img_max.0, %for.body ]
  %phitmp = uitofp i32 %.img_max.0.lcssa to float
  %phitmp46 = fmul float %phitmp, 0x3FE0189380000000
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %img_max.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %phitmp46, %for.end.loopexit ]
  %mul6 = fmul float %img_max.0.lcssa, 5.000000e-01
  %cmp910 = icmp eq i32 %img_height, 0
  br i1 %cmp910, label %for.end163, label %for.cond12.preheader.lr.ph

for.cond12.preheader.lr.ph:                       ; preds = %for.end
  %cmp138 = icmp eq i32 %img_width, 0
  %2 = add i32 %img_height, -1
  %xtraiter37 = and i32 %img_height, 3
  %lcmp.mod38 = icmp eq i32 %xtraiter37, 0
  br i1 %lcmp.mod38, label %for.cond12.preheader.lr.ph.split, label %for.cond12.preheader.prol.preheader

for.cond12.preheader.prol.preheader:              ; preds = %for.cond12.preheader.lr.ph
  br label %for.cond12.preheader.prol

for.cond12.preheader.prol:                        ; preds = %for.cond12.preheader.prol.preheader, %for.inc41.prol
  %indvars.iv29.prol = phi i64 [ %indvars.iv.next30.prol, %for.inc41.prol ], [ 0, %for.cond12.preheader.prol.preheader ]
  %prol.iter39 = phi i32 [ %prol.iter39.sub, %for.inc41.prol ], [ %xtraiter37, %for.cond12.preheader.prol.preheader ]
  br i1 %cmp138, label %for.inc41.prol, label %for.body15.lr.ph.prol

for.body15.lr.ph.prol:                            ; preds = %for.cond12.preheader.prol
  %3 = trunc i64 %indvars.iv29.prol to i32
  %mul16.prol = shl i32 %3, 7
  %4 = sext i32 %mul16.prol to i64
  br label %for.body15.prol

for.body15.prol:                                  ; preds = %for.inc38.prol, %for.body15.lr.ph.prol
  %indvars.iv24.prol = phi i64 [ 0, %for.body15.lr.ph.prol ], [ %indvars.iv.next25.prol, %for.inc38.prol ]
  %5 = add nsw i64 %indvars.iv24.prol, %4
  %arrayidx18.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %5
  %6 = load i32, i32* %arrayidx18.prol, align 4
  %conv19.prol = uitofp i32 %6 to float
  %cmp20.prol = fcmp olt float %conv19.prol, %mul6
  br i1 %cmp20.prol, label %if.then22.prol, label %if.else.prol

if.else.prol:                                     ; preds = %for.body15.prol
  %cmp28.prol = fcmp ult float %conv19.prol, %img_max.0.lcssa
  br i1 %cmp28.prol, label %if.else33.prol, label %if.then30.prol

if.then30.prol:                                   ; preds = %if.else.prol
  store i32 255, i32* %arrayidx18.prol, align 4
  br label %for.inc38.prol

if.else33.prol:                                   ; preds = %if.else.prol
  store i32 75, i32* %arrayidx18.prol, align 4
  br label %for.inc38.prol

if.then22.prol:                                   ; preds = %for.body15.prol
  store i32 0, i32* %arrayidx18.prol, align 4
  br label %for.inc38.prol

for.inc38.prol:                                   ; preds = %if.then22.prol, %if.else33.prol, %if.then30.prol
  %indvars.iv.next25.prol = add nuw nsw i64 %indvars.iv24.prol, 1
  %lftr.wideiv27.prol = trunc i64 %indvars.iv.next25.prol to i32
  %exitcond28.prol = icmp eq i32 %lftr.wideiv27.prol, %img_width
  br i1 %exitcond28.prol, label %for.inc41.prol.loopexit, label %for.body15.prol, !llvm.loop !3

for.inc41.prol.loopexit:                          ; preds = %for.inc38.prol
  br label %for.inc41.prol

for.inc41.prol:                                   ; preds = %for.inc41.prol.loopexit, %for.cond12.preheader.prol
  %indvars.iv.next30.prol = add nuw nsw i64 %indvars.iv29.prol, 1
  %prol.iter39.sub = add i32 %prol.iter39, -1
  %prol.iter39.cmp = icmp eq i32 %prol.iter39.sub, 0
  br i1 %prol.iter39.cmp, label %for.cond12.preheader.lr.ph.split.loopexit, label %for.cond12.preheader.prol, !llvm.loop !4

for.cond12.preheader.lr.ph.split.loopexit:        ; preds = %for.inc41.prol
  %indvars.iv.next30.prol.lcssa = phi i64 [ %indvars.iv.next30.prol, %for.inc41.prol ]
  br label %for.cond12.preheader.lr.ph.split

for.cond12.preheader.lr.ph.split:                 ; preds = %for.cond12.preheader.lr.ph.split.loopexit, %for.cond12.preheader.lr.ph
  %indvars.iv29.unr = phi i64 [ 0, %for.cond12.preheader.lr.ph ], [ %indvars.iv.next30.prol.lcssa, %for.cond12.preheader.lr.ph.split.loopexit ]
  %7 = icmp ult i32 %2, 3
  br i1 %7, label %for.cond50.preheader.lr.ph, label %for.cond12.preheader.preheader

for.cond12.preheader.preheader:                   ; preds = %for.cond12.preheader.lr.ph.split
  br label %for.cond12.preheader

for.cond12.preheader:                             ; preds = %for.cond12.preheader.preheader, %for.inc41.3
  %indvars.iv29 = phi i64 [ %indvars.iv.next30.3, %for.inc41.3 ], [ %indvars.iv29.unr, %for.cond12.preheader.preheader ]
  br i1 %cmp138, label %for.inc41.3, label %for.body15.lr.ph

for.body15.lr.ph:                                 ; preds = %for.cond12.preheader
  %8 = trunc i64 %indvars.iv29 to i32
  %mul16 = shl i32 %8, 7
  %9 = sext i32 %mul16 to i64
  br label %for.body15

for.cond45.preheader:                             ; preds = %for.inc41.3
  %cmp465 = icmp eq i32 %img_height, 0
  br i1 %cmp465, label %for.end163, label %for.cond50.preheader.lr.ph

for.cond50.preheader.lr.ph:                       ; preds = %for.cond12.preheader.lr.ph.split, %for.cond45.preheader
  %cmp513 = icmp eq i32 %img_width, 0
  %10 = zext i32 %sub1 to i64
  %11 = zext i32 %sub to i64
  %12 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 3
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond50.preheader.lr.ph.split, label %for.cond50.preheader.prol.preheader

for.cond50.preheader.prol.preheader:              ; preds = %for.cond50.preheader.lr.ph
  br label %for.cond50.preheader.prol

for.cond50.preheader.prol:                        ; preds = %for.cond50.preheader.prol.preheader, %for.inc161.prol
  %indvars.iv20.prol = phi i64 [ %indvars.iv.next21.prol, %for.inc161.prol ], [ 0, %for.cond50.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc161.prol ], [ %xtraiter, %for.cond50.preheader.prol.preheader ]
  br i1 %cmp513, label %for.inc161.prol, label %for.body53.lr.ph.prol

for.body53.lr.ph.prol:                            ; preds = %for.cond50.preheader.prol
  %13 = trunc i64 %indvars.iv20.prol to i32
  %mul55.prol = shl nsw i32 %13, 7
  %cmp57.prol = icmp eq i64 %indvars.iv20.prol, 0
  %cmp59.prol = icmp eq i64 %indvars.iv20.prol, %11
  %or.cond.prol = or i1 %cmp57.prol, %cmp59.prol
  %14 = trunc i64 %indvars.iv20.prol to i32
  %sub76.prol = shl i32 %14, 7
  %mul86.prol = add i32 %sub76.prol, -128
  %sub103.prol = add i32 %mul55.prol, -1
  %add111.prol = or i32 %mul55.prol, 1
  %mul128.prol = add i32 %sub76.prol, 128
  %15 = sext i32 %mul55.prol to i64
  %16 = sext i32 %mul128.prol to i64
  %17 = sext i32 %mul86.prol to i64
  br label %for.body53.prol

for.body53.prol:                                  ; preds = %for.inc158.prol, %for.body53.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body53.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc158.prol ]
  %18 = add nsw i64 %indvars.iv.prol, %15
  %cmp62.prol = icmp eq i64 %indvars.iv.prol, 0
  %or.cond1.prol = or i1 %or.cond.prol, %cmp62.prol
  %cmp65.prol = icmp eq i64 %indvars.iv.prol, %10
  %or.cond2.prol = or i1 %cmp65.prol, %or.cond1.prol
  br i1 %or.cond2.prol, label %if.then67.prol, label %if.else70.prol

if.else70.prol:                                   ; preds = %for.body53.prol
  %arrayidx72.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %18
  %19 = load i32, i32* %arrayidx72.prol, align 4
  %cmp73.prol = icmp eq i32 %19, 75
  br i1 %cmp73.prol, label %if.then75.prol, label %if.else150.prol

if.else150.prol:                                  ; preds = %if.else70.prol
  %conv153.prol = trunc i32 %19 to i8
  %arrayidx155.prol = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %18
  store i8 %conv153.prol, i8* %arrayidx155.prol, align 1
  br label %for.inc158.prol

if.then75.prol:                                   ; preds = %if.else70.prol
  %20 = trunc i64 %indvars.iv.prol to i32
  %sub78.prol = add i32 %20, %sub76.prol
  %add79.prol = add i32 %sub78.prol, -129
  %idxprom80.prol = sext i32 %add79.prol to i64
  %arrayidx81.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.prol
  %21 = load i32, i32* %arrayidx81.prol, align 4
  %cmp82.prol = icmp eq i32 %21, 255
  br i1 %cmp82.prol, label %if.then143.prol, label %lor.lhs.false84.prol

lor.lhs.false84.prol:                             ; preds = %if.then75.prol
  %22 = add nsw i64 %17, %indvars.iv.prol
  %arrayidx89.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %22
  %23 = load i32, i32* %arrayidx89.prol, align 4
  %cmp90.prol = icmp eq i32 %23, 255
  br i1 %cmp90.prol, label %if.then143.prol, label %lor.lhs.false92.prol

lor.lhs.false92.prol:                             ; preds = %lor.lhs.false84.prol
  %add96.prol = add i32 %sub78.prol, -127
  %idxprom97.prol = sext i32 %add96.prol to i64
  %arrayidx98.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.prol
  %24 = load i32, i32* %arrayidx98.prol, align 4
  %cmp99.prol = icmp eq i32 %24, 255
  br i1 %cmp99.prol, label %if.then143.prol, label %lor.lhs.false101.prol

lor.lhs.false101.prol:                            ; preds = %lor.lhs.false92.prol
  %25 = trunc i64 %indvars.iv.prol to i32
  %add104.prol = add i32 %sub103.prol, %25
  %idxprom105.prol = sext i32 %add104.prol to i64
  %arrayidx106.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.prol
  %26 = load i32, i32* %arrayidx106.prol, align 4
  %cmp107.prol = icmp eq i32 %26, 255
  br i1 %cmp107.prol, label %if.then143.prol, label %lor.lhs.false109.prol

lor.lhs.false109.prol:                            ; preds = %lor.lhs.false101.prol
  %27 = trunc i64 %indvars.iv.prol to i32
  %add112.prol = add i32 %add111.prol, %27
  %idxprom113.prol = sext i32 %add112.prol to i64
  %arrayidx114.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.prol
  %28 = load i32, i32* %arrayidx114.prol, align 4
  %cmp115.prol = icmp eq i32 %28, 255
  br i1 %cmp115.prol, label %if.then143.prol, label %lor.lhs.false117.prol

lor.lhs.false117.prol:                            ; preds = %lor.lhs.false109.prol
  %add121.prol = add i32 %sub78.prol, 127
  %idxprom122.prol = sext i32 %add121.prol to i64
  %arrayidx123.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.prol
  %29 = load i32, i32* %arrayidx123.prol, align 4
  %cmp124.prol = icmp eq i32 %29, 255
  br i1 %cmp124.prol, label %if.then143.prol, label %lor.lhs.false126.prol

lor.lhs.false126.prol:                            ; preds = %lor.lhs.false117.prol
  %30 = add nsw i64 %16, %indvars.iv.prol
  %arrayidx131.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %30
  %31 = load i32, i32* %arrayidx131.prol, align 4
  %cmp132.prol = icmp eq i32 %31, 255
  br i1 %cmp132.prol, label %if.then143.prol, label %lor.lhs.false134.prol

lor.lhs.false134.prol:                            ; preds = %lor.lhs.false126.prol
  %add138.prol = add i32 %sub78.prol, 129
  %idxprom139.prol = sext i32 %add138.prol to i64
  %arrayidx140.prol = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.prol
  %32 = load i32, i32* %arrayidx140.prol, align 4
  %cmp141.prol = icmp eq i32 %32, 255
  br i1 %cmp141.prol, label %if.then143.prol, label %if.else146.prol

if.else146.prol:                                  ; preds = %lor.lhs.false134.prol
  %arrayidx148.prol = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %18
  store i8 0, i8* %arrayidx148.prol, align 1
  br label %for.inc158.prol

if.then143.prol:                                  ; preds = %lor.lhs.false134.prol, %lor.lhs.false126.prol, %lor.lhs.false117.prol, %lor.lhs.false109.prol, %lor.lhs.false101.prol, %lor.lhs.false92.prol, %lor.lhs.false84.prol, %if.then75.prol
  %arrayidx145.prol = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %18
  store i8 -1, i8* %arrayidx145.prol, align 1
  br label %for.inc158.prol

if.then67.prol:                                   ; preds = %for.body53.prol
  %arrayidx69.prol = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %18
  store i8 0, i8* %arrayidx69.prol, align 1
  br label %for.inc158.prol

for.inc158.prol:                                  ; preds = %if.then67.prol, %if.then143.prol, %if.else146.prol, %if.else150.prol
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %img_width
  br i1 %exitcond.prol, label %for.inc161.prol.loopexit, label %for.body53.prol, !llvm.loop !5

for.inc161.prol.loopexit:                         ; preds = %for.inc158.prol
  br label %for.inc161.prol

for.inc161.prol:                                  ; preds = %for.inc161.prol.loopexit, %for.cond50.preheader.prol
  %indvars.iv.next21.prol = add nuw nsw i64 %indvars.iv20.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond50.preheader.lr.ph.split.loopexit, label %for.cond50.preheader.prol, !llvm.loop !6

for.cond50.preheader.lr.ph.split.loopexit:        ; preds = %for.inc161.prol
  %indvars.iv.next21.prol.lcssa = phi i64 [ %indvars.iv.next21.prol, %for.inc161.prol ]
  br label %for.cond50.preheader.lr.ph.split

for.cond50.preheader.lr.ph.split:                 ; preds = %for.cond50.preheader.lr.ph.split.loopexit, %for.cond50.preheader.lr.ph
  %indvars.iv20.unr = phi i64 [ 0, %for.cond50.preheader.lr.ph ], [ %indvars.iv.next21.prol.lcssa, %for.cond50.preheader.lr.ph.split.loopexit ]
  %33 = icmp ult i32 %12, 3
  br i1 %33, label %for.end163, label %for.cond50.preheader.preheader

for.cond50.preheader.preheader:                   ; preds = %for.cond50.preheader.lr.ph.split
  br label %for.cond50.preheader

for.body15:                                       ; preds = %for.inc38, %for.body15.lr.ph
  %indvars.iv24 = phi i64 [ 0, %for.body15.lr.ph ], [ %indvars.iv.next25, %for.inc38 ]
  %34 = add nsw i64 %indvars.iv24, %9
  %arrayidx18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %34
  %35 = load i32, i32* %arrayidx18, align 4
  %conv19 = uitofp i32 %35 to float
  %cmp20 = fcmp olt float %conv19, %mul6
  br i1 %cmp20, label %if.then22, label %if.else

if.then22:                                        ; preds = %for.body15
  store i32 0, i32* %arrayidx18, align 4
  br label %for.inc38

if.else:                                          ; preds = %for.body15
  %cmp28 = fcmp ult float %conv19, %img_max.0.lcssa
  br i1 %cmp28, label %if.else33, label %if.then30

if.then30:                                        ; preds = %if.else
  store i32 255, i32* %arrayidx18, align 4
  br label %for.inc38

if.else33:                                        ; preds = %if.else
  store i32 75, i32* %arrayidx18, align 4
  br label %for.inc38

for.inc38:                                        ; preds = %if.then22, %if.else33, %if.then30
  %indvars.iv.next25 = add nuw nsw i64 %indvars.iv24, 1
  %lftr.wideiv27 = trunc i64 %indvars.iv.next25 to i32
  %exitcond28 = icmp eq i32 %lftr.wideiv27, %img_width
  br i1 %exitcond28, label %for.inc41, label %for.body15, !llvm.loop !3

for.inc41:                                        ; preds = %for.inc38
  br i1 %cmp138, label %for.inc41.3, label %for.body15.lr.ph.1

for.cond50.preheader:                             ; preds = %for.cond50.preheader.preheader, %for.inc161.3
  %indvars.iv20 = phi i64 [ %indvars.iv.next21.3, %for.inc161.3 ], [ %indvars.iv20.unr, %for.cond50.preheader.preheader ]
  br i1 %cmp513, label %for.inc161.3, label %for.body53.lr.ph

for.body53.lr.ph:                                 ; preds = %for.cond50.preheader
  %36 = trunc i64 %indvars.iv20 to i32
  %mul55 = shl nsw i32 %36, 7
  %cmp57 = icmp eq i64 %indvars.iv20, 0
  %cmp59 = icmp eq i64 %indvars.iv20, %11
  %or.cond = or i1 %cmp57, %cmp59
  %37 = trunc i64 %indvars.iv20 to i32
  %sub76 = shl i32 %37, 7
  %mul86 = add i32 %sub76, -128
  %sub103 = add i32 %mul55, -1
  %add111 = or i32 %mul55, 1
  %mul128 = add i32 %sub76, 128
  %38 = sext i32 %mul55 to i64
  %39 = sext i32 %mul128 to i64
  %40 = sext i32 %mul86 to i64
  br label %for.body53

for.body53:                                       ; preds = %for.inc158, %for.body53.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body53.lr.ph ], [ %indvars.iv.next, %for.inc158 ]
  %41 = add nsw i64 %indvars.iv, %38
  %cmp62 = icmp eq i64 %indvars.iv, 0
  %or.cond1 = or i1 %or.cond, %cmp62
  %cmp65 = icmp eq i64 %indvars.iv, %10
  %or.cond2 = or i1 %cmp65, %or.cond1
  br i1 %or.cond2, label %if.then67, label %if.else70

if.then67:                                        ; preds = %for.body53
  %arrayidx69 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %41
  store i8 0, i8* %arrayidx69, align 1
  br label %for.inc158

if.else70:                                        ; preds = %for.body53
  %arrayidx72 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %41
  %42 = load i32, i32* %arrayidx72, align 4
  %cmp73 = icmp eq i32 %42, 75
  br i1 %cmp73, label %if.then75, label %if.else150

if.then75:                                        ; preds = %if.else70
  %43 = trunc i64 %indvars.iv to i32
  %sub78 = add i32 %43, %sub76
  %add79 = add i32 %sub78, -129
  %idxprom80 = sext i32 %add79 to i64
  %arrayidx81 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80
  %44 = load i32, i32* %arrayidx81, align 4
  %cmp82 = icmp eq i32 %44, 255
  br i1 %cmp82, label %if.then143, label %lor.lhs.false84

lor.lhs.false84:                                  ; preds = %if.then75
  %45 = add nsw i64 %40, %indvars.iv
  %arrayidx89 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %45
  %46 = load i32, i32* %arrayidx89, align 4
  %cmp90 = icmp eq i32 %46, 255
  br i1 %cmp90, label %if.then143, label %lor.lhs.false92

lor.lhs.false92:                                  ; preds = %lor.lhs.false84
  %add96 = add i32 %sub78, -127
  %idxprom97 = sext i32 %add96 to i64
  %arrayidx98 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97
  %47 = load i32, i32* %arrayidx98, align 4
  %cmp99 = icmp eq i32 %47, 255
  br i1 %cmp99, label %if.then143, label %lor.lhs.false101

lor.lhs.false101:                                 ; preds = %lor.lhs.false92
  %48 = trunc i64 %indvars.iv to i32
  %add104 = add i32 %sub103, %48
  %idxprom105 = sext i32 %add104 to i64
  %arrayidx106 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105
  %49 = load i32, i32* %arrayidx106, align 4
  %cmp107 = icmp eq i32 %49, 255
  br i1 %cmp107, label %if.then143, label %lor.lhs.false109

lor.lhs.false109:                                 ; preds = %lor.lhs.false101
  %50 = trunc i64 %indvars.iv to i32
  %add112 = add i32 %add111, %50
  %idxprom113 = sext i32 %add112 to i64
  %arrayidx114 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113
  %51 = load i32, i32* %arrayidx114, align 4
  %cmp115 = icmp eq i32 %51, 255
  br i1 %cmp115, label %if.then143, label %lor.lhs.false117

lor.lhs.false117:                                 ; preds = %lor.lhs.false109
  %add121 = add i32 %sub78, 127
  %idxprom122 = sext i32 %add121 to i64
  %arrayidx123 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122
  %52 = load i32, i32* %arrayidx123, align 4
  %cmp124 = icmp eq i32 %52, 255
  br i1 %cmp124, label %if.then143, label %lor.lhs.false126

lor.lhs.false126:                                 ; preds = %lor.lhs.false117
  %53 = add nsw i64 %39, %indvars.iv
  %arrayidx131 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %53
  %54 = load i32, i32* %arrayidx131, align 4
  %cmp132 = icmp eq i32 %54, 255
  br i1 %cmp132, label %if.then143, label %lor.lhs.false134

lor.lhs.false134:                                 ; preds = %lor.lhs.false126
  %add138 = add i32 %sub78, 129
  %idxprom139 = sext i32 %add138 to i64
  %arrayidx140 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139
  %55 = load i32, i32* %arrayidx140, align 4
  %cmp141 = icmp eq i32 %55, 255
  br i1 %cmp141, label %if.then143, label %if.else146

if.then143:                                       ; preds = %lor.lhs.false134, %lor.lhs.false126, %lor.lhs.false117, %lor.lhs.false109, %lor.lhs.false101, %lor.lhs.false92, %lor.lhs.false84, %if.then75
  %arrayidx145 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %41
  store i8 -1, i8* %arrayidx145, align 1
  br label %for.inc158

if.else146:                                       ; preds = %lor.lhs.false134
  %arrayidx148 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %41
  store i8 0, i8* %arrayidx148, align 1
  br label %for.inc158

if.else150:                                       ; preds = %if.else70
  %conv153 = trunc i32 %42 to i8
  %arrayidx155 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %41
  store i8 %conv153, i8* %arrayidx155, align 1
  br label %for.inc158

for.inc158:                                       ; preds = %if.then67, %if.then143, %if.else146, %if.else150
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %img_width
  br i1 %exitcond, label %for.inc161, label %for.body53, !llvm.loop !5

for.inc161:                                       ; preds = %for.inc158
  %indvars.iv.next21 = add nuw nsw i64 %indvars.iv20, 1
  br i1 %cmp513, label %for.inc161.3, label %for.body53.lr.ph.1

for.end163.loopexit:                              ; preds = %for.inc161.3
  br label %for.end163

for.end163:                                       ; preds = %for.end163.loopexit, %for.end, %for.cond50.preheader.lr.ph.split, %for.cond45.preheader
  ret void

for.body53.lr.ph.1:                               ; preds = %for.inc161
  %56 = trunc i64 %indvars.iv.next21 to i32
  %mul55.1 = shl nsw i32 %56, 7
  %cmp59.1 = icmp eq i64 %indvars.iv.next21, %11
  %57 = trunc i64 %indvars.iv.next21 to i32
  %sub76.1 = shl i32 %57, 7
  %mul86.1 = add i32 %sub76.1, -128
  %sub103.1 = add i32 %mul55.1, -1
  %add111.1 = or i32 %mul55.1, 1
  %mul128.1 = add i32 %sub76.1, 128
  %58 = sext i32 %mul55.1 to i64
  %59 = sext i32 %mul128.1 to i64
  %60 = sext i32 %mul86.1 to i64
  br label %for.body53.1

for.body53.1:                                     ; preds = %for.inc158.1, %for.body53.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body53.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc158.1 ]
  %61 = add nsw i64 %indvars.iv.1, %58
  %cmp62.1 = icmp eq i64 %indvars.iv.1, 0
  %or.cond1.1 = or i1 %cmp59.1, %cmp62.1
  %cmp65.1 = icmp eq i64 %indvars.iv.1, %10
  %or.cond2.1 = or i1 %cmp65.1, %or.cond1.1
  br i1 %or.cond2.1, label %if.then67.1, label %if.else70.1

if.else70.1:                                      ; preds = %for.body53.1
  %arrayidx72.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %61
  %62 = load i32, i32* %arrayidx72.1, align 4
  %cmp73.1 = icmp eq i32 %62, 75
  br i1 %cmp73.1, label %if.then75.1, label %if.else150.1

if.else150.1:                                     ; preds = %if.else70.1
  %conv153.1 = trunc i32 %62 to i8
  %arrayidx155.1 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %61
  store i8 %conv153.1, i8* %arrayidx155.1, align 1
  br label %for.inc158.1

if.then75.1:                                      ; preds = %if.else70.1
  %63 = trunc i64 %indvars.iv.1 to i32
  %sub78.1 = add i32 %63, %sub76.1
  %add79.1 = add i32 %sub78.1, -129
  %idxprom80.1 = sext i32 %add79.1 to i64
  %arrayidx81.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.1
  %64 = load i32, i32* %arrayidx81.1, align 4
  %cmp82.1 = icmp eq i32 %64, 255
  br i1 %cmp82.1, label %if.then143.1, label %lor.lhs.false84.1

lor.lhs.false84.1:                                ; preds = %if.then75.1
  %65 = add nsw i64 %60, %indvars.iv.1
  %arrayidx89.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %65
  %66 = load i32, i32* %arrayidx89.1, align 4
  %cmp90.1 = icmp eq i32 %66, 255
  br i1 %cmp90.1, label %if.then143.1, label %lor.lhs.false92.1

lor.lhs.false92.1:                                ; preds = %lor.lhs.false84.1
  %add96.1 = add i32 %sub78.1, -127
  %idxprom97.1 = sext i32 %add96.1 to i64
  %arrayidx98.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.1
  %67 = load i32, i32* %arrayidx98.1, align 4
  %cmp99.1 = icmp eq i32 %67, 255
  br i1 %cmp99.1, label %if.then143.1, label %lor.lhs.false101.1

lor.lhs.false101.1:                               ; preds = %lor.lhs.false92.1
  %68 = trunc i64 %indvars.iv.1 to i32
  %add104.1 = add i32 %sub103.1, %68
  %idxprom105.1 = sext i32 %add104.1 to i64
  %arrayidx106.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.1
  %69 = load i32, i32* %arrayidx106.1, align 4
  %cmp107.1 = icmp eq i32 %69, 255
  br i1 %cmp107.1, label %if.then143.1, label %lor.lhs.false109.1

lor.lhs.false109.1:                               ; preds = %lor.lhs.false101.1
  %70 = trunc i64 %indvars.iv.1 to i32
  %add112.1 = add i32 %add111.1, %70
  %idxprom113.1 = sext i32 %add112.1 to i64
  %arrayidx114.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.1
  %71 = load i32, i32* %arrayidx114.1, align 4
  %cmp115.1 = icmp eq i32 %71, 255
  br i1 %cmp115.1, label %if.then143.1, label %lor.lhs.false117.1

lor.lhs.false117.1:                               ; preds = %lor.lhs.false109.1
  %add121.1 = add i32 %sub78.1, 127
  %idxprom122.1 = sext i32 %add121.1 to i64
  %arrayidx123.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.1
  %72 = load i32, i32* %arrayidx123.1, align 4
  %cmp124.1 = icmp eq i32 %72, 255
  br i1 %cmp124.1, label %if.then143.1, label %lor.lhs.false126.1

lor.lhs.false126.1:                               ; preds = %lor.lhs.false117.1
  %73 = add nsw i64 %59, %indvars.iv.1
  %arrayidx131.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %73
  %74 = load i32, i32* %arrayidx131.1, align 4
  %cmp132.1 = icmp eq i32 %74, 255
  br i1 %cmp132.1, label %if.then143.1, label %lor.lhs.false134.1

lor.lhs.false134.1:                               ; preds = %lor.lhs.false126.1
  %add138.1 = add i32 %sub78.1, 129
  %idxprom139.1 = sext i32 %add138.1 to i64
  %arrayidx140.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.1
  %75 = load i32, i32* %arrayidx140.1, align 4
  %cmp141.1 = icmp eq i32 %75, 255
  br i1 %cmp141.1, label %if.then143.1, label %if.else146.1

if.else146.1:                                     ; preds = %lor.lhs.false134.1
  %arrayidx148.1 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %61
  store i8 0, i8* %arrayidx148.1, align 1
  br label %for.inc158.1

if.then143.1:                                     ; preds = %lor.lhs.false134.1, %lor.lhs.false126.1, %lor.lhs.false117.1, %lor.lhs.false109.1, %lor.lhs.false101.1, %lor.lhs.false92.1, %lor.lhs.false84.1, %if.then75.1
  %arrayidx145.1 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %61
  store i8 -1, i8* %arrayidx145.1, align 1
  br label %for.inc158.1

if.then67.1:                                      ; preds = %for.body53.1
  %arrayidx69.1 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %61
  store i8 0, i8* %arrayidx69.1, align 1
  br label %for.inc158.1

for.inc158.1:                                     ; preds = %if.then67.1, %if.then143.1, %if.else146.1, %if.else150.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %img_width
  br i1 %exitcond.1, label %for.inc161.1, label %for.body53.1, !llvm.loop !5

for.inc161.1:                                     ; preds = %for.inc158.1
  %indvars.iv.next21.1 = add nsw i64 %indvars.iv20, 2
  br i1 %cmp513, label %for.inc161.3, label %for.body53.lr.ph.2

for.body53.lr.ph.2:                               ; preds = %for.inc161.1
  %76 = trunc i64 %indvars.iv.next21.1 to i32
  %mul55.2 = shl nsw i32 %76, 7
  %cmp59.2 = icmp eq i64 %indvars.iv.next21.1, %11
  %77 = trunc i64 %indvars.iv.next21.1 to i32
  %sub76.2 = shl i32 %77, 7
  %mul86.2 = add i32 %sub76.2, -128
  %sub103.2 = add i32 %mul55.2, -1
  %add111.2 = or i32 %mul55.2, 1
  %mul128.2 = add i32 %sub76.2, 128
  %78 = sext i32 %mul55.2 to i64
  %79 = sext i32 %mul128.2 to i64
  %80 = sext i32 %mul86.2 to i64
  br label %for.body53.2

for.body53.2:                                     ; preds = %for.inc158.2, %for.body53.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body53.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc158.2 ]
  %81 = add nsw i64 %indvars.iv.2, %78
  %cmp62.2 = icmp eq i64 %indvars.iv.2, 0
  %or.cond1.2 = or i1 %cmp59.2, %cmp62.2
  %cmp65.2 = icmp eq i64 %indvars.iv.2, %10
  %or.cond2.2 = or i1 %cmp65.2, %or.cond1.2
  br i1 %or.cond2.2, label %if.then67.2, label %if.else70.2

if.else70.2:                                      ; preds = %for.body53.2
  %arrayidx72.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %81
  %82 = load i32, i32* %arrayidx72.2, align 4
  %cmp73.2 = icmp eq i32 %82, 75
  br i1 %cmp73.2, label %if.then75.2, label %if.else150.2

if.else150.2:                                     ; preds = %if.else70.2
  %conv153.2 = trunc i32 %82 to i8
  %arrayidx155.2 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %81
  store i8 %conv153.2, i8* %arrayidx155.2, align 1
  br label %for.inc158.2

if.then75.2:                                      ; preds = %if.else70.2
  %83 = trunc i64 %indvars.iv.2 to i32
  %sub78.2 = add i32 %83, %sub76.2
  %add79.2 = add i32 %sub78.2, -129
  %idxprom80.2 = sext i32 %add79.2 to i64
  %arrayidx81.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.2
  %84 = load i32, i32* %arrayidx81.2, align 4
  %cmp82.2 = icmp eq i32 %84, 255
  br i1 %cmp82.2, label %if.then143.2, label %lor.lhs.false84.2

lor.lhs.false84.2:                                ; preds = %if.then75.2
  %85 = add nsw i64 %80, %indvars.iv.2
  %arrayidx89.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %85
  %86 = load i32, i32* %arrayidx89.2, align 4
  %cmp90.2 = icmp eq i32 %86, 255
  br i1 %cmp90.2, label %if.then143.2, label %lor.lhs.false92.2

lor.lhs.false92.2:                                ; preds = %lor.lhs.false84.2
  %add96.2 = add i32 %sub78.2, -127
  %idxprom97.2 = sext i32 %add96.2 to i64
  %arrayidx98.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.2
  %87 = load i32, i32* %arrayidx98.2, align 4
  %cmp99.2 = icmp eq i32 %87, 255
  br i1 %cmp99.2, label %if.then143.2, label %lor.lhs.false101.2

lor.lhs.false101.2:                               ; preds = %lor.lhs.false92.2
  %88 = trunc i64 %indvars.iv.2 to i32
  %add104.2 = add i32 %sub103.2, %88
  %idxprom105.2 = sext i32 %add104.2 to i64
  %arrayidx106.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.2
  %89 = load i32, i32* %arrayidx106.2, align 4
  %cmp107.2 = icmp eq i32 %89, 255
  br i1 %cmp107.2, label %if.then143.2, label %lor.lhs.false109.2

lor.lhs.false109.2:                               ; preds = %lor.lhs.false101.2
  %90 = trunc i64 %indvars.iv.2 to i32
  %add112.2 = add i32 %add111.2, %90
  %idxprom113.2 = sext i32 %add112.2 to i64
  %arrayidx114.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.2
  %91 = load i32, i32* %arrayidx114.2, align 4
  %cmp115.2 = icmp eq i32 %91, 255
  br i1 %cmp115.2, label %if.then143.2, label %lor.lhs.false117.2

lor.lhs.false117.2:                               ; preds = %lor.lhs.false109.2
  %add121.2 = add i32 %sub78.2, 127
  %idxprom122.2 = sext i32 %add121.2 to i64
  %arrayidx123.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.2
  %92 = load i32, i32* %arrayidx123.2, align 4
  %cmp124.2 = icmp eq i32 %92, 255
  br i1 %cmp124.2, label %if.then143.2, label %lor.lhs.false126.2

lor.lhs.false126.2:                               ; preds = %lor.lhs.false117.2
  %93 = add nsw i64 %79, %indvars.iv.2
  %arrayidx131.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %93
  %94 = load i32, i32* %arrayidx131.2, align 4
  %cmp132.2 = icmp eq i32 %94, 255
  br i1 %cmp132.2, label %if.then143.2, label %lor.lhs.false134.2

lor.lhs.false134.2:                               ; preds = %lor.lhs.false126.2
  %add138.2 = add i32 %sub78.2, 129
  %idxprom139.2 = sext i32 %add138.2 to i64
  %arrayidx140.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.2
  %95 = load i32, i32* %arrayidx140.2, align 4
  %cmp141.2 = icmp eq i32 %95, 255
  br i1 %cmp141.2, label %if.then143.2, label %if.else146.2

if.else146.2:                                     ; preds = %lor.lhs.false134.2
  %arrayidx148.2 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %81
  store i8 0, i8* %arrayidx148.2, align 1
  br label %for.inc158.2

if.then143.2:                                     ; preds = %lor.lhs.false134.2, %lor.lhs.false126.2, %lor.lhs.false117.2, %lor.lhs.false109.2, %lor.lhs.false101.2, %lor.lhs.false92.2, %lor.lhs.false84.2, %if.then75.2
  %arrayidx145.2 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %81
  store i8 -1, i8* %arrayidx145.2, align 1
  br label %for.inc158.2

if.then67.2:                                      ; preds = %for.body53.2
  %arrayidx69.2 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %81
  store i8 0, i8* %arrayidx69.2, align 1
  br label %for.inc158.2

for.inc158.2:                                     ; preds = %if.then67.2, %if.then143.2, %if.else146.2, %if.else150.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %img_width
  br i1 %exitcond.2, label %for.inc161.2, label %for.body53.2, !llvm.loop !5

for.inc161.2:                                     ; preds = %for.inc158.2
  %indvars.iv.next21.2 = add nsw i64 %indvars.iv20, 3
  br i1 %cmp513, label %for.inc161.3, label %for.body53.lr.ph.3

for.body53.lr.ph.3:                               ; preds = %for.inc161.2
  %96 = trunc i64 %indvars.iv.next21.2 to i32
  %mul55.3 = shl nsw i32 %96, 7
  %cmp59.3 = icmp eq i64 %indvars.iv.next21.2, %11
  %97 = trunc i64 %indvars.iv.next21.2 to i32
  %sub76.3 = shl i32 %97, 7
  %mul86.3 = add i32 %sub76.3, -128
  %sub103.3 = add i32 %mul55.3, -1
  %add111.3 = or i32 %mul55.3, 1
  %mul128.3 = add i32 %sub76.3, 128
  %98 = sext i32 %mul55.3 to i64
  %99 = sext i32 %mul128.3 to i64
  %100 = sext i32 %mul86.3 to i64
  br label %for.body53.3

for.body53.3:                                     ; preds = %for.inc158.3, %for.body53.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body53.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc158.3 ]
  %101 = add nsw i64 %indvars.iv.3, %98
  %cmp62.3 = icmp eq i64 %indvars.iv.3, 0
  %or.cond1.3 = or i1 %cmp59.3, %cmp62.3
  %cmp65.3 = icmp eq i64 %indvars.iv.3, %10
  %or.cond2.3 = or i1 %cmp65.3, %or.cond1.3
  br i1 %or.cond2.3, label %if.then67.3, label %if.else70.3

if.else70.3:                                      ; preds = %for.body53.3
  %arrayidx72.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %101
  %102 = load i32, i32* %arrayidx72.3, align 4
  %cmp73.3 = icmp eq i32 %102, 75
  br i1 %cmp73.3, label %if.then75.3, label %if.else150.3

if.else150.3:                                     ; preds = %if.else70.3
  %conv153.3 = trunc i32 %102 to i8
  %arrayidx155.3 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %101
  store i8 %conv153.3, i8* %arrayidx155.3, align 1
  br label %for.inc158.3

if.then75.3:                                      ; preds = %if.else70.3
  %103 = trunc i64 %indvars.iv.3 to i32
  %sub78.3 = add i32 %103, %sub76.3
  %add79.3 = add i32 %sub78.3, -129
  %idxprom80.3 = sext i32 %add79.3 to i64
  %arrayidx81.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.3
  %104 = load i32, i32* %arrayidx81.3, align 4
  %cmp82.3 = icmp eq i32 %104, 255
  br i1 %cmp82.3, label %if.then143.3, label %lor.lhs.false84.3

lor.lhs.false84.3:                                ; preds = %if.then75.3
  %105 = add nsw i64 %100, %indvars.iv.3
  %arrayidx89.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %105
  %106 = load i32, i32* %arrayidx89.3, align 4
  %cmp90.3 = icmp eq i32 %106, 255
  br i1 %cmp90.3, label %if.then143.3, label %lor.lhs.false92.3

lor.lhs.false92.3:                                ; preds = %lor.lhs.false84.3
  %add96.3 = add i32 %sub78.3, -127
  %idxprom97.3 = sext i32 %add96.3 to i64
  %arrayidx98.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.3
  %107 = load i32, i32* %arrayidx98.3, align 4
  %cmp99.3 = icmp eq i32 %107, 255
  br i1 %cmp99.3, label %if.then143.3, label %lor.lhs.false101.3

lor.lhs.false101.3:                               ; preds = %lor.lhs.false92.3
  %108 = trunc i64 %indvars.iv.3 to i32
  %add104.3 = add i32 %sub103.3, %108
  %idxprom105.3 = sext i32 %add104.3 to i64
  %arrayidx106.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.3
  %109 = load i32, i32* %arrayidx106.3, align 4
  %cmp107.3 = icmp eq i32 %109, 255
  br i1 %cmp107.3, label %if.then143.3, label %lor.lhs.false109.3

lor.lhs.false109.3:                               ; preds = %lor.lhs.false101.3
  %110 = trunc i64 %indvars.iv.3 to i32
  %add112.3 = add i32 %add111.3, %110
  %idxprom113.3 = sext i32 %add112.3 to i64
  %arrayidx114.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.3
  %111 = load i32, i32* %arrayidx114.3, align 4
  %cmp115.3 = icmp eq i32 %111, 255
  br i1 %cmp115.3, label %if.then143.3, label %lor.lhs.false117.3

lor.lhs.false117.3:                               ; preds = %lor.lhs.false109.3
  %add121.3 = add i32 %sub78.3, 127
  %idxprom122.3 = sext i32 %add121.3 to i64
  %arrayidx123.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.3
  %112 = load i32, i32* %arrayidx123.3, align 4
  %cmp124.3 = icmp eq i32 %112, 255
  br i1 %cmp124.3, label %if.then143.3, label %lor.lhs.false126.3

lor.lhs.false126.3:                               ; preds = %lor.lhs.false117.3
  %113 = add nsw i64 %99, %indvars.iv.3
  %arrayidx131.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %113
  %114 = load i32, i32* %arrayidx131.3, align 4
  %cmp132.3 = icmp eq i32 %114, 255
  br i1 %cmp132.3, label %if.then143.3, label %lor.lhs.false134.3

lor.lhs.false134.3:                               ; preds = %lor.lhs.false126.3
  %add138.3 = add i32 %sub78.3, 129
  %idxprom139.3 = sext i32 %add138.3 to i64
  %arrayidx140.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.3
  %115 = load i32, i32* %arrayidx140.3, align 4
  %cmp141.3 = icmp eq i32 %115, 255
  br i1 %cmp141.3, label %if.then143.3, label %if.else146.3

if.else146.3:                                     ; preds = %lor.lhs.false134.3
  %arrayidx148.3 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %101
  store i8 0, i8* %arrayidx148.3, align 1
  br label %for.inc158.3

if.then143.3:                                     ; preds = %lor.lhs.false134.3, %lor.lhs.false126.3, %lor.lhs.false117.3, %lor.lhs.false109.3, %lor.lhs.false101.3, %lor.lhs.false92.3, %lor.lhs.false84.3, %if.then75.3
  %arrayidx145.3 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %101
  store i8 -1, i8* %arrayidx145.3, align 1
  br label %for.inc158.3

if.then67.3:                                      ; preds = %for.body53.3
  %arrayidx69.3 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %101
  store i8 0, i8* %arrayidx69.3, align 1
  br label %for.inc158.3

for.inc158.3:                                     ; preds = %if.then67.3, %if.then143.3, %if.else146.3, %if.else150.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %img_width
  br i1 %exitcond.3, label %for.inc161.3.loopexit, label %for.body53.3, !llvm.loop !5

for.inc161.3.loopexit:                            ; preds = %for.inc158.3
  br label %for.inc161.3

for.inc161.3:                                     ; preds = %for.inc161.3.loopexit, %for.cond50.preheader, %for.inc161, %for.inc161.1, %for.inc161.2
  %indvars.iv.next21.3 = add nsw i64 %indvars.iv20, 4
  %lftr.wideiv22.3 = trunc i64 %indvars.iv.next21.3 to i32
  %exitcond23.3 = icmp eq i32 %lftr.wideiv22.3, %img_height
  br i1 %exitcond23.3, label %for.end163.loopexit, label %for.cond50.preheader, !llvm.loop !7

for.body15.lr.ph.1:                               ; preds = %for.inc41
  %indvars.iv.next30 = add nuw nsw i64 %indvars.iv29, 1
  %116 = trunc i64 %indvars.iv.next30 to i32
  %mul16.1 = shl i32 %116, 7
  %117 = sext i32 %mul16.1 to i64
  br label %for.body15.1

for.body15.1:                                     ; preds = %for.inc38.1, %for.body15.lr.ph.1
  %indvars.iv24.1 = phi i64 [ 0, %for.body15.lr.ph.1 ], [ %indvars.iv.next25.1, %for.inc38.1 ]
  %118 = add nsw i64 %indvars.iv24.1, %117
  %arrayidx18.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %118
  %119 = load i32, i32* %arrayidx18.1, align 4
  %conv19.1 = uitofp i32 %119 to float
  %cmp20.1 = fcmp olt float %conv19.1, %mul6
  br i1 %cmp20.1, label %if.then22.1, label %if.else.1

if.else.1:                                        ; preds = %for.body15.1
  %cmp28.1 = fcmp ult float %conv19.1, %img_max.0.lcssa
  br i1 %cmp28.1, label %if.else33.1, label %if.then30.1

if.then30.1:                                      ; preds = %if.else.1
  store i32 255, i32* %arrayidx18.1, align 4
  br label %for.inc38.1

if.else33.1:                                      ; preds = %if.else.1
  store i32 75, i32* %arrayidx18.1, align 4
  br label %for.inc38.1

if.then22.1:                                      ; preds = %for.body15.1
  store i32 0, i32* %arrayidx18.1, align 4
  br label %for.inc38.1

for.inc38.1:                                      ; preds = %if.then22.1, %if.else33.1, %if.then30.1
  %indvars.iv.next25.1 = add nuw nsw i64 %indvars.iv24.1, 1
  %lftr.wideiv27.1 = trunc i64 %indvars.iv.next25.1 to i32
  %exitcond28.1 = icmp eq i32 %lftr.wideiv27.1, %img_width
  br i1 %exitcond28.1, label %for.inc41.1, label %for.body15.1, !llvm.loop !3

for.inc41.1:                                      ; preds = %for.inc38.1
  br i1 %cmp138, label %for.inc41.3, label %for.body15.lr.ph.2

for.body15.lr.ph.2:                               ; preds = %for.inc41.1
  %indvars.iv.next30.1 = add nsw i64 %indvars.iv29, 2
  %120 = trunc i64 %indvars.iv.next30.1 to i32
  %mul16.2 = shl i32 %120, 7
  %121 = sext i32 %mul16.2 to i64
  br label %for.body15.2

for.body15.2:                                     ; preds = %for.inc38.2, %for.body15.lr.ph.2
  %indvars.iv24.2 = phi i64 [ 0, %for.body15.lr.ph.2 ], [ %indvars.iv.next25.2, %for.inc38.2 ]
  %122 = add nsw i64 %indvars.iv24.2, %121
  %arrayidx18.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %122
  %123 = load i32, i32* %arrayidx18.2, align 4
  %conv19.2 = uitofp i32 %123 to float
  %cmp20.2 = fcmp olt float %conv19.2, %mul6
  br i1 %cmp20.2, label %if.then22.2, label %if.else.2

if.else.2:                                        ; preds = %for.body15.2
  %cmp28.2 = fcmp ult float %conv19.2, %img_max.0.lcssa
  br i1 %cmp28.2, label %if.else33.2, label %if.then30.2

if.then30.2:                                      ; preds = %if.else.2
  store i32 255, i32* %arrayidx18.2, align 4
  br label %for.inc38.2

if.else33.2:                                      ; preds = %if.else.2
  store i32 75, i32* %arrayidx18.2, align 4
  br label %for.inc38.2

if.then22.2:                                      ; preds = %for.body15.2
  store i32 0, i32* %arrayidx18.2, align 4
  br label %for.inc38.2

for.inc38.2:                                      ; preds = %if.then22.2, %if.else33.2, %if.then30.2
  %indvars.iv.next25.2 = add nuw nsw i64 %indvars.iv24.2, 1
  %lftr.wideiv27.2 = trunc i64 %indvars.iv.next25.2 to i32
  %exitcond28.2 = icmp eq i32 %lftr.wideiv27.2, %img_width
  br i1 %exitcond28.2, label %for.inc41.2, label %for.body15.2, !llvm.loop !3

for.inc41.2:                                      ; preds = %for.inc38.2
  br i1 %cmp138, label %for.inc41.3, label %for.body15.lr.ph.3

for.body15.lr.ph.3:                               ; preds = %for.inc41.2
  %indvars.iv.next30.2 = add nsw i64 %indvars.iv29, 3
  %124 = trunc i64 %indvars.iv.next30.2 to i32
  %mul16.3 = shl i32 %124, 7
  %125 = sext i32 %mul16.3 to i64
  br label %for.body15.3

for.body15.3:                                     ; preds = %for.inc38.3, %for.body15.lr.ph.3
  %indvars.iv24.3 = phi i64 [ 0, %for.body15.lr.ph.3 ], [ %indvars.iv.next25.3, %for.inc38.3 ]
  %126 = add nsw i64 %indvars.iv24.3, %125
  %arrayidx18.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %126
  %127 = load i32, i32* %arrayidx18.3, align 4
  %conv19.3 = uitofp i32 %127 to float
  %cmp20.3 = fcmp olt float %conv19.3, %mul6
  br i1 %cmp20.3, label %if.then22.3, label %if.else.3

if.else.3:                                        ; preds = %for.body15.3
  %cmp28.3 = fcmp ult float %conv19.3, %img_max.0.lcssa
  br i1 %cmp28.3, label %if.else33.3, label %if.then30.3

if.then30.3:                                      ; preds = %if.else.3
  store i32 255, i32* %arrayidx18.3, align 4
  br label %for.inc38.3

if.else33.3:                                      ; preds = %if.else.3
  store i32 75, i32* %arrayidx18.3, align 4
  br label %for.inc38.3

if.then22.3:                                      ; preds = %for.body15.3
  store i32 0, i32* %arrayidx18.3, align 4
  br label %for.inc38.3

for.inc38.3:                                      ; preds = %if.then22.3, %if.else33.3, %if.then30.3
  %indvars.iv.next25.3 = add nuw nsw i64 %indvars.iv24.3, 1
  %lftr.wideiv27.3 = trunc i64 %indvars.iv.next25.3 to i32
  %exitcond28.3 = icmp eq i32 %lftr.wideiv27.3, %img_width
  br i1 %exitcond28.3, label %for.inc41.3.loopexit, label %for.body15.3, !llvm.loop !3

for.inc41.3.loopexit:                             ; preds = %for.inc38.3
  br label %for.inc41.3

for.inc41.3:                                      ; preds = %for.inc41.3.loopexit, %for.cond12.preheader, %for.inc41, %for.inc41.1, %for.inc41.2
  %indvars.iv.next30.3 = add nsw i64 %indvars.iv29, 4
  %lftr.wideiv31.3 = trunc i64 %indvars.iv.next30.3 to i32
  %exitcond32.3 = icmp eq i32 %lftr.wideiv31.3, %img_height
  br i1 %exitcond32.3, label %for.cond45.preheader, label %for.cond12.preheader, !llvm.loop !8
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
