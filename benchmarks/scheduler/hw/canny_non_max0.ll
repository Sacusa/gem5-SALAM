; ModuleID = 'canny_non_max0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @canny_non_max(i32 %img_height, i32 %img_width, i8 zeroext %spm_part) #0 {
entry:
  %cmp = icmp eq i8 %spm_part, 1
  %. = select i1 %cmp, i32* inttoptr (i64 553844768 to i32*), i32* inttoptr (i64 553779232 to i32*)
  %cmp313 = icmp eq i32 %img_height, 0
  br i1 %cmp313, label %for.end141, label %for.cond5.preheader.lr.ph

for.cond5.preheader.lr.ph:                        ; preds = %entry
  %sub2 = add i32 %img_width, -1
  %sub = add i32 %img_height, -1
  %cmp69 = icmp eq i32 %img_width, 0
  %0 = zext i32 %sub2 to i64
  %1 = zext i32 %sub to i64
  %2 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond5.preheader.lr.ph.split, label %for.cond5.preheader.prol.preheader

for.cond5.preheader.prol.preheader:               ; preds = %for.cond5.preheader.lr.ph
  br label %for.cond5.preheader.prol

for.cond5.preheader.prol:                         ; preds = %for.cond5.preheader.prol.preheader, %for.inc139.prol
  %indvars.iv19.prol = phi i64 [ %indvars.iv.next20.prol, %for.inc139.prol ], [ 0, %for.cond5.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc139.prol ], [ %xtraiter, %for.cond5.preheader.prol.preheader ]
  br i1 %cmp69, label %for.inc139.prol, label %for.body8.lr.ph.prol

for.body8.lr.ph.prol:                             ; preds = %for.cond5.preheader.prol
  %3 = trunc i64 %indvars.iv19.prol to i32
  %mul.prol = shl nsw i32 %3, 7
  %cmp9.prol = icmp eq i64 %indvars.iv19.prol, 0
  %cmp11.prol = icmp eq i64 %indvars.iv19.prol, %1
  %or.cond.prol = or i1 %cmp9.prol, %cmp11.prol
  %add45.prol = or i32 %mul.prol, 1
  %sub50.prol = add i32 %mul.prol, -1
  %4 = trunc i64 %indvars.iv19.prol to i32
  %add63.prol = shl i32 %4, 7
  %5 = trunc i64 %indvars.iv19.prol to i32
  %add84.prol = shl i32 %5, 7
  %mul85.prol = add i32 %add84.prol, 128
  %mul90.prol = add i32 %add84.prol, -128
  %6 = trunc i64 %indvars.iv19.prol to i32
  %sub103.prol = shl i32 %6, 7
  %7 = sext i32 %mul.prol to i64
  %8 = sext i32 %mul90.prol to i64
  %9 = sext i32 %mul85.prol to i64
  br label %for.body8.prol

for.body8.prol:                                   ; preds = %for.inc.prol, %for.body8.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body8.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc.prol ]
  %10 = add nsw i64 %indvars.iv.prol, %7
  %cmp14.prol = icmp eq i64 %indvars.iv.prol, 0
  %or.cond1.prol = or i1 %or.cond.prol, %cmp14.prol
  %cmp17.prol = icmp eq i64 %indvars.iv.prol, %0
  %or.cond2.prol = or i1 %cmp17.prol, %or.cond1.prol
  br i1 %or.cond2.prol, label %if.then19.prol, label %if.else20.prol

if.else20.prol:                                   ; preds = %for.body8.prol
  %arrayidx22.prol = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %10
  %11 = load float, float* %arrayidx22.prol, align 4
  %conv23.prol = fpext float %11 to double
  %mul24.prol = fmul double %conv23.prol, 0x404CA5DC1A63C1F8
  %conv25.prol = fptrunc double %mul24.prol to float
  %cmp26.prol = fcmp olt float %conv25.prol, 0.000000e+00
  %add29.prol = fadd float %conv25.prol, 1.800000e+02
  %angle.0.prol = select i1 %cmp26.prol, float %add29.prol, float %conv25.prol
  %cmp31.prol = fcmp oge float %angle.0.prol, 0.000000e+00
  %cmp34.prol = fcmp olt float %angle.0.prol, 2.250000e+01
  %or.cond3.prol = and i1 %cmp31.prol, %cmp34.prol
  br i1 %or.cond3.prol, label %if.then43.prol, label %lor.lhs.false36.prol

lor.lhs.false36.prol:                             ; preds = %if.else20.prol
  %cmp38.prol = fcmp ult float %angle.0.prol, 1.575000e+02
  %cmp41.prol = fcmp ugt float %angle.0.prol, 1.800000e+02
  %or.cond4.prol = or i1 %cmp38.prol, %cmp41.prol
  br i1 %or.cond4.prol, label %if.else54.prol, label %if.then43.prol

if.else54.prol:                                   ; preds = %lor.lhs.false36.prol
  %cmp56.prol = fcmp oge float %angle.0.prol, 2.250000e+01
  %cmp60.prol = fcmp olt float %angle.0.prol, 6.750000e+01
  %or.cond5.prol = and i1 %cmp56.prol, %cmp60.prol
  br i1 %or.cond5.prol, label %if.then62.prol, label %if.else75.prol

if.else75.prol:                                   ; preds = %if.else54.prol
  %cmp77.prol = fcmp oge float %angle.0.prol, 6.750000e+01
  %cmp81.prol = fcmp olt float %angle.0.prol, 1.125000e+02
  %or.cond6.prol = and i1 %cmp77.prol, %cmp81.prol
  br i1 %or.cond6.prol, label %if.then83.prol, label %if.else94.prol

if.else94.prol:                                   ; preds = %if.else75.prol
  %cmp96.prol = fcmp oge float %angle.0.prol, 1.125000e+02
  %cmp100.prol = fcmp olt float %angle.0.prol, 1.575000e+02
  %or.cond7.prol = and i1 %cmp96.prol, %cmp100.prol
  br i1 %or.cond7.prol, label %if.then102.prol, label %if.end118.prol

if.then102.prol:                                  ; preds = %if.else94.prol
  %12 = trunc i64 %indvars.iv.prol to i32
  %sub105.prol = add i32 %12, %sub103.prol
  %add106.prol = add i32 %sub105.prol, -129
  %idxprom107.prol = sext i32 %add106.prol to i64
  %arrayidx108.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.prol
  %13 = load float, float* %arrayidx108.prol, align 4
  %add112.prol = add i32 %sub105.prol, 129
  %idxprom113.prol = sext i32 %add112.prol to i64
  %arrayidx114.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.prol
  %14 = load float, float* %arrayidx114.prol, align 4
  br label %if.end118.prol

if.then83.prol:                                   ; preds = %if.else75.prol
  %15 = add nsw i64 %9, %indvars.iv.prol
  %arrayidx88.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %15
  %16 = load float, float* %arrayidx88.prol, align 4
  %17 = add nsw i64 %8, %indvars.iv.prol
  %arrayidx93.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %17
  %18 = load float, float* %arrayidx93.prol, align 4
  br label %if.end118.prol

if.then62.prol:                                   ; preds = %if.else54.prol
  %19 = trunc i64 %indvars.iv.prol to i32
  %sub65.prol = add i32 %19, %add63.prol
  %add66.prol = add i32 %sub65.prol, 127
  %idxprom67.prol = sext i32 %add66.prol to i64
  %arrayidx68.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.prol
  %20 = load float, float* %arrayidx68.prol, align 4
  %add72.prol = add i32 %sub65.prol, -127
  %idxprom73.prol = sext i32 %add72.prol to i64
  %arrayidx74.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.prol
  %21 = load float, float* %arrayidx74.prol, align 4
  br label %if.end118.prol

if.then43.prol:                                   ; preds = %lor.lhs.false36.prol, %if.else20.prol
  %22 = trunc i64 %indvars.iv.prol to i32
  %add46.prol = add i32 %add45.prol, %22
  %idxprom47.prol = sext i32 %add46.prol to i64
  %arrayidx48.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.prol
  %23 = load float, float* %arrayidx48.prol, align 4
  %24 = trunc i64 %indvars.iv.prol to i32
  %add51.prol = add i32 %sub50.prol, %24
  %idxprom52.prol = sext i32 %add51.prol to i64
  %arrayidx53.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.prol
  %25 = load float, float* %arrayidx53.prol, align 4
  br label %if.end118.prol

if.end118.prol:                                   ; preds = %if.then43.prol, %if.then62.prol, %if.then83.prol, %if.then102.prol, %if.else94.prol
  %q.3.prol = phi float [ %23, %if.then43.prol ], [ %20, %if.then62.prol ], [ %16, %if.then83.prol ], [ %13, %if.then102.prol ], [ 2.550000e+02, %if.else94.prol ]
  %r.3.prol = phi float [ %25, %if.then43.prol ], [ %21, %if.then62.prol ], [ %18, %if.then83.prol ], [ %14, %if.then102.prol ], [ 2.550000e+02, %if.else94.prol ]
  %arrayidx120.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %10
  %26 = load float, float* %arrayidx120.prol, align 4
  %cmp121.prol = fcmp ult float %26, %q.3.prol
  %cmp126.prol = fcmp ult float %26, %r.3.prol
  %or.cond8.prol = or i1 %cmp121.prol, %cmp126.prol
  br i1 %or.cond8.prol, label %if.else134.prol, label %if.then128.prol

if.then128.prol:                                  ; preds = %if.end118.prol
  %conv131.prol = fptoui float %26 to i32
  %arrayidx133.prol = getelementptr inbounds i32, i32* %., i64 %10
  store i32 %conv131.prol, i32* %arrayidx133.prol, align 4
  br label %for.inc.prol

if.else134.prol:                                  ; preds = %if.end118.prol
  %arrayidx136.prol = getelementptr inbounds i32, i32* %., i64 %10
  store i32 0, i32* %arrayidx136.prol, align 4
  br label %for.inc.prol

if.then19.prol:                                   ; preds = %for.body8.prol
  %arrayidx.prol = getelementptr inbounds i32, i32* %., i64 %10
  store i32 0, i32* %arrayidx.prol, align 4
  br label %for.inc.prol

for.inc.prol:                                     ; preds = %if.then19.prol, %if.else134.prol, %if.then128.prol
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %img_width
  br i1 %exitcond.prol, label %for.inc139.prol.loopexit, label %for.body8.prol, !llvm.loop !1

for.inc139.prol.loopexit:                         ; preds = %for.inc.prol
  br label %for.inc139.prol

for.inc139.prol:                                  ; preds = %for.inc139.prol.loopexit, %for.cond5.preheader.prol
  %indvars.iv.next20.prol = add nuw nsw i64 %indvars.iv19.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond5.preheader.lr.ph.split.loopexit, label %for.cond5.preheader.prol, !llvm.loop !3

for.cond5.preheader.lr.ph.split.loopexit:         ; preds = %for.inc139.prol
  %indvars.iv.next20.prol.lcssa = phi i64 [ %indvars.iv.next20.prol, %for.inc139.prol ]
  br label %for.cond5.preheader.lr.ph.split

for.cond5.preheader.lr.ph.split:                  ; preds = %for.cond5.preheader.lr.ph.split.loopexit, %for.cond5.preheader.lr.ph
  %indvars.iv19.unr = phi i64 [ 0, %for.cond5.preheader.lr.ph ], [ %indvars.iv.next20.prol.lcssa, %for.cond5.preheader.lr.ph.split.loopexit ]
  %27 = icmp ult i32 %2, 31
  br i1 %27, label %for.end141, label %for.cond5.preheader.preheader

for.cond5.preheader.preheader:                    ; preds = %for.cond5.preheader.lr.ph.split
  br label %for.cond5.preheader

for.cond5.preheader:                              ; preds = %for.cond5.preheader.preheader, %for.inc139.31
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.31, %for.inc139.31 ], [ %indvars.iv19.unr, %for.cond5.preheader.preheader ]
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph

for.body8.lr.ph:                                  ; preds = %for.cond5.preheader
  %28 = trunc i64 %indvars.iv19 to i32
  %mul = shl nsw i32 %28, 7
  %cmp9 = icmp eq i64 %indvars.iv19, 0
  %cmp11 = icmp eq i64 %indvars.iv19, %1
  %or.cond = or i1 %cmp9, %cmp11
  %add45 = or i32 %mul, 1
  %sub50 = add i32 %mul, -1
  %29 = trunc i64 %indvars.iv19 to i32
  %add63 = shl i32 %29, 7
  %30 = trunc i64 %indvars.iv19 to i32
  %add84 = shl i32 %30, 7
  %mul85 = add i32 %add84, 128
  %mul90 = add i32 %add84, -128
  %31 = trunc i64 %indvars.iv19 to i32
  %sub103 = shl i32 %31, 7
  %32 = sext i32 %mul to i64
  %33 = sext i32 %mul90 to i64
  %34 = sext i32 %mul85 to i64
  br label %for.body8

for.body8:                                        ; preds = %for.inc, %for.body8.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body8.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %35 = add nsw i64 %indvars.iv, %32
  %cmp14 = icmp eq i64 %indvars.iv, 0
  %or.cond1 = or i1 %or.cond, %cmp14
  %cmp17 = icmp eq i64 %indvars.iv, %0
  %or.cond2 = or i1 %cmp17, %or.cond1
  br i1 %or.cond2, label %if.then19, label %if.else20

if.then19:                                        ; preds = %for.body8
  %arrayidx = getelementptr inbounds i32, i32* %., i64 %35
  store i32 0, i32* %arrayidx, align 4
  br label %for.inc

if.else20:                                        ; preds = %for.body8
  %arrayidx22 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %35
  %36 = load float, float* %arrayidx22, align 4
  %conv23 = fpext float %36 to double
  %mul24 = fmul double %conv23, 0x404CA5DC1A63C1F8
  %conv25 = fptrunc double %mul24 to float
  %cmp26 = fcmp olt float %conv25, 0.000000e+00
  %add29 = fadd float %conv25, 1.800000e+02
  %angle.0 = select i1 %cmp26, float %add29, float %conv25
  %cmp31 = fcmp oge float %angle.0, 0.000000e+00
  %cmp34 = fcmp olt float %angle.0, 2.250000e+01
  %or.cond3 = and i1 %cmp31, %cmp34
  br i1 %or.cond3, label %if.then43, label %lor.lhs.false36

lor.lhs.false36:                                  ; preds = %if.else20
  %cmp38 = fcmp ult float %angle.0, 1.575000e+02
  %cmp41 = fcmp ugt float %angle.0, 1.800000e+02
  %or.cond4 = or i1 %cmp38, %cmp41
  br i1 %or.cond4, label %if.else54, label %if.then43

if.then43:                                        ; preds = %lor.lhs.false36, %if.else20
  %37 = trunc i64 %indvars.iv to i32
  %add46 = add i32 %add45, %37
  %idxprom47 = sext i32 %add46 to i64
  %arrayidx48 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47
  %38 = load float, float* %arrayidx48, align 4
  %39 = trunc i64 %indvars.iv to i32
  %add51 = add i32 %sub50, %39
  %idxprom52 = sext i32 %add51 to i64
  %arrayidx53 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52
  %40 = load float, float* %arrayidx53, align 4
  br label %if.end118

if.else54:                                        ; preds = %lor.lhs.false36
  %cmp56 = fcmp oge float %angle.0, 2.250000e+01
  %cmp60 = fcmp olt float %angle.0, 6.750000e+01
  %or.cond5 = and i1 %cmp56, %cmp60
  br i1 %or.cond5, label %if.then62, label %if.else75

if.then62:                                        ; preds = %if.else54
  %41 = trunc i64 %indvars.iv to i32
  %sub65 = add i32 %41, %add63
  %add66 = add i32 %sub65, 127
  %idxprom67 = sext i32 %add66 to i64
  %arrayidx68 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67
  %42 = load float, float* %arrayidx68, align 4
  %add72 = add i32 %sub65, -127
  %idxprom73 = sext i32 %add72 to i64
  %arrayidx74 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73
  %43 = load float, float* %arrayidx74, align 4
  br label %if.end118

if.else75:                                        ; preds = %if.else54
  %cmp77 = fcmp oge float %angle.0, 6.750000e+01
  %cmp81 = fcmp olt float %angle.0, 1.125000e+02
  %or.cond6 = and i1 %cmp77, %cmp81
  br i1 %or.cond6, label %if.then83, label %if.else94

if.then83:                                        ; preds = %if.else75
  %44 = add nsw i64 %34, %indvars.iv
  %arrayidx88 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %44
  %45 = load float, float* %arrayidx88, align 4
  %46 = add nsw i64 %33, %indvars.iv
  %arrayidx93 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %46
  %47 = load float, float* %arrayidx93, align 4
  br label %if.end118

if.else94:                                        ; preds = %if.else75
  %cmp96 = fcmp oge float %angle.0, 1.125000e+02
  %cmp100 = fcmp olt float %angle.0, 1.575000e+02
  %or.cond7 = and i1 %cmp96, %cmp100
  br i1 %or.cond7, label %if.then102, label %if.end118

if.then102:                                       ; preds = %if.else94
  %48 = trunc i64 %indvars.iv to i32
  %sub105 = add i32 %48, %sub103
  %add106 = add i32 %sub105, -129
  %idxprom107 = sext i32 %add106 to i64
  %arrayidx108 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107
  %49 = load float, float* %arrayidx108, align 4
  %add112 = add i32 %sub105, 129
  %idxprom113 = sext i32 %add112 to i64
  %arrayidx114 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113
  %50 = load float, float* %arrayidx114, align 4
  br label %if.end118

if.end118:                                        ; preds = %if.then62, %if.then102, %if.else94, %if.then83, %if.then43
  %q.3 = phi float [ %38, %if.then43 ], [ %42, %if.then62 ], [ %45, %if.then83 ], [ %49, %if.then102 ], [ 2.550000e+02, %if.else94 ]
  %r.3 = phi float [ %40, %if.then43 ], [ %43, %if.then62 ], [ %47, %if.then83 ], [ %50, %if.then102 ], [ 2.550000e+02, %if.else94 ]
  %arrayidx120 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %35
  %51 = load float, float* %arrayidx120, align 4
  %cmp121 = fcmp ult float %51, %q.3
  %cmp126 = fcmp ult float %51, %r.3
  %or.cond8 = or i1 %cmp121, %cmp126
  br i1 %or.cond8, label %if.else134, label %if.then128

if.then128:                                       ; preds = %if.end118
  %conv131 = fptoui float %51 to i32
  %arrayidx133 = getelementptr inbounds i32, i32* %., i64 %35
  store i32 %conv131, i32* %arrayidx133, align 4
  br label %for.inc

if.else134:                                       ; preds = %if.end118
  %arrayidx136 = getelementptr inbounds i32, i32* %., i64 %35
  store i32 0, i32* %arrayidx136, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.then19, %if.else134, %if.then128
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %img_width
  br i1 %exitcond, label %for.inc139, label %for.body8, !llvm.loop !1

for.inc139:                                       ; preds = %for.inc
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.1

for.end141.loopexit:                              ; preds = %for.inc139.31
  br label %for.end141

for.end141:                                       ; preds = %for.end141.loopexit, %for.cond5.preheader.lr.ph.split, %entry
  ret void

for.body8.lr.ph.1:                                ; preds = %for.inc139
  %52 = trunc i64 %indvars.iv.next20 to i32
  %mul.1 = shl nsw i32 %52, 7
  %cmp11.1 = icmp eq i64 %indvars.iv.next20, %1
  %add45.1 = or i32 %mul.1, 1
  %sub50.1 = add i32 %mul.1, -1
  %53 = trunc i64 %indvars.iv.next20 to i32
  %add63.1 = shl i32 %53, 7
  %54 = trunc i64 %indvars.iv.next20 to i32
  %add84.1 = shl i32 %54, 7
  %mul85.1 = add i32 %add84.1, 128
  %mul90.1 = add i32 %add84.1, -128
  %55 = trunc i64 %indvars.iv.next20 to i32
  %sub103.1 = shl i32 %55, 7
  %56 = sext i32 %mul.1 to i64
  %57 = sext i32 %mul90.1 to i64
  %58 = sext i32 %mul85.1 to i64
  br label %for.body8.1

for.body8.1:                                      ; preds = %for.inc.1, %for.body8.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body8.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc.1 ]
  %59 = add nsw i64 %indvars.iv.1, %56
  %cmp14.1 = icmp eq i64 %indvars.iv.1, 0
  %or.cond1.1 = or i1 %cmp11.1, %cmp14.1
  %cmp17.1 = icmp eq i64 %indvars.iv.1, %0
  %or.cond2.1 = or i1 %cmp17.1, %or.cond1.1
  br i1 %or.cond2.1, label %if.then19.1, label %if.else20.1

if.else20.1:                                      ; preds = %for.body8.1
  %arrayidx22.1 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %59
  %60 = load float, float* %arrayidx22.1, align 4
  %conv23.1 = fpext float %60 to double
  %mul24.1 = fmul double %conv23.1, 0x404CA5DC1A63C1F8
  %conv25.1 = fptrunc double %mul24.1 to float
  %cmp26.1 = fcmp olt float %conv25.1, 0.000000e+00
  %add29.1 = fadd float %conv25.1, 1.800000e+02
  %angle.0.1 = select i1 %cmp26.1, float %add29.1, float %conv25.1
  %cmp31.1 = fcmp oge float %angle.0.1, 0.000000e+00
  %cmp34.1 = fcmp olt float %angle.0.1, 2.250000e+01
  %or.cond3.1 = and i1 %cmp31.1, %cmp34.1
  br i1 %or.cond3.1, label %if.then43.1, label %lor.lhs.false36.1

lor.lhs.false36.1:                                ; preds = %if.else20.1
  %cmp38.1 = fcmp ult float %angle.0.1, 1.575000e+02
  %cmp41.1 = fcmp ugt float %angle.0.1, 1.800000e+02
  %or.cond4.1 = or i1 %cmp38.1, %cmp41.1
  br i1 %or.cond4.1, label %if.else54.1, label %if.then43.1

if.else54.1:                                      ; preds = %lor.lhs.false36.1
  %cmp56.1 = fcmp oge float %angle.0.1, 2.250000e+01
  %cmp60.1 = fcmp olt float %angle.0.1, 6.750000e+01
  %or.cond5.1 = and i1 %cmp56.1, %cmp60.1
  br i1 %or.cond5.1, label %if.then62.1, label %if.else75.1

if.else75.1:                                      ; preds = %if.else54.1
  %cmp77.1 = fcmp oge float %angle.0.1, 6.750000e+01
  %cmp81.1 = fcmp olt float %angle.0.1, 1.125000e+02
  %or.cond6.1 = and i1 %cmp77.1, %cmp81.1
  br i1 %or.cond6.1, label %if.then83.1, label %if.else94.1

if.else94.1:                                      ; preds = %if.else75.1
  %cmp96.1 = fcmp oge float %angle.0.1, 1.125000e+02
  %cmp100.1 = fcmp olt float %angle.0.1, 1.575000e+02
  %or.cond7.1 = and i1 %cmp96.1, %cmp100.1
  br i1 %or.cond7.1, label %if.then102.1, label %if.end118.1

if.then102.1:                                     ; preds = %if.else94.1
  %61 = trunc i64 %indvars.iv.1 to i32
  %sub105.1 = add i32 %61, %sub103.1
  %add106.1 = add i32 %sub105.1, -129
  %idxprom107.1 = sext i32 %add106.1 to i64
  %arrayidx108.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.1
  %62 = load float, float* %arrayidx108.1, align 4
  %add112.1 = add i32 %sub105.1, 129
  %idxprom113.1 = sext i32 %add112.1 to i64
  %arrayidx114.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.1
  %63 = load float, float* %arrayidx114.1, align 4
  br label %if.end118.1

if.then83.1:                                      ; preds = %if.else75.1
  %64 = add nsw i64 %58, %indvars.iv.1
  %arrayidx88.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %64
  %65 = load float, float* %arrayidx88.1, align 4
  %66 = add nsw i64 %57, %indvars.iv.1
  %arrayidx93.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %66
  %67 = load float, float* %arrayidx93.1, align 4
  br label %if.end118.1

if.then62.1:                                      ; preds = %if.else54.1
  %68 = trunc i64 %indvars.iv.1 to i32
  %sub65.1 = add i32 %68, %add63.1
  %add66.1 = add i32 %sub65.1, 127
  %idxprom67.1 = sext i32 %add66.1 to i64
  %arrayidx68.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.1
  %69 = load float, float* %arrayidx68.1, align 4
  %add72.1 = add i32 %sub65.1, -127
  %idxprom73.1 = sext i32 %add72.1 to i64
  %arrayidx74.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.1
  %70 = load float, float* %arrayidx74.1, align 4
  br label %if.end118.1

if.then43.1:                                      ; preds = %lor.lhs.false36.1, %if.else20.1
  %71 = trunc i64 %indvars.iv.1 to i32
  %add46.1 = add i32 %add45.1, %71
  %idxprom47.1 = sext i32 %add46.1 to i64
  %arrayidx48.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.1
  %72 = load float, float* %arrayidx48.1, align 4
  %73 = trunc i64 %indvars.iv.1 to i32
  %add51.1 = add i32 %sub50.1, %73
  %idxprom52.1 = sext i32 %add51.1 to i64
  %arrayidx53.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.1
  %74 = load float, float* %arrayidx53.1, align 4
  br label %if.end118.1

if.end118.1:                                      ; preds = %if.then43.1, %if.then62.1, %if.then83.1, %if.then102.1, %if.else94.1
  %q.3.1 = phi float [ %72, %if.then43.1 ], [ %69, %if.then62.1 ], [ %65, %if.then83.1 ], [ %62, %if.then102.1 ], [ 2.550000e+02, %if.else94.1 ]
  %r.3.1 = phi float [ %74, %if.then43.1 ], [ %70, %if.then62.1 ], [ %67, %if.then83.1 ], [ %63, %if.then102.1 ], [ 2.550000e+02, %if.else94.1 ]
  %arrayidx120.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %59
  %75 = load float, float* %arrayidx120.1, align 4
  %cmp121.1 = fcmp ult float %75, %q.3.1
  %cmp126.1 = fcmp ult float %75, %r.3.1
  %or.cond8.1 = or i1 %cmp121.1, %cmp126.1
  br i1 %or.cond8.1, label %if.else134.1, label %if.then128.1

if.then128.1:                                     ; preds = %if.end118.1
  %conv131.1 = fptoui float %75 to i32
  %arrayidx133.1 = getelementptr inbounds i32, i32* %., i64 %59
  store i32 %conv131.1, i32* %arrayidx133.1, align 4
  br label %for.inc.1

if.else134.1:                                     ; preds = %if.end118.1
  %arrayidx136.1 = getelementptr inbounds i32, i32* %., i64 %59
  store i32 0, i32* %arrayidx136.1, align 4
  br label %for.inc.1

if.then19.1:                                      ; preds = %for.body8.1
  %arrayidx.1 = getelementptr inbounds i32, i32* %., i64 %59
  store i32 0, i32* %arrayidx.1, align 4
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.then19.1, %if.else134.1, %if.then128.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %img_width
  br i1 %exitcond.1, label %for.inc139.1, label %for.body8.1, !llvm.loop !1

for.inc139.1:                                     ; preds = %for.inc.1
  %indvars.iv.next20.1 = add nsw i64 %indvars.iv19, 2
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.2

for.body8.lr.ph.2:                                ; preds = %for.inc139.1
  %76 = trunc i64 %indvars.iv.next20.1 to i32
  %mul.2 = shl nsw i32 %76, 7
  %cmp11.2 = icmp eq i64 %indvars.iv.next20.1, %1
  %add45.2 = or i32 %mul.2, 1
  %sub50.2 = add i32 %mul.2, -1
  %77 = trunc i64 %indvars.iv.next20.1 to i32
  %add63.2 = shl i32 %77, 7
  %78 = trunc i64 %indvars.iv.next20.1 to i32
  %add84.2 = shl i32 %78, 7
  %mul85.2 = add i32 %add84.2, 128
  %mul90.2 = add i32 %add84.2, -128
  %79 = trunc i64 %indvars.iv.next20.1 to i32
  %sub103.2 = shl i32 %79, 7
  %80 = sext i32 %mul.2 to i64
  %81 = sext i32 %mul90.2 to i64
  %82 = sext i32 %mul85.2 to i64
  br label %for.body8.2

for.body8.2:                                      ; preds = %for.inc.2, %for.body8.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body8.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc.2 ]
  %83 = add nsw i64 %indvars.iv.2, %80
  %cmp14.2 = icmp eq i64 %indvars.iv.2, 0
  %or.cond1.2 = or i1 %cmp11.2, %cmp14.2
  %cmp17.2 = icmp eq i64 %indvars.iv.2, %0
  %or.cond2.2 = or i1 %cmp17.2, %or.cond1.2
  br i1 %or.cond2.2, label %if.then19.2, label %if.else20.2

if.else20.2:                                      ; preds = %for.body8.2
  %arrayidx22.2 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %83
  %84 = load float, float* %arrayidx22.2, align 4
  %conv23.2 = fpext float %84 to double
  %mul24.2 = fmul double %conv23.2, 0x404CA5DC1A63C1F8
  %conv25.2 = fptrunc double %mul24.2 to float
  %cmp26.2 = fcmp olt float %conv25.2, 0.000000e+00
  %add29.2 = fadd float %conv25.2, 1.800000e+02
  %angle.0.2 = select i1 %cmp26.2, float %add29.2, float %conv25.2
  %cmp31.2 = fcmp oge float %angle.0.2, 0.000000e+00
  %cmp34.2 = fcmp olt float %angle.0.2, 2.250000e+01
  %or.cond3.2 = and i1 %cmp31.2, %cmp34.2
  br i1 %or.cond3.2, label %if.then43.2, label %lor.lhs.false36.2

lor.lhs.false36.2:                                ; preds = %if.else20.2
  %cmp38.2 = fcmp ult float %angle.0.2, 1.575000e+02
  %cmp41.2 = fcmp ugt float %angle.0.2, 1.800000e+02
  %or.cond4.2 = or i1 %cmp38.2, %cmp41.2
  br i1 %or.cond4.2, label %if.else54.2, label %if.then43.2

if.else54.2:                                      ; preds = %lor.lhs.false36.2
  %cmp56.2 = fcmp oge float %angle.0.2, 2.250000e+01
  %cmp60.2 = fcmp olt float %angle.0.2, 6.750000e+01
  %or.cond5.2 = and i1 %cmp56.2, %cmp60.2
  br i1 %or.cond5.2, label %if.then62.2, label %if.else75.2

if.else75.2:                                      ; preds = %if.else54.2
  %cmp77.2 = fcmp oge float %angle.0.2, 6.750000e+01
  %cmp81.2 = fcmp olt float %angle.0.2, 1.125000e+02
  %or.cond6.2 = and i1 %cmp77.2, %cmp81.2
  br i1 %or.cond6.2, label %if.then83.2, label %if.else94.2

if.else94.2:                                      ; preds = %if.else75.2
  %cmp96.2 = fcmp oge float %angle.0.2, 1.125000e+02
  %cmp100.2 = fcmp olt float %angle.0.2, 1.575000e+02
  %or.cond7.2 = and i1 %cmp96.2, %cmp100.2
  br i1 %or.cond7.2, label %if.then102.2, label %if.end118.2

if.then102.2:                                     ; preds = %if.else94.2
  %85 = trunc i64 %indvars.iv.2 to i32
  %sub105.2 = add i32 %85, %sub103.2
  %add106.2 = add i32 %sub105.2, -129
  %idxprom107.2 = sext i32 %add106.2 to i64
  %arrayidx108.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.2
  %86 = load float, float* %arrayidx108.2, align 4
  %add112.2 = add i32 %sub105.2, 129
  %idxprom113.2 = sext i32 %add112.2 to i64
  %arrayidx114.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.2
  %87 = load float, float* %arrayidx114.2, align 4
  br label %if.end118.2

if.then83.2:                                      ; preds = %if.else75.2
  %88 = add nsw i64 %82, %indvars.iv.2
  %arrayidx88.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %88
  %89 = load float, float* %arrayidx88.2, align 4
  %90 = add nsw i64 %81, %indvars.iv.2
  %arrayidx93.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %90
  %91 = load float, float* %arrayidx93.2, align 4
  br label %if.end118.2

if.then62.2:                                      ; preds = %if.else54.2
  %92 = trunc i64 %indvars.iv.2 to i32
  %sub65.2 = add i32 %92, %add63.2
  %add66.2 = add i32 %sub65.2, 127
  %idxprom67.2 = sext i32 %add66.2 to i64
  %arrayidx68.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.2
  %93 = load float, float* %arrayidx68.2, align 4
  %add72.2 = add i32 %sub65.2, -127
  %idxprom73.2 = sext i32 %add72.2 to i64
  %arrayidx74.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.2
  %94 = load float, float* %arrayidx74.2, align 4
  br label %if.end118.2

if.then43.2:                                      ; preds = %lor.lhs.false36.2, %if.else20.2
  %95 = trunc i64 %indvars.iv.2 to i32
  %add46.2 = add i32 %add45.2, %95
  %idxprom47.2 = sext i32 %add46.2 to i64
  %arrayidx48.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.2
  %96 = load float, float* %arrayidx48.2, align 4
  %97 = trunc i64 %indvars.iv.2 to i32
  %add51.2 = add i32 %sub50.2, %97
  %idxprom52.2 = sext i32 %add51.2 to i64
  %arrayidx53.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.2
  %98 = load float, float* %arrayidx53.2, align 4
  br label %if.end118.2

if.end118.2:                                      ; preds = %if.then43.2, %if.then62.2, %if.then83.2, %if.then102.2, %if.else94.2
  %q.3.2 = phi float [ %96, %if.then43.2 ], [ %93, %if.then62.2 ], [ %89, %if.then83.2 ], [ %86, %if.then102.2 ], [ 2.550000e+02, %if.else94.2 ]
  %r.3.2 = phi float [ %98, %if.then43.2 ], [ %94, %if.then62.2 ], [ %91, %if.then83.2 ], [ %87, %if.then102.2 ], [ 2.550000e+02, %if.else94.2 ]
  %arrayidx120.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %83
  %99 = load float, float* %arrayidx120.2, align 4
  %cmp121.2 = fcmp ult float %99, %q.3.2
  %cmp126.2 = fcmp ult float %99, %r.3.2
  %or.cond8.2 = or i1 %cmp121.2, %cmp126.2
  br i1 %or.cond8.2, label %if.else134.2, label %if.then128.2

if.then128.2:                                     ; preds = %if.end118.2
  %conv131.2 = fptoui float %99 to i32
  %arrayidx133.2 = getelementptr inbounds i32, i32* %., i64 %83
  store i32 %conv131.2, i32* %arrayidx133.2, align 4
  br label %for.inc.2

