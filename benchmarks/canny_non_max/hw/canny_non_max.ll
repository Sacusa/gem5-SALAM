; ModuleID = 'canny_non_max.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @canny_non_max(i32 %img_height, i32 %img_width) #0 {
entry:
  %cmp13 = icmp eq i32 %img_height, 0
  br i1 %cmp13, label %for.end129, label %for.cond2.preheader.lr.ph

for.cond2.preheader.lr.ph:                        ; preds = %entry
  %sub1 = add i32 %img_width, -1
  %sub = add i32 %img_height, -1
  %cmp39 = icmp eq i32 %img_width, 0
  %0 = zext i32 %sub1 to i64
  %1 = zext i32 %sub to i64
  %2 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond2.preheader.lr.ph.split, label %for.cond2.preheader.prol.preheader

for.cond2.preheader.prol.preheader:               ; preds = %for.cond2.preheader.lr.ph
  br label %for.cond2.preheader.prol

for.cond2.preheader.prol:                         ; preds = %for.cond2.preheader.prol.preheader, %for.inc127.prol
  %indvars.iv19.prol = phi i64 [ %indvars.iv.next20.prol, %for.inc127.prol ], [ 0, %for.cond2.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc127.prol ], [ %xtraiter, %for.cond2.preheader.prol.preheader ]
  br i1 %cmp39, label %for.inc127.prol, label %for.body4.lr.ph.prol

for.body4.lr.ph.prol:                             ; preds = %for.cond2.preheader.prol
  %3 = trunc i64 %indvars.iv19.prol to i32
  %mul.prol = shl nsw i32 %3, 7
  %cmp5.prol = icmp eq i64 %indvars.iv19.prol, 0
  %cmp6.prol = icmp eq i64 %indvars.iv19.prol, %1
  %or.cond.prol = or i1 %cmp5.prol, %cmp6.prol
  %add33.prol = or i32 %mul.prol, 1
  %sub38.prol = add i32 %mul.prol, -1
  %4 = trunc i64 %indvars.iv19.prol to i32
  %add51.prol = shl i32 %4, 7
  %5 = trunc i64 %indvars.iv19.prol to i32
  %add72.prol = shl i32 %5, 7
  %mul73.prol = add i32 %add72.prol, 128
  %mul78.prol = add i32 %add72.prol, -128
  %6 = trunc i64 %indvars.iv19.prol to i32
  %sub91.prol = shl i32 %6, 7
  %7 = sext i32 %mul.prol to i64
  %8 = sext i32 %mul78.prol to i64
  %9 = sext i32 %mul73.prol to i64
  br label %for.body4.prol

for.body4.prol:                                   ; preds = %for.inc.prol, %for.body4.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body4.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc.prol ]
  %10 = add nsw i64 %indvars.iv.prol, %7
  %cmp8.prol = icmp eq i64 %indvars.iv.prol, 0
  %or.cond1.prol = or i1 %or.cond.prol, %cmp8.prol
  %cmp10.prol = icmp eq i64 %indvars.iv.prol, %0
  %or.cond2.prol = or i1 %cmp10.prol, %or.cond1.prol
  br i1 %or.cond2.prol, label %if.then.prol, label %if.else.prol

if.else.prol:                                     ; preds = %for.body4.prol
  %arrayidx12.prol = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %10
  %11 = load float, float* %arrayidx12.prol, align 4
  %conv.prol = fpext float %11 to double
  %mul13.prol = fmul double %conv.prol, 0x404CA5DC1A63C1F8
  %conv14.prol = fptrunc double %mul13.prol to float
  %cmp15.prol = fcmp olt float %conv14.prol, 0.000000e+00
  %add18.prol = fadd float %conv14.prol, 1.800000e+02
  %angle.0.prol = select i1 %cmp15.prol, float %add18.prol, float %conv14.prol
  %cmp19.prol = fcmp oge float %angle.0.prol, 0.000000e+00
  %cmp22.prol = fcmp olt float %angle.0.prol, 2.250000e+01
  %or.cond3.prol = and i1 %cmp19.prol, %cmp22.prol
  br i1 %or.cond3.prol, label %if.then31.prol, label %lor.lhs.false24.prol

lor.lhs.false24.prol:                             ; preds = %if.else.prol
  %cmp26.prol = fcmp ult float %angle.0.prol, 1.575000e+02
  %cmp29.prol = fcmp ugt float %angle.0.prol, 1.800000e+02
  %or.cond4.prol = or i1 %cmp26.prol, %cmp29.prol
  br i1 %or.cond4.prol, label %if.else42.prol, label %if.then31.prol

if.else42.prol:                                   ; preds = %lor.lhs.false24.prol
  %cmp44.prol = fcmp oge float %angle.0.prol, 2.250000e+01
  %cmp48.prol = fcmp olt float %angle.0.prol, 6.750000e+01
  %or.cond5.prol = and i1 %cmp44.prol, %cmp48.prol
  br i1 %or.cond5.prol, label %if.then50.prol, label %if.else63.prol

if.else63.prol:                                   ; preds = %if.else42.prol
  %cmp65.prol = fcmp oge float %angle.0.prol, 6.750000e+01
  %cmp69.prol = fcmp olt float %angle.0.prol, 1.125000e+02
  %or.cond6.prol = and i1 %cmp65.prol, %cmp69.prol
  br i1 %or.cond6.prol, label %if.then71.prol, label %if.else82.prol

if.else82.prol:                                   ; preds = %if.else63.prol
  %cmp84.prol = fcmp oge float %angle.0.prol, 1.125000e+02
  %cmp88.prol = fcmp olt float %angle.0.prol, 1.575000e+02
  %or.cond7.prol = and i1 %cmp84.prol, %cmp88.prol
  br i1 %or.cond7.prol, label %if.then90.prol, label %if.end106.prol

if.then90.prol:                                   ; preds = %if.else82.prol
  %12 = trunc i64 %indvars.iv.prol to i32
  %sub93.prol = add i32 %12, %sub91.prol
  %add94.prol = add i32 %sub93.prol, -129
  %idxprom95.prol = sext i32 %add94.prol to i64
  %arrayidx96.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.prol
  %13 = load float, float* %arrayidx96.prol, align 4
  %add100.prol = add i32 %sub93.prol, 129
  %idxprom101.prol = sext i32 %add100.prol to i64
  %arrayidx102.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.prol
  %14 = load float, float* %arrayidx102.prol, align 4
  br label %if.end106.prol

if.then71.prol:                                   ; preds = %if.else63.prol
  %15 = add nsw i64 %9, %indvars.iv.prol
  %arrayidx76.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %15
  %16 = load float, float* %arrayidx76.prol, align 4
  %17 = add nsw i64 %8, %indvars.iv.prol
  %arrayidx81.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %17
  %18 = load float, float* %arrayidx81.prol, align 4
  br label %if.end106.prol

if.then50.prol:                                   ; preds = %if.else42.prol
  %19 = trunc i64 %indvars.iv.prol to i32
  %sub53.prol = add i32 %19, %add51.prol
  %add54.prol = add i32 %sub53.prol, 127
  %idxprom55.prol = sext i32 %add54.prol to i64
  %arrayidx56.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.prol
  %20 = load float, float* %arrayidx56.prol, align 4
  %add60.prol = add i32 %sub53.prol, -127
  %idxprom61.prol = sext i32 %add60.prol to i64
  %arrayidx62.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.prol
  %21 = load float, float* %arrayidx62.prol, align 4
  br label %if.end106.prol

if.then31.prol:                                   ; preds = %lor.lhs.false24.prol, %if.else.prol
  %22 = trunc i64 %indvars.iv.prol to i32
  %add34.prol = add i32 %add33.prol, %22
  %idxprom35.prol = sext i32 %add34.prol to i64
  %arrayidx36.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.prol
  %23 = load float, float* %arrayidx36.prol, align 4
  %24 = trunc i64 %indvars.iv.prol to i32
  %add39.prol = add i32 %sub38.prol, %24
  %idxprom40.prol = sext i32 %add39.prol to i64
  %arrayidx41.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.prol
  %25 = load float, float* %arrayidx41.prol, align 4
  br label %if.end106.prol

if.end106.prol:                                   ; preds = %if.then31.prol, %if.then50.prol, %if.then71.prol, %if.then90.prol, %if.else82.prol
  %q.3.prol = phi float [ %23, %if.then31.prol ], [ %20, %if.then50.prol ], [ %16, %if.then71.prol ], [ %13, %if.then90.prol ], [ 2.550000e+02, %if.else82.prol ]
  %r.3.prol = phi float [ %25, %if.then31.prol ], [ %21, %if.then50.prol ], [ %18, %if.then71.prol ], [ %14, %if.then90.prol ], [ 2.550000e+02, %if.else82.prol ]
  %arrayidx108.prol = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %10
  %26 = load float, float* %arrayidx108.prol, align 4
  %cmp109.prol = fcmp ult float %26, %q.3.prol
  %cmp114.prol = fcmp ult float %26, %r.3.prol
  %or.cond8.prol = or i1 %cmp109.prol, %cmp114.prol
  br i1 %or.cond8.prol, label %if.else122.prol, label %if.then116.prol

if.then116.prol:                                  ; preds = %if.end106.prol
  %conv119.prol = fptoui float %26 to i32
  %arrayidx121.prol = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %10
  store i32 %conv119.prol, i32* %arrayidx121.prol, align 4
  br label %for.inc.prol

if.else122.prol:                                  ; preds = %if.end106.prol
  %arrayidx124.prol = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %10
  store i32 0, i32* %arrayidx124.prol, align 4
  br label %for.inc.prol

if.then.prol:                                     ; preds = %for.body4.prol
  %arrayidx.prol = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %10
  store i32 0, i32* %arrayidx.prol, align 4
  br label %for.inc.prol

for.inc.prol:                                     ; preds = %if.then.prol, %if.else122.prol, %if.then116.prol
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %img_width
  br i1 %exitcond.prol, label %for.inc127.prol.loopexit, label %for.body4.prol, !llvm.loop !1

for.inc127.prol.loopexit:                         ; preds = %for.inc.prol
  br label %for.inc127.prol

for.inc127.prol:                                  ; preds = %for.inc127.prol.loopexit, %for.cond2.preheader.prol
  %indvars.iv.next20.prol = add nuw nsw i64 %indvars.iv19.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond2.preheader.lr.ph.split.loopexit, label %for.cond2.preheader.prol, !llvm.loop !3

for.cond2.preheader.lr.ph.split.loopexit:         ; preds = %for.inc127.prol
  %indvars.iv.next20.prol.lcssa = phi i64 [ %indvars.iv.next20.prol, %for.inc127.prol ]
  br label %for.cond2.preheader.lr.ph.split

for.cond2.preheader.lr.ph.split:                  ; preds = %for.cond2.preheader.lr.ph.split.loopexit, %for.cond2.preheader.lr.ph
  %indvars.iv19.unr = phi i64 [ 0, %for.cond2.preheader.lr.ph ], [ %indvars.iv.next20.prol.lcssa, %for.cond2.preheader.lr.ph.split.loopexit ]
  %27 = icmp ult i32 %2, 31
  br i1 %27, label %for.end129, label %for.cond2.preheader.preheader

for.cond2.preheader.preheader:                    ; preds = %for.cond2.preheader.lr.ph.split
  br label %for.cond2.preheader

for.cond2.preheader:                              ; preds = %for.cond2.preheader.preheader, %for.inc127.31
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.31, %for.inc127.31 ], [ %indvars.iv19.unr, %for.cond2.preheader.preheader ]
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph

for.body4.lr.ph:                                  ; preds = %for.cond2.preheader
  %28 = trunc i64 %indvars.iv19 to i32
  %mul = shl nsw i32 %28, 7
  %cmp5 = icmp eq i64 %indvars.iv19, 0
  %cmp6 = icmp eq i64 %indvars.iv19, %1
  %or.cond = or i1 %cmp5, %cmp6
  %add33 = or i32 %mul, 1
  %sub38 = add i32 %mul, -1
  %29 = trunc i64 %indvars.iv19 to i32
  %add51 = shl i32 %29, 7
  %30 = trunc i64 %indvars.iv19 to i32
  %add72 = shl i32 %30, 7
  %mul73 = add i32 %add72, 128
  %mul78 = add i32 %add72, -128
  %31 = trunc i64 %indvars.iv19 to i32
  %sub91 = shl i32 %31, 7
  %32 = sext i32 %mul to i64
  %33 = sext i32 %mul78 to i64
  %34 = sext i32 %mul73 to i64
  br label %for.body4

for.body4:                                        ; preds = %for.inc, %for.body4.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body4.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %35 = add nsw i64 %indvars.iv, %32
  %cmp8 = icmp eq i64 %indvars.iv, 0
  %or.cond1 = or i1 %or.cond, %cmp8
  %cmp10 = icmp eq i64 %indvars.iv, %0
  %or.cond2 = or i1 %cmp10, %or.cond1
  br i1 %or.cond2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body4
  %arrayidx = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %35
  store i32 0, i32* %arrayidx, align 4
  br label %for.inc

if.else:                                          ; preds = %for.body4
  %arrayidx12 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %35
  %36 = load float, float* %arrayidx12, align 4
  %conv = fpext float %36 to double
  %mul13 = fmul double %conv, 0x404CA5DC1A63C1F8
  %conv14 = fptrunc double %mul13 to float
  %cmp15 = fcmp olt float %conv14, 0.000000e+00
  %add18 = fadd float %conv14, 1.800000e+02
  %angle.0 = select i1 %cmp15, float %add18, float %conv14
  %cmp19 = fcmp oge float %angle.0, 0.000000e+00
  %cmp22 = fcmp olt float %angle.0, 2.250000e+01
  %or.cond3 = and i1 %cmp19, %cmp22
  br i1 %or.cond3, label %if.then31, label %lor.lhs.false24

lor.lhs.false24:                                  ; preds = %if.else
  %cmp26 = fcmp ult float %angle.0, 1.575000e+02
  %cmp29 = fcmp ugt float %angle.0, 1.800000e+02
  %or.cond4 = or i1 %cmp26, %cmp29
  br i1 %or.cond4, label %if.else42, label %if.then31

if.then31:                                        ; preds = %lor.lhs.false24, %if.else
  %37 = trunc i64 %indvars.iv to i32
  %add34 = add i32 %add33, %37
  %idxprom35 = sext i32 %add34 to i64
  %arrayidx36 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35
  %38 = load float, float* %arrayidx36, align 4
  %39 = trunc i64 %indvars.iv to i32
  %add39 = add i32 %sub38, %39
  %idxprom40 = sext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40
  %40 = load float, float* %arrayidx41, align 4
  br label %if.end106

if.else42:                                        ; preds = %lor.lhs.false24
  %cmp44 = fcmp oge float %angle.0, 2.250000e+01
  %cmp48 = fcmp olt float %angle.0, 6.750000e+01
  %or.cond5 = and i1 %cmp44, %cmp48
  br i1 %or.cond5, label %if.then50, label %if.else63

if.then50:                                        ; preds = %if.else42
  %41 = trunc i64 %indvars.iv to i32
  %sub53 = add i32 %41, %add51
  %add54 = add i32 %sub53, 127
  %idxprom55 = sext i32 %add54 to i64
  %arrayidx56 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55
  %42 = load float, float* %arrayidx56, align 4
  %add60 = add i32 %sub53, -127
  %idxprom61 = sext i32 %add60 to i64
  %arrayidx62 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61
  %43 = load float, float* %arrayidx62, align 4
  br label %if.end106

if.else63:                                        ; preds = %if.else42
  %cmp65 = fcmp oge float %angle.0, 6.750000e+01
  %cmp69 = fcmp olt float %angle.0, 1.125000e+02
  %or.cond6 = and i1 %cmp65, %cmp69
  br i1 %or.cond6, label %if.then71, label %if.else82

if.then71:                                        ; preds = %if.else63
  %44 = add nsw i64 %34, %indvars.iv
  %arrayidx76 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %44
  %45 = load float, float* %arrayidx76, align 4
  %46 = add nsw i64 %33, %indvars.iv
  %arrayidx81 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %46
  %47 = load float, float* %arrayidx81, align 4
  br label %if.end106

if.else82:                                        ; preds = %if.else63
  %cmp84 = fcmp oge float %angle.0, 1.125000e+02
  %cmp88 = fcmp olt float %angle.0, 1.575000e+02
  %or.cond7 = and i1 %cmp84, %cmp88
  br i1 %or.cond7, label %if.then90, label %if.end106

if.then90:                                        ; preds = %if.else82
  %48 = trunc i64 %indvars.iv to i32
  %sub93 = add i32 %48, %sub91
  %add94 = add i32 %sub93, -129
  %idxprom95 = sext i32 %add94 to i64
  %arrayidx96 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95
  %49 = load float, float* %arrayidx96, align 4
  %add100 = add i32 %sub93, 129
  %idxprom101 = sext i32 %add100 to i64
  %arrayidx102 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101
  %50 = load float, float* %arrayidx102, align 4
  br label %if.end106

if.end106:                                        ; preds = %if.then50, %if.then90, %if.else82, %if.then71, %if.then31
  %q.3 = phi float [ %38, %if.then31 ], [ %42, %if.then50 ], [ %45, %if.then71 ], [ %49, %if.then90 ], [ 2.550000e+02, %if.else82 ]
  %r.3 = phi float [ %40, %if.then31 ], [ %43, %if.then50 ], [ %47, %if.then71 ], [ %50, %if.then90 ], [ 2.550000e+02, %if.else82 ]
  %arrayidx108 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %35
  %51 = load float, float* %arrayidx108, align 4
  %cmp109 = fcmp ult float %51, %q.3
  %cmp114 = fcmp ult float %51, %r.3
  %or.cond8 = or i1 %cmp109, %cmp114
  br i1 %or.cond8, label %if.else122, label %if.then116

if.then116:                                       ; preds = %if.end106
  %conv119 = fptoui float %51 to i32
  %arrayidx121 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %35
  store i32 %conv119, i32* %arrayidx121, align 4
  br label %for.inc

if.else122:                                       ; preds = %if.end106
  %arrayidx124 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %35
  store i32 0, i32* %arrayidx124, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else122, %if.then116
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %img_width
  br i1 %exitcond, label %for.inc127, label %for.body4, !llvm.loop !1

for.inc127:                                       ; preds = %for.inc
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.1

for.end129.loopexit:                              ; preds = %for.inc127.31
  br label %for.end129

for.end129:                                       ; preds = %for.end129.loopexit, %for.cond2.preheader.lr.ph.split, %entry
  ret void

for.body4.lr.ph.1:                                ; preds = %for.inc127
  %52 = trunc i64 %indvars.iv.next20 to i32
  %mul.1 = shl nsw i32 %52, 7
  %cmp6.1 = icmp eq i64 %indvars.iv.next20, %1
  %add33.1 = or i32 %mul.1, 1
  %sub38.1 = add i32 %mul.1, -1
  %53 = trunc i64 %indvars.iv.next20 to i32
  %add51.1 = shl i32 %53, 7
  %54 = trunc i64 %indvars.iv.next20 to i32
  %add72.1 = shl i32 %54, 7
  %mul73.1 = add i32 %add72.1, 128
  %mul78.1 = add i32 %add72.1, -128
  %55 = trunc i64 %indvars.iv.next20 to i32
  %sub91.1 = shl i32 %55, 7
  %56 = sext i32 %mul.1 to i64
  %57 = sext i32 %mul78.1 to i64
  %58 = sext i32 %mul73.1 to i64
  br label %for.body4.1

for.body4.1:                                      ; preds = %for.inc.1, %for.body4.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body4.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc.1 ]
  %59 = add nsw i64 %indvars.iv.1, %56
  %cmp8.1 = icmp eq i64 %indvars.iv.1, 0
  %or.cond1.1 = or i1 %cmp6.1, %cmp8.1
  %cmp10.1 = icmp eq i64 %indvars.iv.1, %0
  %or.cond2.1 = or i1 %cmp10.1, %or.cond1.1
  br i1 %or.cond2.1, label %if.then.1, label %if.else.1

if.else.1:                                        ; preds = %for.body4.1
  %arrayidx12.1 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %59
  %60 = load float, float* %arrayidx12.1, align 4
  %conv.1 = fpext float %60 to double
  %mul13.1 = fmul double %conv.1, 0x404CA5DC1A63C1F8
  %conv14.1 = fptrunc double %mul13.1 to float
  %cmp15.1 = fcmp olt float %conv14.1, 0.000000e+00
  %add18.1 = fadd float %conv14.1, 1.800000e+02
  %angle.0.1 = select i1 %cmp15.1, float %add18.1, float %conv14.1
  %cmp19.1 = fcmp oge float %angle.0.1, 0.000000e+00
  %cmp22.1 = fcmp olt float %angle.0.1, 2.250000e+01
  %or.cond3.1 = and i1 %cmp19.1, %cmp22.1
  br i1 %or.cond3.1, label %if.then31.1, label %lor.lhs.false24.1

lor.lhs.false24.1:                                ; preds = %if.else.1
  %cmp26.1 = fcmp ult float %angle.0.1, 1.575000e+02
  %cmp29.1 = fcmp ugt float %angle.0.1, 1.800000e+02
  %or.cond4.1 = or i1 %cmp26.1, %cmp29.1
  br i1 %or.cond4.1, label %if.else42.1, label %if.then31.1

if.else42.1:                                      ; preds = %lor.lhs.false24.1
  %cmp44.1 = fcmp oge float %angle.0.1, 2.250000e+01
  %cmp48.1 = fcmp olt float %angle.0.1, 6.750000e+01
  %or.cond5.1 = and i1 %cmp44.1, %cmp48.1
  br i1 %or.cond5.1, label %if.then50.1, label %if.else63.1

if.else63.1:                                      ; preds = %if.else42.1
  %cmp65.1 = fcmp oge float %angle.0.1, 6.750000e+01
  %cmp69.1 = fcmp olt float %angle.0.1, 1.125000e+02
  %or.cond6.1 = and i1 %cmp65.1, %cmp69.1
  br i1 %or.cond6.1, label %if.then71.1, label %if.else82.1

if.else82.1:                                      ; preds = %if.else63.1
  %cmp84.1 = fcmp oge float %angle.0.1, 1.125000e+02
  %cmp88.1 = fcmp olt float %angle.0.1, 1.575000e+02
  %or.cond7.1 = and i1 %cmp84.1, %cmp88.1
  br i1 %or.cond7.1, label %if.then90.1, label %if.end106.1

if.then90.1:                                      ; preds = %if.else82.1
  %61 = trunc i64 %indvars.iv.1 to i32
  %sub93.1 = add i32 %61, %sub91.1
  %add94.1 = add i32 %sub93.1, -129
  %idxprom95.1 = sext i32 %add94.1 to i64
  %arrayidx96.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.1
  %62 = load float, float* %arrayidx96.1, align 4
  %add100.1 = add i32 %sub93.1, 129
  %idxprom101.1 = sext i32 %add100.1 to i64
  %arrayidx102.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.1
  %63 = load float, float* %arrayidx102.1, align 4
  br label %if.end106.1

if.then71.1:                                      ; preds = %if.else63.1
  %64 = add nsw i64 %58, %indvars.iv.1
  %arrayidx76.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %64
  %65 = load float, float* %arrayidx76.1, align 4
  %66 = add nsw i64 %57, %indvars.iv.1
  %arrayidx81.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %66
  %67 = load float, float* %arrayidx81.1, align 4
  br label %if.end106.1

if.then50.1:                                      ; preds = %if.else42.1
  %68 = trunc i64 %indvars.iv.1 to i32
  %sub53.1 = add i32 %68, %add51.1
  %add54.1 = add i32 %sub53.1, 127
  %idxprom55.1 = sext i32 %add54.1 to i64
  %arrayidx56.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.1
  %69 = load float, float* %arrayidx56.1, align 4
  %add60.1 = add i32 %sub53.1, -127
  %idxprom61.1 = sext i32 %add60.1 to i64
  %arrayidx62.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.1
  %70 = load float, float* %arrayidx62.1, align 4
  br label %if.end106.1

if.then31.1:                                      ; preds = %lor.lhs.false24.1, %if.else.1
  %71 = trunc i64 %indvars.iv.1 to i32
  %add34.1 = add i32 %add33.1, %71
  %idxprom35.1 = sext i32 %add34.1 to i64
  %arrayidx36.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.1
  %72 = load float, float* %arrayidx36.1, align 4
  %73 = trunc i64 %indvars.iv.1 to i32
  %add39.1 = add i32 %sub38.1, %73
  %idxprom40.1 = sext i32 %add39.1 to i64
  %arrayidx41.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.1
  %74 = load float, float* %arrayidx41.1, align 4
  br label %if.end106.1

if.end106.1:                                      ; preds = %if.then31.1, %if.then50.1, %if.then71.1, %if.then90.1, %if.else82.1
  %q.3.1 = phi float [ %72, %if.then31.1 ], [ %69, %if.then50.1 ], [ %65, %if.then71.1 ], [ %62, %if.then90.1 ], [ 2.550000e+02, %if.else82.1 ]
  %r.3.1 = phi float [ %74, %if.then31.1 ], [ %70, %if.then50.1 ], [ %67, %if.then71.1 ], [ %63, %if.then90.1 ], [ 2.550000e+02, %if.else82.1 ]
  %arrayidx108.1 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %59
  %75 = load float, float* %arrayidx108.1, align 4
  %cmp109.1 = fcmp ult float %75, %q.3.1
  %cmp114.1 = fcmp ult float %75, %r.3.1
  %or.cond8.1 = or i1 %cmp109.1, %cmp114.1
  br i1 %or.cond8.1, label %if.else122.1, label %if.then116.1

if.then116.1:                                     ; preds = %if.end106.1
  %conv119.1 = fptoui float %75 to i32
  %arrayidx121.1 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %59
  store i32 %conv119.1, i32* %arrayidx121.1, align 4
  br label %for.inc.1

if.else122.1:                                     ; preds = %if.end106.1
  %arrayidx124.1 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %59
  store i32 0, i32* %arrayidx124.1, align 4
  br label %for.inc.1

if.then.1:                                        ; preds = %for.body4.1
  %arrayidx.1 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %59
  store i32 0, i32* %arrayidx.1, align 4
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.then.1, %if.else122.1, %if.then116.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %img_width
  br i1 %exitcond.1, label %for.inc127.1, label %for.body4.1, !llvm.loop !1

for.inc127.1:                                     ; preds = %for.inc.1
  %indvars.iv.next20.1 = add nsw i64 %indvars.iv19, 2
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.2

for.body4.lr.ph.2:                                ; preds = %for.inc127.1
  %76 = trunc i64 %indvars.iv.next20.1 to i32
  %mul.2 = shl nsw i32 %76, 7
  %cmp6.2 = icmp eq i64 %indvars.iv.next20.1, %1
  %add33.2 = or i32 %mul.2, 1
  %sub38.2 = add i32 %mul.2, -1
  %77 = trunc i64 %indvars.iv.next20.1 to i32
  %add51.2 = shl i32 %77, 7
  %78 = trunc i64 %indvars.iv.next20.1 to i32
  %add72.2 = shl i32 %78, 7
  %mul73.2 = add i32 %add72.2, 128
  %mul78.2 = add i32 %add72.2, -128
  %79 = trunc i64 %indvars.iv.next20.1 to i32
  %sub91.2 = shl i32 %79, 7
  %80 = sext i32 %mul.2 to i64
  %81 = sext i32 %mul78.2 to i64
  %82 = sext i32 %mul73.2 to i64
  br label %for.body4.2

for.body4.2:                                      ; preds = %for.inc.2, %for.body4.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body4.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc.2 ]
  %83 = add nsw i64 %indvars.iv.2, %80
  %cmp8.2 = icmp eq i64 %indvars.iv.2, 0
  %or.cond1.2 = or i1 %cmp6.2, %cmp8.2
  %cmp10.2 = icmp eq i64 %indvars.iv.2, %0
  %or.cond2.2 = or i1 %cmp10.2, %or.cond1.2
  br i1 %or.cond2.2, label %if.then.2, label %if.else.2

if.else.2:                                        ; preds = %for.body4.2
  %arrayidx12.2 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %83
  %84 = load float, float* %arrayidx12.2, align 4
  %conv.2 = fpext float %84 to double
  %mul13.2 = fmul double %conv.2, 0x404CA5DC1A63C1F8
  %conv14.2 = fptrunc double %mul13.2 to float
  %cmp15.2 = fcmp olt float %conv14.2, 0.000000e+00
  %add18.2 = fadd float %conv14.2, 1.800000e+02
  %angle.0.2 = select i1 %cmp15.2, float %add18.2, float %conv14.2
  %cmp19.2 = fcmp oge float %angle.0.2, 0.000000e+00
  %cmp22.2 = fcmp olt float %angle.0.2, 2.250000e+01
  %or.cond3.2 = and i1 %cmp19.2, %cmp22.2
  br i1 %or.cond3.2, label %if.then31.2, label %lor.lhs.false24.2

lor.lhs.false24.2:                                ; preds = %if.else.2
  %cmp26.2 = fcmp ult float %angle.0.2, 1.575000e+02
  %cmp29.2 = fcmp ugt float %angle.0.2, 1.800000e+02
  %or.cond4.2 = or i1 %cmp26.2, %cmp29.2
  br i1 %or.cond4.2, label %if.else42.2, label %if.then31.2

if.else42.2:                                      ; preds = %lor.lhs.false24.2
  %cmp44.2 = fcmp oge float %angle.0.2, 2.250000e+01
  %cmp48.2 = fcmp olt float %angle.0.2, 6.750000e+01
  %or.cond5.2 = and i1 %cmp44.2, %cmp48.2
  br i1 %or.cond5.2, label %if.then50.2, label %if.else63.2

if.else63.2:                                      ; preds = %if.else42.2
  %cmp65.2 = fcmp oge float %angle.0.2, 6.750000e+01
  %cmp69.2 = fcmp olt float %angle.0.2, 1.125000e+02
  %or.cond6.2 = and i1 %cmp65.2, %cmp69.2
  br i1 %or.cond6.2, label %if.then71.2, label %if.else82.2

if.else82.2:                                      ; preds = %if.else63.2
  %cmp84.2 = fcmp oge float %angle.0.2, 1.125000e+02
  %cmp88.2 = fcmp olt float %angle.0.2, 1.575000e+02
  %or.cond7.2 = and i1 %cmp84.2, %cmp88.2
  br i1 %or.cond7.2, label %if.then90.2, label %if.end106.2

if.then90.2:                                      ; preds = %if.else82.2
  %85 = trunc i64 %indvars.iv.2 to i32
  %sub93.2 = add i32 %85, %sub91.2
  %add94.2 = add i32 %sub93.2, -129
  %idxprom95.2 = sext i32 %add94.2 to i64
  %arrayidx96.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.2
  %86 = load float, float* %arrayidx96.2, align 4
  %add100.2 = add i32 %sub93.2, 129
  %idxprom101.2 = sext i32 %add100.2 to i64
  %arrayidx102.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.2
  %87 = load float, float* %arrayidx102.2, align 4
  br label %if.end106.2

if.then71.2:                                      ; preds = %if.else63.2
  %88 = add nsw i64 %82, %indvars.iv.2
  %arrayidx76.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %88
  %89 = load float, float* %arrayidx76.2, align 4
  %90 = add nsw i64 %81, %indvars.iv.2
  %arrayidx81.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %90
  %91 = load float, float* %arrayidx81.2, align 4
  br label %if.end106.2

if.then50.2:                                      ; preds = %if.else42.2
  %92 = trunc i64 %indvars.iv.2 to i32
  %sub53.2 = add i32 %92, %add51.2
  %add54.2 = add i32 %sub53.2, 127
  %idxprom55.2 = sext i32 %add54.2 to i64
  %arrayidx56.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.2
  %93 = load float, float* %arrayidx56.2, align 4
  %add60.2 = add i32 %sub53.2, -127
  %idxprom61.2 = sext i32 %add60.2 to i64
  %arrayidx62.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.2
  %94 = load float, float* %arrayidx62.2, align 4
  br label %if.end106.2

if.then31.2:                                      ; preds = %lor.lhs.false24.2, %if.else.2
  %95 = trunc i64 %indvars.iv.2 to i32
  %add34.2 = add i32 %add33.2, %95
  %idxprom35.2 = sext i32 %add34.2 to i64
  %arrayidx36.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.2
  %96 = load float, float* %arrayidx36.2, align 4
  %97 = trunc i64 %indvars.iv.2 to i32
  %add39.2 = add i32 %sub38.2, %97
  %idxprom40.2 = sext i32 %add39.2 to i64
  %arrayidx41.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.2
  %98 = load float, float* %arrayidx41.2, align 4
  br label %if.end106.2

if.end106.2:                                      ; preds = %if.then31.2, %if.then50.2, %if.then71.2, %if.then90.2, %if.else82.2
  %q.3.2 = phi float [ %96, %if.then31.2 ], [ %93, %if.then50.2 ], [ %89, %if.then71.2 ], [ %86, %if.then90.2 ], [ 2.550000e+02, %if.else82.2 ]
  %r.3.2 = phi float [ %98, %if.then31.2 ], [ %94, %if.then50.2 ], [ %91, %if.then71.2 ], [ %87, %if.then90.2 ], [ 2.550000e+02, %if.else82.2 ]
  %arrayidx108.2 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %83
  %99 = load float, float* %arrayidx108.2, align 4
  %cmp109.2 = fcmp ult float %99, %q.3.2
  %cmp114.2 = fcmp ult float %99, %r.3.2
  %or.cond8.2 = or i1 %cmp109.2, %cmp114.2
  br i1 %or.cond8.2, label %if.else122.2, label %if.then116.2

if.then116.2:                                     ; preds = %if.end106.2
  %conv119.2 = fptoui float %99 to i32
  %arrayidx121.2 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %83
  store i32 %conv119.2, i32* %arrayidx121.2, align 4
  br label %for.inc.2

