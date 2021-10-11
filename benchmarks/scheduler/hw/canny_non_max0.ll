; ModuleID = 'canny_non_max0.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @canny_non_max(i32 %img_height, i32 %img_width, i32 %output_spm_addr) #0 {
entry:
  %conv = zext i32 %output_spm_addr to i64
  %0 = inttoptr i64 %conv to i32*
  %cmp13 = icmp eq i32 %img_height, 0
  br i1 %cmp13, label %for.end136, label %for.cond3.preheader.lr.ph

for.cond3.preheader.lr.ph:                        ; preds = %entry
  %sub1 = add i32 %img_width, -1
  %sub = add i32 %img_height, -1
  %cmp49 = icmp eq i32 %img_width, 0
  %1 = zext i32 %sub1 to i64
  %2 = zext i32 %sub to i64
  %3 = add i32 %img_height, -1
  %xtraiter = and i32 %img_height, 31
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond3.preheader.lr.ph.split, label %for.cond3.preheader.prol.preheader

for.cond3.preheader.prol.preheader:               ; preds = %for.cond3.preheader.lr.ph
  br label %for.cond3.preheader.prol

for.cond3.preheader.prol:                         ; preds = %for.cond3.preheader.prol.preheader, %for.inc134.prol
  %indvars.iv19.prol = phi i64 [ %indvars.iv.next20.prol, %for.inc134.prol ], [ 0, %for.cond3.preheader.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.inc134.prol ], [ %xtraiter, %for.cond3.preheader.prol.preheader ]
  br i1 %cmp49, label %for.inc134.prol, label %for.body6.lr.ph.prol

for.body6.lr.ph.prol:                             ; preds = %for.cond3.preheader.prol
  %4 = trunc i64 %indvars.iv19.prol to i32
  %mul.prol = shl nsw i32 %4, 7
  %cmp7.prol = icmp eq i64 %indvars.iv19.prol, 0
  %cmp9.prol = icmp eq i64 %indvars.iv19.prol, %2
  %or.cond.prol = or i1 %cmp7.prol, %cmp9.prol
  %add40.prol = or i32 %mul.prol, 1
  %sub45.prol = add i32 %mul.prol, -1
  %5 = trunc i64 %indvars.iv19.prol to i32
  %add58.prol = shl i32 %5, 7
  %6 = trunc i64 %indvars.iv19.prol to i32
  %add79.prol = shl i32 %6, 7
  %mul80.prol = add i32 %add79.prol, 128
  %mul85.prol = add i32 %add79.prol, -128
  %7 = trunc i64 %indvars.iv19.prol to i32
  %sub98.prol = shl i32 %7, 7
  %8 = sext i32 %mul.prol to i64
  %9 = sext i32 %mul85.prol to i64
  %10 = sext i32 %mul80.prol to i64
  br label %for.body6.prol

for.body6.prol:                                   ; preds = %for.inc.prol, %for.body6.lr.ph.prol
  %indvars.iv.prol = phi i64 [ 0, %for.body6.lr.ph.prol ], [ %indvars.iv.next.prol, %for.inc.prol ]
  %11 = add nsw i64 %indvars.iv.prol, %8
  %cmp12.prol = icmp eq i64 %indvars.iv.prol, 0
  %or.cond1.prol = or i1 %or.cond.prol, %cmp12.prol
  %cmp15.prol = icmp eq i64 %indvars.iv.prol, %1
  %or.cond2.prol = or i1 %cmp15.prol, %or.cond1.prol
  br i1 %or.cond2.prol, label %if.then.prol, label %if.else.prol

if.else.prol:                                     ; preds = %for.body6.prol
  %arrayidx18.prol = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %11
  %12 = load float, float* %arrayidx18.prol, align 4
  %conv19.prol = fpext float %12 to double
  %mul20.prol = fmul double %conv19.prol, 0x404CA5DC1A63C1F8
  %conv21.prol = fptrunc double %mul20.prol to float
  %cmp22.prol = fcmp olt float %conv21.prol, 0.000000e+00
  %add25.prol = fadd float %conv21.prol, 1.800000e+02
  %angle.0.prol = select i1 %cmp22.prol, float %add25.prol, float %conv21.prol
  %cmp26.prol = fcmp oge float %angle.0.prol, 0.000000e+00
  %cmp29.prol = fcmp olt float %angle.0.prol, 2.250000e+01
  %or.cond3.prol = and i1 %cmp26.prol, %cmp29.prol
  br i1 %or.cond3.prol, label %if.then38.prol, label %lor.lhs.false31.prol

lor.lhs.false31.prol:                             ; preds = %if.else.prol
  %cmp33.prol = fcmp ult float %angle.0.prol, 1.575000e+02
  %cmp36.prol = fcmp ugt float %angle.0.prol, 1.800000e+02
  %or.cond4.prol = or i1 %cmp33.prol, %cmp36.prol
  br i1 %or.cond4.prol, label %if.else49.prol, label %if.then38.prol

if.else49.prol:                                   ; preds = %lor.lhs.false31.prol
  %cmp51.prol = fcmp oge float %angle.0.prol, 2.250000e+01
  %cmp55.prol = fcmp olt float %angle.0.prol, 6.750000e+01
  %or.cond5.prol = and i1 %cmp51.prol, %cmp55.prol
  br i1 %or.cond5.prol, label %if.then57.prol, label %if.else70.prol

if.else70.prol:                                   ; preds = %if.else49.prol
  %cmp72.prol = fcmp oge float %angle.0.prol, 6.750000e+01
  %cmp76.prol = fcmp olt float %angle.0.prol, 1.125000e+02
  %or.cond6.prol = and i1 %cmp72.prol, %cmp76.prol
  br i1 %or.cond6.prol, label %if.then78.prol, label %if.else89.prol

if.else89.prol:                                   ; preds = %if.else70.prol
  %cmp91.prol = fcmp oge float %angle.0.prol, 1.125000e+02
  %cmp95.prol = fcmp olt float %angle.0.prol, 1.575000e+02
  %or.cond7.prol = and i1 %cmp91.prol, %cmp95.prol
  br i1 %or.cond7.prol, label %if.then97.prol, label %if.end113.prol

if.then97.prol:                                   ; preds = %if.else89.prol
  %13 = trunc i64 %indvars.iv.prol to i32
  %sub100.prol = add i32 %13, %sub98.prol
  %add101.prol = add i32 %sub100.prol, -129
  %idxprom102.prol = sext i32 %add101.prol to i64
  %arrayidx103.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.prol
  %14 = load float, float* %arrayidx103.prol, align 4
  %add107.prol = add i32 %sub100.prol, 129
  %idxprom108.prol = sext i32 %add107.prol to i64
  %arrayidx109.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.prol
  %15 = load float, float* %arrayidx109.prol, align 4
  br label %if.end113.prol

if.then78.prol:                                   ; preds = %if.else70.prol
  %16 = add nsw i64 %10, %indvars.iv.prol
  %arrayidx83.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %16
  %17 = load float, float* %arrayidx83.prol, align 4
  %18 = add nsw i64 %9, %indvars.iv.prol
  %arrayidx88.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %18
  %19 = load float, float* %arrayidx88.prol, align 4
  br label %if.end113.prol

if.then57.prol:                                   ; preds = %if.else49.prol
  %20 = trunc i64 %indvars.iv.prol to i32
  %sub60.prol = add i32 %20, %add58.prol
  %add61.prol = add i32 %sub60.prol, 127
  %idxprom62.prol = sext i32 %add61.prol to i64
  %arrayidx63.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.prol
  %21 = load float, float* %arrayidx63.prol, align 4
  %add67.prol = add i32 %sub60.prol, -127
  %idxprom68.prol = sext i32 %add67.prol to i64
  %arrayidx69.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.prol
  %22 = load float, float* %arrayidx69.prol, align 4
  br label %if.end113.prol

if.then38.prol:                                   ; preds = %lor.lhs.false31.prol, %if.else.prol
  %23 = trunc i64 %indvars.iv.prol to i32
  %add41.prol = add i32 %add40.prol, %23
  %idxprom42.prol = sext i32 %add41.prol to i64
  %arrayidx43.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.prol
  %24 = load float, float* %arrayidx43.prol, align 4
  %25 = trunc i64 %indvars.iv.prol to i32
  %add46.prol = add i32 %sub45.prol, %25
  %idxprom47.prol = sext i32 %add46.prol to i64
  %arrayidx48.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.prol
  %26 = load float, float* %arrayidx48.prol, align 4
  br label %if.end113.prol

if.end113.prol:                                   ; preds = %if.then38.prol, %if.then57.prol, %if.then78.prol, %if.then97.prol, %if.else89.prol
  %q.3.prol = phi float [ %24, %if.then38.prol ], [ %21, %if.then57.prol ], [ %17, %if.then78.prol ], [ %14, %if.then97.prol ], [ 2.550000e+02, %if.else89.prol ]
  %r.3.prol = phi float [ %26, %if.then38.prol ], [ %22, %if.then57.prol ], [ %19, %if.then78.prol ], [ %15, %if.then97.prol ], [ 2.550000e+02, %if.else89.prol ]
  %arrayidx115.prol = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %11
  %27 = load float, float* %arrayidx115.prol, align 4
  %cmp116.prol = fcmp ult float %27, %q.3.prol
  %cmp121.prol = fcmp ult float %27, %r.3.prol
  %or.cond8.prol = or i1 %cmp116.prol, %cmp121.prol
  br i1 %or.cond8.prol, label %if.else129.prol, label %if.then123.prol

if.then123.prol:                                  ; preds = %if.end113.prol
  %conv126.prol = fptoui float %27 to i32
  %arrayidx128.prol = getelementptr inbounds i32, i32* %0, i64 %11
  store i32 %conv126.prol, i32* %arrayidx128.prol, align 4
  br label %for.inc.prol

if.else129.prol:                                  ; preds = %if.end113.prol
  %arrayidx131.prol = getelementptr inbounds i32, i32* %0, i64 %11
  store i32 0, i32* %arrayidx131.prol, align 4
  br label %for.inc.prol

if.then.prol:                                     ; preds = %for.body6.prol
  %arrayidx.prol = getelementptr inbounds i32, i32* %0, i64 %11
  store i32 0, i32* %arrayidx.prol, align 4
  br label %for.inc.prol

for.inc.prol:                                     ; preds = %if.then.prol, %if.else129.prol, %if.then123.prol
  %indvars.iv.next.prol = add nuw nsw i64 %indvars.iv.prol, 1
  %lftr.wideiv.prol = trunc i64 %indvars.iv.next.prol to i32
  %exitcond.prol = icmp eq i32 %lftr.wideiv.prol, %img_width
  br i1 %exitcond.prol, label %for.inc134.prol.loopexit, label %for.body6.prol, !llvm.loop !1

for.inc134.prol.loopexit:                         ; preds = %for.inc.prol
  br label %for.inc134.prol

for.inc134.prol:                                  ; preds = %for.inc134.prol.loopexit, %for.cond3.preheader.prol
  %indvars.iv.next20.prol = add nuw nsw i64 %indvars.iv19.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %for.cond3.preheader.lr.ph.split.loopexit, label %for.cond3.preheader.prol, !llvm.loop !3

for.cond3.preheader.lr.ph.split.loopexit:         ; preds = %for.inc134.prol
  %indvars.iv.next20.prol.lcssa = phi i64 [ %indvars.iv.next20.prol, %for.inc134.prol ]
  br label %for.cond3.preheader.lr.ph.split

for.cond3.preheader.lr.ph.split:                  ; preds = %for.cond3.preheader.lr.ph.split.loopexit, %for.cond3.preheader.lr.ph
  %indvars.iv19.unr = phi i64 [ 0, %for.cond3.preheader.lr.ph ], [ %indvars.iv.next20.prol.lcssa, %for.cond3.preheader.lr.ph.split.loopexit ]
  %28 = icmp ult i32 %3, 31
  br i1 %28, label %for.end136, label %for.cond3.preheader.preheader

for.cond3.preheader.preheader:                    ; preds = %for.cond3.preheader.lr.ph.split
  br label %for.cond3.preheader

for.cond3.preheader:                              ; preds = %for.cond3.preheader.preheader, %for.inc134.31
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.31, %for.inc134.31 ], [ %indvars.iv19.unr, %for.cond3.preheader.preheader ]
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph

for.body6.lr.ph:                                  ; preds = %for.cond3.preheader
  %29 = trunc i64 %indvars.iv19 to i32
  %mul = shl nsw i32 %29, 7
  %cmp7 = icmp eq i64 %indvars.iv19, 0
  %cmp9 = icmp eq i64 %indvars.iv19, %2
  %or.cond = or i1 %cmp7, %cmp9
  %add40 = or i32 %mul, 1
  %sub45 = add i32 %mul, -1
  %30 = trunc i64 %indvars.iv19 to i32
  %add58 = shl i32 %30, 7
  %31 = trunc i64 %indvars.iv19 to i32
  %add79 = shl i32 %31, 7
  %mul80 = add i32 %add79, 128
  %mul85 = add i32 %add79, -128
  %32 = trunc i64 %indvars.iv19 to i32
  %sub98 = shl i32 %32, 7
  %33 = sext i32 %mul to i64
  %34 = sext i32 %mul85 to i64
  %35 = sext i32 %mul80 to i64
  br label %for.body6

for.body6:                                        ; preds = %for.inc, %for.body6.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body6.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %36 = add nsw i64 %indvars.iv, %33
  %cmp12 = icmp eq i64 %indvars.iv, 0
  %or.cond1 = or i1 %or.cond, %cmp12
  %cmp15 = icmp eq i64 %indvars.iv, %1
  %or.cond2 = or i1 %cmp15, %or.cond1
  br i1 %or.cond2, label %if.then, label %if.else

if.then:                                          ; preds = %for.body6
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %36
  store i32 0, i32* %arrayidx, align 4
  br label %for.inc

if.else:                                          ; preds = %for.body6
  %arrayidx18 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %36
  %37 = load float, float* %arrayidx18, align 4
  %conv19 = fpext float %37 to double
  %mul20 = fmul double %conv19, 0x404CA5DC1A63C1F8
  %conv21 = fptrunc double %mul20 to float
  %cmp22 = fcmp olt float %conv21, 0.000000e+00
  %add25 = fadd float %conv21, 1.800000e+02
  %angle.0 = select i1 %cmp22, float %add25, float %conv21
  %cmp26 = fcmp oge float %angle.0, 0.000000e+00
  %cmp29 = fcmp olt float %angle.0, 2.250000e+01
  %or.cond3 = and i1 %cmp26, %cmp29
  br i1 %or.cond3, label %if.then38, label %lor.lhs.false31

lor.lhs.false31:                                  ; preds = %if.else
  %cmp33 = fcmp ult float %angle.0, 1.575000e+02
  %cmp36 = fcmp ugt float %angle.0, 1.800000e+02
  %or.cond4 = or i1 %cmp33, %cmp36
  br i1 %or.cond4, label %if.else49, label %if.then38

if.then38:                                        ; preds = %lor.lhs.false31, %if.else
  %38 = trunc i64 %indvars.iv to i32
  %add41 = add i32 %add40, %38
  %idxprom42 = sext i32 %add41 to i64
  %arrayidx43 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42
  %39 = load float, float* %arrayidx43, align 4
  %40 = trunc i64 %indvars.iv to i32
  %add46 = add i32 %sub45, %40
  %idxprom47 = sext i32 %add46 to i64
  %arrayidx48 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47
  %41 = load float, float* %arrayidx48, align 4
  br label %if.end113

if.else49:                                        ; preds = %lor.lhs.false31
  %cmp51 = fcmp oge float %angle.0, 2.250000e+01
  %cmp55 = fcmp olt float %angle.0, 6.750000e+01
  %or.cond5 = and i1 %cmp51, %cmp55
  br i1 %or.cond5, label %if.then57, label %if.else70

if.then57:                                        ; preds = %if.else49
  %42 = trunc i64 %indvars.iv to i32
  %sub60 = add i32 %42, %add58
  %add61 = add i32 %sub60, 127
  %idxprom62 = sext i32 %add61 to i64
  %arrayidx63 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62
  %43 = load float, float* %arrayidx63, align 4
  %add67 = add i32 %sub60, -127
  %idxprom68 = sext i32 %add67 to i64
  %arrayidx69 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68
  %44 = load float, float* %arrayidx69, align 4
  br label %if.end113

if.else70:                                        ; preds = %if.else49
  %cmp72 = fcmp oge float %angle.0, 6.750000e+01
  %cmp76 = fcmp olt float %angle.0, 1.125000e+02
  %or.cond6 = and i1 %cmp72, %cmp76
  br i1 %or.cond6, label %if.then78, label %if.else89

if.then78:                                        ; preds = %if.else70
  %45 = add nsw i64 %35, %indvars.iv
  %arrayidx83 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %45
  %46 = load float, float* %arrayidx83, align 4
  %47 = add nsw i64 %34, %indvars.iv
  %arrayidx88 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %47
  %48 = load float, float* %arrayidx88, align 4
  br label %if.end113

if.else89:                                        ; preds = %if.else70
  %cmp91 = fcmp oge float %angle.0, 1.125000e+02
  %cmp95 = fcmp olt float %angle.0, 1.575000e+02
  %or.cond7 = and i1 %cmp91, %cmp95
  br i1 %or.cond7, label %if.then97, label %if.end113

if.then97:                                        ; preds = %if.else89
  %49 = trunc i64 %indvars.iv to i32
  %sub100 = add i32 %49, %sub98
  %add101 = add i32 %sub100, -129
  %idxprom102 = sext i32 %add101 to i64
  %arrayidx103 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102
  %50 = load float, float* %arrayidx103, align 4
  %add107 = add i32 %sub100, 129
  %idxprom108 = sext i32 %add107 to i64
  %arrayidx109 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108
  %51 = load float, float* %arrayidx109, align 4
  br label %if.end113

if.end113:                                        ; preds = %if.then57, %if.then97, %if.else89, %if.then78, %if.then38
  %q.3 = phi float [ %39, %if.then38 ], [ %43, %if.then57 ], [ %46, %if.then78 ], [ %50, %if.then97 ], [ 2.550000e+02, %if.else89 ]
  %r.3 = phi float [ %41, %if.then38 ], [ %44, %if.then57 ], [ %48, %if.then78 ], [ %51, %if.then97 ], [ 2.550000e+02, %if.else89 ]
  %arrayidx115 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %36
  %52 = load float, float* %arrayidx115, align 4
  %cmp116 = fcmp ult float %52, %q.3
  %cmp121 = fcmp ult float %52, %r.3
  %or.cond8 = or i1 %cmp116, %cmp121
  br i1 %or.cond8, label %if.else129, label %if.then123

if.then123:                                       ; preds = %if.end113
  %conv126 = fptoui float %52 to i32
  %arrayidx128 = getelementptr inbounds i32, i32* %0, i64 %36
  store i32 %conv126, i32* %arrayidx128, align 4
  br label %for.inc

if.else129:                                       ; preds = %if.end113
  %arrayidx131 = getelementptr inbounds i32, i32* %0, i64 %36
  store i32 0, i32* %arrayidx131, align 4
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else129, %if.then123
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %img_width
  br i1 %exitcond, label %for.inc134, label %for.body6, !llvm.loop !1

for.inc134:                                       ; preds = %for.inc
  %indvars.iv.next20 = add nuw nsw i64 %indvars.iv19, 1
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.1

for.end136.loopexit:                              ; preds = %for.inc134.31
  br label %for.end136

for.end136:                                       ; preds = %for.end136.loopexit, %for.cond3.preheader.lr.ph.split, %entry
  ret void

for.body6.lr.ph.1:                                ; preds = %for.inc134
  %53 = trunc i64 %indvars.iv.next20 to i32
  %mul.1 = shl nsw i32 %53, 7
  %cmp9.1 = icmp eq i64 %indvars.iv.next20, %2
  %add40.1 = or i32 %mul.1, 1
  %sub45.1 = add i32 %mul.1, -1
  %54 = trunc i64 %indvars.iv.next20 to i32
  %add58.1 = shl i32 %54, 7
  %55 = trunc i64 %indvars.iv.next20 to i32
  %add79.1 = shl i32 %55, 7
  %mul80.1 = add i32 %add79.1, 128
  %mul85.1 = add i32 %add79.1, -128
  %56 = trunc i64 %indvars.iv.next20 to i32
  %sub98.1 = shl i32 %56, 7
  %57 = sext i32 %mul.1 to i64
  %58 = sext i32 %mul85.1 to i64
  %59 = sext i32 %mul80.1 to i64
  br label %for.body6.1

for.body6.1:                                      ; preds = %for.inc.1, %for.body6.lr.ph.1
  %indvars.iv.1 = phi i64 [ 0, %for.body6.lr.ph.1 ], [ %indvars.iv.next.1, %for.inc.1 ]
  %60 = add nsw i64 %indvars.iv.1, %57
  %cmp12.1 = icmp eq i64 %indvars.iv.1, 0
  %or.cond1.1 = or i1 %cmp9.1, %cmp12.1
  %cmp15.1 = icmp eq i64 %indvars.iv.1, %1
  %or.cond2.1 = or i1 %cmp15.1, %or.cond1.1
  br i1 %or.cond2.1, label %if.then.1, label %if.else.1

if.else.1:                                        ; preds = %for.body6.1
  %arrayidx18.1 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %60
  %61 = load float, float* %arrayidx18.1, align 4
  %conv19.1 = fpext float %61 to double
  %mul20.1 = fmul double %conv19.1, 0x404CA5DC1A63C1F8
  %conv21.1 = fptrunc double %mul20.1 to float
  %cmp22.1 = fcmp olt float %conv21.1, 0.000000e+00
  %add25.1 = fadd float %conv21.1, 1.800000e+02
  %angle.0.1 = select i1 %cmp22.1, float %add25.1, float %conv21.1
  %cmp26.1 = fcmp oge float %angle.0.1, 0.000000e+00
  %cmp29.1 = fcmp olt float %angle.0.1, 2.250000e+01
  %or.cond3.1 = and i1 %cmp26.1, %cmp29.1
  br i1 %or.cond3.1, label %if.then38.1, label %lor.lhs.false31.1

lor.lhs.false31.1:                                ; preds = %if.else.1
  %cmp33.1 = fcmp ult float %angle.0.1, 1.575000e+02
  %cmp36.1 = fcmp ugt float %angle.0.1, 1.800000e+02
  %or.cond4.1 = or i1 %cmp33.1, %cmp36.1
  br i1 %or.cond4.1, label %if.else49.1, label %if.then38.1

if.else49.1:                                      ; preds = %lor.lhs.false31.1
  %cmp51.1 = fcmp oge float %angle.0.1, 2.250000e+01
  %cmp55.1 = fcmp olt float %angle.0.1, 6.750000e+01
  %or.cond5.1 = and i1 %cmp51.1, %cmp55.1
  br i1 %or.cond5.1, label %if.then57.1, label %if.else70.1

if.else70.1:                                      ; preds = %if.else49.1
  %cmp72.1 = fcmp oge float %angle.0.1, 6.750000e+01
  %cmp76.1 = fcmp olt float %angle.0.1, 1.125000e+02
  %or.cond6.1 = and i1 %cmp72.1, %cmp76.1
  br i1 %or.cond6.1, label %if.then78.1, label %if.else89.1

if.else89.1:                                      ; preds = %if.else70.1
  %cmp91.1 = fcmp oge float %angle.0.1, 1.125000e+02
  %cmp95.1 = fcmp olt float %angle.0.1, 1.575000e+02
  %or.cond7.1 = and i1 %cmp91.1, %cmp95.1
  br i1 %or.cond7.1, label %if.then97.1, label %if.end113.1

if.then97.1:                                      ; preds = %if.else89.1
  %62 = trunc i64 %indvars.iv.1 to i32
  %sub100.1 = add i32 %62, %sub98.1
  %add101.1 = add i32 %sub100.1, -129
  %idxprom102.1 = sext i32 %add101.1 to i64
  %arrayidx103.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.1
  %63 = load float, float* %arrayidx103.1, align 4
  %add107.1 = add i32 %sub100.1, 129
  %idxprom108.1 = sext i32 %add107.1 to i64
  %arrayidx109.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.1
  %64 = load float, float* %arrayidx109.1, align 4
  br label %if.end113.1

if.then78.1:                                      ; preds = %if.else70.1
  %65 = add nsw i64 %59, %indvars.iv.1
  %arrayidx83.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %65
  %66 = load float, float* %arrayidx83.1, align 4
  %67 = add nsw i64 %58, %indvars.iv.1
  %arrayidx88.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %67
  %68 = load float, float* %arrayidx88.1, align 4
  br label %if.end113.1

if.then57.1:                                      ; preds = %if.else49.1
  %69 = trunc i64 %indvars.iv.1 to i32
  %sub60.1 = add i32 %69, %add58.1
  %add61.1 = add i32 %sub60.1, 127
  %idxprom62.1 = sext i32 %add61.1 to i64
  %arrayidx63.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.1
  %70 = load float, float* %arrayidx63.1, align 4
  %add67.1 = add i32 %sub60.1, -127
  %idxprom68.1 = sext i32 %add67.1 to i64
  %arrayidx69.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.1
  %71 = load float, float* %arrayidx69.1, align 4
  br label %if.end113.1

if.then38.1:                                      ; preds = %lor.lhs.false31.1, %if.else.1
  %72 = trunc i64 %indvars.iv.1 to i32
  %add41.1 = add i32 %add40.1, %72
  %idxprom42.1 = sext i32 %add41.1 to i64
  %arrayidx43.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.1
  %73 = load float, float* %arrayidx43.1, align 4
  %74 = trunc i64 %indvars.iv.1 to i32
  %add46.1 = add i32 %sub45.1, %74
  %idxprom47.1 = sext i32 %add46.1 to i64
  %arrayidx48.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.1
  %75 = load float, float* %arrayidx48.1, align 4
  br label %if.end113.1

if.end113.1:                                      ; preds = %if.then38.1, %if.then57.1, %if.then78.1, %if.then97.1, %if.else89.1
  %q.3.1 = phi float [ %73, %if.then38.1 ], [ %70, %if.then57.1 ], [ %66, %if.then78.1 ], [ %63, %if.then97.1 ], [ 2.550000e+02, %if.else89.1 ]
  %r.3.1 = phi float [ %75, %if.then38.1 ], [ %71, %if.then57.1 ], [ %68, %if.then78.1 ], [ %64, %if.then97.1 ], [ 2.550000e+02, %if.else89.1 ]
  %arrayidx115.1 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %60
  %76 = load float, float* %arrayidx115.1, align 4
  %cmp116.1 = fcmp ult float %76, %q.3.1
  %cmp121.1 = fcmp ult float %76, %r.3.1
  %or.cond8.1 = or i1 %cmp116.1, %cmp121.1
  br i1 %or.cond8.1, label %if.else129.1, label %if.then123.1

if.then123.1:                                     ; preds = %if.end113.1
  %conv126.1 = fptoui float %76 to i32
  %arrayidx128.1 = getelementptr inbounds i32, i32* %0, i64 %60
  store i32 %conv126.1, i32* %arrayidx128.1, align 4
  br label %for.inc.1

if.else129.1:                                     ; preds = %if.end113.1
  %arrayidx131.1 = getelementptr inbounds i32, i32* %0, i64 %60
  store i32 0, i32* %arrayidx131.1, align 4
  br label %for.inc.1

if.then.1:                                        ; preds = %for.body6.1
  %arrayidx.1 = getelementptr inbounds i32, i32* %0, i64 %60
  store i32 0, i32* %arrayidx.1, align 4
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.then.1, %if.else129.1, %if.then123.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %lftr.wideiv.1 = trunc i64 %indvars.iv.next.1 to i32
  %exitcond.1 = icmp eq i32 %lftr.wideiv.1, %img_width
  br i1 %exitcond.1, label %for.inc134.1, label %for.body6.1, !llvm.loop !1

for.inc134.1:                                     ; preds = %for.inc.1
  %indvars.iv.next20.1 = add nsw i64 %indvars.iv19, 2
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.2

for.body6.lr.ph.2:                                ; preds = %for.inc134.1
  %77 = trunc i64 %indvars.iv.next20.1 to i32
  %mul.2 = shl nsw i32 %77, 7
  %cmp9.2 = icmp eq i64 %indvars.iv.next20.1, %2
  %add40.2 = or i32 %mul.2, 1
  %sub45.2 = add i32 %mul.2, -1
  %78 = trunc i64 %indvars.iv.next20.1 to i32
  %add58.2 = shl i32 %78, 7
  %79 = trunc i64 %indvars.iv.next20.1 to i32
  %add79.2 = shl i32 %79, 7
  %mul80.2 = add i32 %add79.2, 128
  %mul85.2 = add i32 %add79.2, -128
  %80 = trunc i64 %indvars.iv.next20.1 to i32
  %sub98.2 = shl i32 %80, 7
  %81 = sext i32 %mul.2 to i64
  %82 = sext i32 %mul85.2 to i64
  %83 = sext i32 %mul80.2 to i64
  br label %for.body6.2

for.body6.2:                                      ; preds = %for.inc.2, %for.body6.lr.ph.2
  %indvars.iv.2 = phi i64 [ 0, %for.body6.lr.ph.2 ], [ %indvars.iv.next.2, %for.inc.2 ]
  %84 = add nsw i64 %indvars.iv.2, %81
  %cmp12.2 = icmp eq i64 %indvars.iv.2, 0
  %or.cond1.2 = or i1 %cmp9.2, %cmp12.2
  %cmp15.2 = icmp eq i64 %indvars.iv.2, %1
  %or.cond2.2 = or i1 %cmp15.2, %or.cond1.2
  br i1 %or.cond2.2, label %if.then.2, label %if.else.2

if.else.2:                                        ; preds = %for.body6.2
  %arrayidx18.2 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %84
  %85 = load float, float* %arrayidx18.2, align 4
  %conv19.2 = fpext float %85 to double
  %mul20.2 = fmul double %conv19.2, 0x404CA5DC1A63C1F8
  %conv21.2 = fptrunc double %mul20.2 to float
  %cmp22.2 = fcmp olt float %conv21.2, 0.000000e+00
  %add25.2 = fadd float %conv21.2, 1.800000e+02
  %angle.0.2 = select i1 %cmp22.2, float %add25.2, float %conv21.2
  %cmp26.2 = fcmp oge float %angle.0.2, 0.000000e+00
  %cmp29.2 = fcmp olt float %angle.0.2, 2.250000e+01
  %or.cond3.2 = and i1 %cmp26.2, %cmp29.2
  br i1 %or.cond3.2, label %if.then38.2, label %lor.lhs.false31.2

lor.lhs.false31.2:                                ; preds = %if.else.2
  %cmp33.2 = fcmp ult float %angle.0.2, 1.575000e+02
  %cmp36.2 = fcmp ugt float %angle.0.2, 1.800000e+02
  %or.cond4.2 = or i1 %cmp33.2, %cmp36.2
  br i1 %or.cond4.2, label %if.else49.2, label %if.then38.2

if.else49.2:                                      ; preds = %lor.lhs.false31.2
  %cmp51.2 = fcmp oge float %angle.0.2, 2.250000e+01
  %cmp55.2 = fcmp olt float %angle.0.2, 6.750000e+01
  %or.cond5.2 = and i1 %cmp51.2, %cmp55.2
  br i1 %or.cond5.2, label %if.then57.2, label %if.else70.2

if.else70.2:                                      ; preds = %if.else49.2
  %cmp72.2 = fcmp oge float %angle.0.2, 6.750000e+01
  %cmp76.2 = fcmp olt float %angle.0.2, 1.125000e+02
  %or.cond6.2 = and i1 %cmp72.2, %cmp76.2
  br i1 %or.cond6.2, label %if.then78.2, label %if.else89.2

if.else89.2:                                      ; preds = %if.else70.2
  %cmp91.2 = fcmp oge float %angle.0.2, 1.125000e+02
  %cmp95.2 = fcmp olt float %angle.0.2, 1.575000e+02
  %or.cond7.2 = and i1 %cmp91.2, %cmp95.2
  br i1 %or.cond7.2, label %if.then97.2, label %if.end113.2

if.then97.2:                                      ; preds = %if.else89.2
  %86 = trunc i64 %indvars.iv.2 to i32
  %sub100.2 = add i32 %86, %sub98.2
  %add101.2 = add i32 %sub100.2, -129
  %idxprom102.2 = sext i32 %add101.2 to i64
  %arrayidx103.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.2
  %87 = load float, float* %arrayidx103.2, align 4
  %add107.2 = add i32 %sub100.2, 129
  %idxprom108.2 = sext i32 %add107.2 to i64
  %arrayidx109.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.2
  %88 = load float, float* %arrayidx109.2, align 4
  br label %if.end113.2

if.then78.2:                                      ; preds = %if.else70.2
  %89 = add nsw i64 %83, %indvars.iv.2
  %arrayidx83.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %89
  %90 = load float, float* %arrayidx83.2, align 4
  %91 = add nsw i64 %82, %indvars.iv.2
  %arrayidx88.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %91
  %92 = load float, float* %arrayidx88.2, align 4
  br label %if.end113.2

if.then57.2:                                      ; preds = %if.else49.2
  %93 = trunc i64 %indvars.iv.2 to i32
  %sub60.2 = add i32 %93, %add58.2
  %add61.2 = add i32 %sub60.2, 127
  %idxprom62.2 = sext i32 %add61.2 to i64
  %arrayidx63.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.2
  %94 = load float, float* %arrayidx63.2, align 4
  %add67.2 = add i32 %sub60.2, -127
  %idxprom68.2 = sext i32 %add67.2 to i64
  %arrayidx69.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.2
  %95 = load float, float* %arrayidx69.2, align 4
  br label %if.end113.2

if.then38.2:                                      ; preds = %lor.lhs.false31.2, %if.else.2
  %96 = trunc i64 %indvars.iv.2 to i32
  %add41.2 = add i32 %add40.2, %96
  %idxprom42.2 = sext i32 %add41.2 to i64
  %arrayidx43.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.2
  %97 = load float, float* %arrayidx43.2, align 4
  %98 = trunc i64 %indvars.iv.2 to i32
  %add46.2 = add i32 %sub45.2, %98
  %idxprom47.2 = sext i32 %add46.2 to i64
  %arrayidx48.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.2
  %99 = load float, float* %arrayidx48.2, align 4
  br label %if.end113.2

if.end113.2:                                      ; preds = %if.then38.2, %if.then57.2, %if.then78.2, %if.then97.2, %if.else89.2
  %q.3.2 = phi float [ %97, %if.then38.2 ], [ %94, %if.then57.2 ], [ %90, %if.then78.2 ], [ %87, %if.then97.2 ], [ 2.550000e+02, %if.else89.2 ]
  %r.3.2 = phi float [ %99, %if.then38.2 ], [ %95, %if.then57.2 ], [ %92, %if.then78.2 ], [ %88, %if.then97.2 ], [ 2.550000e+02, %if.else89.2 ]
  %arrayidx115.2 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %84
  %100 = load float, float* %arrayidx115.2, align 4
  %cmp116.2 = fcmp ult float %100, %q.3.2
  %cmp121.2 = fcmp ult float %100, %r.3.2
  %or.cond8.2 = or i1 %cmp116.2, %cmp121.2
  br i1 %or.cond8.2, label %if.else129.2, label %if.then123.2

if.then123.2:                                     ; preds = %if.end113.2
  %conv126.2 = fptoui float %100 to i32
  %arrayidx128.2 = getelementptr inbounds i32, i32* %0, i64 %84
  store i32 %conv126.2, i32* %arrayidx128.2, align 4
  br label %for.inc.2

if.else129.2:                                     ; preds = %if.end113.2
  %arrayidx131.2 = getelementptr inbounds i32, i32* %0, i64 %84
  store i32 0, i32* %arrayidx131.2, align 4
  br label %for.inc.2

