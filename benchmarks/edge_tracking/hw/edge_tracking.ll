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
  %phitmp74 = fmul float %phitmp, 0x3FE0189380000000
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  %img_max.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %phitmp74, %for.end.loopexit ]
  %mul6 = fmul float %img_max.0.lcssa, 5.000000e-01
  %cmp910 = icmp eq i32 %img_height, 0
  br i1 %cmp910, label %for.end163, label %for.cond12.preheader.lr.ph

for.cond12.preheader.lr.ph:                       ; preds = %for.end
  %cmp138 = icmp eq i32 %img_width, 0
  %2 = add i32 %img_height, -1
  %xtraiter37 = and i32 %img_height, 31
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
  %7 = icmp ult i32 %2, 31
  br i1 %7, label %for.cond50.preheader.lr.ph, label %for.cond12.preheader.preheader

for.cond12.preheader.preheader:                   ; preds = %for.cond12.preheader.lr.ph.split
  br label %for.cond12.preheader

for.cond12.preheader:                             ; preds = %for.cond12.preheader.preheader, %for.inc41.31
  %indvars.iv29 = phi i64 [ %indvars.iv.next30.31, %for.inc41.31 ], [ %indvars.iv29.unr, %for.cond12.preheader.preheader ]
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph

for.body15.lr.ph:                                 ; preds = %for.cond12.preheader
  %8 = trunc i64 %indvars.iv29 to i32
  %mul16 = shl i32 %8, 7
  %9 = sext i32 %mul16 to i64
  br label %for.body15

for.cond45.preheader:                             ; preds = %for.inc41.31
  %cmp465 = icmp eq i32 %img_height, 0
  br i1 %cmp465, label %for.end163, label %for.cond50.preheader.lr.ph

for.cond50.preheader.lr.ph:                       ; preds = %for.cond12.preheader.lr.ph.split, %for.cond45.preheader
  %cmp513 = icmp eq i32 %img_width, 0
  %10 = zext i32 %sub1 to i64
  %11 = zext i32 %sub to i64
  %12 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 31
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
  %33 = icmp ult i32 %12, 31
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
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.1

for.cond50.preheader:                             ; preds = %for.cond50.preheader.preheader, %for.inc161.31
  %indvars.iv20 = phi i64 [ %indvars.iv.next21.31, %for.inc161.31 ], [ %indvars.iv20.unr, %for.cond50.preheader.preheader ]
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph

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
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.1

for.end163.loopexit:                              ; preds = %for.inc161.31
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
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.2

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
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.3

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
  br i1 %exitcond.3, label %for.inc161.3, label %for.body53.3, !llvm.loop !5

for.inc161.3:                                     ; preds = %for.inc158.3
  %indvars.iv.next21.3 = add nsw i64 %indvars.iv20, 4
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.4

for.body53.lr.ph.4:                               ; preds = %for.inc161.3
  %116 = trunc i64 %indvars.iv.next21.3 to i32
  %mul55.4 = shl nsw i32 %116, 7
  %cmp59.4 = icmp eq i64 %indvars.iv.next21.3, %11
  %117 = trunc i64 %indvars.iv.next21.3 to i32
  %sub76.4 = shl i32 %117, 7
  %mul86.4 = add i32 %sub76.4, -128
  %sub103.4 = add i32 %mul55.4, -1
  %add111.4 = or i32 %mul55.4, 1
  %mul128.4 = add i32 %sub76.4, 128
  %118 = sext i32 %mul55.4 to i64
  %119 = sext i32 %mul128.4 to i64
  %120 = sext i32 %mul86.4 to i64
  br label %for.body53.4

for.body53.4:                                     ; preds = %for.inc158.4, %for.body53.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body53.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc158.4 ]
  %121 = add nsw i64 %indvars.iv.4, %118
  %cmp62.4 = icmp eq i64 %indvars.iv.4, 0
  %or.cond1.4 = or i1 %cmp59.4, %cmp62.4
  %cmp65.4 = icmp eq i64 %indvars.iv.4, %10
  %or.cond2.4 = or i1 %cmp65.4, %or.cond1.4
  br i1 %or.cond2.4, label %if.then67.4, label %if.else70.4

if.else70.4:                                      ; preds = %for.body53.4
  %arrayidx72.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %121
  %122 = load i32, i32* %arrayidx72.4, align 4
  %cmp73.4 = icmp eq i32 %122, 75
  br i1 %cmp73.4, label %if.then75.4, label %if.else150.4

if.else150.4:                                     ; preds = %if.else70.4
  %conv153.4 = trunc i32 %122 to i8
  %arrayidx155.4 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %121
  store i8 %conv153.4, i8* %arrayidx155.4, align 1
  br label %for.inc158.4

if.then75.4:                                      ; preds = %if.else70.4
  %123 = trunc i64 %indvars.iv.4 to i32
  %sub78.4 = add i32 %123, %sub76.4
  %add79.4 = add i32 %sub78.4, -129
  %idxprom80.4 = sext i32 %add79.4 to i64
  %arrayidx81.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.4
  %124 = load i32, i32* %arrayidx81.4, align 4
  %cmp82.4 = icmp eq i32 %124, 255
  br i1 %cmp82.4, label %if.then143.4, label %lor.lhs.false84.4

lor.lhs.false84.4:                                ; preds = %if.then75.4
  %125 = add nsw i64 %120, %indvars.iv.4
  %arrayidx89.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %125
  %126 = load i32, i32* %arrayidx89.4, align 4
  %cmp90.4 = icmp eq i32 %126, 255
  br i1 %cmp90.4, label %if.then143.4, label %lor.lhs.false92.4

lor.lhs.false92.4:                                ; preds = %lor.lhs.false84.4
  %add96.4 = add i32 %sub78.4, -127
  %idxprom97.4 = sext i32 %add96.4 to i64
  %arrayidx98.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.4
  %127 = load i32, i32* %arrayidx98.4, align 4
  %cmp99.4 = icmp eq i32 %127, 255
  br i1 %cmp99.4, label %if.then143.4, label %lor.lhs.false101.4

lor.lhs.false101.4:                               ; preds = %lor.lhs.false92.4
  %128 = trunc i64 %indvars.iv.4 to i32
  %add104.4 = add i32 %sub103.4, %128
  %idxprom105.4 = sext i32 %add104.4 to i64
  %arrayidx106.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.4
  %129 = load i32, i32* %arrayidx106.4, align 4
  %cmp107.4 = icmp eq i32 %129, 255
  br i1 %cmp107.4, label %if.then143.4, label %lor.lhs.false109.4

lor.lhs.false109.4:                               ; preds = %lor.lhs.false101.4
  %130 = trunc i64 %indvars.iv.4 to i32
  %add112.4 = add i32 %add111.4, %130
  %idxprom113.4 = sext i32 %add112.4 to i64
  %arrayidx114.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.4
  %131 = load i32, i32* %arrayidx114.4, align 4
  %cmp115.4 = icmp eq i32 %131, 255
  br i1 %cmp115.4, label %if.then143.4, label %lor.lhs.false117.4

lor.lhs.false117.4:                               ; preds = %lor.lhs.false109.4
  %add121.4 = add i32 %sub78.4, 127
  %idxprom122.4 = sext i32 %add121.4 to i64
  %arrayidx123.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.4
  %132 = load i32, i32* %arrayidx123.4, align 4
  %cmp124.4 = icmp eq i32 %132, 255
  br i1 %cmp124.4, label %if.then143.4, label %lor.lhs.false126.4

lor.lhs.false126.4:                               ; preds = %lor.lhs.false117.4
  %133 = add nsw i64 %119, %indvars.iv.4
  %arrayidx131.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %133
  %134 = load i32, i32* %arrayidx131.4, align 4
  %cmp132.4 = icmp eq i32 %134, 255
  br i1 %cmp132.4, label %if.then143.4, label %lor.lhs.false134.4

lor.lhs.false134.4:                               ; preds = %lor.lhs.false126.4
  %add138.4 = add i32 %sub78.4, 129
  %idxprom139.4 = sext i32 %add138.4 to i64
  %arrayidx140.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.4
  %135 = load i32, i32* %arrayidx140.4, align 4
  %cmp141.4 = icmp eq i32 %135, 255
  br i1 %cmp141.4, label %if.then143.4, label %if.else146.4

if.else146.4:                                     ; preds = %lor.lhs.false134.4
  %arrayidx148.4 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %121
  store i8 0, i8* %arrayidx148.4, align 1
  br label %for.inc158.4

if.then143.4:                                     ; preds = %lor.lhs.false134.4, %lor.lhs.false126.4, %lor.lhs.false117.4, %lor.lhs.false109.4, %lor.lhs.false101.4, %lor.lhs.false92.4, %lor.lhs.false84.4, %if.then75.4
  %arrayidx145.4 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %121
  store i8 -1, i8* %arrayidx145.4, align 1
  br label %for.inc158.4

if.then67.4:                                      ; preds = %for.body53.4
  %arrayidx69.4 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %121
  store i8 0, i8* %arrayidx69.4, align 1
  br label %for.inc158.4

for.inc158.4:                                     ; preds = %if.then67.4, %if.then143.4, %if.else146.4, %if.else150.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %img_width
  br i1 %exitcond.4, label %for.inc161.4, label %for.body53.4, !llvm.loop !5

for.inc161.4:                                     ; preds = %for.inc158.4
  %indvars.iv.next21.4 = add nsw i64 %indvars.iv20, 5
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.5

for.body53.lr.ph.5:                               ; preds = %for.inc161.4
  %136 = trunc i64 %indvars.iv.next21.4 to i32
  %mul55.5 = shl nsw i32 %136, 7
  %cmp59.5 = icmp eq i64 %indvars.iv.next21.4, %11
  %137 = trunc i64 %indvars.iv.next21.4 to i32
  %sub76.5 = shl i32 %137, 7
  %mul86.5 = add i32 %sub76.5, -128
  %sub103.5 = add i32 %mul55.5, -1
  %add111.5 = or i32 %mul55.5, 1
  %mul128.5 = add i32 %sub76.5, 128
  %138 = sext i32 %mul55.5 to i64
  %139 = sext i32 %mul128.5 to i64
  %140 = sext i32 %mul86.5 to i64
  br label %for.body53.5

for.body53.5:                                     ; preds = %for.inc158.5, %for.body53.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body53.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc158.5 ]
  %141 = add nsw i64 %indvars.iv.5, %138
  %cmp62.5 = icmp eq i64 %indvars.iv.5, 0
  %or.cond1.5 = or i1 %cmp59.5, %cmp62.5
  %cmp65.5 = icmp eq i64 %indvars.iv.5, %10
  %or.cond2.5 = or i1 %cmp65.5, %or.cond1.5
  br i1 %or.cond2.5, label %if.then67.5, label %if.else70.5

if.else70.5:                                      ; preds = %for.body53.5
  %arrayidx72.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %141
  %142 = load i32, i32* %arrayidx72.5, align 4
  %cmp73.5 = icmp eq i32 %142, 75
  br i1 %cmp73.5, label %if.then75.5, label %if.else150.5

if.else150.5:                                     ; preds = %if.else70.5
  %conv153.5 = trunc i32 %142 to i8
  %arrayidx155.5 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %141
  store i8 %conv153.5, i8* %arrayidx155.5, align 1
  br label %for.inc158.5

if.then75.5:                                      ; preds = %if.else70.5
  %143 = trunc i64 %indvars.iv.5 to i32
  %sub78.5 = add i32 %143, %sub76.5
  %add79.5 = add i32 %sub78.5, -129
  %idxprom80.5 = sext i32 %add79.5 to i64
  %arrayidx81.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.5
  %144 = load i32, i32* %arrayidx81.5, align 4
  %cmp82.5 = icmp eq i32 %144, 255
  br i1 %cmp82.5, label %if.then143.5, label %lor.lhs.false84.5

lor.lhs.false84.5:                                ; preds = %if.then75.5
  %145 = add nsw i64 %140, %indvars.iv.5
  %arrayidx89.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %145
  %146 = load i32, i32* %arrayidx89.5, align 4
  %cmp90.5 = icmp eq i32 %146, 255
  br i1 %cmp90.5, label %if.then143.5, label %lor.lhs.false92.5

lor.lhs.false92.5:                                ; preds = %lor.lhs.false84.5
  %add96.5 = add i32 %sub78.5, -127
  %idxprom97.5 = sext i32 %add96.5 to i64
  %arrayidx98.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.5
  %147 = load i32, i32* %arrayidx98.5, align 4
  %cmp99.5 = icmp eq i32 %147, 255
  br i1 %cmp99.5, label %if.then143.5, label %lor.lhs.false101.5

lor.lhs.false101.5:                               ; preds = %lor.lhs.false92.5
  %148 = trunc i64 %indvars.iv.5 to i32
  %add104.5 = add i32 %sub103.5, %148
  %idxprom105.5 = sext i32 %add104.5 to i64
  %arrayidx106.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.5
  %149 = load i32, i32* %arrayidx106.5, align 4
  %cmp107.5 = icmp eq i32 %149, 255
  br i1 %cmp107.5, label %if.then143.5, label %lor.lhs.false109.5

lor.lhs.false109.5:                               ; preds = %lor.lhs.false101.5
  %150 = trunc i64 %indvars.iv.5 to i32
  %add112.5 = add i32 %add111.5, %150
  %idxprom113.5 = sext i32 %add112.5 to i64
  %arrayidx114.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.5
  %151 = load i32, i32* %arrayidx114.5, align 4
  %cmp115.5 = icmp eq i32 %151, 255
  br i1 %cmp115.5, label %if.then143.5, label %lor.lhs.false117.5

lor.lhs.false117.5:                               ; preds = %lor.lhs.false109.5
  %add121.5 = add i32 %sub78.5, 127
  %idxprom122.5 = sext i32 %add121.5 to i64
  %arrayidx123.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.5
  %152 = load i32, i32* %arrayidx123.5, align 4
  %cmp124.5 = icmp eq i32 %152, 255
  br i1 %cmp124.5, label %if.then143.5, label %lor.lhs.false126.5

lor.lhs.false126.5:                               ; preds = %lor.lhs.false117.5
  %153 = add nsw i64 %139, %indvars.iv.5
  %arrayidx131.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %153
  %154 = load i32, i32* %arrayidx131.5, align 4
  %cmp132.5 = icmp eq i32 %154, 255
  br i1 %cmp132.5, label %if.then143.5, label %lor.lhs.false134.5

lor.lhs.false134.5:                               ; preds = %lor.lhs.false126.5
  %add138.5 = add i32 %sub78.5, 129
  %idxprom139.5 = sext i32 %add138.5 to i64
  %arrayidx140.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.5
  %155 = load i32, i32* %arrayidx140.5, align 4
  %cmp141.5 = icmp eq i32 %155, 255
  br i1 %cmp141.5, label %if.then143.5, label %if.else146.5

if.else146.5:                                     ; preds = %lor.lhs.false134.5
  %arrayidx148.5 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %141
  store i8 0, i8* %arrayidx148.5, align 1
  br label %for.inc158.5

if.then143.5:                                     ; preds = %lor.lhs.false134.5, %lor.lhs.false126.5, %lor.lhs.false117.5, %lor.lhs.false109.5, %lor.lhs.false101.5, %lor.lhs.false92.5, %lor.lhs.false84.5, %if.then75.5
  %arrayidx145.5 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %141
  store i8 -1, i8* %arrayidx145.5, align 1
  br label %for.inc158.5

if.then67.5:                                      ; preds = %for.body53.5
  %arrayidx69.5 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %141
  store i8 0, i8* %arrayidx69.5, align 1
  br label %for.inc158.5

for.inc158.5:                                     ; preds = %if.then67.5, %if.then143.5, %if.else146.5, %if.else150.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %img_width
  br i1 %exitcond.5, label %for.inc161.5, label %for.body53.5, !llvm.loop !5

for.inc161.5:                                     ; preds = %for.inc158.5
  %indvars.iv.next21.5 = add nsw i64 %indvars.iv20, 6
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.6

for.body53.lr.ph.6:                               ; preds = %for.inc161.5
  %156 = trunc i64 %indvars.iv.next21.5 to i32
  %mul55.6 = shl nsw i32 %156, 7
  %cmp59.6 = icmp eq i64 %indvars.iv.next21.5, %11
  %157 = trunc i64 %indvars.iv.next21.5 to i32
  %sub76.6 = shl i32 %157, 7
  %mul86.6 = add i32 %sub76.6, -128
  %sub103.6 = add i32 %mul55.6, -1
  %add111.6 = or i32 %mul55.6, 1
  %mul128.6 = add i32 %sub76.6, 128
  %158 = sext i32 %mul55.6 to i64
  %159 = sext i32 %mul128.6 to i64
  %160 = sext i32 %mul86.6 to i64
  br label %for.body53.6

for.body53.6:                                     ; preds = %for.inc158.6, %for.body53.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body53.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc158.6 ]
  %161 = add nsw i64 %indvars.iv.6, %158
  %cmp62.6 = icmp eq i64 %indvars.iv.6, 0
  %or.cond1.6 = or i1 %cmp59.6, %cmp62.6
  %cmp65.6 = icmp eq i64 %indvars.iv.6, %10
  %or.cond2.6 = or i1 %cmp65.6, %or.cond1.6
  br i1 %or.cond2.6, label %if.then67.6, label %if.else70.6

if.else70.6:                                      ; preds = %for.body53.6
  %arrayidx72.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %161
  %162 = load i32, i32* %arrayidx72.6, align 4
  %cmp73.6 = icmp eq i32 %162, 75
  br i1 %cmp73.6, label %if.then75.6, label %if.else150.6

if.else150.6:                                     ; preds = %if.else70.6
  %conv153.6 = trunc i32 %162 to i8
  %arrayidx155.6 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %161
  store i8 %conv153.6, i8* %arrayidx155.6, align 1
  br label %for.inc158.6

if.then75.6:                                      ; preds = %if.else70.6
  %163 = trunc i64 %indvars.iv.6 to i32
  %sub78.6 = add i32 %163, %sub76.6
  %add79.6 = add i32 %sub78.6, -129
  %idxprom80.6 = sext i32 %add79.6 to i64
  %arrayidx81.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.6
  %164 = load i32, i32* %arrayidx81.6, align 4
  %cmp82.6 = icmp eq i32 %164, 255
  br i1 %cmp82.6, label %if.then143.6, label %lor.lhs.false84.6

lor.lhs.false84.6:                                ; preds = %if.then75.6
  %165 = add nsw i64 %160, %indvars.iv.6
  %arrayidx89.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %165
  %166 = load i32, i32* %arrayidx89.6, align 4
  %cmp90.6 = icmp eq i32 %166, 255
  br i1 %cmp90.6, label %if.then143.6, label %lor.lhs.false92.6

lor.lhs.false92.6:                                ; preds = %lor.lhs.false84.6
  %add96.6 = add i32 %sub78.6, -127
  %idxprom97.6 = sext i32 %add96.6 to i64
  %arrayidx98.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.6
  %167 = load i32, i32* %arrayidx98.6, align 4
  %cmp99.6 = icmp eq i32 %167, 255
  br i1 %cmp99.6, label %if.then143.6, label %lor.lhs.false101.6

lor.lhs.false101.6:                               ; preds = %lor.lhs.false92.6
  %168 = trunc i64 %indvars.iv.6 to i32
  %add104.6 = add i32 %sub103.6, %168
  %idxprom105.6 = sext i32 %add104.6 to i64
  %arrayidx106.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.6
  %169 = load i32, i32* %arrayidx106.6, align 4
  %cmp107.6 = icmp eq i32 %169, 255
  br i1 %cmp107.6, label %if.then143.6, label %lor.lhs.false109.6

lor.lhs.false109.6:                               ; preds = %lor.lhs.false101.6
  %170 = trunc i64 %indvars.iv.6 to i32
  %add112.6 = add i32 %add111.6, %170
  %idxprom113.6 = sext i32 %add112.6 to i64
  %arrayidx114.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.6
  %171 = load i32, i32* %arrayidx114.6, align 4
  %cmp115.6 = icmp eq i32 %171, 255
  br i1 %cmp115.6, label %if.then143.6, label %lor.lhs.false117.6

lor.lhs.false117.6:                               ; preds = %lor.lhs.false109.6
  %add121.6 = add i32 %sub78.6, 127
  %idxprom122.6 = sext i32 %add121.6 to i64
  %arrayidx123.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.6
  %172 = load i32, i32* %arrayidx123.6, align 4
  %cmp124.6 = icmp eq i32 %172, 255
  br i1 %cmp124.6, label %if.then143.6, label %lor.lhs.false126.6

lor.lhs.false126.6:                               ; preds = %lor.lhs.false117.6
  %173 = add nsw i64 %159, %indvars.iv.6
  %arrayidx131.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %173
  %174 = load i32, i32* %arrayidx131.6, align 4
  %cmp132.6 = icmp eq i32 %174, 255
  br i1 %cmp132.6, label %if.then143.6, label %lor.lhs.false134.6

lor.lhs.false134.6:                               ; preds = %lor.lhs.false126.6
  %add138.6 = add i32 %sub78.6, 129
  %idxprom139.6 = sext i32 %add138.6 to i64
  %arrayidx140.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.6
  %175 = load i32, i32* %arrayidx140.6, align 4
  %cmp141.6 = icmp eq i32 %175, 255
  br i1 %cmp141.6, label %if.then143.6, label %if.else146.6

if.else146.6:                                     ; preds = %lor.lhs.false134.6
  %arrayidx148.6 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %161
  store i8 0, i8* %arrayidx148.6, align 1
  br label %for.inc158.6

if.then143.6:                                     ; preds = %lor.lhs.false134.6, %lor.lhs.false126.6, %lor.lhs.false117.6, %lor.lhs.false109.6, %lor.lhs.false101.6, %lor.lhs.false92.6, %lor.lhs.false84.6, %if.then75.6
  %arrayidx145.6 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %161
  store i8 -1, i8* %arrayidx145.6, align 1
  br label %for.inc158.6

if.then67.6:                                      ; preds = %for.body53.6
  %arrayidx69.6 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %161
  store i8 0, i8* %arrayidx69.6, align 1
  br label %for.inc158.6

for.inc158.6:                                     ; preds = %if.then67.6, %if.then143.6, %if.else146.6, %if.else150.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %img_width
  br i1 %exitcond.6, label %for.inc161.6, label %for.body53.6, !llvm.loop !5

for.inc161.6:                                     ; preds = %for.inc158.6
  %indvars.iv.next21.6 = add nsw i64 %indvars.iv20, 7
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.7

for.body53.lr.ph.7:                               ; preds = %for.inc161.6
  %176 = trunc i64 %indvars.iv.next21.6 to i32
  %mul55.7 = shl nsw i32 %176, 7
  %cmp59.7 = icmp eq i64 %indvars.iv.next21.6, %11
  %177 = trunc i64 %indvars.iv.next21.6 to i32
  %sub76.7 = shl i32 %177, 7
  %mul86.7 = add i32 %sub76.7, -128
  %sub103.7 = add i32 %mul55.7, -1
  %add111.7 = or i32 %mul55.7, 1
  %mul128.7 = add i32 %sub76.7, 128
  %178 = sext i32 %mul55.7 to i64
  %179 = sext i32 %mul128.7 to i64
  %180 = sext i32 %mul86.7 to i64
  br label %for.body53.7

for.body53.7:                                     ; preds = %for.inc158.7, %for.body53.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body53.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc158.7 ]
  %181 = add nsw i64 %indvars.iv.7, %178
  %cmp62.7 = icmp eq i64 %indvars.iv.7, 0
  %or.cond1.7 = or i1 %cmp59.7, %cmp62.7
  %cmp65.7 = icmp eq i64 %indvars.iv.7, %10
  %or.cond2.7 = or i1 %cmp65.7, %or.cond1.7
  br i1 %or.cond2.7, label %if.then67.7, label %if.else70.7

if.else70.7:                                      ; preds = %for.body53.7
  %arrayidx72.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %181
  %182 = load i32, i32* %arrayidx72.7, align 4
  %cmp73.7 = icmp eq i32 %182, 75
  br i1 %cmp73.7, label %if.then75.7, label %if.else150.7

if.else150.7:                                     ; preds = %if.else70.7
  %conv153.7 = trunc i32 %182 to i8
  %arrayidx155.7 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %181
  store i8 %conv153.7, i8* %arrayidx155.7, align 1
  br label %for.inc158.7

if.then75.7:                                      ; preds = %if.else70.7
  %183 = trunc i64 %indvars.iv.7 to i32
  %sub78.7 = add i32 %183, %sub76.7
  %add79.7 = add i32 %sub78.7, -129
  %idxprom80.7 = sext i32 %add79.7 to i64
  %arrayidx81.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.7
  %184 = load i32, i32* %arrayidx81.7, align 4
  %cmp82.7 = icmp eq i32 %184, 255
  br i1 %cmp82.7, label %if.then143.7, label %lor.lhs.false84.7

lor.lhs.false84.7:                                ; preds = %if.then75.7
  %185 = add nsw i64 %180, %indvars.iv.7
  %arrayidx89.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %185
  %186 = load i32, i32* %arrayidx89.7, align 4
  %cmp90.7 = icmp eq i32 %186, 255
  br i1 %cmp90.7, label %if.then143.7, label %lor.lhs.false92.7

lor.lhs.false92.7:                                ; preds = %lor.lhs.false84.7
  %add96.7 = add i32 %sub78.7, -127
  %idxprom97.7 = sext i32 %add96.7 to i64
  %arrayidx98.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.7
  %187 = load i32, i32* %arrayidx98.7, align 4
  %cmp99.7 = icmp eq i32 %187, 255
  br i1 %cmp99.7, label %if.then143.7, label %lor.lhs.false101.7

lor.lhs.false101.7:                               ; preds = %lor.lhs.false92.7
  %188 = trunc i64 %indvars.iv.7 to i32
  %add104.7 = add i32 %sub103.7, %188
  %idxprom105.7 = sext i32 %add104.7 to i64
  %arrayidx106.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.7
  %189 = load i32, i32* %arrayidx106.7, align 4
  %cmp107.7 = icmp eq i32 %189, 255
  br i1 %cmp107.7, label %if.then143.7, label %lor.lhs.false109.7

lor.lhs.false109.7:                               ; preds = %lor.lhs.false101.7
  %190 = trunc i64 %indvars.iv.7 to i32
  %add112.7 = add i32 %add111.7, %190
  %idxprom113.7 = sext i32 %add112.7 to i64
  %arrayidx114.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.7
  %191 = load i32, i32* %arrayidx114.7, align 4
  %cmp115.7 = icmp eq i32 %191, 255
  br i1 %cmp115.7, label %if.then143.7, label %lor.lhs.false117.7

lor.lhs.false117.7:                               ; preds = %lor.lhs.false109.7
  %add121.7 = add i32 %sub78.7, 127
  %idxprom122.7 = sext i32 %add121.7 to i64
  %arrayidx123.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.7
  %192 = load i32, i32* %arrayidx123.7, align 4
  %cmp124.7 = icmp eq i32 %192, 255
  br i1 %cmp124.7, label %if.then143.7, label %lor.lhs.false126.7

lor.lhs.false126.7:                               ; preds = %lor.lhs.false117.7
  %193 = add nsw i64 %179, %indvars.iv.7
  %arrayidx131.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %193
  %194 = load i32, i32* %arrayidx131.7, align 4
  %cmp132.7 = icmp eq i32 %194, 255
  br i1 %cmp132.7, label %if.then143.7, label %lor.lhs.false134.7

lor.lhs.false134.7:                               ; preds = %lor.lhs.false126.7
  %add138.7 = add i32 %sub78.7, 129
  %idxprom139.7 = sext i32 %add138.7 to i64
  %arrayidx140.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.7
  %195 = load i32, i32* %arrayidx140.7, align 4
  %cmp141.7 = icmp eq i32 %195, 255
  br i1 %cmp141.7, label %if.then143.7, label %if.else146.7

if.else146.7:                                     ; preds = %lor.lhs.false134.7
  %arrayidx148.7 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %181
  store i8 0, i8* %arrayidx148.7, align 1
  br label %for.inc158.7

if.then143.7:                                     ; preds = %lor.lhs.false134.7, %lor.lhs.false126.7, %lor.lhs.false117.7, %lor.lhs.false109.7, %lor.lhs.false101.7, %lor.lhs.false92.7, %lor.lhs.false84.7, %if.then75.7
  %arrayidx145.7 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %181
  store i8 -1, i8* %arrayidx145.7, align 1
  br label %for.inc158.7

if.then67.7:                                      ; preds = %for.body53.7
  %arrayidx69.7 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %181
  store i8 0, i8* %arrayidx69.7, align 1
  br label %for.inc158.7

for.inc158.7:                                     ; preds = %if.then67.7, %if.then143.7, %if.else146.7, %if.else150.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %img_width
  br i1 %exitcond.7, label %for.inc161.7, label %for.body53.7, !llvm.loop !5

for.inc161.7:                                     ; preds = %for.inc158.7
  %indvars.iv.next21.7 = add nsw i64 %indvars.iv20, 8
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.8

for.body53.lr.ph.8:                               ; preds = %for.inc161.7
  %196 = trunc i64 %indvars.iv.next21.7 to i32
  %mul55.8 = shl nsw i32 %196, 7
  %cmp59.8 = icmp eq i64 %indvars.iv.next21.7, %11
  %197 = trunc i64 %indvars.iv.next21.7 to i32
  %sub76.8 = shl i32 %197, 7
  %mul86.8 = add i32 %sub76.8, -128
  %sub103.8 = add i32 %mul55.8, -1
  %add111.8 = or i32 %mul55.8, 1
  %mul128.8 = add i32 %sub76.8, 128
  %198 = sext i32 %mul55.8 to i64
  %199 = sext i32 %mul128.8 to i64
  %200 = sext i32 %mul86.8 to i64
  br label %for.body53.8

for.body53.8:                                     ; preds = %for.inc158.8, %for.body53.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body53.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc158.8 ]
  %201 = add nsw i64 %indvars.iv.8, %198
  %cmp62.8 = icmp eq i64 %indvars.iv.8, 0
  %or.cond1.8 = or i1 %cmp59.8, %cmp62.8
  %cmp65.8 = icmp eq i64 %indvars.iv.8, %10
  %or.cond2.8 = or i1 %cmp65.8, %or.cond1.8
  br i1 %or.cond2.8, label %if.then67.8, label %if.else70.8

if.else70.8:                                      ; preds = %for.body53.8
  %arrayidx72.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %201
  %202 = load i32, i32* %arrayidx72.8, align 4
  %cmp73.8 = icmp eq i32 %202, 75
  br i1 %cmp73.8, label %if.then75.8, label %if.else150.8

if.else150.8:                                     ; preds = %if.else70.8
  %conv153.8 = trunc i32 %202 to i8
  %arrayidx155.8 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %201
  store i8 %conv153.8, i8* %arrayidx155.8, align 1
  br label %for.inc158.8

if.then75.8:                                      ; preds = %if.else70.8
  %203 = trunc i64 %indvars.iv.8 to i32
  %sub78.8 = add i32 %203, %sub76.8
  %add79.8 = add i32 %sub78.8, -129
  %idxprom80.8 = sext i32 %add79.8 to i64
  %arrayidx81.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.8
  %204 = load i32, i32* %arrayidx81.8, align 4
  %cmp82.8 = icmp eq i32 %204, 255
  br i1 %cmp82.8, label %if.then143.8, label %lor.lhs.false84.8