if.else134.2:                                     ; preds = %if.end118.2
  %arrayidx136.2 = getelementptr inbounds i32, i32* %., i64 %83
  store i32 0, i32* %arrayidx136.2, align 4
  br label %for.inc.2

if.then19.2:                                      ; preds = %for.body8.2
  %arrayidx.2 = getelementptr inbounds i32, i32* %., i64 %83
  store i32 0, i32* %arrayidx.2, align 4
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.then19.2, %if.else134.2, %if.then128.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %img_width
  br i1 %exitcond.2, label %for.inc139.2, label %for.body8.2, !llvm.loop !1

for.inc139.2:                                     ; preds = %for.inc.2
  %indvars.iv.next20.2 = add nsw i64 %indvars.iv19, 3
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.3

for.body8.lr.ph.3:                                ; preds = %for.inc139.2
  %100 = trunc i64 %indvars.iv.next20.2 to i32
  %mul.3 = shl nsw i32 %100, 7
  %cmp11.3 = icmp eq i64 %indvars.iv.next20.2, %1
  %add45.3 = or i32 %mul.3, 1
  %sub50.3 = add i32 %mul.3, -1
  %101 = trunc i64 %indvars.iv.next20.2 to i32
  %add63.3 = shl i32 %101, 7
  %102 = trunc i64 %indvars.iv.next20.2 to i32
  %add84.3 = shl i32 %102, 7
  %mul85.3 = add i32 %add84.3, 128
  %mul90.3 = add i32 %add84.3, -128
  %103 = trunc i64 %indvars.iv.next20.2 to i32
  %sub103.3 = shl i32 %103, 7
  %104 = sext i32 %mul.3 to i64
  %105 = sext i32 %mul90.3 to i64
  %106 = sext i32 %mul85.3 to i64
  br label %for.body8.3

for.body8.3:                                      ; preds = %for.inc.3, %for.body8.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body8.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc.3 ]
  %107 = add nsw i64 %indvars.iv.3, %104
  %cmp14.3 = icmp eq i64 %indvars.iv.3, 0
  %or.cond1.3 = or i1 %cmp11.3, %cmp14.3
  %cmp17.3 = icmp eq i64 %indvars.iv.3, %0
  %or.cond2.3 = or i1 %cmp17.3, %or.cond1.3
  br i1 %or.cond2.3, label %if.then19.3, label %if.else20.3

if.else20.3:                                      ; preds = %for.body8.3
  %arrayidx22.3 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %107
  %108 = load float, float* %arrayidx22.3, align 4
  %conv23.3 = fpext float %108 to double
  %mul24.3 = fmul double %conv23.3, 0x404CA5DC1A63C1F8
  %conv25.3 = fptrunc double %mul24.3 to float
  %cmp26.3 = fcmp olt float %conv25.3, 0.000000e+00
  %add29.3 = fadd float %conv25.3, 1.800000e+02
  %angle.0.3 = select i1 %cmp26.3, float %add29.3, float %conv25.3
  %cmp31.3 = fcmp oge float %angle.0.3, 0.000000e+00
  %cmp34.3 = fcmp olt float %angle.0.3, 2.250000e+01
  %or.cond3.3 = and i1 %cmp31.3, %cmp34.3
  br i1 %or.cond3.3, label %if.then43.3, label %lor.lhs.false36.3

lor.lhs.false36.3:                                ; preds = %if.else20.3
  %cmp38.3 = fcmp ult float %angle.0.3, 1.575000e+02
  %cmp41.3 = fcmp ugt float %angle.0.3, 1.800000e+02
  %or.cond4.3 = or i1 %cmp38.3, %cmp41.3
  br i1 %or.cond4.3, label %if.else54.3, label %if.then43.3

if.else54.3:                                      ; preds = %lor.lhs.false36.3
  %cmp56.3 = fcmp oge float %angle.0.3, 2.250000e+01
  %cmp60.3 = fcmp olt float %angle.0.3, 6.750000e+01
  %or.cond5.3 = and i1 %cmp56.3, %cmp60.3
  br i1 %or.cond5.3, label %if.then62.3, label %if.else75.3

if.else75.3:                                      ; preds = %if.else54.3
  %cmp77.3 = fcmp oge float %angle.0.3, 6.750000e+01
  %cmp81.3 = fcmp olt float %angle.0.3, 1.125000e+02
  %or.cond6.3 = and i1 %cmp77.3, %cmp81.3
  br i1 %or.cond6.3, label %if.then83.3, label %if.else94.3

if.else94.3:                                      ; preds = %if.else75.3
  %cmp96.3 = fcmp oge float %angle.0.3, 1.125000e+02
  %cmp100.3 = fcmp olt float %angle.0.3, 1.575000e+02
  %or.cond7.3 = and i1 %cmp96.3, %cmp100.3
  br i1 %or.cond7.3, label %if.then102.3, label %if.end118.3

if.then102.3:                                     ; preds = %if.else94.3
  %109 = trunc i64 %indvars.iv.3 to i32
  %sub105.3 = add i32 %109, %sub103.3
  %add106.3 = add i32 %sub105.3, -129
  %idxprom107.3 = sext i32 %add106.3 to i64
  %arrayidx108.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.3
  %110 = load float, float* %arrayidx108.3, align 4
  %add112.3 = add i32 %sub105.3, 129
  %idxprom113.3 = sext i32 %add112.3 to i64
  %arrayidx114.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.3
  %111 = load float, float* %arrayidx114.3, align 4
  br label %if.end118.3

if.then83.3:                                      ; preds = %if.else75.3
  %112 = add nsw i64 %106, %indvars.iv.3
  %arrayidx88.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %112
  %113 = load float, float* %arrayidx88.3, align 4
  %114 = add nsw i64 %105, %indvars.iv.3
  %arrayidx93.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %114
  %115 = load float, float* %arrayidx93.3, align 4
  br label %if.end118.3

if.then62.3:                                      ; preds = %if.else54.3
  %116 = trunc i64 %indvars.iv.3 to i32
  %sub65.3 = add i32 %116, %add63.3
  %add66.3 = add i32 %sub65.3, 127
  %idxprom67.3 = sext i32 %add66.3 to i64
  %arrayidx68.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.3
  %117 = load float, float* %arrayidx68.3, align 4
  %add72.3 = add i32 %sub65.3, -127
  %idxprom73.3 = sext i32 %add72.3 to i64
  %arrayidx74.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.3
  %118 = load float, float* %arrayidx74.3, align 4
  br label %if.end118.3

if.then43.3:                                      ; preds = %lor.lhs.false36.3, %if.else20.3
  %119 = trunc i64 %indvars.iv.3 to i32
  %add46.3 = add i32 %add45.3, %119
  %idxprom47.3 = sext i32 %add46.3 to i64
  %arrayidx48.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.3
  %120 = load float, float* %arrayidx48.3, align 4
  %121 = trunc i64 %indvars.iv.3 to i32
  %add51.3 = add i32 %sub50.3, %121
  %idxprom52.3 = sext i32 %add51.3 to i64
  %arrayidx53.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.3
  %122 = load float, float* %arrayidx53.3, align 4
  br label %if.end118.3

if.end118.3:                                      ; preds = %if.then43.3, %if.then62.3, %if.then83.3, %if.then102.3, %if.else94.3
  %q.3.3 = phi float [ %120, %if.then43.3 ], [ %117, %if.then62.3 ], [ %113, %if.then83.3 ], [ %110, %if.then102.3 ], [ 2.550000e+02, %if.else94.3 ]
  %r.3.3 = phi float [ %122, %if.then43.3 ], [ %118, %if.then62.3 ], [ %115, %if.then83.3 ], [ %111, %if.then102.3 ], [ 2.550000e+02, %if.else94.3 ]
  %arrayidx120.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %107
  %123 = load float, float* %arrayidx120.3, align 4
  %cmp121.3 = fcmp ult float %123, %q.3.3
  %cmp126.3 = fcmp ult float %123, %r.3.3
  %or.cond8.3 = or i1 %cmp121.3, %cmp126.3
  br i1 %or.cond8.3, label %if.else134.3, label %if.then128.3

if.then128.3:                                     ; preds = %if.end118.3
  %conv131.3 = fptoui float %123 to i32
  %arrayidx133.3 = getelementptr inbounds i32, i32* %., i64 %107
  store i32 %conv131.3, i32* %arrayidx133.3, align 4
  br label %for.inc.3

if.else134.3:                                     ; preds = %if.end118.3
  %arrayidx136.3 = getelementptr inbounds i32, i32* %., i64 %107
  store i32 0, i32* %arrayidx136.3, align 4
  br label %for.inc.3

if.then19.3:                                      ; preds = %for.body8.3
  %arrayidx.3 = getelementptr inbounds i32, i32* %., i64 %107
  store i32 0, i32* %arrayidx.3, align 4
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.then19.3, %if.else134.3, %if.then128.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %img_width
  br i1 %exitcond.3, label %for.inc139.3, label %for.body8.3, !llvm.loop !1

for.inc139.3:                                     ; preds = %for.inc.3
  %indvars.iv.next20.3 = add nsw i64 %indvars.iv19, 4
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.4

for.body8.lr.ph.4:                                ; preds = %for.inc139.3
  %124 = trunc i64 %indvars.iv.next20.3 to i32
  %mul.4 = shl nsw i32 %124, 7
  %cmp11.4 = icmp eq i64 %indvars.iv.next20.3, %1
  %add45.4 = or i32 %mul.4, 1
  %sub50.4 = add i32 %mul.4, -1
  %125 = trunc i64 %indvars.iv.next20.3 to i32
  %add63.4 = shl i32 %125, 7
  %126 = trunc i64 %indvars.iv.next20.3 to i32
  %add84.4 = shl i32 %126, 7
  %mul85.4 = add i32 %add84.4, 128
  %mul90.4 = add i32 %add84.4, -128
  %127 = trunc i64 %indvars.iv.next20.3 to i32
  %sub103.4 = shl i32 %127, 7
  %128 = sext i32 %mul.4 to i64
  %129 = sext i32 %mul90.4 to i64
  %130 = sext i32 %mul85.4 to i64
  br label %for.body8.4

for.body8.4:                                      ; preds = %for.inc.4, %for.body8.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body8.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc.4 ]
  %131 = add nsw i64 %indvars.iv.4, %128
  %cmp14.4 = icmp eq i64 %indvars.iv.4, 0
  %or.cond1.4 = or i1 %cmp11.4, %cmp14.4
  %cmp17.4 = icmp eq i64 %indvars.iv.4, %0
  %or.cond2.4 = or i1 %cmp17.4, %or.cond1.4
  br i1 %or.cond2.4, label %if.then19.4, label %if.else20.4

if.else20.4:                                      ; preds = %for.body8.4
  %arrayidx22.4 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %131
  %132 = load float, float* %arrayidx22.4, align 4
  %conv23.4 = fpext float %132 to double
  %mul24.4 = fmul double %conv23.4, 0x404CA5DC1A63C1F8
  %conv25.4 = fptrunc double %mul24.4 to float
  %cmp26.4 = fcmp olt float %conv25.4, 0.000000e+00
  %add29.4 = fadd float %conv25.4, 1.800000e+02
  %angle.0.4 = select i1 %cmp26.4, float %add29.4, float %conv25.4
  %cmp31.4 = fcmp oge float %angle.0.4, 0.000000e+00
  %cmp34.4 = fcmp olt float %angle.0.4, 2.250000e+01
  %or.cond3.4 = and i1 %cmp31.4, %cmp34.4
  br i1 %or.cond3.4, label %if.then43.4, label %lor.lhs.false36.4

lor.lhs.false36.4:                                ; preds = %if.else20.4
  %cmp38.4 = fcmp ult float %angle.0.4, 1.575000e+02
  %cmp41.4 = fcmp ugt float %angle.0.4, 1.800000e+02
  %or.cond4.4 = or i1 %cmp38.4, %cmp41.4
  br i1 %or.cond4.4, label %if.else54.4, label %if.then43.4

if.else54.4:                                      ; preds = %lor.lhs.false36.4
  %cmp56.4 = fcmp oge float %angle.0.4, 2.250000e+01
  %cmp60.4 = fcmp olt float %angle.0.4, 6.750000e+01
  %or.cond5.4 = and i1 %cmp56.4, %cmp60.4
  br i1 %or.cond5.4, label %if.then62.4, label %if.else75.4

if.else75.4:                                      ; preds = %if.else54.4
  %cmp77.4 = fcmp oge float %angle.0.4, 6.750000e+01
  %cmp81.4 = fcmp olt float %angle.0.4, 1.125000e+02
  %or.cond6.4 = and i1 %cmp77.4, %cmp81.4
  br i1 %or.cond6.4, label %if.then83.4, label %if.else94.4

if.else94.4:                                      ; preds = %if.else75.4
  %cmp96.4 = fcmp oge float %angle.0.4, 1.125000e+02
  %cmp100.4 = fcmp olt float %angle.0.4, 1.575000e+02
  %or.cond7.4 = and i1 %cmp96.4, %cmp100.4
  br i1 %or.cond7.4, label %if.then102.4, label %if.end118.4

if.then102.4:                                     ; preds = %if.else94.4
  %133 = trunc i64 %indvars.iv.4 to i32
  %sub105.4 = add i32 %133, %sub103.4
  %add106.4 = add i32 %sub105.4, -129
  %idxprom107.4 = sext i32 %add106.4 to i64
  %arrayidx108.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.4
  %134 = load float, float* %arrayidx108.4, align 4
  %add112.4 = add i32 %sub105.4, 129
  %idxprom113.4 = sext i32 %add112.4 to i64
  %arrayidx114.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.4
  %135 = load float, float* %arrayidx114.4, align 4
  br label %if.end118.4

if.then83.4:                                      ; preds = %if.else75.4
  %136 = add nsw i64 %130, %indvars.iv.4
  %arrayidx88.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %136
  %137 = load float, float* %arrayidx88.4, align 4
  %138 = add nsw i64 %129, %indvars.iv.4
  %arrayidx93.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %138
  %139 = load float, float* %arrayidx93.4, align 4
  br label %if.end118.4

if.then62.4:                                      ; preds = %if.else54.4
  %140 = trunc i64 %indvars.iv.4 to i32
  %sub65.4 = add i32 %140, %add63.4
  %add66.4 = add i32 %sub65.4, 127
  %idxprom67.4 = sext i32 %add66.4 to i64
  %arrayidx68.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.4
  %141 = load float, float* %arrayidx68.4, align 4
  %add72.4 = add i32 %sub65.4, -127
  %idxprom73.4 = sext i32 %add72.4 to i64
  %arrayidx74.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.4
  %142 = load float, float* %arrayidx74.4, align 4
  br label %if.end118.4

if.then43.4:                                      ; preds = %lor.lhs.false36.4, %if.else20.4
  %143 = trunc i64 %indvars.iv.4 to i32
  %add46.4 = add i32 %add45.4, %143
  %idxprom47.4 = sext i32 %add46.4 to i64
  %arrayidx48.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.4
  %144 = load float, float* %arrayidx48.4, align 4
  %145 = trunc i64 %indvars.iv.4 to i32
  %add51.4 = add i32 %sub50.4, %145
  %idxprom52.4 = sext i32 %add51.4 to i64
  %arrayidx53.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.4
  %146 = load float, float* %arrayidx53.4, align 4
  br label %if.end118.4

if.end118.4:                                      ; preds = %if.then43.4, %if.then62.4, %if.then83.4, %if.then102.4, %if.else94.4
  %q.3.4 = phi float [ %144, %if.then43.4 ], [ %141, %if.then62.4 ], [ %137, %if.then83.4 ], [ %134, %if.then102.4 ], [ 2.550000e+02, %if.else94.4 ]
  %r.3.4 = phi float [ %146, %if.then43.4 ], [ %142, %if.then62.4 ], [ %139, %if.then83.4 ], [ %135, %if.then102.4 ], [ 2.550000e+02, %if.else94.4 ]
  %arrayidx120.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %131
  %147 = load float, float* %arrayidx120.4, align 4
  %cmp121.4 = fcmp ult float %147, %q.3.4
  %cmp126.4 = fcmp ult float %147, %r.3.4
  %or.cond8.4 = or i1 %cmp121.4, %cmp126.4
  br i1 %or.cond8.4, label %if.else134.4, label %if.then128.4

if.then128.4:                                     ; preds = %if.end118.4
  %conv131.4 = fptoui float %147 to i32
  %arrayidx133.4 = getelementptr inbounds i32, i32* %., i64 %131
  store i32 %conv131.4, i32* %arrayidx133.4, align 4
  br label %for.inc.4

if.else134.4:                                     ; preds = %if.end118.4
  %arrayidx136.4 = getelementptr inbounds i32, i32* %., i64 %131
  store i32 0, i32* %arrayidx136.4, align 4
  br label %for.inc.4

if.then19.4:                                      ; preds = %for.body8.4
  %arrayidx.4 = getelementptr inbounds i32, i32* %., i64 %131
  store i32 0, i32* %arrayidx.4, align 4
  br label %for.inc.4

for.inc.4:                                        ; preds = %if.then19.4, %if.else134.4, %if.then128.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %img_width
  br i1 %exitcond.4, label %for.inc139.4, label %for.body8.4, !llvm.loop !1

for.inc139.4:                                     ; preds = %for.inc.4
  %indvars.iv.next20.4 = add nsw i64 %indvars.iv19, 5
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.5

for.body8.lr.ph.5:                                ; preds = %for.inc139.4
  %148 = trunc i64 %indvars.iv.next20.4 to i32
  %mul.5 = shl nsw i32 %148, 7
  %cmp11.5 = icmp eq i64 %indvars.iv.next20.4, %1
  %add45.5 = or i32 %mul.5, 1
  %sub50.5 = add i32 %mul.5, -1
  %149 = trunc i64 %indvars.iv.next20.4 to i32
  %add63.5 = shl i32 %149, 7
  %150 = trunc i64 %indvars.iv.next20.4 to i32
  %add84.5 = shl i32 %150, 7
  %mul85.5 = add i32 %add84.5, 128
  %mul90.5 = add i32 %add84.5, -128
  %151 = trunc i64 %indvars.iv.next20.4 to i32
  %sub103.5 = shl i32 %151, 7
  %152 = sext i32 %mul.5 to i64
  %153 = sext i32 %mul90.5 to i64
  %154 = sext i32 %mul85.5 to i64
  br label %for.body8.5

for.body8.5:                                      ; preds = %for.inc.5, %for.body8.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body8.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc.5 ]
  %155 = add nsw i64 %indvars.iv.5, %152
  %cmp14.5 = icmp eq i64 %indvars.iv.5, 0
  %or.cond1.5 = or i1 %cmp11.5, %cmp14.5
  %cmp17.5 = icmp eq i64 %indvars.iv.5, %0
  %or.cond2.5 = or i1 %cmp17.5, %or.cond1.5
  br i1 %or.cond2.5, label %if.then19.5, label %if.else20.5

if.else20.5:                                      ; preds = %for.body8.5
  %arrayidx22.5 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %155
  %156 = load float, float* %arrayidx22.5, align 4
  %conv23.5 = fpext float %156 to double
  %mul24.5 = fmul double %conv23.5, 0x404CA5DC1A63C1F8
  %conv25.5 = fptrunc double %mul24.5 to float
  %cmp26.5 = fcmp olt float %conv25.5, 0.000000e+00
  %add29.5 = fadd float %conv25.5, 1.800000e+02
  %angle.0.5 = select i1 %cmp26.5, float %add29.5, float %conv25.5
  %cmp31.5 = fcmp oge float %angle.0.5, 0.000000e+00
  %cmp34.5 = fcmp olt float %angle.0.5, 2.250000e+01
  %or.cond3.5 = and i1 %cmp31.5, %cmp34.5
  br i1 %or.cond3.5, label %if.then43.5, label %lor.lhs.false36.5

lor.lhs.false36.5:                                ; preds = %if.else20.5
  %cmp38.5 = fcmp ult float %angle.0.5, 1.575000e+02
  %cmp41.5 = fcmp ugt float %angle.0.5, 1.800000e+02
  %or.cond4.5 = or i1 %cmp38.5, %cmp41.5
  br i1 %or.cond4.5, label %if.else54.5, label %if.then43.5

if.else54.5:                                      ; preds = %lor.lhs.false36.5
  %cmp56.5 = fcmp oge float %angle.0.5, 2.250000e+01
  %cmp60.5 = fcmp olt float %angle.0.5, 6.750000e+01
  %or.cond5.5 = and i1 %cmp56.5, %cmp60.5
  br i1 %or.cond5.5, label %if.then62.5, label %if.else75.5

if.else75.5:                                      ; preds = %if.else54.5
  %cmp77.5 = fcmp oge float %angle.0.5, 6.750000e+01
  %cmp81.5 = fcmp olt float %angle.0.5, 1.125000e+02
  %or.cond6.5 = and i1 %cmp77.5, %cmp81.5
  br i1 %or.cond6.5, label %if.then83.5, label %if.else94.5

if.else94.5:                                      ; preds = %if.else75.5
  %cmp96.5 = fcmp oge float %angle.0.5, 1.125000e+02
  %cmp100.5 = fcmp olt float %angle.0.5, 1.575000e+02
  %or.cond7.5 = and i1 %cmp96.5, %cmp100.5
  br i1 %or.cond7.5, label %if.then102.5, label %if.end118.5

if.then102.5:                                     ; preds = %if.else94.5
  %157 = trunc i64 %indvars.iv.5 to i32
  %sub105.5 = add i32 %157, %sub103.5
  %add106.5 = add i32 %sub105.5, -129
  %idxprom107.5 = sext i32 %add106.5 to i64
  %arrayidx108.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.5
  %158 = load float, float* %arrayidx108.5, align 4
  %add112.5 = add i32 %sub105.5, 129
  %idxprom113.5 = sext i32 %add112.5 to i64
  %arrayidx114.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.5
  %159 = load float, float* %arrayidx114.5, align 4
  br label %if.end118.5

if.then83.5:                                      ; preds = %if.else75.5
  %160 = add nsw i64 %154, %indvars.iv.5
  %arrayidx88.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %160
  %161 = load float, float* %arrayidx88.5, align 4
  %162 = add nsw i64 %153, %indvars.iv.5
  %arrayidx93.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %162
  %163 = load float, float* %arrayidx93.5, align 4
  br label %if.end118.5

if.then62.5:                                      ; preds = %if.else54.5
  %164 = trunc i64 %indvars.iv.5 to i32
  %sub65.5 = add i32 %164, %add63.5
  %add66.5 = add i32 %sub65.5, 127
  %idxprom67.5 = sext i32 %add66.5 to i64
  %arrayidx68.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.5
  %165 = load float, float* %arrayidx68.5, align 4
  %add72.5 = add i32 %sub65.5, -127
  %idxprom73.5 = sext i32 %add72.5 to i64
  %arrayidx74.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.5
  %166 = load float, float* %arrayidx74.5, align 4
  br label %if.end118.5

if.then43.5:                                      ; preds = %lor.lhs.false36.5, %if.else20.5
  %167 = trunc i64 %indvars.iv.5 to i32
  %add46.5 = add i32 %add45.5, %167
  %idxprom47.5 = sext i32 %add46.5 to i64
  %arrayidx48.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.5
  %168 = load float, float* %arrayidx48.5, align 4
  %169 = trunc i64 %indvars.iv.5 to i32
  %add51.5 = add i32 %sub50.5, %169
  %idxprom52.5 = sext i32 %add51.5 to i64
  %arrayidx53.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.5
  %170 = load float, float* %arrayidx53.5, align 4
  br label %if.end118.5

if.end118.5:                                      ; preds = %if.then43.5, %if.then62.5, %if.then83.5, %if.then102.5, %if.else94.5
  %q.3.5 = phi float [ %168, %if.then43.5 ], [ %165, %if.then62.5 ], [ %161, %if.then83.5 ], [ %158, %if.then102.5 ], [ 2.550000e+02, %if.else94.5 ]
  %r.3.5 = phi float [ %170, %if.then43.5 ], [ %166, %if.then62.5 ], [ %163, %if.then83.5 ], [ %159, %if.then102.5 ], [ 2.550000e+02, %if.else94.5 ]
  %arrayidx120.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %155
  %171 = load float, float* %arrayidx120.5, align 4
  %cmp121.5 = fcmp ult float %171, %q.3.5
  %cmp126.5 = fcmp ult float %171, %r.3.5
  %or.cond8.5 = or i1 %cmp121.5, %cmp126.5
  br i1 %or.cond8.5, label %if.else134.5, label %if.then128.5

if.then128.5:                                     ; preds = %if.end118.5
  %conv131.5 = fptoui float %171 to i32
  %arrayidx133.5 = getelementptr inbounds i32, i32* %., i64 %155
  store i32 %conv131.5, i32* %arrayidx133.5, align 4
  br label %for.inc.5

if.else134.5:                                     ; preds = %if.end118.5
  %arrayidx136.5 = getelementptr inbounds i32, i32* %., i64 %155
  store i32 0, i32* %arrayidx136.5, align 4
  br label %for.inc.5

if.then19.5:                                      ; preds = %for.body8.5
  %arrayidx.5 = getelementptr inbounds i32, i32* %., i64 %155
  store i32 0, i32* %arrayidx.5, align 4
  br label %for.inc.5

for.inc.5:                                        ; preds = %if.then19.5, %if.else134.5, %if.then128.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %img_width
  br i1 %exitcond.5, label %for.inc139.5, label %for.body8.5, !llvm.loop !1

for.inc139.5:                                     ; preds = %for.inc.5
  %indvars.iv.next20.5 = add nsw i64 %indvars.iv19, 6
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.6

for.body8.lr.ph.6:                                ; preds = %for.inc139.5
  %172 = trunc i64 %indvars.iv.next20.5 to i32
  %mul.6 = shl nsw i32 %172, 7
  %cmp11.6 = icmp eq i64 %indvars.iv.next20.5, %1
  %add45.6 = or i32 %mul.6, 1
  %sub50.6 = add i32 %mul.6, -1
  %173 = trunc i64 %indvars.iv.next20.5 to i32
  %add63.6 = shl i32 %173, 7
  %174 = trunc i64 %indvars.iv.next20.5 to i32
  %add84.6 = shl i32 %174, 7
  %mul85.6 = add i32 %add84.6, 128
  %mul90.6 = add i32 %add84.6, -128
  %175 = trunc i64 %indvars.iv.next20.5 to i32
  %sub103.6 = shl i32 %175, 7
  %176 = sext i32 %mul.6 to i64
  %177 = sext i32 %mul90.6 to i64
  %178 = sext i32 %mul85.6 to i64
  br label %for.body8.6

for.body8.6:                                      ; preds = %for.inc.6, %for.body8.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body8.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc.6 ]
  %179 = add nsw i64 %indvars.iv.6, %176
  %cmp14.6 = icmp eq i64 %indvars.iv.6, 0
  %or.cond1.6 = or i1 %cmp11.6, %cmp14.6
  %cmp17.6 = icmp eq i64 %indvars.iv.6, %0
  %or.cond2.6 = or i1 %cmp17.6, %or.cond1.6
  br i1 %or.cond2.6, label %if.then19.6, label %if.else20.6

if.else20.6:                                      ; preds = %for.body8.6
  %arrayidx22.6 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %179
  %180 = load float, float* %arrayidx22.6, align 4
  %conv23.6 = fpext float %180 to double
  %mul24.6 = fmul double %conv23.6, 0x404CA5DC1A63C1F8
  %conv25.6 = fptrunc double %mul24.6 to float
  %cmp26.6 = fcmp olt float %conv25.6, 0.000000e+00
  %add29.6 = fadd float %conv25.6, 1.800000e+02
  %angle.0.6 = select i1 %cmp26.6, float %add29.6, float %conv25.6
  %cmp31.6 = fcmp oge float %angle.0.6, 0.000000e+00
  %cmp34.6 = fcmp olt float %angle.0.6, 2.250000e+01
  %or.cond3.6 = and i1 %cmp31.6, %cmp34.6
  br i1 %or.cond3.6, label %if.then43.6, label %lor.lhs.false36.6

lor.lhs.false36.6:                                ; preds = %if.else20.6
  %cmp38.6 = fcmp ult float %angle.0.6, 1.575000e+02
  %cmp41.6 = fcmp ugt float %angle.0.6, 1.800000e+02
  %or.cond4.6 = or i1 %cmp38.6, %cmp41.6
  br i1 %or.cond4.6, label %if.else54.6, label %if.then43.6

if.else54.6:                                      ; preds = %lor.lhs.false36.6
  %cmp56.6 = fcmp oge float %angle.0.6, 2.250000e+01
  %cmp60.6 = fcmp olt float %angle.0.6, 6.750000e+01
  %or.cond5.6 = and i1 %cmp56.6, %cmp60.6
  br i1 %or.cond5.6, label %if.then62.6, label %if.else75.6

if.else75.6:                                      ; preds = %if.else54.6
  %cmp77.6 = fcmp oge float %angle.0.6, 6.750000e+01
  %cmp81.6 = fcmp olt float %angle.0.6, 1.125000e+02
  %or.cond6.6 = and i1 %cmp77.6, %cmp81.6
  br i1 %or.cond6.6, label %if.then83.6, label %if.else94.6

if.else94.6:                                      ; preds = %if.else75.6
  %cmp96.6 = fcmp oge float %angle.0.6, 1.125000e+02
  %cmp100.6 = fcmp olt float %angle.0.6, 1.575000e+02
  %or.cond7.6 = and i1 %cmp96.6, %cmp100.6
  br i1 %or.cond7.6, label %if.then102.6, label %if.end118.6

if.then102.6:                                     ; preds = %if.else94.6
  %181 = trunc i64 %indvars.iv.6 to i32
  %sub105.6 = add i32 %181, %sub103.6
  %add106.6 = add i32 %sub105.6, -129
  %idxprom107.6 = sext i32 %add106.6 to i64
  %arrayidx108.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.6
  %182 = load float, float* %arrayidx108.6, align 4
  %add112.6 = add i32 %sub105.6, 129
  %idxprom113.6 = sext i32 %add112.6 to i64
  %arrayidx114.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.6
  %183 = load float, float* %arrayidx114.6, align 4
  br label %if.end118.6

if.then83.6:                                      ; preds = %if.else75.6
  %184 = add nsw i64 %178, %indvars.iv.6
  %arrayidx88.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %184
  %185 = load float, float* %arrayidx88.6, align 4
  %186 = add nsw i64 %177, %indvars.iv.6
  %arrayidx93.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %186
  %187 = load float, float* %arrayidx93.6, align 4
  br label %if.end118.6

if.then62.6:                                      ; preds = %if.else54.6
  %188 = trunc i64 %indvars.iv.6 to i32
  %sub65.6 = add i32 %188, %add63.6
  %add66.6 = add i32 %sub65.6, 127
  %idxprom67.6 = sext i32 %add66.6 to i64
  %arrayidx68.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.6
  %189 = load float, float* %arrayidx68.6, align 4
  %add72.6 = add i32 %sub65.6, -127
  %idxprom73.6 = sext i32 %add72.6 to i64
  %arrayidx74.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.6
  %190 = load float, float* %arrayidx74.6, align 4
  br label %if.end118.6

if.then43.6:                                      ; preds = %lor.lhs.false36.6, %if.else20.6
  %191 = trunc i64 %indvars.iv.6 to i32
  %add46.6 = add i32 %add45.6, %191
  %idxprom47.6 = sext i32 %add46.6 to i64
  %arrayidx48.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.6
  %192 = load float, float* %arrayidx48.6, align 4
  %193 = trunc i64 %indvars.iv.6 to i32
  %add51.6 = add i32 %sub50.6, %193
  %idxprom52.6 = sext i32 %add51.6 to i64
  %arrayidx53.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.6
  %194 = load float, float* %arrayidx53.6, align 4
  br label %if.end118.6

if.end118.6:                                      ; preds = %if.then43.6, %if.then62.6, %if.then83.6, %if.then102.6, %if.else94.6
  %q.3.6 = phi float [ %192, %if.then43.6 ], [ %189, %if.then62.6 ], [ %185, %if.then83.6 ], [ %182, %if.then102.6 ], [ 2.550000e+02, %if.else94.6 ]
  %r.3.6 = phi float [ %194, %if.then43.6 ], [ %190, %if.then62.6 ], [ %187, %if.then83.6 ], [ %183, %if.then102.6 ], [ 2.550000e+02, %if.else94.6 ]
  %arrayidx120.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %179
  %195 = load float, float* %arrayidx120.6, align 4
  %cmp121.6 = fcmp ult float %195, %q.3.6
  %cmp126.6 = fcmp ult float %195, %r.3.6
  %or.cond8.6 = or i1 %cmp121.6, %cmp126.6
  br i1 %or.cond8.6, label %if.else134.6, label %if.then128.6

if.then128.6:                                     ; preds = %if.end118.6
  %conv131.6 = fptoui float %195 to i32
  %arrayidx133.6 = getelementptr inbounds i32, i32* %., i64 %179
  store i32 %conv131.6, i32* %arrayidx133.6, align 4
  br label %for.inc.6

if.else134.6:                                     ; preds = %if.end118.6
  %arrayidx136.6 = getelementptr inbounds i32, i32* %., i64 %179
  store i32 0, i32* %arrayidx136.6, align 4
  br label %for.inc.6

if.then19.6:                                      ; preds = %for.body8.6
  %arrayidx.6 = getelementptr inbounds i32, i32* %., i64 %179
  store i32 0, i32* %arrayidx.6, align 4
  br label %for.inc.6

for.inc.6:                                        ; preds = %if.then19.6, %if.else134.6, %if.then128.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %img_width
  br i1 %exitcond.6, label %for.inc139.6, label %for.body8.6, !llvm.loop !1

for.inc139.6:                                     ; preds = %for.inc.6
  %indvars.iv.next20.6 = add nsw i64 %indvars.iv19, 7
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.7

for.body8.lr.ph.7:                                ; preds = %for.inc139.6
  %196 = trunc i64 %indvars.iv.next20.6 to i32
  %mul.7 = shl nsw i32 %196, 7
  %cmp11.7 = icmp eq i64 %indvars.iv.next20.6, %1
  %add45.7 = or i32 %mul.7, 1
  %sub50.7 = add i32 %mul.7, -1
  %197 = trunc i64 %indvars.iv.next20.6 to i32
  %add63.7 = shl i32 %197, 7
  %198 = trunc i64 %indvars.iv.next20.6 to i32
  %add84.7 = shl i32 %198, 7
  %mul85.7 = add i32 %add84.7, 128
  %mul90.7 = add i32 %add84.7, -128
  %199 = trunc i64 %indvars.iv.next20.6 to i32
  %sub103.7 = shl i32 %199, 7
  %200 = sext i32 %mul.7 to i64
  %201 = sext i32 %mul90.7 to i64
  %202 = sext i32 %mul85.7 to i64
  br label %for.body8.7