if.else122.2:                                     ; preds = %if.end106.2
  %arrayidx124.2 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %83
  store i32 0, i32* %arrayidx124.2, align 4
  br label %for.inc.2

if.then.2:                                        ; preds = %for.body4.2
  %arrayidx.2 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %83
  store i32 0, i32* %arrayidx.2, align 4
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.then.2, %if.else122.2, %if.then116.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %img_width
  br i1 %exitcond.2, label %for.inc127.2, label %for.body4.2, !llvm.loop !1

for.inc127.2:                                     ; preds = %for.inc.2
  %indvars.iv.next20.2 = add nsw i64 %indvars.iv19, 3
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.3

for.body4.lr.ph.3:                                ; preds = %for.inc127.2
  %100 = trunc i64 %indvars.iv.next20.2 to i32
  %mul.3 = shl nsw i32 %100, 7
  %cmp6.3 = icmp eq i64 %indvars.iv.next20.2, %1
  %add33.3 = or i32 %mul.3, 1
  %sub38.3 = add i32 %mul.3, -1
  %101 = trunc i64 %indvars.iv.next20.2 to i32
  %add51.3 = shl i32 %101, 7
  %102 = trunc i64 %indvars.iv.next20.2 to i32
  %add72.3 = shl i32 %102, 7
  %mul73.3 = add i32 %add72.3, 128
  %mul78.3 = add i32 %add72.3, -128
  %103 = trunc i64 %indvars.iv.next20.2 to i32
  %sub91.3 = shl i32 %103, 7
  %104 = sext i32 %mul.3 to i64
  %105 = sext i32 %mul78.3 to i64
  %106 = sext i32 %mul73.3 to i64
  br label %for.body4.3

for.body4.3:                                      ; preds = %for.inc.3, %for.body4.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body4.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc.3 ]
  %107 = add nsw i64 %indvars.iv.3, %104
  %cmp8.3 = icmp eq i64 %indvars.iv.3, 0
  %or.cond1.3 = or i1 %cmp6.3, %cmp8.3
  %cmp10.3 = icmp eq i64 %indvars.iv.3, %0
  %or.cond2.3 = or i1 %cmp10.3, %or.cond1.3
  br i1 %or.cond2.3, label %if.then.3, label %if.else.3

if.else.3:                                        ; preds = %for.body4.3
  %arrayidx12.3 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %107
  %108 = load float, float* %arrayidx12.3, align 4
  %conv.3 = fpext float %108 to double
  %mul13.3 = fmul double %conv.3, 0x404CA5DC1A63C1F8
  %conv14.3 = fptrunc double %mul13.3 to float
  %cmp15.3 = fcmp olt float %conv14.3, 0.000000e+00
  %add18.3 = fadd float %conv14.3, 1.800000e+02
  %angle.0.3 = select i1 %cmp15.3, float %add18.3, float %conv14.3
  %cmp19.3 = fcmp oge float %angle.0.3, 0.000000e+00
  %cmp22.3 = fcmp olt float %angle.0.3, 2.250000e+01
  %or.cond3.3 = and i1 %cmp19.3, %cmp22.3
  br i1 %or.cond3.3, label %if.then31.3, label %lor.lhs.false24.3

lor.lhs.false24.3:                                ; preds = %if.else.3
  %cmp26.3 = fcmp ult float %angle.0.3, 1.575000e+02
  %cmp29.3 = fcmp ugt float %angle.0.3, 1.800000e+02
  %or.cond4.3 = or i1 %cmp26.3, %cmp29.3
  br i1 %or.cond4.3, label %if.else42.3, label %if.then31.3

if.else42.3:                                      ; preds = %lor.lhs.false24.3
  %cmp44.3 = fcmp oge float %angle.0.3, 2.250000e+01
  %cmp48.3 = fcmp olt float %angle.0.3, 6.750000e+01
  %or.cond5.3 = and i1 %cmp44.3, %cmp48.3
  br i1 %or.cond5.3, label %if.then50.3, label %if.else63.3

if.else63.3:                                      ; preds = %if.else42.3
  %cmp65.3 = fcmp oge float %angle.0.3, 6.750000e+01
  %cmp69.3 = fcmp olt float %angle.0.3, 1.125000e+02
  %or.cond6.3 = and i1 %cmp65.3, %cmp69.3
  br i1 %or.cond6.3, label %if.then71.3, label %if.else82.3

if.else82.3:                                      ; preds = %if.else63.3
  %cmp84.3 = fcmp oge float %angle.0.3, 1.125000e+02
  %cmp88.3 = fcmp olt float %angle.0.3, 1.575000e+02
  %or.cond7.3 = and i1 %cmp84.3, %cmp88.3
  br i1 %or.cond7.3, label %if.then90.3, label %if.end106.3

if.then90.3:                                      ; preds = %if.else82.3
  %109 = trunc i64 %indvars.iv.3 to i32
  %sub93.3 = add i32 %109, %sub91.3
  %add94.3 = add i32 %sub93.3, -129
  %idxprom95.3 = sext i32 %add94.3 to i64
  %arrayidx96.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.3
  %110 = load float, float* %arrayidx96.3, align 4
  %add100.3 = add i32 %sub93.3, 129
  %idxprom101.3 = sext i32 %add100.3 to i64
  %arrayidx102.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.3
  %111 = load float, float* %arrayidx102.3, align 4
  br label %if.end106.3

if.then71.3:                                      ; preds = %if.else63.3
  %112 = add nsw i64 %106, %indvars.iv.3
  %arrayidx76.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %112
  %113 = load float, float* %arrayidx76.3, align 4
  %114 = add nsw i64 %105, %indvars.iv.3
  %arrayidx81.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %114
  %115 = load float, float* %arrayidx81.3, align 4
  br label %if.end106.3

if.then50.3:                                      ; preds = %if.else42.3
  %116 = trunc i64 %indvars.iv.3 to i32
  %sub53.3 = add i32 %116, %add51.3
  %add54.3 = add i32 %sub53.3, 127
  %idxprom55.3 = sext i32 %add54.3 to i64
  %arrayidx56.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.3
  %117 = load float, float* %arrayidx56.3, align 4
  %add60.3 = add i32 %sub53.3, -127
  %idxprom61.3 = sext i32 %add60.3 to i64
  %arrayidx62.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.3
  %118 = load float, float* %arrayidx62.3, align 4
  br label %if.end106.3

if.then31.3:                                      ; preds = %lor.lhs.false24.3, %if.else.3
  %119 = trunc i64 %indvars.iv.3 to i32
  %add34.3 = add i32 %add33.3, %119
  %idxprom35.3 = sext i32 %add34.3 to i64
  %arrayidx36.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.3
  %120 = load float, float* %arrayidx36.3, align 4
  %121 = trunc i64 %indvars.iv.3 to i32
  %add39.3 = add i32 %sub38.3, %121
  %idxprom40.3 = sext i32 %add39.3 to i64
  %arrayidx41.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.3
  %122 = load float, float* %arrayidx41.3, align 4
  br label %if.end106.3

if.end106.3:                                      ; preds = %if.then31.3, %if.then50.3, %if.then71.3, %if.then90.3, %if.else82.3
  %q.3.3 = phi float [ %120, %if.then31.3 ], [ %117, %if.then50.3 ], [ %113, %if.then71.3 ], [ %110, %if.then90.3 ], [ 2.550000e+02, %if.else82.3 ]
  %r.3.3 = phi float [ %122, %if.then31.3 ], [ %118, %if.then50.3 ], [ %115, %if.then71.3 ], [ %111, %if.then90.3 ], [ 2.550000e+02, %if.else82.3 ]
  %arrayidx108.3 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %107
  %123 = load float, float* %arrayidx108.3, align 4
  %cmp109.3 = fcmp ult float %123, %q.3.3
  %cmp114.3 = fcmp ult float %123, %r.3.3
  %or.cond8.3 = or i1 %cmp109.3, %cmp114.3
  br i1 %or.cond8.3, label %if.else122.3, label %if.then116.3

if.then116.3:                                     ; preds = %if.end106.3
  %conv119.3 = fptoui float %123 to i32
  %arrayidx121.3 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %107
  store i32 %conv119.3, i32* %arrayidx121.3, align 4
  br label %for.inc.3

if.else122.3:                                     ; preds = %if.end106.3
  %arrayidx124.3 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %107
  store i32 0, i32* %arrayidx124.3, align 4
  br label %for.inc.3

if.then.3:                                        ; preds = %for.body4.3
  %arrayidx.3 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %107
  store i32 0, i32* %arrayidx.3, align 4
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.then.3, %if.else122.3, %if.then116.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %img_width
  br i1 %exitcond.3, label %for.inc127.3, label %for.body4.3, !llvm.loop !1

for.inc127.3:                                     ; preds = %for.inc.3
  %indvars.iv.next20.3 = add nsw i64 %indvars.iv19, 4
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.4

for.body4.lr.ph.4:                                ; preds = %for.inc127.3
  %124 = trunc i64 %indvars.iv.next20.3 to i32
  %mul.4 = shl nsw i32 %124, 7
  %cmp6.4 = icmp eq i64 %indvars.iv.next20.3, %1
  %add33.4 = or i32 %mul.4, 1
  %sub38.4 = add i32 %mul.4, -1
  %125 = trunc i64 %indvars.iv.next20.3 to i32
  %add51.4 = shl i32 %125, 7
  %126 = trunc i64 %indvars.iv.next20.3 to i32
  %add72.4 = shl i32 %126, 7
  %mul73.4 = add i32 %add72.4, 128
  %mul78.4 = add i32 %add72.4, -128
  %127 = trunc i64 %indvars.iv.next20.3 to i32
  %sub91.4 = shl i32 %127, 7
  %128 = sext i32 %mul.4 to i64
  %129 = sext i32 %mul78.4 to i64
  %130 = sext i32 %mul73.4 to i64
  br label %for.body4.4

for.body4.4:                                      ; preds = %for.inc.4, %for.body4.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body4.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc.4 ]
  %131 = add nsw i64 %indvars.iv.4, %128
  %cmp8.4 = icmp eq i64 %indvars.iv.4, 0
  %or.cond1.4 = or i1 %cmp6.4, %cmp8.4
  %cmp10.4 = icmp eq i64 %indvars.iv.4, %0
  %or.cond2.4 = or i1 %cmp10.4, %or.cond1.4
  br i1 %or.cond2.4, label %if.then.4, label %if.else.4

if.else.4:                                        ; preds = %for.body4.4
  %arrayidx12.4 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %131
  %132 = load float, float* %arrayidx12.4, align 4
  %conv.4 = fpext float %132 to double
  %mul13.4 = fmul double %conv.4, 0x404CA5DC1A63C1F8
  %conv14.4 = fptrunc double %mul13.4 to float
  %cmp15.4 = fcmp olt float %conv14.4, 0.000000e+00
  %add18.4 = fadd float %conv14.4, 1.800000e+02
  %angle.0.4 = select i1 %cmp15.4, float %add18.4, float %conv14.4
  %cmp19.4 = fcmp oge float %angle.0.4, 0.000000e+00
  %cmp22.4 = fcmp olt float %angle.0.4, 2.250000e+01
  %or.cond3.4 = and i1 %cmp19.4, %cmp22.4
  br i1 %or.cond3.4, label %if.then31.4, label %lor.lhs.false24.4

lor.lhs.false24.4:                                ; preds = %if.else.4
  %cmp26.4 = fcmp ult float %angle.0.4, 1.575000e+02
  %cmp29.4 = fcmp ugt float %angle.0.4, 1.800000e+02
  %or.cond4.4 = or i1 %cmp26.4, %cmp29.4
  br i1 %or.cond4.4, label %if.else42.4, label %if.then31.4

if.else42.4:                                      ; preds = %lor.lhs.false24.4
  %cmp44.4 = fcmp oge float %angle.0.4, 2.250000e+01
  %cmp48.4 = fcmp olt float %angle.0.4, 6.750000e+01
  %or.cond5.4 = and i1 %cmp44.4, %cmp48.4
  br i1 %or.cond5.4, label %if.then50.4, label %if.else63.4

if.else63.4:                                      ; preds = %if.else42.4
  %cmp65.4 = fcmp oge float %angle.0.4, 6.750000e+01
  %cmp69.4 = fcmp olt float %angle.0.4, 1.125000e+02
  %or.cond6.4 = and i1 %cmp65.4, %cmp69.4
  br i1 %or.cond6.4, label %if.then71.4, label %if.else82.4

if.else82.4:                                      ; preds = %if.else63.4
  %cmp84.4 = fcmp oge float %angle.0.4, 1.125000e+02
  %cmp88.4 = fcmp olt float %angle.0.4, 1.575000e+02
  %or.cond7.4 = and i1 %cmp84.4, %cmp88.4
  br i1 %or.cond7.4, label %if.then90.4, label %if.end106.4

if.then90.4:                                      ; preds = %if.else82.4
  %133 = trunc i64 %indvars.iv.4 to i32
  %sub93.4 = add i32 %133, %sub91.4
  %add94.4 = add i32 %sub93.4, -129
  %idxprom95.4 = sext i32 %add94.4 to i64
  %arrayidx96.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.4
  %134 = load float, float* %arrayidx96.4, align 4
  %add100.4 = add i32 %sub93.4, 129
  %idxprom101.4 = sext i32 %add100.4 to i64
  %arrayidx102.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.4
  %135 = load float, float* %arrayidx102.4, align 4
  br label %if.end106.4

if.then71.4:                                      ; preds = %if.else63.4
  %136 = add nsw i64 %130, %indvars.iv.4
  %arrayidx76.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %136
  %137 = load float, float* %arrayidx76.4, align 4
  %138 = add nsw i64 %129, %indvars.iv.4
  %arrayidx81.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %138
  %139 = load float, float* %arrayidx81.4, align 4
  br label %if.end106.4

if.then50.4:                                      ; preds = %if.else42.4
  %140 = trunc i64 %indvars.iv.4 to i32
  %sub53.4 = add i32 %140, %add51.4
  %add54.4 = add i32 %sub53.4, 127
  %idxprom55.4 = sext i32 %add54.4 to i64
  %arrayidx56.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.4
  %141 = load float, float* %arrayidx56.4, align 4
  %add60.4 = add i32 %sub53.4, -127
  %idxprom61.4 = sext i32 %add60.4 to i64
  %arrayidx62.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.4
  %142 = load float, float* %arrayidx62.4, align 4
  br label %if.end106.4

if.then31.4:                                      ; preds = %lor.lhs.false24.4, %if.else.4
  %143 = trunc i64 %indvars.iv.4 to i32
  %add34.4 = add i32 %add33.4, %143
  %idxprom35.4 = sext i32 %add34.4 to i64
  %arrayidx36.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.4
  %144 = load float, float* %arrayidx36.4, align 4
  %145 = trunc i64 %indvars.iv.4 to i32
  %add39.4 = add i32 %sub38.4, %145
  %idxprom40.4 = sext i32 %add39.4 to i64
  %arrayidx41.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.4
  %146 = load float, float* %arrayidx41.4, align 4
  br label %if.end106.4

if.end106.4:                                      ; preds = %if.then31.4, %if.then50.4, %if.then71.4, %if.then90.4, %if.else82.4
  %q.3.4 = phi float [ %144, %if.then31.4 ], [ %141, %if.then50.4 ], [ %137, %if.then71.4 ], [ %134, %if.then90.4 ], [ 2.550000e+02, %if.else82.4 ]
  %r.3.4 = phi float [ %146, %if.then31.4 ], [ %142, %if.then50.4 ], [ %139, %if.then71.4 ], [ %135, %if.then90.4 ], [ 2.550000e+02, %if.else82.4 ]
  %arrayidx108.4 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %131
  %147 = load float, float* %arrayidx108.4, align 4
  %cmp109.4 = fcmp ult float %147, %q.3.4
  %cmp114.4 = fcmp ult float %147, %r.3.4
  %or.cond8.4 = or i1 %cmp109.4, %cmp114.4
  br i1 %or.cond8.4, label %if.else122.4, label %if.then116.4

if.then116.4:                                     ; preds = %if.end106.4
  %conv119.4 = fptoui float %147 to i32
  %arrayidx121.4 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %131
  store i32 %conv119.4, i32* %arrayidx121.4, align 4
  br label %for.inc.4

if.else122.4:                                     ; preds = %if.end106.4
  %arrayidx124.4 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %131
  store i32 0, i32* %arrayidx124.4, align 4
  br label %for.inc.4

if.then.4:                                        ; preds = %for.body4.4
  %arrayidx.4 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %131
  store i32 0, i32* %arrayidx.4, align 4
  br label %for.inc.4

for.inc.4:                                        ; preds = %if.then.4, %if.else122.4, %if.then116.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %img_width
  br i1 %exitcond.4, label %for.inc127.4, label %for.body4.4, !llvm.loop !1

for.inc127.4:                                     ; preds = %for.inc.4
  %indvars.iv.next20.4 = add nsw i64 %indvars.iv19, 5
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.5

for.body4.lr.ph.5:                                ; preds = %for.inc127.4
  %148 = trunc i64 %indvars.iv.next20.4 to i32
  %mul.5 = shl nsw i32 %148, 7
  %cmp6.5 = icmp eq i64 %indvars.iv.next20.4, %1
  %add33.5 = or i32 %mul.5, 1
  %sub38.5 = add i32 %mul.5, -1
  %149 = trunc i64 %indvars.iv.next20.4 to i32
  %add51.5 = shl i32 %149, 7
  %150 = trunc i64 %indvars.iv.next20.4 to i32
  %add72.5 = shl i32 %150, 7
  %mul73.5 = add i32 %add72.5, 128
  %mul78.5 = add i32 %add72.5, -128
  %151 = trunc i64 %indvars.iv.next20.4 to i32
  %sub91.5 = shl i32 %151, 7
  %152 = sext i32 %mul.5 to i64
  %153 = sext i32 %mul78.5 to i64
  %154 = sext i32 %mul73.5 to i64
  br label %for.body4.5

for.body4.5:                                      ; preds = %for.inc.5, %for.body4.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body4.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc.5 ]
  %155 = add nsw i64 %indvars.iv.5, %152
  %cmp8.5 = icmp eq i64 %indvars.iv.5, 0
  %or.cond1.5 = or i1 %cmp6.5, %cmp8.5
  %cmp10.5 = icmp eq i64 %indvars.iv.5, %0
  %or.cond2.5 = or i1 %cmp10.5, %or.cond1.5
  br i1 %or.cond2.5, label %if.then.5, label %if.else.5

if.else.5:                                        ; preds = %for.body4.5
  %arrayidx12.5 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %155
  %156 = load float, float* %arrayidx12.5, align 4
  %conv.5 = fpext float %156 to double
  %mul13.5 = fmul double %conv.5, 0x404CA5DC1A63C1F8
  %conv14.5 = fptrunc double %mul13.5 to float
  %cmp15.5 = fcmp olt float %conv14.5, 0.000000e+00
  %add18.5 = fadd float %conv14.5, 1.800000e+02
  %angle.0.5 = select i1 %cmp15.5, float %add18.5, float %conv14.5
  %cmp19.5 = fcmp oge float %angle.0.5, 0.000000e+00
  %cmp22.5 = fcmp olt float %angle.0.5, 2.250000e+01
  %or.cond3.5 = and i1 %cmp19.5, %cmp22.5
  br i1 %or.cond3.5, label %if.then31.5, label %lor.lhs.false24.5

lor.lhs.false24.5:                                ; preds = %if.else.5
  %cmp26.5 = fcmp ult float %angle.0.5, 1.575000e+02
  %cmp29.5 = fcmp ugt float %angle.0.5, 1.800000e+02
  %or.cond4.5 = or i1 %cmp26.5, %cmp29.5
  br i1 %or.cond4.5, label %if.else42.5, label %if.then31.5

if.else42.5:                                      ; preds = %lor.lhs.false24.5
  %cmp44.5 = fcmp oge float %angle.0.5, 2.250000e+01
  %cmp48.5 = fcmp olt float %angle.0.5, 6.750000e+01
  %or.cond5.5 = and i1 %cmp44.5, %cmp48.5
  br i1 %or.cond5.5, label %if.then50.5, label %if.else63.5

if.else63.5:                                      ; preds = %if.else42.5
  %cmp65.5 = fcmp oge float %angle.0.5, 6.750000e+01
  %cmp69.5 = fcmp olt float %angle.0.5, 1.125000e+02
  %or.cond6.5 = and i1 %cmp65.5, %cmp69.5
  br i1 %or.cond6.5, label %if.then71.5, label %if.else82.5

if.else82.5:                                      ; preds = %if.else63.5
  %cmp84.5 = fcmp oge float %angle.0.5, 1.125000e+02
  %cmp88.5 = fcmp olt float %angle.0.5, 1.575000e+02
  %or.cond7.5 = and i1 %cmp84.5, %cmp88.5
  br i1 %or.cond7.5, label %if.then90.5, label %if.end106.5

if.then90.5:                                      ; preds = %if.else82.5
  %157 = trunc i64 %indvars.iv.5 to i32
  %sub93.5 = add i32 %157, %sub91.5
  %add94.5 = add i32 %sub93.5, -129
  %idxprom95.5 = sext i32 %add94.5 to i64
  %arrayidx96.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.5
  %158 = load float, float* %arrayidx96.5, align 4
  %add100.5 = add i32 %sub93.5, 129
  %idxprom101.5 = sext i32 %add100.5 to i64
  %arrayidx102.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.5
  %159 = load float, float* %arrayidx102.5, align 4
  br label %if.end106.5

if.then71.5:                                      ; preds = %if.else63.5
  %160 = add nsw i64 %154, %indvars.iv.5
  %arrayidx76.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %160
  %161 = load float, float* %arrayidx76.5, align 4
  %162 = add nsw i64 %153, %indvars.iv.5
  %arrayidx81.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %162
  %163 = load float, float* %arrayidx81.5, align 4
  br label %if.end106.5

if.then50.5:                                      ; preds = %if.else42.5
  %164 = trunc i64 %indvars.iv.5 to i32
  %sub53.5 = add i32 %164, %add51.5
  %add54.5 = add i32 %sub53.5, 127
  %idxprom55.5 = sext i32 %add54.5 to i64
  %arrayidx56.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.5
  %165 = load float, float* %arrayidx56.5, align 4
  %add60.5 = add i32 %sub53.5, -127
  %idxprom61.5 = sext i32 %add60.5 to i64
  %arrayidx62.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.5
  %166 = load float, float* %arrayidx62.5, align 4
  br label %if.end106.5

if.then31.5:                                      ; preds = %lor.lhs.false24.5, %if.else.5
  %167 = trunc i64 %indvars.iv.5 to i32
  %add34.5 = add i32 %add33.5, %167
  %idxprom35.5 = sext i32 %add34.5 to i64
  %arrayidx36.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.5
  %168 = load float, float* %arrayidx36.5, align 4
  %169 = trunc i64 %indvars.iv.5 to i32
  %add39.5 = add i32 %sub38.5, %169
  %idxprom40.5 = sext i32 %add39.5 to i64
  %arrayidx41.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.5
  %170 = load float, float* %arrayidx41.5, align 4
  br label %if.end106.5

if.end106.5:                                      ; preds = %if.then31.5, %if.then50.5, %if.then71.5, %if.then90.5, %if.else82.5
  %q.3.5 = phi float [ %168, %if.then31.5 ], [ %165, %if.then50.5 ], [ %161, %if.then71.5 ], [ %158, %if.then90.5 ], [ 2.550000e+02, %if.else82.5 ]
  %r.3.5 = phi float [ %170, %if.then31.5 ], [ %166, %if.then50.5 ], [ %163, %if.then71.5 ], [ %159, %if.then90.5 ], [ 2.550000e+02, %if.else82.5 ]
  %arrayidx108.5 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %155
  %171 = load float, float* %arrayidx108.5, align 4
  %cmp109.5 = fcmp ult float %171, %q.3.5
  %cmp114.5 = fcmp ult float %171, %r.3.5
  %or.cond8.5 = or i1 %cmp109.5, %cmp114.5
  br i1 %or.cond8.5, label %if.else122.5, label %if.then116.5

if.then116.5:                                     ; preds = %if.end106.5
  %conv119.5 = fptoui float %171 to i32
  %arrayidx121.5 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %155
  store i32 %conv119.5, i32* %arrayidx121.5, align 4
  br label %for.inc.5

if.else122.5:                                     ; preds = %if.end106.5
  %arrayidx124.5 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %155
  store i32 0, i32* %arrayidx124.5, align 4
  br label %for.inc.5

if.then.5:                                        ; preds = %for.body4.5
  %arrayidx.5 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %155
  store i32 0, i32* %arrayidx.5, align 4
  br label %for.inc.5

for.inc.5:                                        ; preds = %if.then.5, %if.else122.5, %if.then116.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %img_width
  br i1 %exitcond.5, label %for.inc127.5, label %for.body4.5, !llvm.loop !1

for.inc127.5:                                     ; preds = %for.inc.5
  %indvars.iv.next20.5 = add nsw i64 %indvars.iv19, 6
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.6

for.body4.lr.ph.6:                                ; preds = %for.inc127.5
  %172 = trunc i64 %indvars.iv.next20.5 to i32
  %mul.6 = shl nsw i32 %172, 7
  %cmp6.6 = icmp eq i64 %indvars.iv.next20.5, %1
  %add33.6 = or i32 %mul.6, 1
  %sub38.6 = add i32 %mul.6, -1
  %173 = trunc i64 %indvars.iv.next20.5 to i32
  %add51.6 = shl i32 %173, 7
  %174 = trunc i64 %indvars.iv.next20.5 to i32
  %add72.6 = shl i32 %174, 7
  %mul73.6 = add i32 %add72.6, 128
  %mul78.6 = add i32 %add72.6, -128
  %175 = trunc i64 %indvars.iv.next20.5 to i32
  %sub91.6 = shl i32 %175, 7
  %176 = sext i32 %mul.6 to i64
  %177 = sext i32 %mul78.6 to i64
  %178 = sext i32 %mul73.6 to i64
  br label %for.body4.6

for.body4.6:                                      ; preds = %for.inc.6, %for.body4.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body4.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc.6 ]
  %179 = add nsw i64 %indvars.iv.6, %176
  %cmp8.6 = icmp eq i64 %indvars.iv.6, 0
  %or.cond1.6 = or i1 %cmp6.6, %cmp8.6
  %cmp10.6 = icmp eq i64 %indvars.iv.6, %0
  %or.cond2.6 = or i1 %cmp10.6, %or.cond1.6
  br i1 %or.cond2.6, label %if.then.6, label %if.else.6

if.else.6:                                        ; preds = %for.body4.6
  %arrayidx12.6 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %179
  %180 = load float, float* %arrayidx12.6, align 4
  %conv.6 = fpext float %180 to double
  %mul13.6 = fmul double %conv.6, 0x404CA5DC1A63C1F8
  %conv14.6 = fptrunc double %mul13.6 to float
  %cmp15.6 = fcmp olt float %conv14.6, 0.000000e+00
  %add18.6 = fadd float %conv14.6, 1.800000e+02
  %angle.0.6 = select i1 %cmp15.6, float %add18.6, float %conv14.6
  %cmp19.6 = fcmp oge float %angle.0.6, 0.000000e+00
  %cmp22.6 = fcmp olt float %angle.0.6, 2.250000e+01
  %or.cond3.6 = and i1 %cmp19.6, %cmp22.6
  br i1 %or.cond3.6, label %if.then31.6, label %lor.lhs.false24.6

lor.lhs.false24.6:                                ; preds = %if.else.6
  %cmp26.6 = fcmp ult float %angle.0.6, 1.575000e+02
  %cmp29.6 = fcmp ugt float %angle.0.6, 1.800000e+02
  %or.cond4.6 = or i1 %cmp26.6, %cmp29.6
  br i1 %or.cond4.6, label %if.else42.6, label %if.then31.6

if.else42.6:                                      ; preds = %lor.lhs.false24.6
  %cmp44.6 = fcmp oge float %angle.0.6, 2.250000e+01
  %cmp48.6 = fcmp olt float %angle.0.6, 6.750000e+01
  %or.cond5.6 = and i1 %cmp44.6, %cmp48.6
  br i1 %or.cond5.6, label %if.then50.6, label %if.else63.6

if.else63.6:                                      ; preds = %if.else42.6
  %cmp65.6 = fcmp oge float %angle.0.6, 6.750000e+01
  %cmp69.6 = fcmp olt float %angle.0.6, 1.125000e+02
  %or.cond6.6 = and i1 %cmp65.6, %cmp69.6
  br i1 %or.cond6.6, label %if.then71.6, label %if.else82.6

if.else82.6:                                      ; preds = %if.else63.6
  %cmp84.6 = fcmp oge float %angle.0.6, 1.125000e+02
  %cmp88.6 = fcmp olt float %angle.0.6, 1.575000e+02
  %or.cond7.6 = and i1 %cmp84.6, %cmp88.6
  br i1 %or.cond7.6, label %if.then90.6, label %if.end106.6

if.then90.6:                                      ; preds = %if.else82.6
  %181 = trunc i64 %indvars.iv.6 to i32
  %sub93.6 = add i32 %181, %sub91.6
  %add94.6 = add i32 %sub93.6, -129
  %idxprom95.6 = sext i32 %add94.6 to i64
  %arrayidx96.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.6
  %182 = load float, float* %arrayidx96.6, align 4
  %add100.6 = add i32 %sub93.6, 129
  %idxprom101.6 = sext i32 %add100.6 to i64
  %arrayidx102.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.6
  %183 = load float, float* %arrayidx102.6, align 4
  br label %if.end106.6

if.then71.6:                                      ; preds = %if.else63.6
  %184 = add nsw i64 %178, %indvars.iv.6
  %arrayidx76.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %184
  %185 = load float, float* %arrayidx76.6, align 4
  %186 = add nsw i64 %177, %indvars.iv.6
  %arrayidx81.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %186
  %187 = load float, float* %arrayidx81.6, align 4
  br label %if.end106.6

if.then50.6:                                      ; preds = %if.else42.6
  %188 = trunc i64 %indvars.iv.6 to i32
  %sub53.6 = add i32 %188, %add51.6
  %add54.6 = add i32 %sub53.6, 127
  %idxprom55.6 = sext i32 %add54.6 to i64
  %arrayidx56.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.6
  %189 = load float, float* %arrayidx56.6, align 4
  %add60.6 = add i32 %sub53.6, -127
  %idxprom61.6 = sext i32 %add60.6 to i64
  %arrayidx62.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.6
  %190 = load float, float* %arrayidx62.6, align 4
  br label %if.end106.6

if.then31.6:                                      ; preds = %lor.lhs.false24.6, %if.else.6
  %191 = trunc i64 %indvars.iv.6 to i32
  %add34.6 = add i32 %add33.6, %191
  %idxprom35.6 = sext i32 %add34.6 to i64
  %arrayidx36.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.6
  %192 = load float, float* %arrayidx36.6, align 4
  %193 = trunc i64 %indvars.iv.6 to i32
  %add39.6 = add i32 %sub38.6, %193
  %idxprom40.6 = sext i32 %add39.6 to i64
  %arrayidx41.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.6
  %194 = load float, float* %arrayidx41.6, align 4
  br label %if.end106.6

if.end106.6:                                      ; preds = %if.then31.6, %if.then50.6, %if.then71.6, %if.then90.6, %if.else82.6
  %q.3.6 = phi float [ %192, %if.then31.6 ], [ %189, %if.then50.6 ], [ %185, %if.then71.6 ], [ %182, %if.then90.6 ], [ 2.550000e+02, %if.else82.6 ]
  %r.3.6 = phi float [ %194, %if.then31.6 ], [ %190, %if.then50.6 ], [ %187, %if.then71.6 ], [ %183, %if.then90.6 ], [ 2.550000e+02, %if.else82.6 ]
  %arrayidx108.6 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %179
  %195 = load float, float* %arrayidx108.6, align 4
  %cmp109.6 = fcmp ult float %195, %q.3.6
  %cmp114.6 = fcmp ult float %195, %r.3.6
  %or.cond8.6 = or i1 %cmp109.6, %cmp114.6
  br i1 %or.cond8.6, label %if.else122.6, label %if.then116.6

if.then116.6:                                     ; preds = %if.end106.6
  %conv119.6 = fptoui float %195 to i32
  %arrayidx121.6 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %179
  store i32 %conv119.6, i32* %arrayidx121.6, align 4
  br label %for.inc.6

if.else122.6:                                     ; preds = %if.end106.6
  %arrayidx124.6 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %179
  store i32 0, i32* %arrayidx124.6, align 4
  br label %for.inc.6

if.then.6:                                        ; preds = %for.body4.6
  %arrayidx.6 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %179
  store i32 0, i32* %arrayidx.6, align 4
  br label %for.inc.6

for.inc.6:                                        ; preds = %if.then.6, %if.else122.6, %if.then116.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %img_width
  br i1 %exitcond.6, label %for.inc127.6, label %for.body4.6, !llvm.loop !1

for.inc127.6:                                     ; preds = %for.inc.6
  %indvars.iv.next20.6 = add nsw i64 %indvars.iv19, 7
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.7

for.body4.lr.ph.7:                                ; preds = %for.inc127.6
  %196 = trunc i64 %indvars.iv.next20.6 to i32
  %mul.7 = shl nsw i32 %196, 7
  %cmp6.7 = icmp eq i64 %indvars.iv.next20.6, %1
  %add33.7 = or i32 %mul.7, 1
  %sub38.7 = add i32 %mul.7, -1
  %197 = trunc i64 %indvars.iv.next20.6 to i32
  %add51.7 = shl i32 %197, 7
  %198 = trunc i64 %indvars.iv.next20.6 to i32
  %add72.7 = shl i32 %198, 7
  %mul73.7 = add i32 %add72.7, 128
  %mul78.7 = add i32 %add72.7, -128
  %199 = trunc i64 %indvars.iv.next20.6 to i32
  %sub91.7 = shl i32 %199, 7
  %200 = sext i32 %mul.7 to i64
  %201 = sext i32 %mul78.7 to i64
  %202 = sext i32 %mul73.7 to i64
  br label %for.body4.7

