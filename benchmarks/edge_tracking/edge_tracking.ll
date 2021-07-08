; ModuleID = 'edge_tracking.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @edge_tracking(i32 %img_height, i32 %img_width, float %thr_weak_ratio, float %thr_strong_ratio) #0 {
for.cond6.preheader.preheader:
  %local_maxima = alloca [16 x i32], align 16
  %local_maxima39 = bitcast [16 x i32]* %local_maxima to i8*
  call void @llvm.memset.p0i8.i64(i8* %local_maxima39, i8 0, i64 64, i32 16, i1 false)
  %arrayidx12 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 0
  %arrayidx12.1 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 1
  %arrayidx12.2 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 2
  %arrayidx12.3 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 3
  %arrayidx12.4 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 4
  %arrayidx12.5 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 5
  %arrayidx12.6 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 6
  %arrayidx12.7 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 7
  %arrayidx12.8 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 8
  %arrayidx12.9 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 9
  %arrayidx12.10 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 10
  %arrayidx12.11 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 11
  %arrayidx12.12 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 12
  %arrayidx12.13 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 13
  %arrayidx12.14 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 14
  %arrayidx12.15 = getelementptr inbounds [16 x i32], [16 x i32]* %local_maxima, i64 0, i64 15
  br label %for.body8

for.body8:                                        ; preds = %for.inc19.15, %for.cond6.preheader.preheader
  %indvars.iv34 = phi i64 [ 0, %for.cond6.preheader.preheader ], [ %indvars.iv.next35, %for.inc19.15 ]
  %arrayidx10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %indvars.iv34
  %0 = load i32, i32* %arrayidx10, align 32
  %1 = load i32, i32* %arrayidx12, align 16
  %cmp13 = icmp ugt i32 %0, %1
  br i1 %cmp13, label %if.then, label %for.inc19

if.then:                                          ; preds = %for.body8
  store i32 %0, i32* %arrayidx12, align 16
  br label %for.inc19

for.inc19:                                        ; preds = %for.body8, %if.then
  %2 = or i64 %indvars.iv34, 1
  %arrayidx10.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %2
  %3 = load i32, i32* %arrayidx10.1, align 4
  %4 = load i32, i32* %arrayidx12.1, align 4
  %cmp13.1 = icmp ugt i32 %3, %4
  br i1 %cmp13.1, label %if.then.1, label %for.inc19.1

for.cond47.preheader:                             ; preds = %for.cond47.preheader.preheader, %for.inc156.31
  %indvars.iv18 = phi i64 [ %indvars.iv.next19.31, %for.inc156.31 ], [ 0, %for.cond47.preheader.preheader ]
  %5 = shl nsw i64 %indvars.iv18, 6
  %6 = shl i64 %indvars.iv18, 6
  %7 = add nsw i64 %6, -64
  %8 = add nsw i64 %5, -1
  %9 = or i64 %5, 1
  %10 = or i64 %6, 64
  %11 = trunc i64 %indvars.iv18 to i32
  %cond = icmp eq i32 %11, 0
  br label %for.body50

for.body50:                                       ; preds = %for.inc153, %for.cond47.preheader
  %indvars.iv = phi i64 [ 0, %for.cond47.preheader ], [ %indvars.iv.next, %for.inc153 ]
  %12 = add nuw nsw i64 %indvars.iv, %5
  br i1 %cond, label %if.then63, label %lor.lhs.false57

lor.lhs.false57:                                  ; preds = %for.body50
  %13 = trunc i64 %indvars.iv to i32
  switch i32 %13, label %if.else [
    i32 0, label %if.then63
    i32 63, label %if.then63
  ]

if.then63:                                        ; preds = %for.body50, %lor.lhs.false57, %lor.lhs.false57
  %arrayidx65 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %12
  store i8 0, i8* %arrayidx65, align 1
  br label %for.inc153

if.else:                                          ; preds = %lor.lhs.false57
  %arrayidx67 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %12
  %14 = load i32, i32* %arrayidx67, align 4
  %cmp68 = icmp eq i32 %14, 75
  br i1 %cmp68, label %if.then70, label %if.else145

if.then70:                                        ; preds = %if.else
  %15 = add nuw nsw i64 %indvars.iv, %6
  %16 = add nsw i64 %15, -65
  %arrayidx76 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %16
  %17 = load i32, i32* %arrayidx76, align 4
  %cmp77 = icmp eq i32 %17, 255
  br i1 %cmp77, label %if.then138, label %lor.lhs.false79

lor.lhs.false79:                                  ; preds = %if.then70
  %18 = add nsw i64 %7, %indvars.iv
  %arrayidx84 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %18
  %19 = load i32, i32* %arrayidx84, align 4
  %cmp85 = icmp eq i32 %19, 255
  br i1 %cmp85, label %if.then138, label %lor.lhs.false87

lor.lhs.false87:                                  ; preds = %lor.lhs.false79
  %20 = add nsw i64 %15, -63
  %arrayidx93 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %20
  %21 = load i32, i32* %arrayidx93, align 4
  %cmp94 = icmp eq i32 %21, 255
  br i1 %cmp94, label %if.then138, label %lor.lhs.false96

lor.lhs.false96:                                  ; preds = %lor.lhs.false87
  %22 = add nsw i64 %8, %indvars.iv
  %arrayidx101 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %22
  %23 = load i32, i32* %arrayidx101, align 4
  %cmp102 = icmp eq i32 %23, 255
  br i1 %cmp102, label %if.then138, label %lor.lhs.false104

lor.lhs.false104:                                 ; preds = %lor.lhs.false96
  %24 = add nuw nsw i64 %9, %indvars.iv
  %arrayidx109 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %24
  %25 = load i32, i32* %arrayidx109, align 4
  %cmp110 = icmp eq i32 %25, 255
  br i1 %cmp110, label %if.then138, label %lor.lhs.false112

lor.lhs.false112:                                 ; preds = %lor.lhs.false104
  %26 = add nuw nsw i64 %15, 63
  %arrayidx118 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %26
  %27 = load i32, i32* %arrayidx118, align 4
  %cmp119 = icmp eq i32 %27, 255
  br i1 %cmp119, label %if.then138, label %lor.lhs.false121

lor.lhs.false121:                                 ; preds = %lor.lhs.false112
  %28 = add nuw nsw i64 %10, %indvars.iv
  %arrayidx126 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %28
  %29 = load i32, i32* %arrayidx126, align 4
  %cmp127 = icmp eq i32 %29, 255
  br i1 %cmp127, label %if.then138, label %lor.lhs.false129

lor.lhs.false129:                                 ; preds = %lor.lhs.false121
  %30 = add nuw nsw i64 %15, 65
  %arrayidx135 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %30
  %31 = load i32, i32* %arrayidx135, align 4
  %cmp136 = icmp eq i32 %31, 255
  br i1 %cmp136, label %if.then138, label %if.else141

if.then138:                                       ; preds = %lor.lhs.false129, %lor.lhs.false121, %lor.lhs.false112, %lor.lhs.false104, %lor.lhs.false96, %lor.lhs.false87, %lor.lhs.false79, %if.then70
  %arrayidx140 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %12
  store i8 -1, i8* %arrayidx140, align 1
  br label %for.inc153

if.else141:                                       ; preds = %lor.lhs.false129
  %arrayidx143 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %12
  store i8 0, i8* %arrayidx143, align 1
  br label %for.inc153

if.else145:                                       ; preds = %if.else
  %conv148 = trunc i32 %14 to i8
  %arrayidx150 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %12
  store i8 %conv148, i8* %arrayidx150, align 1
  br label %for.inc153

for.inc153:                                       ; preds = %if.then63, %if.then138, %if.else141, %if.else145
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 64
  br i1 %exitcond, label %for.inc156, label %for.body50, !llvm.loop !1

for.inc156:                                       ; preds = %for.inc153
  %indvars.iv.next19 = or i64 %indvars.iv18, 1
  %32 = shl nsw i64 %indvars.iv.next19, 6
  %33 = shl i64 %indvars.iv.next19, 6
  %34 = add nsw i64 %33, -64
  %35 = add nsw i64 %32, -1
  %36 = or i64 %32, 1
  %37 = add nuw nsw i64 %33, 64
  br label %for.body50.1

for.end158:                                       ; preds = %for.inc156.31
  ret void

for.body50.1:                                     ; preds = %for.inc153.1, %for.inc156
  %indvars.iv.1 = phi i64 [ 0, %for.inc156 ], [ %indvars.iv.next.1, %for.inc153.1 ]
  %38 = add nuw nsw i64 %indvars.iv.1, %32
  %39 = trunc i64 %indvars.iv.1 to i32
  switch i32 %39, label %if.else.1 [
    i32 0, label %if.then63.1
    i32 63, label %if.then63.1
  ]

if.then63.1:                                      ; preds = %for.body50.1, %for.body50.1
  %arrayidx65.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %38
  store i8 0, i8* %arrayidx65.1, align 1
  br label %for.inc153.1

if.else.1:                                        ; preds = %for.body50.1
  %arrayidx67.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %38
  %40 = load i32, i32* %arrayidx67.1, align 4
  %cmp68.1 = icmp eq i32 %40, 75
  br i1 %cmp68.1, label %if.then70.1, label %if.else145.1

if.else145.1:                                     ; preds = %if.else.1
  %conv148.1 = trunc i32 %40 to i8
  %arrayidx150.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %38
  store i8 %conv148.1, i8* %arrayidx150.1, align 1
  br label %for.inc153.1

if.then70.1:                                      ; preds = %if.else.1
  %41 = add nuw nsw i64 %indvars.iv.1, %33
  %42 = add nsw i64 %41, -65
  %arrayidx76.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %42
  %43 = load i32, i32* %arrayidx76.1, align 4
  %cmp77.1 = icmp eq i32 %43, 255
  br i1 %cmp77.1, label %if.then138.1, label %lor.lhs.false79.1

lor.lhs.false79.1:                                ; preds = %if.then70.1
  %44 = add nuw nsw i64 %34, %indvars.iv.1
  %arrayidx84.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %44
  %45 = load i32, i32* %arrayidx84.1, align 4
  %cmp85.1 = icmp eq i32 %45, 255
  br i1 %cmp85.1, label %if.then138.1, label %lor.lhs.false87.1

lor.lhs.false87.1:                                ; preds = %lor.lhs.false79.1
  %46 = add nsw i64 %41, -63
  %arrayidx93.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %46
  %47 = load i32, i32* %arrayidx93.1, align 4
  %cmp94.1 = icmp eq i32 %47, 255
  br i1 %cmp94.1, label %if.then138.1, label %lor.lhs.false96.1

lor.lhs.false96.1:                                ; preds = %lor.lhs.false87.1
  %48 = add nuw nsw i64 %35, %indvars.iv.1
  %arrayidx101.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %48
  %49 = load i32, i32* %arrayidx101.1, align 4
  %cmp102.1 = icmp eq i32 %49, 255
  br i1 %cmp102.1, label %if.then138.1, label %lor.lhs.false104.1

lor.lhs.false104.1:                               ; preds = %lor.lhs.false96.1
  %50 = add nuw nsw i64 %36, %indvars.iv.1
  %arrayidx109.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %50
  %51 = load i32, i32* %arrayidx109.1, align 4
  %cmp110.1 = icmp eq i32 %51, 255
  br i1 %cmp110.1, label %if.then138.1, label %lor.lhs.false112.1

lor.lhs.false112.1:                               ; preds = %lor.lhs.false104.1
  %52 = add nuw nsw i64 %41, 63
  %arrayidx118.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %52
  %53 = load i32, i32* %arrayidx118.1, align 4
  %cmp119.1 = icmp eq i32 %53, 255
  br i1 %cmp119.1, label %if.then138.1, label %lor.lhs.false121.1

lor.lhs.false121.1:                               ; preds = %lor.lhs.false112.1
  %54 = add nuw nsw i64 %37, %indvars.iv.1
  %arrayidx126.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %54
  %55 = load i32, i32* %arrayidx126.1, align 4
  %cmp127.1 = icmp eq i32 %55, 255
  br i1 %cmp127.1, label %if.then138.1, label %lor.lhs.false129.1

lor.lhs.false129.1:                               ; preds = %lor.lhs.false121.1
  %56 = add nuw nsw i64 %41, 65
  %arrayidx135.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %56
  %57 = load i32, i32* %arrayidx135.1, align 4
  %cmp136.1 = icmp eq i32 %57, 255
  br i1 %cmp136.1, label %if.then138.1, label %if.else141.1

if.else141.1:                                     ; preds = %lor.lhs.false129.1
  %arrayidx143.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %38
  store i8 0, i8* %arrayidx143.1, align 1
  br label %for.inc153.1

if.then138.1:                                     ; preds = %lor.lhs.false129.1, %lor.lhs.false121.1, %lor.lhs.false112.1, %lor.lhs.false104.1, %lor.lhs.false96.1, %lor.lhs.false87.1, %lor.lhs.false79.1, %if.then70.1
  %arrayidx140.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %38
  store i8 -1, i8* %arrayidx140.1, align 1
  br label %for.inc153.1

for.inc153.1:                                     ; preds = %if.then138.1, %if.else141.1, %if.else145.1, %if.then63.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %exitcond.1 = icmp eq i64 %indvars.iv.next.1, 64
  br i1 %exitcond.1, label %for.inc156.1, label %for.body50.1, !llvm.loop !1

for.inc156.1:                                     ; preds = %for.inc153.1
  %indvars.iv.next19.1 = or i64 %indvars.iv18, 2
  %58 = shl nsw i64 %indvars.iv.next19.1, 6
  %59 = shl i64 %indvars.iv.next19.1, 6
  %60 = add nsw i64 %59, -64
  %61 = add nsw i64 %58, -1
  %62 = or i64 %58, 1
  %63 = or i64 %59, 64
  br label %for.body50.2

for.body50.2:                                     ; preds = %for.inc153.2, %for.inc156.1
  %indvars.iv.2 = phi i64 [ 0, %for.inc156.1 ], [ %indvars.iv.next.2, %for.inc153.2 ]
  %64 = add nuw nsw i64 %indvars.iv.2, %58
  %65 = trunc i64 %indvars.iv.2 to i32
  switch i32 %65, label %if.else.2 [
    i32 0, label %if.then63.2
    i32 63, label %if.then63.2
  ]

if.then63.2:                                      ; preds = %for.body50.2, %for.body50.2
  %arrayidx65.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %64
  store i8 0, i8* %arrayidx65.2, align 1
  br label %for.inc153.2

if.else.2:                                        ; preds = %for.body50.2
  %arrayidx67.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %64
  %66 = load i32, i32* %arrayidx67.2, align 4
  %cmp68.2 = icmp eq i32 %66, 75
  br i1 %cmp68.2, label %if.then70.2, label %if.else145.2

if.else145.2:                                     ; preds = %if.else.2
  %conv148.2 = trunc i32 %66 to i8
  %arrayidx150.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %64
  store i8 %conv148.2, i8* %arrayidx150.2, align 1
  br label %for.inc153.2

if.then70.2:                                      ; preds = %if.else.2
  %67 = add nuw nsw i64 %indvars.iv.2, %59
  %68 = add nsw i64 %67, -65
  %arrayidx76.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %68
  %69 = load i32, i32* %arrayidx76.2, align 4
  %cmp77.2 = icmp eq i32 %69, 255
  br i1 %cmp77.2, label %if.then138.2, label %lor.lhs.false79.2

lor.lhs.false79.2:                                ; preds = %if.then70.2
  %70 = add nuw nsw i64 %60, %indvars.iv.2
  %arrayidx84.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %70
  %71 = load i32, i32* %arrayidx84.2, align 4
  %cmp85.2 = icmp eq i32 %71, 255
  br i1 %cmp85.2, label %if.then138.2, label %lor.lhs.false87.2

lor.lhs.false87.2:                                ; preds = %lor.lhs.false79.2
  %72 = add nsw i64 %67, -63
  %arrayidx93.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %72
  %73 = load i32, i32* %arrayidx93.2, align 4
  %cmp94.2 = icmp eq i32 %73, 255
  br i1 %cmp94.2, label %if.then138.2, label %lor.lhs.false96.2

lor.lhs.false96.2:                                ; preds = %lor.lhs.false87.2
  %74 = add nuw nsw i64 %61, %indvars.iv.2
  %arrayidx101.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %74
  %75 = load i32, i32* %arrayidx101.2, align 4
  %cmp102.2 = icmp eq i32 %75, 255
  br i1 %cmp102.2, label %if.then138.2, label %lor.lhs.false104.2

lor.lhs.false104.2:                               ; preds = %lor.lhs.false96.2
  %76 = add nuw nsw i64 %62, %indvars.iv.2
  %arrayidx109.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %76
  %77 = load i32, i32* %arrayidx109.2, align 4
  %cmp110.2 = icmp eq i32 %77, 255
  br i1 %cmp110.2, label %if.then138.2, label %lor.lhs.false112.2

lor.lhs.false112.2:                               ; preds = %lor.lhs.false104.2
  %78 = add nuw nsw i64 %67, 63
  %arrayidx118.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %78
  %79 = load i32, i32* %arrayidx118.2, align 4
  %cmp119.2 = icmp eq i32 %79, 255
  br i1 %cmp119.2, label %if.then138.2, label %lor.lhs.false121.2

lor.lhs.false121.2:                               ; preds = %lor.lhs.false112.2
  %80 = add nuw nsw i64 %63, %indvars.iv.2
  %arrayidx126.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %80
  %81 = load i32, i32* %arrayidx126.2, align 4
  %cmp127.2 = icmp eq i32 %81, 255
  br i1 %cmp127.2, label %if.then138.2, label %lor.lhs.false129.2

lor.lhs.false129.2:                               ; preds = %lor.lhs.false121.2
  %82 = add nuw nsw i64 %67, 65
  %arrayidx135.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %82
  %83 = load i32, i32* %arrayidx135.2, align 4
  %cmp136.2 = icmp eq i32 %83, 255
  br i1 %cmp136.2, label %if.then138.2, label %if.else141.2

if.else141.2:                                     ; preds = %lor.lhs.false129.2
  %arrayidx143.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %64
  store i8 0, i8* %arrayidx143.2, align 1
  br label %for.inc153.2

if.then138.2:                                     ; preds = %lor.lhs.false129.2, %lor.lhs.false121.2, %lor.lhs.false112.2, %lor.lhs.false104.2, %lor.lhs.false96.2, %lor.lhs.false87.2, %lor.lhs.false79.2, %if.then70.2
  %arrayidx140.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %64
  store i8 -1, i8* %arrayidx140.2, align 1
  br label %for.inc153.2

for.inc153.2:                                     ; preds = %if.then138.2, %if.else141.2, %if.else145.2, %if.then63.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %exitcond.2 = icmp eq i64 %indvars.iv.next.2, 64
  br i1 %exitcond.2, label %for.inc156.2, label %for.body50.2, !llvm.loop !1

for.inc156.2:                                     ; preds = %for.inc153.2
  %indvars.iv.next19.2 = or i64 %indvars.iv18, 3
  %84 = shl nsw i64 %indvars.iv.next19.2, 6
  %85 = shl i64 %indvars.iv.next19.2, 6
  %86 = add nsw i64 %85, -64
  %87 = add nsw i64 %84, -1
  %88 = or i64 %84, 1
  %89 = add nuw nsw i64 %85, 64
  br label %for.body50.3

for.body50.3:                                     ; preds = %for.inc153.3, %for.inc156.2
  %indvars.iv.3 = phi i64 [ 0, %for.inc156.2 ], [ %indvars.iv.next.3, %for.inc153.3 ]
  %90 = add nuw nsw i64 %indvars.iv.3, %84
  %91 = trunc i64 %indvars.iv.3 to i32
  switch i32 %91, label %if.else.3 [
    i32 0, label %if.then63.3
    i32 63, label %if.then63.3
  ]

if.then63.3:                                      ; preds = %for.body50.3, %for.body50.3
  %arrayidx65.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %90
  store i8 0, i8* %arrayidx65.3, align 1
  br label %for.inc153.3

if.else.3:                                        ; preds = %for.body50.3
  %arrayidx67.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %90
  %92 = load i32, i32* %arrayidx67.3, align 4
  %cmp68.3 = icmp eq i32 %92, 75
  br i1 %cmp68.3, label %if.then70.3, label %if.else145.3

if.else145.3:                                     ; preds = %if.else.3
  %conv148.3 = trunc i32 %92 to i8
  %arrayidx150.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %90
  store i8 %conv148.3, i8* %arrayidx150.3, align 1
  br label %for.inc153.3

if.then70.3:                                      ; preds = %if.else.3
  %93 = add nuw nsw i64 %indvars.iv.3, %85
  %94 = add nsw i64 %93, -65
  %arrayidx76.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %94
  %95 = load i32, i32* %arrayidx76.3, align 4
  %cmp77.3 = icmp eq i32 %95, 255
  br i1 %cmp77.3, label %if.then138.3, label %lor.lhs.false79.3

lor.lhs.false79.3:                                ; preds = %if.then70.3
  %96 = add nuw nsw i64 %86, %indvars.iv.3
  %arrayidx84.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %96
  %97 = load i32, i32* %arrayidx84.3, align 4
  %cmp85.3 = icmp eq i32 %97, 255
  br i1 %cmp85.3, label %if.then138.3, label %lor.lhs.false87.3

lor.lhs.false87.3:                                ; preds = %lor.lhs.false79.3
  %98 = add nsw i64 %93, -63
  %arrayidx93.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %98
  %99 = load i32, i32* %arrayidx93.3, align 4
  %cmp94.3 = icmp eq i32 %99, 255
  br i1 %cmp94.3, label %if.then138.3, label %lor.lhs.false96.3

lor.lhs.false96.3:                                ; preds = %lor.lhs.false87.3
  %100 = add nuw nsw i64 %87, %indvars.iv.3
  %arrayidx101.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %100
  %101 = load i32, i32* %arrayidx101.3, align 4
  %cmp102.3 = icmp eq i32 %101, 255
  br i1 %cmp102.3, label %if.then138.3, label %lor.lhs.false104.3

lor.lhs.false104.3:                               ; preds = %lor.lhs.false96.3
  %102 = add nuw nsw i64 %88, %indvars.iv.3
  %arrayidx109.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %102
  %103 = load i32, i32* %arrayidx109.3, align 4
  %cmp110.3 = icmp eq i32 %103, 255
  br i1 %cmp110.3, label %if.then138.3, label %lor.lhs.false112.3

lor.lhs.false112.3:                               ; preds = %lor.lhs.false104.3
  %104 = add nuw nsw i64 %93, 63
  %arrayidx118.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %104
  %105 = load i32, i32* %arrayidx118.3, align 4
  %cmp119.3 = icmp eq i32 %105, 255
  br i1 %cmp119.3, label %if.then138.3, label %lor.lhs.false121.3

lor.lhs.false121.3:                               ; preds = %lor.lhs.false112.3
  %106 = add nuw nsw i64 %89, %indvars.iv.3
  %arrayidx126.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %106
  %107 = load i32, i32* %arrayidx126.3, align 4
  %cmp127.3 = icmp eq i32 %107, 255
  br i1 %cmp127.3, label %if.then138.3, label %lor.lhs.false129.3

lor.lhs.false129.3:                               ; preds = %lor.lhs.false121.3
  %108 = add nuw nsw i64 %93, 65
  %arrayidx135.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %108
  %109 = load i32, i32* %arrayidx135.3, align 4
  %cmp136.3 = icmp eq i32 %109, 255
  br i1 %cmp136.3, label %if.then138.3, label %if.else141.3

if.else141.3:                                     ; preds = %lor.lhs.false129.3
  %arrayidx143.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %90
  store i8 0, i8* %arrayidx143.3, align 1
  br label %for.inc153.3