lor.lhs.false84.8:                                ; preds = %if.then75.8
  %205 = add nsw i64 %200, %indvars.iv.8
  %arrayidx89.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %205
  %206 = load i32, i32* %arrayidx89.8, align 4
  %cmp90.8 = icmp eq i32 %206, 255
  br i1 %cmp90.8, label %if.then143.8, label %lor.lhs.false92.8

lor.lhs.false92.8:                                ; preds = %lor.lhs.false84.8
  %add96.8 = add i32 %sub78.8, -127
  %idxprom97.8 = sext i32 %add96.8 to i64
  %arrayidx98.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.8
  %207 = load i32, i32* %arrayidx98.8, align 4
  %cmp99.8 = icmp eq i32 %207, 255
  br i1 %cmp99.8, label %if.then143.8, label %lor.lhs.false101.8

lor.lhs.false101.8:                               ; preds = %lor.lhs.false92.8
  %208 = trunc i64 %indvars.iv.8 to i32
  %add104.8 = add i32 %sub103.8, %208
  %idxprom105.8 = sext i32 %add104.8 to i64
  %arrayidx106.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.8
  %209 = load i32, i32* %arrayidx106.8, align 4
  %cmp107.8 = icmp eq i32 %209, 255
  br i1 %cmp107.8, label %if.then143.8, label %lor.lhs.false109.8

lor.lhs.false109.8:                               ; preds = %lor.lhs.false101.8
  %210 = trunc i64 %indvars.iv.8 to i32
  %add112.8 = add i32 %add111.8, %210
  %idxprom113.8 = sext i32 %add112.8 to i64
  %arrayidx114.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.8
  %211 = load i32, i32* %arrayidx114.8, align 4
  %cmp115.8 = icmp eq i32 %211, 255
  br i1 %cmp115.8, label %if.then143.8, label %lor.lhs.false117.8

lor.lhs.false117.8:                               ; preds = %lor.lhs.false109.8
  %add121.8 = add i32 %sub78.8, 127
  %idxprom122.8 = sext i32 %add121.8 to i64
  %arrayidx123.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.8
  %212 = load i32, i32* %arrayidx123.8, align 4
  %cmp124.8 = icmp eq i32 %212, 255
  br i1 %cmp124.8, label %if.then143.8, label %lor.lhs.false126.8

lor.lhs.false126.8:                               ; preds = %lor.lhs.false117.8
  %213 = add nsw i64 %199, %indvars.iv.8
  %arrayidx131.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %213
  %214 = load i32, i32* %arrayidx131.8, align 4
  %cmp132.8 = icmp eq i32 %214, 255
  br i1 %cmp132.8, label %if.then143.8, label %lor.lhs.false134.8

lor.lhs.false134.8:                               ; preds = %lor.lhs.false126.8
  %add138.8 = add i32 %sub78.8, 129
  %idxprom139.8 = sext i32 %add138.8 to i64
  %arrayidx140.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.8
  %215 = load i32, i32* %arrayidx140.8, align 4
  %cmp141.8 = icmp eq i32 %215, 255
  br i1 %cmp141.8, label %if.then143.8, label %if.else146.8

if.else146.8:                                     ; preds = %lor.lhs.false134.8
  %arrayidx148.8 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %201
  store i8 0, i8* %arrayidx148.8, align 1
  br label %for.inc158.8

if.then143.8:                                     ; preds = %lor.lhs.false134.8, %lor.lhs.false126.8, %lor.lhs.false117.8, %lor.lhs.false109.8, %lor.lhs.false101.8, %lor.lhs.false92.8, %lor.lhs.false84.8, %if.then75.8
  %arrayidx145.8 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %201
  store i8 -1, i8* %arrayidx145.8, align 1
  br label %for.inc158.8

if.then67.8:                                      ; preds = %for.body53.8
  %arrayidx69.8 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %201
  store i8 0, i8* %arrayidx69.8, align 1
  br label %for.inc158.8

for.inc158.8:                                     ; preds = %if.then67.8, %if.then143.8, %if.else146.8, %if.else150.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %img_width
  br i1 %exitcond.8, label %for.inc161.8, label %for.body53.8, !llvm.loop !5

for.inc161.8:                                     ; preds = %for.inc158.8
  %indvars.iv.next21.8 = add nsw i64 %indvars.iv20, 9
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.9

for.body53.lr.ph.9:                               ; preds = %for.inc161.8
  %216 = trunc i64 %indvars.iv.next21.8 to i32
  %mul55.9 = shl nsw i32 %216, 7
  %cmp59.9 = icmp eq i64 %indvars.iv.next21.8, %11
  %217 = trunc i64 %indvars.iv.next21.8 to i32
  %sub76.9 = shl i32 %217, 7
  %mul86.9 = add i32 %sub76.9, -128
  %sub103.9 = add i32 %mul55.9, -1
  %add111.9 = or i32 %mul55.9, 1
  %mul128.9 = add i32 %sub76.9, 128
  %218 = sext i32 %mul55.9 to i64
  %219 = sext i32 %mul128.9 to i64
  %220 = sext i32 %mul86.9 to i64
  br label %for.body53.9

for.body53.9:                                     ; preds = %for.inc158.9, %for.body53.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body53.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc158.9 ]
  %221 = add nsw i64 %indvars.iv.9, %218
  %cmp62.9 = icmp eq i64 %indvars.iv.9, 0
  %or.cond1.9 = or i1 %cmp59.9, %cmp62.9
  %cmp65.9 = icmp eq i64 %indvars.iv.9, %10
  %or.cond2.9 = or i1 %cmp65.9, %or.cond1.9
  br i1 %or.cond2.9, label %if.then67.9, label %if.else70.9

if.else70.9:                                      ; preds = %for.body53.9
  %arrayidx72.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %221
  %222 = load i32, i32* %arrayidx72.9, align 4
  %cmp73.9 = icmp eq i32 %222, 75
  br i1 %cmp73.9, label %if.then75.9, label %if.else150.9

if.else150.9:                                     ; preds = %if.else70.9
  %conv153.9 = trunc i32 %222 to i8
  %arrayidx155.9 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %221
  store i8 %conv153.9, i8* %arrayidx155.9, align 1
  br label %for.inc158.9

if.then75.9:                                      ; preds = %if.else70.9
  %223 = trunc i64 %indvars.iv.9 to i32
  %sub78.9 = add i32 %223, %sub76.9
  %add79.9 = add i32 %sub78.9, -129
  %idxprom80.9 = sext i32 %add79.9 to i64
  %arrayidx81.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.9
  %224 = load i32, i32* %arrayidx81.9, align 4
  %cmp82.9 = icmp eq i32 %224, 255
  br i1 %cmp82.9, label %if.then143.9, label %lor.lhs.false84.9

lor.lhs.false84.9:                                ; preds = %if.then75.9
  %225 = add nsw i64 %220, %indvars.iv.9
  %arrayidx89.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %225
  %226 = load i32, i32* %arrayidx89.9, align 4
  %cmp90.9 = icmp eq i32 %226, 255
  br i1 %cmp90.9, label %if.then143.9, label %lor.lhs.false92.9

lor.lhs.false92.9:                                ; preds = %lor.lhs.false84.9
  %add96.9 = add i32 %sub78.9, -127
  %idxprom97.9 = sext i32 %add96.9 to i64
  %arrayidx98.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.9
  %227 = load i32, i32* %arrayidx98.9, align 4
  %cmp99.9 = icmp eq i32 %227, 255
  br i1 %cmp99.9, label %if.then143.9, label %lor.lhs.false101.9

lor.lhs.false101.9:                               ; preds = %lor.lhs.false92.9
  %228 = trunc i64 %indvars.iv.9 to i32
  %add104.9 = add i32 %sub103.9, %228
  %idxprom105.9 = sext i32 %add104.9 to i64
  %arrayidx106.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.9
  %229 = load i32, i32* %arrayidx106.9, align 4
  %cmp107.9 = icmp eq i32 %229, 255
  br i1 %cmp107.9, label %if.then143.9, label %lor.lhs.false109.9

lor.lhs.false109.9:                               ; preds = %lor.lhs.false101.9
  %230 = trunc i64 %indvars.iv.9 to i32
  %add112.9 = add i32 %add111.9, %230
  %idxprom113.9 = sext i32 %add112.9 to i64
  %arrayidx114.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.9
  %231 = load i32, i32* %arrayidx114.9, align 4
  %cmp115.9 = icmp eq i32 %231, 255
  br i1 %cmp115.9, label %if.then143.9, label %lor.lhs.false117.9

lor.lhs.false117.9:                               ; preds = %lor.lhs.false109.9
  %add121.9 = add i32 %sub78.9, 127
  %idxprom122.9 = sext i32 %add121.9 to i64
  %arrayidx123.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.9
  %232 = load i32, i32* %arrayidx123.9, align 4
  %cmp124.9 = icmp eq i32 %232, 255
  br i1 %cmp124.9, label %if.then143.9, label %lor.lhs.false126.9

lor.lhs.false126.9:                               ; preds = %lor.lhs.false117.9
  %233 = add nsw i64 %219, %indvars.iv.9
  %arrayidx131.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %233
  %234 = load i32, i32* %arrayidx131.9, align 4
  %cmp132.9 = icmp eq i32 %234, 255
  br i1 %cmp132.9, label %if.then143.9, label %lor.lhs.false134.9

lor.lhs.false134.9:                               ; preds = %lor.lhs.false126.9
  %add138.9 = add i32 %sub78.9, 129
  %idxprom139.9 = sext i32 %add138.9 to i64
  %arrayidx140.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.9
  %235 = load i32, i32* %arrayidx140.9, align 4
  %cmp141.9 = icmp eq i32 %235, 255
  br i1 %cmp141.9, label %if.then143.9, label %if.else146.9

if.else146.9:                                     ; preds = %lor.lhs.false134.9
  %arrayidx148.9 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %221
  store i8 0, i8* %arrayidx148.9, align 1
  br label %for.inc158.9

if.then143.9:                                     ; preds = %lor.lhs.false134.9, %lor.lhs.false126.9, %lor.lhs.false117.9, %lor.lhs.false109.9, %lor.lhs.false101.9, %lor.lhs.false92.9, %lor.lhs.false84.9, %if.then75.9
  %arrayidx145.9 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %221
  store i8 -1, i8* %arrayidx145.9, align 1
  br label %for.inc158.9

if.then67.9:                                      ; preds = %for.body53.9
  %arrayidx69.9 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %221
  store i8 0, i8* %arrayidx69.9, align 1
  br label %for.inc158.9

for.inc158.9:                                     ; preds = %if.then67.9, %if.then143.9, %if.else146.9, %if.else150.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %img_width
  br i1 %exitcond.9, label %for.inc161.9, label %for.body53.9, !llvm.loop !5

for.inc161.9:                                     ; preds = %for.inc158.9
  %indvars.iv.next21.9 = add nsw i64 %indvars.iv20, 10
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.10

for.body53.lr.ph.10:                              ; preds = %for.inc161.9
  %236 = trunc i64 %indvars.iv.next21.9 to i32
  %mul55.10 = shl nsw i32 %236, 7
  %cmp59.10 = icmp eq i64 %indvars.iv.next21.9, %11
  %237 = trunc i64 %indvars.iv.next21.9 to i32
  %sub76.10 = shl i32 %237, 7
  %mul86.10 = add i32 %sub76.10, -128
  %sub103.10 = add i32 %mul55.10, -1
  %add111.10 = or i32 %mul55.10, 1
  %mul128.10 = add i32 %sub76.10, 128
  %238 = sext i32 %mul55.10 to i64
  %239 = sext i32 %mul128.10 to i64
  %240 = sext i32 %mul86.10 to i64
  br label %for.body53.10

for.body53.10:                                    ; preds = %for.inc158.10, %for.body53.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body53.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc158.10 ]
  %241 = add nsw i64 %indvars.iv.10, %238
  %cmp62.10 = icmp eq i64 %indvars.iv.10, 0
  %or.cond1.10 = or i1 %cmp59.10, %cmp62.10
  %cmp65.10 = icmp eq i64 %indvars.iv.10, %10
  %or.cond2.10 = or i1 %cmp65.10, %or.cond1.10
  br i1 %or.cond2.10, label %if.then67.10, label %if.else70.10

if.else70.10:                                     ; preds = %for.body53.10
  %arrayidx72.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %241
  %242 = load i32, i32* %arrayidx72.10, align 4
  %cmp73.10 = icmp eq i32 %242, 75
  br i1 %cmp73.10, label %if.then75.10, label %if.else150.10

if.else150.10:                                    ; preds = %if.else70.10
  %conv153.10 = trunc i32 %242 to i8
  %arrayidx155.10 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %241
  store i8 %conv153.10, i8* %arrayidx155.10, align 1
  br label %for.inc158.10

if.then75.10:                                     ; preds = %if.else70.10
  %243 = trunc i64 %indvars.iv.10 to i32
  %sub78.10 = add i32 %243, %sub76.10
  %add79.10 = add i32 %sub78.10, -129
  %idxprom80.10 = sext i32 %add79.10 to i64
  %arrayidx81.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.10
  %244 = load i32, i32* %arrayidx81.10, align 4
  %cmp82.10 = icmp eq i32 %244, 255
  br i1 %cmp82.10, label %if.then143.10, label %lor.lhs.false84.10

lor.lhs.false84.10:                               ; preds = %if.then75.10
  %245 = add nsw i64 %240, %indvars.iv.10
  %arrayidx89.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %245
  %246 = load i32, i32* %arrayidx89.10, align 4
  %cmp90.10 = icmp eq i32 %246, 255
  br i1 %cmp90.10, label %if.then143.10, label %lor.lhs.false92.10

lor.lhs.false92.10:                               ; preds = %lor.lhs.false84.10
  %add96.10 = add i32 %sub78.10, -127
  %idxprom97.10 = sext i32 %add96.10 to i64
  %arrayidx98.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.10
  %247 = load i32, i32* %arrayidx98.10, align 4
  %cmp99.10 = icmp eq i32 %247, 255
  br i1 %cmp99.10, label %if.then143.10, label %lor.lhs.false101.10

lor.lhs.false101.10:                              ; preds = %lor.lhs.false92.10
  %248 = trunc i64 %indvars.iv.10 to i32
  %add104.10 = add i32 %sub103.10, %248
  %idxprom105.10 = sext i32 %add104.10 to i64
  %arrayidx106.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.10
  %249 = load i32, i32* %arrayidx106.10, align 4
  %cmp107.10 = icmp eq i32 %249, 255
  br i1 %cmp107.10, label %if.then143.10, label %lor.lhs.false109.10

lor.lhs.false109.10:                              ; preds = %lor.lhs.false101.10
  %250 = trunc i64 %indvars.iv.10 to i32
  %add112.10 = add i32 %add111.10, %250
  %idxprom113.10 = sext i32 %add112.10 to i64
  %arrayidx114.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.10
  %251 = load i32, i32* %arrayidx114.10, align 4
  %cmp115.10 = icmp eq i32 %251, 255
  br i1 %cmp115.10, label %if.then143.10, label %lor.lhs.false117.10

lor.lhs.false117.10:                              ; preds = %lor.lhs.false109.10
  %add121.10 = add i32 %sub78.10, 127
  %idxprom122.10 = sext i32 %add121.10 to i64
  %arrayidx123.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.10
  %252 = load i32, i32* %arrayidx123.10, align 4
  %cmp124.10 = icmp eq i32 %252, 255
  br i1 %cmp124.10, label %if.then143.10, label %lor.lhs.false126.10

lor.lhs.false126.10:                              ; preds = %lor.lhs.false117.10
  %253 = add nsw i64 %239, %indvars.iv.10
  %arrayidx131.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %253
  %254 = load i32, i32* %arrayidx131.10, align 4
  %cmp132.10 = icmp eq i32 %254, 255
  br i1 %cmp132.10, label %if.then143.10, label %lor.lhs.false134.10

lor.lhs.false134.10:                              ; preds = %lor.lhs.false126.10
  %add138.10 = add i32 %sub78.10, 129
  %idxprom139.10 = sext i32 %add138.10 to i64
  %arrayidx140.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.10
  %255 = load i32, i32* %arrayidx140.10, align 4
  %cmp141.10 = icmp eq i32 %255, 255
  br i1 %cmp141.10, label %if.then143.10, label %if.else146.10

if.else146.10:                                    ; preds = %lor.lhs.false134.10
  %arrayidx148.10 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %241
  store i8 0, i8* %arrayidx148.10, align 1
  br label %for.inc158.10

if.then143.10:                                    ; preds = %lor.lhs.false134.10, %lor.lhs.false126.10, %lor.lhs.false117.10, %lor.lhs.false109.10, %lor.lhs.false101.10, %lor.lhs.false92.10, %lor.lhs.false84.10, %if.then75.10
  %arrayidx145.10 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %241
  store i8 -1, i8* %arrayidx145.10, align 1
  br label %for.inc158.10

if.then67.10:                                     ; preds = %for.body53.10
  %arrayidx69.10 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %241
  store i8 0, i8* %arrayidx69.10, align 1
  br label %for.inc158.10

for.inc158.10:                                    ; preds = %if.then67.10, %if.then143.10, %if.else146.10, %if.else150.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %img_width
  br i1 %exitcond.10, label %for.inc161.10, label %for.body53.10, !llvm.loop !5

for.inc161.10:                                    ; preds = %for.inc158.10
  %indvars.iv.next21.10 = add nsw i64 %indvars.iv20, 11
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.11

for.body53.lr.ph.11:                              ; preds = %for.inc161.10
  %256 = trunc i64 %indvars.iv.next21.10 to i32
  %mul55.11 = shl nsw i32 %256, 7
  %cmp59.11 = icmp eq i64 %indvars.iv.next21.10, %11
  %257 = trunc i64 %indvars.iv.next21.10 to i32
  %sub76.11 = shl i32 %257, 7
  %mul86.11 = add i32 %sub76.11, -128
  %sub103.11 = add i32 %mul55.11, -1
  %add111.11 = or i32 %mul55.11, 1
  %mul128.11 = add i32 %sub76.11, 128
  %258 = sext i32 %mul55.11 to i64
  %259 = sext i32 %mul128.11 to i64
  %260 = sext i32 %mul86.11 to i64
  br label %for.body53.11

for.body53.11:                                    ; preds = %for.inc158.11, %for.body53.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body53.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc158.11 ]
  %261 = add nsw i64 %indvars.iv.11, %258
  %cmp62.11 = icmp eq i64 %indvars.iv.11, 0
  %or.cond1.11 = or i1 %cmp59.11, %cmp62.11
  %cmp65.11 = icmp eq i64 %indvars.iv.11, %10
  %or.cond2.11 = or i1 %cmp65.11, %or.cond1.11
  br i1 %or.cond2.11, label %if.then67.11, label %if.else70.11

if.else70.11:                                     ; preds = %for.body53.11
  %arrayidx72.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %261
  %262 = load i32, i32* %arrayidx72.11, align 4
  %cmp73.11 = icmp eq i32 %262, 75
  br i1 %cmp73.11, label %if.then75.11, label %if.else150.11

if.else150.11:                                    ; preds = %if.else70.11
  %conv153.11 = trunc i32 %262 to i8
  %arrayidx155.11 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %261
  store i8 %conv153.11, i8* %arrayidx155.11, align 1
  br label %for.inc158.11

if.then75.11:                                     ; preds = %if.else70.11
  %263 = trunc i64 %indvars.iv.11 to i32
  %sub78.11 = add i32 %263, %sub76.11
  %add79.11 = add i32 %sub78.11, -129
  %idxprom80.11 = sext i32 %add79.11 to i64
  %arrayidx81.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.11
  %264 = load i32, i32* %arrayidx81.11, align 4
  %cmp82.11 = icmp eq i32 %264, 255
  br i1 %cmp82.11, label %if.then143.11, label %lor.lhs.false84.11

lor.lhs.false84.11:                               ; preds = %if.then75.11
  %265 = add nsw i64 %260, %indvars.iv.11
  %arrayidx89.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %265
  %266 = load i32, i32* %arrayidx89.11, align 4
  %cmp90.11 = icmp eq i32 %266, 255
  br i1 %cmp90.11, label %if.then143.11, label %lor.lhs.false92.11

lor.lhs.false92.11:                               ; preds = %lor.lhs.false84.11
  %add96.11 = add i32 %sub78.11, -127
  %idxprom97.11 = sext i32 %add96.11 to i64
  %arrayidx98.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.11
  %267 = load i32, i32* %arrayidx98.11, align 4
  %cmp99.11 = icmp eq i32 %267, 255
  br i1 %cmp99.11, label %if.then143.11, label %lor.lhs.false101.11

lor.lhs.false101.11:                              ; preds = %lor.lhs.false92.11
  %268 = trunc i64 %indvars.iv.11 to i32
  %add104.11 = add i32 %sub103.11, %268
  %idxprom105.11 = sext i32 %add104.11 to i64
  %arrayidx106.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.11
  %269 = load i32, i32* %arrayidx106.11, align 4
  %cmp107.11 = icmp eq i32 %269, 255
  br i1 %cmp107.11, label %if.then143.11, label %lor.lhs.false109.11

lor.lhs.false109.11:                              ; preds = %lor.lhs.false101.11
  %270 = trunc i64 %indvars.iv.11 to i32
  %add112.11 = add i32 %add111.11, %270
  %idxprom113.11 = sext i32 %add112.11 to i64
  %arrayidx114.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.11
  %271 = load i32, i32* %arrayidx114.11, align 4
  %cmp115.11 = icmp eq i32 %271, 255
  br i1 %cmp115.11, label %if.then143.11, label %lor.lhs.false117.11

lor.lhs.false117.11:                              ; preds = %lor.lhs.false109.11
  %add121.11 = add i32 %sub78.11, 127
  %idxprom122.11 = sext i32 %add121.11 to i64
  %arrayidx123.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.11
  %272 = load i32, i32* %arrayidx123.11, align 4
  %cmp124.11 = icmp eq i32 %272, 255
  br i1 %cmp124.11, label %if.then143.11, label %lor.lhs.false126.11

lor.lhs.false126.11:                              ; preds = %lor.lhs.false117.11
  %273 = add nsw i64 %259, %indvars.iv.11
  %arrayidx131.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %273
  %274 = load i32, i32* %arrayidx131.11, align 4
  %cmp132.11 = icmp eq i32 %274, 255
  br i1 %cmp132.11, label %if.then143.11, label %lor.lhs.false134.11

lor.lhs.false134.11:                              ; preds = %lor.lhs.false126.11
  %add138.11 = add i32 %sub78.11, 129
  %idxprom139.11 = sext i32 %add138.11 to i64
  %arrayidx140.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.11
  %275 = load i32, i32* %arrayidx140.11, align 4
  %cmp141.11 = icmp eq i32 %275, 255
  br i1 %cmp141.11, label %if.then143.11, label %if.else146.11

if.else146.11:                                    ; preds = %lor.lhs.false134.11
  %arrayidx148.11 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %261
  store i8 0, i8* %arrayidx148.11, align 1
  br label %for.inc158.11

if.then143.11:                                    ; preds = %lor.lhs.false134.11, %lor.lhs.false126.11, %lor.lhs.false117.11, %lor.lhs.false109.11, %lor.lhs.false101.11, %lor.lhs.false92.11, %lor.lhs.false84.11, %if.then75.11
  %arrayidx145.11 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %261
  store i8 -1, i8* %arrayidx145.11, align 1
  br label %for.inc158.11

if.then67.11:                                     ; preds = %for.body53.11
  %arrayidx69.11 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %261
  store i8 0, i8* %arrayidx69.11, align 1
  br label %for.inc158.11

for.inc158.11:                                    ; preds = %if.then67.11, %if.then143.11, %if.else146.11, %if.else150.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %img_width
  br i1 %exitcond.11, label %for.inc161.11, label %for.body53.11, !llvm.loop !5

for.inc161.11:                                    ; preds = %for.inc158.11
  %indvars.iv.next21.11 = add nsw i64 %indvars.iv20, 12
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.12

for.body53.lr.ph.12:                              ; preds = %for.inc161.11
  %276 = trunc i64 %indvars.iv.next21.11 to i32
  %mul55.12 = shl nsw i32 %276, 7
  %cmp59.12 = icmp eq i64 %indvars.iv.next21.11, %11
  %277 = trunc i64 %indvars.iv.next21.11 to i32
  %sub76.12 = shl i32 %277, 7
  %mul86.12 = add i32 %sub76.12, -128
  %sub103.12 = add i32 %mul55.12, -1
  %add111.12 = or i32 %mul55.12, 1
  %mul128.12 = add i32 %sub76.12, 128
  %278 = sext i32 %mul55.12 to i64
  %279 = sext i32 %mul128.12 to i64
  %280 = sext i32 %mul86.12 to i64
  br label %for.body53.12

for.body53.12:                                    ; preds = %for.inc158.12, %for.body53.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body53.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc158.12 ]
  %281 = add nsw i64 %indvars.iv.12, %278
  %cmp62.12 = icmp eq i64 %indvars.iv.12, 0
  %or.cond1.12 = or i1 %cmp59.12, %cmp62.12
  %cmp65.12 = icmp eq i64 %indvars.iv.12, %10
  %or.cond2.12 = or i1 %cmp65.12, %or.cond1.12
  br i1 %or.cond2.12, label %if.then67.12, label %if.else70.12

if.else70.12:                                     ; preds = %for.body53.12
  %arrayidx72.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %281
  %282 = load i32, i32* %arrayidx72.12, align 4
  %cmp73.12 = icmp eq i32 %282, 75
  br i1 %cmp73.12, label %if.then75.12, label %if.else150.12

if.else150.12:                                    ; preds = %if.else70.12
  %conv153.12 = trunc i32 %282 to i8
  %arrayidx155.12 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %281
  store i8 %conv153.12, i8* %arrayidx155.12, align 1
  br label %for.inc158.12

if.then75.12:                                     ; preds = %if.else70.12
  %283 = trunc i64 %indvars.iv.12 to i32
  %sub78.12 = add i32 %283, %sub76.12
  %add79.12 = add i32 %sub78.12, -129
  %idxprom80.12 = sext i32 %add79.12 to i64
  %arrayidx81.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.12
  %284 = load i32, i32* %arrayidx81.12, align 4
  %cmp82.12 = icmp eq i32 %284, 255
  br i1 %cmp82.12, label %if.then143.12, label %lor.lhs.false84.12

lor.lhs.false84.12:                               ; preds = %if.then75.12
  %285 = add nsw i64 %280, %indvars.iv.12
  %arrayidx89.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %285
  %286 = load i32, i32* %arrayidx89.12, align 4
  %cmp90.12 = icmp eq i32 %286, 255
  br i1 %cmp90.12, label %if.then143.12, label %lor.lhs.false92.12

lor.lhs.false92.12:                               ; preds = %lor.lhs.false84.12
  %add96.12 = add i32 %sub78.12, -127
  %idxprom97.12 = sext i32 %add96.12 to i64
  %arrayidx98.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.12
  %287 = load i32, i32* %arrayidx98.12, align 4
  %cmp99.12 = icmp eq i32 %287, 255
  br i1 %cmp99.12, label %if.then143.12, label %lor.lhs.false101.12

lor.lhs.false101.12:                              ; preds = %lor.lhs.false92.12
  %288 = trunc i64 %indvars.iv.12 to i32
  %add104.12 = add i32 %sub103.12, %288
  %idxprom105.12 = sext i32 %add104.12 to i64
  %arrayidx106.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.12
  %289 = load i32, i32* %arrayidx106.12, align 4
  %cmp107.12 = icmp eq i32 %289, 255
  br i1 %cmp107.12, label %if.then143.12, label %lor.lhs.false109.12

lor.lhs.false109.12:                              ; preds = %lor.lhs.false101.12
  %290 = trunc i64 %indvars.iv.12 to i32
  %add112.12 = add i32 %add111.12, %290
  %idxprom113.12 = sext i32 %add112.12 to i64
  %arrayidx114.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.12
  %291 = load i32, i32* %arrayidx114.12, align 4
  %cmp115.12 = icmp eq i32 %291, 255
  br i1 %cmp115.12, label %if.then143.12, label %lor.lhs.false117.12

lor.lhs.false117.12:                              ; preds = %lor.lhs.false109.12
  %add121.12 = add i32 %sub78.12, 127
  %idxprom122.12 = sext i32 %add121.12 to i64
  %arrayidx123.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.12
  %292 = load i32, i32* %arrayidx123.12, align 4
  %cmp124.12 = icmp eq i32 %292, 255
  br i1 %cmp124.12, label %if.then143.12, label %lor.lhs.false126.12

lor.lhs.false126.12:                              ; preds = %lor.lhs.false117.12
  %293 = add nsw i64 %279, %indvars.iv.12
  %arrayidx131.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %293
  %294 = load i32, i32* %arrayidx131.12, align 4
  %cmp132.12 = icmp eq i32 %294, 255
  br i1 %cmp132.12, label %if.then143.12, label %lor.lhs.false134.12

lor.lhs.false134.12:                              ; preds = %lor.lhs.false126.12
  %add138.12 = add i32 %sub78.12, 129
  %idxprom139.12 = sext i32 %add138.12 to i64
  %arrayidx140.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.12
  %295 = load i32, i32* %arrayidx140.12, align 4
  %cmp141.12 = icmp eq i32 %295, 255
  br i1 %cmp141.12, label %if.then143.12, label %if.else146.12

if.else146.12:                                    ; preds = %lor.lhs.false134.12
  %arrayidx148.12 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %281
  store i8 0, i8* %arrayidx148.12, align 1
  br label %for.inc158.12

if.then143.12:                                    ; preds = %lor.lhs.false134.12, %lor.lhs.false126.12, %lor.lhs.false117.12, %lor.lhs.false109.12, %lor.lhs.false101.12, %lor.lhs.false92.12, %lor.lhs.false84.12, %if.then75.12
  %arrayidx145.12 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %281
  store i8 -1, i8* %arrayidx145.12, align 1
  br label %for.inc158.12

if.then67.12:                                     ; preds = %for.body53.12
  %arrayidx69.12 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %281
  store i8 0, i8* %arrayidx69.12, align 1
  br label %for.inc158.12

for.inc158.12:                                    ; preds = %if.then67.12, %if.then143.12, %if.else146.12, %if.else150.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %img_width
  br i1 %exitcond.12, label %for.inc161.12, label %for.body53.12, !llvm.loop !5

for.inc161.12:                                    ; preds = %for.inc158.12
  %indvars.iv.next21.12 = add nsw i64 %indvars.iv20, 13
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.13

for.body53.lr.ph.13:                              ; preds = %for.inc161.12
  %296 = trunc i64 %indvars.iv.next21.12 to i32
  %mul55.13 = shl nsw i32 %296, 7
  %cmp59.13 = icmp eq i64 %indvars.iv.next21.12, %11
  %297 = trunc i64 %indvars.iv.next21.12 to i32
  %sub76.13 = shl i32 %297, 7
  %mul86.13 = add i32 %sub76.13, -128
  %sub103.13 = add i32 %mul55.13, -1
  %add111.13 = or i32 %mul55.13, 1
  %mul128.13 = add i32 %sub76.13, 128
  %298 = sext i32 %mul55.13 to i64
  %299 = sext i32 %mul128.13 to i64
  %300 = sext i32 %mul86.13 to i64
  br label %for.body53.13

for.body53.13:                                    ; preds = %for.inc158.13, %for.body53.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body53.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc158.13 ]
  %301 = add nsw i64 %indvars.iv.13, %298
  %cmp62.13 = icmp eq i64 %indvars.iv.13, 0
  %or.cond1.13 = or i1 %cmp59.13, %cmp62.13
  %cmp65.13 = icmp eq i64 %indvars.iv.13, %10
  %or.cond2.13 = or i1 %cmp65.13, %or.cond1.13
  br i1 %or.cond2.13, label %if.then67.13, label %if.else70.13