if.then.2:                                        ; preds = %for.body6.2
  %arrayidx.2 = getelementptr inbounds i32, i32* %0, i64 %84
  store i32 0, i32* %arrayidx.2, align 4
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.then.2, %if.else129.2, %if.then123.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %lftr.wideiv.2 = trunc i64 %indvars.iv.next.2 to i32
  %exitcond.2 = icmp eq i32 %lftr.wideiv.2, %img_width
  br i1 %exitcond.2, label %for.inc134.2, label %for.body6.2, !llvm.loop !1

for.inc134.2:                                     ; preds = %for.inc.2
  %indvars.iv.next20.2 = add nsw i64 %indvars.iv19, 3
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.3

for.body6.lr.ph.3:                                ; preds = %for.inc134.2
  %101 = trunc i64 %indvars.iv.next20.2 to i32
  %mul.3 = shl nsw i32 %101, 7
  %cmp9.3 = icmp eq i64 %indvars.iv.next20.2, %2
  %add40.3 = or i32 %mul.3, 1
  %sub45.3 = add i32 %mul.3, -1
  %102 = trunc i64 %indvars.iv.next20.2 to i32
  %add58.3 = shl i32 %102, 7
  %103 = trunc i64 %indvars.iv.next20.2 to i32
  %add79.3 = shl i32 %103, 7
  %mul80.3 = add i32 %add79.3, 128
  %mul85.3 = add i32 %add79.3, -128
  %104 = trunc i64 %indvars.iv.next20.2 to i32
  %sub98.3 = shl i32 %104, 7
  %105 = sext i32 %mul.3 to i64
  %106 = sext i32 %mul85.3 to i64
  %107 = sext i32 %mul80.3 to i64
  br label %for.body6.3

for.body6.3:                                      ; preds = %for.inc.3, %for.body6.lr.ph.3
  %indvars.iv.3 = phi i64 [ 0, %for.body6.lr.ph.3 ], [ %indvars.iv.next.3, %for.inc.3 ]
  %108 = add nsw i64 %indvars.iv.3, %105
  %cmp12.3 = icmp eq i64 %indvars.iv.3, 0
  %or.cond1.3 = or i1 %cmp9.3, %cmp12.3
  %cmp15.3 = icmp eq i64 %indvars.iv.3, %1
  %or.cond2.3 = or i1 %cmp15.3, %or.cond1.3
  br i1 %or.cond2.3, label %if.then.3, label %if.else.3

if.else.3:                                        ; preds = %for.body6.3
  %arrayidx18.3 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %108
  %109 = load float, float* %arrayidx18.3, align 4
  %conv19.3 = fpext float %109 to double
  %mul20.3 = fmul double %conv19.3, 0x404CA5DC1A63C1F8
  %conv21.3 = fptrunc double %mul20.3 to float
  %cmp22.3 = fcmp olt float %conv21.3, 0.000000e+00
  %add25.3 = fadd float %conv21.3, 1.800000e+02
  %angle.0.3 = select i1 %cmp22.3, float %add25.3, float %conv21.3
  %cmp26.3 = fcmp oge float %angle.0.3, 0.000000e+00
  %cmp29.3 = fcmp olt float %angle.0.3, 2.250000e+01
  %or.cond3.3 = and i1 %cmp26.3, %cmp29.3
  br i1 %or.cond3.3, label %if.then38.3, label %lor.lhs.false31.3

lor.lhs.false31.3:                                ; preds = %if.else.3
  %cmp33.3 = fcmp ult float %angle.0.3, 1.575000e+02
  %cmp36.3 = fcmp ugt float %angle.0.3, 1.800000e+02
  %or.cond4.3 = or i1 %cmp33.3, %cmp36.3
  br i1 %or.cond4.3, label %if.else49.3, label %if.then38.3

if.else49.3:                                      ; preds = %lor.lhs.false31.3
  %cmp51.3 = fcmp oge float %angle.0.3, 2.250000e+01
  %cmp55.3 = fcmp olt float %angle.0.3, 6.750000e+01
  %or.cond5.3 = and i1 %cmp51.3, %cmp55.3
  br i1 %or.cond5.3, label %if.then57.3, label %if.else70.3

if.else70.3:                                      ; preds = %if.else49.3
  %cmp72.3 = fcmp oge float %angle.0.3, 6.750000e+01
  %cmp76.3 = fcmp olt float %angle.0.3, 1.125000e+02
  %or.cond6.3 = and i1 %cmp72.3, %cmp76.3
  br i1 %or.cond6.3, label %if.then78.3, label %if.else89.3

if.else89.3:                                      ; preds = %if.else70.3
  %cmp91.3 = fcmp oge float %angle.0.3, 1.125000e+02
  %cmp95.3 = fcmp olt float %angle.0.3, 1.575000e+02
  %or.cond7.3 = and i1 %cmp91.3, %cmp95.3
  br i1 %or.cond7.3, label %if.then97.3, label %if.end113.3

if.then97.3:                                      ; preds = %if.else89.3
  %110 = trunc i64 %indvars.iv.3 to i32
  %sub100.3 = add i32 %110, %sub98.3
  %add101.3 = add i32 %sub100.3, -129
  %idxprom102.3 = sext i32 %add101.3 to i64
  %arrayidx103.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.3
  %111 = load float, float* %arrayidx103.3, align 4
  %add107.3 = add i32 %sub100.3, 129
  %idxprom108.3 = sext i32 %add107.3 to i64
  %arrayidx109.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.3
  %112 = load float, float* %arrayidx109.3, align 4
  br label %if.end113.3

if.then78.3:                                      ; preds = %if.else70.3
  %113 = add nsw i64 %107, %indvars.iv.3
  %arrayidx83.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %113
  %114 = load float, float* %arrayidx83.3, align 4
  %115 = add nsw i64 %106, %indvars.iv.3
  %arrayidx88.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %115
  %116 = load float, float* %arrayidx88.3, align 4
  br label %if.end113.3

if.then57.3:                                      ; preds = %if.else49.3
  %117 = trunc i64 %indvars.iv.3 to i32
  %sub60.3 = add i32 %117, %add58.3
  %add61.3 = add i32 %sub60.3, 127
  %idxprom62.3 = sext i32 %add61.3 to i64
  %arrayidx63.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.3
  %118 = load float, float* %arrayidx63.3, align 4
  %add67.3 = add i32 %sub60.3, -127
  %idxprom68.3 = sext i32 %add67.3 to i64
  %arrayidx69.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.3
  %119 = load float, float* %arrayidx69.3, align 4
  br label %if.end113.3

if.then38.3:                                      ; preds = %lor.lhs.false31.3, %if.else.3
  %120 = trunc i64 %indvars.iv.3 to i32
  %add41.3 = add i32 %add40.3, %120
  %idxprom42.3 = sext i32 %add41.3 to i64
  %arrayidx43.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.3
  %121 = load float, float* %arrayidx43.3, align 4
  %122 = trunc i64 %indvars.iv.3 to i32
  %add46.3 = add i32 %sub45.3, %122
  %idxprom47.3 = sext i32 %add46.3 to i64
  %arrayidx48.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.3
  %123 = load float, float* %arrayidx48.3, align 4
  br label %if.end113.3

if.end113.3:                                      ; preds = %if.then38.3, %if.then57.3, %if.then78.3, %if.then97.3, %if.else89.3
  %q.3.3 = phi float [ %121, %if.then38.3 ], [ %118, %if.then57.3 ], [ %114, %if.then78.3 ], [ %111, %if.then97.3 ], [ 2.550000e+02, %if.else89.3 ]
  %r.3.3 = phi float [ %123, %if.then38.3 ], [ %119, %if.then57.3 ], [ %116, %if.then78.3 ], [ %112, %if.then97.3 ], [ 2.550000e+02, %if.else89.3 ]
  %arrayidx115.3 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %108
  %124 = load float, float* %arrayidx115.3, align 4
  %cmp116.3 = fcmp ult float %124, %q.3.3
  %cmp121.3 = fcmp ult float %124, %r.3.3
  %or.cond8.3 = or i1 %cmp116.3, %cmp121.3
  br i1 %or.cond8.3, label %if.else129.3, label %if.then123.3

if.then123.3:                                     ; preds = %if.end113.3
  %conv126.3 = fptoui float %124 to i32
  %arrayidx128.3 = getelementptr inbounds i32, i32* %0, i64 %108
  store i32 %conv126.3, i32* %arrayidx128.3, align 4
  br label %for.inc.3

if.else129.3:                                     ; preds = %if.end113.3
  %arrayidx131.3 = getelementptr inbounds i32, i32* %0, i64 %108
  store i32 0, i32* %arrayidx131.3, align 4
  br label %for.inc.3

if.then.3:                                        ; preds = %for.body6.3
  %arrayidx.3 = getelementptr inbounds i32, i32* %0, i64 %108
  store i32 0, i32* %arrayidx.3, align 4
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.then.3, %if.else129.3, %if.then123.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.3 = icmp eq i32 %lftr.wideiv.3, %img_width
  br i1 %exitcond.3, label %for.inc134.3, label %for.body6.3, !llvm.loop !1

for.inc134.3:                                     ; preds = %for.inc.3
  %indvars.iv.next20.3 = add nsw i64 %indvars.iv19, 4
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.4

for.body6.lr.ph.4:                                ; preds = %for.inc134.3
  %125 = trunc i64 %indvars.iv.next20.3 to i32
  %mul.4 = shl nsw i32 %125, 7
  %cmp9.4 = icmp eq i64 %indvars.iv.next20.3, %2
  %add40.4 = or i32 %mul.4, 1
  %sub45.4 = add i32 %mul.4, -1
  %126 = trunc i64 %indvars.iv.next20.3 to i32
  %add58.4 = shl i32 %126, 7
  %127 = trunc i64 %indvars.iv.next20.3 to i32
  %add79.4 = shl i32 %127, 7
  %mul80.4 = add i32 %add79.4, 128
  %mul85.4 = add i32 %add79.4, -128
  %128 = trunc i64 %indvars.iv.next20.3 to i32
  %sub98.4 = shl i32 %128, 7
  %129 = sext i32 %mul.4 to i64
  %130 = sext i32 %mul85.4 to i64
  %131 = sext i32 %mul80.4 to i64
  br label %for.body6.4

for.body6.4:                                      ; preds = %for.inc.4, %for.body6.lr.ph.4
  %indvars.iv.4 = phi i64 [ 0, %for.body6.lr.ph.4 ], [ %indvars.iv.next.4, %for.inc.4 ]
  %132 = add nsw i64 %indvars.iv.4, %129
  %cmp12.4 = icmp eq i64 %indvars.iv.4, 0
  %or.cond1.4 = or i1 %cmp9.4, %cmp12.4
  %cmp15.4 = icmp eq i64 %indvars.iv.4, %1
  %or.cond2.4 = or i1 %cmp15.4, %or.cond1.4
  br i1 %or.cond2.4, label %if.then.4, label %if.else.4

if.else.4:                                        ; preds = %for.body6.4
  %arrayidx18.4 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %132
  %133 = load float, float* %arrayidx18.4, align 4
  %conv19.4 = fpext float %133 to double
  %mul20.4 = fmul double %conv19.4, 0x404CA5DC1A63C1F8
  %conv21.4 = fptrunc double %mul20.4 to float
  %cmp22.4 = fcmp olt float %conv21.4, 0.000000e+00
  %add25.4 = fadd float %conv21.4, 1.800000e+02
  %angle.0.4 = select i1 %cmp22.4, float %add25.4, float %conv21.4
  %cmp26.4 = fcmp oge float %angle.0.4, 0.000000e+00
  %cmp29.4 = fcmp olt float %angle.0.4, 2.250000e+01
  %or.cond3.4 = and i1 %cmp26.4, %cmp29.4
  br i1 %or.cond3.4, label %if.then38.4, label %lor.lhs.false31.4

lor.lhs.false31.4:                                ; preds = %if.else.4
  %cmp33.4 = fcmp ult float %angle.0.4, 1.575000e+02
  %cmp36.4 = fcmp ugt float %angle.0.4, 1.800000e+02
  %or.cond4.4 = or i1 %cmp33.4, %cmp36.4
  br i1 %or.cond4.4, label %if.else49.4, label %if.then38.4

if.else49.4:                                      ; preds = %lor.lhs.false31.4
  %cmp51.4 = fcmp oge float %angle.0.4, 2.250000e+01
  %cmp55.4 = fcmp olt float %angle.0.4, 6.750000e+01
  %or.cond5.4 = and i1 %cmp51.4, %cmp55.4
  br i1 %or.cond5.4, label %if.then57.4, label %if.else70.4

if.else70.4:                                      ; preds = %if.else49.4
  %cmp72.4 = fcmp oge float %angle.0.4, 6.750000e+01
  %cmp76.4 = fcmp olt float %angle.0.4, 1.125000e+02
  %or.cond6.4 = and i1 %cmp72.4, %cmp76.4
  br i1 %or.cond6.4, label %if.then78.4, label %if.else89.4

if.else89.4:                                      ; preds = %if.else70.4
  %cmp91.4 = fcmp oge float %angle.0.4, 1.125000e+02
  %cmp95.4 = fcmp olt float %angle.0.4, 1.575000e+02
  %or.cond7.4 = and i1 %cmp91.4, %cmp95.4
  br i1 %or.cond7.4, label %if.then97.4, label %if.end113.4

if.then97.4:                                      ; preds = %if.else89.4
  %134 = trunc i64 %indvars.iv.4 to i32
  %sub100.4 = add i32 %134, %sub98.4
  %add101.4 = add i32 %sub100.4, -129
  %idxprom102.4 = sext i32 %add101.4 to i64
  %arrayidx103.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.4
  %135 = load float, float* %arrayidx103.4, align 4
  %add107.4 = add i32 %sub100.4, 129
  %idxprom108.4 = sext i32 %add107.4 to i64
  %arrayidx109.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.4
  %136 = load float, float* %arrayidx109.4, align 4
  br label %if.end113.4

if.then78.4:                                      ; preds = %if.else70.4
  %137 = add nsw i64 %131, %indvars.iv.4
  %arrayidx83.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %137
  %138 = load float, float* %arrayidx83.4, align 4
  %139 = add nsw i64 %130, %indvars.iv.4
  %arrayidx88.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %139
  %140 = load float, float* %arrayidx88.4, align 4
  br label %if.end113.4

if.then57.4:                                      ; preds = %if.else49.4
  %141 = trunc i64 %indvars.iv.4 to i32
  %sub60.4 = add i32 %141, %add58.4
  %add61.4 = add i32 %sub60.4, 127
  %idxprom62.4 = sext i32 %add61.4 to i64
  %arrayidx63.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.4
  %142 = load float, float* %arrayidx63.4, align 4
  %add67.4 = add i32 %sub60.4, -127
  %idxprom68.4 = sext i32 %add67.4 to i64
  %arrayidx69.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.4
  %143 = load float, float* %arrayidx69.4, align 4
  br label %if.end113.4

if.then38.4:                                      ; preds = %lor.lhs.false31.4, %if.else.4
  %144 = trunc i64 %indvars.iv.4 to i32
  %add41.4 = add i32 %add40.4, %144
  %idxprom42.4 = sext i32 %add41.4 to i64
  %arrayidx43.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.4
  %145 = load float, float* %arrayidx43.4, align 4
  %146 = trunc i64 %indvars.iv.4 to i32
  %add46.4 = add i32 %sub45.4, %146
  %idxprom47.4 = sext i32 %add46.4 to i64
  %arrayidx48.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.4
  %147 = load float, float* %arrayidx48.4, align 4
  br label %if.end113.4

if.end113.4:                                      ; preds = %if.then38.4, %if.then57.4, %if.then78.4, %if.then97.4, %if.else89.4
  %q.3.4 = phi float [ %145, %if.then38.4 ], [ %142, %if.then57.4 ], [ %138, %if.then78.4 ], [ %135, %if.then97.4 ], [ 2.550000e+02, %if.else89.4 ]
  %r.3.4 = phi float [ %147, %if.then38.4 ], [ %143, %if.then57.4 ], [ %140, %if.then78.4 ], [ %136, %if.then97.4 ], [ 2.550000e+02, %if.else89.4 ]
  %arrayidx115.4 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %132
  %148 = load float, float* %arrayidx115.4, align 4
  %cmp116.4 = fcmp ult float %148, %q.3.4
  %cmp121.4 = fcmp ult float %148, %r.3.4
  %or.cond8.4 = or i1 %cmp116.4, %cmp121.4
  br i1 %or.cond8.4, label %if.else129.4, label %if.then123.4

if.then123.4:                                     ; preds = %if.end113.4
  %conv126.4 = fptoui float %148 to i32
  %arrayidx128.4 = getelementptr inbounds i32, i32* %0, i64 %132
  store i32 %conv126.4, i32* %arrayidx128.4, align 4
  br label %for.inc.4

if.else129.4:                                     ; preds = %if.end113.4
  %arrayidx131.4 = getelementptr inbounds i32, i32* %0, i64 %132
  store i32 0, i32* %arrayidx131.4, align 4
  br label %for.inc.4

if.then.4:                                        ; preds = %for.body6.4
  %arrayidx.4 = getelementptr inbounds i32, i32* %0, i64 %132
  store i32 0, i32* %arrayidx.4, align 4
  br label %for.inc.4

for.inc.4:                                        ; preds = %if.then.4, %if.else129.4, %if.then123.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %lftr.wideiv.4 = trunc i64 %indvars.iv.next.4 to i32
  %exitcond.4 = icmp eq i32 %lftr.wideiv.4, %img_width
  br i1 %exitcond.4, label %for.inc134.4, label %for.body6.4, !llvm.loop !1

for.inc134.4:                                     ; preds = %for.inc.4
  %indvars.iv.next20.4 = add nsw i64 %indvars.iv19, 5
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.5

for.body6.lr.ph.5:                                ; preds = %for.inc134.4
  %149 = trunc i64 %indvars.iv.next20.4 to i32
  %mul.5 = shl nsw i32 %149, 7
  %cmp9.5 = icmp eq i64 %indvars.iv.next20.4, %2
  %add40.5 = or i32 %mul.5, 1
  %sub45.5 = add i32 %mul.5, -1
  %150 = trunc i64 %indvars.iv.next20.4 to i32
  %add58.5 = shl i32 %150, 7
  %151 = trunc i64 %indvars.iv.next20.4 to i32
  %add79.5 = shl i32 %151, 7
  %mul80.5 = add i32 %add79.5, 128
  %mul85.5 = add i32 %add79.5, -128
  %152 = trunc i64 %indvars.iv.next20.4 to i32
  %sub98.5 = shl i32 %152, 7
  %153 = sext i32 %mul.5 to i64
  %154 = sext i32 %mul85.5 to i64
  %155 = sext i32 %mul80.5 to i64
  br label %for.body6.5

for.body6.5:                                      ; preds = %for.inc.5, %for.body6.lr.ph.5
  %indvars.iv.5 = phi i64 [ 0, %for.body6.lr.ph.5 ], [ %indvars.iv.next.5, %for.inc.5 ]
  %156 = add nsw i64 %indvars.iv.5, %153
  %cmp12.5 = icmp eq i64 %indvars.iv.5, 0
  %or.cond1.5 = or i1 %cmp9.5, %cmp12.5
  %cmp15.5 = icmp eq i64 %indvars.iv.5, %1
  %or.cond2.5 = or i1 %cmp15.5, %or.cond1.5
  br i1 %or.cond2.5, label %if.then.5, label %if.else.5

if.else.5:                                        ; preds = %for.body6.5
  %arrayidx18.5 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %156
  %157 = load float, float* %arrayidx18.5, align 4
  %conv19.5 = fpext float %157 to double
  %mul20.5 = fmul double %conv19.5, 0x404CA5DC1A63C1F8
  %conv21.5 = fptrunc double %mul20.5 to float
  %cmp22.5 = fcmp olt float %conv21.5, 0.000000e+00
  %add25.5 = fadd float %conv21.5, 1.800000e+02
  %angle.0.5 = select i1 %cmp22.5, float %add25.5, float %conv21.5
  %cmp26.5 = fcmp oge float %angle.0.5, 0.000000e+00
  %cmp29.5 = fcmp olt float %angle.0.5, 2.250000e+01
  %or.cond3.5 = and i1 %cmp26.5, %cmp29.5
  br i1 %or.cond3.5, label %if.then38.5, label %lor.lhs.false31.5

lor.lhs.false31.5:                                ; preds = %if.else.5
  %cmp33.5 = fcmp ult float %angle.0.5, 1.575000e+02
  %cmp36.5 = fcmp ugt float %angle.0.5, 1.800000e+02
  %or.cond4.5 = or i1 %cmp33.5, %cmp36.5
  br i1 %or.cond4.5, label %if.else49.5, label %if.then38.5

if.else49.5:                                      ; preds = %lor.lhs.false31.5
  %cmp51.5 = fcmp oge float %angle.0.5, 2.250000e+01
  %cmp55.5 = fcmp olt float %angle.0.5, 6.750000e+01
  %or.cond5.5 = and i1 %cmp51.5, %cmp55.5
  br i1 %or.cond5.5, label %if.then57.5, label %if.else70.5

if.else70.5:                                      ; preds = %if.else49.5
  %cmp72.5 = fcmp oge float %angle.0.5, 6.750000e+01
  %cmp76.5 = fcmp olt float %angle.0.5, 1.125000e+02
  %or.cond6.5 = and i1 %cmp72.5, %cmp76.5
  br i1 %or.cond6.5, label %if.then78.5, label %if.else89.5

if.else89.5:                                      ; preds = %if.else70.5
  %cmp91.5 = fcmp oge float %angle.0.5, 1.125000e+02
  %cmp95.5 = fcmp olt float %angle.0.5, 1.575000e+02
  %or.cond7.5 = and i1 %cmp91.5, %cmp95.5
  br i1 %or.cond7.5, label %if.then97.5, label %if.end113.5

if.then97.5:                                      ; preds = %if.else89.5
  %158 = trunc i64 %indvars.iv.5 to i32
  %sub100.5 = add i32 %158, %sub98.5
  %add101.5 = add i32 %sub100.5, -129
  %idxprom102.5 = sext i32 %add101.5 to i64
  %arrayidx103.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.5
  %159 = load float, float* %arrayidx103.5, align 4
  %add107.5 = add i32 %sub100.5, 129
  %idxprom108.5 = sext i32 %add107.5 to i64
  %arrayidx109.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.5
  %160 = load float, float* %arrayidx109.5, align 4
  br label %if.end113.5

if.then78.5:                                      ; preds = %if.else70.5
  %161 = add nsw i64 %155, %indvars.iv.5
  %arrayidx83.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %161
  %162 = load float, float* %arrayidx83.5, align 4
  %163 = add nsw i64 %154, %indvars.iv.5
  %arrayidx88.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %163
  %164 = load float, float* %arrayidx88.5, align 4
  br label %if.end113.5

if.then57.5:                                      ; preds = %if.else49.5
  %165 = trunc i64 %indvars.iv.5 to i32
  %sub60.5 = add i32 %165, %add58.5
  %add61.5 = add i32 %sub60.5, 127
  %idxprom62.5 = sext i32 %add61.5 to i64
  %arrayidx63.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.5
  %166 = load float, float* %arrayidx63.5, align 4
  %add67.5 = add i32 %sub60.5, -127
  %idxprom68.5 = sext i32 %add67.5 to i64
  %arrayidx69.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.5
  %167 = load float, float* %arrayidx69.5, align 4
  br label %if.end113.5

if.then38.5:                                      ; preds = %lor.lhs.false31.5, %if.else.5
  %168 = trunc i64 %indvars.iv.5 to i32
  %add41.5 = add i32 %add40.5, %168
  %idxprom42.5 = sext i32 %add41.5 to i64
  %arrayidx43.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.5
  %169 = load float, float* %arrayidx43.5, align 4
  %170 = trunc i64 %indvars.iv.5 to i32
  %add46.5 = add i32 %sub45.5, %170
  %idxprom47.5 = sext i32 %add46.5 to i64
  %arrayidx48.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.5
  %171 = load float, float* %arrayidx48.5, align 4
  br label %if.end113.5

if.end113.5:                                      ; preds = %if.then38.5, %if.then57.5, %if.then78.5, %if.then97.5, %if.else89.5
  %q.3.5 = phi float [ %169, %if.then38.5 ], [ %166, %if.then57.5 ], [ %162, %if.then78.5 ], [ %159, %if.then97.5 ], [ 2.550000e+02, %if.else89.5 ]
  %r.3.5 = phi float [ %171, %if.then38.5 ], [ %167, %if.then57.5 ], [ %164, %if.then78.5 ], [ %160, %if.then97.5 ], [ 2.550000e+02, %if.else89.5 ]
  %arrayidx115.5 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %156
  %172 = load float, float* %arrayidx115.5, align 4
  %cmp116.5 = fcmp ult float %172, %q.3.5
  %cmp121.5 = fcmp ult float %172, %r.3.5
  %or.cond8.5 = or i1 %cmp116.5, %cmp121.5
  br i1 %or.cond8.5, label %if.else129.5, label %if.then123.5

if.then123.5:                                     ; preds = %if.end113.5
  %conv126.5 = fptoui float %172 to i32
  %arrayidx128.5 = getelementptr inbounds i32, i32* %0, i64 %156
  store i32 %conv126.5, i32* %arrayidx128.5, align 4
  br label %for.inc.5

if.else129.5:                                     ; preds = %if.end113.5
  %arrayidx131.5 = getelementptr inbounds i32, i32* %0, i64 %156
  store i32 0, i32* %arrayidx131.5, align 4
  br label %for.inc.5

if.then.5:                                        ; preds = %for.body6.5
  %arrayidx.5 = getelementptr inbounds i32, i32* %0, i64 %156
  store i32 0, i32* %arrayidx.5, align 4
  br label %for.inc.5

for.inc.5:                                        ; preds = %if.then.5, %if.else129.5, %if.then123.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %lftr.wideiv.5 = trunc i64 %indvars.iv.next.5 to i32
  %exitcond.5 = icmp eq i32 %lftr.wideiv.5, %img_width
  br i1 %exitcond.5, label %for.inc134.5, label %for.body6.5, !llvm.loop !1

for.inc134.5:                                     ; preds = %for.inc.5
  %indvars.iv.next20.5 = add nsw i64 %indvars.iv19, 6
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.6

for.body6.lr.ph.6:                                ; preds = %for.inc134.5
  %173 = trunc i64 %indvars.iv.next20.5 to i32
  %mul.6 = shl nsw i32 %173, 7
  %cmp9.6 = icmp eq i64 %indvars.iv.next20.5, %2
  %add40.6 = or i32 %mul.6, 1
  %sub45.6 = add i32 %mul.6, -1
  %174 = trunc i64 %indvars.iv.next20.5 to i32
  %add58.6 = shl i32 %174, 7
  %175 = trunc i64 %indvars.iv.next20.5 to i32
  %add79.6 = shl i32 %175, 7
  %mul80.6 = add i32 %add79.6, 128
  %mul85.6 = add i32 %add79.6, -128
  %176 = trunc i64 %indvars.iv.next20.5 to i32
  %sub98.6 = shl i32 %176, 7
  %177 = sext i32 %mul.6 to i64
  %178 = sext i32 %mul85.6 to i64
  %179 = sext i32 %mul80.6 to i64
  br label %for.body6.6

for.body6.6:                                      ; preds = %for.inc.6, %for.body6.lr.ph.6
  %indvars.iv.6 = phi i64 [ 0, %for.body6.lr.ph.6 ], [ %indvars.iv.next.6, %for.inc.6 ]
  %180 = add nsw i64 %indvars.iv.6, %177
  %cmp12.6 = icmp eq i64 %indvars.iv.6, 0
  %or.cond1.6 = or i1 %cmp9.6, %cmp12.6
  %cmp15.6 = icmp eq i64 %indvars.iv.6, %1
  %or.cond2.6 = or i1 %cmp15.6, %or.cond1.6
  br i1 %or.cond2.6, label %if.then.6, label %if.else.6

if.else.6:                                        ; preds = %for.body6.6
  %arrayidx18.6 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %180
  %181 = load float, float* %arrayidx18.6, align 4
  %conv19.6 = fpext float %181 to double
  %mul20.6 = fmul double %conv19.6, 0x404CA5DC1A63C1F8
  %conv21.6 = fptrunc double %mul20.6 to float
  %cmp22.6 = fcmp olt float %conv21.6, 0.000000e+00
  %add25.6 = fadd float %conv21.6, 1.800000e+02
  %angle.0.6 = select i1 %cmp22.6, float %add25.6, float %conv21.6
  %cmp26.6 = fcmp oge float %angle.0.6, 0.000000e+00
  %cmp29.6 = fcmp olt float %angle.0.6, 2.250000e+01
  %or.cond3.6 = and i1 %cmp26.6, %cmp29.6
  br i1 %or.cond3.6, label %if.then38.6, label %lor.lhs.false31.6

lor.lhs.false31.6:                                ; preds = %if.else.6
  %cmp33.6 = fcmp ult float %angle.0.6, 1.575000e+02
  %cmp36.6 = fcmp ugt float %angle.0.6, 1.800000e+02
  %or.cond4.6 = or i1 %cmp33.6, %cmp36.6
  br i1 %or.cond4.6, label %if.else49.6, label %if.then38.6

if.else49.6:                                      ; preds = %lor.lhs.false31.6
  %cmp51.6 = fcmp oge float %angle.0.6, 2.250000e+01
  %cmp55.6 = fcmp olt float %angle.0.6, 6.750000e+01
  %or.cond5.6 = and i1 %cmp51.6, %cmp55.6
  br i1 %or.cond5.6, label %if.then57.6, label %if.else70.6

if.else70.6:                                      ; preds = %if.else49.6
  %cmp72.6 = fcmp oge float %angle.0.6, 6.750000e+01
  %cmp76.6 = fcmp olt float %angle.0.6, 1.125000e+02
  %or.cond6.6 = and i1 %cmp72.6, %cmp76.6
  br i1 %or.cond6.6, label %if.then78.6, label %if.else89.6

if.else89.6:                                      ; preds = %if.else70.6
  %cmp91.6 = fcmp oge float %angle.0.6, 1.125000e+02
  %cmp95.6 = fcmp olt float %angle.0.6, 1.575000e+02
  %or.cond7.6 = and i1 %cmp91.6, %cmp95.6
  br i1 %or.cond7.6, label %if.then97.6, label %if.end113.6

if.then97.6:                                      ; preds = %if.else89.6
  %182 = trunc i64 %indvars.iv.6 to i32
  %sub100.6 = add i32 %182, %sub98.6
  %add101.6 = add i32 %sub100.6, -129
  %idxprom102.6 = sext i32 %add101.6 to i64
  %arrayidx103.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.6
  %183 = load float, float* %arrayidx103.6, align 4
  %add107.6 = add i32 %sub100.6, 129
  %idxprom108.6 = sext i32 %add107.6 to i64
  %arrayidx109.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.6
  %184 = load float, float* %arrayidx109.6, align 4
  br label %if.end113.6

if.then78.6:                                      ; preds = %if.else70.6
  %185 = add nsw i64 %179, %indvars.iv.6
  %arrayidx83.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %185
  %186 = load float, float* %arrayidx83.6, align 4
  %187 = add nsw i64 %178, %indvars.iv.6
  %arrayidx88.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %187
  %188 = load float, float* %arrayidx88.6, align 4
  br label %if.end113.6

if.then57.6:                                      ; preds = %if.else49.6
  %189 = trunc i64 %indvars.iv.6 to i32
  %sub60.6 = add i32 %189, %add58.6
  %add61.6 = add i32 %sub60.6, 127
  %idxprom62.6 = sext i32 %add61.6 to i64
  %arrayidx63.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.6
  %190 = load float, float* %arrayidx63.6, align 4
  %add67.6 = add i32 %sub60.6, -127
  %idxprom68.6 = sext i32 %add67.6 to i64
  %arrayidx69.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.6
  %191 = load float, float* %arrayidx69.6, align 4
  br label %if.end113.6

if.then38.6:                                      ; preds = %lor.lhs.false31.6, %if.else.6
  %192 = trunc i64 %indvars.iv.6 to i32
  %add41.6 = add i32 %add40.6, %192
  %idxprom42.6 = sext i32 %add41.6 to i64
  %arrayidx43.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.6
  %193 = load float, float* %arrayidx43.6, align 4
  %194 = trunc i64 %indvars.iv.6 to i32
  %add46.6 = add i32 %sub45.6, %194
  %idxprom47.6 = sext i32 %add46.6 to i64
  %arrayidx48.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.6
  %195 = load float, float* %arrayidx48.6, align 4
  br label %if.end113.6

if.end113.6:                                      ; preds = %if.then38.6, %if.then57.6, %if.then78.6, %if.then97.6, %if.else89.6
  %q.3.6 = phi float [ %193, %if.then38.6 ], [ %190, %if.then57.6 ], [ %186, %if.then78.6 ], [ %183, %if.then97.6 ], [ 2.550000e+02, %if.else89.6 ]
  %r.3.6 = phi float [ %195, %if.then38.6 ], [ %191, %if.then57.6 ], [ %188, %if.then78.6 ], [ %184, %if.then97.6 ], [ 2.550000e+02, %if.else89.6 ]
  %arrayidx115.6 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %180
  %196 = load float, float* %arrayidx115.6, align 4
  %cmp116.6 = fcmp ult float %196, %q.3.6
  %cmp121.6 = fcmp ult float %196, %r.3.6
  %or.cond8.6 = or i1 %cmp116.6, %cmp121.6
  br i1 %or.cond8.6, label %if.else129.6, label %if.then123.6

if.then123.6:                                     ; preds = %if.end113.6
  %conv126.6 = fptoui float %196 to i32
  %arrayidx128.6 = getelementptr inbounds i32, i32* %0, i64 %180
  store i32 %conv126.6, i32* %arrayidx128.6, align 4
  br label %for.inc.6

if.else129.6:                                     ; preds = %if.end113.6
  %arrayidx131.6 = getelementptr inbounds i32, i32* %0, i64 %180
  store i32 0, i32* %arrayidx131.6, align 4
  br label %for.inc.6

if.then.6:                                        ; preds = %for.body6.6
  %arrayidx.6 = getelementptr inbounds i32, i32* %0, i64 %180
  store i32 0, i32* %arrayidx.6, align 4
  br label %for.inc.6

for.inc.6:                                        ; preds = %if.then.6, %if.else129.6, %if.then123.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %lftr.wideiv.6 = trunc i64 %indvars.iv.next.6 to i32
  %exitcond.6 = icmp eq i32 %lftr.wideiv.6, %img_width
  br i1 %exitcond.6, label %for.inc134.6, label %for.body6.6, !llvm.loop !1

for.inc134.6:                                     ; preds = %for.inc.6
  %indvars.iv.next20.6 = add nsw i64 %indvars.iv19, 7
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.7

for.body6.lr.ph.7:                                ; preds = %for.inc134.6
  %197 = trunc i64 %indvars.iv.next20.6 to i32
  %mul.7 = shl nsw i32 %197, 7
  %cmp9.7 = icmp eq i64 %indvars.iv.next20.6, %2
  %add40.7 = or i32 %mul.7, 1
  %sub45.7 = add i32 %mul.7, -1
  %198 = trunc i64 %indvars.iv.next20.6 to i32
  %add58.7 = shl i32 %198, 7
  %199 = trunc i64 %indvars.iv.next20.6 to i32
  %add79.7 = shl i32 %199, 7
  %mul80.7 = add i32 %add79.7, 128
  %mul85.7 = add i32 %add79.7, -128
  %200 = trunc i64 %indvars.iv.next20.6 to i32
  %sub98.7 = shl i32 %200, 7
  %201 = sext i32 %mul.7 to i64
  %202 = sext i32 %mul85.7 to i64
  %203 = sext i32 %mul80.7 to i64
  br label %for.body6.7