if.then138.3:                                     ; preds = %lor.lhs.false129.3, %lor.lhs.false121.3, %lor.lhs.false112.3, %lor.lhs.false104.3, %lor.lhs.false96.3, %lor.lhs.false87.3, %lor.lhs.false79.3, %if.then70.3
  %arrayidx140.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %90
  store i8 -1, i8* %arrayidx140.3, align 1
  br label %for.inc153.3

for.inc153.3:                                     ; preds = %if.then138.3, %if.else141.3, %if.else145.3, %if.then63.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %exitcond.3 = icmp eq i64 %indvars.iv.next.3, 64
  br i1 %exitcond.3, label %for.inc156.3, label %for.body50.3, !llvm.loop !1

for.inc156.3:                                     ; preds = %for.inc153.3
  %indvars.iv.next19.3 = or i64 %indvars.iv18, 4
  %110 = shl nsw i64 %indvars.iv.next19.3, 6
  %111 = shl i64 %indvars.iv.next19.3, 6
  %112 = add nsw i64 %111, -64
  %113 = add nsw i64 %110, -1
  %114 = or i64 %110, 1
  %115 = or i64 %111, 64
  br label %for.body50.4

for.body50.4:                                     ; preds = %for.inc153.4, %for.inc156.3
  %indvars.iv.4 = phi i64 [ 0, %for.inc156.3 ], [ %indvars.iv.next.4, %for.inc153.4 ]
  %116 = add nuw nsw i64 %indvars.iv.4, %110
  %117 = trunc i64 %indvars.iv.4 to i32
  switch i32 %117, label %if.else.4 [
    i32 0, label %if.then63.4
    i32 63, label %if.then63.4
  ]

if.then63.4:                                      ; preds = %for.body50.4, %for.body50.4
  %arrayidx65.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %116
  store i8 0, i8* %arrayidx65.4, align 1
  br label %for.inc153.4

if.else.4:                                        ; preds = %for.body50.4
  %arrayidx67.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %116
  %118 = load i32, i32* %arrayidx67.4, align 4
  %cmp68.4 = icmp eq i32 %118, 75
  br i1 %cmp68.4, label %if.then70.4, label %if.else145.4

if.else145.4:                                     ; preds = %if.else.4
  %conv148.4 = trunc i32 %118 to i8
  %arrayidx150.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %116
  store i8 %conv148.4, i8* %arrayidx150.4, align 1
  br label %for.inc153.4

if.then70.4:                                      ; preds = %if.else.4
  %119 = add nuw nsw i64 %indvars.iv.4, %111
  %120 = add nsw i64 %119, -65
  %arrayidx76.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %120
  %121 = load i32, i32* %arrayidx76.4, align 4
  %cmp77.4 = icmp eq i32 %121, 255
  br i1 %cmp77.4, label %if.then138.4, label %lor.lhs.false79.4

lor.lhs.false79.4:                                ; preds = %if.then70.4
  %122 = add nuw nsw i64 %112, %indvars.iv.4
  %arrayidx84.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %122
  %123 = load i32, i32* %arrayidx84.4, align 4
  %cmp85.4 = icmp eq i32 %123, 255
  br i1 %cmp85.4, label %if.then138.4, label %lor.lhs.false87.4

lor.lhs.false87.4:                                ; preds = %lor.lhs.false79.4
  %124 = add nsw i64 %119, -63
  %arrayidx93.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %124
  %125 = load i32, i32* %arrayidx93.4, align 4
  %cmp94.4 = icmp eq i32 %125, 255
  br i1 %cmp94.4, label %if.then138.4, label %lor.lhs.false96.4

lor.lhs.false96.4:                                ; preds = %lor.lhs.false87.4
  %126 = add nuw nsw i64 %113, %indvars.iv.4
  %arrayidx101.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %126
  %127 = load i32, i32* %arrayidx101.4, align 4
  %cmp102.4 = icmp eq i32 %127, 255
  br i1 %cmp102.4, label %if.then138.4, label %lor.lhs.false104.4

lor.lhs.false104.4:                               ; preds = %lor.lhs.false96.4
  %128 = add nuw nsw i64 %114, %indvars.iv.4
  %arrayidx109.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %128
  %129 = load i32, i32* %arrayidx109.4, align 4
  %cmp110.4 = icmp eq i32 %129, 255
  br i1 %cmp110.4, label %if.then138.4, label %lor.lhs.false112.4

lor.lhs.false112.4:                               ; preds = %lor.lhs.false104.4
  %130 = add nuw nsw i64 %119, 63
  %arrayidx118.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %130
  %131 = load i32, i32* %arrayidx118.4, align 4
  %cmp119.4 = icmp eq i32 %131, 255
  br i1 %cmp119.4, label %if.then138.4, label %lor.lhs.false121.4

lor.lhs.false121.4:                               ; preds = %lor.lhs.false112.4
  %132 = add nuw nsw i64 %115, %indvars.iv.4
  %arrayidx126.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %132
  %133 = load i32, i32* %arrayidx126.4, align 4
  %cmp127.4 = icmp eq i32 %133, 255
  br i1 %cmp127.4, label %if.then138.4, label %lor.lhs.false129.4

lor.lhs.false129.4:                               ; preds = %lor.lhs.false121.4
  %134 = add nuw nsw i64 %119, 65
  %arrayidx135.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %134
  %135 = load i32, i32* %arrayidx135.4, align 4
  %cmp136.4 = icmp eq i32 %135, 255
  br i1 %cmp136.4, label %if.then138.4, label %if.else141.4

if.else141.4:                                     ; preds = %lor.lhs.false129.4
  %arrayidx143.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %116
  store i8 0, i8* %arrayidx143.4, align 1
  br label %for.inc153.4

if.then138.4:                                     ; preds = %lor.lhs.false129.4, %lor.lhs.false121.4, %lor.lhs.false112.4, %lor.lhs.false104.4, %lor.lhs.false96.4, %lor.lhs.false87.4, %lor.lhs.false79.4, %if.then70.4
  %arrayidx140.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %116
  store i8 -1, i8* %arrayidx140.4, align 1
  br label %for.inc153.4

for.inc153.4:                                     ; preds = %if.then138.4, %if.else141.4, %if.else145.4, %if.then63.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 64
  br i1 %exitcond.4, label %for.inc156.4, label %for.body50.4, !llvm.loop !1

for.inc156.4:                                     ; preds = %for.inc153.4
  %indvars.iv.next19.4 = or i64 %indvars.iv18, 5
  %136 = shl nsw i64 %indvars.iv.next19.4, 6
  %137 = shl i64 %indvars.iv.next19.4, 6
  %138 = add nsw i64 %137, -64
  %139 = add nsw i64 %136, -1
  %140 = or i64 %136, 1
  %141 = add nuw nsw i64 %137, 64
  br label %for.body50.5

for.body50.5:                                     ; preds = %for.inc153.5, %for.inc156.4
  %indvars.iv.5 = phi i64 [ 0, %for.inc156.4 ], [ %indvars.iv.next.5, %for.inc153.5 ]
  %142 = add nuw nsw i64 %indvars.iv.5, %136
  %143 = trunc i64 %indvars.iv.5 to i32
  switch i32 %143, label %if.else.5 [
    i32 0, label %if.then63.5
    i32 63, label %if.then63.5
  ]

if.then63.5:                                      ; preds = %for.body50.5, %for.body50.5
  %arrayidx65.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %142
  store i8 0, i8* %arrayidx65.5, align 1
  br label %for.inc153.5

if.else.5:                                        ; preds = %for.body50.5
  %arrayidx67.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %142
  %144 = load i32, i32* %arrayidx67.5, align 4
  %cmp68.5 = icmp eq i32 %144, 75
  br i1 %cmp68.5, label %if.then70.5, label %if.else145.5

if.else145.5:                                     ; preds = %if.else.5
  %conv148.5 = trunc i32 %144 to i8
  %arrayidx150.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %142
  store i8 %conv148.5, i8* %arrayidx150.5, align 1
  br label %for.inc153.5

if.then70.5:                                      ; preds = %if.else.5
  %145 = add nuw nsw i64 %indvars.iv.5, %137
  %146 = add nsw i64 %145, -65
  %arrayidx76.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %146
  %147 = load i32, i32* %arrayidx76.5, align 4
  %cmp77.5 = icmp eq i32 %147, 255
  br i1 %cmp77.5, label %if.then138.5, label %lor.lhs.false79.5

lor.lhs.false79.5:                                ; preds = %if.then70.5
  %148 = add nuw nsw i64 %138, %indvars.iv.5
  %arrayidx84.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %148
  %149 = load i32, i32* %arrayidx84.5, align 4
  %cmp85.5 = icmp eq i32 %149, 255
  br i1 %cmp85.5, label %if.then138.5, label %lor.lhs.false87.5

lor.lhs.false87.5:                                ; preds = %lor.lhs.false79.5
  %150 = add nsw i64 %145, -63
  %arrayidx93.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %150
  %151 = load i32, i32* %arrayidx93.5, align 4
  %cmp94.5 = icmp eq i32 %151, 255
  br i1 %cmp94.5, label %if.then138.5, label %lor.lhs.false96.5

lor.lhs.false96.5:                                ; preds = %lor.lhs.false87.5
  %152 = add nuw nsw i64 %139, %indvars.iv.5
  %arrayidx101.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %152
  %153 = load i32, i32* %arrayidx101.5, align 4
  %cmp102.5 = icmp eq i32 %153, 255
  br i1 %cmp102.5, label %if.then138.5, label %lor.lhs.false104.5

lor.lhs.false104.5:                               ; preds = %lor.lhs.false96.5
  %154 = add nuw nsw i64 %140, %indvars.iv.5
  %arrayidx109.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %154
  %155 = load i32, i32* %arrayidx109.5, align 4
  %cmp110.5 = icmp eq i32 %155, 255
  br i1 %cmp110.5, label %if.then138.5, label %lor.lhs.false112.5

lor.lhs.false112.5:                               ; preds = %lor.lhs.false104.5
  %156 = add nuw nsw i64 %145, 63
  %arrayidx118.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %156
  %157 = load i32, i32* %arrayidx118.5, align 4
  %cmp119.5 = icmp eq i32 %157, 255
  br i1 %cmp119.5, label %if.then138.5, label %lor.lhs.false121.5

lor.lhs.false121.5:                               ; preds = %lor.lhs.false112.5
  %158 = add nuw nsw i64 %141, %indvars.iv.5
  %arrayidx126.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %158
  %159 = load i32, i32* %arrayidx126.5, align 4
  %cmp127.5 = icmp eq i32 %159, 255
  br i1 %cmp127.5, label %if.then138.5, label %lor.lhs.false129.5

lor.lhs.false129.5:                               ; preds = %lor.lhs.false121.5
  %160 = add nuw nsw i64 %145, 65
  %arrayidx135.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %160
  %161 = load i32, i32* %arrayidx135.5, align 4
  %cmp136.5 = icmp eq i32 %161, 255
  br i1 %cmp136.5, label %if.then138.5, label %if.else141.5

if.else141.5:                                     ; preds = %lor.lhs.false129.5
  %arrayidx143.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %142
  store i8 0, i8* %arrayidx143.5, align 1
  br label %for.inc153.5

if.then138.5:                                     ; preds = %lor.lhs.false129.5, %lor.lhs.false121.5, %lor.lhs.false112.5, %lor.lhs.false104.5, %lor.lhs.false96.5, %lor.lhs.false87.5, %lor.lhs.false79.5, %if.then70.5
  %arrayidx140.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %142
  store i8 -1, i8* %arrayidx140.5, align 1
  br label %for.inc153.5

for.inc153.5:                                     ; preds = %if.then138.5, %if.else141.5, %if.else145.5, %if.then63.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %exitcond.5 = icmp eq i64 %indvars.iv.next.5, 64
  br i1 %exitcond.5, label %for.inc156.5, label %for.body50.5, !llvm.loop !1

for.inc156.5:                                     ; preds = %for.inc153.5
  %indvars.iv.next19.5 = or i64 %indvars.iv18, 6
  %162 = shl nsw i64 %indvars.iv.next19.5, 6
  %163 = shl i64 %indvars.iv.next19.5, 6
  %164 = add nsw i64 %163, -64
  %165 = add nsw i64 %162, -1
  %166 = or i64 %162, 1
  %167 = or i64 %163, 64
  br label %for.body50.6

for.body50.6:                                     ; preds = %for.inc153.6, %for.inc156.5
  %indvars.iv.6 = phi i64 [ 0, %for.inc156.5 ], [ %indvars.iv.next.6, %for.inc153.6 ]
  %168 = add nuw nsw i64 %indvars.iv.6, %162
  %169 = trunc i64 %indvars.iv.6 to i32
  switch i32 %169, label %if.else.6 [
    i32 0, label %if.then63.6
    i32 63, label %if.then63.6
  ]

if.then63.6:                                      ; preds = %for.body50.6, %for.body50.6
  %arrayidx65.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %168
  store i8 0, i8* %arrayidx65.6, align 1
  br label %for.inc153.6

if.else.6:                                        ; preds = %for.body50.6
  %arrayidx67.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %168
  %170 = load i32, i32* %arrayidx67.6, align 4
  %cmp68.6 = icmp eq i32 %170, 75
  br i1 %cmp68.6, label %if.then70.6, label %if.else145.6

if.else145.6:                                     ; preds = %if.else.6
  %conv148.6 = trunc i32 %170 to i8
  %arrayidx150.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %168
  store i8 %conv148.6, i8* %arrayidx150.6, align 1
  br label %for.inc153.6

if.then70.6:                                      ; preds = %if.else.6
  %171 = add nuw nsw i64 %indvars.iv.6, %163
  %172 = add nsw i64 %171, -65
  %arrayidx76.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %172
  %173 = load i32, i32* %arrayidx76.6, align 4
  %cmp77.6 = icmp eq i32 %173, 255
  br i1 %cmp77.6, label %if.then138.6, label %lor.lhs.false79.6

lor.lhs.false79.6:                                ; preds = %if.then70.6
  %174 = add nuw nsw i64 %164, %indvars.iv.6
  %arrayidx84.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %174
  %175 = load i32, i32* %arrayidx84.6, align 4
  %cmp85.6 = icmp eq i32 %175, 255
  br i1 %cmp85.6, label %if.then138.6, label %lor.lhs.false87.6

lor.lhs.false87.6:                                ; preds = %lor.lhs.false79.6
  %176 = add nsw i64 %171, -63
  %arrayidx93.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %176
  %177 = load i32, i32* %arrayidx93.6, align 4
  %cmp94.6 = icmp eq i32 %177, 255
  br i1 %cmp94.6, label %if.then138.6, label %lor.lhs.false96.6

lor.lhs.false96.6:                                ; preds = %lor.lhs.false87.6
  %178 = add nuw nsw i64 %165, %indvars.iv.6
  %arrayidx101.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %178
  %179 = load i32, i32* %arrayidx101.6, align 4
  %cmp102.6 = icmp eq i32 %179, 255
  br i1 %cmp102.6, label %if.then138.6, label %lor.lhs.false104.6

lor.lhs.false104.6:                               ; preds = %lor.lhs.false96.6
  %180 = add nuw nsw i64 %166, %indvars.iv.6
  %arrayidx109.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %180
  %181 = load i32, i32* %arrayidx109.6, align 4
  %cmp110.6 = icmp eq i32 %181, 255
  br i1 %cmp110.6, label %if.then138.6, label %lor.lhs.false112.6

lor.lhs.false112.6:                               ; preds = %lor.lhs.false104.6
  %182 = add nuw nsw i64 %171, 63
  %arrayidx118.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %182
  %183 = load i32, i32* %arrayidx118.6, align 4
  %cmp119.6 = icmp eq i32 %183, 255
  br i1 %cmp119.6, label %if.then138.6, label %lor.lhs.false121.6

lor.lhs.false121.6:                               ; preds = %lor.lhs.false112.6
  %184 = add nuw nsw i64 %167, %indvars.iv.6
  %arrayidx126.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %184
  %185 = load i32, i32* %arrayidx126.6, align 4
  %cmp127.6 = icmp eq i32 %185, 255
  br i1 %cmp127.6, label %if.then138.6, label %lor.lhs.false129.6

lor.lhs.false129.6:                               ; preds = %lor.lhs.false121.6
  %186 = add nuw nsw i64 %171, 65
  %arrayidx135.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %186
  %187 = load i32, i32* %arrayidx135.6, align 4
  %cmp136.6 = icmp eq i32 %187, 255
  br i1 %cmp136.6, label %if.then138.6, label %if.else141.6

if.else141.6:                                     ; preds = %lor.lhs.false129.6
  %arrayidx143.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %168
  store i8 0, i8* %arrayidx143.6, align 1
  br label %for.inc153.6

if.then138.6:                                     ; preds = %lor.lhs.false129.6, %lor.lhs.false121.6, %lor.lhs.false112.6, %lor.lhs.false104.6, %lor.lhs.false96.6, %lor.lhs.false87.6, %lor.lhs.false79.6, %if.then70.6
  %arrayidx140.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %168
  store i8 -1, i8* %arrayidx140.6, align 1
  br label %for.inc153.6

for.inc153.6:                                     ; preds = %if.then138.6, %if.else141.6, %if.else145.6, %if.then63.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %exitcond.6 = icmp eq i64 %indvars.iv.next.6, 64
  br i1 %exitcond.6, label %for.inc156.6, label %for.body50.6, !llvm.loop !1

for.inc156.6:                                     ; preds = %for.inc153.6
  %indvars.iv.next19.6 = or i64 %indvars.iv18, 7
  %188 = shl nsw i64 %indvars.iv.next19.6, 6
  %189 = shl i64 %indvars.iv.next19.6, 6
  %190 = add nsw i64 %189, -64
  %191 = add nsw i64 %188, -1
  %192 = or i64 %188, 1
  %193 = add nuw nsw i64 %189, 64
  br label %for.body50.7

for.body50.7:                                     ; preds = %for.inc153.7, %for.inc156.6
  %indvars.iv.7 = phi i64 [ 0, %for.inc156.6 ], [ %indvars.iv.next.7, %for.inc153.7 ]
  %194 = add nuw nsw i64 %indvars.iv.7, %188
  %195 = trunc i64 %indvars.iv.7 to i32
  switch i32 %195, label %if.else.7 [
    i32 0, label %if.then63.7
    i32 63, label %if.then63.7
  ]

if.then63.7:                                      ; preds = %for.body50.7, %for.body50.7
  %arrayidx65.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %194
  store i8 0, i8* %arrayidx65.7, align 1
  br label %for.inc153.7

if.else.7:                                        ; preds = %for.body50.7
  %arrayidx67.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %194
  %196 = load i32, i32* %arrayidx67.7, align 4
  %cmp68.7 = icmp eq i32 %196, 75
  br i1 %cmp68.7, label %if.then70.7, label %if.else145.7

if.else145.7:                                     ; preds = %if.else.7
  %conv148.7 = trunc i32 %196 to i8
  %arrayidx150.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %194
  store i8 %conv148.7, i8* %arrayidx150.7, align 1
  br label %for.inc153.7

if.then70.7:                                      ; preds = %if.else.7
  %197 = add nuw nsw i64 %indvars.iv.7, %189
  %198 = add nsw i64 %197, -65
  %arrayidx76.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %198
  %199 = load i32, i32* %arrayidx76.7, align 4
  %cmp77.7 = icmp eq i32 %199, 255
  br i1 %cmp77.7, label %if.then138.7, label %lor.lhs.false79.7

lor.lhs.false79.7:                                ; preds = %if.then70.7
  %200 = add nuw nsw i64 %190, %indvars.iv.7
  %arrayidx84.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %200
  %201 = load i32, i32* %arrayidx84.7, align 4
  %cmp85.7 = icmp eq i32 %201, 255
  br i1 %cmp85.7, label %if.then138.7, label %lor.lhs.false87.7

lor.lhs.false87.7:                                ; preds = %lor.lhs.false79.7
  %202 = add nsw i64 %197, -63
  %arrayidx93.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %202
  %203 = load i32, i32* %arrayidx93.7, align 4
  %cmp94.7 = icmp eq i32 %203, 255
  br i1 %cmp94.7, label %if.then138.7, label %lor.lhs.false96.7

lor.lhs.false96.7:                                ; preds = %lor.lhs.false87.7
  %204 = add nuw nsw i64 %191, %indvars.iv.7
  %arrayidx101.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %204
  %205 = load i32, i32* %arrayidx101.7, align 4
  %cmp102.7 = icmp eq i32 %205, 255
  br i1 %cmp102.7, label %if.then138.7, label %lor.lhs.false104.7

lor.lhs.false104.7:                               ; preds = %lor.lhs.false96.7
  %206 = add nuw nsw i64 %192, %indvars.iv.7
  %arrayidx109.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %206
  %207 = load i32, i32* %arrayidx109.7, align 4
  %cmp110.7 = icmp eq i32 %207, 255
  br i1 %cmp110.7, label %if.then138.7, label %lor.lhs.false112.7

lor.lhs.false112.7:                               ; preds = %lor.lhs.false104.7
  %208 = add nuw nsw i64 %197, 63
  %arrayidx118.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %208
  %209 = load i32, i32* %arrayidx118.7, align 4
  %cmp119.7 = icmp eq i32 %209, 255
  br i1 %cmp119.7, label %if.then138.7, label %lor.lhs.false121.7

lor.lhs.false121.7:                               ; preds = %lor.lhs.false112.7
  %210 = add nuw nsw i64 %193, %indvars.iv.7
  %arrayidx126.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %210
  %211 = load i32, i32* %arrayidx126.7, align 4
  %cmp127.7 = icmp eq i32 %211, 255
  br i1 %cmp127.7, label %if.then138.7, label %lor.lhs.false129.7

lor.lhs.false129.7:                               ; preds = %lor.lhs.false121.7
  %212 = add nuw nsw i64 %197, 65
  %arrayidx135.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %212
  %213 = load i32, i32* %arrayidx135.7, align 4
  %cmp136.7 = icmp eq i32 %213, 255
  br i1 %cmp136.7, label %if.then138.7, label %if.else141.7

if.else141.7:                                     ; preds = %lor.lhs.false129.7
  %arrayidx143.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %194
  store i8 0, i8* %arrayidx143.7, align 1
  br label %for.inc153.7

if.then138.7:                                     ; preds = %lor.lhs.false129.7, %lor.lhs.false121.7, %lor.lhs.false112.7, %lor.lhs.false104.7, %lor.lhs.false96.7, %lor.lhs.false87.7, %lor.lhs.false79.7, %if.then70.7
  %arrayidx140.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %194
  store i8 -1, i8* %arrayidx140.7, align 1
  br label %for.inc153.7

for.inc153.7:                                     ; preds = %if.then138.7, %if.else141.7, %if.else145.7, %if.then63.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %exitcond.7 = icmp eq i64 %indvars.iv.next.7, 64
  br i1 %exitcond.7, label %for.inc156.7, label %for.body50.7, !llvm.loop !1

for.inc156.7:                                     ; preds = %for.inc153.7
  %indvars.iv.next19.7 = or i64 %indvars.iv18, 8
  %214 = shl nsw i64 %indvars.iv.next19.7, 6
  %215 = shl i64 %indvars.iv.next19.7, 6
  %216 = add nsw i64 %215, -64
  %217 = add nsw i64 %214, -1
  %218 = or i64 %214, 1
  %219 = or i64 %215, 64
  br label %for.body50.8

for.body50.8:                                     ; preds = %for.inc153.8, %for.inc156.7
  %indvars.iv.8 = phi i64 [ 0, %for.inc156.7 ], [ %indvars.iv.next.8, %for.inc153.8 ]
  %220 = add nuw nsw i64 %indvars.iv.8, %214
  %221 = trunc i64 %indvars.iv.8 to i32
  switch i32 %221, label %if.else.8 [
    i32 0, label %if.then63.8
    i32 63, label %if.then63.8
  ]