if.else70.13:                                     ; preds = %for.body53.13
  %arrayidx72.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %301
  %302 = load i32, i32* %arrayidx72.13, align 4
  %cmp73.13 = icmp eq i32 %302, 75
  br i1 %cmp73.13, label %if.then75.13, label %if.else150.13

if.else150.13:                                    ; preds = %if.else70.13
  %conv153.13 = trunc i32 %302 to i8
  %arrayidx155.13 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %301
  store i8 %conv153.13, i8* %arrayidx155.13, align 1
  br label %for.inc158.13

if.then75.13:                                     ; preds = %if.else70.13
  %303 = trunc i64 %indvars.iv.13 to i32
  %sub78.13 = add i32 %303, %sub76.13
  %add79.13 = add i32 %sub78.13, -129
  %idxprom80.13 = sext i32 %add79.13 to i64
  %arrayidx81.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.13
  %304 = load i32, i32* %arrayidx81.13, align 4
  %cmp82.13 = icmp eq i32 %304, 255
  br i1 %cmp82.13, label %if.then143.13, label %lor.lhs.false84.13

lor.lhs.false84.13:                               ; preds = %if.then75.13
  %305 = add nsw i64 %300, %indvars.iv.13
  %arrayidx89.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %305
  %306 = load i32, i32* %arrayidx89.13, align 4
  %cmp90.13 = icmp eq i32 %306, 255
  br i1 %cmp90.13, label %if.then143.13, label %lor.lhs.false92.13

lor.lhs.false92.13:                               ; preds = %lor.lhs.false84.13
  %add96.13 = add i32 %sub78.13, -127
  %idxprom97.13 = sext i32 %add96.13 to i64
  %arrayidx98.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.13
  %307 = load i32, i32* %arrayidx98.13, align 4
  %cmp99.13 = icmp eq i32 %307, 255
  br i1 %cmp99.13, label %if.then143.13, label %lor.lhs.false101.13

lor.lhs.false101.13:                              ; preds = %lor.lhs.false92.13
  %308 = trunc i64 %indvars.iv.13 to i32
  %add104.13 = add i32 %sub103.13, %308
  %idxprom105.13 = sext i32 %add104.13 to i64
  %arrayidx106.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.13
  %309 = load i32, i32* %arrayidx106.13, align 4
  %cmp107.13 = icmp eq i32 %309, 255
  br i1 %cmp107.13, label %if.then143.13, label %lor.lhs.false109.13

lor.lhs.false109.13:                              ; preds = %lor.lhs.false101.13
  %310 = trunc i64 %indvars.iv.13 to i32
  %add112.13 = add i32 %add111.13, %310
  %idxprom113.13 = sext i32 %add112.13 to i64
  %arrayidx114.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.13
  %311 = load i32, i32* %arrayidx114.13, align 4
  %cmp115.13 = icmp eq i32 %311, 255
  br i1 %cmp115.13, label %if.then143.13, label %lor.lhs.false117.13

lor.lhs.false117.13:                              ; preds = %lor.lhs.false109.13
  %add121.13 = add i32 %sub78.13, 127
  %idxprom122.13 = sext i32 %add121.13 to i64
  %arrayidx123.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.13
  %312 = load i32, i32* %arrayidx123.13, align 4
  %cmp124.13 = icmp eq i32 %312, 255
  br i1 %cmp124.13, label %if.then143.13, label %lor.lhs.false126.13

lor.lhs.false126.13:                              ; preds = %lor.lhs.false117.13
  %313 = add nsw i64 %299, %indvars.iv.13
  %arrayidx131.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %313
  %314 = load i32, i32* %arrayidx131.13, align 4
  %cmp132.13 = icmp eq i32 %314, 255
  br i1 %cmp132.13, label %if.then143.13, label %lor.lhs.false134.13

lor.lhs.false134.13:                              ; preds = %lor.lhs.false126.13
  %add138.13 = add i32 %sub78.13, 129
  %idxprom139.13 = sext i32 %add138.13 to i64
  %arrayidx140.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.13
  %315 = load i32, i32* %arrayidx140.13, align 4
  %cmp141.13 = icmp eq i32 %315, 255
  br i1 %cmp141.13, label %if.then143.13, label %if.else146.13

if.else146.13:                                    ; preds = %lor.lhs.false134.13
  %arrayidx148.13 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %301
  store i8 0, i8* %arrayidx148.13, align 1
  br label %for.inc158.13

if.then143.13:                                    ; preds = %lor.lhs.false134.13, %lor.lhs.false126.13, %lor.lhs.false117.13, %lor.lhs.false109.13, %lor.lhs.false101.13, %lor.lhs.false92.13, %lor.lhs.false84.13, %if.then75.13
  %arrayidx145.13 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %301
  store i8 -1, i8* %arrayidx145.13, align 1
  br label %for.inc158.13

if.then67.13:                                     ; preds = %for.body53.13
  %arrayidx69.13 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %301
  store i8 0, i8* %arrayidx69.13, align 1
  br label %for.inc158.13

for.inc158.13:                                    ; preds = %if.then67.13, %if.then143.13, %if.else146.13, %if.else150.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %img_width
  br i1 %exitcond.13, label %for.inc161.13, label %for.body53.13, !llvm.loop !5

for.inc161.13:                                    ; preds = %for.inc158.13
  %indvars.iv.next21.13 = add nsw i64 %indvars.iv20, 14
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.14

for.body53.lr.ph.14:                              ; preds = %for.inc161.13
  %316 = trunc i64 %indvars.iv.next21.13 to i32
  %mul55.14 = shl nsw i32 %316, 7
  %cmp59.14 = icmp eq i64 %indvars.iv.next21.13, %11
  %317 = trunc i64 %indvars.iv.next21.13 to i32
  %sub76.14 = shl i32 %317, 7
  %mul86.14 = add i32 %sub76.14, -128
  %sub103.14 = add i32 %mul55.14, -1
  %add111.14 = or i32 %mul55.14, 1
  %mul128.14 = add i32 %sub76.14, 128
  %318 = sext i32 %mul55.14 to i64
  %319 = sext i32 %mul128.14 to i64
  %320 = sext i32 %mul86.14 to i64
  br label %for.body53.14

for.body53.14:                                    ; preds = %for.inc158.14, %for.body53.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body53.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc158.14 ]
  %321 = add nsw i64 %indvars.iv.14, %318
  %cmp62.14 = icmp eq i64 %indvars.iv.14, 0
  %or.cond1.14 = or i1 %cmp59.14, %cmp62.14
  %cmp65.14 = icmp eq i64 %indvars.iv.14, %10
  %or.cond2.14 = or i1 %cmp65.14, %or.cond1.14
  br i1 %or.cond2.14, label %if.then67.14, label %if.else70.14

if.else70.14:                                     ; preds = %for.body53.14
  %arrayidx72.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %321
  %322 = load i32, i32* %arrayidx72.14, align 4
  %cmp73.14 = icmp eq i32 %322, 75
  br i1 %cmp73.14, label %if.then75.14, label %if.else150.14

if.else150.14:                                    ; preds = %if.else70.14
  %conv153.14 = trunc i32 %322 to i8
  %arrayidx155.14 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %321
  store i8 %conv153.14, i8* %arrayidx155.14, align 1
  br label %for.inc158.14

if.then75.14:                                     ; preds = %if.else70.14
  %323 = trunc i64 %indvars.iv.14 to i32
  %sub78.14 = add i32 %323, %sub76.14
  %add79.14 = add i32 %sub78.14, -129
  %idxprom80.14 = sext i32 %add79.14 to i64
  %arrayidx81.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.14
  %324 = load i32, i32* %arrayidx81.14, align 4
  %cmp82.14 = icmp eq i32 %324, 255
  br i1 %cmp82.14, label %if.then143.14, label %lor.lhs.false84.14

lor.lhs.false84.14:                               ; preds = %if.then75.14
  %325 = add nsw i64 %320, %indvars.iv.14
  %arrayidx89.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %325
  %326 = load i32, i32* %arrayidx89.14, align 4
  %cmp90.14 = icmp eq i32 %326, 255
  br i1 %cmp90.14, label %if.then143.14, label %lor.lhs.false92.14

lor.lhs.false92.14:                               ; preds = %lor.lhs.false84.14
  %add96.14 = add i32 %sub78.14, -127
  %idxprom97.14 = sext i32 %add96.14 to i64
  %arrayidx98.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.14
  %327 = load i32, i32* %arrayidx98.14, align 4
  %cmp99.14 = icmp eq i32 %327, 255
  br i1 %cmp99.14, label %if.then143.14, label %lor.lhs.false101.14

lor.lhs.false101.14:                              ; preds = %lor.lhs.false92.14
  %328 = trunc i64 %indvars.iv.14 to i32
  %add104.14 = add i32 %sub103.14, %328
  %idxprom105.14 = sext i32 %add104.14 to i64
  %arrayidx106.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.14
  %329 = load i32, i32* %arrayidx106.14, align 4
  %cmp107.14 = icmp eq i32 %329, 255
  br i1 %cmp107.14, label %if.then143.14, label %lor.lhs.false109.14

lor.lhs.false109.14:                              ; preds = %lor.lhs.false101.14
  %330 = trunc i64 %indvars.iv.14 to i32
  %add112.14 = add i32 %add111.14, %330
  %idxprom113.14 = sext i32 %add112.14 to i64
  %arrayidx114.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.14
  %331 = load i32, i32* %arrayidx114.14, align 4
  %cmp115.14 = icmp eq i32 %331, 255
  br i1 %cmp115.14, label %if.then143.14, label %lor.lhs.false117.14

lor.lhs.false117.14:                              ; preds = %lor.lhs.false109.14
  %add121.14 = add i32 %sub78.14, 127
  %idxprom122.14 = sext i32 %add121.14 to i64
  %arrayidx123.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.14
  %332 = load i32, i32* %arrayidx123.14, align 4
  %cmp124.14 = icmp eq i32 %332, 255
  br i1 %cmp124.14, label %if.then143.14, label %lor.lhs.false126.14

lor.lhs.false126.14:                              ; preds = %lor.lhs.false117.14
  %333 = add nsw i64 %319, %indvars.iv.14
  %arrayidx131.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %333
  %334 = load i32, i32* %arrayidx131.14, align 4
  %cmp132.14 = icmp eq i32 %334, 255
  br i1 %cmp132.14, label %if.then143.14, label %lor.lhs.false134.14

lor.lhs.false134.14:                              ; preds = %lor.lhs.false126.14
  %add138.14 = add i32 %sub78.14, 129
  %idxprom139.14 = sext i32 %add138.14 to i64
  %arrayidx140.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.14
  %335 = load i32, i32* %arrayidx140.14, align 4
  %cmp141.14 = icmp eq i32 %335, 255
  br i1 %cmp141.14, label %if.then143.14, label %if.else146.14

if.else146.14:                                    ; preds = %lor.lhs.false134.14
  %arrayidx148.14 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %321
  store i8 0, i8* %arrayidx148.14, align 1
  br label %for.inc158.14

if.then143.14:                                    ; preds = %lor.lhs.false134.14, %lor.lhs.false126.14, %lor.lhs.false117.14, %lor.lhs.false109.14, %lor.lhs.false101.14, %lor.lhs.false92.14, %lor.lhs.false84.14, %if.then75.14
  %arrayidx145.14 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %321
  store i8 -1, i8* %arrayidx145.14, align 1
  br label %for.inc158.14

if.then67.14:                                     ; preds = %for.body53.14
  %arrayidx69.14 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %321
  store i8 0, i8* %arrayidx69.14, align 1
  br label %for.inc158.14

for.inc158.14:                                    ; preds = %if.then67.14, %if.then143.14, %if.else146.14, %if.else150.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %img_width
  br i1 %exitcond.14, label %for.inc161.14, label %for.body53.14, !llvm.loop !5

for.inc161.14:                                    ; preds = %for.inc158.14
  %indvars.iv.next21.14 = add nsw i64 %indvars.iv20, 15
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.15

for.body53.lr.ph.15:                              ; preds = %for.inc161.14
  %336 = trunc i64 %indvars.iv.next21.14 to i32
  %mul55.15 = shl nsw i32 %336, 7
  %cmp59.15 = icmp eq i64 %indvars.iv.next21.14, %11
  %337 = trunc i64 %indvars.iv.next21.14 to i32
  %sub76.15 = shl i32 %337, 7
  %mul86.15 = add i32 %sub76.15, -128
  %sub103.15 = add i32 %mul55.15, -1
  %add111.15 = or i32 %mul55.15, 1
  %mul128.15 = add i32 %sub76.15, 128
  %338 = sext i32 %mul55.15 to i64
  %339 = sext i32 %mul128.15 to i64
  %340 = sext i32 %mul86.15 to i64
  br label %for.body53.15

for.body53.15:                                    ; preds = %for.inc158.15, %for.body53.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body53.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc158.15 ]
  %341 = add nsw i64 %indvars.iv.15, %338
  %cmp62.15 = icmp eq i64 %indvars.iv.15, 0
  %or.cond1.15 = or i1 %cmp59.15, %cmp62.15
  %cmp65.15 = icmp eq i64 %indvars.iv.15, %10
  %or.cond2.15 = or i1 %cmp65.15, %or.cond1.15
  br i1 %or.cond2.15, label %if.then67.15, label %if.else70.15

if.else70.15:                                     ; preds = %for.body53.15
  %arrayidx72.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %341
  %342 = load i32, i32* %arrayidx72.15, align 4
  %cmp73.15 = icmp eq i32 %342, 75
  br i1 %cmp73.15, label %if.then75.15, label %if.else150.15

if.else150.15:                                    ; preds = %if.else70.15
  %conv153.15 = trunc i32 %342 to i8
  %arrayidx155.15 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %341
  store i8 %conv153.15, i8* %arrayidx155.15, align 1
  br label %for.inc158.15

if.then75.15:                                     ; preds = %if.else70.15
  %343 = trunc i64 %indvars.iv.15 to i32
  %sub78.15 = add i32 %343, %sub76.15
  %add79.15 = add i32 %sub78.15, -129
  %idxprom80.15 = sext i32 %add79.15 to i64
  %arrayidx81.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.15
  %344 = load i32, i32* %arrayidx81.15, align 4
  %cmp82.15 = icmp eq i32 %344, 255
  br i1 %cmp82.15, label %if.then143.15, label %lor.lhs.false84.15

lor.lhs.false84.15:                               ; preds = %if.then75.15
  %345 = add nsw i64 %340, %indvars.iv.15
  %arrayidx89.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %345
  %346 = load i32, i32* %arrayidx89.15, align 4
  %cmp90.15 = icmp eq i32 %346, 255
  br i1 %cmp90.15, label %if.then143.15, label %lor.lhs.false92.15

lor.lhs.false92.15:                               ; preds = %lor.lhs.false84.15
  %add96.15 = add i32 %sub78.15, -127
  %idxprom97.15 = sext i32 %add96.15 to i64
  %arrayidx98.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.15
  %347 = load i32, i32* %arrayidx98.15, align 4
  %cmp99.15 = icmp eq i32 %347, 255
  br i1 %cmp99.15, label %if.then143.15, label %lor.lhs.false101.15

lor.lhs.false101.15:                              ; preds = %lor.lhs.false92.15
  %348 = trunc i64 %indvars.iv.15 to i32
  %add104.15 = add i32 %sub103.15, %348
  %idxprom105.15 = sext i32 %add104.15 to i64
  %arrayidx106.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.15
  %349 = load i32, i32* %arrayidx106.15, align 4
  %cmp107.15 = icmp eq i32 %349, 255
  br i1 %cmp107.15, label %if.then143.15, label %lor.lhs.false109.15

lor.lhs.false109.15:                              ; preds = %lor.lhs.false101.15
  %350 = trunc i64 %indvars.iv.15 to i32
  %add112.15 = add i32 %add111.15, %350
  %idxprom113.15 = sext i32 %add112.15 to i64
  %arrayidx114.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.15
  %351 = load i32, i32* %arrayidx114.15, align 4
  %cmp115.15 = icmp eq i32 %351, 255
  br i1 %cmp115.15, label %if.then143.15, label %lor.lhs.false117.15

lor.lhs.false117.15:                              ; preds = %lor.lhs.false109.15
  %add121.15 = add i32 %sub78.15, 127
  %idxprom122.15 = sext i32 %add121.15 to i64
  %arrayidx123.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.15
  %352 = load i32, i32* %arrayidx123.15, align 4
  %cmp124.15 = icmp eq i32 %352, 255
  br i1 %cmp124.15, label %if.then143.15, label %lor.lhs.false126.15

lor.lhs.false126.15:                              ; preds = %lor.lhs.false117.15
  %353 = add nsw i64 %339, %indvars.iv.15
  %arrayidx131.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %353
  %354 = load i32, i32* %arrayidx131.15, align 4
  %cmp132.15 = icmp eq i32 %354, 255
  br i1 %cmp132.15, label %if.then143.15, label %lor.lhs.false134.15

lor.lhs.false134.15:                              ; preds = %lor.lhs.false126.15
  %add138.15 = add i32 %sub78.15, 129
  %idxprom139.15 = sext i32 %add138.15 to i64
  %arrayidx140.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.15
  %355 = load i32, i32* %arrayidx140.15, align 4
  %cmp141.15 = icmp eq i32 %355, 255
  br i1 %cmp141.15, label %if.then143.15, label %if.else146.15

if.else146.15:                                    ; preds = %lor.lhs.false134.15
  %arrayidx148.15 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %341
  store i8 0, i8* %arrayidx148.15, align 1
  br label %for.inc158.15

if.then143.15:                                    ; preds = %lor.lhs.false134.15, %lor.lhs.false126.15, %lor.lhs.false117.15, %lor.lhs.false109.15, %lor.lhs.false101.15, %lor.lhs.false92.15, %lor.lhs.false84.15, %if.then75.15
  %arrayidx145.15 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %341
  store i8 -1, i8* %arrayidx145.15, align 1
  br label %for.inc158.15

if.then67.15:                                     ; preds = %for.body53.15
  %arrayidx69.15 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %341
  store i8 0, i8* %arrayidx69.15, align 1
  br label %for.inc158.15

for.inc158.15:                                    ; preds = %if.then67.15, %if.then143.15, %if.else146.15, %if.else150.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %img_width
  br i1 %exitcond.15, label %for.inc161.15, label %for.body53.15, !llvm.loop !5

for.inc161.15:                                    ; preds = %for.inc158.15
  %indvars.iv.next21.15 = add nsw i64 %indvars.iv20, 16
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.16

for.body53.lr.ph.16:                              ; preds = %for.inc161.15
  %356 = trunc i64 %indvars.iv.next21.15 to i32
  %mul55.16 = shl nsw i32 %356, 7
  %cmp59.16 = icmp eq i64 %indvars.iv.next21.15, %11
  %357 = trunc i64 %indvars.iv.next21.15 to i32
  %sub76.16 = shl i32 %357, 7
  %mul86.16 = add i32 %sub76.16, -128
  %sub103.16 = add i32 %mul55.16, -1
  %add111.16 = or i32 %mul55.16, 1
  %mul128.16 = add i32 %sub76.16, 128
  %358 = sext i32 %mul55.16 to i64
  %359 = sext i32 %mul128.16 to i64
  %360 = sext i32 %mul86.16 to i64
  br label %for.body53.16

for.body53.16:                                    ; preds = %for.inc158.16, %for.body53.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body53.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc158.16 ]
  %361 = add nsw i64 %indvars.iv.16, %358
  %cmp62.16 = icmp eq i64 %indvars.iv.16, 0
  %or.cond1.16 = or i1 %cmp59.16, %cmp62.16
  %cmp65.16 = icmp eq i64 %indvars.iv.16, %10
  %or.cond2.16 = or i1 %cmp65.16, %or.cond1.16
  br i1 %or.cond2.16, label %if.then67.16, label %if.else70.16

if.else70.16:                                     ; preds = %for.body53.16
  %arrayidx72.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %361
  %362 = load i32, i32* %arrayidx72.16, align 4
  %cmp73.16 = icmp eq i32 %362, 75
  br i1 %cmp73.16, label %if.then75.16, label %if.else150.16

if.else150.16:                                    ; preds = %if.else70.16
  %conv153.16 = trunc i32 %362 to i8
  %arrayidx155.16 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %361
  store i8 %conv153.16, i8* %arrayidx155.16, align 1
  br label %for.inc158.16

if.then75.16:                                     ; preds = %if.else70.16
  %363 = trunc i64 %indvars.iv.16 to i32
  %sub78.16 = add i32 %363, %sub76.16
  %add79.16 = add i32 %sub78.16, -129
  %idxprom80.16 = sext i32 %add79.16 to i64
  %arrayidx81.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.16
  %364 = load i32, i32* %arrayidx81.16, align 4
  %cmp82.16 = icmp eq i32 %364, 255
  br i1 %cmp82.16, label %if.then143.16, label %lor.lhs.false84.16

lor.lhs.false84.16:                               ; preds = %if.then75.16
  %365 = add nsw i64 %360, %indvars.iv.16
  %arrayidx89.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %365
  %366 = load i32, i32* %arrayidx89.16, align 4
  %cmp90.16 = icmp eq i32 %366, 255
  br i1 %cmp90.16, label %if.then143.16, label %lor.lhs.false92.16

lor.lhs.false92.16:                               ; preds = %lor.lhs.false84.16
  %add96.16 = add i32 %sub78.16, -127
  %idxprom97.16 = sext i32 %add96.16 to i64
  %arrayidx98.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.16
  %367 = load i32, i32* %arrayidx98.16, align 4
  %cmp99.16 = icmp eq i32 %367, 255
  br i1 %cmp99.16, label %if.then143.16, label %lor.lhs.false101.16

lor.lhs.false101.16:                              ; preds = %lor.lhs.false92.16
  %368 = trunc i64 %indvars.iv.16 to i32
  %add104.16 = add i32 %sub103.16, %368
  %idxprom105.16 = sext i32 %add104.16 to i64
  %arrayidx106.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.16
  %369 = load i32, i32* %arrayidx106.16, align 4
  %cmp107.16 = icmp eq i32 %369, 255
  br i1 %cmp107.16, label %if.then143.16, label %lor.lhs.false109.16

lor.lhs.false109.16:                              ; preds = %lor.lhs.false101.16
  %370 = trunc i64 %indvars.iv.16 to i32
  %add112.16 = add i32 %add111.16, %370
  %idxprom113.16 = sext i32 %add112.16 to i64
  %arrayidx114.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.16
  %371 = load i32, i32* %arrayidx114.16, align 4
  %cmp115.16 = icmp eq i32 %371, 255
  br i1 %cmp115.16, label %if.then143.16, label %lor.lhs.false117.16

lor.lhs.false117.16:                              ; preds = %lor.lhs.false109.16
  %add121.16 = add i32 %sub78.16, 127
  %idxprom122.16 = sext i32 %add121.16 to i64
  %arrayidx123.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.16
  %372 = load i32, i32* %arrayidx123.16, align 4
  %cmp124.16 = icmp eq i32 %372, 255
  br i1 %cmp124.16, label %if.then143.16, label %lor.lhs.false126.16

lor.lhs.false126.16:                              ; preds = %lor.lhs.false117.16
  %373 = add nsw i64 %359, %indvars.iv.16
  %arrayidx131.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %373
  %374 = load i32, i32* %arrayidx131.16, align 4
  %cmp132.16 = icmp eq i32 %374, 255
  br i1 %cmp132.16, label %if.then143.16, label %lor.lhs.false134.16

lor.lhs.false134.16:                              ; preds = %lor.lhs.false126.16
  %add138.16 = add i32 %sub78.16, 129
  %idxprom139.16 = sext i32 %add138.16 to i64
  %arrayidx140.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.16
  %375 = load i32, i32* %arrayidx140.16, align 4
  %cmp141.16 = icmp eq i32 %375, 255
  br i1 %cmp141.16, label %if.then143.16, label %if.else146.16

if.else146.16:                                    ; preds = %lor.lhs.false134.16
  %arrayidx148.16 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %361
  store i8 0, i8* %arrayidx148.16, align 1
  br label %for.inc158.16

if.then143.16:                                    ; preds = %lor.lhs.false134.16, %lor.lhs.false126.16, %lor.lhs.false117.16, %lor.lhs.false109.16, %lor.lhs.false101.16, %lor.lhs.false92.16, %lor.lhs.false84.16, %if.then75.16
  %arrayidx145.16 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %361
  store i8 -1, i8* %arrayidx145.16, align 1
  br label %for.inc158.16

if.then67.16:                                     ; preds = %for.body53.16
  %arrayidx69.16 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %361
  store i8 0, i8* %arrayidx69.16, align 1
  br label %for.inc158.16

for.inc158.16:                                    ; preds = %if.then67.16, %if.then143.16, %if.else146.16, %if.else150.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %img_width
  br i1 %exitcond.16, label %for.inc161.16, label %for.body53.16, !llvm.loop !5

for.inc161.16:                                    ; preds = %for.inc158.16
  %indvars.iv.next21.16 = add nsw i64 %indvars.iv20, 17
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.17

for.body53.lr.ph.17:                              ; preds = %for.inc161.16
  %376 = trunc i64 %indvars.iv.next21.16 to i32
  %mul55.17 = shl nsw i32 %376, 7
  %cmp59.17 = icmp eq i64 %indvars.iv.next21.16, %11
  %377 = trunc i64 %indvars.iv.next21.16 to i32
  %sub76.17 = shl i32 %377, 7
  %mul86.17 = add i32 %sub76.17, -128
  %sub103.17 = add i32 %mul55.17, -1
  %add111.17 = or i32 %mul55.17, 1
  %mul128.17 = add i32 %sub76.17, 128
  %378 = sext i32 %mul55.17 to i64
  %379 = sext i32 %mul128.17 to i64
  %380 = sext i32 %mul86.17 to i64
  br label %for.body53.17

for.body53.17:                                    ; preds = %for.inc158.17, %for.body53.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body53.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc158.17 ]
  %381 = add nsw i64 %indvars.iv.17, %378
  %cmp62.17 = icmp eq i64 %indvars.iv.17, 0
  %or.cond1.17 = or i1 %cmp59.17, %cmp62.17
  %cmp65.17 = icmp eq i64 %indvars.iv.17, %10
  %or.cond2.17 = or i1 %cmp65.17, %or.cond1.17
  br i1 %or.cond2.17, label %if.then67.17, label %if.else70.17

if.else70.17:                                     ; preds = %for.body53.17
  %arrayidx72.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %381
  %382 = load i32, i32* %arrayidx72.17, align 4
  %cmp73.17 = icmp eq i32 %382, 75
  br i1 %cmp73.17, label %if.then75.17, label %if.else150.17

if.else150.17:                                    ; preds = %if.else70.17
  %conv153.17 = trunc i32 %382 to i8
  %arrayidx155.17 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %381
  store i8 %conv153.17, i8* %arrayidx155.17, align 1
  br label %for.inc158.17

if.then75.17:                                     ; preds = %if.else70.17
  %383 = trunc i64 %indvars.iv.17 to i32
  %sub78.17 = add i32 %383, %sub76.17
  %add79.17 = add i32 %sub78.17, -129
  %idxprom80.17 = sext i32 %add79.17 to i64
  %arrayidx81.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.17
  %384 = load i32, i32* %arrayidx81.17, align 4
  %cmp82.17 = icmp eq i32 %384, 255
  br i1 %cmp82.17, label %if.then143.17, label %lor.lhs.false84.17

lor.lhs.false84.17:                               ; preds = %if.then75.17
  %385 = add nsw i64 %380, %indvars.iv.17
  %arrayidx89.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %385
  %386 = load i32, i32* %arrayidx89.17, align 4
  %cmp90.17 = icmp eq i32 %386, 255
  br i1 %cmp90.17, label %if.then143.17, label %lor.lhs.false92.17

lor.lhs.false92.17:                               ; preds = %lor.lhs.false84.17
  %add96.17 = add i32 %sub78.17, -127
  %idxprom97.17 = sext i32 %add96.17 to i64
  %arrayidx98.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.17
  %387 = load i32, i32* %arrayidx98.17, align 4
  %cmp99.17 = icmp eq i32 %387, 255
  br i1 %cmp99.17, label %if.then143.17, label %lor.lhs.false101.17

lor.lhs.false101.17:                              ; preds = %lor.lhs.false92.17
  %388 = trunc i64 %indvars.iv.17 to i32
  %add104.17 = add i32 %sub103.17, %388
  %idxprom105.17 = sext i32 %add104.17 to i64
  %arrayidx106.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.17
  %389 = load i32, i32* %arrayidx106.17, align 4
  %cmp107.17 = icmp eq i32 %389, 255
  br i1 %cmp107.17, label %if.then143.17, label %lor.lhs.false109.17

lor.lhs.false109.17:                              ; preds = %lor.lhs.false101.17
  %390 = trunc i64 %indvars.iv.17 to i32
  %add112.17 = add i32 %add111.17, %390
  %idxprom113.17 = sext i32 %add112.17 to i64
  %arrayidx114.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.17
  %391 = load i32, i32* %arrayidx114.17, align 4
  %cmp115.17 = icmp eq i32 %391, 255
  br i1 %cmp115.17, label %if.then143.17, label %lor.lhs.false117.17

lor.lhs.false117.17:                              ; preds = %lor.lhs.false109.17
  %add121.17 = add i32 %sub78.17, 127
  %idxprom122.17 = sext i32 %add121.17 to i64
  %arrayidx123.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.17
  %392 = load i32, i32* %arrayidx123.17, align 4
  %cmp124.17 = icmp eq i32 %392, 255
  br i1 %cmp124.17, label %if.then143.17, label %lor.lhs.false126.17

lor.lhs.false126.17:                              ; preds = %lor.lhs.false117.17
  %393 = add nsw i64 %379, %indvars.iv.17
  %arrayidx131.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %393
  %394 = load i32, i32* %arrayidx131.17, align 4
  %cmp132.17 = icmp eq i32 %394, 255
  br i1 %cmp132.17, label %if.then143.17, label %lor.lhs.false134.17

lor.lhs.false134.17:                              ; preds = %lor.lhs.false126.17
  %add138.17 = add i32 %sub78.17, 129
  %idxprom139.17 = sext i32 %add138.17 to i64
  %arrayidx140.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.17
  %395 = load i32, i32* %arrayidx140.17, align 4
  %cmp141.17 = icmp eq i32 %395, 255
  br i1 %cmp141.17, label %if.then143.17, label %if.else146.17

if.else146.17:                                    ; preds = %lor.lhs.false134.17
  %arrayidx148.17 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %381
  store i8 0, i8* %arrayidx148.17, align 1
  br label %for.inc158.17

if.then143.17:                                    ; preds = %lor.lhs.false134.17, %lor.lhs.false126.17, %lor.lhs.false117.17, %lor.lhs.false109.17, %lor.lhs.false101.17, %lor.lhs.false92.17, %lor.lhs.false84.17, %if.then75.17
  %arrayidx145.17 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %381
  store i8 -1, i8* %arrayidx145.17, align 1
  br label %for.inc158.17

if.then67.17:                                     ; preds = %for.body53.17
  %arrayidx69.17 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %381
  store i8 0, i8* %arrayidx69.17, align 1
  br label %for.inc158.17

for.inc158.17:                                    ; preds = %if.then67.17, %if.then143.17, %if.else146.17, %if.else150.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %img_width
  br i1 %exitcond.17, label %for.inc161.17, label %for.body53.17, !llvm.loop !5