for.body6.7:                                      ; preds = %for.inc.7, %for.body6.lr.ph.7
  %indvars.iv.7 = phi i64 [ 0, %for.body6.lr.ph.7 ], [ %indvars.iv.next.7, %for.inc.7 ]
  %204 = add nsw i64 %indvars.iv.7, %201
  %cmp12.7 = icmp eq i64 %indvars.iv.7, 0
  %or.cond1.7 = or i1 %cmp9.7, %cmp12.7
  %cmp15.7 = icmp eq i64 %indvars.iv.7, %1
  %or.cond2.7 = or i1 %cmp15.7, %or.cond1.7
  br i1 %or.cond2.7, label %if.then.7, label %if.else.7

if.else.7:                                        ; preds = %for.body6.7
  %arrayidx18.7 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %204
  %205 = load float, float* %arrayidx18.7, align 4
  %conv19.7 = fpext float %205 to double
  %mul20.7 = fmul double %conv19.7, 0x404CA5DC1A63C1F8
  %conv21.7 = fptrunc double %mul20.7 to float
  %cmp22.7 = fcmp olt float %conv21.7, 0.000000e+00
  %add25.7 = fadd float %conv21.7, 1.800000e+02
  %angle.0.7 = select i1 %cmp22.7, float %add25.7, float %conv21.7
  %cmp26.7 = fcmp oge float %angle.0.7, 0.000000e+00
  %cmp29.7 = fcmp olt float %angle.0.7, 2.250000e+01
  %or.cond3.7 = and i1 %cmp26.7, %cmp29.7
  br i1 %or.cond3.7, label %if.then38.7, label %lor.lhs.false31.7

lor.lhs.false31.7:                                ; preds = %if.else.7
  %cmp33.7 = fcmp ult float %angle.0.7, 1.575000e+02
  %cmp36.7 = fcmp ugt float %angle.0.7, 1.800000e+02
  %or.cond4.7 = or i1 %cmp33.7, %cmp36.7
  br i1 %or.cond4.7, label %if.else49.7, label %if.then38.7

if.else49.7:                                      ; preds = %lor.lhs.false31.7
  %cmp51.7 = fcmp oge float %angle.0.7, 2.250000e+01
  %cmp55.7 = fcmp olt float %angle.0.7, 6.750000e+01
  %or.cond5.7 = and i1 %cmp51.7, %cmp55.7
  br i1 %or.cond5.7, label %if.then57.7, label %if.else70.7

if.else70.7:                                      ; preds = %if.else49.7
  %cmp72.7 = fcmp oge float %angle.0.7, 6.750000e+01
  %cmp76.7 = fcmp olt float %angle.0.7, 1.125000e+02
  %or.cond6.7 = and i1 %cmp72.7, %cmp76.7
  br i1 %or.cond6.7, label %if.then78.7, label %if.else89.7

if.else89.7:                                      ; preds = %if.else70.7
  %cmp91.7 = fcmp oge float %angle.0.7, 1.125000e+02
  %cmp95.7 = fcmp olt float %angle.0.7, 1.575000e+02
  %or.cond7.7 = and i1 %cmp91.7, %cmp95.7
  br i1 %or.cond7.7, label %if.then97.7, label %if.end113.7

if.then97.7:                                      ; preds = %if.else89.7
  %206 = trunc i64 %indvars.iv.7 to i32
  %sub100.7 = add i32 %206, %sub98.7
  %add101.7 = add i32 %sub100.7, -129
  %idxprom102.7 = sext i32 %add101.7 to i64
  %arrayidx103.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.7
  %207 = load float, float* %arrayidx103.7, align 4
  %add107.7 = add i32 %sub100.7, 129
  %idxprom108.7 = sext i32 %add107.7 to i64
  %arrayidx109.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.7
  %208 = load float, float* %arrayidx109.7, align 4
  br label %if.end113.7

if.then78.7:                                      ; preds = %if.else70.7
  %209 = add nsw i64 %203, %indvars.iv.7
  %arrayidx83.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %209
  %210 = load float, float* %arrayidx83.7, align 4
  %211 = add nsw i64 %202, %indvars.iv.7
  %arrayidx88.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %211
  %212 = load float, float* %arrayidx88.7, align 4
  br label %if.end113.7

if.then57.7:                                      ; preds = %if.else49.7
  %213 = trunc i64 %indvars.iv.7 to i32
  %sub60.7 = add i32 %213, %add58.7
  %add61.7 = add i32 %sub60.7, 127
  %idxprom62.7 = sext i32 %add61.7 to i64
  %arrayidx63.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.7
  %214 = load float, float* %arrayidx63.7, align 4
  %add67.7 = add i32 %sub60.7, -127
  %idxprom68.7 = sext i32 %add67.7 to i64
  %arrayidx69.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.7
  %215 = load float, float* %arrayidx69.7, align 4
  br label %if.end113.7

if.then38.7:                                      ; preds = %lor.lhs.false31.7, %if.else.7
  %216 = trunc i64 %indvars.iv.7 to i32
  %add41.7 = add i32 %add40.7, %216
  %idxprom42.7 = sext i32 %add41.7 to i64
  %arrayidx43.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.7
  %217 = load float, float* %arrayidx43.7, align 4
  %218 = trunc i64 %indvars.iv.7 to i32
  %add46.7 = add i32 %sub45.7, %218
  %idxprom47.7 = sext i32 %add46.7 to i64
  %arrayidx48.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.7
  %219 = load float, float* %arrayidx48.7, align 4
  br label %if.end113.7

if.end113.7:                                      ; preds = %if.then38.7, %if.then57.7, %if.then78.7, %if.then97.7, %if.else89.7
  %q.3.7 = phi float [ %217, %if.then38.7 ], [ %214, %if.then57.7 ], [ %210, %if.then78.7 ], [ %207, %if.then97.7 ], [ 2.550000e+02, %if.else89.7 ]
  %r.3.7 = phi float [ %219, %if.then38.7 ], [ %215, %if.then57.7 ], [ %212, %if.then78.7 ], [ %208, %if.then97.7 ], [ 2.550000e+02, %if.else89.7 ]
  %arrayidx115.7 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %204
  %220 = load float, float* %arrayidx115.7, align 4
  %cmp116.7 = fcmp ult float %220, %q.3.7
  %cmp121.7 = fcmp ult float %220, %r.3.7
  %or.cond8.7 = or i1 %cmp116.7, %cmp121.7
  br i1 %or.cond8.7, label %if.else129.7, label %if.then123.7

if.then123.7:                                     ; preds = %if.end113.7
  %conv126.7 = fptoui float %220 to i32
  %arrayidx128.7 = getelementptr inbounds i32, i32* %0, i64 %204
  store i32 %conv126.7, i32* %arrayidx128.7, align 4
  br label %for.inc.7

if.else129.7:                                     ; preds = %if.end113.7
  %arrayidx131.7 = getelementptr inbounds i32, i32* %0, i64 %204
  store i32 0, i32* %arrayidx131.7, align 4
  br label %for.inc.7

if.then.7:                                        ; preds = %for.body6.7
  %arrayidx.7 = getelementptr inbounds i32, i32* %0, i64 %204
  store i32 0, i32* %arrayidx.7, align 4
  br label %for.inc.7

for.inc.7:                                        ; preds = %if.then.7, %if.else129.7, %if.then123.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %lftr.wideiv.7 = trunc i64 %indvars.iv.next.7 to i32
  %exitcond.7 = icmp eq i32 %lftr.wideiv.7, %img_width
  br i1 %exitcond.7, label %for.inc134.7, label %for.body6.7, !llvm.loop !1

for.inc134.7:                                     ; preds = %for.inc.7
  %indvars.iv.next20.7 = add nsw i64 %indvars.iv19, 8
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.8

for.body6.lr.ph.8:                                ; preds = %for.inc134.7
  %221 = trunc i64 %indvars.iv.next20.7 to i32
  %mul.8 = shl nsw i32 %221, 7
  %cmp9.8 = icmp eq i64 %indvars.iv.next20.7, %2
  %add40.8 = or i32 %mul.8, 1
  %sub45.8 = add i32 %mul.8, -1
  %222 = trunc i64 %indvars.iv.next20.7 to i32
  %add58.8 = shl i32 %222, 7
  %223 = trunc i64 %indvars.iv.next20.7 to i32
  %add79.8 = shl i32 %223, 7
  %mul80.8 = add i32 %add79.8, 128
  %mul85.8 = add i32 %add79.8, -128
  %224 = trunc i64 %indvars.iv.next20.7 to i32
  %sub98.8 = shl i32 %224, 7
  %225 = sext i32 %mul.8 to i64
  %226 = sext i32 %mul85.8 to i64
  %227 = sext i32 %mul80.8 to i64
  br label %for.body6.8

for.body6.8:                                      ; preds = %for.inc.8, %for.body6.lr.ph.8
  %indvars.iv.8 = phi i64 [ 0, %for.body6.lr.ph.8 ], [ %indvars.iv.next.8, %for.inc.8 ]
  %228 = add nsw i64 %indvars.iv.8, %225
  %cmp12.8 = icmp eq i64 %indvars.iv.8, 0
  %or.cond1.8 = or i1 %cmp9.8, %cmp12.8
  %cmp15.8 = icmp eq i64 %indvars.iv.8, %1
  %or.cond2.8 = or i1 %cmp15.8, %or.cond1.8
  br i1 %or.cond2.8, label %if.then.8, label %if.else.8

if.else.8:                                        ; preds = %for.body6.8
  %arrayidx18.8 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %228
  %229 = load float, float* %arrayidx18.8, align 4
  %conv19.8 = fpext float %229 to double
  %mul20.8 = fmul double %conv19.8, 0x404CA5DC1A63C1F8
  %conv21.8 = fptrunc double %mul20.8 to float
  %cmp22.8 = fcmp olt float %conv21.8, 0.000000e+00
  %add25.8 = fadd float %conv21.8, 1.800000e+02
  %angle.0.8 = select i1 %cmp22.8, float %add25.8, float %conv21.8
  %cmp26.8 = fcmp oge float %angle.0.8, 0.000000e+00
  %cmp29.8 = fcmp olt float %angle.0.8, 2.250000e+01
  %or.cond3.8 = and i1 %cmp26.8, %cmp29.8
  br i1 %or.cond3.8, label %if.then38.8, label %lor.lhs.false31.8

lor.lhs.false31.8:                                ; preds = %if.else.8
  %cmp33.8 = fcmp ult float %angle.0.8, 1.575000e+02
  %cmp36.8 = fcmp ugt float %angle.0.8, 1.800000e+02
  %or.cond4.8 = or i1 %cmp33.8, %cmp36.8
  br i1 %or.cond4.8, label %if.else49.8, label %if.then38.8

if.else49.8:                                      ; preds = %lor.lhs.false31.8
  %cmp51.8 = fcmp oge float %angle.0.8, 2.250000e+01
  %cmp55.8 = fcmp olt float %angle.0.8, 6.750000e+01
  %or.cond5.8 = and i1 %cmp51.8, %cmp55.8
  br i1 %or.cond5.8, label %if.then57.8, label %if.else70.8

if.else70.8:                                      ; preds = %if.else49.8
  %cmp72.8 = fcmp oge float %angle.0.8, 6.750000e+01
  %cmp76.8 = fcmp olt float %angle.0.8, 1.125000e+02
  %or.cond6.8 = and i1 %cmp72.8, %cmp76.8
  br i1 %or.cond6.8, label %if.then78.8, label %if.else89.8

if.else89.8:                                      ; preds = %if.else70.8
  %cmp91.8 = fcmp oge float %angle.0.8, 1.125000e+02
  %cmp95.8 = fcmp olt float %angle.0.8, 1.575000e+02
  %or.cond7.8 = and i1 %cmp91.8, %cmp95.8
  br i1 %or.cond7.8, label %if.then97.8, label %if.end113.8

if.then97.8:                                      ; preds = %if.else89.8
  %230 = trunc i64 %indvars.iv.8 to i32
  %sub100.8 = add i32 %230, %sub98.8
  %add101.8 = add i32 %sub100.8, -129
  %idxprom102.8 = sext i32 %add101.8 to i64
  %arrayidx103.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.8
  %231 = load float, float* %arrayidx103.8, align 4
  %add107.8 = add i32 %sub100.8, 129
  %idxprom108.8 = sext i32 %add107.8 to i64
  %arrayidx109.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.8
  %232 = load float, float* %arrayidx109.8, align 4
  br label %if.end113.8

if.then78.8:                                      ; preds = %if.else70.8
  %233 = add nsw i64 %227, %indvars.iv.8
  %arrayidx83.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %233
  %234 = load float, float* %arrayidx83.8, align 4
  %235 = add nsw i64 %226, %indvars.iv.8
  %arrayidx88.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %235
  %236 = load float, float* %arrayidx88.8, align 4
  br label %if.end113.8

if.then57.8:                                      ; preds = %if.else49.8
  %237 = trunc i64 %indvars.iv.8 to i32
  %sub60.8 = add i32 %237, %add58.8
  %add61.8 = add i32 %sub60.8, 127
  %idxprom62.8 = sext i32 %add61.8 to i64
  %arrayidx63.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.8
  %238 = load float, float* %arrayidx63.8, align 4
  %add67.8 = add i32 %sub60.8, -127
  %idxprom68.8 = sext i32 %add67.8 to i64
  %arrayidx69.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.8
  %239 = load float, float* %arrayidx69.8, align 4
  br label %if.end113.8

if.then38.8:                                      ; preds = %lor.lhs.false31.8, %if.else.8
  %240 = trunc i64 %indvars.iv.8 to i32
  %add41.8 = add i32 %add40.8, %240
  %idxprom42.8 = sext i32 %add41.8 to i64
  %arrayidx43.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.8
  %241 = load float, float* %arrayidx43.8, align 4
  %242 = trunc i64 %indvars.iv.8 to i32
  %add46.8 = add i32 %sub45.8, %242
  %idxprom47.8 = sext i32 %add46.8 to i64
  %arrayidx48.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.8
  %243 = load float, float* %arrayidx48.8, align 4
  br label %if.end113.8

if.end113.8:                                      ; preds = %if.then38.8, %if.then57.8, %if.then78.8, %if.then97.8, %if.else89.8
  %q.3.8 = phi float [ %241, %if.then38.8 ], [ %238, %if.then57.8 ], [ %234, %if.then78.8 ], [ %231, %if.then97.8 ], [ 2.550000e+02, %if.else89.8 ]
  %r.3.8 = phi float [ %243, %if.then38.8 ], [ %239, %if.then57.8 ], [ %236, %if.then78.8 ], [ %232, %if.then97.8 ], [ 2.550000e+02, %if.else89.8 ]
  %arrayidx115.8 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %228
  %244 = load float, float* %arrayidx115.8, align 4
  %cmp116.8 = fcmp ult float %244, %q.3.8
  %cmp121.8 = fcmp ult float %244, %r.3.8
  %or.cond8.8 = or i1 %cmp116.8, %cmp121.8
  br i1 %or.cond8.8, label %if.else129.8, label %if.then123.8

if.then123.8:                                     ; preds = %if.end113.8
  %conv126.8 = fptoui float %244 to i32
  %arrayidx128.8 = getelementptr inbounds i32, i32* %0, i64 %228
  store i32 %conv126.8, i32* %arrayidx128.8, align 4
  br label %for.inc.8

if.else129.8:                                     ; preds = %if.end113.8
  %arrayidx131.8 = getelementptr inbounds i32, i32* %0, i64 %228
  store i32 0, i32* %arrayidx131.8, align 4
  br label %for.inc.8

if.then.8:                                        ; preds = %for.body6.8
  %arrayidx.8 = getelementptr inbounds i32, i32* %0, i64 %228
  store i32 0, i32* %arrayidx.8, align 4
  br label %for.inc.8

for.inc.8:                                        ; preds = %if.then.8, %if.else129.8, %if.then123.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %lftr.wideiv.8 = trunc i64 %indvars.iv.next.8 to i32
  %exitcond.8 = icmp eq i32 %lftr.wideiv.8, %img_width
  br i1 %exitcond.8, label %for.inc134.8, label %for.body6.8, !llvm.loop !1

for.inc134.8:                                     ; preds = %for.inc.8
  %indvars.iv.next20.8 = add nsw i64 %indvars.iv19, 9
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.9

for.body6.lr.ph.9:                                ; preds = %for.inc134.8
  %245 = trunc i64 %indvars.iv.next20.8 to i32
  %mul.9 = shl nsw i32 %245, 7
  %cmp9.9 = icmp eq i64 %indvars.iv.next20.8, %2
  %add40.9 = or i32 %mul.9, 1
  %sub45.9 = add i32 %mul.9, -1
  %246 = trunc i64 %indvars.iv.next20.8 to i32
  %add58.9 = shl i32 %246, 7
  %247 = trunc i64 %indvars.iv.next20.8 to i32
  %add79.9 = shl i32 %247, 7
  %mul80.9 = add i32 %add79.9, 128
  %mul85.9 = add i32 %add79.9, -128
  %248 = trunc i64 %indvars.iv.next20.8 to i32
  %sub98.9 = shl i32 %248, 7
  %249 = sext i32 %mul.9 to i64
  %250 = sext i32 %mul85.9 to i64
  %251 = sext i32 %mul80.9 to i64
  br label %for.body6.9

for.body6.9:                                      ; preds = %for.inc.9, %for.body6.lr.ph.9
  %indvars.iv.9 = phi i64 [ 0, %for.body6.lr.ph.9 ], [ %indvars.iv.next.9, %for.inc.9 ]
  %252 = add nsw i64 %indvars.iv.9, %249
  %cmp12.9 = icmp eq i64 %indvars.iv.9, 0
  %or.cond1.9 = or i1 %cmp9.9, %cmp12.9
  %cmp15.9 = icmp eq i64 %indvars.iv.9, %1
  %or.cond2.9 = or i1 %cmp15.9, %or.cond1.9
  br i1 %or.cond2.9, label %if.then.9, label %if.else.9

if.else.9:                                        ; preds = %for.body6.9
  %arrayidx18.9 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %252
  %253 = load float, float* %arrayidx18.9, align 4
  %conv19.9 = fpext float %253 to double
  %mul20.9 = fmul double %conv19.9, 0x404CA5DC1A63C1F8
  %conv21.9 = fptrunc double %mul20.9 to float
  %cmp22.9 = fcmp olt float %conv21.9, 0.000000e+00
  %add25.9 = fadd float %conv21.9, 1.800000e+02
  %angle.0.9 = select i1 %cmp22.9, float %add25.9, float %conv21.9
  %cmp26.9 = fcmp oge float %angle.0.9, 0.000000e+00
  %cmp29.9 = fcmp olt float %angle.0.9, 2.250000e+01
  %or.cond3.9 = and i1 %cmp26.9, %cmp29.9
  br i1 %or.cond3.9, label %if.then38.9, label %lor.lhs.false31.9

lor.lhs.false31.9:                                ; preds = %if.else.9
  %cmp33.9 = fcmp ult float %angle.0.9, 1.575000e+02
  %cmp36.9 = fcmp ugt float %angle.0.9, 1.800000e+02
  %or.cond4.9 = or i1 %cmp33.9, %cmp36.9
  br i1 %or.cond4.9, label %if.else49.9, label %if.then38.9

if.else49.9:                                      ; preds = %lor.lhs.false31.9
  %cmp51.9 = fcmp oge float %angle.0.9, 2.250000e+01
  %cmp55.9 = fcmp olt float %angle.0.9, 6.750000e+01
  %or.cond5.9 = and i1 %cmp51.9, %cmp55.9
  br i1 %or.cond5.9, label %if.then57.9, label %if.else70.9

if.else70.9:                                      ; preds = %if.else49.9
  %cmp72.9 = fcmp oge float %angle.0.9, 6.750000e+01
  %cmp76.9 = fcmp olt float %angle.0.9, 1.125000e+02
  %or.cond6.9 = and i1 %cmp72.9, %cmp76.9
  br i1 %or.cond6.9, label %if.then78.9, label %if.else89.9

if.else89.9:                                      ; preds = %if.else70.9
  %cmp91.9 = fcmp oge float %angle.0.9, 1.125000e+02
  %cmp95.9 = fcmp olt float %angle.0.9, 1.575000e+02
  %or.cond7.9 = and i1 %cmp91.9, %cmp95.9
  br i1 %or.cond7.9, label %if.then97.9, label %if.end113.9

if.then97.9:                                      ; preds = %if.else89.9
  %254 = trunc i64 %indvars.iv.9 to i32
  %sub100.9 = add i32 %254, %sub98.9
  %add101.9 = add i32 %sub100.9, -129
  %idxprom102.9 = sext i32 %add101.9 to i64
  %arrayidx103.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.9
  %255 = load float, float* %arrayidx103.9, align 4
  %add107.9 = add i32 %sub100.9, 129
  %idxprom108.9 = sext i32 %add107.9 to i64
  %arrayidx109.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.9
  %256 = load float, float* %arrayidx109.9, align 4
  br label %if.end113.9

if.then78.9:                                      ; preds = %if.else70.9
  %257 = add nsw i64 %251, %indvars.iv.9
  %arrayidx83.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %257
  %258 = load float, float* %arrayidx83.9, align 4
  %259 = add nsw i64 %250, %indvars.iv.9
  %arrayidx88.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %259
  %260 = load float, float* %arrayidx88.9, align 4
  br label %if.end113.9

if.then57.9:                                      ; preds = %if.else49.9
  %261 = trunc i64 %indvars.iv.9 to i32
  %sub60.9 = add i32 %261, %add58.9
  %add61.9 = add i32 %sub60.9, 127
  %idxprom62.9 = sext i32 %add61.9 to i64
  %arrayidx63.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.9
  %262 = load float, float* %arrayidx63.9, align 4
  %add67.9 = add i32 %sub60.9, -127
  %idxprom68.9 = sext i32 %add67.9 to i64
  %arrayidx69.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.9
  %263 = load float, float* %arrayidx69.9, align 4
  br label %if.end113.9

if.then38.9:                                      ; preds = %lor.lhs.false31.9, %if.else.9
  %264 = trunc i64 %indvars.iv.9 to i32
  %add41.9 = add i32 %add40.9, %264
  %idxprom42.9 = sext i32 %add41.9 to i64
  %arrayidx43.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.9
  %265 = load float, float* %arrayidx43.9, align 4
  %266 = trunc i64 %indvars.iv.9 to i32
  %add46.9 = add i32 %sub45.9, %266
  %idxprom47.9 = sext i32 %add46.9 to i64
  %arrayidx48.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.9
  %267 = load float, float* %arrayidx48.9, align 4
  br label %if.end113.9

if.end113.9:                                      ; preds = %if.then38.9, %if.then57.9, %if.then78.9, %if.then97.9, %if.else89.9
  %q.3.9 = phi float [ %265, %if.then38.9 ], [ %262, %if.then57.9 ], [ %258, %if.then78.9 ], [ %255, %if.then97.9 ], [ 2.550000e+02, %if.else89.9 ]
  %r.3.9 = phi float [ %267, %if.then38.9 ], [ %263, %if.then57.9 ], [ %260, %if.then78.9 ], [ %256, %if.then97.9 ], [ 2.550000e+02, %if.else89.9 ]
  %arrayidx115.9 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %252
  %268 = load float, float* %arrayidx115.9, align 4
  %cmp116.9 = fcmp ult float %268, %q.3.9
  %cmp121.9 = fcmp ult float %268, %r.3.9
  %or.cond8.9 = or i1 %cmp116.9, %cmp121.9
  br i1 %or.cond8.9, label %if.else129.9, label %if.then123.9

if.then123.9:                                     ; preds = %if.end113.9
  %conv126.9 = fptoui float %268 to i32
  %arrayidx128.9 = getelementptr inbounds i32, i32* %0, i64 %252
  store i32 %conv126.9, i32* %arrayidx128.9, align 4
  br label %for.inc.9

if.else129.9:                                     ; preds = %if.end113.9
  %arrayidx131.9 = getelementptr inbounds i32, i32* %0, i64 %252
  store i32 0, i32* %arrayidx131.9, align 4
  br label %for.inc.9

if.then.9:                                        ; preds = %for.body6.9
  %arrayidx.9 = getelementptr inbounds i32, i32* %0, i64 %252
  store i32 0, i32* %arrayidx.9, align 4
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.then.9, %if.else129.9, %if.then123.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %lftr.wideiv.9 = trunc i64 %indvars.iv.next.9 to i32
  %exitcond.9 = icmp eq i32 %lftr.wideiv.9, %img_width
  br i1 %exitcond.9, label %for.inc134.9, label %for.body6.9, !llvm.loop !1

for.inc134.9:                                     ; preds = %for.inc.9
  %indvars.iv.next20.9 = add nsw i64 %indvars.iv19, 10
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.10

for.body6.lr.ph.10:                               ; preds = %for.inc134.9
  %269 = trunc i64 %indvars.iv.next20.9 to i32
  %mul.10 = shl nsw i32 %269, 7
  %cmp9.10 = icmp eq i64 %indvars.iv.next20.9, %2
  %add40.10 = or i32 %mul.10, 1
  %sub45.10 = add i32 %mul.10, -1
  %270 = trunc i64 %indvars.iv.next20.9 to i32
  %add58.10 = shl i32 %270, 7
  %271 = trunc i64 %indvars.iv.next20.9 to i32
  %add79.10 = shl i32 %271, 7
  %mul80.10 = add i32 %add79.10, 128
  %mul85.10 = add i32 %add79.10, -128
  %272 = trunc i64 %indvars.iv.next20.9 to i32
  %sub98.10 = shl i32 %272, 7
  %273 = sext i32 %mul.10 to i64
  %274 = sext i32 %mul85.10 to i64
  %275 = sext i32 %mul80.10 to i64
  br label %for.body6.10

for.body6.10:                                     ; preds = %for.inc.10, %for.body6.lr.ph.10
  %indvars.iv.10 = phi i64 [ 0, %for.body6.lr.ph.10 ], [ %indvars.iv.next.10, %for.inc.10 ]
  %276 = add nsw i64 %indvars.iv.10, %273
  %cmp12.10 = icmp eq i64 %indvars.iv.10, 0
  %or.cond1.10 = or i1 %cmp9.10, %cmp12.10
  %cmp15.10 = icmp eq i64 %indvars.iv.10, %1
  %or.cond2.10 = or i1 %cmp15.10, %or.cond1.10
  br i1 %or.cond2.10, label %if.then.10, label %if.else.10

if.else.10:                                       ; preds = %for.body6.10
  %arrayidx18.10 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %276
  %277 = load float, float* %arrayidx18.10, align 4
  %conv19.10 = fpext float %277 to double
  %mul20.10 = fmul double %conv19.10, 0x404CA5DC1A63C1F8
  %conv21.10 = fptrunc double %mul20.10 to float
  %cmp22.10 = fcmp olt float %conv21.10, 0.000000e+00
  %add25.10 = fadd float %conv21.10, 1.800000e+02
  %angle.0.10 = select i1 %cmp22.10, float %add25.10, float %conv21.10
  %cmp26.10 = fcmp oge float %angle.0.10, 0.000000e+00
  %cmp29.10 = fcmp olt float %angle.0.10, 2.250000e+01
  %or.cond3.10 = and i1 %cmp26.10, %cmp29.10
  br i1 %or.cond3.10, label %if.then38.10, label %lor.lhs.false31.10

lor.lhs.false31.10:                               ; preds = %if.else.10
  %cmp33.10 = fcmp ult float %angle.0.10, 1.575000e+02
  %cmp36.10 = fcmp ugt float %angle.0.10, 1.800000e+02
  %or.cond4.10 = or i1 %cmp33.10, %cmp36.10
  br i1 %or.cond4.10, label %if.else49.10, label %if.then38.10

if.else49.10:                                     ; preds = %lor.lhs.false31.10
  %cmp51.10 = fcmp oge float %angle.0.10, 2.250000e+01
  %cmp55.10 = fcmp olt float %angle.0.10, 6.750000e+01
  %or.cond5.10 = and i1 %cmp51.10, %cmp55.10
  br i1 %or.cond5.10, label %if.then57.10, label %if.else70.10

if.else70.10:                                     ; preds = %if.else49.10
  %cmp72.10 = fcmp oge float %angle.0.10, 6.750000e+01
  %cmp76.10 = fcmp olt float %angle.0.10, 1.125000e+02
  %or.cond6.10 = and i1 %cmp72.10, %cmp76.10
  br i1 %or.cond6.10, label %if.then78.10, label %if.else89.10

if.else89.10:                                     ; preds = %if.else70.10
  %cmp91.10 = fcmp oge float %angle.0.10, 1.125000e+02
  %cmp95.10 = fcmp olt float %angle.0.10, 1.575000e+02
  %or.cond7.10 = and i1 %cmp91.10, %cmp95.10
  br i1 %or.cond7.10, label %if.then97.10, label %if.end113.10

if.then97.10:                                     ; preds = %if.else89.10
  %278 = trunc i64 %indvars.iv.10 to i32
  %sub100.10 = add i32 %278, %sub98.10
  %add101.10 = add i32 %sub100.10, -129
  %idxprom102.10 = sext i32 %add101.10 to i64
  %arrayidx103.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.10
  %279 = load float, float* %arrayidx103.10, align 4
  %add107.10 = add i32 %sub100.10, 129
  %idxprom108.10 = sext i32 %add107.10 to i64
  %arrayidx109.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.10
  %280 = load float, float* %arrayidx109.10, align 4
  br label %if.end113.10

if.then78.10:                                     ; preds = %if.else70.10
  %281 = add nsw i64 %275, %indvars.iv.10
  %arrayidx83.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %281
  %282 = load float, float* %arrayidx83.10, align 4
  %283 = add nsw i64 %274, %indvars.iv.10
  %arrayidx88.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %283
  %284 = load float, float* %arrayidx88.10, align 4
  br label %if.end113.10

if.then57.10:                                     ; preds = %if.else49.10
  %285 = trunc i64 %indvars.iv.10 to i32
  %sub60.10 = add i32 %285, %add58.10
  %add61.10 = add i32 %sub60.10, 127
  %idxprom62.10 = sext i32 %add61.10 to i64
  %arrayidx63.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.10
  %286 = load float, float* %arrayidx63.10, align 4
  %add67.10 = add i32 %sub60.10, -127
  %idxprom68.10 = sext i32 %add67.10 to i64
  %arrayidx69.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.10
  %287 = load float, float* %arrayidx69.10, align 4
  br label %if.end113.10

if.then38.10:                                     ; preds = %lor.lhs.false31.10, %if.else.10
  %288 = trunc i64 %indvars.iv.10 to i32
  %add41.10 = add i32 %add40.10, %288
  %idxprom42.10 = sext i32 %add41.10 to i64
  %arrayidx43.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.10
  %289 = load float, float* %arrayidx43.10, align 4
  %290 = trunc i64 %indvars.iv.10 to i32
  %add46.10 = add i32 %sub45.10, %290
  %idxprom47.10 = sext i32 %add46.10 to i64
  %arrayidx48.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.10
  %291 = load float, float* %arrayidx48.10, align 4
  br label %if.end113.10

if.end113.10:                                     ; preds = %if.then38.10, %if.then57.10, %if.then78.10, %if.then97.10, %if.else89.10
  %q.3.10 = phi float [ %289, %if.then38.10 ], [ %286, %if.then57.10 ], [ %282, %if.then78.10 ], [ %279, %if.then97.10 ], [ 2.550000e+02, %if.else89.10 ]
  %r.3.10 = phi float [ %291, %if.then38.10 ], [ %287, %if.then57.10 ], [ %284, %if.then78.10 ], [ %280, %if.then97.10 ], [ 2.550000e+02, %if.else89.10 ]
  %arrayidx115.10 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %276
  %292 = load float, float* %arrayidx115.10, align 4
  %cmp116.10 = fcmp ult float %292, %q.3.10
  %cmp121.10 = fcmp ult float %292, %r.3.10
  %or.cond8.10 = or i1 %cmp116.10, %cmp121.10
  br i1 %or.cond8.10, label %if.else129.10, label %if.then123.10

if.then123.10:                                    ; preds = %if.end113.10
  %conv126.10 = fptoui float %292 to i32
  %arrayidx128.10 = getelementptr inbounds i32, i32* %0, i64 %276
  store i32 %conv126.10, i32* %arrayidx128.10, align 4
  br label %for.inc.10

if.else129.10:                                    ; preds = %if.end113.10
  %arrayidx131.10 = getelementptr inbounds i32, i32* %0, i64 %276
  store i32 0, i32* %arrayidx131.10, align 4
  br label %for.inc.10

if.then.10:                                       ; preds = %for.body6.10
  %arrayidx.10 = getelementptr inbounds i32, i32* %0, i64 %276
  store i32 0, i32* %arrayidx.10, align 4
  br label %for.inc.10

for.inc.10:                                       ; preds = %if.then.10, %if.else129.10, %if.then123.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %lftr.wideiv.10 = trunc i64 %indvars.iv.next.10 to i32
  %exitcond.10 = icmp eq i32 %lftr.wideiv.10, %img_width
  br i1 %exitcond.10, label %for.inc134.10, label %for.body6.10, !llvm.loop !1

for.inc134.10:                                    ; preds = %for.inc.10
  %indvars.iv.next20.10 = add nsw i64 %indvars.iv19, 11
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.11

for.body6.lr.ph.11:                               ; preds = %for.inc134.10
  %293 = trunc i64 %indvars.iv.next20.10 to i32
  %mul.11 = shl nsw i32 %293, 7
  %cmp9.11 = icmp eq i64 %indvars.iv.next20.10, %2
  %add40.11 = or i32 %mul.11, 1
  %sub45.11 = add i32 %mul.11, -1
  %294 = trunc i64 %indvars.iv.next20.10 to i32
  %add58.11 = shl i32 %294, 7
  %295 = trunc i64 %indvars.iv.next20.10 to i32
  %add79.11 = shl i32 %295, 7
  %mul80.11 = add i32 %add79.11, 128
  %mul85.11 = add i32 %add79.11, -128
  %296 = trunc i64 %indvars.iv.next20.10 to i32
  %sub98.11 = shl i32 %296, 7
  %297 = sext i32 %mul.11 to i64
  %298 = sext i32 %mul85.11 to i64
  %299 = sext i32 %mul80.11 to i64
  br label %for.body6.11

for.body6.11:                                     ; preds = %for.inc.11, %for.body6.lr.ph.11
  %indvars.iv.11 = phi i64 [ 0, %for.body6.lr.ph.11 ], [ %indvars.iv.next.11, %for.inc.11 ]
  %300 = add nsw i64 %indvars.iv.11, %297
  %cmp12.11 = icmp eq i64 %indvars.iv.11, 0
  %or.cond1.11 = or i1 %cmp9.11, %cmp12.11
  %cmp15.11 = icmp eq i64 %indvars.iv.11, %1
  %or.cond2.11 = or i1 %cmp15.11, %or.cond1.11
  br i1 %or.cond2.11, label %if.then.11, label %if.else.11

if.else.11:                                       ; preds = %for.body6.11
  %arrayidx18.11 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %300
  %301 = load float, float* %arrayidx18.11, align 4
  %conv19.11 = fpext float %301 to double
  %mul20.11 = fmul double %conv19.11, 0x404CA5DC1A63C1F8
  %conv21.11 = fptrunc double %mul20.11 to float
  %cmp22.11 = fcmp olt float %conv21.11, 0.000000e+00
  %add25.11 = fadd float %conv21.11, 1.800000e+02
  %angle.0.11 = select i1 %cmp22.11, float %add25.11, float %conv21.11
  %cmp26.11 = fcmp oge float %angle.0.11, 0.000000e+00
  %cmp29.11 = fcmp olt float %angle.0.11, 2.250000e+01
  %or.cond3.11 = and i1 %cmp26.11, %cmp29.11
  br i1 %or.cond3.11, label %if.then38.11, label %lor.lhs.false31.11