if.then63.8:                                      ; preds = %for.body50.8, %for.body50.8
  %arrayidx65.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %220
  store i8 0, i8* %arrayidx65.8, align 1
  br label %for.inc153.8

if.else.8:                                        ; preds = %for.body50.8
  %arrayidx67.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %220
  %222 = load i32, i32* %arrayidx67.8, align 4
  %cmp68.8 = icmp eq i32 %222, 75
  br i1 %cmp68.8, label %if.then70.8, label %if.else145.8

if.else145.8:                                     ; preds = %if.else.8
  %conv148.8 = trunc i32 %222 to i8
  %arrayidx150.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %220
  store i8 %conv148.8, i8* %arrayidx150.8, align 1
  br label %for.inc153.8

if.then70.8:                                      ; preds = %if.else.8
  %223 = add nuw nsw i64 %indvars.iv.8, %215
  %224 = add nsw i64 %223, -65
  %arrayidx76.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %224
  %225 = load i32, i32* %arrayidx76.8, align 4
  %cmp77.8 = icmp eq i32 %225, 255
  br i1 %cmp77.8, label %if.then138.8, label %lor.lhs.false79.8

lor.lhs.false79.8:                                ; preds = %if.then70.8
  %226 = add nuw nsw i64 %216, %indvars.iv.8
  %arrayidx84.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %226
  %227 = load i32, i32* %arrayidx84.8, align 4
  %cmp85.8 = icmp eq i32 %227, 255
  br i1 %cmp85.8, label %if.then138.8, label %lor.lhs.false87.8

lor.lhs.false87.8:                                ; preds = %lor.lhs.false79.8
  %228 = add nsw i64 %223, -63
  %arrayidx93.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %228
  %229 = load i32, i32* %arrayidx93.8, align 4
  %cmp94.8 = icmp eq i32 %229, 255
  br i1 %cmp94.8, label %if.then138.8, label %lor.lhs.false96.8

lor.lhs.false96.8:                                ; preds = %lor.lhs.false87.8
  %230 = add nuw nsw i64 %217, %indvars.iv.8
  %arrayidx101.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %230
  %231 = load i32, i32* %arrayidx101.8, align 4
  %cmp102.8 = icmp eq i32 %231, 255
  br i1 %cmp102.8, label %if.then138.8, label %lor.lhs.false104.8

lor.lhs.false104.8:                               ; preds = %lor.lhs.false96.8
  %232 = add nuw nsw i64 %218, %indvars.iv.8
  %arrayidx109.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %232
  %233 = load i32, i32* %arrayidx109.8, align 4
  %cmp110.8 = icmp eq i32 %233, 255
  br i1 %cmp110.8, label %if.then138.8, label %lor.lhs.false112.8

lor.lhs.false112.8:                               ; preds = %lor.lhs.false104.8
  %234 = add nuw nsw i64 %223, 63
  %arrayidx118.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %234
  %235 = load i32, i32* %arrayidx118.8, align 4
  %cmp119.8 = icmp eq i32 %235, 255
  br i1 %cmp119.8, label %if.then138.8, label %lor.lhs.false121.8

lor.lhs.false121.8:                               ; preds = %lor.lhs.false112.8
  %236 = add nuw nsw i64 %219, %indvars.iv.8
  %arrayidx126.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %236
  %237 = load i32, i32* %arrayidx126.8, align 4
  %cmp127.8 = icmp eq i32 %237, 255
  br i1 %cmp127.8, label %if.then138.8, label %lor.lhs.false129.8

lor.lhs.false129.8:                               ; preds = %lor.lhs.false121.8
  %238 = add nuw nsw i64 %223, 65
  %arrayidx135.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %238
  %239 = load i32, i32* %arrayidx135.8, align 4
  %cmp136.8 = icmp eq i32 %239, 255
  br i1 %cmp136.8, label %if.then138.8, label %if.else141.8

if.else141.8:                                     ; preds = %lor.lhs.false129.8
  %arrayidx143.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %220
  store i8 0, i8* %arrayidx143.8, align 1
  br label %for.inc153.8

if.then138.8:                                     ; preds = %lor.lhs.false129.8, %lor.lhs.false121.8, %lor.lhs.false112.8, %lor.lhs.false104.8, %lor.lhs.false96.8, %lor.lhs.false87.8, %lor.lhs.false79.8, %if.then70.8
  %arrayidx140.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %220
  store i8 -1, i8* %arrayidx140.8, align 1
  br label %for.inc153.8

for.inc153.8:                                     ; preds = %if.then138.8, %if.else141.8, %if.else145.8, %if.then63.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %exitcond.8 = icmp eq i64 %indvars.iv.next.8, 64
  br i1 %exitcond.8, label %for.inc156.8, label %for.body50.8, !llvm.loop !1

for.inc156.8:                                     ; preds = %for.inc153.8
  %indvars.iv.next19.8 = or i64 %indvars.iv18, 9
  %240 = shl nsw i64 %indvars.iv.next19.8, 6
  %241 = shl i64 %indvars.iv.next19.8, 6
  %242 = add nsw i64 %241, -64
  %243 = add nsw i64 %240, -1
  %244 = or i64 %240, 1
  %245 = add nuw nsw i64 %241, 64
  br label %for.body50.9

for.body50.9:                                     ; preds = %for.inc153.9, %for.inc156.8
  %indvars.iv.9 = phi i64 [ 0, %for.inc156.8 ], [ %indvars.iv.next.9, %for.inc153.9 ]
  %246 = add nuw nsw i64 %indvars.iv.9, %240
  %247 = trunc i64 %indvars.iv.9 to i32
  switch i32 %247, label %if.else.9 [
    i32 0, label %if.then63.9
    i32 63, label %if.then63.9
  ]

if.then63.9:                                      ; preds = %for.body50.9, %for.body50.9
  %arrayidx65.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %246
  store i8 0, i8* %arrayidx65.9, align 1
  br label %for.inc153.9

if.else.9:                                        ; preds = %for.body50.9
  %arrayidx67.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %246
  %248 = load i32, i32* %arrayidx67.9, align 4
  %cmp68.9 = icmp eq i32 %248, 75
  br i1 %cmp68.9, label %if.then70.9, label %if.else145.9

if.else145.9:                                     ; preds = %if.else.9
  %conv148.9 = trunc i32 %248 to i8
  %arrayidx150.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %246
  store i8 %conv148.9, i8* %arrayidx150.9, align 1
  br label %for.inc153.9

if.then70.9:                                      ; preds = %if.else.9
  %249 = add nuw nsw i64 %indvars.iv.9, %241
  %250 = add nsw i64 %249, -65
  %arrayidx76.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %250
  %251 = load i32, i32* %arrayidx76.9, align 4
  %cmp77.9 = icmp eq i32 %251, 255
  br i1 %cmp77.9, label %if.then138.9, label %lor.lhs.false79.9

lor.lhs.false79.9:                                ; preds = %if.then70.9
  %252 = add nuw nsw i64 %242, %indvars.iv.9
  %arrayidx84.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %252
  %253 = load i32, i32* %arrayidx84.9, align 4
  %cmp85.9 = icmp eq i32 %253, 255
  br i1 %cmp85.9, label %if.then138.9, label %lor.lhs.false87.9

lor.lhs.false87.9:                                ; preds = %lor.lhs.false79.9
  %254 = add nsw i64 %249, -63
  %arrayidx93.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %254
  %255 = load i32, i32* %arrayidx93.9, align 4
  %cmp94.9 = icmp eq i32 %255, 255
  br i1 %cmp94.9, label %if.then138.9, label %lor.lhs.false96.9

lor.lhs.false96.9:                                ; preds = %lor.lhs.false87.9
  %256 = add nuw nsw i64 %243, %indvars.iv.9
  %arrayidx101.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %256
  %257 = load i32, i32* %arrayidx101.9, align 4
  %cmp102.9 = icmp eq i32 %257, 255
  br i1 %cmp102.9, label %if.then138.9, label %lor.lhs.false104.9

lor.lhs.false104.9:                               ; preds = %lor.lhs.false96.9
  %258 = add nuw nsw i64 %244, %indvars.iv.9
  %arrayidx109.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %258
  %259 = load i32, i32* %arrayidx109.9, align 4
  %cmp110.9 = icmp eq i32 %259, 255
  br i1 %cmp110.9, label %if.then138.9, label %lor.lhs.false112.9

lor.lhs.false112.9:                               ; preds = %lor.lhs.false104.9
  %260 = add nuw nsw i64 %249, 63
  %arrayidx118.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %260
  %261 = load i32, i32* %arrayidx118.9, align 4
  %cmp119.9 = icmp eq i32 %261, 255
  br i1 %cmp119.9, label %if.then138.9, label %lor.lhs.false121.9

lor.lhs.false121.9:                               ; preds = %lor.lhs.false112.9
  %262 = add nuw nsw i64 %245, %indvars.iv.9
  %arrayidx126.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %262
  %263 = load i32, i32* %arrayidx126.9, align 4
  %cmp127.9 = icmp eq i32 %263, 255
  br i1 %cmp127.9, label %if.then138.9, label %lor.lhs.false129.9

lor.lhs.false129.9:                               ; preds = %lor.lhs.false121.9
  %264 = add nuw nsw i64 %249, 65
  %arrayidx135.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %264
  %265 = load i32, i32* %arrayidx135.9, align 4
  %cmp136.9 = icmp eq i32 %265, 255
  br i1 %cmp136.9, label %if.then138.9, label %if.else141.9

if.else141.9:                                     ; preds = %lor.lhs.false129.9
  %arrayidx143.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %246
  store i8 0, i8* %arrayidx143.9, align 1
  br label %for.inc153.9

if.then138.9:                                     ; preds = %lor.lhs.false129.9, %lor.lhs.false121.9, %lor.lhs.false112.9, %lor.lhs.false104.9, %lor.lhs.false96.9, %lor.lhs.false87.9, %lor.lhs.false79.9, %if.then70.9
  %arrayidx140.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %246
  store i8 -1, i8* %arrayidx140.9, align 1
  br label %for.inc153.9

for.inc153.9:                                     ; preds = %if.then138.9, %if.else141.9, %if.else145.9, %if.then63.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %exitcond.9 = icmp eq i64 %indvars.iv.next.9, 64
  br i1 %exitcond.9, label %for.inc156.9, label %for.body50.9, !llvm.loop !1

for.inc156.9:                                     ; preds = %for.inc153.9
  %indvars.iv.next19.9 = or i64 %indvars.iv18, 10
  %266 = shl nsw i64 %indvars.iv.next19.9, 6
  %267 = shl i64 %indvars.iv.next19.9, 6
  %268 = add nsw i64 %267, -64
  %269 = add nsw i64 %266, -1
  %270 = or i64 %266, 1
  %271 = or i64 %267, 64
  br label %for.body50.10

for.body50.10:                                    ; preds = %for.inc153.10, %for.inc156.9
  %indvars.iv.10 = phi i64 [ 0, %for.inc156.9 ], [ %indvars.iv.next.10, %for.inc153.10 ]
  %272 = add nuw nsw i64 %indvars.iv.10, %266
  %273 = trunc i64 %indvars.iv.10 to i32
  switch i32 %273, label %if.else.10 [
    i32 0, label %if.then63.10
    i32 63, label %if.then63.10
  ]

if.then63.10:                                     ; preds = %for.body50.10, %for.body50.10
  %arrayidx65.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %272
  store i8 0, i8* %arrayidx65.10, align 1
  br label %for.inc153.10

if.else.10:                                       ; preds = %for.body50.10
  %arrayidx67.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %272
  %274 = load i32, i32* %arrayidx67.10, align 4
  %cmp68.10 = icmp eq i32 %274, 75
  br i1 %cmp68.10, label %if.then70.10, label %if.else145.10

if.else145.10:                                    ; preds = %if.else.10
  %conv148.10 = trunc i32 %274 to i8
  %arrayidx150.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %272
  store i8 %conv148.10, i8* %arrayidx150.10, align 1
  br label %for.inc153.10

if.then70.10:                                     ; preds = %if.else.10
  %275 = add nuw nsw i64 %indvars.iv.10, %267
  %276 = add nsw i64 %275, -65
  %arrayidx76.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %276
  %277 = load i32, i32* %arrayidx76.10, align 4
  %cmp77.10 = icmp eq i32 %277, 255
  br i1 %cmp77.10, label %if.then138.10, label %lor.lhs.false79.10

lor.lhs.false79.10:                               ; preds = %if.then70.10
  %278 = add nuw nsw i64 %268, %indvars.iv.10
  %arrayidx84.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %278
  %279 = load i32, i32* %arrayidx84.10, align 4
  %cmp85.10 = icmp eq i32 %279, 255
  br i1 %cmp85.10, label %if.then138.10, label %lor.lhs.false87.10

lor.lhs.false87.10:                               ; preds = %lor.lhs.false79.10
  %280 = add nsw i64 %275, -63
  %arrayidx93.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %280
  %281 = load i32, i32* %arrayidx93.10, align 4
  %cmp94.10 = icmp eq i32 %281, 255
  br i1 %cmp94.10, label %if.then138.10, label %lor.lhs.false96.10

lor.lhs.false96.10:                               ; preds = %lor.lhs.false87.10
  %282 = add nuw nsw i64 %269, %indvars.iv.10
  %arrayidx101.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %282
  %283 = load i32, i32* %arrayidx101.10, align 4
  %cmp102.10 = icmp eq i32 %283, 255
  br i1 %cmp102.10, label %if.then138.10, label %lor.lhs.false104.10

lor.lhs.false104.10:                              ; preds = %lor.lhs.false96.10
  %284 = add nuw nsw i64 %270, %indvars.iv.10
  %arrayidx109.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %284
  %285 = load i32, i32* %arrayidx109.10, align 4
  %cmp110.10 = icmp eq i32 %285, 255
  br i1 %cmp110.10, label %if.then138.10, label %lor.lhs.false112.10

lor.lhs.false112.10:                              ; preds = %lor.lhs.false104.10
  %286 = add nuw nsw i64 %275, 63
  %arrayidx118.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %286
  %287 = load i32, i32* %arrayidx118.10, align 4
  %cmp119.10 = icmp eq i32 %287, 255
  br i1 %cmp119.10, label %if.then138.10, label %lor.lhs.false121.10

lor.lhs.false121.10:                              ; preds = %lor.lhs.false112.10
  %288 = add nuw nsw i64 %271, %indvars.iv.10
  %arrayidx126.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %288
  %289 = load i32, i32* %arrayidx126.10, align 4
  %cmp127.10 = icmp eq i32 %289, 255
  br i1 %cmp127.10, label %if.then138.10, label %lor.lhs.false129.10

lor.lhs.false129.10:                              ; preds = %lor.lhs.false121.10
  %290 = add nuw nsw i64 %275, 65
  %arrayidx135.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %290
  %291 = load i32, i32* %arrayidx135.10, align 4
  %cmp136.10 = icmp eq i32 %291, 255
  br i1 %cmp136.10, label %if.then138.10, label %if.else141.10

if.else141.10:                                    ; preds = %lor.lhs.false129.10
  %arrayidx143.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %272
  store i8 0, i8* %arrayidx143.10, align 1
  br label %for.inc153.10

if.then138.10:                                    ; preds = %lor.lhs.false129.10, %lor.lhs.false121.10, %lor.lhs.false112.10, %lor.lhs.false104.10, %lor.lhs.false96.10, %lor.lhs.false87.10, %lor.lhs.false79.10, %if.then70.10
  %arrayidx140.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %272
  store i8 -1, i8* %arrayidx140.10, align 1
  br label %for.inc153.10

for.inc153.10:                                    ; preds = %if.then138.10, %if.else141.10, %if.else145.10, %if.then63.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %exitcond.10 = icmp eq i64 %indvars.iv.next.10, 64
  br i1 %exitcond.10, label %for.inc156.10, label %for.body50.10, !llvm.loop !1

for.inc156.10:                                    ; preds = %for.inc153.10
  %indvars.iv.next19.10 = or i64 %indvars.iv18, 11
  %292 = shl nsw i64 %indvars.iv.next19.10, 6
  %293 = shl i64 %indvars.iv.next19.10, 6
  %294 = add nsw i64 %293, -64
  %295 = add nsw i64 %292, -1
  %296 = or i64 %292, 1
  %297 = add nuw nsw i64 %293, 64
  br label %for.body50.11

for.body50.11:                                    ; preds = %for.inc153.11, %for.inc156.10
  %indvars.iv.11 = phi i64 [ 0, %for.inc156.10 ], [ %indvars.iv.next.11, %for.inc153.11 ]
  %298 = add nuw nsw i64 %indvars.iv.11, %292
  %299 = trunc i64 %indvars.iv.11 to i32
  switch i32 %299, label %if.else.11 [
    i32 0, label %if.then63.11
    i32 63, label %if.then63.11
  ]

if.then63.11:                                     ; preds = %for.body50.11, %for.body50.11
  %arrayidx65.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %298
  store i8 0, i8* %arrayidx65.11, align 1
  br label %for.inc153.11

if.else.11:                                       ; preds = %for.body50.11
  %arrayidx67.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %298
  %300 = load i32, i32* %arrayidx67.11, align 4
  %cmp68.11 = icmp eq i32 %300, 75
  br i1 %cmp68.11, label %if.then70.11, label %if.else145.11

if.else145.11:                                    ; preds = %if.else.11
  %conv148.11 = trunc i32 %300 to i8
  %arrayidx150.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %298
  store i8 %conv148.11, i8* %arrayidx150.11, align 1
  br label %for.inc153.11

if.then70.11:                                     ; preds = %if.else.11
  %301 = add nuw nsw i64 %indvars.iv.11, %293
  %302 = add nsw i64 %301, -65
  %arrayidx76.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %302
  %303 = load i32, i32* %arrayidx76.11, align 4
  %cmp77.11 = icmp eq i32 %303, 255
  br i1 %cmp77.11, label %if.then138.11, label %lor.lhs.false79.11

lor.lhs.false79.11:                               ; preds = %if.then70.11
  %304 = add nuw nsw i64 %294, %indvars.iv.11
  %arrayidx84.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %304
  %305 = load i32, i32* %arrayidx84.11, align 4
  %cmp85.11 = icmp eq i32 %305, 255
  br i1 %cmp85.11, label %if.then138.11, label %lor.lhs.false87.11

lor.lhs.false87.11:                               ; preds = %lor.lhs.false79.11
  %306 = add nsw i64 %301, -63
  %arrayidx93.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %306
  %307 = load i32, i32* %arrayidx93.11, align 4
  %cmp94.11 = icmp eq i32 %307, 255
  br i1 %cmp94.11, label %if.then138.11, label %lor.lhs.false96.11

lor.lhs.false96.11:                               ; preds = %lor.lhs.false87.11
  %308 = add nuw nsw i64 %295, %indvars.iv.11
  %arrayidx101.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %308
  %309 = load i32, i32* %arrayidx101.11, align 4
  %cmp102.11 = icmp eq i32 %309, 255
  br i1 %cmp102.11, label %if.then138.11, label %lor.lhs.false104.11

lor.lhs.false104.11:                              ; preds = %lor.lhs.false96.11
  %310 = add nuw nsw i64 %296, %indvars.iv.11
  %arrayidx109.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %310
  %311 = load i32, i32* %arrayidx109.11, align 4
  %cmp110.11 = icmp eq i32 %311, 255
  br i1 %cmp110.11, label %if.then138.11, label %lor.lhs.false112.11

lor.lhs.false112.11:                              ; preds = %lor.lhs.false104.11
  %312 = add nuw nsw i64 %301, 63
  %arrayidx118.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %312
  %313 = load i32, i32* %arrayidx118.11, align 4
  %cmp119.11 = icmp eq i32 %313, 255
  br i1 %cmp119.11, label %if.then138.11, label %lor.lhs.false121.11

lor.lhs.false121.11:                              ; preds = %lor.lhs.false112.11
  %314 = add nuw nsw i64 %297, %indvars.iv.11
  %arrayidx126.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %314
  %315 = load i32, i32* %arrayidx126.11, align 4
  %cmp127.11 = icmp eq i32 %315, 255
  br i1 %cmp127.11, label %if.then138.11, label %lor.lhs.false129.11

lor.lhs.false129.11:                              ; preds = %lor.lhs.false121.11
  %316 = add nuw nsw i64 %301, 65
  %arrayidx135.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %316
  %317 = load i32, i32* %arrayidx135.11, align 4
  %cmp136.11 = icmp eq i32 %317, 255
  br i1 %cmp136.11, label %if.then138.11, label %if.else141.11

if.else141.11:                                    ; preds = %lor.lhs.false129.11
  %arrayidx143.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %298
  store i8 0, i8* %arrayidx143.11, align 1
  br label %for.inc153.11

if.then138.11:                                    ; preds = %lor.lhs.false129.11, %lor.lhs.false121.11, %lor.lhs.false112.11, %lor.lhs.false104.11, %lor.lhs.false96.11, %lor.lhs.false87.11, %lor.lhs.false79.11, %if.then70.11
  %arrayidx140.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %298
  store i8 -1, i8* %arrayidx140.11, align 1
  br label %for.inc153.11

for.inc153.11:                                    ; preds = %if.then138.11, %if.else141.11, %if.else145.11, %if.then63.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %exitcond.11 = icmp eq i64 %indvars.iv.next.11, 64
  br i1 %exitcond.11, label %for.inc156.11, label %for.body50.11, !llvm.loop !1

for.inc156.11:                                    ; preds = %for.inc153.11
  %indvars.iv.next19.11 = or i64 %indvars.iv18, 12
  %318 = shl nsw i64 %indvars.iv.next19.11, 6
  %319 = shl i64 %indvars.iv.next19.11, 6
  %320 = add nsw i64 %319, -64
  %321 = add nsw i64 %318, -1
  %322 = or i64 %318, 1
  %323 = or i64 %319, 64
  br label %for.body50.12

for.body50.12:                                    ; preds = %for.inc153.12, %for.inc156.11
  %indvars.iv.12 = phi i64 [ 0, %for.inc156.11 ], [ %indvars.iv.next.12, %for.inc153.12 ]
  %324 = add nuw nsw i64 %indvars.iv.12, %318
  %325 = trunc i64 %indvars.iv.12 to i32
  switch i32 %325, label %if.else.12 [
    i32 0, label %if.then63.12
    i32 63, label %if.then63.12
  ]

if.then63.12:                                     ; preds = %for.body50.12, %for.body50.12
  %arrayidx65.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %324
  store i8 0, i8* %arrayidx65.12, align 1
  br label %for.inc153.12

if.else.12:                                       ; preds = %for.body50.12
  %arrayidx67.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %324
  %326 = load i32, i32* %arrayidx67.12, align 4
  %cmp68.12 = icmp eq i32 %326, 75
  br i1 %cmp68.12, label %if.then70.12, label %if.else145.12

if.else145.12:                                    ; preds = %if.else.12
  %conv148.12 = trunc i32 %326 to i8
  %arrayidx150.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %324
  store i8 %conv148.12, i8* %arrayidx150.12, align 1
  br label %for.inc153.12

if.then70.12:                                     ; preds = %if.else.12
  %327 = add nuw nsw i64 %indvars.iv.12, %319
  %328 = add nsw i64 %327, -65
  %arrayidx76.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %328
  %329 = load i32, i32* %arrayidx76.12, align 4
  %cmp77.12 = icmp eq i32 %329, 255
  br i1 %cmp77.12, label %if.then138.12, label %lor.lhs.false79.12