for.body4.7:                                      ; preds = %for.inc.7, %for.body4.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body4.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc.7 ]
  %203 = add nsw i64 %indvars.iv.7, %200
  %cmp8.7 = icmp eq i64 %indvars.iv.7, 0
  %or.cond1.7 = or i1 %cmp6.7, %cmp8.7
  %cmp10.7 = icmp eq i64 %indvars.iv.7, %0
  %or.cond2.7 = or i1 %cmp10.7, %or.cond1.7
  br i1 %or.cond2.7, label %if.then.7, label %if.else.7

if.else.7:                                        ; preds = %for.body4.7
  %arrayidx12.7 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %203
  %204 = load float, float* %arrayidx12.7, align 4
  %conv.7 = fpext float %204 to double
  %mul13.7 = fmul double %conv.7, 0x404CA5DC1A63C1F8
  %conv14.7 = fptrunc double %mul13.7 to float
  %cmp15.7 = fcmp olt float %conv14.7, 0.000000e+00
  %add18.7 = fadd float %conv14.7, 1.800000e+02
  %angle.0.7 = select i1 %cmp15.7, float %add18.7, float %conv14.7
  %cmp19.7 = fcmp oge float %angle.0.7, 0.000000e+00
  %cmp22.7 = fcmp olt float %angle.0.7, 2.250000e+01
  %or.cond3.7 = and i1 %cmp19.7, %cmp22.7
  br i1 %or.cond3.7, label %if.then31.7, label %lor.lhs.false24.7

lor.lhs.false24.7:                                ; preds = %if.else.7
  %cmp26.7 = fcmp ult float %angle.0.7, 1.575000e+02
  %cmp29.7 = fcmp ugt float %angle.0.7, 1.800000e+02
  %or.cond4.7 = or i1 %cmp26.7, %cmp29.7
  br i1 %or.cond4.7, label %if.else42.7, label %if.then31.7

if.else42.7:                                      ; preds = %lor.lhs.false24.7
  %cmp44.7 = fcmp oge float %angle.0.7, 2.250000e+01
  %cmp48.7 = fcmp olt float %angle.0.7, 6.750000e+01
  %or.cond5.7 = and i1 %cmp44.7, %cmp48.7
  br i1 %or.cond5.7, label %if.then50.7, label %if.else63.7

if.else63.7:                                      ; preds = %if.else42.7
  %cmp65.7 = fcmp oge float %angle.0.7, 6.750000e+01
  %cmp69.7 = fcmp olt float %angle.0.7, 1.125000e+02
  %or.cond6.7 = and i1 %cmp65.7, %cmp69.7
  br i1 %or.cond6.7, label %if.then71.7, label %if.else82.7

if.else82.7:                                      ; preds = %if.else63.7
  %cmp84.7 = fcmp oge float %angle.0.7, 1.125000e+02
  %cmp88.7 = fcmp olt float %angle.0.7, 1.575000e+02
  %or.cond7.7 = and i1 %cmp84.7, %cmp88.7
  br i1 %or.cond7.7, label %if.then90.7, label %if.end106.7

if.then90.7:                                      ; preds = %if.else82.7
  %205 = trunc i64 %indvars.iv.7 to i32
  %sub93.7 = add i32 %205, %sub91.7
  %add94.7 = add i32 %sub93.7, -129
  %idxprom95.7 = sext i32 %add94.7 to i64
  %arrayidx96.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.7
  %206 = load float, float* %arrayidx96.7, align 4
  %add100.7 = add i32 %sub93.7, 129
  %idxprom101.7 = sext i32 %add100.7 to i64
  %arrayidx102.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.7
  %207 = load float, float* %arrayidx102.7, align 4
  br label %if.end106.7

if.then71.7:                                      ; preds = %if.else63.7
  %208 = add nsw i64 %202, %indvars.iv.7
  %arrayidx76.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %208
  %209 = load float, float* %arrayidx76.7, align 4
  %210 = add nsw i64 %201, %indvars.iv.7
  %arrayidx81.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %210
  %211 = load float, float* %arrayidx81.7, align 4
  br label %if.end106.7

if.then50.7:                                      ; preds = %if.else42.7
  %212 = trunc i64 %indvars.iv.7 to i32
  %sub53.7 = add i32 %212, %add51.7
  %add54.7 = add i32 %sub53.7, 127
  %idxprom55.7 = sext i32 %add54.7 to i64
  %arrayidx56.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.7
  %213 = load float, float* %arrayidx56.7, align 4
  %add60.7 = add i32 %sub53.7, -127
  %idxprom61.7 = sext i32 %add60.7 to i64
  %arrayidx62.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.7
  %214 = load float, float* %arrayidx62.7, align 4
  br label %if.end106.7

if.then31.7:                                      ; preds = %lor.lhs.false24.7, %if.else.7
  %215 = trunc i64 %indvars.iv.7 to i32
  %add34.7 = add i32 %add33.7, %215
  %idxprom35.7 = sext i32 %add34.7 to i64
  %arrayidx36.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.7
  %216 = load float, float* %arrayidx36.7, align 4
  %217 = trunc i64 %indvars.iv.7 to i32
  %add39.7 = add i32 %sub38.7, %217
  %idxprom40.7 = sext i32 %add39.7 to i64
  %arrayidx41.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.7
  %218 = load float, float* %arrayidx41.7, align 4
  br label %if.end106.7

if.end106.7:                                      ; preds = %if.then31.7, %if.then50.7, %if.then71.7, %if.then90.7, %if.else82.7
  %q.3.7 = phi float [ %216, %if.then31.7 ], [ %213, %if.then50.7 ], [ %209, %if.then71.7 ], [ %206, %if.then90.7 ], [ 2.550000e+02, %if.else82.7 ]
  %r.3.7 = phi float [ %218, %if.then31.7 ], [ %214, %if.then50.7 ], [ %211, %if.then71.7 ], [ %207, %if.then90.7 ], [ 2.550000e+02, %if.else82.7 ]
  %arrayidx108.7 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %203
  %219 = load float, float* %arrayidx108.7, align 4
  %cmp109.7 = fcmp ult float %219, %q.3.7
  %cmp114.7 = fcmp ult float %219, %r.3.7
  %or.cond8.7 = or i1 %cmp109.7, %cmp114.7
  br i1 %or.cond8.7, label %if.else122.7, label %if.then116.7

if.then116.7:                                     ; preds = %if.end106.7
  %conv119.7 = fptoui float %219 to i32
  %arrayidx121.7 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %203
  store i32 %conv119.7, i32* %arrayidx121.7, align 4
  br label %for.inc.7

if.else122.7:                                     ; preds = %if.end106.7
  %arrayidx124.7 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %203
  store i32 0, i32* %arrayidx124.7, align 4
  br label %for.inc.7

if.then.7:                                        ; preds = %for.body4.7
  %arrayidx.7 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %203
  store i32 0, i32* %arrayidx.7, align 4
  br label %for.inc.7

for.inc.7:                                        ; preds = %if.then.7, %if.else122.7, %if.then116.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %img_width
  br i1 %exitcond.7, label %for.inc127.7, label %for.body4.7, !llvm.loop !1

for.inc127.7:                                     ; preds = %for.inc.7
  %indvars.iv.next20.7 = add nsw i64 %indvars.iv19, 8
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.8

for.body4.lr.ph.8:                                ; preds = %for.inc127.7
  %220 = trunc i64 %indvars.iv.next20.7 to i32
  %mul.8 = shl nsw i32 %220, 7
  %cmp6.8 = icmp eq i64 %indvars.iv.next20.7, %1
  %add33.8 = or i32 %mul.8, 1
  %sub38.8 = add i32 %mul.8, -1
  %221 = trunc i64 %indvars.iv.next20.7 to i32
  %add51.8 = shl i32 %221, 7
  %222 = trunc i64 %indvars.iv.next20.7 to i32
  %add72.8 = shl i32 %222, 7
  %mul73.8 = add i32 %add72.8, 128
  %mul78.8 = add i32 %add72.8, -128
  %223 = trunc i64 %indvars.iv.next20.7 to i32
  %sub91.8 = shl i32 %223, 7
  %224 = sext i32 %mul.8 to i64
  %225 = sext i32 %mul78.8 to i64
  %226 = sext i32 %mul73.8 to i64
  br label %for.body4.8

for.body4.8:                                      ; preds = %for.inc.8, %for.body4.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body4.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc.8 ]
  %227 = add nsw i64 %indvars.iv.8, %224
  %cmp8.8 = icmp eq i64 %indvars.iv.8, 0
  %or.cond1.8 = or i1 %cmp6.8, %cmp8.8
  %cmp10.8 = icmp eq i64 %indvars.iv.8, %0
  %or.cond2.8 = or i1 %cmp10.8, %or.cond1.8
  br i1 %or.cond2.8, label %if.then.8, label %if.else.8

if.else.8:                                        ; preds = %for.body4.8
  %arrayidx12.8 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %227
  %228 = load float, float* %arrayidx12.8, align 4
  %conv.8 = fpext float %228 to double
  %mul13.8 = fmul double %conv.8, 0x404CA5DC1A63C1F8
  %conv14.8 = fptrunc double %mul13.8 to float
  %cmp15.8 = fcmp olt float %conv14.8, 0.000000e+00
  %add18.8 = fadd float %conv14.8, 1.800000e+02
  %angle.0.8 = select i1 %cmp15.8, float %add18.8, float %conv14.8
  %cmp19.8 = fcmp oge float %angle.0.8, 0.000000e+00
  %cmp22.8 = fcmp olt float %angle.0.8, 2.250000e+01
  %or.cond3.8 = and i1 %cmp19.8, %cmp22.8
  br i1 %or.cond3.8, label %if.then31.8, label %lor.lhs.false24.8

lor.lhs.false24.8:                                ; preds = %if.else.8
  %cmp26.8 = fcmp ult float %angle.0.8, 1.575000e+02
  %cmp29.8 = fcmp ugt float %angle.0.8, 1.800000e+02
  %or.cond4.8 = or i1 %cmp26.8, %cmp29.8
  br i1 %or.cond4.8, label %if.else42.8, label %if.then31.8

if.else42.8:                                      ; preds = %lor.lhs.false24.8
  %cmp44.8 = fcmp oge float %angle.0.8, 2.250000e+01
  %cmp48.8 = fcmp olt float %angle.0.8, 6.750000e+01
  %or.cond5.8 = and i1 %cmp44.8, %cmp48.8
  br i1 %or.cond5.8, label %if.then50.8, label %if.else63.8

if.else63.8:                                      ; preds = %if.else42.8
  %cmp65.8 = fcmp oge float %angle.0.8, 6.750000e+01
  %cmp69.8 = fcmp olt float %angle.0.8, 1.125000e+02
  %or.cond6.8 = and i1 %cmp65.8, %cmp69.8
  br i1 %or.cond6.8, label %if.then71.8, label %if.else82.8

if.else82.8:                                      ; preds = %if.else63.8
  %cmp84.8 = fcmp oge float %angle.0.8, 1.125000e+02
  %cmp88.8 = fcmp olt float %angle.0.8, 1.575000e+02
  %or.cond7.8 = and i1 %cmp84.8, %cmp88.8
  br i1 %or.cond7.8, label %if.then90.8, label %if.end106.8

if.then90.8:                                      ; preds = %if.else82.8
  %229 = trunc i64 %indvars.iv.8 to i32
  %sub93.8 = add i32 %229, %sub91.8
  %add94.8 = add i32 %sub93.8, -129
  %idxprom95.8 = sext i32 %add94.8 to i64
  %arrayidx96.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.8
  %230 = load float, float* %arrayidx96.8, align 4
  %add100.8 = add i32 %sub93.8, 129
  %idxprom101.8 = sext i32 %add100.8 to i64
  %arrayidx102.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.8
  %231 = load float, float* %arrayidx102.8, align 4
  br label %if.end106.8

if.then71.8:                                      ; preds = %if.else63.8
  %232 = add nsw i64 %226, %indvars.iv.8
  %arrayidx76.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %232
  %233 = load float, float* %arrayidx76.8, align 4
  %234 = add nsw i64 %225, %indvars.iv.8
  %arrayidx81.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %234
  %235 = load float, float* %arrayidx81.8, align 4
  br label %if.end106.8

if.then50.8:                                      ; preds = %if.else42.8
  %236 = trunc i64 %indvars.iv.8 to i32
  %sub53.8 = add i32 %236, %add51.8
  %add54.8 = add i32 %sub53.8, 127
  %idxprom55.8 = sext i32 %add54.8 to i64
  %arrayidx56.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.8
  %237 = load float, float* %arrayidx56.8, align 4
  %add60.8 = add i32 %sub53.8, -127
  %idxprom61.8 = sext i32 %add60.8 to i64
  %arrayidx62.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.8
  %238 = load float, float* %arrayidx62.8, align 4
  br label %if.end106.8

if.then31.8:                                      ; preds = %lor.lhs.false24.8, %if.else.8
  %239 = trunc i64 %indvars.iv.8 to i32
  %add34.8 = add i32 %add33.8, %239
  %idxprom35.8 = sext i32 %add34.8 to i64
  %arrayidx36.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.8
  %240 = load float, float* %arrayidx36.8, align 4
  %241 = trunc i64 %indvars.iv.8 to i32
  %add39.8 = add i32 %sub38.8, %241
  %idxprom40.8 = sext i32 %add39.8 to i64
  %arrayidx41.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.8
  %242 = load float, float* %arrayidx41.8, align 4
  br label %if.end106.8

if.end106.8:                                      ; preds = %if.then31.8, %if.then50.8, %if.then71.8, %if.then90.8, %if.else82.8
  %q.3.8 = phi float [ %240, %if.then31.8 ], [ %237, %if.then50.8 ], [ %233, %if.then71.8 ], [ %230, %if.then90.8 ], [ 2.550000e+02, %if.else82.8 ]
  %r.3.8 = phi float [ %242, %if.then31.8 ], [ %238, %if.then50.8 ], [ %235, %if.then71.8 ], [ %231, %if.then90.8 ], [ 2.550000e+02, %if.else82.8 ]
  %arrayidx108.8 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %227
  %243 = load float, float* %arrayidx108.8, align 4
  %cmp109.8 = fcmp ult float %243, %q.3.8
  %cmp114.8 = fcmp ult float %243, %r.3.8
  %or.cond8.8 = or i1 %cmp109.8, %cmp114.8
  br i1 %or.cond8.8, label %if.else122.8, label %if.then116.8

if.then116.8:                                     ; preds = %if.end106.8
  %conv119.8 = fptoui float %243 to i32
  %arrayidx121.8 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %227
  store i32 %conv119.8, i32* %arrayidx121.8, align 4
  br label %for.inc.8

if.else122.8:                                     ; preds = %if.end106.8
  %arrayidx124.8 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %227
  store i32 0, i32* %arrayidx124.8, align 4
  br label %for.inc.8

if.then.8:                                        ; preds = %for.body4.8
  %arrayidx.8 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %227
  store i32 0, i32* %arrayidx.8, align 4
  br label %for.inc.8

for.inc.8:                                        ; preds = %if.then.8, %if.else122.8, %if.then116.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %img_width
  br i1 %exitcond.8, label %for.inc127.8, label %for.body4.8, !llvm.loop !1

for.inc127.8:                                     ; preds = %for.inc.8
  %indvars.iv.next20.8 = add nsw i64 %indvars.iv19, 9
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.9

for.body4.lr.ph.9:                                ; preds = %for.inc127.8
  %244 = trunc i64 %indvars.iv.next20.8 to i32
  %mul.9 = shl nsw i32 %244, 7
  %cmp6.9 = icmp eq i64 %indvars.iv.next20.8, %1
  %add33.9 = or i32 %mul.9, 1
  %sub38.9 = add i32 %mul.9, -1
  %245 = trunc i64 %indvars.iv.next20.8 to i32
  %add51.9 = shl i32 %245, 7
  %246 = trunc i64 %indvars.iv.next20.8 to i32
  %add72.9 = shl i32 %246, 7
  %mul73.9 = add i32 %add72.9, 128
  %mul78.9 = add i32 %add72.9, -128
  %247 = trunc i64 %indvars.iv.next20.8 to i32
  %sub91.9 = shl i32 %247, 7
  %248 = sext i32 %mul.9 to i64
  %249 = sext i32 %mul78.9 to i64
  %250 = sext i32 %mul73.9 to i64
  br label %for.body4.9

for.body4.9:                                      ; preds = %for.inc.9, %for.body4.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body4.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc.9 ]
  %251 = add nsw i64 %indvars.iv.9, %248
  %cmp8.9 = icmp eq i64 %indvars.iv.9, 0
  %or.cond1.9 = or i1 %cmp6.9, %cmp8.9
  %cmp10.9 = icmp eq i64 %indvars.iv.9, %0
  %or.cond2.9 = or i1 %cmp10.9, %or.cond1.9
  br i1 %or.cond2.9, label %if.then.9, label %if.else.9

if.else.9:                                        ; preds = %for.body4.9
  %arrayidx12.9 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %251
  %252 = load float, float* %arrayidx12.9, align 4
  %conv.9 = fpext float %252 to double
  %mul13.9 = fmul double %conv.9, 0x404CA5DC1A63C1F8
  %conv14.9 = fptrunc double %mul13.9 to float
  %cmp15.9 = fcmp olt float %conv14.9, 0.000000e+00
  %add18.9 = fadd float %conv14.9, 1.800000e+02
  %angle.0.9 = select i1 %cmp15.9, float %add18.9, float %conv14.9
  %cmp19.9 = fcmp oge float %angle.0.9, 0.000000e+00
  %cmp22.9 = fcmp olt float %angle.0.9, 2.250000e+01
  %or.cond3.9 = and i1 %cmp19.9, %cmp22.9
  br i1 %or.cond3.9, label %if.then31.9, label %lor.lhs.false24.9

lor.lhs.false24.9:                                ; preds = %if.else.9
  %cmp26.9 = fcmp ult float %angle.0.9, 1.575000e+02
  %cmp29.9 = fcmp ugt float %angle.0.9, 1.800000e+02
  %or.cond4.9 = or i1 %cmp26.9, %cmp29.9
  br i1 %or.cond4.9, label %if.else42.9, label %if.then31.9

if.else42.9:                                      ; preds = %lor.lhs.false24.9
  %cmp44.9 = fcmp oge float %angle.0.9, 2.250000e+01
  %cmp48.9 = fcmp olt float %angle.0.9, 6.750000e+01
  %or.cond5.9 = and i1 %cmp44.9, %cmp48.9
  br i1 %or.cond5.9, label %if.then50.9, label %if.else63.9

if.else63.9:                                      ; preds = %if.else42.9
  %cmp65.9 = fcmp oge float %angle.0.9, 6.750000e+01
  %cmp69.9 = fcmp olt float %angle.0.9, 1.125000e+02
  %or.cond6.9 = and i1 %cmp65.9, %cmp69.9
  br i1 %or.cond6.9, label %if.then71.9, label %if.else82.9

if.else82.9:                                      ; preds = %if.else63.9
  %cmp84.9 = fcmp oge float %angle.0.9, 1.125000e+02
  %cmp88.9 = fcmp olt float %angle.0.9, 1.575000e+02
  %or.cond7.9 = and i1 %cmp84.9, %cmp88.9
  br i1 %or.cond7.9, label %if.then90.9, label %if.end106.9

if.then90.9:                                      ; preds = %if.else82.9
  %253 = trunc i64 %indvars.iv.9 to i32
  %sub93.9 = add i32 %253, %sub91.9
  %add94.9 = add i32 %sub93.9, -129
  %idxprom95.9 = sext i32 %add94.9 to i64
  %arrayidx96.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.9
  %254 = load float, float* %arrayidx96.9, align 4
  %add100.9 = add i32 %sub93.9, 129
  %idxprom101.9 = sext i32 %add100.9 to i64
  %arrayidx102.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.9
  %255 = load float, float* %arrayidx102.9, align 4
  br label %if.end106.9

if.then71.9:                                      ; preds = %if.else63.9
  %256 = add nsw i64 %250, %indvars.iv.9
  %arrayidx76.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %256
  %257 = load float, float* %arrayidx76.9, align 4
  %258 = add nsw i64 %249, %indvars.iv.9
  %arrayidx81.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %258
  %259 = load float, float* %arrayidx81.9, align 4
  br label %if.end106.9

if.then50.9:                                      ; preds = %if.else42.9
  %260 = trunc i64 %indvars.iv.9 to i32
  %sub53.9 = add i32 %260, %add51.9
  %add54.9 = add i32 %sub53.9, 127
  %idxprom55.9 = sext i32 %add54.9 to i64
  %arrayidx56.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.9
  %261 = load float, float* %arrayidx56.9, align 4
  %add60.9 = add i32 %sub53.9, -127
  %idxprom61.9 = sext i32 %add60.9 to i64
  %arrayidx62.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.9
  %262 = load float, float* %arrayidx62.9, align 4
  br label %if.end106.9

if.then31.9:                                      ; preds = %lor.lhs.false24.9, %if.else.9
  %263 = trunc i64 %indvars.iv.9 to i32
  %add34.9 = add i32 %add33.9, %263
  %idxprom35.9 = sext i32 %add34.9 to i64
  %arrayidx36.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.9
  %264 = load float, float* %arrayidx36.9, align 4
  %265 = trunc i64 %indvars.iv.9 to i32
  %add39.9 = add i32 %sub38.9, %265
  %idxprom40.9 = sext i32 %add39.9 to i64
  %arrayidx41.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.9
  %266 = load float, float* %arrayidx41.9, align 4
  br label %if.end106.9

if.end106.9:                                      ; preds = %if.then31.9, %if.then50.9, %if.then71.9, %if.then90.9, %if.else82.9
  %q.3.9 = phi float [ %264, %if.then31.9 ], [ %261, %if.then50.9 ], [ %257, %if.then71.9 ], [ %254, %if.then90.9 ], [ 2.550000e+02, %if.else82.9 ]
  %r.3.9 = phi float [ %266, %if.then31.9 ], [ %262, %if.then50.9 ], [ %259, %if.then71.9 ], [ %255, %if.then90.9 ], [ 2.550000e+02, %if.else82.9 ]
  %arrayidx108.9 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %251
  %267 = load float, float* %arrayidx108.9, align 4
  %cmp109.9 = fcmp ult float %267, %q.3.9
  %cmp114.9 = fcmp ult float %267, %r.3.9
  %or.cond8.9 = or i1 %cmp109.9, %cmp114.9
  br i1 %or.cond8.9, label %if.else122.9, label %if.then116.9

if.then116.9:                                     ; preds = %if.end106.9
  %conv119.9 = fptoui float %267 to i32
  %arrayidx121.9 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %251
  store i32 %conv119.9, i32* %arrayidx121.9, align 4
  br label %for.inc.9

if.else122.9:                                     ; preds = %if.end106.9
  %arrayidx124.9 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %251
  store i32 0, i32* %arrayidx124.9, align 4
  br label %for.inc.9

if.then.9:                                        ; preds = %for.body4.9
  %arrayidx.9 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %251
  store i32 0, i32* %arrayidx.9, align 4
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.then.9, %if.else122.9, %if.then116.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %img_width
  br i1 %exitcond.9, label %for.inc127.9, label %for.body4.9, !llvm.loop !1

for.inc127.9:                                     ; preds = %for.inc.9
  %indvars.iv.next20.9 = add nsw i64 %indvars.iv19, 10
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.10

for.body4.lr.ph.10:                               ; preds = %for.inc127.9
  %268 = trunc i64 %indvars.iv.next20.9 to i32
  %mul.10 = shl nsw i32 %268, 7
  %cmp6.10 = icmp eq i64 %indvars.iv.next20.9, %1
  %add33.10 = or i32 %mul.10, 1
  %sub38.10 = add i32 %mul.10, -1
  %269 = trunc i64 %indvars.iv.next20.9 to i32
  %add51.10 = shl i32 %269, 7
  %270 = trunc i64 %indvars.iv.next20.9 to i32
  %add72.10 = shl i32 %270, 7
  %mul73.10 = add i32 %add72.10, 128
  %mul78.10 = add i32 %add72.10, -128
  %271 = trunc i64 %indvars.iv.next20.9 to i32
  %sub91.10 = shl i32 %271, 7
  %272 = sext i32 %mul.10 to i64
  %273 = sext i32 %mul78.10 to i64
  %274 = sext i32 %mul73.10 to i64
  br label %for.body4.10

for.body4.10:                                     ; preds = %for.inc.10, %for.body4.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body4.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc.10 ]
  %275 = add nsw i64 %indvars.iv.10, %272
  %cmp8.10 = icmp eq i64 %indvars.iv.10, 0
  %or.cond1.10 = or i1 %cmp6.10, %cmp8.10
  %cmp10.10 = icmp eq i64 %indvars.iv.10, %0
  %or.cond2.10 = or i1 %cmp10.10, %or.cond1.10
  br i1 %or.cond2.10, label %if.then.10, label %if.else.10

if.else.10:                                       ; preds = %for.body4.10
  %arrayidx12.10 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %275
  %276 = load float, float* %arrayidx12.10, align 4
  %conv.10 = fpext float %276 to double
  %mul13.10 = fmul double %conv.10, 0x404CA5DC1A63C1F8
  %conv14.10 = fptrunc double %mul13.10 to float
  %cmp15.10 = fcmp olt float %conv14.10, 0.000000e+00
  %add18.10 = fadd float %conv14.10, 1.800000e+02
  %angle.0.10 = select i1 %cmp15.10, float %add18.10, float %conv14.10
  %cmp19.10 = fcmp oge float %angle.0.10, 0.000000e+00
  %cmp22.10 = fcmp olt float %angle.0.10, 2.250000e+01
  %or.cond3.10 = and i1 %cmp19.10, %cmp22.10
  br i1 %or.cond3.10, label %if.then31.10, label %lor.lhs.false24.10

lor.lhs.false24.10:                               ; preds = %if.else.10
  %cmp26.10 = fcmp ult float %angle.0.10, 1.575000e+02
  %cmp29.10 = fcmp ugt float %angle.0.10, 1.800000e+02
  %or.cond4.10 = or i1 %cmp26.10, %cmp29.10
  br i1 %or.cond4.10, label %if.else42.10, label %if.then31.10

if.else42.10:                                     ; preds = %lor.lhs.false24.10
  %cmp44.10 = fcmp oge float %angle.0.10, 2.250000e+01
  %cmp48.10 = fcmp olt float %angle.0.10, 6.750000e+01
  %or.cond5.10 = and i1 %cmp44.10, %cmp48.10
  br i1 %or.cond5.10, label %if.then50.10, label %if.else63.10

if.else63.10:                                     ; preds = %if.else42.10
  %cmp65.10 = fcmp oge float %angle.0.10, 6.750000e+01
  %cmp69.10 = fcmp olt float %angle.0.10, 1.125000e+02
  %or.cond6.10 = and i1 %cmp65.10, %cmp69.10
  br i1 %or.cond6.10, label %if.then71.10, label %if.else82.10

if.else82.10:                                     ; preds = %if.else63.10
  %cmp84.10 = fcmp oge float %angle.0.10, 1.125000e+02
  %cmp88.10 = fcmp olt float %angle.0.10, 1.575000e+02
  %or.cond7.10 = and i1 %cmp84.10, %cmp88.10
  br i1 %or.cond7.10, label %if.then90.10, label %if.end106.10

if.then90.10:                                     ; preds = %if.else82.10
  %277 = trunc i64 %indvars.iv.10 to i32
  %sub93.10 = add i32 %277, %sub91.10
  %add94.10 = add i32 %sub93.10, -129
  %idxprom95.10 = sext i32 %add94.10 to i64
  %arrayidx96.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.10
  %278 = load float, float* %arrayidx96.10, align 4
  %add100.10 = add i32 %sub93.10, 129
  %idxprom101.10 = sext i32 %add100.10 to i64
  %arrayidx102.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.10
  %279 = load float, float* %arrayidx102.10, align 4
  br label %if.end106.10

if.then71.10:                                     ; preds = %if.else63.10
  %280 = add nsw i64 %274, %indvars.iv.10
  %arrayidx76.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %280
  %281 = load float, float* %arrayidx76.10, align 4
  %282 = add nsw i64 %273, %indvars.iv.10
  %arrayidx81.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %282
  %283 = load float, float* %arrayidx81.10, align 4
  br label %if.end106.10

if.then50.10:                                     ; preds = %if.else42.10
  %284 = trunc i64 %indvars.iv.10 to i32
  %sub53.10 = add i32 %284, %add51.10
  %add54.10 = add i32 %sub53.10, 127
  %idxprom55.10 = sext i32 %add54.10 to i64
  %arrayidx56.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.10
  %285 = load float, float* %arrayidx56.10, align 4
  %add60.10 = add i32 %sub53.10, -127
  %idxprom61.10 = sext i32 %add60.10 to i64
  %arrayidx62.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.10
  %286 = load float, float* %arrayidx62.10, align 4
  br label %if.end106.10

if.then31.10:                                     ; preds = %lor.lhs.false24.10, %if.else.10
  %287 = trunc i64 %indvars.iv.10 to i32
  %add34.10 = add i32 %add33.10, %287
  %idxprom35.10 = sext i32 %add34.10 to i64
  %arrayidx36.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.10
  %288 = load float, float* %arrayidx36.10, align 4
  %289 = trunc i64 %indvars.iv.10 to i32
  %add39.10 = add i32 %sub38.10, %289
  %idxprom40.10 = sext i32 %add39.10 to i64
  %arrayidx41.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.10
  %290 = load float, float* %arrayidx41.10, align 4
  br label %if.end106.10

if.end106.10:                                     ; preds = %if.then31.10, %if.then50.10, %if.then71.10, %if.then90.10, %if.else82.10
  %q.3.10 = phi float [ %288, %if.then31.10 ], [ %285, %if.then50.10 ], [ %281, %if.then71.10 ], [ %278, %if.then90.10 ], [ 2.550000e+02, %if.else82.10 ]
  %r.3.10 = phi float [ %290, %if.then31.10 ], [ %286, %if.then50.10 ], [ %283, %if.then71.10 ], [ %279, %if.then90.10 ], [ 2.550000e+02, %if.else82.10 ]
  %arrayidx108.10 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %275
  %291 = load float, float* %arrayidx108.10, align 4
  %cmp109.10 = fcmp ult float %291, %q.3.10
  %cmp114.10 = fcmp ult float %291, %r.3.10
  %or.cond8.10 = or i1 %cmp109.10, %cmp114.10
  br i1 %or.cond8.10, label %if.else122.10, label %if.then116.10

if.then116.10:                                    ; preds = %if.end106.10
  %conv119.10 = fptoui float %291 to i32
  %arrayidx121.10 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %275
  store i32 %conv119.10, i32* %arrayidx121.10, align 4
  br label %for.inc.10

if.else122.10:                                    ; preds = %if.end106.10
  %arrayidx124.10 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %275
  store i32 0, i32* %arrayidx124.10, align 4
  br label %for.inc.10

if.then.10:                                       ; preds = %for.body4.10
  %arrayidx.10 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %275
  store i32 0, i32* %arrayidx.10, align 4
  br label %for.inc.10

for.inc.10:                                       ; preds = %if.then.10, %if.else122.10, %if.then116.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %img_width
  br i1 %exitcond.10, label %for.inc127.10, label %for.body4.10, !llvm.loop !1

for.inc127.10:                                    ; preds = %for.inc.10
  %indvars.iv.next20.10 = add nsw i64 %indvars.iv19, 11
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.11

for.body4.lr.ph.11:                               ; preds = %for.inc127.10
  %292 = trunc i64 %indvars.iv.next20.10 to i32
  %mul.11 = shl nsw i32 %292, 7
  %cmp6.11 = icmp eq i64 %indvars.iv.next20.10, %1
  %add33.11 = or i32 %mul.11, 1
  %sub38.11 = add i32 %mul.11, -1
  %293 = trunc i64 %indvars.iv.next20.10 to i32
  %add51.11 = shl i32 %293, 7
  %294 = trunc i64 %indvars.iv.next20.10 to i32
  %add72.11 = shl i32 %294, 7
  %mul73.11 = add i32 %add72.11, 128
  %mul78.11 = add i32 %add72.11, -128
  %295 = trunc i64 %indvars.iv.next20.10 to i32
  %sub91.11 = shl i32 %295, 7
  %296 = sext i32 %mul.11 to i64
  %297 = sext i32 %mul78.11 to i64
  %298 = sext i32 %mul73.11 to i64
  br label %for.body4.11

for.body4.11:                                     ; preds = %for.inc.11, %for.body4.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body4.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc.11 ]
  %299 = add nsw i64 %indvars.iv.11, %296
  %cmp8.11 = icmp eq i64 %indvars.iv.11, 0
  %or.cond1.11 = or i1 %cmp6.11, %cmp8.11
  %cmp10.11 = icmp eq i64 %indvars.iv.11, %0
  %or.cond2.11 = or i1 %cmp10.11, %or.cond1.11
  br i1 %or.cond2.11, label %if.then.11, label %if.else.11

if.else.11:                                       ; preds = %for.body4.11
  %arrayidx12.11 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %299
  %300 = load float, float* %arrayidx12.11, align 4
  %conv.11 = fpext float %300 to double
  %mul13.11 = fmul double %conv.11, 0x404CA5DC1A63C1F8
  %conv14.11 = fptrunc double %mul13.11 to float
  %cmp15.11 = fcmp olt float %conv14.11, 0.000000e+00
  %add18.11 = fadd float %conv14.11, 1.800000e+02
  %angle.0.11 = select i1 %cmp15.11, float %add18.11, float %conv14.11
  %cmp19.11 = fcmp oge float %angle.0.11, 0.000000e+00
  %cmp22.11 = fcmp olt float %angle.0.11, 2.250000e+01
  %or.cond3.11 = and i1 %cmp19.11, %cmp22.11
  br i1 %or.cond3.11, label %if.then31.11, label %lor.lhs.false24.11