for.inc161.17:                                    ; preds = %for.inc158.17
  %indvars.iv.next21.17 = add nsw i64 %indvars.iv20, 18
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.18

for.body53.lr.ph.18:                              ; preds = %for.inc161.17
  %396 = trunc i64 %indvars.iv.next21.17 to i32
  %mul55.18 = shl nsw i32 %396, 7
  %cmp59.18 = icmp eq i64 %indvars.iv.next21.17, %11
  %397 = trunc i64 %indvars.iv.next21.17 to i32
  %sub76.18 = shl i32 %397, 7
  %mul86.18 = add i32 %sub76.18, -128
  %sub103.18 = add i32 %mul55.18, -1
  %add111.18 = or i32 %mul55.18, 1
  %mul128.18 = add i32 %sub76.18, 128
  %398 = sext i32 %mul55.18 to i64
  %399 = sext i32 %mul128.18 to i64
  %400 = sext i32 %mul86.18 to i64
  br label %for.body53.18

for.body53.18:                                    ; preds = %for.inc158.18, %for.body53.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body53.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc158.18 ]
  %401 = add nsw i64 %indvars.iv.18, %398
  %cmp62.18 = icmp eq i64 %indvars.iv.18, 0
  %or.cond1.18 = or i1 %cmp59.18, %cmp62.18
  %cmp65.18 = icmp eq i64 %indvars.iv.18, %10
  %or.cond2.18 = or i1 %cmp65.18, %or.cond1.18
  br i1 %or.cond2.18, label %if.then67.18, label %if.else70.18

if.else70.18:                                     ; preds = %for.body53.18
  %arrayidx72.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %401
  %402 = load i32, i32* %arrayidx72.18, align 4
  %cmp73.18 = icmp eq i32 %402, 75
  br i1 %cmp73.18, label %if.then75.18, label %if.else150.18

if.else150.18:                                    ; preds = %if.else70.18
  %conv153.18 = trunc i32 %402 to i8
  %arrayidx155.18 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %401
  store i8 %conv153.18, i8* %arrayidx155.18, align 1
  br label %for.inc158.18

if.then75.18:                                     ; preds = %if.else70.18
  %403 = trunc i64 %indvars.iv.18 to i32
  %sub78.18 = add i32 %403, %sub76.18
  %add79.18 = add i32 %sub78.18, -129
  %idxprom80.18 = sext i32 %add79.18 to i64
  %arrayidx81.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.18
  %404 = load i32, i32* %arrayidx81.18, align 4
  %cmp82.18 = icmp eq i32 %404, 255
  br i1 %cmp82.18, label %if.then143.18, label %lor.lhs.false84.18

lor.lhs.false84.18:                               ; preds = %if.then75.18
  %405 = add nsw i64 %400, %indvars.iv.18
  %arrayidx89.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %405
  %406 = load i32, i32* %arrayidx89.18, align 4
  %cmp90.18 = icmp eq i32 %406, 255
  br i1 %cmp90.18, label %if.then143.18, label %lor.lhs.false92.18

lor.lhs.false92.18:                               ; preds = %lor.lhs.false84.18
  %add96.18 = add i32 %sub78.18, -127
  %idxprom97.18 = sext i32 %add96.18 to i64
  %arrayidx98.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.18
  %407 = load i32, i32* %arrayidx98.18, align 4
  %cmp99.18 = icmp eq i32 %407, 255
  br i1 %cmp99.18, label %if.then143.18, label %lor.lhs.false101.18

lor.lhs.false101.18:                              ; preds = %lor.lhs.false92.18
  %408 = trunc i64 %indvars.iv.18 to i32
  %add104.18 = add i32 %sub103.18, %408
  %idxprom105.18 = sext i32 %add104.18 to i64
  %arrayidx106.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.18
  %409 = load i32, i32* %arrayidx106.18, align 4
  %cmp107.18 = icmp eq i32 %409, 255
  br i1 %cmp107.18, label %if.then143.18, label %lor.lhs.false109.18

lor.lhs.false109.18:                              ; preds = %lor.lhs.false101.18
  %410 = trunc i64 %indvars.iv.18 to i32
  %add112.18 = add i32 %add111.18, %410
  %idxprom113.18 = sext i32 %add112.18 to i64
  %arrayidx114.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.18
  %411 = load i32, i32* %arrayidx114.18, align 4
  %cmp115.18 = icmp eq i32 %411, 255
  br i1 %cmp115.18, label %if.then143.18, label %lor.lhs.false117.18

lor.lhs.false117.18:                              ; preds = %lor.lhs.false109.18
  %add121.18 = add i32 %sub78.18, 127
  %idxprom122.18 = sext i32 %add121.18 to i64
  %arrayidx123.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.18
  %412 = load i32, i32* %arrayidx123.18, align 4
  %cmp124.18 = icmp eq i32 %412, 255
  br i1 %cmp124.18, label %if.then143.18, label %lor.lhs.false126.18

lor.lhs.false126.18:                              ; preds = %lor.lhs.false117.18
  %413 = add nsw i64 %399, %indvars.iv.18
  %arrayidx131.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %413
  %414 = load i32, i32* %arrayidx131.18, align 4
  %cmp132.18 = icmp eq i32 %414, 255
  br i1 %cmp132.18, label %if.then143.18, label %lor.lhs.false134.18

lor.lhs.false134.18:                              ; preds = %lor.lhs.false126.18
  %add138.18 = add i32 %sub78.18, 129
  %idxprom139.18 = sext i32 %add138.18 to i64
  %arrayidx140.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.18
  %415 = load i32, i32* %arrayidx140.18, align 4
  %cmp141.18 = icmp eq i32 %415, 255
  br i1 %cmp141.18, label %if.then143.18, label %if.else146.18

if.else146.18:                                    ; preds = %lor.lhs.false134.18
  %arrayidx148.18 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %401
  store i8 0, i8* %arrayidx148.18, align 1
  br label %for.inc158.18

if.then143.18:                                    ; preds = %lor.lhs.false134.18, %lor.lhs.false126.18, %lor.lhs.false117.18, %lor.lhs.false109.18, %lor.lhs.false101.18, %lor.lhs.false92.18, %lor.lhs.false84.18, %if.then75.18
  %arrayidx145.18 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %401
  store i8 -1, i8* %arrayidx145.18, align 1
  br label %for.inc158.18

if.then67.18:                                     ; preds = %for.body53.18
  %arrayidx69.18 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %401
  store i8 0, i8* %arrayidx69.18, align 1
  br label %for.inc158.18

for.inc158.18:                                    ; preds = %if.then67.18, %if.then143.18, %if.else146.18, %if.else150.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %img_width
  br i1 %exitcond.18, label %for.inc161.18, label %for.body53.18, !llvm.loop !5

for.inc161.18:                                    ; preds = %for.inc158.18
  %indvars.iv.next21.18 = add nsw i64 %indvars.iv20, 19
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.19

for.body53.lr.ph.19:                              ; preds = %for.inc161.18
  %416 = trunc i64 %indvars.iv.next21.18 to i32
  %mul55.19 = shl nsw i32 %416, 7
  %cmp59.19 = icmp eq i64 %indvars.iv.next21.18, %11
  %417 = trunc i64 %indvars.iv.next21.18 to i32
  %sub76.19 = shl i32 %417, 7
  %mul86.19 = add i32 %sub76.19, -128
  %sub103.19 = add i32 %mul55.19, -1
  %add111.19 = or i32 %mul55.19, 1
  %mul128.19 = add i32 %sub76.19, 128
  %418 = sext i32 %mul55.19 to i64
  %419 = sext i32 %mul128.19 to i64
  %420 = sext i32 %mul86.19 to i64
  br label %for.body53.19

for.body53.19:                                    ; preds = %for.inc158.19, %for.body53.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body53.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc158.19 ]
  %421 = add nsw i64 %indvars.iv.19, %418
  %cmp62.19 = icmp eq i64 %indvars.iv.19, 0
  %or.cond1.19 = or i1 %cmp59.19, %cmp62.19
  %cmp65.19 = icmp eq i64 %indvars.iv.19, %10
  %or.cond2.19 = or i1 %cmp65.19, %or.cond1.19
  br i1 %or.cond2.19, label %if.then67.19, label %if.else70.19

if.else70.19:                                     ; preds = %for.body53.19
  %arrayidx72.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %421
  %422 = load i32, i32* %arrayidx72.19, align 4
  %cmp73.19 = icmp eq i32 %422, 75
  br i1 %cmp73.19, label %if.then75.19, label %if.else150.19

if.else150.19:                                    ; preds = %if.else70.19
  %conv153.19 = trunc i32 %422 to i8
  %arrayidx155.19 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %421
  store i8 %conv153.19, i8* %arrayidx155.19, align 1
  br label %for.inc158.19

if.then75.19:                                     ; preds = %if.else70.19
  %423 = trunc i64 %indvars.iv.19 to i32
  %sub78.19 = add i32 %423, %sub76.19
  %add79.19 = add i32 %sub78.19, -129
  %idxprom80.19 = sext i32 %add79.19 to i64
  %arrayidx81.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.19
  %424 = load i32, i32* %arrayidx81.19, align 4
  %cmp82.19 = icmp eq i32 %424, 255
  br i1 %cmp82.19, label %if.then143.19, label %lor.lhs.false84.19

lor.lhs.false84.19:                               ; preds = %if.then75.19
  %425 = add nsw i64 %420, %indvars.iv.19
  %arrayidx89.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %425
  %426 = load i32, i32* %arrayidx89.19, align 4
  %cmp90.19 = icmp eq i32 %426, 255
  br i1 %cmp90.19, label %if.then143.19, label %lor.lhs.false92.19

lor.lhs.false92.19:                               ; preds = %lor.lhs.false84.19
  %add96.19 = add i32 %sub78.19, -127
  %idxprom97.19 = sext i32 %add96.19 to i64
  %arrayidx98.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.19
  %427 = load i32, i32* %arrayidx98.19, align 4
  %cmp99.19 = icmp eq i32 %427, 255
  br i1 %cmp99.19, label %if.then143.19, label %lor.lhs.false101.19

lor.lhs.false101.19:                              ; preds = %lor.lhs.false92.19
  %428 = trunc i64 %indvars.iv.19 to i32
  %add104.19 = add i32 %sub103.19, %428
  %idxprom105.19 = sext i32 %add104.19 to i64
  %arrayidx106.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.19
  %429 = load i32, i32* %arrayidx106.19, align 4
  %cmp107.19 = icmp eq i32 %429, 255
  br i1 %cmp107.19, label %if.then143.19, label %lor.lhs.false109.19

lor.lhs.false109.19:                              ; preds = %lor.lhs.false101.19
  %430 = trunc i64 %indvars.iv.19 to i32
  %add112.19 = add i32 %add111.19, %430
  %idxprom113.19 = sext i32 %add112.19 to i64
  %arrayidx114.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.19
  %431 = load i32, i32* %arrayidx114.19, align 4
  %cmp115.19 = icmp eq i32 %431, 255
  br i1 %cmp115.19, label %if.then143.19, label %lor.lhs.false117.19

lor.lhs.false117.19:                              ; preds = %lor.lhs.false109.19
  %add121.19 = add i32 %sub78.19, 127
  %idxprom122.19 = sext i32 %add121.19 to i64
  %arrayidx123.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.19
  %432 = load i32, i32* %arrayidx123.19, align 4
  %cmp124.19 = icmp eq i32 %432, 255
  br i1 %cmp124.19, label %if.then143.19, label %lor.lhs.false126.19

lor.lhs.false126.19:                              ; preds = %lor.lhs.false117.19
  %433 = add nsw i64 %419, %indvars.iv.19
  %arrayidx131.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %433
  %434 = load i32, i32* %arrayidx131.19, align 4
  %cmp132.19 = icmp eq i32 %434, 255
  br i1 %cmp132.19, label %if.then143.19, label %lor.lhs.false134.19

lor.lhs.false134.19:                              ; preds = %lor.lhs.false126.19
  %add138.19 = add i32 %sub78.19, 129
  %idxprom139.19 = sext i32 %add138.19 to i64
  %arrayidx140.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.19
  %435 = load i32, i32* %arrayidx140.19, align 4
  %cmp141.19 = icmp eq i32 %435, 255
  br i1 %cmp141.19, label %if.then143.19, label %if.else146.19

if.else146.19:                                    ; preds = %lor.lhs.false134.19
  %arrayidx148.19 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %421
  store i8 0, i8* %arrayidx148.19, align 1
  br label %for.inc158.19

if.then143.19:                                    ; preds = %lor.lhs.false134.19, %lor.lhs.false126.19, %lor.lhs.false117.19, %lor.lhs.false109.19, %lor.lhs.false101.19, %lor.lhs.false92.19, %lor.lhs.false84.19, %if.then75.19
  %arrayidx145.19 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %421
  store i8 -1, i8* %arrayidx145.19, align 1
  br label %for.inc158.19

if.then67.19:                                     ; preds = %for.body53.19
  %arrayidx69.19 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %421
  store i8 0, i8* %arrayidx69.19, align 1
  br label %for.inc158.19

for.inc158.19:                                    ; preds = %if.then67.19, %if.then143.19, %if.else146.19, %if.else150.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %img_width
  br i1 %exitcond.19, label %for.inc161.19, label %for.body53.19, !llvm.loop !5

for.inc161.19:                                    ; preds = %for.inc158.19
  %indvars.iv.next21.19 = add nsw i64 %indvars.iv20, 20
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.20

for.body53.lr.ph.20:                              ; preds = %for.inc161.19
  %436 = trunc i64 %indvars.iv.next21.19 to i32
  %mul55.20 = shl nsw i32 %436, 7
  %cmp59.20 = icmp eq i64 %indvars.iv.next21.19, %11
  %437 = trunc i64 %indvars.iv.next21.19 to i32
  %sub76.20 = shl i32 %437, 7
  %mul86.20 = add i32 %sub76.20, -128
  %sub103.20 = add i32 %mul55.20, -1
  %add111.20 = or i32 %mul55.20, 1
  %mul128.20 = add i32 %sub76.20, 128
  %438 = sext i32 %mul55.20 to i64
  %439 = sext i32 %mul128.20 to i64
  %440 = sext i32 %mul86.20 to i64
  br label %for.body53.20

for.body53.20:                                    ; preds = %for.inc158.20, %for.body53.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body53.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc158.20 ]
  %441 = add nsw i64 %indvars.iv.20, %438
  %cmp62.20 = icmp eq i64 %indvars.iv.20, 0
  %or.cond1.20 = or i1 %cmp59.20, %cmp62.20
  %cmp65.20 = icmp eq i64 %indvars.iv.20, %10
  %or.cond2.20 = or i1 %cmp65.20, %or.cond1.20
  br i1 %or.cond2.20, label %if.then67.20, label %if.else70.20

if.else70.20:                                     ; preds = %for.body53.20
  %arrayidx72.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %441
  %442 = load i32, i32* %arrayidx72.20, align 4
  %cmp73.20 = icmp eq i32 %442, 75
  br i1 %cmp73.20, label %if.then75.20, label %if.else150.20

if.else150.20:                                    ; preds = %if.else70.20
  %conv153.20 = trunc i32 %442 to i8
  %arrayidx155.20 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %441
  store i8 %conv153.20, i8* %arrayidx155.20, align 1
  br label %for.inc158.20

if.then75.20:                                     ; preds = %if.else70.20
  %443 = trunc i64 %indvars.iv.20 to i32
  %sub78.20 = add i32 %443, %sub76.20
  %add79.20 = add i32 %sub78.20, -129
  %idxprom80.20 = sext i32 %add79.20 to i64
  %arrayidx81.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.20
  %444 = load i32, i32* %arrayidx81.20, align 4
  %cmp82.20 = icmp eq i32 %444, 255
  br i1 %cmp82.20, label %if.then143.20, label %lor.lhs.false84.20

lor.lhs.false84.20:                               ; preds = %if.then75.20
  %445 = add nsw i64 %440, %indvars.iv.20
  %arrayidx89.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %445
  %446 = load i32, i32* %arrayidx89.20, align 4
  %cmp90.20 = icmp eq i32 %446, 255
  br i1 %cmp90.20, label %if.then143.20, label %lor.lhs.false92.20

lor.lhs.false92.20:                               ; preds = %lor.lhs.false84.20
  %add96.20 = add i32 %sub78.20, -127
  %idxprom97.20 = sext i32 %add96.20 to i64
  %arrayidx98.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.20
  %447 = load i32, i32* %arrayidx98.20, align 4
  %cmp99.20 = icmp eq i32 %447, 255
  br i1 %cmp99.20, label %if.then143.20, label %lor.lhs.false101.20

lor.lhs.false101.20:                              ; preds = %lor.lhs.false92.20
  %448 = trunc i64 %indvars.iv.20 to i32
  %add104.20 = add i32 %sub103.20, %448
  %idxprom105.20 = sext i32 %add104.20 to i64
  %arrayidx106.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.20
  %449 = load i32, i32* %arrayidx106.20, align 4
  %cmp107.20 = icmp eq i32 %449, 255
  br i1 %cmp107.20, label %if.then143.20, label %lor.lhs.false109.20

lor.lhs.false109.20:                              ; preds = %lor.lhs.false101.20
  %450 = trunc i64 %indvars.iv.20 to i32
  %add112.20 = add i32 %add111.20, %450
  %idxprom113.20 = sext i32 %add112.20 to i64
  %arrayidx114.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.20
  %451 = load i32, i32* %arrayidx114.20, align 4
  %cmp115.20 = icmp eq i32 %451, 255
  br i1 %cmp115.20, label %if.then143.20, label %lor.lhs.false117.20

lor.lhs.false117.20:                              ; preds = %lor.lhs.false109.20
  %add121.20 = add i32 %sub78.20, 127
  %idxprom122.20 = sext i32 %add121.20 to i64
  %arrayidx123.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.20
  %452 = load i32, i32* %arrayidx123.20, align 4
  %cmp124.20 = icmp eq i32 %452, 255
  br i1 %cmp124.20, label %if.then143.20, label %lor.lhs.false126.20

lor.lhs.false126.20:                              ; preds = %lor.lhs.false117.20
  %453 = add nsw i64 %439, %indvars.iv.20
  %arrayidx131.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %453
  %454 = load i32, i32* %arrayidx131.20, align 4
  %cmp132.20 = icmp eq i32 %454, 255
  br i1 %cmp132.20, label %if.then143.20, label %lor.lhs.false134.20

lor.lhs.false134.20:                              ; preds = %lor.lhs.false126.20
  %add138.20 = add i32 %sub78.20, 129
  %idxprom139.20 = sext i32 %add138.20 to i64
  %arrayidx140.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.20
  %455 = load i32, i32* %arrayidx140.20, align 4
  %cmp141.20 = icmp eq i32 %455, 255
  br i1 %cmp141.20, label %if.then143.20, label %if.else146.20

if.else146.20:                                    ; preds = %lor.lhs.false134.20
  %arrayidx148.20 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %441
  store i8 0, i8* %arrayidx148.20, align 1
  br label %for.inc158.20

if.then143.20:                                    ; preds = %lor.lhs.false134.20, %lor.lhs.false126.20, %lor.lhs.false117.20, %lor.lhs.false109.20, %lor.lhs.false101.20, %lor.lhs.false92.20, %lor.lhs.false84.20, %if.then75.20
  %arrayidx145.20 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %441
  store i8 -1, i8* %arrayidx145.20, align 1
  br label %for.inc158.20

if.then67.20:                                     ; preds = %for.body53.20
  %arrayidx69.20 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %441
  store i8 0, i8* %arrayidx69.20, align 1
  br label %for.inc158.20

for.inc158.20:                                    ; preds = %if.then67.20, %if.then143.20, %if.else146.20, %if.else150.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %img_width
  br i1 %exitcond.20, label %for.inc161.20, label %for.body53.20, !llvm.loop !5

for.inc161.20:                                    ; preds = %for.inc158.20
  %indvars.iv.next21.20 = add nsw i64 %indvars.iv20, 21
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.21

for.body53.lr.ph.21:                              ; preds = %for.inc161.20
  %456 = trunc i64 %indvars.iv.next21.20 to i32
  %mul55.21 = shl nsw i32 %456, 7
  %cmp59.21 = icmp eq i64 %indvars.iv.next21.20, %11
  %457 = trunc i64 %indvars.iv.next21.20 to i32
  %sub76.21 = shl i32 %457, 7
  %mul86.21 = add i32 %sub76.21, -128
  %sub103.21 = add i32 %mul55.21, -1
  %add111.21 = or i32 %mul55.21, 1
  %mul128.21 = add i32 %sub76.21, 128
  %458 = sext i32 %mul55.21 to i64
  %459 = sext i32 %mul128.21 to i64
  %460 = sext i32 %mul86.21 to i64
  br label %for.body53.21

for.body53.21:                                    ; preds = %for.inc158.21, %for.body53.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body53.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc158.21 ]
  %461 = add nsw i64 %indvars.iv.21, %458
  %cmp62.21 = icmp eq i64 %indvars.iv.21, 0
  %or.cond1.21 = or i1 %cmp59.21, %cmp62.21
  %cmp65.21 = icmp eq i64 %indvars.iv.21, %10
  %or.cond2.21 = or i1 %cmp65.21, %or.cond1.21
  br i1 %or.cond2.21, label %if.then67.21, label %if.else70.21

if.else70.21:                                     ; preds = %for.body53.21
  %arrayidx72.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %461
  %462 = load i32, i32* %arrayidx72.21, align 4
  %cmp73.21 = icmp eq i32 %462, 75
  br i1 %cmp73.21, label %if.then75.21, label %if.else150.21

if.else150.21:                                    ; preds = %if.else70.21
  %conv153.21 = trunc i32 %462 to i8
  %arrayidx155.21 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %461
  store i8 %conv153.21, i8* %arrayidx155.21, align 1
  br label %for.inc158.21

if.then75.21:                                     ; preds = %if.else70.21
  %463 = trunc i64 %indvars.iv.21 to i32
  %sub78.21 = add i32 %463, %sub76.21
  %add79.21 = add i32 %sub78.21, -129
  %idxprom80.21 = sext i32 %add79.21 to i64
  %arrayidx81.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.21
  %464 = load i32, i32* %arrayidx81.21, align 4
  %cmp82.21 = icmp eq i32 %464, 255
  br i1 %cmp82.21, label %if.then143.21, label %lor.lhs.false84.21

lor.lhs.false84.21:                               ; preds = %if.then75.21
  %465 = add nsw i64 %460, %indvars.iv.21
  %arrayidx89.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %465
  %466 = load i32, i32* %arrayidx89.21, align 4
  %cmp90.21 = icmp eq i32 %466, 255
  br i1 %cmp90.21, label %if.then143.21, label %lor.lhs.false92.21

lor.lhs.false92.21:                               ; preds = %lor.lhs.false84.21
  %add96.21 = add i32 %sub78.21, -127
  %idxprom97.21 = sext i32 %add96.21 to i64
  %arrayidx98.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.21
  %467 = load i32, i32* %arrayidx98.21, align 4
  %cmp99.21 = icmp eq i32 %467, 255
  br i1 %cmp99.21, label %if.then143.21, label %lor.lhs.false101.21

lor.lhs.false101.21:                              ; preds = %lor.lhs.false92.21
  %468 = trunc i64 %indvars.iv.21 to i32
  %add104.21 = add i32 %sub103.21, %468
  %idxprom105.21 = sext i32 %add104.21 to i64
  %arrayidx106.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.21
  %469 = load i32, i32* %arrayidx106.21, align 4
  %cmp107.21 = icmp eq i32 %469, 255
  br i1 %cmp107.21, label %if.then143.21, label %lor.lhs.false109.21

lor.lhs.false109.21:                              ; preds = %lor.lhs.false101.21
  %470 = trunc i64 %indvars.iv.21 to i32
  %add112.21 = add i32 %add111.21, %470
  %idxprom113.21 = sext i32 %add112.21 to i64
  %arrayidx114.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.21
  %471 = load i32, i32* %arrayidx114.21, align 4
  %cmp115.21 = icmp eq i32 %471, 255
  br i1 %cmp115.21, label %if.then143.21, label %lor.lhs.false117.21

lor.lhs.false117.21:                              ; preds = %lor.lhs.false109.21
  %add121.21 = add i32 %sub78.21, 127
  %idxprom122.21 = sext i32 %add121.21 to i64
  %arrayidx123.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.21
  %472 = load i32, i32* %arrayidx123.21, align 4
  %cmp124.21 = icmp eq i32 %472, 255
  br i1 %cmp124.21, label %if.then143.21, label %lor.lhs.false126.21

lor.lhs.false126.21:                              ; preds = %lor.lhs.false117.21
  %473 = add nsw i64 %459, %indvars.iv.21
  %arrayidx131.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %473
  %474 = load i32, i32* %arrayidx131.21, align 4
  %cmp132.21 = icmp eq i32 %474, 255
  br i1 %cmp132.21, label %if.then143.21, label %lor.lhs.false134.21

lor.lhs.false134.21:                              ; preds = %lor.lhs.false126.21
  %add138.21 = add i32 %sub78.21, 129
  %idxprom139.21 = sext i32 %add138.21 to i64
  %arrayidx140.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.21
  %475 = load i32, i32* %arrayidx140.21, align 4
  %cmp141.21 = icmp eq i32 %475, 255
  br i1 %cmp141.21, label %if.then143.21, label %if.else146.21

if.else146.21:                                    ; preds = %lor.lhs.false134.21
  %arrayidx148.21 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %461
  store i8 0, i8* %arrayidx148.21, align 1
  br label %for.inc158.21

if.then143.21:                                    ; preds = %lor.lhs.false134.21, %lor.lhs.false126.21, %lor.lhs.false117.21, %lor.lhs.false109.21, %lor.lhs.false101.21, %lor.lhs.false92.21, %lor.lhs.false84.21, %if.then75.21
  %arrayidx145.21 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %461
  store i8 -1, i8* %arrayidx145.21, align 1
  br label %for.inc158.21

if.then67.21:                                     ; preds = %for.body53.21
  %arrayidx69.21 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %461
  store i8 0, i8* %arrayidx69.21, align 1
  br label %for.inc158.21

for.inc158.21:                                    ; preds = %if.then67.21, %if.then143.21, %if.else146.21, %if.else150.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %img_width
  br i1 %exitcond.21, label %for.inc161.21, label %for.body53.21, !llvm.loop !5

for.inc161.21:                                    ; preds = %for.inc158.21
  %indvars.iv.next21.21 = add nsw i64 %indvars.iv20, 22
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.22

for.body53.lr.ph.22:                              ; preds = %for.inc161.21
  %476 = trunc i64 %indvars.iv.next21.21 to i32
  %mul55.22 = shl nsw i32 %476, 7
  %cmp59.22 = icmp eq i64 %indvars.iv.next21.21, %11
  %477 = trunc i64 %indvars.iv.next21.21 to i32
  %sub76.22 = shl i32 %477, 7
  %mul86.22 = add i32 %sub76.22, -128
  %sub103.22 = add i32 %mul55.22, -1
  %add111.22 = or i32 %mul55.22, 1
  %mul128.22 = add i32 %sub76.22, 128
  %478 = sext i32 %mul55.22 to i64
  %479 = sext i32 %mul128.22 to i64
  %480 = sext i32 %mul86.22 to i64
  br label %for.body53.22

for.body53.22:                                    ; preds = %for.inc158.22, %for.body53.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body53.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc158.22 ]
  %481 = add nsw i64 %indvars.iv.22, %478
  %cmp62.22 = icmp eq i64 %indvars.iv.22, 0
  %or.cond1.22 = or i1 %cmp59.22, %cmp62.22
  %cmp65.22 = icmp eq i64 %indvars.iv.22, %10
  %or.cond2.22 = or i1 %cmp65.22, %or.cond1.22
  br i1 %or.cond2.22, label %if.then67.22, label %if.else70.22

if.else70.22:                                     ; preds = %for.body53.22
  %arrayidx72.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %481
  %482 = load i32, i32* %arrayidx72.22, align 4
  %cmp73.22 = icmp eq i32 %482, 75
  br i1 %cmp73.22, label %if.then75.22, label %if.else150.22

if.else150.22:                                    ; preds = %if.else70.22
  %conv153.22 = trunc i32 %482 to i8
  %arrayidx155.22 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %481
  store i8 %conv153.22, i8* %arrayidx155.22, align 1
  br label %for.inc158.22

if.then75.22:                                     ; preds = %if.else70.22
  %483 = trunc i64 %indvars.iv.22 to i32
  %sub78.22 = add i32 %483, %sub76.22
  %add79.22 = add i32 %sub78.22, -129
  %idxprom80.22 = sext i32 %add79.22 to i64
  %arrayidx81.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.22
  %484 = load i32, i32* %arrayidx81.22, align 4
  %cmp82.22 = icmp eq i32 %484, 255
  br i1 %cmp82.22, label %if.then143.22, label %lor.lhs.false84.22

lor.lhs.false84.22:                               ; preds = %if.then75.22
  %485 = add nsw i64 %480, %indvars.iv.22
  %arrayidx89.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %485
  %486 = load i32, i32* %arrayidx89.22, align 4
  %cmp90.22 = icmp eq i32 %486, 255
  br i1 %cmp90.22, label %if.then143.22, label %lor.lhs.false92.22

lor.lhs.false92.22:                               ; preds = %lor.lhs.false84.22
  %add96.22 = add i32 %sub78.22, -127
  %idxprom97.22 = sext i32 %add96.22 to i64
  %arrayidx98.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.22
  %487 = load i32, i32* %arrayidx98.22, align 4
  %cmp99.22 = icmp eq i32 %487, 255
  br i1 %cmp99.22, label %if.then143.22, label %lor.lhs.false101.22

lor.lhs.false101.22:                              ; preds = %lor.lhs.false92.22
  %488 = trunc i64 %indvars.iv.22 to i32
  %add104.22 = add i32 %sub103.22, %488
  %idxprom105.22 = sext i32 %add104.22 to i64
  %arrayidx106.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.22
  %489 = load i32, i32* %arrayidx106.22, align 4
  %cmp107.22 = icmp eq i32 %489, 255
  br i1 %cmp107.22, label %if.then143.22, label %lor.lhs.false109.22

lor.lhs.false109.22:                              ; preds = %lor.lhs.false101.22
  %490 = trunc i64 %indvars.iv.22 to i32
  %add112.22 = add i32 %add111.22, %490
  %idxprom113.22 = sext i32 %add112.22 to i64
  %arrayidx114.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.22
  %491 = load i32, i32* %arrayidx114.22, align 4
  %cmp115.22 = icmp eq i32 %491, 255
  br i1 %cmp115.22, label %if.then143.22, label %lor.lhs.false117.22

lor.lhs.false117.22:                              ; preds = %lor.lhs.false109.22
  %add121.22 = add i32 %sub78.22, 127
  %idxprom122.22 = sext i32 %add121.22 to i64
  %arrayidx123.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.22
  %492 = load i32, i32* %arrayidx123.22, align 4
  %cmp124.22 = icmp eq i32 %492, 255
  br i1 %cmp124.22, label %if.then143.22, label %lor.lhs.false126.22

lor.lhs.false126.22:                              ; preds = %lor.lhs.false117.22
  %493 = add nsw i64 %479, %indvars.iv.22
  %arrayidx131.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %493
  %494 = load i32, i32* %arrayidx131.22, align 4
  %cmp132.22 = icmp eq i32 %494, 255
  br i1 %cmp132.22, label %if.then143.22, label %lor.lhs.false134.22

