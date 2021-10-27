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
  %xtraiter = and i32 %img_height, 7
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
  %27 = icmp ult i32 %2, 7
  br i1 %27, label %for.end129, label %for.cond2.preheader.preheader

for.cond2.preheader.preheader:                    ; preds = %for.cond2.preheader.lr.ph.split
  br label %for.cond2.preheader

for.cond2.preheader:                              ; preds = %for.cond2.preheader.preheader, %for.inc127.7
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.7, %for.inc127.7 ], [ %indvars.iv19.unr, %for.cond2.preheader.preheader ]
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph

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
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph.1

for.end129.loopexit:                              ; preds = %for.inc127.7
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
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph.2

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
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph.3

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
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph.4

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
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph.5

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
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph.6

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
  br i1 %cmp39, label %for.inc127.7, label %for.body4.lr.ph.7

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
  br i1 %exitcond.7, label %for.inc127.7.loopexit, label %for.body4.7, !llvm.loop !1

for.inc127.7.loopexit:                            ; preds = %for.inc.7
  br label %for.inc127.7

for.inc127.7:                                     ; preds = %for.inc127.7.loopexit, %for.cond2.preheader, %for.inc127, %for.inc127.1, %for.inc127.2, %for.inc127.3, %for.inc127.4, %for.inc127.5, %for.inc127.6
  %indvars.iv.next20.7 = add nsw i64 %indvars.iv19, 8
  %lftr.wideiv21.7 = trunc i64 %indvars.iv.next20.7 to i32
  %exitcond22.7 = icmp eq i32 %lftr.wideiv21.7, %img_height
  br i1 %exitcond22.7, label %for.end129.loopexit, label %for.cond2.preheader, !llvm.loop !4
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