lor.lhs.false24.11:                               ; preds = %if.else.11
  %cmp26.11 = fcmp ult float %angle.0.11, 1.575000e+02
  %cmp29.11 = fcmp ugt float %angle.0.11, 1.800000e+02
  %or.cond4.11 = or i1 %cmp26.11, %cmp29.11
  br i1 %or.cond4.11, label %if.else42.11, label %if.then31.11

if.else42.11:                                     ; preds = %lor.lhs.false24.11
  %cmp44.11 = fcmp oge float %angle.0.11, 2.250000e+01
  %cmp48.11 = fcmp olt float %angle.0.11, 6.750000e+01
  %or.cond5.11 = and i1 %cmp44.11, %cmp48.11
  br i1 %or.cond5.11, label %if.then50.11, label %if.else63.11

if.else63.11:                                     ; preds = %if.else42.11
  %cmp65.11 = fcmp oge float %angle.0.11, 6.750000e+01
  %cmp69.11 = fcmp olt float %angle.0.11, 1.125000e+02
  %or.cond6.11 = and i1 %cmp65.11, %cmp69.11
  br i1 %or.cond6.11, label %if.then71.11, label %if.else82.11

if.else82.11:                                     ; preds = %if.else63.11
  %cmp84.11 = fcmp oge float %angle.0.11, 1.125000e+02
  %cmp88.11 = fcmp olt float %angle.0.11, 1.575000e+02
  %or.cond7.11 = and i1 %cmp84.11, %cmp88.11
  br i1 %or.cond7.11, label %if.then90.11, label %if.end106.11

if.then90.11:                                     ; preds = %if.else82.11
  %301 = trunc i64 %indvars.iv.11 to i32
  %sub93.11 = add i32 %301, %sub91.11
  %add94.11 = add i32 %sub93.11, -129
  %idxprom95.11 = sext i32 %add94.11 to i64
  %arrayidx96.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.11
  %302 = load float, float* %arrayidx96.11, align 4
  %add100.11 = add i32 %sub93.11, 129
  %idxprom101.11 = sext i32 %add100.11 to i64
  %arrayidx102.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.11
  %303 = load float, float* %arrayidx102.11, align 4
  br label %if.end106.11

if.then71.11:                                     ; preds = %if.else63.11
  %304 = add nsw i64 %298, %indvars.iv.11
  %arrayidx76.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %304
  %305 = load float, float* %arrayidx76.11, align 4
  %306 = add nsw i64 %297, %indvars.iv.11
  %arrayidx81.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %306
  %307 = load float, float* %arrayidx81.11, align 4
  br label %if.end106.11

if.then50.11:                                     ; preds = %if.else42.11
  %308 = trunc i64 %indvars.iv.11 to i32
  %sub53.11 = add i32 %308, %add51.11
  %add54.11 = add i32 %sub53.11, 127
  %idxprom55.11 = sext i32 %add54.11 to i64
  %arrayidx56.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.11
  %309 = load float, float* %arrayidx56.11, align 4
  %add60.11 = add i32 %sub53.11, -127
  %idxprom61.11 = sext i32 %add60.11 to i64
  %arrayidx62.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.11
  %310 = load float, float* %arrayidx62.11, align 4
  br label %if.end106.11

if.then31.11:                                     ; preds = %lor.lhs.false24.11, %if.else.11
  %311 = trunc i64 %indvars.iv.11 to i32
  %add34.11 = add i32 %add33.11, %311
  %idxprom35.11 = sext i32 %add34.11 to i64
  %arrayidx36.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.11
  %312 = load float, float* %arrayidx36.11, align 4
  %313 = trunc i64 %indvars.iv.11 to i32
  %add39.11 = add i32 %sub38.11, %313
  %idxprom40.11 = sext i32 %add39.11 to i64
  %arrayidx41.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.11
  %314 = load float, float* %arrayidx41.11, align 4
  br label %if.end106.11

if.end106.11:                                     ; preds = %if.then31.11, %if.then50.11, %if.then71.11, %if.then90.11, %if.else82.11
  %q.3.11 = phi float [ %312, %if.then31.11 ], [ %309, %if.then50.11 ], [ %305, %if.then71.11 ], [ %302, %if.then90.11 ], [ 2.550000e+02, %if.else82.11 ]
  %r.3.11 = phi float [ %314, %if.then31.11 ], [ %310, %if.then50.11 ], [ %307, %if.then71.11 ], [ %303, %if.then90.11 ], [ 2.550000e+02, %if.else82.11 ]
  %arrayidx108.11 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %299
  %315 = load float, float* %arrayidx108.11, align 4
  %cmp109.11 = fcmp ult float %315, %q.3.11
  %cmp114.11 = fcmp ult float %315, %r.3.11
  %or.cond8.11 = or i1 %cmp109.11, %cmp114.11
  br i1 %or.cond8.11, label %if.else122.11, label %if.then116.11

if.then116.11:                                    ; preds = %if.end106.11
  %conv119.11 = fptoui float %315 to i32
  %arrayidx121.11 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %299
  store i32 %conv119.11, i32* %arrayidx121.11, align 4
  br label %for.inc.11

if.else122.11:                                    ; preds = %if.end106.11
  %arrayidx124.11 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %299
  store i32 0, i32* %arrayidx124.11, align 4
  br label %for.inc.11

if.then.11:                                       ; preds = %for.body4.11
  %arrayidx.11 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %299
  store i32 0, i32* %arrayidx.11, align 4
  br label %for.inc.11

for.inc.11:                                       ; preds = %if.then.11, %if.else122.11, %if.then116.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %img_width
  br i1 %exitcond.11, label %for.inc127.11, label %for.body4.11, !llvm.loop !1

for.inc127.11:                                    ; preds = %for.inc.11
  %indvars.iv.next20.11 = add nsw i64 %indvars.iv19, 12
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.12

for.body4.lr.ph.12:                               ; preds = %for.inc127.11
  %316 = trunc i64 %indvars.iv.next20.11 to i32
  %mul.12 = shl nsw i32 %316, 7
  %cmp6.12 = icmp eq i64 %indvars.iv.next20.11, %1
  %add33.12 = or i32 %mul.12, 1
  %sub38.12 = add i32 %mul.12, -1
  %317 = trunc i64 %indvars.iv.next20.11 to i32
  %add51.12 = shl i32 %317, 7
  %318 = trunc i64 %indvars.iv.next20.11 to i32
  %add72.12 = shl i32 %318, 7
  %mul73.12 = add i32 %add72.12, 128
  %mul78.12 = add i32 %add72.12, -128
  %319 = trunc i64 %indvars.iv.next20.11 to i32
  %sub91.12 = shl i32 %319, 7
  %320 = sext i32 %mul.12 to i64
  %321 = sext i32 %mul78.12 to i64
  %322 = sext i32 %mul73.12 to i64
  br label %for.body4.12

for.body4.12:                                     ; preds = %for.inc.12, %for.body4.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body4.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc.12 ]
  %323 = add nsw i64 %indvars.iv.12, %320
  %cmp8.12 = icmp eq i64 %indvars.iv.12, 0
  %or.cond1.12 = or i1 %cmp6.12, %cmp8.12
  %cmp10.12 = icmp eq i64 %indvars.iv.12, %0
  %or.cond2.12 = or i1 %cmp10.12, %or.cond1.12
  br i1 %or.cond2.12, label %if.then.12, label %if.else.12

if.else.12:                                       ; preds = %for.body4.12
  %arrayidx12.12 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %323
  %324 = load float, float* %arrayidx12.12, align 4
  %conv.12 = fpext float %324 to double
  %mul13.12 = fmul double %conv.12, 0x404CA5DC1A63C1F8
  %conv14.12 = fptrunc double %mul13.12 to float
  %cmp15.12 = fcmp olt float %conv14.12, 0.000000e+00
  %add18.12 = fadd float %conv14.12, 1.800000e+02
  %angle.0.12 = select i1 %cmp15.12, float %add18.12, float %conv14.12
  %cmp19.12 = fcmp oge float %angle.0.12, 0.000000e+00
  %cmp22.12 = fcmp olt float %angle.0.12, 2.250000e+01
  %or.cond3.12 = and i1 %cmp19.12, %cmp22.12
  br i1 %or.cond3.12, label %if.then31.12, label %lor.lhs.false24.12

lor.lhs.false24.12:                               ; preds = %if.else.12
  %cmp26.12 = fcmp ult float %angle.0.12, 1.575000e+02
  %cmp29.12 = fcmp ugt float %angle.0.12, 1.800000e+02
  %or.cond4.12 = or i1 %cmp26.12, %cmp29.12
  br i1 %or.cond4.12, label %if.else42.12, label %if.then31.12

if.else42.12:                                     ; preds = %lor.lhs.false24.12
  %cmp44.12 = fcmp oge float %angle.0.12, 2.250000e+01
  %cmp48.12 = fcmp olt float %angle.0.12, 6.750000e+01
  %or.cond5.12 = and i1 %cmp44.12, %cmp48.12
  br i1 %or.cond5.12, label %if.then50.12, label %if.else63.12

if.else63.12:                                     ; preds = %if.else42.12
  %cmp65.12 = fcmp oge float %angle.0.12, 6.750000e+01
  %cmp69.12 = fcmp olt float %angle.0.12, 1.125000e+02
  %or.cond6.12 = and i1 %cmp65.12, %cmp69.12
  br i1 %or.cond6.12, label %if.then71.12, label %if.else82.12

if.else82.12:                                     ; preds = %if.else63.12
  %cmp84.12 = fcmp oge float %angle.0.12, 1.125000e+02
  %cmp88.12 = fcmp olt float %angle.0.12, 1.575000e+02
  %or.cond7.12 = and i1 %cmp84.12, %cmp88.12
  br i1 %or.cond7.12, label %if.then90.12, label %if.end106.12

if.then90.12:                                     ; preds = %if.else82.12
  %325 = trunc i64 %indvars.iv.12 to i32
  %sub93.12 = add i32 %325, %sub91.12
  %add94.12 = add i32 %sub93.12, -129
  %idxprom95.12 = sext i32 %add94.12 to i64
  %arrayidx96.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.12
  %326 = load float, float* %arrayidx96.12, align 4
  %add100.12 = add i32 %sub93.12, 129
  %idxprom101.12 = sext i32 %add100.12 to i64
  %arrayidx102.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.12
  %327 = load float, float* %arrayidx102.12, align 4
  br label %if.end106.12

if.then71.12:                                     ; preds = %if.else63.12
  %328 = add nsw i64 %322, %indvars.iv.12
  %arrayidx76.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %328
  %329 = load float, float* %arrayidx76.12, align 4
  %330 = add nsw i64 %321, %indvars.iv.12
  %arrayidx81.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %330
  %331 = load float, float* %arrayidx81.12, align 4
  br label %if.end106.12

if.then50.12:                                     ; preds = %if.else42.12
  %332 = trunc i64 %indvars.iv.12 to i32
  %sub53.12 = add i32 %332, %add51.12
  %add54.12 = add i32 %sub53.12, 127
  %idxprom55.12 = sext i32 %add54.12 to i64
  %arrayidx56.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.12
  %333 = load float, float* %arrayidx56.12, align 4
  %add60.12 = add i32 %sub53.12, -127
  %idxprom61.12 = sext i32 %add60.12 to i64
  %arrayidx62.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.12
  %334 = load float, float* %arrayidx62.12, align 4
  br label %if.end106.12

if.then31.12:                                     ; preds = %lor.lhs.false24.12, %if.else.12
  %335 = trunc i64 %indvars.iv.12 to i32
  %add34.12 = add i32 %add33.12, %335
  %idxprom35.12 = sext i32 %add34.12 to i64
  %arrayidx36.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.12
  %336 = load float, float* %arrayidx36.12, align 4
  %337 = trunc i64 %indvars.iv.12 to i32
  %add39.12 = add i32 %sub38.12, %337
  %idxprom40.12 = sext i32 %add39.12 to i64
  %arrayidx41.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.12
  %338 = load float, float* %arrayidx41.12, align 4
  br label %if.end106.12

if.end106.12:                                     ; preds = %if.then31.12, %if.then50.12, %if.then71.12, %if.then90.12, %if.else82.12
  %q.3.12 = phi float [ %336, %if.then31.12 ], [ %333, %if.then50.12 ], [ %329, %if.then71.12 ], [ %326, %if.then90.12 ], [ 2.550000e+02, %if.else82.12 ]
  %r.3.12 = phi float [ %338, %if.then31.12 ], [ %334, %if.then50.12 ], [ %331, %if.then71.12 ], [ %327, %if.then90.12 ], [ 2.550000e+02, %if.else82.12 ]
  %arrayidx108.12 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %323
  %339 = load float, float* %arrayidx108.12, align 4
  %cmp109.12 = fcmp ult float %339, %q.3.12
  %cmp114.12 = fcmp ult float %339, %r.3.12
  %or.cond8.12 = or i1 %cmp109.12, %cmp114.12
  br i1 %or.cond8.12, label %if.else122.12, label %if.then116.12

if.then116.12:                                    ; preds = %if.end106.12
  %conv119.12 = fptoui float %339 to i32
  %arrayidx121.12 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %323
  store i32 %conv119.12, i32* %arrayidx121.12, align 4
  br label %for.inc.12

if.else122.12:                                    ; preds = %if.end106.12
  %arrayidx124.12 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %323
  store i32 0, i32* %arrayidx124.12, align 4
  br label %for.inc.12

if.then.12:                                       ; preds = %for.body4.12
  %arrayidx.12 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %323
  store i32 0, i32* %arrayidx.12, align 4
  br label %for.inc.12

for.inc.12:                                       ; preds = %if.then.12, %if.else122.12, %if.then116.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %img_width
  br i1 %exitcond.12, label %for.inc127.12, label %for.body4.12, !llvm.loop !1

for.inc127.12:                                    ; preds = %for.inc.12
  %indvars.iv.next20.12 = add nsw i64 %indvars.iv19, 13
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.13

for.body4.lr.ph.13:                               ; preds = %for.inc127.12
  %340 = trunc i64 %indvars.iv.next20.12 to i32
  %mul.13 = shl nsw i32 %340, 7
  %cmp6.13 = icmp eq i64 %indvars.iv.next20.12, %1
  %add33.13 = or i32 %mul.13, 1
  %sub38.13 = add i32 %mul.13, -1
  %341 = trunc i64 %indvars.iv.next20.12 to i32
  %add51.13 = shl i32 %341, 7
  %342 = trunc i64 %indvars.iv.next20.12 to i32
  %add72.13 = shl i32 %342, 7
  %mul73.13 = add i32 %add72.13, 128
  %mul78.13 = add i32 %add72.13, -128
  %343 = trunc i64 %indvars.iv.next20.12 to i32
  %sub91.13 = shl i32 %343, 7
  %344 = sext i32 %mul.13 to i64
  %345 = sext i32 %mul78.13 to i64
  %346 = sext i32 %mul73.13 to i64
  br label %for.body4.13

for.body4.13:                                     ; preds = %for.inc.13, %for.body4.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body4.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc.13 ]
  %347 = add nsw i64 %indvars.iv.13, %344
  %cmp8.13 = icmp eq i64 %indvars.iv.13, 0
  %or.cond1.13 = or i1 %cmp6.13, %cmp8.13
  %cmp10.13 = icmp eq i64 %indvars.iv.13, %0
  %or.cond2.13 = or i1 %cmp10.13, %or.cond1.13
  br i1 %or.cond2.13, label %if.then.13, label %if.else.13

if.else.13:                                       ; preds = %for.body4.13
  %arrayidx12.13 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %347
  %348 = load float, float* %arrayidx12.13, align 4
  %conv.13 = fpext float %348 to double
  %mul13.13 = fmul double %conv.13, 0x404CA5DC1A63C1F8
  %conv14.13 = fptrunc double %mul13.13 to float
  %cmp15.13 = fcmp olt float %conv14.13, 0.000000e+00
  %add18.13 = fadd float %conv14.13, 1.800000e+02
  %angle.0.13 = select i1 %cmp15.13, float %add18.13, float %conv14.13
  %cmp19.13 = fcmp oge float %angle.0.13, 0.000000e+00
  %cmp22.13 = fcmp olt float %angle.0.13, 2.250000e+01
  %or.cond3.13 = and i1 %cmp19.13, %cmp22.13
  br i1 %or.cond3.13, label %if.then31.13, label %lor.lhs.false24.13

lor.lhs.false24.13:                               ; preds = %if.else.13
  %cmp26.13 = fcmp ult float %angle.0.13, 1.575000e+02
  %cmp29.13 = fcmp ugt float %angle.0.13, 1.800000e+02
  %or.cond4.13 = or i1 %cmp26.13, %cmp29.13
  br i1 %or.cond4.13, label %if.else42.13, label %if.then31.13

if.else42.13:                                     ; preds = %lor.lhs.false24.13
  %cmp44.13 = fcmp oge float %angle.0.13, 2.250000e+01
  %cmp48.13 = fcmp olt float %angle.0.13, 6.750000e+01
  %or.cond5.13 = and i1 %cmp44.13, %cmp48.13
  br i1 %or.cond5.13, label %if.then50.13, label %if.else63.13

if.else63.13:                                     ; preds = %if.else42.13
  %cmp65.13 = fcmp oge float %angle.0.13, 6.750000e+01
  %cmp69.13 = fcmp olt float %angle.0.13, 1.125000e+02
  %or.cond6.13 = and i1 %cmp65.13, %cmp69.13
  br i1 %or.cond6.13, label %if.then71.13, label %if.else82.13

if.else82.13:                                     ; preds = %if.else63.13
  %cmp84.13 = fcmp oge float %angle.0.13, 1.125000e+02
  %cmp88.13 = fcmp olt float %angle.0.13, 1.575000e+02
  %or.cond7.13 = and i1 %cmp84.13, %cmp88.13
  br i1 %or.cond7.13, label %if.then90.13, label %if.end106.13

if.then90.13:                                     ; preds = %if.else82.13
  %349 = trunc i64 %indvars.iv.13 to i32
  %sub93.13 = add i32 %349, %sub91.13
  %add94.13 = add i32 %sub93.13, -129
  %idxprom95.13 = sext i32 %add94.13 to i64
  %arrayidx96.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.13
  %350 = load float, float* %arrayidx96.13, align 4
  %add100.13 = add i32 %sub93.13, 129
  %idxprom101.13 = sext i32 %add100.13 to i64
  %arrayidx102.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.13
  %351 = load float, float* %arrayidx102.13, align 4
  br label %if.end106.13

if.then71.13:                                     ; preds = %if.else63.13
  %352 = add nsw i64 %346, %indvars.iv.13
  %arrayidx76.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %352
  %353 = load float, float* %arrayidx76.13, align 4
  %354 = add nsw i64 %345, %indvars.iv.13
  %arrayidx81.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %354
  %355 = load float, float* %arrayidx81.13, align 4
  br label %if.end106.13

if.then50.13:                                     ; preds = %if.else42.13
  %356 = trunc i64 %indvars.iv.13 to i32
  %sub53.13 = add i32 %356, %add51.13
  %add54.13 = add i32 %sub53.13, 127
  %idxprom55.13 = sext i32 %add54.13 to i64
  %arrayidx56.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.13
  %357 = load float, float* %arrayidx56.13, align 4
  %add60.13 = add i32 %sub53.13, -127
  %idxprom61.13 = sext i32 %add60.13 to i64
  %arrayidx62.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.13
  %358 = load float, float* %arrayidx62.13, align 4
  br label %if.end106.13

if.then31.13:                                     ; preds = %lor.lhs.false24.13, %if.else.13
  %359 = trunc i64 %indvars.iv.13 to i32
  %add34.13 = add i32 %add33.13, %359
  %idxprom35.13 = sext i32 %add34.13 to i64
  %arrayidx36.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.13
  %360 = load float, float* %arrayidx36.13, align 4
  %361 = trunc i64 %indvars.iv.13 to i32
  %add39.13 = add i32 %sub38.13, %361
  %idxprom40.13 = sext i32 %add39.13 to i64
  %arrayidx41.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.13
  %362 = load float, float* %arrayidx41.13, align 4
  br label %if.end106.13

if.end106.13:                                     ; preds = %if.then31.13, %if.then50.13, %if.then71.13, %if.then90.13, %if.else82.13
  %q.3.13 = phi float [ %360, %if.then31.13 ], [ %357, %if.then50.13 ], [ %353, %if.then71.13 ], [ %350, %if.then90.13 ], [ 2.550000e+02, %if.else82.13 ]
  %r.3.13 = phi float [ %362, %if.then31.13 ], [ %358, %if.then50.13 ], [ %355, %if.then71.13 ], [ %351, %if.then90.13 ], [ 2.550000e+02, %if.else82.13 ]
  %arrayidx108.13 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %347
  %363 = load float, float* %arrayidx108.13, align 4
  %cmp109.13 = fcmp ult float %363, %q.3.13
  %cmp114.13 = fcmp ult float %363, %r.3.13
  %or.cond8.13 = or i1 %cmp109.13, %cmp114.13
  br i1 %or.cond8.13, label %if.else122.13, label %if.then116.13

if.then116.13:                                    ; preds = %if.end106.13
  %conv119.13 = fptoui float %363 to i32
  %arrayidx121.13 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %347
  store i32 %conv119.13, i32* %arrayidx121.13, align 4
  br label %for.inc.13

if.else122.13:                                    ; preds = %if.end106.13
  %arrayidx124.13 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %347
  store i32 0, i32* %arrayidx124.13, align 4
  br label %for.inc.13

if.then.13:                                       ; preds = %for.body4.13
  %arrayidx.13 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %347
  store i32 0, i32* %arrayidx.13, align 4
  br label %for.inc.13

for.inc.13:                                       ; preds = %if.then.13, %if.else122.13, %if.then116.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %img_width
  br i1 %exitcond.13, label %for.inc127.13, label %for.body4.13, !llvm.loop !1

for.inc127.13:                                    ; preds = %for.inc.13
  %indvars.iv.next20.13 = add nsw i64 %indvars.iv19, 14
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.14

for.body4.lr.ph.14:                               ; preds = %for.inc127.13
  %364 = trunc i64 %indvars.iv.next20.13 to i32
  %mul.14 = shl nsw i32 %364, 7
  %cmp6.14 = icmp eq i64 %indvars.iv.next20.13, %1
  %add33.14 = or i32 %mul.14, 1
  %sub38.14 = add i32 %mul.14, -1
  %365 = trunc i64 %indvars.iv.next20.13 to i32
  %add51.14 = shl i32 %365, 7
  %366 = trunc i64 %indvars.iv.next20.13 to i32
  %add72.14 = shl i32 %366, 7
  %mul73.14 = add i32 %add72.14, 128
  %mul78.14 = add i32 %add72.14, -128
  %367 = trunc i64 %indvars.iv.next20.13 to i32
  %sub91.14 = shl i32 %367, 7
  %368 = sext i32 %mul.14 to i64
  %369 = sext i32 %mul78.14 to i64
  %370 = sext i32 %mul73.14 to i64
  br label %for.body4.14

for.body4.14:                                     ; preds = %for.inc.14, %for.body4.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body4.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc.14 ]
  %371 = add nsw i64 %indvars.iv.14, %368
  %cmp8.14 = icmp eq i64 %indvars.iv.14, 0
  %or.cond1.14 = or i1 %cmp6.14, %cmp8.14
  %cmp10.14 = icmp eq i64 %indvars.iv.14, %0
  %or.cond2.14 = or i1 %cmp10.14, %or.cond1.14
  br i1 %or.cond2.14, label %if.then.14, label %if.else.14

if.else.14:                                       ; preds = %for.body4.14
  %arrayidx12.14 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %371
  %372 = load float, float* %arrayidx12.14, align 4
  %conv.14 = fpext float %372 to double
  %mul13.14 = fmul double %conv.14, 0x404CA5DC1A63C1F8
  %conv14.14 = fptrunc double %mul13.14 to float
  %cmp15.14 = fcmp olt float %conv14.14, 0.000000e+00
  %add18.14 = fadd float %conv14.14, 1.800000e+02
  %angle.0.14 = select i1 %cmp15.14, float %add18.14, float %conv14.14
  %cmp19.14 = fcmp oge float %angle.0.14, 0.000000e+00
  %cmp22.14 = fcmp olt float %angle.0.14, 2.250000e+01
  %or.cond3.14 = and i1 %cmp19.14, %cmp22.14
  br i1 %or.cond3.14, label %if.then31.14, label %lor.lhs.false24.14

lor.lhs.false24.14:                               ; preds = %if.else.14
  %cmp26.14 = fcmp ult float %angle.0.14, 1.575000e+02
  %cmp29.14 = fcmp ugt float %angle.0.14, 1.800000e+02
  %or.cond4.14 = or i1 %cmp26.14, %cmp29.14
  br i1 %or.cond4.14, label %if.else42.14, label %if.then31.14

if.else42.14:                                     ; preds = %lor.lhs.false24.14
  %cmp44.14 = fcmp oge float %angle.0.14, 2.250000e+01
  %cmp48.14 = fcmp olt float %angle.0.14, 6.750000e+01
  %or.cond5.14 = and i1 %cmp44.14, %cmp48.14
  br i1 %or.cond5.14, label %if.then50.14, label %if.else63.14

if.else63.14:                                     ; preds = %if.else42.14
  %cmp65.14 = fcmp oge float %angle.0.14, 6.750000e+01
  %cmp69.14 = fcmp olt float %angle.0.14, 1.125000e+02
  %or.cond6.14 = and i1 %cmp65.14, %cmp69.14
  br i1 %or.cond6.14, label %if.then71.14, label %if.else82.14

if.else82.14:                                     ; preds = %if.else63.14
  %cmp84.14 = fcmp oge float %angle.0.14, 1.125000e+02
  %cmp88.14 = fcmp olt float %angle.0.14, 1.575000e+02
  %or.cond7.14 = and i1 %cmp84.14, %cmp88.14
  br i1 %or.cond7.14, label %if.then90.14, label %if.end106.14

if.then90.14:                                     ; preds = %if.else82.14
  %373 = trunc i64 %indvars.iv.14 to i32
  %sub93.14 = add i32 %373, %sub91.14
  %add94.14 = add i32 %sub93.14, -129
  %idxprom95.14 = sext i32 %add94.14 to i64
  %arrayidx96.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.14
  %374 = load float, float* %arrayidx96.14, align 4
  %add100.14 = add i32 %sub93.14, 129
  %idxprom101.14 = sext i32 %add100.14 to i64
  %arrayidx102.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.14
  %375 = load float, float* %arrayidx102.14, align 4
  br label %if.end106.14

if.then71.14:                                     ; preds = %if.else63.14
  %376 = add nsw i64 %370, %indvars.iv.14
  %arrayidx76.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %376
  %377 = load float, float* %arrayidx76.14, align 4
  %378 = add nsw i64 %369, %indvars.iv.14
  %arrayidx81.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %378
  %379 = load float, float* %arrayidx81.14, align 4
  br label %if.end106.14

if.then50.14:                                     ; preds = %if.else42.14
  %380 = trunc i64 %indvars.iv.14 to i32
  %sub53.14 = add i32 %380, %add51.14
  %add54.14 = add i32 %sub53.14, 127
  %idxprom55.14 = sext i32 %add54.14 to i64
  %arrayidx56.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.14
  %381 = load float, float* %arrayidx56.14, align 4
  %add60.14 = add i32 %sub53.14, -127
  %idxprom61.14 = sext i32 %add60.14 to i64
  %arrayidx62.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.14
  %382 = load float, float* %arrayidx62.14, align 4
  br label %if.end106.14

if.then31.14:                                     ; preds = %lor.lhs.false24.14, %if.else.14
  %383 = trunc i64 %indvars.iv.14 to i32
  %add34.14 = add i32 %add33.14, %383
  %idxprom35.14 = sext i32 %add34.14 to i64
  %arrayidx36.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.14
  %384 = load float, float* %arrayidx36.14, align 4
  %385 = trunc i64 %indvars.iv.14 to i32
  %add39.14 = add i32 %sub38.14, %385
  %idxprom40.14 = sext i32 %add39.14 to i64
  %arrayidx41.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.14
  %386 = load float, float* %arrayidx41.14, align 4
  br label %if.end106.14

if.end106.14:                                     ; preds = %if.then31.14, %if.then50.14, %if.then71.14, %if.then90.14, %if.else82.14
  %q.3.14 = phi float [ %384, %if.then31.14 ], [ %381, %if.then50.14 ], [ %377, %if.then71.14 ], [ %374, %if.then90.14 ], [ 2.550000e+02, %if.else82.14 ]
  %r.3.14 = phi float [ %386, %if.then31.14 ], [ %382, %if.then50.14 ], [ %379, %if.then71.14 ], [ %375, %if.then90.14 ], [ 2.550000e+02, %if.else82.14 ]
  %arrayidx108.14 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %371
  %387 = load float, float* %arrayidx108.14, align 4
  %cmp109.14 = fcmp ult float %387, %q.3.14
  %cmp114.14 = fcmp ult float %387, %r.3.14
  %or.cond8.14 = or i1 %cmp109.14, %cmp114.14
  br i1 %or.cond8.14, label %if.else122.14, label %if.then116.14

if.then116.14:                                    ; preds = %if.end106.14
  %conv119.14 = fptoui float %387 to i32
  %arrayidx121.14 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %371
  store i32 %conv119.14, i32* %arrayidx121.14, align 4
  br label %for.inc.14

if.else122.14:                                    ; preds = %if.end106.14
  %arrayidx124.14 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %371
  store i32 0, i32* %arrayidx124.14, align 4
  br label %for.inc.14

if.then.14:                                       ; preds = %for.body4.14
  %arrayidx.14 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %371
  store i32 0, i32* %arrayidx.14, align 4
  br label %for.inc.14

for.inc.14:                                       ; preds = %if.then.14, %if.else122.14, %if.then116.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %img_width
  br i1 %exitcond.14, label %for.inc127.14, label %for.body4.14, !llvm.loop !1

for.inc127.14:                                    ; preds = %for.inc.14
  %indvars.iv.next20.14 = add nsw i64 %indvars.iv19, 15
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.15

for.body4.lr.ph.15:                               ; preds = %for.inc127.14
  %388 = trunc i64 %indvars.iv.next20.14 to i32
  %mul.15 = shl nsw i32 %388, 7
  %cmp6.15 = icmp eq i64 %indvars.iv.next20.14, %1
  %add33.15 = or i32 %mul.15, 1
  %sub38.15 = add i32 %mul.15, -1
  %389 = trunc i64 %indvars.iv.next20.14 to i32
  %add51.15 = shl i32 %389, 7
  %390 = trunc i64 %indvars.iv.next20.14 to i32
  %add72.15 = shl i32 %390, 7
  %mul73.15 = add i32 %add72.15, 128
  %mul78.15 = add i32 %add72.15, -128
  %391 = trunc i64 %indvars.iv.next20.14 to i32
  %sub91.15 = shl i32 %391, 7
  %392 = sext i32 %mul.15 to i64
  %393 = sext i32 %mul78.15 to i64
  %394 = sext i32 %mul73.15 to i64
  br label %for.body4.15

for.body4.15:                                     ; preds = %for.inc.15, %for.body4.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body4.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc.15 ]
  %395 = add nsw i64 %indvars.iv.15, %392
  %cmp8.15 = icmp eq i64 %indvars.iv.15, 0
  %or.cond1.15 = or i1 %cmp6.15, %cmp8.15
  %cmp10.15 = icmp eq i64 %indvars.iv.15, %0
  %or.cond2.15 = or i1 %cmp10.15, %or.cond1.15
  br i1 %or.cond2.15, label %if.then.15, label %if.else.15

if.else.15:                                       ; preds = %for.body4.15
  %arrayidx12.15 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %395
  %396 = load float, float* %arrayidx12.15, align 4
  %conv.15 = fpext float %396 to double
  %mul13.15 = fmul double %conv.15, 0x404CA5DC1A63C1F8
  %conv14.15 = fptrunc double %mul13.15 to float
  %cmp15.15 = fcmp olt float %conv14.15, 0.000000e+00
  %add18.15 = fadd float %conv14.15, 1.800000e+02
  %angle.0.15 = select i1 %cmp15.15, float %add18.15, float %conv14.15
  %cmp19.15 = fcmp oge float %angle.0.15, 0.000000e+00
  %cmp22.15 = fcmp olt float %angle.0.15, 2.250000e+01
  %or.cond3.15 = and i1 %cmp19.15, %cmp22.15
  br i1 %or.cond3.15, label %if.then31.15, label %lor.lhs.false24.15

lor.lhs.false24.15:                               ; preds = %if.else.15
  %cmp26.15 = fcmp ult float %angle.0.15, 1.575000e+02
  %cmp29.15 = fcmp ugt float %angle.0.15, 1.800000e+02
  %or.cond4.15 = or i1 %cmp26.15, %cmp29.15
  br i1 %or.cond4.15, label %if.else42.15, label %if.then31.15

if.else42.15:                                     ; preds = %lor.lhs.false24.15
  %cmp44.15 = fcmp oge float %angle.0.15, 2.250000e+01
  %cmp48.15 = fcmp olt float %angle.0.15, 6.750000e+01
  %or.cond5.15 = and i1 %cmp44.15, %cmp48.15
  br i1 %or.cond5.15, label %if.then50.15, label %if.else63.15

if.else63.15:                                     ; preds = %if.else42.15
  %cmp65.15 = fcmp oge float %angle.0.15, 6.750000e+01
  %cmp69.15 = fcmp olt float %angle.0.15, 1.125000e+02
  %or.cond6.15 = and i1 %cmp65.15, %cmp69.15
  br i1 %or.cond6.15, label %if.then71.15, label %if.else82.15

if.else82.15:                                     ; preds = %if.else63.15
  %cmp84.15 = fcmp oge float %angle.0.15, 1.125000e+02
  %cmp88.15 = fcmp olt float %angle.0.15, 1.575000e+02
  %or.cond7.15 = and i1 %cmp84.15, %cmp88.15
  br i1 %or.cond7.15, label %if.then90.15, label %if.end106.15