lor.lhs.false134.22:                              ; preds = %lor.lhs.false126.22
  %add138.22 = add i32 %sub78.22, 129
  %idxprom139.22 = sext i32 %add138.22 to i64
  %arrayidx140.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.22
  %495 = load i32, i32* %arrayidx140.22, align 4
  %cmp141.22 = icmp eq i32 %495, 255
  br i1 %cmp141.22, label %if.then143.22, label %if.else146.22

if.else146.22:                                    ; preds = %lor.lhs.false134.22
  %arrayidx148.22 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %481
  store i8 0, i8* %arrayidx148.22, align 1
  br label %for.inc158.22

if.then143.22:                                    ; preds = %lor.lhs.false134.22, %lor.lhs.false126.22, %lor.lhs.false117.22, %lor.lhs.false109.22, %lor.lhs.false101.22, %lor.lhs.false92.22, %lor.lhs.false84.22, %if.then75.22
  %arrayidx145.22 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %481
  store i8 -1, i8* %arrayidx145.22, align 1
  br label %for.inc158.22

if.then67.22:                                     ; preds = %for.body53.22
  %arrayidx69.22 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %481
  store i8 0, i8* %arrayidx69.22, align 1
  br label %for.inc158.22

for.inc158.22:                                    ; preds = %if.then67.22, %if.then143.22, %if.else146.22, %if.else150.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %img_width
  br i1 %exitcond.22, label %for.inc161.22, label %for.body53.22, !llvm.loop !5

for.inc161.22:                                    ; preds = %for.inc158.22
  %indvars.iv.next21.22 = add nsw i64 %indvars.iv20, 23
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.23

for.body53.lr.ph.23:                              ; preds = %for.inc161.22
  %496 = trunc i64 %indvars.iv.next21.22 to i32
  %mul55.23 = shl nsw i32 %496, 7
  %cmp59.23 = icmp eq i64 %indvars.iv.next21.22, %11
  %497 = trunc i64 %indvars.iv.next21.22 to i32
  %sub76.23 = shl i32 %497, 7
  %mul86.23 = add i32 %sub76.23, -128
  %sub103.23 = add i32 %mul55.23, -1
  %add111.23 = or i32 %mul55.23, 1
  %mul128.23 = add i32 %sub76.23, 128
  %498 = sext i32 %mul55.23 to i64
  %499 = sext i32 %mul128.23 to i64
  %500 = sext i32 %mul86.23 to i64
  br label %for.body53.23

for.body53.23:                                    ; preds = %for.inc158.23, %for.body53.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body53.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc158.23 ]
  %501 = add nsw i64 %indvars.iv.23, %498
  %cmp62.23 = icmp eq i64 %indvars.iv.23, 0
  %or.cond1.23 = or i1 %cmp59.23, %cmp62.23
  %cmp65.23 = icmp eq i64 %indvars.iv.23, %10
  %or.cond2.23 = or i1 %cmp65.23, %or.cond1.23
  br i1 %or.cond2.23, label %if.then67.23, label %if.else70.23

if.else70.23:                                     ; preds = %for.body53.23
  %arrayidx72.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %501
  %502 = load i32, i32* %arrayidx72.23, align 4
  %cmp73.23 = icmp eq i32 %502, 75
  br i1 %cmp73.23, label %if.then75.23, label %if.else150.23

if.else150.23:                                    ; preds = %if.else70.23
  %conv153.23 = trunc i32 %502 to i8
  %arrayidx155.23 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %501
  store i8 %conv153.23, i8* %arrayidx155.23, align 1
  br label %for.inc158.23

if.then75.23:                                     ; preds = %if.else70.23
  %503 = trunc i64 %indvars.iv.23 to i32
  %sub78.23 = add i32 %503, %sub76.23
  %add79.23 = add i32 %sub78.23, -129
  %idxprom80.23 = sext i32 %add79.23 to i64
  %arrayidx81.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.23
  %504 = load i32, i32* %arrayidx81.23, align 4
  %cmp82.23 = icmp eq i32 %504, 255
  br i1 %cmp82.23, label %if.then143.23, label %lor.lhs.false84.23

lor.lhs.false84.23:                               ; preds = %if.then75.23
  %505 = add nsw i64 %500, %indvars.iv.23
  %arrayidx89.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %505
  %506 = load i32, i32* %arrayidx89.23, align 4
  %cmp90.23 = icmp eq i32 %506, 255
  br i1 %cmp90.23, label %if.then143.23, label %lor.lhs.false92.23

lor.lhs.false92.23:                               ; preds = %lor.lhs.false84.23
  %add96.23 = add i32 %sub78.23, -127
  %idxprom97.23 = sext i32 %add96.23 to i64
  %arrayidx98.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.23
  %507 = load i32, i32* %arrayidx98.23, align 4
  %cmp99.23 = icmp eq i32 %507, 255
  br i1 %cmp99.23, label %if.then143.23, label %lor.lhs.false101.23

lor.lhs.false101.23:                              ; preds = %lor.lhs.false92.23
  %508 = trunc i64 %indvars.iv.23 to i32
  %add104.23 = add i32 %sub103.23, %508
  %idxprom105.23 = sext i32 %add104.23 to i64
  %arrayidx106.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.23
  %509 = load i32, i32* %arrayidx106.23, align 4
  %cmp107.23 = icmp eq i32 %509, 255
  br i1 %cmp107.23, label %if.then143.23, label %lor.lhs.false109.23

lor.lhs.false109.23:                              ; preds = %lor.lhs.false101.23
  %510 = trunc i64 %indvars.iv.23 to i32
  %add112.23 = add i32 %add111.23, %510
  %idxprom113.23 = sext i32 %add112.23 to i64
  %arrayidx114.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.23
  %511 = load i32, i32* %arrayidx114.23, align 4
  %cmp115.23 = icmp eq i32 %511, 255
  br i1 %cmp115.23, label %if.then143.23, label %lor.lhs.false117.23

lor.lhs.false117.23:                              ; preds = %lor.lhs.false109.23
  %add121.23 = add i32 %sub78.23, 127
  %idxprom122.23 = sext i32 %add121.23 to i64
  %arrayidx123.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.23
  %512 = load i32, i32* %arrayidx123.23, align 4
  %cmp124.23 = icmp eq i32 %512, 255
  br i1 %cmp124.23, label %if.then143.23, label %lor.lhs.false126.23

lor.lhs.false126.23:                              ; preds = %lor.lhs.false117.23
  %513 = add nsw i64 %499, %indvars.iv.23
  %arrayidx131.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %513
  %514 = load i32, i32* %arrayidx131.23, align 4
  %cmp132.23 = icmp eq i32 %514, 255
  br i1 %cmp132.23, label %if.then143.23, label %lor.lhs.false134.23

lor.lhs.false134.23:                              ; preds = %lor.lhs.false126.23
  %add138.23 = add i32 %sub78.23, 129
  %idxprom139.23 = sext i32 %add138.23 to i64
  %arrayidx140.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.23
  %515 = load i32, i32* %arrayidx140.23, align 4
  %cmp141.23 = icmp eq i32 %515, 255
  br i1 %cmp141.23, label %if.then143.23, label %if.else146.23

if.else146.23:                                    ; preds = %lor.lhs.false134.23
  %arrayidx148.23 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %501
  store i8 0, i8* %arrayidx148.23, align 1
  br label %for.inc158.23

if.then143.23:                                    ; preds = %lor.lhs.false134.23, %lor.lhs.false126.23, %lor.lhs.false117.23, %lor.lhs.false109.23, %lor.lhs.false101.23, %lor.lhs.false92.23, %lor.lhs.false84.23, %if.then75.23
  %arrayidx145.23 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %501
  store i8 -1, i8* %arrayidx145.23, align 1
  br label %for.inc158.23

if.then67.23:                                     ; preds = %for.body53.23
  %arrayidx69.23 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %501
  store i8 0, i8* %arrayidx69.23, align 1
  br label %for.inc158.23

for.inc158.23:                                    ; preds = %if.then67.23, %if.then143.23, %if.else146.23, %if.else150.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %img_width
  br i1 %exitcond.23, label %for.inc161.23, label %for.body53.23, !llvm.loop !5

for.inc161.23:                                    ; preds = %for.inc158.23
  %indvars.iv.next21.23 = add nsw i64 %indvars.iv20, 24
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.24

for.body53.lr.ph.24:                              ; preds = %for.inc161.23
  %516 = trunc i64 %indvars.iv.next21.23 to i32
  %mul55.24 = shl nsw i32 %516, 7
  %cmp59.24 = icmp eq i64 %indvars.iv.next21.23, %11
  %517 = trunc i64 %indvars.iv.next21.23 to i32
  %sub76.24 = shl i32 %517, 7
  %mul86.24 = add i32 %sub76.24, -128
  %sub103.24 = add i32 %mul55.24, -1
  %add111.24 = or i32 %mul55.24, 1
  %mul128.24 = add i32 %sub76.24, 128
  %518 = sext i32 %mul55.24 to i64
  %519 = sext i32 %mul128.24 to i64
  %520 = sext i32 %mul86.24 to i64
  br label %for.body53.24

for.body53.24:                                    ; preds = %for.inc158.24, %for.body53.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body53.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc158.24 ]
  %521 = add nsw i64 %indvars.iv.24, %518
  %cmp62.24 = icmp eq i64 %indvars.iv.24, 0
  %or.cond1.24 = or i1 %cmp59.24, %cmp62.24
  %cmp65.24 = icmp eq i64 %indvars.iv.24, %10
  %or.cond2.24 = or i1 %cmp65.24, %or.cond1.24
  br i1 %or.cond2.24, label %if.then67.24, label %if.else70.24

if.else70.24:                                     ; preds = %for.body53.24
  %arrayidx72.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %521
  %522 = load i32, i32* %arrayidx72.24, align 4
  %cmp73.24 = icmp eq i32 %522, 75
  br i1 %cmp73.24, label %if.then75.24, label %if.else150.24

if.else150.24:                                    ; preds = %if.else70.24
  %conv153.24 = trunc i32 %522 to i8
  %arrayidx155.24 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %521
  store i8 %conv153.24, i8* %arrayidx155.24, align 1
  br label %for.inc158.24

if.then75.24:                                     ; preds = %if.else70.24
  %523 = trunc i64 %indvars.iv.24 to i32
  %sub78.24 = add i32 %523, %sub76.24
  %add79.24 = add i32 %sub78.24, -129
  %idxprom80.24 = sext i32 %add79.24 to i64
  %arrayidx81.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.24
  %524 = load i32, i32* %arrayidx81.24, align 4
  %cmp82.24 = icmp eq i32 %524, 255
  br i1 %cmp82.24, label %if.then143.24, label %lor.lhs.false84.24

lor.lhs.false84.24:                               ; preds = %if.then75.24
  %525 = add nsw i64 %520, %indvars.iv.24
  %arrayidx89.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %525
  %526 = load i32, i32* %arrayidx89.24, align 4
  %cmp90.24 = icmp eq i32 %526, 255
  br i1 %cmp90.24, label %if.then143.24, label %lor.lhs.false92.24

lor.lhs.false92.24:                               ; preds = %lor.lhs.false84.24
  %add96.24 = add i32 %sub78.24, -127
  %idxprom97.24 = sext i32 %add96.24 to i64
  %arrayidx98.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.24
  %527 = load i32, i32* %arrayidx98.24, align 4
  %cmp99.24 = icmp eq i32 %527, 255
  br i1 %cmp99.24, label %if.then143.24, label %lor.lhs.false101.24

lor.lhs.false101.24:                              ; preds = %lor.lhs.false92.24
  %528 = trunc i64 %indvars.iv.24 to i32
  %add104.24 = add i32 %sub103.24, %528
  %idxprom105.24 = sext i32 %add104.24 to i64
  %arrayidx106.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.24
  %529 = load i32, i32* %arrayidx106.24, align 4
  %cmp107.24 = icmp eq i32 %529, 255
  br i1 %cmp107.24, label %if.then143.24, label %lor.lhs.false109.24

lor.lhs.false109.24:                              ; preds = %lor.lhs.false101.24
  %530 = trunc i64 %indvars.iv.24 to i32
  %add112.24 = add i32 %add111.24, %530
  %idxprom113.24 = sext i32 %add112.24 to i64
  %arrayidx114.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.24
  %531 = load i32, i32* %arrayidx114.24, align 4
  %cmp115.24 = icmp eq i32 %531, 255
  br i1 %cmp115.24, label %if.then143.24, label %lor.lhs.false117.24

lor.lhs.false117.24:                              ; preds = %lor.lhs.false109.24
  %add121.24 = add i32 %sub78.24, 127
  %idxprom122.24 = sext i32 %add121.24 to i64
  %arrayidx123.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.24
  %532 = load i32, i32* %arrayidx123.24, align 4
  %cmp124.24 = icmp eq i32 %532, 255
  br i1 %cmp124.24, label %if.then143.24, label %lor.lhs.false126.24

lor.lhs.false126.24:                              ; preds = %lor.lhs.false117.24
  %533 = add nsw i64 %519, %indvars.iv.24
  %arrayidx131.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %533
  %534 = load i32, i32* %arrayidx131.24, align 4
  %cmp132.24 = icmp eq i32 %534, 255
  br i1 %cmp132.24, label %if.then143.24, label %lor.lhs.false134.24

lor.lhs.false134.24:                              ; preds = %lor.lhs.false126.24
  %add138.24 = add i32 %sub78.24, 129
  %idxprom139.24 = sext i32 %add138.24 to i64
  %arrayidx140.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.24
  %535 = load i32, i32* %arrayidx140.24, align 4
  %cmp141.24 = icmp eq i32 %535, 255
  br i1 %cmp141.24, label %if.then143.24, label %if.else146.24

if.else146.24:                                    ; preds = %lor.lhs.false134.24
  %arrayidx148.24 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %521
  store i8 0, i8* %arrayidx148.24, align 1
  br label %for.inc158.24

if.then143.24:                                    ; preds = %lor.lhs.false134.24, %lor.lhs.false126.24, %lor.lhs.false117.24, %lor.lhs.false109.24, %lor.lhs.false101.24, %lor.lhs.false92.24, %lor.lhs.false84.24, %if.then75.24
  %arrayidx145.24 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %521
  store i8 -1, i8* %arrayidx145.24, align 1
  br label %for.inc158.24

if.then67.24:                                     ; preds = %for.body53.24
  %arrayidx69.24 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %521
  store i8 0, i8* %arrayidx69.24, align 1
  br label %for.inc158.24

for.inc158.24:                                    ; preds = %if.then67.24, %if.then143.24, %if.else146.24, %if.else150.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %img_width
  br i1 %exitcond.24, label %for.inc161.24, label %for.body53.24, !llvm.loop !5

for.inc161.24:                                    ; preds = %for.inc158.24
  %indvars.iv.next21.24 = add nsw i64 %indvars.iv20, 25
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.25

for.body53.lr.ph.25:                              ; preds = %for.inc161.24
  %536 = trunc i64 %indvars.iv.next21.24 to i32
  %mul55.25 = shl nsw i32 %536, 7
  %cmp59.25 = icmp eq i64 %indvars.iv.next21.24, %11
  %537 = trunc i64 %indvars.iv.next21.24 to i32
  %sub76.25 = shl i32 %537, 7
  %mul86.25 = add i32 %sub76.25, -128
  %sub103.25 = add i32 %mul55.25, -1
  %add111.25 = or i32 %mul55.25, 1
  %mul128.25 = add i32 %sub76.25, 128
  %538 = sext i32 %mul55.25 to i64
  %539 = sext i32 %mul128.25 to i64
  %540 = sext i32 %mul86.25 to i64
  br label %for.body53.25

for.body53.25:                                    ; preds = %for.inc158.25, %for.body53.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body53.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc158.25 ]
  %541 = add nsw i64 %indvars.iv.25, %538
  %cmp62.25 = icmp eq i64 %indvars.iv.25, 0
  %or.cond1.25 = or i1 %cmp59.25, %cmp62.25
  %cmp65.25 = icmp eq i64 %indvars.iv.25, %10
  %or.cond2.25 = or i1 %cmp65.25, %or.cond1.25
  br i1 %or.cond2.25, label %if.then67.25, label %if.else70.25

if.else70.25:                                     ; preds = %for.body53.25
  %arrayidx72.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %541
  %542 = load i32, i32* %arrayidx72.25, align 4
  %cmp73.25 = icmp eq i32 %542, 75
  br i1 %cmp73.25, label %if.then75.25, label %if.else150.25

if.else150.25:                                    ; preds = %if.else70.25
  %conv153.25 = trunc i32 %542 to i8
  %arrayidx155.25 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %541
  store i8 %conv153.25, i8* %arrayidx155.25, align 1
  br label %for.inc158.25

if.then75.25:                                     ; preds = %if.else70.25
  %543 = trunc i64 %indvars.iv.25 to i32
  %sub78.25 = add i32 %543, %sub76.25
  %add79.25 = add i32 %sub78.25, -129
  %idxprom80.25 = sext i32 %add79.25 to i64
  %arrayidx81.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.25
  %544 = load i32, i32* %arrayidx81.25, align 4
  %cmp82.25 = icmp eq i32 %544, 255
  br i1 %cmp82.25, label %if.then143.25, label %lor.lhs.false84.25

lor.lhs.false84.25:                               ; preds = %if.then75.25
  %545 = add nsw i64 %540, %indvars.iv.25
  %arrayidx89.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %545
  %546 = load i32, i32* %arrayidx89.25, align 4
  %cmp90.25 = icmp eq i32 %546, 255
  br i1 %cmp90.25, label %if.then143.25, label %lor.lhs.false92.25

lor.lhs.false92.25:                               ; preds = %lor.lhs.false84.25
  %add96.25 = add i32 %sub78.25, -127
  %idxprom97.25 = sext i32 %add96.25 to i64
  %arrayidx98.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.25
  %547 = load i32, i32* %arrayidx98.25, align 4
  %cmp99.25 = icmp eq i32 %547, 255
  br i1 %cmp99.25, label %if.then143.25, label %lor.lhs.false101.25

lor.lhs.false101.25:                              ; preds = %lor.lhs.false92.25
  %548 = trunc i64 %indvars.iv.25 to i32
  %add104.25 = add i32 %sub103.25, %548
  %idxprom105.25 = sext i32 %add104.25 to i64
  %arrayidx106.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.25
  %549 = load i32, i32* %arrayidx106.25, align 4
  %cmp107.25 = icmp eq i32 %549, 255
  br i1 %cmp107.25, label %if.then143.25, label %lor.lhs.false109.25

lor.lhs.false109.25:                              ; preds = %lor.lhs.false101.25
  %550 = trunc i64 %indvars.iv.25 to i32
  %add112.25 = add i32 %add111.25, %550
  %idxprom113.25 = sext i32 %add112.25 to i64
  %arrayidx114.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.25
  %551 = load i32, i32* %arrayidx114.25, align 4
  %cmp115.25 = icmp eq i32 %551, 255
  br i1 %cmp115.25, label %if.then143.25, label %lor.lhs.false117.25

lor.lhs.false117.25:                              ; preds = %lor.lhs.false109.25
  %add121.25 = add i32 %sub78.25, 127
  %idxprom122.25 = sext i32 %add121.25 to i64
  %arrayidx123.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.25
  %552 = load i32, i32* %arrayidx123.25, align 4
  %cmp124.25 = icmp eq i32 %552, 255
  br i1 %cmp124.25, label %if.then143.25, label %lor.lhs.false126.25

lor.lhs.false126.25:                              ; preds = %lor.lhs.false117.25
  %553 = add nsw i64 %539, %indvars.iv.25
  %arrayidx131.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %553
  %554 = load i32, i32* %arrayidx131.25, align 4
  %cmp132.25 = icmp eq i32 %554, 255
  br i1 %cmp132.25, label %if.then143.25, label %lor.lhs.false134.25

lor.lhs.false134.25:                              ; preds = %lor.lhs.false126.25
  %add138.25 = add i32 %sub78.25, 129
  %idxprom139.25 = sext i32 %add138.25 to i64
  %arrayidx140.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.25
  %555 = load i32, i32* %arrayidx140.25, align 4
  %cmp141.25 = icmp eq i32 %555, 255
  br i1 %cmp141.25, label %if.then143.25, label %if.else146.25

if.else146.25:                                    ; preds = %lor.lhs.false134.25
  %arrayidx148.25 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %541
  store i8 0, i8* %arrayidx148.25, align 1
  br label %for.inc158.25

if.then143.25:                                    ; preds = %lor.lhs.false134.25, %lor.lhs.false126.25, %lor.lhs.false117.25, %lor.lhs.false109.25, %lor.lhs.false101.25, %lor.lhs.false92.25, %lor.lhs.false84.25, %if.then75.25
  %arrayidx145.25 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %541
  store i8 -1, i8* %arrayidx145.25, align 1
  br label %for.inc158.25

if.then67.25:                                     ; preds = %for.body53.25
  %arrayidx69.25 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %541
  store i8 0, i8* %arrayidx69.25, align 1
  br label %for.inc158.25

for.inc158.25:                                    ; preds = %if.then67.25, %if.then143.25, %if.else146.25, %if.else150.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %img_width
  br i1 %exitcond.25, label %for.inc161.25, label %for.body53.25, !llvm.loop !5

for.inc161.25:                                    ; preds = %for.inc158.25
  %indvars.iv.next21.25 = add nsw i64 %indvars.iv20, 26
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.26

for.body53.lr.ph.26:                              ; preds = %for.inc161.25
  %556 = trunc i64 %indvars.iv.next21.25 to i32
  %mul55.26 = shl nsw i32 %556, 7
  %cmp59.26 = icmp eq i64 %indvars.iv.next21.25, %11
  %557 = trunc i64 %indvars.iv.next21.25 to i32
  %sub76.26 = shl i32 %557, 7
  %mul86.26 = add i32 %sub76.26, -128
  %sub103.26 = add i32 %mul55.26, -1
  %add111.26 = or i32 %mul55.26, 1
  %mul128.26 = add i32 %sub76.26, 128
  %558 = sext i32 %mul55.26 to i64
  %559 = sext i32 %mul128.26 to i64
  %560 = sext i32 %mul86.26 to i64
  br label %for.body53.26

for.body53.26:                                    ; preds = %for.inc158.26, %for.body53.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body53.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc158.26 ]
  %561 = add nsw i64 %indvars.iv.26, %558
  %cmp62.26 = icmp eq i64 %indvars.iv.26, 0
  %or.cond1.26 = or i1 %cmp59.26, %cmp62.26
  %cmp65.26 = icmp eq i64 %indvars.iv.26, %10
  %or.cond2.26 = or i1 %cmp65.26, %or.cond1.26
  br i1 %or.cond2.26, label %if.then67.26, label %if.else70.26

if.else70.26:                                     ; preds = %for.body53.26
  %arrayidx72.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %561
  %562 = load i32, i32* %arrayidx72.26, align 4
  %cmp73.26 = icmp eq i32 %562, 75
  br i1 %cmp73.26, label %if.then75.26, label %if.else150.26

if.else150.26:                                    ; preds = %if.else70.26
  %conv153.26 = trunc i32 %562 to i8
  %arrayidx155.26 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %561
  store i8 %conv153.26, i8* %arrayidx155.26, align 1
  br label %for.inc158.26

if.then75.26:                                     ; preds = %if.else70.26
  %563 = trunc i64 %indvars.iv.26 to i32
  %sub78.26 = add i32 %563, %sub76.26
  %add79.26 = add i32 %sub78.26, -129
  %idxprom80.26 = sext i32 %add79.26 to i64
  %arrayidx81.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.26
  %564 = load i32, i32* %arrayidx81.26, align 4
  %cmp82.26 = icmp eq i32 %564, 255
  br i1 %cmp82.26, label %if.then143.26, label %lor.lhs.false84.26

lor.lhs.false84.26:                               ; preds = %if.then75.26
  %565 = add nsw i64 %560, %indvars.iv.26
  %arrayidx89.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %565
  %566 = load i32, i32* %arrayidx89.26, align 4
  %cmp90.26 = icmp eq i32 %566, 255
  br i1 %cmp90.26, label %if.then143.26, label %lor.lhs.false92.26

lor.lhs.false92.26:                               ; preds = %lor.lhs.false84.26
  %add96.26 = add i32 %sub78.26, -127
  %idxprom97.26 = sext i32 %add96.26 to i64
  %arrayidx98.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.26
  %567 = load i32, i32* %arrayidx98.26, align 4
  %cmp99.26 = icmp eq i32 %567, 255
  br i1 %cmp99.26, label %if.then143.26, label %lor.lhs.false101.26

lor.lhs.false101.26:                              ; preds = %lor.lhs.false92.26
  %568 = trunc i64 %indvars.iv.26 to i32
  %add104.26 = add i32 %sub103.26, %568
  %idxprom105.26 = sext i32 %add104.26 to i64
  %arrayidx106.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.26
  %569 = load i32, i32* %arrayidx106.26, align 4
  %cmp107.26 = icmp eq i32 %569, 255
  br i1 %cmp107.26, label %if.then143.26, label %lor.lhs.false109.26

lor.lhs.false109.26:                              ; preds = %lor.lhs.false101.26
  %570 = trunc i64 %indvars.iv.26 to i32
  %add112.26 = add i32 %add111.26, %570
  %idxprom113.26 = sext i32 %add112.26 to i64
  %arrayidx114.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.26
  %571 = load i32, i32* %arrayidx114.26, align 4
  %cmp115.26 = icmp eq i32 %571, 255
  br i1 %cmp115.26, label %if.then143.26, label %lor.lhs.false117.26

lor.lhs.false117.26:                              ; preds = %lor.lhs.false109.26
  %add121.26 = add i32 %sub78.26, 127
  %idxprom122.26 = sext i32 %add121.26 to i64
  %arrayidx123.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.26
  %572 = load i32, i32* %arrayidx123.26, align 4
  %cmp124.26 = icmp eq i32 %572, 255
  br i1 %cmp124.26, label %if.then143.26, label %lor.lhs.false126.26

lor.lhs.false126.26:                              ; preds = %lor.lhs.false117.26
  %573 = add nsw i64 %559, %indvars.iv.26
  %arrayidx131.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %573
  %574 = load i32, i32* %arrayidx131.26, align 4
  %cmp132.26 = icmp eq i32 %574, 255
  br i1 %cmp132.26, label %if.then143.26, label %lor.lhs.false134.26

lor.lhs.false134.26:                              ; preds = %lor.lhs.false126.26
  %add138.26 = add i32 %sub78.26, 129
  %idxprom139.26 = sext i32 %add138.26 to i64
  %arrayidx140.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.26
  %575 = load i32, i32* %arrayidx140.26, align 4
  %cmp141.26 = icmp eq i32 %575, 255
  br i1 %cmp141.26, label %if.then143.26, label %if.else146.26

if.else146.26:                                    ; preds = %lor.lhs.false134.26
  %arrayidx148.26 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %561
  store i8 0, i8* %arrayidx148.26, align 1
  br label %for.inc158.26

if.then143.26:                                    ; preds = %lor.lhs.false134.26, %lor.lhs.false126.26, %lor.lhs.false117.26, %lor.lhs.false109.26, %lor.lhs.false101.26, %lor.lhs.false92.26, %lor.lhs.false84.26, %if.then75.26
  %arrayidx145.26 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %561
  store i8 -1, i8* %arrayidx145.26, align 1
  br label %for.inc158.26

if.then67.26:                                     ; preds = %for.body53.26
  %arrayidx69.26 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %561
  store i8 0, i8* %arrayidx69.26, align 1
  br label %for.inc158.26

for.inc158.26:                                    ; preds = %if.then67.26, %if.then143.26, %if.else146.26, %if.else150.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %img_width
  br i1 %exitcond.26, label %for.inc161.26, label %for.body53.26, !llvm.loop !5

for.inc161.26:                                    ; preds = %for.inc158.26
  %indvars.iv.next21.26 = add nsw i64 %indvars.iv20, 27
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.27

for.body53.lr.ph.27:                              ; preds = %for.inc161.26
  %576 = trunc i64 %indvars.iv.next21.26 to i32
  %mul55.27 = shl nsw i32 %576, 7
  %cmp59.27 = icmp eq i64 %indvars.iv.next21.26, %11
  %577 = trunc i64 %indvars.iv.next21.26 to i32
  %sub76.27 = shl i32 %577, 7
  %mul86.27 = add i32 %sub76.27, -128
  %sub103.27 = add i32 %mul55.27, -1
  %add111.27 = or i32 %mul55.27, 1
  %mul128.27 = add i32 %sub76.27, 128
  %578 = sext i32 %mul55.27 to i64
  %579 = sext i32 %mul128.27 to i64
  %580 = sext i32 %mul86.27 to i64
  br label %for.body53.27

for.body53.27:                                    ; preds = %for.inc158.27, %for.body53.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body53.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc158.27 ]
  %581 = add nsw i64 %indvars.iv.27, %578
  %cmp62.27 = icmp eq i64 %indvars.iv.27, 0
  %or.cond1.27 = or i1 %cmp59.27, %cmp62.27
  %cmp65.27 = icmp eq i64 %indvars.iv.27, %10
  %or.cond2.27 = or i1 %cmp65.27, %or.cond1.27
  br i1 %or.cond2.27, label %if.then67.27, label %if.else70.27

if.else70.27:                                     ; preds = %for.body53.27
  %arrayidx72.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %581
  %582 = load i32, i32* %arrayidx72.27, align 4
  %cmp73.27 = icmp eq i32 %582, 75
  br i1 %cmp73.27, label %if.then75.27, label %if.else150.27

if.else150.27:                                    ; preds = %if.else70.27
  %conv153.27 = trunc i32 %582 to i8
  %arrayidx155.27 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %581
  store i8 %conv153.27, i8* %arrayidx155.27, align 1
  br label %for.inc158.27

if.then75.27:                                     ; preds = %if.else70.27
  %583 = trunc i64 %indvars.iv.27 to i32
  %sub78.27 = add i32 %583, %sub76.27
  %add79.27 = add i32 %sub78.27, -129
  %idxprom80.27 = sext i32 %add79.27 to i64
  %arrayidx81.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.27
  %584 = load i32, i32* %arrayidx81.27, align 4
  %cmp82.27 = icmp eq i32 %584, 255
  br i1 %cmp82.27, label %if.then143.27, label %lor.lhs.false84.27

lor.lhs.false84.27:                               ; preds = %if.then75.27
  %585 = add nsw i64 %580, %indvars.iv.27
  %arrayidx89.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %585
  %586 = load i32, i32* %arrayidx89.27, align 4
  %cmp90.27 = icmp eq i32 %586, 255
  br i1 %cmp90.27, label %if.then143.27, label %lor.lhs.false92.27

lor.lhs.false92.27:                               ; preds = %lor.lhs.false84.27
  %add96.27 = add i32 %sub78.27, -127
  %idxprom97.27 = sext i32 %add96.27 to i64
  %arrayidx98.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.27
  %587 = load i32, i32* %arrayidx98.27, align 4
  %cmp99.27 = icmp eq i32 %587, 255
  br i1 %cmp99.27, label %if.then143.27, label %lor.lhs.false101.27

lor.lhs.false101.27:                              ; preds = %lor.lhs.false92.27
  %588 = trunc i64 %indvars.iv.27 to i32
  %add104.27 = add i32 %sub103.27, %588
  %idxprom105.27 = sext i32 %add104.27 to i64
  %arrayidx106.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.27
  %589 = load i32, i32* %arrayidx106.27, align 4
  %cmp107.27 = icmp eq i32 %589, 255
  br i1 %cmp107.27, label %if.then143.27, label %lor.lhs.false109.27