lor.lhs.false79.12:                               ; preds = %if.then70.12
  %330 = add nuw nsw i64 %320, %indvars.iv.12
  %arrayidx84.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %330
  %331 = load i32, i32* %arrayidx84.12, align 4
  %cmp85.12 = icmp eq i32 %331, 255
  br i1 %cmp85.12, label %if.then138.12, label %lor.lhs.false87.12

lor.lhs.false87.12:                               ; preds = %lor.lhs.false79.12
  %332 = add nsw i64 %327, -63
  %arrayidx93.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %332
  %333 = load i32, i32* %arrayidx93.12, align 4
  %cmp94.12 = icmp eq i32 %333, 255
  br i1 %cmp94.12, label %if.then138.12, label %lor.lhs.false96.12

lor.lhs.false96.12:                               ; preds = %lor.lhs.false87.12
  %334 = add nuw nsw i64 %321, %indvars.iv.12
  %arrayidx101.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %334
  %335 = load i32, i32* %arrayidx101.12, align 4
  %cmp102.12 = icmp eq i32 %335, 255
  br i1 %cmp102.12, label %if.then138.12, label %lor.lhs.false104.12

lor.lhs.false104.12:                              ; preds = %lor.lhs.false96.12
  %336 = add nuw nsw i64 %322, %indvars.iv.12
  %arrayidx109.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %336
  %337 = load i32, i32* %arrayidx109.12, align 4
  %cmp110.12 = icmp eq i32 %337, 255
  br i1 %cmp110.12, label %if.then138.12, label %lor.lhs.false112.12

lor.lhs.false112.12:                              ; preds = %lor.lhs.false104.12
  %338 = add nuw nsw i64 %327, 63
  %arrayidx118.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %338
  %339 = load i32, i32* %arrayidx118.12, align 4
  %cmp119.12 = icmp eq i32 %339, 255
  br i1 %cmp119.12, label %if.then138.12, label %lor.lhs.false121.12

lor.lhs.false121.12:                              ; preds = %lor.lhs.false112.12
  %340 = add nuw nsw i64 %323, %indvars.iv.12
  %arrayidx126.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %340
  %341 = load i32, i32* %arrayidx126.12, align 4
  %cmp127.12 = icmp eq i32 %341, 255
  br i1 %cmp127.12, label %if.then138.12, label %lor.lhs.false129.12

lor.lhs.false129.12:                              ; preds = %lor.lhs.false121.12
  %342 = add nuw nsw i64 %327, 65
  %arrayidx135.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %342
  %343 = load i32, i32* %arrayidx135.12, align 4
  %cmp136.12 = icmp eq i32 %343, 255
  br i1 %cmp136.12, label %if.then138.12, label %if.else141.12

if.else141.12:                                    ; preds = %lor.lhs.false129.12
  %arrayidx143.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %324
  store i8 0, i8* %arrayidx143.12, align 1
  br label %for.inc153.12

if.then138.12:                                    ; preds = %lor.lhs.false129.12, %lor.lhs.false121.12, %lor.lhs.false112.12, %lor.lhs.false104.12, %lor.lhs.false96.12, %lor.lhs.false87.12, %lor.lhs.false79.12, %if.then70.12
  %arrayidx140.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %324
  store i8 -1, i8* %arrayidx140.12, align 1
  br label %for.inc153.12

for.inc153.12:                                    ; preds = %if.then138.12, %if.else141.12, %if.else145.12, %if.then63.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %exitcond.12 = icmp eq i64 %indvars.iv.next.12, 64
  br i1 %exitcond.12, label %for.inc156.12, label %for.body50.12, !llvm.loop !1

for.inc156.12:                                    ; preds = %for.inc153.12
  %indvars.iv.next19.12 = or i64 %indvars.iv18, 13
  %344 = shl nsw i64 %indvars.iv.next19.12, 6
  %345 = shl i64 %indvars.iv.next19.12, 6
  %346 = add nsw i64 %345, -64
  %347 = add nsw i64 %344, -1
  %348 = or i64 %344, 1
  %349 = add nuw nsw i64 %345, 64
  br label %for.body50.13

for.body50.13:                                    ; preds = %for.inc153.13, %for.inc156.12
  %indvars.iv.13 = phi i64 [ 0, %for.inc156.12 ], [ %indvars.iv.next.13, %for.inc153.13 ]
  %350 = add nuw nsw i64 %indvars.iv.13, %344
  %351 = trunc i64 %indvars.iv.13 to i32
  switch i32 %351, label %if.else.13 [
    i32 0, label %if.then63.13
    i32 63, label %if.then63.13
  ]

if.then63.13:                                     ; preds = %for.body50.13, %for.body50.13
  %arrayidx65.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %350
  store i8 0, i8* %arrayidx65.13, align 1
  br label %for.inc153.13

if.else.13:                                       ; preds = %for.body50.13
  %arrayidx67.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %350
  %352 = load i32, i32* %arrayidx67.13, align 4
  %cmp68.13 = icmp eq i32 %352, 75
  br i1 %cmp68.13, label %if.then70.13, label %if.else145.13

if.else145.13:                                    ; preds = %if.else.13
  %conv148.13 = trunc i32 %352 to i8
  %arrayidx150.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %350
  store i8 %conv148.13, i8* %arrayidx150.13, align 1
  br label %for.inc153.13

if.then70.13:                                     ; preds = %if.else.13
  %353 = add nuw nsw i64 %indvars.iv.13, %345
  %354 = add nsw i64 %353, -65
  %arrayidx76.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %354
  %355 = load i32, i32* %arrayidx76.13, align 4
  %cmp77.13 = icmp eq i32 %355, 255
  br i1 %cmp77.13, label %if.then138.13, label %lor.lhs.false79.13

lor.lhs.false79.13:                               ; preds = %if.then70.13
  %356 = add nuw nsw i64 %346, %indvars.iv.13
  %arrayidx84.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %356
  %357 = load i32, i32* %arrayidx84.13, align 4
  %cmp85.13 = icmp eq i32 %357, 255
  br i1 %cmp85.13, label %if.then138.13, label %lor.lhs.false87.13

lor.lhs.false87.13:                               ; preds = %lor.lhs.false79.13
  %358 = add nsw i64 %353, -63
  %arrayidx93.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %358
  %359 = load i32, i32* %arrayidx93.13, align 4
  %cmp94.13 = icmp eq i32 %359, 255
  br i1 %cmp94.13, label %if.then138.13, label %lor.lhs.false96.13

lor.lhs.false96.13:                               ; preds = %lor.lhs.false87.13
  %360 = add nuw nsw i64 %347, %indvars.iv.13
  %arrayidx101.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %360
  %361 = load i32, i32* %arrayidx101.13, align 4
  %cmp102.13 = icmp eq i32 %361, 255
  br i1 %cmp102.13, label %if.then138.13, label %lor.lhs.false104.13

lor.lhs.false104.13:                              ; preds = %lor.lhs.false96.13
  %362 = add nuw nsw i64 %348, %indvars.iv.13
  %arrayidx109.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %362
  %363 = load i32, i32* %arrayidx109.13, align 4
  %cmp110.13 = icmp eq i32 %363, 255
  br i1 %cmp110.13, label %if.then138.13, label %lor.lhs.false112.13

lor.lhs.false112.13:                              ; preds = %lor.lhs.false104.13
  %364 = add nuw nsw i64 %353, 63
  %arrayidx118.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %364
  %365 = load i32, i32* %arrayidx118.13, align 4
  %cmp119.13 = icmp eq i32 %365, 255
  br i1 %cmp119.13, label %if.then138.13, label %lor.lhs.false121.13

lor.lhs.false121.13:                              ; preds = %lor.lhs.false112.13
  %366 = add nuw nsw i64 %349, %indvars.iv.13
  %arrayidx126.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %366
  %367 = load i32, i32* %arrayidx126.13, align 4
  %cmp127.13 = icmp eq i32 %367, 255
  br i1 %cmp127.13, label %if.then138.13, label %lor.lhs.false129.13

lor.lhs.false129.13:                              ; preds = %lor.lhs.false121.13
  %368 = add nuw nsw i64 %353, 65
  %arrayidx135.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %368
  %369 = load i32, i32* %arrayidx135.13, align 4
  %cmp136.13 = icmp eq i32 %369, 255
  br i1 %cmp136.13, label %if.then138.13, label %if.else141.13

if.else141.13:                                    ; preds = %lor.lhs.false129.13
  %arrayidx143.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %350
  store i8 0, i8* %arrayidx143.13, align 1
  br label %for.inc153.13

if.then138.13:                                    ; preds = %lor.lhs.false129.13, %lor.lhs.false121.13, %lor.lhs.false112.13, %lor.lhs.false104.13, %lor.lhs.false96.13, %lor.lhs.false87.13, %lor.lhs.false79.13, %if.then70.13
  %arrayidx140.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %350
  store i8 -1, i8* %arrayidx140.13, align 1
  br label %for.inc153.13

for.inc153.13:                                    ; preds = %if.then138.13, %if.else141.13, %if.else145.13, %if.then63.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %exitcond.13 = icmp eq i64 %indvars.iv.next.13, 64
  br i1 %exitcond.13, label %for.inc156.13, label %for.body50.13, !llvm.loop !1

for.inc156.13:                                    ; preds = %for.inc153.13
  %indvars.iv.next19.13 = or i64 %indvars.iv18, 14
  %370 = shl nsw i64 %indvars.iv.next19.13, 6
  %371 = shl i64 %indvars.iv.next19.13, 6
  %372 = add nsw i64 %371, -64
  %373 = add nsw i64 %370, -1
  %374 = or i64 %370, 1
  %375 = or i64 %371, 64
  br label %for.body50.14

for.body50.14:                                    ; preds = %for.inc153.14, %for.inc156.13
  %indvars.iv.14 = phi i64 [ 0, %for.inc156.13 ], [ %indvars.iv.next.14, %for.inc153.14 ]
  %376 = add nuw nsw i64 %indvars.iv.14, %370
  %377 = trunc i64 %indvars.iv.14 to i32
  switch i32 %377, label %if.else.14 [
    i32 0, label %if.then63.14
    i32 63, label %if.then63.14
  ]

if.then63.14:                                     ; preds = %for.body50.14, %for.body50.14
  %arrayidx65.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %376
  store i8 0, i8* %arrayidx65.14, align 1
  br label %for.inc153.14

if.else.14:                                       ; preds = %for.body50.14
  %arrayidx67.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %376
  %378 = load i32, i32* %arrayidx67.14, align 4
  %cmp68.14 = icmp eq i32 %378, 75
  br i1 %cmp68.14, label %if.then70.14, label %if.else145.14

if.else145.14:                                    ; preds = %if.else.14
  %conv148.14 = trunc i32 %378 to i8
  %arrayidx150.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %376
  store i8 %conv148.14, i8* %arrayidx150.14, align 1
  br label %for.inc153.14

if.then70.14:                                     ; preds = %if.else.14
  %379 = add nuw nsw i64 %indvars.iv.14, %371
  %380 = add nsw i64 %379, -65
  %arrayidx76.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %380
  %381 = load i32, i32* %arrayidx76.14, align 4
  %cmp77.14 = icmp eq i32 %381, 255
  br i1 %cmp77.14, label %if.then138.14, label %lor.lhs.false79.14

lor.lhs.false79.14:                               ; preds = %if.then70.14
  %382 = add nuw nsw i64 %372, %indvars.iv.14
  %arrayidx84.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %382
  %383 = load i32, i32* %arrayidx84.14, align 4
  %cmp85.14 = icmp eq i32 %383, 255
  br i1 %cmp85.14, label %if.then138.14, label %lor.lhs.false87.14

lor.lhs.false87.14:                               ; preds = %lor.lhs.false79.14
  %384 = add nsw i64 %379, -63
  %arrayidx93.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %384
  %385 = load i32, i32* %arrayidx93.14, align 4
  %cmp94.14 = icmp eq i32 %385, 255
  br i1 %cmp94.14, label %if.then138.14, label %lor.lhs.false96.14

lor.lhs.false96.14:                               ; preds = %lor.lhs.false87.14
  %386 = add nuw nsw i64 %373, %indvars.iv.14
  %arrayidx101.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %386
  %387 = load i32, i32* %arrayidx101.14, align 4
  %cmp102.14 = icmp eq i32 %387, 255
  br i1 %cmp102.14, label %if.then138.14, label %lor.lhs.false104.14

lor.lhs.false104.14:                              ; preds = %lor.lhs.false96.14
  %388 = add nuw nsw i64 %374, %indvars.iv.14
  %arrayidx109.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %388
  %389 = load i32, i32* %arrayidx109.14, align 4
  %cmp110.14 = icmp eq i32 %389, 255
  br i1 %cmp110.14, label %if.then138.14, label %lor.lhs.false112.14

lor.lhs.false112.14:                              ; preds = %lor.lhs.false104.14
  %390 = add nuw nsw i64 %379, 63
  %arrayidx118.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %390
  %391 = load i32, i32* %arrayidx118.14, align 4
  %cmp119.14 = icmp eq i32 %391, 255
  br i1 %cmp119.14, label %if.then138.14, label %lor.lhs.false121.14

lor.lhs.false121.14:                              ; preds = %lor.lhs.false112.14
  %392 = add nuw nsw i64 %375, %indvars.iv.14
  %arrayidx126.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %392
  %393 = load i32, i32* %arrayidx126.14, align 4
  %cmp127.14 = icmp eq i32 %393, 255
  br i1 %cmp127.14, label %if.then138.14, label %lor.lhs.false129.14

lor.lhs.false129.14:                              ; preds = %lor.lhs.false121.14
  %394 = add nuw nsw i64 %379, 65
  %arrayidx135.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %394
  %395 = load i32, i32* %arrayidx135.14, align 4
  %cmp136.14 = icmp eq i32 %395, 255
  br i1 %cmp136.14, label %if.then138.14, label %if.else141.14

if.else141.14:                                    ; preds = %lor.lhs.false129.14
  %arrayidx143.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %376
  store i8 0, i8* %arrayidx143.14, align 1
  br label %for.inc153.14

if.then138.14:                                    ; preds = %lor.lhs.false129.14, %lor.lhs.false121.14, %lor.lhs.false112.14, %lor.lhs.false104.14, %lor.lhs.false96.14, %lor.lhs.false87.14, %lor.lhs.false79.14, %if.then70.14
  %arrayidx140.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %376
  store i8 -1, i8* %arrayidx140.14, align 1
  br label %for.inc153.14

for.inc153.14:                                    ; preds = %if.then138.14, %if.else141.14, %if.else145.14, %if.then63.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %exitcond.14 = icmp eq i64 %indvars.iv.next.14, 64
  br i1 %exitcond.14, label %for.inc156.14, label %for.body50.14, !llvm.loop !1

for.inc156.14:                                    ; preds = %for.inc153.14
  %indvars.iv.next19.14 = or i64 %indvars.iv18, 15
  %396 = shl nsw i64 %indvars.iv.next19.14, 6
  %397 = shl i64 %indvars.iv.next19.14, 6
  %398 = add nsw i64 %397, -64
  %399 = add nsw i64 %396, -1
  %400 = or i64 %396, 1
  %401 = add nuw nsw i64 %397, 64
  br label %for.body50.15

for.body50.15:                                    ; preds = %for.inc153.15, %for.inc156.14
  %indvars.iv.15 = phi i64 [ 0, %for.inc156.14 ], [ %indvars.iv.next.15, %for.inc153.15 ]
  %402 = add nuw nsw i64 %indvars.iv.15, %396
  %403 = trunc i64 %indvars.iv.15 to i32
  switch i32 %403, label %if.else.15 [
    i32 0, label %if.then63.15
    i32 63, label %if.then63.15
  ]

if.then63.15:                                     ; preds = %for.body50.15, %for.body50.15
  %arrayidx65.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %402
  store i8 0, i8* %arrayidx65.15, align 1
  br label %for.inc153.15

if.else.15:                                       ; preds = %for.body50.15
  %arrayidx67.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %402
  %404 = load i32, i32* %arrayidx67.15, align 4
  %cmp68.15 = icmp eq i32 %404, 75
  br i1 %cmp68.15, label %if.then70.15, label %if.else145.15

if.else145.15:                                    ; preds = %if.else.15
  %conv148.15 = trunc i32 %404 to i8
  %arrayidx150.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %402
  store i8 %conv148.15, i8* %arrayidx150.15, align 1
  br label %for.inc153.15

if.then70.15:                                     ; preds = %if.else.15
  %405 = add nuw nsw i64 %indvars.iv.15, %397
  %406 = add nsw i64 %405, -65
  %arrayidx76.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %406
  %407 = load i32, i32* %arrayidx76.15, align 4
  %cmp77.15 = icmp eq i32 %407, 255
  br i1 %cmp77.15, label %if.then138.15, label %lor.lhs.false79.15

lor.lhs.false79.15:                               ; preds = %if.then70.15
  %408 = add nuw nsw i64 %398, %indvars.iv.15
  %arrayidx84.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %408
  %409 = load i32, i32* %arrayidx84.15, align 4
  %cmp85.15 = icmp eq i32 %409, 255
  br i1 %cmp85.15, label %if.then138.15, label %lor.lhs.false87.15

lor.lhs.false87.15:                               ; preds = %lor.lhs.false79.15
  %410 = add nsw i64 %405, -63
  %arrayidx93.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %410
  %411 = load i32, i32* %arrayidx93.15, align 4
  %cmp94.15 = icmp eq i32 %411, 255
  br i1 %cmp94.15, label %if.then138.15, label %lor.lhs.false96.15

lor.lhs.false96.15:                               ; preds = %lor.lhs.false87.15
  %412 = add nuw nsw i64 %399, %indvars.iv.15
  %arrayidx101.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %412
  %413 = load i32, i32* %arrayidx101.15, align 4
  %cmp102.15 = icmp eq i32 %413, 255
  br i1 %cmp102.15, label %if.then138.15, label %lor.lhs.false104.15

lor.lhs.false104.15:                              ; preds = %lor.lhs.false96.15
  %414 = add nuw nsw i64 %400, %indvars.iv.15
  %arrayidx109.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %414
  %415 = load i32, i32* %arrayidx109.15, align 4
  %cmp110.15 = icmp eq i32 %415, 255
  br i1 %cmp110.15, label %if.then138.15, label %lor.lhs.false112.15

lor.lhs.false112.15:                              ; preds = %lor.lhs.false104.15
  %416 = add nuw nsw i64 %405, 63
  %arrayidx118.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %416
  %417 = load i32, i32* %arrayidx118.15, align 4
  %cmp119.15 = icmp eq i32 %417, 255
  br i1 %cmp119.15, label %if.then138.15, label %lor.lhs.false121.15

lor.lhs.false121.15:                              ; preds = %lor.lhs.false112.15
  %418 = add nuw nsw i64 %401, %indvars.iv.15
  %arrayidx126.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %418
  %419 = load i32, i32* %arrayidx126.15, align 4
  %cmp127.15 = icmp eq i32 %419, 255
  br i1 %cmp127.15, label %if.then138.15, label %lor.lhs.false129.15

lor.lhs.false129.15:                              ; preds = %lor.lhs.false121.15
  %420 = add nuw nsw i64 %405, 65
  %arrayidx135.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %420
  %421 = load i32, i32* %arrayidx135.15, align 4
  %cmp136.15 = icmp eq i32 %421, 255
  br i1 %cmp136.15, label %if.then138.15, label %if.else141.15

if.else141.15:                                    ; preds = %lor.lhs.false129.15
  %arrayidx143.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %402
  store i8 0, i8* %arrayidx143.15, align 1
  br label %for.inc153.15

if.then138.15:                                    ; preds = %lor.lhs.false129.15, %lor.lhs.false121.15, %lor.lhs.false112.15, %lor.lhs.false104.15, %lor.lhs.false96.15, %lor.lhs.false87.15, %lor.lhs.false79.15, %if.then70.15
  %arrayidx140.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %402
  store i8 -1, i8* %arrayidx140.15, align 1
  br label %for.inc153.15

for.inc153.15:                                    ; preds = %if.then138.15, %if.else141.15, %if.else145.15, %if.then63.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %exitcond.15 = icmp eq i64 %indvars.iv.next.15, 64
  br i1 %exitcond.15, label %for.inc156.15, label %for.body50.15, !llvm.loop !1

for.inc156.15:                                    ; preds = %for.inc153.15
  %indvars.iv.next19.15 = or i64 %indvars.iv18, 16
  %422 = shl nsw i64 %indvars.iv.next19.15, 6
  %423 = shl i64 %indvars.iv.next19.15, 6
  %424 = add nsw i64 %423, -64
  %425 = add nsw i64 %422, -1
  %426 = or i64 %422, 1
  %427 = or i64 %423, 64
  br label %for.body50.16

for.body50.16:                                    ; preds = %for.inc153.16, %for.inc156.15
  %indvars.iv.16 = phi i64 [ 0, %for.inc156.15 ], [ %indvars.iv.next.16, %for.inc153.16 ]
  %428 = add nuw nsw i64 %indvars.iv.16, %422
  %429 = trunc i64 %indvars.iv.16 to i32
  switch i32 %429, label %if.else.16 [
    i32 0, label %if.then63.16
    i32 63, label %if.then63.16
  ]

if.then63.16:                                     ; preds = %for.body50.16, %for.body50.16
  %arrayidx65.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %428
  store i8 0, i8* %arrayidx65.16, align 1
  br label %for.inc153.16

if.else.16:                                       ; preds = %for.body50.16
  %arrayidx67.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %428
  %430 = load i32, i32* %arrayidx67.16, align 4
  %cmp68.16 = icmp eq i32 %430, 75
  br i1 %cmp68.16, label %if.then70.16, label %if.else145.16

if.else145.16:                                    ; preds = %if.else.16
  %conv148.16 = trunc i32 %430 to i8
  %arrayidx150.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %428
  store i8 %conv148.16, i8* %arrayidx150.16, align 1
  br label %for.inc153.16

if.then70.16:                                     ; preds = %if.else.16
  %431 = add nuw nsw i64 %indvars.iv.16, %423
  %432 = add nsw i64 %431, -65
  %arrayidx76.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %432
  %433 = load i32, i32* %arrayidx76.16, align 4
  %cmp77.16 = icmp eq i32 %433, 255
  br i1 %cmp77.16, label %if.then138.16, label %lor.lhs.false79.16

lor.lhs.false79.16:                               ; preds = %if.then70.16
  %434 = add nuw nsw i64 %424, %indvars.iv.16
  %arrayidx84.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %434
  %435 = load i32, i32* %arrayidx84.16, align 4
  %cmp85.16 = icmp eq i32 %435, 255
  br i1 %cmp85.16, label %if.then138.16, label %lor.lhs.false87.16

lor.lhs.false87.16:                               ; preds = %lor.lhs.false79.16
  %436 = add nsw i64 %431, -63
  %arrayidx93.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %436
  %437 = load i32, i32* %arrayidx93.16, align 4
  %cmp94.16 = icmp eq i32 %437, 255
  br i1 %cmp94.16, label %if.then138.16, label %lor.lhs.false96.16

lor.lhs.false96.16:                               ; preds = %lor.lhs.false87.16
  %438 = add nuw nsw i64 %425, %indvars.iv.16
  %arrayidx101.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %438
  %439 = load i32, i32* %arrayidx101.16, align 4
  %cmp102.16 = icmp eq i32 %439, 255
  br i1 %cmp102.16, label %if.then138.16, label %lor.lhs.false104.16

lor.lhs.false104.16:                              ; preds = %lor.lhs.false96.16
  %440 = add nuw nsw i64 %426, %indvars.iv.16
  %arrayidx109.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %440
  %441 = load i32, i32* %arrayidx109.16, align 4
  %cmp110.16 = icmp eq i32 %441, 255
  br i1 %cmp110.16, label %if.then138.16, label %lor.lhs.false112.16