if.then90.15:                                     ; preds = %if.else82.15
  %397 = trunc i64 %indvars.iv.15 to i32
  %sub93.15 = add i32 %397, %sub91.15
  %add94.15 = add i32 %sub93.15, -129
  %idxprom95.15 = sext i32 %add94.15 to i64
  %arrayidx96.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.15
  %398 = load float, float* %arrayidx96.15, align 4
  %add100.15 = add i32 %sub93.15, 129
  %idxprom101.15 = sext i32 %add100.15 to i64
  %arrayidx102.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.15
  %399 = load float, float* %arrayidx102.15, align 4
  br label %if.end106.15

if.then71.15:                                     ; preds = %if.else63.15
  %400 = add nsw i64 %394, %indvars.iv.15
  %arrayidx76.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %400
  %401 = load float, float* %arrayidx76.15, align 4
  %402 = add nsw i64 %393, %indvars.iv.15
  %arrayidx81.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %402
  %403 = load float, float* %arrayidx81.15, align 4
  br label %if.end106.15

if.then50.15:                                     ; preds = %if.else42.15
  %404 = trunc i64 %indvars.iv.15 to i32
  %sub53.15 = add i32 %404, %add51.15
  %add54.15 = add i32 %sub53.15, 127
  %idxprom55.15 = sext i32 %add54.15 to i64
  %arrayidx56.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.15
  %405 = load float, float* %arrayidx56.15, align 4
  %add60.15 = add i32 %sub53.15, -127
  %idxprom61.15 = sext i32 %add60.15 to i64
  %arrayidx62.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.15
  %406 = load float, float* %arrayidx62.15, align 4
  br label %if.end106.15

if.then31.15:                                     ; preds = %lor.lhs.false24.15, %if.else.15
  %407 = trunc i64 %indvars.iv.15 to i32
  %add34.15 = add i32 %add33.15, %407
  %idxprom35.15 = sext i32 %add34.15 to i64
  %arrayidx36.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.15
  %408 = load float, float* %arrayidx36.15, align 4
  %409 = trunc i64 %indvars.iv.15 to i32
  %add39.15 = add i32 %sub38.15, %409
  %idxprom40.15 = sext i32 %add39.15 to i64
  %arrayidx41.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.15
  %410 = load float, float* %arrayidx41.15, align 4
  br label %if.end106.15

if.end106.15:                                     ; preds = %if.then31.15, %if.then50.15, %if.then71.15, %if.then90.15, %if.else82.15
  %q.3.15 = phi float [ %408, %if.then31.15 ], [ %405, %if.then50.15 ], [ %401, %if.then71.15 ], [ %398, %if.then90.15 ], [ 2.550000e+02, %if.else82.15 ]
  %r.3.15 = phi float [ %410, %if.then31.15 ], [ %406, %if.then50.15 ], [ %403, %if.then71.15 ], [ %399, %if.then90.15 ], [ 2.550000e+02, %if.else82.15 ]
  %arrayidx108.15 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %395
  %411 = load float, float* %arrayidx108.15, align 4
  %cmp109.15 = fcmp ult float %411, %q.3.15
  %cmp114.15 = fcmp ult float %411, %r.3.15
  %or.cond8.15 = or i1 %cmp109.15, %cmp114.15
  br i1 %or.cond8.15, label %if.else122.15, label %if.then116.15

if.then116.15:                                    ; preds = %if.end106.15
  %conv119.15 = fptoui float %411 to i32
  %arrayidx121.15 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %395
  store i32 %conv119.15, i32* %arrayidx121.15, align 4
  br label %for.inc.15

if.else122.15:                                    ; preds = %if.end106.15
  %arrayidx124.15 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %395
  store i32 0, i32* %arrayidx124.15, align 4
  br label %for.inc.15

if.then.15:                                       ; preds = %for.body4.15
  %arrayidx.15 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %395
  store i32 0, i32* %arrayidx.15, align 4
  br label %for.inc.15

for.inc.15:                                       ; preds = %if.then.15, %if.else122.15, %if.then116.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %img_width
  br i1 %exitcond.15, label %for.inc127.15, label %for.body4.15, !llvm.loop !1

for.inc127.15:                                    ; preds = %for.inc.15
  %indvars.iv.next20.15 = add nsw i64 %indvars.iv19, 16
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.16

for.body4.lr.ph.16:                               ; preds = %for.inc127.15
  %412 = trunc i64 %indvars.iv.next20.15 to i32
  %mul.16 = shl nsw i32 %412, 7
  %cmp6.16 = icmp eq i64 %indvars.iv.next20.15, %1
  %add33.16 = or i32 %mul.16, 1
  %sub38.16 = add i32 %mul.16, -1
  %413 = trunc i64 %indvars.iv.next20.15 to i32
  %add51.16 = shl i32 %413, 7
  %414 = trunc i64 %indvars.iv.next20.15 to i32
  %add72.16 = shl i32 %414, 7
  %mul73.16 = add i32 %add72.16, 128
  %mul78.16 = add i32 %add72.16, -128
  %415 = trunc i64 %indvars.iv.next20.15 to i32
  %sub91.16 = shl i32 %415, 7
  %416 = sext i32 %mul.16 to i64
  %417 = sext i32 %mul78.16 to i64
  %418 = sext i32 %mul73.16 to i64
  br label %for.body4.16

for.body4.16:                                     ; preds = %for.inc.16, %for.body4.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body4.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc.16 ]
  %419 = add nsw i64 %indvars.iv.16, %416
  %cmp8.16 = icmp eq i64 %indvars.iv.16, 0
  %or.cond1.16 = or i1 %cmp6.16, %cmp8.16
  %cmp10.16 = icmp eq i64 %indvars.iv.16, %0
  %or.cond2.16 = or i1 %cmp10.16, %or.cond1.16
  br i1 %or.cond2.16, label %if.then.16, label %if.else.16

if.else.16:                                       ; preds = %for.body4.16
  %arrayidx12.16 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %419
  %420 = load float, float* %arrayidx12.16, align 4
  %conv.16 = fpext float %420 to double
  %mul13.16 = fmul double %conv.16, 0x404CA5DC1A63C1F8
  %conv14.16 = fptrunc double %mul13.16 to float
  %cmp15.16 = fcmp olt float %conv14.16, 0.000000e+00
  %add18.16 = fadd float %conv14.16, 1.800000e+02
  %angle.0.16 = select i1 %cmp15.16, float %add18.16, float %conv14.16
  %cmp19.16 = fcmp oge float %angle.0.16, 0.000000e+00
  %cmp22.16 = fcmp olt float %angle.0.16, 2.250000e+01
  %or.cond3.16 = and i1 %cmp19.16, %cmp22.16
  br i1 %or.cond3.16, label %if.then31.16, label %lor.lhs.false24.16

lor.lhs.false24.16:                               ; preds = %if.else.16
  %cmp26.16 = fcmp ult float %angle.0.16, 1.575000e+02
  %cmp29.16 = fcmp ugt float %angle.0.16, 1.800000e+02
  %or.cond4.16 = or i1 %cmp26.16, %cmp29.16
  br i1 %or.cond4.16, label %if.else42.16, label %if.then31.16

if.else42.16:                                     ; preds = %lor.lhs.false24.16
  %cmp44.16 = fcmp oge float %angle.0.16, 2.250000e+01
  %cmp48.16 = fcmp olt float %angle.0.16, 6.750000e+01
  %or.cond5.16 = and i1 %cmp44.16, %cmp48.16
  br i1 %or.cond5.16, label %if.then50.16, label %if.else63.16

if.else63.16:                                     ; preds = %if.else42.16
  %cmp65.16 = fcmp oge float %angle.0.16, 6.750000e+01
  %cmp69.16 = fcmp olt float %angle.0.16, 1.125000e+02
  %or.cond6.16 = and i1 %cmp65.16, %cmp69.16
  br i1 %or.cond6.16, label %if.then71.16, label %if.else82.16

if.else82.16:                                     ; preds = %if.else63.16
  %cmp84.16 = fcmp oge float %angle.0.16, 1.125000e+02
  %cmp88.16 = fcmp olt float %angle.0.16, 1.575000e+02
  %or.cond7.16 = and i1 %cmp84.16, %cmp88.16
  br i1 %or.cond7.16, label %if.then90.16, label %if.end106.16

if.then90.16:                                     ; preds = %if.else82.16
  %421 = trunc i64 %indvars.iv.16 to i32
  %sub93.16 = add i32 %421, %sub91.16
  %add94.16 = add i32 %sub93.16, -129
  %idxprom95.16 = sext i32 %add94.16 to i64
  %arrayidx96.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.16
  %422 = load float, float* %arrayidx96.16, align 4
  %add100.16 = add i32 %sub93.16, 129
  %idxprom101.16 = sext i32 %add100.16 to i64
  %arrayidx102.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.16
  %423 = load float, float* %arrayidx102.16, align 4
  br label %if.end106.16

if.then71.16:                                     ; preds = %if.else63.16
  %424 = add nsw i64 %418, %indvars.iv.16
  %arrayidx76.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %424
  %425 = load float, float* %arrayidx76.16, align 4
  %426 = add nsw i64 %417, %indvars.iv.16
  %arrayidx81.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %426
  %427 = load float, float* %arrayidx81.16, align 4
  br label %if.end106.16

if.then50.16:                                     ; preds = %if.else42.16
  %428 = trunc i64 %indvars.iv.16 to i32
  %sub53.16 = add i32 %428, %add51.16
  %add54.16 = add i32 %sub53.16, 127
  %idxprom55.16 = sext i32 %add54.16 to i64
  %arrayidx56.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.16
  %429 = load float, float* %arrayidx56.16, align 4
  %add60.16 = add i32 %sub53.16, -127
  %idxprom61.16 = sext i32 %add60.16 to i64
  %arrayidx62.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.16
  %430 = load float, float* %arrayidx62.16, align 4
  br label %if.end106.16

if.then31.16:                                     ; preds = %lor.lhs.false24.16, %if.else.16
  %431 = trunc i64 %indvars.iv.16 to i32
  %add34.16 = add i32 %add33.16, %431
  %idxprom35.16 = sext i32 %add34.16 to i64
  %arrayidx36.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.16
  %432 = load float, float* %arrayidx36.16, align 4
  %433 = trunc i64 %indvars.iv.16 to i32
  %add39.16 = add i32 %sub38.16, %433
  %idxprom40.16 = sext i32 %add39.16 to i64
  %arrayidx41.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.16
  %434 = load float, float* %arrayidx41.16, align 4
  br label %if.end106.16

if.end106.16:                                     ; preds = %if.then31.16, %if.then50.16, %if.then71.16, %if.then90.16, %if.else82.16
  %q.3.16 = phi float [ %432, %if.then31.16 ], [ %429, %if.then50.16 ], [ %425, %if.then71.16 ], [ %422, %if.then90.16 ], [ 2.550000e+02, %if.else82.16 ]
  %r.3.16 = phi float [ %434, %if.then31.16 ], [ %430, %if.then50.16 ], [ %427, %if.then71.16 ], [ %423, %if.then90.16 ], [ 2.550000e+02, %if.else82.16 ]
  %arrayidx108.16 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %419
  %435 = load float, float* %arrayidx108.16, align 4
  %cmp109.16 = fcmp ult float %435, %q.3.16
  %cmp114.16 = fcmp ult float %435, %r.3.16
  %or.cond8.16 = or i1 %cmp109.16, %cmp114.16
  br i1 %or.cond8.16, label %if.else122.16, label %if.then116.16

if.then116.16:                                    ; preds = %if.end106.16
  %conv119.16 = fptoui float %435 to i32
  %arrayidx121.16 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %419
  store i32 %conv119.16, i32* %arrayidx121.16, align 4
  br label %for.inc.16

if.else122.16:                                    ; preds = %if.end106.16
  %arrayidx124.16 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %419
  store i32 0, i32* %arrayidx124.16, align 4
  br label %for.inc.16

if.then.16:                                       ; preds = %for.body4.16
  %arrayidx.16 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %419
  store i32 0, i32* %arrayidx.16, align 4
  br label %for.inc.16

for.inc.16:                                       ; preds = %if.then.16, %if.else122.16, %if.then116.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %img_width
  br i1 %exitcond.16, label %for.inc127.16, label %for.body4.16, !llvm.loop !1

for.inc127.16:                                    ; preds = %for.inc.16
  %indvars.iv.next20.16 = add nsw i64 %indvars.iv19, 17
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.17

for.body4.lr.ph.17:                               ; preds = %for.inc127.16
  %436 = trunc i64 %indvars.iv.next20.16 to i32
  %mul.17 = shl nsw i32 %436, 7
  %cmp6.17 = icmp eq i64 %indvars.iv.next20.16, %1
  %add33.17 = or i32 %mul.17, 1
  %sub38.17 = add i32 %mul.17, -1
  %437 = trunc i64 %indvars.iv.next20.16 to i32
  %add51.17 = shl i32 %437, 7
  %438 = trunc i64 %indvars.iv.next20.16 to i32
  %add72.17 = shl i32 %438, 7
  %mul73.17 = add i32 %add72.17, 128
  %mul78.17 = add i32 %add72.17, -128
  %439 = trunc i64 %indvars.iv.next20.16 to i32
  %sub91.17 = shl i32 %439, 7
  %440 = sext i32 %mul.17 to i64
  %441 = sext i32 %mul78.17 to i64
  %442 = sext i32 %mul73.17 to i64
  br label %for.body4.17

for.body4.17:                                     ; preds = %for.inc.17, %for.body4.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body4.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc.17 ]
  %443 = add nsw i64 %indvars.iv.17, %440
  %cmp8.17 = icmp eq i64 %indvars.iv.17, 0
  %or.cond1.17 = or i1 %cmp6.17, %cmp8.17
  %cmp10.17 = icmp eq i64 %indvars.iv.17, %0
  %or.cond2.17 = or i1 %cmp10.17, %or.cond1.17
  br i1 %or.cond2.17, label %if.then.17, label %if.else.17

if.else.17:                                       ; preds = %for.body4.17
  %arrayidx12.17 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %443
  %444 = load float, float* %arrayidx12.17, align 4
  %conv.17 = fpext float %444 to double
  %mul13.17 = fmul double %conv.17, 0x404CA5DC1A63C1F8
  %conv14.17 = fptrunc double %mul13.17 to float
  %cmp15.17 = fcmp olt float %conv14.17, 0.000000e+00
  %add18.17 = fadd float %conv14.17, 1.800000e+02
  %angle.0.17 = select i1 %cmp15.17, float %add18.17, float %conv14.17
  %cmp19.17 = fcmp oge float %angle.0.17, 0.000000e+00
  %cmp22.17 = fcmp olt float %angle.0.17, 2.250000e+01
  %or.cond3.17 = and i1 %cmp19.17, %cmp22.17
  br i1 %or.cond3.17, label %if.then31.17, label %lor.lhs.false24.17

lor.lhs.false24.17:                               ; preds = %if.else.17
  %cmp26.17 = fcmp ult float %angle.0.17, 1.575000e+02
  %cmp29.17 = fcmp ugt float %angle.0.17, 1.800000e+02
  %or.cond4.17 = or i1 %cmp26.17, %cmp29.17
  br i1 %or.cond4.17, label %if.else42.17, label %if.then31.17

if.else42.17:                                     ; preds = %lor.lhs.false24.17
  %cmp44.17 = fcmp oge float %angle.0.17, 2.250000e+01
  %cmp48.17 = fcmp olt float %angle.0.17, 6.750000e+01
  %or.cond5.17 = and i1 %cmp44.17, %cmp48.17
  br i1 %or.cond5.17, label %if.then50.17, label %if.else63.17

if.else63.17:                                     ; preds = %if.else42.17
  %cmp65.17 = fcmp oge float %angle.0.17, 6.750000e+01
  %cmp69.17 = fcmp olt float %angle.0.17, 1.125000e+02
  %or.cond6.17 = and i1 %cmp65.17, %cmp69.17
  br i1 %or.cond6.17, label %if.then71.17, label %if.else82.17

if.else82.17:                                     ; preds = %if.else63.17
  %cmp84.17 = fcmp oge float %angle.0.17, 1.125000e+02
  %cmp88.17 = fcmp olt float %angle.0.17, 1.575000e+02
  %or.cond7.17 = and i1 %cmp84.17, %cmp88.17
  br i1 %or.cond7.17, label %if.then90.17, label %if.end106.17

if.then90.17:                                     ; preds = %if.else82.17
  %445 = trunc i64 %indvars.iv.17 to i32
  %sub93.17 = add i32 %445, %sub91.17
  %add94.17 = add i32 %sub93.17, -129
  %idxprom95.17 = sext i32 %add94.17 to i64
  %arrayidx96.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.17
  %446 = load float, float* %arrayidx96.17, align 4
  %add100.17 = add i32 %sub93.17, 129
  %idxprom101.17 = sext i32 %add100.17 to i64
  %arrayidx102.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.17
  %447 = load float, float* %arrayidx102.17, align 4
  br label %if.end106.17

if.then71.17:                                     ; preds = %if.else63.17
  %448 = add nsw i64 %442, %indvars.iv.17
  %arrayidx76.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %448
  %449 = load float, float* %arrayidx76.17, align 4
  %450 = add nsw i64 %441, %indvars.iv.17
  %arrayidx81.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %450
  %451 = load float, float* %arrayidx81.17, align 4
  br label %if.end106.17

if.then50.17:                                     ; preds = %if.else42.17
  %452 = trunc i64 %indvars.iv.17 to i32
  %sub53.17 = add i32 %452, %add51.17
  %add54.17 = add i32 %sub53.17, 127
  %idxprom55.17 = sext i32 %add54.17 to i64
  %arrayidx56.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.17
  %453 = load float, float* %arrayidx56.17, align 4
  %add60.17 = add i32 %sub53.17, -127
  %idxprom61.17 = sext i32 %add60.17 to i64
  %arrayidx62.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.17
  %454 = load float, float* %arrayidx62.17, align 4
  br label %if.end106.17

if.then31.17:                                     ; preds = %lor.lhs.false24.17, %if.else.17
  %455 = trunc i64 %indvars.iv.17 to i32
  %add34.17 = add i32 %add33.17, %455
  %idxprom35.17 = sext i32 %add34.17 to i64
  %arrayidx36.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.17
  %456 = load float, float* %arrayidx36.17, align 4
  %457 = trunc i64 %indvars.iv.17 to i32
  %add39.17 = add i32 %sub38.17, %457
  %idxprom40.17 = sext i32 %add39.17 to i64
  %arrayidx41.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.17
  %458 = load float, float* %arrayidx41.17, align 4
  br label %if.end106.17

if.end106.17:                                     ; preds = %if.then31.17, %if.then50.17, %if.then71.17, %if.then90.17, %if.else82.17
  %q.3.17 = phi float [ %456, %if.then31.17 ], [ %453, %if.then50.17 ], [ %449, %if.then71.17 ], [ %446, %if.then90.17 ], [ 2.550000e+02, %if.else82.17 ]
  %r.3.17 = phi float [ %458, %if.then31.17 ], [ %454, %if.then50.17 ], [ %451, %if.then71.17 ], [ %447, %if.then90.17 ], [ 2.550000e+02, %if.else82.17 ]
  %arrayidx108.17 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %443
  %459 = load float, float* %arrayidx108.17, align 4
  %cmp109.17 = fcmp ult float %459, %q.3.17
  %cmp114.17 = fcmp ult float %459, %r.3.17
  %or.cond8.17 = or i1 %cmp109.17, %cmp114.17
  br i1 %or.cond8.17, label %if.else122.17, label %if.then116.17

if.then116.17:                                    ; preds = %if.end106.17
  %conv119.17 = fptoui float %459 to i32
  %arrayidx121.17 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %443
  store i32 %conv119.17, i32* %arrayidx121.17, align 4
  br label %for.inc.17

if.else122.17:                                    ; preds = %if.end106.17
  %arrayidx124.17 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %443
  store i32 0, i32* %arrayidx124.17, align 4
  br label %for.inc.17

if.then.17:                                       ; preds = %for.body4.17
  %arrayidx.17 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %443
  store i32 0, i32* %arrayidx.17, align 4
  br label %for.inc.17

for.inc.17:                                       ; preds = %if.then.17, %if.else122.17, %if.then116.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %img_width
  br i1 %exitcond.17, label %for.inc127.17, label %for.body4.17, !llvm.loop !1

for.inc127.17:                                    ; preds = %for.inc.17
  %indvars.iv.next20.17 = add nsw i64 %indvars.iv19, 18
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.18

for.body4.lr.ph.18:                               ; preds = %for.inc127.17
  %460 = trunc i64 %indvars.iv.next20.17 to i32
  %mul.18 = shl nsw i32 %460, 7
  %cmp6.18 = icmp eq i64 %indvars.iv.next20.17, %1
  %add33.18 = or i32 %mul.18, 1
  %sub38.18 = add i32 %mul.18, -1
  %461 = trunc i64 %indvars.iv.next20.17 to i32
  %add51.18 = shl i32 %461, 7
  %462 = trunc i64 %indvars.iv.next20.17 to i32
  %add72.18 = shl i32 %462, 7
  %mul73.18 = add i32 %add72.18, 128
  %mul78.18 = add i32 %add72.18, -128
  %463 = trunc i64 %indvars.iv.next20.17 to i32
  %sub91.18 = shl i32 %463, 7
  %464 = sext i32 %mul.18 to i64
  %465 = sext i32 %mul78.18 to i64
  %466 = sext i32 %mul73.18 to i64
  br label %for.body4.18

for.body4.18:                                     ; preds = %for.inc.18, %for.body4.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body4.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc.18 ]
  %467 = add nsw i64 %indvars.iv.18, %464
  %cmp8.18 = icmp eq i64 %indvars.iv.18, 0
  %or.cond1.18 = or i1 %cmp6.18, %cmp8.18
  %cmp10.18 = icmp eq i64 %indvars.iv.18, %0
  %or.cond2.18 = or i1 %cmp10.18, %or.cond1.18
  br i1 %or.cond2.18, label %if.then.18, label %if.else.18

if.else.18:                                       ; preds = %for.body4.18
  %arrayidx12.18 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %467
  %468 = load float, float* %arrayidx12.18, align 4
  %conv.18 = fpext float %468 to double
  %mul13.18 = fmul double %conv.18, 0x404CA5DC1A63C1F8
  %conv14.18 = fptrunc double %mul13.18 to float
  %cmp15.18 = fcmp olt float %conv14.18, 0.000000e+00
  %add18.18 = fadd float %conv14.18, 1.800000e+02
  %angle.0.18 = select i1 %cmp15.18, float %add18.18, float %conv14.18
  %cmp19.18 = fcmp oge float %angle.0.18, 0.000000e+00
  %cmp22.18 = fcmp olt float %angle.0.18, 2.250000e+01
  %or.cond3.18 = and i1 %cmp19.18, %cmp22.18
  br i1 %or.cond3.18, label %if.then31.18, label %lor.lhs.false24.18

lor.lhs.false24.18:                               ; preds = %if.else.18
  %cmp26.18 = fcmp ult float %angle.0.18, 1.575000e+02
  %cmp29.18 = fcmp ugt float %angle.0.18, 1.800000e+02
  %or.cond4.18 = or i1 %cmp26.18, %cmp29.18
  br i1 %or.cond4.18, label %if.else42.18, label %if.then31.18

if.else42.18:                                     ; preds = %lor.lhs.false24.18
  %cmp44.18 = fcmp oge float %angle.0.18, 2.250000e+01
  %cmp48.18 = fcmp olt float %angle.0.18, 6.750000e+01
  %or.cond5.18 = and i1 %cmp44.18, %cmp48.18
  br i1 %or.cond5.18, label %if.then50.18, label %if.else63.18

if.else63.18:                                     ; preds = %if.else42.18
  %cmp65.18 = fcmp oge float %angle.0.18, 6.750000e+01
  %cmp69.18 = fcmp olt float %angle.0.18, 1.125000e+02
  %or.cond6.18 = and i1 %cmp65.18, %cmp69.18
  br i1 %or.cond6.18, label %if.then71.18, label %if.else82.18

if.else82.18:                                     ; preds = %if.else63.18
  %cmp84.18 = fcmp oge float %angle.0.18, 1.125000e+02
  %cmp88.18 = fcmp olt float %angle.0.18, 1.575000e+02
  %or.cond7.18 = and i1 %cmp84.18, %cmp88.18
  br i1 %or.cond7.18, label %if.then90.18, label %if.end106.18

if.then90.18:                                     ; preds = %if.else82.18
  %469 = trunc i64 %indvars.iv.18 to i32
  %sub93.18 = add i32 %469, %sub91.18
  %add94.18 = add i32 %sub93.18, -129
  %idxprom95.18 = sext i32 %add94.18 to i64
  %arrayidx96.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.18
  %470 = load float, float* %arrayidx96.18, align 4
  %add100.18 = add i32 %sub93.18, 129
  %idxprom101.18 = sext i32 %add100.18 to i64
  %arrayidx102.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.18
  %471 = load float, float* %arrayidx102.18, align 4
  br label %if.end106.18

if.then71.18:                                     ; preds = %if.else63.18
  %472 = add nsw i64 %466, %indvars.iv.18
  %arrayidx76.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %472
  %473 = load float, float* %arrayidx76.18, align 4
  %474 = add nsw i64 %465, %indvars.iv.18
  %arrayidx81.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %474
  %475 = load float, float* %arrayidx81.18, align 4
  br label %if.end106.18

if.then50.18:                                     ; preds = %if.else42.18
  %476 = trunc i64 %indvars.iv.18 to i32
  %sub53.18 = add i32 %476, %add51.18
  %add54.18 = add i32 %sub53.18, 127
  %idxprom55.18 = sext i32 %add54.18 to i64
  %arrayidx56.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.18
  %477 = load float, float* %arrayidx56.18, align 4
  %add60.18 = add i32 %sub53.18, -127
  %idxprom61.18 = sext i32 %add60.18 to i64
  %arrayidx62.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.18
  %478 = load float, float* %arrayidx62.18, align 4
  br label %if.end106.18

if.then31.18:                                     ; preds = %lor.lhs.false24.18, %if.else.18
  %479 = trunc i64 %indvars.iv.18 to i32
  %add34.18 = add i32 %add33.18, %479
  %idxprom35.18 = sext i32 %add34.18 to i64
  %arrayidx36.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.18
  %480 = load float, float* %arrayidx36.18, align 4
  %481 = trunc i64 %indvars.iv.18 to i32
  %add39.18 = add i32 %sub38.18, %481
  %idxprom40.18 = sext i32 %add39.18 to i64
  %arrayidx41.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.18
  %482 = load float, float* %arrayidx41.18, align 4
  br label %if.end106.18

if.end106.18:                                     ; preds = %if.then31.18, %if.then50.18, %if.then71.18, %if.then90.18, %if.else82.18
  %q.3.18 = phi float [ %480, %if.then31.18 ], [ %477, %if.then50.18 ], [ %473, %if.then71.18 ], [ %470, %if.then90.18 ], [ 2.550000e+02, %if.else82.18 ]
  %r.3.18 = phi float [ %482, %if.then31.18 ], [ %478, %if.then50.18 ], [ %475, %if.then71.18 ], [ %471, %if.then90.18 ], [ 2.550000e+02, %if.else82.18 ]
  %arrayidx108.18 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %467
  %483 = load float, float* %arrayidx108.18, align 4
  %cmp109.18 = fcmp ult float %483, %q.3.18
  %cmp114.18 = fcmp ult float %483, %r.3.18
  %or.cond8.18 = or i1 %cmp109.18, %cmp114.18
  br i1 %or.cond8.18, label %if.else122.18, label %if.then116.18

if.then116.18:                                    ; preds = %if.end106.18
  %conv119.18 = fptoui float %483 to i32
  %arrayidx121.18 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %467
  store i32 %conv119.18, i32* %arrayidx121.18, align 4
  br label %for.inc.18

if.else122.18:                                    ; preds = %if.end106.18
  %arrayidx124.18 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %467
  store i32 0, i32* %arrayidx124.18, align 4
  br label %for.inc.18

if.then.18:                                       ; preds = %for.body4.18
  %arrayidx.18 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %467
  store i32 0, i32* %arrayidx.18, align 4
  br label %for.inc.18

for.inc.18:                                       ; preds = %if.then.18, %if.else122.18, %if.then116.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %img_width
  br i1 %exitcond.18, label %for.inc127.18, label %for.body4.18, !llvm.loop !1

for.inc127.18:                                    ; preds = %for.inc.18
  %indvars.iv.next20.18 = add nsw i64 %indvars.iv19, 19
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.19

for.body4.lr.ph.19:                               ; preds = %for.inc127.18
  %484 = trunc i64 %indvars.iv.next20.18 to i32
  %mul.19 = shl nsw i32 %484, 7
  %cmp6.19 = icmp eq i64 %indvars.iv.next20.18, %1
  %add33.19 = or i32 %mul.19, 1
  %sub38.19 = add i32 %mul.19, -1
  %485 = trunc i64 %indvars.iv.next20.18 to i32
  %add51.19 = shl i32 %485, 7
  %486 = trunc i64 %indvars.iv.next20.18 to i32
  %add72.19 = shl i32 %486, 7
  %mul73.19 = add i32 %add72.19, 128
  %mul78.19 = add i32 %add72.19, -128
  %487 = trunc i64 %indvars.iv.next20.18 to i32
  %sub91.19 = shl i32 %487, 7
  %488 = sext i32 %mul.19 to i64
  %489 = sext i32 %mul78.19 to i64
  %490 = sext i32 %mul73.19 to i64
  br label %for.body4.19

for.body4.19:                                     ; preds = %for.inc.19, %for.body4.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body4.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc.19 ]
  %491 = add nsw i64 %indvars.iv.19, %488
  %cmp8.19 = icmp eq i64 %indvars.iv.19, 0
  %or.cond1.19 = or i1 %cmp6.19, %cmp8.19
  %cmp10.19 = icmp eq i64 %indvars.iv.19, %0
  %or.cond2.19 = or i1 %cmp10.19, %or.cond1.19
  br i1 %or.cond2.19, label %if.then.19, label %if.else.19

if.else.19:                                       ; preds = %for.body4.19
  %arrayidx12.19 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %491
  %492 = load float, float* %arrayidx12.19, align 4
  %conv.19 = fpext float %492 to double
  %mul13.19 = fmul double %conv.19, 0x404CA5DC1A63C1F8
  %conv14.19 = fptrunc double %mul13.19 to float
  %cmp15.19 = fcmp olt float %conv14.19, 0.000000e+00
  %add18.19 = fadd float %conv14.19, 1.800000e+02
  %angle.0.19 = select i1 %cmp15.19, float %add18.19, float %conv14.19
  %cmp19.19 = fcmp oge float %angle.0.19, 0.000000e+00
  %cmp22.19 = fcmp olt float %angle.0.19, 2.250000e+01
  %or.cond3.19 = and i1 %cmp19.19, %cmp22.19
  br i1 %or.cond3.19, label %if.then31.19, label %lor.lhs.false24.19

lor.lhs.false24.19:                               ; preds = %if.else.19
  %cmp26.19 = fcmp ult float %angle.0.19, 1.575000e+02
  %cmp29.19 = fcmp ugt float %angle.0.19, 1.800000e+02
  %or.cond4.19 = or i1 %cmp26.19, %cmp29.19
  br i1 %or.cond4.19, label %if.else42.19, label %if.then31.19

if.else42.19:                                     ; preds = %lor.lhs.false24.19
  %cmp44.19 = fcmp oge float %angle.0.19, 2.250000e+01
  %cmp48.19 = fcmp olt float %angle.0.19, 6.750000e+01
  %or.cond5.19 = and i1 %cmp44.19, %cmp48.19
  br i1 %or.cond5.19, label %if.then50.19, label %if.else63.19

if.else63.19:                                     ; preds = %if.else42.19
  %cmp65.19 = fcmp oge float %angle.0.19, 6.750000e+01
  %cmp69.19 = fcmp olt float %angle.0.19, 1.125000e+02
  %or.cond6.19 = and i1 %cmp65.19, %cmp69.19
  br i1 %or.cond6.19, label %if.then71.19, label %if.else82.19

if.else82.19:                                     ; preds = %if.else63.19
  %cmp84.19 = fcmp oge float %angle.0.19, 1.125000e+02
  %cmp88.19 = fcmp olt float %angle.0.19, 1.575000e+02
  %or.cond7.19 = and i1 %cmp84.19, %cmp88.19
  br i1 %or.cond7.19, label %if.then90.19, label %if.end106.19

if.then90.19:                                     ; preds = %if.else82.19
  %493 = trunc i64 %indvars.iv.19 to i32
  %sub93.19 = add i32 %493, %sub91.19
  %add94.19 = add i32 %sub93.19, -129
  %idxprom95.19 = sext i32 %add94.19 to i64
  %arrayidx96.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.19
  %494 = load float, float* %arrayidx96.19, align 4
  %add100.19 = add i32 %sub93.19, 129
  %idxprom101.19 = sext i32 %add100.19 to i64
  %arrayidx102.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.19
  %495 = load float, float* %arrayidx102.19, align 4
  br label %if.end106.19

if.then71.19:                                     ; preds = %if.else63.19
  %496 = add nsw i64 %490, %indvars.iv.19
  %arrayidx76.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %496
  %497 = load float, float* %arrayidx76.19, align 4
  %498 = add nsw i64 %489, %indvars.iv.19
  %arrayidx81.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %498
  %499 = load float, float* %arrayidx81.19, align 4
  br label %if.end106.19

if.then50.19:                                     ; preds = %if.else42.19
  %500 = trunc i64 %indvars.iv.19 to i32
  %sub53.19 = add i32 %500, %add51.19
  %add54.19 = add i32 %sub53.19, 127
  %idxprom55.19 = sext i32 %add54.19 to i64
  %arrayidx56.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.19
  %501 = load float, float* %arrayidx56.19, align 4
  %add60.19 = add i32 %sub53.19, -127
  %idxprom61.19 = sext i32 %add60.19 to i64
  %arrayidx62.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.19
  %502 = load float, float* %arrayidx62.19, align 4
  br label %if.end106.19