lor.lhs.false109.27:                              ; preds = %lor.lhs.false101.27
  %590 = trunc i64 %indvars.iv.27 to i32
  %add112.27 = add i32 %add111.27, %590
  %idxprom113.27 = sext i32 %add112.27 to i64
  %arrayidx114.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.27
  %591 = load i32, i32* %arrayidx114.27, align 4
  %cmp115.27 = icmp eq i32 %591, 255
  br i1 %cmp115.27, label %if.then143.27, label %lor.lhs.false117.27

lor.lhs.false117.27:                              ; preds = %lor.lhs.false109.27
  %add121.27 = add i32 %sub78.27, 127
  %idxprom122.27 = sext i32 %add121.27 to i64
  %arrayidx123.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.27
  %592 = load i32, i32* %arrayidx123.27, align 4
  %cmp124.27 = icmp eq i32 %592, 255
  br i1 %cmp124.27, label %if.then143.27, label %lor.lhs.false126.27

lor.lhs.false126.27:                              ; preds = %lor.lhs.false117.27
  %593 = add nsw i64 %579, %indvars.iv.27
  %arrayidx131.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %593
  %594 = load i32, i32* %arrayidx131.27, align 4
  %cmp132.27 = icmp eq i32 %594, 255
  br i1 %cmp132.27, label %if.then143.27, label %lor.lhs.false134.27

lor.lhs.false134.27:                              ; preds = %lor.lhs.false126.27
  %add138.27 = add i32 %sub78.27, 129
  %idxprom139.27 = sext i32 %add138.27 to i64
  %arrayidx140.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.27
  %595 = load i32, i32* %arrayidx140.27, align 4
  %cmp141.27 = icmp eq i32 %595, 255
  br i1 %cmp141.27, label %if.then143.27, label %if.else146.27

if.else146.27:                                    ; preds = %lor.lhs.false134.27
  %arrayidx148.27 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %581
  store i8 0, i8* %arrayidx148.27, align 1
  br label %for.inc158.27

if.then143.27:                                    ; preds = %lor.lhs.false134.27, %lor.lhs.false126.27, %lor.lhs.false117.27, %lor.lhs.false109.27, %lor.lhs.false101.27, %lor.lhs.false92.27, %lor.lhs.false84.27, %if.then75.27
  %arrayidx145.27 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %581
  store i8 -1, i8* %arrayidx145.27, align 1
  br label %for.inc158.27

if.then67.27:                                     ; preds = %for.body53.27
  %arrayidx69.27 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %581
  store i8 0, i8* %arrayidx69.27, align 1
  br label %for.inc158.27

for.inc158.27:                                    ; preds = %if.then67.27, %if.then143.27, %if.else146.27, %if.else150.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %img_width
  br i1 %exitcond.27, label %for.inc161.27, label %for.body53.27, !llvm.loop !5

for.inc161.27:                                    ; preds = %for.inc158.27
  %indvars.iv.next21.27 = add nsw i64 %indvars.iv20, 28
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.28

for.body53.lr.ph.28:                              ; preds = %for.inc161.27
  %596 = trunc i64 %indvars.iv.next21.27 to i32
  %mul55.28 = shl nsw i32 %596, 7
  %cmp59.28 = icmp eq i64 %indvars.iv.next21.27, %11
  %597 = trunc i64 %indvars.iv.next21.27 to i32
  %sub76.28 = shl i32 %597, 7
  %mul86.28 = add i32 %sub76.28, -128
  %sub103.28 = add i32 %mul55.28, -1
  %add111.28 = or i32 %mul55.28, 1
  %mul128.28 = add i32 %sub76.28, 128
  %598 = sext i32 %mul55.28 to i64
  %599 = sext i32 %mul128.28 to i64
  %600 = sext i32 %mul86.28 to i64
  br label %for.body53.28

for.body53.28:                                    ; preds = %for.inc158.28, %for.body53.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body53.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc158.28 ]
  %601 = add nsw i64 %indvars.iv.28, %598
  %cmp62.28 = icmp eq i64 %indvars.iv.28, 0
  %or.cond1.28 = or i1 %cmp59.28, %cmp62.28
  %cmp65.28 = icmp eq i64 %indvars.iv.28, %10
  %or.cond2.28 = or i1 %cmp65.28, %or.cond1.28
  br i1 %or.cond2.28, label %if.then67.28, label %if.else70.28

if.else70.28:                                     ; preds = %for.body53.28
  %arrayidx72.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %601
  %602 = load i32, i32* %arrayidx72.28, align 4
  %cmp73.28 = icmp eq i32 %602, 75
  br i1 %cmp73.28, label %if.then75.28, label %if.else150.28

if.else150.28:                                    ; preds = %if.else70.28
  %conv153.28 = trunc i32 %602 to i8
  %arrayidx155.28 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %601
  store i8 %conv153.28, i8* %arrayidx155.28, align 1
  br label %for.inc158.28

if.then75.28:                                     ; preds = %if.else70.28
  %603 = trunc i64 %indvars.iv.28 to i32
  %sub78.28 = add i32 %603, %sub76.28
  %add79.28 = add i32 %sub78.28, -129
  %idxprom80.28 = sext i32 %add79.28 to i64
  %arrayidx81.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.28
  %604 = load i32, i32* %arrayidx81.28, align 4
  %cmp82.28 = icmp eq i32 %604, 255
  br i1 %cmp82.28, label %if.then143.28, label %lor.lhs.false84.28

lor.lhs.false84.28:                               ; preds = %if.then75.28
  %605 = add nsw i64 %600, %indvars.iv.28
  %arrayidx89.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %605
  %606 = load i32, i32* %arrayidx89.28, align 4
  %cmp90.28 = icmp eq i32 %606, 255
  br i1 %cmp90.28, label %if.then143.28, label %lor.lhs.false92.28

lor.lhs.false92.28:                               ; preds = %lor.lhs.false84.28
  %add96.28 = add i32 %sub78.28, -127
  %idxprom97.28 = sext i32 %add96.28 to i64
  %arrayidx98.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.28
  %607 = load i32, i32* %arrayidx98.28, align 4
  %cmp99.28 = icmp eq i32 %607, 255
  br i1 %cmp99.28, label %if.then143.28, label %lor.lhs.false101.28

lor.lhs.false101.28:                              ; preds = %lor.lhs.false92.28
  %608 = trunc i64 %indvars.iv.28 to i32
  %add104.28 = add i32 %sub103.28, %608
  %idxprom105.28 = sext i32 %add104.28 to i64
  %arrayidx106.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.28
  %609 = load i32, i32* %arrayidx106.28, align 4
  %cmp107.28 = icmp eq i32 %609, 255
  br i1 %cmp107.28, label %if.then143.28, label %lor.lhs.false109.28

lor.lhs.false109.28:                              ; preds = %lor.lhs.false101.28
  %610 = trunc i64 %indvars.iv.28 to i32
  %add112.28 = add i32 %add111.28, %610
  %idxprom113.28 = sext i32 %add112.28 to i64
  %arrayidx114.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.28
  %611 = load i32, i32* %arrayidx114.28, align 4
  %cmp115.28 = icmp eq i32 %611, 255
  br i1 %cmp115.28, label %if.then143.28, label %lor.lhs.false117.28

lor.lhs.false117.28:                              ; preds = %lor.lhs.false109.28
  %add121.28 = add i32 %sub78.28, 127
  %idxprom122.28 = sext i32 %add121.28 to i64
  %arrayidx123.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.28
  %612 = load i32, i32* %arrayidx123.28, align 4
  %cmp124.28 = icmp eq i32 %612, 255
  br i1 %cmp124.28, label %if.then143.28, label %lor.lhs.false126.28

lor.lhs.false126.28:                              ; preds = %lor.lhs.false117.28
  %613 = add nsw i64 %599, %indvars.iv.28
  %arrayidx131.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %613
  %614 = load i32, i32* %arrayidx131.28, align 4
  %cmp132.28 = icmp eq i32 %614, 255
  br i1 %cmp132.28, label %if.then143.28, label %lor.lhs.false134.28

lor.lhs.false134.28:                              ; preds = %lor.lhs.false126.28
  %add138.28 = add i32 %sub78.28, 129
  %idxprom139.28 = sext i32 %add138.28 to i64
  %arrayidx140.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.28
  %615 = load i32, i32* %arrayidx140.28, align 4
  %cmp141.28 = icmp eq i32 %615, 255
  br i1 %cmp141.28, label %if.then143.28, label %if.else146.28

if.else146.28:                                    ; preds = %lor.lhs.false134.28
  %arrayidx148.28 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %601
  store i8 0, i8* %arrayidx148.28, align 1
  br label %for.inc158.28

if.then143.28:                                    ; preds = %lor.lhs.false134.28, %lor.lhs.false126.28, %lor.lhs.false117.28, %lor.lhs.false109.28, %lor.lhs.false101.28, %lor.lhs.false92.28, %lor.lhs.false84.28, %if.then75.28
  %arrayidx145.28 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %601
  store i8 -1, i8* %arrayidx145.28, align 1
  br label %for.inc158.28

if.then67.28:                                     ; preds = %for.body53.28
  %arrayidx69.28 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %601
  store i8 0, i8* %arrayidx69.28, align 1
  br label %for.inc158.28

for.inc158.28:                                    ; preds = %if.then67.28, %if.then143.28, %if.else146.28, %if.else150.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %img_width
  br i1 %exitcond.28, label %for.inc161.28, label %for.body53.28, !llvm.loop !5

for.inc161.28:                                    ; preds = %for.inc158.28
  %indvars.iv.next21.28 = add nsw i64 %indvars.iv20, 29
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.29

for.body53.lr.ph.29:                              ; preds = %for.inc161.28
  %616 = trunc i64 %indvars.iv.next21.28 to i32
  %mul55.29 = shl nsw i32 %616, 7
  %cmp59.29 = icmp eq i64 %indvars.iv.next21.28, %11
  %617 = trunc i64 %indvars.iv.next21.28 to i32
  %sub76.29 = shl i32 %617, 7
  %mul86.29 = add i32 %sub76.29, -128
  %sub103.29 = add i32 %mul55.29, -1
  %add111.29 = or i32 %mul55.29, 1
  %mul128.29 = add i32 %sub76.29, 128
  %618 = sext i32 %mul55.29 to i64
  %619 = sext i32 %mul128.29 to i64
  %620 = sext i32 %mul86.29 to i64
  br label %for.body53.29

for.body53.29:                                    ; preds = %for.inc158.29, %for.body53.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body53.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc158.29 ]
  %621 = add nsw i64 %indvars.iv.29, %618
  %cmp62.29 = icmp eq i64 %indvars.iv.29, 0
  %or.cond1.29 = or i1 %cmp59.29, %cmp62.29
  %cmp65.29 = icmp eq i64 %indvars.iv.29, %10
  %or.cond2.29 = or i1 %cmp65.29, %or.cond1.29
  br i1 %or.cond2.29, label %if.then67.29, label %if.else70.29

if.else70.29:                                     ; preds = %for.body53.29
  %arrayidx72.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %621
  %622 = load i32, i32* %arrayidx72.29, align 4
  %cmp73.29 = icmp eq i32 %622, 75
  br i1 %cmp73.29, label %if.then75.29, label %if.else150.29

if.else150.29:                                    ; preds = %if.else70.29
  %conv153.29 = trunc i32 %622 to i8
  %arrayidx155.29 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %621
  store i8 %conv153.29, i8* %arrayidx155.29, align 1
  br label %for.inc158.29

if.then75.29:                                     ; preds = %if.else70.29
  %623 = trunc i64 %indvars.iv.29 to i32
  %sub78.29 = add i32 %623, %sub76.29
  %add79.29 = add i32 %sub78.29, -129
  %idxprom80.29 = sext i32 %add79.29 to i64
  %arrayidx81.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.29
  %624 = load i32, i32* %arrayidx81.29, align 4
  %cmp82.29 = icmp eq i32 %624, 255
  br i1 %cmp82.29, label %if.then143.29, label %lor.lhs.false84.29

lor.lhs.false84.29:                               ; preds = %if.then75.29
  %625 = add nsw i64 %620, %indvars.iv.29
  %arrayidx89.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %625
  %626 = load i32, i32* %arrayidx89.29, align 4
  %cmp90.29 = icmp eq i32 %626, 255
  br i1 %cmp90.29, label %if.then143.29, label %lor.lhs.false92.29

lor.lhs.false92.29:                               ; preds = %lor.lhs.false84.29
  %add96.29 = add i32 %sub78.29, -127
  %idxprom97.29 = sext i32 %add96.29 to i64
  %arrayidx98.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.29
  %627 = load i32, i32* %arrayidx98.29, align 4
  %cmp99.29 = icmp eq i32 %627, 255
  br i1 %cmp99.29, label %if.then143.29, label %lor.lhs.false101.29

lor.lhs.false101.29:                              ; preds = %lor.lhs.false92.29
  %628 = trunc i64 %indvars.iv.29 to i32
  %add104.29 = add i32 %sub103.29, %628
  %idxprom105.29 = sext i32 %add104.29 to i64
  %arrayidx106.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.29
  %629 = load i32, i32* %arrayidx106.29, align 4
  %cmp107.29 = icmp eq i32 %629, 255
  br i1 %cmp107.29, label %if.then143.29, label %lor.lhs.false109.29

lor.lhs.false109.29:                              ; preds = %lor.lhs.false101.29
  %630 = trunc i64 %indvars.iv.29 to i32
  %add112.29 = add i32 %add111.29, %630
  %idxprom113.29 = sext i32 %add112.29 to i64
  %arrayidx114.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.29
  %631 = load i32, i32* %arrayidx114.29, align 4
  %cmp115.29 = icmp eq i32 %631, 255
  br i1 %cmp115.29, label %if.then143.29, label %lor.lhs.false117.29

lor.lhs.false117.29:                              ; preds = %lor.lhs.false109.29
  %add121.29 = add i32 %sub78.29, 127
  %idxprom122.29 = sext i32 %add121.29 to i64
  %arrayidx123.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.29
  %632 = load i32, i32* %arrayidx123.29, align 4
  %cmp124.29 = icmp eq i32 %632, 255
  br i1 %cmp124.29, label %if.then143.29, label %lor.lhs.false126.29

lor.lhs.false126.29:                              ; preds = %lor.lhs.false117.29
  %633 = add nsw i64 %619, %indvars.iv.29
  %arrayidx131.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %633
  %634 = load i32, i32* %arrayidx131.29, align 4
  %cmp132.29 = icmp eq i32 %634, 255
  br i1 %cmp132.29, label %if.then143.29, label %lor.lhs.false134.29

lor.lhs.false134.29:                              ; preds = %lor.lhs.false126.29
  %add138.29 = add i32 %sub78.29, 129
  %idxprom139.29 = sext i32 %add138.29 to i64
  %arrayidx140.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.29
  %635 = load i32, i32* %arrayidx140.29, align 4
  %cmp141.29 = icmp eq i32 %635, 255
  br i1 %cmp141.29, label %if.then143.29, label %if.else146.29

if.else146.29:                                    ; preds = %lor.lhs.false134.29
  %arrayidx148.29 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %621
  store i8 0, i8* %arrayidx148.29, align 1
  br label %for.inc158.29

if.then143.29:                                    ; preds = %lor.lhs.false134.29, %lor.lhs.false126.29, %lor.lhs.false117.29, %lor.lhs.false109.29, %lor.lhs.false101.29, %lor.lhs.false92.29, %lor.lhs.false84.29, %if.then75.29
  %arrayidx145.29 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %621
  store i8 -1, i8* %arrayidx145.29, align 1
  br label %for.inc158.29

if.then67.29:                                     ; preds = %for.body53.29
  %arrayidx69.29 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %621
  store i8 0, i8* %arrayidx69.29, align 1
  br label %for.inc158.29

for.inc158.29:                                    ; preds = %if.then67.29, %if.then143.29, %if.else146.29, %if.else150.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %img_width
  br i1 %exitcond.29, label %for.inc161.29, label %for.body53.29, !llvm.loop !5

for.inc161.29:                                    ; preds = %for.inc158.29
  %indvars.iv.next21.29 = add nsw i64 %indvars.iv20, 30
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.30

for.body53.lr.ph.30:                              ; preds = %for.inc161.29
  %636 = trunc i64 %indvars.iv.next21.29 to i32
  %mul55.30 = shl nsw i32 %636, 7
  %cmp59.30 = icmp eq i64 %indvars.iv.next21.29, %11
  %637 = trunc i64 %indvars.iv.next21.29 to i32
  %sub76.30 = shl i32 %637, 7
  %mul86.30 = add i32 %sub76.30, -128
  %sub103.30 = add i32 %mul55.30, -1
  %add111.30 = or i32 %mul55.30, 1
  %mul128.30 = add i32 %sub76.30, 128
  %638 = sext i32 %mul55.30 to i64
  %639 = sext i32 %mul128.30 to i64
  %640 = sext i32 %mul86.30 to i64
  br label %for.body53.30

for.body53.30:                                    ; preds = %for.inc158.30, %for.body53.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body53.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc158.30 ]
  %641 = add nsw i64 %indvars.iv.30, %638
  %cmp62.30 = icmp eq i64 %indvars.iv.30, 0
  %or.cond1.30 = or i1 %cmp59.30, %cmp62.30
  %cmp65.30 = icmp eq i64 %indvars.iv.30, %10
  %or.cond2.30 = or i1 %cmp65.30, %or.cond1.30
  br i1 %or.cond2.30, label %if.then67.30, label %if.else70.30

if.else70.30:                                     ; preds = %for.body53.30
  %arrayidx72.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %641
  %642 = load i32, i32* %arrayidx72.30, align 4
  %cmp73.30 = icmp eq i32 %642, 75
  br i1 %cmp73.30, label %if.then75.30, label %if.else150.30

if.else150.30:                                    ; preds = %if.else70.30
  %conv153.30 = trunc i32 %642 to i8
  %arrayidx155.30 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %641
  store i8 %conv153.30, i8* %arrayidx155.30, align 1
  br label %for.inc158.30

if.then75.30:                                     ; preds = %if.else70.30
  %643 = trunc i64 %indvars.iv.30 to i32
  %sub78.30 = add i32 %643, %sub76.30
  %add79.30 = add i32 %sub78.30, -129
  %idxprom80.30 = sext i32 %add79.30 to i64
  %arrayidx81.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.30
  %644 = load i32, i32* %arrayidx81.30, align 4
  %cmp82.30 = icmp eq i32 %644, 255
  br i1 %cmp82.30, label %if.then143.30, label %lor.lhs.false84.30

lor.lhs.false84.30:                               ; preds = %if.then75.30
  %645 = add nsw i64 %640, %indvars.iv.30
  %arrayidx89.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %645
  %646 = load i32, i32* %arrayidx89.30, align 4
  %cmp90.30 = icmp eq i32 %646, 255
  br i1 %cmp90.30, label %if.then143.30, label %lor.lhs.false92.30

lor.lhs.false92.30:                               ; preds = %lor.lhs.false84.30
  %add96.30 = add i32 %sub78.30, -127
  %idxprom97.30 = sext i32 %add96.30 to i64
  %arrayidx98.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.30
  %647 = load i32, i32* %arrayidx98.30, align 4
  %cmp99.30 = icmp eq i32 %647, 255
  br i1 %cmp99.30, label %if.then143.30, label %lor.lhs.false101.30

lor.lhs.false101.30:                              ; preds = %lor.lhs.false92.30
  %648 = trunc i64 %indvars.iv.30 to i32
  %add104.30 = add i32 %sub103.30, %648
  %idxprom105.30 = sext i32 %add104.30 to i64
  %arrayidx106.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.30
  %649 = load i32, i32* %arrayidx106.30, align 4
  %cmp107.30 = icmp eq i32 %649, 255
  br i1 %cmp107.30, label %if.then143.30, label %lor.lhs.false109.30

lor.lhs.false109.30:                              ; preds = %lor.lhs.false101.30
  %650 = trunc i64 %indvars.iv.30 to i32
  %add112.30 = add i32 %add111.30, %650
  %idxprom113.30 = sext i32 %add112.30 to i64
  %arrayidx114.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.30
  %651 = load i32, i32* %arrayidx114.30, align 4
  %cmp115.30 = icmp eq i32 %651, 255
  br i1 %cmp115.30, label %if.then143.30, label %lor.lhs.false117.30

lor.lhs.false117.30:                              ; preds = %lor.lhs.false109.30
  %add121.30 = add i32 %sub78.30, 127
  %idxprom122.30 = sext i32 %add121.30 to i64
  %arrayidx123.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.30
  %652 = load i32, i32* %arrayidx123.30, align 4
  %cmp124.30 = icmp eq i32 %652, 255
  br i1 %cmp124.30, label %if.then143.30, label %lor.lhs.false126.30

lor.lhs.false126.30:                              ; preds = %lor.lhs.false117.30
  %653 = add nsw i64 %639, %indvars.iv.30
  %arrayidx131.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %653
  %654 = load i32, i32* %arrayidx131.30, align 4
  %cmp132.30 = icmp eq i32 %654, 255
  br i1 %cmp132.30, label %if.then143.30, label %lor.lhs.false134.30

lor.lhs.false134.30:                              ; preds = %lor.lhs.false126.30
  %add138.30 = add i32 %sub78.30, 129
  %idxprom139.30 = sext i32 %add138.30 to i64
  %arrayidx140.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.30
  %655 = load i32, i32* %arrayidx140.30, align 4
  %cmp141.30 = icmp eq i32 %655, 255
  br i1 %cmp141.30, label %if.then143.30, label %if.else146.30

if.else146.30:                                    ; preds = %lor.lhs.false134.30
  %arrayidx148.30 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %641
  store i8 0, i8* %arrayidx148.30, align 1
  br label %for.inc158.30

if.then143.30:                                    ; preds = %lor.lhs.false134.30, %lor.lhs.false126.30, %lor.lhs.false117.30, %lor.lhs.false109.30, %lor.lhs.false101.30, %lor.lhs.false92.30, %lor.lhs.false84.30, %if.then75.30
  %arrayidx145.30 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %641
  store i8 -1, i8* %arrayidx145.30, align 1
  br label %for.inc158.30

if.then67.30:                                     ; preds = %for.body53.30
  %arrayidx69.30 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %641
  store i8 0, i8* %arrayidx69.30, align 1
  br label %for.inc158.30

for.inc158.30:                                    ; preds = %if.then67.30, %if.then143.30, %if.else146.30, %if.else150.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %img_width
  br i1 %exitcond.30, label %for.inc161.30, label %for.body53.30, !llvm.loop !5

for.inc161.30:                                    ; preds = %for.inc158.30
  %indvars.iv.next21.30 = add nsw i64 %indvars.iv20, 31
  br i1 %cmp513, label %for.inc161.31, label %for.body53.lr.ph.31

for.body53.lr.ph.31:                              ; preds = %for.inc161.30
  %656 = trunc i64 %indvars.iv.next21.30 to i32
  %mul55.31 = shl nsw i32 %656, 7
  %cmp59.31 = icmp eq i64 %indvars.iv.next21.30, %11
  %657 = trunc i64 %indvars.iv.next21.30 to i32
  %sub76.31 = shl i32 %657, 7
  %mul86.31 = add i32 %sub76.31, -128
  %sub103.31 = add i32 %mul55.31, -1
  %add111.31 = or i32 %mul55.31, 1
  %mul128.31 = add i32 %sub76.31, 128
  %658 = sext i32 %mul55.31 to i64
  %659 = sext i32 %mul128.31 to i64
  %660 = sext i32 %mul86.31 to i64
  br label %for.body53.31

for.body53.31:                                    ; preds = %for.inc158.31, %for.body53.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body53.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc158.31 ]
  %661 = add nsw i64 %indvars.iv.31, %658
  %cmp62.31 = icmp eq i64 %indvars.iv.31, 0
  %or.cond1.31 = or i1 %cmp59.31, %cmp62.31
  %cmp65.31 = icmp eq i64 %indvars.iv.31, %10
  %or.cond2.31 = or i1 %cmp65.31, %or.cond1.31
  br i1 %or.cond2.31, label %if.then67.31, label %if.else70.31

if.else70.31:                                     ; preds = %for.body53.31
  %arrayidx72.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %661
  %662 = load i32, i32* %arrayidx72.31, align 4
  %cmp73.31 = icmp eq i32 %662, 75
  br i1 %cmp73.31, label %if.then75.31, label %if.else150.31

if.else150.31:                                    ; preds = %if.else70.31
  %conv153.31 = trunc i32 %662 to i8
  %arrayidx155.31 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %661
  store i8 %conv153.31, i8* %arrayidx155.31, align 1
  br label %for.inc158.31

if.then75.31:                                     ; preds = %if.else70.31
  %663 = trunc i64 %indvars.iv.31 to i32
  %sub78.31 = add i32 %663, %sub76.31
  %add79.31 = add i32 %sub78.31, -129
  %idxprom80.31 = sext i32 %add79.31 to i64
  %arrayidx81.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom80.31
  %664 = load i32, i32* %arrayidx81.31, align 4
  %cmp82.31 = icmp eq i32 %664, 255
  br i1 %cmp82.31, label %if.then143.31, label %lor.lhs.false84.31

lor.lhs.false84.31:                               ; preds = %if.then75.31
  %665 = add nsw i64 %660, %indvars.iv.31
  %arrayidx89.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %665
  %666 = load i32, i32* %arrayidx89.31, align 4
  %cmp90.31 = icmp eq i32 %666, 255
  br i1 %cmp90.31, label %if.then143.31, label %lor.lhs.false92.31

lor.lhs.false92.31:                               ; preds = %lor.lhs.false84.31
  %add96.31 = add i32 %sub78.31, -127
  %idxprom97.31 = sext i32 %add96.31 to i64
  %arrayidx98.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom97.31
  %667 = load i32, i32* %arrayidx98.31, align 4
  %cmp99.31 = icmp eq i32 %667, 255
  br i1 %cmp99.31, label %if.then143.31, label %lor.lhs.false101.31

lor.lhs.false101.31:                              ; preds = %lor.lhs.false92.31
  %668 = trunc i64 %indvars.iv.31 to i32
  %add104.31 = add i32 %sub103.31, %668
  %idxprom105.31 = sext i32 %add104.31 to i64
  %arrayidx106.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom105.31
  %669 = load i32, i32* %arrayidx106.31, align 4
  %cmp107.31 = icmp eq i32 %669, 255
  br i1 %cmp107.31, label %if.then143.31, label %lor.lhs.false109.31

lor.lhs.false109.31:                              ; preds = %lor.lhs.false101.31
  %670 = trunc i64 %indvars.iv.31 to i32
  %add112.31 = add i32 %add111.31, %670
  %idxprom113.31 = sext i32 %add112.31 to i64
  %arrayidx114.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom113.31
  %671 = load i32, i32* %arrayidx114.31, align 4
  %cmp115.31 = icmp eq i32 %671, 255
  br i1 %cmp115.31, label %if.then143.31, label %lor.lhs.false117.31

lor.lhs.false117.31:                              ; preds = %lor.lhs.false109.31
  %add121.31 = add i32 %sub78.31, 127
  %idxprom122.31 = sext i32 %add121.31 to i64
  %arrayidx123.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom122.31
  %672 = load i32, i32* %arrayidx123.31, align 4
  %cmp124.31 = icmp eq i32 %672, 255
  br i1 %cmp124.31, label %if.then143.31, label %lor.lhs.false126.31

lor.lhs.false126.31:                              ; preds = %lor.lhs.false117.31
  %673 = add nsw i64 %659, %indvars.iv.31
  %arrayidx131.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %673
  %674 = load i32, i32* %arrayidx131.31, align 4
  %cmp132.31 = icmp eq i32 %674, 255
  br i1 %cmp132.31, label %if.then143.31, label %lor.lhs.false134.31

lor.lhs.false134.31:                              ; preds = %lor.lhs.false126.31
  %add138.31 = add i32 %sub78.31, 129
  %idxprom139.31 = sext i32 %add138.31 to i64
  %arrayidx140.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %idxprom139.31
  %675 = load i32, i32* %arrayidx140.31, align 4
  %cmp141.31 = icmp eq i32 %675, 255
  br i1 %cmp141.31, label %if.then143.31, label %if.else146.31

if.else146.31:                                    ; preds = %lor.lhs.false134.31
  %arrayidx148.31 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %661
  store i8 0, i8* %arrayidx148.31, align 1
  br label %for.inc158.31

if.then143.31:                                    ; preds = %lor.lhs.false134.31, %lor.lhs.false126.31, %lor.lhs.false117.31, %lor.lhs.false109.31, %lor.lhs.false101.31, %lor.lhs.false92.31, %lor.lhs.false84.31, %if.then75.31
  %arrayidx145.31 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %661
  store i8 -1, i8* %arrayidx145.31, align 1
  br label %for.inc158.31

if.then67.31:                                     ; preds = %for.body53.31
  %arrayidx69.31 = getelementptr inbounds i8, i8* inttoptr (i64 587268128 to i8*), i64 %661
  store i8 0, i8* %arrayidx69.31, align 1
  br label %for.inc158.31

for.inc158.31:                                    ; preds = %if.then67.31, %if.then143.31, %if.else146.31, %if.else150.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %img_width
  br i1 %exitcond.31, label %for.inc161.31.loopexit, label %for.body53.31, !llvm.loop !5

for.inc161.31.loopexit:                           ; preds = %for.inc158.31
  br label %for.inc161.31

for.inc161.31:                                    ; preds = %for.inc161.31.loopexit, %for.cond50.preheader, %for.inc161, %for.inc161.1, %for.inc161.2, %for.inc161.3, %for.inc161.4, %for.inc161.5, %for.inc161.6, %for.inc161.7, %for.inc161.8, %for.inc161.9, %for.inc161.10, %for.inc161.11, %for.inc161.12, %for.inc161.13, %for.inc161.14, %for.inc161.15, %for.inc161.16, %for.inc161.17, %for.inc161.18, %for.inc161.19, %for.inc161.20, %for.inc161.21, %for.inc161.22, %for.inc161.23, %for.inc161.24, %for.inc161.25, %for.inc161.26, %for.inc161.27, %for.inc161.28, %for.inc161.29, %for.inc161.30
  %indvars.iv.next21.31 = add nsw i64 %indvars.iv20, 32
  %lftr.wideiv22.31 = trunc i64 %indvars.iv.next21.31 to i32
  %exitcond23.31 = icmp eq i32 %lftr.wideiv22.31, %img_height
  br i1 %exitcond23.31, label %for.end163.loopexit, label %for.cond50.preheader, !llvm.loop !7

for.body15.lr.ph.1:                               ; preds = %for.inc41
  %indvars.iv.next30 = add nuw nsw i64 %indvars.iv29, 1
  %676 = trunc i64 %indvars.iv.next30 to i32
  %mul16.1 = shl i32 %676, 7
  %677 = sext i32 %mul16.1 to i64
  br label %for.body15.1

for.body15.1:                                     ; preds = %for.inc38.1, %for.body15.lr.ph.1
  %indvars.iv24.1 = phi i64 [ 0, %for.body15.lr.ph.1 ], [ %indvars.iv.next25.1, %for.inc38.1 ]
  %678 = add nsw i64 %indvars.iv24.1, %677
  %arrayidx18.1 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %678
  %679 = load i32, i32* %arrayidx18.1, align 4
  %conv19.1 = uitofp i32 %679 to float
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
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.2

for.body15.lr.ph.2:                               ; preds = %for.inc41.1
  %indvars.iv.next30.1 = add nsw i64 %indvars.iv29, 2
  %680 = trunc i64 %indvars.iv.next30.1 to i32
  %mul16.2 = shl i32 %680, 7
  %681 = sext i32 %mul16.2 to i64
  br label %for.body15.2