lor.lhs.false112.16:                              ; preds = %lor.lhs.false104.16
  %442 = add nuw nsw i64 %431, 63
  %arrayidx118.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %442
  %443 = load i32, i32* %arrayidx118.16, align 4
  %cmp119.16 = icmp eq i32 %443, 255
  br i1 %cmp119.16, label %if.then138.16, label %lor.lhs.false121.16

lor.lhs.false121.16:                              ; preds = %lor.lhs.false112.16
  %444 = add nuw nsw i64 %427, %indvars.iv.16
  %arrayidx126.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %444
  %445 = load i32, i32* %arrayidx126.16, align 4
  %cmp127.16 = icmp eq i32 %445, 255
  br i1 %cmp127.16, label %if.then138.16, label %lor.lhs.false129.16

lor.lhs.false129.16:                              ; preds = %lor.lhs.false121.16
  %446 = add nuw nsw i64 %431, 65
  %arrayidx135.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %446
  %447 = load i32, i32* %arrayidx135.16, align 4
  %cmp136.16 = icmp eq i32 %447, 255
  br i1 %cmp136.16, label %if.then138.16, label %if.else141.16

if.else141.16:                                    ; preds = %lor.lhs.false129.16
  %arrayidx143.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %428
  store i8 0, i8* %arrayidx143.16, align 1
  br label %for.inc153.16

if.then138.16:                                    ; preds = %lor.lhs.false129.16, %lor.lhs.false121.16, %lor.lhs.false112.16, %lor.lhs.false104.16, %lor.lhs.false96.16, %lor.lhs.false87.16, %lor.lhs.false79.16, %if.then70.16
  %arrayidx140.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %428
  store i8 -1, i8* %arrayidx140.16, align 1
  br label %for.inc153.16

for.inc153.16:                                    ; preds = %if.then138.16, %if.else141.16, %if.else145.16, %if.then63.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %exitcond.16 = icmp eq i64 %indvars.iv.next.16, 64
  br i1 %exitcond.16, label %for.inc156.16, label %for.body50.16, !llvm.loop !1

for.inc156.16:                                    ; preds = %for.inc153.16
  %indvars.iv.next19.16 = or i64 %indvars.iv18, 17
  %448 = shl nsw i64 %indvars.iv.next19.16, 6
  %449 = shl i64 %indvars.iv.next19.16, 6
  %450 = add nsw i64 %449, -64
  %451 = add nsw i64 %448, -1
  %452 = or i64 %448, 1
  %453 = add nuw nsw i64 %449, 64
  br label %for.body50.17

for.body50.17:                                    ; preds = %for.inc153.17, %for.inc156.16
  %indvars.iv.17 = phi i64 [ 0, %for.inc156.16 ], [ %indvars.iv.next.17, %for.inc153.17 ]
  %454 = add nuw nsw i64 %indvars.iv.17, %448
  %455 = trunc i64 %indvars.iv.17 to i32
  switch i32 %455, label %if.else.17 [
    i32 0, label %if.then63.17
    i32 63, label %if.then63.17
  ]

if.then63.17:                                     ; preds = %for.body50.17, %for.body50.17
  %arrayidx65.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %454
  store i8 0, i8* %arrayidx65.17, align 1
  br label %for.inc153.17

if.else.17:                                       ; preds = %for.body50.17
  %arrayidx67.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %454
  %456 = load i32, i32* %arrayidx67.17, align 4
  %cmp68.17 = icmp eq i32 %456, 75
  br i1 %cmp68.17, label %if.then70.17, label %if.else145.17

if.else145.17:                                    ; preds = %if.else.17
  %conv148.17 = trunc i32 %456 to i8
  %arrayidx150.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %454
  store i8 %conv148.17, i8* %arrayidx150.17, align 1
  br label %for.inc153.17

if.then70.17:                                     ; preds = %if.else.17
  %457 = add nuw nsw i64 %indvars.iv.17, %449
  %458 = add nsw i64 %457, -65
  %arrayidx76.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %458
  %459 = load i32, i32* %arrayidx76.17, align 4
  %cmp77.17 = icmp eq i32 %459, 255
  br i1 %cmp77.17, label %if.then138.17, label %lor.lhs.false79.17

lor.lhs.false79.17:                               ; preds = %if.then70.17
  %460 = add nuw nsw i64 %450, %indvars.iv.17
  %arrayidx84.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %460
  %461 = load i32, i32* %arrayidx84.17, align 4
  %cmp85.17 = icmp eq i32 %461, 255
  br i1 %cmp85.17, label %if.then138.17, label %lor.lhs.false87.17

lor.lhs.false87.17:                               ; preds = %lor.lhs.false79.17
  %462 = add nsw i64 %457, -63
  %arrayidx93.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %462
  %463 = load i32, i32* %arrayidx93.17, align 4
  %cmp94.17 = icmp eq i32 %463, 255
  br i1 %cmp94.17, label %if.then138.17, label %lor.lhs.false96.17

lor.lhs.false96.17:                               ; preds = %lor.lhs.false87.17
  %464 = add nuw nsw i64 %451, %indvars.iv.17
  %arrayidx101.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %464
  %465 = load i32, i32* %arrayidx101.17, align 4
  %cmp102.17 = icmp eq i32 %465, 255
  br i1 %cmp102.17, label %if.then138.17, label %lor.lhs.false104.17

lor.lhs.false104.17:                              ; preds = %lor.lhs.false96.17
  %466 = add nuw nsw i64 %452, %indvars.iv.17
  %arrayidx109.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %466
  %467 = load i32, i32* %arrayidx109.17, align 4
  %cmp110.17 = icmp eq i32 %467, 255
  br i1 %cmp110.17, label %if.then138.17, label %lor.lhs.false112.17

lor.lhs.false112.17:                              ; preds = %lor.lhs.false104.17
  %468 = add nuw nsw i64 %457, 63
  %arrayidx118.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %468
  %469 = load i32, i32* %arrayidx118.17, align 4
  %cmp119.17 = icmp eq i32 %469, 255
  br i1 %cmp119.17, label %if.then138.17, label %lor.lhs.false121.17

lor.lhs.false121.17:                              ; preds = %lor.lhs.false112.17
  %470 = add nuw nsw i64 %453, %indvars.iv.17
  %arrayidx126.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %470
  %471 = load i32, i32* %arrayidx126.17, align 4
  %cmp127.17 = icmp eq i32 %471, 255
  br i1 %cmp127.17, label %if.then138.17, label %lor.lhs.false129.17

lor.lhs.false129.17:                              ; preds = %lor.lhs.false121.17
  %472 = add nuw nsw i64 %457, 65
  %arrayidx135.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %472
  %473 = load i32, i32* %arrayidx135.17, align 4
  %cmp136.17 = icmp eq i32 %473, 255
  br i1 %cmp136.17, label %if.then138.17, label %if.else141.17

if.else141.17:                                    ; preds = %lor.lhs.false129.17
  %arrayidx143.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %454
  store i8 0, i8* %arrayidx143.17, align 1
  br label %for.inc153.17

if.then138.17:                                    ; preds = %lor.lhs.false129.17, %lor.lhs.false121.17, %lor.lhs.false112.17, %lor.lhs.false104.17, %lor.lhs.false96.17, %lor.lhs.false87.17, %lor.lhs.false79.17, %if.then70.17
  %arrayidx140.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %454
  store i8 -1, i8* %arrayidx140.17, align 1
  br label %for.inc153.17

for.inc153.17:                                    ; preds = %if.then138.17, %if.else141.17, %if.else145.17, %if.then63.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %exitcond.17 = icmp eq i64 %indvars.iv.next.17, 64
  br i1 %exitcond.17, label %for.inc156.17, label %for.body50.17, !llvm.loop !1

for.inc156.17:                                    ; preds = %for.inc153.17
  %indvars.iv.next19.17 = or i64 %indvars.iv18, 18
  %474 = shl nsw i64 %indvars.iv.next19.17, 6
  %475 = shl i64 %indvars.iv.next19.17, 6
  %476 = add nsw i64 %475, -64
  %477 = add nsw i64 %474, -1
  %478 = or i64 %474, 1
  %479 = or i64 %475, 64
  br label %for.body50.18

for.body50.18:                                    ; preds = %for.inc153.18, %for.inc156.17
  %indvars.iv.18 = phi i64 [ 0, %for.inc156.17 ], [ %indvars.iv.next.18, %for.inc153.18 ]
  %480 = add nuw nsw i64 %indvars.iv.18, %474
  %481 = trunc i64 %indvars.iv.18 to i32
  switch i32 %481, label %if.else.18 [
    i32 0, label %if.then63.18
    i32 63, label %if.then63.18
  ]

if.then63.18:                                     ; preds = %for.body50.18, %for.body50.18
  %arrayidx65.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %480
  store i8 0, i8* %arrayidx65.18, align 1
  br label %for.inc153.18

if.else.18:                                       ; preds = %for.body50.18
  %arrayidx67.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %480
  %482 = load i32, i32* %arrayidx67.18, align 4
  %cmp68.18 = icmp eq i32 %482, 75
  br i1 %cmp68.18, label %if.then70.18, label %if.else145.18

if.else145.18:                                    ; preds = %if.else.18
  %conv148.18 = trunc i32 %482 to i8
  %arrayidx150.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %480
  store i8 %conv148.18, i8* %arrayidx150.18, align 1
  br label %for.inc153.18

if.then70.18:                                     ; preds = %if.else.18
  %483 = add nuw nsw i64 %indvars.iv.18, %475
  %484 = add nsw i64 %483, -65
  %arrayidx76.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %484
  %485 = load i32, i32* %arrayidx76.18, align 4
  %cmp77.18 = icmp eq i32 %485, 255
  br i1 %cmp77.18, label %if.then138.18, label %lor.lhs.false79.18

lor.lhs.false79.18:                               ; preds = %if.then70.18
  %486 = add nuw nsw i64 %476, %indvars.iv.18
  %arrayidx84.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %486
  %487 = load i32, i32* %arrayidx84.18, align 4
  %cmp85.18 = icmp eq i32 %487, 255
  br i1 %cmp85.18, label %if.then138.18, label %lor.lhs.false87.18

lor.lhs.false87.18:                               ; preds = %lor.lhs.false79.18
  %488 = add nsw i64 %483, -63
  %arrayidx93.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %488
  %489 = load i32, i32* %arrayidx93.18, align 4
  %cmp94.18 = icmp eq i32 %489, 255
  br i1 %cmp94.18, label %if.then138.18, label %lor.lhs.false96.18

lor.lhs.false96.18:                               ; preds = %lor.lhs.false87.18
  %490 = add nuw nsw i64 %477, %indvars.iv.18
  %arrayidx101.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %490
  %491 = load i32, i32* %arrayidx101.18, align 4
  %cmp102.18 = icmp eq i32 %491, 255
  br i1 %cmp102.18, label %if.then138.18, label %lor.lhs.false104.18

lor.lhs.false104.18:                              ; preds = %lor.lhs.false96.18
  %492 = add nuw nsw i64 %478, %indvars.iv.18
  %arrayidx109.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %492
  %493 = load i32, i32* %arrayidx109.18, align 4
  %cmp110.18 = icmp eq i32 %493, 255
  br i1 %cmp110.18, label %if.then138.18, label %lor.lhs.false112.18

lor.lhs.false112.18:                              ; preds = %lor.lhs.false104.18
  %494 = add nuw nsw i64 %483, 63
  %arrayidx118.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %494
  %495 = load i32, i32* %arrayidx118.18, align 4
  %cmp119.18 = icmp eq i32 %495, 255
  br i1 %cmp119.18, label %if.then138.18, label %lor.lhs.false121.18

lor.lhs.false121.18:                              ; preds = %lor.lhs.false112.18
  %496 = add nuw nsw i64 %479, %indvars.iv.18
  %arrayidx126.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %496
  %497 = load i32, i32* %arrayidx126.18, align 4
  %cmp127.18 = icmp eq i32 %497, 255
  br i1 %cmp127.18, label %if.then138.18, label %lor.lhs.false129.18

lor.lhs.false129.18:                              ; preds = %lor.lhs.false121.18
  %498 = add nuw nsw i64 %483, 65
  %arrayidx135.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %498
  %499 = load i32, i32* %arrayidx135.18, align 4
  %cmp136.18 = icmp eq i32 %499, 255
  br i1 %cmp136.18, label %if.then138.18, label %if.else141.18

if.else141.18:                                    ; preds = %lor.lhs.false129.18
  %arrayidx143.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %480
  store i8 0, i8* %arrayidx143.18, align 1
  br label %for.inc153.18

if.then138.18:                                    ; preds = %lor.lhs.false129.18, %lor.lhs.false121.18, %lor.lhs.false112.18, %lor.lhs.false104.18, %lor.lhs.false96.18, %lor.lhs.false87.18, %lor.lhs.false79.18, %if.then70.18
  %arrayidx140.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %480
  store i8 -1, i8* %arrayidx140.18, align 1
  br label %for.inc153.18

for.inc153.18:                                    ; preds = %if.then138.18, %if.else141.18, %if.else145.18, %if.then63.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %exitcond.18 = icmp eq i64 %indvars.iv.next.18, 64
  br i1 %exitcond.18, label %for.inc156.18, label %for.body50.18, !llvm.loop !1

for.inc156.18:                                    ; preds = %for.inc153.18
  %indvars.iv.next19.18 = or i64 %indvars.iv18, 19
  %500 = shl nsw i64 %indvars.iv.next19.18, 6
  %501 = shl i64 %indvars.iv.next19.18, 6
  %502 = add nsw i64 %501, -64
  %503 = add nsw i64 %500, -1
  %504 = or i64 %500, 1
  %505 = add nuw nsw i64 %501, 64
  br label %for.body50.19

for.body50.19:                                    ; preds = %for.inc153.19, %for.inc156.18
  %indvars.iv.19 = phi i64 [ 0, %for.inc156.18 ], [ %indvars.iv.next.19, %for.inc153.19 ]
  %506 = add nuw nsw i64 %indvars.iv.19, %500
  %507 = trunc i64 %indvars.iv.19 to i32
  switch i32 %507, label %if.else.19 [
    i32 0, label %if.then63.19
    i32 63, label %if.then63.19
  ]

if.then63.19:                                     ; preds = %for.body50.19, %for.body50.19
  %arrayidx65.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %506
  store i8 0, i8* %arrayidx65.19, align 1
  br label %for.inc153.19

if.else.19:                                       ; preds = %for.body50.19
  %arrayidx67.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %506
  %508 = load i32, i32* %arrayidx67.19, align 4
  %cmp68.19 = icmp eq i32 %508, 75
  br i1 %cmp68.19, label %if.then70.19, label %if.else145.19

if.else145.19:                                    ; preds = %if.else.19
  %conv148.19 = trunc i32 %508 to i8
  %arrayidx150.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %506
  store i8 %conv148.19, i8* %arrayidx150.19, align 1
  br label %for.inc153.19

if.then70.19:                                     ; preds = %if.else.19
  %509 = add nuw nsw i64 %indvars.iv.19, %501
  %510 = add nsw i64 %509, -65
  %arrayidx76.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %510
  %511 = load i32, i32* %arrayidx76.19, align 4
  %cmp77.19 = icmp eq i32 %511, 255
  br i1 %cmp77.19, label %if.then138.19, label %lor.lhs.false79.19

lor.lhs.false79.19:                               ; preds = %if.then70.19
  %512 = add nuw nsw i64 %502, %indvars.iv.19
  %arrayidx84.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %512
  %513 = load i32, i32* %arrayidx84.19, align 4
  %cmp85.19 = icmp eq i32 %513, 255
  br i1 %cmp85.19, label %if.then138.19, label %lor.lhs.false87.19

lor.lhs.false87.19:                               ; preds = %lor.lhs.false79.19
  %514 = add nsw i64 %509, -63
  %arrayidx93.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %514
  %515 = load i32, i32* %arrayidx93.19, align 4
  %cmp94.19 = icmp eq i32 %515, 255
  br i1 %cmp94.19, label %if.then138.19, label %lor.lhs.false96.19

lor.lhs.false96.19:                               ; preds = %lor.lhs.false87.19
  %516 = add nuw nsw i64 %503, %indvars.iv.19
  %arrayidx101.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %516
  %517 = load i32, i32* %arrayidx101.19, align 4
  %cmp102.19 = icmp eq i32 %517, 255
  br i1 %cmp102.19, label %if.then138.19, label %lor.lhs.false104.19

lor.lhs.false104.19:                              ; preds = %lor.lhs.false96.19
  %518 = add nuw nsw i64 %504, %indvars.iv.19
  %arrayidx109.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %518
  %519 = load i32, i32* %arrayidx109.19, align 4
  %cmp110.19 = icmp eq i32 %519, 255
  br i1 %cmp110.19, label %if.then138.19, label %lor.lhs.false112.19

lor.lhs.false112.19:                              ; preds = %lor.lhs.false104.19
  %520 = add nuw nsw i64 %509, 63
  %arrayidx118.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %520
  %521 = load i32, i32* %arrayidx118.19, align 4
  %cmp119.19 = icmp eq i32 %521, 255
  br i1 %cmp119.19, label %if.then138.19, label %lor.lhs.false121.19

lor.lhs.false121.19:                              ; preds = %lor.lhs.false112.19
  %522 = add nuw nsw i64 %505, %indvars.iv.19
  %arrayidx126.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %522
  %523 = load i32, i32* %arrayidx126.19, align 4
  %cmp127.19 = icmp eq i32 %523, 255
  br i1 %cmp127.19, label %if.then138.19, label %lor.lhs.false129.19

lor.lhs.false129.19:                              ; preds = %lor.lhs.false121.19
  %524 = add nuw nsw i64 %509, 65
  %arrayidx135.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %524
  %525 = load i32, i32* %arrayidx135.19, align 4
  %cmp136.19 = icmp eq i32 %525, 255
  br i1 %cmp136.19, label %if.then138.19, label %if.else141.19

if.else141.19:                                    ; preds = %lor.lhs.false129.19
  %arrayidx143.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %506
  store i8 0, i8* %arrayidx143.19, align 1
  br label %for.inc153.19

if.then138.19:                                    ; preds = %lor.lhs.false129.19, %lor.lhs.false121.19, %lor.lhs.false112.19, %lor.lhs.false104.19, %lor.lhs.false96.19, %lor.lhs.false87.19, %lor.lhs.false79.19, %if.then70.19
  %arrayidx140.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %506
  store i8 -1, i8* %arrayidx140.19, align 1
  br label %for.inc153.19

for.inc153.19:                                    ; preds = %if.then138.19, %if.else141.19, %if.else145.19, %if.then63.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %exitcond.19 = icmp eq i64 %indvars.iv.next.19, 64
  br i1 %exitcond.19, label %for.inc156.19, label %for.body50.19, !llvm.loop !1

for.inc156.19:                                    ; preds = %for.inc153.19
  %indvars.iv.next19.19 = or i64 %indvars.iv18, 20
  %526 = shl nsw i64 %indvars.iv.next19.19, 6
  %527 = shl i64 %indvars.iv.next19.19, 6
  %528 = add nsw i64 %527, -64
  %529 = add nsw i64 %526, -1
  %530 = or i64 %526, 1
  %531 = or i64 %527, 64
  br label %for.body50.20

for.body50.20:                                    ; preds = %for.inc153.20, %for.inc156.19
  %indvars.iv.20 = phi i64 [ 0, %for.inc156.19 ], [ %indvars.iv.next.20, %for.inc153.20 ]
  %532 = add nuw nsw i64 %indvars.iv.20, %526
  %533 = trunc i64 %indvars.iv.20 to i32
  switch i32 %533, label %if.else.20 [
    i32 0, label %if.then63.20
    i32 63, label %if.then63.20
  ]

if.then63.20:                                     ; preds = %for.body50.20, %for.body50.20
  %arrayidx65.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %532
  store i8 0, i8* %arrayidx65.20, align 1
  br label %for.inc153.20

if.else.20:                                       ; preds = %for.body50.20
  %arrayidx67.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %532
  %534 = load i32, i32* %arrayidx67.20, align 4
  %cmp68.20 = icmp eq i32 %534, 75
  br i1 %cmp68.20, label %if.then70.20, label %if.else145.20

if.else145.20:                                    ; preds = %if.else.20
  %conv148.20 = trunc i32 %534 to i8
  %arrayidx150.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %532
  store i8 %conv148.20, i8* %arrayidx150.20, align 1
  br label %for.inc153.20

if.then70.20:                                     ; preds = %if.else.20
  %535 = add nuw nsw i64 %indvars.iv.20, %527
  %536 = add nsw i64 %535, -65
  %arrayidx76.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %536
  %537 = load i32, i32* %arrayidx76.20, align 4
  %cmp77.20 = icmp eq i32 %537, 255
  br i1 %cmp77.20, label %if.then138.20, label %lor.lhs.false79.20

lor.lhs.false79.20:                               ; preds = %if.then70.20
  %538 = add nuw nsw i64 %528, %indvars.iv.20
  %arrayidx84.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %538
  %539 = load i32, i32* %arrayidx84.20, align 4
  %cmp85.20 = icmp eq i32 %539, 255
  br i1 %cmp85.20, label %if.then138.20, label %lor.lhs.false87.20

lor.lhs.false87.20:                               ; preds = %lor.lhs.false79.20
  %540 = add nsw i64 %535, -63
  %arrayidx93.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %540
  %541 = load i32, i32* %arrayidx93.20, align 4
  %cmp94.20 = icmp eq i32 %541, 255
  br i1 %cmp94.20, label %if.then138.20, label %lor.lhs.false96.20

lor.lhs.false96.20:                               ; preds = %lor.lhs.false87.20
  %542 = add nuw nsw i64 %529, %indvars.iv.20
  %arrayidx101.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %542
  %543 = load i32, i32* %arrayidx101.20, align 4
  %cmp102.20 = icmp eq i32 %543, 255
  br i1 %cmp102.20, label %if.then138.20, label %lor.lhs.false104.20

lor.lhs.false104.20:                              ; preds = %lor.lhs.false96.20
  %544 = add nuw nsw i64 %530, %indvars.iv.20
  %arrayidx109.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %544
  %545 = load i32, i32* %arrayidx109.20, align 4
  %cmp110.20 = icmp eq i32 %545, 255
  br i1 %cmp110.20, label %if.then138.20, label %lor.lhs.false112.20

lor.lhs.false112.20:                              ; preds = %lor.lhs.false104.20
  %546 = add nuw nsw i64 %535, 63
  %arrayidx118.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %546
  %547 = load i32, i32* %arrayidx118.20, align 4
  %cmp119.20 = icmp eq i32 %547, 255
  br i1 %cmp119.20, label %if.then138.20, label %lor.lhs.false121.20

lor.lhs.false121.20:                              ; preds = %lor.lhs.false112.20
  %548 = add nuw nsw i64 %531, %indvars.iv.20
  %arrayidx126.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %548
  %549 = load i32, i32* %arrayidx126.20, align 4
  %cmp127.20 = icmp eq i32 %549, 255
  br i1 %cmp127.20, label %if.then138.20, label %lor.lhs.false129.20

lor.lhs.false129.20:                              ; preds = %lor.lhs.false121.20
  %550 = add nuw nsw i64 %535, 65
  %arrayidx135.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %550
  %551 = load i32, i32* %arrayidx135.20, align 4
  %cmp136.20 = icmp eq i32 %551, 255
  br i1 %cmp136.20, label %if.then138.20, label %if.else141.20

if.else141.20:                                    ; preds = %lor.lhs.false129.20
  %arrayidx143.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %532
  store i8 0, i8* %arrayidx143.20, align 1
  br label %for.inc153.20

