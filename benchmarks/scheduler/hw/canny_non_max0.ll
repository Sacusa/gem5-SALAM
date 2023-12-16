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
  %xtraiter = and i32 %img_height, 7
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
  %28 = icmp ult i32 %3, 7
  br i1 %28, label %for.end136, label %for.cond3.preheader.preheader

for.cond3.preheader.preheader:                    ; preds = %for.cond3.preheader.lr.ph.split
  br label %for.cond3.preheader

for.cond3.preheader:                              ; preds = %for.cond3.preheader.preheader, %for.inc134.7
  %indvars.iv19 = phi i64 [ %indvars.iv.next20.7, %for.inc134.7 ], [ %indvars.iv19.unr, %for.cond3.preheader.preheader ]
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph

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
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph.1

for.end136.loopexit:                              ; preds = %for.inc134.7
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
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph.2

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
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph.3

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
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph.4

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
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph.5

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
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph.6

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
  br i1 %cmp49, label %for.inc134.7, label %for.body6.lr.ph.7

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
  br i1 %exitcond.7, label %for.inc134.7.loopexit, label %for.body6.7, !llvm.loop !1

for.inc134.7.loopexit:                            ; preds = %for.inc.7
  br label %for.inc134.7

for.inc134.7:                                     ; preds = %for.inc134.7.loopexit, %for.cond3.preheader, %for.inc134, %for.inc134.1, %for.inc134.2, %for.inc134.3, %for.inc134.4, %for.inc134.5, %for.inc134.6
  %indvars.iv.next20.7 = add nsw i64 %indvars.iv19, 8
  %lftr.wideiv21.7 = trunc i64 %indvars.iv.next20.7 to i32
  %exitcond22.7 = icmp eq i32 %lftr.wideiv21.7, %img_height
  br i1 %exitcond22.7, label %for.end136.loopexit, label %for.cond3.preheader, !llvm.loop !4
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