for.body15.2:                                     ; preds = %for.inc38.2, %for.body15.lr.ph.2
  %indvars.iv24.2 = phi i64 [ 0, %for.body15.lr.ph.2 ], [ %indvars.iv.next25.2, %for.inc38.2 ]
  %682 = add nsw i64 %indvars.iv24.2, %681
  %arrayidx18.2 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %682
  %683 = load i32, i32* %arrayidx18.2, align 4
  %conv19.2 = uitofp i32 %683 to float
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
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.3

for.body15.lr.ph.3:                               ; preds = %for.inc41.2
  %indvars.iv.next30.2 = add nsw i64 %indvars.iv29, 3
  %684 = trunc i64 %indvars.iv.next30.2 to i32
  %mul16.3 = shl i32 %684, 7
  %685 = sext i32 %mul16.3 to i64
  br label %for.body15.3

for.body15.3:                                     ; preds = %for.inc38.3, %for.body15.lr.ph.3
  %indvars.iv24.3 = phi i64 [ 0, %for.body15.lr.ph.3 ], [ %indvars.iv.next25.3, %for.inc38.3 ]
  %686 = add nsw i64 %indvars.iv24.3, %685
  %arrayidx18.3 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %686
  %687 = load i32, i32* %arrayidx18.3, align 4
  %conv19.3 = uitofp i32 %687 to float
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
  br i1 %exitcond28.3, label %for.inc41.3, label %for.body15.3, !llvm.loop !3

for.inc41.3:                                      ; preds = %for.inc38.3
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.4

for.body15.lr.ph.4:                               ; preds = %for.inc41.3
  %indvars.iv.next30.3 = add nsw i64 %indvars.iv29, 4
  %688 = trunc i64 %indvars.iv.next30.3 to i32
  %mul16.4 = shl i32 %688, 7
  %689 = sext i32 %mul16.4 to i64
  br label %for.body15.4

for.body15.4:                                     ; preds = %for.inc38.4, %for.body15.lr.ph.4
  %indvars.iv24.4 = phi i64 [ 0, %for.body15.lr.ph.4 ], [ %indvars.iv.next25.4, %for.inc38.4 ]
  %690 = add nsw i64 %indvars.iv24.4, %689
  %arrayidx18.4 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %690
  %691 = load i32, i32* %arrayidx18.4, align 4
  %conv19.4 = uitofp i32 %691 to float
  %cmp20.4 = fcmp olt float %conv19.4, %mul6
  br i1 %cmp20.4, label %if.then22.4, label %if.else.4

if.else.4:                                        ; preds = %for.body15.4
  %cmp28.4 = fcmp ult float %conv19.4, %img_max.0.lcssa
  br i1 %cmp28.4, label %if.else33.4, label %if.then30.4

if.then30.4:                                      ; preds = %if.else.4
  store i32 255, i32* %arrayidx18.4, align 4
  br label %for.inc38.4

if.else33.4:                                      ; preds = %if.else.4
  store i32 75, i32* %arrayidx18.4, align 4
  br label %for.inc38.4

if.then22.4:                                      ; preds = %for.body15.4
  store i32 0, i32* %arrayidx18.4, align 4
  br label %for.inc38.4

for.inc38.4:                                      ; preds = %if.then22.4, %if.else33.4, %if.then30.4
  %indvars.iv.next25.4 = add nuw nsw i64 %indvars.iv24.4, 1
  %lftr.wideiv27.4 = trunc i64 %indvars.iv.next25.4 to i32
  %exitcond28.4 = icmp eq i32 %lftr.wideiv27.4, %img_width
  br i1 %exitcond28.4, label %for.inc41.4, label %for.body15.4, !llvm.loop !3

for.inc41.4:                                      ; preds = %for.inc38.4
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.5

for.body15.lr.ph.5:                               ; preds = %for.inc41.4
  %indvars.iv.next30.4 = add nsw i64 %indvars.iv29, 5
  %692 = trunc i64 %indvars.iv.next30.4 to i32
  %mul16.5 = shl i32 %692, 7
  %693 = sext i32 %mul16.5 to i64
  br label %for.body15.5

for.body15.5:                                     ; preds = %for.inc38.5, %for.body15.lr.ph.5
  %indvars.iv24.5 = phi i64 [ 0, %for.body15.lr.ph.5 ], [ %indvars.iv.next25.5, %for.inc38.5 ]
  %694 = add nsw i64 %indvars.iv24.5, %693
  %arrayidx18.5 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %694
  %695 = load i32, i32* %arrayidx18.5, align 4
  %conv19.5 = uitofp i32 %695 to float
  %cmp20.5 = fcmp olt float %conv19.5, %mul6
  br i1 %cmp20.5, label %if.then22.5, label %if.else.5

if.else.5:                                        ; preds = %for.body15.5
  %cmp28.5 = fcmp ult float %conv19.5, %img_max.0.lcssa
  br i1 %cmp28.5, label %if.else33.5, label %if.then30.5

if.then30.5:                                      ; preds = %if.else.5
  store i32 255, i32* %arrayidx18.5, align 4
  br label %for.inc38.5

if.else33.5:                                      ; preds = %if.else.5
  store i32 75, i32* %arrayidx18.5, align 4
  br label %for.inc38.5

if.then22.5:                                      ; preds = %for.body15.5
  store i32 0, i32* %arrayidx18.5, align 4
  br label %for.inc38.5

for.inc38.5:                                      ; preds = %if.then22.5, %if.else33.5, %if.then30.5
  %indvars.iv.next25.5 = add nuw nsw i64 %indvars.iv24.5, 1
  %lftr.wideiv27.5 = trunc i64 %indvars.iv.next25.5 to i32
  %exitcond28.5 = icmp eq i32 %lftr.wideiv27.5, %img_width
  br i1 %exitcond28.5, label %for.inc41.5, label %for.body15.5, !llvm.loop !3

for.inc41.5:                                      ; preds = %for.inc38.5
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.6

for.body15.lr.ph.6:                               ; preds = %for.inc41.5
  %indvars.iv.next30.5 = add nsw i64 %indvars.iv29, 6
  %696 = trunc i64 %indvars.iv.next30.5 to i32
  %mul16.6 = shl i32 %696, 7
  %697 = sext i32 %mul16.6 to i64
  br label %for.body15.6

for.body15.6:                                     ; preds = %for.inc38.6, %for.body15.lr.ph.6
  %indvars.iv24.6 = phi i64 [ 0, %for.body15.lr.ph.6 ], [ %indvars.iv.next25.6, %for.inc38.6 ]
  %698 = add nsw i64 %indvars.iv24.6, %697
  %arrayidx18.6 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %698
  %699 = load i32, i32* %arrayidx18.6, align 4
  %conv19.6 = uitofp i32 %699 to float
  %cmp20.6 = fcmp olt float %conv19.6, %mul6
  br i1 %cmp20.6, label %if.then22.6, label %if.else.6

if.else.6:                                        ; preds = %for.body15.6
  %cmp28.6 = fcmp ult float %conv19.6, %img_max.0.lcssa
  br i1 %cmp28.6, label %if.else33.6, label %if.then30.6

if.then30.6:                                      ; preds = %if.else.6
  store i32 255, i32* %arrayidx18.6, align 4
  br label %for.inc38.6

if.else33.6:                                      ; preds = %if.else.6
  store i32 75, i32* %arrayidx18.6, align 4
  br label %for.inc38.6

if.then22.6:                                      ; preds = %for.body15.6
  store i32 0, i32* %arrayidx18.6, align 4
  br label %for.inc38.6

for.inc38.6:                                      ; preds = %if.then22.6, %if.else33.6, %if.then30.6
  %indvars.iv.next25.6 = add nuw nsw i64 %indvars.iv24.6, 1
  %lftr.wideiv27.6 = trunc i64 %indvars.iv.next25.6 to i32
  %exitcond28.6 = icmp eq i32 %lftr.wideiv27.6, %img_width
  br i1 %exitcond28.6, label %for.inc41.6, label %for.body15.6, !llvm.loop !3

for.inc41.6:                                      ; preds = %for.inc38.6
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.7

for.body15.lr.ph.7:                               ; preds = %for.inc41.6
  %indvars.iv.next30.6 = add nsw i64 %indvars.iv29, 7
  %700 = trunc i64 %indvars.iv.next30.6 to i32
  %mul16.7 = shl i32 %700, 7
  %701 = sext i32 %mul16.7 to i64
  br label %for.body15.7

for.body15.7:                                     ; preds = %for.inc38.7, %for.body15.lr.ph.7
  %indvars.iv24.7 = phi i64 [ 0, %for.body15.lr.ph.7 ], [ %indvars.iv.next25.7, %for.inc38.7 ]
  %702 = add nsw i64 %indvars.iv24.7, %701
  %arrayidx18.7 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %702
  %703 = load i32, i32* %arrayidx18.7, align 4
  %conv19.7 = uitofp i32 %703 to float
  %cmp20.7 = fcmp olt float %conv19.7, %mul6
  br i1 %cmp20.7, label %if.then22.7, label %if.else.7

if.else.7:                                        ; preds = %for.body15.7
  %cmp28.7 = fcmp ult float %conv19.7, %img_max.0.lcssa
  br i1 %cmp28.7, label %if.else33.7, label %if.then30.7

if.then30.7:                                      ; preds = %if.else.7
  store i32 255, i32* %arrayidx18.7, align 4
  br label %for.inc38.7

if.else33.7:                                      ; preds = %if.else.7
  store i32 75, i32* %arrayidx18.7, align 4
  br label %for.inc38.7

if.then22.7:                                      ; preds = %for.body15.7
  store i32 0, i32* %arrayidx18.7, align 4
  br label %for.inc38.7

for.inc38.7:                                      ; preds = %if.then22.7, %if.else33.7, %if.then30.7
  %indvars.iv.next25.7 = add nuw nsw i64 %indvars.iv24.7, 1
  %lftr.wideiv27.7 = trunc i64 %indvars.iv.next25.7 to i32
  %exitcond28.7 = icmp eq i32 %lftr.wideiv27.7, %img_width
  br i1 %exitcond28.7, label %for.inc41.7, label %for.body15.7, !llvm.loop !3

for.inc41.7:                                      ; preds = %for.inc38.7
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.8

for.body15.lr.ph.8:                               ; preds = %for.inc41.7
  %indvars.iv.next30.7 = add nsw i64 %indvars.iv29, 8
  %704 = trunc i64 %indvars.iv.next30.7 to i32
  %mul16.8 = shl i32 %704, 7
  %705 = sext i32 %mul16.8 to i64
  br label %for.body15.8

for.body15.8:                                     ; preds = %for.inc38.8, %for.body15.lr.ph.8
  %indvars.iv24.8 = phi i64 [ 0, %for.body15.lr.ph.8 ], [ %indvars.iv.next25.8, %for.inc38.8 ]
  %706 = add nsw i64 %indvars.iv24.8, %705
  %arrayidx18.8 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %706
  %707 = load i32, i32* %arrayidx18.8, align 4
  %conv19.8 = uitofp i32 %707 to float
  %cmp20.8 = fcmp olt float %conv19.8, %mul6
  br i1 %cmp20.8, label %if.then22.8, label %if.else.8

if.else.8:                                        ; preds = %for.body15.8
  %cmp28.8 = fcmp ult float %conv19.8, %img_max.0.lcssa
  br i1 %cmp28.8, label %if.else33.8, label %if.then30.8

if.then30.8:                                      ; preds = %if.else.8
  store i32 255, i32* %arrayidx18.8, align 4
  br label %for.inc38.8

if.else33.8:                                      ; preds = %if.else.8
  store i32 75, i32* %arrayidx18.8, align 4
  br label %for.inc38.8

if.then22.8:                                      ; preds = %for.body15.8
  store i32 0, i32* %arrayidx18.8, align 4
  br label %for.inc38.8

for.inc38.8:                                      ; preds = %if.then22.8, %if.else33.8, %if.then30.8
  %indvars.iv.next25.8 = add nuw nsw i64 %indvars.iv24.8, 1
  %lftr.wideiv27.8 = trunc i64 %indvars.iv.next25.8 to i32
  %exitcond28.8 = icmp eq i32 %lftr.wideiv27.8, %img_width
  br i1 %exitcond28.8, label %for.inc41.8, label %for.body15.8, !llvm.loop !3

for.inc41.8:                                      ; preds = %for.inc38.8
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.9

for.body15.lr.ph.9:                               ; preds = %for.inc41.8
  %indvars.iv.next30.8 = add nsw i64 %indvars.iv29, 9
  %708 = trunc i64 %indvars.iv.next30.8 to i32
  %mul16.9 = shl i32 %708, 7
  %709 = sext i32 %mul16.9 to i64
  br label %for.body15.9

for.body15.9:                                     ; preds = %for.inc38.9, %for.body15.lr.ph.9
  %indvars.iv24.9 = phi i64 [ 0, %for.body15.lr.ph.9 ], [ %indvars.iv.next25.9, %for.inc38.9 ]
  %710 = add nsw i64 %indvars.iv24.9, %709
  %arrayidx18.9 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %710
  %711 = load i32, i32* %arrayidx18.9, align 4
  %conv19.9 = uitofp i32 %711 to float
  %cmp20.9 = fcmp olt float %conv19.9, %mul6
  br i1 %cmp20.9, label %if.then22.9, label %if.else.9

if.else.9:                                        ; preds = %for.body15.9
  %cmp28.9 = fcmp ult float %conv19.9, %img_max.0.lcssa
  br i1 %cmp28.9, label %if.else33.9, label %if.then30.9

if.then30.9:                                      ; preds = %if.else.9
  store i32 255, i32* %arrayidx18.9, align 4
  br label %for.inc38.9

if.else33.9:                                      ; preds = %if.else.9
  store i32 75, i32* %arrayidx18.9, align 4
  br label %for.inc38.9

if.then22.9:                                      ; preds = %for.body15.9
  store i32 0, i32* %arrayidx18.9, align 4
  br label %for.inc38.9

for.inc38.9:                                      ; preds = %if.then22.9, %if.else33.9, %if.then30.9
  %indvars.iv.next25.9 = add nuw nsw i64 %indvars.iv24.9, 1
  %lftr.wideiv27.9 = trunc i64 %indvars.iv.next25.9 to i32
  %exitcond28.9 = icmp eq i32 %lftr.wideiv27.9, %img_width
  br i1 %exitcond28.9, label %for.inc41.9, label %for.body15.9, !llvm.loop !3

for.inc41.9:                                      ; preds = %for.inc38.9
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.10

for.body15.lr.ph.10:                              ; preds = %for.inc41.9
  %indvars.iv.next30.9 = add nsw i64 %indvars.iv29, 10
  %712 = trunc i64 %indvars.iv.next30.9 to i32
  %mul16.10 = shl i32 %712, 7
  %713 = sext i32 %mul16.10 to i64
  br label %for.body15.10

for.body15.10:                                    ; preds = %for.inc38.10, %for.body15.lr.ph.10
  %indvars.iv24.10 = phi i64 [ 0, %for.body15.lr.ph.10 ], [ %indvars.iv.next25.10, %for.inc38.10 ]
  %714 = add nsw i64 %indvars.iv24.10, %713
  %arrayidx18.10 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %714
  %715 = load i32, i32* %arrayidx18.10, align 4
  %conv19.10 = uitofp i32 %715 to float
  %cmp20.10 = fcmp olt float %conv19.10, %mul6
  br i1 %cmp20.10, label %if.then22.10, label %if.else.10

if.else.10:                                       ; preds = %for.body15.10
  %cmp28.10 = fcmp ult float %conv19.10, %img_max.0.lcssa
  br i1 %cmp28.10, label %if.else33.10, label %if.then30.10

if.then30.10:                                     ; preds = %if.else.10
  store i32 255, i32* %arrayidx18.10, align 4
  br label %for.inc38.10

if.else33.10:                                     ; preds = %if.else.10
  store i32 75, i32* %arrayidx18.10, align 4
  br label %for.inc38.10

if.then22.10:                                     ; preds = %for.body15.10
  store i32 0, i32* %arrayidx18.10, align 4
  br label %for.inc38.10

for.inc38.10:                                     ; preds = %if.then22.10, %if.else33.10, %if.then30.10
  %indvars.iv.next25.10 = add nuw nsw i64 %indvars.iv24.10, 1
  %lftr.wideiv27.10 = trunc i64 %indvars.iv.next25.10 to i32
  %exitcond28.10 = icmp eq i32 %lftr.wideiv27.10, %img_width
  br i1 %exitcond28.10, label %for.inc41.10, label %for.body15.10, !llvm.loop !3

for.inc41.10:                                     ; preds = %for.inc38.10
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.11

for.body15.lr.ph.11:                              ; preds = %for.inc41.10
  %indvars.iv.next30.10 = add nsw i64 %indvars.iv29, 11
  %716 = trunc i64 %indvars.iv.next30.10 to i32
  %mul16.11 = shl i32 %716, 7
  %717 = sext i32 %mul16.11 to i64
  br label %for.body15.11

for.body15.11:                                    ; preds = %for.inc38.11, %for.body15.lr.ph.11
  %indvars.iv24.11 = phi i64 [ 0, %for.body15.lr.ph.11 ], [ %indvars.iv.next25.11, %for.inc38.11 ]
  %718 = add nsw i64 %indvars.iv24.11, %717
  %arrayidx18.11 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %718
  %719 = load i32, i32* %arrayidx18.11, align 4
  %conv19.11 = uitofp i32 %719 to float
  %cmp20.11 = fcmp olt float %conv19.11, %mul6
  br i1 %cmp20.11, label %if.then22.11, label %if.else.11

if.else.11:                                       ; preds = %for.body15.11
  %cmp28.11 = fcmp ult float %conv19.11, %img_max.0.lcssa
  br i1 %cmp28.11, label %if.else33.11, label %if.then30.11

if.then30.11:                                     ; preds = %if.else.11
  store i32 255, i32* %arrayidx18.11, align 4
  br label %for.inc38.11

if.else33.11:                                     ; preds = %if.else.11
  store i32 75, i32* %arrayidx18.11, align 4
  br label %for.inc38.11

if.then22.11:                                     ; preds = %for.body15.11
  store i32 0, i32* %arrayidx18.11, align 4
  br label %for.inc38.11

for.inc38.11:                                     ; preds = %if.then22.11, %if.else33.11, %if.then30.11
  %indvars.iv.next25.11 = add nuw nsw i64 %indvars.iv24.11, 1
  %lftr.wideiv27.11 = trunc i64 %indvars.iv.next25.11 to i32
  %exitcond28.11 = icmp eq i32 %lftr.wideiv27.11, %img_width
  br i1 %exitcond28.11, label %for.inc41.11, label %for.body15.11, !llvm.loop !3

for.inc41.11:                                     ; preds = %for.inc38.11
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.12

for.body15.lr.ph.12:                              ; preds = %for.inc41.11
  %indvars.iv.next30.11 = add nsw i64 %indvars.iv29, 12
  %720 = trunc i64 %indvars.iv.next30.11 to i32
  %mul16.12 = shl i32 %720, 7
  %721 = sext i32 %mul16.12 to i64
  br label %for.body15.12

for.body15.12:                                    ; preds = %for.inc38.12, %for.body15.lr.ph.12
  %indvars.iv24.12 = phi i64 [ 0, %for.body15.lr.ph.12 ], [ %indvars.iv.next25.12, %for.inc38.12 ]
  %722 = add nsw i64 %indvars.iv24.12, %721
  %arrayidx18.12 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %722
  %723 = load i32, i32* %arrayidx18.12, align 4
  %conv19.12 = uitofp i32 %723 to float
  %cmp20.12 = fcmp olt float %conv19.12, %mul6
  br i1 %cmp20.12, label %if.then22.12, label %if.else.12

if.else.12:                                       ; preds = %for.body15.12
  %cmp28.12 = fcmp ult float %conv19.12, %img_max.0.lcssa
  br i1 %cmp28.12, label %if.else33.12, label %if.then30.12

if.then30.12:                                     ; preds = %if.else.12
  store i32 255, i32* %arrayidx18.12, align 4
  br label %for.inc38.12

if.else33.12:                                     ; preds = %if.else.12
  store i32 75, i32* %arrayidx18.12, align 4
  br label %for.inc38.12

if.then22.12:                                     ; preds = %for.body15.12
  store i32 0, i32* %arrayidx18.12, align 4
  br label %for.inc38.12

for.inc38.12:                                     ; preds = %if.then22.12, %if.else33.12, %if.then30.12
  %indvars.iv.next25.12 = add nuw nsw i64 %indvars.iv24.12, 1
  %lftr.wideiv27.12 = trunc i64 %indvars.iv.next25.12 to i32
  %exitcond28.12 = icmp eq i32 %lftr.wideiv27.12, %img_width
  br i1 %exitcond28.12, label %for.inc41.12, label %for.body15.12, !llvm.loop !3

for.inc41.12:                                     ; preds = %for.inc38.12
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.13

for.body15.lr.ph.13:                              ; preds = %for.inc41.12
  %indvars.iv.next30.12 = add nsw i64 %indvars.iv29, 13
  %724 = trunc i64 %indvars.iv.next30.12 to i32
  %mul16.13 = shl i32 %724, 7
  %725 = sext i32 %mul16.13 to i64
  br label %for.body15.13

for.body15.13:                                    ; preds = %for.inc38.13, %for.body15.lr.ph.13
  %indvars.iv24.13 = phi i64 [ 0, %for.body15.lr.ph.13 ], [ %indvars.iv.next25.13, %for.inc38.13 ]
  %726 = add nsw i64 %indvars.iv24.13, %725
  %arrayidx18.13 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %726
  %727 = load i32, i32* %arrayidx18.13, align 4
  %conv19.13 = uitofp i32 %727 to float
  %cmp20.13 = fcmp olt float %conv19.13, %mul6
  br i1 %cmp20.13, label %if.then22.13, label %if.else.13

if.else.13:                                       ; preds = %for.body15.13
  %cmp28.13 = fcmp ult float %conv19.13, %img_max.0.lcssa
  br i1 %cmp28.13, label %if.else33.13, label %if.then30.13

if.then30.13:                                     ; preds = %if.else.13
  store i32 255, i32* %arrayidx18.13, align 4
  br label %for.inc38.13

if.else33.13:                                     ; preds = %if.else.13
  store i32 75, i32* %arrayidx18.13, align 4
  br label %for.inc38.13

if.then22.13:                                     ; preds = %for.body15.13
  store i32 0, i32* %arrayidx18.13, align 4
  br label %for.inc38.13

for.inc38.13:                                     ; preds = %if.then22.13, %if.else33.13, %if.then30.13
  %indvars.iv.next25.13 = add nuw nsw i64 %indvars.iv24.13, 1
  %lftr.wideiv27.13 = trunc i64 %indvars.iv.next25.13 to i32
  %exitcond28.13 = icmp eq i32 %lftr.wideiv27.13, %img_width
  br i1 %exitcond28.13, label %for.inc41.13, label %for.body15.13, !llvm.loop !3

for.inc41.13:                                     ; preds = %for.inc38.13
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.14

for.body15.lr.ph.14:                              ; preds = %for.inc41.13
  %indvars.iv.next30.13 = add nsw i64 %indvars.iv29, 14
  %728 = trunc i64 %indvars.iv.next30.13 to i32
  %mul16.14 = shl i32 %728, 7
  %729 = sext i32 %mul16.14 to i64
  br label %for.body15.14

for.body15.14:                                    ; preds = %for.inc38.14, %for.body15.lr.ph.14
  %indvars.iv24.14 = phi i64 [ 0, %for.body15.lr.ph.14 ], [ %indvars.iv.next25.14, %for.inc38.14 ]
  %730 = add nsw i64 %indvars.iv24.14, %729
  %arrayidx18.14 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %730
  %731 = load i32, i32* %arrayidx18.14, align 4
  %conv19.14 = uitofp i32 %731 to float
  %cmp20.14 = fcmp olt float %conv19.14, %mul6
  br i1 %cmp20.14, label %if.then22.14, label %if.else.14

if.else.14:                                       ; preds = %for.body15.14
  %cmp28.14 = fcmp ult float %conv19.14, %img_max.0.lcssa
  br i1 %cmp28.14, label %if.else33.14, label %if.then30.14

if.then30.14:                                     ; preds = %if.else.14
  store i32 255, i32* %arrayidx18.14, align 4
  br label %for.inc38.14

if.else33.14:                                     ; preds = %if.else.14
  store i32 75, i32* %arrayidx18.14, align 4
  br label %for.inc38.14

if.then22.14:                                     ; preds = %for.body15.14
  store i32 0, i32* %arrayidx18.14, align 4
  br label %for.inc38.14

for.inc38.14:                                     ; preds = %if.then22.14, %if.else33.14, %if.then30.14
  %indvars.iv.next25.14 = add nuw nsw i64 %indvars.iv24.14, 1
  %lftr.wideiv27.14 = trunc i64 %indvars.iv.next25.14 to i32
  %exitcond28.14 = icmp eq i32 %lftr.wideiv27.14, %img_width
  br i1 %exitcond28.14, label %for.inc41.14, label %for.body15.14, !llvm.loop !3

for.inc41.14:                                     ; preds = %for.inc38.14
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.15

for.body15.lr.ph.15:                              ; preds = %for.inc41.14
  %indvars.iv.next30.14 = add nsw i64 %indvars.iv29, 15
  %732 = trunc i64 %indvars.iv.next30.14 to i32
  %mul16.15 = shl i32 %732, 7
  %733 = sext i32 %mul16.15 to i64
  br label %for.body15.15

for.body15.15:                                    ; preds = %for.inc38.15, %for.body15.lr.ph.15
  %indvars.iv24.15 = phi i64 [ 0, %for.body15.lr.ph.15 ], [ %indvars.iv.next25.15, %for.inc38.15 ]
  %734 = add nsw i64 %indvars.iv24.15, %733
  %arrayidx18.15 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %734
  %735 = load i32, i32* %arrayidx18.15, align 4
  %conv19.15 = uitofp i32 %735 to float
  %cmp20.15 = fcmp olt float %conv19.15, %mul6
  br i1 %cmp20.15, label %if.then22.15, label %if.else.15

if.else.15:                                       ; preds = %for.body15.15
  %cmp28.15 = fcmp ult float %conv19.15, %img_max.0.lcssa
  br i1 %cmp28.15, label %if.else33.15, label %if.then30.15

if.then30.15:                                     ; preds = %if.else.15
  store i32 255, i32* %arrayidx18.15, align 4
  br label %for.inc38.15

if.else33.15:                                     ; preds = %if.else.15
  store i32 75, i32* %arrayidx18.15, align 4
  br label %for.inc38.15

if.then22.15:                                     ; preds = %for.body15.15
  store i32 0, i32* %arrayidx18.15, align 4
  br label %for.inc38.15

for.inc38.15:                                     ; preds = %if.then22.15, %if.else33.15, %if.then30.15
  %indvars.iv.next25.15 = add nuw nsw i64 %indvars.iv24.15, 1
  %lftr.wideiv27.15 = trunc i64 %indvars.iv.next25.15 to i32
  %exitcond28.15 = icmp eq i32 %lftr.wideiv27.15, %img_width
  br i1 %exitcond28.15, label %for.inc41.15, label %for.body15.15, !llvm.loop !3

for.inc41.15:                                     ; preds = %for.inc38.15
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.16

for.body15.lr.ph.16:                              ; preds = %for.inc41.15
  %indvars.iv.next30.15 = add nsw i64 %indvars.iv29, 16
  %736 = trunc i64 %indvars.iv.next30.15 to i32
  %mul16.16 = shl i32 %736, 7
  %737 = sext i32 %mul16.16 to i64
  br label %for.body15.16

for.body15.16:                                    ; preds = %for.inc38.16, %for.body15.lr.ph.16
  %indvars.iv24.16 = phi i64 [ 0, %for.body15.lr.ph.16 ], [ %indvars.iv.next25.16, %for.inc38.16 ]
  %738 = add nsw i64 %indvars.iv24.16, %737
  %arrayidx18.16 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %738
  %739 = load i32, i32* %arrayidx18.16, align 4
  %conv19.16 = uitofp i32 %739 to float
  %cmp20.16 = fcmp olt float %conv19.16, %mul6
  br i1 %cmp20.16, label %if.then22.16, label %if.else.16

if.else.16:                                       ; preds = %for.body15.16
  %cmp28.16 = fcmp ult float %conv19.16, %img_max.0.lcssa
  br i1 %cmp28.16, label %if.else33.16, label %if.then30.16

if.then30.16:                                     ; preds = %if.else.16
  store i32 255, i32* %arrayidx18.16, align 4
  br label %for.inc38.16

if.else33.16:                                     ; preds = %if.else.16
  store i32 75, i32* %arrayidx18.16, align 4
  br label %for.inc38.16

if.then22.16:                                     ; preds = %for.body15.16
  store i32 0, i32* %arrayidx18.16, align 4
  br label %for.inc38.16

for.inc38.16:                                     ; preds = %if.then22.16, %if.else33.16, %if.then30.16
  %indvars.iv.next25.16 = add nuw nsw i64 %indvars.iv24.16, 1
  %lftr.wideiv27.16 = trunc i64 %indvars.iv.next25.16 to i32
  %exitcond28.16 = icmp eq i32 %lftr.wideiv27.16, %img_width
  br i1 %exitcond28.16, label %for.inc41.16, label %for.body15.16, !llvm.loop !3

for.inc41.16:                                     ; preds = %for.inc38.16
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.17

for.body15.lr.ph.17:                              ; preds = %for.inc41.16
  %indvars.iv.next30.16 = add nsw i64 %indvars.iv29, 17
  %740 = trunc i64 %indvars.iv.next30.16 to i32
  %mul16.17 = shl i32 %740, 7
  %741 = sext i32 %mul16.17 to i64
  br label %for.body15.17

for.body15.17:                                    ; preds = %for.inc38.17, %for.body15.lr.ph.17
  %indvars.iv24.17 = phi i64 [ 0, %for.body15.lr.ph.17 ], [ %indvars.iv.next25.17, %for.inc38.17 ]
  %742 = add nsw i64 %indvars.iv24.17, %741
  %arrayidx18.17 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %742
  %743 = load i32, i32* %arrayidx18.17, align 4
  %conv19.17 = uitofp i32 %743 to float
  %cmp20.17 = fcmp olt float %conv19.17, %mul6
  br i1 %cmp20.17, label %if.then22.17, label %if.else.17

if.else.17:                                       ; preds = %for.body15.17
  %cmp28.17 = fcmp ult float %conv19.17, %img_max.0.lcssa
  br i1 %cmp28.17, label %if.else33.17, label %if.then30.17

if.then30.17:                                     ; preds = %if.else.17
  store i32 255, i32* %arrayidx18.17, align 4
  br label %for.inc38.17

if.else33.17:                                     ; preds = %if.else.17
  store i32 75, i32* %arrayidx18.17, align 4
  br label %for.inc38.17

if.then22.17:                                     ; preds = %for.body15.17
  store i32 0, i32* %arrayidx18.17, align 4
  br label %for.inc38.17

for.inc38.17:                                     ; preds = %if.then22.17, %if.else33.17, %if.then30.17
  %indvars.iv.next25.17 = add nuw nsw i64 %indvars.iv24.17, 1
  %lftr.wideiv27.17 = trunc i64 %indvars.iv.next25.17 to i32
  %exitcond28.17 = icmp eq i32 %lftr.wideiv27.17, %img_width
  br i1 %exitcond28.17, label %for.inc41.17, label %for.body15.17, !llvm.loop !3