if.then31.19:                                     ; preds = %lor.lhs.false24.19, %if.else.19
  %503 = trunc i64 %indvars.iv.19 to i32
  %add34.19 = add i32 %add33.19, %503
  %idxprom35.19 = sext i32 %add34.19 to i64
  %arrayidx36.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.19
  %504 = load float, float* %arrayidx36.19, align 4
  %505 = trunc i64 %indvars.iv.19 to i32
  %add39.19 = add i32 %sub38.19, %505
  %idxprom40.19 = sext i32 %add39.19 to i64
  %arrayidx41.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.19
  %506 = load float, float* %arrayidx41.19, align 4
  br label %if.end106.19

if.end106.19:                                     ; preds = %if.then31.19, %if.then50.19, %if.then71.19, %if.then90.19, %if.else82.19
  %q.3.19 = phi float [ %504, %if.then31.19 ], [ %501, %if.then50.19 ], [ %497, %if.then71.19 ], [ %494, %if.then90.19 ], [ 2.550000e+02, %if.else82.19 ]
  %r.3.19 = phi float [ %506, %if.then31.19 ], [ %502, %if.then50.19 ], [ %499, %if.then71.19 ], [ %495, %if.then90.19 ], [ 2.550000e+02, %if.else82.19 ]
  %arrayidx108.19 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %491
  %507 = load float, float* %arrayidx108.19, align 4
  %cmp109.19 = fcmp ult float %507, %q.3.19
  %cmp114.19 = fcmp ult float %507, %r.3.19
  %or.cond8.19 = or i1 %cmp109.19, %cmp114.19
  br i1 %or.cond8.19, label %if.else122.19, label %if.then116.19

if.then116.19:                                    ; preds = %if.end106.19
  %conv119.19 = fptoui float %507 to i32
  %arrayidx121.19 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %491
  store i32 %conv119.19, i32* %arrayidx121.19, align 4
  br label %for.inc.19

if.else122.19:                                    ; preds = %if.end106.19
  %arrayidx124.19 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %491
  store i32 0, i32* %arrayidx124.19, align 4
  br label %for.inc.19

if.then.19:                                       ; preds = %for.body4.19
  %arrayidx.19 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %491
  store i32 0, i32* %arrayidx.19, align 4
  br label %for.inc.19

for.inc.19:                                       ; preds = %if.then.19, %if.else122.19, %if.then116.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %img_width
  br i1 %exitcond.19, label %for.inc127.19, label %for.body4.19, !llvm.loop !1

for.inc127.19:                                    ; preds = %for.inc.19
  %indvars.iv.next20.19 = add nsw i64 %indvars.iv19, 20
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.20

for.body4.lr.ph.20:                               ; preds = %for.inc127.19
  %508 = trunc i64 %indvars.iv.next20.19 to i32
  %mul.20 = shl nsw i32 %508, 7
  %cmp6.20 = icmp eq i64 %indvars.iv.next20.19, %1
  %add33.20 = or i32 %mul.20, 1
  %sub38.20 = add i32 %mul.20, -1
  %509 = trunc i64 %indvars.iv.next20.19 to i32
  %add51.20 = shl i32 %509, 7
  %510 = trunc i64 %indvars.iv.next20.19 to i32
  %add72.20 = shl i32 %510, 7
  %mul73.20 = add i32 %add72.20, 128
  %mul78.20 = add i32 %add72.20, -128
  %511 = trunc i64 %indvars.iv.next20.19 to i32
  %sub91.20 = shl i32 %511, 7
  %512 = sext i32 %mul.20 to i64
  %513 = sext i32 %mul78.20 to i64
  %514 = sext i32 %mul73.20 to i64
  br label %for.body4.20

for.body4.20:                                     ; preds = %for.inc.20, %for.body4.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body4.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc.20 ]
  %515 = add nsw i64 %indvars.iv.20, %512
  %cmp8.20 = icmp eq i64 %indvars.iv.20, 0
  %or.cond1.20 = or i1 %cmp6.20, %cmp8.20
  %cmp10.20 = icmp eq i64 %indvars.iv.20, %0
  %or.cond2.20 = or i1 %cmp10.20, %or.cond1.20
  br i1 %or.cond2.20, label %if.then.20, label %if.else.20

if.else.20:                                       ; preds = %for.body4.20
  %arrayidx12.20 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %515
  %516 = load float, float* %arrayidx12.20, align 4
  %conv.20 = fpext float %516 to double
  %mul13.20 = fmul double %conv.20, 0x404CA5DC1A63C1F8
  %conv14.20 = fptrunc double %mul13.20 to float
  %cmp15.20 = fcmp olt float %conv14.20, 0.000000e+00
  %add18.20 = fadd float %conv14.20, 1.800000e+02
  %angle.0.20 = select i1 %cmp15.20, float %add18.20, float %conv14.20
  %cmp19.20 = fcmp oge float %angle.0.20, 0.000000e+00
  %cmp22.20 = fcmp olt float %angle.0.20, 2.250000e+01
  %or.cond3.20 = and i1 %cmp19.20, %cmp22.20
  br i1 %or.cond3.20, label %if.then31.20, label %lor.lhs.false24.20

lor.lhs.false24.20:                               ; preds = %if.else.20
  %cmp26.20 = fcmp ult float %angle.0.20, 1.575000e+02
  %cmp29.20 = fcmp ugt float %angle.0.20, 1.800000e+02
  %or.cond4.20 = or i1 %cmp26.20, %cmp29.20
  br i1 %or.cond4.20, label %if.else42.20, label %if.then31.20

if.else42.20:                                     ; preds = %lor.lhs.false24.20
  %cmp44.20 = fcmp oge float %angle.0.20, 2.250000e+01
  %cmp48.20 = fcmp olt float %angle.0.20, 6.750000e+01
  %or.cond5.20 = and i1 %cmp44.20, %cmp48.20
  br i1 %or.cond5.20, label %if.then50.20, label %if.else63.20

if.else63.20:                                     ; preds = %if.else42.20
  %cmp65.20 = fcmp oge float %angle.0.20, 6.750000e+01
  %cmp69.20 = fcmp olt float %angle.0.20, 1.125000e+02
  %or.cond6.20 = and i1 %cmp65.20, %cmp69.20
  br i1 %or.cond6.20, label %if.then71.20, label %if.else82.20

if.else82.20:                                     ; preds = %if.else63.20
  %cmp84.20 = fcmp oge float %angle.0.20, 1.125000e+02
  %cmp88.20 = fcmp olt float %angle.0.20, 1.575000e+02
  %or.cond7.20 = and i1 %cmp84.20, %cmp88.20
  br i1 %or.cond7.20, label %if.then90.20, label %if.end106.20

if.then90.20:                                     ; preds = %if.else82.20
  %517 = trunc i64 %indvars.iv.20 to i32
  %sub93.20 = add i32 %517, %sub91.20
  %add94.20 = add i32 %sub93.20, -129
  %idxprom95.20 = sext i32 %add94.20 to i64
  %arrayidx96.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.20
  %518 = load float, float* %arrayidx96.20, align 4
  %add100.20 = add i32 %sub93.20, 129
  %idxprom101.20 = sext i32 %add100.20 to i64
  %arrayidx102.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.20
  %519 = load float, float* %arrayidx102.20, align 4
  br label %if.end106.20

if.then71.20:                                     ; preds = %if.else63.20
  %520 = add nsw i64 %514, %indvars.iv.20
  %arrayidx76.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %520
  %521 = load float, float* %arrayidx76.20, align 4
  %522 = add nsw i64 %513, %indvars.iv.20
  %arrayidx81.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %522
  %523 = load float, float* %arrayidx81.20, align 4
  br label %if.end106.20

if.then50.20:                                     ; preds = %if.else42.20
  %524 = trunc i64 %indvars.iv.20 to i32
  %sub53.20 = add i32 %524, %add51.20
  %add54.20 = add i32 %sub53.20, 127
  %idxprom55.20 = sext i32 %add54.20 to i64
  %arrayidx56.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.20
  %525 = load float, float* %arrayidx56.20, align 4
  %add60.20 = add i32 %sub53.20, -127
  %idxprom61.20 = sext i32 %add60.20 to i64
  %arrayidx62.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.20
  %526 = load float, float* %arrayidx62.20, align 4
  br label %if.end106.20

if.then31.20:                                     ; preds = %lor.lhs.false24.20, %if.else.20
  %527 = trunc i64 %indvars.iv.20 to i32
  %add34.20 = add i32 %add33.20, %527
  %idxprom35.20 = sext i32 %add34.20 to i64
  %arrayidx36.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.20
  %528 = load float, float* %arrayidx36.20, align 4
  %529 = trunc i64 %indvars.iv.20 to i32
  %add39.20 = add i32 %sub38.20, %529
  %idxprom40.20 = sext i32 %add39.20 to i64
  %arrayidx41.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.20
  %530 = load float, float* %arrayidx41.20, align 4
  br label %if.end106.20

if.end106.20:                                     ; preds = %if.then31.20, %if.then50.20, %if.then71.20, %if.then90.20, %if.else82.20
  %q.3.20 = phi float [ %528, %if.then31.20 ], [ %525, %if.then50.20 ], [ %521, %if.then71.20 ], [ %518, %if.then90.20 ], [ 2.550000e+02, %if.else82.20 ]
  %r.3.20 = phi float [ %530, %if.then31.20 ], [ %526, %if.then50.20 ], [ %523, %if.then71.20 ], [ %519, %if.then90.20 ], [ 2.550000e+02, %if.else82.20 ]
  %arrayidx108.20 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %515
  %531 = load float, float* %arrayidx108.20, align 4
  %cmp109.20 = fcmp ult float %531, %q.3.20
  %cmp114.20 = fcmp ult float %531, %r.3.20
  %or.cond8.20 = or i1 %cmp109.20, %cmp114.20
  br i1 %or.cond8.20, label %if.else122.20, label %if.then116.20

if.then116.20:                                    ; preds = %if.end106.20
  %conv119.20 = fptoui float %531 to i32
  %arrayidx121.20 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %515
  store i32 %conv119.20, i32* %arrayidx121.20, align 4
  br label %for.inc.20

if.else122.20:                                    ; preds = %if.end106.20
  %arrayidx124.20 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %515
  store i32 0, i32* %arrayidx124.20, align 4
  br label %for.inc.20

if.then.20:                                       ; preds = %for.body4.20
  %arrayidx.20 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %515
  store i32 0, i32* %arrayidx.20, align 4
  br label %for.inc.20

for.inc.20:                                       ; preds = %if.then.20, %if.else122.20, %if.then116.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %img_width
  br i1 %exitcond.20, label %for.inc127.20, label %for.body4.20, !llvm.loop !1

for.inc127.20:                                    ; preds = %for.inc.20
  %indvars.iv.next20.20 = add nsw i64 %indvars.iv19, 21
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.21

for.body4.lr.ph.21:                               ; preds = %for.inc127.20
  %532 = trunc i64 %indvars.iv.next20.20 to i32
  %mul.21 = shl nsw i32 %532, 7
  %cmp6.21 = icmp eq i64 %indvars.iv.next20.20, %1
  %add33.21 = or i32 %mul.21, 1
  %sub38.21 = add i32 %mul.21, -1
  %533 = trunc i64 %indvars.iv.next20.20 to i32
  %add51.21 = shl i32 %533, 7
  %534 = trunc i64 %indvars.iv.next20.20 to i32
  %add72.21 = shl i32 %534, 7
  %mul73.21 = add i32 %add72.21, 128
  %mul78.21 = add i32 %add72.21, -128
  %535 = trunc i64 %indvars.iv.next20.20 to i32
  %sub91.21 = shl i32 %535, 7
  %536 = sext i32 %mul.21 to i64
  %537 = sext i32 %mul78.21 to i64
  %538 = sext i32 %mul73.21 to i64
  br label %for.body4.21

for.body4.21:                                     ; preds = %for.inc.21, %for.body4.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body4.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc.21 ]
  %539 = add nsw i64 %indvars.iv.21, %536
  %cmp8.21 = icmp eq i64 %indvars.iv.21, 0
  %or.cond1.21 = or i1 %cmp6.21, %cmp8.21
  %cmp10.21 = icmp eq i64 %indvars.iv.21, %0
  %or.cond2.21 = or i1 %cmp10.21, %or.cond1.21
  br i1 %or.cond2.21, label %if.then.21, label %if.else.21

if.else.21:                                       ; preds = %for.body4.21
  %arrayidx12.21 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %539
  %540 = load float, float* %arrayidx12.21, align 4
  %conv.21 = fpext float %540 to double
  %mul13.21 = fmul double %conv.21, 0x404CA5DC1A63C1F8
  %conv14.21 = fptrunc double %mul13.21 to float
  %cmp15.21 = fcmp olt float %conv14.21, 0.000000e+00
  %add18.21 = fadd float %conv14.21, 1.800000e+02
  %angle.0.21 = select i1 %cmp15.21, float %add18.21, float %conv14.21
  %cmp19.21 = fcmp oge float %angle.0.21, 0.000000e+00
  %cmp22.21 = fcmp olt float %angle.0.21, 2.250000e+01
  %or.cond3.21 = and i1 %cmp19.21, %cmp22.21
  br i1 %or.cond3.21, label %if.then31.21, label %lor.lhs.false24.21

lor.lhs.false24.21:                               ; preds = %if.else.21
  %cmp26.21 = fcmp ult float %angle.0.21, 1.575000e+02
  %cmp29.21 = fcmp ugt float %angle.0.21, 1.800000e+02
  %or.cond4.21 = or i1 %cmp26.21, %cmp29.21
  br i1 %or.cond4.21, label %if.else42.21, label %if.then31.21

if.else42.21:                                     ; preds = %lor.lhs.false24.21
  %cmp44.21 = fcmp oge float %angle.0.21, 2.250000e+01
  %cmp48.21 = fcmp olt float %angle.0.21, 6.750000e+01
  %or.cond5.21 = and i1 %cmp44.21, %cmp48.21
  br i1 %or.cond5.21, label %if.then50.21, label %if.else63.21

if.else63.21:                                     ; preds = %if.else42.21
  %cmp65.21 = fcmp oge float %angle.0.21, 6.750000e+01
  %cmp69.21 = fcmp olt float %angle.0.21, 1.125000e+02
  %or.cond6.21 = and i1 %cmp65.21, %cmp69.21
  br i1 %or.cond6.21, label %if.then71.21, label %if.else82.21

if.else82.21:                                     ; preds = %if.else63.21
  %cmp84.21 = fcmp oge float %angle.0.21, 1.125000e+02
  %cmp88.21 = fcmp olt float %angle.0.21, 1.575000e+02
  %or.cond7.21 = and i1 %cmp84.21, %cmp88.21
  br i1 %or.cond7.21, label %if.then90.21, label %if.end106.21

if.then90.21:                                     ; preds = %if.else82.21
  %541 = trunc i64 %indvars.iv.21 to i32
  %sub93.21 = add i32 %541, %sub91.21
  %add94.21 = add i32 %sub93.21, -129
  %idxprom95.21 = sext i32 %add94.21 to i64
  %arrayidx96.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.21
  %542 = load float, float* %arrayidx96.21, align 4
  %add100.21 = add i32 %sub93.21, 129
  %idxprom101.21 = sext i32 %add100.21 to i64
  %arrayidx102.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.21
  %543 = load float, float* %arrayidx102.21, align 4
  br label %if.end106.21

if.then71.21:                                     ; preds = %if.else63.21
  %544 = add nsw i64 %538, %indvars.iv.21
  %arrayidx76.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %544
  %545 = load float, float* %arrayidx76.21, align 4
  %546 = add nsw i64 %537, %indvars.iv.21
  %arrayidx81.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %546
  %547 = load float, float* %arrayidx81.21, align 4
  br label %if.end106.21

if.then50.21:                                     ; preds = %if.else42.21
  %548 = trunc i64 %indvars.iv.21 to i32
  %sub53.21 = add i32 %548, %add51.21
  %add54.21 = add i32 %sub53.21, 127
  %idxprom55.21 = sext i32 %add54.21 to i64
  %arrayidx56.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.21
  %549 = load float, float* %arrayidx56.21, align 4
  %add60.21 = add i32 %sub53.21, -127
  %idxprom61.21 = sext i32 %add60.21 to i64
  %arrayidx62.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.21
  %550 = load float, float* %arrayidx62.21, align 4
  br label %if.end106.21

if.then31.21:                                     ; preds = %lor.lhs.false24.21, %if.else.21
  %551 = trunc i64 %indvars.iv.21 to i32
  %add34.21 = add i32 %add33.21, %551
  %idxprom35.21 = sext i32 %add34.21 to i64
  %arrayidx36.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.21
  %552 = load float, float* %arrayidx36.21, align 4
  %553 = trunc i64 %indvars.iv.21 to i32
  %add39.21 = add i32 %sub38.21, %553
  %idxprom40.21 = sext i32 %add39.21 to i64
  %arrayidx41.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.21
  %554 = load float, float* %arrayidx41.21, align 4
  br label %if.end106.21

if.end106.21:                                     ; preds = %if.then31.21, %if.then50.21, %if.then71.21, %if.then90.21, %if.else82.21
  %q.3.21 = phi float [ %552, %if.then31.21 ], [ %549, %if.then50.21 ], [ %545, %if.then71.21 ], [ %542, %if.then90.21 ], [ 2.550000e+02, %if.else82.21 ]
  %r.3.21 = phi float [ %554, %if.then31.21 ], [ %550, %if.then50.21 ], [ %547, %if.then71.21 ], [ %543, %if.then90.21 ], [ 2.550000e+02, %if.else82.21 ]
  %arrayidx108.21 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %539
  %555 = load float, float* %arrayidx108.21, align 4
  %cmp109.21 = fcmp ult float %555, %q.3.21
  %cmp114.21 = fcmp ult float %555, %r.3.21
  %or.cond8.21 = or i1 %cmp109.21, %cmp114.21
  br i1 %or.cond8.21, label %if.else122.21, label %if.then116.21

if.then116.21:                                    ; preds = %if.end106.21
  %conv119.21 = fptoui float %555 to i32
  %arrayidx121.21 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %539
  store i32 %conv119.21, i32* %arrayidx121.21, align 4
  br label %for.inc.21

if.else122.21:                                    ; preds = %if.end106.21
  %arrayidx124.21 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %539
  store i32 0, i32* %arrayidx124.21, align 4
  br label %for.inc.21

if.then.21:                                       ; preds = %for.body4.21
  %arrayidx.21 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %539
  store i32 0, i32* %arrayidx.21, align 4
  br label %for.inc.21

for.inc.21:                                       ; preds = %if.then.21, %if.else122.21, %if.then116.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %img_width
  br i1 %exitcond.21, label %for.inc127.21, label %for.body4.21, !llvm.loop !1

for.inc127.21:                                    ; preds = %for.inc.21
  %indvars.iv.next20.21 = add nsw i64 %indvars.iv19, 22
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.22

for.body4.lr.ph.22:                               ; preds = %for.inc127.21
  %556 = trunc i64 %indvars.iv.next20.21 to i32
  %mul.22 = shl nsw i32 %556, 7
  %cmp6.22 = icmp eq i64 %indvars.iv.next20.21, %1
  %add33.22 = or i32 %mul.22, 1
  %sub38.22 = add i32 %mul.22, -1
  %557 = trunc i64 %indvars.iv.next20.21 to i32
  %add51.22 = shl i32 %557, 7
  %558 = trunc i64 %indvars.iv.next20.21 to i32
  %add72.22 = shl i32 %558, 7
  %mul73.22 = add i32 %add72.22, 128
  %mul78.22 = add i32 %add72.22, -128
  %559 = trunc i64 %indvars.iv.next20.21 to i32
  %sub91.22 = shl i32 %559, 7
  %560 = sext i32 %mul.22 to i64
  %561 = sext i32 %mul78.22 to i64
  %562 = sext i32 %mul73.22 to i64
  br label %for.body4.22

for.body4.22:                                     ; preds = %for.inc.22, %for.body4.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body4.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc.22 ]
  %563 = add nsw i64 %indvars.iv.22, %560
  %cmp8.22 = icmp eq i64 %indvars.iv.22, 0
  %or.cond1.22 = or i1 %cmp6.22, %cmp8.22
  %cmp10.22 = icmp eq i64 %indvars.iv.22, %0
  %or.cond2.22 = or i1 %cmp10.22, %or.cond1.22
  br i1 %or.cond2.22, label %if.then.22, label %if.else.22

if.else.22:                                       ; preds = %for.body4.22
  %arrayidx12.22 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %563
  %564 = load float, float* %arrayidx12.22, align 4
  %conv.22 = fpext float %564 to double
  %mul13.22 = fmul double %conv.22, 0x404CA5DC1A63C1F8
  %conv14.22 = fptrunc double %mul13.22 to float
  %cmp15.22 = fcmp olt float %conv14.22, 0.000000e+00
  %add18.22 = fadd float %conv14.22, 1.800000e+02
  %angle.0.22 = select i1 %cmp15.22, float %add18.22, float %conv14.22
  %cmp19.22 = fcmp oge float %angle.0.22, 0.000000e+00
  %cmp22.22 = fcmp olt float %angle.0.22, 2.250000e+01
  %or.cond3.22 = and i1 %cmp19.22, %cmp22.22
  br i1 %or.cond3.22, label %if.then31.22, label %lor.lhs.false24.22

lor.lhs.false24.22:                               ; preds = %if.else.22
  %cmp26.22 = fcmp ult float %angle.0.22, 1.575000e+02
  %cmp29.22 = fcmp ugt float %angle.0.22, 1.800000e+02
  %or.cond4.22 = or i1 %cmp26.22, %cmp29.22
  br i1 %or.cond4.22, label %if.else42.22, label %if.then31.22

if.else42.22:                                     ; preds = %lor.lhs.false24.22
  %cmp44.22 = fcmp oge float %angle.0.22, 2.250000e+01
  %cmp48.22 = fcmp olt float %angle.0.22, 6.750000e+01
  %or.cond5.22 = and i1 %cmp44.22, %cmp48.22
  br i1 %or.cond5.22, label %if.then50.22, label %if.else63.22

if.else63.22:                                     ; preds = %if.else42.22
  %cmp65.22 = fcmp oge float %angle.0.22, 6.750000e+01
  %cmp69.22 = fcmp olt float %angle.0.22, 1.125000e+02
  %or.cond6.22 = and i1 %cmp65.22, %cmp69.22
  br i1 %or.cond6.22, label %if.then71.22, label %if.else82.22

if.else82.22:                                     ; preds = %if.else63.22
  %cmp84.22 = fcmp oge float %angle.0.22, 1.125000e+02
  %cmp88.22 = fcmp olt float %angle.0.22, 1.575000e+02
  %or.cond7.22 = and i1 %cmp84.22, %cmp88.22
  br i1 %or.cond7.22, label %if.then90.22, label %if.end106.22

if.then90.22:                                     ; preds = %if.else82.22
  %565 = trunc i64 %indvars.iv.22 to i32
  %sub93.22 = add i32 %565, %sub91.22
  %add94.22 = add i32 %sub93.22, -129
  %idxprom95.22 = sext i32 %add94.22 to i64
  %arrayidx96.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.22
  %566 = load float, float* %arrayidx96.22, align 4
  %add100.22 = add i32 %sub93.22, 129
  %idxprom101.22 = sext i32 %add100.22 to i64
  %arrayidx102.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.22
  %567 = load float, float* %arrayidx102.22, align 4
  br label %if.end106.22

if.then71.22:                                     ; preds = %if.else63.22
  %568 = add nsw i64 %562, %indvars.iv.22
  %arrayidx76.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %568
  %569 = load float, float* %arrayidx76.22, align 4
  %570 = add nsw i64 %561, %indvars.iv.22
  %arrayidx81.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %570
  %571 = load float, float* %arrayidx81.22, align 4
  br label %if.end106.22

if.then50.22:                                     ; preds = %if.else42.22
  %572 = trunc i64 %indvars.iv.22 to i32
  %sub53.22 = add i32 %572, %add51.22
  %add54.22 = add i32 %sub53.22, 127
  %idxprom55.22 = sext i32 %add54.22 to i64
  %arrayidx56.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.22
  %573 = load float, float* %arrayidx56.22, align 4
  %add60.22 = add i32 %sub53.22, -127
  %idxprom61.22 = sext i32 %add60.22 to i64
  %arrayidx62.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.22
  %574 = load float, float* %arrayidx62.22, align 4
  br label %if.end106.22

if.then31.22:                                     ; preds = %lor.lhs.false24.22, %if.else.22
  %575 = trunc i64 %indvars.iv.22 to i32
  %add34.22 = add i32 %add33.22, %575
  %idxprom35.22 = sext i32 %add34.22 to i64
  %arrayidx36.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.22
  %576 = load float, float* %arrayidx36.22, align 4
  %577 = trunc i64 %indvars.iv.22 to i32
  %add39.22 = add i32 %sub38.22, %577
  %idxprom40.22 = sext i32 %add39.22 to i64
  %arrayidx41.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.22
  %578 = load float, float* %arrayidx41.22, align 4
  br label %if.end106.22

if.end106.22:                                     ; preds = %if.then31.22, %if.then50.22, %if.then71.22, %if.then90.22, %if.else82.22
  %q.3.22 = phi float [ %576, %if.then31.22 ], [ %573, %if.then50.22 ], [ %569, %if.then71.22 ], [ %566, %if.then90.22 ], [ 2.550000e+02, %if.else82.22 ]
  %r.3.22 = phi float [ %578, %if.then31.22 ], [ %574, %if.then50.22 ], [ %571, %if.then71.22 ], [ %567, %if.then90.22 ], [ 2.550000e+02, %if.else82.22 ]
  %arrayidx108.22 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %563
  %579 = load float, float* %arrayidx108.22, align 4
  %cmp109.22 = fcmp ult float %579, %q.3.22
  %cmp114.22 = fcmp ult float %579, %r.3.22
  %or.cond8.22 = or i1 %cmp109.22, %cmp114.22
  br i1 %or.cond8.22, label %if.else122.22, label %if.then116.22

if.then116.22:                                    ; preds = %if.end106.22
  %conv119.22 = fptoui float %579 to i32
  %arrayidx121.22 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %563
  store i32 %conv119.22, i32* %arrayidx121.22, align 4
  br label %for.inc.22

if.else122.22:                                    ; preds = %if.end106.22
  %arrayidx124.22 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %563
  store i32 0, i32* %arrayidx124.22, align 4
  br label %for.inc.22

if.then.22:                                       ; preds = %for.body4.22
  %arrayidx.22 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %563
  store i32 0, i32* %arrayidx.22, align 4
  br label %for.inc.22

for.inc.22:                                       ; preds = %if.then.22, %if.else122.22, %if.then116.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %img_width
  br i1 %exitcond.22, label %for.inc127.22, label %for.body4.22, !llvm.loop !1

for.inc127.22:                                    ; preds = %for.inc.22
  %indvars.iv.next20.22 = add nsw i64 %indvars.iv19, 23
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.23

for.body4.lr.ph.23:                               ; preds = %for.inc127.22
  %580 = trunc i64 %indvars.iv.next20.22 to i32
  %mul.23 = shl nsw i32 %580, 7
  %cmp6.23 = icmp eq i64 %indvars.iv.next20.22, %1
  %add33.23 = or i32 %mul.23, 1
  %sub38.23 = add i32 %mul.23, -1
  %581 = trunc i64 %indvars.iv.next20.22 to i32
  %add51.23 = shl i32 %581, 7
  %582 = trunc i64 %indvars.iv.next20.22 to i32
  %add72.23 = shl i32 %582, 7
  %mul73.23 = add i32 %add72.23, 128
  %mul78.23 = add i32 %add72.23, -128
  %583 = trunc i64 %indvars.iv.next20.22 to i32
  %sub91.23 = shl i32 %583, 7
  %584 = sext i32 %mul.23 to i64
  %585 = sext i32 %mul78.23 to i64
  %586 = sext i32 %mul73.23 to i64
  br label %for.body4.23

for.body4.23:                                     ; preds = %for.inc.23, %for.body4.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body4.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc.23 ]
  %587 = add nsw i64 %indvars.iv.23, %584
  %cmp8.23 = icmp eq i64 %indvars.iv.23, 0
  %or.cond1.23 = or i1 %cmp6.23, %cmp8.23
  %cmp10.23 = icmp eq i64 %indvars.iv.23, %0
  %or.cond2.23 = or i1 %cmp10.23, %or.cond1.23
  br i1 %or.cond2.23, label %if.then.23, label %if.else.23

if.else.23:                                       ; preds = %for.body4.23
  %arrayidx12.23 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %587
  %588 = load float, float* %arrayidx12.23, align 4
  %conv.23 = fpext float %588 to double
  %mul13.23 = fmul double %conv.23, 0x404CA5DC1A63C1F8
  %conv14.23 = fptrunc double %mul13.23 to float
  %cmp15.23 = fcmp olt float %conv14.23, 0.000000e+00
  %add18.23 = fadd float %conv14.23, 1.800000e+02
  %angle.0.23 = select i1 %cmp15.23, float %add18.23, float %conv14.23
  %cmp19.23 = fcmp oge float %angle.0.23, 0.000000e+00
  %cmp22.23 = fcmp olt float %angle.0.23, 2.250000e+01
  %or.cond3.23 = and i1 %cmp19.23, %cmp22.23
  br i1 %or.cond3.23, label %if.then31.23, label %lor.lhs.false24.23

lor.lhs.false24.23:                               ; preds = %if.else.23
  %cmp26.23 = fcmp ult float %angle.0.23, 1.575000e+02
  %cmp29.23 = fcmp ugt float %angle.0.23, 1.800000e+02
  %or.cond4.23 = or i1 %cmp26.23, %cmp29.23
  br i1 %or.cond4.23, label %if.else42.23, label %if.then31.23

if.else42.23:                                     ; preds = %lor.lhs.false24.23
  %cmp44.23 = fcmp oge float %angle.0.23, 2.250000e+01
  %cmp48.23 = fcmp olt float %angle.0.23, 6.750000e+01
  %or.cond5.23 = and i1 %cmp44.23, %cmp48.23
  br i1 %or.cond5.23, label %if.then50.23, label %if.else63.23

if.else63.23:                                     ; preds = %if.else42.23
  %cmp65.23 = fcmp oge float %angle.0.23, 6.750000e+01
  %cmp69.23 = fcmp olt float %angle.0.23, 1.125000e+02
  %or.cond6.23 = and i1 %cmp65.23, %cmp69.23
  br i1 %or.cond6.23, label %if.then71.23, label %if.else82.23

if.else82.23:                                     ; preds = %if.else63.23
  %cmp84.23 = fcmp oge float %angle.0.23, 1.125000e+02
  %cmp88.23 = fcmp olt float %angle.0.23, 1.575000e+02
  %or.cond7.23 = and i1 %cmp84.23, %cmp88.23
  br i1 %or.cond7.23, label %if.then90.23, label %if.end106.23

if.then90.23:                                     ; preds = %if.else82.23
  %589 = trunc i64 %indvars.iv.23 to i32
  %sub93.23 = add i32 %589, %sub91.23
  %add94.23 = add i32 %sub93.23, -129
  %idxprom95.23 = sext i32 %add94.23 to i64
  %arrayidx96.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.23
  %590 = load float, float* %arrayidx96.23, align 4
  %add100.23 = add i32 %sub93.23, 129
  %idxprom101.23 = sext i32 %add100.23 to i64
  %arrayidx102.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.23
  %591 = load float, float* %arrayidx102.23, align 4
  br label %if.end106.23

if.then71.23:                                     ; preds = %if.else63.23
  %592 = add nsw i64 %586, %indvars.iv.23
  %arrayidx76.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %592
  %593 = load float, float* %arrayidx76.23, align 4
  %594 = add nsw i64 %585, %indvars.iv.23
  %arrayidx81.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %594
  %595 = load float, float* %arrayidx81.23, align 4
  br label %if.end106.23

if.then50.23:                                     ; preds = %if.else42.23
  %596 = trunc i64 %indvars.iv.23 to i32
  %sub53.23 = add i32 %596, %add51.23
  %add54.23 = add i32 %sub53.23, 127
  %idxprom55.23 = sext i32 %add54.23 to i64
  %arrayidx56.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.23
  %597 = load float, float* %arrayidx56.23, align 4
  %add60.23 = add i32 %sub53.23, -127
  %idxprom61.23 = sext i32 %add60.23 to i64
  %arrayidx62.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.23
  %598 = load float, float* %arrayidx62.23, align 4
  br label %if.end106.23

if.then31.23:                                     ; preds = %lor.lhs.false24.23, %if.else.23
  %599 = trunc i64 %indvars.iv.23 to i32
  %add34.23 = add i32 %add33.23, %599
  %idxprom35.23 = sext i32 %add34.23 to i64
  %arrayidx36.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.23
  %600 = load float, float* %arrayidx36.23, align 4
  %601 = trunc i64 %indvars.iv.23 to i32
  %add39.23 = add i32 %sub38.23, %601
  %idxprom40.23 = sext i32 %add39.23 to i64
  %arrayidx41.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.23
  %602 = load float, float* %arrayidx41.23, align 4
  br label %if.end106.23

if.end106.23:                                     ; preds = %if.then31.23, %if.then50.23, %if.then71.23, %if.then90.23, %if.else82.23
  %q.3.23 = phi float [ %600, %if.then31.23 ], [ %597, %if.then50.23 ], [ %593, %if.then71.23 ], [ %590, %if.then90.23 ], [ 2.550000e+02, %if.else82.23 ]
  %r.3.23 = phi float [ %602, %if.then31.23 ], [ %598, %if.then50.23 ], [ %595, %if.then71.23 ], [ %591, %if.then90.23 ], [ 2.550000e+02, %if.else82.23 ]
  %arrayidx108.23 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %587
  %603 = load float, float* %arrayidx108.23, align 4
  %cmp109.23 = fcmp ult float %603, %q.3.23
  %cmp114.23 = fcmp ult float %603, %r.3.23
  %or.cond8.23 = or i1 %cmp109.23, %cmp114.23
  br i1 %or.cond8.23, label %if.else122.23, label %if.then116.23