for.body8.7:                                      ; preds = %for.inc.7, %for.body8.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body8.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc.7 ]
  %203 = add nsw i64 %indvars.iv.7, %200
  %cmp14.7 = icmp eq i64 %indvars.iv.7, 0
  %or.cond1.7 = or i1 %cmp11.7, %cmp14.7
  %cmp17.7 = icmp eq i64 %indvars.iv.7, %0
  %or.cond2.7 = or i1 %cmp17.7, %or.cond1.7
  br i1 %or.cond2.7, label %if.then19.7, label %if.else20.7

if.else20.7:                                      ; preds = %for.body8.7
  %arrayidx22.7 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %203
  %204 = load float, float* %arrayidx22.7, align 4
  %conv23.7 = fpext float %204 to double
  %mul24.7 = fmul double %conv23.7, 0x404CA5DC1A63C1F8
  %conv25.7 = fptrunc double %mul24.7 to float
  %cmp26.7 = fcmp olt float %conv25.7, 0.000000e+00
  %add29.7 = fadd float %conv25.7, 1.800000e+02
  %angle.0.7 = select i1 %cmp26.7, float %add29.7, float %conv25.7
  %cmp31.7 = fcmp oge float %angle.0.7, 0.000000e+00
  %cmp34.7 = fcmp olt float %angle.0.7, 2.250000e+01
  %or.cond3.7 = and i1 %cmp31.7, %cmp34.7
  br i1 %or.cond3.7, label %if.then43.7, label %lor.lhs.false36.7

lor.lhs.false36.7:                                ; preds = %if.else20.7
  %cmp38.7 = fcmp ult float %angle.0.7, 1.575000e+02
  %cmp41.7 = fcmp ugt float %angle.0.7, 1.800000e+02
  %or.cond4.7 = or i1 %cmp38.7, %cmp41.7
  br i1 %or.cond4.7, label %if.else54.7, label %if.then43.7

if.else54.7:                                      ; preds = %lor.lhs.false36.7
  %cmp56.7 = fcmp oge float %angle.0.7, 2.250000e+01
  %cmp60.7 = fcmp olt float %angle.0.7, 6.750000e+01
  %or.cond5.7 = and i1 %cmp56.7, %cmp60.7
  br i1 %or.cond5.7, label %if.then62.7, label %if.else75.7

if.else75.7:                                      ; preds = %if.else54.7
  %cmp77.7 = fcmp oge float %angle.0.7, 6.750000e+01
  %cmp81.7 = fcmp olt float %angle.0.7, 1.125000e+02
  %or.cond6.7 = and i1 %cmp77.7, %cmp81.7
  br i1 %or.cond6.7, label %if.then83.7, label %if.else94.7

if.else94.7:                                      ; preds = %if.else75.7
  %cmp96.7 = fcmp oge float %angle.0.7, 1.125000e+02
  %cmp100.7 = fcmp olt float %angle.0.7, 1.575000e+02
  %or.cond7.7 = and i1 %cmp96.7, %cmp100.7
  br i1 %or.cond7.7, label %if.then102.7, label %if.end118.7

if.then102.7:                                     ; preds = %if.else94.7
  %205 = trunc i64 %indvars.iv.7 to i32
  %sub105.7 = add i32 %205, %sub103.7
  %add106.7 = add i32 %sub105.7, -129
  %idxprom107.7 = sext i32 %add106.7 to i64
  %arrayidx108.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.7
  %206 = load float, float* %arrayidx108.7, align 4
  %add112.7 = add i32 %sub105.7, 129
  %idxprom113.7 = sext i32 %add112.7 to i64
  %arrayidx114.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.7
  %207 = load float, float* %arrayidx114.7, align 4
  br label %if.end118.7

if.then83.7:                                      ; preds = %if.else75.7
  %208 = add nsw i64 %202, %indvars.iv.7
  %arrayidx88.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %208
  %209 = load float, float* %arrayidx88.7, align 4
  %210 = add nsw i64 %201, %indvars.iv.7
  %arrayidx93.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %210
  %211 = load float, float* %arrayidx93.7, align 4
  br label %if.end118.7

if.then62.7:                                      ; preds = %if.else54.7
  %212 = trunc i64 %indvars.iv.7 to i32
  %sub65.7 = add i32 %212, %add63.7
  %add66.7 = add i32 %sub65.7, 127
  %idxprom67.7 = sext i32 %add66.7 to i64
  %arrayidx68.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.7
  %213 = load float, float* %arrayidx68.7, align 4
  %add72.7 = add i32 %sub65.7, -127
  %idxprom73.7 = sext i32 %add72.7 to i64
  %arrayidx74.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.7
  %214 = load float, float* %arrayidx74.7, align 4
  br label %if.end118.7

if.then43.7:                                      ; preds = %lor.lhs.false36.7, %if.else20.7
  %215 = trunc i64 %indvars.iv.7 to i32
  %add46.7 = add i32 %add45.7, %215
  %idxprom47.7 = sext i32 %add46.7 to i64
  %arrayidx48.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.7
  %216 = load float, float* %arrayidx48.7, align 4
  %217 = trunc i64 %indvars.iv.7 to i32
  %add51.7 = add i32 %sub50.7, %217
  %idxprom52.7 = sext i32 %add51.7 to i64
  %arrayidx53.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.7
  %218 = load float, float* %arrayidx53.7, align 4
  br label %if.end118.7

if.end118.7:                                      ; preds = %if.then43.7, %if.then62.7, %if.then83.7, %if.then102.7, %if.else94.7
  %q.3.7 = phi float [ %216, %if.then43.7 ], [ %213, %if.then62.7 ], [ %209, %if.then83.7 ], [ %206, %if.then102.7 ], [ 2.550000e+02, %if.else94.7 ]
  %r.3.7 = phi float [ %218, %if.then43.7 ], [ %214, %if.then62.7 ], [ %211, %if.then83.7 ], [ %207, %if.then102.7 ], [ 2.550000e+02, %if.else94.7 ]
  %arrayidx120.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %203
  %219 = load float, float* %arrayidx120.7, align 4
  %cmp121.7 = fcmp ult float %219, %q.3.7
  %cmp126.7 = fcmp ult float %219, %r.3.7
  %or.cond8.7 = or i1 %cmp121.7, %cmp126.7
  br i1 %or.cond8.7, label %if.else134.7, label %if.then128.7

if.then128.7:                                     ; preds = %if.end118.7
  %conv131.7 = fptoui float %219 to i32
  %arrayidx133.7 = getelementptr inbounds i32, i32* %., i64 %203
  store i32 %conv131.7, i32* %arrayidx133.7, align 4
  br label %for.inc.7

if.else134.7:                                     ; preds = %if.end118.7
  %arrayidx136.7 = getelementptr inbounds i32, i32* %., i64 %203
  store i32 0, i32* %arrayidx136.7, align 4
  br label %for.inc.7

if.then19.7:                                      ; preds = %for.body8.7
  %arrayidx.7 = getelementptr inbounds i32, i32* %., i64 %203
  store i32 0, i32* %arrayidx.7, align 4
  br label %for.inc.7

for.inc.7:                                        ; preds = %if.then19.7, %if.else134.7, %if.then128.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %img_width
  br i1 %exitcond.7, label %for.inc139.7, label %for.body8.7, !llvm.loop !1

for.inc139.7:                                     ; preds = %for.inc.7
  %indvars.iv.next20.7 = add nsw i64 %indvars.iv19, 8
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.8

for.body8.lr.ph.8:                                ; preds = %for.inc139.7
  %220 = trunc i64 %indvars.iv.next20.7 to i32
  %mul.8 = shl nsw i32 %220, 7
  %cmp11.8 = icmp eq i64 %indvars.iv.next20.7, %1
  %add45.8 = or i32 %mul.8, 1
  %sub50.8 = add i32 %mul.8, -1
  %221 = trunc i64 %indvars.iv.next20.7 to i32
  %add63.8 = shl i32 %221, 7
  %222 = trunc i64 %indvars.iv.next20.7 to i32
  %add84.8 = shl i32 %222, 7
  %mul85.8 = add i32 %add84.8, 128
  %mul90.8 = add i32 %add84.8, -128
  %223 = trunc i64 %indvars.iv.next20.7 to i32
  %sub103.8 = shl i32 %223, 7
  %224 = sext i32 %mul.8 to i64
  %225 = sext i32 %mul90.8 to i64
  %226 = sext i32 %mul85.8 to i64
  br label %for.body8.8

for.body8.8:                                      ; preds = %for.inc.8, %for.body8.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body8.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc.8 ]
  %227 = add nsw i64 %indvars.iv.8, %224
  %cmp14.8 = icmp eq i64 %indvars.iv.8, 0
  %or.cond1.8 = or i1 %cmp11.8, %cmp14.8
  %cmp17.8 = icmp eq i64 %indvars.iv.8, %0
  %or.cond2.8 = or i1 %cmp17.8, %or.cond1.8
  br i1 %or.cond2.8, label %if.then19.8, label %if.else20.8

if.else20.8:                                      ; preds = %for.body8.8
  %arrayidx22.8 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %227
  %228 = load float, float* %arrayidx22.8, align 4
  %conv23.8 = fpext float %228 to double
  %mul24.8 = fmul double %conv23.8, 0x404CA5DC1A63C1F8
  %conv25.8 = fptrunc double %mul24.8 to float
  %cmp26.8 = fcmp olt float %conv25.8, 0.000000e+00
  %add29.8 = fadd float %conv25.8, 1.800000e+02
  %angle.0.8 = select i1 %cmp26.8, float %add29.8, float %conv25.8
  %cmp31.8 = fcmp oge float %angle.0.8, 0.000000e+00
  %cmp34.8 = fcmp olt float %angle.0.8, 2.250000e+01
  %or.cond3.8 = and i1 %cmp31.8, %cmp34.8
  br i1 %or.cond3.8, label %if.then43.8, label %lor.lhs.false36.8

lor.lhs.false36.8:                                ; preds = %if.else20.8
  %cmp38.8 = fcmp ult float %angle.0.8, 1.575000e+02
  %cmp41.8 = fcmp ugt float %angle.0.8, 1.800000e+02
  %or.cond4.8 = or i1 %cmp38.8, %cmp41.8
  br i1 %or.cond4.8, label %if.else54.8, label %if.then43.8

if.else54.8:                                      ; preds = %lor.lhs.false36.8
  %cmp56.8 = fcmp oge float %angle.0.8, 2.250000e+01
  %cmp60.8 = fcmp olt float %angle.0.8, 6.750000e+01
  %or.cond5.8 = and i1 %cmp56.8, %cmp60.8
  br i1 %or.cond5.8, label %if.then62.8, label %if.else75.8

if.else75.8:                                      ; preds = %if.else54.8
  %cmp77.8 = fcmp oge float %angle.0.8, 6.750000e+01
  %cmp81.8 = fcmp olt float %angle.0.8, 1.125000e+02
  %or.cond6.8 = and i1 %cmp77.8, %cmp81.8
  br i1 %or.cond6.8, label %if.then83.8, label %if.else94.8

if.else94.8:                                      ; preds = %if.else75.8
  %cmp96.8 = fcmp oge float %angle.0.8, 1.125000e+02
  %cmp100.8 = fcmp olt float %angle.0.8, 1.575000e+02
  %or.cond7.8 = and i1 %cmp96.8, %cmp100.8
  br i1 %or.cond7.8, label %if.then102.8, label %if.end118.8

if.then102.8:                                     ; preds = %if.else94.8
  %229 = trunc i64 %indvars.iv.8 to i32
  %sub105.8 = add i32 %229, %sub103.8
  %add106.8 = add i32 %sub105.8, -129
  %idxprom107.8 = sext i32 %add106.8 to i64
  %arrayidx108.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.8
  %230 = load float, float* %arrayidx108.8, align 4
  %add112.8 = add i32 %sub105.8, 129
  %idxprom113.8 = sext i32 %add112.8 to i64
  %arrayidx114.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.8
  %231 = load float, float* %arrayidx114.8, align 4
  br label %if.end118.8

if.then83.8:                                      ; preds = %if.else75.8
  %232 = add nsw i64 %226, %indvars.iv.8
  %arrayidx88.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %232
  %233 = load float, float* %arrayidx88.8, align 4
  %234 = add nsw i64 %225, %indvars.iv.8
  %arrayidx93.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %234
  %235 = load float, float* %arrayidx93.8, align 4
  br label %if.end118.8

if.then62.8:                                      ; preds = %if.else54.8
  %236 = trunc i64 %indvars.iv.8 to i32
  %sub65.8 = add i32 %236, %add63.8
  %add66.8 = add i32 %sub65.8, 127
  %idxprom67.8 = sext i32 %add66.8 to i64
  %arrayidx68.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.8
  %237 = load float, float* %arrayidx68.8, align 4
  %add72.8 = add i32 %sub65.8, -127
  %idxprom73.8 = sext i32 %add72.8 to i64
  %arrayidx74.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.8
  %238 = load float, float* %arrayidx74.8, align 4
  br label %if.end118.8

if.then43.8:                                      ; preds = %lor.lhs.false36.8, %if.else20.8
  %239 = trunc i64 %indvars.iv.8 to i32
  %add46.8 = add i32 %add45.8, %239
  %idxprom47.8 = sext i32 %add46.8 to i64
  %arrayidx48.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.8
  %240 = load float, float* %arrayidx48.8, align 4
  %241 = trunc i64 %indvars.iv.8 to i32
  %add51.8 = add i32 %sub50.8, %241
  %idxprom52.8 = sext i32 %add51.8 to i64
  %arrayidx53.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.8
  %242 = load float, float* %arrayidx53.8, align 4
  br label %if.end118.8

if.end118.8:                                      ; preds = %if.then43.8, %if.then62.8, %if.then83.8, %if.then102.8, %if.else94.8
  %q.3.8 = phi float [ %240, %if.then43.8 ], [ %237, %if.then62.8 ], [ %233, %if.then83.8 ], [ %230, %if.then102.8 ], [ 2.550000e+02, %if.else94.8 ]
  %r.3.8 = phi float [ %242, %if.then43.8 ], [ %238, %if.then62.8 ], [ %235, %if.then83.8 ], [ %231, %if.then102.8 ], [ 2.550000e+02, %if.else94.8 ]
  %arrayidx120.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %227
  %243 = load float, float* %arrayidx120.8, align 4
  %cmp121.8 = fcmp ult float %243, %q.3.8
  %cmp126.8 = fcmp ult float %243, %r.3.8
  %or.cond8.8 = or i1 %cmp121.8, %cmp126.8
  br i1 %or.cond8.8, label %if.else134.8, label %if.then128.8

if.then128.8:                                     ; preds = %if.end118.8
  %conv131.8 = fptoui float %243 to i32
  %arrayidx133.8 = getelementptr inbounds i32, i32* %., i64 %227
  store i32 %conv131.8, i32* %arrayidx133.8, align 4
  br label %for.inc.8

if.else134.8:                                     ; preds = %if.end118.8
  %arrayidx136.8 = getelementptr inbounds i32, i32* %., i64 %227
  store i32 0, i32* %arrayidx136.8, align 4
  br label %for.inc.8

if.then19.8:                                      ; preds = %for.body8.8
  %arrayidx.8 = getelementptr inbounds i32, i32* %., i64 %227
  store i32 0, i32* %arrayidx.8, align 4
  br label %for.inc.8

for.inc.8:                                        ; preds = %if.then19.8, %if.else134.8, %if.then128.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %img_width
  br i1 %exitcond.8, label %for.inc139.8, label %for.body8.8, !llvm.loop !1

for.inc139.8:                                     ; preds = %for.inc.8
  %indvars.iv.next20.8 = add nsw i64 %indvars.iv19, 9
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.9

for.body8.lr.ph.9:                                ; preds = %for.inc139.8
  %244 = trunc i64 %indvars.iv.next20.8 to i32
  %mul.9 = shl nsw i32 %244, 7
  %cmp11.9 = icmp eq i64 %indvars.iv.next20.8, %1
  %add45.9 = or i32 %mul.9, 1
  %sub50.9 = add i32 %mul.9, -1
  %245 = trunc i64 %indvars.iv.next20.8 to i32
  %add63.9 = shl i32 %245, 7
  %246 = trunc i64 %indvars.iv.next20.8 to i32
  %add84.9 = shl i32 %246, 7
  %mul85.9 = add i32 %add84.9, 128
  %mul90.9 = add i32 %add84.9, -128
  %247 = trunc i64 %indvars.iv.next20.8 to i32
  %sub103.9 = shl i32 %247, 7
  %248 = sext i32 %mul.9 to i64
  %249 = sext i32 %mul90.9 to i64
  %250 = sext i32 %mul85.9 to i64
  br label %for.body8.9

for.body8.9:                                      ; preds = %for.inc.9, %for.body8.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body8.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc.9 ]
  %251 = add nsw i64 %indvars.iv.9, %248
  %cmp14.9 = icmp eq i64 %indvars.iv.9, 0
  %or.cond1.9 = or i1 %cmp11.9, %cmp14.9
  %cmp17.9 = icmp eq i64 %indvars.iv.9, %0
  %or.cond2.9 = or i1 %cmp17.9, %or.cond1.9
  br i1 %or.cond2.9, label %if.then19.9, label %if.else20.9

if.else20.9:                                      ; preds = %for.body8.9
  %arrayidx22.9 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %251
  %252 = load float, float* %arrayidx22.9, align 4
  %conv23.9 = fpext float %252 to double
  %mul24.9 = fmul double %conv23.9, 0x404CA5DC1A63C1F8
  %conv25.9 = fptrunc double %mul24.9 to float
  %cmp26.9 = fcmp olt float %conv25.9, 0.000000e+00
  %add29.9 = fadd float %conv25.9, 1.800000e+02
  %angle.0.9 = select i1 %cmp26.9, float %add29.9, float %conv25.9
  %cmp31.9 = fcmp oge float %angle.0.9, 0.000000e+00
  %cmp34.9 = fcmp olt float %angle.0.9, 2.250000e+01
  %or.cond3.9 = and i1 %cmp31.9, %cmp34.9
  br i1 %or.cond3.9, label %if.then43.9, label %lor.lhs.false36.9

lor.lhs.false36.9:                                ; preds = %if.else20.9
  %cmp38.9 = fcmp ult float %angle.0.9, 1.575000e+02
  %cmp41.9 = fcmp ugt float %angle.0.9, 1.800000e+02
  %or.cond4.9 = or i1 %cmp38.9, %cmp41.9
  br i1 %or.cond4.9, label %if.else54.9, label %if.then43.9

if.else54.9:                                      ; preds = %lor.lhs.false36.9
  %cmp56.9 = fcmp oge float %angle.0.9, 2.250000e+01
  %cmp60.9 = fcmp olt float %angle.0.9, 6.750000e+01
  %or.cond5.9 = and i1 %cmp56.9, %cmp60.9
  br i1 %or.cond5.9, label %if.then62.9, label %if.else75.9

if.else75.9:                                      ; preds = %if.else54.9
  %cmp77.9 = fcmp oge float %angle.0.9, 6.750000e+01
  %cmp81.9 = fcmp olt float %angle.0.9, 1.125000e+02
  %or.cond6.9 = and i1 %cmp77.9, %cmp81.9
  br i1 %or.cond6.9, label %if.then83.9, label %if.else94.9

if.else94.9:                                      ; preds = %if.else75.9
  %cmp96.9 = fcmp oge float %angle.0.9, 1.125000e+02
  %cmp100.9 = fcmp olt float %angle.0.9, 1.575000e+02
  %or.cond7.9 = and i1 %cmp96.9, %cmp100.9
  br i1 %or.cond7.9, label %if.then102.9, label %if.end118.9

if.then102.9:                                     ; preds = %if.else94.9
  %253 = trunc i64 %indvars.iv.9 to i32
  %sub105.9 = add i32 %253, %sub103.9
  %add106.9 = add i32 %sub105.9, -129
  %idxprom107.9 = sext i32 %add106.9 to i64
  %arrayidx108.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.9
  %254 = load float, float* %arrayidx108.9, align 4
  %add112.9 = add i32 %sub105.9, 129
  %idxprom113.9 = sext i32 %add112.9 to i64
  %arrayidx114.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.9
  %255 = load float, float* %arrayidx114.9, align 4
  br label %if.end118.9

if.then83.9:                                      ; preds = %if.else75.9
  %256 = add nsw i64 %250, %indvars.iv.9
  %arrayidx88.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %256
  %257 = load float, float* %arrayidx88.9, align 4
  %258 = add nsw i64 %249, %indvars.iv.9
  %arrayidx93.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %258
  %259 = load float, float* %arrayidx93.9, align 4
  br label %if.end118.9

if.then62.9:                                      ; preds = %if.else54.9
  %260 = trunc i64 %indvars.iv.9 to i32
  %sub65.9 = add i32 %260, %add63.9
  %add66.9 = add i32 %sub65.9, 127
  %idxprom67.9 = sext i32 %add66.9 to i64
  %arrayidx68.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.9
  %261 = load float, float* %arrayidx68.9, align 4
  %add72.9 = add i32 %sub65.9, -127
  %idxprom73.9 = sext i32 %add72.9 to i64
  %arrayidx74.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.9
  %262 = load float, float* %arrayidx74.9, align 4
  br label %if.end118.9

if.then43.9:                                      ; preds = %lor.lhs.false36.9, %if.else20.9
  %263 = trunc i64 %indvars.iv.9 to i32
  %add46.9 = add i32 %add45.9, %263
  %idxprom47.9 = sext i32 %add46.9 to i64
  %arrayidx48.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.9
  %264 = load float, float* %arrayidx48.9, align 4
  %265 = trunc i64 %indvars.iv.9 to i32
  %add51.9 = add i32 %sub50.9, %265
  %idxprom52.9 = sext i32 %add51.9 to i64
  %arrayidx53.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.9
  %266 = load float, float* %arrayidx53.9, align 4
  br label %if.end118.9

if.end118.9:                                      ; preds = %if.then43.9, %if.then62.9, %if.then83.9, %if.then102.9, %if.else94.9
  %q.3.9 = phi float [ %264, %if.then43.9 ], [ %261, %if.then62.9 ], [ %257, %if.then83.9 ], [ %254, %if.then102.9 ], [ 2.550000e+02, %if.else94.9 ]
  %r.3.9 = phi float [ %266, %if.then43.9 ], [ %262, %if.then62.9 ], [ %259, %if.then83.9 ], [ %255, %if.then102.9 ], [ 2.550000e+02, %if.else94.9 ]
  %arrayidx120.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %251
  %267 = load float, float* %arrayidx120.9, align 4
  %cmp121.9 = fcmp ult float %267, %q.3.9
  %cmp126.9 = fcmp ult float %267, %r.3.9
  %or.cond8.9 = or i1 %cmp121.9, %cmp126.9
  br i1 %or.cond8.9, label %if.else134.9, label %if.then128.9

if.then128.9:                                     ; preds = %if.end118.9
  %conv131.9 = fptoui float %267 to i32
  %arrayidx133.9 = getelementptr inbounds i32, i32* %., i64 %251
  store i32 %conv131.9, i32* %arrayidx133.9, align 4
  br label %for.inc.9

if.else134.9:                                     ; preds = %if.end118.9
  %arrayidx136.9 = getelementptr inbounds i32, i32* %., i64 %251
  store i32 0, i32* %arrayidx136.9, align 4
  br label %for.inc.9

if.then19.9:                                      ; preds = %for.body8.9
  %arrayidx.9 = getelementptr inbounds i32, i32* %., i64 %251
  store i32 0, i32* %arrayidx.9, align 4
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.then19.9, %if.else134.9, %if.then128.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %img_width
  br i1 %exitcond.9, label %for.inc139.9, label %for.body8.9, !llvm.loop !1

for.inc139.9:                                     ; preds = %for.inc.9
  %indvars.iv.next20.9 = add nsw i64 %indvars.iv19, 10
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.10

for.body8.lr.ph.10:                               ; preds = %for.inc139.9
  %268 = trunc i64 %indvars.iv.next20.9 to i32
  %mul.10 = shl nsw i32 %268, 7
  %cmp11.10 = icmp eq i64 %indvars.iv.next20.9, %1
  %add45.10 = or i32 %mul.10, 1
  %sub50.10 = add i32 %mul.10, -1
  %269 = trunc i64 %indvars.iv.next20.9 to i32
  %add63.10 = shl i32 %269, 7
  %270 = trunc i64 %indvars.iv.next20.9 to i32
  %add84.10 = shl i32 %270, 7
  %mul85.10 = add i32 %add84.10, 128
  %mul90.10 = add i32 %add84.10, -128
  %271 = trunc i64 %indvars.iv.next20.9 to i32
  %sub103.10 = shl i32 %271, 7
  %272 = sext i32 %mul.10 to i64
  %273 = sext i32 %mul90.10 to i64
  %274 = sext i32 %mul85.10 to i64
  br label %for.body8.10

for.body8.10:                                     ; preds = %for.inc.10, %for.body8.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body8.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc.10 ]
  %275 = add nsw i64 %indvars.iv.10, %272
  %cmp14.10 = icmp eq i64 %indvars.iv.10, 0
  %or.cond1.10 = or i1 %cmp11.10, %cmp14.10
  %cmp17.10 = icmp eq i64 %indvars.iv.10, %0
  %or.cond2.10 = or i1 %cmp17.10, %or.cond1.10
  br i1 %or.cond2.10, label %if.then19.10, label %if.else20.10

if.else20.10:                                     ; preds = %for.body8.10
  %arrayidx22.10 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %275
  %276 = load float, float* %arrayidx22.10, align 4
  %conv23.10 = fpext float %276 to double
  %mul24.10 = fmul double %conv23.10, 0x404CA5DC1A63C1F8
  %conv25.10 = fptrunc double %mul24.10 to float
  %cmp26.10 = fcmp olt float %conv25.10, 0.000000e+00
  %add29.10 = fadd float %conv25.10, 1.800000e+02
  %angle.0.10 = select i1 %cmp26.10, float %add29.10, float %conv25.10
  %cmp31.10 = fcmp oge float %angle.0.10, 0.000000e+00
  %cmp34.10 = fcmp olt float %angle.0.10, 2.250000e+01
  %or.cond3.10 = and i1 %cmp31.10, %cmp34.10
  br i1 %or.cond3.10, label %if.then43.10, label %lor.lhs.false36.10

lor.lhs.false36.10:                               ; preds = %if.else20.10
  %cmp38.10 = fcmp ult float %angle.0.10, 1.575000e+02
  %cmp41.10 = fcmp ugt float %angle.0.10, 1.800000e+02
  %or.cond4.10 = or i1 %cmp38.10, %cmp41.10
  br i1 %or.cond4.10, label %if.else54.10, label %if.then43.10

if.else54.10:                                     ; preds = %lor.lhs.false36.10
  %cmp56.10 = fcmp oge float %angle.0.10, 2.250000e+01
  %cmp60.10 = fcmp olt float %angle.0.10, 6.750000e+01
  %or.cond5.10 = and i1 %cmp56.10, %cmp60.10
  br i1 %or.cond5.10, label %if.then62.10, label %if.else75.10

if.else75.10:                                     ; preds = %if.else54.10
  %cmp77.10 = fcmp oge float %angle.0.10, 6.750000e+01
  %cmp81.10 = fcmp olt float %angle.0.10, 1.125000e+02
  %or.cond6.10 = and i1 %cmp77.10, %cmp81.10
  br i1 %or.cond6.10, label %if.then83.10, label %if.else94.10

if.else94.10:                                     ; preds = %if.else75.10
  %cmp96.10 = fcmp oge float %angle.0.10, 1.125000e+02
  %cmp100.10 = fcmp olt float %angle.0.10, 1.575000e+02
  %or.cond7.10 = and i1 %cmp96.10, %cmp100.10
  br i1 %or.cond7.10, label %if.then102.10, label %if.end118.10

if.then102.10:                                    ; preds = %if.else94.10
  %277 = trunc i64 %indvars.iv.10 to i32
  %sub105.10 = add i32 %277, %sub103.10
  %add106.10 = add i32 %sub105.10, -129
  %idxprom107.10 = sext i32 %add106.10 to i64
  %arrayidx108.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.10
  %278 = load float, float* %arrayidx108.10, align 4
  %add112.10 = add i32 %sub105.10, 129
  %idxprom113.10 = sext i32 %add112.10 to i64
  %arrayidx114.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.10
  %279 = load float, float* %arrayidx114.10, align 4
  br label %if.end118.10

if.then83.10:                                     ; preds = %if.else75.10
  %280 = add nsw i64 %274, %indvars.iv.10
  %arrayidx88.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %280
  %281 = load float, float* %arrayidx88.10, align 4
  %282 = add nsw i64 %273, %indvars.iv.10
  %arrayidx93.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %282
  %283 = load float, float* %arrayidx93.10, align 4
  br label %if.end118.10

if.then62.10:                                     ; preds = %if.else54.10
  %284 = trunc i64 %indvars.iv.10 to i32
  %sub65.10 = add i32 %284, %add63.10
  %add66.10 = add i32 %sub65.10, 127
  %idxprom67.10 = sext i32 %add66.10 to i64
  %arrayidx68.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.10
  %285 = load float, float* %arrayidx68.10, align 4
  %add72.10 = add i32 %sub65.10, -127
  %idxprom73.10 = sext i32 %add72.10 to i64
  %arrayidx74.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.10
  %286 = load float, float* %arrayidx74.10, align 4
  br label %if.end118.10

if.then43.10:                                     ; preds = %lor.lhs.false36.10, %if.else20.10
  %287 = trunc i64 %indvars.iv.10 to i32
  %add46.10 = add i32 %add45.10, %287
  %idxprom47.10 = sext i32 %add46.10 to i64
  %arrayidx48.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.10
  %288 = load float, float* %arrayidx48.10, align 4
  %289 = trunc i64 %indvars.iv.10 to i32
  %add51.10 = add i32 %sub50.10, %289
  %idxprom52.10 = sext i32 %add51.10 to i64
  %arrayidx53.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.10
  %290 = load float, float* %arrayidx53.10, align 4
  br label %if.end118.10

if.end118.10:                                     ; preds = %if.then43.10, %if.then62.10, %if.then83.10, %if.then102.10, %if.else94.10
  %q.3.10 = phi float [ %288, %if.then43.10 ], [ %285, %if.then62.10 ], [ %281, %if.then83.10 ], [ %278, %if.then102.10 ], [ 2.550000e+02, %if.else94.10 ]
  %r.3.10 = phi float [ %290, %if.then43.10 ], [ %286, %if.then62.10 ], [ %283, %if.then83.10 ], [ %279, %if.then102.10 ], [ 2.550000e+02, %if.else94.10 ]
  %arrayidx120.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %275
  %291 = load float, float* %arrayidx120.10, align 4
  %cmp121.10 = fcmp ult float %291, %q.3.10
  %cmp126.10 = fcmp ult float %291, %r.3.10
  %or.cond8.10 = or i1 %cmp121.10, %cmp126.10
  br i1 %or.cond8.10, label %if.else134.10, label %if.then128.10

if.then128.10:                                    ; preds = %if.end118.10
  %conv131.10 = fptoui float %291 to i32
  %arrayidx133.10 = getelementptr inbounds i32, i32* %., i64 %275
  store i32 %conv131.10, i32* %arrayidx133.10, align 4
  br label %for.inc.10

if.else134.10:                                    ; preds = %if.end118.10
  %arrayidx136.10 = getelementptr inbounds i32, i32* %., i64 %275
  store i32 0, i32* %arrayidx136.10, align 4
  br label %for.inc.10

if.then19.10:                                     ; preds = %for.body8.10
  %arrayidx.10 = getelementptr inbounds i32, i32* %., i64 %275
  store i32 0, i32* %arrayidx.10, align 4
  br label %for.inc.10

for.inc.10:                                       ; preds = %if.then19.10, %if.else134.10, %if.then128.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %img_width
  br i1 %exitcond.10, label %for.inc139.10, label %for.body8.10, !llvm.loop !1

for.inc139.10:                                    ; preds = %for.inc.10
  %indvars.iv.next20.10 = add nsw i64 %indvars.iv19, 11
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.11

for.body8.lr.ph.11:                               ; preds = %for.inc139.10
  %292 = trunc i64 %indvars.iv.next20.10 to i32
  %mul.11 = shl nsw i32 %292, 7
  %cmp11.11 = icmp eq i64 %indvars.iv.next20.10, %1
  %add45.11 = or i32 %mul.11, 1
  %sub50.11 = add i32 %mul.11, -1
  %293 = trunc i64 %indvars.iv.next20.10 to i32
  %add63.11 = shl i32 %293, 7
  %294 = trunc i64 %indvars.iv.next20.10 to i32
  %add84.11 = shl i32 %294, 7
  %mul85.11 = add i32 %add84.11, 128
  %mul90.11 = add i32 %add84.11, -128
  %295 = trunc i64 %indvars.iv.next20.10 to i32
  %sub103.11 = shl i32 %295, 7
  %296 = sext i32 %mul.11 to i64
  %297 = sext i32 %mul90.11 to i64
  %298 = sext i32 %mul85.11 to i64
  br label %for.body8.11

for.body8.11:                                     ; preds = %for.inc.11, %for.body8.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body8.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc.11 ]
  %299 = add nsw i64 %indvars.iv.11, %296
  %cmp14.11 = icmp eq i64 %indvars.iv.11, 0
  %or.cond1.11 = or i1 %cmp11.11, %cmp14.11
  %cmp17.11 = icmp eq i64 %indvars.iv.11, %0
  %or.cond2.11 = or i1 %cmp17.11, %or.cond1.11
  br i1 %or.cond2.11, label %if.then19.11, label %if.else20.11

if.else20.11:                                     ; preds = %for.body8.11
  %arrayidx22.11 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %299
  %300 = load float, float* %arrayidx22.11, align 4
  %conv23.11 = fpext float %300 to double
  %mul24.11 = fmul double %conv23.11, 0x404CA5DC1A63C1F8
  %conv25.11 = fptrunc double %mul24.11 to float
  %cmp26.11 = fcmp olt float %conv25.11, 0.000000e+00
  %add29.11 = fadd float %conv25.11, 1.800000e+02
  %angle.0.11 = select i1 %cmp26.11, float %add29.11, float %conv25.11
  %cmp31.11 = fcmp oge float %angle.0.11, 0.000000e+00
  %cmp34.11 = fcmp olt float %angle.0.11, 2.250000e+01
  %or.cond3.11 = and i1 %cmp31.11, %cmp34.11
  br i1 %or.cond3.11, label %if.then43.11, label %lor.lhs.false36.11