lor.lhs.false31.11:                               ; preds = %if.else.11
  %cmp33.11 = fcmp ult float %angle.0.11, 1.575000e+02
  %cmp36.11 = fcmp ugt float %angle.0.11, 1.800000e+02
  %or.cond4.11 = or i1 %cmp33.11, %cmp36.11
  br i1 %or.cond4.11, label %if.else49.11, label %if.then38.11

if.else49.11:                                     ; preds = %lor.lhs.false31.11
  %cmp51.11 = fcmp oge float %angle.0.11, 2.250000e+01
  %cmp55.11 = fcmp olt float %angle.0.11, 6.750000e+01
  %or.cond5.11 = and i1 %cmp51.11, %cmp55.11
  br i1 %or.cond5.11, label %if.then57.11, label %if.else70.11

if.else70.11:                                     ; preds = %if.else49.11
  %cmp72.11 = fcmp oge float %angle.0.11, 6.750000e+01
  %cmp76.11 = fcmp olt float %angle.0.11, 1.125000e+02
  %or.cond6.11 = and i1 %cmp72.11, %cmp76.11
  br i1 %or.cond6.11, label %if.then78.11, label %if.else89.11

if.else89.11:                                     ; preds = %if.else70.11
  %cmp91.11 = fcmp oge float %angle.0.11, 1.125000e+02
  %cmp95.11 = fcmp olt float %angle.0.11, 1.575000e+02
  %or.cond7.11 = and i1 %cmp91.11, %cmp95.11
  br i1 %or.cond7.11, label %if.then97.11, label %if.end113.11

if.then97.11:                                     ; preds = %if.else89.11
  %302 = trunc i64 %indvars.iv.11 to i32
  %sub100.11 = add i32 %302, %sub98.11
  %add101.11 = add i32 %sub100.11, -129
  %idxprom102.11 = sext i32 %add101.11 to i64
  %arrayidx103.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.11
  %303 = load float, float* %arrayidx103.11, align 4
  %add107.11 = add i32 %sub100.11, 129
  %idxprom108.11 = sext i32 %add107.11 to i64
  %arrayidx109.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.11
  %304 = load float, float* %arrayidx109.11, align 4
  br label %if.end113.11

if.then78.11:                                     ; preds = %if.else70.11
  %305 = add nsw i64 %299, %indvars.iv.11
  %arrayidx83.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %305
  %306 = load float, float* %arrayidx83.11, align 4
  %307 = add nsw i64 %298, %indvars.iv.11
  %arrayidx88.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %307
  %308 = load float, float* %arrayidx88.11, align 4
  br label %if.end113.11

if.then57.11:                                     ; preds = %if.else49.11
  %309 = trunc i64 %indvars.iv.11 to i32
  %sub60.11 = add i32 %309, %add58.11
  %add61.11 = add i32 %sub60.11, 127
  %idxprom62.11 = sext i32 %add61.11 to i64
  %arrayidx63.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.11
  %310 = load float, float* %arrayidx63.11, align 4
  %add67.11 = add i32 %sub60.11, -127
  %idxprom68.11 = sext i32 %add67.11 to i64
  %arrayidx69.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.11
  %311 = load float, float* %arrayidx69.11, align 4
  br label %if.end113.11

if.then38.11:                                     ; preds = %lor.lhs.false31.11, %if.else.11
  %312 = trunc i64 %indvars.iv.11 to i32
  %add41.11 = add i32 %add40.11, %312
  %idxprom42.11 = sext i32 %add41.11 to i64
  %arrayidx43.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.11
  %313 = load float, float* %arrayidx43.11, align 4
  %314 = trunc i64 %indvars.iv.11 to i32
  %add46.11 = add i32 %sub45.11, %314
  %idxprom47.11 = sext i32 %add46.11 to i64
  %arrayidx48.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.11
  %315 = load float, float* %arrayidx48.11, align 4
  br label %if.end113.11

if.end113.11:                                     ; preds = %if.then38.11, %if.then57.11, %if.then78.11, %if.then97.11, %if.else89.11
  %q.3.11 = phi float [ %313, %if.then38.11 ], [ %310, %if.then57.11 ], [ %306, %if.then78.11 ], [ %303, %if.then97.11 ], [ 2.550000e+02, %if.else89.11 ]
  %r.3.11 = phi float [ %315, %if.then38.11 ], [ %311, %if.then57.11 ], [ %308, %if.then78.11 ], [ %304, %if.then97.11 ], [ 2.550000e+02, %if.else89.11 ]
  %arrayidx115.11 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %300
  %316 = load float, float* %arrayidx115.11, align 4
  %cmp116.11 = fcmp ult float %316, %q.3.11
  %cmp121.11 = fcmp ult float %316, %r.3.11
  %or.cond8.11 = or i1 %cmp116.11, %cmp121.11
  br i1 %or.cond8.11, label %if.else129.11, label %if.then123.11

if.then123.11:                                    ; preds = %if.end113.11
  %conv126.11 = fptoui float %316 to i32
  %arrayidx128.11 = getelementptr inbounds i32, i32* %0, i64 %300
  store i32 %conv126.11, i32* %arrayidx128.11, align 4
  br label %for.inc.11

if.else129.11:                                    ; preds = %if.end113.11
  %arrayidx131.11 = getelementptr inbounds i32, i32* %0, i64 %300
  store i32 0, i32* %arrayidx131.11, align 4
  br label %for.inc.11

if.then.11:                                       ; preds = %for.body6.11
  %arrayidx.11 = getelementptr inbounds i32, i32* %0, i64 %300
  store i32 0, i32* %arrayidx.11, align 4
  br label %for.inc.11

for.inc.11:                                       ; preds = %if.then.11, %if.else129.11, %if.then123.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %lftr.wideiv.11 = trunc i64 %indvars.iv.next.11 to i32
  %exitcond.11 = icmp eq i32 %lftr.wideiv.11, %img_width
  br i1 %exitcond.11, label %for.inc134.11, label %for.body6.11, !llvm.loop !1

for.inc134.11:                                    ; preds = %for.inc.11
  %indvars.iv.next20.11 = add nsw i64 %indvars.iv19, 12
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.12

for.body6.lr.ph.12:                               ; preds = %for.inc134.11
  %317 = trunc i64 %indvars.iv.next20.11 to i32
  %mul.12 = shl nsw i32 %317, 7
  %cmp9.12 = icmp eq i64 %indvars.iv.next20.11, %2
  %add40.12 = or i32 %mul.12, 1
  %sub45.12 = add i32 %mul.12, -1
  %318 = trunc i64 %indvars.iv.next20.11 to i32
  %add58.12 = shl i32 %318, 7
  %319 = trunc i64 %indvars.iv.next20.11 to i32
  %add79.12 = shl i32 %319, 7
  %mul80.12 = add i32 %add79.12, 128
  %mul85.12 = add i32 %add79.12, -128
  %320 = trunc i64 %indvars.iv.next20.11 to i32
  %sub98.12 = shl i32 %320, 7
  %321 = sext i32 %mul.12 to i64
  %322 = sext i32 %mul85.12 to i64
  %323 = sext i32 %mul80.12 to i64
  br label %for.body6.12

for.body6.12:                                     ; preds = %for.inc.12, %for.body6.lr.ph.12
  %indvars.iv.12 = phi i64 [ 0, %for.body6.lr.ph.12 ], [ %indvars.iv.next.12, %for.inc.12 ]
  %324 = add nsw i64 %indvars.iv.12, %321
  %cmp12.12 = icmp eq i64 %indvars.iv.12, 0
  %or.cond1.12 = or i1 %cmp9.12, %cmp12.12
  %cmp15.12 = icmp eq i64 %indvars.iv.12, %1
  %or.cond2.12 = or i1 %cmp15.12, %or.cond1.12
  br i1 %or.cond2.12, label %if.then.12, label %if.else.12

if.else.12:                                       ; preds = %for.body6.12
  %arrayidx18.12 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %324
  %325 = load float, float* %arrayidx18.12, align 4
  %conv19.12 = fpext float %325 to double
  %mul20.12 = fmul double %conv19.12, 0x404CA5DC1A63C1F8
  %conv21.12 = fptrunc double %mul20.12 to float
  %cmp22.12 = fcmp olt float %conv21.12, 0.000000e+00
  %add25.12 = fadd float %conv21.12, 1.800000e+02
  %angle.0.12 = select i1 %cmp22.12, float %add25.12, float %conv21.12
  %cmp26.12 = fcmp oge float %angle.0.12, 0.000000e+00
  %cmp29.12 = fcmp olt float %angle.0.12, 2.250000e+01
  %or.cond3.12 = and i1 %cmp26.12, %cmp29.12
  br i1 %or.cond3.12, label %if.then38.12, label %lor.lhs.false31.12

lor.lhs.false31.12:                               ; preds = %if.else.12
  %cmp33.12 = fcmp ult float %angle.0.12, 1.575000e+02
  %cmp36.12 = fcmp ugt float %angle.0.12, 1.800000e+02
  %or.cond4.12 = or i1 %cmp33.12, %cmp36.12
  br i1 %or.cond4.12, label %if.else49.12, label %if.then38.12

if.else49.12:                                     ; preds = %lor.lhs.false31.12
  %cmp51.12 = fcmp oge float %angle.0.12, 2.250000e+01
  %cmp55.12 = fcmp olt float %angle.0.12, 6.750000e+01
  %or.cond5.12 = and i1 %cmp51.12, %cmp55.12
  br i1 %or.cond5.12, label %if.then57.12, label %if.else70.12

if.else70.12:                                     ; preds = %if.else49.12
  %cmp72.12 = fcmp oge float %angle.0.12, 6.750000e+01
  %cmp76.12 = fcmp olt float %angle.0.12, 1.125000e+02
  %or.cond6.12 = and i1 %cmp72.12, %cmp76.12
  br i1 %or.cond6.12, label %if.then78.12, label %if.else89.12

if.else89.12:                                     ; preds = %if.else70.12
  %cmp91.12 = fcmp oge float %angle.0.12, 1.125000e+02
  %cmp95.12 = fcmp olt float %angle.0.12, 1.575000e+02
  %or.cond7.12 = and i1 %cmp91.12, %cmp95.12
  br i1 %or.cond7.12, label %if.then97.12, label %if.end113.12

if.then97.12:                                     ; preds = %if.else89.12
  %326 = trunc i64 %indvars.iv.12 to i32
  %sub100.12 = add i32 %326, %sub98.12
  %add101.12 = add i32 %sub100.12, -129
  %idxprom102.12 = sext i32 %add101.12 to i64
  %arrayidx103.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.12
  %327 = load float, float* %arrayidx103.12, align 4
  %add107.12 = add i32 %sub100.12, 129
  %idxprom108.12 = sext i32 %add107.12 to i64
  %arrayidx109.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.12
  %328 = load float, float* %arrayidx109.12, align 4
  br label %if.end113.12

if.then78.12:                                     ; preds = %if.else70.12
  %329 = add nsw i64 %323, %indvars.iv.12
  %arrayidx83.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %329
  %330 = load float, float* %arrayidx83.12, align 4
  %331 = add nsw i64 %322, %indvars.iv.12
  %arrayidx88.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %331
  %332 = load float, float* %arrayidx88.12, align 4
  br label %if.end113.12

if.then57.12:                                     ; preds = %if.else49.12
  %333 = trunc i64 %indvars.iv.12 to i32
  %sub60.12 = add i32 %333, %add58.12
  %add61.12 = add i32 %sub60.12, 127
  %idxprom62.12 = sext i32 %add61.12 to i64
  %arrayidx63.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.12
  %334 = load float, float* %arrayidx63.12, align 4
  %add67.12 = add i32 %sub60.12, -127
  %idxprom68.12 = sext i32 %add67.12 to i64
  %arrayidx69.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.12
  %335 = load float, float* %arrayidx69.12, align 4
  br label %if.end113.12

if.then38.12:                                     ; preds = %lor.lhs.false31.12, %if.else.12
  %336 = trunc i64 %indvars.iv.12 to i32
  %add41.12 = add i32 %add40.12, %336
  %idxprom42.12 = sext i32 %add41.12 to i64
  %arrayidx43.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.12
  %337 = load float, float* %arrayidx43.12, align 4
  %338 = trunc i64 %indvars.iv.12 to i32
  %add46.12 = add i32 %sub45.12, %338
  %idxprom47.12 = sext i32 %add46.12 to i64
  %arrayidx48.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.12
  %339 = load float, float* %arrayidx48.12, align 4
  br label %if.end113.12

if.end113.12:                                     ; preds = %if.then38.12, %if.then57.12, %if.then78.12, %if.then97.12, %if.else89.12
  %q.3.12 = phi float [ %337, %if.then38.12 ], [ %334, %if.then57.12 ], [ %330, %if.then78.12 ], [ %327, %if.then97.12 ], [ 2.550000e+02, %if.else89.12 ]
  %r.3.12 = phi float [ %339, %if.then38.12 ], [ %335, %if.then57.12 ], [ %332, %if.then78.12 ], [ %328, %if.then97.12 ], [ 2.550000e+02, %if.else89.12 ]
  %arrayidx115.12 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %324
  %340 = load float, float* %arrayidx115.12, align 4
  %cmp116.12 = fcmp ult float %340, %q.3.12
  %cmp121.12 = fcmp ult float %340, %r.3.12
  %or.cond8.12 = or i1 %cmp116.12, %cmp121.12
  br i1 %or.cond8.12, label %if.else129.12, label %if.then123.12

if.then123.12:                                    ; preds = %if.end113.12
  %conv126.12 = fptoui float %340 to i32
  %arrayidx128.12 = getelementptr inbounds i32, i32* %0, i64 %324
  store i32 %conv126.12, i32* %arrayidx128.12, align 4
  br label %for.inc.12

if.else129.12:                                    ; preds = %if.end113.12
  %arrayidx131.12 = getelementptr inbounds i32, i32* %0, i64 %324
  store i32 0, i32* %arrayidx131.12, align 4
  br label %for.inc.12

if.then.12:                                       ; preds = %for.body6.12
  %arrayidx.12 = getelementptr inbounds i32, i32* %0, i64 %324
  store i32 0, i32* %arrayidx.12, align 4
  br label %for.inc.12

for.inc.12:                                       ; preds = %if.then.12, %if.else129.12, %if.then123.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %lftr.wideiv.12 = trunc i64 %indvars.iv.next.12 to i32
  %exitcond.12 = icmp eq i32 %lftr.wideiv.12, %img_width
  br i1 %exitcond.12, label %for.inc134.12, label %for.body6.12, !llvm.loop !1

for.inc134.12:                                    ; preds = %for.inc.12
  %indvars.iv.next20.12 = add nsw i64 %indvars.iv19, 13
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.13

for.body6.lr.ph.13:                               ; preds = %for.inc134.12
  %341 = trunc i64 %indvars.iv.next20.12 to i32
  %mul.13 = shl nsw i32 %341, 7
  %cmp9.13 = icmp eq i64 %indvars.iv.next20.12, %2
  %add40.13 = or i32 %mul.13, 1
  %sub45.13 = add i32 %mul.13, -1
  %342 = trunc i64 %indvars.iv.next20.12 to i32
  %add58.13 = shl i32 %342, 7
  %343 = trunc i64 %indvars.iv.next20.12 to i32
  %add79.13 = shl i32 %343, 7
  %mul80.13 = add i32 %add79.13, 128
  %mul85.13 = add i32 %add79.13, -128
  %344 = trunc i64 %indvars.iv.next20.12 to i32
  %sub98.13 = shl i32 %344, 7
  %345 = sext i32 %mul.13 to i64
  %346 = sext i32 %mul85.13 to i64
  %347 = sext i32 %mul80.13 to i64
  br label %for.body6.13

for.body6.13:                                     ; preds = %for.inc.13, %for.body6.lr.ph.13
  %indvars.iv.13 = phi i64 [ 0, %for.body6.lr.ph.13 ], [ %indvars.iv.next.13, %for.inc.13 ]
  %348 = add nsw i64 %indvars.iv.13, %345
  %cmp12.13 = icmp eq i64 %indvars.iv.13, 0
  %or.cond1.13 = or i1 %cmp9.13, %cmp12.13
  %cmp15.13 = icmp eq i64 %indvars.iv.13, %1
  %or.cond2.13 = or i1 %cmp15.13, %or.cond1.13
  br i1 %or.cond2.13, label %if.then.13, label %if.else.13

if.else.13:                                       ; preds = %for.body6.13
  %arrayidx18.13 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %348
  %349 = load float, float* %arrayidx18.13, align 4
  %conv19.13 = fpext float %349 to double
  %mul20.13 = fmul double %conv19.13, 0x404CA5DC1A63C1F8
  %conv21.13 = fptrunc double %mul20.13 to float
  %cmp22.13 = fcmp olt float %conv21.13, 0.000000e+00
  %add25.13 = fadd float %conv21.13, 1.800000e+02
  %angle.0.13 = select i1 %cmp22.13, float %add25.13, float %conv21.13
  %cmp26.13 = fcmp oge float %angle.0.13, 0.000000e+00
  %cmp29.13 = fcmp olt float %angle.0.13, 2.250000e+01
  %or.cond3.13 = and i1 %cmp26.13, %cmp29.13
  br i1 %or.cond3.13, label %if.then38.13, label %lor.lhs.false31.13

lor.lhs.false31.13:                               ; preds = %if.else.13
  %cmp33.13 = fcmp ult float %angle.0.13, 1.575000e+02
  %cmp36.13 = fcmp ugt float %angle.0.13, 1.800000e+02
  %or.cond4.13 = or i1 %cmp33.13, %cmp36.13
  br i1 %or.cond4.13, label %if.else49.13, label %if.then38.13

if.else49.13:                                     ; preds = %lor.lhs.false31.13
  %cmp51.13 = fcmp oge float %angle.0.13, 2.250000e+01
  %cmp55.13 = fcmp olt float %angle.0.13, 6.750000e+01
  %or.cond5.13 = and i1 %cmp51.13, %cmp55.13
  br i1 %or.cond5.13, label %if.then57.13, label %if.else70.13

if.else70.13:                                     ; preds = %if.else49.13
  %cmp72.13 = fcmp oge float %angle.0.13, 6.750000e+01
  %cmp76.13 = fcmp olt float %angle.0.13, 1.125000e+02
  %or.cond6.13 = and i1 %cmp72.13, %cmp76.13
  br i1 %or.cond6.13, label %if.then78.13, label %if.else89.13

if.else89.13:                                     ; preds = %if.else70.13
  %cmp91.13 = fcmp oge float %angle.0.13, 1.125000e+02
  %cmp95.13 = fcmp olt float %angle.0.13, 1.575000e+02
  %or.cond7.13 = and i1 %cmp91.13, %cmp95.13
  br i1 %or.cond7.13, label %if.then97.13, label %if.end113.13

if.then97.13:                                     ; preds = %if.else89.13
  %350 = trunc i64 %indvars.iv.13 to i32
  %sub100.13 = add i32 %350, %sub98.13
  %add101.13 = add i32 %sub100.13, -129
  %idxprom102.13 = sext i32 %add101.13 to i64
  %arrayidx103.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.13
  %351 = load float, float* %arrayidx103.13, align 4
  %add107.13 = add i32 %sub100.13, 129
  %idxprom108.13 = sext i32 %add107.13 to i64
  %arrayidx109.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.13
  %352 = load float, float* %arrayidx109.13, align 4
  br label %if.end113.13

if.then78.13:                                     ; preds = %if.else70.13
  %353 = add nsw i64 %347, %indvars.iv.13
  %arrayidx83.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %353
  %354 = load float, float* %arrayidx83.13, align 4
  %355 = add nsw i64 %346, %indvars.iv.13
  %arrayidx88.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %355
  %356 = load float, float* %arrayidx88.13, align 4
  br label %if.end113.13

if.then57.13:                                     ; preds = %if.else49.13
  %357 = trunc i64 %indvars.iv.13 to i32
  %sub60.13 = add i32 %357, %add58.13
  %add61.13 = add i32 %sub60.13, 127
  %idxprom62.13 = sext i32 %add61.13 to i64
  %arrayidx63.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.13
  %358 = load float, float* %arrayidx63.13, align 4
  %add67.13 = add i32 %sub60.13, -127
  %idxprom68.13 = sext i32 %add67.13 to i64
  %arrayidx69.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.13
  %359 = load float, float* %arrayidx69.13, align 4
  br label %if.end113.13

if.then38.13:                                     ; preds = %lor.lhs.false31.13, %if.else.13
  %360 = trunc i64 %indvars.iv.13 to i32
  %add41.13 = add i32 %add40.13, %360
  %idxprom42.13 = sext i32 %add41.13 to i64
  %arrayidx43.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.13
  %361 = load float, float* %arrayidx43.13, align 4
  %362 = trunc i64 %indvars.iv.13 to i32
  %add46.13 = add i32 %sub45.13, %362
  %idxprom47.13 = sext i32 %add46.13 to i64
  %arrayidx48.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.13
  %363 = load float, float* %arrayidx48.13, align 4
  br label %if.end113.13

if.end113.13:                                     ; preds = %if.then38.13, %if.then57.13, %if.then78.13, %if.then97.13, %if.else89.13
  %q.3.13 = phi float [ %361, %if.then38.13 ], [ %358, %if.then57.13 ], [ %354, %if.then78.13 ], [ %351, %if.then97.13 ], [ 2.550000e+02, %if.else89.13 ]
  %r.3.13 = phi float [ %363, %if.then38.13 ], [ %359, %if.then57.13 ], [ %356, %if.then78.13 ], [ %352, %if.then97.13 ], [ 2.550000e+02, %if.else89.13 ]
  %arrayidx115.13 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %348
  %364 = load float, float* %arrayidx115.13, align 4
  %cmp116.13 = fcmp ult float %364, %q.3.13
  %cmp121.13 = fcmp ult float %364, %r.3.13
  %or.cond8.13 = or i1 %cmp116.13, %cmp121.13
  br i1 %or.cond8.13, label %if.else129.13, label %if.then123.13

if.then123.13:                                    ; preds = %if.end113.13
  %conv126.13 = fptoui float %364 to i32
  %arrayidx128.13 = getelementptr inbounds i32, i32* %0, i64 %348
  store i32 %conv126.13, i32* %arrayidx128.13, align 4
  br label %for.inc.13

if.else129.13:                                    ; preds = %if.end113.13
  %arrayidx131.13 = getelementptr inbounds i32, i32* %0, i64 %348
  store i32 0, i32* %arrayidx131.13, align 4
  br label %for.inc.13

if.then.13:                                       ; preds = %for.body6.13
  %arrayidx.13 = getelementptr inbounds i32, i32* %0, i64 %348
  store i32 0, i32* %arrayidx.13, align 4
  br label %for.inc.13

for.inc.13:                                       ; preds = %if.then.13, %if.else129.13, %if.then123.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %lftr.wideiv.13 = trunc i64 %indvars.iv.next.13 to i32
  %exitcond.13 = icmp eq i32 %lftr.wideiv.13, %img_width
  br i1 %exitcond.13, label %for.inc134.13, label %for.body6.13, !llvm.loop !1

for.inc134.13:                                    ; preds = %for.inc.13
  %indvars.iv.next20.13 = add nsw i64 %indvars.iv19, 14
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.14

for.body6.lr.ph.14:                               ; preds = %for.inc134.13
  %365 = trunc i64 %indvars.iv.next20.13 to i32
  %mul.14 = shl nsw i32 %365, 7
  %cmp9.14 = icmp eq i64 %indvars.iv.next20.13, %2
  %add40.14 = or i32 %mul.14, 1
  %sub45.14 = add i32 %mul.14, -1
  %366 = trunc i64 %indvars.iv.next20.13 to i32
  %add58.14 = shl i32 %366, 7
  %367 = trunc i64 %indvars.iv.next20.13 to i32
  %add79.14 = shl i32 %367, 7
  %mul80.14 = add i32 %add79.14, 128
  %mul85.14 = add i32 %add79.14, -128
  %368 = trunc i64 %indvars.iv.next20.13 to i32
  %sub98.14 = shl i32 %368, 7
  %369 = sext i32 %mul.14 to i64
  %370 = sext i32 %mul85.14 to i64
  %371 = sext i32 %mul80.14 to i64
  br label %for.body6.14

for.body6.14:                                     ; preds = %for.inc.14, %for.body6.lr.ph.14
  %indvars.iv.14 = phi i64 [ 0, %for.body6.lr.ph.14 ], [ %indvars.iv.next.14, %for.inc.14 ]
  %372 = add nsw i64 %indvars.iv.14, %369
  %cmp12.14 = icmp eq i64 %indvars.iv.14, 0
  %or.cond1.14 = or i1 %cmp9.14, %cmp12.14
  %cmp15.14 = icmp eq i64 %indvars.iv.14, %1
  %or.cond2.14 = or i1 %cmp15.14, %or.cond1.14
  br i1 %or.cond2.14, label %if.then.14, label %if.else.14

if.else.14:                                       ; preds = %for.body6.14
  %arrayidx18.14 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %372
  %373 = load float, float* %arrayidx18.14, align 4
  %conv19.14 = fpext float %373 to double
  %mul20.14 = fmul double %conv19.14, 0x404CA5DC1A63C1F8
  %conv21.14 = fptrunc double %mul20.14 to float
  %cmp22.14 = fcmp olt float %conv21.14, 0.000000e+00
  %add25.14 = fadd float %conv21.14, 1.800000e+02
  %angle.0.14 = select i1 %cmp22.14, float %add25.14, float %conv21.14
  %cmp26.14 = fcmp oge float %angle.0.14, 0.000000e+00
  %cmp29.14 = fcmp olt float %angle.0.14, 2.250000e+01
  %or.cond3.14 = and i1 %cmp26.14, %cmp29.14
  br i1 %or.cond3.14, label %if.then38.14, label %lor.lhs.false31.14

lor.lhs.false31.14:                               ; preds = %if.else.14
  %cmp33.14 = fcmp ult float %angle.0.14, 1.575000e+02
  %cmp36.14 = fcmp ugt float %angle.0.14, 1.800000e+02
  %or.cond4.14 = or i1 %cmp33.14, %cmp36.14
  br i1 %or.cond4.14, label %if.else49.14, label %if.then38.14

if.else49.14:                                     ; preds = %lor.lhs.false31.14
  %cmp51.14 = fcmp oge float %angle.0.14, 2.250000e+01
  %cmp55.14 = fcmp olt float %angle.0.14, 6.750000e+01
  %or.cond5.14 = and i1 %cmp51.14, %cmp55.14
  br i1 %or.cond5.14, label %if.then57.14, label %if.else70.14

if.else70.14:                                     ; preds = %if.else49.14
  %cmp72.14 = fcmp oge float %angle.0.14, 6.750000e+01
  %cmp76.14 = fcmp olt float %angle.0.14, 1.125000e+02
  %or.cond6.14 = and i1 %cmp72.14, %cmp76.14
  br i1 %or.cond6.14, label %if.then78.14, label %if.else89.14

if.else89.14:                                     ; preds = %if.else70.14
  %cmp91.14 = fcmp oge float %angle.0.14, 1.125000e+02
  %cmp95.14 = fcmp olt float %angle.0.14, 1.575000e+02
  %or.cond7.14 = and i1 %cmp91.14, %cmp95.14
  br i1 %or.cond7.14, label %if.then97.14, label %if.end113.14

if.then97.14:                                     ; preds = %if.else89.14
  %374 = trunc i64 %indvars.iv.14 to i32
  %sub100.14 = add i32 %374, %sub98.14
  %add101.14 = add i32 %sub100.14, -129
  %idxprom102.14 = sext i32 %add101.14 to i64
  %arrayidx103.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.14
  %375 = load float, float* %arrayidx103.14, align 4
  %add107.14 = add i32 %sub100.14, 129
  %idxprom108.14 = sext i32 %add107.14 to i64
  %arrayidx109.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.14
  %376 = load float, float* %arrayidx109.14, align 4
  br label %if.end113.14

if.then78.14:                                     ; preds = %if.else70.14
  %377 = add nsw i64 %371, %indvars.iv.14
  %arrayidx83.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %377
  %378 = load float, float* %arrayidx83.14, align 4
  %379 = add nsw i64 %370, %indvars.iv.14
  %arrayidx88.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %379
  %380 = load float, float* %arrayidx88.14, align 4
  br label %if.end113.14

if.then57.14:                                     ; preds = %if.else49.14
  %381 = trunc i64 %indvars.iv.14 to i32
  %sub60.14 = add i32 %381, %add58.14
  %add61.14 = add i32 %sub60.14, 127
  %idxprom62.14 = sext i32 %add61.14 to i64
  %arrayidx63.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.14
  %382 = load float, float* %arrayidx63.14, align 4
  %add67.14 = add i32 %sub60.14, -127
  %idxprom68.14 = sext i32 %add67.14 to i64
  %arrayidx69.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.14
  %383 = load float, float* %arrayidx69.14, align 4
  br label %if.end113.14

if.then38.14:                                     ; preds = %lor.lhs.false31.14, %if.else.14
  %384 = trunc i64 %indvars.iv.14 to i32
  %add41.14 = add i32 %add40.14, %384
  %idxprom42.14 = sext i32 %add41.14 to i64
  %arrayidx43.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.14
  %385 = load float, float* %arrayidx43.14, align 4
  %386 = trunc i64 %indvars.iv.14 to i32
  %add46.14 = add i32 %sub45.14, %386
  %idxprom47.14 = sext i32 %add46.14 to i64
  %arrayidx48.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.14
  %387 = load float, float* %arrayidx48.14, align 4
  br label %if.end113.14

if.end113.14:                                     ; preds = %if.then38.14, %if.then57.14, %if.then78.14, %if.then97.14, %if.else89.14
  %q.3.14 = phi float [ %385, %if.then38.14 ], [ %382, %if.then57.14 ], [ %378, %if.then78.14 ], [ %375, %if.then97.14 ], [ 2.550000e+02, %if.else89.14 ]
  %r.3.14 = phi float [ %387, %if.then38.14 ], [ %383, %if.then57.14 ], [ %380, %if.then78.14 ], [ %376, %if.then97.14 ], [ 2.550000e+02, %if.else89.14 ]
  %arrayidx115.14 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %372
  %388 = load float, float* %arrayidx115.14, align 4
  %cmp116.14 = fcmp ult float %388, %q.3.14
  %cmp121.14 = fcmp ult float %388, %r.3.14
  %or.cond8.14 = or i1 %cmp116.14, %cmp121.14
  br i1 %or.cond8.14, label %if.else129.14, label %if.then123.14

if.then123.14:                                    ; preds = %if.end113.14
  %conv126.14 = fptoui float %388 to i32
  %arrayidx128.14 = getelementptr inbounds i32, i32* %0, i64 %372
  store i32 %conv126.14, i32* %arrayidx128.14, align 4
  br label %for.inc.14

if.else129.14:                                    ; preds = %if.end113.14
  %arrayidx131.14 = getelementptr inbounds i32, i32* %0, i64 %372
  store i32 0, i32* %arrayidx131.14, align 4
  br label %for.inc.14

if.then.14:                                       ; preds = %for.body6.14
  %arrayidx.14 = getelementptr inbounds i32, i32* %0, i64 %372
  store i32 0, i32* %arrayidx.14, align 4
  br label %for.inc.14

for.inc.14:                                       ; preds = %if.then.14, %if.else129.14, %if.then123.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %lftr.wideiv.14 = trunc i64 %indvars.iv.next.14 to i32
  %exitcond.14 = icmp eq i32 %lftr.wideiv.14, %img_width
  br i1 %exitcond.14, label %for.inc134.14, label %for.body6.14, !llvm.loop !1

for.inc134.14:                                    ; preds = %for.inc.14
  %indvars.iv.next20.14 = add nsw i64 %indvars.iv19, 15
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.15

for.body6.lr.ph.15:                               ; preds = %for.inc134.14
  %389 = trunc i64 %indvars.iv.next20.14 to i32
  %mul.15 = shl nsw i32 %389, 7
  %cmp9.15 = icmp eq i64 %indvars.iv.next20.14, %2
  %add40.15 = or i32 %mul.15, 1
  %sub45.15 = add i32 %mul.15, -1
  %390 = trunc i64 %indvars.iv.next20.14 to i32
  %add58.15 = shl i32 %390, 7
  %391 = trunc i64 %indvars.iv.next20.14 to i32
  %add79.15 = shl i32 %391, 7
  %mul80.15 = add i32 %add79.15, 128
  %mul85.15 = add i32 %add79.15, -128
  %392 = trunc i64 %indvars.iv.next20.14 to i32
  %sub98.15 = shl i32 %392, 7
  %393 = sext i32 %mul.15 to i64
  %394 = sext i32 %mul85.15 to i64
  %395 = sext i32 %mul80.15 to i64
  br label %for.body6.15

for.body6.15:                                     ; preds = %for.inc.15, %for.body6.lr.ph.15
  %indvars.iv.15 = phi i64 [ 0, %for.body6.lr.ph.15 ], [ %indvars.iv.next.15, %for.inc.15 ]
  %396 = add nsw i64 %indvars.iv.15, %393
  %cmp12.15 = icmp eq i64 %indvars.iv.15, 0
  %or.cond1.15 = or i1 %cmp9.15, %cmp12.15
  %cmp15.15 = icmp eq i64 %indvars.iv.15, %1
  %or.cond2.15 = or i1 %cmp15.15, %or.cond1.15
  br i1 %or.cond2.15, label %if.then.15, label %if.else.15

if.else.15:                                       ; preds = %for.body6.15
  %arrayidx18.15 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %396
  %397 = load float, float* %arrayidx18.15, align 4
  %conv19.15 = fpext float %397 to double
  %mul20.15 = fmul double %conv19.15, 0x404CA5DC1A63C1F8
  %conv21.15 = fptrunc double %mul20.15 to float
  %cmp22.15 = fcmp olt float %conv21.15, 0.000000e+00
  %add25.15 = fadd float %conv21.15, 1.800000e+02
  %angle.0.15 = select i1 %cmp22.15, float %add25.15, float %conv21.15
  %cmp26.15 = fcmp oge float %angle.0.15, 0.000000e+00
  %cmp29.15 = fcmp olt float %angle.0.15, 2.250000e+01
  %or.cond3.15 = and i1 %cmp26.15, %cmp29.15
  br i1 %or.cond3.15, label %if.then38.15, label %lor.lhs.false31.15

lor.lhs.false31.15:                               ; preds = %if.else.15
  %cmp33.15 = fcmp ult float %angle.0.15, 1.575000e+02
  %cmp36.15 = fcmp ugt float %angle.0.15, 1.800000e+02
  %or.cond4.15 = or i1 %cmp33.15, %cmp36.15
  br i1 %or.cond4.15, label %if.else49.15, label %if.then38.15

if.else49.15:                                     ; preds = %lor.lhs.false31.15
  %cmp51.15 = fcmp oge float %angle.0.15, 2.250000e+01
  %cmp55.15 = fcmp olt float %angle.0.15, 6.750000e+01
  %or.cond5.15 = and i1 %cmp51.15, %cmp55.15
  br i1 %or.cond5.15, label %if.then57.15, label %if.else70.15

if.else70.15:                                     ; preds = %if.else49.15
  %cmp72.15 = fcmp oge float %angle.0.15, 6.750000e+01
  %cmp76.15 = fcmp olt float %angle.0.15, 1.125000e+02
  %or.cond6.15 = and i1 %cmp72.15, %cmp76.15
  br i1 %or.cond6.15, label %if.then78.15, label %if.else89.15

if.else89.15:                                     ; preds = %if.else70.15
  %cmp91.15 = fcmp oge float %angle.0.15, 1.125000e+02
  %cmp95.15 = fcmp olt float %angle.0.15, 1.575000e+02
  %or.cond7.15 = and i1 %cmp91.15, %cmp95.15
  br i1 %or.cond7.15, label %if.then97.15, label %if.end113.15