for.inc41.17:                                     ; preds = %for.inc38.17
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.18

for.body15.lr.ph.18:                              ; preds = %for.inc41.17
  %indvars.iv.next30.17 = add nsw i64 %indvars.iv29, 18
  %744 = trunc i64 %indvars.iv.next30.17 to i32
  %mul16.18 = shl i32 %744, 7
  %745 = sext i32 %mul16.18 to i64
  br label %for.body15.18

for.body15.18:                                    ; preds = %for.inc38.18, %for.body15.lr.ph.18
  %indvars.iv24.18 = phi i64 [ 0, %for.body15.lr.ph.18 ], [ %indvars.iv.next25.18, %for.inc38.18 ]
  %746 = add nsw i64 %indvars.iv24.18, %745
  %arrayidx18.18 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %746
  %747 = load i32, i32* %arrayidx18.18, align 4
  %conv19.18 = uitofp i32 %747 to float
  %cmp20.18 = fcmp olt float %conv19.18, %mul6
  br i1 %cmp20.18, label %if.then22.18, label %if.else.18

if.else.18:                                       ; preds = %for.body15.18
  %cmp28.18 = fcmp ult float %conv19.18, %img_max.0.lcssa
  br i1 %cmp28.18, label %if.else33.18, label %if.then30.18

if.then30.18:                                     ; preds = %if.else.18
  store i32 255, i32* %arrayidx18.18, align 4
  br label %for.inc38.18

if.else33.18:                                     ; preds = %if.else.18
  store i32 75, i32* %arrayidx18.18, align 4
  br label %for.inc38.18

if.then22.18:                                     ; preds = %for.body15.18
  store i32 0, i32* %arrayidx18.18, align 4
  br label %for.inc38.18

for.inc38.18:                                     ; preds = %if.then22.18, %if.else33.18, %if.then30.18
  %indvars.iv.next25.18 = add nuw nsw i64 %indvars.iv24.18, 1
  %lftr.wideiv27.18 = trunc i64 %indvars.iv.next25.18 to i32
  %exitcond28.18 = icmp eq i32 %lftr.wideiv27.18, %img_width
  br i1 %exitcond28.18, label %for.inc41.18, label %for.body15.18, !llvm.loop !3

for.inc41.18:                                     ; preds = %for.inc38.18
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.19

for.body15.lr.ph.19:                              ; preds = %for.inc41.18
  %indvars.iv.next30.18 = add nsw i64 %indvars.iv29, 19
  %748 = trunc i64 %indvars.iv.next30.18 to i32
  %mul16.19 = shl i32 %748, 7
  %749 = sext i32 %mul16.19 to i64
  br label %for.body15.19

for.body15.19:                                    ; preds = %for.inc38.19, %for.body15.lr.ph.19
  %indvars.iv24.19 = phi i64 [ 0, %for.body15.lr.ph.19 ], [ %indvars.iv.next25.19, %for.inc38.19 ]
  %750 = add nsw i64 %indvars.iv24.19, %749
  %arrayidx18.19 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %750
  %751 = load i32, i32* %arrayidx18.19, align 4
  %conv19.19 = uitofp i32 %751 to float
  %cmp20.19 = fcmp olt float %conv19.19, %mul6
  br i1 %cmp20.19, label %if.then22.19, label %if.else.19

if.else.19:                                       ; preds = %for.body15.19
  %cmp28.19 = fcmp ult float %conv19.19, %img_max.0.lcssa
  br i1 %cmp28.19, label %if.else33.19, label %if.then30.19

if.then30.19:                                     ; preds = %if.else.19
  store i32 255, i32* %arrayidx18.19, align 4
  br label %for.inc38.19

if.else33.19:                                     ; preds = %if.else.19
  store i32 75, i32* %arrayidx18.19, align 4
  br label %for.inc38.19

if.then22.19:                                     ; preds = %for.body15.19
  store i32 0, i32* %arrayidx18.19, align 4
  br label %for.inc38.19

for.inc38.19:                                     ; preds = %if.then22.19, %if.else33.19, %if.then30.19
  %indvars.iv.next25.19 = add nuw nsw i64 %indvars.iv24.19, 1
  %lftr.wideiv27.19 = trunc i64 %indvars.iv.next25.19 to i32
  %exitcond28.19 = icmp eq i32 %lftr.wideiv27.19, %img_width
  br i1 %exitcond28.19, label %for.inc41.19, label %for.body15.19, !llvm.loop !3

for.inc41.19:                                     ; preds = %for.inc38.19
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.20

for.body15.lr.ph.20:                              ; preds = %for.inc41.19
  %indvars.iv.next30.19 = add nsw i64 %indvars.iv29, 20
  %752 = trunc i64 %indvars.iv.next30.19 to i32
  %mul16.20 = shl i32 %752, 7
  %753 = sext i32 %mul16.20 to i64
  br label %for.body15.20

for.body15.20:                                    ; preds = %for.inc38.20, %for.body15.lr.ph.20
  %indvars.iv24.20 = phi i64 [ 0, %for.body15.lr.ph.20 ], [ %indvars.iv.next25.20, %for.inc38.20 ]
  %754 = add nsw i64 %indvars.iv24.20, %753
  %arrayidx18.20 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %754
  %755 = load i32, i32* %arrayidx18.20, align 4
  %conv19.20 = uitofp i32 %755 to float
  %cmp20.20 = fcmp olt float %conv19.20, %mul6
  br i1 %cmp20.20, label %if.then22.20, label %if.else.20

if.else.20:                                       ; preds = %for.body15.20
  %cmp28.20 = fcmp ult float %conv19.20, %img_max.0.lcssa
  br i1 %cmp28.20, label %if.else33.20, label %if.then30.20

if.then30.20:                                     ; preds = %if.else.20
  store i32 255, i32* %arrayidx18.20, align 4
  br label %for.inc38.20

if.else33.20:                                     ; preds = %if.else.20
  store i32 75, i32* %arrayidx18.20, align 4
  br label %for.inc38.20

if.then22.20:                                     ; preds = %for.body15.20
  store i32 0, i32* %arrayidx18.20, align 4
  br label %for.inc38.20

for.inc38.20:                                     ; preds = %if.then22.20, %if.else33.20, %if.then30.20
  %indvars.iv.next25.20 = add nuw nsw i64 %indvars.iv24.20, 1
  %lftr.wideiv27.20 = trunc i64 %indvars.iv.next25.20 to i32
  %exitcond28.20 = icmp eq i32 %lftr.wideiv27.20, %img_width
  br i1 %exitcond28.20, label %for.inc41.20, label %for.body15.20, !llvm.loop !3

for.inc41.20:                                     ; preds = %for.inc38.20
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.21

for.body15.lr.ph.21:                              ; preds = %for.inc41.20
  %indvars.iv.next30.20 = add nsw i64 %indvars.iv29, 21
  %756 = trunc i64 %indvars.iv.next30.20 to i32
  %mul16.21 = shl i32 %756, 7
  %757 = sext i32 %mul16.21 to i64
  br label %for.body15.21

for.body15.21:                                    ; preds = %for.inc38.21, %for.body15.lr.ph.21
  %indvars.iv24.21 = phi i64 [ 0, %for.body15.lr.ph.21 ], [ %indvars.iv.next25.21, %for.inc38.21 ]
  %758 = add nsw i64 %indvars.iv24.21, %757
  %arrayidx18.21 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %758
  %759 = load i32, i32* %arrayidx18.21, align 4
  %conv19.21 = uitofp i32 %759 to float
  %cmp20.21 = fcmp olt float %conv19.21, %mul6
  br i1 %cmp20.21, label %if.then22.21, label %if.else.21

if.else.21:                                       ; preds = %for.body15.21
  %cmp28.21 = fcmp ult float %conv19.21, %img_max.0.lcssa
  br i1 %cmp28.21, label %if.else33.21, label %if.then30.21

if.then30.21:                                     ; preds = %if.else.21
  store i32 255, i32* %arrayidx18.21, align 4
  br label %for.inc38.21

if.else33.21:                                     ; preds = %if.else.21
  store i32 75, i32* %arrayidx18.21, align 4
  br label %for.inc38.21

if.then22.21:                                     ; preds = %for.body15.21
  store i32 0, i32* %arrayidx18.21, align 4
  br label %for.inc38.21

for.inc38.21:                                     ; preds = %if.then22.21, %if.else33.21, %if.then30.21
  %indvars.iv.next25.21 = add nuw nsw i64 %indvars.iv24.21, 1
  %lftr.wideiv27.21 = trunc i64 %indvars.iv.next25.21 to i32
  %exitcond28.21 = icmp eq i32 %lftr.wideiv27.21, %img_width
  br i1 %exitcond28.21, label %for.inc41.21, label %for.body15.21, !llvm.loop !3

for.inc41.21:                                     ; preds = %for.inc38.21
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.22

for.body15.lr.ph.22:                              ; preds = %for.inc41.21
  %indvars.iv.next30.21 = add nsw i64 %indvars.iv29, 22
  %760 = trunc i64 %indvars.iv.next30.21 to i32
  %mul16.22 = shl i32 %760, 7
  %761 = sext i32 %mul16.22 to i64
  br label %for.body15.22

for.body15.22:                                    ; preds = %for.inc38.22, %for.body15.lr.ph.22
  %indvars.iv24.22 = phi i64 [ 0, %for.body15.lr.ph.22 ], [ %indvars.iv.next25.22, %for.inc38.22 ]
  %762 = add nsw i64 %indvars.iv24.22, %761
  %arrayidx18.22 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %762
  %763 = load i32, i32* %arrayidx18.22, align 4
  %conv19.22 = uitofp i32 %763 to float
  %cmp20.22 = fcmp olt float %conv19.22, %mul6
  br i1 %cmp20.22, label %if.then22.22, label %if.else.22

if.else.22:                                       ; preds = %for.body15.22
  %cmp28.22 = fcmp ult float %conv19.22, %img_max.0.lcssa
  br i1 %cmp28.22, label %if.else33.22, label %if.then30.22

if.then30.22:                                     ; preds = %if.else.22
  store i32 255, i32* %arrayidx18.22, align 4
  br label %for.inc38.22

if.else33.22:                                     ; preds = %if.else.22
  store i32 75, i32* %arrayidx18.22, align 4
  br label %for.inc38.22

if.then22.22:                                     ; preds = %for.body15.22
  store i32 0, i32* %arrayidx18.22, align 4
  br label %for.inc38.22

for.inc38.22:                                     ; preds = %if.then22.22, %if.else33.22, %if.then30.22
  %indvars.iv.next25.22 = add nuw nsw i64 %indvars.iv24.22, 1
  %lftr.wideiv27.22 = trunc i64 %indvars.iv.next25.22 to i32
  %exitcond28.22 = icmp eq i32 %lftr.wideiv27.22, %img_width
  br i1 %exitcond28.22, label %for.inc41.22, label %for.body15.22, !llvm.loop !3

for.inc41.22:                                     ; preds = %for.inc38.22
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.23

for.body15.lr.ph.23:                              ; preds = %for.inc41.22
  %indvars.iv.next30.22 = add nsw i64 %indvars.iv29, 23
  %764 = trunc i64 %indvars.iv.next30.22 to i32
  %mul16.23 = shl i32 %764, 7
  %765 = sext i32 %mul16.23 to i64
  br label %for.body15.23

for.body15.23:                                    ; preds = %for.inc38.23, %for.body15.lr.ph.23
  %indvars.iv24.23 = phi i64 [ 0, %for.body15.lr.ph.23 ], [ %indvars.iv.next25.23, %for.inc38.23 ]
  %766 = add nsw i64 %indvars.iv24.23, %765
  %arrayidx18.23 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %766
  %767 = load i32, i32* %arrayidx18.23, align 4
  %conv19.23 = uitofp i32 %767 to float
  %cmp20.23 = fcmp olt float %conv19.23, %mul6
  br i1 %cmp20.23, label %if.then22.23, label %if.else.23

if.else.23:                                       ; preds = %for.body15.23
  %cmp28.23 = fcmp ult float %conv19.23, %img_max.0.lcssa
  br i1 %cmp28.23, label %if.else33.23, label %if.then30.23

if.then30.23:                                     ; preds = %if.else.23
  store i32 255, i32* %arrayidx18.23, align 4
  br label %for.inc38.23

if.else33.23:                                     ; preds = %if.else.23
  store i32 75, i32* %arrayidx18.23, align 4
  br label %for.inc38.23

if.then22.23:                                     ; preds = %for.body15.23
  store i32 0, i32* %arrayidx18.23, align 4
  br label %for.inc38.23

for.inc38.23:                                     ; preds = %if.then22.23, %if.else33.23, %if.then30.23
  %indvars.iv.next25.23 = add nuw nsw i64 %indvars.iv24.23, 1
  %lftr.wideiv27.23 = trunc i64 %indvars.iv.next25.23 to i32
  %exitcond28.23 = icmp eq i32 %lftr.wideiv27.23, %img_width
  br i1 %exitcond28.23, label %for.inc41.23, label %for.body15.23, !llvm.loop !3

for.inc41.23:                                     ; preds = %for.inc38.23
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.24

for.body15.lr.ph.24:                              ; preds = %for.inc41.23
  %indvars.iv.next30.23 = add nsw i64 %indvars.iv29, 24
  %768 = trunc i64 %indvars.iv.next30.23 to i32
  %mul16.24 = shl i32 %768, 7
  %769 = sext i32 %mul16.24 to i64
  br label %for.body15.24

for.body15.24:                                    ; preds = %for.inc38.24, %for.body15.lr.ph.24
  %indvars.iv24.24 = phi i64 [ 0, %for.body15.lr.ph.24 ], [ %indvars.iv.next25.24, %for.inc38.24 ]
  %770 = add nsw i64 %indvars.iv24.24, %769
  %arrayidx18.24 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %770
  %771 = load i32, i32* %arrayidx18.24, align 4
  %conv19.24 = uitofp i32 %771 to float
  %cmp20.24 = fcmp olt float %conv19.24, %mul6
  br i1 %cmp20.24, label %if.then22.24, label %if.else.24

if.else.24:                                       ; preds = %for.body15.24
  %cmp28.24 = fcmp ult float %conv19.24, %img_max.0.lcssa
  br i1 %cmp28.24, label %if.else33.24, label %if.then30.24

if.then30.24:                                     ; preds = %if.else.24
  store i32 255, i32* %arrayidx18.24, align 4
  br label %for.inc38.24

if.else33.24:                                     ; preds = %if.else.24
  store i32 75, i32* %arrayidx18.24, align 4
  br label %for.inc38.24

if.then22.24:                                     ; preds = %for.body15.24
  store i32 0, i32* %arrayidx18.24, align 4
  br label %for.inc38.24

for.inc38.24:                                     ; preds = %if.then22.24, %if.else33.24, %if.then30.24
  %indvars.iv.next25.24 = add nuw nsw i64 %indvars.iv24.24, 1
  %lftr.wideiv27.24 = trunc i64 %indvars.iv.next25.24 to i32
  %exitcond28.24 = icmp eq i32 %lftr.wideiv27.24, %img_width
  br i1 %exitcond28.24, label %for.inc41.24, label %for.body15.24, !llvm.loop !3

for.inc41.24:                                     ; preds = %for.inc38.24
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.25

for.body15.lr.ph.25:                              ; preds = %for.inc41.24
  %indvars.iv.next30.24 = add nsw i64 %indvars.iv29, 25
  %772 = trunc i64 %indvars.iv.next30.24 to i32
  %mul16.25 = shl i32 %772, 7
  %773 = sext i32 %mul16.25 to i64
  br label %for.body15.25

for.body15.25:                                    ; preds = %for.inc38.25, %for.body15.lr.ph.25
  %indvars.iv24.25 = phi i64 [ 0, %for.body15.lr.ph.25 ], [ %indvars.iv.next25.25, %for.inc38.25 ]
  %774 = add nsw i64 %indvars.iv24.25, %773
  %arrayidx18.25 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %774
  %775 = load i32, i32* %arrayidx18.25, align 4
  %conv19.25 = uitofp i32 %775 to float
  %cmp20.25 = fcmp olt float %conv19.25, %mul6
  br i1 %cmp20.25, label %if.then22.25, label %if.else.25

if.else.25:                                       ; preds = %for.body15.25
  %cmp28.25 = fcmp ult float %conv19.25, %img_max.0.lcssa
  br i1 %cmp28.25, label %if.else33.25, label %if.then30.25

if.then30.25:                                     ; preds = %if.else.25
  store i32 255, i32* %arrayidx18.25, align 4
  br label %for.inc38.25

if.else33.25:                                     ; preds = %if.else.25
  store i32 75, i32* %arrayidx18.25, align 4
  br label %for.inc38.25

if.then22.25:                                     ; preds = %for.body15.25
  store i32 0, i32* %arrayidx18.25, align 4
  br label %for.inc38.25

for.inc38.25:                                     ; preds = %if.then22.25, %if.else33.25, %if.then30.25
  %indvars.iv.next25.25 = add nuw nsw i64 %indvars.iv24.25, 1
  %lftr.wideiv27.25 = trunc i64 %indvars.iv.next25.25 to i32
  %exitcond28.25 = icmp eq i32 %lftr.wideiv27.25, %img_width
  br i1 %exitcond28.25, label %for.inc41.25, label %for.body15.25, !llvm.loop !3

for.inc41.25:                                     ; preds = %for.inc38.25
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.26

for.body15.lr.ph.26:                              ; preds = %for.inc41.25
  %indvars.iv.next30.25 = add nsw i64 %indvars.iv29, 26
  %776 = trunc i64 %indvars.iv.next30.25 to i32
  %mul16.26 = shl i32 %776, 7
  %777 = sext i32 %mul16.26 to i64
  br label %for.body15.26

for.body15.26:                                    ; preds = %for.inc38.26, %for.body15.lr.ph.26
  %indvars.iv24.26 = phi i64 [ 0, %for.body15.lr.ph.26 ], [ %indvars.iv.next25.26, %for.inc38.26 ]
  %778 = add nsw i64 %indvars.iv24.26, %777
  %arrayidx18.26 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %778
  %779 = load i32, i32* %arrayidx18.26, align 4
  %conv19.26 = uitofp i32 %779 to float
  %cmp20.26 = fcmp olt float %conv19.26, %mul6
  br i1 %cmp20.26, label %if.then22.26, label %if.else.26

if.else.26:                                       ; preds = %for.body15.26
  %cmp28.26 = fcmp ult float %conv19.26, %img_max.0.lcssa
  br i1 %cmp28.26, label %if.else33.26, label %if.then30.26

if.then30.26:                                     ; preds = %if.else.26
  store i32 255, i32* %arrayidx18.26, align 4
  br label %for.inc38.26

if.else33.26:                                     ; preds = %if.else.26
  store i32 75, i32* %arrayidx18.26, align 4
  br label %for.inc38.26

if.then22.26:                                     ; preds = %for.body15.26
  store i32 0, i32* %arrayidx18.26, align 4
  br label %for.inc38.26

for.inc38.26:                                     ; preds = %if.then22.26, %if.else33.26, %if.then30.26
  %indvars.iv.next25.26 = add nuw nsw i64 %indvars.iv24.26, 1
  %lftr.wideiv27.26 = trunc i64 %indvars.iv.next25.26 to i32
  %exitcond28.26 = icmp eq i32 %lftr.wideiv27.26, %img_width
  br i1 %exitcond28.26, label %for.inc41.26, label %for.body15.26, !llvm.loop !3

for.inc41.26:                                     ; preds = %for.inc38.26
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.27

for.body15.lr.ph.27:                              ; preds = %for.inc41.26
  %indvars.iv.next30.26 = add nsw i64 %indvars.iv29, 27
  %780 = trunc i64 %indvars.iv.next30.26 to i32
  %mul16.27 = shl i32 %780, 7
  %781 = sext i32 %mul16.27 to i64
  br label %for.body15.27

for.body15.27:                                    ; preds = %for.inc38.27, %for.body15.lr.ph.27
  %indvars.iv24.27 = phi i64 [ 0, %for.body15.lr.ph.27 ], [ %indvars.iv.next25.27, %for.inc38.27 ]
  %782 = add nsw i64 %indvars.iv24.27, %781
  %arrayidx18.27 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %782
  %783 = load i32, i32* %arrayidx18.27, align 4
  %conv19.27 = uitofp i32 %783 to float
  %cmp20.27 = fcmp olt float %conv19.27, %mul6
  br i1 %cmp20.27, label %if.then22.27, label %if.else.27

if.else.27:                                       ; preds = %for.body15.27
  %cmp28.27 = fcmp ult float %conv19.27, %img_max.0.lcssa
  br i1 %cmp28.27, label %if.else33.27, label %if.then30.27

if.then30.27:                                     ; preds = %if.else.27
  store i32 255, i32* %arrayidx18.27, align 4
  br label %for.inc38.27

if.else33.27:                                     ; preds = %if.else.27
  store i32 75, i32* %arrayidx18.27, align 4
  br label %for.inc38.27

if.then22.27:                                     ; preds = %for.body15.27
  store i32 0, i32* %arrayidx18.27, align 4
  br label %for.inc38.27

for.inc38.27:                                     ; preds = %if.then22.27, %if.else33.27, %if.then30.27
  %indvars.iv.next25.27 = add nuw nsw i64 %indvars.iv24.27, 1
  %lftr.wideiv27.27 = trunc i64 %indvars.iv.next25.27 to i32
  %exitcond28.27 = icmp eq i32 %lftr.wideiv27.27, %img_width
  br i1 %exitcond28.27, label %for.inc41.27, label %for.body15.27, !llvm.loop !3

for.inc41.27:                                     ; preds = %for.inc38.27
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.28

for.body15.lr.ph.28:                              ; preds = %for.inc41.27
  %indvars.iv.next30.27 = add nsw i64 %indvars.iv29, 28
  %784 = trunc i64 %indvars.iv.next30.27 to i32
  %mul16.28 = shl i32 %784, 7
  %785 = sext i32 %mul16.28 to i64
  br label %for.body15.28

for.body15.28:                                    ; preds = %for.inc38.28, %for.body15.lr.ph.28
  %indvars.iv24.28 = phi i64 [ 0, %for.body15.lr.ph.28 ], [ %indvars.iv.next25.28, %for.inc38.28 ]
  %786 = add nsw i64 %indvars.iv24.28, %785
  %arrayidx18.28 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %786
  %787 = load i32, i32* %arrayidx18.28, align 4
  %conv19.28 = uitofp i32 %787 to float
  %cmp20.28 = fcmp olt float %conv19.28, %mul6
  br i1 %cmp20.28, label %if.then22.28, label %if.else.28

if.else.28:                                       ; preds = %for.body15.28
  %cmp28.28 = fcmp ult float %conv19.28, %img_max.0.lcssa
  br i1 %cmp28.28, label %if.else33.28, label %if.then30.28

if.then30.28:                                     ; preds = %if.else.28
  store i32 255, i32* %arrayidx18.28, align 4
  br label %for.inc38.28

if.else33.28:                                     ; preds = %if.else.28
  store i32 75, i32* %arrayidx18.28, align 4
  br label %for.inc38.28

if.then22.28:                                     ; preds = %for.body15.28
  store i32 0, i32* %arrayidx18.28, align 4
  br label %for.inc38.28

for.inc38.28:                                     ; preds = %if.then22.28, %if.else33.28, %if.then30.28
  %indvars.iv.next25.28 = add nuw nsw i64 %indvars.iv24.28, 1
  %lftr.wideiv27.28 = trunc i64 %indvars.iv.next25.28 to i32
  %exitcond28.28 = icmp eq i32 %lftr.wideiv27.28, %img_width
  br i1 %exitcond28.28, label %for.inc41.28, label %for.body15.28, !llvm.loop !3

for.inc41.28:                                     ; preds = %for.inc38.28
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.29

for.body15.lr.ph.29:                              ; preds = %for.inc41.28
  %indvars.iv.next30.28 = add nsw i64 %indvars.iv29, 29
  %788 = trunc i64 %indvars.iv.next30.28 to i32
  %mul16.29 = shl i32 %788, 7
  %789 = sext i32 %mul16.29 to i64
  br label %for.body15.29

for.body15.29:                                    ; preds = %for.inc38.29, %for.body15.lr.ph.29
  %indvars.iv24.29 = phi i64 [ 0, %for.body15.lr.ph.29 ], [ %indvars.iv.next25.29, %for.inc38.29 ]
  %790 = add nsw i64 %indvars.iv24.29, %789
  %arrayidx18.29 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %790
  %791 = load i32, i32* %arrayidx18.29, align 4
  %conv19.29 = uitofp i32 %791 to float
  %cmp20.29 = fcmp olt float %conv19.29, %mul6
  br i1 %cmp20.29, label %if.then22.29, label %if.else.29

if.else.29:                                       ; preds = %for.body15.29
  %cmp28.29 = fcmp ult float %conv19.29, %img_max.0.lcssa
  br i1 %cmp28.29, label %if.else33.29, label %if.then30.29

if.then30.29:                                     ; preds = %if.else.29
  store i32 255, i32* %arrayidx18.29, align 4
  br label %for.inc38.29

if.else33.29:                                     ; preds = %if.else.29
  store i32 75, i32* %arrayidx18.29, align 4
  br label %for.inc38.29

if.then22.29:                                     ; preds = %for.body15.29
  store i32 0, i32* %arrayidx18.29, align 4
  br label %for.inc38.29

for.inc38.29:                                     ; preds = %if.then22.29, %if.else33.29, %if.then30.29
  %indvars.iv.next25.29 = add nuw nsw i64 %indvars.iv24.29, 1
  %lftr.wideiv27.29 = trunc i64 %indvars.iv.next25.29 to i32
  %exitcond28.29 = icmp eq i32 %lftr.wideiv27.29, %img_width
  br i1 %exitcond28.29, label %for.inc41.29, label %for.body15.29, !llvm.loop !3

for.inc41.29:                                     ; preds = %for.inc38.29
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.30

for.body15.lr.ph.30:                              ; preds = %for.inc41.29
  %indvars.iv.next30.29 = add nsw i64 %indvars.iv29, 30
  %792 = trunc i64 %indvars.iv.next30.29 to i32
  %mul16.30 = shl i32 %792, 7
  %793 = sext i32 %mul16.30 to i64
  br label %for.body15.30

for.body15.30:                                    ; preds = %for.inc38.30, %for.body15.lr.ph.30
  %indvars.iv24.30 = phi i64 [ 0, %for.body15.lr.ph.30 ], [ %indvars.iv.next25.30, %for.inc38.30 ]
  %794 = add nsw i64 %indvars.iv24.30, %793
  %arrayidx18.30 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %794
  %795 = load i32, i32* %arrayidx18.30, align 4
  %conv19.30 = uitofp i32 %795 to float
  %cmp20.30 = fcmp olt float %conv19.30, %mul6
  br i1 %cmp20.30, label %if.then22.30, label %if.else.30

if.else.30:                                       ; preds = %for.body15.30
  %cmp28.30 = fcmp ult float %conv19.30, %img_max.0.lcssa
  br i1 %cmp28.30, label %if.else33.30, label %if.then30.30

if.then30.30:                                     ; preds = %if.else.30
  store i32 255, i32* %arrayidx18.30, align 4
  br label %for.inc38.30

if.else33.30:                                     ; preds = %if.else.30
  store i32 75, i32* %arrayidx18.30, align 4
  br label %for.inc38.30

if.then22.30:                                     ; preds = %for.body15.30
  store i32 0, i32* %arrayidx18.30, align 4
  br label %for.inc38.30

for.inc38.30:                                     ; preds = %if.then22.30, %if.else33.30, %if.then30.30
  %indvars.iv.next25.30 = add nuw nsw i64 %indvars.iv24.30, 1
  %lftr.wideiv27.30 = trunc i64 %indvars.iv.next25.30 to i32
  %exitcond28.30 = icmp eq i32 %lftr.wideiv27.30, %img_width
  br i1 %exitcond28.30, label %for.inc41.30, label %for.body15.30, !llvm.loop !3

for.inc41.30:                                     ; preds = %for.inc38.30
  br i1 %cmp138, label %for.inc41.31, label %for.body15.lr.ph.31

for.body15.lr.ph.31:                              ; preds = %for.inc41.30
  %indvars.iv.next30.30 = add nsw i64 %indvars.iv29, 31
  %796 = trunc i64 %indvars.iv.next30.30 to i32
  %mul16.31 = shl i32 %796, 7
  %797 = sext i32 %mul16.31 to i64
  br label %for.body15.31

for.body15.31:                                    ; preds = %for.inc38.31, %for.body15.lr.ph.31
  %indvars.iv24.31 = phi i64 [ 0, %for.body15.lr.ph.31 ], [ %indvars.iv.next25.31, %for.inc38.31 ]
  %798 = add nsw i64 %indvars.iv24.31, %797
  %arrayidx18.31 = getelementptr inbounds i32, i32* inttoptr (i64 587202592 to i32*), i64 %798
  %799 = load i32, i32* %arrayidx18.31, align 4
  %conv19.31 = uitofp i32 %799 to float
  %cmp20.31 = fcmp olt float %conv19.31, %mul6
  br i1 %cmp20.31, label %if.then22.31, label %if.else.31

if.else.31:                                       ; preds = %for.body15.31
  %cmp28.31 = fcmp ult float %conv19.31, %img_max.0.lcssa
  br i1 %cmp28.31, label %if.else33.31, label %if.then30.31

if.then30.31:                                     ; preds = %if.else.31
  store i32 255, i32* %arrayidx18.31, align 4
  br label %for.inc38.31

if.else33.31:                                     ; preds = %if.else.31
  store i32 75, i32* %arrayidx18.31, align 4
  br label %for.inc38.31

if.then22.31:                                     ; preds = %for.body15.31
  store i32 0, i32* %arrayidx18.31, align 4
  br label %for.inc38.31

for.inc38.31:                                     ; preds = %if.then22.31, %if.else33.31, %if.then30.31
  %indvars.iv.next25.31 = add nuw nsw i64 %indvars.iv24.31, 1
  %lftr.wideiv27.31 = trunc i64 %indvars.iv.next25.31 to i32
  %exitcond28.31 = icmp eq i32 %lftr.wideiv27.31, %img_width
  br i1 %exitcond28.31, label %for.inc41.31.loopexit, label %for.body15.31, !llvm.loop !3

for.inc41.31.loopexit:                            ; preds = %for.inc38.31
  br label %for.inc41.31

for.inc41.31:                                     ; preds = %for.inc41.31.loopexit, %for.cond12.preheader, %for.inc41, %for.inc41.1, %for.inc41.2, %for.inc41.3, %for.inc41.4, %for.inc41.5, %for.inc41.6, %for.inc41.7, %for.inc41.8, %for.inc41.9, %for.inc41.10, %for.inc41.11, %for.inc41.12, %for.inc41.13, %for.inc41.14, %for.inc41.15, %for.inc41.16, %for.inc41.17, %for.inc41.18, %for.inc41.19, %for.inc41.20, %for.inc41.21, %for.inc41.22, %for.inc41.23, %for.inc41.24, %for.inc41.25, %for.inc41.26, %for.inc41.27, %for.inc41.28, %for.inc41.29, %for.inc41.30
  %indvars.iv.next30.31 = add nsw i64 %indvars.iv29, 32
  %lftr.wideiv31.31 = trunc i64 %indvars.iv.next30.31 to i32
  %exitcond32.31 = icmp eq i32 %lftr.wideiv31.31, %img_height
  br i1 %exitcond32.31, label %for.cond45.preheader, label %for.cond12.preheader, !llvm.loop !8
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