lor.lhs.false36.11:                               ; preds = %if.else20.11
  %cmp38.11 = fcmp ult float %angle.0.11, 1.575000e+02
  %cmp41.11 = fcmp ugt float %angle.0.11, 1.800000e+02
  %or.cond4.11 = or i1 %cmp38.11, %cmp41.11
  br i1 %or.cond4.11, label %if.else54.11, label %if.then43.11

if.else54.11:                                     ; preds = %lor.lhs.false36.11
  %cmp56.11 = fcmp oge float %angle.0.11, 2.250000e+01
  %cmp60.11 = fcmp olt float %angle.0.11, 6.750000e+01
  %or.cond5.11 = and i1 %cmp56.11, %cmp60.11
  br i1 %or.cond5.11, label %if.then62.11, label %if.else75.11

if.else75.11:                                     ; preds = %if.else54.11
  %cmp77.11 = fcmp oge float %angle.0.11, 6.750000e+01
  %cmp81.11 = fcmp olt float %angle.0.11, 1.125000e+02
  %or.cond6.11 = and i1 %cmp77.11, %cmp81.11
  br i1 %or.cond6.11, label %if.then83.11, label %if.else94.11

if.else94.11:                                     ; preds = %if.else75.11
  %cmp96.11 = fcmp oge float %angle.0.11, 1.125000e+02
  %cmp100.11 = fcmp olt float %angle.0.11, 1.575000e+02
  %or.cond7.11 = and i1 %cmp96.11, %cmp100.11
  br i1 %or.cond7.11, label %if.then102.11, label %if.end118.11

if.then102.11:                                    ; preds = %if.else94.11
  %301 = trunc i64 %indvars.iv.11 to i32
  %sub105.11 = add i32 %301, %sub103.11
  %add106.11 = add i32 %sub105.11, -129
  %idxprom107.11 = sext i32 %add106.11 to i64
  %arrayidx108.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.11
  %302 = load float, float* %arrayidx108.11, align 4
  %add112.11 = add i32 %sub105.11, 129
  %idxprom113.11 = sext i32 %add112.11 to i64
  %arrayidx114.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.11
  %303 = load float, float* %arrayidx114.11, align 4
  br label %if.end118.11

if.then83.11:                                     ; preds = %if.else75.11
  %304 = add nsw i64 %298, %indvars.iv.11
  %arrayidx88.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %304
  %305 = load float, float* %arrayidx88.11, align 4
  %306 = add nsw i64 %297, %indvars.iv.11
  %arrayidx93.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %306
  %307 = load float, float* %arrayidx93.11, align 4
  br label %if.end118.11

if.then62.11:                                     ; preds = %if.else54.11
  %308 = trunc i64 %indvars.iv.11 to i32
  %sub65.11 = add i32 %308, %add63.11
  %add66.11 = add i32 %sub65.11, 127
  %idxprom67.11 = sext i32 %add66.11 to i64
  %arrayidx68.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.11
  %309 = load float, float* %arrayidx68.11, align 4
  %add72.11 = add i32 %sub65.11, -127
  %idxprom73.11 = sext i32 %add72.11 to i64
  %arrayidx74.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.11
  %310 = load float, float* %arrayidx74.11, align 4
  br label %if.end118.11

if.then43.11:                                     ; preds = %lor.lhs.false36.11, %if.else20.11
  %311 = trunc i64 %indvars.iv.11 to i32
  %add46.11 = add i32 %add45.11, %311
  %idxprom47.11 = sext i32 %add46.11 to i64
  %arrayidx48.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.11
  %312 = load float, float* %arrayidx48.11, align 4
  %313 = trunc i64 %indvars.iv.11 to i32
  %add51.11 = add i32 %sub50.11, %313
  %idxprom52.11 = sext i32 %add51.11 to i64
  %arrayidx53.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.11
  %314 = load float, float* %arrayidx53.11, align 4
  br label %if.end118.11

if.end118.11:                                     ; preds = %if.then43.11, %if.then62.11, %if.then83.11, %if.then102.11, %if.else94.11
  %q.3.11 = phi float [ %312, %if.then43.11 ], [ %309, %if.then62.11 ], [ %305, %if.then83.11 ], [ %302, %if.then102.11 ], [ 2.550000e+02, %if.else94.11 ]
  %r.3.11 = phi float [ %314, %if.then43.11 ], [ %310, %if.then62.11 ], [ %307, %if.then83.11 ], [ %303, %if.then102.11 ], [ 2.550000e+02, %if.else94.11 ]
  %arrayidx120.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %299
  %315 = load float, float* %arrayidx120.11, align 4
  %cmp121.11 = fcmp ult float %315, %q.3.11
  %cmp126.11 = fcmp ult float %315, %r.3.11
  %or.cond8.11 = or i1 %cmp121.11, %cmp126.11
  br i1 %or.cond8.11, label %if.else134.11, label %if.then128.11

if.then128.11:                                    ; preds = %if.end118.11
  %conv131.11 = fptoui float %315 to i32
  %arrayidx133.11 = getelementptr inbounds i32, i32* %., i64 %299
  store i32 %conv131.11, i32* %arrayidx133.11, align 4
  br label %for.inc.11

if.else134.11:                                    ; preds = %if.end118.11
  %arrayidx136.11 = getelementptr inbounds i32, i32* %., i64 %299
  store i32 0, i32* %arrayidx136.11, align 4
  br label %for.inc.11

if.then19.11:                                     ; preds = %for.body8.11
  %arrayidx.11 = getelementptr inbounds i32, i32* %., i64 %299
  store i32 0, i32* %arrayidx.11, align 4
  br label %for.inc.11

for.inc.11:                                       ; preds = %if.then19.11, %if.else134.11, %if.then128.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %img_width
  br i1 %exitcond.11, label %for.inc139.11, label %for.body8.11, !llvm.loop !1

for.inc139.11:                                    ; preds = %for.inc.11
  %indvars.iv.next20.11 = add nsw i64 %indvars.iv19, 12
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.12

for.body8.lr.ph.12:                               ; preds = %for.inc139.11
  %316 = trunc i64 %indvars.iv.next20.11 to i32
  %mul.12 = shl nsw i32 %316, 7
  %cmp11.12 = icmp eq i64 %indvars.iv.next20.11, %1
  %add45.12 = or i32 %mul.12, 1
  %sub50.12 = add i32 %mul.12, -1
  %317 = trunc i64 %indvars.iv.next20.11 to i32
  %add63.12 = shl i32 %317, 7
  %318 = trunc i64 %indvars.iv.next20.11 to i32
  %add84.12 = shl i32 %318, 7
  %mul85.12 = add i32 %add84.12, 128
  %mul90.12 = add i32 %add84.12, -128
  %319 = trunc i64 %indvars.iv.next20.11 to i32
  %sub103.12 = shl i32 %319, 7
  %320 = sext i32 %mul.12 to i64
  %321 = sext i32 %mul90.12 to i64
  %322 = sext i32 %mul85.12 to i64
  br label %for.body8.12

for.body8.12:                                     ; preds = %for.inc.12, %for.body8.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body8.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc.12 ]
  %323 = add nsw i64 %indvars.iv.12, %320
  %cmp14.12 = icmp eq i64 %indvars.iv.12, 0
  %or.cond1.12 = or i1 %cmp11.12, %cmp14.12
  %cmp17.12 = icmp eq i64 %indvars.iv.12, %0
  %or.cond2.12 = or i1 %cmp17.12, %or.cond1.12
  br i1 %or.cond2.12, label %if.then19.12, label %if.else20.12

if.else20.12:                                     ; preds = %for.body8.12
  %arrayidx22.12 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %323
  %324 = load float, float* %arrayidx22.12, align 4
  %conv23.12 = fpext float %324 to double
  %mul24.12 = fmul double %conv23.12, 0x404CA5DC1A63C1F8
  %conv25.12 = fptrunc double %mul24.12 to float
  %cmp26.12 = fcmp olt float %conv25.12, 0.000000e+00
  %add29.12 = fadd float %conv25.12, 1.800000e+02
  %angle.0.12 = select i1 %cmp26.12, float %add29.12, float %conv25.12
  %cmp31.12 = fcmp oge float %angle.0.12, 0.000000e+00
  %cmp34.12 = fcmp olt float %angle.0.12, 2.250000e+01
  %or.cond3.12 = and i1 %cmp31.12, %cmp34.12
  br i1 %or.cond3.12, label %if.then43.12, label %lor.lhs.false36.12

lor.lhs.false36.12:                               ; preds = %if.else20.12
  %cmp38.12 = fcmp ult float %angle.0.12, 1.575000e+02
  %cmp41.12 = fcmp ugt float %angle.0.12, 1.800000e+02
  %or.cond4.12 = or i1 %cmp38.12, %cmp41.12
  br i1 %or.cond4.12, label %if.else54.12, label %if.then43.12

if.else54.12:                                     ; preds = %lor.lhs.false36.12
  %cmp56.12 = fcmp oge float %angle.0.12, 2.250000e+01
  %cmp60.12 = fcmp olt float %angle.0.12, 6.750000e+01
  %or.cond5.12 = and i1 %cmp56.12, %cmp60.12
  br i1 %or.cond5.12, label %if.then62.12, label %if.else75.12

if.else75.12:                                     ; preds = %if.else54.12
  %cmp77.12 = fcmp oge float %angle.0.12, 6.750000e+01
  %cmp81.12 = fcmp olt float %angle.0.12, 1.125000e+02
  %or.cond6.12 = and i1 %cmp77.12, %cmp81.12
  br i1 %or.cond6.12, label %if.then83.12, label %if.else94.12

if.else94.12:                                     ; preds = %if.else75.12
  %cmp96.12 = fcmp oge float %angle.0.12, 1.125000e+02
  %cmp100.12 = fcmp olt float %angle.0.12, 1.575000e+02
  %or.cond7.12 = and i1 %cmp96.12, %cmp100.12
  br i1 %or.cond7.12, label %if.then102.12, label %if.end118.12

if.then102.12:                                    ; preds = %if.else94.12
  %325 = trunc i64 %indvars.iv.12 to i32
  %sub105.12 = add i32 %325, %sub103.12
  %add106.12 = add i32 %sub105.12, -129
  %idxprom107.12 = sext i32 %add106.12 to i64
  %arrayidx108.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.12
  %326 = load float, float* %arrayidx108.12, align 4
  %add112.12 = add i32 %sub105.12, 129
  %idxprom113.12 = sext i32 %add112.12 to i64
  %arrayidx114.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.12
  %327 = load float, float* %arrayidx114.12, align 4
  br label %if.end118.12

if.then83.12:                                     ; preds = %if.else75.12
  %328 = add nsw i64 %322, %indvars.iv.12
  %arrayidx88.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %328
  %329 = load float, float* %arrayidx88.12, align 4
  %330 = add nsw i64 %321, %indvars.iv.12
  %arrayidx93.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %330
  %331 = load float, float* %arrayidx93.12, align 4
  br label %if.end118.12

if.then62.12:                                     ; preds = %if.else54.12
  %332 = trunc i64 %indvars.iv.12 to i32
  %sub65.12 = add i32 %332, %add63.12
  %add66.12 = add i32 %sub65.12, 127
  %idxprom67.12 = sext i32 %add66.12 to i64
  %arrayidx68.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.12
  %333 = load float, float* %arrayidx68.12, align 4
  %add72.12 = add i32 %sub65.12, -127
  %idxprom73.12 = sext i32 %add72.12 to i64
  %arrayidx74.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.12
  %334 = load float, float* %arrayidx74.12, align 4
  br label %if.end118.12

if.then43.12:                                     ; preds = %lor.lhs.false36.12, %if.else20.12
  %335 = trunc i64 %indvars.iv.12 to i32
  %add46.12 = add i32 %add45.12, %335
  %idxprom47.12 = sext i32 %add46.12 to i64
  %arrayidx48.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.12
  %336 = load float, float* %arrayidx48.12, align 4
  %337 = trunc i64 %indvars.iv.12 to i32
  %add51.12 = add i32 %sub50.12, %337
  %idxprom52.12 = sext i32 %add51.12 to i64
  %arrayidx53.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.12
  %338 = load float, float* %arrayidx53.12, align 4
  br label %if.end118.12

if.end118.12:                                     ; preds = %if.then43.12, %if.then62.12, %if.then83.12, %if.then102.12, %if.else94.12
  %q.3.12 = phi float [ %336, %if.then43.12 ], [ %333, %if.then62.12 ], [ %329, %if.then83.12 ], [ %326, %if.then102.12 ], [ 2.550000e+02, %if.else94.12 ]
  %r.3.12 = phi float [ %338, %if.then43.12 ], [ %334, %if.then62.12 ], [ %331, %if.then83.12 ], [ %327, %if.then102.12 ], [ 2.550000e+02, %if.else94.12 ]
  %arrayidx120.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %323
  %339 = load float, float* %arrayidx120.12, align 4
  %cmp121.12 = fcmp ult float %339, %q.3.12
  %cmp126.12 = fcmp ult float %339, %r.3.12
  %or.cond8.12 = or i1 %cmp121.12, %cmp126.12
  br i1 %or.cond8.12, label %if.else134.12, label %if.then128.12

if.then128.12:                                    ; preds = %if.end118.12
  %conv131.12 = fptoui float %339 to i32
  %arrayidx133.12 = getelementptr inbounds i32, i32* %., i64 %323
  store i32 %conv131.12, i32* %arrayidx133.12, align 4
  br label %for.inc.12

if.else134.12:                                    ; preds = %if.end118.12
  %arrayidx136.12 = getelementptr inbounds i32, i32* %., i64 %323
  store i32 0, i32* %arrayidx136.12, align 4
  br label %for.inc.12

if.then19.12:                                     ; preds = %for.body8.12
  %arrayidx.12 = getelementptr inbounds i32, i32* %., i64 %323
  store i32 0, i32* %arrayidx.12, align 4
  br label %for.inc.12

for.inc.12:                                       ; preds = %if.then19.12, %if.else134.12, %if.then128.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %img_width
  br i1 %exitcond.12, label %for.inc139.12, label %for.body8.12, !llvm.loop !1

for.inc139.12:                                    ; preds = %for.inc.12
  %indvars.iv.next20.12 = add nsw i64 %indvars.iv19, 13
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.13

for.body8.lr.ph.13:                               ; preds = %for.inc139.12
  %340 = trunc i64 %indvars.iv.next20.12 to i32
  %mul.13 = shl nsw i32 %340, 7
  %cmp11.13 = icmp eq i64 %indvars.iv.next20.12, %1
  %add45.13 = or i32 %mul.13, 1
  %sub50.13 = add i32 %mul.13, -1
  %341 = trunc i64 %indvars.iv.next20.12 to i32
  %add63.13 = shl i32 %341, 7
  %342 = trunc i64 %indvars.iv.next20.12 to i32
  %add84.13 = shl i32 %342, 7
  %mul85.13 = add i32 %add84.13, 128
  %mul90.13 = add i32 %add84.13, -128
  %343 = trunc i64 %indvars.iv.next20.12 to i32
  %sub103.13 = shl i32 %343, 7
  %344 = sext i32 %mul.13 to i64
  %345 = sext i32 %mul90.13 to i64
  %346 = sext i32 %mul85.13 to i64
  br label %for.body8.13

for.body8.13:                                     ; preds = %for.inc.13, %for.body8.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body8.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc.13 ]
  %347 = add nsw i64 %indvars.iv.13, %344
  %cmp14.13 = icmp eq i64 %indvars.iv.13, 0
  %or.cond1.13 = or i1 %cmp11.13, %cmp14.13
  %cmp17.13 = icmp eq i64 %indvars.iv.13, %0
  %or.cond2.13 = or i1 %cmp17.13, %or.cond1.13
  br i1 %or.cond2.13, label %if.then19.13, label %if.else20.13

if.else20.13:                                     ; preds = %for.body8.13
  %arrayidx22.13 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %347
  %348 = load float, float* %arrayidx22.13, align 4
  %conv23.13 = fpext float %348 to double
  %mul24.13 = fmul double %conv23.13, 0x404CA5DC1A63C1F8
  %conv25.13 = fptrunc double %mul24.13 to float
  %cmp26.13 = fcmp olt float %conv25.13, 0.000000e+00
  %add29.13 = fadd float %conv25.13, 1.800000e+02
  %angle.0.13 = select i1 %cmp26.13, float %add29.13, float %conv25.13
  %cmp31.13 = fcmp oge float %angle.0.13, 0.000000e+00
  %cmp34.13 = fcmp olt float %angle.0.13, 2.250000e+01
  %or.cond3.13 = and i1 %cmp31.13, %cmp34.13
  br i1 %or.cond3.13, label %if.then43.13, label %lor.lhs.false36.13

lor.lhs.false36.13:                               ; preds = %if.else20.13
  %cmp38.13 = fcmp ult float %angle.0.13, 1.575000e+02
  %cmp41.13 = fcmp ugt float %angle.0.13, 1.800000e+02
  %or.cond4.13 = or i1 %cmp38.13, %cmp41.13
  br i1 %or.cond4.13, label %if.else54.13, label %if.then43.13

if.else54.13:                                     ; preds = %lor.lhs.false36.13
  %cmp56.13 = fcmp oge float %angle.0.13, 2.250000e+01
  %cmp60.13 = fcmp olt float %angle.0.13, 6.750000e+01
  %or.cond5.13 = and i1 %cmp56.13, %cmp60.13
  br i1 %or.cond5.13, label %if.then62.13, label %if.else75.13

if.else75.13:                                     ; preds = %if.else54.13
  %cmp77.13 = fcmp oge float %angle.0.13, 6.750000e+01
  %cmp81.13 = fcmp olt float %angle.0.13, 1.125000e+02
  %or.cond6.13 = and i1 %cmp77.13, %cmp81.13
  br i1 %or.cond6.13, label %if.then83.13, label %if.else94.13

if.else94.13:                                     ; preds = %if.else75.13
  %cmp96.13 = fcmp oge float %angle.0.13, 1.125000e+02
  %cmp100.13 = fcmp olt float %angle.0.13, 1.575000e+02
  %or.cond7.13 = and i1 %cmp96.13, %cmp100.13
  br i1 %or.cond7.13, label %if.then102.13, label %if.end118.13

if.then102.13:                                    ; preds = %if.else94.13
  %349 = trunc i64 %indvars.iv.13 to i32
  %sub105.13 = add i32 %349, %sub103.13
  %add106.13 = add i32 %sub105.13, -129
  %idxprom107.13 = sext i32 %add106.13 to i64
  %arrayidx108.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.13
  %350 = load float, float* %arrayidx108.13, align 4
  %add112.13 = add i32 %sub105.13, 129
  %idxprom113.13 = sext i32 %add112.13 to i64
  %arrayidx114.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.13
  %351 = load float, float* %arrayidx114.13, align 4
  br label %if.end118.13

if.then83.13:                                     ; preds = %if.else75.13
  %352 = add nsw i64 %346, %indvars.iv.13
  %arrayidx88.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %352
  %353 = load float, float* %arrayidx88.13, align 4
  %354 = add nsw i64 %345, %indvars.iv.13
  %arrayidx93.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %354
  %355 = load float, float* %arrayidx93.13, align 4
  br label %if.end118.13

if.then62.13:                                     ; preds = %if.else54.13
  %356 = trunc i64 %indvars.iv.13 to i32
  %sub65.13 = add i32 %356, %add63.13
  %add66.13 = add i32 %sub65.13, 127
  %idxprom67.13 = sext i32 %add66.13 to i64
  %arrayidx68.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.13
  %357 = load float, float* %arrayidx68.13, align 4
  %add72.13 = add i32 %sub65.13, -127
  %idxprom73.13 = sext i32 %add72.13 to i64
  %arrayidx74.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.13
  %358 = load float, float* %arrayidx74.13, align 4
  br label %if.end118.13

if.then43.13:                                     ; preds = %lor.lhs.false36.13, %if.else20.13
  %359 = trunc i64 %indvars.iv.13 to i32
  %add46.13 = add i32 %add45.13, %359
  %idxprom47.13 = sext i32 %add46.13 to i64
  %arrayidx48.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.13
  %360 = load float, float* %arrayidx48.13, align 4
  %361 = trunc i64 %indvars.iv.13 to i32
  %add51.13 = add i32 %sub50.13, %361
  %idxprom52.13 = sext i32 %add51.13 to i64
  %arrayidx53.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.13
  %362 = load float, float* %arrayidx53.13, align 4
  br label %if.end118.13

if.end118.13:                                     ; preds = %if.then43.13, %if.then62.13, %if.then83.13, %if.then102.13, %if.else94.13
  %q.3.13 = phi float [ %360, %if.then43.13 ], [ %357, %if.then62.13 ], [ %353, %if.then83.13 ], [ %350, %if.then102.13 ], [ 2.550000e+02, %if.else94.13 ]
  %r.3.13 = phi float [ %362, %if.then43.13 ], [ %358, %if.then62.13 ], [ %355, %if.then83.13 ], [ %351, %if.then102.13 ], [ 2.550000e+02, %if.else94.13 ]
  %arrayidx120.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %347
  %363 = load float, float* %arrayidx120.13, align 4
  %cmp121.13 = fcmp ult float %363, %q.3.13
  %cmp126.13 = fcmp ult float %363, %r.3.13
  %or.cond8.13 = or i1 %cmp121.13, %cmp126.13
  br i1 %or.cond8.13, label %if.else134.13, label %if.then128.13

if.then128.13:                                    ; preds = %if.end118.13
  %conv131.13 = fptoui float %363 to i32
  %arrayidx133.13 = getelementptr inbounds i32, i32* %., i64 %347
  store i32 %conv131.13, i32* %arrayidx133.13, align 4
  br label %for.inc.13

if.else134.13:                                    ; preds = %if.end118.13
  %arrayidx136.13 = getelementptr inbounds i32, i32* %., i64 %347
  store i32 0, i32* %arrayidx136.13, align 4
  br label %for.inc.13

if.then19.13:                                     ; preds = %for.body8.13
  %arrayidx.13 = getelementptr inbounds i32, i32* %., i64 %347
  store i32 0, i32* %arrayidx.13, align 4
  br label %for.inc.13

for.inc.13:                                       ; preds = %if.then19.13, %if.else134.13, %if.then128.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %img_width
  br i1 %exitcond.13, label %for.inc139.13, label %for.body8.13, !llvm.loop !1

for.inc139.13:                                    ; preds = %for.inc.13
  %indvars.iv.next20.13 = add nsw i64 %indvars.iv19, 14
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.14

for.body8.lr.ph.14:                               ; preds = %for.inc139.13
  %364 = trunc i64 %indvars.iv.next20.13 to i32
  %mul.14 = shl nsw i32 %364, 7
  %cmp11.14 = icmp eq i64 %indvars.iv.next20.13, %1
  %add45.14 = or i32 %mul.14, 1
  %sub50.14 = add i32 %mul.14, -1
  %365 = trunc i64 %indvars.iv.next20.13 to i32
  %add63.14 = shl i32 %365, 7
  %366 = trunc i64 %indvars.iv.next20.13 to i32
  %add84.14 = shl i32 %366, 7
  %mul85.14 = add i32 %add84.14, 128
  %mul90.14 = add i32 %add84.14, -128
  %367 = trunc i64 %indvars.iv.next20.13 to i32
  %sub103.14 = shl i32 %367, 7
  %368 = sext i32 %mul.14 to i64
  %369 = sext i32 %mul90.14 to i64
  %370 = sext i32 %mul85.14 to i64
  br label %for.body8.14

for.body8.14:                                     ; preds = %for.inc.14, %for.body8.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body8.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc.14 ]
  %371 = add nsw i64 %indvars.iv.14, %368
  %cmp14.14 = icmp eq i64 %indvars.iv.14, 0
  %or.cond1.14 = or i1 %cmp11.14, %cmp14.14
  %cmp17.14 = icmp eq i64 %indvars.iv.14, %0
  %or.cond2.14 = or i1 %cmp17.14, %or.cond1.14
  br i1 %or.cond2.14, label %if.then19.14, label %if.else20.14

if.else20.14:                                     ; preds = %for.body8.14
  %arrayidx22.14 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %371
  %372 = load float, float* %arrayidx22.14, align 4
  %conv23.14 = fpext float %372 to double
  %mul24.14 = fmul double %conv23.14, 0x404CA5DC1A63C1F8
  %conv25.14 = fptrunc double %mul24.14 to float
  %cmp26.14 = fcmp olt float %conv25.14, 0.000000e+00
  %add29.14 = fadd float %conv25.14, 1.800000e+02
  %angle.0.14 = select i1 %cmp26.14, float %add29.14, float %conv25.14
  %cmp31.14 = fcmp oge float %angle.0.14, 0.000000e+00
  %cmp34.14 = fcmp olt float %angle.0.14, 2.250000e+01
  %or.cond3.14 = and i1 %cmp31.14, %cmp34.14
  br i1 %or.cond3.14, label %if.then43.14, label %lor.lhs.false36.14

lor.lhs.false36.14:                               ; preds = %if.else20.14
  %cmp38.14 = fcmp ult float %angle.0.14, 1.575000e+02
  %cmp41.14 = fcmp ugt float %angle.0.14, 1.800000e+02
  %or.cond4.14 = or i1 %cmp38.14, %cmp41.14
  br i1 %or.cond4.14, label %if.else54.14, label %if.then43.14

if.else54.14:                                     ; preds = %lor.lhs.false36.14
  %cmp56.14 = fcmp oge float %angle.0.14, 2.250000e+01
  %cmp60.14 = fcmp olt float %angle.0.14, 6.750000e+01
  %or.cond5.14 = and i1 %cmp56.14, %cmp60.14
  br i1 %or.cond5.14, label %if.then62.14, label %if.else75.14

if.else75.14:                                     ; preds = %if.else54.14
  %cmp77.14 = fcmp oge float %angle.0.14, 6.750000e+01
  %cmp81.14 = fcmp olt float %angle.0.14, 1.125000e+02
  %or.cond6.14 = and i1 %cmp77.14, %cmp81.14
  br i1 %or.cond6.14, label %if.then83.14, label %if.else94.14

if.else94.14:                                     ; preds = %if.else75.14
  %cmp96.14 = fcmp oge float %angle.0.14, 1.125000e+02
  %cmp100.14 = fcmp olt float %angle.0.14, 1.575000e+02
  %or.cond7.14 = and i1 %cmp96.14, %cmp100.14
  br i1 %or.cond7.14, label %if.then102.14, label %if.end118.14

if.then102.14:                                    ; preds = %if.else94.14
  %373 = trunc i64 %indvars.iv.14 to i32
  %sub105.14 = add i32 %373, %sub103.14
  %add106.14 = add i32 %sub105.14, -129
  %idxprom107.14 = sext i32 %add106.14 to i64
  %arrayidx108.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.14
  %374 = load float, float* %arrayidx108.14, align 4
  %add112.14 = add i32 %sub105.14, 129
  %idxprom113.14 = sext i32 %add112.14 to i64
  %arrayidx114.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.14
  %375 = load float, float* %arrayidx114.14, align 4
  br label %if.end118.14

if.then83.14:                                     ; preds = %if.else75.14
  %376 = add nsw i64 %370, %indvars.iv.14
  %arrayidx88.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %376
  %377 = load float, float* %arrayidx88.14, align 4
  %378 = add nsw i64 %369, %indvars.iv.14
  %arrayidx93.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %378
  %379 = load float, float* %arrayidx93.14, align 4
  br label %if.end118.14

if.then62.14:                                     ; preds = %if.else54.14
  %380 = trunc i64 %indvars.iv.14 to i32
  %sub65.14 = add i32 %380, %add63.14
  %add66.14 = add i32 %sub65.14, 127
  %idxprom67.14 = sext i32 %add66.14 to i64
  %arrayidx68.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.14
  %381 = load float, float* %arrayidx68.14, align 4
  %add72.14 = add i32 %sub65.14, -127
  %idxprom73.14 = sext i32 %add72.14 to i64
  %arrayidx74.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.14
  %382 = load float, float* %arrayidx74.14, align 4
  br label %if.end118.14

if.then43.14:                                     ; preds = %lor.lhs.false36.14, %if.else20.14
  %383 = trunc i64 %indvars.iv.14 to i32
  %add46.14 = add i32 %add45.14, %383
  %idxprom47.14 = sext i32 %add46.14 to i64
  %arrayidx48.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.14
  %384 = load float, float* %arrayidx48.14, align 4
  %385 = trunc i64 %indvars.iv.14 to i32
  %add51.14 = add i32 %sub50.14, %385
  %idxprom52.14 = sext i32 %add51.14 to i64
  %arrayidx53.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.14
  %386 = load float, float* %arrayidx53.14, align 4
  br label %if.end118.14

if.end118.14:                                     ; preds = %if.then43.14, %if.then62.14, %if.then83.14, %if.then102.14, %if.else94.14
  %q.3.14 = phi float [ %384, %if.then43.14 ], [ %381, %if.then62.14 ], [ %377, %if.then83.14 ], [ %374, %if.then102.14 ], [ 2.550000e+02, %if.else94.14 ]
  %r.3.14 = phi float [ %386, %if.then43.14 ], [ %382, %if.then62.14 ], [ %379, %if.then83.14 ], [ %375, %if.then102.14 ], [ 2.550000e+02, %if.else94.14 ]
  %arrayidx120.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %371
  %387 = load float, float* %arrayidx120.14, align 4
  %cmp121.14 = fcmp ult float %387, %q.3.14
  %cmp126.14 = fcmp ult float %387, %r.3.14
  %or.cond8.14 = or i1 %cmp121.14, %cmp126.14
  br i1 %or.cond8.14, label %if.else134.14, label %if.then128.14

if.then128.14:                                    ; preds = %if.end118.14
  %conv131.14 = fptoui float %387 to i32
  %arrayidx133.14 = getelementptr inbounds i32, i32* %., i64 %371
  store i32 %conv131.14, i32* %arrayidx133.14, align 4
  br label %for.inc.14

if.else134.14:                                    ; preds = %if.end118.14
  %arrayidx136.14 = getelementptr inbounds i32, i32* %., i64 %371
  store i32 0, i32* %arrayidx136.14, align 4
  br label %for.inc.14

if.then19.14:                                     ; preds = %for.body8.14
  %arrayidx.14 = getelementptr inbounds i32, i32* %., i64 %371
  store i32 0, i32* %arrayidx.14, align 4
  br label %for.inc.14

for.inc.14:                                       ; preds = %if.then19.14, %if.else134.14, %if.then128.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %img_width
  br i1 %exitcond.14, label %for.inc139.14, label %for.body8.14, !llvm.loop !1

for.inc139.14:                                    ; preds = %for.inc.14
  %indvars.iv.next20.14 = add nsw i64 %indvars.iv19, 15
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.15

for.body8.lr.ph.15:                               ; preds = %for.inc139.14
  %388 = trunc i64 %indvars.iv.next20.14 to i32
  %mul.15 = shl nsw i32 %388, 7
  %cmp11.15 = icmp eq i64 %indvars.iv.next20.14, %1
  %add45.15 = or i32 %mul.15, 1
  %sub50.15 = add i32 %mul.15, -1
  %389 = trunc i64 %indvars.iv.next20.14 to i32
  %add63.15 = shl i32 %389, 7
  %390 = trunc i64 %indvars.iv.next20.14 to i32
  %add84.15 = shl i32 %390, 7
  %mul85.15 = add i32 %add84.15, 128
  %mul90.15 = add i32 %add84.15, -128
  %391 = trunc i64 %indvars.iv.next20.14 to i32
  %sub103.15 = shl i32 %391, 7
  %392 = sext i32 %mul.15 to i64
  %393 = sext i32 %mul90.15 to i64
  %394 = sext i32 %mul85.15 to i64
  br label %for.body8.15

for.body8.15:                                     ; preds = %for.inc.15, %for.body8.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body8.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc.15 ]
  %395 = add nsw i64 %indvars.iv.15, %392
  %cmp14.15 = icmp eq i64 %indvars.iv.15, 0
  %or.cond1.15 = or i1 %cmp11.15, %cmp14.15
  %cmp17.15 = icmp eq i64 %indvars.iv.15, %0
  %or.cond2.15 = or i1 %cmp17.15, %or.cond1.15
  br i1 %or.cond2.15, label %if.then19.15, label %if.else20.15

if.else20.15:                                     ; preds = %for.body8.15
  %arrayidx22.15 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %395
  %396 = load float, float* %arrayidx22.15, align 4
  %conv23.15 = fpext float %396 to double
  %mul24.15 = fmul double %conv23.15, 0x404CA5DC1A63C1F8
  %conv25.15 = fptrunc double %mul24.15 to float
  %cmp26.15 = fcmp olt float %conv25.15, 0.000000e+00
  %add29.15 = fadd float %conv25.15, 1.800000e+02
  %angle.0.15 = select i1 %cmp26.15, float %add29.15, float %conv25.15
  %cmp31.15 = fcmp oge float %angle.0.15, 0.000000e+00
  %cmp34.15 = fcmp olt float %angle.0.15, 2.250000e+01
  %or.cond3.15 = and i1 %cmp31.15, %cmp34.15
  br i1 %or.cond3.15, label %if.then43.15, label %lor.lhs.false36.15

lor.lhs.false36.15:                               ; preds = %if.else20.15
  %cmp38.15 = fcmp ult float %angle.0.15, 1.575000e+02
  %cmp41.15 = fcmp ugt float %angle.0.15, 1.800000e+02
  %or.cond4.15 = or i1 %cmp38.15, %cmp41.15
  br i1 %or.cond4.15, label %if.else54.15, label %if.then43.15

if.else54.15:                                     ; preds = %lor.lhs.false36.15
  %cmp56.15 = fcmp oge float %angle.0.15, 2.250000e+01
  %cmp60.15 = fcmp olt float %angle.0.15, 6.750000e+01
  %or.cond5.15 = and i1 %cmp56.15, %cmp60.15
  br i1 %or.cond5.15, label %if.then62.15, label %if.else75.15

if.else75.15:                                     ; preds = %if.else54.15
  %cmp77.15 = fcmp oge float %angle.0.15, 6.750000e+01
  %cmp81.15 = fcmp olt float %angle.0.15, 1.125000e+02
  %or.cond6.15 = and i1 %cmp77.15, %cmp81.15
  br i1 %or.cond6.15, label %if.then83.15, label %if.else94.15