if.then116.23:                                    ; preds = %if.end106.23
  %conv119.23 = fptoui float %603 to i32
  %arrayidx121.23 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %587
  store i32 %conv119.23, i32* %arrayidx121.23, align 4
  br label %for.inc.23

if.else122.23:                                    ; preds = %if.end106.23
  %arrayidx124.23 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %587
  store i32 0, i32* %arrayidx124.23, align 4
  br label %for.inc.23

if.then.23:                                       ; preds = %for.body4.23
  %arrayidx.23 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %587
  store i32 0, i32* %arrayidx.23, align 4
  br label %for.inc.23

for.inc.23:                                       ; preds = %if.then.23, %if.else122.23, %if.then116.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %img_width
  br i1 %exitcond.23, label %for.inc127.23, label %for.body4.23, !llvm.loop !1

for.inc127.23:                                    ; preds = %for.inc.23
  %indvars.iv.next20.23 = add nsw i64 %indvars.iv19, 24
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.24

for.body4.lr.ph.24:                               ; preds = %for.inc127.23
  %604 = trunc i64 %indvars.iv.next20.23 to i32
  %mul.24 = shl nsw i32 %604, 7
  %cmp6.24 = icmp eq i64 %indvars.iv.next20.23, %1
  %add33.24 = or i32 %mul.24, 1
  %sub38.24 = add i32 %mul.24, -1
  %605 = trunc i64 %indvars.iv.next20.23 to i32
  %add51.24 = shl i32 %605, 7
  %606 = trunc i64 %indvars.iv.next20.23 to i32
  %add72.24 = shl i32 %606, 7
  %mul73.24 = add i32 %add72.24, 128
  %mul78.24 = add i32 %add72.24, -128
  %607 = trunc i64 %indvars.iv.next20.23 to i32
  %sub91.24 = shl i32 %607, 7
  %608 = sext i32 %mul.24 to i64
  %609 = sext i32 %mul78.24 to i64
  %610 = sext i32 %mul73.24 to i64
  br label %for.body4.24

for.body4.24:                                     ; preds = %for.inc.24, %for.body4.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body4.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc.24 ]
  %611 = add nsw i64 %indvars.iv.24, %608
  %cmp8.24 = icmp eq i64 %indvars.iv.24, 0
  %or.cond1.24 = or i1 %cmp6.24, %cmp8.24
  %cmp10.24 = icmp eq i64 %indvars.iv.24, %0
  %or.cond2.24 = or i1 %cmp10.24, %or.cond1.24
  br i1 %or.cond2.24, label %if.then.24, label %if.else.24

if.else.24:                                       ; preds = %for.body4.24
  %arrayidx12.24 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %611
  %612 = load float, float* %arrayidx12.24, align 4
  %conv.24 = fpext float %612 to double
  %mul13.24 = fmul double %conv.24, 0x404CA5DC1A63C1F8
  %conv14.24 = fptrunc double %mul13.24 to float
  %cmp15.24 = fcmp olt float %conv14.24, 0.000000e+00
  %add18.24 = fadd float %conv14.24, 1.800000e+02
  %angle.0.24 = select i1 %cmp15.24, float %add18.24, float %conv14.24
  %cmp19.24 = fcmp oge float %angle.0.24, 0.000000e+00
  %cmp22.24 = fcmp olt float %angle.0.24, 2.250000e+01
  %or.cond3.24 = and i1 %cmp19.24, %cmp22.24
  br i1 %or.cond3.24, label %if.then31.24, label %lor.lhs.false24.24

lor.lhs.false24.24:                               ; preds = %if.else.24
  %cmp26.24 = fcmp ult float %angle.0.24, 1.575000e+02
  %cmp29.24 = fcmp ugt float %angle.0.24, 1.800000e+02
  %or.cond4.24 = or i1 %cmp26.24, %cmp29.24
  br i1 %or.cond4.24, label %if.else42.24, label %if.then31.24

if.else42.24:                                     ; preds = %lor.lhs.false24.24
  %cmp44.24 = fcmp oge float %angle.0.24, 2.250000e+01
  %cmp48.24 = fcmp olt float %angle.0.24, 6.750000e+01
  %or.cond5.24 = and i1 %cmp44.24, %cmp48.24
  br i1 %or.cond5.24, label %if.then50.24, label %if.else63.24

if.else63.24:                                     ; preds = %if.else42.24
  %cmp65.24 = fcmp oge float %angle.0.24, 6.750000e+01
  %cmp69.24 = fcmp olt float %angle.0.24, 1.125000e+02
  %or.cond6.24 = and i1 %cmp65.24, %cmp69.24
  br i1 %or.cond6.24, label %if.then71.24, label %if.else82.24

if.else82.24:                                     ; preds = %if.else63.24
  %cmp84.24 = fcmp oge float %angle.0.24, 1.125000e+02
  %cmp88.24 = fcmp olt float %angle.0.24, 1.575000e+02
  %or.cond7.24 = and i1 %cmp84.24, %cmp88.24
  br i1 %or.cond7.24, label %if.then90.24, label %if.end106.24

if.then90.24:                                     ; preds = %if.else82.24
  %613 = trunc i64 %indvars.iv.24 to i32
  %sub93.24 = add i32 %613, %sub91.24
  %add94.24 = add i32 %sub93.24, -129
  %idxprom95.24 = sext i32 %add94.24 to i64
  %arrayidx96.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.24
  %614 = load float, float* %arrayidx96.24, align 4
  %add100.24 = add i32 %sub93.24, 129
  %idxprom101.24 = sext i32 %add100.24 to i64
  %arrayidx102.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.24
  %615 = load float, float* %arrayidx102.24, align 4
  br label %if.end106.24

if.then71.24:                                     ; preds = %if.else63.24
  %616 = add nsw i64 %610, %indvars.iv.24
  %arrayidx76.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %616
  %617 = load float, float* %arrayidx76.24, align 4
  %618 = add nsw i64 %609, %indvars.iv.24
  %arrayidx81.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %618
  %619 = load float, float* %arrayidx81.24, align 4
  br label %if.end106.24

if.then50.24:                                     ; preds = %if.else42.24
  %620 = trunc i64 %indvars.iv.24 to i32
  %sub53.24 = add i32 %620, %add51.24
  %add54.24 = add i32 %sub53.24, 127
  %idxprom55.24 = sext i32 %add54.24 to i64
  %arrayidx56.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.24
  %621 = load float, float* %arrayidx56.24, align 4
  %add60.24 = add i32 %sub53.24, -127
  %idxprom61.24 = sext i32 %add60.24 to i64
  %arrayidx62.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.24
  %622 = load float, float* %arrayidx62.24, align 4
  br label %if.end106.24

if.then31.24:                                     ; preds = %lor.lhs.false24.24, %if.else.24
  %623 = trunc i64 %indvars.iv.24 to i32
  %add34.24 = add i32 %add33.24, %623
  %idxprom35.24 = sext i32 %add34.24 to i64
  %arrayidx36.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.24
  %624 = load float, float* %arrayidx36.24, align 4
  %625 = trunc i64 %indvars.iv.24 to i32
  %add39.24 = add i32 %sub38.24, %625
  %idxprom40.24 = sext i32 %add39.24 to i64
  %arrayidx41.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.24
  %626 = load float, float* %arrayidx41.24, align 4
  br label %if.end106.24

if.end106.24:                                     ; preds = %if.then31.24, %if.then50.24, %if.then71.24, %if.then90.24, %if.else82.24
  %q.3.24 = phi float [ %624, %if.then31.24 ], [ %621, %if.then50.24 ], [ %617, %if.then71.24 ], [ %614, %if.then90.24 ], [ 2.550000e+02, %if.else82.24 ]
  %r.3.24 = phi float [ %626, %if.then31.24 ], [ %622, %if.then50.24 ], [ %619, %if.then71.24 ], [ %615, %if.then90.24 ], [ 2.550000e+02, %if.else82.24 ]
  %arrayidx108.24 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %611
  %627 = load float, float* %arrayidx108.24, align 4
  %cmp109.24 = fcmp ult float %627, %q.3.24
  %cmp114.24 = fcmp ult float %627, %r.3.24
  %or.cond8.24 = or i1 %cmp109.24, %cmp114.24
  br i1 %or.cond8.24, label %if.else122.24, label %if.then116.24

if.then116.24:                                    ; preds = %if.end106.24
  %conv119.24 = fptoui float %627 to i32
  %arrayidx121.24 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %611
  store i32 %conv119.24, i32* %arrayidx121.24, align 4
  br label %for.inc.24

if.else122.24:                                    ; preds = %if.end106.24
  %arrayidx124.24 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %611
  store i32 0, i32* %arrayidx124.24, align 4
  br label %for.inc.24

if.then.24:                                       ; preds = %for.body4.24
  %arrayidx.24 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %611
  store i32 0, i32* %arrayidx.24, align 4
  br label %for.inc.24

for.inc.24:                                       ; preds = %if.then.24, %if.else122.24, %if.then116.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %img_width
  br i1 %exitcond.24, label %for.inc127.24, label %for.body4.24, !llvm.loop !1

for.inc127.24:                                    ; preds = %for.inc.24
  %indvars.iv.next20.24 = add nsw i64 %indvars.iv19, 25
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.25

for.body4.lr.ph.25:                               ; preds = %for.inc127.24
  %628 = trunc i64 %indvars.iv.next20.24 to i32
  %mul.25 = shl nsw i32 %628, 7
  %cmp6.25 = icmp eq i64 %indvars.iv.next20.24, %1
  %add33.25 = or i32 %mul.25, 1
  %sub38.25 = add i32 %mul.25, -1
  %629 = trunc i64 %indvars.iv.next20.24 to i32
  %add51.25 = shl i32 %629, 7
  %630 = trunc i64 %indvars.iv.next20.24 to i32
  %add72.25 = shl i32 %630, 7
  %mul73.25 = add i32 %add72.25, 128
  %mul78.25 = add i32 %add72.25, -128
  %631 = trunc i64 %indvars.iv.next20.24 to i32
  %sub91.25 = shl i32 %631, 7
  %632 = sext i32 %mul.25 to i64
  %633 = sext i32 %mul78.25 to i64
  %634 = sext i32 %mul73.25 to i64
  br label %for.body4.25

for.body4.25:                                     ; preds = %for.inc.25, %for.body4.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body4.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc.25 ]
  %635 = add nsw i64 %indvars.iv.25, %632
  %cmp8.25 = icmp eq i64 %indvars.iv.25, 0
  %or.cond1.25 = or i1 %cmp6.25, %cmp8.25
  %cmp10.25 = icmp eq i64 %indvars.iv.25, %0
  %or.cond2.25 = or i1 %cmp10.25, %or.cond1.25
  br i1 %or.cond2.25, label %if.then.25, label %if.else.25

if.else.25:                                       ; preds = %for.body4.25
  %arrayidx12.25 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %635
  %636 = load float, float* %arrayidx12.25, align 4
  %conv.25 = fpext float %636 to double
  %mul13.25 = fmul double %conv.25, 0x404CA5DC1A63C1F8
  %conv14.25 = fptrunc double %mul13.25 to float
  %cmp15.25 = fcmp olt float %conv14.25, 0.000000e+00
  %add18.25 = fadd float %conv14.25, 1.800000e+02
  %angle.0.25 = select i1 %cmp15.25, float %add18.25, float %conv14.25
  %cmp19.25 = fcmp oge float %angle.0.25, 0.000000e+00
  %cmp22.25 = fcmp olt float %angle.0.25, 2.250000e+01
  %or.cond3.25 = and i1 %cmp19.25, %cmp22.25
  br i1 %or.cond3.25, label %if.then31.25, label %lor.lhs.false24.25

lor.lhs.false24.25:                               ; preds = %if.else.25
  %cmp26.25 = fcmp ult float %angle.0.25, 1.575000e+02
  %cmp29.25 = fcmp ugt float %angle.0.25, 1.800000e+02
  %or.cond4.25 = or i1 %cmp26.25, %cmp29.25
  br i1 %or.cond4.25, label %if.else42.25, label %if.then31.25

if.else42.25:                                     ; preds = %lor.lhs.false24.25
  %cmp44.25 = fcmp oge float %angle.0.25, 2.250000e+01
  %cmp48.25 = fcmp olt float %angle.0.25, 6.750000e+01
  %or.cond5.25 = and i1 %cmp44.25, %cmp48.25
  br i1 %or.cond5.25, label %if.then50.25, label %if.else63.25

if.else63.25:                                     ; preds = %if.else42.25
  %cmp65.25 = fcmp oge float %angle.0.25, 6.750000e+01
  %cmp69.25 = fcmp olt float %angle.0.25, 1.125000e+02
  %or.cond6.25 = and i1 %cmp65.25, %cmp69.25
  br i1 %or.cond6.25, label %if.then71.25, label %if.else82.25

if.else82.25:                                     ; preds = %if.else63.25
  %cmp84.25 = fcmp oge float %angle.0.25, 1.125000e+02
  %cmp88.25 = fcmp olt float %angle.0.25, 1.575000e+02
  %or.cond7.25 = and i1 %cmp84.25, %cmp88.25
  br i1 %or.cond7.25, label %if.then90.25, label %if.end106.25

if.then90.25:                                     ; preds = %if.else82.25
  %637 = trunc i64 %indvars.iv.25 to i32
  %sub93.25 = add i32 %637, %sub91.25
  %add94.25 = add i32 %sub93.25, -129
  %idxprom95.25 = sext i32 %add94.25 to i64
  %arrayidx96.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.25
  %638 = load float, float* %arrayidx96.25, align 4
  %add100.25 = add i32 %sub93.25, 129
  %idxprom101.25 = sext i32 %add100.25 to i64
  %arrayidx102.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.25
  %639 = load float, float* %arrayidx102.25, align 4
  br label %if.end106.25

if.then71.25:                                     ; preds = %if.else63.25
  %640 = add nsw i64 %634, %indvars.iv.25
  %arrayidx76.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %640
  %641 = load float, float* %arrayidx76.25, align 4
  %642 = add nsw i64 %633, %indvars.iv.25
  %arrayidx81.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %642
  %643 = load float, float* %arrayidx81.25, align 4
  br label %if.end106.25

if.then50.25:                                     ; preds = %if.else42.25
  %644 = trunc i64 %indvars.iv.25 to i32
  %sub53.25 = add i32 %644, %add51.25
  %add54.25 = add i32 %sub53.25, 127
  %idxprom55.25 = sext i32 %add54.25 to i64
  %arrayidx56.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.25
  %645 = load float, float* %arrayidx56.25, align 4
  %add60.25 = add i32 %sub53.25, -127
  %idxprom61.25 = sext i32 %add60.25 to i64
  %arrayidx62.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.25
  %646 = load float, float* %arrayidx62.25, align 4
  br label %if.end106.25

if.then31.25:                                     ; preds = %lor.lhs.false24.25, %if.else.25
  %647 = trunc i64 %indvars.iv.25 to i32
  %add34.25 = add i32 %add33.25, %647
  %idxprom35.25 = sext i32 %add34.25 to i64
  %arrayidx36.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.25
  %648 = load float, float* %arrayidx36.25, align 4
  %649 = trunc i64 %indvars.iv.25 to i32
  %add39.25 = add i32 %sub38.25, %649
  %idxprom40.25 = sext i32 %add39.25 to i64
  %arrayidx41.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.25
  %650 = load float, float* %arrayidx41.25, align 4
  br label %if.end106.25

if.end106.25:                                     ; preds = %if.then31.25, %if.then50.25, %if.then71.25, %if.then90.25, %if.else82.25
  %q.3.25 = phi float [ %648, %if.then31.25 ], [ %645, %if.then50.25 ], [ %641, %if.then71.25 ], [ %638, %if.then90.25 ], [ 2.550000e+02, %if.else82.25 ]
  %r.3.25 = phi float [ %650, %if.then31.25 ], [ %646, %if.then50.25 ], [ %643, %if.then71.25 ], [ %639, %if.then90.25 ], [ 2.550000e+02, %if.else82.25 ]
  %arrayidx108.25 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %635
  %651 = load float, float* %arrayidx108.25, align 4
  %cmp109.25 = fcmp ult float %651, %q.3.25
  %cmp114.25 = fcmp ult float %651, %r.3.25
  %or.cond8.25 = or i1 %cmp109.25, %cmp114.25
  br i1 %or.cond8.25, label %if.else122.25, label %if.then116.25

if.then116.25:                                    ; preds = %if.end106.25
  %conv119.25 = fptoui float %651 to i32
  %arrayidx121.25 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %635
  store i32 %conv119.25, i32* %arrayidx121.25, align 4
  br label %for.inc.25

if.else122.25:                                    ; preds = %if.end106.25
  %arrayidx124.25 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %635
  store i32 0, i32* %arrayidx124.25, align 4
  br label %for.inc.25

if.then.25:                                       ; preds = %for.body4.25
  %arrayidx.25 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %635
  store i32 0, i32* %arrayidx.25, align 4
  br label %for.inc.25

for.inc.25:                                       ; preds = %if.then.25, %if.else122.25, %if.then116.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %img_width
  br i1 %exitcond.25, label %for.inc127.25, label %for.body4.25, !llvm.loop !1

for.inc127.25:                                    ; preds = %for.inc.25
  %indvars.iv.next20.25 = add nsw i64 %indvars.iv19, 26
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.26

for.body4.lr.ph.26:                               ; preds = %for.inc127.25
  %652 = trunc i64 %indvars.iv.next20.25 to i32
  %mul.26 = shl nsw i32 %652, 7
  %cmp6.26 = icmp eq i64 %indvars.iv.next20.25, %1
  %add33.26 = or i32 %mul.26, 1
  %sub38.26 = add i32 %mul.26, -1
  %653 = trunc i64 %indvars.iv.next20.25 to i32
  %add51.26 = shl i32 %653, 7
  %654 = trunc i64 %indvars.iv.next20.25 to i32
  %add72.26 = shl i32 %654, 7
  %mul73.26 = add i32 %add72.26, 128
  %mul78.26 = add i32 %add72.26, -128
  %655 = trunc i64 %indvars.iv.next20.25 to i32
  %sub91.26 = shl i32 %655, 7
  %656 = sext i32 %mul.26 to i64
  %657 = sext i32 %mul78.26 to i64
  %658 = sext i32 %mul73.26 to i64
  br label %for.body4.26

for.body4.26:                                     ; preds = %for.inc.26, %for.body4.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body4.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc.26 ]
  %659 = add nsw i64 %indvars.iv.26, %656
  %cmp8.26 = icmp eq i64 %indvars.iv.26, 0
  %or.cond1.26 = or i1 %cmp6.26, %cmp8.26
  %cmp10.26 = icmp eq i64 %indvars.iv.26, %0
  %or.cond2.26 = or i1 %cmp10.26, %or.cond1.26
  br i1 %or.cond2.26, label %if.then.26, label %if.else.26

if.else.26:                                       ; preds = %for.body4.26
  %arrayidx12.26 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %659
  %660 = load float, float* %arrayidx12.26, align 4
  %conv.26 = fpext float %660 to double
  %mul13.26 = fmul double %conv.26, 0x404CA5DC1A63C1F8
  %conv14.26 = fptrunc double %mul13.26 to float
  %cmp15.26 = fcmp olt float %conv14.26, 0.000000e+00
  %add18.26 = fadd float %conv14.26, 1.800000e+02
  %angle.0.26 = select i1 %cmp15.26, float %add18.26, float %conv14.26
  %cmp19.26 = fcmp oge float %angle.0.26, 0.000000e+00
  %cmp22.26 = fcmp olt float %angle.0.26, 2.250000e+01
  %or.cond3.26 = and i1 %cmp19.26, %cmp22.26
  br i1 %or.cond3.26, label %if.then31.26, label %lor.lhs.false24.26

lor.lhs.false24.26:                               ; preds = %if.else.26
  %cmp26.26 = fcmp ult float %angle.0.26, 1.575000e+02
  %cmp29.26 = fcmp ugt float %angle.0.26, 1.800000e+02
  %or.cond4.26 = or i1 %cmp26.26, %cmp29.26
  br i1 %or.cond4.26, label %if.else42.26, label %if.then31.26

if.else42.26:                                     ; preds = %lor.lhs.false24.26
  %cmp44.26 = fcmp oge float %angle.0.26, 2.250000e+01
  %cmp48.26 = fcmp olt float %angle.0.26, 6.750000e+01
  %or.cond5.26 = and i1 %cmp44.26, %cmp48.26
  br i1 %or.cond5.26, label %if.then50.26, label %if.else63.26

if.else63.26:                                     ; preds = %if.else42.26
  %cmp65.26 = fcmp oge float %angle.0.26, 6.750000e+01
  %cmp69.26 = fcmp olt float %angle.0.26, 1.125000e+02
  %or.cond6.26 = and i1 %cmp65.26, %cmp69.26
  br i1 %or.cond6.26, label %if.then71.26, label %if.else82.26

if.else82.26:                                     ; preds = %if.else63.26
  %cmp84.26 = fcmp oge float %angle.0.26, 1.125000e+02
  %cmp88.26 = fcmp olt float %angle.0.26, 1.575000e+02
  %or.cond7.26 = and i1 %cmp84.26, %cmp88.26
  br i1 %or.cond7.26, label %if.then90.26, label %if.end106.26

if.then90.26:                                     ; preds = %if.else82.26
  %661 = trunc i64 %indvars.iv.26 to i32
  %sub93.26 = add i32 %661, %sub91.26
  %add94.26 = add i32 %sub93.26, -129
  %idxprom95.26 = sext i32 %add94.26 to i64
  %arrayidx96.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.26
  %662 = load float, float* %arrayidx96.26, align 4
  %add100.26 = add i32 %sub93.26, 129
  %idxprom101.26 = sext i32 %add100.26 to i64
  %arrayidx102.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.26
  %663 = load float, float* %arrayidx102.26, align 4
  br label %if.end106.26

if.then71.26:                                     ; preds = %if.else63.26
  %664 = add nsw i64 %658, %indvars.iv.26
  %arrayidx76.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %664
  %665 = load float, float* %arrayidx76.26, align 4
  %666 = add nsw i64 %657, %indvars.iv.26
  %arrayidx81.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %666
  %667 = load float, float* %arrayidx81.26, align 4
  br label %if.end106.26

if.then50.26:                                     ; preds = %if.else42.26
  %668 = trunc i64 %indvars.iv.26 to i32
  %sub53.26 = add i32 %668, %add51.26
  %add54.26 = add i32 %sub53.26, 127
  %idxprom55.26 = sext i32 %add54.26 to i64
  %arrayidx56.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.26
  %669 = load float, float* %arrayidx56.26, align 4
  %add60.26 = add i32 %sub53.26, -127
  %idxprom61.26 = sext i32 %add60.26 to i64
  %arrayidx62.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.26
  %670 = load float, float* %arrayidx62.26, align 4
  br label %if.end106.26

if.then31.26:                                     ; preds = %lor.lhs.false24.26, %if.else.26
  %671 = trunc i64 %indvars.iv.26 to i32
  %add34.26 = add i32 %add33.26, %671
  %idxprom35.26 = sext i32 %add34.26 to i64
  %arrayidx36.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.26
  %672 = load float, float* %arrayidx36.26, align 4
  %673 = trunc i64 %indvars.iv.26 to i32
  %add39.26 = add i32 %sub38.26, %673
  %idxprom40.26 = sext i32 %add39.26 to i64
  %arrayidx41.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.26
  %674 = load float, float* %arrayidx41.26, align 4
  br label %if.end106.26

if.end106.26:                                     ; preds = %if.then31.26, %if.then50.26, %if.then71.26, %if.then90.26, %if.else82.26
  %q.3.26 = phi float [ %672, %if.then31.26 ], [ %669, %if.then50.26 ], [ %665, %if.then71.26 ], [ %662, %if.then90.26 ], [ 2.550000e+02, %if.else82.26 ]
  %r.3.26 = phi float [ %674, %if.then31.26 ], [ %670, %if.then50.26 ], [ %667, %if.then71.26 ], [ %663, %if.then90.26 ], [ 2.550000e+02, %if.else82.26 ]
  %arrayidx108.26 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %659
  %675 = load float, float* %arrayidx108.26, align 4
  %cmp109.26 = fcmp ult float %675, %q.3.26
  %cmp114.26 = fcmp ult float %675, %r.3.26
  %or.cond8.26 = or i1 %cmp109.26, %cmp114.26
  br i1 %or.cond8.26, label %if.else122.26, label %if.then116.26

if.then116.26:                                    ; preds = %if.end106.26
  %conv119.26 = fptoui float %675 to i32
  %arrayidx121.26 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %659
  store i32 %conv119.26, i32* %arrayidx121.26, align 4
  br label %for.inc.26

if.else122.26:                                    ; preds = %if.end106.26
  %arrayidx124.26 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %659
  store i32 0, i32* %arrayidx124.26, align 4
  br label %for.inc.26

if.then.26:                                       ; preds = %for.body4.26
  %arrayidx.26 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %659
  store i32 0, i32* %arrayidx.26, align 4
  br label %for.inc.26

for.inc.26:                                       ; preds = %if.then.26, %if.else122.26, %if.then116.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %img_width
  br i1 %exitcond.26, label %for.inc127.26, label %for.body4.26, !llvm.loop !1

for.inc127.26:                                    ; preds = %for.inc.26
  %indvars.iv.next20.26 = add nsw i64 %indvars.iv19, 27
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.27

for.body4.lr.ph.27:                               ; preds = %for.inc127.26
  %676 = trunc i64 %indvars.iv.next20.26 to i32
  %mul.27 = shl nsw i32 %676, 7
  %cmp6.27 = icmp eq i64 %indvars.iv.next20.26, %1
  %add33.27 = or i32 %mul.27, 1
  %sub38.27 = add i32 %mul.27, -1
  %677 = trunc i64 %indvars.iv.next20.26 to i32
  %add51.27 = shl i32 %677, 7
  %678 = trunc i64 %indvars.iv.next20.26 to i32
  %add72.27 = shl i32 %678, 7
  %mul73.27 = add i32 %add72.27, 128
  %mul78.27 = add i32 %add72.27, -128
  %679 = trunc i64 %indvars.iv.next20.26 to i32
  %sub91.27 = shl i32 %679, 7
  %680 = sext i32 %mul.27 to i64
  %681 = sext i32 %mul78.27 to i64
  %682 = sext i32 %mul73.27 to i64
  br label %for.body4.27

for.body4.27:                                     ; preds = %for.inc.27, %for.body4.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body4.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc.27 ]
  %683 = add nsw i64 %indvars.iv.27, %680
  %cmp8.27 = icmp eq i64 %indvars.iv.27, 0
  %or.cond1.27 = or i1 %cmp6.27, %cmp8.27
  %cmp10.27 = icmp eq i64 %indvars.iv.27, %0
  %or.cond2.27 = or i1 %cmp10.27, %or.cond1.27
  br i1 %or.cond2.27, label %if.then.27, label %if.else.27

if.else.27:                                       ; preds = %for.body4.27
  %arrayidx12.27 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %683
  %684 = load float, float* %arrayidx12.27, align 4
  %conv.27 = fpext float %684 to double
  %mul13.27 = fmul double %conv.27, 0x404CA5DC1A63C1F8
  %conv14.27 = fptrunc double %mul13.27 to float
  %cmp15.27 = fcmp olt float %conv14.27, 0.000000e+00
  %add18.27 = fadd float %conv14.27, 1.800000e+02
  %angle.0.27 = select i1 %cmp15.27, float %add18.27, float %conv14.27
  %cmp19.27 = fcmp oge float %angle.0.27, 0.000000e+00
  %cmp22.27 = fcmp olt float %angle.0.27, 2.250000e+01
  %or.cond3.27 = and i1 %cmp19.27, %cmp22.27
  br i1 %or.cond3.27, label %if.then31.27, label %lor.lhs.false24.27

lor.lhs.false24.27:                               ; preds = %if.else.27
  %cmp26.27 = fcmp ult float %angle.0.27, 1.575000e+02
  %cmp29.27 = fcmp ugt float %angle.0.27, 1.800000e+02
  %or.cond4.27 = or i1 %cmp26.27, %cmp29.27
  br i1 %or.cond4.27, label %if.else42.27, label %if.then31.27

if.else42.27:                                     ; preds = %lor.lhs.false24.27
  %cmp44.27 = fcmp oge float %angle.0.27, 2.250000e+01
  %cmp48.27 = fcmp olt float %angle.0.27, 6.750000e+01
  %or.cond5.27 = and i1 %cmp44.27, %cmp48.27
  br i1 %or.cond5.27, label %if.then50.27, label %if.else63.27

if.else63.27:                                     ; preds = %if.else42.27
  %cmp65.27 = fcmp oge float %angle.0.27, 6.750000e+01
  %cmp69.27 = fcmp olt float %angle.0.27, 1.125000e+02
  %or.cond6.27 = and i1 %cmp65.27, %cmp69.27
  br i1 %or.cond6.27, label %if.then71.27, label %if.else82.27

if.else82.27:                                     ; preds = %if.else63.27
  %cmp84.27 = fcmp oge float %angle.0.27, 1.125000e+02
  %cmp88.27 = fcmp olt float %angle.0.27, 1.575000e+02
  %or.cond7.27 = and i1 %cmp84.27, %cmp88.27
  br i1 %or.cond7.27, label %if.then90.27, label %if.end106.27

if.then90.27:                                     ; preds = %if.else82.27
  %685 = trunc i64 %indvars.iv.27 to i32
  %sub93.27 = add i32 %685, %sub91.27
  %add94.27 = add i32 %sub93.27, -129
  %idxprom95.27 = sext i32 %add94.27 to i64
  %arrayidx96.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.27
  %686 = load float, float* %arrayidx96.27, align 4
  %add100.27 = add i32 %sub93.27, 129
  %idxprom101.27 = sext i32 %add100.27 to i64
  %arrayidx102.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.27
  %687 = load float, float* %arrayidx102.27, align 4
  br label %if.end106.27

if.then71.27:                                     ; preds = %if.else63.27
  %688 = add nsw i64 %682, %indvars.iv.27
  %arrayidx76.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %688
  %689 = load float, float* %arrayidx76.27, align 4
  %690 = add nsw i64 %681, %indvars.iv.27
  %arrayidx81.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %690
  %691 = load float, float* %arrayidx81.27, align 4
  br label %if.end106.27

if.then50.27:                                     ; preds = %if.else42.27
  %692 = trunc i64 %indvars.iv.27 to i32
  %sub53.27 = add i32 %692, %add51.27
  %add54.27 = add i32 %sub53.27, 127
  %idxprom55.27 = sext i32 %add54.27 to i64
  %arrayidx56.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.27
  %693 = load float, float* %arrayidx56.27, align 4
  %add60.27 = add i32 %sub53.27, -127
  %idxprom61.27 = sext i32 %add60.27 to i64
  %arrayidx62.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.27
  %694 = load float, float* %arrayidx62.27, align 4
  br label %if.end106.27

if.then31.27:                                     ; preds = %lor.lhs.false24.27, %if.else.27
  %695 = trunc i64 %indvars.iv.27 to i32
  %add34.27 = add i32 %add33.27, %695
  %idxprom35.27 = sext i32 %add34.27 to i64
  %arrayidx36.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.27
  %696 = load float, float* %arrayidx36.27, align 4
  %697 = trunc i64 %indvars.iv.27 to i32
  %add39.27 = add i32 %sub38.27, %697
  %idxprom40.27 = sext i32 %add39.27 to i64
  %arrayidx41.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.27
  %698 = load float, float* %arrayidx41.27, align 4
  br label %if.end106.27

if.end106.27:                                     ; preds = %if.then31.27, %if.then50.27, %if.then71.27, %if.then90.27, %if.else82.27
  %q.3.27 = phi float [ %696, %if.then31.27 ], [ %693, %if.then50.27 ], [ %689, %if.then71.27 ], [ %686, %if.then90.27 ], [ 2.550000e+02, %if.else82.27 ]
  %r.3.27 = phi float [ %698, %if.then31.27 ], [ %694, %if.then50.27 ], [ %691, %if.then71.27 ], [ %687, %if.then90.27 ], [ 2.550000e+02, %if.else82.27 ]
  %arrayidx108.27 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %683
  %699 = load float, float* %arrayidx108.27, align 4
  %cmp109.27 = fcmp ult float %699, %q.3.27
  %cmp114.27 = fcmp ult float %699, %r.3.27
  %or.cond8.27 = or i1 %cmp109.27, %cmp114.27
  br i1 %or.cond8.27, label %if.else122.27, label %if.then116.27

if.then116.27:                                    ; preds = %if.end106.27
  %conv119.27 = fptoui float %699 to i32
  %arrayidx121.27 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %683
  store i32 %conv119.27, i32* %arrayidx121.27, align 4
  br label %for.inc.27

if.else122.27:                                    ; preds = %if.end106.27
  %arrayidx124.27 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %683
  store i32 0, i32* %arrayidx124.27, align 4
  br label %for.inc.27

if.then.27:                                       ; preds = %for.body4.27
  %arrayidx.27 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %683
  store i32 0, i32* %arrayidx.27, align 4
  br label %for.inc.27

for.inc.27:                                       ; preds = %if.then.27, %if.else122.27, %if.then116.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %img_width
  br i1 %exitcond.27, label %for.inc127.27, label %for.body4.27, !llvm.loop !1

for.inc127.27:                                    ; preds = %for.inc.27
  %indvars.iv.next20.27 = add nsw i64 %indvars.iv19, 28
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.28