if.then97.15:                                     ; preds = %if.else89.15
  %398 = trunc i64 %indvars.iv.15 to i32
  %sub100.15 = add i32 %398, %sub98.15
  %add101.15 = add i32 %sub100.15, -129
  %idxprom102.15 = sext i32 %add101.15 to i64
  %arrayidx103.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.15
  %399 = load float, float* %arrayidx103.15, align 4
  %add107.15 = add i32 %sub100.15, 129
  %idxprom108.15 = sext i32 %add107.15 to i64
  %arrayidx109.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.15
  %400 = load float, float* %arrayidx109.15, align 4
  br label %if.end113.15

if.then78.15:                                     ; preds = %if.else70.15
  %401 = add nsw i64 %395, %indvars.iv.15
  %arrayidx83.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %401
  %402 = load float, float* %arrayidx83.15, align 4
  %403 = add nsw i64 %394, %indvars.iv.15
  %arrayidx88.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %403
  %404 = load float, float* %arrayidx88.15, align 4
  br label %if.end113.15

if.then57.15:                                     ; preds = %if.else49.15
  %405 = trunc i64 %indvars.iv.15 to i32
  %sub60.15 = add i32 %405, %add58.15
  %add61.15 = add i32 %sub60.15, 127
  %idxprom62.15 = sext i32 %add61.15 to i64
  %arrayidx63.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.15
  %406 = load float, float* %arrayidx63.15, align 4
  %add67.15 = add i32 %sub60.15, -127
  %idxprom68.15 = sext i32 %add67.15 to i64
  %arrayidx69.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.15
  %407 = load float, float* %arrayidx69.15, align 4
  br label %if.end113.15

if.then38.15:                                     ; preds = %lor.lhs.false31.15, %if.else.15
  %408 = trunc i64 %indvars.iv.15 to i32
  %add41.15 = add i32 %add40.15, %408
  %idxprom42.15 = sext i32 %add41.15 to i64
  %arrayidx43.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.15
  %409 = load float, float* %arrayidx43.15, align 4
  %410 = trunc i64 %indvars.iv.15 to i32
  %add46.15 = add i32 %sub45.15, %410
  %idxprom47.15 = sext i32 %add46.15 to i64
  %arrayidx48.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.15
  %411 = load float, float* %arrayidx48.15, align 4
  br label %if.end113.15

if.end113.15:                                     ; preds = %if.then38.15, %if.then57.15, %if.then78.15, %if.then97.15, %if.else89.15
  %q.3.15 = phi float [ %409, %if.then38.15 ], [ %406, %if.then57.15 ], [ %402, %if.then78.15 ], [ %399, %if.then97.15 ], [ 2.550000e+02, %if.else89.15 ]
  %r.3.15 = phi float [ %411, %if.then38.15 ], [ %407, %if.then57.15 ], [ %404, %if.then78.15 ], [ %400, %if.then97.15 ], [ 2.550000e+02, %if.else89.15 ]
  %arrayidx115.15 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %396
  %412 = load float, float* %arrayidx115.15, align 4
  %cmp116.15 = fcmp ult float %412, %q.3.15
  %cmp121.15 = fcmp ult float %412, %r.3.15
  %or.cond8.15 = or i1 %cmp116.15, %cmp121.15
  br i1 %or.cond8.15, label %if.else129.15, label %if.then123.15

if.then123.15:                                    ; preds = %if.end113.15
  %conv126.15 = fptoui float %412 to i32
  %arrayidx128.15 = getelementptr inbounds i32, i32* %0, i64 %396
  store i32 %conv126.15, i32* %arrayidx128.15, align 4
  br label %for.inc.15

if.else129.15:                                    ; preds = %if.end113.15
  %arrayidx131.15 = getelementptr inbounds i32, i32* %0, i64 %396
  store i32 0, i32* %arrayidx131.15, align 4
  br label %for.inc.15

if.then.15:                                       ; preds = %for.body6.15
  %arrayidx.15 = getelementptr inbounds i32, i32* %0, i64 %396
  store i32 0, i32* %arrayidx.15, align 4
  br label %for.inc.15

for.inc.15:                                       ; preds = %if.then.15, %if.else129.15, %if.then123.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %lftr.wideiv.15 = trunc i64 %indvars.iv.next.15 to i32
  %exitcond.15 = icmp eq i32 %lftr.wideiv.15, %img_width
  br i1 %exitcond.15, label %for.inc134.15, label %for.body6.15, !llvm.loop !1

for.inc134.15:                                    ; preds = %for.inc.15
  %indvars.iv.next20.15 = add nsw i64 %indvars.iv19, 16
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.16

for.body6.lr.ph.16:                               ; preds = %for.inc134.15
  %413 = trunc i64 %indvars.iv.next20.15 to i32
  %mul.16 = shl nsw i32 %413, 7
  %cmp9.16 = icmp eq i64 %indvars.iv.next20.15, %2
  %add40.16 = or i32 %mul.16, 1
  %sub45.16 = add i32 %mul.16, -1
  %414 = trunc i64 %indvars.iv.next20.15 to i32
  %add58.16 = shl i32 %414, 7
  %415 = trunc i64 %indvars.iv.next20.15 to i32
  %add79.16 = shl i32 %415, 7
  %mul80.16 = add i32 %add79.16, 128
  %mul85.16 = add i32 %add79.16, -128
  %416 = trunc i64 %indvars.iv.next20.15 to i32
  %sub98.16 = shl i32 %416, 7
  %417 = sext i32 %mul.16 to i64
  %418 = sext i32 %mul85.16 to i64
  %419 = sext i32 %mul80.16 to i64
  br label %for.body6.16

for.body6.16:                                     ; preds = %for.inc.16, %for.body6.lr.ph.16
  %indvars.iv.16 = phi i64 [ 0, %for.body6.lr.ph.16 ], [ %indvars.iv.next.16, %for.inc.16 ]
  %420 = add nsw i64 %indvars.iv.16, %417
  %cmp12.16 = icmp eq i64 %indvars.iv.16, 0
  %or.cond1.16 = or i1 %cmp9.16, %cmp12.16
  %cmp15.16 = icmp eq i64 %indvars.iv.16, %1
  %or.cond2.16 = or i1 %cmp15.16, %or.cond1.16
  br i1 %or.cond2.16, label %if.then.16, label %if.else.16

if.else.16:                                       ; preds = %for.body6.16
  %arrayidx18.16 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %420
  %421 = load float, float* %arrayidx18.16, align 4
  %conv19.16 = fpext float %421 to double
  %mul20.16 = fmul double %conv19.16, 0x404CA5DC1A63C1F8
  %conv21.16 = fptrunc double %mul20.16 to float
  %cmp22.16 = fcmp olt float %conv21.16, 0.000000e+00
  %add25.16 = fadd float %conv21.16, 1.800000e+02
  %angle.0.16 = select i1 %cmp22.16, float %add25.16, float %conv21.16
  %cmp26.16 = fcmp oge float %angle.0.16, 0.000000e+00
  %cmp29.16 = fcmp olt float %angle.0.16, 2.250000e+01
  %or.cond3.16 = and i1 %cmp26.16, %cmp29.16
  br i1 %or.cond3.16, label %if.then38.16, label %lor.lhs.false31.16

lor.lhs.false31.16:                               ; preds = %if.else.16
  %cmp33.16 = fcmp ult float %angle.0.16, 1.575000e+02
  %cmp36.16 = fcmp ugt float %angle.0.16, 1.800000e+02
  %or.cond4.16 = or i1 %cmp33.16, %cmp36.16
  br i1 %or.cond4.16, label %if.else49.16, label %if.then38.16

if.else49.16:                                     ; preds = %lor.lhs.false31.16
  %cmp51.16 = fcmp oge float %angle.0.16, 2.250000e+01
  %cmp55.16 = fcmp olt float %angle.0.16, 6.750000e+01
  %or.cond5.16 = and i1 %cmp51.16, %cmp55.16
  br i1 %or.cond5.16, label %if.then57.16, label %if.else70.16

if.else70.16:                                     ; preds = %if.else49.16
  %cmp72.16 = fcmp oge float %angle.0.16, 6.750000e+01
  %cmp76.16 = fcmp olt float %angle.0.16, 1.125000e+02
  %or.cond6.16 = and i1 %cmp72.16, %cmp76.16
  br i1 %or.cond6.16, label %if.then78.16, label %if.else89.16

if.else89.16:                                     ; preds = %if.else70.16
  %cmp91.16 = fcmp oge float %angle.0.16, 1.125000e+02
  %cmp95.16 = fcmp olt float %angle.0.16, 1.575000e+02
  %or.cond7.16 = and i1 %cmp91.16, %cmp95.16
  br i1 %or.cond7.16, label %if.then97.16, label %if.end113.16

if.then97.16:                                     ; preds = %if.else89.16
  %422 = trunc i64 %indvars.iv.16 to i32
  %sub100.16 = add i32 %422, %sub98.16
  %add101.16 = add i32 %sub100.16, -129
  %idxprom102.16 = sext i32 %add101.16 to i64
  %arrayidx103.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.16
  %423 = load float, float* %arrayidx103.16, align 4
  %add107.16 = add i32 %sub100.16, 129
  %idxprom108.16 = sext i32 %add107.16 to i64
  %arrayidx109.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.16
  %424 = load float, float* %arrayidx109.16, align 4
  br label %if.end113.16

if.then78.16:                                     ; preds = %if.else70.16
  %425 = add nsw i64 %419, %indvars.iv.16
  %arrayidx83.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %425
  %426 = load float, float* %arrayidx83.16, align 4
  %427 = add nsw i64 %418, %indvars.iv.16
  %arrayidx88.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %427
  %428 = load float, float* %arrayidx88.16, align 4
  br label %if.end113.16

if.then57.16:                                     ; preds = %if.else49.16
  %429 = trunc i64 %indvars.iv.16 to i32
  %sub60.16 = add i32 %429, %add58.16
  %add61.16 = add i32 %sub60.16, 127
  %idxprom62.16 = sext i32 %add61.16 to i64
  %arrayidx63.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.16
  %430 = load float, float* %arrayidx63.16, align 4
  %add67.16 = add i32 %sub60.16, -127
  %idxprom68.16 = sext i32 %add67.16 to i64
  %arrayidx69.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.16
  %431 = load float, float* %arrayidx69.16, align 4
  br label %if.end113.16

if.then38.16:                                     ; preds = %lor.lhs.false31.16, %if.else.16
  %432 = trunc i64 %indvars.iv.16 to i32
  %add41.16 = add i32 %add40.16, %432
  %idxprom42.16 = sext i32 %add41.16 to i64
  %arrayidx43.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.16
  %433 = load float, float* %arrayidx43.16, align 4
  %434 = trunc i64 %indvars.iv.16 to i32
  %add46.16 = add i32 %sub45.16, %434
  %idxprom47.16 = sext i32 %add46.16 to i64
  %arrayidx48.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.16
  %435 = load float, float* %arrayidx48.16, align 4
  br label %if.end113.16

if.end113.16:                                     ; preds = %if.then38.16, %if.then57.16, %if.then78.16, %if.then97.16, %if.else89.16
  %q.3.16 = phi float [ %433, %if.then38.16 ], [ %430, %if.then57.16 ], [ %426, %if.then78.16 ], [ %423, %if.then97.16 ], [ 2.550000e+02, %if.else89.16 ]
  %r.3.16 = phi float [ %435, %if.then38.16 ], [ %431, %if.then57.16 ], [ %428, %if.then78.16 ], [ %424, %if.then97.16 ], [ 2.550000e+02, %if.else89.16 ]
  %arrayidx115.16 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %420
  %436 = load float, float* %arrayidx115.16, align 4
  %cmp116.16 = fcmp ult float %436, %q.3.16
  %cmp121.16 = fcmp ult float %436, %r.3.16
  %or.cond8.16 = or i1 %cmp116.16, %cmp121.16
  br i1 %or.cond8.16, label %if.else129.16, label %if.then123.16

if.then123.16:                                    ; preds = %if.end113.16
  %conv126.16 = fptoui float %436 to i32
  %arrayidx128.16 = getelementptr inbounds i32, i32* %0, i64 %420
  store i32 %conv126.16, i32* %arrayidx128.16, align 4
  br label %for.inc.16

if.else129.16:                                    ; preds = %if.end113.16
  %arrayidx131.16 = getelementptr inbounds i32, i32* %0, i64 %420
  store i32 0, i32* %arrayidx131.16, align 4
  br label %for.inc.16

if.then.16:                                       ; preds = %for.body6.16
  %arrayidx.16 = getelementptr inbounds i32, i32* %0, i64 %420
  store i32 0, i32* %arrayidx.16, align 4
  br label %for.inc.16

for.inc.16:                                       ; preds = %if.then.16, %if.else129.16, %if.then123.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %lftr.wideiv.16 = trunc i64 %indvars.iv.next.16 to i32
  %exitcond.16 = icmp eq i32 %lftr.wideiv.16, %img_width
  br i1 %exitcond.16, label %for.inc134.16, label %for.body6.16, !llvm.loop !1

for.inc134.16:                                    ; preds = %for.inc.16
  %indvars.iv.next20.16 = add nsw i64 %indvars.iv19, 17
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.17

for.body6.lr.ph.17:                               ; preds = %for.inc134.16
  %437 = trunc i64 %indvars.iv.next20.16 to i32
  %mul.17 = shl nsw i32 %437, 7
  %cmp9.17 = icmp eq i64 %indvars.iv.next20.16, %2
  %add40.17 = or i32 %mul.17, 1
  %sub45.17 = add i32 %mul.17, -1
  %438 = trunc i64 %indvars.iv.next20.16 to i32
  %add58.17 = shl i32 %438, 7
  %439 = trunc i64 %indvars.iv.next20.16 to i32
  %add79.17 = shl i32 %439, 7
  %mul80.17 = add i32 %add79.17, 128
  %mul85.17 = add i32 %add79.17, -128
  %440 = trunc i64 %indvars.iv.next20.16 to i32
  %sub98.17 = shl i32 %440, 7
  %441 = sext i32 %mul.17 to i64
  %442 = sext i32 %mul85.17 to i64
  %443 = sext i32 %mul80.17 to i64
  br label %for.body6.17

for.body6.17:                                     ; preds = %for.inc.17, %for.body6.lr.ph.17
  %indvars.iv.17 = phi i64 [ 0, %for.body6.lr.ph.17 ], [ %indvars.iv.next.17, %for.inc.17 ]
  %444 = add nsw i64 %indvars.iv.17, %441
  %cmp12.17 = icmp eq i64 %indvars.iv.17, 0
  %or.cond1.17 = or i1 %cmp9.17, %cmp12.17
  %cmp15.17 = icmp eq i64 %indvars.iv.17, %1
  %or.cond2.17 = or i1 %cmp15.17, %or.cond1.17
  br i1 %or.cond2.17, label %if.then.17, label %if.else.17

if.else.17:                                       ; preds = %for.body6.17
  %arrayidx18.17 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %444
  %445 = load float, float* %arrayidx18.17, align 4
  %conv19.17 = fpext float %445 to double
  %mul20.17 = fmul double %conv19.17, 0x404CA5DC1A63C1F8
  %conv21.17 = fptrunc double %mul20.17 to float
  %cmp22.17 = fcmp olt float %conv21.17, 0.000000e+00
  %add25.17 = fadd float %conv21.17, 1.800000e+02
  %angle.0.17 = select i1 %cmp22.17, float %add25.17, float %conv21.17
  %cmp26.17 = fcmp oge float %angle.0.17, 0.000000e+00
  %cmp29.17 = fcmp olt float %angle.0.17, 2.250000e+01
  %or.cond3.17 = and i1 %cmp26.17, %cmp29.17
  br i1 %or.cond3.17, label %if.then38.17, label %lor.lhs.false31.17

lor.lhs.false31.17:                               ; preds = %if.else.17
  %cmp33.17 = fcmp ult float %angle.0.17, 1.575000e+02
  %cmp36.17 = fcmp ugt float %angle.0.17, 1.800000e+02
  %or.cond4.17 = or i1 %cmp33.17, %cmp36.17
  br i1 %or.cond4.17, label %if.else49.17, label %if.then38.17

if.else49.17:                                     ; preds = %lor.lhs.false31.17
  %cmp51.17 = fcmp oge float %angle.0.17, 2.250000e+01
  %cmp55.17 = fcmp olt float %angle.0.17, 6.750000e+01
  %or.cond5.17 = and i1 %cmp51.17, %cmp55.17
  br i1 %or.cond5.17, label %if.then57.17, label %if.else70.17

if.else70.17:                                     ; preds = %if.else49.17
  %cmp72.17 = fcmp oge float %angle.0.17, 6.750000e+01
  %cmp76.17 = fcmp olt float %angle.0.17, 1.125000e+02
  %or.cond6.17 = and i1 %cmp72.17, %cmp76.17
  br i1 %or.cond6.17, label %if.then78.17, label %if.else89.17

if.else89.17:                                     ; preds = %if.else70.17
  %cmp91.17 = fcmp oge float %angle.0.17, 1.125000e+02
  %cmp95.17 = fcmp olt float %angle.0.17, 1.575000e+02
  %or.cond7.17 = and i1 %cmp91.17, %cmp95.17
  br i1 %or.cond7.17, label %if.then97.17, label %if.end113.17

if.then97.17:                                     ; preds = %if.else89.17
  %446 = trunc i64 %indvars.iv.17 to i32
  %sub100.17 = add i32 %446, %sub98.17
  %add101.17 = add i32 %sub100.17, -129
  %idxprom102.17 = sext i32 %add101.17 to i64
  %arrayidx103.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.17
  %447 = load float, float* %arrayidx103.17, align 4
  %add107.17 = add i32 %sub100.17, 129
  %idxprom108.17 = sext i32 %add107.17 to i64
  %arrayidx109.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.17
  %448 = load float, float* %arrayidx109.17, align 4
  br label %if.end113.17

if.then78.17:                                     ; preds = %if.else70.17
  %449 = add nsw i64 %443, %indvars.iv.17
  %arrayidx83.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %449
  %450 = load float, float* %arrayidx83.17, align 4
  %451 = add nsw i64 %442, %indvars.iv.17
  %arrayidx88.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %451
  %452 = load float, float* %arrayidx88.17, align 4
  br label %if.end113.17

if.then57.17:                                     ; preds = %if.else49.17
  %453 = trunc i64 %indvars.iv.17 to i32
  %sub60.17 = add i32 %453, %add58.17
  %add61.17 = add i32 %sub60.17, 127
  %idxprom62.17 = sext i32 %add61.17 to i64
  %arrayidx63.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.17
  %454 = load float, float* %arrayidx63.17, align 4
  %add67.17 = add i32 %sub60.17, -127
  %idxprom68.17 = sext i32 %add67.17 to i64
  %arrayidx69.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.17
  %455 = load float, float* %arrayidx69.17, align 4
  br label %if.end113.17

if.then38.17:                                     ; preds = %lor.lhs.false31.17, %if.else.17
  %456 = trunc i64 %indvars.iv.17 to i32
  %add41.17 = add i32 %add40.17, %456
  %idxprom42.17 = sext i32 %add41.17 to i64
  %arrayidx43.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.17
  %457 = load float, float* %arrayidx43.17, align 4
  %458 = trunc i64 %indvars.iv.17 to i32
  %add46.17 = add i32 %sub45.17, %458
  %idxprom47.17 = sext i32 %add46.17 to i64
  %arrayidx48.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.17
  %459 = load float, float* %arrayidx48.17, align 4
  br label %if.end113.17

if.end113.17:                                     ; preds = %if.then38.17, %if.then57.17, %if.then78.17, %if.then97.17, %if.else89.17
  %q.3.17 = phi float [ %457, %if.then38.17 ], [ %454, %if.then57.17 ], [ %450, %if.then78.17 ], [ %447, %if.then97.17 ], [ 2.550000e+02, %if.else89.17 ]
  %r.3.17 = phi float [ %459, %if.then38.17 ], [ %455, %if.then57.17 ], [ %452, %if.then78.17 ], [ %448, %if.then97.17 ], [ 2.550000e+02, %if.else89.17 ]
  %arrayidx115.17 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %444
  %460 = load float, float* %arrayidx115.17, align 4
  %cmp116.17 = fcmp ult float %460, %q.3.17
  %cmp121.17 = fcmp ult float %460, %r.3.17
  %or.cond8.17 = or i1 %cmp116.17, %cmp121.17
  br i1 %or.cond8.17, label %if.else129.17, label %if.then123.17

if.then123.17:                                    ; preds = %if.end113.17
  %conv126.17 = fptoui float %460 to i32
  %arrayidx128.17 = getelementptr inbounds i32, i32* %0, i64 %444
  store i32 %conv126.17, i32* %arrayidx128.17, align 4
  br label %for.inc.17

if.else129.17:                                    ; preds = %if.end113.17
  %arrayidx131.17 = getelementptr inbounds i32, i32* %0, i64 %444
  store i32 0, i32* %arrayidx131.17, align 4
  br label %for.inc.17

if.then.17:                                       ; preds = %for.body6.17
  %arrayidx.17 = getelementptr inbounds i32, i32* %0, i64 %444
  store i32 0, i32* %arrayidx.17, align 4
  br label %for.inc.17

for.inc.17:                                       ; preds = %if.then.17, %if.else129.17, %if.then123.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %lftr.wideiv.17 = trunc i64 %indvars.iv.next.17 to i32
  %exitcond.17 = icmp eq i32 %lftr.wideiv.17, %img_width
  br i1 %exitcond.17, label %for.inc134.17, label %for.body6.17, !llvm.loop !1

for.inc134.17:                                    ; preds = %for.inc.17
  %indvars.iv.next20.17 = add nsw i64 %indvars.iv19, 18
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.18

for.body6.lr.ph.18:                               ; preds = %for.inc134.17
  %461 = trunc i64 %indvars.iv.next20.17 to i32
  %mul.18 = shl nsw i32 %461, 7
  %cmp9.18 = icmp eq i64 %indvars.iv.next20.17, %2
  %add40.18 = or i32 %mul.18, 1
  %sub45.18 = add i32 %mul.18, -1
  %462 = trunc i64 %indvars.iv.next20.17 to i32
  %add58.18 = shl i32 %462, 7
  %463 = trunc i64 %indvars.iv.next20.17 to i32
  %add79.18 = shl i32 %463, 7
  %mul80.18 = add i32 %add79.18, 128
  %mul85.18 = add i32 %add79.18, -128
  %464 = trunc i64 %indvars.iv.next20.17 to i32
  %sub98.18 = shl i32 %464, 7
  %465 = sext i32 %mul.18 to i64
  %466 = sext i32 %mul85.18 to i64
  %467 = sext i32 %mul80.18 to i64
  br label %for.body6.18

for.body6.18:                                     ; preds = %for.inc.18, %for.body6.lr.ph.18
  %indvars.iv.18 = phi i64 [ 0, %for.body6.lr.ph.18 ], [ %indvars.iv.next.18, %for.inc.18 ]
  %468 = add nsw i64 %indvars.iv.18, %465
  %cmp12.18 = icmp eq i64 %indvars.iv.18, 0
  %or.cond1.18 = or i1 %cmp9.18, %cmp12.18
  %cmp15.18 = icmp eq i64 %indvars.iv.18, %1
  %or.cond2.18 = or i1 %cmp15.18, %or.cond1.18
  br i1 %or.cond2.18, label %if.then.18, label %if.else.18

if.else.18:                                       ; preds = %for.body6.18
  %arrayidx18.18 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %468
  %469 = load float, float* %arrayidx18.18, align 4
  %conv19.18 = fpext float %469 to double
  %mul20.18 = fmul double %conv19.18, 0x404CA5DC1A63C1F8
  %conv21.18 = fptrunc double %mul20.18 to float
  %cmp22.18 = fcmp olt float %conv21.18, 0.000000e+00
  %add25.18 = fadd float %conv21.18, 1.800000e+02
  %angle.0.18 = select i1 %cmp22.18, float %add25.18, float %conv21.18
  %cmp26.18 = fcmp oge float %angle.0.18, 0.000000e+00
  %cmp29.18 = fcmp olt float %angle.0.18, 2.250000e+01
  %or.cond3.18 = and i1 %cmp26.18, %cmp29.18
  br i1 %or.cond3.18, label %if.then38.18, label %lor.lhs.false31.18

lor.lhs.false31.18:                               ; preds = %if.else.18
  %cmp33.18 = fcmp ult float %angle.0.18, 1.575000e+02
  %cmp36.18 = fcmp ugt float %angle.0.18, 1.800000e+02
  %or.cond4.18 = or i1 %cmp33.18, %cmp36.18
  br i1 %or.cond4.18, label %if.else49.18, label %if.then38.18

if.else49.18:                                     ; preds = %lor.lhs.false31.18
  %cmp51.18 = fcmp oge float %angle.0.18, 2.250000e+01
  %cmp55.18 = fcmp olt float %angle.0.18, 6.750000e+01
  %or.cond5.18 = and i1 %cmp51.18, %cmp55.18
  br i1 %or.cond5.18, label %if.then57.18, label %if.else70.18

if.else70.18:                                     ; preds = %if.else49.18
  %cmp72.18 = fcmp oge float %angle.0.18, 6.750000e+01
  %cmp76.18 = fcmp olt float %angle.0.18, 1.125000e+02
  %or.cond6.18 = and i1 %cmp72.18, %cmp76.18
  br i1 %or.cond6.18, label %if.then78.18, label %if.else89.18

if.else89.18:                                     ; preds = %if.else70.18
  %cmp91.18 = fcmp oge float %angle.0.18, 1.125000e+02
  %cmp95.18 = fcmp olt float %angle.0.18, 1.575000e+02
  %or.cond7.18 = and i1 %cmp91.18, %cmp95.18
  br i1 %or.cond7.18, label %if.then97.18, label %if.end113.18

if.then97.18:                                     ; preds = %if.else89.18
  %470 = trunc i64 %indvars.iv.18 to i32
  %sub100.18 = add i32 %470, %sub98.18
  %add101.18 = add i32 %sub100.18, -129
  %idxprom102.18 = sext i32 %add101.18 to i64
  %arrayidx103.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.18
  %471 = load float, float* %arrayidx103.18, align 4
  %add107.18 = add i32 %sub100.18, 129
  %idxprom108.18 = sext i32 %add107.18 to i64
  %arrayidx109.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.18
  %472 = load float, float* %arrayidx109.18, align 4
  br label %if.end113.18

if.then78.18:                                     ; preds = %if.else70.18
  %473 = add nsw i64 %467, %indvars.iv.18
  %arrayidx83.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %473
  %474 = load float, float* %arrayidx83.18, align 4
  %475 = add nsw i64 %466, %indvars.iv.18
  %arrayidx88.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %475
  %476 = load float, float* %arrayidx88.18, align 4
  br label %if.end113.18

if.then57.18:                                     ; preds = %if.else49.18
  %477 = trunc i64 %indvars.iv.18 to i32
  %sub60.18 = add i32 %477, %add58.18
  %add61.18 = add i32 %sub60.18, 127
  %idxprom62.18 = sext i32 %add61.18 to i64
  %arrayidx63.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.18
  %478 = load float, float* %arrayidx63.18, align 4
  %add67.18 = add i32 %sub60.18, -127
  %idxprom68.18 = sext i32 %add67.18 to i64
  %arrayidx69.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.18
  %479 = load float, float* %arrayidx69.18, align 4
  br label %if.end113.18

if.then38.18:                                     ; preds = %lor.lhs.false31.18, %if.else.18
  %480 = trunc i64 %indvars.iv.18 to i32
  %add41.18 = add i32 %add40.18, %480
  %idxprom42.18 = sext i32 %add41.18 to i64
  %arrayidx43.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.18
  %481 = load float, float* %arrayidx43.18, align 4
  %482 = trunc i64 %indvars.iv.18 to i32
  %add46.18 = add i32 %sub45.18, %482
  %idxprom47.18 = sext i32 %add46.18 to i64
  %arrayidx48.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.18
  %483 = load float, float* %arrayidx48.18, align 4
  br label %if.end113.18

if.end113.18:                                     ; preds = %if.then38.18, %if.then57.18, %if.then78.18, %if.then97.18, %if.else89.18
  %q.3.18 = phi float [ %481, %if.then38.18 ], [ %478, %if.then57.18 ], [ %474, %if.then78.18 ], [ %471, %if.then97.18 ], [ 2.550000e+02, %if.else89.18 ]
  %r.3.18 = phi float [ %483, %if.then38.18 ], [ %479, %if.then57.18 ], [ %476, %if.then78.18 ], [ %472, %if.then97.18 ], [ 2.550000e+02, %if.else89.18 ]
  %arrayidx115.18 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %468
  %484 = load float, float* %arrayidx115.18, align 4
  %cmp116.18 = fcmp ult float %484, %q.3.18
  %cmp121.18 = fcmp ult float %484, %r.3.18
  %or.cond8.18 = or i1 %cmp116.18, %cmp121.18
  br i1 %or.cond8.18, label %if.else129.18, label %if.then123.18

if.then123.18:                                    ; preds = %if.end113.18
  %conv126.18 = fptoui float %484 to i32
  %arrayidx128.18 = getelementptr inbounds i32, i32* %0, i64 %468
  store i32 %conv126.18, i32* %arrayidx128.18, align 4
  br label %for.inc.18

if.else129.18:                                    ; preds = %if.end113.18
  %arrayidx131.18 = getelementptr inbounds i32, i32* %0, i64 %468
  store i32 0, i32* %arrayidx131.18, align 4
  br label %for.inc.18

if.then.18:                                       ; preds = %for.body6.18
  %arrayidx.18 = getelementptr inbounds i32, i32* %0, i64 %468
  store i32 0, i32* %arrayidx.18, align 4
  br label %for.inc.18

for.inc.18:                                       ; preds = %if.then.18, %if.else129.18, %if.then123.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %lftr.wideiv.18 = trunc i64 %indvars.iv.next.18 to i32
  %exitcond.18 = icmp eq i32 %lftr.wideiv.18, %img_width
  br i1 %exitcond.18, label %for.inc134.18, label %for.body6.18, !llvm.loop !1

for.inc134.18:                                    ; preds = %for.inc.18
  %indvars.iv.next20.18 = add nsw i64 %indvars.iv19, 19
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.19

for.body6.lr.ph.19:                               ; preds = %for.inc134.18
  %485 = trunc i64 %indvars.iv.next20.18 to i32
  %mul.19 = shl nsw i32 %485, 7
  %cmp9.19 = icmp eq i64 %indvars.iv.next20.18, %2
  %add40.19 = or i32 %mul.19, 1
  %sub45.19 = add i32 %mul.19, -1
  %486 = trunc i64 %indvars.iv.next20.18 to i32
  %add58.19 = shl i32 %486, 7
  %487 = trunc i64 %indvars.iv.next20.18 to i32
  %add79.19 = shl i32 %487, 7
  %mul80.19 = add i32 %add79.19, 128
  %mul85.19 = add i32 %add79.19, -128
  %488 = trunc i64 %indvars.iv.next20.18 to i32
  %sub98.19 = shl i32 %488, 7
  %489 = sext i32 %mul.19 to i64
  %490 = sext i32 %mul85.19 to i64
  %491 = sext i32 %mul80.19 to i64
  br label %for.body6.19

for.body6.19:                                     ; preds = %for.inc.19, %for.body6.lr.ph.19
  %indvars.iv.19 = phi i64 [ 0, %for.body6.lr.ph.19 ], [ %indvars.iv.next.19, %for.inc.19 ]
  %492 = add nsw i64 %indvars.iv.19, %489
  %cmp12.19 = icmp eq i64 %indvars.iv.19, 0
  %or.cond1.19 = or i1 %cmp9.19, %cmp12.19
  %cmp15.19 = icmp eq i64 %indvars.iv.19, %1
  %or.cond2.19 = or i1 %cmp15.19, %or.cond1.19
  br i1 %or.cond2.19, label %if.then.19, label %if.else.19

if.else.19:                                       ; preds = %for.body6.19
  %arrayidx18.19 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %492
  %493 = load float, float* %arrayidx18.19, align 4
  %conv19.19 = fpext float %493 to double
  %mul20.19 = fmul double %conv19.19, 0x404CA5DC1A63C1F8
  %conv21.19 = fptrunc double %mul20.19 to float
  %cmp22.19 = fcmp olt float %conv21.19, 0.000000e+00
  %add25.19 = fadd float %conv21.19, 1.800000e+02
  %angle.0.19 = select i1 %cmp22.19, float %add25.19, float %conv21.19
  %cmp26.19 = fcmp oge float %angle.0.19, 0.000000e+00
  %cmp29.19 = fcmp olt float %angle.0.19, 2.250000e+01
  %or.cond3.19 = and i1 %cmp26.19, %cmp29.19
  br i1 %or.cond3.19, label %if.then38.19, label %lor.lhs.false31.19

lor.lhs.false31.19:                               ; preds = %if.else.19
  %cmp33.19 = fcmp ult float %angle.0.19, 1.575000e+02
  %cmp36.19 = fcmp ugt float %angle.0.19, 1.800000e+02
  %or.cond4.19 = or i1 %cmp33.19, %cmp36.19
  br i1 %or.cond4.19, label %if.else49.19, label %if.then38.19

if.else49.19:                                     ; preds = %lor.lhs.false31.19
  %cmp51.19 = fcmp oge float %angle.0.19, 2.250000e+01
  %cmp55.19 = fcmp olt float %angle.0.19, 6.750000e+01
  %or.cond5.19 = and i1 %cmp51.19, %cmp55.19
  br i1 %or.cond5.19, label %if.then57.19, label %if.else70.19

if.else70.19:                                     ; preds = %if.else49.19
  %cmp72.19 = fcmp oge float %angle.0.19, 6.750000e+01
  %cmp76.19 = fcmp olt float %angle.0.19, 1.125000e+02
  %or.cond6.19 = and i1 %cmp72.19, %cmp76.19
  br i1 %or.cond6.19, label %if.then78.19, label %if.else89.19

if.else89.19:                                     ; preds = %if.else70.19
  %cmp91.19 = fcmp oge float %angle.0.19, 1.125000e+02
  %cmp95.19 = fcmp olt float %angle.0.19, 1.575000e+02
  %or.cond7.19 = and i1 %cmp91.19, %cmp95.19
  br i1 %or.cond7.19, label %if.then97.19, label %if.end113.19

if.then97.19:                                     ; preds = %if.else89.19
  %494 = trunc i64 %indvars.iv.19 to i32
  %sub100.19 = add i32 %494, %sub98.19
  %add101.19 = add i32 %sub100.19, -129
  %idxprom102.19 = sext i32 %add101.19 to i64
  %arrayidx103.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.19
  %495 = load float, float* %arrayidx103.19, align 4
  %add107.19 = add i32 %sub100.19, 129
  %idxprom108.19 = sext i32 %add107.19 to i64
  %arrayidx109.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.19
  %496 = load float, float* %arrayidx109.19, align 4
  br label %if.end113.19

if.then78.19:                                     ; preds = %if.else70.19
  %497 = add nsw i64 %491, %indvars.iv.19
  %arrayidx83.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %497
  %498 = load float, float* %arrayidx83.19, align 4
  %499 = add nsw i64 %490, %indvars.iv.19
  %arrayidx88.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %499
  %500 = load float, float* %arrayidx88.19, align 4
  br label %if.end113.19

if.then57.19:                                     ; preds = %if.else49.19
  %501 = trunc i64 %indvars.iv.19 to i32
  %sub60.19 = add i32 %501, %add58.19
  %add61.19 = add i32 %sub60.19, 127
  %idxprom62.19 = sext i32 %add61.19 to i64
  %arrayidx63.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.19
  %502 = load float, float* %arrayidx63.19, align 4
  %add67.19 = add i32 %sub60.19, -127
  %idxprom68.19 = sext i32 %add67.19 to i64
  %arrayidx69.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.19
  %503 = load float, float* %arrayidx69.19, align 4
  br label %if.end113.19