if.else94.15:                                     ; preds = %if.else75.15
  %cmp96.15 = fcmp oge float %angle.0.15, 1.125000e+02
  %cmp100.15 = fcmp olt float %angle.0.15, 1.575000e+02
  %or.cond7.15 = and i1 %cmp96.15, %cmp100.15
  br i1 %or.cond7.15, label %if.then102.15, label %if.end118.15

if.then102.15:                                    ; preds = %if.else94.15
  %397 = trunc i64 %indvars.iv.15 to i32
  %sub105.15 = add i32 %397, %sub103.15
  %add106.15 = add i32 %sub105.15, -129
  %idxprom107.15 = sext i32 %add106.15 to i64
  %arrayidx108.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.15
  %398 = load float, float* %arrayidx108.15, align 4
  %add112.15 = add i32 %sub105.15, 129
  %idxprom113.15 = sext i32 %add112.15 to i64
  %arrayidx114.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.15
  %399 = load float, float* %arrayidx114.15, align 4
  br label %if.end118.15

if.then83.15:                                     ; preds = %if.else75.15
  %400 = add nsw i64 %394, %indvars.iv.15
  %arrayidx88.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %400
  %401 = load float, float* %arrayidx88.15, align 4
  %402 = add nsw i64 %393, %indvars.iv.15
  %arrayidx93.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %402
  %403 = load float, float* %arrayidx93.15, align 4
  br label %if.end118.15

if.then62.15:                                     ; preds = %if.else54.15
  %404 = trunc i64 %indvars.iv.15 to i32
  %sub65.15 = add i32 %404, %add63.15
  %add66.15 = add i32 %sub65.15, 127
  %idxprom67.15 = sext i32 %add66.15 to i64
  %arrayidx68.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.15
  %405 = load float, float* %arrayidx68.15, align 4
  %add72.15 = add i32 %sub65.15, -127
  %idxprom73.15 = sext i32 %add72.15 to i64
  %arrayidx74.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.15
  %406 = load float, float* %arrayidx74.15, align 4
  br label %if.end118.15

if.then43.15:                                     ; preds = %lor.lhs.false36.15, %if.else20.15
  %407 = trunc i64 %indvars.iv.15 to i32
  %add46.15 = add i32 %add45.15, %407
  %idxprom47.15 = sext i32 %add46.15 to i64
  %arrayidx48.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.15
  %408 = load float, float* %arrayidx48.15, align 4
  %409 = trunc i64 %indvars.iv.15 to i32
  %add51.15 = add i32 %sub50.15, %409
  %idxprom52.15 = sext i32 %add51.15 to i64
  %arrayidx53.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.15
  %410 = load float, float* %arrayidx53.15, align 4
  br label %if.end118.15

if.end118.15:                                     ; preds = %if.then43.15, %if.then62.15, %if.then83.15, %if.then102.15, %if.else94.15
  %q.3.15 = phi float [ %408, %if.then43.15 ], [ %405, %if.then62.15 ], [ %401, %if.then83.15 ], [ %398, %if.then102.15 ], [ 2.550000e+02, %if.else94.15 ]
  %r.3.15 = phi float [ %410, %if.then43.15 ], [ %406, %if.then62.15 ], [ %403, %if.then83.15 ], [ %399, %if.then102.15 ], [ 2.550000e+02, %if.else94.15 ]
  %arrayidx120.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %395
  %411 = load float, float* %arrayidx120.15, align 4
  %cmp121.15 = fcmp ult float %411, %q.3.15
  %cmp126.15 = fcmp ult float %411, %r.3.15
  %or.cond8.15 = or i1 %cmp121.15, %cmp126.15
  br i1 %or.cond8.15, label %if.else134.15, label %if.then128.15

if.then128.15:                                    ; preds = %if.end118.15
  %conv131.15 = fptoui float %411 to i32
  %arrayidx133.15 = getelementptr inbounds i32, i32* %., i64 %395
  store i32 %conv131.15, i32* %arrayidx133.15, align 4
  br label %for.inc.15

if.else134.15:                                    ; preds = %if.end118.15
  %arrayidx136.15 = getelementptr inbounds i32, i32* %., i64 %395
  store i32 0, i32* %arrayidx136.15, align 4
  br label %for.inc.15

if.then19.15:                                     ; preds = %for.body8.15
  %arrayidx.15 = getelementptr inbounds i32, i32* %., i64 %395
  store i32 0, i32* %arrayidx.15, align 4
  br label %for.inc.15

for.inc.15:                                       ; preds = %if.then19.15, %if.else134.15, %if.then128.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %img_width
  br i1 %exitcond.15, label %for.inc139.15, label %for.body8.15, !llvm.loop !1

for.inc139.15:                                    ; preds = %for.inc.15
  %indvars.iv.next20.15 = add nsw i64 %indvars.iv19, 16
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.16

for.body8.lr.ph.16:                               ; preds = %for.inc139.15
  %412 = trunc i64 %indvars.iv.next20.15 to i32
  %mul.16 = shl nsw i32 %412, 7
  %cmp11.16 = icmp eq i64 %indvars.iv.next20.15, %1
  %add45.16 = or i32 %mul.16, 1
  %sub50.16 = add i32 %mul.16, -1
  %413 = trunc i64 %indvars.iv.next20.15 to i32
  %add63.16 = shl i32 %413, 7
  %414 = trunc i64 %indvars.iv.next20.15 to i32
  %add84.16 = shl i32 %414, 7
  %mul85.16 = add i32 %add84.16, 128
  %mul90.16 = add i32 %add84.16, -128
  %415 = trunc i64 %indvars.iv.next20.15 to i32
  %sub103.16 = shl i32 %415, 7
  %416 = sext i32 %mul.16 to i64
  %417 = sext i32 %mul90.16 to i64
  %418 = sext i32 %mul85.16 to i64
  br label %for.body8.16

for.body8.16:                                     ; preds = %for.inc.16, %for.body8.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body8.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc.16 ]
  %419 = add nsw i64 %indvars.iv.16, %416
  %cmp14.16 = icmp eq i64 %indvars.iv.16, 0
  %or.cond1.16 = or i1 %cmp11.16, %cmp14.16
  %cmp17.16 = icmp eq i64 %indvars.iv.16, %0
  %or.cond2.16 = or i1 %cmp17.16, %or.cond1.16
  br i1 %or.cond2.16, label %if.then19.16, label %if.else20.16

if.else20.16:                                     ; preds = %for.body8.16
  %arrayidx22.16 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %419
  %420 = load float, float* %arrayidx22.16, align 4
  %conv23.16 = fpext float %420 to double
  %mul24.16 = fmul double %conv23.16, 0x404CA5DC1A63C1F8
  %conv25.16 = fptrunc double %mul24.16 to float
  %cmp26.16 = fcmp olt float %conv25.16, 0.000000e+00
  %add29.16 = fadd float %conv25.16, 1.800000e+02
  %angle.0.16 = select i1 %cmp26.16, float %add29.16, float %conv25.16
  %cmp31.16 = fcmp oge float %angle.0.16, 0.000000e+00
  %cmp34.16 = fcmp olt float %angle.0.16, 2.250000e+01
  %or.cond3.16 = and i1 %cmp31.16, %cmp34.16
  br i1 %or.cond3.16, label %if.then43.16, label %lor.lhs.false36.16

lor.lhs.false36.16:                               ; preds = %if.else20.16
  %cmp38.16 = fcmp ult float %angle.0.16, 1.575000e+02
  %cmp41.16 = fcmp ugt float %angle.0.16, 1.800000e+02
  %or.cond4.16 = or i1 %cmp38.16, %cmp41.16
  br i1 %or.cond4.16, label %if.else54.16, label %if.then43.16

if.else54.16:                                     ; preds = %lor.lhs.false36.16
  %cmp56.16 = fcmp oge float %angle.0.16, 2.250000e+01
  %cmp60.16 = fcmp olt float %angle.0.16, 6.750000e+01
  %or.cond5.16 = and i1 %cmp56.16, %cmp60.16
  br i1 %or.cond5.16, label %if.then62.16, label %if.else75.16

if.else75.16:                                     ; preds = %if.else54.16
  %cmp77.16 = fcmp oge float %angle.0.16, 6.750000e+01
  %cmp81.16 = fcmp olt float %angle.0.16, 1.125000e+02
  %or.cond6.16 = and i1 %cmp77.16, %cmp81.16
  br i1 %or.cond6.16, label %if.then83.16, label %if.else94.16

if.else94.16:                                     ; preds = %if.else75.16
  %cmp96.16 = fcmp oge float %angle.0.16, 1.125000e+02
  %cmp100.16 = fcmp olt float %angle.0.16, 1.575000e+02
  %or.cond7.16 = and i1 %cmp96.16, %cmp100.16
  br i1 %or.cond7.16, label %if.then102.16, label %if.end118.16

if.then102.16:                                    ; preds = %if.else94.16
  %421 = trunc i64 %indvars.iv.16 to i32
  %sub105.16 = add i32 %421, %sub103.16
  %add106.16 = add i32 %sub105.16, -129
  %idxprom107.16 = sext i32 %add106.16 to i64
  %arrayidx108.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.16
  %422 = load float, float* %arrayidx108.16, align 4
  %add112.16 = add i32 %sub105.16, 129
  %idxprom113.16 = sext i32 %add112.16 to i64
  %arrayidx114.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.16
  %423 = load float, float* %arrayidx114.16, align 4
  br label %if.end118.16

if.then83.16:                                     ; preds = %if.else75.16
  %424 = add nsw i64 %418, %indvars.iv.16
  %arrayidx88.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %424
  %425 = load float, float* %arrayidx88.16, align 4
  %426 = add nsw i64 %417, %indvars.iv.16
  %arrayidx93.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %426
  %427 = load float, float* %arrayidx93.16, align 4
  br label %if.end118.16

if.then62.16:                                     ; preds = %if.else54.16
  %428 = trunc i64 %indvars.iv.16 to i32
  %sub65.16 = add i32 %428, %add63.16
  %add66.16 = add i32 %sub65.16, 127
  %idxprom67.16 = sext i32 %add66.16 to i64
  %arrayidx68.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.16
  %429 = load float, float* %arrayidx68.16, align 4
  %add72.16 = add i32 %sub65.16, -127
  %idxprom73.16 = sext i32 %add72.16 to i64
  %arrayidx74.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.16
  %430 = load float, float* %arrayidx74.16, align 4
  br label %if.end118.16

if.then43.16:                                     ; preds = %lor.lhs.false36.16, %if.else20.16
  %431 = trunc i64 %indvars.iv.16 to i32
  %add46.16 = add i32 %add45.16, %431
  %idxprom47.16 = sext i32 %add46.16 to i64
  %arrayidx48.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.16
  %432 = load float, float* %arrayidx48.16, align 4
  %433 = trunc i64 %indvars.iv.16 to i32
  %add51.16 = add i32 %sub50.16, %433
  %idxprom52.16 = sext i32 %add51.16 to i64
  %arrayidx53.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.16
  %434 = load float, float* %arrayidx53.16, align 4
  br label %if.end118.16

if.end118.16:                                     ; preds = %if.then43.16, %if.then62.16, %if.then83.16, %if.then102.16, %if.else94.16
  %q.3.16 = phi float [ %432, %if.then43.16 ], [ %429, %if.then62.16 ], [ %425, %if.then83.16 ], [ %422, %if.then102.16 ], [ 2.550000e+02, %if.else94.16 ]
  %r.3.16 = phi float [ %434, %if.then43.16 ], [ %430, %if.then62.16 ], [ %427, %if.then83.16 ], [ %423, %if.then102.16 ], [ 2.550000e+02, %if.else94.16 ]
  %arrayidx120.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %419
  %435 = load float, float* %arrayidx120.16, align 4
  %cmp121.16 = fcmp ult float %435, %q.3.16
  %cmp126.16 = fcmp ult float %435, %r.3.16
  %or.cond8.16 = or i1 %cmp121.16, %cmp126.16
  br i1 %or.cond8.16, label %if.else134.16, label %if.then128.16

if.then128.16:                                    ; preds = %if.end118.16
  %conv131.16 = fptoui float %435 to i32
  %arrayidx133.16 = getelementptr inbounds i32, i32* %., i64 %419
  store i32 %conv131.16, i32* %arrayidx133.16, align 4
  br label %for.inc.16

if.else134.16:                                    ; preds = %if.end118.16
  %arrayidx136.16 = getelementptr inbounds i32, i32* %., i64 %419
  store i32 0, i32* %arrayidx136.16, align 4
  br label %for.inc.16

if.then19.16:                                     ; preds = %for.body8.16
  %arrayidx.16 = getelementptr inbounds i32, i32* %., i64 %419
  store i32 0, i32* %arrayidx.16, align 4
  br label %for.inc.16

for.inc.16:                                       ; preds = %if.then19.16, %if.else134.16, %if.then128.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %img_width
  br i1 %exitcond.16, label %for.inc139.16, label %for.body8.16, !llvm.loop !1

for.inc139.16:                                    ; preds = %for.inc.16
  %indvars.iv.next20.16 = add nsw i64 %indvars.iv19, 17
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.17

for.body8.lr.ph.17:                               ; preds = %for.inc139.16
  %436 = trunc i64 %indvars.iv.next20.16 to i32
  %mul.17 = shl nsw i32 %436, 7
  %cmp11.17 = icmp eq i64 %indvars.iv.next20.16, %1
  %add45.17 = or i32 %mul.17, 1
  %sub50.17 = add i32 %mul.17, -1
  %437 = trunc i64 %indvars.iv.next20.16 to i32
  %add63.17 = shl i32 %437, 7
  %438 = trunc i64 %indvars.iv.next20.16 to i32
  %add84.17 = shl i32 %438, 7
  %mul85.17 = add i32 %add84.17, 128
  %mul90.17 = add i32 %add84.17, -128
  %439 = trunc i64 %indvars.iv.next20.16 to i32
  %sub103.17 = shl i32 %439, 7
  %440 = sext i32 %mul.17 to i64
  %441 = sext i32 %mul90.17 to i64
  %442 = sext i32 %mul85.17 to i64
  br label %for.body8.17

for.body8.17:                                     ; preds = %for.inc.17, %for.body8.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body8.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc.17 ]
  %443 = add nsw i64 %indvars.iv.17, %440
  %cmp14.17 = icmp eq i64 %indvars.iv.17, 0
  %or.cond1.17 = or i1 %cmp11.17, %cmp14.17
  %cmp17.17 = icmp eq i64 %indvars.iv.17, %0
  %or.cond2.17 = or i1 %cmp17.17, %or.cond1.17
  br i1 %or.cond2.17, label %if.then19.17, label %if.else20.17

if.else20.17:                                     ; preds = %for.body8.17
  %arrayidx22.17 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %443
  %444 = load float, float* %arrayidx22.17, align 4
  %conv23.17 = fpext float %444 to double
  %mul24.17 = fmul double %conv23.17, 0x404CA5DC1A63C1F8
  %conv25.17 = fptrunc double %mul24.17 to float
  %cmp26.17 = fcmp olt float %conv25.17, 0.000000e+00
  %add29.17 = fadd float %conv25.17, 1.800000e+02
  %angle.0.17 = select i1 %cmp26.17, float %add29.17, float %conv25.17
  %cmp31.17 = fcmp oge float %angle.0.17, 0.000000e+00
  %cmp34.17 = fcmp olt float %angle.0.17, 2.250000e+01
  %or.cond3.17 = and i1 %cmp31.17, %cmp34.17
  br i1 %or.cond3.17, label %if.then43.17, label %lor.lhs.false36.17

lor.lhs.false36.17:                               ; preds = %if.else20.17
  %cmp38.17 = fcmp ult float %angle.0.17, 1.575000e+02
  %cmp41.17 = fcmp ugt float %angle.0.17, 1.800000e+02
  %or.cond4.17 = or i1 %cmp38.17, %cmp41.17
  br i1 %or.cond4.17, label %if.else54.17, label %if.then43.17

if.else54.17:                                     ; preds = %lor.lhs.false36.17
  %cmp56.17 = fcmp oge float %angle.0.17, 2.250000e+01
  %cmp60.17 = fcmp olt float %angle.0.17, 6.750000e+01
  %or.cond5.17 = and i1 %cmp56.17, %cmp60.17
  br i1 %or.cond5.17, label %if.then62.17, label %if.else75.17

if.else75.17:                                     ; preds = %if.else54.17
  %cmp77.17 = fcmp oge float %angle.0.17, 6.750000e+01
  %cmp81.17 = fcmp olt float %angle.0.17, 1.125000e+02
  %or.cond6.17 = and i1 %cmp77.17, %cmp81.17
  br i1 %or.cond6.17, label %if.then83.17, label %if.else94.17

if.else94.17:                                     ; preds = %if.else75.17
  %cmp96.17 = fcmp oge float %angle.0.17, 1.125000e+02
  %cmp100.17 = fcmp olt float %angle.0.17, 1.575000e+02
  %or.cond7.17 = and i1 %cmp96.17, %cmp100.17
  br i1 %or.cond7.17, label %if.then102.17, label %if.end118.17

if.then102.17:                                    ; preds = %if.else94.17
  %445 = trunc i64 %indvars.iv.17 to i32
  %sub105.17 = add i32 %445, %sub103.17
  %add106.17 = add i32 %sub105.17, -129
  %idxprom107.17 = sext i32 %add106.17 to i64
  %arrayidx108.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.17
  %446 = load float, float* %arrayidx108.17, align 4
  %add112.17 = add i32 %sub105.17, 129
  %idxprom113.17 = sext i32 %add112.17 to i64
  %arrayidx114.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.17
  %447 = load float, float* %arrayidx114.17, align 4
  br label %if.end118.17

if.then83.17:                                     ; preds = %if.else75.17
  %448 = add nsw i64 %442, %indvars.iv.17
  %arrayidx88.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %448
  %449 = load float, float* %arrayidx88.17, align 4
  %450 = add nsw i64 %441, %indvars.iv.17
  %arrayidx93.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %450
  %451 = load float, float* %arrayidx93.17, align 4
  br label %if.end118.17

if.then62.17:                                     ; preds = %if.else54.17
  %452 = trunc i64 %indvars.iv.17 to i32
  %sub65.17 = add i32 %452, %add63.17
  %add66.17 = add i32 %sub65.17, 127
  %idxprom67.17 = sext i32 %add66.17 to i64
  %arrayidx68.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.17
  %453 = load float, float* %arrayidx68.17, align 4
  %add72.17 = add i32 %sub65.17, -127
  %idxprom73.17 = sext i32 %add72.17 to i64
  %arrayidx74.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.17
  %454 = load float, float* %arrayidx74.17, align 4
  br label %if.end118.17

if.then43.17:                                     ; preds = %lor.lhs.false36.17, %if.else20.17
  %455 = trunc i64 %indvars.iv.17 to i32
  %add46.17 = add i32 %add45.17, %455
  %idxprom47.17 = sext i32 %add46.17 to i64
  %arrayidx48.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.17
  %456 = load float, float* %arrayidx48.17, align 4
  %457 = trunc i64 %indvars.iv.17 to i32
  %add51.17 = add i32 %sub50.17, %457
  %idxprom52.17 = sext i32 %add51.17 to i64
  %arrayidx53.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.17
  %458 = load float, float* %arrayidx53.17, align 4
  br label %if.end118.17

if.end118.17:                                     ; preds = %if.then43.17, %if.then62.17, %if.then83.17, %if.then102.17, %if.else94.17
  %q.3.17 = phi float [ %456, %if.then43.17 ], [ %453, %if.then62.17 ], [ %449, %if.then83.17 ], [ %446, %if.then102.17 ], [ 2.550000e+02, %if.else94.17 ]
  %r.3.17 = phi float [ %458, %if.then43.17 ], [ %454, %if.then62.17 ], [ %451, %if.then83.17 ], [ %447, %if.then102.17 ], [ 2.550000e+02, %if.else94.17 ]
  %arrayidx120.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %443
  %459 = load float, float* %arrayidx120.17, align 4
  %cmp121.17 = fcmp ult float %459, %q.3.17
  %cmp126.17 = fcmp ult float %459, %r.3.17
  %or.cond8.17 = or i1 %cmp121.17, %cmp126.17
  br i1 %or.cond8.17, label %if.else134.17, label %if.then128.17

if.then128.17:                                    ; preds = %if.end118.17
  %conv131.17 = fptoui float %459 to i32
  %arrayidx133.17 = getelementptr inbounds i32, i32* %., i64 %443
  store i32 %conv131.17, i32* %arrayidx133.17, align 4
  br label %for.inc.17

if.else134.17:                                    ; preds = %if.end118.17
  %arrayidx136.17 = getelementptr inbounds i32, i32* %., i64 %443
  store i32 0, i32* %arrayidx136.17, align 4
  br label %for.inc.17

if.then19.17:                                     ; preds = %for.body8.17
  %arrayidx.17 = getelementptr inbounds i32, i32* %., i64 %443
  store i32 0, i32* %arrayidx.17, align 4
  br label %for.inc.17

for.inc.17:                                       ; preds = %if.then19.17, %if.else134.17, %if.then128.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %img_width
  br i1 %exitcond.17, label %for.inc139.17, label %for.body8.17, !llvm.loop !1

for.inc139.17:                                    ; preds = %for.inc.17
  %indvars.iv.next20.17 = add nsw i64 %indvars.iv19, 18
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.18

for.body8.lr.ph.18:                               ; preds = %for.inc139.17
  %460 = trunc i64 %indvars.iv.next20.17 to i32
  %mul.18 = shl nsw i32 %460, 7
  %cmp11.18 = icmp eq i64 %indvars.iv.next20.17, %1
  %add45.18 = or i32 %mul.18, 1
  %sub50.18 = add i32 %mul.18, -1
  %461 = trunc i64 %indvars.iv.next20.17 to i32
  %add63.18 = shl i32 %461, 7
  %462 = trunc i64 %indvars.iv.next20.17 to i32
  %add84.18 = shl i32 %462, 7
  %mul85.18 = add i32 %add84.18, 128
  %mul90.18 = add i32 %add84.18, -128
  %463 = trunc i64 %indvars.iv.next20.17 to i32
  %sub103.18 = shl i32 %463, 7
  %464 = sext i32 %mul.18 to i64
  %465 = sext i32 %mul90.18 to i64
  %466 = sext i32 %mul85.18 to i64
  br label %for.body8.18

for.body8.18:                                     ; preds = %for.inc.18, %for.body8.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body8.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc.18 ]
  %467 = add nsw i64 %indvars.iv.18, %464
  %cmp14.18 = icmp eq i64 %indvars.iv.18, 0
  %or.cond1.18 = or i1 %cmp11.18, %cmp14.18
  %cmp17.18 = icmp eq i64 %indvars.iv.18, %0
  %or.cond2.18 = or i1 %cmp17.18, %or.cond1.18
  br i1 %or.cond2.18, label %if.then19.18, label %if.else20.18

if.else20.18:                                     ; preds = %for.body8.18
  %arrayidx22.18 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %467
  %468 = load float, float* %arrayidx22.18, align 4
  %conv23.18 = fpext float %468 to double
  %mul24.18 = fmul double %conv23.18, 0x404CA5DC1A63C1F8
  %conv25.18 = fptrunc double %mul24.18 to float
  %cmp26.18 = fcmp olt float %conv25.18, 0.000000e+00
  %add29.18 = fadd float %conv25.18, 1.800000e+02
  %angle.0.18 = select i1 %cmp26.18, float %add29.18, float %conv25.18
  %cmp31.18 = fcmp oge float %angle.0.18, 0.000000e+00
  %cmp34.18 = fcmp olt float %angle.0.18, 2.250000e+01
  %or.cond3.18 = and i1 %cmp31.18, %cmp34.18
  br i1 %or.cond3.18, label %if.then43.18, label %lor.lhs.false36.18

lor.lhs.false36.18:                               ; preds = %if.else20.18
  %cmp38.18 = fcmp ult float %angle.0.18, 1.575000e+02
  %cmp41.18 = fcmp ugt float %angle.0.18, 1.800000e+02
  %or.cond4.18 = or i1 %cmp38.18, %cmp41.18
  br i1 %or.cond4.18, label %if.else54.18, label %if.then43.18

if.else54.18:                                     ; preds = %lor.lhs.false36.18
  %cmp56.18 = fcmp oge float %angle.0.18, 2.250000e+01
  %cmp60.18 = fcmp olt float %angle.0.18, 6.750000e+01
  %or.cond5.18 = and i1 %cmp56.18, %cmp60.18
  br i1 %or.cond5.18, label %if.then62.18, label %if.else75.18

if.else75.18:                                     ; preds = %if.else54.18
  %cmp77.18 = fcmp oge float %angle.0.18, 6.750000e+01
  %cmp81.18 = fcmp olt float %angle.0.18, 1.125000e+02
  %or.cond6.18 = and i1 %cmp77.18, %cmp81.18
  br i1 %or.cond6.18, label %if.then83.18, label %if.else94.18

if.else94.18:                                     ; preds = %if.else75.18
  %cmp96.18 = fcmp oge float %angle.0.18, 1.125000e+02
  %cmp100.18 = fcmp olt float %angle.0.18, 1.575000e+02
  %or.cond7.18 = and i1 %cmp96.18, %cmp100.18
  br i1 %or.cond7.18, label %if.then102.18, label %if.end118.18

if.then102.18:                                    ; preds = %if.else94.18
  %469 = trunc i64 %indvars.iv.18 to i32
  %sub105.18 = add i32 %469, %sub103.18
  %add106.18 = add i32 %sub105.18, -129
  %idxprom107.18 = sext i32 %add106.18 to i64
  %arrayidx108.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.18
  %470 = load float, float* %arrayidx108.18, align 4
  %add112.18 = add i32 %sub105.18, 129
  %idxprom113.18 = sext i32 %add112.18 to i64
  %arrayidx114.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.18
  %471 = load float, float* %arrayidx114.18, align 4
  br label %if.end118.18

if.then83.18:                                     ; preds = %if.else75.18
  %472 = add nsw i64 %466, %indvars.iv.18
  %arrayidx88.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %472
  %473 = load float, float* %arrayidx88.18, align 4
  %474 = add nsw i64 %465, %indvars.iv.18
  %arrayidx93.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %474
  %475 = load float, float* %arrayidx93.18, align 4
  br label %if.end118.18

if.then62.18:                                     ; preds = %if.else54.18
  %476 = trunc i64 %indvars.iv.18 to i32
  %sub65.18 = add i32 %476, %add63.18
  %add66.18 = add i32 %sub65.18, 127
  %idxprom67.18 = sext i32 %add66.18 to i64
  %arrayidx68.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.18
  %477 = load float, float* %arrayidx68.18, align 4
  %add72.18 = add i32 %sub65.18, -127
  %idxprom73.18 = sext i32 %add72.18 to i64
  %arrayidx74.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.18
  %478 = load float, float* %arrayidx74.18, align 4
  br label %if.end118.18

if.then43.18:                                     ; preds = %lor.lhs.false36.18, %if.else20.18
  %479 = trunc i64 %indvars.iv.18 to i32
  %add46.18 = add i32 %add45.18, %479
  %idxprom47.18 = sext i32 %add46.18 to i64
  %arrayidx48.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.18
  %480 = load float, float* %arrayidx48.18, align 4
  %481 = trunc i64 %indvars.iv.18 to i32
  %add51.18 = add i32 %sub50.18, %481
  %idxprom52.18 = sext i32 %add51.18 to i64
  %arrayidx53.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.18
  %482 = load float, float* %arrayidx53.18, align 4
  br label %if.end118.18

if.end118.18:                                     ; preds = %if.then43.18, %if.then62.18, %if.then83.18, %if.then102.18, %if.else94.18
  %q.3.18 = phi float [ %480, %if.then43.18 ], [ %477, %if.then62.18 ], [ %473, %if.then83.18 ], [ %470, %if.then102.18 ], [ 2.550000e+02, %if.else94.18 ]
  %r.3.18 = phi float [ %482, %if.then43.18 ], [ %478, %if.then62.18 ], [ %475, %if.then83.18 ], [ %471, %if.then102.18 ], [ 2.550000e+02, %if.else94.18 ]
  %arrayidx120.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %467
  %483 = load float, float* %arrayidx120.18, align 4
  %cmp121.18 = fcmp ult float %483, %q.3.18
  %cmp126.18 = fcmp ult float %483, %r.3.18
  %or.cond8.18 = or i1 %cmp121.18, %cmp126.18
  br i1 %or.cond8.18, label %if.else134.18, label %if.then128.18

if.then128.18:                                    ; preds = %if.end118.18
  %conv131.18 = fptoui float %483 to i32
  %arrayidx133.18 = getelementptr inbounds i32, i32* %., i64 %467
  store i32 %conv131.18, i32* %arrayidx133.18, align 4
  br label %for.inc.18

if.else134.18:                                    ; preds = %if.end118.18
  %arrayidx136.18 = getelementptr inbounds i32, i32* %., i64 %467
  store i32 0, i32* %arrayidx136.18, align 4
  br label %for.inc.18

if.then19.18:                                     ; preds = %for.body8.18
  %arrayidx.18 = getelementptr inbounds i32, i32* %., i64 %467
  store i32 0, i32* %arrayidx.18, align 4
  br label %for.inc.18

for.inc.18:                                       ; preds = %if.then19.18, %if.else134.18, %if.then128.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %img_width
  br i1 %exitcond.18, label %for.inc139.18, label %for.body8.18, !llvm.loop !1

for.inc139.18:                                    ; preds = %for.inc.18
  %indvars.iv.next20.18 = add nsw i64 %indvars.iv19, 19
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.19

for.body8.lr.ph.19:                               ; preds = %for.inc139.18
  %484 = trunc i64 %indvars.iv.next20.18 to i32
  %mul.19 = shl nsw i32 %484, 7
  %cmp11.19 = icmp eq i64 %indvars.iv.next20.18, %1
  %add45.19 = or i32 %mul.19, 1
  %sub50.19 = add i32 %mul.19, -1
  %485 = trunc i64 %indvars.iv.next20.18 to i32
  %add63.19 = shl i32 %485, 7
  %486 = trunc i64 %indvars.iv.next20.18 to i32
  %add84.19 = shl i32 %486, 7
  %mul85.19 = add i32 %add84.19, 128
  %mul90.19 = add i32 %add84.19, -128
  %487 = trunc i64 %indvars.iv.next20.18 to i32
  %sub103.19 = shl i32 %487, 7
  %488 = sext i32 %mul.19 to i64
  %489 = sext i32 %mul90.19 to i64
  %490 = sext i32 %mul85.19 to i64
  br label %for.body8.19

for.body8.19:                                     ; preds = %for.inc.19, %for.body8.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body8.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc.19 ]
  %491 = add nsw i64 %indvars.iv.19, %488
  %cmp14.19 = icmp eq i64 %indvars.iv.19, 0
  %or.cond1.19 = or i1 %cmp11.19, %cmp14.19
  %cmp17.19 = icmp eq i64 %indvars.iv.19, %0
  %or.cond2.19 = or i1 %cmp17.19, %or.cond1.19
  br i1 %or.cond2.19, label %if.then19.19, label %if.else20.19

if.else20.19:                                     ; preds = %for.body8.19
  %arrayidx22.19 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %491
  %492 = load float, float* %arrayidx22.19, align 4
  %conv23.19 = fpext float %492 to double
  %mul24.19 = fmul double %conv23.19, 0x404CA5DC1A63C1F8
  %conv25.19 = fptrunc double %mul24.19 to float
  %cmp26.19 = fcmp olt float %conv25.19, 0.000000e+00
  %add29.19 = fadd float %conv25.19, 1.800000e+02
  %angle.0.19 = select i1 %cmp26.19, float %add29.19, float %conv25.19
  %cmp31.19 = fcmp oge float %angle.0.19, 0.000000e+00
  %cmp34.19 = fcmp olt float %angle.0.19, 2.250000e+01
  %or.cond3.19 = and i1 %cmp31.19, %cmp34.19
  br i1 %or.cond3.19, label %if.then43.19, label %lor.lhs.false36.19

lor.lhs.false36.19:                               ; preds = %if.else20.19
  %cmp38.19 = fcmp ult float %angle.0.19, 1.575000e+02
  %cmp41.19 = fcmp ugt float %angle.0.19, 1.800000e+02
  %or.cond4.19 = or i1 %cmp38.19, %cmp41.19
  br i1 %or.cond4.19, label %if.else54.19, label %if.then43.19

if.else54.19:                                     ; preds = %lor.lhs.false36.19
  %cmp56.19 = fcmp oge float %angle.0.19, 2.250000e+01
  %cmp60.19 = fcmp olt float %angle.0.19, 6.750000e+01
  %or.cond5.19 = and i1 %cmp56.19, %cmp60.19
  br i1 %or.cond5.19, label %if.then62.19, label %if.else75.19

if.else75.19:                                     ; preds = %if.else54.19
  %cmp77.19 = fcmp oge float %angle.0.19, 6.750000e+01
  %cmp81.19 = fcmp olt float %angle.0.19, 1.125000e+02
  %or.cond6.19 = and i1 %cmp77.19, %cmp81.19
  br i1 %or.cond6.19, label %if.then83.19, label %if.else94.19

if.else94.19:                                     ; preds = %if.else75.19
  %cmp96.19 = fcmp oge float %angle.0.19, 1.125000e+02
  %cmp100.19 = fcmp olt float %angle.0.19, 1.575000e+02
  %or.cond7.19 = and i1 %cmp96.19, %cmp100.19
  br i1 %or.cond7.19, label %if.then102.19, label %if.end118.19

if.then102.19:                                    ; preds = %if.else94.19
  %493 = trunc i64 %indvars.iv.19 to i32
  %sub105.19 = add i32 %493, %sub103.19
  %add106.19 = add i32 %sub105.19, -129
  %idxprom107.19 = sext i32 %add106.19 to i64
  %arrayidx108.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.19
  %494 = load float, float* %arrayidx108.19, align 4
  %add112.19 = add i32 %sub105.19, 129
  %idxprom113.19 = sext i32 %add112.19 to i64
  %arrayidx114.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.19
  %495 = load float, float* %arrayidx114.19, align 4
  br label %if.end118.19

if.then83.19:                                     ; preds = %if.else75.19
  %496 = add nsw i64 %490, %indvars.iv.19
  %arrayidx88.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %496
  %497 = load float, float* %arrayidx88.19, align 4
  %498 = add nsw i64 %489, %indvars.iv.19
  %arrayidx93.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %498
  %499 = load float, float* %arrayidx93.19, align 4
  br label %if.end118.19