if.then138.20:                                    ; preds = %lor.lhs.false129.20, %lor.lhs.false121.20, %lor.lhs.false112.20, %lor.lhs.false104.20, %lor.lhs.false96.20, %lor.lhs.false87.20, %lor.lhs.false79.20, %if.then70.20
  %arrayidx140.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %532
  store i8 -1, i8* %arrayidx140.20, align 1
  br label %for.inc153.20

for.inc153.20:                                    ; preds = %if.then138.20, %if.else141.20, %if.else145.20, %if.then63.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %exitcond.20 = icmp eq i64 %indvars.iv.next.20, 64
  br i1 %exitcond.20, label %for.inc156.20, label %for.body50.20, !llvm.loop !1

for.inc156.20:                                    ; preds = %for.inc153.20
  %indvars.iv.next19.20 = or i64 %indvars.iv18, 21
  %552 = shl nsw i64 %indvars.iv.next19.20, 6
  %553 = shl i64 %indvars.iv.next19.20, 6
  %554 = add nsw i64 %553, -64
  %555 = add nsw i64 %552, -1
  %556 = or i64 %552, 1
  %557 = add nuw nsw i64 %553, 64
  br label %for.body50.21

for.body50.21:                                    ; preds = %for.inc153.21, %for.inc156.20
  %indvars.iv.21 = phi i64 [ 0, %for.inc156.20 ], [ %indvars.iv.next.21, %for.inc153.21 ]
  %558 = add nuw nsw i64 %indvars.iv.21, %552
  %559 = trunc i64 %indvars.iv.21 to i32
  switch i32 %559, label %if.else.21 [
    i32 0, label %if.then63.21
    i32 63, label %if.then63.21
  ]

if.then63.21:                                     ; preds = %for.body50.21, %for.body50.21
  %arrayidx65.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %558
  store i8 0, i8* %arrayidx65.21, align 1
  br label %for.inc153.21

if.else.21:                                       ; preds = %for.body50.21
  %arrayidx67.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %558
  %560 = load i32, i32* %arrayidx67.21, align 4
  %cmp68.21 = icmp eq i32 %560, 75
  br i1 %cmp68.21, label %if.then70.21, label %if.else145.21

if.else145.21:                                    ; preds = %if.else.21
  %conv148.21 = trunc i32 %560 to i8
  %arrayidx150.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %558
  store i8 %conv148.21, i8* %arrayidx150.21, align 1
  br label %for.inc153.21

if.then70.21:                                     ; preds = %if.else.21
  %561 = add nuw nsw i64 %indvars.iv.21, %553
  %562 = add nsw i64 %561, -65
  %arrayidx76.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %562
  %563 = load i32, i32* %arrayidx76.21, align 4
  %cmp77.21 = icmp eq i32 %563, 255
  br i1 %cmp77.21, label %if.then138.21, label %lor.lhs.false79.21

lor.lhs.false79.21:                               ; preds = %if.then70.21
  %564 = add nuw nsw i64 %554, %indvars.iv.21
  %arrayidx84.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %564
  %565 = load i32, i32* %arrayidx84.21, align 4
  %cmp85.21 = icmp eq i32 %565, 255
  br i1 %cmp85.21, label %if.then138.21, label %lor.lhs.false87.21

lor.lhs.false87.21:                               ; preds = %lor.lhs.false79.21
  %566 = add nsw i64 %561, -63
  %arrayidx93.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %566
  %567 = load i32, i32* %arrayidx93.21, align 4
  %cmp94.21 = icmp eq i32 %567, 255
  br i1 %cmp94.21, label %if.then138.21, label %lor.lhs.false96.21

lor.lhs.false96.21:                               ; preds = %lor.lhs.false87.21
  %568 = add nuw nsw i64 %555, %indvars.iv.21
  %arrayidx101.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %568
  %569 = load i32, i32* %arrayidx101.21, align 4
  %cmp102.21 = icmp eq i32 %569, 255
  br i1 %cmp102.21, label %if.then138.21, label %lor.lhs.false104.21

lor.lhs.false104.21:                              ; preds = %lor.lhs.false96.21
  %570 = add nuw nsw i64 %556, %indvars.iv.21
  %arrayidx109.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %570
  %571 = load i32, i32* %arrayidx109.21, align 4
  %cmp110.21 = icmp eq i32 %571, 255
  br i1 %cmp110.21, label %if.then138.21, label %lor.lhs.false112.21

lor.lhs.false112.21:                              ; preds = %lor.lhs.false104.21
  %572 = add nuw nsw i64 %561, 63
  %arrayidx118.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %572
  %573 = load i32, i32* %arrayidx118.21, align 4
  %cmp119.21 = icmp eq i32 %573, 255
  br i1 %cmp119.21, label %if.then138.21, label %lor.lhs.false121.21

lor.lhs.false121.21:                              ; preds = %lor.lhs.false112.21
  %574 = add nuw nsw i64 %557, %indvars.iv.21
  %arrayidx126.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %574
  %575 = load i32, i32* %arrayidx126.21, align 4
  %cmp127.21 = icmp eq i32 %575, 255
  br i1 %cmp127.21, label %if.then138.21, label %lor.lhs.false129.21

lor.lhs.false129.21:                              ; preds = %lor.lhs.false121.21
  %576 = add nuw nsw i64 %561, 65
  %arrayidx135.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %576
  %577 = load i32, i32* %arrayidx135.21, align 4
  %cmp136.21 = icmp eq i32 %577, 255
  br i1 %cmp136.21, label %if.then138.21, label %if.else141.21

if.else141.21:                                    ; preds = %lor.lhs.false129.21
  %arrayidx143.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %558
  store i8 0, i8* %arrayidx143.21, align 1
  br label %for.inc153.21

if.then138.21:                                    ; preds = %lor.lhs.false129.21, %lor.lhs.false121.21, %lor.lhs.false112.21, %lor.lhs.false104.21, %lor.lhs.false96.21, %lor.lhs.false87.21, %lor.lhs.false79.21, %if.then70.21
  %arrayidx140.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %558
  store i8 -1, i8* %arrayidx140.21, align 1
  br label %for.inc153.21

for.inc153.21:                                    ; preds = %if.then138.21, %if.else141.21, %if.else145.21, %if.then63.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %exitcond.21 = icmp eq i64 %indvars.iv.next.21, 64
  br i1 %exitcond.21, label %for.inc156.21, label %for.body50.21, !llvm.loop !1

for.inc156.21:                                    ; preds = %for.inc153.21
  %indvars.iv.next19.21 = or i64 %indvars.iv18, 22
  %578 = shl nsw i64 %indvars.iv.next19.21, 6
  %579 = shl i64 %indvars.iv.next19.21, 6
  %580 = add nsw i64 %579, -64
  %581 = add nsw i64 %578, -1
  %582 = or i64 %578, 1
  %583 = or i64 %579, 64
  br label %for.body50.22

for.body50.22:                                    ; preds = %for.inc153.22, %for.inc156.21
  %indvars.iv.22 = phi i64 [ 0, %for.inc156.21 ], [ %indvars.iv.next.22, %for.inc153.22 ]
  %584 = add nuw nsw i64 %indvars.iv.22, %578
  %585 = trunc i64 %indvars.iv.22 to i32
  switch i32 %585, label %if.else.22 [
    i32 0, label %if.then63.22
    i32 63, label %if.then63.22
  ]

if.then63.22:                                     ; preds = %for.body50.22, %for.body50.22
  %arrayidx65.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %584
  store i8 0, i8* %arrayidx65.22, align 1
  br label %for.inc153.22

if.else.22:                                       ; preds = %for.body50.22
  %arrayidx67.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %584
  %586 = load i32, i32* %arrayidx67.22, align 4
  %cmp68.22 = icmp eq i32 %586, 75
  br i1 %cmp68.22, label %if.then70.22, label %if.else145.22

if.else145.22:                                    ; preds = %if.else.22
  %conv148.22 = trunc i32 %586 to i8
  %arrayidx150.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %584
  store i8 %conv148.22, i8* %arrayidx150.22, align 1
  br label %for.inc153.22

if.then70.22:                                     ; preds = %if.else.22
  %587 = add nuw nsw i64 %indvars.iv.22, %579
  %588 = add nsw i64 %587, -65
  %arrayidx76.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %588
  %589 = load i32, i32* %arrayidx76.22, align 4
  %cmp77.22 = icmp eq i32 %589, 255
  br i1 %cmp77.22, label %if.then138.22, label %lor.lhs.false79.22

lor.lhs.false79.22:                               ; preds = %if.then70.22
  %590 = add nuw nsw i64 %580, %indvars.iv.22
  %arrayidx84.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %590
  %591 = load i32, i32* %arrayidx84.22, align 4
  %cmp85.22 = icmp eq i32 %591, 255
  br i1 %cmp85.22, label %if.then138.22, label %lor.lhs.false87.22

lor.lhs.false87.22:                               ; preds = %lor.lhs.false79.22
  %592 = add nsw i64 %587, -63
  %arrayidx93.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %592
  %593 = load i32, i32* %arrayidx93.22, align 4
  %cmp94.22 = icmp eq i32 %593, 255
  br i1 %cmp94.22, label %if.then138.22, label %lor.lhs.false96.22

lor.lhs.false96.22:                               ; preds = %lor.lhs.false87.22
  %594 = add nuw nsw i64 %581, %indvars.iv.22
  %arrayidx101.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %594
  %595 = load i32, i32* %arrayidx101.22, align 4
  %cmp102.22 = icmp eq i32 %595, 255
  br i1 %cmp102.22, label %if.then138.22, label %lor.lhs.false104.22

lor.lhs.false104.22:                              ; preds = %lor.lhs.false96.22
  %596 = add nuw nsw i64 %582, %indvars.iv.22
  %arrayidx109.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %596
  %597 = load i32, i32* %arrayidx109.22, align 4
  %cmp110.22 = icmp eq i32 %597, 255
  br i1 %cmp110.22, label %if.then138.22, label %lor.lhs.false112.22

lor.lhs.false112.22:                              ; preds = %lor.lhs.false104.22
  %598 = add nuw nsw i64 %587, 63
  %arrayidx118.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %598
  %599 = load i32, i32* %arrayidx118.22, align 4
  %cmp119.22 = icmp eq i32 %599, 255
  br i1 %cmp119.22, label %if.then138.22, label %lor.lhs.false121.22

lor.lhs.false121.22:                              ; preds = %lor.lhs.false112.22
  %600 = add nuw nsw i64 %583, %indvars.iv.22
  %arrayidx126.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %600
  %601 = load i32, i32* %arrayidx126.22, align 4
  %cmp127.22 = icmp eq i32 %601, 255
  br i1 %cmp127.22, label %if.then138.22, label %lor.lhs.false129.22

lor.lhs.false129.22:                              ; preds = %lor.lhs.false121.22
  %602 = add nuw nsw i64 %587, 65
  %arrayidx135.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %602
  %603 = load i32, i32* %arrayidx135.22, align 4
  %cmp136.22 = icmp eq i32 %603, 255
  br i1 %cmp136.22, label %if.then138.22, label %if.else141.22

if.else141.22:                                    ; preds = %lor.lhs.false129.22
  %arrayidx143.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %584
  store i8 0, i8* %arrayidx143.22, align 1
  br label %for.inc153.22

if.then138.22:                                    ; preds = %lor.lhs.false129.22, %lor.lhs.false121.22, %lor.lhs.false112.22, %lor.lhs.false104.22, %lor.lhs.false96.22, %lor.lhs.false87.22, %lor.lhs.false79.22, %if.then70.22
  %arrayidx140.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %584
  store i8 -1, i8* %arrayidx140.22, align 1
  br label %for.inc153.22

for.inc153.22:                                    ; preds = %if.then138.22, %if.else141.22, %if.else145.22, %if.then63.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %exitcond.22 = icmp eq i64 %indvars.iv.next.22, 64
  br i1 %exitcond.22, label %for.inc156.22, label %for.body50.22, !llvm.loop !1

for.inc156.22:                                    ; preds = %for.inc153.22
  %indvars.iv.next19.22 = or i64 %indvars.iv18, 23
  %604 = shl nsw i64 %indvars.iv.next19.22, 6
  %605 = shl i64 %indvars.iv.next19.22, 6
  %606 = add nsw i64 %605, -64
  %607 = add nsw i64 %604, -1
  %608 = or i64 %604, 1
  %609 = add nuw nsw i64 %605, 64
  br label %for.body50.23

for.body50.23:                                    ; preds = %for.inc153.23, %for.inc156.22
  %indvars.iv.23 = phi i64 [ 0, %for.inc156.22 ], [ %indvars.iv.next.23, %for.inc153.23 ]
  %610 = add nuw nsw i64 %indvars.iv.23, %604
  %611 = trunc i64 %indvars.iv.23 to i32
  switch i32 %611, label %if.else.23 [
    i32 0, label %if.then63.23
    i32 63, label %if.then63.23
  ]

if.then63.23:                                     ; preds = %for.body50.23, %for.body50.23
  %arrayidx65.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %610
  store i8 0, i8* %arrayidx65.23, align 1
  br label %for.inc153.23

if.else.23:                                       ; preds = %for.body50.23
  %arrayidx67.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %610
  %612 = load i32, i32* %arrayidx67.23, align 4
  %cmp68.23 = icmp eq i32 %612, 75
  br i1 %cmp68.23, label %if.then70.23, label %if.else145.23

if.else145.23:                                    ; preds = %if.else.23
  %conv148.23 = trunc i32 %612 to i8
  %arrayidx150.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %610
  store i8 %conv148.23, i8* %arrayidx150.23, align 1
  br label %for.inc153.23

if.then70.23:                                     ; preds = %if.else.23
  %613 = add nuw nsw i64 %indvars.iv.23, %605
  %614 = add nsw i64 %613, -65
  %arrayidx76.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %614
  %615 = load i32, i32* %arrayidx76.23, align 4
  %cmp77.23 = icmp eq i32 %615, 255
  br i1 %cmp77.23, label %if.then138.23, label %lor.lhs.false79.23

lor.lhs.false79.23:                               ; preds = %if.then70.23
  %616 = add nuw nsw i64 %606, %indvars.iv.23
  %arrayidx84.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %616
  %617 = load i32, i32* %arrayidx84.23, align 4
  %cmp85.23 = icmp eq i32 %617, 255
  br i1 %cmp85.23, label %if.then138.23, label %lor.lhs.false87.23

lor.lhs.false87.23:                               ; preds = %lor.lhs.false79.23
  %618 = add nsw i64 %613, -63
  %arrayidx93.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %618
  %619 = load i32, i32* %arrayidx93.23, align 4
  %cmp94.23 = icmp eq i32 %619, 255
  br i1 %cmp94.23, label %if.then138.23, label %lor.lhs.false96.23

lor.lhs.false96.23:                               ; preds = %lor.lhs.false87.23
  %620 = add nuw nsw i64 %607, %indvars.iv.23
  %arrayidx101.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %620
  %621 = load i32, i32* %arrayidx101.23, align 4
  %cmp102.23 = icmp eq i32 %621, 255
  br i1 %cmp102.23, label %if.then138.23, label %lor.lhs.false104.23

lor.lhs.false104.23:                              ; preds = %lor.lhs.false96.23
  %622 = add nuw nsw i64 %608, %indvars.iv.23
  %arrayidx109.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %622
  %623 = load i32, i32* %arrayidx109.23, align 4
  %cmp110.23 = icmp eq i32 %623, 255
  br i1 %cmp110.23, label %if.then138.23, label %lor.lhs.false112.23

lor.lhs.false112.23:                              ; preds = %lor.lhs.false104.23
  %624 = add nuw nsw i64 %613, 63
  %arrayidx118.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %624
  %625 = load i32, i32* %arrayidx118.23, align 4
  %cmp119.23 = icmp eq i32 %625, 255
  br i1 %cmp119.23, label %if.then138.23, label %lor.lhs.false121.23

lor.lhs.false121.23:                              ; preds = %lor.lhs.false112.23
  %626 = add nuw nsw i64 %609, %indvars.iv.23
  %arrayidx126.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %626
  %627 = load i32, i32* %arrayidx126.23, align 4
  %cmp127.23 = icmp eq i32 %627, 255
  br i1 %cmp127.23, label %if.then138.23, label %lor.lhs.false129.23

lor.lhs.false129.23:                              ; preds = %lor.lhs.false121.23
  %628 = add nuw nsw i64 %613, 65
  %arrayidx135.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %628
  %629 = load i32, i32* %arrayidx135.23, align 4
  %cmp136.23 = icmp eq i32 %629, 255
  br i1 %cmp136.23, label %if.then138.23, label %if.else141.23

if.else141.23:                                    ; preds = %lor.lhs.false129.23
  %arrayidx143.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %610
  store i8 0, i8* %arrayidx143.23, align 1
  br label %for.inc153.23

if.then138.23:                                    ; preds = %lor.lhs.false129.23, %lor.lhs.false121.23, %lor.lhs.false112.23, %lor.lhs.false104.23, %lor.lhs.false96.23, %lor.lhs.false87.23, %lor.lhs.false79.23, %if.then70.23
  %arrayidx140.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %610
  store i8 -1, i8* %arrayidx140.23, align 1
  br label %for.inc153.23

for.inc153.23:                                    ; preds = %if.then138.23, %if.else141.23, %if.else145.23, %if.then63.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %exitcond.23 = icmp eq i64 %indvars.iv.next.23, 64
  br i1 %exitcond.23, label %for.inc156.23, label %for.body50.23, !llvm.loop !1

for.inc156.23:                                    ; preds = %for.inc153.23
  %indvars.iv.next19.23 = or i64 %indvars.iv18, 24
  %630 = shl nsw i64 %indvars.iv.next19.23, 6
  %631 = shl i64 %indvars.iv.next19.23, 6
  %632 = add nsw i64 %631, -64
  %633 = add nsw i64 %630, -1
  %634 = or i64 %630, 1
  %635 = or i64 %631, 64
  br label %for.body50.24

for.body50.24:                                    ; preds = %for.inc153.24, %for.inc156.23
  %indvars.iv.24 = phi i64 [ 0, %for.inc156.23 ], [ %indvars.iv.next.24, %for.inc153.24 ]
  %636 = add nuw nsw i64 %indvars.iv.24, %630
  %637 = trunc i64 %indvars.iv.24 to i32
  switch i32 %637, label %if.else.24 [
    i32 0, label %if.then63.24
    i32 63, label %if.then63.24
  ]

if.then63.24:                                     ; preds = %for.body50.24, %for.body50.24
  %arrayidx65.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %636
  store i8 0, i8* %arrayidx65.24, align 1
  br label %for.inc153.24

if.else.24:                                       ; preds = %for.body50.24
  %arrayidx67.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %636
  %638 = load i32, i32* %arrayidx67.24, align 4
  %cmp68.24 = icmp eq i32 %638, 75
  br i1 %cmp68.24, label %if.then70.24, label %if.else145.24

if.else145.24:                                    ; preds = %if.else.24
  %conv148.24 = trunc i32 %638 to i8
  %arrayidx150.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %636
  store i8 %conv148.24, i8* %arrayidx150.24, align 1
  br label %for.inc153.24

if.then70.24:                                     ; preds = %if.else.24
  %639 = add nuw nsw i64 %indvars.iv.24, %631
  %640 = add nsw i64 %639, -65
  %arrayidx76.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %640
  %641 = load i32, i32* %arrayidx76.24, align 4
  %cmp77.24 = icmp eq i32 %641, 255
  br i1 %cmp77.24, label %if.then138.24, label %lor.lhs.false79.24

lor.lhs.false79.24:                               ; preds = %if.then70.24
  %642 = add nuw nsw i64 %632, %indvars.iv.24
  %arrayidx84.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %642
  %643 = load i32, i32* %arrayidx84.24, align 4
  %cmp85.24 = icmp eq i32 %643, 255
  br i1 %cmp85.24, label %if.then138.24, label %lor.lhs.false87.24

lor.lhs.false87.24:                               ; preds = %lor.lhs.false79.24
  %644 = add nsw i64 %639, -63
  %arrayidx93.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %644
  %645 = load i32, i32* %arrayidx93.24, align 4
  %cmp94.24 = icmp eq i32 %645, 255
  br i1 %cmp94.24, label %if.then138.24, label %lor.lhs.false96.24

lor.lhs.false96.24:                               ; preds = %lor.lhs.false87.24
  %646 = add nuw nsw i64 %633, %indvars.iv.24
  %arrayidx101.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %646
  %647 = load i32, i32* %arrayidx101.24, align 4
  %cmp102.24 = icmp eq i32 %647, 255
  br i1 %cmp102.24, label %if.then138.24, label %lor.lhs.false104.24

lor.lhs.false104.24:                              ; preds = %lor.lhs.false96.24
  %648 = add nuw nsw i64 %634, %indvars.iv.24
  %arrayidx109.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %648
  %649 = load i32, i32* %arrayidx109.24, align 4
  %cmp110.24 = icmp eq i32 %649, 255
  br i1 %cmp110.24, label %if.then138.24, label %lor.lhs.false112.24

lor.lhs.false112.24:                              ; preds = %lor.lhs.false104.24
  %650 = add nuw nsw i64 %639, 63
  %arrayidx118.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %650
  %651 = load i32, i32* %arrayidx118.24, align 4
  %cmp119.24 = icmp eq i32 %651, 255
  br i1 %cmp119.24, label %if.then138.24, label %lor.lhs.false121.24

lor.lhs.false121.24:                              ; preds = %lor.lhs.false112.24
  %652 = add nuw nsw i64 %635, %indvars.iv.24
  %arrayidx126.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %652
  %653 = load i32, i32* %arrayidx126.24, align 4
  %cmp127.24 = icmp eq i32 %653, 255
  br i1 %cmp127.24, label %if.then138.24, label %lor.lhs.false129.24

lor.lhs.false129.24:                              ; preds = %lor.lhs.false121.24
  %654 = add nuw nsw i64 %639, 65
  %arrayidx135.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %654
  %655 = load i32, i32* %arrayidx135.24, align 4
  %cmp136.24 = icmp eq i32 %655, 255
  br i1 %cmp136.24, label %if.then138.24, label %if.else141.24

if.else141.24:                                    ; preds = %lor.lhs.false129.24
  %arrayidx143.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %636
  store i8 0, i8* %arrayidx143.24, align 1
  br label %for.inc153.24

if.then138.24:                                    ; preds = %lor.lhs.false129.24, %lor.lhs.false121.24, %lor.lhs.false112.24, %lor.lhs.false104.24, %lor.lhs.false96.24, %lor.lhs.false87.24, %lor.lhs.false79.24, %if.then70.24
  %arrayidx140.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %636
  store i8 -1, i8* %arrayidx140.24, align 1
  br label %for.inc153.24

for.inc153.24:                                    ; preds = %if.then138.24, %if.else141.24, %if.else145.24, %if.then63.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %exitcond.24 = icmp eq i64 %indvars.iv.next.24, 64
  br i1 %exitcond.24, label %for.inc156.24, label %for.body50.24, !llvm.loop !1

for.inc156.24:                                    ; preds = %for.inc153.24
  %indvars.iv.next19.24 = or i64 %indvars.iv18, 25
  %656 = shl nsw i64 %indvars.iv.next19.24, 6
  %657 = shl i64 %indvars.iv.next19.24, 6
  %658 = add nsw i64 %657, -64
  %659 = add nsw i64 %656, -1
  %660 = or i64 %656, 1
  %661 = add nuw nsw i64 %657, 64
  br label %for.body50.25

for.body50.25:                                    ; preds = %for.inc153.25, %for.inc156.24
  %indvars.iv.25 = phi i64 [ 0, %for.inc156.24 ], [ %indvars.iv.next.25, %for.inc153.25 ]
  %662 = add nuw nsw i64 %indvars.iv.25, %656
  %663 = trunc i64 %indvars.iv.25 to i32
  switch i32 %663, label %if.else.25 [
    i32 0, label %if.then63.25
    i32 63, label %if.then63.25
  ]