if.then38.19:                                     ; preds = %lor.lhs.false31.19, %if.else.19
  %504 = trunc i64 %indvars.iv.19 to i32
  %add41.19 = add i32 %add40.19, %504
  %idxprom42.19 = sext i32 %add41.19 to i64
  %arrayidx43.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.19
  %505 = load float, float* %arrayidx43.19, align 4
  %506 = trunc i64 %indvars.iv.19 to i32
  %add46.19 = add i32 %sub45.19, %506
  %idxprom47.19 = sext i32 %add46.19 to i64
  %arrayidx48.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.19
  %507 = load float, float* %arrayidx48.19, align 4
  br label %if.end113.19

if.end113.19:                                     ; preds = %if.then38.19, %if.then57.19, %if.then78.19, %if.then97.19, %if.else89.19
  %q.3.19 = phi float [ %505, %if.then38.19 ], [ %502, %if.then57.19 ], [ %498, %if.then78.19 ], [ %495, %if.then97.19 ], [ 2.550000e+02, %if.else89.19 ]
  %r.3.19 = phi float [ %507, %if.then38.19 ], [ %503, %if.then57.19 ], [ %500, %if.then78.19 ], [ %496, %if.then97.19 ], [ 2.550000e+02, %if.else89.19 ]
  %arrayidx115.19 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %492
  %508 = load float, float* %arrayidx115.19, align 4
  %cmp116.19 = fcmp ult float %508, %q.3.19
  %cmp121.19 = fcmp ult float %508, %r.3.19
  %or.cond8.19 = or i1 %cmp116.19, %cmp121.19
  br i1 %or.cond8.19, label %if.else129.19, label %if.then123.19

if.then123.19:                                    ; preds = %if.end113.19
  %conv126.19 = fptoui float %508 to i32
  %arrayidx128.19 = getelementptr inbounds i32, i32* %0, i64 %492
  store i32 %conv126.19, i32* %arrayidx128.19, align 4
  br label %for.inc.19

if.else129.19:                                    ; preds = %if.end113.19
  %arrayidx131.19 = getelementptr inbounds i32, i32* %0, i64 %492
  store i32 0, i32* %arrayidx131.19, align 4
  br label %for.inc.19

if.then.19:                                       ; preds = %for.body6.19
  %arrayidx.19 = getelementptr inbounds i32, i32* %0, i64 %492
  store i32 0, i32* %arrayidx.19, align 4
  br label %for.inc.19

for.inc.19:                                       ; preds = %if.then.19, %if.else129.19, %if.then123.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %lftr.wideiv.19 = trunc i64 %indvars.iv.next.19 to i32
  %exitcond.19 = icmp eq i32 %lftr.wideiv.19, %img_width
  br i1 %exitcond.19, label %for.inc134.19, label %for.body6.19, !llvm.loop !1

for.inc134.19:                                    ; preds = %for.inc.19
  %indvars.iv.next20.19 = add nsw i64 %indvars.iv19, 20
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.20

for.body6.lr.ph.20:                               ; preds = %for.inc134.19
  %509 = trunc i64 %indvars.iv.next20.19 to i32
  %mul.20 = shl nsw i32 %509, 7
  %cmp9.20 = icmp eq i64 %indvars.iv.next20.19, %2
  %add40.20 = or i32 %mul.20, 1
  %sub45.20 = add i32 %mul.20, -1
  %510 = trunc i64 %indvars.iv.next20.19 to i32
  %add58.20 = shl i32 %510, 7
  %511 = trunc i64 %indvars.iv.next20.19 to i32
  %add79.20 = shl i32 %511, 7
  %mul80.20 = add i32 %add79.20, 128
  %mul85.20 = add i32 %add79.20, -128
  %512 = trunc i64 %indvars.iv.next20.19 to i32
  %sub98.20 = shl i32 %512, 7
  %513 = sext i32 %mul.20 to i64
  %514 = sext i32 %mul85.20 to i64
  %515 = sext i32 %mul80.20 to i64
  br label %for.body6.20

for.body6.20:                                     ; preds = %for.inc.20, %for.body6.lr.ph.20
  %indvars.iv.20 = phi i64 [ 0, %for.body6.lr.ph.20 ], [ %indvars.iv.next.20, %for.inc.20 ]
  %516 = add nsw i64 %indvars.iv.20, %513
  %cmp12.20 = icmp eq i64 %indvars.iv.20, 0
  %or.cond1.20 = or i1 %cmp9.20, %cmp12.20
  %cmp15.20 = icmp eq i64 %indvars.iv.20, %1
  %or.cond2.20 = or i1 %cmp15.20, %or.cond1.20
  br i1 %or.cond2.20, label %if.then.20, label %if.else.20

if.else.20:                                       ; preds = %for.body6.20
  %arrayidx18.20 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %516
  %517 = load float, float* %arrayidx18.20, align 4
  %conv19.20 = fpext float %517 to double
  %mul20.20 = fmul double %conv19.20, 0x404CA5DC1A63C1F8
  %conv21.20 = fptrunc double %mul20.20 to float
  %cmp22.20 = fcmp olt float %conv21.20, 0.000000e+00
  %add25.20 = fadd float %conv21.20, 1.800000e+02
  %angle.0.20 = select i1 %cmp22.20, float %add25.20, float %conv21.20
  %cmp26.20 = fcmp oge float %angle.0.20, 0.000000e+00
  %cmp29.20 = fcmp olt float %angle.0.20, 2.250000e+01
  %or.cond3.20 = and i1 %cmp26.20, %cmp29.20
  br i1 %or.cond3.20, label %if.then38.20, label %lor.lhs.false31.20

lor.lhs.false31.20:                               ; preds = %if.else.20
  %cmp33.20 = fcmp ult float %angle.0.20, 1.575000e+02
  %cmp36.20 = fcmp ugt float %angle.0.20, 1.800000e+02
  %or.cond4.20 = or i1 %cmp33.20, %cmp36.20
  br i1 %or.cond4.20, label %if.else49.20, label %if.then38.20

if.else49.20:                                     ; preds = %lor.lhs.false31.20
  %cmp51.20 = fcmp oge float %angle.0.20, 2.250000e+01
  %cmp55.20 = fcmp olt float %angle.0.20, 6.750000e+01
  %or.cond5.20 = and i1 %cmp51.20, %cmp55.20
  br i1 %or.cond5.20, label %if.then57.20, label %if.else70.20

if.else70.20:                                     ; preds = %if.else49.20
  %cmp72.20 = fcmp oge float %angle.0.20, 6.750000e+01
  %cmp76.20 = fcmp olt float %angle.0.20, 1.125000e+02
  %or.cond6.20 = and i1 %cmp72.20, %cmp76.20
  br i1 %or.cond6.20, label %if.then78.20, label %if.else89.20

if.else89.20:                                     ; preds = %if.else70.20
  %cmp91.20 = fcmp oge float %angle.0.20, 1.125000e+02
  %cmp95.20 = fcmp olt float %angle.0.20, 1.575000e+02
  %or.cond7.20 = and i1 %cmp91.20, %cmp95.20
  br i1 %or.cond7.20, label %if.then97.20, label %if.end113.20

if.then97.20:                                     ; preds = %if.else89.20
  %518 = trunc i64 %indvars.iv.20 to i32
  %sub100.20 = add i32 %518, %sub98.20
  %add101.20 = add i32 %sub100.20, -129
  %idxprom102.20 = sext i32 %add101.20 to i64
  %arrayidx103.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.20
  %519 = load float, float* %arrayidx103.20, align 4
  %add107.20 = add i32 %sub100.20, 129
  %idxprom108.20 = sext i32 %add107.20 to i64
  %arrayidx109.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.20
  %520 = load float, float* %arrayidx109.20, align 4
  br label %if.end113.20

if.then78.20:                                     ; preds = %if.else70.20
  %521 = add nsw i64 %515, %indvars.iv.20
  %arrayidx83.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %521
  %522 = load float, float* %arrayidx83.20, align 4
  %523 = add nsw i64 %514, %indvars.iv.20
  %arrayidx88.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %523
  %524 = load float, float* %arrayidx88.20, align 4
  br label %if.end113.20

if.then57.20:                                     ; preds = %if.else49.20
  %525 = trunc i64 %indvars.iv.20 to i32
  %sub60.20 = add i32 %525, %add58.20
  %add61.20 = add i32 %sub60.20, 127
  %idxprom62.20 = sext i32 %add61.20 to i64
  %arrayidx63.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.20
  %526 = load float, float* %arrayidx63.20, align 4
  %add67.20 = add i32 %sub60.20, -127
  %idxprom68.20 = sext i32 %add67.20 to i64
  %arrayidx69.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.20
  %527 = load float, float* %arrayidx69.20, align 4
  br label %if.end113.20

if.then38.20:                                     ; preds = %lor.lhs.false31.20, %if.else.20
  %528 = trunc i64 %indvars.iv.20 to i32
  %add41.20 = add i32 %add40.20, %528
  %idxprom42.20 = sext i32 %add41.20 to i64
  %arrayidx43.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.20
  %529 = load float, float* %arrayidx43.20, align 4
  %530 = trunc i64 %indvars.iv.20 to i32
  %add46.20 = add i32 %sub45.20, %530
  %idxprom47.20 = sext i32 %add46.20 to i64
  %arrayidx48.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.20
  %531 = load float, float* %arrayidx48.20, align 4
  br label %if.end113.20

if.end113.20:                                     ; preds = %if.then38.20, %if.then57.20, %if.then78.20, %if.then97.20, %if.else89.20
  %q.3.20 = phi float [ %529, %if.then38.20 ], [ %526, %if.then57.20 ], [ %522, %if.then78.20 ], [ %519, %if.then97.20 ], [ 2.550000e+02, %if.else89.20 ]
  %r.3.20 = phi float [ %531, %if.then38.20 ], [ %527, %if.then57.20 ], [ %524, %if.then78.20 ], [ %520, %if.then97.20 ], [ 2.550000e+02, %if.else89.20 ]
  %arrayidx115.20 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %516
  %532 = load float, float* %arrayidx115.20, align 4
  %cmp116.20 = fcmp ult float %532, %q.3.20
  %cmp121.20 = fcmp ult float %532, %r.3.20
  %or.cond8.20 = or i1 %cmp116.20, %cmp121.20
  br i1 %or.cond8.20, label %if.else129.20, label %if.then123.20

if.then123.20:                                    ; preds = %if.end113.20
  %conv126.20 = fptoui float %532 to i32
  %arrayidx128.20 = getelementptr inbounds i32, i32* %0, i64 %516
  store i32 %conv126.20, i32* %arrayidx128.20, align 4
  br label %for.inc.20

if.else129.20:                                    ; preds = %if.end113.20
  %arrayidx131.20 = getelementptr inbounds i32, i32* %0, i64 %516
  store i32 0, i32* %arrayidx131.20, align 4
  br label %for.inc.20

if.then.20:                                       ; preds = %for.body6.20
  %arrayidx.20 = getelementptr inbounds i32, i32* %0, i64 %516
  store i32 0, i32* %arrayidx.20, align 4
  br label %for.inc.20

for.inc.20:                                       ; preds = %if.then.20, %if.else129.20, %if.then123.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %lftr.wideiv.20 = trunc i64 %indvars.iv.next.20 to i32
  %exitcond.20 = icmp eq i32 %lftr.wideiv.20, %img_width
  br i1 %exitcond.20, label %for.inc134.20, label %for.body6.20, !llvm.loop !1

for.inc134.20:                                    ; preds = %for.inc.20
  %indvars.iv.next20.20 = add nsw i64 %indvars.iv19, 21
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.21

for.body6.lr.ph.21:                               ; preds = %for.inc134.20
  %533 = trunc i64 %indvars.iv.next20.20 to i32
  %mul.21 = shl nsw i32 %533, 7
  %cmp9.21 = icmp eq i64 %indvars.iv.next20.20, %2
  %add40.21 = or i32 %mul.21, 1
  %sub45.21 = add i32 %mul.21, -1
  %534 = trunc i64 %indvars.iv.next20.20 to i32
  %add58.21 = shl i32 %534, 7
  %535 = trunc i64 %indvars.iv.next20.20 to i32
  %add79.21 = shl i32 %535, 7
  %mul80.21 = add i32 %add79.21, 128
  %mul85.21 = add i32 %add79.21, -128
  %536 = trunc i64 %indvars.iv.next20.20 to i32
  %sub98.21 = shl i32 %536, 7
  %537 = sext i32 %mul.21 to i64
  %538 = sext i32 %mul85.21 to i64
  %539 = sext i32 %mul80.21 to i64
  br label %for.body6.21

for.body6.21:                                     ; preds = %for.inc.21, %for.body6.lr.ph.21
  %indvars.iv.21 = phi i64 [ 0, %for.body6.lr.ph.21 ], [ %indvars.iv.next.21, %for.inc.21 ]
  %540 = add nsw i64 %indvars.iv.21, %537
  %cmp12.21 = icmp eq i64 %indvars.iv.21, 0
  %or.cond1.21 = or i1 %cmp9.21, %cmp12.21
  %cmp15.21 = icmp eq i64 %indvars.iv.21, %1
  %or.cond2.21 = or i1 %cmp15.21, %or.cond1.21
  br i1 %or.cond2.21, label %if.then.21, label %if.else.21

if.else.21:                                       ; preds = %for.body6.21
  %arrayidx18.21 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %540
  %541 = load float, float* %arrayidx18.21, align 4
  %conv19.21 = fpext float %541 to double
  %mul20.21 = fmul double %conv19.21, 0x404CA5DC1A63C1F8
  %conv21.21 = fptrunc double %mul20.21 to float
  %cmp22.21 = fcmp olt float %conv21.21, 0.000000e+00
  %add25.21 = fadd float %conv21.21, 1.800000e+02
  %angle.0.21 = select i1 %cmp22.21, float %add25.21, float %conv21.21
  %cmp26.21 = fcmp oge float %angle.0.21, 0.000000e+00
  %cmp29.21 = fcmp olt float %angle.0.21, 2.250000e+01
  %or.cond3.21 = and i1 %cmp26.21, %cmp29.21
  br i1 %or.cond3.21, label %if.then38.21, label %lor.lhs.false31.21

lor.lhs.false31.21:                               ; preds = %if.else.21
  %cmp33.21 = fcmp ult float %angle.0.21, 1.575000e+02
  %cmp36.21 = fcmp ugt float %angle.0.21, 1.800000e+02
  %or.cond4.21 = or i1 %cmp33.21, %cmp36.21
  br i1 %or.cond4.21, label %if.else49.21, label %if.then38.21

if.else49.21:                                     ; preds = %lor.lhs.false31.21
  %cmp51.21 = fcmp oge float %angle.0.21, 2.250000e+01
  %cmp55.21 = fcmp olt float %angle.0.21, 6.750000e+01
  %or.cond5.21 = and i1 %cmp51.21, %cmp55.21
  br i1 %or.cond5.21, label %if.then57.21, label %if.else70.21

if.else70.21:                                     ; preds = %if.else49.21
  %cmp72.21 = fcmp oge float %angle.0.21, 6.750000e+01
  %cmp76.21 = fcmp olt float %angle.0.21, 1.125000e+02
  %or.cond6.21 = and i1 %cmp72.21, %cmp76.21
  br i1 %or.cond6.21, label %if.then78.21, label %if.else89.21

if.else89.21:                                     ; preds = %if.else70.21
  %cmp91.21 = fcmp oge float %angle.0.21, 1.125000e+02
  %cmp95.21 = fcmp olt float %angle.0.21, 1.575000e+02
  %or.cond7.21 = and i1 %cmp91.21, %cmp95.21
  br i1 %or.cond7.21, label %if.then97.21, label %if.end113.21

if.then97.21:                                     ; preds = %if.else89.21
  %542 = trunc i64 %indvars.iv.21 to i32
  %sub100.21 = add i32 %542, %sub98.21
  %add101.21 = add i32 %sub100.21, -129
  %idxprom102.21 = sext i32 %add101.21 to i64
  %arrayidx103.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.21
  %543 = load float, float* %arrayidx103.21, align 4
  %add107.21 = add i32 %sub100.21, 129
  %idxprom108.21 = sext i32 %add107.21 to i64
  %arrayidx109.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.21
  %544 = load float, float* %arrayidx109.21, align 4
  br label %if.end113.21

if.then78.21:                                     ; preds = %if.else70.21
  %545 = add nsw i64 %539, %indvars.iv.21
  %arrayidx83.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %545
  %546 = load float, float* %arrayidx83.21, align 4
  %547 = add nsw i64 %538, %indvars.iv.21
  %arrayidx88.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %547
  %548 = load float, float* %arrayidx88.21, align 4
  br label %if.end113.21

if.then57.21:                                     ; preds = %if.else49.21
  %549 = trunc i64 %indvars.iv.21 to i32
  %sub60.21 = add i32 %549, %add58.21
  %add61.21 = add i32 %sub60.21, 127
  %idxprom62.21 = sext i32 %add61.21 to i64
  %arrayidx63.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.21
  %550 = load float, float* %arrayidx63.21, align 4
  %add67.21 = add i32 %sub60.21, -127
  %idxprom68.21 = sext i32 %add67.21 to i64
  %arrayidx69.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.21
  %551 = load float, float* %arrayidx69.21, align 4
  br label %if.end113.21

if.then38.21:                                     ; preds = %lor.lhs.false31.21, %if.else.21
  %552 = trunc i64 %indvars.iv.21 to i32
  %add41.21 = add i32 %add40.21, %552
  %idxprom42.21 = sext i32 %add41.21 to i64
  %arrayidx43.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.21
  %553 = load float, float* %arrayidx43.21, align 4
  %554 = trunc i64 %indvars.iv.21 to i32
  %add46.21 = add i32 %sub45.21, %554
  %idxprom47.21 = sext i32 %add46.21 to i64
  %arrayidx48.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.21
  %555 = load float, float* %arrayidx48.21, align 4
  br label %if.end113.21

if.end113.21:                                     ; preds = %if.then38.21, %if.then57.21, %if.then78.21, %if.then97.21, %if.else89.21
  %q.3.21 = phi float [ %553, %if.then38.21 ], [ %550, %if.then57.21 ], [ %546, %if.then78.21 ], [ %543, %if.then97.21 ], [ 2.550000e+02, %if.else89.21 ]
  %r.3.21 = phi float [ %555, %if.then38.21 ], [ %551, %if.then57.21 ], [ %548, %if.then78.21 ], [ %544, %if.then97.21 ], [ 2.550000e+02, %if.else89.21 ]
  %arrayidx115.21 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %540
  %556 = load float, float* %arrayidx115.21, align 4
  %cmp116.21 = fcmp ult float %556, %q.3.21
  %cmp121.21 = fcmp ult float %556, %r.3.21
  %or.cond8.21 = or i1 %cmp116.21, %cmp121.21
  br i1 %or.cond8.21, label %if.else129.21, label %if.then123.21

if.then123.21:                                    ; preds = %if.end113.21
  %conv126.21 = fptoui float %556 to i32
  %arrayidx128.21 = getelementptr inbounds i32, i32* %0, i64 %540
  store i32 %conv126.21, i32* %arrayidx128.21, align 4
  br label %for.inc.21

if.else129.21:                                    ; preds = %if.end113.21
  %arrayidx131.21 = getelementptr inbounds i32, i32* %0, i64 %540
  store i32 0, i32* %arrayidx131.21, align 4
  br label %for.inc.21

if.then.21:                                       ; preds = %for.body6.21
  %arrayidx.21 = getelementptr inbounds i32, i32* %0, i64 %540
  store i32 0, i32* %arrayidx.21, align 4
  br label %for.inc.21

for.inc.21:                                       ; preds = %if.then.21, %if.else129.21, %if.then123.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %lftr.wideiv.21 = trunc i64 %indvars.iv.next.21 to i32
  %exitcond.21 = icmp eq i32 %lftr.wideiv.21, %img_width
  br i1 %exitcond.21, label %for.inc134.21, label %for.body6.21, !llvm.loop !1

for.inc134.21:                                    ; preds = %for.inc.21
  %indvars.iv.next20.21 = add nsw i64 %indvars.iv19, 22
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.22

for.body6.lr.ph.22:                               ; preds = %for.inc134.21
  %557 = trunc i64 %indvars.iv.next20.21 to i32
  %mul.22 = shl nsw i32 %557, 7
  %cmp9.22 = icmp eq i64 %indvars.iv.next20.21, %2
  %add40.22 = or i32 %mul.22, 1
  %sub45.22 = add i32 %mul.22, -1
  %558 = trunc i64 %indvars.iv.next20.21 to i32
  %add58.22 = shl i32 %558, 7
  %559 = trunc i64 %indvars.iv.next20.21 to i32
  %add79.22 = shl i32 %559, 7
  %mul80.22 = add i32 %add79.22, 128
  %mul85.22 = add i32 %add79.22, -128
  %560 = trunc i64 %indvars.iv.next20.21 to i32
  %sub98.22 = shl i32 %560, 7
  %561 = sext i32 %mul.22 to i64
  %562 = sext i32 %mul85.22 to i64
  %563 = sext i32 %mul80.22 to i64
  br label %for.body6.22

for.body6.22:                                     ; preds = %for.inc.22, %for.body6.lr.ph.22
  %indvars.iv.22 = phi i64 [ 0, %for.body6.lr.ph.22 ], [ %indvars.iv.next.22, %for.inc.22 ]
  %564 = add nsw i64 %indvars.iv.22, %561
  %cmp12.22 = icmp eq i64 %indvars.iv.22, 0
  %or.cond1.22 = or i1 %cmp9.22, %cmp12.22
  %cmp15.22 = icmp eq i64 %indvars.iv.22, %1
  %or.cond2.22 = or i1 %cmp15.22, %or.cond1.22
  br i1 %or.cond2.22, label %if.then.22, label %if.else.22

if.else.22:                                       ; preds = %for.body6.22
  %arrayidx18.22 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %564
  %565 = load float, float* %arrayidx18.22, align 4
  %conv19.22 = fpext float %565 to double
  %mul20.22 = fmul double %conv19.22, 0x404CA5DC1A63C1F8
  %conv21.22 = fptrunc double %mul20.22 to float
  %cmp22.22 = fcmp olt float %conv21.22, 0.000000e+00
  %add25.22 = fadd float %conv21.22, 1.800000e+02
  %angle.0.22 = select i1 %cmp22.22, float %add25.22, float %conv21.22
  %cmp26.22 = fcmp oge float %angle.0.22, 0.000000e+00
  %cmp29.22 = fcmp olt float %angle.0.22, 2.250000e+01
  %or.cond3.22 = and i1 %cmp26.22, %cmp29.22
  br i1 %or.cond3.22, label %if.then38.22, label %lor.lhs.false31.22

lor.lhs.false31.22:                               ; preds = %if.else.22
  %cmp33.22 = fcmp ult float %angle.0.22, 1.575000e+02
  %cmp36.22 = fcmp ugt float %angle.0.22, 1.800000e+02
  %or.cond4.22 = or i1 %cmp33.22, %cmp36.22
  br i1 %or.cond4.22, label %if.else49.22, label %if.then38.22

if.else49.22:                                     ; preds = %lor.lhs.false31.22
  %cmp51.22 = fcmp oge float %angle.0.22, 2.250000e+01
  %cmp55.22 = fcmp olt float %angle.0.22, 6.750000e+01
  %or.cond5.22 = and i1 %cmp51.22, %cmp55.22
  br i1 %or.cond5.22, label %if.then57.22, label %if.else70.22

if.else70.22:                                     ; preds = %if.else49.22
  %cmp72.22 = fcmp oge float %angle.0.22, 6.750000e+01
  %cmp76.22 = fcmp olt float %angle.0.22, 1.125000e+02
  %or.cond6.22 = and i1 %cmp72.22, %cmp76.22
  br i1 %or.cond6.22, label %if.then78.22, label %if.else89.22

if.else89.22:                                     ; preds = %if.else70.22
  %cmp91.22 = fcmp oge float %angle.0.22, 1.125000e+02
  %cmp95.22 = fcmp olt float %angle.0.22, 1.575000e+02
  %or.cond7.22 = and i1 %cmp91.22, %cmp95.22
  br i1 %or.cond7.22, label %if.then97.22, label %if.end113.22

if.then97.22:                                     ; preds = %if.else89.22
  %566 = trunc i64 %indvars.iv.22 to i32
  %sub100.22 = add i32 %566, %sub98.22
  %add101.22 = add i32 %sub100.22, -129
  %idxprom102.22 = sext i32 %add101.22 to i64
  %arrayidx103.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.22
  %567 = load float, float* %arrayidx103.22, align 4
  %add107.22 = add i32 %sub100.22, 129
  %idxprom108.22 = sext i32 %add107.22 to i64
  %arrayidx109.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.22
  %568 = load float, float* %arrayidx109.22, align 4
  br label %if.end113.22

if.then78.22:                                     ; preds = %if.else70.22
  %569 = add nsw i64 %563, %indvars.iv.22
  %arrayidx83.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %569
  %570 = load float, float* %arrayidx83.22, align 4
  %571 = add nsw i64 %562, %indvars.iv.22
  %arrayidx88.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %571
  %572 = load float, float* %arrayidx88.22, align 4
  br label %if.end113.22

if.then57.22:                                     ; preds = %if.else49.22
  %573 = trunc i64 %indvars.iv.22 to i32
  %sub60.22 = add i32 %573, %add58.22
  %add61.22 = add i32 %sub60.22, 127
  %idxprom62.22 = sext i32 %add61.22 to i64
  %arrayidx63.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.22
  %574 = load float, float* %arrayidx63.22, align 4
  %add67.22 = add i32 %sub60.22, -127
  %idxprom68.22 = sext i32 %add67.22 to i64
  %arrayidx69.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.22
  %575 = load float, float* %arrayidx69.22, align 4
  br label %if.end113.22

if.then38.22:                                     ; preds = %lor.lhs.false31.22, %if.else.22
  %576 = trunc i64 %indvars.iv.22 to i32
  %add41.22 = add i32 %add40.22, %576
  %idxprom42.22 = sext i32 %add41.22 to i64
  %arrayidx43.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.22
  %577 = load float, float* %arrayidx43.22, align 4
  %578 = trunc i64 %indvars.iv.22 to i32
  %add46.22 = add i32 %sub45.22, %578
  %idxprom47.22 = sext i32 %add46.22 to i64
  %arrayidx48.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.22
  %579 = load float, float* %arrayidx48.22, align 4
  br label %if.end113.22

if.end113.22:                                     ; preds = %if.then38.22, %if.then57.22, %if.then78.22, %if.then97.22, %if.else89.22
  %q.3.22 = phi float [ %577, %if.then38.22 ], [ %574, %if.then57.22 ], [ %570, %if.then78.22 ], [ %567, %if.then97.22 ], [ 2.550000e+02, %if.else89.22 ]
  %r.3.22 = phi float [ %579, %if.then38.22 ], [ %575, %if.then57.22 ], [ %572, %if.then78.22 ], [ %568, %if.then97.22 ], [ 2.550000e+02, %if.else89.22 ]
  %arrayidx115.22 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %564
  %580 = load float, float* %arrayidx115.22, align 4
  %cmp116.22 = fcmp ult float %580, %q.3.22
  %cmp121.22 = fcmp ult float %580, %r.3.22
  %or.cond8.22 = or i1 %cmp116.22, %cmp121.22
  br i1 %or.cond8.22, label %if.else129.22, label %if.then123.22

if.then123.22:                                    ; preds = %if.end113.22
  %conv126.22 = fptoui float %580 to i32
  %arrayidx128.22 = getelementptr inbounds i32, i32* %0, i64 %564
  store i32 %conv126.22, i32* %arrayidx128.22, align 4
  br label %for.inc.22

if.else129.22:                                    ; preds = %if.end113.22
  %arrayidx131.22 = getelementptr inbounds i32, i32* %0, i64 %564
  store i32 0, i32* %arrayidx131.22, align 4
  br label %for.inc.22

if.then.22:                                       ; preds = %for.body6.22
  %arrayidx.22 = getelementptr inbounds i32, i32* %0, i64 %564
  store i32 0, i32* %arrayidx.22, align 4
  br label %for.inc.22

for.inc.22:                                       ; preds = %if.then.22, %if.else129.22, %if.then123.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %lftr.wideiv.22 = trunc i64 %indvars.iv.next.22 to i32
  %exitcond.22 = icmp eq i32 %lftr.wideiv.22, %img_width
  br i1 %exitcond.22, label %for.inc134.22, label %for.body6.22, !llvm.loop !1

for.inc134.22:                                    ; preds = %for.inc.22
  %indvars.iv.next20.22 = add nsw i64 %indvars.iv19, 23
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.23

for.body6.lr.ph.23:                               ; preds = %for.inc134.22
  %581 = trunc i64 %indvars.iv.next20.22 to i32
  %mul.23 = shl nsw i32 %581, 7
  %cmp9.23 = icmp eq i64 %indvars.iv.next20.22, %2
  %add40.23 = or i32 %mul.23, 1
  %sub45.23 = add i32 %mul.23, -1
  %582 = trunc i64 %indvars.iv.next20.22 to i32
  %add58.23 = shl i32 %582, 7
  %583 = trunc i64 %indvars.iv.next20.22 to i32
  %add79.23 = shl i32 %583, 7
  %mul80.23 = add i32 %add79.23, 128
  %mul85.23 = add i32 %add79.23, -128
  %584 = trunc i64 %indvars.iv.next20.22 to i32
  %sub98.23 = shl i32 %584, 7
  %585 = sext i32 %mul.23 to i64
  %586 = sext i32 %mul85.23 to i64
  %587 = sext i32 %mul80.23 to i64
  br label %for.body6.23

for.body6.23:                                     ; preds = %for.inc.23, %for.body6.lr.ph.23
  %indvars.iv.23 = phi i64 [ 0, %for.body6.lr.ph.23 ], [ %indvars.iv.next.23, %for.inc.23 ]
  %588 = add nsw i64 %indvars.iv.23, %585
  %cmp12.23 = icmp eq i64 %indvars.iv.23, 0
  %or.cond1.23 = or i1 %cmp9.23, %cmp12.23
  %cmp15.23 = icmp eq i64 %indvars.iv.23, %1
  %or.cond2.23 = or i1 %cmp15.23, %or.cond1.23
  br i1 %or.cond2.23, label %if.then.23, label %if.else.23

if.else.23:                                       ; preds = %for.body6.23
  %arrayidx18.23 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %588
  %589 = load float, float* %arrayidx18.23, align 4
  %conv19.23 = fpext float %589 to double
  %mul20.23 = fmul double %conv19.23, 0x404CA5DC1A63C1F8
  %conv21.23 = fptrunc double %mul20.23 to float
  %cmp22.23 = fcmp olt float %conv21.23, 0.000000e+00
  %add25.23 = fadd float %conv21.23, 1.800000e+02
  %angle.0.23 = select i1 %cmp22.23, float %add25.23, float %conv21.23
  %cmp26.23 = fcmp oge float %angle.0.23, 0.000000e+00
  %cmp29.23 = fcmp olt float %angle.0.23, 2.250000e+01
  %or.cond3.23 = and i1 %cmp26.23, %cmp29.23
  br i1 %or.cond3.23, label %if.then38.23, label %lor.lhs.false31.23

lor.lhs.false31.23:                               ; preds = %if.else.23
  %cmp33.23 = fcmp ult float %angle.0.23, 1.575000e+02
  %cmp36.23 = fcmp ugt float %angle.0.23, 1.800000e+02
  %or.cond4.23 = or i1 %cmp33.23, %cmp36.23
  br i1 %or.cond4.23, label %if.else49.23, label %if.then38.23

if.else49.23:                                     ; preds = %lor.lhs.false31.23
  %cmp51.23 = fcmp oge float %angle.0.23, 2.250000e+01
  %cmp55.23 = fcmp olt float %angle.0.23, 6.750000e+01
  %or.cond5.23 = and i1 %cmp51.23, %cmp55.23
  br i1 %or.cond5.23, label %if.then57.23, label %if.else70.23

if.else70.23:                                     ; preds = %if.else49.23
  %cmp72.23 = fcmp oge float %angle.0.23, 6.750000e+01
  %cmp76.23 = fcmp olt float %angle.0.23, 1.125000e+02
  %or.cond6.23 = and i1 %cmp72.23, %cmp76.23
  br i1 %or.cond6.23, label %if.then78.23, label %if.else89.23

if.else89.23:                                     ; preds = %if.else70.23
  %cmp91.23 = fcmp oge float %angle.0.23, 1.125000e+02
  %cmp95.23 = fcmp olt float %angle.0.23, 1.575000e+02
  %or.cond7.23 = and i1 %cmp91.23, %cmp95.23
  br i1 %or.cond7.23, label %if.then97.23, label %if.end113.23

if.then97.23:                                     ; preds = %if.else89.23
  %590 = trunc i64 %indvars.iv.23 to i32
  %sub100.23 = add i32 %590, %sub98.23
  %add101.23 = add i32 %sub100.23, -129
  %idxprom102.23 = sext i32 %add101.23 to i64
  %arrayidx103.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.23
  %591 = load float, float* %arrayidx103.23, align 4
  %add107.23 = add i32 %sub100.23, 129
  %idxprom108.23 = sext i32 %add107.23 to i64
  %arrayidx109.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.23
  %592 = load float, float* %arrayidx109.23, align 4
  br label %if.end113.23

if.then78.23:                                     ; preds = %if.else70.23
  %593 = add nsw i64 %587, %indvars.iv.23
  %arrayidx83.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %593
  %594 = load float, float* %arrayidx83.23, align 4
  %595 = add nsw i64 %586, %indvars.iv.23
  %arrayidx88.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %595
  %596 = load float, float* %arrayidx88.23, align 4
  br label %if.end113.23

if.then57.23:                                     ; preds = %if.else49.23
  %597 = trunc i64 %indvars.iv.23 to i32
  %sub60.23 = add i32 %597, %add58.23
  %add61.23 = add i32 %sub60.23, 127
  %idxprom62.23 = sext i32 %add61.23 to i64
  %arrayidx63.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.23
  %598 = load float, float* %arrayidx63.23, align 4
  %add67.23 = add i32 %sub60.23, -127
  %idxprom68.23 = sext i32 %add67.23 to i64
  %arrayidx69.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.23
  %599 = load float, float* %arrayidx69.23, align 4
  br label %if.end113.23

if.then38.23:                                     ; preds = %lor.lhs.false31.23, %if.else.23
  %600 = trunc i64 %indvars.iv.23 to i32
  %add41.23 = add i32 %add40.23, %600
  %idxprom42.23 = sext i32 %add41.23 to i64
  %arrayidx43.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.23
  %601 = load float, float* %arrayidx43.23, align 4
  %602 = trunc i64 %indvars.iv.23 to i32
  %add46.23 = add i32 %sub45.23, %602
  %idxprom47.23 = sext i32 %add46.23 to i64
  %arrayidx48.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.23
  %603 = load float, float* %arrayidx48.23, align 4
  br label %if.end113.23

if.end113.23:                                     ; preds = %if.then38.23, %if.then57.23, %if.then78.23, %if.then97.23, %if.else89.23
  %q.3.23 = phi float [ %601, %if.then38.23 ], [ %598, %if.then57.23 ], [ %594, %if.then78.23 ], [ %591, %if.then97.23 ], [ 2.550000e+02, %if.else89.23 ]
  %r.3.23 = phi float [ %603, %if.then38.23 ], [ %599, %if.then57.23 ], [ %596, %if.then78.23 ], [ %592, %if.then97.23 ], [ 2.550000e+02, %if.else89.23 ]
  %arrayidx115.23 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %588
  %604 = load float, float* %arrayidx115.23, align 4
  %cmp116.23 = fcmp ult float %604, %q.3.23
  %cmp121.23 = fcmp ult float %604, %r.3.23
  %or.cond8.23 = or i1 %cmp116.23, %cmp121.23
  br i1 %or.cond8.23, label %if.else129.23, label %if.then123.23