if.then62.19:                                     ; preds = %if.else54.19
  %500 = trunc i64 %indvars.iv.19 to i32
  %sub65.19 = add i32 %500, %add63.19
  %add66.19 = add i32 %sub65.19, 127
  %idxprom67.19 = sext i32 %add66.19 to i64
  %arrayidx68.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.19
  %501 = load float, float* %arrayidx68.19, align 4
  %add72.19 = add i32 %sub65.19, -127
  %idxprom73.19 = sext i32 %add72.19 to i64
  %arrayidx74.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.19
  %502 = load float, float* %arrayidx74.19, align 4
  br label %if.end118.19

if.then43.19:                                     ; preds = %lor.lhs.false36.19, %if.else20.19
  %503 = trunc i64 %indvars.iv.19 to i32
  %add46.19 = add i32 %add45.19, %503
  %idxprom47.19 = sext i32 %add46.19 to i64
  %arrayidx48.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.19
  %504 = load float, float* %arrayidx48.19, align 4
  %505 = trunc i64 %indvars.iv.19 to i32
  %add51.19 = add i32 %sub50.19, %505
  %idxprom52.19 = sext i32 %add51.19 to i64
  %arrayidx53.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.19
  %506 = load float, float* %arrayidx53.19, align 4
  br label %if.end118.19

if.end118.19:                                     ; preds = %if.then43.19, %if.then62.19, %if.then83.19, %if.then102.19, %if.else94.19
  %q.3.19 = phi float [ %504, %if.then43.19 ], [ %501, %if.then62.19 ], [ %497, %if.then83.19 ], [ %494, %if.then102.19 ], [ 2.550000e+02, %if.else94.19 ]
  %r.3.19 = phi float [ %506, %if.then43.19 ], [ %502, %if.then62.19 ], [ %499, %if.then83.19 ], [ %495, %if.then102.19 ], [ 2.550000e+02, %if.else94.19 ]
  %arrayidx120.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %491
  %507 = load float, float* %arrayidx120.19, align 4
  %cmp121.19 = fcmp ult float %507, %q.3.19
  %cmp126.19 = fcmp ult float %507, %r.3.19
  %or.cond8.19 = or i1 %cmp121.19, %cmp126.19
  br i1 %or.cond8.19, label %if.else134.19, label %if.then128.19

if.then128.19:                                    ; preds = %if.end118.19
  %conv131.19 = fptoui float %507 to i32
  %arrayidx133.19 = getelementptr inbounds i32, i32* %., i64 %491
  store i32 %conv131.19, i32* %arrayidx133.19, align 4
  br label %for.inc.19

if.else134.19:                                    ; preds = %if.end118.19
  %arrayidx136.19 = getelementptr inbounds i32, i32* %., i64 %491
  store i32 0, i32* %arrayidx136.19, align 4
  br label %for.inc.19

if.then19.19:                                     ; preds = %for.body8.19
  %arrayidx.19 = getelementptr inbounds i32, i32* %., i64 %491
  store i32 0, i32* %arrayidx.19, align 4
  br label %for.inc.19

for.inc.19:                                       ; preds = %if.then19.19, %if.else134.19, %if.then128.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %img_width
  br i1 %exitcond.19, label %for.inc139.19, label %for.body8.19, !llvm.loop !1

for.inc139.19:                                    ; preds = %for.inc.19
  %indvars.iv.next20.19 = add nsw i64 %indvars.iv19, 20
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.20

for.body8.lr.ph.20:                               ; preds = %for.inc139.19
  %508 = trunc i64 %indvars.iv.next20.19 to i32
  %mul.20 = shl nsw i32 %508, 7
  %cmp11.20 = icmp eq i64 %indvars.iv.next20.19, %1
  %add45.20 = or i32 %mul.20, 1
  %sub50.20 = add i32 %mul.20, -1
  %509 = trunc i64 %indvars.iv.next20.19 to i32
  %add63.20 = shl i32 %509, 7
  %510 = trunc i64 %indvars.iv.next20.19 to i32
  %add84.20 = shl i32 %510, 7
  %mul85.20 = add i32 %add84.20, 128
  %mul90.20 = add i32 %add84.20, -128
  %511 = trunc i64 %indvars.iv.next20.19 to i32
  %sub103.20 = shl i32 %511, 7
  %512 = sext i32 %mul.20 to i64
  %513 = sext i32 %mul90.20 to i64
  %514 = sext i32 %mul85.20 to i64
  br label %for.body8.20

for.body8.20:                                     ; preds = %for.inc.20, %for.body8.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body8.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc.20 ]
  %515 = add nsw i64 %indvars.iv.20, %512
  %cmp14.20 = icmp eq i64 %indvars.iv.20, 0
  %or.cond1.20 = or i1 %cmp11.20, %cmp14.20
  %cmp17.20 = icmp eq i64 %indvars.iv.20, %0
  %or.cond2.20 = or i1 %cmp17.20, %or.cond1.20
  br i1 %or.cond2.20, label %if.then19.20, label %if.else20.20

if.else20.20:                                     ; preds = %for.body8.20
  %arrayidx22.20 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %515
  %516 = load float, float* %arrayidx22.20, align 4
  %conv23.20 = fpext float %516 to double
  %mul24.20 = fmul double %conv23.20, 0x404CA5DC1A63C1F8
  %conv25.20 = fptrunc double %mul24.20 to float
  %cmp26.20 = fcmp olt float %conv25.20, 0.000000e+00
  %add29.20 = fadd float %conv25.20, 1.800000e+02
  %angle.0.20 = select i1 %cmp26.20, float %add29.20, float %conv25.20
  %cmp31.20 = fcmp oge float %angle.0.20, 0.000000e+00
  %cmp34.20 = fcmp olt float %angle.0.20, 2.250000e+01
  %or.cond3.20 = and i1 %cmp31.20, %cmp34.20
  br i1 %or.cond3.20, label %if.then43.20, label %lor.lhs.false36.20

lor.lhs.false36.20:                               ; preds = %if.else20.20
  %cmp38.20 = fcmp ult float %angle.0.20, 1.575000e+02
  %cmp41.20 = fcmp ugt float %angle.0.20, 1.800000e+02
  %or.cond4.20 = or i1 %cmp38.20, %cmp41.20
  br i1 %or.cond4.20, label %if.else54.20, label %if.then43.20

if.else54.20:                                     ; preds = %lor.lhs.false36.20
  %cmp56.20 = fcmp oge float %angle.0.20, 2.250000e+01
  %cmp60.20 = fcmp olt float %angle.0.20, 6.750000e+01
  %or.cond5.20 = and i1 %cmp56.20, %cmp60.20
  br i1 %or.cond5.20, label %if.then62.20, label %if.else75.20

if.else75.20:                                     ; preds = %if.else54.20
  %cmp77.20 = fcmp oge float %angle.0.20, 6.750000e+01
  %cmp81.20 = fcmp olt float %angle.0.20, 1.125000e+02
  %or.cond6.20 = and i1 %cmp77.20, %cmp81.20
  br i1 %or.cond6.20, label %if.then83.20, label %if.else94.20

if.else94.20:                                     ; preds = %if.else75.20
  %cmp96.20 = fcmp oge float %angle.0.20, 1.125000e+02
  %cmp100.20 = fcmp olt float %angle.0.20, 1.575000e+02
  %or.cond7.20 = and i1 %cmp96.20, %cmp100.20
  br i1 %or.cond7.20, label %if.then102.20, label %if.end118.20

if.then102.20:                                    ; preds = %if.else94.20
  %517 = trunc i64 %indvars.iv.20 to i32
  %sub105.20 = add i32 %517, %sub103.20
  %add106.20 = add i32 %sub105.20, -129
  %idxprom107.20 = sext i32 %add106.20 to i64
  %arrayidx108.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.20
  %518 = load float, float* %arrayidx108.20, align 4
  %add112.20 = add i32 %sub105.20, 129
  %idxprom113.20 = sext i32 %add112.20 to i64
  %arrayidx114.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.20
  %519 = load float, float* %arrayidx114.20, align 4
  br label %if.end118.20

if.then83.20:                                     ; preds = %if.else75.20
  %520 = add nsw i64 %514, %indvars.iv.20
  %arrayidx88.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %520
  %521 = load float, float* %arrayidx88.20, align 4
  %522 = add nsw i64 %513, %indvars.iv.20
  %arrayidx93.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %522
  %523 = load float, float* %arrayidx93.20, align 4
  br label %if.end118.20

if.then62.20:                                     ; preds = %if.else54.20
  %524 = trunc i64 %indvars.iv.20 to i32
  %sub65.20 = add i32 %524, %add63.20
  %add66.20 = add i32 %sub65.20, 127
  %idxprom67.20 = sext i32 %add66.20 to i64
  %arrayidx68.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.20
  %525 = load float, float* %arrayidx68.20, align 4
  %add72.20 = add i32 %sub65.20, -127
  %idxprom73.20 = sext i32 %add72.20 to i64
  %arrayidx74.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.20
  %526 = load float, float* %arrayidx74.20, align 4
  br label %if.end118.20

if.then43.20:                                     ; preds = %lor.lhs.false36.20, %if.else20.20
  %527 = trunc i64 %indvars.iv.20 to i32
  %add46.20 = add i32 %add45.20, %527
  %idxprom47.20 = sext i32 %add46.20 to i64
  %arrayidx48.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.20
  %528 = load float, float* %arrayidx48.20, align 4
  %529 = trunc i64 %indvars.iv.20 to i32
  %add51.20 = add i32 %sub50.20, %529
  %idxprom52.20 = sext i32 %add51.20 to i64
  %arrayidx53.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.20
  %530 = load float, float* %arrayidx53.20, align 4
  br label %if.end118.20

if.end118.20:                                     ; preds = %if.then43.20, %if.then62.20, %if.then83.20, %if.then102.20, %if.else94.20
  %q.3.20 = phi float [ %528, %if.then43.20 ], [ %525, %if.then62.20 ], [ %521, %if.then83.20 ], [ %518, %if.then102.20 ], [ 2.550000e+02, %if.else94.20 ]
  %r.3.20 = phi float [ %530, %if.then43.20 ], [ %526, %if.then62.20 ], [ %523, %if.then83.20 ], [ %519, %if.then102.20 ], [ 2.550000e+02, %if.else94.20 ]
  %arrayidx120.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %515
  %531 = load float, float* %arrayidx120.20, align 4
  %cmp121.20 = fcmp ult float %531, %q.3.20
  %cmp126.20 = fcmp ult float %531, %r.3.20
  %or.cond8.20 = or i1 %cmp121.20, %cmp126.20
  br i1 %or.cond8.20, label %if.else134.20, label %if.then128.20

if.then128.20:                                    ; preds = %if.end118.20
  %conv131.20 = fptoui float %531 to i32
  %arrayidx133.20 = getelementptr inbounds i32, i32* %., i64 %515
  store i32 %conv131.20, i32* %arrayidx133.20, align 4
  br label %for.inc.20

if.else134.20:                                    ; preds = %if.end118.20
  %arrayidx136.20 = getelementptr inbounds i32, i32* %., i64 %515
  store i32 0, i32* %arrayidx136.20, align 4
  br label %for.inc.20

if.then19.20:                                     ; preds = %for.body8.20
  %arrayidx.20 = getelementptr inbounds i32, i32* %., i64 %515
  store i32 0, i32* %arrayidx.20, align 4
  br label %for.inc.20

for.inc.20:                                       ; preds = %if.then19.20, %if.else134.20, %if.then128.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %img_width
  br i1 %exitcond.20, label %for.inc139.20, label %for.body8.20, !llvm.loop !1

for.inc139.20:                                    ; preds = %for.inc.20
  %indvars.iv.next20.20 = add nsw i64 %indvars.iv19, 21
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.21

for.body8.lr.ph.21:                               ; preds = %for.inc139.20
  %532 = trunc i64 %indvars.iv.next20.20 to i32
  %mul.21 = shl nsw i32 %532, 7
  %cmp11.21 = icmp eq i64 %indvars.iv.next20.20, %1
  %add45.21 = or i32 %mul.21, 1
  %sub50.21 = add i32 %mul.21, -1
  %533 = trunc i64 %indvars.iv.next20.20 to i32
  %add63.21 = shl i32 %533, 7
  %534 = trunc i64 %indvars.iv.next20.20 to i32
  %add84.21 = shl i32 %534, 7
  %mul85.21 = add i32 %add84.21, 128
  %mul90.21 = add i32 %add84.21, -128
  %535 = trunc i64 %indvars.iv.next20.20 to i32
  %sub103.21 = shl i32 %535, 7
  %536 = sext i32 %mul.21 to i64
  %537 = sext i32 %mul90.21 to i64
  %538 = sext i32 %mul85.21 to i64
  br label %for.body8.21

for.body8.21:                                     ; preds = %for.inc.21, %for.body8.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body8.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc.21 ]
  %539 = add nsw i64 %indvars.iv.21, %536
  %cmp14.21 = icmp eq i64 %indvars.iv.21, 0
  %or.cond1.21 = or i1 %cmp11.21, %cmp14.21
  %cmp17.21 = icmp eq i64 %indvars.iv.21, %0
  %or.cond2.21 = or i1 %cmp17.21, %or.cond1.21
  br i1 %or.cond2.21, label %if.then19.21, label %if.else20.21

if.else20.21:                                     ; preds = %for.body8.21
  %arrayidx22.21 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %539
  %540 = load float, float* %arrayidx22.21, align 4
  %conv23.21 = fpext float %540 to double
  %mul24.21 = fmul double %conv23.21, 0x404CA5DC1A63C1F8
  %conv25.21 = fptrunc double %mul24.21 to float
  %cmp26.21 = fcmp olt float %conv25.21, 0.000000e+00
  %add29.21 = fadd float %conv25.21, 1.800000e+02
  %angle.0.21 = select i1 %cmp26.21, float %add29.21, float %conv25.21
  %cmp31.21 = fcmp oge float %angle.0.21, 0.000000e+00
  %cmp34.21 = fcmp olt float %angle.0.21, 2.250000e+01
  %or.cond3.21 = and i1 %cmp31.21, %cmp34.21
  br i1 %or.cond3.21, label %if.then43.21, label %lor.lhs.false36.21

lor.lhs.false36.21:                               ; preds = %if.else20.21
  %cmp38.21 = fcmp ult float %angle.0.21, 1.575000e+02
  %cmp41.21 = fcmp ugt float %angle.0.21, 1.800000e+02
  %or.cond4.21 = or i1 %cmp38.21, %cmp41.21
  br i1 %or.cond4.21, label %if.else54.21, label %if.then43.21

if.else54.21:                                     ; preds = %lor.lhs.false36.21
  %cmp56.21 = fcmp oge float %angle.0.21, 2.250000e+01
  %cmp60.21 = fcmp olt float %angle.0.21, 6.750000e+01
  %or.cond5.21 = and i1 %cmp56.21, %cmp60.21
  br i1 %or.cond5.21, label %if.then62.21, label %if.else75.21

if.else75.21:                                     ; preds = %if.else54.21
  %cmp77.21 = fcmp oge float %angle.0.21, 6.750000e+01
  %cmp81.21 = fcmp olt float %angle.0.21, 1.125000e+02
  %or.cond6.21 = and i1 %cmp77.21, %cmp81.21
  br i1 %or.cond6.21, label %if.then83.21, label %if.else94.21

if.else94.21:                                     ; preds = %if.else75.21
  %cmp96.21 = fcmp oge float %angle.0.21, 1.125000e+02
  %cmp100.21 = fcmp olt float %angle.0.21, 1.575000e+02
  %or.cond7.21 = and i1 %cmp96.21, %cmp100.21
  br i1 %or.cond7.21, label %if.then102.21, label %if.end118.21

if.then102.21:                                    ; preds = %if.else94.21
  %541 = trunc i64 %indvars.iv.21 to i32
  %sub105.21 = add i32 %541, %sub103.21
  %add106.21 = add i32 %sub105.21, -129
  %idxprom107.21 = sext i32 %add106.21 to i64
  %arrayidx108.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.21
  %542 = load float, float* %arrayidx108.21, align 4
  %add112.21 = add i32 %sub105.21, 129
  %idxprom113.21 = sext i32 %add112.21 to i64
  %arrayidx114.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.21
  %543 = load float, float* %arrayidx114.21, align 4
  br label %if.end118.21

if.then83.21:                                     ; preds = %if.else75.21
  %544 = add nsw i64 %538, %indvars.iv.21
  %arrayidx88.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %544
  %545 = load float, float* %arrayidx88.21, align 4
  %546 = add nsw i64 %537, %indvars.iv.21
  %arrayidx93.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %546
  %547 = load float, float* %arrayidx93.21, align 4
  br label %if.end118.21

if.then62.21:                                     ; preds = %if.else54.21
  %548 = trunc i64 %indvars.iv.21 to i32
  %sub65.21 = add i32 %548, %add63.21
  %add66.21 = add i32 %sub65.21, 127
  %idxprom67.21 = sext i32 %add66.21 to i64
  %arrayidx68.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.21
  %549 = load float, float* %arrayidx68.21, align 4
  %add72.21 = add i32 %sub65.21, -127
  %idxprom73.21 = sext i32 %add72.21 to i64
  %arrayidx74.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.21
  %550 = load float, float* %arrayidx74.21, align 4
  br label %if.end118.21

if.then43.21:                                     ; preds = %lor.lhs.false36.21, %if.else20.21
  %551 = trunc i64 %indvars.iv.21 to i32
  %add46.21 = add i32 %add45.21, %551
  %idxprom47.21 = sext i32 %add46.21 to i64
  %arrayidx48.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.21
  %552 = load float, float* %arrayidx48.21, align 4
  %553 = trunc i64 %indvars.iv.21 to i32
  %add51.21 = add i32 %sub50.21, %553
  %idxprom52.21 = sext i32 %add51.21 to i64
  %arrayidx53.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.21
  %554 = load float, float* %arrayidx53.21, align 4
  br label %if.end118.21

if.end118.21:                                     ; preds = %if.then43.21, %if.then62.21, %if.then83.21, %if.then102.21, %if.else94.21
  %q.3.21 = phi float [ %552, %if.then43.21 ], [ %549, %if.then62.21 ], [ %545, %if.then83.21 ], [ %542, %if.then102.21 ], [ 2.550000e+02, %if.else94.21 ]
  %r.3.21 = phi float [ %554, %if.then43.21 ], [ %550, %if.then62.21 ], [ %547, %if.then83.21 ], [ %543, %if.then102.21 ], [ 2.550000e+02, %if.else94.21 ]
  %arrayidx120.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %539
  %555 = load float, float* %arrayidx120.21, align 4
  %cmp121.21 = fcmp ult float %555, %q.3.21
  %cmp126.21 = fcmp ult float %555, %r.3.21
  %or.cond8.21 = or i1 %cmp121.21, %cmp126.21
  br i1 %or.cond8.21, label %if.else134.21, label %if.then128.21

if.then128.21:                                    ; preds = %if.end118.21
  %conv131.21 = fptoui float %555 to i32
  %arrayidx133.21 = getelementptr inbounds i32, i32* %., i64 %539
  store i32 %conv131.21, i32* %arrayidx133.21, align 4
  br label %for.inc.21

if.else134.21:                                    ; preds = %if.end118.21
  %arrayidx136.21 = getelementptr inbounds i32, i32* %., i64 %539
  store i32 0, i32* %arrayidx136.21, align 4
  br label %for.inc.21

if.then19.21:                                     ; preds = %for.body8.21
  %arrayidx.21 = getelementptr inbounds i32, i32* %., i64 %539
  store i32 0, i32* %arrayidx.21, align 4
  br label %for.inc.21

for.inc.21:                                       ; preds = %if.then19.21, %if.else134.21, %if.then128.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %img_width
  br i1 %exitcond.21, label %for.inc139.21, label %for.body8.21, !llvm.loop !1

for.inc139.21:                                    ; preds = %for.inc.21
  %indvars.iv.next20.21 = add nsw i64 %indvars.iv19, 22
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.22

for.body8.lr.ph.22:                               ; preds = %for.inc139.21
  %556 = trunc i64 %indvars.iv.next20.21 to i32
  %mul.22 = shl nsw i32 %556, 7
  %cmp11.22 = icmp eq i64 %indvars.iv.next20.21, %1
  %add45.22 = or i32 %mul.22, 1
  %sub50.22 = add i32 %mul.22, -1
  %557 = trunc i64 %indvars.iv.next20.21 to i32
  %add63.22 = shl i32 %557, 7
  %558 = trunc i64 %indvars.iv.next20.21 to i32
  %add84.22 = shl i32 %558, 7
  %mul85.22 = add i32 %add84.22, 128
  %mul90.22 = add i32 %add84.22, -128
  %559 = trunc i64 %indvars.iv.next20.21 to i32
  %sub103.22 = shl i32 %559, 7
  %560 = sext i32 %mul.22 to i64
  %561 = sext i32 %mul90.22 to i64
  %562 = sext i32 %mul85.22 to i64
  br label %for.body8.22

for.body8.22:                                     ; preds = %for.inc.22, %for.body8.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body8.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc.22 ]
  %563 = add nsw i64 %indvars.iv.22, %560
  %cmp14.22 = icmp eq i64 %indvars.iv.22, 0
  %or.cond1.22 = or i1 %cmp11.22, %cmp14.22
  %cmp17.22 = icmp eq i64 %indvars.iv.22, %0
  %or.cond2.22 = or i1 %cmp17.22, %or.cond1.22
  br i1 %or.cond2.22, label %if.then19.22, label %if.else20.22

if.else20.22:                                     ; preds = %for.body8.22
  %arrayidx22.22 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %563
  %564 = load float, float* %arrayidx22.22, align 4
  %conv23.22 = fpext float %564 to double
  %mul24.22 = fmul double %conv23.22, 0x404CA5DC1A63C1F8
  %conv25.22 = fptrunc double %mul24.22 to float
  %cmp26.22 = fcmp olt float %conv25.22, 0.000000e+00
  %add29.22 = fadd float %conv25.22, 1.800000e+02
  %angle.0.22 = select i1 %cmp26.22, float %add29.22, float %conv25.22
  %cmp31.22 = fcmp oge float %angle.0.22, 0.000000e+00
  %cmp34.22 = fcmp olt float %angle.0.22, 2.250000e+01
  %or.cond3.22 = and i1 %cmp31.22, %cmp34.22
  br i1 %or.cond3.22, label %if.then43.22, label %lor.lhs.false36.22

lor.lhs.false36.22:                               ; preds = %if.else20.22
  %cmp38.22 = fcmp ult float %angle.0.22, 1.575000e+02
  %cmp41.22 = fcmp ugt float %angle.0.22, 1.800000e+02
  %or.cond4.22 = or i1 %cmp38.22, %cmp41.22
  br i1 %or.cond4.22, label %if.else54.22, label %if.then43.22

if.else54.22:                                     ; preds = %lor.lhs.false36.22
  %cmp56.22 = fcmp oge float %angle.0.22, 2.250000e+01
  %cmp60.22 = fcmp olt float %angle.0.22, 6.750000e+01
  %or.cond5.22 = and i1 %cmp56.22, %cmp60.22
  br i1 %or.cond5.22, label %if.then62.22, label %if.else75.22

if.else75.22:                                     ; preds = %if.else54.22
  %cmp77.22 = fcmp oge float %angle.0.22, 6.750000e+01
  %cmp81.22 = fcmp olt float %angle.0.22, 1.125000e+02
  %or.cond6.22 = and i1 %cmp77.22, %cmp81.22
  br i1 %or.cond6.22, label %if.then83.22, label %if.else94.22

if.else94.22:                                     ; preds = %if.else75.22
  %cmp96.22 = fcmp oge float %angle.0.22, 1.125000e+02
  %cmp100.22 = fcmp olt float %angle.0.22, 1.575000e+02
  %or.cond7.22 = and i1 %cmp96.22, %cmp100.22
  br i1 %or.cond7.22, label %if.then102.22, label %if.end118.22

if.then102.22:                                    ; preds = %if.else94.22
  %565 = trunc i64 %indvars.iv.22 to i32
  %sub105.22 = add i32 %565, %sub103.22
  %add106.22 = add i32 %sub105.22, -129
  %idxprom107.22 = sext i32 %add106.22 to i64
  %arrayidx108.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.22
  %566 = load float, float* %arrayidx108.22, align 4
  %add112.22 = add i32 %sub105.22, 129
  %idxprom113.22 = sext i32 %add112.22 to i64
  %arrayidx114.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.22
  %567 = load float, float* %arrayidx114.22, align 4
  br label %if.end118.22

if.then83.22:                                     ; preds = %if.else75.22
  %568 = add nsw i64 %562, %indvars.iv.22
  %arrayidx88.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %568
  %569 = load float, float* %arrayidx88.22, align 4
  %570 = add nsw i64 %561, %indvars.iv.22
  %arrayidx93.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %570
  %571 = load float, float* %arrayidx93.22, align 4
  br label %if.end118.22

if.then62.22:                                     ; preds = %if.else54.22
  %572 = trunc i64 %indvars.iv.22 to i32
  %sub65.22 = add i32 %572, %add63.22
  %add66.22 = add i32 %sub65.22, 127
  %idxprom67.22 = sext i32 %add66.22 to i64
  %arrayidx68.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.22
  %573 = load float, float* %arrayidx68.22, align 4
  %add72.22 = add i32 %sub65.22, -127
  %idxprom73.22 = sext i32 %add72.22 to i64
  %arrayidx74.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.22
  %574 = load float, float* %arrayidx74.22, align 4
  br label %if.end118.22

if.then43.22:                                     ; preds = %lor.lhs.false36.22, %if.else20.22
  %575 = trunc i64 %indvars.iv.22 to i32
  %add46.22 = add i32 %add45.22, %575
  %idxprom47.22 = sext i32 %add46.22 to i64
  %arrayidx48.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.22
  %576 = load float, float* %arrayidx48.22, align 4
  %577 = trunc i64 %indvars.iv.22 to i32
  %add51.22 = add i32 %sub50.22, %577
  %idxprom52.22 = sext i32 %add51.22 to i64
  %arrayidx53.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.22
  %578 = load float, float* %arrayidx53.22, align 4
  br label %if.end118.22

if.end118.22:                                     ; preds = %if.then43.22, %if.then62.22, %if.then83.22, %if.then102.22, %if.else94.22
  %q.3.22 = phi float [ %576, %if.then43.22 ], [ %573, %if.then62.22 ], [ %569, %if.then83.22 ], [ %566, %if.then102.22 ], [ 2.550000e+02, %if.else94.22 ]
  %r.3.22 = phi float [ %578, %if.then43.22 ], [ %574, %if.then62.22 ], [ %571, %if.then83.22 ], [ %567, %if.then102.22 ], [ 2.550000e+02, %if.else94.22 ]
  %arrayidx120.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %563
  %579 = load float, float* %arrayidx120.22, align 4
  %cmp121.22 = fcmp ult float %579, %q.3.22
  %cmp126.22 = fcmp ult float %579, %r.3.22
  %or.cond8.22 = or i1 %cmp121.22, %cmp126.22
  br i1 %or.cond8.22, label %if.else134.22, label %if.then128.22

if.then128.22:                                    ; preds = %if.end118.22
  %conv131.22 = fptoui float %579 to i32
  %arrayidx133.22 = getelementptr inbounds i32, i32* %., i64 %563
  store i32 %conv131.22, i32* %arrayidx133.22, align 4
  br label %for.inc.22

if.else134.22:                                    ; preds = %if.end118.22
  %arrayidx136.22 = getelementptr inbounds i32, i32* %., i64 %563
  store i32 0, i32* %arrayidx136.22, align 4
  br label %for.inc.22

if.then19.22:                                     ; preds = %for.body8.22
  %arrayidx.22 = getelementptr inbounds i32, i32* %., i64 %563
  store i32 0, i32* %arrayidx.22, align 4
  br label %for.inc.22

for.inc.22:                                       ; preds = %if.then19.22, %if.else134.22, %if.then128.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %img_width
  br i1 %exitcond.22, label %for.inc139.22, label %for.body8.22, !llvm.loop !1

for.inc139.22:                                    ; preds = %for.inc.22
  %indvars.iv.next20.22 = add nsw i64 %indvars.iv19, 23
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.23

for.body8.lr.ph.23:                               ; preds = %for.inc139.22
  %580 = trunc i64 %indvars.iv.next20.22 to i32
  %mul.23 = shl nsw i32 %580, 7
  %cmp11.23 = icmp eq i64 %indvars.iv.next20.22, %1
  %add45.23 = or i32 %mul.23, 1
  %sub50.23 = add i32 %mul.23, -1
  %581 = trunc i64 %indvars.iv.next20.22 to i32
  %add63.23 = shl i32 %581, 7
  %582 = trunc i64 %indvars.iv.next20.22 to i32
  %add84.23 = shl i32 %582, 7
  %mul85.23 = add i32 %add84.23, 128
  %mul90.23 = add i32 %add84.23, -128
  %583 = trunc i64 %indvars.iv.next20.22 to i32
  %sub103.23 = shl i32 %583, 7
  %584 = sext i32 %mul.23 to i64
  %585 = sext i32 %mul90.23 to i64
  %586 = sext i32 %mul85.23 to i64
  br label %for.body8.23

for.body8.23:                                     ; preds = %for.inc.23, %for.body8.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body8.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc.23 ]
  %587 = add nsw i64 %indvars.iv.23, %584
  %cmp14.23 = icmp eq i64 %indvars.iv.23, 0
  %or.cond1.23 = or i1 %cmp11.23, %cmp14.23
  %cmp17.23 = icmp eq i64 %indvars.iv.23, %0
  %or.cond2.23 = or i1 %cmp17.23, %or.cond1.23
  br i1 %or.cond2.23, label %if.then19.23, label %if.else20.23

if.else20.23:                                     ; preds = %for.body8.23
  %arrayidx22.23 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %587
  %588 = load float, float* %arrayidx22.23, align 4
  %conv23.23 = fpext float %588 to double
  %mul24.23 = fmul double %conv23.23, 0x404CA5DC1A63C1F8
  %conv25.23 = fptrunc double %mul24.23 to float
  %cmp26.23 = fcmp olt float %conv25.23, 0.000000e+00
  %add29.23 = fadd float %conv25.23, 1.800000e+02
  %angle.0.23 = select i1 %cmp26.23, float %add29.23, float %conv25.23
  %cmp31.23 = fcmp oge float %angle.0.23, 0.000000e+00
  %cmp34.23 = fcmp olt float %angle.0.23, 2.250000e+01
  %or.cond3.23 = and i1 %cmp31.23, %cmp34.23
  br i1 %or.cond3.23, label %if.then43.23, label %lor.lhs.false36.23

lor.lhs.false36.23:                               ; preds = %if.else20.23
  %cmp38.23 = fcmp ult float %angle.0.23, 1.575000e+02
  %cmp41.23 = fcmp ugt float %angle.0.23, 1.800000e+02
  %or.cond4.23 = or i1 %cmp38.23, %cmp41.23
  br i1 %or.cond4.23, label %if.else54.23, label %if.then43.23

if.else54.23:                                     ; preds = %lor.lhs.false36.23
  %cmp56.23 = fcmp oge float %angle.0.23, 2.250000e+01
  %cmp60.23 = fcmp olt float %angle.0.23, 6.750000e+01
  %or.cond5.23 = and i1 %cmp56.23, %cmp60.23
  br i1 %or.cond5.23, label %if.then62.23, label %if.else75.23

if.else75.23:                                     ; preds = %if.else54.23
  %cmp77.23 = fcmp oge float %angle.0.23, 6.750000e+01
  %cmp81.23 = fcmp olt float %angle.0.23, 1.125000e+02
  %or.cond6.23 = and i1 %cmp77.23, %cmp81.23
  br i1 %or.cond6.23, label %if.then83.23, label %if.else94.23

if.else94.23:                                     ; preds = %if.else75.23
  %cmp96.23 = fcmp oge float %angle.0.23, 1.125000e+02
  %cmp100.23 = fcmp olt float %angle.0.23, 1.575000e+02
  %or.cond7.23 = and i1 %cmp96.23, %cmp100.23
  br i1 %or.cond7.23, label %if.then102.23, label %if.end118.23

if.then102.23:                                    ; preds = %if.else94.23
  %589 = trunc i64 %indvars.iv.23 to i32
  %sub105.23 = add i32 %589, %sub103.23
  %add106.23 = add i32 %sub105.23, -129
  %idxprom107.23 = sext i32 %add106.23 to i64
  %arrayidx108.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.23
  %590 = load float, float* %arrayidx108.23, align 4
  %add112.23 = add i32 %sub105.23, 129
  %idxprom113.23 = sext i32 %add112.23 to i64
  %arrayidx114.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.23
  %591 = load float, float* %arrayidx114.23, align 4
  br label %if.end118.23

if.then83.23:                                     ; preds = %if.else75.23
  %592 = add nsw i64 %586, %indvars.iv.23
  %arrayidx88.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %592
  %593 = load float, float* %arrayidx88.23, align 4
  %594 = add nsw i64 %585, %indvars.iv.23
  %arrayidx93.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %594
  %595 = load float, float* %arrayidx93.23, align 4
  br label %if.end118.23

if.then62.23:                                     ; preds = %if.else54.23
  %596 = trunc i64 %indvars.iv.23 to i32
  %sub65.23 = add i32 %596, %add63.23
  %add66.23 = add i32 %sub65.23, 127
  %idxprom67.23 = sext i32 %add66.23 to i64
  %arrayidx68.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.23
  %597 = load float, float* %arrayidx68.23, align 4
  %add72.23 = add i32 %sub65.23, -127
  %idxprom73.23 = sext i32 %add72.23 to i64
  %arrayidx74.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.23
  %598 = load float, float* %arrayidx74.23, align 4
  br label %if.end118.23

if.then43.23:                                     ; preds = %lor.lhs.false36.23, %if.else20.23
  %599 = trunc i64 %indvars.iv.23 to i32
  %add46.23 = add i32 %add45.23, %599
  %idxprom47.23 = sext i32 %add46.23 to i64
  %arrayidx48.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.23
  %600 = load float, float* %arrayidx48.23, align 4
  %601 = trunc i64 %indvars.iv.23 to i32
  %add51.23 = add i32 %sub50.23, %601
  %idxprom52.23 = sext i32 %add51.23 to i64
  %arrayidx53.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.23
  %602 = load float, float* %arrayidx53.23, align 4
  br label %if.end118.23