if.then63.25:                                     ; preds = %for.body50.25, %for.body50.25
  %arrayidx65.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %662
  store i8 0, i8* %arrayidx65.25, align 1
  br label %for.inc153.25

if.else.25:                                       ; preds = %for.body50.25
  %arrayidx67.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %662
  %664 = load i32, i32* %arrayidx67.25, align 4
  %cmp68.25 = icmp eq i32 %664, 75
  br i1 %cmp68.25, label %if.then70.25, label %if.else145.25

if.else145.25:                                    ; preds = %if.else.25
  %conv148.25 = trunc i32 %664 to i8
  %arrayidx150.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %662
  store i8 %conv148.25, i8* %arrayidx150.25, align 1
  br label %for.inc153.25

if.then70.25:                                     ; preds = %if.else.25
  %665 = add nuw nsw i64 %indvars.iv.25, %657
  %666 = add nsw i64 %665, -65
  %arrayidx76.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %666
  %667 = load i32, i32* %arrayidx76.25, align 4
  %cmp77.25 = icmp eq i32 %667, 255
  br i1 %cmp77.25, label %if.then138.25, label %lor.lhs.false79.25

lor.lhs.false79.25:                               ; preds = %if.then70.25
  %668 = add nuw nsw i64 %658, %indvars.iv.25
  %arrayidx84.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %668
  %669 = load i32, i32* %arrayidx84.25, align 4
  %cmp85.25 = icmp eq i32 %669, 255
  br i1 %cmp85.25, label %if.then138.25, label %lor.lhs.false87.25

lor.lhs.false87.25:                               ; preds = %lor.lhs.false79.25
  %670 = add nsw i64 %665, -63
  %arrayidx93.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %670
  %671 = load i32, i32* %arrayidx93.25, align 4
  %cmp94.25 = icmp eq i32 %671, 255
  br i1 %cmp94.25, label %if.then138.25, label %lor.lhs.false96.25

lor.lhs.false96.25:                               ; preds = %lor.lhs.false87.25
  %672 = add nuw nsw i64 %659, %indvars.iv.25
  %arrayidx101.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %672
  %673 = load i32, i32* %arrayidx101.25, align 4
  %cmp102.25 = icmp eq i32 %673, 255
  br i1 %cmp102.25, label %if.then138.25, label %lor.lhs.false104.25

lor.lhs.false104.25:                              ; preds = %lor.lhs.false96.25
  %674 = add nuw nsw i64 %660, %indvars.iv.25
  %arrayidx109.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %674
  %675 = load i32, i32* %arrayidx109.25, align 4
  %cmp110.25 = icmp eq i32 %675, 255
  br i1 %cmp110.25, label %if.then138.25, label %lor.lhs.false112.25

lor.lhs.false112.25:                              ; preds = %lor.lhs.false104.25
  %676 = add nuw nsw i64 %665, 63
  %arrayidx118.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %676
  %677 = load i32, i32* %arrayidx118.25, align 4
  %cmp119.25 = icmp eq i32 %677, 255
  br i1 %cmp119.25, label %if.then138.25, label %lor.lhs.false121.25

lor.lhs.false121.25:                              ; preds = %lor.lhs.false112.25
  %678 = add nuw nsw i64 %661, %indvars.iv.25
  %arrayidx126.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %678
  %679 = load i32, i32* %arrayidx126.25, align 4
  %cmp127.25 = icmp eq i32 %679, 255
  br i1 %cmp127.25, label %if.then138.25, label %lor.lhs.false129.25

lor.lhs.false129.25:                              ; preds = %lor.lhs.false121.25
  %680 = add nuw nsw i64 %665, 65
  %arrayidx135.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %680
  %681 = load i32, i32* %arrayidx135.25, align 4
  %cmp136.25 = icmp eq i32 %681, 255
  br i1 %cmp136.25, label %if.then138.25, label %if.else141.25

if.else141.25:                                    ; preds = %lor.lhs.false129.25
  %arrayidx143.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %662
  store i8 0, i8* %arrayidx143.25, align 1
  br label %for.inc153.25

if.then138.25:                                    ; preds = %lor.lhs.false129.25, %lor.lhs.false121.25, %lor.lhs.false112.25, %lor.lhs.false104.25, %lor.lhs.false96.25, %lor.lhs.false87.25, %lor.lhs.false79.25, %if.then70.25
  %arrayidx140.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %662
  store i8 -1, i8* %arrayidx140.25, align 1
  br label %for.inc153.25

for.inc153.25:                                    ; preds = %if.then138.25, %if.else141.25, %if.else145.25, %if.then63.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %exitcond.25 = icmp eq i64 %indvars.iv.next.25, 64
  br i1 %exitcond.25, label %for.inc156.25, label %for.body50.25, !llvm.loop !1

for.inc156.25:                                    ; preds = %for.inc153.25
  %indvars.iv.next19.25 = or i64 %indvars.iv18, 26
  %682 = shl nsw i64 %indvars.iv.next19.25, 6
  %683 = shl i64 %indvars.iv.next19.25, 6
  %684 = add nsw i64 %683, -64
  %685 = add nsw i64 %682, -1
  %686 = or i64 %682, 1
  %687 = or i64 %683, 64
  br label %for.body50.26

for.body50.26:                                    ; preds = %for.inc153.26, %for.inc156.25
  %indvars.iv.26 = phi i64 [ 0, %for.inc156.25 ], [ %indvars.iv.next.26, %for.inc153.26 ]
  %688 = add nuw nsw i64 %indvars.iv.26, %682
  %689 = trunc i64 %indvars.iv.26 to i32
  switch i32 %689, label %if.else.26 [
    i32 0, label %if.then63.26
    i32 63, label %if.then63.26
  ]

if.then63.26:                                     ; preds = %for.body50.26, %for.body50.26
  %arrayidx65.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %688
  store i8 0, i8* %arrayidx65.26, align 1
  br label %for.inc153.26

if.else.26:                                       ; preds = %for.body50.26
  %arrayidx67.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %688
  %690 = load i32, i32* %arrayidx67.26, align 4
  %cmp68.26 = icmp eq i32 %690, 75
  br i1 %cmp68.26, label %if.then70.26, label %if.else145.26

if.else145.26:                                    ; preds = %if.else.26
  %conv148.26 = trunc i32 %690 to i8
  %arrayidx150.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %688
  store i8 %conv148.26, i8* %arrayidx150.26, align 1
  br label %for.inc153.26

if.then70.26:                                     ; preds = %if.else.26
  %691 = add nuw nsw i64 %indvars.iv.26, %683
  %692 = add nsw i64 %691, -65
  %arrayidx76.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %692
  %693 = load i32, i32* %arrayidx76.26, align 4
  %cmp77.26 = icmp eq i32 %693, 255
  br i1 %cmp77.26, label %if.then138.26, label %lor.lhs.false79.26

lor.lhs.false79.26:                               ; preds = %if.then70.26
  %694 = add nuw nsw i64 %684, %indvars.iv.26
  %arrayidx84.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %694
  %695 = load i32, i32* %arrayidx84.26, align 4
  %cmp85.26 = icmp eq i32 %695, 255
  br i1 %cmp85.26, label %if.then138.26, label %lor.lhs.false87.26

lor.lhs.false87.26:                               ; preds = %lor.lhs.false79.26
  %696 = add nsw i64 %691, -63
  %arrayidx93.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %696
  %697 = load i32, i32* %arrayidx93.26, align 4
  %cmp94.26 = icmp eq i32 %697, 255
  br i1 %cmp94.26, label %if.then138.26, label %lor.lhs.false96.26

lor.lhs.false96.26:                               ; preds = %lor.lhs.false87.26
  %698 = add nuw nsw i64 %685, %indvars.iv.26
  %arrayidx101.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %698
  %699 = load i32, i32* %arrayidx101.26, align 4
  %cmp102.26 = icmp eq i32 %699, 255
  br i1 %cmp102.26, label %if.then138.26, label %lor.lhs.false104.26

lor.lhs.false104.26:                              ; preds = %lor.lhs.false96.26
  %700 = add nuw nsw i64 %686, %indvars.iv.26
  %arrayidx109.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %700
  %701 = load i32, i32* %arrayidx109.26, align 4
  %cmp110.26 = icmp eq i32 %701, 255
  br i1 %cmp110.26, label %if.then138.26, label %lor.lhs.false112.26

lor.lhs.false112.26:                              ; preds = %lor.lhs.false104.26
  %702 = add nuw nsw i64 %691, 63
  %arrayidx118.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %702
  %703 = load i32, i32* %arrayidx118.26, align 4
  %cmp119.26 = icmp eq i32 %703, 255
  br i1 %cmp119.26, label %if.then138.26, label %lor.lhs.false121.26

lor.lhs.false121.26:                              ; preds = %lor.lhs.false112.26
  %704 = add nuw nsw i64 %687, %indvars.iv.26
  %arrayidx126.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %704
  %705 = load i32, i32* %arrayidx126.26, align 4
  %cmp127.26 = icmp eq i32 %705, 255
  br i1 %cmp127.26, label %if.then138.26, label %lor.lhs.false129.26

lor.lhs.false129.26:                              ; preds = %lor.lhs.false121.26
  %706 = add nuw nsw i64 %691, 65
  %arrayidx135.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %706
  %707 = load i32, i32* %arrayidx135.26, align 4
  %cmp136.26 = icmp eq i32 %707, 255
  br i1 %cmp136.26, label %if.then138.26, label %if.else141.26

if.else141.26:                                    ; preds = %lor.lhs.false129.26
  %arrayidx143.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %688
  store i8 0, i8* %arrayidx143.26, align 1
  br label %for.inc153.26

if.then138.26:                                    ; preds = %lor.lhs.false129.26, %lor.lhs.false121.26, %lor.lhs.false112.26, %lor.lhs.false104.26, %lor.lhs.false96.26, %lor.lhs.false87.26, %lor.lhs.false79.26, %if.then70.26
  %arrayidx140.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %688
  store i8 -1, i8* %arrayidx140.26, align 1
  br label %for.inc153.26

for.inc153.26:                                    ; preds = %if.then138.26, %if.else141.26, %if.else145.26, %if.then63.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %exitcond.26 = icmp eq i64 %indvars.iv.next.26, 64
  br i1 %exitcond.26, label %for.inc156.26, label %for.body50.26, !llvm.loop !1

for.inc156.26:                                    ; preds = %for.inc153.26
  %indvars.iv.next19.26 = or i64 %indvars.iv18, 27
  %708 = shl nsw i64 %indvars.iv.next19.26, 6
  %709 = shl i64 %indvars.iv.next19.26, 6
  %710 = add nsw i64 %709, -64
  %711 = add nsw i64 %708, -1
  %712 = or i64 %708, 1
  %713 = add nuw nsw i64 %709, 64
  br label %for.body50.27

for.body50.27:                                    ; preds = %for.inc153.27, %for.inc156.26
  %indvars.iv.27 = phi i64 [ 0, %for.inc156.26 ], [ %indvars.iv.next.27, %for.inc153.27 ]
  %714 = add nuw nsw i64 %indvars.iv.27, %708
  %715 = trunc i64 %indvars.iv.27 to i32
  switch i32 %715, label %if.else.27 [
    i32 0, label %if.then63.27
    i32 63, label %if.then63.27
  ]

if.then63.27:                                     ; preds = %for.body50.27, %for.body50.27
  %arrayidx65.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %714
  store i8 0, i8* %arrayidx65.27, align 1
  br label %for.inc153.27

if.else.27:                                       ; preds = %for.body50.27
  %arrayidx67.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %714
  %716 = load i32, i32* %arrayidx67.27, align 4
  %cmp68.27 = icmp eq i32 %716, 75
  br i1 %cmp68.27, label %if.then70.27, label %if.else145.27

if.else145.27:                                    ; preds = %if.else.27
  %conv148.27 = trunc i32 %716 to i8
  %arrayidx150.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %714
  store i8 %conv148.27, i8* %arrayidx150.27, align 1
  br label %for.inc153.27

if.then70.27:                                     ; preds = %if.else.27
  %717 = add nuw nsw i64 %indvars.iv.27, %709
  %718 = add nsw i64 %717, -65
  %arrayidx76.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %718
  %719 = load i32, i32* %arrayidx76.27, align 4
  %cmp77.27 = icmp eq i32 %719, 255
  br i1 %cmp77.27, label %if.then138.27, label %lor.lhs.false79.27

lor.lhs.false79.27:                               ; preds = %if.then70.27
  %720 = add nuw nsw i64 %710, %indvars.iv.27
  %arrayidx84.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %720
  %721 = load i32, i32* %arrayidx84.27, align 4
  %cmp85.27 = icmp eq i32 %721, 255
  br i1 %cmp85.27, label %if.then138.27, label %lor.lhs.false87.27

lor.lhs.false87.27:                               ; preds = %lor.lhs.false79.27
  %722 = add nsw i64 %717, -63
  %arrayidx93.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %722
  %723 = load i32, i32* %arrayidx93.27, align 4
  %cmp94.27 = icmp eq i32 %723, 255
  br i1 %cmp94.27, label %if.then138.27, label %lor.lhs.false96.27

lor.lhs.false96.27:                               ; preds = %lor.lhs.false87.27
  %724 = add nuw nsw i64 %711, %indvars.iv.27
  %arrayidx101.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %724
  %725 = load i32, i32* %arrayidx101.27, align 4
  %cmp102.27 = icmp eq i32 %725, 255
  br i1 %cmp102.27, label %if.then138.27, label %lor.lhs.false104.27

lor.lhs.false104.27:                              ; preds = %lor.lhs.false96.27
  %726 = add nuw nsw i64 %712, %indvars.iv.27
  %arrayidx109.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %726
  %727 = load i32, i32* %arrayidx109.27, align 4
  %cmp110.27 = icmp eq i32 %727, 255
  br i1 %cmp110.27, label %if.then138.27, label %lor.lhs.false112.27

lor.lhs.false112.27:                              ; preds = %lor.lhs.false104.27
  %728 = add nuw nsw i64 %717, 63
  %arrayidx118.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %728
  %729 = load i32, i32* %arrayidx118.27, align 4
  %cmp119.27 = icmp eq i32 %729, 255
  br i1 %cmp119.27, label %if.then138.27, label %lor.lhs.false121.27

lor.lhs.false121.27:                              ; preds = %lor.lhs.false112.27
  %730 = add nuw nsw i64 %713, %indvars.iv.27
  %arrayidx126.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %730
  %731 = load i32, i32* %arrayidx126.27, align 4
  %cmp127.27 = icmp eq i32 %731, 255
  br i1 %cmp127.27, label %if.then138.27, label %lor.lhs.false129.27

lor.lhs.false129.27:                              ; preds = %lor.lhs.false121.27
  %732 = add nuw nsw i64 %717, 65
  %arrayidx135.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %732
  %733 = load i32, i32* %arrayidx135.27, align 4
  %cmp136.27 = icmp eq i32 %733, 255
  br i1 %cmp136.27, label %if.then138.27, label %if.else141.27

if.else141.27:                                    ; preds = %lor.lhs.false129.27
  %arrayidx143.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %714
  store i8 0, i8* %arrayidx143.27, align 1
  br label %for.inc153.27

if.then138.27:                                    ; preds = %lor.lhs.false129.27, %lor.lhs.false121.27, %lor.lhs.false112.27, %lor.lhs.false104.27, %lor.lhs.false96.27, %lor.lhs.false87.27, %lor.lhs.false79.27, %if.then70.27
  %arrayidx140.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %714
  store i8 -1, i8* %arrayidx140.27, align 1
  br label %for.inc153.27

for.inc153.27:                                    ; preds = %if.then138.27, %if.else141.27, %if.else145.27, %if.then63.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %exitcond.27 = icmp eq i64 %indvars.iv.next.27, 64
  br i1 %exitcond.27, label %for.inc156.27, label %for.body50.27, !llvm.loop !1

for.inc156.27:                                    ; preds = %for.inc153.27
  %indvars.iv.next19.27 = or i64 %indvars.iv18, 28
  %734 = shl nsw i64 %indvars.iv.next19.27, 6
  %735 = shl i64 %indvars.iv.next19.27, 6
  %736 = add nsw i64 %735, -64
  %737 = add nsw i64 %734, -1
  %738 = or i64 %734, 1
  %739 = or i64 %735, 64
  br label %for.body50.28

for.body50.28:                                    ; preds = %for.inc153.28, %for.inc156.27
  %indvars.iv.28 = phi i64 [ 0, %for.inc156.27 ], [ %indvars.iv.next.28, %for.inc153.28 ]
  %740 = add nuw nsw i64 %indvars.iv.28, %734
  %741 = trunc i64 %indvars.iv.28 to i32
  switch i32 %741, label %if.else.28 [
    i32 0, label %if.then63.28
    i32 63, label %if.then63.28
  ]

if.then63.28:                                     ; preds = %for.body50.28, %for.body50.28
  %arrayidx65.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %740
  store i8 0, i8* %arrayidx65.28, align 1
  br label %for.inc153.28

if.else.28:                                       ; preds = %for.body50.28
  %arrayidx67.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %740
  %742 = load i32, i32* %arrayidx67.28, align 4
  %cmp68.28 = icmp eq i32 %742, 75
  br i1 %cmp68.28, label %if.then70.28, label %if.else145.28

if.else145.28:                                    ; preds = %if.else.28
  %conv148.28 = trunc i32 %742 to i8
  %arrayidx150.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %740
  store i8 %conv148.28, i8* %arrayidx150.28, align 1
  br label %for.inc153.28

if.then70.28:                                     ; preds = %if.else.28
  %743 = add nuw nsw i64 %indvars.iv.28, %735
  %744 = add nsw i64 %743, -65
  %arrayidx76.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %744
  %745 = load i32, i32* %arrayidx76.28, align 4
  %cmp77.28 = icmp eq i32 %745, 255
  br i1 %cmp77.28, label %if.then138.28, label %lor.lhs.false79.28

lor.lhs.false79.28:                               ; preds = %if.then70.28
  %746 = add nuw nsw i64 %736, %indvars.iv.28
  %arrayidx84.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %746
  %747 = load i32, i32* %arrayidx84.28, align 4
  %cmp85.28 = icmp eq i32 %747, 255
  br i1 %cmp85.28, label %if.then138.28, label %lor.lhs.false87.28

lor.lhs.false87.28:                               ; preds = %lor.lhs.false79.28
  %748 = add nsw i64 %743, -63
  %arrayidx93.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %748
  %749 = load i32, i32* %arrayidx93.28, align 4
  %cmp94.28 = icmp eq i32 %749, 255
  br i1 %cmp94.28, label %if.then138.28, label %lor.lhs.false96.28

lor.lhs.false96.28:                               ; preds = %lor.lhs.false87.28
  %750 = add nuw nsw i64 %737, %indvars.iv.28
  %arrayidx101.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %750
  %751 = load i32, i32* %arrayidx101.28, align 4
  %cmp102.28 = icmp eq i32 %751, 255
  br i1 %cmp102.28, label %if.then138.28, label %lor.lhs.false104.28

lor.lhs.false104.28:                              ; preds = %lor.lhs.false96.28
  %752 = add nuw nsw i64 %738, %indvars.iv.28
  %arrayidx109.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %752
  %753 = load i32, i32* %arrayidx109.28, align 4
  %cmp110.28 = icmp eq i32 %753, 255
  br i1 %cmp110.28, label %if.then138.28, label %lor.lhs.false112.28

lor.lhs.false112.28:                              ; preds = %lor.lhs.false104.28
  %754 = add nuw nsw i64 %743, 63
  %arrayidx118.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %754
  %755 = load i32, i32* %arrayidx118.28, align 4
  %cmp119.28 = icmp eq i32 %755, 255
  br i1 %cmp119.28, label %if.then138.28, label %lor.lhs.false121.28

lor.lhs.false121.28:                              ; preds = %lor.lhs.false112.28
  %756 = add nuw nsw i64 %739, %indvars.iv.28
  %arrayidx126.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %756
  %757 = load i32, i32* %arrayidx126.28, align 4
  %cmp127.28 = icmp eq i32 %757, 255
  br i1 %cmp127.28, label %if.then138.28, label %lor.lhs.false129.28

lor.lhs.false129.28:                              ; preds = %lor.lhs.false121.28
  %758 = add nuw nsw i64 %743, 65
  %arrayidx135.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %758
  %759 = load i32, i32* %arrayidx135.28, align 4
  %cmp136.28 = icmp eq i32 %759, 255
  br i1 %cmp136.28, label %if.then138.28, label %if.else141.28

if.else141.28:                                    ; preds = %lor.lhs.false129.28
  %arrayidx143.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %740
  store i8 0, i8* %arrayidx143.28, align 1
  br label %for.inc153.28

if.then138.28:                                    ; preds = %lor.lhs.false129.28, %lor.lhs.false121.28, %lor.lhs.false112.28, %lor.lhs.false104.28, %lor.lhs.false96.28, %lor.lhs.false87.28, %lor.lhs.false79.28, %if.then70.28
  %arrayidx140.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %740
  store i8 -1, i8* %arrayidx140.28, align 1
  br label %for.inc153.28

for.inc153.28:                                    ; preds = %if.then138.28, %if.else141.28, %if.else145.28, %if.then63.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %exitcond.28 = icmp eq i64 %indvars.iv.next.28, 64
  br i1 %exitcond.28, label %for.inc156.28, label %for.body50.28, !llvm.loop !1

for.inc156.28:                                    ; preds = %for.inc153.28
  %indvars.iv.next19.28 = or i64 %indvars.iv18, 29
  %760 = shl nsw i64 %indvars.iv.next19.28, 6
  %761 = shl i64 %indvars.iv.next19.28, 6
  %762 = add nsw i64 %761, -64
  %763 = add nsw i64 %760, -1
  %764 = or i64 %760, 1
  %765 = add nuw nsw i64 %761, 64
  br label %for.body50.29

for.body50.29:                                    ; preds = %for.inc153.29, %for.inc156.28
  %indvars.iv.29 = phi i64 [ 0, %for.inc156.28 ], [ %indvars.iv.next.29, %for.inc153.29 ]
  %766 = add nuw nsw i64 %indvars.iv.29, %760
  %767 = trunc i64 %indvars.iv.29 to i32
  switch i32 %767, label %if.else.29 [
    i32 0, label %if.then63.29
    i32 63, label %if.then63.29
  ]

if.then63.29:                                     ; preds = %for.body50.29, %for.body50.29
  %arrayidx65.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %766
  store i8 0, i8* %arrayidx65.29, align 1
  br label %for.inc153.29

if.else.29:                                       ; preds = %for.body50.29
  %arrayidx67.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %766
  %768 = load i32, i32* %arrayidx67.29, align 4
  %cmp68.29 = icmp eq i32 %768, 75
  br i1 %cmp68.29, label %if.then70.29, label %if.else145.29

if.else145.29:                                    ; preds = %if.else.29
  %conv148.29 = trunc i32 %768 to i8
  %arrayidx150.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %766
  store i8 %conv148.29, i8* %arrayidx150.29, align 1
  br label %for.inc153.29

if.then70.29:                                     ; preds = %if.else.29
  %769 = add nuw nsw i64 %indvars.iv.29, %761
  %770 = add nsw i64 %769, -65
  %arrayidx76.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %770
  %771 = load i32, i32* %arrayidx76.29, align 4
  %cmp77.29 = icmp eq i32 %771, 255
  br i1 %cmp77.29, label %if.then138.29, label %lor.lhs.false79.29

lor.lhs.false79.29:                               ; preds = %if.then70.29
  %772 = add nuw nsw i64 %762, %indvars.iv.29
  %arrayidx84.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %772
  %773 = load i32, i32* %arrayidx84.29, align 4
  %cmp85.29 = icmp eq i32 %773, 255
  br i1 %cmp85.29, label %if.then138.29, label %lor.lhs.false87.29