if.then123.23:                                    ; preds = %if.end113.23
  %conv126.23 = fptoui float %604 to i32
  %arrayidx128.23 = getelementptr inbounds i32, i32* %0, i64 %588
  store i32 %conv126.23, i32* %arrayidx128.23, align 4
  br label %for.inc.23

if.else129.23:                                    ; preds = %if.end113.23
  %arrayidx131.23 = getelementptr inbounds i32, i32* %0, i64 %588
  store i32 0, i32* %arrayidx131.23, align 4
  br label %for.inc.23

if.then.23:                                       ; preds = %for.body6.23
  %arrayidx.23 = getelementptr inbounds i32, i32* %0, i64 %588
  store i32 0, i32* %arrayidx.23, align 4
  br label %for.inc.23

for.inc.23:                                       ; preds = %if.then.23, %if.else129.23, %if.then123.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %lftr.wideiv.23 = trunc i64 %indvars.iv.next.23 to i32
  %exitcond.23 = icmp eq i32 %lftr.wideiv.23, %img_width
  br i1 %exitcond.23, label %for.inc134.23, label %for.body6.23, !llvm.loop !1

for.inc134.23:                                    ; preds = %for.inc.23
  %indvars.iv.next20.23 = add nsw i64 %indvars.iv19, 24
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.24

for.body6.lr.ph.24:                               ; preds = %for.inc134.23
  %605 = trunc i64 %indvars.iv.next20.23 to i32
  %mul.24 = shl nsw i32 %605, 7
  %cmp9.24 = icmp eq i64 %indvars.iv.next20.23, %2
  %add40.24 = or i32 %mul.24, 1
  %sub45.24 = add i32 %mul.24, -1
  %606 = trunc i64 %indvars.iv.next20.23 to i32
  %add58.24 = shl i32 %606, 7
  %607 = trunc i64 %indvars.iv.next20.23 to i32
  %add79.24 = shl i32 %607, 7
  %mul80.24 = add i32 %add79.24, 128
  %mul85.24 = add i32 %add79.24, -128
  %608 = trunc i64 %indvars.iv.next20.23 to i32
  %sub98.24 = shl i32 %608, 7
  %609 = sext i32 %mul.24 to i64
  %610 = sext i32 %mul85.24 to i64
  %611 = sext i32 %mul80.24 to i64
  br label %for.body6.24

for.body6.24:                                     ; preds = %for.inc.24, %for.body6.lr.ph.24
  %indvars.iv.24 = phi i64 [ 0, %for.body6.lr.ph.24 ], [ %indvars.iv.next.24, %for.inc.24 ]
  %612 = add nsw i64 %indvars.iv.24, %609
  %cmp12.24 = icmp eq i64 %indvars.iv.24, 0
  %or.cond1.24 = or i1 %cmp9.24, %cmp12.24
  %cmp15.24 = icmp eq i64 %indvars.iv.24, %1
  %or.cond2.24 = or i1 %cmp15.24, %or.cond1.24
  br i1 %or.cond2.24, label %if.then.24, label %if.else.24

if.else.24:                                       ; preds = %for.body6.24
  %arrayidx18.24 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %612
  %613 = load float, float* %arrayidx18.24, align 4
  %conv19.24 = fpext float %613 to double
  %mul20.24 = fmul double %conv19.24, 0x404CA5DC1A63C1F8
  %conv21.24 = fptrunc double %mul20.24 to float
  %cmp22.24 = fcmp olt float %conv21.24, 0.000000e+00
  %add25.24 = fadd float %conv21.24, 1.800000e+02
  %angle.0.24 = select i1 %cmp22.24, float %add25.24, float %conv21.24
  %cmp26.24 = fcmp oge float %angle.0.24, 0.000000e+00
  %cmp29.24 = fcmp olt float %angle.0.24, 2.250000e+01
  %or.cond3.24 = and i1 %cmp26.24, %cmp29.24
  br i1 %or.cond3.24, label %if.then38.24, label %lor.lhs.false31.24

lor.lhs.false31.24:                               ; preds = %if.else.24
  %cmp33.24 = fcmp ult float %angle.0.24, 1.575000e+02
  %cmp36.24 = fcmp ugt float %angle.0.24, 1.800000e+02
  %or.cond4.24 = or i1 %cmp33.24, %cmp36.24
  br i1 %or.cond4.24, label %if.else49.24, label %if.then38.24

if.else49.24:                                     ; preds = %lor.lhs.false31.24
  %cmp51.24 = fcmp oge float %angle.0.24, 2.250000e+01
  %cmp55.24 = fcmp olt float %angle.0.24, 6.750000e+01
  %or.cond5.24 = and i1 %cmp51.24, %cmp55.24
  br i1 %or.cond5.24, label %if.then57.24, label %if.else70.24

if.else70.24:                                     ; preds = %if.else49.24
  %cmp72.24 = fcmp oge float %angle.0.24, 6.750000e+01
  %cmp76.24 = fcmp olt float %angle.0.24, 1.125000e+02
  %or.cond6.24 = and i1 %cmp72.24, %cmp76.24
  br i1 %or.cond6.24, label %if.then78.24, label %if.else89.24

if.else89.24:                                     ; preds = %if.else70.24
  %cmp91.24 = fcmp oge float %angle.0.24, 1.125000e+02
  %cmp95.24 = fcmp olt float %angle.0.24, 1.575000e+02
  %or.cond7.24 = and i1 %cmp91.24, %cmp95.24
  br i1 %or.cond7.24, label %if.then97.24, label %if.end113.24

if.then97.24:                                     ; preds = %if.else89.24
  %614 = trunc i64 %indvars.iv.24 to i32
  %sub100.24 = add i32 %614, %sub98.24
  %add101.24 = add i32 %sub100.24, -129
  %idxprom102.24 = sext i32 %add101.24 to i64
  %arrayidx103.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.24
  %615 = load float, float* %arrayidx103.24, align 4
  %add107.24 = add i32 %sub100.24, 129
  %idxprom108.24 = sext i32 %add107.24 to i64
  %arrayidx109.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.24
  %616 = load float, float* %arrayidx109.24, align 4
  br label %if.end113.24

if.then78.24:                                     ; preds = %if.else70.24
  %617 = add nsw i64 %611, %indvars.iv.24
  %arrayidx83.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %617
  %618 = load float, float* %arrayidx83.24, align 4
  %619 = add nsw i64 %610, %indvars.iv.24
  %arrayidx88.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %619
  %620 = load float, float* %arrayidx88.24, align 4
  br label %if.end113.24

if.then57.24:                                     ; preds = %if.else49.24
  %621 = trunc i64 %indvars.iv.24 to i32
  %sub60.24 = add i32 %621, %add58.24
  %add61.24 = add i32 %sub60.24, 127
  %idxprom62.24 = sext i32 %add61.24 to i64
  %arrayidx63.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.24
  %622 = load float, float* %arrayidx63.24, align 4
  %add67.24 = add i32 %sub60.24, -127
  %idxprom68.24 = sext i32 %add67.24 to i64
  %arrayidx69.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.24
  %623 = load float, float* %arrayidx69.24, align 4
  br label %if.end113.24

if.then38.24:                                     ; preds = %lor.lhs.false31.24, %if.else.24
  %624 = trunc i64 %indvars.iv.24 to i32
  %add41.24 = add i32 %add40.24, %624
  %idxprom42.24 = sext i32 %add41.24 to i64
  %arrayidx43.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.24
  %625 = load float, float* %arrayidx43.24, align 4
  %626 = trunc i64 %indvars.iv.24 to i32
  %add46.24 = add i32 %sub45.24, %626
  %idxprom47.24 = sext i32 %add46.24 to i64
  %arrayidx48.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.24
  %627 = load float, float* %arrayidx48.24, align 4
  br label %if.end113.24

if.end113.24:                                     ; preds = %if.then38.24, %if.then57.24, %if.then78.24, %if.then97.24, %if.else89.24
  %q.3.24 = phi float [ %625, %if.then38.24 ], [ %622, %if.then57.24 ], [ %618, %if.then78.24 ], [ %615, %if.then97.24 ], [ 2.550000e+02, %if.else89.24 ]
  %r.3.24 = phi float [ %627, %if.then38.24 ], [ %623, %if.then57.24 ], [ %620, %if.then78.24 ], [ %616, %if.then97.24 ], [ 2.550000e+02, %if.else89.24 ]
  %arrayidx115.24 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %612
  %628 = load float, float* %arrayidx115.24, align 4
  %cmp116.24 = fcmp ult float %628, %q.3.24
  %cmp121.24 = fcmp ult float %628, %r.3.24
  %or.cond8.24 = or i1 %cmp116.24, %cmp121.24
  br i1 %or.cond8.24, label %if.else129.24, label %if.then123.24

if.then123.24:                                    ; preds = %if.end113.24
  %conv126.24 = fptoui float %628 to i32
  %arrayidx128.24 = getelementptr inbounds i32, i32* %0, i64 %612
  store i32 %conv126.24, i32* %arrayidx128.24, align 4
  br label %for.inc.24

if.else129.24:                                    ; preds = %if.end113.24
  %arrayidx131.24 = getelementptr inbounds i32, i32* %0, i64 %612
  store i32 0, i32* %arrayidx131.24, align 4
  br label %for.inc.24

if.then.24:                                       ; preds = %for.body6.24
  %arrayidx.24 = getelementptr inbounds i32, i32* %0, i64 %612
  store i32 0, i32* %arrayidx.24, align 4
  br label %for.inc.24

for.inc.24:                                       ; preds = %if.then.24, %if.else129.24, %if.then123.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %lftr.wideiv.24 = trunc i64 %indvars.iv.next.24 to i32
  %exitcond.24 = icmp eq i32 %lftr.wideiv.24, %img_width
  br i1 %exitcond.24, label %for.inc134.24, label %for.body6.24, !llvm.loop !1

for.inc134.24:                                    ; preds = %for.inc.24
  %indvars.iv.next20.24 = add nsw i64 %indvars.iv19, 25
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.25

for.body6.lr.ph.25:                               ; preds = %for.inc134.24
  %629 = trunc i64 %indvars.iv.next20.24 to i32
  %mul.25 = shl nsw i32 %629, 7
  %cmp9.25 = icmp eq i64 %indvars.iv.next20.24, %2
  %add40.25 = or i32 %mul.25, 1
  %sub45.25 = add i32 %mul.25, -1
  %630 = trunc i64 %indvars.iv.next20.24 to i32
  %add58.25 = shl i32 %630, 7
  %631 = trunc i64 %indvars.iv.next20.24 to i32
  %add79.25 = shl i32 %631, 7
  %mul80.25 = add i32 %add79.25, 128
  %mul85.25 = add i32 %add79.25, -128
  %632 = trunc i64 %indvars.iv.next20.24 to i32
  %sub98.25 = shl i32 %632, 7
  %633 = sext i32 %mul.25 to i64
  %634 = sext i32 %mul85.25 to i64
  %635 = sext i32 %mul80.25 to i64
  br label %for.body6.25

for.body6.25:                                     ; preds = %for.inc.25, %for.body6.lr.ph.25
  %indvars.iv.25 = phi i64 [ 0, %for.body6.lr.ph.25 ], [ %indvars.iv.next.25, %for.inc.25 ]
  %636 = add nsw i64 %indvars.iv.25, %633
  %cmp12.25 = icmp eq i64 %indvars.iv.25, 0
  %or.cond1.25 = or i1 %cmp9.25, %cmp12.25
  %cmp15.25 = icmp eq i64 %indvars.iv.25, %1
  %or.cond2.25 = or i1 %cmp15.25, %or.cond1.25
  br i1 %or.cond2.25, label %if.then.25, label %if.else.25

if.else.25:                                       ; preds = %for.body6.25
  %arrayidx18.25 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %636
  %637 = load float, float* %arrayidx18.25, align 4
  %conv19.25 = fpext float %637 to double
  %mul20.25 = fmul double %conv19.25, 0x404CA5DC1A63C1F8
  %conv21.25 = fptrunc double %mul20.25 to float
  %cmp22.25 = fcmp olt float %conv21.25, 0.000000e+00
  %add25.25 = fadd float %conv21.25, 1.800000e+02
  %angle.0.25 = select i1 %cmp22.25, float %add25.25, float %conv21.25
  %cmp26.25 = fcmp oge float %angle.0.25, 0.000000e+00
  %cmp29.25 = fcmp olt float %angle.0.25, 2.250000e+01
  %or.cond3.25 = and i1 %cmp26.25, %cmp29.25
  br i1 %or.cond3.25, label %if.then38.25, label %lor.lhs.false31.25

lor.lhs.false31.25:                               ; preds = %if.else.25
  %cmp33.25 = fcmp ult float %angle.0.25, 1.575000e+02
  %cmp36.25 = fcmp ugt float %angle.0.25, 1.800000e+02
  %or.cond4.25 = or i1 %cmp33.25, %cmp36.25
  br i1 %or.cond4.25, label %if.else49.25, label %if.then38.25

if.else49.25:                                     ; preds = %lor.lhs.false31.25
  %cmp51.25 = fcmp oge float %angle.0.25, 2.250000e+01
  %cmp55.25 = fcmp olt float %angle.0.25, 6.750000e+01
  %or.cond5.25 = and i1 %cmp51.25, %cmp55.25
  br i1 %or.cond5.25, label %if.then57.25, label %if.else70.25

if.else70.25:                                     ; preds = %if.else49.25
  %cmp72.25 = fcmp oge float %angle.0.25, 6.750000e+01
  %cmp76.25 = fcmp olt float %angle.0.25, 1.125000e+02
  %or.cond6.25 = and i1 %cmp72.25, %cmp76.25
  br i1 %or.cond6.25, label %if.then78.25, label %if.else89.25

if.else89.25:                                     ; preds = %if.else70.25
  %cmp91.25 = fcmp oge float %angle.0.25, 1.125000e+02
  %cmp95.25 = fcmp olt float %angle.0.25, 1.575000e+02
  %or.cond7.25 = and i1 %cmp91.25, %cmp95.25
  br i1 %or.cond7.25, label %if.then97.25, label %if.end113.25

if.then97.25:                                     ; preds = %if.else89.25
  %638 = trunc i64 %indvars.iv.25 to i32
  %sub100.25 = add i32 %638, %sub98.25
  %add101.25 = add i32 %sub100.25, -129
  %idxprom102.25 = sext i32 %add101.25 to i64
  %arrayidx103.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.25
  %639 = load float, float* %arrayidx103.25, align 4
  %add107.25 = add i32 %sub100.25, 129
  %idxprom108.25 = sext i32 %add107.25 to i64
  %arrayidx109.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.25
  %640 = load float, float* %arrayidx109.25, align 4
  br label %if.end113.25

if.then78.25:                                     ; preds = %if.else70.25
  %641 = add nsw i64 %635, %indvars.iv.25
  %arrayidx83.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %641
  %642 = load float, float* %arrayidx83.25, align 4
  %643 = add nsw i64 %634, %indvars.iv.25
  %arrayidx88.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %643
  %644 = load float, float* %arrayidx88.25, align 4
  br label %if.end113.25

if.then57.25:                                     ; preds = %if.else49.25
  %645 = trunc i64 %indvars.iv.25 to i32
  %sub60.25 = add i32 %645, %add58.25
  %add61.25 = add i32 %sub60.25, 127
  %idxprom62.25 = sext i32 %add61.25 to i64
  %arrayidx63.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.25
  %646 = load float, float* %arrayidx63.25, align 4
  %add67.25 = add i32 %sub60.25, -127
  %idxprom68.25 = sext i32 %add67.25 to i64
  %arrayidx69.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.25
  %647 = load float, float* %arrayidx69.25, align 4
  br label %if.end113.25

if.then38.25:                                     ; preds = %lor.lhs.false31.25, %if.else.25
  %648 = trunc i64 %indvars.iv.25 to i32
  %add41.25 = add i32 %add40.25, %648
  %idxprom42.25 = sext i32 %add41.25 to i64
  %arrayidx43.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.25
  %649 = load float, float* %arrayidx43.25, align 4
  %650 = trunc i64 %indvars.iv.25 to i32
  %add46.25 = add i32 %sub45.25, %650
  %idxprom47.25 = sext i32 %add46.25 to i64
  %arrayidx48.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.25
  %651 = load float, float* %arrayidx48.25, align 4
  br label %if.end113.25

if.end113.25:                                     ; preds = %if.then38.25, %if.then57.25, %if.then78.25, %if.then97.25, %if.else89.25
  %q.3.25 = phi float [ %649, %if.then38.25 ], [ %646, %if.then57.25 ], [ %642, %if.then78.25 ], [ %639, %if.then97.25 ], [ 2.550000e+02, %if.else89.25 ]
  %r.3.25 = phi float [ %651, %if.then38.25 ], [ %647, %if.then57.25 ], [ %644, %if.then78.25 ], [ %640, %if.then97.25 ], [ 2.550000e+02, %if.else89.25 ]
  %arrayidx115.25 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %636
  %652 = load float, float* %arrayidx115.25, align 4
  %cmp116.25 = fcmp ult float %652, %q.3.25
  %cmp121.25 = fcmp ult float %652, %r.3.25
  %or.cond8.25 = or i1 %cmp116.25, %cmp121.25
  br i1 %or.cond8.25, label %if.else129.25, label %if.then123.25

if.then123.25:                                    ; preds = %if.end113.25
  %conv126.25 = fptoui float %652 to i32
  %arrayidx128.25 = getelementptr inbounds i32, i32* %0, i64 %636
  store i32 %conv126.25, i32* %arrayidx128.25, align 4
  br label %for.inc.25

if.else129.25:                                    ; preds = %if.end113.25
  %arrayidx131.25 = getelementptr inbounds i32, i32* %0, i64 %636
  store i32 0, i32* %arrayidx131.25, align 4
  br label %for.inc.25

if.then.25:                                       ; preds = %for.body6.25
  %arrayidx.25 = getelementptr inbounds i32, i32* %0, i64 %636
  store i32 0, i32* %arrayidx.25, align 4
  br label %for.inc.25

for.inc.25:                                       ; preds = %if.then.25, %if.else129.25, %if.then123.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %lftr.wideiv.25 = trunc i64 %indvars.iv.next.25 to i32
  %exitcond.25 = icmp eq i32 %lftr.wideiv.25, %img_width
  br i1 %exitcond.25, label %for.inc134.25, label %for.body6.25, !llvm.loop !1

for.inc134.25:                                    ; preds = %for.inc.25
  %indvars.iv.next20.25 = add nsw i64 %indvars.iv19, 26
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.26

for.body6.lr.ph.26:                               ; preds = %for.inc134.25
  %653 = trunc i64 %indvars.iv.next20.25 to i32
  %mul.26 = shl nsw i32 %653, 7
  %cmp9.26 = icmp eq i64 %indvars.iv.next20.25, %2
  %add40.26 = or i32 %mul.26, 1
  %sub45.26 = add i32 %mul.26, -1
  %654 = trunc i64 %indvars.iv.next20.25 to i32
  %add58.26 = shl i32 %654, 7
  %655 = trunc i64 %indvars.iv.next20.25 to i32
  %add79.26 = shl i32 %655, 7
  %mul80.26 = add i32 %add79.26, 128
  %mul85.26 = add i32 %add79.26, -128
  %656 = trunc i64 %indvars.iv.next20.25 to i32
  %sub98.26 = shl i32 %656, 7
  %657 = sext i32 %mul.26 to i64
  %658 = sext i32 %mul85.26 to i64
  %659 = sext i32 %mul80.26 to i64
  br label %for.body6.26

for.body6.26:                                     ; preds = %for.inc.26, %for.body6.lr.ph.26
  %indvars.iv.26 = phi i64 [ 0, %for.body6.lr.ph.26 ], [ %indvars.iv.next.26, %for.inc.26 ]
  %660 = add nsw i64 %indvars.iv.26, %657
  %cmp12.26 = icmp eq i64 %indvars.iv.26, 0
  %or.cond1.26 = or i1 %cmp9.26, %cmp12.26
  %cmp15.26 = icmp eq i64 %indvars.iv.26, %1
  %or.cond2.26 = or i1 %cmp15.26, %or.cond1.26
  br i1 %or.cond2.26, label %if.then.26, label %if.else.26

if.else.26:                                       ; preds = %for.body6.26
  %arrayidx18.26 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %660
  %661 = load float, float* %arrayidx18.26, align 4
  %conv19.26 = fpext float %661 to double
  %mul20.26 = fmul double %conv19.26, 0x404CA5DC1A63C1F8
  %conv21.26 = fptrunc double %mul20.26 to float
  %cmp22.26 = fcmp olt float %conv21.26, 0.000000e+00
  %add25.26 = fadd float %conv21.26, 1.800000e+02
  %angle.0.26 = select i1 %cmp22.26, float %add25.26, float %conv21.26
  %cmp26.26 = fcmp oge float %angle.0.26, 0.000000e+00
  %cmp29.26 = fcmp olt float %angle.0.26, 2.250000e+01
  %or.cond3.26 = and i1 %cmp26.26, %cmp29.26
  br i1 %or.cond3.26, label %if.then38.26, label %lor.lhs.false31.26

lor.lhs.false31.26:                               ; preds = %if.else.26
  %cmp33.26 = fcmp ult float %angle.0.26, 1.575000e+02
  %cmp36.26 = fcmp ugt float %angle.0.26, 1.800000e+02
  %or.cond4.26 = or i1 %cmp33.26, %cmp36.26
  br i1 %or.cond4.26, label %if.else49.26, label %if.then38.26

if.else49.26:                                     ; preds = %lor.lhs.false31.26
  %cmp51.26 = fcmp oge float %angle.0.26, 2.250000e+01
  %cmp55.26 = fcmp olt float %angle.0.26, 6.750000e+01
  %or.cond5.26 = and i1 %cmp51.26, %cmp55.26
  br i1 %or.cond5.26, label %if.then57.26, label %if.else70.26

if.else70.26:                                     ; preds = %if.else49.26
  %cmp72.26 = fcmp oge float %angle.0.26, 6.750000e+01
  %cmp76.26 = fcmp olt float %angle.0.26, 1.125000e+02
  %or.cond6.26 = and i1 %cmp72.26, %cmp76.26
  br i1 %or.cond6.26, label %if.then78.26, label %if.else89.26

if.else89.26:                                     ; preds = %if.else70.26
  %cmp91.26 = fcmp oge float %angle.0.26, 1.125000e+02
  %cmp95.26 = fcmp olt float %angle.0.26, 1.575000e+02
  %or.cond7.26 = and i1 %cmp91.26, %cmp95.26
  br i1 %or.cond7.26, label %if.then97.26, label %if.end113.26

if.then97.26:                                     ; preds = %if.else89.26
  %662 = trunc i64 %indvars.iv.26 to i32
  %sub100.26 = add i32 %662, %sub98.26
  %add101.26 = add i32 %sub100.26, -129
  %idxprom102.26 = sext i32 %add101.26 to i64
  %arrayidx103.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.26
  %663 = load float, float* %arrayidx103.26, align 4
  %add107.26 = add i32 %sub100.26, 129
  %idxprom108.26 = sext i32 %add107.26 to i64
  %arrayidx109.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.26
  %664 = load float, float* %arrayidx109.26, align 4
  br label %if.end113.26

if.then78.26:                                     ; preds = %if.else70.26
  %665 = add nsw i64 %659, %indvars.iv.26
  %arrayidx83.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %665
  %666 = load float, float* %arrayidx83.26, align 4
  %667 = add nsw i64 %658, %indvars.iv.26
  %arrayidx88.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %667
  %668 = load float, float* %arrayidx88.26, align 4
  br label %if.end113.26

if.then57.26:                                     ; preds = %if.else49.26
  %669 = trunc i64 %indvars.iv.26 to i32
  %sub60.26 = add i32 %669, %add58.26
  %add61.26 = add i32 %sub60.26, 127
  %idxprom62.26 = sext i32 %add61.26 to i64
  %arrayidx63.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.26
  %670 = load float, float* %arrayidx63.26, align 4
  %add67.26 = add i32 %sub60.26, -127
  %idxprom68.26 = sext i32 %add67.26 to i64
  %arrayidx69.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.26
  %671 = load float, float* %arrayidx69.26, align 4
  br label %if.end113.26

if.then38.26:                                     ; preds = %lor.lhs.false31.26, %if.else.26
  %672 = trunc i64 %indvars.iv.26 to i32
  %add41.26 = add i32 %add40.26, %672
  %idxprom42.26 = sext i32 %add41.26 to i64
  %arrayidx43.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.26
  %673 = load float, float* %arrayidx43.26, align 4
  %674 = trunc i64 %indvars.iv.26 to i32
  %add46.26 = add i32 %sub45.26, %674
  %idxprom47.26 = sext i32 %add46.26 to i64
  %arrayidx48.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.26
  %675 = load float, float* %arrayidx48.26, align 4
  br label %if.end113.26

if.end113.26:                                     ; preds = %if.then38.26, %if.then57.26, %if.then78.26, %if.then97.26, %if.else89.26
  %q.3.26 = phi float [ %673, %if.then38.26 ], [ %670, %if.then57.26 ], [ %666, %if.then78.26 ], [ %663, %if.then97.26 ], [ 2.550000e+02, %if.else89.26 ]
  %r.3.26 = phi float [ %675, %if.then38.26 ], [ %671, %if.then57.26 ], [ %668, %if.then78.26 ], [ %664, %if.then97.26 ], [ 2.550000e+02, %if.else89.26 ]
  %arrayidx115.26 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %660
  %676 = load float, float* %arrayidx115.26, align 4
  %cmp116.26 = fcmp ult float %676, %q.3.26
  %cmp121.26 = fcmp ult float %676, %r.3.26
  %or.cond8.26 = or i1 %cmp116.26, %cmp121.26
  br i1 %or.cond8.26, label %if.else129.26, label %if.then123.26

if.then123.26:                                    ; preds = %if.end113.26
  %conv126.26 = fptoui float %676 to i32
  %arrayidx128.26 = getelementptr inbounds i32, i32* %0, i64 %660
  store i32 %conv126.26, i32* %arrayidx128.26, align 4
  br label %for.inc.26

if.else129.26:                                    ; preds = %if.end113.26
  %arrayidx131.26 = getelementptr inbounds i32, i32* %0, i64 %660
  store i32 0, i32* %arrayidx131.26, align 4
  br label %for.inc.26

if.then.26:                                       ; preds = %for.body6.26
  %arrayidx.26 = getelementptr inbounds i32, i32* %0, i64 %660
  store i32 0, i32* %arrayidx.26, align 4
  br label %for.inc.26

for.inc.26:                                       ; preds = %if.then.26, %if.else129.26, %if.then123.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %lftr.wideiv.26 = trunc i64 %indvars.iv.next.26 to i32
  %exitcond.26 = icmp eq i32 %lftr.wideiv.26, %img_width
  br i1 %exitcond.26, label %for.inc134.26, label %for.body6.26, !llvm.loop !1

for.inc134.26:                                    ; preds = %for.inc.26
  %indvars.iv.next20.26 = add nsw i64 %indvars.iv19, 27
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.27

for.body6.lr.ph.27:                               ; preds = %for.inc134.26
  %677 = trunc i64 %indvars.iv.next20.26 to i32
  %mul.27 = shl nsw i32 %677, 7
  %cmp9.27 = icmp eq i64 %indvars.iv.next20.26, %2
  %add40.27 = or i32 %mul.27, 1
  %sub45.27 = add i32 %mul.27, -1
  %678 = trunc i64 %indvars.iv.next20.26 to i32
  %add58.27 = shl i32 %678, 7
  %679 = trunc i64 %indvars.iv.next20.26 to i32
  %add79.27 = shl i32 %679, 7
  %mul80.27 = add i32 %add79.27, 128
  %mul85.27 = add i32 %add79.27, -128
  %680 = trunc i64 %indvars.iv.next20.26 to i32
  %sub98.27 = shl i32 %680, 7
  %681 = sext i32 %mul.27 to i64
  %682 = sext i32 %mul85.27 to i64
  %683 = sext i32 %mul80.27 to i64
  br label %for.body6.27

for.body6.27:                                     ; preds = %for.inc.27, %for.body6.lr.ph.27
  %indvars.iv.27 = phi i64 [ 0, %for.body6.lr.ph.27 ], [ %indvars.iv.next.27, %for.inc.27 ]
  %684 = add nsw i64 %indvars.iv.27, %681
  %cmp12.27 = icmp eq i64 %indvars.iv.27, 0
  %or.cond1.27 = or i1 %cmp9.27, %cmp12.27
  %cmp15.27 = icmp eq i64 %indvars.iv.27, %1
  %or.cond2.27 = or i1 %cmp15.27, %or.cond1.27
  br i1 %or.cond2.27, label %if.then.27, label %if.else.27

if.else.27:                                       ; preds = %for.body6.27
  %arrayidx18.27 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %684
  %685 = load float, float* %arrayidx18.27, align 4
  %conv19.27 = fpext float %685 to double
  %mul20.27 = fmul double %conv19.27, 0x404CA5DC1A63C1F8
  %conv21.27 = fptrunc double %mul20.27 to float
  %cmp22.27 = fcmp olt float %conv21.27, 0.000000e+00
  %add25.27 = fadd float %conv21.27, 1.800000e+02
  %angle.0.27 = select i1 %cmp22.27, float %add25.27, float %conv21.27
  %cmp26.27 = fcmp oge float %angle.0.27, 0.000000e+00
  %cmp29.27 = fcmp olt float %angle.0.27, 2.250000e+01
  %or.cond3.27 = and i1 %cmp26.27, %cmp29.27
  br i1 %or.cond3.27, label %if.then38.27, label %lor.lhs.false31.27

lor.lhs.false31.27:                               ; preds = %if.else.27
  %cmp33.27 = fcmp ult float %angle.0.27, 1.575000e+02
  %cmp36.27 = fcmp ugt float %angle.0.27, 1.800000e+02
  %or.cond4.27 = or i1 %cmp33.27, %cmp36.27
  br i1 %or.cond4.27, label %if.else49.27, label %if.then38.27

if.else49.27:                                     ; preds = %lor.lhs.false31.27
  %cmp51.27 = fcmp oge float %angle.0.27, 2.250000e+01
  %cmp55.27 = fcmp olt float %angle.0.27, 6.750000e+01
  %or.cond5.27 = and i1 %cmp51.27, %cmp55.27
  br i1 %or.cond5.27, label %if.then57.27, label %if.else70.27

if.else70.27:                                     ; preds = %if.else49.27
  %cmp72.27 = fcmp oge float %angle.0.27, 6.750000e+01
  %cmp76.27 = fcmp olt float %angle.0.27, 1.125000e+02
  %or.cond6.27 = and i1 %cmp72.27, %cmp76.27
  br i1 %or.cond6.27, label %if.then78.27, label %if.else89.27

if.else89.27:                                     ; preds = %if.else70.27
  %cmp91.27 = fcmp oge float %angle.0.27, 1.125000e+02
  %cmp95.27 = fcmp olt float %angle.0.27, 1.575000e+02
  %or.cond7.27 = and i1 %cmp91.27, %cmp95.27
  br i1 %or.cond7.27, label %if.then97.27, label %if.end113.27

if.then97.27:                                     ; preds = %if.else89.27
  %686 = trunc i64 %indvars.iv.27 to i32
  %sub100.27 = add i32 %686, %sub98.27
  %add101.27 = add i32 %sub100.27, -129
  %idxprom102.27 = sext i32 %add101.27 to i64
  %arrayidx103.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.27
  %687 = load float, float* %arrayidx103.27, align 4
  %add107.27 = add i32 %sub100.27, 129
  %idxprom108.27 = sext i32 %add107.27 to i64
  %arrayidx109.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.27
  %688 = load float, float* %arrayidx109.27, align 4
  br label %if.end113.27

if.then78.27:                                     ; preds = %if.else70.27
  %689 = add nsw i64 %683, %indvars.iv.27
  %arrayidx83.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %689
  %690 = load float, float* %arrayidx83.27, align 4
  %691 = add nsw i64 %682, %indvars.iv.27
  %arrayidx88.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %691
  %692 = load float, float* %arrayidx88.27, align 4
  br label %if.end113.27

if.then57.27:                                     ; preds = %if.else49.27
  %693 = trunc i64 %indvars.iv.27 to i32
  %sub60.27 = add i32 %693, %add58.27
  %add61.27 = add i32 %sub60.27, 127
  %idxprom62.27 = sext i32 %add61.27 to i64
  %arrayidx63.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.27
  %694 = load float, float* %arrayidx63.27, align 4
  %add67.27 = add i32 %sub60.27, -127
  %idxprom68.27 = sext i32 %add67.27 to i64
  %arrayidx69.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.27
  %695 = load float, float* %arrayidx69.27, align 4
  br label %if.end113.27

if.then38.27:                                     ; preds = %lor.lhs.false31.27, %if.else.27
  %696 = trunc i64 %indvars.iv.27 to i32
  %add41.27 = add i32 %add40.27, %696
  %idxprom42.27 = sext i32 %add41.27 to i64
  %arrayidx43.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.27
  %697 = load float, float* %arrayidx43.27, align 4
  %698 = trunc i64 %indvars.iv.27 to i32
  %add46.27 = add i32 %sub45.27, %698
  %idxprom47.27 = sext i32 %add46.27 to i64
  %arrayidx48.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.27
  %699 = load float, float* %arrayidx48.27, align 4
  br label %if.end113.27

if.end113.27:                                     ; preds = %if.then38.27, %if.then57.27, %if.then78.27, %if.then97.27, %if.else89.27
  %q.3.27 = phi float [ %697, %if.then38.27 ], [ %694, %if.then57.27 ], [ %690, %if.then78.27 ], [ %687, %if.then97.27 ], [ 2.550000e+02, %if.else89.27 ]
  %r.3.27 = phi float [ %699, %if.then38.27 ], [ %695, %if.then57.27 ], [ %692, %if.then78.27 ], [ %688, %if.then97.27 ], [ 2.550000e+02, %if.else89.27 ]
  %arrayidx115.27 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %684
  %700 = load float, float* %arrayidx115.27, align 4
  %cmp116.27 = fcmp ult float %700, %q.3.27
  %cmp121.27 = fcmp ult float %700, %r.3.27
  %or.cond8.27 = or i1 %cmp116.27, %cmp121.27
  br i1 %or.cond8.27, label %if.else129.27, label %if.then123.27

if.then123.27:                                    ; preds = %if.end113.27
  %conv126.27 = fptoui float %700 to i32
  %arrayidx128.27 = getelementptr inbounds i32, i32* %0, i64 %684
  store i32 %conv126.27, i32* %arrayidx128.27, align 4
  br label %for.inc.27

if.else129.27:                                    ; preds = %if.end113.27
  %arrayidx131.27 = getelementptr inbounds i32, i32* %0, i64 %684
  store i32 0, i32* %arrayidx131.27, align 4
  br label %for.inc.27

if.then.27:                                       ; preds = %for.body6.27
  %arrayidx.27 = getelementptr inbounds i32, i32* %0, i64 %684
  store i32 0, i32* %arrayidx.27, align 4
  br label %for.inc.27

for.inc.27:                                       ; preds = %if.then.27, %if.else129.27, %if.then123.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %lftr.wideiv.27 = trunc i64 %indvars.iv.next.27 to i32
  %exitcond.27 = icmp eq i32 %lftr.wideiv.27, %img_width
  br i1 %exitcond.27, label %for.inc134.27, label %for.body6.27, !llvm.loop !1