if.end118.23:                                     ; preds = %if.then43.23, %if.then62.23, %if.then83.23, %if.then102.23, %if.else94.23
  %q.3.23 = phi float [ %600, %if.then43.23 ], [ %597, %if.then62.23 ], [ %593, %if.then83.23 ], [ %590, %if.then102.23 ], [ 2.550000e+02, %if.else94.23 ]
  %r.3.23 = phi float [ %602, %if.then43.23 ], [ %598, %if.then62.23 ], [ %595, %if.then83.23 ], [ %591, %if.then102.23 ], [ 2.550000e+02, %if.else94.23 ]
  %arrayidx120.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %587
  %603 = load float, float* %arrayidx120.23, align 4
  %cmp121.23 = fcmp ult float %603, %q.3.23
  %cmp126.23 = fcmp ult float %603, %r.3.23
  %or.cond8.23 = or i1 %cmp121.23, %cmp126.23
  br i1 %or.cond8.23, label %if.else134.23, label %if.then128.23

if.then128.23:                                    ; preds = %if.end118.23
  %conv131.23 = fptoui float %603 to i32
  %arrayidx133.23 = getelementptr inbounds i32, i32* %., i64 %587
  store i32 %conv131.23, i32* %arrayidx133.23, align 4
  br label %for.inc.23

if.else134.23:                                    ; preds = %if.end118.23
  %arrayidx136.23 = getelementptr inbounds i32, i32* %., i64 %587
  store i32 0, i32* %arrayidx136.23, align 4
  br label %for.inc.23

if.then19.23:                                     ; preds = %for.body8.23
  %arrayidx.23 = getelementptr inbounds i32, i32* %., i64 %587
  store i32 0, i32* %arrayidx.23, align 4
  br label %for.inc.23

for.inc.23:                                       ; preds = %if.then19.23, %if.else134.23, %if.then128.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %img_width
  br i1 %exitcond.23, label %for.inc139.23, label %for.body8.23, !llvm.loop !1

for.inc139.23:                                    ; preds = %for.inc.23
  %indvars.iv.next20.23 = add nsw i64 %indvars.iv19, 24
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.24

for.body8.lr.ph.24:                               ; preds = %for.inc139.23
  %604 = trunc i64 %indvars.iv.next20.23 to i32
  %mul.24 = shl nsw i32 %604, 7
  %cmp11.24 = icmp eq i64 %indvars.iv.next20.23, %1
  %add45.24 = or i32 %mul.24, 1
  %sub50.24 = add i32 %mul.24, -1
  %605 = trunc i64 %indvars.iv.next20.23 to i32
  %add63.24 = shl i32 %605, 7
  %606 = trunc i64 %indvars.iv.next20.23 to i32
  %add84.24 = shl i32 %606, 7
  %mul85.24 = add i32 %add84.24, 128
  %mul90.24 = add i32 %add84.24, -128
  %607 = trunc i64 %indvars.iv.next20.23 to i32
  %sub103.24 = shl i32 %607, 7
  %608 = sext i32 %mul.24 to i64
  %609 = sext i32 %mul90.24 to i64
  %610 = sext i32 %mul85.24 to i64
  br label %for.body8.24

for.body8.24:                                     ; preds = %for.inc.24, %for.body8.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body8.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc.24 ]
  %611 = add nsw i64 %indvars.iv.24, %608
  %cmp14.24 = icmp eq i64 %indvars.iv.24, 0
  %or.cond1.24 = or i1 %cmp11.24, %cmp14.24
  %cmp17.24 = icmp eq i64 %indvars.iv.24, %0
  %or.cond2.24 = or i1 %cmp17.24, %or.cond1.24
  br i1 %or.cond2.24, label %if.then19.24, label %if.else20.24

if.else20.24:                                     ; preds = %for.body8.24
  %arrayidx22.24 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %611
  %612 = load float, float* %arrayidx22.24, align 4
  %conv23.24 = fpext float %612 to double
  %mul24.24 = fmul double %conv23.24, 0x404CA5DC1A63C1F8
  %conv25.24 = fptrunc double %mul24.24 to float
  %cmp26.24 = fcmp olt float %conv25.24, 0.000000e+00
  %add29.24 = fadd float %conv25.24, 1.800000e+02
  %angle.0.24 = select i1 %cmp26.24, float %add29.24, float %conv25.24
  %cmp31.24 = fcmp oge float %angle.0.24, 0.000000e+00
  %cmp34.24 = fcmp olt float %angle.0.24, 2.250000e+01
  %or.cond3.24 = and i1 %cmp31.24, %cmp34.24
  br i1 %or.cond3.24, label %if.then43.24, label %lor.lhs.false36.24

lor.lhs.false36.24:                               ; preds = %if.else20.24
  %cmp38.24 = fcmp ult float %angle.0.24, 1.575000e+02
  %cmp41.24 = fcmp ugt float %angle.0.24, 1.800000e+02
  %or.cond4.24 = or i1 %cmp38.24, %cmp41.24
  br i1 %or.cond4.24, label %if.else54.24, label %if.then43.24

if.else54.24:                                     ; preds = %lor.lhs.false36.24
  %cmp56.24 = fcmp oge float %angle.0.24, 2.250000e+01
  %cmp60.24 = fcmp olt float %angle.0.24, 6.750000e+01
  %or.cond5.24 = and i1 %cmp56.24, %cmp60.24
  br i1 %or.cond5.24, label %if.then62.24, label %if.else75.24

if.else75.24:                                     ; preds = %if.else54.24
  %cmp77.24 = fcmp oge float %angle.0.24, 6.750000e+01
  %cmp81.24 = fcmp olt float %angle.0.24, 1.125000e+02
  %or.cond6.24 = and i1 %cmp77.24, %cmp81.24
  br i1 %or.cond6.24, label %if.then83.24, label %if.else94.24

if.else94.24:                                     ; preds = %if.else75.24
  %cmp96.24 = fcmp oge float %angle.0.24, 1.125000e+02
  %cmp100.24 = fcmp olt float %angle.0.24, 1.575000e+02
  %or.cond7.24 = and i1 %cmp96.24, %cmp100.24
  br i1 %or.cond7.24, label %if.then102.24, label %if.end118.24

if.then102.24:                                    ; preds = %if.else94.24
  %613 = trunc i64 %indvars.iv.24 to i32
  %sub105.24 = add i32 %613, %sub103.24
  %add106.24 = add i32 %sub105.24, -129
  %idxprom107.24 = sext i32 %add106.24 to i64
  %arrayidx108.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.24
  %614 = load float, float* %arrayidx108.24, align 4
  %add112.24 = add i32 %sub105.24, 129
  %idxprom113.24 = sext i32 %add112.24 to i64
  %arrayidx114.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.24
  %615 = load float, float* %arrayidx114.24, align 4
  br label %if.end118.24

if.then83.24:                                     ; preds = %if.else75.24
  %616 = add nsw i64 %610, %indvars.iv.24
  %arrayidx88.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %616
  %617 = load float, float* %arrayidx88.24, align 4
  %618 = add nsw i64 %609, %indvars.iv.24
  %arrayidx93.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %618
  %619 = load float, float* %arrayidx93.24, align 4
  br label %if.end118.24

if.then62.24:                                     ; preds = %if.else54.24
  %620 = trunc i64 %indvars.iv.24 to i32
  %sub65.24 = add i32 %620, %add63.24
  %add66.24 = add i32 %sub65.24, 127
  %idxprom67.24 = sext i32 %add66.24 to i64
  %arrayidx68.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.24
  %621 = load float, float* %arrayidx68.24, align 4
  %add72.24 = add i32 %sub65.24, -127
  %idxprom73.24 = sext i32 %add72.24 to i64
  %arrayidx74.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.24
  %622 = load float, float* %arrayidx74.24, align 4
  br label %if.end118.24

if.then43.24:                                     ; preds = %lor.lhs.false36.24, %if.else20.24
  %623 = trunc i64 %indvars.iv.24 to i32
  %add46.24 = add i32 %add45.24, %623
  %idxprom47.24 = sext i32 %add46.24 to i64
  %arrayidx48.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.24
  %624 = load float, float* %arrayidx48.24, align 4
  %625 = trunc i64 %indvars.iv.24 to i32
  %add51.24 = add i32 %sub50.24, %625
  %idxprom52.24 = sext i32 %add51.24 to i64
  %arrayidx53.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.24
  %626 = load float, float* %arrayidx53.24, align 4
  br label %if.end118.24

if.end118.24:                                     ; preds = %if.then43.24, %if.then62.24, %if.then83.24, %if.then102.24, %if.else94.24
  %q.3.24 = phi float [ %624, %if.then43.24 ], [ %621, %if.then62.24 ], [ %617, %if.then83.24 ], [ %614, %if.then102.24 ], [ 2.550000e+02, %if.else94.24 ]
  %r.3.24 = phi float [ %626, %if.then43.24 ], [ %622, %if.then62.24 ], [ %619, %if.then83.24 ], [ %615, %if.then102.24 ], [ 2.550000e+02, %if.else94.24 ]
  %arrayidx120.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %611
  %627 = load float, float* %arrayidx120.24, align 4
  %cmp121.24 = fcmp ult float %627, %q.3.24
  %cmp126.24 = fcmp ult float %627, %r.3.24
  %or.cond8.24 = or i1 %cmp121.24, %cmp126.24
  br i1 %or.cond8.24, label %if.else134.24, label %if.then128.24

if.then128.24:                                    ; preds = %if.end118.24
  %conv131.24 = fptoui float %627 to i32
  %arrayidx133.24 = getelementptr inbounds i32, i32* %., i64 %611
  store i32 %conv131.24, i32* %arrayidx133.24, align 4
  br label %for.inc.24

if.else134.24:                                    ; preds = %if.end118.24
  %arrayidx136.24 = getelementptr inbounds i32, i32* %., i64 %611
  store i32 0, i32* %arrayidx136.24, align 4
  br label %for.inc.24

if.then19.24:                                     ; preds = %for.body8.24
  %arrayidx.24 = getelementptr inbounds i32, i32* %., i64 %611
  store i32 0, i32* %arrayidx.24, align 4
  br label %for.inc.24

for.inc.24:                                       ; preds = %if.then19.24, %if.else134.24, %if.then128.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %img_width
  br i1 %exitcond.24, label %for.inc139.24, label %for.body8.24, !llvm.loop !1

for.inc139.24:                                    ; preds = %for.inc.24
  %indvars.iv.next20.24 = add nsw i64 %indvars.iv19, 25
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.25

for.body8.lr.ph.25:                               ; preds = %for.inc139.24
  %628 = trunc i64 %indvars.iv.next20.24 to i32
  %mul.25 = shl nsw i32 %628, 7
  %cmp11.25 = icmp eq i64 %indvars.iv.next20.24, %1
  %add45.25 = or i32 %mul.25, 1
  %sub50.25 = add i32 %mul.25, -1
  %629 = trunc i64 %indvars.iv.next20.24 to i32
  %add63.25 = shl i32 %629, 7
  %630 = trunc i64 %indvars.iv.next20.24 to i32
  %add84.25 = shl i32 %630, 7
  %mul85.25 = add i32 %add84.25, 128
  %mul90.25 = add i32 %add84.25, -128
  %631 = trunc i64 %indvars.iv.next20.24 to i32
  %sub103.25 = shl i32 %631, 7
  %632 = sext i32 %mul.25 to i64
  %633 = sext i32 %mul90.25 to i64
  %634 = sext i32 %mul85.25 to i64
  br label %for.body8.25

for.body8.25:                                     ; preds = %for.inc.25, %for.body8.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body8.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc.25 ]
  %635 = add nsw i64 %indvars.iv.25, %632
  %cmp14.25 = icmp eq i64 %indvars.iv.25, 0
  %or.cond1.25 = or i1 %cmp11.25, %cmp14.25
  %cmp17.25 = icmp eq i64 %indvars.iv.25, %0
  %or.cond2.25 = or i1 %cmp17.25, %or.cond1.25
  br i1 %or.cond2.25, label %if.then19.25, label %if.else20.25

if.else20.25:                                     ; preds = %for.body8.25
  %arrayidx22.25 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %635
  %636 = load float, float* %arrayidx22.25, align 4
  %conv23.25 = fpext float %636 to double
  %mul24.25 = fmul double %conv23.25, 0x404CA5DC1A63C1F8
  %conv25.25 = fptrunc double %mul24.25 to float
  %cmp26.25 = fcmp olt float %conv25.25, 0.000000e+00
  %add29.25 = fadd float %conv25.25, 1.800000e+02
  %angle.0.25 = select i1 %cmp26.25, float %add29.25, float %conv25.25
  %cmp31.25 = fcmp oge float %angle.0.25, 0.000000e+00
  %cmp34.25 = fcmp olt float %angle.0.25, 2.250000e+01
  %or.cond3.25 = and i1 %cmp31.25, %cmp34.25
  br i1 %or.cond3.25, label %if.then43.25, label %lor.lhs.false36.25

lor.lhs.false36.25:                               ; preds = %if.else20.25
  %cmp38.25 = fcmp ult float %angle.0.25, 1.575000e+02
  %cmp41.25 = fcmp ugt float %angle.0.25, 1.800000e+02
  %or.cond4.25 = or i1 %cmp38.25, %cmp41.25
  br i1 %or.cond4.25, label %if.else54.25, label %if.then43.25

if.else54.25:                                     ; preds = %lor.lhs.false36.25
  %cmp56.25 = fcmp oge float %angle.0.25, 2.250000e+01
  %cmp60.25 = fcmp olt float %angle.0.25, 6.750000e+01
  %or.cond5.25 = and i1 %cmp56.25, %cmp60.25
  br i1 %or.cond5.25, label %if.then62.25, label %if.else75.25

if.else75.25:                                     ; preds = %if.else54.25
  %cmp77.25 = fcmp oge float %angle.0.25, 6.750000e+01
  %cmp81.25 = fcmp olt float %angle.0.25, 1.125000e+02
  %or.cond6.25 = and i1 %cmp77.25, %cmp81.25
  br i1 %or.cond6.25, label %if.then83.25, label %if.else94.25

if.else94.25:                                     ; preds = %if.else75.25
  %cmp96.25 = fcmp oge float %angle.0.25, 1.125000e+02
  %cmp100.25 = fcmp olt float %angle.0.25, 1.575000e+02
  %or.cond7.25 = and i1 %cmp96.25, %cmp100.25
  br i1 %or.cond7.25, label %if.then102.25, label %if.end118.25

if.then102.25:                                    ; preds = %if.else94.25
  %637 = trunc i64 %indvars.iv.25 to i32
  %sub105.25 = add i32 %637, %sub103.25
  %add106.25 = add i32 %sub105.25, -129
  %idxprom107.25 = sext i32 %add106.25 to i64
  %arrayidx108.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.25
  %638 = load float, float* %arrayidx108.25, align 4
  %add112.25 = add i32 %sub105.25, 129
  %idxprom113.25 = sext i32 %add112.25 to i64
  %arrayidx114.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.25
  %639 = load float, float* %arrayidx114.25, align 4
  br label %if.end118.25

if.then83.25:                                     ; preds = %if.else75.25
  %640 = add nsw i64 %634, %indvars.iv.25
  %arrayidx88.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %640
  %641 = load float, float* %arrayidx88.25, align 4
  %642 = add nsw i64 %633, %indvars.iv.25
  %arrayidx93.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %642
  %643 = load float, float* %arrayidx93.25, align 4
  br label %if.end118.25

if.then62.25:                                     ; preds = %if.else54.25
  %644 = trunc i64 %indvars.iv.25 to i32
  %sub65.25 = add i32 %644, %add63.25
  %add66.25 = add i32 %sub65.25, 127
  %idxprom67.25 = sext i32 %add66.25 to i64
  %arrayidx68.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.25
  %645 = load float, float* %arrayidx68.25, align 4
  %add72.25 = add i32 %sub65.25, -127
  %idxprom73.25 = sext i32 %add72.25 to i64
  %arrayidx74.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.25
  %646 = load float, float* %arrayidx74.25, align 4
  br label %if.end118.25

if.then43.25:                                     ; preds = %lor.lhs.false36.25, %if.else20.25
  %647 = trunc i64 %indvars.iv.25 to i32
  %add46.25 = add i32 %add45.25, %647
  %idxprom47.25 = sext i32 %add46.25 to i64
  %arrayidx48.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.25
  %648 = load float, float* %arrayidx48.25, align 4
  %649 = trunc i64 %indvars.iv.25 to i32
  %add51.25 = add i32 %sub50.25, %649
  %idxprom52.25 = sext i32 %add51.25 to i64
  %arrayidx53.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.25
  %650 = load float, float* %arrayidx53.25, align 4
  br label %if.end118.25

if.end118.25:                                     ; preds = %if.then43.25, %if.then62.25, %if.then83.25, %if.then102.25, %if.else94.25
  %q.3.25 = phi float [ %648, %if.then43.25 ], [ %645, %if.then62.25 ], [ %641, %if.then83.25 ], [ %638, %if.then102.25 ], [ 2.550000e+02, %if.else94.25 ]
  %r.3.25 = phi float [ %650, %if.then43.25 ], [ %646, %if.then62.25 ], [ %643, %if.then83.25 ], [ %639, %if.then102.25 ], [ 2.550000e+02, %if.else94.25 ]
  %arrayidx120.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %635
  %651 = load float, float* %arrayidx120.25, align 4
  %cmp121.25 = fcmp ult float %651, %q.3.25
  %cmp126.25 = fcmp ult float %651, %r.3.25
  %or.cond8.25 = or i1 %cmp121.25, %cmp126.25
  br i1 %or.cond8.25, label %if.else134.25, label %if.then128.25

if.then128.25:                                    ; preds = %if.end118.25
  %conv131.25 = fptoui float %651 to i32
  %arrayidx133.25 = getelementptr inbounds i32, i32* %., i64 %635
  store i32 %conv131.25, i32* %arrayidx133.25, align 4
  br label %for.inc.25

if.else134.25:                                    ; preds = %if.end118.25
  %arrayidx136.25 = getelementptr inbounds i32, i32* %., i64 %635
  store i32 0, i32* %arrayidx136.25, align 4
  br label %for.inc.25

if.then19.25:                                     ; preds = %for.body8.25
  %arrayidx.25 = getelementptr inbounds i32, i32* %., i64 %635
  store i32 0, i32* %arrayidx.25, align 4
  br label %for.inc.25

for.inc.25:                                       ; preds = %if.then19.25, %if.else134.25, %if.then128.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %img_width
  br i1 %exitcond.25, label %for.inc139.25, label %for.body8.25, !llvm.loop !1

for.inc139.25:                                    ; preds = %for.inc.25
  %indvars.iv.next20.25 = add nsw i64 %indvars.iv19, 26
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.26

for.body8.lr.ph.26:                               ; preds = %for.inc139.25
  %652 = trunc i64 %indvars.iv.next20.25 to i32
  %mul.26 = shl nsw i32 %652, 7
  %cmp11.26 = icmp eq i64 %indvars.iv.next20.25, %1
  %add45.26 = or i32 %mul.26, 1
  %sub50.26 = add i32 %mul.26, -1
  %653 = trunc i64 %indvars.iv.next20.25 to i32
  %add63.26 = shl i32 %653, 7
  %654 = trunc i64 %indvars.iv.next20.25 to i32
  %add84.26 = shl i32 %654, 7
  %mul85.26 = add i32 %add84.26, 128
  %mul90.26 = add i32 %add84.26, -128
  %655 = trunc i64 %indvars.iv.next20.25 to i32
  %sub103.26 = shl i32 %655, 7
  %656 = sext i32 %mul.26 to i64
  %657 = sext i32 %mul90.26 to i64
  %658 = sext i32 %mul85.26 to i64
  br label %for.body8.26

for.body8.26:                                     ; preds = %for.inc.26, %for.body8.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body8.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc.26 ]
  %659 = add nsw i64 %indvars.iv.26, %656
  %cmp14.26 = icmp eq i64 %indvars.iv.26, 0
  %or.cond1.26 = or i1 %cmp11.26, %cmp14.26
  %cmp17.26 = icmp eq i64 %indvars.iv.26, %0
  %or.cond2.26 = or i1 %cmp17.26, %or.cond1.26
  br i1 %or.cond2.26, label %if.then19.26, label %if.else20.26

if.else20.26:                                     ; preds = %for.body8.26
  %arrayidx22.26 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %659
  %660 = load float, float* %arrayidx22.26, align 4
  %conv23.26 = fpext float %660 to double
  %mul24.26 = fmul double %conv23.26, 0x404CA5DC1A63C1F8
  %conv25.26 = fptrunc double %mul24.26 to float
  %cmp26.26 = fcmp olt float %conv25.26, 0.000000e+00
  %add29.26 = fadd float %conv25.26, 1.800000e+02
  %angle.0.26 = select i1 %cmp26.26, float %add29.26, float %conv25.26
  %cmp31.26 = fcmp oge float %angle.0.26, 0.000000e+00
  %cmp34.26 = fcmp olt float %angle.0.26, 2.250000e+01
  %or.cond3.26 = and i1 %cmp31.26, %cmp34.26
  br i1 %or.cond3.26, label %if.then43.26, label %lor.lhs.false36.26

lor.lhs.false36.26:                               ; preds = %if.else20.26
  %cmp38.26 = fcmp ult float %angle.0.26, 1.575000e+02
  %cmp41.26 = fcmp ugt float %angle.0.26, 1.800000e+02
  %or.cond4.26 = or i1 %cmp38.26, %cmp41.26
  br i1 %or.cond4.26, label %if.else54.26, label %if.then43.26

if.else54.26:                                     ; preds = %lor.lhs.false36.26
  %cmp56.26 = fcmp oge float %angle.0.26, 2.250000e+01
  %cmp60.26 = fcmp olt float %angle.0.26, 6.750000e+01
  %or.cond5.26 = and i1 %cmp56.26, %cmp60.26
  br i1 %or.cond5.26, label %if.then62.26, label %if.else75.26

if.else75.26:                                     ; preds = %if.else54.26
  %cmp77.26 = fcmp oge float %angle.0.26, 6.750000e+01
  %cmp81.26 = fcmp olt float %angle.0.26, 1.125000e+02
  %or.cond6.26 = and i1 %cmp77.26, %cmp81.26
  br i1 %or.cond6.26, label %if.then83.26, label %if.else94.26

if.else94.26:                                     ; preds = %if.else75.26
  %cmp96.26 = fcmp oge float %angle.0.26, 1.125000e+02
  %cmp100.26 = fcmp olt float %angle.0.26, 1.575000e+02
  %or.cond7.26 = and i1 %cmp96.26, %cmp100.26
  br i1 %or.cond7.26, label %if.then102.26, label %if.end118.26

if.then102.26:                                    ; preds = %if.else94.26
  %661 = trunc i64 %indvars.iv.26 to i32
  %sub105.26 = add i32 %661, %sub103.26
  %add106.26 = add i32 %sub105.26, -129
  %idxprom107.26 = sext i32 %add106.26 to i64
  %arrayidx108.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.26
  %662 = load float, float* %arrayidx108.26, align 4
  %add112.26 = add i32 %sub105.26, 129
  %idxprom113.26 = sext i32 %add112.26 to i64
  %arrayidx114.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.26
  %663 = load float, float* %arrayidx114.26, align 4
  br label %if.end118.26

if.then83.26:                                     ; preds = %if.else75.26
  %664 = add nsw i64 %658, %indvars.iv.26
  %arrayidx88.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %664
  %665 = load float, float* %arrayidx88.26, align 4
  %666 = add nsw i64 %657, %indvars.iv.26
  %arrayidx93.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %666
  %667 = load float, float* %arrayidx93.26, align 4
  br label %if.end118.26

if.then62.26:                                     ; preds = %if.else54.26
  %668 = trunc i64 %indvars.iv.26 to i32
  %sub65.26 = add i32 %668, %add63.26
  %add66.26 = add i32 %sub65.26, 127
  %idxprom67.26 = sext i32 %add66.26 to i64
  %arrayidx68.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.26
  %669 = load float, float* %arrayidx68.26, align 4
  %add72.26 = add i32 %sub65.26, -127
  %idxprom73.26 = sext i32 %add72.26 to i64
  %arrayidx74.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.26
  %670 = load float, float* %arrayidx74.26, align 4
  br label %if.end118.26

if.then43.26:                                     ; preds = %lor.lhs.false36.26, %if.else20.26
  %671 = trunc i64 %indvars.iv.26 to i32
  %add46.26 = add i32 %add45.26, %671
  %idxprom47.26 = sext i32 %add46.26 to i64
  %arrayidx48.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.26
  %672 = load float, float* %arrayidx48.26, align 4
  %673 = trunc i64 %indvars.iv.26 to i32
  %add51.26 = add i32 %sub50.26, %673
  %idxprom52.26 = sext i32 %add51.26 to i64
  %arrayidx53.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.26
  %674 = load float, float* %arrayidx53.26, align 4
  br label %if.end118.26

if.end118.26:                                     ; preds = %if.then43.26, %if.then62.26, %if.then83.26, %if.then102.26, %if.else94.26
  %q.3.26 = phi float [ %672, %if.then43.26 ], [ %669, %if.then62.26 ], [ %665, %if.then83.26 ], [ %662, %if.then102.26 ], [ 2.550000e+02, %if.else94.26 ]
  %r.3.26 = phi float [ %674, %if.then43.26 ], [ %670, %if.then62.26 ], [ %667, %if.then83.26 ], [ %663, %if.then102.26 ], [ 2.550000e+02, %if.else94.26 ]
  %arrayidx120.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %659
  %675 = load float, float* %arrayidx120.26, align 4
  %cmp121.26 = fcmp ult float %675, %q.3.26
  %cmp126.26 = fcmp ult float %675, %r.3.26
  %or.cond8.26 = or i1 %cmp121.26, %cmp126.26
  br i1 %or.cond8.26, label %if.else134.26, label %if.then128.26

if.then128.26:                                    ; preds = %if.end118.26
  %conv131.26 = fptoui float %675 to i32
  %arrayidx133.26 = getelementptr inbounds i32, i32* %., i64 %659
  store i32 %conv131.26, i32* %arrayidx133.26, align 4
  br label %for.inc.26

if.else134.26:                                    ; preds = %if.end118.26
  %arrayidx136.26 = getelementptr inbounds i32, i32* %., i64 %659
  store i32 0, i32* %arrayidx136.26, align 4
  br label %for.inc.26

if.then19.26:                                     ; preds = %for.body8.26
  %arrayidx.26 = getelementptr inbounds i32, i32* %., i64 %659
  store i32 0, i32* %arrayidx.26, align 4
  br label %for.inc.26

for.inc.26:                                       ; preds = %if.then19.26, %if.else134.26, %if.then128.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %img_width
  br i1 %exitcond.26, label %for.inc139.26, label %for.body8.26, !llvm.loop !1

for.inc139.26:                                    ; preds = %for.inc.26
  %indvars.iv.next20.26 = add nsw i64 %indvars.iv19, 27
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.27

for.body8.lr.ph.27:                               ; preds = %for.inc139.26
  %676 = trunc i64 %indvars.iv.next20.26 to i32
  %mul.27 = shl nsw i32 %676, 7
  %cmp11.27 = icmp eq i64 %indvars.iv.next20.26, %1
  %add45.27 = or i32 %mul.27, 1
  %sub50.27 = add i32 %mul.27, -1
  %677 = trunc i64 %indvars.iv.next20.26 to i32
  %add63.27 = shl i32 %677, 7
  %678 = trunc i64 %indvars.iv.next20.26 to i32
  %add84.27 = shl i32 %678, 7
  %mul85.27 = add i32 %add84.27, 128
  %mul90.27 = add i32 %add84.27, -128
  %679 = trunc i64 %indvars.iv.next20.26 to i32
  %sub103.27 = shl i32 %679, 7
  %680 = sext i32 %mul.27 to i64
  %681 = sext i32 %mul90.27 to i64
  %682 = sext i32 %mul85.27 to i64
  br label %for.body8.27

for.body8.27:                                     ; preds = %for.inc.27, %for.body8.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body8.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc.27 ]
  %683 = add nsw i64 %indvars.iv.27, %680
  %cmp14.27 = icmp eq i64 %indvars.iv.27, 0
  %or.cond1.27 = or i1 %cmp11.27, %cmp14.27
  %cmp17.27 = icmp eq i64 %indvars.iv.27, %0
  %or.cond2.27 = or i1 %cmp17.27, %or.cond1.27
  br i1 %or.cond2.27, label %if.then19.27, label %if.else20.27

if.else20.27:                                     ; preds = %for.body8.27
  %arrayidx22.27 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %683
  %684 = load float, float* %arrayidx22.27, align 4
  %conv23.27 = fpext float %684 to double
  %mul24.27 = fmul double %conv23.27, 0x404CA5DC1A63C1F8
  %conv25.27 = fptrunc double %mul24.27 to float
  %cmp26.27 = fcmp olt float %conv25.27, 0.000000e+00
  %add29.27 = fadd float %conv25.27, 1.800000e+02
  %angle.0.27 = select i1 %cmp26.27, float %add29.27, float %conv25.27
  %cmp31.27 = fcmp oge float %angle.0.27, 0.000000e+00
  %cmp34.27 = fcmp olt float %angle.0.27, 2.250000e+01
  %or.cond3.27 = and i1 %cmp31.27, %cmp34.27
  br i1 %or.cond3.27, label %if.then43.27, label %lor.lhs.false36.27

lor.lhs.false36.27:                               ; preds = %if.else20.27
  %cmp38.27 = fcmp ult float %angle.0.27, 1.575000e+02
  %cmp41.27 = fcmp ugt float %angle.0.27, 1.800000e+02
  %or.cond4.27 = or i1 %cmp38.27, %cmp41.27
  br i1 %or.cond4.27, label %if.else54.27, label %if.then43.27

if.else54.27:                                     ; preds = %lor.lhs.false36.27
  %cmp56.27 = fcmp oge float %angle.0.27, 2.250000e+01
  %cmp60.27 = fcmp olt float %angle.0.27, 6.750000e+01
  %or.cond5.27 = and i1 %cmp56.27, %cmp60.27
  br i1 %or.cond5.27, label %if.then62.27, label %if.else75.27

if.else75.27:                                     ; preds = %if.else54.27
  %cmp77.27 = fcmp oge float %angle.0.27, 6.750000e+01
  %cmp81.27 = fcmp olt float %angle.0.27, 1.125000e+02
  %or.cond6.27 = and i1 %cmp77.27, %cmp81.27
  br i1 %or.cond6.27, label %if.then83.27, label %if.else94.27

if.else94.27:                                     ; preds = %if.else75.27
  %cmp96.27 = fcmp oge float %angle.0.27, 1.125000e+02
  %cmp100.27 = fcmp olt float %angle.0.27, 1.575000e+02
  %or.cond7.27 = and i1 %cmp96.27, %cmp100.27
  br i1 %or.cond7.27, label %if.then102.27, label %if.end118.27

if.then102.27:                                    ; preds = %if.else94.27
  %685 = trunc i64 %indvars.iv.27 to i32
  %sub105.27 = add i32 %685, %sub103.27
  %add106.27 = add i32 %sub105.27, -129
  %idxprom107.27 = sext i32 %add106.27 to i64
  %arrayidx108.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.27
  %686 = load float, float* %arrayidx108.27, align 4
  %add112.27 = add i32 %sub105.27, 129
  %idxprom113.27 = sext i32 %add112.27 to i64
  %arrayidx114.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.27
  %687 = load float, float* %arrayidx114.27, align 4
  br label %if.end118.27

if.then83.27:                                     ; preds = %if.else75.27
  %688 = add nsw i64 %682, %indvars.iv.27
  %arrayidx88.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %688
  %689 = load float, float* %arrayidx88.27, align 4
  %690 = add nsw i64 %681, %indvars.iv.27
  %arrayidx93.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %690
  %691 = load float, float* %arrayidx93.27, align 4
  br label %if.end118.27

if.then62.27:                                     ; preds = %if.else54.27
  %692 = trunc i64 %indvars.iv.27 to i32
  %sub65.27 = add i32 %692, %add63.27
  %add66.27 = add i32 %sub65.27, 127
  %idxprom67.27 = sext i32 %add66.27 to i64
  %arrayidx68.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.27
  %693 = load float, float* %arrayidx68.27, align 4
  %add72.27 = add i32 %sub65.27, -127
  %idxprom73.27 = sext i32 %add72.27 to i64
  %arrayidx74.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.27
  %694 = load float, float* %arrayidx74.27, align 4
  br label %if.end118.27

if.then43.27:                                     ; preds = %lor.lhs.false36.27, %if.else20.27
  %695 = trunc i64 %indvars.iv.27 to i32
  %add46.27 = add i32 %add45.27, %695
  %idxprom47.27 = sext i32 %add46.27 to i64
  %arrayidx48.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.27
  %696 = load float, float* %arrayidx48.27, align 4
  %697 = trunc i64 %indvars.iv.27 to i32
  %add51.27 = add i32 %sub50.27, %697
  %idxprom52.27 = sext i32 %add51.27 to i64
  %arrayidx53.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.27
  %698 = load float, float* %arrayidx53.27, align 4
  br label %if.end118.27

if.end118.27:                                     ; preds = %if.then43.27, %if.then62.27, %if.then83.27, %if.then102.27, %if.else94.27
  %q.3.27 = phi float [ %696, %if.then43.27 ], [ %693, %if.then62.27 ], [ %689, %if.then83.27 ], [ %686, %if.then102.27 ], [ 2.550000e+02, %if.else94.27 ]
  %r.3.27 = phi float [ %698, %if.then43.27 ], [ %694, %if.then62.27 ], [ %691, %if.then83.27 ], [ %687, %if.then102.27 ], [ 2.550000e+02, %if.else94.27 ]
  %arrayidx120.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %683
  %699 = load float, float* %arrayidx120.27, align 4
  %cmp121.27 = fcmp ult float %699, %q.3.27
  %cmp126.27 = fcmp ult float %699, %r.3.27
  %or.cond8.27 = or i1 %cmp121.27, %cmp126.27
  br i1 %or.cond8.27, label %if.else134.27, label %if.then128.27

if.then128.27:                                    ; preds = %if.end118.27
  %conv131.27 = fptoui float %699 to i32
  %arrayidx133.27 = getelementptr inbounds i32, i32* %., i64 %683
  store i32 %conv131.27, i32* %arrayidx133.27, align 4
  br label %for.inc.27

if.else134.27:                                    ; preds = %if.end118.27
  %arrayidx136.27 = getelementptr inbounds i32, i32* %., i64 %683
  store i32 0, i32* %arrayidx136.27, align 4
  br label %for.inc.27

if.then19.27:                                     ; preds = %for.body8.27
  %arrayidx.27 = getelementptr inbounds i32, i32* %., i64 %683
  store i32 0, i32* %arrayidx.27, align 4
  br label %for.inc.27

for.inc.27:                                       ; preds = %if.then19.27, %if.else134.27, %if.then128.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %img_width
  br i1 %exitcond.27, label %for.inc139.27, label %for.body8.27, !llvm.loop !1