for.body4.lr.ph.28:                               ; preds = %for.inc127.27
  %700 = trunc i64 %indvars.iv.next20.27 to i32
  %mul.28 = shl nsw i32 %700, 7
  %cmp6.28 = icmp eq i64 %indvars.iv.next20.27, %1
  %add33.28 = or i32 %mul.28, 1
  %sub38.28 = add i32 %mul.28, -1
  %701 = trunc i64 %indvars.iv.next20.27 to i32
  %add51.28 = shl i32 %701, 7
  %702 = trunc i64 %indvars.iv.next20.27 to i32
  %add72.28 = shl i32 %702, 7
  %mul73.28 = add i32 %add72.28, 128
  %mul78.28 = add i32 %add72.28, -128
  %703 = trunc i64 %indvars.iv.next20.27 to i32
  %sub91.28 = shl i32 %703, 7
  %704 = sext i32 %mul.28 to i64
  %705 = sext i32 %mul78.28 to i64
  %706 = sext i32 %mul73.28 to i64
  br label %for.body4.28

for.body4.28:                                     ; preds = %for.inc.28, %for.body4.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body4.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc.28 ]
  %707 = add nsw i64 %indvars.iv.28, %704
  %cmp8.28 = icmp eq i64 %indvars.iv.28, 0
  %or.cond1.28 = or i1 %cmp6.28, %cmp8.28
  %cmp10.28 = icmp eq i64 %indvars.iv.28, %0
  %or.cond2.28 = or i1 %cmp10.28, %or.cond1.28
  br i1 %or.cond2.28, label %if.then.28, label %if.else.28

if.else.28:                                       ; preds = %for.body4.28
  %arrayidx12.28 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %707
  %708 = load float, float* %arrayidx12.28, align 4
  %conv.28 = fpext float %708 to double
  %mul13.28 = fmul double %conv.28, 0x404CA5DC1A63C1F8
  %conv14.28 = fptrunc double %mul13.28 to float
  %cmp15.28 = fcmp olt float %conv14.28, 0.000000e+00
  %add18.28 = fadd float %conv14.28, 1.800000e+02
  %angle.0.28 = select i1 %cmp15.28, float %add18.28, float %conv14.28
  %cmp19.28 = fcmp oge float %angle.0.28, 0.000000e+00
  %cmp22.28 = fcmp olt float %angle.0.28, 2.250000e+01
  %or.cond3.28 = and i1 %cmp19.28, %cmp22.28
  br i1 %or.cond3.28, label %if.then31.28, label %lor.lhs.false24.28

lor.lhs.false24.28:                               ; preds = %if.else.28
  %cmp26.28 = fcmp ult float %angle.0.28, 1.575000e+02
  %cmp29.28 = fcmp ugt float %angle.0.28, 1.800000e+02
  %or.cond4.28 = or i1 %cmp26.28, %cmp29.28
  br i1 %or.cond4.28, label %if.else42.28, label %if.then31.28

if.else42.28:                                     ; preds = %lor.lhs.false24.28
  %cmp44.28 = fcmp oge float %angle.0.28, 2.250000e+01
  %cmp48.28 = fcmp olt float %angle.0.28, 6.750000e+01
  %or.cond5.28 = and i1 %cmp44.28, %cmp48.28
  br i1 %or.cond5.28, label %if.then50.28, label %if.else63.28

if.else63.28:                                     ; preds = %if.else42.28
  %cmp65.28 = fcmp oge float %angle.0.28, 6.750000e+01
  %cmp69.28 = fcmp olt float %angle.0.28, 1.125000e+02
  %or.cond6.28 = and i1 %cmp65.28, %cmp69.28
  br i1 %or.cond6.28, label %if.then71.28, label %if.else82.28

if.else82.28:                                     ; preds = %if.else63.28
  %cmp84.28 = fcmp oge float %angle.0.28, 1.125000e+02
  %cmp88.28 = fcmp olt float %angle.0.28, 1.575000e+02
  %or.cond7.28 = and i1 %cmp84.28, %cmp88.28
  br i1 %or.cond7.28, label %if.then90.28, label %if.end106.28

if.then90.28:                                     ; preds = %if.else82.28
  %709 = trunc i64 %indvars.iv.28 to i32
  %sub93.28 = add i32 %709, %sub91.28
  %add94.28 = add i32 %sub93.28, -129
  %idxprom95.28 = sext i32 %add94.28 to i64
  %arrayidx96.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.28
  %710 = load float, float* %arrayidx96.28, align 4
  %add100.28 = add i32 %sub93.28, 129
  %idxprom101.28 = sext i32 %add100.28 to i64
  %arrayidx102.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.28
  %711 = load float, float* %arrayidx102.28, align 4
  br label %if.end106.28

if.then71.28:                                     ; preds = %if.else63.28
  %712 = add nsw i64 %706, %indvars.iv.28
  %arrayidx76.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %712
  %713 = load float, float* %arrayidx76.28, align 4
  %714 = add nsw i64 %705, %indvars.iv.28
  %arrayidx81.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %714
  %715 = load float, float* %arrayidx81.28, align 4
  br label %if.end106.28

if.then50.28:                                     ; preds = %if.else42.28
  %716 = trunc i64 %indvars.iv.28 to i32
  %sub53.28 = add i32 %716, %add51.28
  %add54.28 = add i32 %sub53.28, 127
  %idxprom55.28 = sext i32 %add54.28 to i64
  %arrayidx56.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.28
  %717 = load float, float* %arrayidx56.28, align 4
  %add60.28 = add i32 %sub53.28, -127
  %idxprom61.28 = sext i32 %add60.28 to i64
  %arrayidx62.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.28
  %718 = load float, float* %arrayidx62.28, align 4
  br label %if.end106.28

if.then31.28:                                     ; preds = %lor.lhs.false24.28, %if.else.28
  %719 = trunc i64 %indvars.iv.28 to i32
  %add34.28 = add i32 %add33.28, %719
  %idxprom35.28 = sext i32 %add34.28 to i64
  %arrayidx36.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.28
  %720 = load float, float* %arrayidx36.28, align 4
  %721 = trunc i64 %indvars.iv.28 to i32
  %add39.28 = add i32 %sub38.28, %721
  %idxprom40.28 = sext i32 %add39.28 to i64
  %arrayidx41.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.28
  %722 = load float, float* %arrayidx41.28, align 4
  br label %if.end106.28

if.end106.28:                                     ; preds = %if.then31.28, %if.then50.28, %if.then71.28, %if.then90.28, %if.else82.28
  %q.3.28 = phi float [ %720, %if.then31.28 ], [ %717, %if.then50.28 ], [ %713, %if.then71.28 ], [ %710, %if.then90.28 ], [ 2.550000e+02, %if.else82.28 ]
  %r.3.28 = phi float [ %722, %if.then31.28 ], [ %718, %if.then50.28 ], [ %715, %if.then71.28 ], [ %711, %if.then90.28 ], [ 2.550000e+02, %if.else82.28 ]
  %arrayidx108.28 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %707
  %723 = load float, float* %arrayidx108.28, align 4
  %cmp109.28 = fcmp ult float %723, %q.3.28
  %cmp114.28 = fcmp ult float %723, %r.3.28
  %or.cond8.28 = or i1 %cmp109.28, %cmp114.28
  br i1 %or.cond8.28, label %if.else122.28, label %if.then116.28

if.then116.28:                                    ; preds = %if.end106.28
  %conv119.28 = fptoui float %723 to i32
  %arrayidx121.28 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %707
  store i32 %conv119.28, i32* %arrayidx121.28, align 4
  br label %for.inc.28

if.else122.28:                                    ; preds = %if.end106.28
  %arrayidx124.28 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %707
  store i32 0, i32* %arrayidx124.28, align 4
  br label %for.inc.28

if.then.28:                                       ; preds = %for.body4.28
  %arrayidx.28 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %707
  store i32 0, i32* %arrayidx.28, align 4
  br label %for.inc.28

for.inc.28:                                       ; preds = %if.then.28, %if.else122.28, %if.then116.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %img_width
  br i1 %exitcond.28, label %for.inc127.28, label %for.body4.28, !llvm.loop !1

for.inc127.28:                                    ; preds = %for.inc.28
  %indvars.iv.next20.28 = add nsw i64 %indvars.iv19, 29
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.29

for.body4.lr.ph.29:                               ; preds = %for.inc127.28
  %724 = trunc i64 %indvars.iv.next20.28 to i32
  %mul.29 = shl nsw i32 %724, 7
  %cmp6.29 = icmp eq i64 %indvars.iv.next20.28, %1
  %add33.29 = or i32 %mul.29, 1
  %sub38.29 = add i32 %mul.29, -1
  %725 = trunc i64 %indvars.iv.next20.28 to i32
  %add51.29 = shl i32 %725, 7
  %726 = trunc i64 %indvars.iv.next20.28 to i32
  %add72.29 = shl i32 %726, 7
  %mul73.29 = add i32 %add72.29, 128
  %mul78.29 = add i32 %add72.29, -128
  %727 = trunc i64 %indvars.iv.next20.28 to i32
  %sub91.29 = shl i32 %727, 7
  %728 = sext i32 %mul.29 to i64
  %729 = sext i32 %mul78.29 to i64
  %730 = sext i32 %mul73.29 to i64
  br label %for.body4.29

for.body4.29:                                     ; preds = %for.inc.29, %for.body4.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body4.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc.29 ]
  %731 = add nsw i64 %indvars.iv.29, %728
  %cmp8.29 = icmp eq i64 %indvars.iv.29, 0
  %or.cond1.29 = or i1 %cmp6.29, %cmp8.29
  %cmp10.29 = icmp eq i64 %indvars.iv.29, %0
  %or.cond2.29 = or i1 %cmp10.29, %or.cond1.29
  br i1 %or.cond2.29, label %if.then.29, label %if.else.29

if.else.29:                                       ; preds = %for.body4.29
  %arrayidx12.29 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %731
  %732 = load float, float* %arrayidx12.29, align 4
  %conv.29 = fpext float %732 to double
  %mul13.29 = fmul double %conv.29, 0x404CA5DC1A63C1F8
  %conv14.29 = fptrunc double %mul13.29 to float
  %cmp15.29 = fcmp olt float %conv14.29, 0.000000e+00
  %add18.29 = fadd float %conv14.29, 1.800000e+02
  %angle.0.29 = select i1 %cmp15.29, float %add18.29, float %conv14.29
  %cmp19.29 = fcmp oge float %angle.0.29, 0.000000e+00
  %cmp22.29 = fcmp olt float %angle.0.29, 2.250000e+01
  %or.cond3.29 = and i1 %cmp19.29, %cmp22.29
  br i1 %or.cond3.29, label %if.then31.29, label %lor.lhs.false24.29

lor.lhs.false24.29:                               ; preds = %if.else.29
  %cmp26.29 = fcmp ult float %angle.0.29, 1.575000e+02
  %cmp29.29 = fcmp ugt float %angle.0.29, 1.800000e+02
  %or.cond4.29 = or i1 %cmp26.29, %cmp29.29
  br i1 %or.cond4.29, label %if.else42.29, label %if.then31.29

if.else42.29:                                     ; preds = %lor.lhs.false24.29
  %cmp44.29 = fcmp oge float %angle.0.29, 2.250000e+01
  %cmp48.29 = fcmp olt float %angle.0.29, 6.750000e+01
  %or.cond5.29 = and i1 %cmp44.29, %cmp48.29
  br i1 %or.cond5.29, label %if.then50.29, label %if.else63.29

if.else63.29:                                     ; preds = %if.else42.29
  %cmp65.29 = fcmp oge float %angle.0.29, 6.750000e+01
  %cmp69.29 = fcmp olt float %angle.0.29, 1.125000e+02
  %or.cond6.29 = and i1 %cmp65.29, %cmp69.29
  br i1 %or.cond6.29, label %if.then71.29, label %if.else82.29

if.else82.29:                                     ; preds = %if.else63.29
  %cmp84.29 = fcmp oge float %angle.0.29, 1.125000e+02
  %cmp88.29 = fcmp olt float %angle.0.29, 1.575000e+02
  %or.cond7.29 = and i1 %cmp84.29, %cmp88.29
  br i1 %or.cond7.29, label %if.then90.29, label %if.end106.29

if.then90.29:                                     ; preds = %if.else82.29
  %733 = trunc i64 %indvars.iv.29 to i32
  %sub93.29 = add i32 %733, %sub91.29
  %add94.29 = add i32 %sub93.29, -129
  %idxprom95.29 = sext i32 %add94.29 to i64
  %arrayidx96.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.29
  %734 = load float, float* %arrayidx96.29, align 4
  %add100.29 = add i32 %sub93.29, 129
  %idxprom101.29 = sext i32 %add100.29 to i64
  %arrayidx102.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.29
  %735 = load float, float* %arrayidx102.29, align 4
  br label %if.end106.29

if.then71.29:                                     ; preds = %if.else63.29
  %736 = add nsw i64 %730, %indvars.iv.29
  %arrayidx76.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %736
  %737 = load float, float* %arrayidx76.29, align 4
  %738 = add nsw i64 %729, %indvars.iv.29
  %arrayidx81.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %738
  %739 = load float, float* %arrayidx81.29, align 4
  br label %if.end106.29

if.then50.29:                                     ; preds = %if.else42.29
  %740 = trunc i64 %indvars.iv.29 to i32
  %sub53.29 = add i32 %740, %add51.29
  %add54.29 = add i32 %sub53.29, 127
  %idxprom55.29 = sext i32 %add54.29 to i64
  %arrayidx56.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.29
  %741 = load float, float* %arrayidx56.29, align 4
  %add60.29 = add i32 %sub53.29, -127
  %idxprom61.29 = sext i32 %add60.29 to i64
  %arrayidx62.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.29
  %742 = load float, float* %arrayidx62.29, align 4
  br label %if.end106.29

if.then31.29:                                     ; preds = %lor.lhs.false24.29, %if.else.29
  %743 = trunc i64 %indvars.iv.29 to i32
  %add34.29 = add i32 %add33.29, %743
  %idxprom35.29 = sext i32 %add34.29 to i64
  %arrayidx36.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.29
  %744 = load float, float* %arrayidx36.29, align 4
  %745 = trunc i64 %indvars.iv.29 to i32
  %add39.29 = add i32 %sub38.29, %745
  %idxprom40.29 = sext i32 %add39.29 to i64
  %arrayidx41.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.29
  %746 = load float, float* %arrayidx41.29, align 4
  br label %if.end106.29

if.end106.29:                                     ; preds = %if.then31.29, %if.then50.29, %if.then71.29, %if.then90.29, %if.else82.29
  %q.3.29 = phi float [ %744, %if.then31.29 ], [ %741, %if.then50.29 ], [ %737, %if.then71.29 ], [ %734, %if.then90.29 ], [ 2.550000e+02, %if.else82.29 ]
  %r.3.29 = phi float [ %746, %if.then31.29 ], [ %742, %if.then50.29 ], [ %739, %if.then71.29 ], [ %735, %if.then90.29 ], [ 2.550000e+02, %if.else82.29 ]
  %arrayidx108.29 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %731
  %747 = load float, float* %arrayidx108.29, align 4
  %cmp109.29 = fcmp ult float %747, %q.3.29
  %cmp114.29 = fcmp ult float %747, %r.3.29
  %or.cond8.29 = or i1 %cmp109.29, %cmp114.29
  br i1 %or.cond8.29, label %if.else122.29, label %if.then116.29

if.then116.29:                                    ; preds = %if.end106.29
  %conv119.29 = fptoui float %747 to i32
  %arrayidx121.29 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %731
  store i32 %conv119.29, i32* %arrayidx121.29, align 4
  br label %for.inc.29

if.else122.29:                                    ; preds = %if.end106.29
  %arrayidx124.29 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %731
  store i32 0, i32* %arrayidx124.29, align 4
  br label %for.inc.29

if.then.29:                                       ; preds = %for.body4.29
  %arrayidx.29 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %731
  store i32 0, i32* %arrayidx.29, align 4
  br label %for.inc.29

for.inc.29:                                       ; preds = %if.then.29, %if.else122.29, %if.then116.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %img_width
  br i1 %exitcond.29, label %for.inc127.29, label %for.body4.29, !llvm.loop !1

for.inc127.29:                                    ; preds = %for.inc.29
  %indvars.iv.next20.29 = add nsw i64 %indvars.iv19, 30
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.30

for.body4.lr.ph.30:                               ; preds = %for.inc127.29
  %748 = trunc i64 %indvars.iv.next20.29 to i32
  %mul.30 = shl nsw i32 %748, 7
  %cmp6.30 = icmp eq i64 %indvars.iv.next20.29, %1
  %add33.30 = or i32 %mul.30, 1
  %sub38.30 = add i32 %mul.30, -1
  %749 = trunc i64 %indvars.iv.next20.29 to i32
  %add51.30 = shl i32 %749, 7
  %750 = trunc i64 %indvars.iv.next20.29 to i32
  %add72.30 = shl i32 %750, 7
  %mul73.30 = add i32 %add72.30, 128
  %mul78.30 = add i32 %add72.30, -128
  %751 = trunc i64 %indvars.iv.next20.29 to i32
  %sub91.30 = shl i32 %751, 7
  %752 = sext i32 %mul.30 to i64
  %753 = sext i32 %mul78.30 to i64
  %754 = sext i32 %mul73.30 to i64
  br label %for.body4.30

for.body4.30:                                     ; preds = %for.inc.30, %for.body4.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body4.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc.30 ]
  %755 = add nsw i64 %indvars.iv.30, %752
  %cmp8.30 = icmp eq i64 %indvars.iv.30, 0
  %or.cond1.30 = or i1 %cmp6.30, %cmp8.30
  %cmp10.30 = icmp eq i64 %indvars.iv.30, %0
  %or.cond2.30 = or i1 %cmp10.30, %or.cond1.30
  br i1 %or.cond2.30, label %if.then.30, label %if.else.30

if.else.30:                                       ; preds = %for.body4.30
  %arrayidx12.30 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %755
  %756 = load float, float* %arrayidx12.30, align 4
  %conv.30 = fpext float %756 to double
  %mul13.30 = fmul double %conv.30, 0x404CA5DC1A63C1F8
  %conv14.30 = fptrunc double %mul13.30 to float
  %cmp15.30 = fcmp olt float %conv14.30, 0.000000e+00
  %add18.30 = fadd float %conv14.30, 1.800000e+02
  %angle.0.30 = select i1 %cmp15.30, float %add18.30, float %conv14.30
  %cmp19.30 = fcmp oge float %angle.0.30, 0.000000e+00
  %cmp22.30 = fcmp olt float %angle.0.30, 2.250000e+01
  %or.cond3.30 = and i1 %cmp19.30, %cmp22.30
  br i1 %or.cond3.30, label %if.then31.30, label %lor.lhs.false24.30

lor.lhs.false24.30:                               ; preds = %if.else.30
  %cmp26.30 = fcmp ult float %angle.0.30, 1.575000e+02
  %cmp29.30 = fcmp ugt float %angle.0.30, 1.800000e+02
  %or.cond4.30 = or i1 %cmp26.30, %cmp29.30
  br i1 %or.cond4.30, label %if.else42.30, label %if.then31.30

if.else42.30:                                     ; preds = %lor.lhs.false24.30
  %cmp44.30 = fcmp oge float %angle.0.30, 2.250000e+01
  %cmp48.30 = fcmp olt float %angle.0.30, 6.750000e+01
  %or.cond5.30 = and i1 %cmp44.30, %cmp48.30
  br i1 %or.cond5.30, label %if.then50.30, label %if.else63.30

if.else63.30:                                     ; preds = %if.else42.30
  %cmp65.30 = fcmp oge float %angle.0.30, 6.750000e+01
  %cmp69.30 = fcmp olt float %angle.0.30, 1.125000e+02
  %or.cond6.30 = and i1 %cmp65.30, %cmp69.30
  br i1 %or.cond6.30, label %if.then71.30, label %if.else82.30

if.else82.30:                                     ; preds = %if.else63.30
  %cmp84.30 = fcmp oge float %angle.0.30, 1.125000e+02
  %cmp88.30 = fcmp olt float %angle.0.30, 1.575000e+02
  %or.cond7.30 = and i1 %cmp84.30, %cmp88.30
  br i1 %or.cond7.30, label %if.then90.30, label %if.end106.30

if.then90.30:                                     ; preds = %if.else82.30
  %757 = trunc i64 %indvars.iv.30 to i32
  %sub93.30 = add i32 %757, %sub91.30
  %add94.30 = add i32 %sub93.30, -129
  %idxprom95.30 = sext i32 %add94.30 to i64
  %arrayidx96.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.30
  %758 = load float, float* %arrayidx96.30, align 4
  %add100.30 = add i32 %sub93.30, 129
  %idxprom101.30 = sext i32 %add100.30 to i64
  %arrayidx102.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.30
  %759 = load float, float* %arrayidx102.30, align 4
  br label %if.end106.30

if.then71.30:                                     ; preds = %if.else63.30
  %760 = add nsw i64 %754, %indvars.iv.30
  %arrayidx76.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %760
  %761 = load float, float* %arrayidx76.30, align 4
  %762 = add nsw i64 %753, %indvars.iv.30
  %arrayidx81.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %762
  %763 = load float, float* %arrayidx81.30, align 4
  br label %if.end106.30

if.then50.30:                                     ; preds = %if.else42.30
  %764 = trunc i64 %indvars.iv.30 to i32
  %sub53.30 = add i32 %764, %add51.30
  %add54.30 = add i32 %sub53.30, 127
  %idxprom55.30 = sext i32 %add54.30 to i64
  %arrayidx56.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.30
  %765 = load float, float* %arrayidx56.30, align 4
  %add60.30 = add i32 %sub53.30, -127
  %idxprom61.30 = sext i32 %add60.30 to i64
  %arrayidx62.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.30
  %766 = load float, float* %arrayidx62.30, align 4
  br label %if.end106.30

if.then31.30:                                     ; preds = %lor.lhs.false24.30, %if.else.30
  %767 = trunc i64 %indvars.iv.30 to i32
  %add34.30 = add i32 %add33.30, %767
  %idxprom35.30 = sext i32 %add34.30 to i64
  %arrayidx36.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.30
  %768 = load float, float* %arrayidx36.30, align 4
  %769 = trunc i64 %indvars.iv.30 to i32
  %add39.30 = add i32 %sub38.30, %769
  %idxprom40.30 = sext i32 %add39.30 to i64
  %arrayidx41.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.30
  %770 = load float, float* %arrayidx41.30, align 4
  br label %if.end106.30

if.end106.30:                                     ; preds = %if.then31.30, %if.then50.30, %if.then71.30, %if.then90.30, %if.else82.30
  %q.3.30 = phi float [ %768, %if.then31.30 ], [ %765, %if.then50.30 ], [ %761, %if.then71.30 ], [ %758, %if.then90.30 ], [ 2.550000e+02, %if.else82.30 ]
  %r.3.30 = phi float [ %770, %if.then31.30 ], [ %766, %if.then50.30 ], [ %763, %if.then71.30 ], [ %759, %if.then90.30 ], [ 2.550000e+02, %if.else82.30 ]
  %arrayidx108.30 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %755
  %771 = load float, float* %arrayidx108.30, align 4
  %cmp109.30 = fcmp ult float %771, %q.3.30
  %cmp114.30 = fcmp ult float %771, %r.3.30
  %or.cond8.30 = or i1 %cmp109.30, %cmp114.30
  br i1 %or.cond8.30, label %if.else122.30, label %if.then116.30

if.then116.30:                                    ; preds = %if.end106.30
  %conv119.30 = fptoui float %771 to i32
  %arrayidx121.30 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %755
  store i32 %conv119.30, i32* %arrayidx121.30, align 4
  br label %for.inc.30

if.else122.30:                                    ; preds = %if.end106.30
  %arrayidx124.30 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %755
  store i32 0, i32* %arrayidx124.30, align 4
  br label %for.inc.30

if.then.30:                                       ; preds = %for.body4.30
  %arrayidx.30 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %755
  store i32 0, i32* %arrayidx.30, align 4
  br label %for.inc.30

for.inc.30:                                       ; preds = %if.then.30, %if.else122.30, %if.then116.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %img_width
  br i1 %exitcond.30, label %for.inc127.30, label %for.body4.30, !llvm.loop !1

for.inc127.30:                                    ; preds = %for.inc.30
  %indvars.iv.next20.30 = add nsw i64 %indvars.iv19, 31
  br i1 %cmp39, label %for.inc127.31, label %for.body4.lr.ph.31

for.body4.lr.ph.31:                               ; preds = %for.inc127.30
  %772 = trunc i64 %indvars.iv.next20.30 to i32
  %mul.31 = shl nsw i32 %772, 7
  %cmp6.31 = icmp eq i64 %indvars.iv.next20.30, %1
  %add33.31 = or i32 %mul.31, 1
  %sub38.31 = add i32 %mul.31, -1
  %773 = trunc i64 %indvars.iv.next20.30 to i32
  %add51.31 = shl i32 %773, 7
  %774 = trunc i64 %indvars.iv.next20.30 to i32
  %add72.31 = shl i32 %774, 7
  %mul73.31 = add i32 %add72.31, 128
  %mul78.31 = add i32 %add72.31, -128
  %775 = trunc i64 %indvars.iv.next20.30 to i32
  %sub91.31 = shl i32 %775, 7
  %776 = sext i32 %mul.31 to i64
  %777 = sext i32 %mul78.31 to i64
  %778 = sext i32 %mul73.31 to i64
  br label %for.body4.31

for.body4.31:                                     ; preds = %for.inc.31, %for.body4.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body4.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc.31 ]
  %779 = add nsw i64 %indvars.iv.31, %776
  %cmp8.31 = icmp eq i64 %indvars.iv.31, 0
  %or.cond1.31 = or i1 %cmp6.31, %cmp8.31
  %cmp10.31 = icmp eq i64 %indvars.iv.31, %0
  %or.cond2.31 = or i1 %cmp10.31, %or.cond1.31
  br i1 %or.cond2.31, label %if.then.31, label %if.else.31

if.else.31:                                       ; preds = %for.body4.31
  %arrayidx12.31 = getelementptr inbounds float, float* inttoptr (i64 553713728 to float*), i64 %779
  %780 = load float, float* %arrayidx12.31, align 4
  %conv.31 = fpext float %780 to double
  %mul13.31 = fmul double %conv.31, 0x404CA5DC1A63C1F8
  %conv14.31 = fptrunc double %mul13.31 to float
  %cmp15.31 = fcmp olt float %conv14.31, 0.000000e+00
  %add18.31 = fadd float %conv14.31, 1.800000e+02
  %angle.0.31 = select i1 %cmp15.31, float %add18.31, float %conv14.31
  %cmp19.31 = fcmp oge float %angle.0.31, 0.000000e+00
  %cmp22.31 = fcmp olt float %angle.0.31, 2.250000e+01
  %or.cond3.31 = and i1 %cmp19.31, %cmp22.31
  br i1 %or.cond3.31, label %if.then31.31, label %lor.lhs.false24.31

lor.lhs.false24.31:                               ; preds = %if.else.31
  %cmp26.31 = fcmp ult float %angle.0.31, 1.575000e+02
  %cmp29.31 = fcmp ugt float %angle.0.31, 1.800000e+02
  %or.cond4.31 = or i1 %cmp26.31, %cmp29.31
  br i1 %or.cond4.31, label %if.else42.31, label %if.then31.31

if.else42.31:                                     ; preds = %lor.lhs.false24.31
  %cmp44.31 = fcmp oge float %angle.0.31, 2.250000e+01
  %cmp48.31 = fcmp olt float %angle.0.31, 6.750000e+01
  %or.cond5.31 = and i1 %cmp44.31, %cmp48.31
  br i1 %or.cond5.31, label %if.then50.31, label %if.else63.31

if.else63.31:                                     ; preds = %if.else42.31
  %cmp65.31 = fcmp oge float %angle.0.31, 6.750000e+01
  %cmp69.31 = fcmp olt float %angle.0.31, 1.125000e+02
  %or.cond6.31 = and i1 %cmp65.31, %cmp69.31
  br i1 %or.cond6.31, label %if.then71.31, label %if.else82.31

if.else82.31:                                     ; preds = %if.else63.31
  %cmp84.31 = fcmp oge float %angle.0.31, 1.125000e+02
  %cmp88.31 = fcmp olt float %angle.0.31, 1.575000e+02
  %or.cond7.31 = and i1 %cmp84.31, %cmp88.31
  br i1 %or.cond7.31, label %if.then90.31, label %if.end106.31

if.then90.31:                                     ; preds = %if.else82.31
  %781 = trunc i64 %indvars.iv.31 to i32
  %sub93.31 = add i32 %781, %sub91.31
  %add94.31 = add i32 %sub93.31, -129
  %idxprom95.31 = sext i32 %add94.31 to i64
  %arrayidx96.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom95.31
  %782 = load float, float* %arrayidx96.31, align 4
  %add100.31 = add i32 %sub93.31, 129
  %idxprom101.31 = sext i32 %add100.31 to i64
  %arrayidx102.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom101.31
  %783 = load float, float* %arrayidx102.31, align 4
  br label %if.end106.31

if.then71.31:                                     ; preds = %if.else63.31
  %784 = add nsw i64 %778, %indvars.iv.31
  %arrayidx76.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %784
  %785 = load float, float* %arrayidx76.31, align 4
  %786 = add nsw i64 %777, %indvars.iv.31
  %arrayidx81.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %786
  %787 = load float, float* %arrayidx81.31, align 4
  br label %if.end106.31

if.then50.31:                                     ; preds = %if.else42.31
  %788 = trunc i64 %indvars.iv.31 to i32
  %sub53.31 = add i32 %788, %add51.31
  %add54.31 = add i32 %sub53.31, 127
  %idxprom55.31 = sext i32 %add54.31 to i64
  %arrayidx56.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom55.31
  %789 = load float, float* %arrayidx56.31, align 4
  %add60.31 = add i32 %sub53.31, -127
  %idxprom61.31 = sext i32 %add60.31 to i64
  %arrayidx62.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom61.31
  %790 = load float, float* %arrayidx62.31, align 4
  br label %if.end106.31

if.then31.31:                                     ; preds = %lor.lhs.false24.31, %if.else.31
  %791 = trunc i64 %indvars.iv.31 to i32
  %add34.31 = add i32 %add33.31, %791
  %idxprom35.31 = sext i32 %add34.31 to i64
  %arrayidx36.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom35.31
  %792 = load float, float* %arrayidx36.31, align 4
  %793 = trunc i64 %indvars.iv.31 to i32
  %add39.31 = add i32 %sub38.31, %793
  %idxprom40.31 = sext i32 %add39.31 to i64
  %arrayidx41.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %idxprom40.31
  %794 = load float, float* %arrayidx41.31, align 4
  br label %if.end106.31

if.end106.31:                                     ; preds = %if.then31.31, %if.then50.31, %if.then71.31, %if.then90.31, %if.else82.31
  %q.3.31 = phi float [ %792, %if.then31.31 ], [ %789, %if.then50.31 ], [ %785, %if.then71.31 ], [ %782, %if.then90.31 ], [ 2.550000e+02, %if.else82.31 ]
  %r.3.31 = phi float [ %794, %if.then31.31 ], [ %790, %if.then50.31 ], [ %787, %if.then71.31 ], [ %783, %if.then90.31 ], [ 2.550000e+02, %if.else82.31 ]
  %arrayidx108.31 = getelementptr inbounds float, float* inttoptr (i64 553648192 to float*), i64 %779
  %795 = load float, float* %arrayidx108.31, align 4
  %cmp109.31 = fcmp ult float %795, %q.3.31
  %cmp114.31 = fcmp ult float %795, %r.3.31
  %or.cond8.31 = or i1 %cmp109.31, %cmp114.31
  br i1 %or.cond8.31, label %if.else122.31, label %if.then116.31

if.then116.31:                                    ; preds = %if.end106.31
  %conv119.31 = fptoui float %795 to i32
  %arrayidx121.31 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %779
  store i32 %conv119.31, i32* %arrayidx121.31, align 4
  br label %for.inc.31

if.else122.31:                                    ; preds = %if.end106.31
  %arrayidx124.31 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %779
  store i32 0, i32* %arrayidx124.31, align 4
  br label %for.inc.31

if.then.31:                                       ; preds = %for.body4.31
  %arrayidx.31 = getelementptr inbounds i32, i32* inttoptr (i64 553779264 to i32*), i64 %779
  store i32 0, i32* %arrayidx.31, align 4
  br label %for.inc.31

for.inc.31:                                       ; preds = %if.then.31, %if.else122.31, %if.then116.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %img_width
  br i1 %exitcond.31, label %for.inc127.31.loopexit, label %for.body4.31, !llvm.loop !1

for.inc127.31.loopexit:                           ; preds = %for.inc.31
  br label %for.inc127.31

for.inc127.31:                                    ; preds = %for.inc127.31.loopexit, %for.cond2.preheader, %for.inc127, %for.inc127.1, %for.inc127.2, %for.inc127.3, %for.inc127.4, %for.inc127.5, %for.inc127.6, %for.inc127.7, %for.inc127.8, %for.inc127.9, %for.inc127.10, %for.inc127.11, %for.inc127.12, %for.inc127.13, %for.inc127.14, %for.inc127.15, %for.inc127.16, %for.inc127.17, %for.inc127.18, %for.inc127.19, %for.inc127.20, %for.inc127.21, %for.inc127.22, %for.inc127.23, %for.inc127.24, %for.inc127.25, %for.inc127.26, %for.inc127.27, %for.inc127.28, %for.inc127.29, %for.inc127.30
  %indvars.iv.next20.31 = add nsw i64 %indvars.iv19, 32
  %lftr.wideiv21.31 = trunc i64 %indvars.iv.next20.31 to i32
  %exitcond22.31 = icmp eq i32 %lftr.wideiv21.31, %img_height
  br i1 %exitcond22.31, label %for.end129.loopexit, label %for.cond2.preheader, !llvm.loop !4
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