for.inc134.27:                                    ; preds = %for.inc.27
  %indvars.iv.next20.27 = add nsw i64 %indvars.iv19, 28
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.28

for.body6.lr.ph.28:                               ; preds = %for.inc134.27
  %701 = trunc i64 %indvars.iv.next20.27 to i32
  %mul.28 = shl nsw i32 %701, 7
  %cmp9.28 = icmp eq i64 %indvars.iv.next20.27, %2
  %add40.28 = or i32 %mul.28, 1
  %sub45.28 = add i32 %mul.28, -1
  %702 = trunc i64 %indvars.iv.next20.27 to i32
  %add58.28 = shl i32 %702, 7
  %703 = trunc i64 %indvars.iv.next20.27 to i32
  %add79.28 = shl i32 %703, 7
  %mul80.28 = add i32 %add79.28, 128
  %mul85.28 = add i32 %add79.28, -128
  %704 = trunc i64 %indvars.iv.next20.27 to i32
  %sub98.28 = shl i32 %704, 7
  %705 = sext i32 %mul.28 to i64
  %706 = sext i32 %mul85.28 to i64
  %707 = sext i32 %mul80.28 to i64
  br label %for.body6.28

for.body6.28:                                     ; preds = %for.inc.28, %for.body6.lr.ph.28
  %indvars.iv.28 = phi i64 [ 0, %for.body6.lr.ph.28 ], [ %indvars.iv.next.28, %for.inc.28 ]
  %708 = add nsw i64 %indvars.iv.28, %705
  %cmp12.28 = icmp eq i64 %indvars.iv.28, 0
  %or.cond1.28 = or i1 %cmp9.28, %cmp12.28
  %cmp15.28 = icmp eq i64 %indvars.iv.28, %1
  %or.cond2.28 = or i1 %cmp15.28, %or.cond1.28
  br i1 %or.cond2.28, label %if.then.28, label %if.else.28

if.else.28:                                       ; preds = %for.body6.28
  %arrayidx18.28 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %708
  %709 = load float, float* %arrayidx18.28, align 4
  %conv19.28 = fpext float %709 to double
  %mul20.28 = fmul double %conv19.28, 0x404CA5DC1A63C1F8
  %conv21.28 = fptrunc double %mul20.28 to float
  %cmp22.28 = fcmp olt float %conv21.28, 0.000000e+00
  %add25.28 = fadd float %conv21.28, 1.800000e+02
  %angle.0.28 = select i1 %cmp22.28, float %add25.28, float %conv21.28
  %cmp26.28 = fcmp oge float %angle.0.28, 0.000000e+00
  %cmp29.28 = fcmp olt float %angle.0.28, 2.250000e+01
  %or.cond3.28 = and i1 %cmp26.28, %cmp29.28
  br i1 %or.cond3.28, label %if.then38.28, label %lor.lhs.false31.28

lor.lhs.false31.28:                               ; preds = %if.else.28
  %cmp33.28 = fcmp ult float %angle.0.28, 1.575000e+02
  %cmp36.28 = fcmp ugt float %angle.0.28, 1.800000e+02
  %or.cond4.28 = or i1 %cmp33.28, %cmp36.28
  br i1 %or.cond4.28, label %if.else49.28, label %if.then38.28

if.else49.28:                                     ; preds = %lor.lhs.false31.28
  %cmp51.28 = fcmp oge float %angle.0.28, 2.250000e+01
  %cmp55.28 = fcmp olt float %angle.0.28, 6.750000e+01
  %or.cond5.28 = and i1 %cmp51.28, %cmp55.28
  br i1 %or.cond5.28, label %if.then57.28, label %if.else70.28

if.else70.28:                                     ; preds = %if.else49.28
  %cmp72.28 = fcmp oge float %angle.0.28, 6.750000e+01
  %cmp76.28 = fcmp olt float %angle.0.28, 1.125000e+02
  %or.cond6.28 = and i1 %cmp72.28, %cmp76.28
  br i1 %or.cond6.28, label %if.then78.28, label %if.else89.28

if.else89.28:                                     ; preds = %if.else70.28
  %cmp91.28 = fcmp oge float %angle.0.28, 1.125000e+02
  %cmp95.28 = fcmp olt float %angle.0.28, 1.575000e+02
  %or.cond7.28 = and i1 %cmp91.28, %cmp95.28
  br i1 %or.cond7.28, label %if.then97.28, label %if.end113.28

if.then97.28:                                     ; preds = %if.else89.28
  %710 = trunc i64 %indvars.iv.28 to i32
  %sub100.28 = add i32 %710, %sub98.28
  %add101.28 = add i32 %sub100.28, -129
  %idxprom102.28 = sext i32 %add101.28 to i64
  %arrayidx103.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.28
  %711 = load float, float* %arrayidx103.28, align 4
  %add107.28 = add i32 %sub100.28, 129
  %idxprom108.28 = sext i32 %add107.28 to i64
  %arrayidx109.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.28
  %712 = load float, float* %arrayidx109.28, align 4
  br label %if.end113.28

if.then78.28:                                     ; preds = %if.else70.28
  %713 = add nsw i64 %707, %indvars.iv.28
  %arrayidx83.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %713
  %714 = load float, float* %arrayidx83.28, align 4
  %715 = add nsw i64 %706, %indvars.iv.28
  %arrayidx88.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %715
  %716 = load float, float* %arrayidx88.28, align 4
  br label %if.end113.28

if.then57.28:                                     ; preds = %if.else49.28
  %717 = trunc i64 %indvars.iv.28 to i32
  %sub60.28 = add i32 %717, %add58.28
  %add61.28 = add i32 %sub60.28, 127
  %idxprom62.28 = sext i32 %add61.28 to i64
  %arrayidx63.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.28
  %718 = load float, float* %arrayidx63.28, align 4
  %add67.28 = add i32 %sub60.28, -127
  %idxprom68.28 = sext i32 %add67.28 to i64
  %arrayidx69.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.28
  %719 = load float, float* %arrayidx69.28, align 4
  br label %if.end113.28

if.then38.28:                                     ; preds = %lor.lhs.false31.28, %if.else.28
  %720 = trunc i64 %indvars.iv.28 to i32
  %add41.28 = add i32 %add40.28, %720
  %idxprom42.28 = sext i32 %add41.28 to i64
  %arrayidx43.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.28
  %721 = load float, float* %arrayidx43.28, align 4
  %722 = trunc i64 %indvars.iv.28 to i32
  %add46.28 = add i32 %sub45.28, %722
  %idxprom47.28 = sext i32 %add46.28 to i64
  %arrayidx48.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.28
  %723 = load float, float* %arrayidx48.28, align 4
  br label %if.end113.28

if.end113.28:                                     ; preds = %if.then38.28, %if.then57.28, %if.then78.28, %if.then97.28, %if.else89.28
  %q.3.28 = phi float [ %721, %if.then38.28 ], [ %718, %if.then57.28 ], [ %714, %if.then78.28 ], [ %711, %if.then97.28 ], [ 2.550000e+02, %if.else89.28 ]
  %r.3.28 = phi float [ %723, %if.then38.28 ], [ %719, %if.then57.28 ], [ %716, %if.then78.28 ], [ %712, %if.then97.28 ], [ 2.550000e+02, %if.else89.28 ]
  %arrayidx115.28 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %708
  %724 = load float, float* %arrayidx115.28, align 4
  %cmp116.28 = fcmp ult float %724, %q.3.28
  %cmp121.28 = fcmp ult float %724, %r.3.28
  %or.cond8.28 = or i1 %cmp116.28, %cmp121.28
  br i1 %or.cond8.28, label %if.else129.28, label %if.then123.28

if.then123.28:                                    ; preds = %if.end113.28
  %conv126.28 = fptoui float %724 to i32
  %arrayidx128.28 = getelementptr inbounds i32, i32* %0, i64 %708
  store i32 %conv126.28, i32* %arrayidx128.28, align 4
  br label %for.inc.28

if.else129.28:                                    ; preds = %if.end113.28
  %arrayidx131.28 = getelementptr inbounds i32, i32* %0, i64 %708
  store i32 0, i32* %arrayidx131.28, align 4
  br label %for.inc.28

if.then.28:                                       ; preds = %for.body6.28
  %arrayidx.28 = getelementptr inbounds i32, i32* %0, i64 %708
  store i32 0, i32* %arrayidx.28, align 4
  br label %for.inc.28

for.inc.28:                                       ; preds = %if.then.28, %if.else129.28, %if.then123.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %lftr.wideiv.28 = trunc i64 %indvars.iv.next.28 to i32
  %exitcond.28 = icmp eq i32 %lftr.wideiv.28, %img_width
  br i1 %exitcond.28, label %for.inc134.28, label %for.body6.28, !llvm.loop !1

for.inc134.28:                                    ; preds = %for.inc.28
  %indvars.iv.next20.28 = add nsw i64 %indvars.iv19, 29
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.29

for.body6.lr.ph.29:                               ; preds = %for.inc134.28
  %725 = trunc i64 %indvars.iv.next20.28 to i32
  %mul.29 = shl nsw i32 %725, 7
  %cmp9.29 = icmp eq i64 %indvars.iv.next20.28, %2
  %add40.29 = or i32 %mul.29, 1
  %sub45.29 = add i32 %mul.29, -1
  %726 = trunc i64 %indvars.iv.next20.28 to i32
  %add58.29 = shl i32 %726, 7
  %727 = trunc i64 %indvars.iv.next20.28 to i32
  %add79.29 = shl i32 %727, 7
  %mul80.29 = add i32 %add79.29, 128
  %mul85.29 = add i32 %add79.29, -128
  %728 = trunc i64 %indvars.iv.next20.28 to i32
  %sub98.29 = shl i32 %728, 7
  %729 = sext i32 %mul.29 to i64
  %730 = sext i32 %mul85.29 to i64
  %731 = sext i32 %mul80.29 to i64
  br label %for.body6.29

for.body6.29:                                     ; preds = %for.inc.29, %for.body6.lr.ph.29
  %indvars.iv.29 = phi i64 [ 0, %for.body6.lr.ph.29 ], [ %indvars.iv.next.29, %for.inc.29 ]
  %732 = add nsw i64 %indvars.iv.29, %729
  %cmp12.29 = icmp eq i64 %indvars.iv.29, 0
  %or.cond1.29 = or i1 %cmp9.29, %cmp12.29
  %cmp15.29 = icmp eq i64 %indvars.iv.29, %1
  %or.cond2.29 = or i1 %cmp15.29, %or.cond1.29
  br i1 %or.cond2.29, label %if.then.29, label %if.else.29

if.else.29:                                       ; preds = %for.body6.29
  %arrayidx18.29 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %732
  %733 = load float, float* %arrayidx18.29, align 4
  %conv19.29 = fpext float %733 to double
  %mul20.29 = fmul double %conv19.29, 0x404CA5DC1A63C1F8
  %conv21.29 = fptrunc double %mul20.29 to float
  %cmp22.29 = fcmp olt float %conv21.29, 0.000000e+00
  %add25.29 = fadd float %conv21.29, 1.800000e+02
  %angle.0.29 = select i1 %cmp22.29, float %add25.29, float %conv21.29
  %cmp26.29 = fcmp oge float %angle.0.29, 0.000000e+00
  %cmp29.29 = fcmp olt float %angle.0.29, 2.250000e+01
  %or.cond3.29 = and i1 %cmp26.29, %cmp29.29
  br i1 %or.cond3.29, label %if.then38.29, label %lor.lhs.false31.29

lor.lhs.false31.29:                               ; preds = %if.else.29
  %cmp33.29 = fcmp ult float %angle.0.29, 1.575000e+02
  %cmp36.29 = fcmp ugt float %angle.0.29, 1.800000e+02
  %or.cond4.29 = or i1 %cmp33.29, %cmp36.29
  br i1 %or.cond4.29, label %if.else49.29, label %if.then38.29

if.else49.29:                                     ; preds = %lor.lhs.false31.29
  %cmp51.29 = fcmp oge float %angle.0.29, 2.250000e+01
  %cmp55.29 = fcmp olt float %angle.0.29, 6.750000e+01
  %or.cond5.29 = and i1 %cmp51.29, %cmp55.29
  br i1 %or.cond5.29, label %if.then57.29, label %if.else70.29

if.else70.29:                                     ; preds = %if.else49.29
  %cmp72.29 = fcmp oge float %angle.0.29, 6.750000e+01
  %cmp76.29 = fcmp olt float %angle.0.29, 1.125000e+02
  %or.cond6.29 = and i1 %cmp72.29, %cmp76.29
  br i1 %or.cond6.29, label %if.then78.29, label %if.else89.29

if.else89.29:                                     ; preds = %if.else70.29
  %cmp91.29 = fcmp oge float %angle.0.29, 1.125000e+02
  %cmp95.29 = fcmp olt float %angle.0.29, 1.575000e+02
  %or.cond7.29 = and i1 %cmp91.29, %cmp95.29
  br i1 %or.cond7.29, label %if.then97.29, label %if.end113.29

if.then97.29:                                     ; preds = %if.else89.29
  %734 = trunc i64 %indvars.iv.29 to i32
  %sub100.29 = add i32 %734, %sub98.29
  %add101.29 = add i32 %sub100.29, -129
  %idxprom102.29 = sext i32 %add101.29 to i64
  %arrayidx103.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.29
  %735 = load float, float* %arrayidx103.29, align 4
  %add107.29 = add i32 %sub100.29, 129
  %idxprom108.29 = sext i32 %add107.29 to i64
  %arrayidx109.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.29
  %736 = load float, float* %arrayidx109.29, align 4
  br label %if.end113.29

if.then78.29:                                     ; preds = %if.else70.29
  %737 = add nsw i64 %731, %indvars.iv.29
  %arrayidx83.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %737
  %738 = load float, float* %arrayidx83.29, align 4
  %739 = add nsw i64 %730, %indvars.iv.29
  %arrayidx88.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %739
  %740 = load float, float* %arrayidx88.29, align 4
  br label %if.end113.29

if.then57.29:                                     ; preds = %if.else49.29
  %741 = trunc i64 %indvars.iv.29 to i32
  %sub60.29 = add i32 %741, %add58.29
  %add61.29 = add i32 %sub60.29, 127
  %idxprom62.29 = sext i32 %add61.29 to i64
  %arrayidx63.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.29
  %742 = load float, float* %arrayidx63.29, align 4
  %add67.29 = add i32 %sub60.29, -127
  %idxprom68.29 = sext i32 %add67.29 to i64
  %arrayidx69.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.29
  %743 = load float, float* %arrayidx69.29, align 4
  br label %if.end113.29

if.then38.29:                                     ; preds = %lor.lhs.false31.29, %if.else.29
  %744 = trunc i64 %indvars.iv.29 to i32
  %add41.29 = add i32 %add40.29, %744
  %idxprom42.29 = sext i32 %add41.29 to i64
  %arrayidx43.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.29
  %745 = load float, float* %arrayidx43.29, align 4
  %746 = trunc i64 %indvars.iv.29 to i32
  %add46.29 = add i32 %sub45.29, %746
  %idxprom47.29 = sext i32 %add46.29 to i64
  %arrayidx48.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.29
  %747 = load float, float* %arrayidx48.29, align 4
  br label %if.end113.29

if.end113.29:                                     ; preds = %if.then38.29, %if.then57.29, %if.then78.29, %if.then97.29, %if.else89.29
  %q.3.29 = phi float [ %745, %if.then38.29 ], [ %742, %if.then57.29 ], [ %738, %if.then78.29 ], [ %735, %if.then97.29 ], [ 2.550000e+02, %if.else89.29 ]
  %r.3.29 = phi float [ %747, %if.then38.29 ], [ %743, %if.then57.29 ], [ %740, %if.then78.29 ], [ %736, %if.then97.29 ], [ 2.550000e+02, %if.else89.29 ]
  %arrayidx115.29 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %732
  %748 = load float, float* %arrayidx115.29, align 4
  %cmp116.29 = fcmp ult float %748, %q.3.29
  %cmp121.29 = fcmp ult float %748, %r.3.29
  %or.cond8.29 = or i1 %cmp116.29, %cmp121.29
  br i1 %or.cond8.29, label %if.else129.29, label %if.then123.29

if.then123.29:                                    ; preds = %if.end113.29
  %conv126.29 = fptoui float %748 to i32
  %arrayidx128.29 = getelementptr inbounds i32, i32* %0, i64 %732
  store i32 %conv126.29, i32* %arrayidx128.29, align 4
  br label %for.inc.29

if.else129.29:                                    ; preds = %if.end113.29
  %arrayidx131.29 = getelementptr inbounds i32, i32* %0, i64 %732
  store i32 0, i32* %arrayidx131.29, align 4
  br label %for.inc.29

if.then.29:                                       ; preds = %for.body6.29
  %arrayidx.29 = getelementptr inbounds i32, i32* %0, i64 %732
  store i32 0, i32* %arrayidx.29, align 4
  br label %for.inc.29

for.inc.29:                                       ; preds = %if.then.29, %if.else129.29, %if.then123.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %lftr.wideiv.29 = trunc i64 %indvars.iv.next.29 to i32
  %exitcond.29 = icmp eq i32 %lftr.wideiv.29, %img_width
  br i1 %exitcond.29, label %for.inc134.29, label %for.body6.29, !llvm.loop !1

for.inc134.29:                                    ; preds = %for.inc.29
  %indvars.iv.next20.29 = add nsw i64 %indvars.iv19, 30
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.30

for.body6.lr.ph.30:                               ; preds = %for.inc134.29
  %749 = trunc i64 %indvars.iv.next20.29 to i32
  %mul.30 = shl nsw i32 %749, 7
  %cmp9.30 = icmp eq i64 %indvars.iv.next20.29, %2
  %add40.30 = or i32 %mul.30, 1
  %sub45.30 = add i32 %mul.30, -1
  %750 = trunc i64 %indvars.iv.next20.29 to i32
  %add58.30 = shl i32 %750, 7
  %751 = trunc i64 %indvars.iv.next20.29 to i32
  %add79.30 = shl i32 %751, 7
  %mul80.30 = add i32 %add79.30, 128
  %mul85.30 = add i32 %add79.30, -128
  %752 = trunc i64 %indvars.iv.next20.29 to i32
  %sub98.30 = shl i32 %752, 7
  %753 = sext i32 %mul.30 to i64
  %754 = sext i32 %mul85.30 to i64
  %755 = sext i32 %mul80.30 to i64
  br label %for.body6.30

for.body6.30:                                     ; preds = %for.inc.30, %for.body6.lr.ph.30
  %indvars.iv.30 = phi i64 [ 0, %for.body6.lr.ph.30 ], [ %indvars.iv.next.30, %for.inc.30 ]
  %756 = add nsw i64 %indvars.iv.30, %753
  %cmp12.30 = icmp eq i64 %indvars.iv.30, 0
  %or.cond1.30 = or i1 %cmp9.30, %cmp12.30
  %cmp15.30 = icmp eq i64 %indvars.iv.30, %1
  %or.cond2.30 = or i1 %cmp15.30, %or.cond1.30
  br i1 %or.cond2.30, label %if.then.30, label %if.else.30

if.else.30:                                       ; preds = %for.body6.30
  %arrayidx18.30 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %756
  %757 = load float, float* %arrayidx18.30, align 4
  %conv19.30 = fpext float %757 to double
  %mul20.30 = fmul double %conv19.30, 0x404CA5DC1A63C1F8
  %conv21.30 = fptrunc double %mul20.30 to float
  %cmp22.30 = fcmp olt float %conv21.30, 0.000000e+00
  %add25.30 = fadd float %conv21.30, 1.800000e+02
  %angle.0.30 = select i1 %cmp22.30, float %add25.30, float %conv21.30
  %cmp26.30 = fcmp oge float %angle.0.30, 0.000000e+00
  %cmp29.30 = fcmp olt float %angle.0.30, 2.250000e+01
  %or.cond3.30 = and i1 %cmp26.30, %cmp29.30
  br i1 %or.cond3.30, label %if.then38.30, label %lor.lhs.false31.30

lor.lhs.false31.30:                               ; preds = %if.else.30
  %cmp33.30 = fcmp ult float %angle.0.30, 1.575000e+02
  %cmp36.30 = fcmp ugt float %angle.0.30, 1.800000e+02
  %or.cond4.30 = or i1 %cmp33.30, %cmp36.30
  br i1 %or.cond4.30, label %if.else49.30, label %if.then38.30

if.else49.30:                                     ; preds = %lor.lhs.false31.30
  %cmp51.30 = fcmp oge float %angle.0.30, 2.250000e+01
  %cmp55.30 = fcmp olt float %angle.0.30, 6.750000e+01
  %or.cond5.30 = and i1 %cmp51.30, %cmp55.30
  br i1 %or.cond5.30, label %if.then57.30, label %if.else70.30

if.else70.30:                                     ; preds = %if.else49.30
  %cmp72.30 = fcmp oge float %angle.0.30, 6.750000e+01
  %cmp76.30 = fcmp olt float %angle.0.30, 1.125000e+02
  %or.cond6.30 = and i1 %cmp72.30, %cmp76.30
  br i1 %or.cond6.30, label %if.then78.30, label %if.else89.30

if.else89.30:                                     ; preds = %if.else70.30
  %cmp91.30 = fcmp oge float %angle.0.30, 1.125000e+02
  %cmp95.30 = fcmp olt float %angle.0.30, 1.575000e+02
  %or.cond7.30 = and i1 %cmp91.30, %cmp95.30
  br i1 %or.cond7.30, label %if.then97.30, label %if.end113.30

if.then97.30:                                     ; preds = %if.else89.30
  %758 = trunc i64 %indvars.iv.30 to i32
  %sub100.30 = add i32 %758, %sub98.30
  %add101.30 = add i32 %sub100.30, -129
  %idxprom102.30 = sext i32 %add101.30 to i64
  %arrayidx103.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.30
  %759 = load float, float* %arrayidx103.30, align 4
  %add107.30 = add i32 %sub100.30, 129
  %idxprom108.30 = sext i32 %add107.30 to i64
  %arrayidx109.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.30
  %760 = load float, float* %arrayidx109.30, align 4
  br label %if.end113.30

if.then78.30:                                     ; preds = %if.else70.30
  %761 = add nsw i64 %755, %indvars.iv.30
  %arrayidx83.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %761
  %762 = load float, float* %arrayidx83.30, align 4
  %763 = add nsw i64 %754, %indvars.iv.30
  %arrayidx88.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %763
  %764 = load float, float* %arrayidx88.30, align 4
  br label %if.end113.30

if.then57.30:                                     ; preds = %if.else49.30
  %765 = trunc i64 %indvars.iv.30 to i32
  %sub60.30 = add i32 %765, %add58.30
  %add61.30 = add i32 %sub60.30, 127
  %idxprom62.30 = sext i32 %add61.30 to i64
  %arrayidx63.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.30
  %766 = load float, float* %arrayidx63.30, align 4
  %add67.30 = add i32 %sub60.30, -127
  %idxprom68.30 = sext i32 %add67.30 to i64
  %arrayidx69.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.30
  %767 = load float, float* %arrayidx69.30, align 4
  br label %if.end113.30

if.then38.30:                                     ; preds = %lor.lhs.false31.30, %if.else.30
  %768 = trunc i64 %indvars.iv.30 to i32
  %add41.30 = add i32 %add40.30, %768
  %idxprom42.30 = sext i32 %add41.30 to i64
  %arrayidx43.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.30
  %769 = load float, float* %arrayidx43.30, align 4
  %770 = trunc i64 %indvars.iv.30 to i32
  %add46.30 = add i32 %sub45.30, %770
  %idxprom47.30 = sext i32 %add46.30 to i64
  %arrayidx48.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.30
  %771 = load float, float* %arrayidx48.30, align 4
  br label %if.end113.30

if.end113.30:                                     ; preds = %if.then38.30, %if.then57.30, %if.then78.30, %if.then97.30, %if.else89.30
  %q.3.30 = phi float [ %769, %if.then38.30 ], [ %766, %if.then57.30 ], [ %762, %if.then78.30 ], [ %759, %if.then97.30 ], [ 2.550000e+02, %if.else89.30 ]
  %r.3.30 = phi float [ %771, %if.then38.30 ], [ %767, %if.then57.30 ], [ %764, %if.then78.30 ], [ %760, %if.then97.30 ], [ 2.550000e+02, %if.else89.30 ]
  %arrayidx115.30 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %756
  %772 = load float, float* %arrayidx115.30, align 4
  %cmp116.30 = fcmp ult float %772, %q.3.30
  %cmp121.30 = fcmp ult float %772, %r.3.30
  %or.cond8.30 = or i1 %cmp116.30, %cmp121.30
  br i1 %or.cond8.30, label %if.else129.30, label %if.then123.30

if.then123.30:                                    ; preds = %if.end113.30
  %conv126.30 = fptoui float %772 to i32
  %arrayidx128.30 = getelementptr inbounds i32, i32* %0, i64 %756
  store i32 %conv126.30, i32* %arrayidx128.30, align 4
  br label %for.inc.30

if.else129.30:                                    ; preds = %if.end113.30
  %arrayidx131.30 = getelementptr inbounds i32, i32* %0, i64 %756
  store i32 0, i32* %arrayidx131.30, align 4
  br label %for.inc.30

if.then.30:                                       ; preds = %for.body6.30
  %arrayidx.30 = getelementptr inbounds i32, i32* %0, i64 %756
  store i32 0, i32* %arrayidx.30, align 4
  br label %for.inc.30

for.inc.30:                                       ; preds = %if.then.30, %if.else129.30, %if.then123.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %lftr.wideiv.30 = trunc i64 %indvars.iv.next.30 to i32
  %exitcond.30 = icmp eq i32 %lftr.wideiv.30, %img_width
  br i1 %exitcond.30, label %for.inc134.30, label %for.body6.30, !llvm.loop !1

for.inc134.30:                                    ; preds = %for.inc.30
  %indvars.iv.next20.30 = add nsw i64 %indvars.iv19, 31
  br i1 %cmp49, label %for.inc134.31, label %for.body6.lr.ph.31

for.body6.lr.ph.31:                               ; preds = %for.inc134.30
  %773 = trunc i64 %indvars.iv.next20.30 to i32
  %mul.31 = shl nsw i32 %773, 7
  %cmp9.31 = icmp eq i64 %indvars.iv.next20.30, %2
  %add40.31 = or i32 %mul.31, 1
  %sub45.31 = add i32 %mul.31, -1
  %774 = trunc i64 %indvars.iv.next20.30 to i32
  %add58.31 = shl i32 %774, 7
  %775 = trunc i64 %indvars.iv.next20.30 to i32
  %add79.31 = shl i32 %775, 7
  %mul80.31 = add i32 %add79.31, 128
  %mul85.31 = add i32 %add79.31, -128
  %776 = trunc i64 %indvars.iv.next20.30 to i32
  %sub98.31 = shl i32 %776, 7
  %777 = sext i32 %mul.31 to i64
  %778 = sext i32 %mul85.31 to i64
  %779 = sext i32 %mul80.31 to i64
  br label %for.body6.31

for.body6.31:                                     ; preds = %for.inc.31, %for.body6.lr.ph.31
  %indvars.iv.31 = phi i64 [ 0, %for.body6.lr.ph.31 ], [ %indvars.iv.next.31, %for.inc.31 ]
  %780 = add nsw i64 %indvars.iv.31, %777
  %cmp12.31 = icmp eq i64 %indvars.iv.31, 0
  %or.cond1.31 = or i1 %cmp9.31, %cmp12.31
  %cmp15.31 = icmp eq i64 %indvars.iv.31, %1
  %or.cond2.31 = or i1 %cmp15.31, %or.cond1.31
  br i1 %or.cond2.31, label %if.then.31, label %if.else.31

if.else.31:                                       ; preds = %for.body6.31
  %arrayidx18.31 = getelementptr inbounds float, float* inttoptr (i64 553713696 to float*), i64 %780
  %781 = load float, float* %arrayidx18.31, align 4
  %conv19.31 = fpext float %781 to double
  %mul20.31 = fmul double %conv19.31, 0x404CA5DC1A63C1F8
  %conv21.31 = fptrunc double %mul20.31 to float
  %cmp22.31 = fcmp olt float %conv21.31, 0.000000e+00
  %add25.31 = fadd float %conv21.31, 1.800000e+02
  %angle.0.31 = select i1 %cmp22.31, float %add25.31, float %conv21.31
  %cmp26.31 = fcmp oge float %angle.0.31, 0.000000e+00
  %cmp29.31 = fcmp olt float %angle.0.31, 2.250000e+01
  %or.cond3.31 = and i1 %cmp26.31, %cmp29.31
  br i1 %or.cond3.31, label %if.then38.31, label %lor.lhs.false31.31

lor.lhs.false31.31:                               ; preds = %if.else.31
  %cmp33.31 = fcmp ult float %angle.0.31, 1.575000e+02
  %cmp36.31 = fcmp ugt float %angle.0.31, 1.800000e+02
  %or.cond4.31 = or i1 %cmp33.31, %cmp36.31
  br i1 %or.cond4.31, label %if.else49.31, label %if.then38.31

if.else49.31:                                     ; preds = %lor.lhs.false31.31
  %cmp51.31 = fcmp oge float %angle.0.31, 2.250000e+01
  %cmp55.31 = fcmp olt float %angle.0.31, 6.750000e+01
  %or.cond5.31 = and i1 %cmp51.31, %cmp55.31
  br i1 %or.cond5.31, label %if.then57.31, label %if.else70.31

if.else70.31:                                     ; preds = %if.else49.31
  %cmp72.31 = fcmp oge float %angle.0.31, 6.750000e+01
  %cmp76.31 = fcmp olt float %angle.0.31, 1.125000e+02
  %or.cond6.31 = and i1 %cmp72.31, %cmp76.31
  br i1 %or.cond6.31, label %if.then78.31, label %if.else89.31

if.else89.31:                                     ; preds = %if.else70.31
  %cmp91.31 = fcmp oge float %angle.0.31, 1.125000e+02
  %cmp95.31 = fcmp olt float %angle.0.31, 1.575000e+02
  %or.cond7.31 = and i1 %cmp91.31, %cmp95.31
  br i1 %or.cond7.31, label %if.then97.31, label %if.end113.31

if.then97.31:                                     ; preds = %if.else89.31
  %782 = trunc i64 %indvars.iv.31 to i32
  %sub100.31 = add i32 %782, %sub98.31
  %add101.31 = add i32 %sub100.31, -129
  %idxprom102.31 = sext i32 %add101.31 to i64
  %arrayidx103.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom102.31
  %783 = load float, float* %arrayidx103.31, align 4
  %add107.31 = add i32 %sub100.31, 129
  %idxprom108.31 = sext i32 %add107.31 to i64
  %arrayidx109.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom108.31
  %784 = load float, float* %arrayidx109.31, align 4
  br label %if.end113.31

if.then78.31:                                     ; preds = %if.else70.31
  %785 = add nsw i64 %779, %indvars.iv.31
  %arrayidx83.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %785
  %786 = load float, float* %arrayidx83.31, align 4
  %787 = add nsw i64 %778, %indvars.iv.31
  %arrayidx88.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %787
  %788 = load float, float* %arrayidx88.31, align 4
  br label %if.end113.31

if.then57.31:                                     ; preds = %if.else49.31
  %789 = trunc i64 %indvars.iv.31 to i32
  %sub60.31 = add i32 %789, %add58.31
  %add61.31 = add i32 %sub60.31, 127
  %idxprom62.31 = sext i32 %add61.31 to i64
  %arrayidx63.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom62.31
  %790 = load float, float* %arrayidx63.31, align 4
  %add67.31 = add i32 %sub60.31, -127
  %idxprom68.31 = sext i32 %add67.31 to i64
  %arrayidx69.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom68.31
  %791 = load float, float* %arrayidx69.31, align 4
  br label %if.end113.31

if.then38.31:                                     ; preds = %lor.lhs.false31.31, %if.else.31
  %792 = trunc i64 %indvars.iv.31 to i32
  %add41.31 = add i32 %add40.31, %792
  %idxprom42.31 = sext i32 %add41.31 to i64
  %arrayidx43.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom42.31
  %793 = load float, float* %arrayidx43.31, align 4
  %794 = trunc i64 %indvars.iv.31 to i32
  %add46.31 = add i32 %sub45.31, %794
  %idxprom47.31 = sext i32 %add46.31 to i64
  %arrayidx48.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %idxprom47.31
  %795 = load float, float* %arrayidx48.31, align 4
  br label %if.end113.31

if.end113.31:                                     ; preds = %if.then38.31, %if.then57.31, %if.then78.31, %if.then97.31, %if.else89.31
  %q.3.31 = phi float [ %793, %if.then38.31 ], [ %790, %if.then57.31 ], [ %786, %if.then78.31 ], [ %783, %if.then97.31 ], [ 2.550000e+02, %if.else89.31 ]
  %r.3.31 = phi float [ %795, %if.then38.31 ], [ %791, %if.then57.31 ], [ %788, %if.then78.31 ], [ %784, %if.then97.31 ], [ 2.550000e+02, %if.else89.31 ]
  %arrayidx115.31 = getelementptr inbounds float, float* inttoptr (i64 553648160 to float*), i64 %780
  %796 = load float, float* %arrayidx115.31, align 4
  %cmp116.31 = fcmp ult float %796, %q.3.31
  %cmp121.31 = fcmp ult float %796, %r.3.31
  %or.cond8.31 = or i1 %cmp116.31, %cmp121.31
  br i1 %or.cond8.31, label %if.else129.31, label %if.then123.31

if.then123.31:                                    ; preds = %if.end113.31
  %conv126.31 = fptoui float %796 to i32
  %arrayidx128.31 = getelementptr inbounds i32, i32* %0, i64 %780
  store i32 %conv126.31, i32* %arrayidx128.31, align 4
  br label %for.inc.31

if.else129.31:                                    ; preds = %if.end113.31
  %arrayidx131.31 = getelementptr inbounds i32, i32* %0, i64 %780
  store i32 0, i32* %arrayidx131.31, align 4
  br label %for.inc.31

if.then.31:                                       ; preds = %for.body6.31
  %arrayidx.31 = getelementptr inbounds i32, i32* %0, i64 %780
  store i32 0, i32* %arrayidx.31, align 4
  br label %for.inc.31

for.inc.31:                                       ; preds = %if.then.31, %if.else129.31, %if.then123.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %lftr.wideiv.31 = trunc i64 %indvars.iv.next.31 to i32
  %exitcond.31 = icmp eq i32 %lftr.wideiv.31, %img_width
  br i1 %exitcond.31, label %for.inc134.31.loopexit, label %for.body6.31, !llvm.loop !1

for.inc134.31.loopexit:                           ; preds = %for.inc.31
  br label %for.inc134.31

for.inc134.31:                                    ; preds = %for.inc134.31.loopexit, %for.cond3.preheader, %for.inc134, %for.inc134.1, %for.inc134.2, %for.inc134.3, %for.inc134.4, %for.inc134.5, %for.inc134.6, %for.inc134.7, %for.inc134.8, %for.inc134.9, %for.inc134.10, %for.inc134.11, %for.inc134.12, %for.inc134.13, %for.inc134.14, %for.inc134.15, %for.inc134.16, %for.inc134.17, %for.inc134.18, %for.inc134.19, %for.inc134.20, %for.inc134.21, %for.inc134.22, %for.inc134.23, %for.inc134.24, %for.inc134.25, %for.inc134.26, %for.inc134.27, %for.inc134.28, %for.inc134.29, %for.inc134.30
  %indvars.iv.next20.31 = add nsw i64 %indvars.iv19, 32
  %lftr.wideiv21.31 = trunc i64 %indvars.iv.next20.31 to i32
  %exitcond22.31 = icmp eq i32 %lftr.wideiv21.31, %img_height
  br i1 %exitcond22.31, label %for.end136.loopexit, label %for.cond3.preheader, !llvm.loop !4
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