for.inc139.27:                                    ; preds = %for.inc.27
  %indvars.iv.next20.27 = add nsw i64 %indvars.iv19, 28
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.28

for.body8.lr.ph.28:                               ; preds = %for.inc139.27
  %700 = trunc i64 %indvars.iv.next20.27 to i32
  %mul.28 = shl nsw i32 %700, 7
  %cmp11.28 = icmp eq i64 %indvars.iv.next20.27, %1
  %add45.28 = or i32 %mul.28, 1
  %sub50.28 = add i32 %mul.28, -1
  %701 = trunc i64 %indvars.iv.next20.27 to i32
  %add63.28 = shl i32 %701, 7
  %702 = trunc i64 %indvars.iv.next20.27 to i32
  %add84.28 = shl i32 %702, 7
  %mul85.28 = add i32 %add84.28, 128
  %mul90.28 = add i32 %add84.28, -128
  %703 = trunc i64 %indvars.iv.next20.27 to i32
  %sub103.28 = shl i32 %703, 7
  %704 = sext i32 %mul.28 to i64
  %705 = sext i32 %mul90.28 to i64
  %706 = sext i32 %mul85.28 to i64
  br label %for.body8.28

for.body8.28:                                     ; preds = %for.inc.28, %for.body8.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body8.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc.28 ]
  %707 = add nsw i64 %indvars.iv.28, %704
  %cmp14.28 = icmp eq i64 %indvars.iv.28, 0
  %or.cond1.28 = or i1 %cmp11.28, %cmp14.28
  %cmp17.28 = icmp eq i64 %indvars.iv.28, %0
  %or.cond2.28 = or i1 %cmp17.28, %or.cond1.28
  br i1 %or.cond2.28, label %if.then19.28, label %if.else20.28

if.else20.28:                                     ; preds = %for.body8.28
  %arrayidx22.28 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %707
  %708 = load float, float* %arrayidx22.28, align 4
  %conv23.28 = fpext float %708 to double
  %mul24.28 = fmul double %conv23.28, 0x404CA5DC1A63C1F8
  %conv25.28 = fptrunc double %mul24.28 to float
  %cmp26.28 = fcmp olt float %conv25.28, 0.000000e+00
  %add29.28 = fadd float %conv25.28, 1.800000e+02
  %angle.0.28 = select i1 %cmp26.28, float %add29.28, float %conv25.28
  %cmp31.28 = fcmp oge float %angle.0.28, 0.000000e+00
  %cmp34.28 = fcmp olt float %angle.0.28, 2.250000e+01
  %or.cond3.28 = and i1 %cmp31.28, %cmp34.28
  br i1 %or.cond3.28, label %if.then43.28, label %lor.lhs.false36.28

lor.lhs.false36.28:                               ; preds = %if.else20.28
  %cmp38.28 = fcmp ult float %angle.0.28, 1.575000e+02
  %cmp41.28 = fcmp ugt float %angle.0.28, 1.800000e+02
  %or.cond4.28 = or i1 %cmp38.28, %cmp41.28
  br i1 %or.cond4.28, label %if.else54.28, label %if.then43.28

if.else54.28:                                     ; preds = %lor.lhs.false36.28
  %cmp56.28 = fcmp oge float %angle.0.28, 2.250000e+01
  %cmp60.28 = fcmp olt float %angle.0.28, 6.750000e+01
  %or.cond5.28 = and i1 %cmp56.28, %cmp60.28
  br i1 %or.cond5.28, label %if.then62.28, label %if.else75.28

if.else75.28:                                     ; preds = %if.else54.28
  %cmp77.28 = fcmp oge float %angle.0.28, 6.750000e+01
  %cmp81.28 = fcmp olt float %angle.0.28, 1.125000e+02
  %or.cond6.28 = and i1 %cmp77.28, %cmp81.28
  br i1 %or.cond6.28, label %if.then83.28, label %if.else94.28

if.else94.28:                                     ; preds = %if.else75.28
  %cmp96.28 = fcmp oge float %angle.0.28, 1.125000e+02
  %cmp100.28 = fcmp olt float %angle.0.28, 1.575000e+02
  %or.cond7.28 = and i1 %cmp96.28, %cmp100.28
  br i1 %or.cond7.28, label %if.then102.28, label %if.end118.28

if.then102.28:                                    ; preds = %if.else94.28
  %709 = trunc i64 %indvars.iv.28 to i32
  %sub105.28 = add i32 %709, %sub103.28
  %add106.28 = add i32 %sub105.28, -129
  %idxprom107.28 = sext i32 %add106.28 to i64
  %arrayidx108.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.28
  %710 = load float, float* %arrayidx108.28, align 4
  %add112.28 = add i32 %sub105.28, 129
  %idxprom113.28 = sext i32 %add112.28 to i64
  %arrayidx114.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.28
  %711 = load float, float* %arrayidx114.28, align 4
  br label %if.end118.28

if.then83.28:                                     ; preds = %if.else75.28
  %712 = add nsw i64 %706, %indvars.iv.28
  %arrayidx88.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %712
  %713 = load float, float* %arrayidx88.28, align 4
  %714 = add nsw i64 %705, %indvars.iv.28
  %arrayidx93.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %714
  %715 = load float, float* %arrayidx93.28, align 4
  br label %if.end118.28

if.then62.28:                                     ; preds = %if.else54.28
  %716 = trunc i64 %indvars.iv.28 to i32
  %sub65.28 = add i32 %716, %add63.28
  %add66.28 = add i32 %sub65.28, 127
  %idxprom67.28 = sext i32 %add66.28 to i64
  %arrayidx68.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.28
  %717 = load float, float* %arrayidx68.28, align 4
  %add72.28 = add i32 %sub65.28, -127
  %idxprom73.28 = sext i32 %add72.28 to i64
  %arrayidx74.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.28
  %718 = load float, float* %arrayidx74.28, align 4
  br label %if.end118.28

if.then43.28:                                     ; preds = %lor.lhs.false36.28, %if.else20.28
  %719 = trunc i64 %indvars.iv.28 to i32
  %add46.28 = add i32 %add45.28, %719
  %idxprom47.28 = sext i32 %add46.28 to i64
  %arrayidx48.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.28
  %720 = load float, float* %arrayidx48.28, align 4
  %721 = trunc i64 %indvars.iv.28 to i32
  %add51.28 = add i32 %sub50.28, %721
  %idxprom52.28 = sext i32 %add51.28 to i64
  %arrayidx53.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.28
  %722 = load float, float* %arrayidx53.28, align 4
  br label %if.end118.28

if.end118.28:                                     ; preds = %if.then43.28, %if.then62.28, %if.then83.28, %if.then102.28, %if.else94.28
  %q.3.28 = phi float [ %720, %if.then43.28 ], [ %717, %if.then62.28 ], [ %713, %if.then83.28 ], [ %710, %if.then102.28 ], [ 2.550000e+02, %if.else94.28 ]
  %r.3.28 = phi float [ %722, %if.then43.28 ], [ %718, %if.then62.28 ], [ %715, %if.then83.28 ], [ %711, %if.then102.28 ], [ 2.550000e+02, %if.else94.28 ]
  %arrayidx120.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %707
  %723 = load float, float* %arrayidx120.28, align 4
  %cmp121.28 = fcmp ult float %723, %q.3.28
  %cmp126.28 = fcmp ult float %723, %r.3.28
  %or.cond8.28 = or i1 %cmp121.28, %cmp126.28
  br i1 %or.cond8.28, label %if.else134.28, label %if.then128.28

if.then128.28:                                    ; preds = %if.end118.28
  %conv131.28 = fptoui float %723 to i32
  %arrayidx133.28 = getelementptr inbounds i32, i32* %., i64 %707
  store i32 %conv131.28, i32* %arrayidx133.28, align 4
  br label %for.inc.28

if.else134.28:                                    ; preds = %if.end118.28
  %arrayidx136.28 = getelementptr inbounds i32, i32* %., i64 %707
  store i32 0, i32* %arrayidx136.28, align 4
  br label %for.inc.28

if.then19.28:                                     ; preds = %for.body8.28
  %arrayidx.28 = getelementptr inbounds i32, i32* %., i64 %707
  store i32 0, i32* %arrayidx.28, align 4
  br label %for.inc.28

for.inc.28:                                       ; preds = %if.then19.28, %if.else134.28, %if.then128.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %img_width
  br i1 %exitcond.28, label %for.inc139.28, label %for.body8.28, !llvm.loop !1

for.inc139.28:                                    ; preds = %for.inc.28
  %indvars.iv.next20.28 = add nsw i64 %indvars.iv19, 29
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.29

for.body8.lr.ph.29:                               ; preds = %for.inc139.28
  %724 = trunc i64 %indvars.iv.next20.28 to i32
  %mul.29 = shl nsw i32 %724, 7
  %cmp11.29 = icmp eq i64 %indvars.iv.next20.28, %1
  %add45.29 = or i32 %mul.29, 1
  %sub50.29 = add i32 %mul.29, -1
  %725 = trunc i64 %indvars.iv.next20.28 to i32
  %add63.29 = shl i32 %725, 7
  %726 = trunc i64 %indvars.iv.next20.28 to i32
  %add84.29 = shl i32 %726, 7
  %mul85.29 = add i32 %add84.29, 128
  %mul90.29 = add i32 %add84.29, -128
  %727 = trunc i64 %indvars.iv.next20.28 to i32
  %sub103.29 = shl i32 %727, 7
  %728 = sext i32 %mul.29 to i64
  %729 = sext i32 %mul90.29 to i64
  %730 = sext i32 %mul85.29 to i64
  br label %for.body8.29

for.body8.29:                                     ; preds = %for.inc.29, %for.body8.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body8.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc.29 ]
  %731 = add nsw i64 %indvars.iv.29, %728
  %cmp14.29 = icmp eq i64 %indvars.iv.29, 0
  %or.cond1.29 = or i1 %cmp11.29, %cmp14.29
  %cmp17.29 = icmp eq i64 %indvars.iv.29, %0
  %or.cond2.29 = or i1 %cmp17.29, %or.cond1.29
  br i1 %or.cond2.29, label %if.then19.29, label %if.else20.29

if.else20.29:                                     ; preds = %for.body8.29
  %arrayidx22.29 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %731
  %732 = load float, float* %arrayidx22.29, align 4
  %conv23.29 = fpext float %732 to double
  %mul24.29 = fmul double %conv23.29, 0x404CA5DC1A63C1F8
  %conv25.29 = fptrunc double %mul24.29 to float
  %cmp26.29 = fcmp olt float %conv25.29, 0.000000e+00
  %add29.29 = fadd float %conv25.29, 1.800000e+02
  %angle.0.29 = select i1 %cmp26.29, float %add29.29, float %conv25.29
  %cmp31.29 = fcmp oge float %angle.0.29, 0.000000e+00
  %cmp34.29 = fcmp olt float %angle.0.29, 2.250000e+01
  %or.cond3.29 = and i1 %cmp31.29, %cmp34.29
  br i1 %or.cond3.29, label %if.then43.29, label %lor.lhs.false36.29

lor.lhs.false36.29:                               ; preds = %if.else20.29
  %cmp38.29 = fcmp ult float %angle.0.29, 1.575000e+02
  %cmp41.29 = fcmp ugt float %angle.0.29, 1.800000e+02
  %or.cond4.29 = or i1 %cmp38.29, %cmp41.29
  br i1 %or.cond4.29, label %if.else54.29, label %if.then43.29

if.else54.29:                                     ; preds = %lor.lhs.false36.29
  %cmp56.29 = fcmp oge float %angle.0.29, 2.250000e+01
  %cmp60.29 = fcmp olt float %angle.0.29, 6.750000e+01
  %or.cond5.29 = and i1 %cmp56.29, %cmp60.29
  br i1 %or.cond5.29, label %if.then62.29, label %if.else75.29

if.else75.29:                                     ; preds = %if.else54.29
  %cmp77.29 = fcmp oge float %angle.0.29, 6.750000e+01
  %cmp81.29 = fcmp olt float %angle.0.29, 1.125000e+02
  %or.cond6.29 = and i1 %cmp77.29, %cmp81.29
  br i1 %or.cond6.29, label %if.then83.29, label %if.else94.29

if.else94.29:                                     ; preds = %if.else75.29
  %cmp96.29 = fcmp oge float %angle.0.29, 1.125000e+02
  %cmp100.29 = fcmp olt float %angle.0.29, 1.575000e+02
  %or.cond7.29 = and i1 %cmp96.29, %cmp100.29
  br i1 %or.cond7.29, label %if.then102.29, label %if.end118.29

if.then102.29:                                    ; preds = %if.else94.29
  %733 = trunc i64 %indvars.iv.29 to i32
  %sub105.29 = add i32 %733, %sub103.29
  %add106.29 = add i32 %sub105.29, -129
  %idxprom107.29 = sext i32 %add106.29 to i64
  %arrayidx108.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.29
  %734 = load float, float* %arrayidx108.29, align 4
  %add112.29 = add i32 %sub105.29, 129
  %idxprom113.29 = sext i32 %add112.29 to i64
  %arrayidx114.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.29
  %735 = load float, float* %arrayidx114.29, align 4
  br label %if.end118.29

if.then83.29:                                     ; preds = %if.else75.29
  %736 = add nsw i64 %730, %indvars.iv.29
  %arrayidx88.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %736
  %737 = load float, float* %arrayidx88.29, align 4
  %738 = add nsw i64 %729, %indvars.iv.29
  %arrayidx93.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %738
  %739 = load float, float* %arrayidx93.29, align 4
  br label %if.end118.29

if.then62.29:                                     ; preds = %if.else54.29
  %740 = trunc i64 %indvars.iv.29 to i32
  %sub65.29 = add i32 %740, %add63.29
  %add66.29 = add i32 %sub65.29, 127
  %idxprom67.29 = sext i32 %add66.29 to i64
  %arrayidx68.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.29
  %741 = load float, float* %arrayidx68.29, align 4
  %add72.29 = add i32 %sub65.29, -127
  %idxprom73.29 = sext i32 %add72.29 to i64
  %arrayidx74.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.29
  %742 = load float, float* %arrayidx74.29, align 4
  br label %if.end118.29

if.then43.29:                                     ; preds = %lor.lhs.false36.29, %if.else20.29
  %743 = trunc i64 %indvars.iv.29 to i32
  %add46.29 = add i32 %add45.29, %743
  %idxprom47.29 = sext i32 %add46.29 to i64
  %arrayidx48.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.29
  %744 = load float, float* %arrayidx48.29, align 4
  %745 = trunc i64 %indvars.iv.29 to i32
  %add51.29 = add i32 %sub50.29, %745
  %idxprom52.29 = sext i32 %add51.29 to i64
  %arrayidx53.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.29
  %746 = load float, float* %arrayidx53.29, align 4
  br label %if.end118.29

if.end118.29:                                     ; preds = %if.then43.29, %if.then62.29, %if.then83.29, %if.then102.29, %if.else94.29
  %q.3.29 = phi float [ %744, %if.then43.29 ], [ %741, %if.then62.29 ], [ %737, %if.then83.29 ], [ %734, %if.then102.29 ], [ 2.550000e+02, %if.else94.29 ]
  %r.3.29 = phi float [ %746, %if.then43.29 ], [ %742, %if.then62.29 ], [ %739, %if.then83.29 ], [ %735, %if.then102.29 ], [ 2.550000e+02, %if.else94.29 ]
  %arrayidx120.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %731
  %747 = load float, float* %arrayidx120.29, align 4
  %cmp121.29 = fcmp ult float %747, %q.3.29
  %cmp126.29 = fcmp ult float %747, %r.3.29
  %or.cond8.29 = or i1 %cmp121.29, %cmp126.29
  br i1 %or.cond8.29, label %if.else134.29, label %if.then128.29

if.then128.29:                                    ; preds = %if.end118.29
  %conv131.29 = fptoui float %747 to i32
  %arrayidx133.29 = getelementptr inbounds i32, i32* %., i64 %731
  store i32 %conv131.29, i32* %arrayidx133.29, align 4
  br label %for.inc.29

if.else134.29:                                    ; preds = %if.end118.29
  %arrayidx136.29 = getelementptr inbounds i32, i32* %., i64 %731
  store i32 0, i32* %arrayidx136.29, align 4
  br label %for.inc.29

if.then19.29:                                     ; preds = %for.body8.29
  %arrayidx.29 = getelementptr inbounds i32, i32* %., i64 %731
  store i32 0, i32* %arrayidx.29, align 4
  br label %for.inc.29

for.inc.29:                                       ; preds = %if.then19.29, %if.else134.29, %if.then128.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %img_width
  br i1 %exitcond.29, label %for.inc139.29, label %for.body8.29, !llvm.loop !1

for.inc139.29:                                    ; preds = %for.inc.29
  %indvars.iv.next20.29 = add nsw i64 %indvars.iv19, 30
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.30

for.body8.lr.ph.30:                               ; preds = %for.inc139.29
  %748 = trunc i64 %indvars.iv.next20.29 to i32
  %mul.30 = shl nsw i32 %748, 7
  %cmp11.30 = icmp eq i64 %indvars.iv.next20.29, %1
  %add45.30 = or i32 %mul.30, 1
  %sub50.30 = add i32 %mul.30, -1
  %749 = trunc i64 %indvars.iv.next20.29 to i32
  %add63.30 = shl i32 %749, 7
  %750 = trunc i64 %indvars.iv.next20.29 to i32
  %add84.30 = shl i32 %750, 7
  %mul85.30 = add i32 %add84.30, 128
  %mul90.30 = add i32 %add84.30, -128
  %751 = trunc i64 %indvars.iv.next20.29 to i32
  %sub103.30 = shl i32 %751, 7
  %752 = sext i32 %mul.30 to i64
  %753 = sext i32 %mul90.30 to i64
  %754 = sext i32 %mul85.30 to i64
  br label %for.body8.30

for.body8.30:                                     ; preds = %for.inc.30, %for.body8.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body8.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc.30 ]
  %755 = add nsw i64 %indvars.iv.30, %752
  %cmp14.30 = icmp eq i64 %indvars.iv.30, 0
  %or.cond1.30 = or i1 %cmp11.30, %cmp14.30
  %cmp17.30 = icmp eq i64 %indvars.iv.30, %0
  %or.cond2.30 = or i1 %cmp17.30, %or.cond1.30
  br i1 %or.cond2.30, label %if.then19.30, label %if.else20.30

if.else20.30:                                     ; preds = %for.body8.30
  %arrayidx22.30 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %755
  %756 = load float, float* %arrayidx22.30, align 4
  %conv23.30 = fpext float %756 to double
  %mul24.30 = fmul double %conv23.30, 0x404CA5DC1A63C1F8
  %conv25.30 = fptrunc double %mul24.30 to float
  %cmp26.30 = fcmp olt float %conv25.30, 0.000000e+00
  %add29.30 = fadd float %conv25.30, 1.800000e+02
  %angle.0.30 = select i1 %cmp26.30, float %add29.30, float %conv25.30
  %cmp31.30 = fcmp oge float %angle.0.30, 0.000000e+00
  %cmp34.30 = fcmp olt float %angle.0.30, 2.250000e+01
  %or.cond3.30 = and i1 %cmp31.30, %cmp34.30
  br i1 %or.cond3.30, label %if.then43.30, label %lor.lhs.false36.30

lor.lhs.false36.30:                               ; preds = %if.else20.30
  %cmp38.30 = fcmp ult float %angle.0.30, 1.575000e+02
  %cmp41.30 = fcmp ugt float %angle.0.30, 1.800000e+02
  %or.cond4.30 = or i1 %cmp38.30, %cmp41.30
  br i1 %or.cond4.30, label %if.else54.30, label %if.then43.30

if.else54.30:                                     ; preds = %lor.lhs.false36.30
  %cmp56.30 = fcmp oge float %angle.0.30, 2.250000e+01
  %cmp60.30 = fcmp olt float %angle.0.30, 6.750000e+01
  %or.cond5.30 = and i1 %cmp56.30, %cmp60.30
  br i1 %or.cond5.30, label %if.then62.30, label %if.else75.30

if.else75.30:                                     ; preds = %if.else54.30
  %cmp77.30 = fcmp oge float %angle.0.30, 6.750000e+01
  %cmp81.30 = fcmp olt float %angle.0.30, 1.125000e+02
  %or.cond6.30 = and i1 %cmp77.30, %cmp81.30
  br i1 %or.cond6.30, label %if.then83.30, label %if.else94.30

if.else94.30:                                     ; preds = %if.else75.30
  %cmp96.30 = fcmp oge float %angle.0.30, 1.125000e+02
  %cmp100.30 = fcmp olt float %angle.0.30, 1.575000e+02
  %or.cond7.30 = and i1 %cmp96.30, %cmp100.30
  br i1 %or.cond7.30, label %if.then102.30, label %if.end118.30

if.then102.30:                                    ; preds = %if.else94.30
  %757 = trunc i64 %indvars.iv.30 to i32
  %sub105.30 = add i32 %757, %sub103.30
  %add106.30 = add i32 %sub105.30, -129
  %idxprom107.30 = sext i32 %add106.30 to i64
  %arrayidx108.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.30
  %758 = load float, float* %arrayidx108.30, align 4
  %add112.30 = add i32 %sub105.30, 129
  %idxprom113.30 = sext i32 %add112.30 to i64
  %arrayidx114.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.30
  %759 = load float, float* %arrayidx114.30, align 4
  br label %if.end118.30

if.then83.30:                                     ; preds = %if.else75.30
  %760 = add nsw i64 %754, %indvars.iv.30
  %arrayidx88.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %760
  %761 = load float, float* %arrayidx88.30, align 4
  %762 = add nsw i64 %753, %indvars.iv.30
  %arrayidx93.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %762
  %763 = load float, float* %arrayidx93.30, align 4
  br label %if.end118.30

if.then62.30:                                     ; preds = %if.else54.30
  %764 = trunc i64 %indvars.iv.30 to i32
  %sub65.30 = add i32 %764, %add63.30
  %add66.30 = add i32 %sub65.30, 127
  %idxprom67.30 = sext i32 %add66.30 to i64
  %arrayidx68.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.30
  %765 = load float, float* %arrayidx68.30, align 4
  %add72.30 = add i32 %sub65.30, -127
  %idxprom73.30 = sext i32 %add72.30 to i64
  %arrayidx74.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.30
  %766 = load float, float* %arrayidx74.30, align 4
  br label %if.end118.30

if.then43.30:                                     ; preds = %lor.lhs.false36.30, %if.else20.30
  %767 = trunc i64 %indvars.iv.30 to i32
  %add46.30 = add i32 %add45.30, %767
  %idxprom47.30 = sext i32 %add46.30 to i64
  %arrayidx48.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.30
  %768 = load float, float* %arrayidx48.30, align 4
  %769 = trunc i64 %indvars.iv.30 to i32
  %add51.30 = add i32 %sub50.30, %769
  %idxprom52.30 = sext i32 %add51.30 to i64
  %arrayidx53.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.30
  %770 = load float, float* %arrayidx53.30, align 4
  br label %if.end118.30

if.end118.30:                                     ; preds = %if.then43.30, %if.then62.30, %if.then83.30, %if.then102.30, %if.else94.30
  %q.3.30 = phi float [ %768, %if.then43.30 ], [ %765, %if.then62.30 ], [ %761, %if.then83.30 ], [ %758, %if.then102.30 ], [ 2.550000e+02, %if.else94.30 ]
  %r.3.30 = phi float [ %770, %if.then43.30 ], [ %766, %if.then62.30 ], [ %763, %if.then83.30 ], [ %759, %if.then102.30 ], [ 2.550000e+02, %if.else94.30 ]
  %arrayidx120.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %755
  %771 = load float, float* %arrayidx120.30, align 4
  %cmp121.30 = fcmp ult float %771, %q.3.30
  %cmp126.30 = fcmp ult float %771, %r.3.30
  %or.cond8.30 = or i1 %cmp121.30, %cmp126.30
  br i1 %or.cond8.30, label %if.else134.30, label %if.then128.30

if.then128.30:                                    ; preds = %if.end118.30
  %conv131.30 = fptoui float %771 to i32
  %arrayidx133.30 = getelementptr inbounds i32, i32* %., i64 %755
  store i32 %conv131.30, i32* %arrayidx133.30, align 4
  br label %for.inc.30

if.else134.30:                                    ; preds = %if.end118.30
  %arrayidx136.30 = getelementptr inbounds i32, i32* %., i64 %755
  store i32 0, i32* %arrayidx136.30, align 4
  br label %for.inc.30

if.then19.30:                                     ; preds = %for.body8.30
  %arrayidx.30 = getelementptr inbounds i32, i32* %., i64 %755
  store i32 0, i32* %arrayidx.30, align 4
  br label %for.inc.30

for.inc.30:                                       ; preds = %if.then19.30, %if.else134.30, %if.then128.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %img_width
  br i1 %exitcond.30, label %for.inc139.30, label %for.body8.30, !llvm.loop !1

for.inc139.30:                                    ; preds = %for.inc.30
  %indvars.iv.next20.30 = add nsw i64 %indvars.iv19, 31
  br i1 %cmp69, label %for.inc139.31, label %for.body8.lr.ph.31

for.body8.lr.ph.31:                               ; preds = %for.inc139.30
  %772 = trunc i64 %indvars.iv.next20.30 to i32
  %mul.31 = shl nsw i32 %772, 7
  %cmp11.31 = icmp eq i64 %indvars.iv.next20.30, %1
  %add45.31 = or i32 %mul.31, 1
  %sub50.31 = add i32 %mul.31, -1
  %773 = trunc i64 %indvars.iv.next20.30 to i32
  %add63.31 = shl i32 %773, 7
  %774 = trunc i64 %indvars.iv.next20.30 to i32
  %add84.31 = shl i32 %774, 7
  %mul85.31 = add i32 %add84.31, 128
  %mul90.31 = add i32 %add84.31, -128
  %775 = trunc i64 %indvars.iv.next20.30 to i32
  %sub103.31 = shl i32 %775, 7
  %776 = sext i32 %mul.31 to i64
  %777 = sext i32 %mul90.31 to i64
  %778 = sext i32 %mul85.31 to i64
  br label %for.body8.31

for.body8.31:                                     ; preds = %for.inc.31, %for.body8.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body8.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc.31 ]
  %779 = add nsw i64 %indvars.iv.31, %776
  %cmp14.31 = icmp eq i64 %indvars.iv.31, 0
  %or.cond1.31 = or i1 %cmp11.31, %cmp14.31
  %cmp17.31 = icmp eq i64 %indvars.iv.31, %0
  %or.cond2.31 = or i1 %cmp17.31, %or.cond1.31
  br i1 %or.cond2.31, label %if.then19.31, label %if.else20.31

if.else20.31:                                     ; preds = %for.body8.31
  %arrayidx22.31 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %779
  %780 = load float, float* %arrayidx22.31, align 4
  %conv23.31 = fpext float %780 to double
  %mul24.31 = fmul double %conv23.31, 0x404CA5DC1A63C1F8
  %conv25.31 = fptrunc double %mul24.31 to float
  %cmp26.31 = fcmp olt float %conv25.31, 0.000000e+00
  %add29.31 = fadd float %conv25.31, 1.800000e+02
  %angle.0.31 = select i1 %cmp26.31, float %add29.31, float %conv25.31
  %cmp31.31 = fcmp oge float %angle.0.31, 0.000000e+00
  %cmp34.31 = fcmp olt float %angle.0.31, 2.250000e+01
  %or.cond3.31 = and i1 %cmp31.31, %cmp34.31
  br i1 %or.cond3.31, label %if.then43.31, label %lor.lhs.false36.31

lor.lhs.false36.31:                               ; preds = %if.else20.31
  %cmp38.31 = fcmp ult float %angle.0.31, 1.575000e+02
  %cmp41.31 = fcmp ugt float %angle.0.31, 1.800000e+02
  %or.cond4.31 = or i1 %cmp38.31, %cmp41.31
  br i1 %or.cond4.31, label %if.else54.31, label %if.then43.31

if.else54.31:                                     ; preds = %lor.lhs.false36.31
  %cmp56.31 = fcmp oge float %angle.0.31, 2.250000e+01
  %cmp60.31 = fcmp olt float %angle.0.31, 6.750000e+01
  %or.cond5.31 = and i1 %cmp56.31, %cmp60.31
  br i1 %or.cond5.31, label %if.then62.31, label %if.else75.31

if.else75.31:                                     ; preds = %if.else54.31
  %cmp77.31 = fcmp oge float %angle.0.31, 6.750000e+01
  %cmp81.31 = fcmp olt float %angle.0.31, 1.125000e+02
  %or.cond6.31 = and i1 %cmp77.31, %cmp81.31
  br i1 %or.cond6.31, label %if.then83.31, label %if.else94.31

if.else94.31:                                     ; preds = %if.else75.31
  %cmp96.31 = fcmp oge float %angle.0.31, 1.125000e+02
  %cmp100.31 = fcmp olt float %angle.0.31, 1.575000e+02
  %or.cond7.31 = and i1 %cmp96.31, %cmp100.31
  br i1 %or.cond7.31, label %if.then102.31, label %if.end118.31

if.then102.31:                                    ; preds = %if.else94.31
  %781 = trunc i64 %indvars.iv.31 to i32
  %sub105.31 = add i32 %781, %sub103.31
  %add106.31 = add i32 %sub105.31, -129
  %idxprom107.31 = sext i32 %add106.31 to i64
  %arrayidx108.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom107.31
  %782 = load float, float* %arrayidx108.31, align 4
  %add112.31 = add i32 %sub105.31, 129
  %idxprom113.31 = sext i32 %add112.31 to i64
  %arrayidx114.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom113.31
  %783 = load float, float* %arrayidx114.31, align 4
  br label %if.end118.31

if.then83.31:                                     ; preds = %if.else75.31
  %784 = add nsw i64 %778, %indvars.iv.31
  %arrayidx88.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %784
  %785 = load float, float* %arrayidx88.31, align 4
  %786 = add nsw i64 %777, %indvars.iv.31
  %arrayidx93.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %786
  %787 = load float, float* %arrayidx93.31, align 4
  br label %if.end118.31

if.then62.31:                                     ; preds = %if.else54.31
  %788 = trunc i64 %indvars.iv.31 to i32
  %sub65.31 = add i32 %788, %add63.31
  %add66.31 = add i32 %sub65.31, 127
  %idxprom67.31 = sext i32 %add66.31 to i64
  %arrayidx68.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom67.31
  %789 = load float, float* %arrayidx68.31, align 4
  %add72.31 = add i32 %sub65.31, -127
  %idxprom73.31 = sext i32 %add72.31 to i64
  %arrayidx74.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom73.31
  %790 = load float, float* %arrayidx74.31, align 4
  br label %if.end118.31

if.then43.31:                                     ; preds = %lor.lhs.false36.31, %if.else20.31
  %791 = trunc i64 %indvars.iv.31 to i32
  %add46.31 = add i32 %add45.31, %791
  %idxprom47.31 = sext i32 %add46.31 to i64
  %arrayidx48.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.31
  %792 = load float, float* %arrayidx48.31, align 4
  %793 = trunc i64 %indvars.iv.31 to i32
  %add51.31 = add i32 %sub50.31, %793
  %idxprom52.31 = sext i32 %add51.31 to i64
  %arrayidx53.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom52.31
  %794 = load float, float* %arrayidx53.31, align 4
  br label %if.end118.31

if.end118.31:                                     ; preds = %if.then43.31, %if.then62.31, %if.then83.31, %if.then102.31, %if.else94.31
  %q.3.31 = phi float [ %792, %if.then43.31 ], [ %789, %if.then62.31 ], [ %785, %if.then83.31 ], [ %782, %if.then102.31 ], [ 2.550000e+02, %if.else94.31 ]
  %r.3.31 = phi float [ %794, %if.then43.31 ], [ %790, %if.then62.31 ], [ %787, %if.then83.31 ], [ %783, %if.then102.31 ], [ 2.550000e+02, %if.else94.31 ]
  %arrayidx120.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %779
  %795 = load float, float* %arrayidx120.31, align 4
  %cmp121.31 = fcmp ult float %795, %q.3.31
  %cmp126.31 = fcmp ult float %795, %r.3.31
  %or.cond8.31 = or i1 %cmp121.31, %cmp126.31
  br i1 %or.cond8.31, label %if.else134.31, label %if.then128.31

if.then128.31:                                    ; preds = %if.end118.31
  %conv131.31 = fptoui float %795 to i32
  %arrayidx133.31 = getelementptr inbounds i32, i32* %., i64 %779
  store i32 %conv131.31, i32* %arrayidx133.31, align 4
  br label %for.inc.31

if.else134.31:                                    ; preds = %if.end118.31
  %arrayidx136.31 = getelementptr inbounds i32, i32* %., i64 %779
  store i32 0, i32* %arrayidx136.31, align 4
  br label %for.inc.31

if.then19.31:                                     ; preds = %for.body8.31
  %arrayidx.31 = getelementptr inbounds i32, i32* %., i64 %779
  store i32 0, i32* %arrayidx.31, align 4
  br label %for.inc.31

for.inc.31:                                       ; preds = %if.then19.31, %if.else134.31, %if.then128.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %img_width
  br i1 %exitcond.31, label %for.inc139.31.loopexit, label %for.body8.31, !llvm.loop !1

for.inc139.31.loopexit:                           ; preds = %for.inc.31
  br label %for.inc139.31

for.inc139.31:                                    ; preds = %for.inc139.31.loopexit, %for.cond5.preheader, %for.inc139, %for.inc139.1, %for.inc139.2, %for.inc139.3, %for.inc139.4, %for.inc139.5, %for.inc139.6, %for.inc139.7, %for.inc139.8, %for.inc139.9, %for.inc139.10, %for.inc139.11, %for.inc139.12, %for.inc139.13, %for.inc139.14, %for.inc139.15, %for.inc139.16, %for.inc139.17, %for.inc139.18, %for.inc139.19, %for.inc139.20, %for.inc139.21, %for.inc139.22, %for.inc139.23, %for.inc139.24, %for.inc139.25, %for.inc139.26, %for.inc139.27, %for.inc139.28, %for.inc139.29, %for.inc139.30
  %indvars.iv.next20.31 = add nsw i64 %indvars.iv19, 32
  %lftr.wideiv21.31 = trunc i64 %indvars.iv.next20.31 to i32
  %exitcond22.31 = icmp eq i32 %lftr.wideiv21.31, %img_height
  br i1 %exitcond22.31, label %for.end141.loopexit, label %for.cond5.preheader, !llvm.loop !4
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