lor.lhs.false87.29:                               ; preds = %lor.lhs.false79.29
  %774 = add nsw i64 %769, -63
  %arrayidx93.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %774
  %775 = load i32, i32* %arrayidx93.29, align 4
  %cmp94.29 = icmp eq i32 %775, 255
  br i1 %cmp94.29, label %if.then138.29, label %lor.lhs.false96.29

lor.lhs.false96.29:                               ; preds = %lor.lhs.false87.29
  %776 = add nuw nsw i64 %763, %indvars.iv.29
  %arrayidx101.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %776
  %777 = load i32, i32* %arrayidx101.29, align 4
  %cmp102.29 = icmp eq i32 %777, 255
  br i1 %cmp102.29, label %if.then138.29, label %lor.lhs.false104.29

lor.lhs.false104.29:                              ; preds = %lor.lhs.false96.29
  %778 = add nuw nsw i64 %764, %indvars.iv.29
  %arrayidx109.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %778
  %779 = load i32, i32* %arrayidx109.29, align 4
  %cmp110.29 = icmp eq i32 %779, 255
  br i1 %cmp110.29, label %if.then138.29, label %lor.lhs.false112.29

lor.lhs.false112.29:                              ; preds = %lor.lhs.false104.29
  %780 = add nuw nsw i64 %769, 63
  %arrayidx118.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %780
  %781 = load i32, i32* %arrayidx118.29, align 4
  %cmp119.29 = icmp eq i32 %781, 255
  br i1 %cmp119.29, label %if.then138.29, label %lor.lhs.false121.29

lor.lhs.false121.29:                              ; preds = %lor.lhs.false112.29
  %782 = add nuw nsw i64 %765, %indvars.iv.29
  %arrayidx126.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %782
  %783 = load i32, i32* %arrayidx126.29, align 4
  %cmp127.29 = icmp eq i32 %783, 255
  br i1 %cmp127.29, label %if.then138.29, label %lor.lhs.false129.29

lor.lhs.false129.29:                              ; preds = %lor.lhs.false121.29
  %784 = add nuw nsw i64 %769, 65
  %arrayidx135.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %784
  %785 = load i32, i32* %arrayidx135.29, align 4
  %cmp136.29 = icmp eq i32 %785, 255
  br i1 %cmp136.29, label %if.then138.29, label %if.else141.29

if.else141.29:                                    ; preds = %lor.lhs.false129.29
  %arrayidx143.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %766
  store i8 0, i8* %arrayidx143.29, align 1
  br label %for.inc153.29

if.then138.29:                                    ; preds = %lor.lhs.false129.29, %lor.lhs.false121.29, %lor.lhs.false112.29, %lor.lhs.false104.29, %lor.lhs.false96.29, %lor.lhs.false87.29, %lor.lhs.false79.29, %if.then70.29
  %arrayidx140.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %766
  store i8 -1, i8* %arrayidx140.29, align 1
  br label %for.inc153.29

for.inc153.29:                                    ; preds = %if.then138.29, %if.else141.29, %if.else145.29, %if.then63.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %exitcond.29 = icmp eq i64 %indvars.iv.next.29, 64
  br i1 %exitcond.29, label %for.inc156.29, label %for.body50.29, !llvm.loop !1

for.inc156.29:                                    ; preds = %for.inc153.29
  %indvars.iv.next19.29 = or i64 %indvars.iv18, 30
  %786 = shl nsw i64 %indvars.iv.next19.29, 6
  %787 = shl i64 %indvars.iv.next19.29, 6
  %788 = add nsw i64 %787, -64
  %789 = add nsw i64 %786, -1
  %790 = or i64 %786, 1
  %791 = or i64 %787, 64
  br label %for.body50.30

for.body50.30:                                    ; preds = %for.inc153.30, %for.inc156.29
  %indvars.iv.30 = phi i64 [ 0, %for.inc156.29 ], [ %indvars.iv.next.30, %for.inc153.30 ]
  %792 = add nuw nsw i64 %indvars.iv.30, %786
  %793 = trunc i64 %indvars.iv.30 to i32
  switch i32 %793, label %if.else.30 [
    i32 0, label %if.then63.30
    i32 63, label %if.then63.30
  ]

if.then63.30:                                     ; preds = %for.body50.30, %for.body50.30
  %arrayidx65.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %792
  store i8 0, i8* %arrayidx65.30, align 1
  br label %for.inc153.30

if.else.30:                                       ; preds = %for.body50.30
  %arrayidx67.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %792
  %794 = load i32, i32* %arrayidx67.30, align 4
  %cmp68.30 = icmp eq i32 %794, 75
  br i1 %cmp68.30, label %if.then70.30, label %if.else145.30

if.else145.30:                                    ; preds = %if.else.30
  %conv148.30 = trunc i32 %794 to i8
  %arrayidx150.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %792
  store i8 %conv148.30, i8* %arrayidx150.30, align 1
  br label %for.inc153.30

if.then70.30:                                     ; preds = %if.else.30
  %795 = add nuw nsw i64 %indvars.iv.30, %787
  %796 = add nsw i64 %795, -65
  %arrayidx76.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %796
  %797 = load i32, i32* %arrayidx76.30, align 4
  %cmp77.30 = icmp eq i32 %797, 255
  br i1 %cmp77.30, label %if.then138.30, label %lor.lhs.false79.30

lor.lhs.false79.30:                               ; preds = %if.then70.30
  %798 = add nuw nsw i64 %788, %indvars.iv.30
  %arrayidx84.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %798
  %799 = load i32, i32* %arrayidx84.30, align 4
  %cmp85.30 = icmp eq i32 %799, 255
  br i1 %cmp85.30, label %if.then138.30, label %lor.lhs.false87.30

lor.lhs.false87.30:                               ; preds = %lor.lhs.false79.30
  %800 = add nsw i64 %795, -63
  %arrayidx93.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %800
  %801 = load i32, i32* %arrayidx93.30, align 4
  %cmp94.30 = icmp eq i32 %801, 255
  br i1 %cmp94.30, label %if.then138.30, label %lor.lhs.false96.30

lor.lhs.false96.30:                               ; preds = %lor.lhs.false87.30
  %802 = add nuw nsw i64 %789, %indvars.iv.30
  %arrayidx101.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %802
  %803 = load i32, i32* %arrayidx101.30, align 4
  %cmp102.30 = icmp eq i32 %803, 255
  br i1 %cmp102.30, label %if.then138.30, label %lor.lhs.false104.30

lor.lhs.false104.30:                              ; preds = %lor.lhs.false96.30
  %804 = add nuw nsw i64 %790, %indvars.iv.30
  %arrayidx109.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %804
  %805 = load i32, i32* %arrayidx109.30, align 4
  %cmp110.30 = icmp eq i32 %805, 255
  br i1 %cmp110.30, label %if.then138.30, label %lor.lhs.false112.30

lor.lhs.false112.30:                              ; preds = %lor.lhs.false104.30
  %806 = add nuw nsw i64 %795, 63
  %arrayidx118.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %806
  %807 = load i32, i32* %arrayidx118.30, align 4
  %cmp119.30 = icmp eq i32 %807, 255
  br i1 %cmp119.30, label %if.then138.30, label %lor.lhs.false121.30

lor.lhs.false121.30:                              ; preds = %lor.lhs.false112.30
  %808 = add nuw nsw i64 %791, %indvars.iv.30
  %arrayidx126.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %808
  %809 = load i32, i32* %arrayidx126.30, align 4
  %cmp127.30 = icmp eq i32 %809, 255
  br i1 %cmp127.30, label %if.then138.30, label %lor.lhs.false129.30

lor.lhs.false129.30:                              ; preds = %lor.lhs.false121.30
  %810 = add nuw nsw i64 %795, 65
  %arrayidx135.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %810
  %811 = load i32, i32* %arrayidx135.30, align 4
  %cmp136.30 = icmp eq i32 %811, 255
  br i1 %cmp136.30, label %if.then138.30, label %if.else141.30

if.else141.30:                                    ; preds = %lor.lhs.false129.30
  %arrayidx143.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %792
  store i8 0, i8* %arrayidx143.30, align 1
  br label %for.inc153.30

if.then138.30:                                    ; preds = %lor.lhs.false129.30, %lor.lhs.false121.30, %lor.lhs.false112.30, %lor.lhs.false104.30, %lor.lhs.false96.30, %lor.lhs.false87.30, %lor.lhs.false79.30, %if.then70.30
  %arrayidx140.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %792
  store i8 -1, i8* %arrayidx140.30, align 1
  br label %for.inc153.30

for.inc153.30:                                    ; preds = %if.then138.30, %if.else141.30, %if.else145.30, %if.then63.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %exitcond.30 = icmp eq i64 %indvars.iv.next.30, 64
  br i1 %exitcond.30, label %for.inc156.30, label %for.body50.30, !llvm.loop !1

for.inc156.30:                                    ; preds = %for.inc153.30
  %indvars.iv.next19.30 = or i64 %indvars.iv18, 31
  %812 = shl nsw i64 %indvars.iv.next19.30, 6
  %813 = shl i64 %indvars.iv.next19.30, 6
  %814 = add nsw i64 %813, -64
  %815 = add nsw i64 %812, -1
  %816 = or i64 %812, 1
  %817 = add nuw nsw i64 %813, 64
  %818 = trunc i64 %indvars.iv.next19.30 to i32
  %cond40 = icmp eq i32 %818, 63
  br label %for.body50.31

for.body50.31:                                    ; preds = %for.inc153.31, %for.inc156.30
  %indvars.iv.31 = phi i64 [ 0, %for.inc156.30 ], [ %indvars.iv.next.31, %for.inc153.31 ]
  %819 = add nuw nsw i64 %indvars.iv.31, %812
  br i1 %cond40, label %if.then63.31, label %lor.lhs.false57.31

lor.lhs.false57.31:                               ; preds = %for.body50.31
  %820 = trunc i64 %indvars.iv.31 to i32
  switch i32 %820, label %if.else.31 [
    i32 0, label %if.then63.31
    i32 63, label %if.then63.31
  ]

if.then63.31:                                     ; preds = %for.body50.31, %lor.lhs.false57.31, %lor.lhs.false57.31
  %arrayidx65.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %819
  store i8 0, i8* %arrayidx65.31, align 1
  br label %for.inc153.31

if.else.31:                                       ; preds = %lor.lhs.false57.31
  %arrayidx67.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %819
  %821 = load i32, i32* %arrayidx67.31, align 4
  %cmp68.31 = icmp eq i32 %821, 75
  br i1 %cmp68.31, label %if.then70.31, label %if.else145.31

if.else145.31:                                    ; preds = %if.else.31
  %conv148.31 = trunc i32 %821 to i8
  %arrayidx150.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %819
  store i8 %conv148.31, i8* %arrayidx150.31, align 1
  br label %for.inc153.31

if.then70.31:                                     ; preds = %if.else.31
  %822 = add nuw nsw i64 %indvars.iv.31, %813
  %823 = add nsw i64 %822, -65
  %arrayidx76.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %823
  %824 = load i32, i32* %arrayidx76.31, align 4
  %cmp77.31 = icmp eq i32 %824, 255
  br i1 %cmp77.31, label %if.then138.31, label %lor.lhs.false79.31

lor.lhs.false79.31:                               ; preds = %if.then70.31
  %825 = add nuw nsw i64 %814, %indvars.iv.31
  %arrayidx84.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %825
  %826 = load i32, i32* %arrayidx84.31, align 4
  %cmp85.31 = icmp eq i32 %826, 255
  br i1 %cmp85.31, label %if.then138.31, label %lor.lhs.false87.31

lor.lhs.false87.31:                               ; preds = %lor.lhs.false79.31
  %827 = add nsw i64 %822, -63
  %arrayidx93.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %827
  %828 = load i32, i32* %arrayidx93.31, align 4
  %cmp94.31 = icmp eq i32 %828, 255
  br i1 %cmp94.31, label %if.then138.31, label %lor.lhs.false96.31

lor.lhs.false96.31:                               ; preds = %lor.lhs.false87.31
  %829 = add nuw nsw i64 %815, %indvars.iv.31
  %arrayidx101.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %829
  %830 = load i32, i32* %arrayidx101.31, align 4
  %cmp102.31 = icmp eq i32 %830, 255
  br i1 %cmp102.31, label %if.then138.31, label %lor.lhs.false104.31

lor.lhs.false104.31:                              ; preds = %lor.lhs.false96.31
  %831 = add nuw nsw i64 %816, %indvars.iv.31
  %arrayidx109.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %831
  %832 = load i32, i32* %arrayidx109.31, align 4
  %cmp110.31 = icmp eq i32 %832, 255
  br i1 %cmp110.31, label %if.then138.31, label %lor.lhs.false112.31

lor.lhs.false112.31:                              ; preds = %lor.lhs.false104.31
  %833 = add nuw nsw i64 %822, 63
  %arrayidx118.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %833
  %834 = load i32, i32* %arrayidx118.31, align 4
  %cmp119.31 = icmp eq i32 %834, 255
  br i1 %cmp119.31, label %if.then138.31, label %lor.lhs.false121.31

lor.lhs.false121.31:                              ; preds = %lor.lhs.false112.31
  %835 = add nuw nsw i64 %817, %indvars.iv.31
  %arrayidx126.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %835
  %836 = load i32, i32* %arrayidx126.31, align 4
  %cmp127.31 = icmp eq i32 %836, 255
  br i1 %cmp127.31, label %if.then138.31, label %lor.lhs.false129.31

lor.lhs.false129.31:                              ; preds = %lor.lhs.false121.31
  %837 = add nuw nsw i64 %822, 65
  %arrayidx135.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %837
  %838 = load i32, i32* %arrayidx135.31, align 4
  %cmp136.31 = icmp eq i32 %838, 255
  br i1 %cmp136.31, label %if.then138.31, label %if.else141.31

if.else141.31:                                    ; preds = %lor.lhs.false129.31
  %arrayidx143.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %819
  store i8 0, i8* %arrayidx143.31, align 1
  br label %for.inc153.31

if.then138.31:                                    ; preds = %lor.lhs.false129.31, %lor.lhs.false121.31, %lor.lhs.false112.31, %lor.lhs.false104.31, %lor.lhs.false96.31, %lor.lhs.false87.31, %lor.lhs.false79.31, %if.then70.31
  %arrayidx140.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %819
  store i8 -1, i8* %arrayidx140.31, align 1
  br label %for.inc153.31

for.inc153.31:                                    ; preds = %if.then138.31, %if.else141.31, %if.else145.31, %if.then63.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %exitcond.31 = icmp eq i64 %indvars.iv.next.31, 64
  br i1 %exitcond.31, label %for.inc156.31, label %for.body50.31, !llvm.loop !1

for.inc156.31:                                    ; preds = %for.inc153.31
  %indvars.iv.next19.31 = add nsw i64 %indvars.iv18, 32
  %exitcond26.31 = icmp eq i64 %indvars.iv.next19.31, 64
  br i1 %exitcond26.31, label %for.end158, label %for.cond47.preheader, !llvm.loop !3

if.then.1:                                        ; preds = %for.inc19
  store i32 %3, i32* %arrayidx12.1, align 4
  br label %for.inc19.1

for.inc19.1:                                      ; preds = %if.then.1, %for.inc19
  %839 = or i64 %indvars.iv34, 2
  %arrayidx10.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %839
  %840 = load i32, i32* %arrayidx10.2, align 8
  %841 = load i32, i32* %arrayidx12.2, align 8
  %cmp13.2 = icmp ugt i32 %840, %841
  br i1 %cmp13.2, label %if.then.2, label %for.inc19.2

if.then.2:                                        ; preds = %for.inc19.1
  store i32 %840, i32* %arrayidx12.2, align 8
  br label %for.inc19.2

for.inc19.2:                                      ; preds = %if.then.2, %for.inc19.1
  %842 = or i64 %indvars.iv34, 3
  %arrayidx10.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %842
  %843 = load i32, i32* %arrayidx10.3, align 4
  %844 = load i32, i32* %arrayidx12.3, align 4
  %cmp13.3 = icmp ugt i32 %843, %844
  br i1 %cmp13.3, label %if.then.3, label %for.inc19.3

if.then.3:                                        ; preds = %for.inc19.2
  store i32 %843, i32* %arrayidx12.3, align 4
  br label %for.inc19.3

for.inc19.3:                                      ; preds = %if.then.3, %for.inc19.2
  %845 = or i64 %indvars.iv34, 4
  %arrayidx10.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %845
  %846 = load i32, i32* %arrayidx10.4, align 16
  %847 = load i32, i32* %arrayidx12.4, align 16
  %cmp13.4 = icmp ugt i32 %846, %847
  br i1 %cmp13.4, label %if.then.4, label %for.inc19.4

if.then.4:                                        ; preds = %for.inc19.3
  store i32 %846, i32* %arrayidx12.4, align 16
  br label %for.inc19.4

for.inc19.4:                                      ; preds = %if.then.4, %for.inc19.3
  %848 = or i64 %indvars.iv34, 5
  %arrayidx10.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %848
  %849 = load i32, i32* %arrayidx10.5, align 4
  %850 = load i32, i32* %arrayidx12.5, align 4
  %cmp13.5 = icmp ugt i32 %849, %850
  br i1 %cmp13.5, label %if.then.5, label %for.inc19.5

if.then.5:                                        ; preds = %for.inc19.4
  store i32 %849, i32* %arrayidx12.5, align 4
  br label %for.inc19.5

for.inc19.5:                                      ; preds = %if.then.5, %for.inc19.4
  %851 = or i64 %indvars.iv34, 6
  %arrayidx10.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %851
  %852 = load i32, i32* %arrayidx10.6, align 8
  %853 = load i32, i32* %arrayidx12.6, align 8
  %cmp13.6 = icmp ugt i32 %852, %853
  br i1 %cmp13.6, label %if.then.6, label %for.inc19.6

if.then.6:                                        ; preds = %for.inc19.5
  store i32 %852, i32* %arrayidx12.6, align 8
  br label %for.inc19.6

for.inc19.6:                                      ; preds = %if.then.6, %for.inc19.5
  %854 = or i64 %indvars.iv34, 7
  %arrayidx10.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %854
  %855 = load i32, i32* %arrayidx10.7, align 4
  %856 = load i32, i32* %arrayidx12.7, align 4
  %cmp13.7 = icmp ugt i32 %855, %856
  br i1 %cmp13.7, label %if.then.7, label %for.inc19.7

if.then.7:                                        ; preds = %for.inc19.6
  store i32 %855, i32* %arrayidx12.7, align 4
  br label %for.inc19.7

for.inc19.7:                                      ; preds = %if.then.7, %for.inc19.6
  %857 = or i64 %indvars.iv34, 8
  %arrayidx10.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %857
  %858 = load i32, i32* %arrayidx10.8, align 32
  %859 = load i32, i32* %arrayidx12.8, align 16
  %cmp13.8 = icmp ugt i32 %858, %859
  br i1 %cmp13.8, label %if.then.8, label %for.inc19.8

if.then.8:                                        ; preds = %for.inc19.7
  store i32 %858, i32* %arrayidx12.8, align 16
  br label %for.inc19.8

for.inc19.8:                                      ; preds = %if.then.8, %for.inc19.7
  %860 = or i64 %indvars.iv34, 9
  %arrayidx10.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %860
  %861 = load i32, i32* %arrayidx10.9, align 4
  %862 = load i32, i32* %arrayidx12.9, align 4
  %cmp13.9 = icmp ugt i32 %861, %862
  br i1 %cmp13.9, label %if.then.9, label %for.inc19.9

if.then.9:                                        ; preds = %for.inc19.8
  store i32 %861, i32* %arrayidx12.9, align 4
  br label %for.inc19.9

for.inc19.9:                                      ; preds = %if.then.9, %for.inc19.8
  %863 = or i64 %indvars.iv34, 10
  %arrayidx10.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %863
  %864 = load i32, i32* %arrayidx10.10, align 8
  %865 = load i32, i32* %arrayidx12.10, align 8
  %cmp13.10 = icmp ugt i32 %864, %865
  br i1 %cmp13.10, label %if.then.10, label %for.inc19.10

if.then.10:                                       ; preds = %for.inc19.9
  store i32 %864, i32* %arrayidx12.10, align 8
  br label %for.inc19.10

for.inc19.10:                                     ; preds = %if.then.10, %for.inc19.9
  %866 = or i64 %indvars.iv34, 11
  %arrayidx10.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %866
  %867 = load i32, i32* %arrayidx10.11, align 4
  %868 = load i32, i32* %arrayidx12.11, align 4
  %cmp13.11 = icmp ugt i32 %867, %868
  br i1 %cmp13.11, label %if.then.11, label %for.inc19.11

if.then.11:                                       ; preds = %for.inc19.10
  store i32 %867, i32* %arrayidx12.11, align 4
  br label %for.inc19.11

for.inc19.11:                                     ; preds = %if.then.11, %for.inc19.10
  %869 = or i64 %indvars.iv34, 12
  %arrayidx10.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %869
  %870 = load i32, i32* %arrayidx10.12, align 16
  %871 = load i32, i32* %arrayidx12.12, align 16
  %cmp13.12 = icmp ugt i32 %870, %871
  br i1 %cmp13.12, label %if.then.12, label %for.inc19.12

if.then.12:                                       ; preds = %for.inc19.11
  store i32 %870, i32* %arrayidx12.12, align 16
  br label %for.inc19.12

for.inc19.12:                                     ; preds = %if.then.12, %for.inc19.11
  %872 = or i64 %indvars.iv34, 13
  %arrayidx10.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %872
  %873 = load i32, i32* %arrayidx10.13, align 4
  %874 = load i32, i32* %arrayidx12.13, align 4
  %cmp13.13 = icmp ugt i32 %873, %874
  br i1 %cmp13.13, label %if.then.13, label %for.inc19.13

if.then.13:                                       ; preds = %for.inc19.12
  store i32 %873, i32* %arrayidx12.13, align 4
  br label %for.inc19.13

for.inc19.13:                                     ; preds = %if.then.13, %for.inc19.12
  %875 = or i64 %indvars.iv34, 14
  %arrayidx10.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %875
  %876 = load i32, i32* %arrayidx10.14, align 8
  %877 = load i32, i32* %arrayidx12.14, align 8
  %cmp13.14 = icmp ugt i32 %876, %877
  br i1 %cmp13.14, label %if.then.14, label %for.inc19.14

if.then.14:                                       ; preds = %for.inc19.13
  store i32 %876, i32* %arrayidx12.14, align 8
  br label %for.inc19.14

for.inc19.14:                                     ; preds = %if.then.14, %for.inc19.13
  %878 = or i64 %indvars.iv34, 15
  %arrayidx10.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %878
  %879 = load i32, i32* %arrayidx10.15, align 4
  %880 = load i32, i32* %arrayidx12.15, align 4
  %cmp13.15 = icmp ugt i32 %879, %880
  br i1 %cmp13.15, label %if.then.15, label %for.inc19.15

if.then.15:                                       ; preds = %for.inc19.14
  store i32 %879, i32* %arrayidx12.15, align 4
  br label %for.inc19.15

for.inc19.15:                                     ; preds = %if.then.15, %for.inc19.14
  %indvars.iv.next35 = add nuw nsw i64 %indvars.iv34, 16
  %cmp4 = icmp slt i64 %indvars.iv.next35, 4096
  br i1 %cmp4, label %for.body8, label %for.cond47.preheader.preheader, !llvm.loop !4

for.cond47.preheader.preheader:                   ; preds = %for.inc19.15
  br label %for.cond47.preheader
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
!4 = distinct !{!4, !2}
