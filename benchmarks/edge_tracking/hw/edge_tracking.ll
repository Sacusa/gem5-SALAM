; ModuleID = 'edge_tracking.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: norecurse nounwind uwtable
define void @edge_tracking(i32 %img_height, i32 %img_width, float %thr_weak_ratio, float %thr_strong_ratio) #0 {
for.cond20.preheader.preheader:
  br label %for.cond20.preheader

for.cond20.preheader:                             ; preds = %for.inc128.31, %for.cond20.preheader.preheader
  %indvars.iv16 = phi i64 [ 0, %for.cond20.preheader.preheader ], [ %indvars.iv.next17.31, %for.inc128.31 ]
  %0 = shl nsw i64 %indvars.iv16, 6
  %1 = shl i64 %indvars.iv16, 6
  %2 = add nsw i64 %1, -64
  %3 = add nsw i64 %0, -1
  %4 = or i64 %0, 1
  %5 = or i64 %1, 64
  %6 = trunc i64 %indvars.iv16 to i32
  %cond = icmp eq i32 %6, 0
  br label %for.body23

for.body23:                                       ; preds = %for.inc125, %for.cond20.preheader
  %indvars.iv = phi i64 [ 0, %for.cond20.preheader ], [ %indvars.iv.next, %for.inc125 ]
  %7 = add nuw nsw i64 %indvars.iv, %0
  br i1 %cond, label %if.then35, label %lor.lhs.false29

lor.lhs.false29:                                  ; preds = %for.body23
  %8 = trunc i64 %indvars.iv to i32
  switch i32 %8, label %if.else [
    i32 0, label %if.then35
    i32 63, label %if.then35
  ]

if.then35:                                        ; preds = %for.body23, %lor.lhs.false29, %lor.lhs.false29
  %arrayidx37 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %7
  store i8 0, i8* %arrayidx37, align 1
  br label %for.inc125

if.else:                                          ; preds = %lor.lhs.false29
  %arrayidx39 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %7
  %9 = load i32, i32* %arrayidx39, align 4
  %cmp40 = icmp eq i32 %9, 75
  br i1 %cmp40, label %if.then42, label %if.else117

if.then42:                                        ; preds = %if.else
  %10 = add nuw nsw i64 %indvars.iv, %1
  %11 = add nsw i64 %10, -65
  %arrayidx48 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %11
  %12 = load i32, i32* %arrayidx48, align 4
  %cmp49 = icmp eq i32 %12, 255
  br i1 %cmp49, label %if.then110, label %lor.lhs.false51

lor.lhs.false51:                                  ; preds = %if.then42
  %13 = add nsw i64 %2, %indvars.iv
  %arrayidx56 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %13
  %14 = load i32, i32* %arrayidx56, align 4
  %cmp57 = icmp eq i32 %14, 255
  br i1 %cmp57, label %if.then110, label %lor.lhs.false59

lor.lhs.false59:                                  ; preds = %lor.lhs.false51
  %15 = add nsw i64 %10, -63
  %arrayidx65 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %15
  %16 = load i32, i32* %arrayidx65, align 4
  %cmp66 = icmp eq i32 %16, 255
  br i1 %cmp66, label %if.then110, label %lor.lhs.false68

lor.lhs.false68:                                  ; preds = %lor.lhs.false59
  %17 = add nsw i64 %3, %indvars.iv
  %arrayidx73 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %17
  %18 = load i32, i32* %arrayidx73, align 4
  %cmp74 = icmp eq i32 %18, 255
  br i1 %cmp74, label %if.then110, label %lor.lhs.false76

lor.lhs.false76:                                  ; preds = %lor.lhs.false68
  %19 = add nuw nsw i64 %4, %indvars.iv
  %arrayidx81 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %19
  %20 = load i32, i32* %arrayidx81, align 4
  %cmp82 = icmp eq i32 %20, 255
  br i1 %cmp82, label %if.then110, label %lor.lhs.false84

lor.lhs.false84:                                  ; preds = %lor.lhs.false76
  %21 = add nuw nsw i64 %10, 63
  %arrayidx90 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %21
  %22 = load i32, i32* %arrayidx90, align 4
  %cmp91 = icmp eq i32 %22, 255
  br i1 %cmp91, label %if.then110, label %lor.lhs.false93

lor.lhs.false93:                                  ; preds = %lor.lhs.false84
  %23 = add nuw nsw i64 %5, %indvars.iv
  %arrayidx98 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %23
  %24 = load i32, i32* %arrayidx98, align 4
  %cmp99 = icmp eq i32 %24, 255
  br i1 %cmp99, label %if.then110, label %lor.lhs.false101

lor.lhs.false101:                                 ; preds = %lor.lhs.false93
  %25 = add nuw nsw i64 %10, 65
  %arrayidx107 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %25
  %26 = load i32, i32* %arrayidx107, align 4
  %cmp108 = icmp eq i32 %26, 255
  br i1 %cmp108, label %if.then110, label %if.else113

if.then110:                                       ; preds = %lor.lhs.false101, %lor.lhs.false93, %lor.lhs.false84, %lor.lhs.false76, %lor.lhs.false68, %lor.lhs.false59, %lor.lhs.false51, %if.then42
  %arrayidx112 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %7
  store i8 -1, i8* %arrayidx112, align 1
  br label %for.inc125

if.else113:                                       ; preds = %lor.lhs.false101
  %arrayidx115 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %7
  store i8 0, i8* %arrayidx115, align 1
  br label %for.inc125

if.else117:                                       ; preds = %if.else
  %conv120 = trunc i32 %9 to i8
  %arrayidx122 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %7
  store i8 %conv120, i8* %arrayidx122, align 1
  br label %for.inc125

for.inc125:                                       ; preds = %if.then35, %if.then110, %if.else113, %if.else117
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 64
  br i1 %exitcond, label %for.inc128, label %for.body23, !llvm.loop !1

for.inc128:                                       ; preds = %for.inc125
  %indvars.iv.next17 = or i64 %indvars.iv16, 1
  %27 = shl nsw i64 %indvars.iv.next17, 6
  %28 = shl i64 %indvars.iv.next17, 6
  %29 = add nsw i64 %28, -64
  %30 = add nsw i64 %27, -1
  %31 = or i64 %27, 1
  %32 = add nuw nsw i64 %28, 64
  br label %for.body23.1

for.end130:                                       ; preds = %for.inc128.31
  ret void

for.body23.1:                                     ; preds = %for.inc125.1, %for.inc128
  %indvars.iv.1 = phi i64 [ 0, %for.inc128 ], [ %indvars.iv.next.1, %for.inc125.1 ]
  %33 = add nuw nsw i64 %indvars.iv.1, %27
  %34 = trunc i64 %indvars.iv.1 to i32
  switch i32 %34, label %if.else.1 [
    i32 0, label %if.then35.1
    i32 63, label %if.then35.1
  ]

if.then35.1:                                      ; preds = %for.body23.1, %for.body23.1
  %arrayidx37.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %33
  store i8 0, i8* %arrayidx37.1, align 1
  br label %for.inc125.1

if.else.1:                                        ; preds = %for.body23.1
  %arrayidx39.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %33
  %35 = load i32, i32* %arrayidx39.1, align 4
  %cmp40.1 = icmp eq i32 %35, 75
  br i1 %cmp40.1, label %if.then42.1, label %if.else117.1

if.else117.1:                                     ; preds = %if.else.1
  %conv120.1 = trunc i32 %35 to i8
  %arrayidx122.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %33
  store i8 %conv120.1, i8* %arrayidx122.1, align 1
  br label %for.inc125.1

if.then42.1:                                      ; preds = %if.else.1
  %36 = add nuw nsw i64 %indvars.iv.1, %28
  %37 = add nsw i64 %36, -65
  %arrayidx48.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %37
  %38 = load i32, i32* %arrayidx48.1, align 4
  %cmp49.1 = icmp eq i32 %38, 255
  br i1 %cmp49.1, label %if.then110.1, label %lor.lhs.false51.1

lor.lhs.false51.1:                                ; preds = %if.then42.1
  %39 = add nuw nsw i64 %29, %indvars.iv.1
  %arrayidx56.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %39
  %40 = load i32, i32* %arrayidx56.1, align 4
  %cmp57.1 = icmp eq i32 %40, 255
  br i1 %cmp57.1, label %if.then110.1, label %lor.lhs.false59.1

lor.lhs.false59.1:                                ; preds = %lor.lhs.false51.1
  %41 = add nsw i64 %36, -63
  %arrayidx65.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %41
  %42 = load i32, i32* %arrayidx65.1, align 4
  %cmp66.1 = icmp eq i32 %42, 255
  br i1 %cmp66.1, label %if.then110.1, label %lor.lhs.false68.1

lor.lhs.false68.1:                                ; preds = %lor.lhs.false59.1
  %43 = add nuw nsw i64 %30, %indvars.iv.1
  %arrayidx73.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %43
  %44 = load i32, i32* %arrayidx73.1, align 4
  %cmp74.1 = icmp eq i32 %44, 255
  br i1 %cmp74.1, label %if.then110.1, label %lor.lhs.false76.1

lor.lhs.false76.1:                                ; preds = %lor.lhs.false68.1
  %45 = add nuw nsw i64 %31, %indvars.iv.1
  %arrayidx81.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %45
  %46 = load i32, i32* %arrayidx81.1, align 4
  %cmp82.1 = icmp eq i32 %46, 255
  br i1 %cmp82.1, label %if.then110.1, label %lor.lhs.false84.1

lor.lhs.false84.1:                                ; preds = %lor.lhs.false76.1
  %47 = add nuw nsw i64 %36, 63
  %arrayidx90.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %47
  %48 = load i32, i32* %arrayidx90.1, align 4
  %cmp91.1 = icmp eq i32 %48, 255
  br i1 %cmp91.1, label %if.then110.1, label %lor.lhs.false93.1

lor.lhs.false93.1:                                ; preds = %lor.lhs.false84.1
  %49 = add nuw nsw i64 %32, %indvars.iv.1
  %arrayidx98.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %49
  %50 = load i32, i32* %arrayidx98.1, align 4
  %cmp99.1 = icmp eq i32 %50, 255
  br i1 %cmp99.1, label %if.then110.1, label %lor.lhs.false101.1

lor.lhs.false101.1:                               ; preds = %lor.lhs.false93.1
  %51 = add nuw nsw i64 %36, 65
  %arrayidx107.1 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %51
  %52 = load i32, i32* %arrayidx107.1, align 4
  %cmp108.1 = icmp eq i32 %52, 255
  br i1 %cmp108.1, label %if.then110.1, label %if.else113.1

if.else113.1:                                     ; preds = %lor.lhs.false101.1
  %arrayidx115.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %33
  store i8 0, i8* %arrayidx115.1, align 1
  br label %for.inc125.1

if.then110.1:                                     ; preds = %lor.lhs.false101.1, %lor.lhs.false93.1, %lor.lhs.false84.1, %lor.lhs.false76.1, %lor.lhs.false68.1, %lor.lhs.false59.1, %lor.lhs.false51.1, %if.then42.1
  %arrayidx112.1 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %33
  store i8 -1, i8* %arrayidx112.1, align 1
  br label %for.inc125.1

for.inc125.1:                                     ; preds = %if.then110.1, %if.else113.1, %if.else117.1, %if.then35.1
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.1, 1
  %exitcond.1 = icmp eq i64 %indvars.iv.next.1, 64
  br i1 %exitcond.1, label %for.inc128.1, label %for.body23.1, !llvm.loop !1

for.inc128.1:                                     ; preds = %for.inc125.1
  %indvars.iv.next17.1 = or i64 %indvars.iv16, 2
  %53 = shl nsw i64 %indvars.iv.next17.1, 6
  %54 = shl i64 %indvars.iv.next17.1, 6
  %55 = add nsw i64 %54, -64
  %56 = add nsw i64 %53, -1
  %57 = or i64 %53, 1
  %58 = or i64 %54, 64
  br label %for.body23.2

for.body23.2:                                     ; preds = %for.inc125.2, %for.inc128.1
  %indvars.iv.2 = phi i64 [ 0, %for.inc128.1 ], [ %indvars.iv.next.2, %for.inc125.2 ]
  %59 = add nuw nsw i64 %indvars.iv.2, %53
  %60 = trunc i64 %indvars.iv.2 to i32
  switch i32 %60, label %if.else.2 [
    i32 0, label %if.then35.2
    i32 63, label %if.then35.2
  ]

if.then35.2:                                      ; preds = %for.body23.2, %for.body23.2
  %arrayidx37.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %59
  store i8 0, i8* %arrayidx37.2, align 1
  br label %for.inc125.2

if.else.2:                                        ; preds = %for.body23.2
  %arrayidx39.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %59
  %61 = load i32, i32* %arrayidx39.2, align 4
  %cmp40.2 = icmp eq i32 %61, 75
  br i1 %cmp40.2, label %if.then42.2, label %if.else117.2

if.else117.2:                                     ; preds = %if.else.2
  %conv120.2 = trunc i32 %61 to i8
  %arrayidx122.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %59
  store i8 %conv120.2, i8* %arrayidx122.2, align 1
  br label %for.inc125.2

if.then42.2:                                      ; preds = %if.else.2
  %62 = add nuw nsw i64 %indvars.iv.2, %54
  %63 = add nsw i64 %62, -65
  %arrayidx48.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %63
  %64 = load i32, i32* %arrayidx48.2, align 4
  %cmp49.2 = icmp eq i32 %64, 255
  br i1 %cmp49.2, label %if.then110.2, label %lor.lhs.false51.2

lor.lhs.false51.2:                                ; preds = %if.then42.2
  %65 = add nuw nsw i64 %55, %indvars.iv.2
  %arrayidx56.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %65
  %66 = load i32, i32* %arrayidx56.2, align 4
  %cmp57.2 = icmp eq i32 %66, 255
  br i1 %cmp57.2, label %if.then110.2, label %lor.lhs.false59.2

lor.lhs.false59.2:                                ; preds = %lor.lhs.false51.2
  %67 = add nsw i64 %62, -63
  %arrayidx65.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %67
  %68 = load i32, i32* %arrayidx65.2, align 4
  %cmp66.2 = icmp eq i32 %68, 255
  br i1 %cmp66.2, label %if.then110.2, label %lor.lhs.false68.2

lor.lhs.false68.2:                                ; preds = %lor.lhs.false59.2
  %69 = add nuw nsw i64 %56, %indvars.iv.2
  %arrayidx73.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %69
  %70 = load i32, i32* %arrayidx73.2, align 4
  %cmp74.2 = icmp eq i32 %70, 255
  br i1 %cmp74.2, label %if.then110.2, label %lor.lhs.false76.2

lor.lhs.false76.2:                                ; preds = %lor.lhs.false68.2
  %71 = add nuw nsw i64 %57, %indvars.iv.2
  %arrayidx81.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %71
  %72 = load i32, i32* %arrayidx81.2, align 4
  %cmp82.2 = icmp eq i32 %72, 255
  br i1 %cmp82.2, label %if.then110.2, label %lor.lhs.false84.2

lor.lhs.false84.2:                                ; preds = %lor.lhs.false76.2
  %73 = add nuw nsw i64 %62, 63
  %arrayidx90.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %73
  %74 = load i32, i32* %arrayidx90.2, align 4
  %cmp91.2 = icmp eq i32 %74, 255
  br i1 %cmp91.2, label %if.then110.2, label %lor.lhs.false93.2

lor.lhs.false93.2:                                ; preds = %lor.lhs.false84.2
  %75 = add nuw nsw i64 %58, %indvars.iv.2
  %arrayidx98.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %75
  %76 = load i32, i32* %arrayidx98.2, align 4
  %cmp99.2 = icmp eq i32 %76, 255
  br i1 %cmp99.2, label %if.then110.2, label %lor.lhs.false101.2

lor.lhs.false101.2:                               ; preds = %lor.lhs.false93.2
  %77 = add nuw nsw i64 %62, 65
  %arrayidx107.2 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %77
  %78 = load i32, i32* %arrayidx107.2, align 4
  %cmp108.2 = icmp eq i32 %78, 255
  br i1 %cmp108.2, label %if.then110.2, label %if.else113.2

if.else113.2:                                     ; preds = %lor.lhs.false101.2
  %arrayidx115.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %59
  store i8 0, i8* %arrayidx115.2, align 1
  br label %for.inc125.2

if.then110.2:                                     ; preds = %lor.lhs.false101.2, %lor.lhs.false93.2, %lor.lhs.false84.2, %lor.lhs.false76.2, %lor.lhs.false68.2, %lor.lhs.false59.2, %lor.lhs.false51.2, %if.then42.2
  %arrayidx112.2 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %59
  store i8 -1, i8* %arrayidx112.2, align 1
  br label %for.inc125.2

for.inc125.2:                                     ; preds = %if.then110.2, %if.else113.2, %if.else117.2, %if.then35.2
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.2, 1
  %exitcond.2 = icmp eq i64 %indvars.iv.next.2, 64
  br i1 %exitcond.2, label %for.inc128.2, label %for.body23.2, !llvm.loop !1

for.inc128.2:                                     ; preds = %for.inc125.2
  %indvars.iv.next17.2 = or i64 %indvars.iv16, 3
  %79 = shl nsw i64 %indvars.iv.next17.2, 6
  %80 = shl i64 %indvars.iv.next17.2, 6
  %81 = add nsw i64 %80, -64
  %82 = add nsw i64 %79, -1
  %83 = or i64 %79, 1
  %84 = add nuw nsw i64 %80, 64
  br label %for.body23.3

for.body23.3:                                     ; preds = %for.inc125.3, %for.inc128.2
  %indvars.iv.3 = phi i64 [ 0, %for.inc128.2 ], [ %indvars.iv.next.3, %for.inc125.3 ]
  %85 = add nuw nsw i64 %indvars.iv.3, %79
  %86 = trunc i64 %indvars.iv.3 to i32
  switch i32 %86, label %if.else.3 [
    i32 0, label %if.then35.3
    i32 63, label %if.then35.3
  ]

if.then35.3:                                      ; preds = %for.body23.3, %for.body23.3
  %arrayidx37.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %85
  store i8 0, i8* %arrayidx37.3, align 1
  br label %for.inc125.3

if.else.3:                                        ; preds = %for.body23.3
  %arrayidx39.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %85
  %87 = load i32, i32* %arrayidx39.3, align 4
  %cmp40.3 = icmp eq i32 %87, 75
  br i1 %cmp40.3, label %if.then42.3, label %if.else117.3

if.else117.3:                                     ; preds = %if.else.3
  %conv120.3 = trunc i32 %87 to i8
  %arrayidx122.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %85
  store i8 %conv120.3, i8* %arrayidx122.3, align 1
  br label %for.inc125.3

if.then42.3:                                      ; preds = %if.else.3
  %88 = add nuw nsw i64 %indvars.iv.3, %80
  %89 = add nsw i64 %88, -65
  %arrayidx48.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %89
  %90 = load i32, i32* %arrayidx48.3, align 4
  %cmp49.3 = icmp eq i32 %90, 255
  br i1 %cmp49.3, label %if.then110.3, label %lor.lhs.false51.3

lor.lhs.false51.3:                                ; preds = %if.then42.3
  %91 = add nuw nsw i64 %81, %indvars.iv.3
  %arrayidx56.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %91
  %92 = load i32, i32* %arrayidx56.3, align 4
  %cmp57.3 = icmp eq i32 %92, 255
  br i1 %cmp57.3, label %if.then110.3, label %lor.lhs.false59.3

lor.lhs.false59.3:                                ; preds = %lor.lhs.false51.3
  %93 = add nsw i64 %88, -63
  %arrayidx65.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %93
  %94 = load i32, i32* %arrayidx65.3, align 4
  %cmp66.3 = icmp eq i32 %94, 255
  br i1 %cmp66.3, label %if.then110.3, label %lor.lhs.false68.3

lor.lhs.false68.3:                                ; preds = %lor.lhs.false59.3
  %95 = add nuw nsw i64 %82, %indvars.iv.3
  %arrayidx73.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %95
  %96 = load i32, i32* %arrayidx73.3, align 4
  %cmp74.3 = icmp eq i32 %96, 255
  br i1 %cmp74.3, label %if.then110.3, label %lor.lhs.false76.3

lor.lhs.false76.3:                                ; preds = %lor.lhs.false68.3
  %97 = add nuw nsw i64 %83, %indvars.iv.3
  %arrayidx81.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %97
  %98 = load i32, i32* %arrayidx81.3, align 4
  %cmp82.3 = icmp eq i32 %98, 255
  br i1 %cmp82.3, label %if.then110.3, label %lor.lhs.false84.3

lor.lhs.false84.3:                                ; preds = %lor.lhs.false76.3
  %99 = add nuw nsw i64 %88, 63
  %arrayidx90.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %99
  %100 = load i32, i32* %arrayidx90.3, align 4
  %cmp91.3 = icmp eq i32 %100, 255
  br i1 %cmp91.3, label %if.then110.3, label %lor.lhs.false93.3

lor.lhs.false93.3:                                ; preds = %lor.lhs.false84.3
  %101 = add nuw nsw i64 %84, %indvars.iv.3
  %arrayidx98.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %101
  %102 = load i32, i32* %arrayidx98.3, align 4
  %cmp99.3 = icmp eq i32 %102, 255
  br i1 %cmp99.3, label %if.then110.3, label %lor.lhs.false101.3

lor.lhs.false101.3:                               ; preds = %lor.lhs.false93.3
  %103 = add nuw nsw i64 %88, 65
  %arrayidx107.3 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %103
  %104 = load i32, i32* %arrayidx107.3, align 4
  %cmp108.3 = icmp eq i32 %104, 255
  br i1 %cmp108.3, label %if.then110.3, label %if.else113.3

if.else113.3:                                     ; preds = %lor.lhs.false101.3
  %arrayidx115.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %85
  store i8 0, i8* %arrayidx115.3, align 1
  br label %for.inc125.3

if.then110.3:                                     ; preds = %lor.lhs.false101.3, %lor.lhs.false93.3, %lor.lhs.false84.3, %lor.lhs.false76.3, %lor.lhs.false68.3, %lor.lhs.false59.3, %lor.lhs.false51.3, %if.then42.3
  %arrayidx112.3 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %85
  store i8 -1, i8* %arrayidx112.3, align 1
  br label %for.inc125.3

for.inc125.3:                                     ; preds = %if.then110.3, %if.else113.3, %if.else117.3, %if.then35.3
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.3, 1
  %exitcond.3 = icmp eq i64 %indvars.iv.next.3, 64
  br i1 %exitcond.3, label %for.inc128.3, label %for.body23.3, !llvm.loop !1

for.inc128.3:                                     ; preds = %for.inc125.3
  %indvars.iv.next17.3 = or i64 %indvars.iv16, 4
  %105 = shl nsw i64 %indvars.iv.next17.3, 6
  %106 = shl i64 %indvars.iv.next17.3, 6
  %107 = add nsw i64 %106, -64
  %108 = add nsw i64 %105, -1
  %109 = or i64 %105, 1
  %110 = or i64 %106, 64
  br label %for.body23.4

for.body23.4:                                     ; preds = %for.inc125.4, %for.inc128.3
  %indvars.iv.4 = phi i64 [ 0, %for.inc128.3 ], [ %indvars.iv.next.4, %for.inc125.4 ]
  %111 = add nuw nsw i64 %indvars.iv.4, %105
  %112 = trunc i64 %indvars.iv.4 to i32
  switch i32 %112, label %if.else.4 [
    i32 0, label %if.then35.4
    i32 63, label %if.then35.4
  ]

if.then35.4:                                      ; preds = %for.body23.4, %for.body23.4
  %arrayidx37.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %111
  store i8 0, i8* %arrayidx37.4, align 1
  br label %for.inc125.4

if.else.4:                                        ; preds = %for.body23.4
  %arrayidx39.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %111
  %113 = load i32, i32* %arrayidx39.4, align 4
  %cmp40.4 = icmp eq i32 %113, 75
  br i1 %cmp40.4, label %if.then42.4, label %if.else117.4

if.else117.4:                                     ; preds = %if.else.4
  %conv120.4 = trunc i32 %113 to i8
  %arrayidx122.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %111
  store i8 %conv120.4, i8* %arrayidx122.4, align 1
  br label %for.inc125.4

if.then42.4:                                      ; preds = %if.else.4
  %114 = add nuw nsw i64 %indvars.iv.4, %106
  %115 = add nsw i64 %114, -65
  %arrayidx48.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %115
  %116 = load i32, i32* %arrayidx48.4, align 4
  %cmp49.4 = icmp eq i32 %116, 255
  br i1 %cmp49.4, label %if.then110.4, label %lor.lhs.false51.4

lor.lhs.false51.4:                                ; preds = %if.then42.4
  %117 = add nuw nsw i64 %107, %indvars.iv.4
  %arrayidx56.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %117
  %118 = load i32, i32* %arrayidx56.4, align 4
  %cmp57.4 = icmp eq i32 %118, 255
  br i1 %cmp57.4, label %if.then110.4, label %lor.lhs.false59.4

lor.lhs.false59.4:                                ; preds = %lor.lhs.false51.4
  %119 = add nsw i64 %114, -63
  %arrayidx65.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %119
  %120 = load i32, i32* %arrayidx65.4, align 4
  %cmp66.4 = icmp eq i32 %120, 255
  br i1 %cmp66.4, label %if.then110.4, label %lor.lhs.false68.4

lor.lhs.false68.4:                                ; preds = %lor.lhs.false59.4
  %121 = add nuw nsw i64 %108, %indvars.iv.4
  %arrayidx73.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %121
  %122 = load i32, i32* %arrayidx73.4, align 4
  %cmp74.4 = icmp eq i32 %122, 255
  br i1 %cmp74.4, label %if.then110.4, label %lor.lhs.false76.4

lor.lhs.false76.4:                                ; preds = %lor.lhs.false68.4
  %123 = add nuw nsw i64 %109, %indvars.iv.4
  %arrayidx81.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %123
  %124 = load i32, i32* %arrayidx81.4, align 4
  %cmp82.4 = icmp eq i32 %124, 255
  br i1 %cmp82.4, label %if.then110.4, label %lor.lhs.false84.4

lor.lhs.false84.4:                                ; preds = %lor.lhs.false76.4
  %125 = add nuw nsw i64 %114, 63
  %arrayidx90.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %125
  %126 = load i32, i32* %arrayidx90.4, align 4
  %cmp91.4 = icmp eq i32 %126, 255
  br i1 %cmp91.4, label %if.then110.4, label %lor.lhs.false93.4

lor.lhs.false93.4:                                ; preds = %lor.lhs.false84.4
  %127 = add nuw nsw i64 %110, %indvars.iv.4
  %arrayidx98.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %127
  %128 = load i32, i32* %arrayidx98.4, align 4
  %cmp99.4 = icmp eq i32 %128, 255
  br i1 %cmp99.4, label %if.then110.4, label %lor.lhs.false101.4

lor.lhs.false101.4:                               ; preds = %lor.lhs.false93.4
  %129 = add nuw nsw i64 %114, 65
  %arrayidx107.4 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %129
  %130 = load i32, i32* %arrayidx107.4, align 4
  %cmp108.4 = icmp eq i32 %130, 255
  br i1 %cmp108.4, label %if.then110.4, label %if.else113.4

if.else113.4:                                     ; preds = %lor.lhs.false101.4
  %arrayidx115.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %111
  store i8 0, i8* %arrayidx115.4, align 1
  br label %for.inc125.4

if.then110.4:                                     ; preds = %lor.lhs.false101.4, %lor.lhs.false93.4, %lor.lhs.false84.4, %lor.lhs.false76.4, %lor.lhs.false68.4, %lor.lhs.false59.4, %lor.lhs.false51.4, %if.then42.4
  %arrayidx112.4 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %111
  store i8 -1, i8* %arrayidx112.4, align 1
  br label %for.inc125.4

for.inc125.4:                                     ; preds = %if.then110.4, %if.else113.4, %if.else117.4, %if.then35.4
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.4, 1
  %exitcond.4 = icmp eq i64 %indvars.iv.next.4, 64
  br i1 %exitcond.4, label %for.inc128.4, label %for.body23.4, !llvm.loop !1

for.inc128.4:                                     ; preds = %for.inc125.4
  %indvars.iv.next17.4 = or i64 %indvars.iv16, 5
  %131 = shl nsw i64 %indvars.iv.next17.4, 6
  %132 = shl i64 %indvars.iv.next17.4, 6
  %133 = add nsw i64 %132, -64
  %134 = add nsw i64 %131, -1
  %135 = or i64 %131, 1
  %136 = add nuw nsw i64 %132, 64
  br label %for.body23.5

for.body23.5:                                     ; preds = %for.inc125.5, %for.inc128.4
  %indvars.iv.5 = phi i64 [ 0, %for.inc128.4 ], [ %indvars.iv.next.5, %for.inc125.5 ]
  %137 = add nuw nsw i64 %indvars.iv.5, %131
  %138 = trunc i64 %indvars.iv.5 to i32
  switch i32 %138, label %if.else.5 [
    i32 0, label %if.then35.5
    i32 63, label %if.then35.5
  ]

if.then35.5:                                      ; preds = %for.body23.5, %for.body23.5
  %arrayidx37.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %137
  store i8 0, i8* %arrayidx37.5, align 1
  br label %for.inc125.5

if.else.5:                                        ; preds = %for.body23.5
  %arrayidx39.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %137
  %139 = load i32, i32* %arrayidx39.5, align 4
  %cmp40.5 = icmp eq i32 %139, 75
  br i1 %cmp40.5, label %if.then42.5, label %if.else117.5

if.else117.5:                                     ; preds = %if.else.5
  %conv120.5 = trunc i32 %139 to i8
  %arrayidx122.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %137
  store i8 %conv120.5, i8* %arrayidx122.5, align 1
  br label %for.inc125.5

if.then42.5:                                      ; preds = %if.else.5
  %140 = add nuw nsw i64 %indvars.iv.5, %132
  %141 = add nsw i64 %140, -65
  %arrayidx48.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %141
  %142 = load i32, i32* %arrayidx48.5, align 4
  %cmp49.5 = icmp eq i32 %142, 255
  br i1 %cmp49.5, label %if.then110.5, label %lor.lhs.false51.5

lor.lhs.false51.5:                                ; preds = %if.then42.5
  %143 = add nuw nsw i64 %133, %indvars.iv.5
  %arrayidx56.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %143
  %144 = load i32, i32* %arrayidx56.5, align 4
  %cmp57.5 = icmp eq i32 %144, 255
  br i1 %cmp57.5, label %if.then110.5, label %lor.lhs.false59.5

lor.lhs.false59.5:                                ; preds = %lor.lhs.false51.5
  %145 = add nsw i64 %140, -63
  %arrayidx65.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %145
  %146 = load i32, i32* %arrayidx65.5, align 4
  %cmp66.5 = icmp eq i32 %146, 255
  br i1 %cmp66.5, label %if.then110.5, label %lor.lhs.false68.5

lor.lhs.false68.5:                                ; preds = %lor.lhs.false59.5
  %147 = add nuw nsw i64 %134, %indvars.iv.5
  %arrayidx73.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %147
  %148 = load i32, i32* %arrayidx73.5, align 4
  %cmp74.5 = icmp eq i32 %148, 255
  br i1 %cmp74.5, label %if.then110.5, label %lor.lhs.false76.5

lor.lhs.false76.5:                                ; preds = %lor.lhs.false68.5
  %149 = add nuw nsw i64 %135, %indvars.iv.5
  %arrayidx81.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %149
  %150 = load i32, i32* %arrayidx81.5, align 4
  %cmp82.5 = icmp eq i32 %150, 255
  br i1 %cmp82.5, label %if.then110.5, label %lor.lhs.false84.5

lor.lhs.false84.5:                                ; preds = %lor.lhs.false76.5
  %151 = add nuw nsw i64 %140, 63
  %arrayidx90.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %151
  %152 = load i32, i32* %arrayidx90.5, align 4
  %cmp91.5 = icmp eq i32 %152, 255
  br i1 %cmp91.5, label %if.then110.5, label %lor.lhs.false93.5

lor.lhs.false93.5:                                ; preds = %lor.lhs.false84.5
  %153 = add nuw nsw i64 %136, %indvars.iv.5
  %arrayidx98.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %153
  %154 = load i32, i32* %arrayidx98.5, align 4
  %cmp99.5 = icmp eq i32 %154, 255
  br i1 %cmp99.5, label %if.then110.5, label %lor.lhs.false101.5

lor.lhs.false101.5:                               ; preds = %lor.lhs.false93.5
  %155 = add nuw nsw i64 %140, 65
  %arrayidx107.5 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %155
  %156 = load i32, i32* %arrayidx107.5, align 4
  %cmp108.5 = icmp eq i32 %156, 255
  br i1 %cmp108.5, label %if.then110.5, label %if.else113.5

if.else113.5:                                     ; preds = %lor.lhs.false101.5
  %arrayidx115.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %137
  store i8 0, i8* %arrayidx115.5, align 1
  br label %for.inc125.5

if.then110.5:                                     ; preds = %lor.lhs.false101.5, %lor.lhs.false93.5, %lor.lhs.false84.5, %lor.lhs.false76.5, %lor.lhs.false68.5, %lor.lhs.false59.5, %lor.lhs.false51.5, %if.then42.5
  %arrayidx112.5 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %137
  store i8 -1, i8* %arrayidx112.5, align 1
  br label %for.inc125.5

for.inc125.5:                                     ; preds = %if.then110.5, %if.else113.5, %if.else117.5, %if.then35.5
  %indvars.iv.next.5 = add nuw nsw i64 %indvars.iv.5, 1
  %exitcond.5 = icmp eq i64 %indvars.iv.next.5, 64
  br i1 %exitcond.5, label %for.inc128.5, label %for.body23.5, !llvm.loop !1

for.inc128.5:                                     ; preds = %for.inc125.5
  %indvars.iv.next17.5 = or i64 %indvars.iv16, 6
  %157 = shl nsw i64 %indvars.iv.next17.5, 6
  %158 = shl i64 %indvars.iv.next17.5, 6
  %159 = add nsw i64 %158, -64
  %160 = add nsw i64 %157, -1
  %161 = or i64 %157, 1
  %162 = or i64 %158, 64
  br label %for.body23.6

for.body23.6:                                     ; preds = %for.inc125.6, %for.inc128.5
  %indvars.iv.6 = phi i64 [ 0, %for.inc128.5 ], [ %indvars.iv.next.6, %for.inc125.6 ]
  %163 = add nuw nsw i64 %indvars.iv.6, %157
  %164 = trunc i64 %indvars.iv.6 to i32
  switch i32 %164, label %if.else.6 [
    i32 0, label %if.then35.6
    i32 63, label %if.then35.6
  ]

if.then35.6:                                      ; preds = %for.body23.6, %for.body23.6
  %arrayidx37.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %163
  store i8 0, i8* %arrayidx37.6, align 1
  br label %for.inc125.6

if.else.6:                                        ; preds = %for.body23.6
  %arrayidx39.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %163
  %165 = load i32, i32* %arrayidx39.6, align 4
  %cmp40.6 = icmp eq i32 %165, 75
  br i1 %cmp40.6, label %if.then42.6, label %if.else117.6

if.else117.6:                                     ; preds = %if.else.6
  %conv120.6 = trunc i32 %165 to i8
  %arrayidx122.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %163
  store i8 %conv120.6, i8* %arrayidx122.6, align 1
  br label %for.inc125.6

if.then42.6:                                      ; preds = %if.else.6
  %166 = add nuw nsw i64 %indvars.iv.6, %158
  %167 = add nsw i64 %166, -65
  %arrayidx48.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %167
  %168 = load i32, i32* %arrayidx48.6, align 4
  %cmp49.6 = icmp eq i32 %168, 255
  br i1 %cmp49.6, label %if.then110.6, label %lor.lhs.false51.6

lor.lhs.false51.6:                                ; preds = %if.then42.6
  %169 = add nuw nsw i64 %159, %indvars.iv.6
  %arrayidx56.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %169
  %170 = load i32, i32* %arrayidx56.6, align 4
  %cmp57.6 = icmp eq i32 %170, 255
  br i1 %cmp57.6, label %if.then110.6, label %lor.lhs.false59.6

lor.lhs.false59.6:                                ; preds = %lor.lhs.false51.6
  %171 = add nsw i64 %166, -63
  %arrayidx65.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %171
  %172 = load i32, i32* %arrayidx65.6, align 4
  %cmp66.6 = icmp eq i32 %172, 255
  br i1 %cmp66.6, label %if.then110.6, label %lor.lhs.false68.6

lor.lhs.false68.6:                                ; preds = %lor.lhs.false59.6
  %173 = add nuw nsw i64 %160, %indvars.iv.6
  %arrayidx73.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %173
  %174 = load i32, i32* %arrayidx73.6, align 4
  %cmp74.6 = icmp eq i32 %174, 255
  br i1 %cmp74.6, label %if.then110.6, label %lor.lhs.false76.6

lor.lhs.false76.6:                                ; preds = %lor.lhs.false68.6
  %175 = add nuw nsw i64 %161, %indvars.iv.6
  %arrayidx81.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %175
  %176 = load i32, i32* %arrayidx81.6, align 4
  %cmp82.6 = icmp eq i32 %176, 255
  br i1 %cmp82.6, label %if.then110.6, label %lor.lhs.false84.6

lor.lhs.false84.6:                                ; preds = %lor.lhs.false76.6
  %177 = add nuw nsw i64 %166, 63
  %arrayidx90.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %177
  %178 = load i32, i32* %arrayidx90.6, align 4
  %cmp91.6 = icmp eq i32 %178, 255
  br i1 %cmp91.6, label %if.then110.6, label %lor.lhs.false93.6

lor.lhs.false93.6:                                ; preds = %lor.lhs.false84.6
  %179 = add nuw nsw i64 %162, %indvars.iv.6
  %arrayidx98.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %179
  %180 = load i32, i32* %arrayidx98.6, align 4
  %cmp99.6 = icmp eq i32 %180, 255
  br i1 %cmp99.6, label %if.then110.6, label %lor.lhs.false101.6

lor.lhs.false101.6:                               ; preds = %lor.lhs.false93.6
  %181 = add nuw nsw i64 %166, 65
  %arrayidx107.6 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %181
  %182 = load i32, i32* %arrayidx107.6, align 4
  %cmp108.6 = icmp eq i32 %182, 255
  br i1 %cmp108.6, label %if.then110.6, label %if.else113.6

if.else113.6:                                     ; preds = %lor.lhs.false101.6
  %arrayidx115.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %163
  store i8 0, i8* %arrayidx115.6, align 1
  br label %for.inc125.6

if.then110.6:                                     ; preds = %lor.lhs.false101.6, %lor.lhs.false93.6, %lor.lhs.false84.6, %lor.lhs.false76.6, %lor.lhs.false68.6, %lor.lhs.false59.6, %lor.lhs.false51.6, %if.then42.6
  %arrayidx112.6 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %163
  store i8 -1, i8* %arrayidx112.6, align 1
  br label %for.inc125.6

for.inc125.6:                                     ; preds = %if.then110.6, %if.else113.6, %if.else117.6, %if.then35.6
  %indvars.iv.next.6 = add nuw nsw i64 %indvars.iv.6, 1
  %exitcond.6 = icmp eq i64 %indvars.iv.next.6, 64
  br i1 %exitcond.6, label %for.inc128.6, label %for.body23.6, !llvm.loop !1

for.inc128.6:                                     ; preds = %for.inc125.6
  %indvars.iv.next17.6 = or i64 %indvars.iv16, 7
  %183 = shl nsw i64 %indvars.iv.next17.6, 6
  %184 = shl i64 %indvars.iv.next17.6, 6
  %185 = add nsw i64 %184, -64
  %186 = add nsw i64 %183, -1
  %187 = or i64 %183, 1
  %188 = add nuw nsw i64 %184, 64
  br label %for.body23.7

for.body23.7:                                     ; preds = %for.inc125.7, %for.inc128.6
  %indvars.iv.7 = phi i64 [ 0, %for.inc128.6 ], [ %indvars.iv.next.7, %for.inc125.7 ]
  %189 = add nuw nsw i64 %indvars.iv.7, %183
  %190 = trunc i64 %indvars.iv.7 to i32
  switch i32 %190, label %if.else.7 [
    i32 0, label %if.then35.7
    i32 63, label %if.then35.7
  ]

if.then35.7:                                      ; preds = %for.body23.7, %for.body23.7
  %arrayidx37.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %189
  store i8 0, i8* %arrayidx37.7, align 1
  br label %for.inc125.7

if.else.7:                                        ; preds = %for.body23.7
  %arrayidx39.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %189
  %191 = load i32, i32* %arrayidx39.7, align 4
  %cmp40.7 = icmp eq i32 %191, 75
  br i1 %cmp40.7, label %if.then42.7, label %if.else117.7

if.else117.7:                                     ; preds = %if.else.7
  %conv120.7 = trunc i32 %191 to i8
  %arrayidx122.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %189
  store i8 %conv120.7, i8* %arrayidx122.7, align 1
  br label %for.inc125.7

if.then42.7:                                      ; preds = %if.else.7
  %192 = add nuw nsw i64 %indvars.iv.7, %184
  %193 = add nsw i64 %192, -65
  %arrayidx48.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %193
  %194 = load i32, i32* %arrayidx48.7, align 4
  %cmp49.7 = icmp eq i32 %194, 255
  br i1 %cmp49.7, label %if.then110.7, label %lor.lhs.false51.7

lor.lhs.false51.7:                                ; preds = %if.then42.7
  %195 = add nuw nsw i64 %185, %indvars.iv.7
  %arrayidx56.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %195
  %196 = load i32, i32* %arrayidx56.7, align 4
  %cmp57.7 = icmp eq i32 %196, 255
  br i1 %cmp57.7, label %if.then110.7, label %lor.lhs.false59.7

lor.lhs.false59.7:                                ; preds = %lor.lhs.false51.7
  %197 = add nsw i64 %192, -63
  %arrayidx65.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %197
  %198 = load i32, i32* %arrayidx65.7, align 4
  %cmp66.7 = icmp eq i32 %198, 255
  br i1 %cmp66.7, label %if.then110.7, label %lor.lhs.false68.7

lor.lhs.false68.7:                                ; preds = %lor.lhs.false59.7
  %199 = add nuw nsw i64 %186, %indvars.iv.7
  %arrayidx73.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %199
  %200 = load i32, i32* %arrayidx73.7, align 4
  %cmp74.7 = icmp eq i32 %200, 255
  br i1 %cmp74.7, label %if.then110.7, label %lor.lhs.false76.7

lor.lhs.false76.7:                                ; preds = %lor.lhs.false68.7
  %201 = add nuw nsw i64 %187, %indvars.iv.7
  %arrayidx81.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %201
  %202 = load i32, i32* %arrayidx81.7, align 4
  %cmp82.7 = icmp eq i32 %202, 255
  br i1 %cmp82.7, label %if.then110.7, label %lor.lhs.false84.7

lor.lhs.false84.7:                                ; preds = %lor.lhs.false76.7
  %203 = add nuw nsw i64 %192, 63
  %arrayidx90.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %203
  %204 = load i32, i32* %arrayidx90.7, align 4
  %cmp91.7 = icmp eq i32 %204, 255
  br i1 %cmp91.7, label %if.then110.7, label %lor.lhs.false93.7

lor.lhs.false93.7:                                ; preds = %lor.lhs.false84.7
  %205 = add nuw nsw i64 %188, %indvars.iv.7
  %arrayidx98.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %205
  %206 = load i32, i32* %arrayidx98.7, align 4
  %cmp99.7 = icmp eq i32 %206, 255
  br i1 %cmp99.7, label %if.then110.7, label %lor.lhs.false101.7

lor.lhs.false101.7:                               ; preds = %lor.lhs.false93.7
  %207 = add nuw nsw i64 %192, 65
  %arrayidx107.7 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %207
  %208 = load i32, i32* %arrayidx107.7, align 4
  %cmp108.7 = icmp eq i32 %208, 255
  br i1 %cmp108.7, label %if.then110.7, label %if.else113.7

if.else113.7:                                     ; preds = %lor.lhs.false101.7
  %arrayidx115.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %189
  store i8 0, i8* %arrayidx115.7, align 1
  br label %for.inc125.7

if.then110.7:                                     ; preds = %lor.lhs.false101.7, %lor.lhs.false93.7, %lor.lhs.false84.7, %lor.lhs.false76.7, %lor.lhs.false68.7, %lor.lhs.false59.7, %lor.lhs.false51.7, %if.then42.7
  %arrayidx112.7 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %189
  store i8 -1, i8* %arrayidx112.7, align 1
  br label %for.inc125.7

for.inc125.7:                                     ; preds = %if.then110.7, %if.else113.7, %if.else117.7, %if.then35.7
  %indvars.iv.next.7 = add nuw nsw i64 %indvars.iv.7, 1
  %exitcond.7 = icmp eq i64 %indvars.iv.next.7, 64
  br i1 %exitcond.7, label %for.inc128.7, label %for.body23.7, !llvm.loop !1

for.inc128.7:                                     ; preds = %for.inc125.7
  %indvars.iv.next17.7 = or i64 %indvars.iv16, 8
  %209 = shl nsw i64 %indvars.iv.next17.7, 6
  %210 = shl i64 %indvars.iv.next17.7, 6
  %211 = add nsw i64 %210, -64
  %212 = add nsw i64 %209, -1
  %213 = or i64 %209, 1
  %214 = or i64 %210, 64
  br label %for.body23.8

for.body23.8:                                     ; preds = %for.inc125.8, %for.inc128.7
  %indvars.iv.8 = phi i64 [ 0, %for.inc128.7 ], [ %indvars.iv.next.8, %for.inc125.8 ]
  %215 = add nuw nsw i64 %indvars.iv.8, %209
  %216 = trunc i64 %indvars.iv.8 to i32
  switch i32 %216, label %if.else.8 [
    i32 0, label %if.then35.8
    i32 63, label %if.then35.8
  ]

if.then35.8:                                      ; preds = %for.body23.8, %for.body23.8
  %arrayidx37.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %215
  store i8 0, i8* %arrayidx37.8, align 1
  br label %for.inc125.8

if.else.8:                                        ; preds = %for.body23.8
  %arrayidx39.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %215
  %217 = load i32, i32* %arrayidx39.8, align 4
  %cmp40.8 = icmp eq i32 %217, 75
  br i1 %cmp40.8, label %if.then42.8, label %if.else117.8

if.else117.8:                                     ; preds = %if.else.8
  %conv120.8 = trunc i32 %217 to i8
  %arrayidx122.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %215
  store i8 %conv120.8, i8* %arrayidx122.8, align 1
  br label %for.inc125.8

if.then42.8:                                      ; preds = %if.else.8
  %218 = add nuw nsw i64 %indvars.iv.8, %210
  %219 = add nsw i64 %218, -65
  %arrayidx48.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %219
  %220 = load i32, i32* %arrayidx48.8, align 4
  %cmp49.8 = icmp eq i32 %220, 255
  br i1 %cmp49.8, label %if.then110.8, label %lor.lhs.false51.8

lor.lhs.false51.8:                                ; preds = %if.then42.8
  %221 = add nuw nsw i64 %211, %indvars.iv.8
  %arrayidx56.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %221
  %222 = load i32, i32* %arrayidx56.8, align 4
  %cmp57.8 = icmp eq i32 %222, 255
  br i1 %cmp57.8, label %if.then110.8, label %lor.lhs.false59.8

lor.lhs.false59.8:                                ; preds = %lor.lhs.false51.8
  %223 = add nsw i64 %218, -63
  %arrayidx65.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %223
  %224 = load i32, i32* %arrayidx65.8, align 4
  %cmp66.8 = icmp eq i32 %224, 255
  br i1 %cmp66.8, label %if.then110.8, label %lor.lhs.false68.8

lor.lhs.false68.8:                                ; preds = %lor.lhs.false59.8
  %225 = add nuw nsw i64 %212, %indvars.iv.8
  %arrayidx73.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %225
  %226 = load i32, i32* %arrayidx73.8, align 4
  %cmp74.8 = icmp eq i32 %226, 255
  br i1 %cmp74.8, label %if.then110.8, label %lor.lhs.false76.8

lor.lhs.false76.8:                                ; preds = %lor.lhs.false68.8
  %227 = add nuw nsw i64 %213, %indvars.iv.8
  %arrayidx81.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %227
  %228 = load i32, i32* %arrayidx81.8, align 4
  %cmp82.8 = icmp eq i32 %228, 255
  br i1 %cmp82.8, label %if.then110.8, label %lor.lhs.false84.8

lor.lhs.false84.8:                                ; preds = %lor.lhs.false76.8
  %229 = add nuw nsw i64 %218, 63
  %arrayidx90.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %229
  %230 = load i32, i32* %arrayidx90.8, align 4
  %cmp91.8 = icmp eq i32 %230, 255
  br i1 %cmp91.8, label %if.then110.8, label %lor.lhs.false93.8

lor.lhs.false93.8:                                ; preds = %lor.lhs.false84.8
  %231 = add nuw nsw i64 %214, %indvars.iv.8
  %arrayidx98.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %231
  %232 = load i32, i32* %arrayidx98.8, align 4
  %cmp99.8 = icmp eq i32 %232, 255
  br i1 %cmp99.8, label %if.then110.8, label %lor.lhs.false101.8

lor.lhs.false101.8:                               ; preds = %lor.lhs.false93.8
  %233 = add nuw nsw i64 %218, 65
  %arrayidx107.8 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %233
  %234 = load i32, i32* %arrayidx107.8, align 4
  %cmp108.8 = icmp eq i32 %234, 255
  br i1 %cmp108.8, label %if.then110.8, label %if.else113.8

if.else113.8:                                     ; preds = %lor.lhs.false101.8
  %arrayidx115.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %215
  store i8 0, i8* %arrayidx115.8, align 1
  br label %for.inc125.8

if.then110.8:                                     ; preds = %lor.lhs.false101.8, %lor.lhs.false93.8, %lor.lhs.false84.8, %lor.lhs.false76.8, %lor.lhs.false68.8, %lor.lhs.false59.8, %lor.lhs.false51.8, %if.then42.8
  %arrayidx112.8 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %215
  store i8 -1, i8* %arrayidx112.8, align 1
  br label %for.inc125.8

for.inc125.8:                                     ; preds = %if.then110.8, %if.else113.8, %if.else117.8, %if.then35.8
  %indvars.iv.next.8 = add nuw nsw i64 %indvars.iv.8, 1
  %exitcond.8 = icmp eq i64 %indvars.iv.next.8, 64
  br i1 %exitcond.8, label %for.inc128.8, label %for.body23.8, !llvm.loop !1

for.inc128.8:                                     ; preds = %for.inc125.8
  %indvars.iv.next17.8 = or i64 %indvars.iv16, 9
  %235 = shl nsw i64 %indvars.iv.next17.8, 6
  %236 = shl i64 %indvars.iv.next17.8, 6
  %237 = add nsw i64 %236, -64
  %238 = add nsw i64 %235, -1
  %239 = or i64 %235, 1
  %240 = add nuw nsw i64 %236, 64
  br label %for.body23.9

for.body23.9:                                     ; preds = %for.inc125.9, %for.inc128.8
  %indvars.iv.9 = phi i64 [ 0, %for.inc128.8 ], [ %indvars.iv.next.9, %for.inc125.9 ]
  %241 = add nuw nsw i64 %indvars.iv.9, %235
  %242 = trunc i64 %indvars.iv.9 to i32
  switch i32 %242, label %if.else.9 [
    i32 0, label %if.then35.9
    i32 63, label %if.then35.9
  ]

if.then35.9:                                      ; preds = %for.body23.9, %for.body23.9
  %arrayidx37.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %241
  store i8 0, i8* %arrayidx37.9, align 1
  br label %for.inc125.9

if.else.9:                                        ; preds = %for.body23.9
  %arrayidx39.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %241
  %243 = load i32, i32* %arrayidx39.9, align 4
  %cmp40.9 = icmp eq i32 %243, 75
  br i1 %cmp40.9, label %if.then42.9, label %if.else117.9

if.else117.9:                                     ; preds = %if.else.9
  %conv120.9 = trunc i32 %243 to i8
  %arrayidx122.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %241
  store i8 %conv120.9, i8* %arrayidx122.9, align 1
  br label %for.inc125.9

if.then42.9:                                      ; preds = %if.else.9
  %244 = add nuw nsw i64 %indvars.iv.9, %236
  %245 = add nsw i64 %244, -65
  %arrayidx48.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %245
  %246 = load i32, i32* %arrayidx48.9, align 4
  %cmp49.9 = icmp eq i32 %246, 255
  br i1 %cmp49.9, label %if.then110.9, label %lor.lhs.false51.9

lor.lhs.false51.9:                                ; preds = %if.then42.9
  %247 = add nuw nsw i64 %237, %indvars.iv.9
  %arrayidx56.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %247
  %248 = load i32, i32* %arrayidx56.9, align 4
  %cmp57.9 = icmp eq i32 %248, 255
  br i1 %cmp57.9, label %if.then110.9, label %lor.lhs.false59.9

lor.lhs.false59.9:                                ; preds = %lor.lhs.false51.9
  %249 = add nsw i64 %244, -63
  %arrayidx65.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %249
  %250 = load i32, i32* %arrayidx65.9, align 4
  %cmp66.9 = icmp eq i32 %250, 255
  br i1 %cmp66.9, label %if.then110.9, label %lor.lhs.false68.9

lor.lhs.false68.9:                                ; preds = %lor.lhs.false59.9
  %251 = add nuw nsw i64 %238, %indvars.iv.9
  %arrayidx73.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %251
  %252 = load i32, i32* %arrayidx73.9, align 4
  %cmp74.9 = icmp eq i32 %252, 255
  br i1 %cmp74.9, label %if.then110.9, label %lor.lhs.false76.9

lor.lhs.false76.9:                                ; preds = %lor.lhs.false68.9
  %253 = add nuw nsw i64 %239, %indvars.iv.9
  %arrayidx81.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %253
  %254 = load i32, i32* %arrayidx81.9, align 4
  %cmp82.9 = icmp eq i32 %254, 255
  br i1 %cmp82.9, label %if.then110.9, label %lor.lhs.false84.9

lor.lhs.false84.9:                                ; preds = %lor.lhs.false76.9
  %255 = add nuw nsw i64 %244, 63
  %arrayidx90.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %255
  %256 = load i32, i32* %arrayidx90.9, align 4
  %cmp91.9 = icmp eq i32 %256, 255
  br i1 %cmp91.9, label %if.then110.9, label %lor.lhs.false93.9

lor.lhs.false93.9:                                ; preds = %lor.lhs.false84.9
  %257 = add nuw nsw i64 %240, %indvars.iv.9
  %arrayidx98.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %257
  %258 = load i32, i32* %arrayidx98.9, align 4
  %cmp99.9 = icmp eq i32 %258, 255
  br i1 %cmp99.9, label %if.then110.9, label %lor.lhs.false101.9

lor.lhs.false101.9:                               ; preds = %lor.lhs.false93.9
  %259 = add nuw nsw i64 %244, 65
  %arrayidx107.9 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %259
  %260 = load i32, i32* %arrayidx107.9, align 4
  %cmp108.9 = icmp eq i32 %260, 255
  br i1 %cmp108.9, label %if.then110.9, label %if.else113.9

if.else113.9:                                     ; preds = %lor.lhs.false101.9
  %arrayidx115.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %241
  store i8 0, i8* %arrayidx115.9, align 1
  br label %for.inc125.9

if.then110.9:                                     ; preds = %lor.lhs.false101.9, %lor.lhs.false93.9, %lor.lhs.false84.9, %lor.lhs.false76.9, %lor.lhs.false68.9, %lor.lhs.false59.9, %lor.lhs.false51.9, %if.then42.9
  %arrayidx112.9 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %241
  store i8 -1, i8* %arrayidx112.9, align 1
  br label %for.inc125.9

for.inc125.9:                                     ; preds = %if.then110.9, %if.else113.9, %if.else117.9, %if.then35.9
  %indvars.iv.next.9 = add nuw nsw i64 %indvars.iv.9, 1
  %exitcond.9 = icmp eq i64 %indvars.iv.next.9, 64
  br i1 %exitcond.9, label %for.inc128.9, label %for.body23.9, !llvm.loop !1

for.inc128.9:                                     ; preds = %for.inc125.9
  %indvars.iv.next17.9 = or i64 %indvars.iv16, 10
  %261 = shl nsw i64 %indvars.iv.next17.9, 6
  %262 = shl i64 %indvars.iv.next17.9, 6
  %263 = add nsw i64 %262, -64
  %264 = add nsw i64 %261, -1
  %265 = or i64 %261, 1
  %266 = or i64 %262, 64
  br label %for.body23.10

for.body23.10:                                    ; preds = %for.inc125.10, %for.inc128.9
  %indvars.iv.10 = phi i64 [ 0, %for.inc128.9 ], [ %indvars.iv.next.10, %for.inc125.10 ]
  %267 = add nuw nsw i64 %indvars.iv.10, %261
  %268 = trunc i64 %indvars.iv.10 to i32
  switch i32 %268, label %if.else.10 [
    i32 0, label %if.then35.10
    i32 63, label %if.then35.10
  ]

if.then35.10:                                     ; preds = %for.body23.10, %for.body23.10
  %arrayidx37.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %267
  store i8 0, i8* %arrayidx37.10, align 1
  br label %for.inc125.10

if.else.10:                                       ; preds = %for.body23.10
  %arrayidx39.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %267
  %269 = load i32, i32* %arrayidx39.10, align 4
  %cmp40.10 = icmp eq i32 %269, 75
  br i1 %cmp40.10, label %if.then42.10, label %if.else117.10

if.else117.10:                                    ; preds = %if.else.10
  %conv120.10 = trunc i32 %269 to i8
  %arrayidx122.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %267
  store i8 %conv120.10, i8* %arrayidx122.10, align 1
  br label %for.inc125.10

if.then42.10:                                     ; preds = %if.else.10
  %270 = add nuw nsw i64 %indvars.iv.10, %262
  %271 = add nsw i64 %270, -65
  %arrayidx48.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %271
  %272 = load i32, i32* %arrayidx48.10, align 4
  %cmp49.10 = icmp eq i32 %272, 255
  br i1 %cmp49.10, label %if.then110.10, label %lor.lhs.false51.10

lor.lhs.false51.10:                               ; preds = %if.then42.10
  %273 = add nuw nsw i64 %263, %indvars.iv.10
  %arrayidx56.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %273
  %274 = load i32, i32* %arrayidx56.10, align 4
  %cmp57.10 = icmp eq i32 %274, 255
  br i1 %cmp57.10, label %if.then110.10, label %lor.lhs.false59.10

lor.lhs.false59.10:                               ; preds = %lor.lhs.false51.10
  %275 = add nsw i64 %270, -63
  %arrayidx65.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %275
  %276 = load i32, i32* %arrayidx65.10, align 4
  %cmp66.10 = icmp eq i32 %276, 255
  br i1 %cmp66.10, label %if.then110.10, label %lor.lhs.false68.10

lor.lhs.false68.10:                               ; preds = %lor.lhs.false59.10
  %277 = add nuw nsw i64 %264, %indvars.iv.10
  %arrayidx73.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %277
  %278 = load i32, i32* %arrayidx73.10, align 4
  %cmp74.10 = icmp eq i32 %278, 255
  br i1 %cmp74.10, label %if.then110.10, label %lor.lhs.false76.10

lor.lhs.false76.10:                               ; preds = %lor.lhs.false68.10
  %279 = add nuw nsw i64 %265, %indvars.iv.10
  %arrayidx81.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %279
  %280 = load i32, i32* %arrayidx81.10, align 4
  %cmp82.10 = icmp eq i32 %280, 255
  br i1 %cmp82.10, label %if.then110.10, label %lor.lhs.false84.10

lor.lhs.false84.10:                               ; preds = %lor.lhs.false76.10
  %281 = add nuw nsw i64 %270, 63
  %arrayidx90.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %281
  %282 = load i32, i32* %arrayidx90.10, align 4
  %cmp91.10 = icmp eq i32 %282, 255
  br i1 %cmp91.10, label %if.then110.10, label %lor.lhs.false93.10

lor.lhs.false93.10:                               ; preds = %lor.lhs.false84.10
  %283 = add nuw nsw i64 %266, %indvars.iv.10
  %arrayidx98.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %283
  %284 = load i32, i32* %arrayidx98.10, align 4
  %cmp99.10 = icmp eq i32 %284, 255
  br i1 %cmp99.10, label %if.then110.10, label %lor.lhs.false101.10

lor.lhs.false101.10:                              ; preds = %lor.lhs.false93.10
  %285 = add nuw nsw i64 %270, 65
  %arrayidx107.10 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %285
  %286 = load i32, i32* %arrayidx107.10, align 4
  %cmp108.10 = icmp eq i32 %286, 255
  br i1 %cmp108.10, label %if.then110.10, label %if.else113.10

if.else113.10:                                    ; preds = %lor.lhs.false101.10
  %arrayidx115.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %267
  store i8 0, i8* %arrayidx115.10, align 1
  br label %for.inc125.10

if.then110.10:                                    ; preds = %lor.lhs.false101.10, %lor.lhs.false93.10, %lor.lhs.false84.10, %lor.lhs.false76.10, %lor.lhs.false68.10, %lor.lhs.false59.10, %lor.lhs.false51.10, %if.then42.10
  %arrayidx112.10 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %267
  store i8 -1, i8* %arrayidx112.10, align 1
  br label %for.inc125.10

for.inc125.10:                                    ; preds = %if.then110.10, %if.else113.10, %if.else117.10, %if.then35.10
  %indvars.iv.next.10 = add nuw nsw i64 %indvars.iv.10, 1
  %exitcond.10 = icmp eq i64 %indvars.iv.next.10, 64
  br i1 %exitcond.10, label %for.inc128.10, label %for.body23.10, !llvm.loop !1

for.inc128.10:                                    ; preds = %for.inc125.10
  %indvars.iv.next17.10 = or i64 %indvars.iv16, 11
  %287 = shl nsw i64 %indvars.iv.next17.10, 6
  %288 = shl i64 %indvars.iv.next17.10, 6
  %289 = add nsw i64 %288, -64
  %290 = add nsw i64 %287, -1
  %291 = or i64 %287, 1
  %292 = add nuw nsw i64 %288, 64
  br label %for.body23.11

for.body23.11:                                    ; preds = %for.inc125.11, %for.inc128.10
  %indvars.iv.11 = phi i64 [ 0, %for.inc128.10 ], [ %indvars.iv.next.11, %for.inc125.11 ]
  %293 = add nuw nsw i64 %indvars.iv.11, %287
  %294 = trunc i64 %indvars.iv.11 to i32
  switch i32 %294, label %if.else.11 [
    i32 0, label %if.then35.11
    i32 63, label %if.then35.11
  ]

if.then35.11:                                     ; preds = %for.body23.11, %for.body23.11
  %arrayidx37.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %293
  store i8 0, i8* %arrayidx37.11, align 1
  br label %for.inc125.11

if.else.11:                                       ; preds = %for.body23.11
  %arrayidx39.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %293
  %295 = load i32, i32* %arrayidx39.11, align 4
  %cmp40.11 = icmp eq i32 %295, 75
  br i1 %cmp40.11, label %if.then42.11, label %if.else117.11

if.else117.11:                                    ; preds = %if.else.11
  %conv120.11 = trunc i32 %295 to i8
  %arrayidx122.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %293
  store i8 %conv120.11, i8* %arrayidx122.11, align 1
  br label %for.inc125.11

if.then42.11:                                     ; preds = %if.else.11
  %296 = add nuw nsw i64 %indvars.iv.11, %288
  %297 = add nsw i64 %296, -65
  %arrayidx48.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %297
  %298 = load i32, i32* %arrayidx48.11, align 4
  %cmp49.11 = icmp eq i32 %298, 255
  br i1 %cmp49.11, label %if.then110.11, label %lor.lhs.false51.11

lor.lhs.false51.11:                               ; preds = %if.then42.11
  %299 = add nuw nsw i64 %289, %indvars.iv.11
  %arrayidx56.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %299
  %300 = load i32, i32* %arrayidx56.11, align 4
  %cmp57.11 = icmp eq i32 %300, 255
  br i1 %cmp57.11, label %if.then110.11, label %lor.lhs.false59.11

lor.lhs.false59.11:                               ; preds = %lor.lhs.false51.11
  %301 = add nsw i64 %296, -63
  %arrayidx65.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %301
  %302 = load i32, i32* %arrayidx65.11, align 4
  %cmp66.11 = icmp eq i32 %302, 255
  br i1 %cmp66.11, label %if.then110.11, label %lor.lhs.false68.11

lor.lhs.false68.11:                               ; preds = %lor.lhs.false59.11
  %303 = add nuw nsw i64 %290, %indvars.iv.11
  %arrayidx73.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %303
  %304 = load i32, i32* %arrayidx73.11, align 4
  %cmp74.11 = icmp eq i32 %304, 255
  br i1 %cmp74.11, label %if.then110.11, label %lor.lhs.false76.11

lor.lhs.false76.11:                               ; preds = %lor.lhs.false68.11
  %305 = add nuw nsw i64 %291, %indvars.iv.11
  %arrayidx81.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %305
  %306 = load i32, i32* %arrayidx81.11, align 4
  %cmp82.11 = icmp eq i32 %306, 255
  br i1 %cmp82.11, label %if.then110.11, label %lor.lhs.false84.11

lor.lhs.false84.11:                               ; preds = %lor.lhs.false76.11
  %307 = add nuw nsw i64 %296, 63
  %arrayidx90.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %307
  %308 = load i32, i32* %arrayidx90.11, align 4
  %cmp91.11 = icmp eq i32 %308, 255
  br i1 %cmp91.11, label %if.then110.11, label %lor.lhs.false93.11

lor.lhs.false93.11:                               ; preds = %lor.lhs.false84.11
  %309 = add nuw nsw i64 %292, %indvars.iv.11
  %arrayidx98.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %309
  %310 = load i32, i32* %arrayidx98.11, align 4
  %cmp99.11 = icmp eq i32 %310, 255
  br i1 %cmp99.11, label %if.then110.11, label %lor.lhs.false101.11

lor.lhs.false101.11:                              ; preds = %lor.lhs.false93.11
  %311 = add nuw nsw i64 %296, 65
  %arrayidx107.11 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %311
  %312 = load i32, i32* %arrayidx107.11, align 4
  %cmp108.11 = icmp eq i32 %312, 255
  br i1 %cmp108.11, label %if.then110.11, label %if.else113.11

if.else113.11:                                    ; preds = %lor.lhs.false101.11
  %arrayidx115.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %293
  store i8 0, i8* %arrayidx115.11, align 1
  br label %for.inc125.11

if.then110.11:                                    ; preds = %lor.lhs.false101.11, %lor.lhs.false93.11, %lor.lhs.false84.11, %lor.lhs.false76.11, %lor.lhs.false68.11, %lor.lhs.false59.11, %lor.lhs.false51.11, %if.then42.11
  %arrayidx112.11 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %293
  store i8 -1, i8* %arrayidx112.11, align 1
  br label %for.inc125.11

for.inc125.11:                                    ; preds = %if.then110.11, %if.else113.11, %if.else117.11, %if.then35.11
  %indvars.iv.next.11 = add nuw nsw i64 %indvars.iv.11, 1
  %exitcond.11 = icmp eq i64 %indvars.iv.next.11, 64
  br i1 %exitcond.11, label %for.inc128.11, label %for.body23.11, !llvm.loop !1

for.inc128.11:                                    ; preds = %for.inc125.11
  %indvars.iv.next17.11 = or i64 %indvars.iv16, 12
  %313 = shl nsw i64 %indvars.iv.next17.11, 6
  %314 = shl i64 %indvars.iv.next17.11, 6
  %315 = add nsw i64 %314, -64
  %316 = add nsw i64 %313, -1
  %317 = or i64 %313, 1
  %318 = or i64 %314, 64
  br label %for.body23.12

for.body23.12:                                    ; preds = %for.inc125.12, %for.inc128.11
  %indvars.iv.12 = phi i64 [ 0, %for.inc128.11 ], [ %indvars.iv.next.12, %for.inc125.12 ]
  %319 = add nuw nsw i64 %indvars.iv.12, %313
  %320 = trunc i64 %indvars.iv.12 to i32
  switch i32 %320, label %if.else.12 [
    i32 0, label %if.then35.12
    i32 63, label %if.then35.12
  ]

if.then35.12:                                     ; preds = %for.body23.12, %for.body23.12
  %arrayidx37.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %319
  store i8 0, i8* %arrayidx37.12, align 1
  br label %for.inc125.12

if.else.12:                                       ; preds = %for.body23.12
  %arrayidx39.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %319
  %321 = load i32, i32* %arrayidx39.12, align 4
  %cmp40.12 = icmp eq i32 %321, 75
  br i1 %cmp40.12, label %if.then42.12, label %if.else117.12

if.else117.12:                                    ; preds = %if.else.12
  %conv120.12 = trunc i32 %321 to i8
  %arrayidx122.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %319
  store i8 %conv120.12, i8* %arrayidx122.12, align 1
  br label %for.inc125.12

if.then42.12:                                     ; preds = %if.else.12
  %322 = add nuw nsw i64 %indvars.iv.12, %314
  %323 = add nsw i64 %322, -65
  %arrayidx48.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %323
  %324 = load i32, i32* %arrayidx48.12, align 4
  %cmp49.12 = icmp eq i32 %324, 255
  br i1 %cmp49.12, label %if.then110.12, label %lor.lhs.false51.12

lor.lhs.false51.12:                               ; preds = %if.then42.12
  %325 = add nuw nsw i64 %315, %indvars.iv.12
  %arrayidx56.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %325
  %326 = load i32, i32* %arrayidx56.12, align 4
  %cmp57.12 = icmp eq i32 %326, 255
  br i1 %cmp57.12, label %if.then110.12, label %lor.lhs.false59.12

lor.lhs.false59.12:                               ; preds = %lor.lhs.false51.12
  %327 = add nsw i64 %322, -63
  %arrayidx65.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %327
  %328 = load i32, i32* %arrayidx65.12, align 4
  %cmp66.12 = icmp eq i32 %328, 255
  br i1 %cmp66.12, label %if.then110.12, label %lor.lhs.false68.12

lor.lhs.false68.12:                               ; preds = %lor.lhs.false59.12
  %329 = add nuw nsw i64 %316, %indvars.iv.12
  %arrayidx73.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %329
  %330 = load i32, i32* %arrayidx73.12, align 4
  %cmp74.12 = icmp eq i32 %330, 255
  br i1 %cmp74.12, label %if.then110.12, label %lor.lhs.false76.12

lor.lhs.false76.12:                               ; preds = %lor.lhs.false68.12
  %331 = add nuw nsw i64 %317, %indvars.iv.12
  %arrayidx81.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %331
  %332 = load i32, i32* %arrayidx81.12, align 4
  %cmp82.12 = icmp eq i32 %332, 255
  br i1 %cmp82.12, label %if.then110.12, label %lor.lhs.false84.12

lor.lhs.false84.12:                               ; preds = %lor.lhs.false76.12
  %333 = add nuw nsw i64 %322, 63
  %arrayidx90.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %333
  %334 = load i32, i32* %arrayidx90.12, align 4
  %cmp91.12 = icmp eq i32 %334, 255
  br i1 %cmp91.12, label %if.then110.12, label %lor.lhs.false93.12

lor.lhs.false93.12:                               ; preds = %lor.lhs.false84.12
  %335 = add nuw nsw i64 %318, %indvars.iv.12
  %arrayidx98.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %335
  %336 = load i32, i32* %arrayidx98.12, align 4
  %cmp99.12 = icmp eq i32 %336, 255
  br i1 %cmp99.12, label %if.then110.12, label %lor.lhs.false101.12

lor.lhs.false101.12:                              ; preds = %lor.lhs.false93.12
  %337 = add nuw nsw i64 %322, 65
  %arrayidx107.12 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %337
  %338 = load i32, i32* %arrayidx107.12, align 4
  %cmp108.12 = icmp eq i32 %338, 255
  br i1 %cmp108.12, label %if.then110.12, label %if.else113.12

if.else113.12:                                    ; preds = %lor.lhs.false101.12
  %arrayidx115.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %319
  store i8 0, i8* %arrayidx115.12, align 1
  br label %for.inc125.12

if.then110.12:                                    ; preds = %lor.lhs.false101.12, %lor.lhs.false93.12, %lor.lhs.false84.12, %lor.lhs.false76.12, %lor.lhs.false68.12, %lor.lhs.false59.12, %lor.lhs.false51.12, %if.then42.12
  %arrayidx112.12 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %319
  store i8 -1, i8* %arrayidx112.12, align 1
  br label %for.inc125.12

for.inc125.12:                                    ; preds = %if.then110.12, %if.else113.12, %if.else117.12, %if.then35.12
  %indvars.iv.next.12 = add nuw nsw i64 %indvars.iv.12, 1
  %exitcond.12 = icmp eq i64 %indvars.iv.next.12, 64
  br i1 %exitcond.12, label %for.inc128.12, label %for.body23.12, !llvm.loop !1

for.inc128.12:                                    ; preds = %for.inc125.12
  %indvars.iv.next17.12 = or i64 %indvars.iv16, 13
  %339 = shl nsw i64 %indvars.iv.next17.12, 6
  %340 = shl i64 %indvars.iv.next17.12, 6
  %341 = add nsw i64 %340, -64
  %342 = add nsw i64 %339, -1
  %343 = or i64 %339, 1
  %344 = add nuw nsw i64 %340, 64
  br label %for.body23.13

for.body23.13:                                    ; preds = %for.inc125.13, %for.inc128.12
  %indvars.iv.13 = phi i64 [ 0, %for.inc128.12 ], [ %indvars.iv.next.13, %for.inc125.13 ]
  %345 = add nuw nsw i64 %indvars.iv.13, %339
  %346 = trunc i64 %indvars.iv.13 to i32
  switch i32 %346, label %if.else.13 [
    i32 0, label %if.then35.13
    i32 63, label %if.then35.13
  ]

if.then35.13:                                     ; preds = %for.body23.13, %for.body23.13
  %arrayidx37.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %345
  store i8 0, i8* %arrayidx37.13, align 1
  br label %for.inc125.13

if.else.13:                                       ; preds = %for.body23.13
  %arrayidx39.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %345
  %347 = load i32, i32* %arrayidx39.13, align 4
  %cmp40.13 = icmp eq i32 %347, 75
  br i1 %cmp40.13, label %if.then42.13, label %if.else117.13

if.else117.13:                                    ; preds = %if.else.13
  %conv120.13 = trunc i32 %347 to i8
  %arrayidx122.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %345
  store i8 %conv120.13, i8* %arrayidx122.13, align 1
  br label %for.inc125.13

if.then42.13:                                     ; preds = %if.else.13
  %348 = add nuw nsw i64 %indvars.iv.13, %340
  %349 = add nsw i64 %348, -65
  %arrayidx48.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %349
  %350 = load i32, i32* %arrayidx48.13, align 4
  %cmp49.13 = icmp eq i32 %350, 255
  br i1 %cmp49.13, label %if.then110.13, label %lor.lhs.false51.13

lor.lhs.false51.13:                               ; preds = %if.then42.13
  %351 = add nuw nsw i64 %341, %indvars.iv.13
  %arrayidx56.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %351
  %352 = load i32, i32* %arrayidx56.13, align 4
  %cmp57.13 = icmp eq i32 %352, 255
  br i1 %cmp57.13, label %if.then110.13, label %lor.lhs.false59.13

lor.lhs.false59.13:                               ; preds = %lor.lhs.false51.13
  %353 = add nsw i64 %348, -63
  %arrayidx65.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %353
  %354 = load i32, i32* %arrayidx65.13, align 4
  %cmp66.13 = icmp eq i32 %354, 255
  br i1 %cmp66.13, label %if.then110.13, label %lor.lhs.false68.13

lor.lhs.false68.13:                               ; preds = %lor.lhs.false59.13
  %355 = add nuw nsw i64 %342, %indvars.iv.13
  %arrayidx73.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %355
  %356 = load i32, i32* %arrayidx73.13, align 4
  %cmp74.13 = icmp eq i32 %356, 255
  br i1 %cmp74.13, label %if.then110.13, label %lor.lhs.false76.13

lor.lhs.false76.13:                               ; preds = %lor.lhs.false68.13
  %357 = add nuw nsw i64 %343, %indvars.iv.13
  %arrayidx81.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %357
  %358 = load i32, i32* %arrayidx81.13, align 4
  %cmp82.13 = icmp eq i32 %358, 255
  br i1 %cmp82.13, label %if.then110.13, label %lor.lhs.false84.13

lor.lhs.false84.13:                               ; preds = %lor.lhs.false76.13
  %359 = add nuw nsw i64 %348, 63
  %arrayidx90.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %359
  %360 = load i32, i32* %arrayidx90.13, align 4
  %cmp91.13 = icmp eq i32 %360, 255
  br i1 %cmp91.13, label %if.then110.13, label %lor.lhs.false93.13

lor.lhs.false93.13:                               ; preds = %lor.lhs.false84.13
  %361 = add nuw nsw i64 %344, %indvars.iv.13
  %arrayidx98.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %361
  %362 = load i32, i32* %arrayidx98.13, align 4
  %cmp99.13 = icmp eq i32 %362, 255
  br i1 %cmp99.13, label %if.then110.13, label %lor.lhs.false101.13

lor.lhs.false101.13:                              ; preds = %lor.lhs.false93.13
  %363 = add nuw nsw i64 %348, 65
  %arrayidx107.13 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %363
  %364 = load i32, i32* %arrayidx107.13, align 4
  %cmp108.13 = icmp eq i32 %364, 255
  br i1 %cmp108.13, label %if.then110.13, label %if.else113.13

if.else113.13:                                    ; preds = %lor.lhs.false101.13
  %arrayidx115.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %345
  store i8 0, i8* %arrayidx115.13, align 1
  br label %for.inc125.13

if.then110.13:                                    ; preds = %lor.lhs.false101.13, %lor.lhs.false93.13, %lor.lhs.false84.13, %lor.lhs.false76.13, %lor.lhs.false68.13, %lor.lhs.false59.13, %lor.lhs.false51.13, %if.then42.13
  %arrayidx112.13 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %345
  store i8 -1, i8* %arrayidx112.13, align 1
  br label %for.inc125.13

for.inc125.13:                                    ; preds = %if.then110.13, %if.else113.13, %if.else117.13, %if.then35.13
  %indvars.iv.next.13 = add nuw nsw i64 %indvars.iv.13, 1
  %exitcond.13 = icmp eq i64 %indvars.iv.next.13, 64
  br i1 %exitcond.13, label %for.inc128.13, label %for.body23.13, !llvm.loop !1

for.inc128.13:                                    ; preds = %for.inc125.13
  %indvars.iv.next17.13 = or i64 %indvars.iv16, 14
  %365 = shl nsw i64 %indvars.iv.next17.13, 6
  %366 = shl i64 %indvars.iv.next17.13, 6
  %367 = add nsw i64 %366, -64
  %368 = add nsw i64 %365, -1
  %369 = or i64 %365, 1
  %370 = or i64 %366, 64
  br label %for.body23.14

for.body23.14:                                    ; preds = %for.inc125.14, %for.inc128.13
  %indvars.iv.14 = phi i64 [ 0, %for.inc128.13 ], [ %indvars.iv.next.14, %for.inc125.14 ]
  %371 = add nuw nsw i64 %indvars.iv.14, %365
  %372 = trunc i64 %indvars.iv.14 to i32
  switch i32 %372, label %if.else.14 [
    i32 0, label %if.then35.14
    i32 63, label %if.then35.14
  ]

if.then35.14:                                     ; preds = %for.body23.14, %for.body23.14
  %arrayidx37.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %371
  store i8 0, i8* %arrayidx37.14, align 1
  br label %for.inc125.14

if.else.14:                                       ; preds = %for.body23.14
  %arrayidx39.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %371
  %373 = load i32, i32* %arrayidx39.14, align 4
  %cmp40.14 = icmp eq i32 %373, 75
  br i1 %cmp40.14, label %if.then42.14, label %if.else117.14

if.else117.14:                                    ; preds = %if.else.14
  %conv120.14 = trunc i32 %373 to i8
  %arrayidx122.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %371
  store i8 %conv120.14, i8* %arrayidx122.14, align 1
  br label %for.inc125.14

if.then42.14:                                     ; preds = %if.else.14
  %374 = add nuw nsw i64 %indvars.iv.14, %366
  %375 = add nsw i64 %374, -65
  %arrayidx48.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %375
  %376 = load i32, i32* %arrayidx48.14, align 4
  %cmp49.14 = icmp eq i32 %376, 255
  br i1 %cmp49.14, label %if.then110.14, label %lor.lhs.false51.14

lor.lhs.false51.14:                               ; preds = %if.then42.14
  %377 = add nuw nsw i64 %367, %indvars.iv.14
  %arrayidx56.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %377
  %378 = load i32, i32* %arrayidx56.14, align 4
  %cmp57.14 = icmp eq i32 %378, 255
  br i1 %cmp57.14, label %if.then110.14, label %lor.lhs.false59.14

lor.lhs.false59.14:                               ; preds = %lor.lhs.false51.14
  %379 = add nsw i64 %374, -63
  %arrayidx65.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %379
  %380 = load i32, i32* %arrayidx65.14, align 4
  %cmp66.14 = icmp eq i32 %380, 255
  br i1 %cmp66.14, label %if.then110.14, label %lor.lhs.false68.14

lor.lhs.false68.14:                               ; preds = %lor.lhs.false59.14
  %381 = add nuw nsw i64 %368, %indvars.iv.14
  %arrayidx73.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %381
  %382 = load i32, i32* %arrayidx73.14, align 4
  %cmp74.14 = icmp eq i32 %382, 255
  br i1 %cmp74.14, label %if.then110.14, label %lor.lhs.false76.14

lor.lhs.false76.14:                               ; preds = %lor.lhs.false68.14
  %383 = add nuw nsw i64 %369, %indvars.iv.14
  %arrayidx81.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %383
  %384 = load i32, i32* %arrayidx81.14, align 4
  %cmp82.14 = icmp eq i32 %384, 255
  br i1 %cmp82.14, label %if.then110.14, label %lor.lhs.false84.14

lor.lhs.false84.14:                               ; preds = %lor.lhs.false76.14
  %385 = add nuw nsw i64 %374, 63
  %arrayidx90.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %385
  %386 = load i32, i32* %arrayidx90.14, align 4
  %cmp91.14 = icmp eq i32 %386, 255
  br i1 %cmp91.14, label %if.then110.14, label %lor.lhs.false93.14

lor.lhs.false93.14:                               ; preds = %lor.lhs.false84.14
  %387 = add nuw nsw i64 %370, %indvars.iv.14
  %arrayidx98.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %387
  %388 = load i32, i32* %arrayidx98.14, align 4
  %cmp99.14 = icmp eq i32 %388, 255
  br i1 %cmp99.14, label %if.then110.14, label %lor.lhs.false101.14

lor.lhs.false101.14:                              ; preds = %lor.lhs.false93.14
  %389 = add nuw nsw i64 %374, 65
  %arrayidx107.14 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %389
  %390 = load i32, i32* %arrayidx107.14, align 4
  %cmp108.14 = icmp eq i32 %390, 255
  br i1 %cmp108.14, label %if.then110.14, label %if.else113.14

if.else113.14:                                    ; preds = %lor.lhs.false101.14
  %arrayidx115.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %371
  store i8 0, i8* %arrayidx115.14, align 1
  br label %for.inc125.14

if.then110.14:                                    ; preds = %lor.lhs.false101.14, %lor.lhs.false93.14, %lor.lhs.false84.14, %lor.lhs.false76.14, %lor.lhs.false68.14, %lor.lhs.false59.14, %lor.lhs.false51.14, %if.then42.14
  %arrayidx112.14 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %371
  store i8 -1, i8* %arrayidx112.14, align 1
  br label %for.inc125.14

for.inc125.14:                                    ; preds = %if.then110.14, %if.else113.14, %if.else117.14, %if.then35.14
  %indvars.iv.next.14 = add nuw nsw i64 %indvars.iv.14, 1
  %exitcond.14 = icmp eq i64 %indvars.iv.next.14, 64
  br i1 %exitcond.14, label %for.inc128.14, label %for.body23.14, !llvm.loop !1

for.inc128.14:                                    ; preds = %for.inc125.14
  %indvars.iv.next17.14 = or i64 %indvars.iv16, 15
  %391 = shl nsw i64 %indvars.iv.next17.14, 6
  %392 = shl i64 %indvars.iv.next17.14, 6
  %393 = add nsw i64 %392, -64
  %394 = add nsw i64 %391, -1
  %395 = or i64 %391, 1
  %396 = add nuw nsw i64 %392, 64
  br label %for.body23.15

for.body23.15:                                    ; preds = %for.inc125.15, %for.inc128.14
  %indvars.iv.15 = phi i64 [ 0, %for.inc128.14 ], [ %indvars.iv.next.15, %for.inc125.15 ]
  %397 = add nuw nsw i64 %indvars.iv.15, %391
  %398 = trunc i64 %indvars.iv.15 to i32
  switch i32 %398, label %if.else.15 [
    i32 0, label %if.then35.15
    i32 63, label %if.then35.15
  ]

if.then35.15:                                     ; preds = %for.body23.15, %for.body23.15
  %arrayidx37.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %397
  store i8 0, i8* %arrayidx37.15, align 1
  br label %for.inc125.15

if.else.15:                                       ; preds = %for.body23.15
  %arrayidx39.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %397
  %399 = load i32, i32* %arrayidx39.15, align 4
  %cmp40.15 = icmp eq i32 %399, 75
  br i1 %cmp40.15, label %if.then42.15, label %if.else117.15

if.else117.15:                                    ; preds = %if.else.15
  %conv120.15 = trunc i32 %399 to i8
  %arrayidx122.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %397
  store i8 %conv120.15, i8* %arrayidx122.15, align 1
  br label %for.inc125.15

if.then42.15:                                     ; preds = %if.else.15
  %400 = add nuw nsw i64 %indvars.iv.15, %392
  %401 = add nsw i64 %400, -65
  %arrayidx48.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %401
  %402 = load i32, i32* %arrayidx48.15, align 4
  %cmp49.15 = icmp eq i32 %402, 255
  br i1 %cmp49.15, label %if.then110.15, label %lor.lhs.false51.15

lor.lhs.false51.15:                               ; preds = %if.then42.15
  %403 = add nuw nsw i64 %393, %indvars.iv.15
  %arrayidx56.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %403
  %404 = load i32, i32* %arrayidx56.15, align 4
  %cmp57.15 = icmp eq i32 %404, 255
  br i1 %cmp57.15, label %if.then110.15, label %lor.lhs.false59.15

lor.lhs.false59.15:                               ; preds = %lor.lhs.false51.15
  %405 = add nsw i64 %400, -63
  %arrayidx65.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %405
  %406 = load i32, i32* %arrayidx65.15, align 4
  %cmp66.15 = icmp eq i32 %406, 255
  br i1 %cmp66.15, label %if.then110.15, label %lor.lhs.false68.15

lor.lhs.false68.15:                               ; preds = %lor.lhs.false59.15
  %407 = add nuw nsw i64 %394, %indvars.iv.15
  %arrayidx73.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %407
  %408 = load i32, i32* %arrayidx73.15, align 4
  %cmp74.15 = icmp eq i32 %408, 255
  br i1 %cmp74.15, label %if.then110.15, label %lor.lhs.false76.15

lor.lhs.false76.15:                               ; preds = %lor.lhs.false68.15
  %409 = add nuw nsw i64 %395, %indvars.iv.15
  %arrayidx81.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %409
  %410 = load i32, i32* %arrayidx81.15, align 4
  %cmp82.15 = icmp eq i32 %410, 255
  br i1 %cmp82.15, label %if.then110.15, label %lor.lhs.false84.15

lor.lhs.false84.15:                               ; preds = %lor.lhs.false76.15
  %411 = add nuw nsw i64 %400, 63
  %arrayidx90.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %411
  %412 = load i32, i32* %arrayidx90.15, align 4
  %cmp91.15 = icmp eq i32 %412, 255
  br i1 %cmp91.15, label %if.then110.15, label %lor.lhs.false93.15

lor.lhs.false93.15:                               ; preds = %lor.lhs.false84.15
  %413 = add nuw nsw i64 %396, %indvars.iv.15
  %arrayidx98.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %413
  %414 = load i32, i32* %arrayidx98.15, align 4
  %cmp99.15 = icmp eq i32 %414, 255
  br i1 %cmp99.15, label %if.then110.15, label %lor.lhs.false101.15

lor.lhs.false101.15:                              ; preds = %lor.lhs.false93.15
  %415 = add nuw nsw i64 %400, 65
  %arrayidx107.15 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %415
  %416 = load i32, i32* %arrayidx107.15, align 4
  %cmp108.15 = icmp eq i32 %416, 255
  br i1 %cmp108.15, label %if.then110.15, label %if.else113.15

if.else113.15:                                    ; preds = %lor.lhs.false101.15
  %arrayidx115.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %397
  store i8 0, i8* %arrayidx115.15, align 1
  br label %for.inc125.15

if.then110.15:                                    ; preds = %lor.lhs.false101.15, %lor.lhs.false93.15, %lor.lhs.false84.15, %lor.lhs.false76.15, %lor.lhs.false68.15, %lor.lhs.false59.15, %lor.lhs.false51.15, %if.then42.15
  %arrayidx112.15 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %397
  store i8 -1, i8* %arrayidx112.15, align 1
  br label %for.inc125.15

for.inc125.15:                                    ; preds = %if.then110.15, %if.else113.15, %if.else117.15, %if.then35.15
  %indvars.iv.next.15 = add nuw nsw i64 %indvars.iv.15, 1
  %exitcond.15 = icmp eq i64 %indvars.iv.next.15, 64
  br i1 %exitcond.15, label %for.inc128.15, label %for.body23.15, !llvm.loop !1

for.inc128.15:                                    ; preds = %for.inc125.15
  %indvars.iv.next17.15 = or i64 %indvars.iv16, 16
  %417 = shl nsw i64 %indvars.iv.next17.15, 6
  %418 = shl i64 %indvars.iv.next17.15, 6
  %419 = add nsw i64 %418, -64
  %420 = add nsw i64 %417, -1
  %421 = or i64 %417, 1
  %422 = or i64 %418, 64
  br label %for.body23.16

for.body23.16:                                    ; preds = %for.inc125.16, %for.inc128.15
  %indvars.iv.16 = phi i64 [ 0, %for.inc128.15 ], [ %indvars.iv.next.16, %for.inc125.16 ]
  %423 = add nuw nsw i64 %indvars.iv.16, %417
  %424 = trunc i64 %indvars.iv.16 to i32
  switch i32 %424, label %if.else.16 [
    i32 0, label %if.then35.16
    i32 63, label %if.then35.16
  ]

if.then35.16:                                     ; preds = %for.body23.16, %for.body23.16
  %arrayidx37.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %423
  store i8 0, i8* %arrayidx37.16, align 1
  br label %for.inc125.16

if.else.16:                                       ; preds = %for.body23.16
  %arrayidx39.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %423
  %425 = load i32, i32* %arrayidx39.16, align 4
  %cmp40.16 = icmp eq i32 %425, 75
  br i1 %cmp40.16, label %if.then42.16, label %if.else117.16

if.else117.16:                                    ; preds = %if.else.16
  %conv120.16 = trunc i32 %425 to i8
  %arrayidx122.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %423
  store i8 %conv120.16, i8* %arrayidx122.16, align 1
  br label %for.inc125.16

if.then42.16:                                     ; preds = %if.else.16
  %426 = add nuw nsw i64 %indvars.iv.16, %418
  %427 = add nsw i64 %426, -65
  %arrayidx48.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %427
  %428 = load i32, i32* %arrayidx48.16, align 4
  %cmp49.16 = icmp eq i32 %428, 255
  br i1 %cmp49.16, label %if.then110.16, label %lor.lhs.false51.16

lor.lhs.false51.16:                               ; preds = %if.then42.16
  %429 = add nuw nsw i64 %419, %indvars.iv.16
  %arrayidx56.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %429
  %430 = load i32, i32* %arrayidx56.16, align 4
  %cmp57.16 = icmp eq i32 %430, 255
  br i1 %cmp57.16, label %if.then110.16, label %lor.lhs.false59.16

lor.lhs.false59.16:                               ; preds = %lor.lhs.false51.16
  %431 = add nsw i64 %426, -63
  %arrayidx65.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %431
  %432 = load i32, i32* %arrayidx65.16, align 4
  %cmp66.16 = icmp eq i32 %432, 255
  br i1 %cmp66.16, label %if.then110.16, label %lor.lhs.false68.16

lor.lhs.false68.16:                               ; preds = %lor.lhs.false59.16
  %433 = add nuw nsw i64 %420, %indvars.iv.16
  %arrayidx73.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %433
  %434 = load i32, i32* %arrayidx73.16, align 4
  %cmp74.16 = icmp eq i32 %434, 255
  br i1 %cmp74.16, label %if.then110.16, label %lor.lhs.false76.16

lor.lhs.false76.16:                               ; preds = %lor.lhs.false68.16
  %435 = add nuw nsw i64 %421, %indvars.iv.16
  %arrayidx81.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %435
  %436 = load i32, i32* %arrayidx81.16, align 4
  %cmp82.16 = icmp eq i32 %436, 255
  br i1 %cmp82.16, label %if.then110.16, label %lor.lhs.false84.16

lor.lhs.false84.16:                               ; preds = %lor.lhs.false76.16
  %437 = add nuw nsw i64 %426, 63
  %arrayidx90.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %437
  %438 = load i32, i32* %arrayidx90.16, align 4
  %cmp91.16 = icmp eq i32 %438, 255
  br i1 %cmp91.16, label %if.then110.16, label %lor.lhs.false93.16

lor.lhs.false93.16:                               ; preds = %lor.lhs.false84.16
  %439 = add nuw nsw i64 %422, %indvars.iv.16
  %arrayidx98.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %439
  %440 = load i32, i32* %arrayidx98.16, align 4
  %cmp99.16 = icmp eq i32 %440, 255
  br i1 %cmp99.16, label %if.then110.16, label %lor.lhs.false101.16

lor.lhs.false101.16:                              ; preds = %lor.lhs.false93.16
  %441 = add nuw nsw i64 %426, 65
  %arrayidx107.16 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %441
  %442 = load i32, i32* %arrayidx107.16, align 4
  %cmp108.16 = icmp eq i32 %442, 255
  br i1 %cmp108.16, label %if.then110.16, label %if.else113.16

if.else113.16:                                    ; preds = %lor.lhs.false101.16
  %arrayidx115.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %423
  store i8 0, i8* %arrayidx115.16, align 1
  br label %for.inc125.16

if.then110.16:                                    ; preds = %lor.lhs.false101.16, %lor.lhs.false93.16, %lor.lhs.false84.16, %lor.lhs.false76.16, %lor.lhs.false68.16, %lor.lhs.false59.16, %lor.lhs.false51.16, %if.then42.16
  %arrayidx112.16 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %423
  store i8 -1, i8* %arrayidx112.16, align 1
  br label %for.inc125.16

for.inc125.16:                                    ; preds = %if.then110.16, %if.else113.16, %if.else117.16, %if.then35.16
  %indvars.iv.next.16 = add nuw nsw i64 %indvars.iv.16, 1
  %exitcond.16 = icmp eq i64 %indvars.iv.next.16, 64
  br i1 %exitcond.16, label %for.inc128.16, label %for.body23.16, !llvm.loop !1

for.inc128.16:                                    ; preds = %for.inc125.16
  %indvars.iv.next17.16 = or i64 %indvars.iv16, 17
  %443 = shl nsw i64 %indvars.iv.next17.16, 6
  %444 = shl i64 %indvars.iv.next17.16, 6
  %445 = add nsw i64 %444, -64
  %446 = add nsw i64 %443, -1
  %447 = or i64 %443, 1
  %448 = add nuw nsw i64 %444, 64
  br label %for.body23.17

for.body23.17:                                    ; preds = %for.inc125.17, %for.inc128.16
  %indvars.iv.17 = phi i64 [ 0, %for.inc128.16 ], [ %indvars.iv.next.17, %for.inc125.17 ]
  %449 = add nuw nsw i64 %indvars.iv.17, %443
  %450 = trunc i64 %indvars.iv.17 to i32
  switch i32 %450, label %if.else.17 [
    i32 0, label %if.then35.17
    i32 63, label %if.then35.17
  ]

if.then35.17:                                     ; preds = %for.body23.17, %for.body23.17
  %arrayidx37.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %449
  store i8 0, i8* %arrayidx37.17, align 1
  br label %for.inc125.17

if.else.17:                                       ; preds = %for.body23.17
  %arrayidx39.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %449
  %451 = load i32, i32* %arrayidx39.17, align 4
  %cmp40.17 = icmp eq i32 %451, 75
  br i1 %cmp40.17, label %if.then42.17, label %if.else117.17

if.else117.17:                                    ; preds = %if.else.17
  %conv120.17 = trunc i32 %451 to i8
  %arrayidx122.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %449
  store i8 %conv120.17, i8* %arrayidx122.17, align 1
  br label %for.inc125.17

if.then42.17:                                     ; preds = %if.else.17
  %452 = add nuw nsw i64 %indvars.iv.17, %444
  %453 = add nsw i64 %452, -65
  %arrayidx48.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %453
  %454 = load i32, i32* %arrayidx48.17, align 4
  %cmp49.17 = icmp eq i32 %454, 255
  br i1 %cmp49.17, label %if.then110.17, label %lor.lhs.false51.17

lor.lhs.false51.17:                               ; preds = %if.then42.17
  %455 = add nuw nsw i64 %445, %indvars.iv.17
  %arrayidx56.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %455
  %456 = load i32, i32* %arrayidx56.17, align 4
  %cmp57.17 = icmp eq i32 %456, 255
  br i1 %cmp57.17, label %if.then110.17, label %lor.lhs.false59.17

lor.lhs.false59.17:                               ; preds = %lor.lhs.false51.17
  %457 = add nsw i64 %452, -63
  %arrayidx65.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %457
  %458 = load i32, i32* %arrayidx65.17, align 4
  %cmp66.17 = icmp eq i32 %458, 255
  br i1 %cmp66.17, label %if.then110.17, label %lor.lhs.false68.17

lor.lhs.false68.17:                               ; preds = %lor.lhs.false59.17
  %459 = add nuw nsw i64 %446, %indvars.iv.17
  %arrayidx73.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %459
  %460 = load i32, i32* %arrayidx73.17, align 4
  %cmp74.17 = icmp eq i32 %460, 255
  br i1 %cmp74.17, label %if.then110.17, label %lor.lhs.false76.17

lor.lhs.false76.17:                               ; preds = %lor.lhs.false68.17
  %461 = add nuw nsw i64 %447, %indvars.iv.17
  %arrayidx81.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %461
  %462 = load i32, i32* %arrayidx81.17, align 4
  %cmp82.17 = icmp eq i32 %462, 255
  br i1 %cmp82.17, label %if.then110.17, label %lor.lhs.false84.17

lor.lhs.false84.17:                               ; preds = %lor.lhs.false76.17
  %463 = add nuw nsw i64 %452, 63
  %arrayidx90.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %463
  %464 = load i32, i32* %arrayidx90.17, align 4
  %cmp91.17 = icmp eq i32 %464, 255
  br i1 %cmp91.17, label %if.then110.17, label %lor.lhs.false93.17

lor.lhs.false93.17:                               ; preds = %lor.lhs.false84.17
  %465 = add nuw nsw i64 %448, %indvars.iv.17
  %arrayidx98.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %465
  %466 = load i32, i32* %arrayidx98.17, align 4
  %cmp99.17 = icmp eq i32 %466, 255
  br i1 %cmp99.17, label %if.then110.17, label %lor.lhs.false101.17

lor.lhs.false101.17:                              ; preds = %lor.lhs.false93.17
  %467 = add nuw nsw i64 %452, 65
  %arrayidx107.17 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %467
  %468 = load i32, i32* %arrayidx107.17, align 4
  %cmp108.17 = icmp eq i32 %468, 255
  br i1 %cmp108.17, label %if.then110.17, label %if.else113.17

if.else113.17:                                    ; preds = %lor.lhs.false101.17
  %arrayidx115.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %449
  store i8 0, i8* %arrayidx115.17, align 1
  br label %for.inc125.17

if.then110.17:                                    ; preds = %lor.lhs.false101.17, %lor.lhs.false93.17, %lor.lhs.false84.17, %lor.lhs.false76.17, %lor.lhs.false68.17, %lor.lhs.false59.17, %lor.lhs.false51.17, %if.then42.17
  %arrayidx112.17 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %449
  store i8 -1, i8* %arrayidx112.17, align 1
  br label %for.inc125.17

for.inc125.17:                                    ; preds = %if.then110.17, %if.else113.17, %if.else117.17, %if.then35.17
  %indvars.iv.next.17 = add nuw nsw i64 %indvars.iv.17, 1
  %exitcond.17 = icmp eq i64 %indvars.iv.next.17, 64
  br i1 %exitcond.17, label %for.inc128.17, label %for.body23.17, !llvm.loop !1

for.inc128.17:                                    ; preds = %for.inc125.17
  %indvars.iv.next17.17 = or i64 %indvars.iv16, 18
  %469 = shl nsw i64 %indvars.iv.next17.17, 6
  %470 = shl i64 %indvars.iv.next17.17, 6
  %471 = add nsw i64 %470, -64
  %472 = add nsw i64 %469, -1
  %473 = or i64 %469, 1
  %474 = or i64 %470, 64
  br label %for.body23.18

for.body23.18:                                    ; preds = %for.inc125.18, %for.inc128.17
  %indvars.iv.18 = phi i64 [ 0, %for.inc128.17 ], [ %indvars.iv.next.18, %for.inc125.18 ]
  %475 = add nuw nsw i64 %indvars.iv.18, %469
  %476 = trunc i64 %indvars.iv.18 to i32
  switch i32 %476, label %if.else.18 [
    i32 0, label %if.then35.18
    i32 63, label %if.then35.18
  ]

if.then35.18:                                     ; preds = %for.body23.18, %for.body23.18
  %arrayidx37.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %475
  store i8 0, i8* %arrayidx37.18, align 1
  br label %for.inc125.18

if.else.18:                                       ; preds = %for.body23.18
  %arrayidx39.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %475
  %477 = load i32, i32* %arrayidx39.18, align 4
  %cmp40.18 = icmp eq i32 %477, 75
  br i1 %cmp40.18, label %if.then42.18, label %if.else117.18

if.else117.18:                                    ; preds = %if.else.18
  %conv120.18 = trunc i32 %477 to i8
  %arrayidx122.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %475
  store i8 %conv120.18, i8* %arrayidx122.18, align 1
  br label %for.inc125.18

if.then42.18:                                     ; preds = %if.else.18
  %478 = add nuw nsw i64 %indvars.iv.18, %470
  %479 = add nsw i64 %478, -65
  %arrayidx48.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %479
  %480 = load i32, i32* %arrayidx48.18, align 4
  %cmp49.18 = icmp eq i32 %480, 255
  br i1 %cmp49.18, label %if.then110.18, label %lor.lhs.false51.18

lor.lhs.false51.18:                               ; preds = %if.then42.18
  %481 = add nuw nsw i64 %471, %indvars.iv.18
  %arrayidx56.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %481
  %482 = load i32, i32* %arrayidx56.18, align 4
  %cmp57.18 = icmp eq i32 %482, 255
  br i1 %cmp57.18, label %if.then110.18, label %lor.lhs.false59.18

lor.lhs.false59.18:                               ; preds = %lor.lhs.false51.18
  %483 = add nsw i64 %478, -63
  %arrayidx65.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %483
  %484 = load i32, i32* %arrayidx65.18, align 4
  %cmp66.18 = icmp eq i32 %484, 255
  br i1 %cmp66.18, label %if.then110.18, label %lor.lhs.false68.18

lor.lhs.false68.18:                               ; preds = %lor.lhs.false59.18
  %485 = add nuw nsw i64 %472, %indvars.iv.18
  %arrayidx73.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %485
  %486 = load i32, i32* %arrayidx73.18, align 4
  %cmp74.18 = icmp eq i32 %486, 255
  br i1 %cmp74.18, label %if.then110.18, label %lor.lhs.false76.18

lor.lhs.false76.18:                               ; preds = %lor.lhs.false68.18
  %487 = add nuw nsw i64 %473, %indvars.iv.18
  %arrayidx81.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %487
  %488 = load i32, i32* %arrayidx81.18, align 4
  %cmp82.18 = icmp eq i32 %488, 255
  br i1 %cmp82.18, label %if.then110.18, label %lor.lhs.false84.18

lor.lhs.false84.18:                               ; preds = %lor.lhs.false76.18
  %489 = add nuw nsw i64 %478, 63
  %arrayidx90.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %489
  %490 = load i32, i32* %arrayidx90.18, align 4
  %cmp91.18 = icmp eq i32 %490, 255
  br i1 %cmp91.18, label %if.then110.18, label %lor.lhs.false93.18

lor.lhs.false93.18:                               ; preds = %lor.lhs.false84.18
  %491 = add nuw nsw i64 %474, %indvars.iv.18
  %arrayidx98.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %491
  %492 = load i32, i32* %arrayidx98.18, align 4
  %cmp99.18 = icmp eq i32 %492, 255
  br i1 %cmp99.18, label %if.then110.18, label %lor.lhs.false101.18

lor.lhs.false101.18:                              ; preds = %lor.lhs.false93.18
  %493 = add nuw nsw i64 %478, 65
  %arrayidx107.18 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %493
  %494 = load i32, i32* %arrayidx107.18, align 4
  %cmp108.18 = icmp eq i32 %494, 255
  br i1 %cmp108.18, label %if.then110.18, label %if.else113.18

if.else113.18:                                    ; preds = %lor.lhs.false101.18
  %arrayidx115.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %475
  store i8 0, i8* %arrayidx115.18, align 1
  br label %for.inc125.18

if.then110.18:                                    ; preds = %lor.lhs.false101.18, %lor.lhs.false93.18, %lor.lhs.false84.18, %lor.lhs.false76.18, %lor.lhs.false68.18, %lor.lhs.false59.18, %lor.lhs.false51.18, %if.then42.18
  %arrayidx112.18 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %475
  store i8 -1, i8* %arrayidx112.18, align 1
  br label %for.inc125.18

for.inc125.18:                                    ; preds = %if.then110.18, %if.else113.18, %if.else117.18, %if.then35.18
  %indvars.iv.next.18 = add nuw nsw i64 %indvars.iv.18, 1
  %exitcond.18 = icmp eq i64 %indvars.iv.next.18, 64
  br i1 %exitcond.18, label %for.inc128.18, label %for.body23.18, !llvm.loop !1

for.inc128.18:                                    ; preds = %for.inc125.18
  %indvars.iv.next17.18 = or i64 %indvars.iv16, 19
  %495 = shl nsw i64 %indvars.iv.next17.18, 6
  %496 = shl i64 %indvars.iv.next17.18, 6
  %497 = add nsw i64 %496, -64
  %498 = add nsw i64 %495, -1
  %499 = or i64 %495, 1
  %500 = add nuw nsw i64 %496, 64
  br label %for.body23.19

for.body23.19:                                    ; preds = %for.inc125.19, %for.inc128.18
  %indvars.iv.19 = phi i64 [ 0, %for.inc128.18 ], [ %indvars.iv.next.19, %for.inc125.19 ]
  %501 = add nuw nsw i64 %indvars.iv.19, %495
  %502 = trunc i64 %indvars.iv.19 to i32
  switch i32 %502, label %if.else.19 [
    i32 0, label %if.then35.19
    i32 63, label %if.then35.19
  ]

if.then35.19:                                     ; preds = %for.body23.19, %for.body23.19
  %arrayidx37.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %501
  store i8 0, i8* %arrayidx37.19, align 1
  br label %for.inc125.19

if.else.19:                                       ; preds = %for.body23.19
  %arrayidx39.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %501
  %503 = load i32, i32* %arrayidx39.19, align 4
  %cmp40.19 = icmp eq i32 %503, 75
  br i1 %cmp40.19, label %if.then42.19, label %if.else117.19

if.else117.19:                                    ; preds = %if.else.19
  %conv120.19 = trunc i32 %503 to i8
  %arrayidx122.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %501
  store i8 %conv120.19, i8* %arrayidx122.19, align 1
  br label %for.inc125.19

if.then42.19:                                     ; preds = %if.else.19
  %504 = add nuw nsw i64 %indvars.iv.19, %496
  %505 = add nsw i64 %504, -65
  %arrayidx48.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %505
  %506 = load i32, i32* %arrayidx48.19, align 4
  %cmp49.19 = icmp eq i32 %506, 255
  br i1 %cmp49.19, label %if.then110.19, label %lor.lhs.false51.19

lor.lhs.false51.19:                               ; preds = %if.then42.19
  %507 = add nuw nsw i64 %497, %indvars.iv.19
  %arrayidx56.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %507
  %508 = load i32, i32* %arrayidx56.19, align 4
  %cmp57.19 = icmp eq i32 %508, 255
  br i1 %cmp57.19, label %if.then110.19, label %lor.lhs.false59.19

lor.lhs.false59.19:                               ; preds = %lor.lhs.false51.19
  %509 = add nsw i64 %504, -63
  %arrayidx65.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %509
  %510 = load i32, i32* %arrayidx65.19, align 4
  %cmp66.19 = icmp eq i32 %510, 255
  br i1 %cmp66.19, label %if.then110.19, label %lor.lhs.false68.19

lor.lhs.false68.19:                               ; preds = %lor.lhs.false59.19
  %511 = add nuw nsw i64 %498, %indvars.iv.19
  %arrayidx73.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %511
  %512 = load i32, i32* %arrayidx73.19, align 4
  %cmp74.19 = icmp eq i32 %512, 255
  br i1 %cmp74.19, label %if.then110.19, label %lor.lhs.false76.19

lor.lhs.false76.19:                               ; preds = %lor.lhs.false68.19
  %513 = add nuw nsw i64 %499, %indvars.iv.19
  %arrayidx81.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %513
  %514 = load i32, i32* %arrayidx81.19, align 4
  %cmp82.19 = icmp eq i32 %514, 255
  br i1 %cmp82.19, label %if.then110.19, label %lor.lhs.false84.19

lor.lhs.false84.19:                               ; preds = %lor.lhs.false76.19
  %515 = add nuw nsw i64 %504, 63
  %arrayidx90.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %515
  %516 = load i32, i32* %arrayidx90.19, align 4
  %cmp91.19 = icmp eq i32 %516, 255
  br i1 %cmp91.19, label %if.then110.19, label %lor.lhs.false93.19

lor.lhs.false93.19:                               ; preds = %lor.lhs.false84.19
  %517 = add nuw nsw i64 %500, %indvars.iv.19
  %arrayidx98.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %517
  %518 = load i32, i32* %arrayidx98.19, align 4
  %cmp99.19 = icmp eq i32 %518, 255
  br i1 %cmp99.19, label %if.then110.19, label %lor.lhs.false101.19

lor.lhs.false101.19:                              ; preds = %lor.lhs.false93.19
  %519 = add nuw nsw i64 %504, 65
  %arrayidx107.19 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %519
  %520 = load i32, i32* %arrayidx107.19, align 4
  %cmp108.19 = icmp eq i32 %520, 255
  br i1 %cmp108.19, label %if.then110.19, label %if.else113.19

if.else113.19:                                    ; preds = %lor.lhs.false101.19
  %arrayidx115.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %501
  store i8 0, i8* %arrayidx115.19, align 1
  br label %for.inc125.19

if.then110.19:                                    ; preds = %lor.lhs.false101.19, %lor.lhs.false93.19, %lor.lhs.false84.19, %lor.lhs.false76.19, %lor.lhs.false68.19, %lor.lhs.false59.19, %lor.lhs.false51.19, %if.then42.19
  %arrayidx112.19 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %501
  store i8 -1, i8* %arrayidx112.19, align 1
  br label %for.inc125.19

for.inc125.19:                                    ; preds = %if.then110.19, %if.else113.19, %if.else117.19, %if.then35.19
  %indvars.iv.next.19 = add nuw nsw i64 %indvars.iv.19, 1
  %exitcond.19 = icmp eq i64 %indvars.iv.next.19, 64
  br i1 %exitcond.19, label %for.inc128.19, label %for.body23.19, !llvm.loop !1

for.inc128.19:                                    ; preds = %for.inc125.19
  %indvars.iv.next17.19 = or i64 %indvars.iv16, 20
  %521 = shl nsw i64 %indvars.iv.next17.19, 6
  %522 = shl i64 %indvars.iv.next17.19, 6
  %523 = add nsw i64 %522, -64
  %524 = add nsw i64 %521, -1
  %525 = or i64 %521, 1
  %526 = or i64 %522, 64
  br label %for.body23.20

for.body23.20:                                    ; preds = %for.inc125.20, %for.inc128.19
  %indvars.iv.20 = phi i64 [ 0, %for.inc128.19 ], [ %indvars.iv.next.20, %for.inc125.20 ]
  %527 = add nuw nsw i64 %indvars.iv.20, %521
  %528 = trunc i64 %indvars.iv.20 to i32
  switch i32 %528, label %if.else.20 [
    i32 0, label %if.then35.20
    i32 63, label %if.then35.20
  ]

if.then35.20:                                     ; preds = %for.body23.20, %for.body23.20
  %arrayidx37.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %527
  store i8 0, i8* %arrayidx37.20, align 1
  br label %for.inc125.20

if.else.20:                                       ; preds = %for.body23.20
  %arrayidx39.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %527
  %529 = load i32, i32* %arrayidx39.20, align 4
  %cmp40.20 = icmp eq i32 %529, 75
  br i1 %cmp40.20, label %if.then42.20, label %if.else117.20

if.else117.20:                                    ; preds = %if.else.20
  %conv120.20 = trunc i32 %529 to i8
  %arrayidx122.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %527
  store i8 %conv120.20, i8* %arrayidx122.20, align 1
  br label %for.inc125.20

if.then42.20:                                     ; preds = %if.else.20
  %530 = add nuw nsw i64 %indvars.iv.20, %522
  %531 = add nsw i64 %530, -65
  %arrayidx48.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %531
  %532 = load i32, i32* %arrayidx48.20, align 4
  %cmp49.20 = icmp eq i32 %532, 255
  br i1 %cmp49.20, label %if.then110.20, label %lor.lhs.false51.20

lor.lhs.false51.20:                               ; preds = %if.then42.20
  %533 = add nuw nsw i64 %523, %indvars.iv.20
  %arrayidx56.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %533
  %534 = load i32, i32* %arrayidx56.20, align 4
  %cmp57.20 = icmp eq i32 %534, 255
  br i1 %cmp57.20, label %if.then110.20, label %lor.lhs.false59.20

lor.lhs.false59.20:                               ; preds = %lor.lhs.false51.20
  %535 = add nsw i64 %530, -63
  %arrayidx65.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %535
  %536 = load i32, i32* %arrayidx65.20, align 4
  %cmp66.20 = icmp eq i32 %536, 255
  br i1 %cmp66.20, label %if.then110.20, label %lor.lhs.false68.20

lor.lhs.false68.20:                               ; preds = %lor.lhs.false59.20
  %537 = add nuw nsw i64 %524, %indvars.iv.20
  %arrayidx73.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %537
  %538 = load i32, i32* %arrayidx73.20, align 4
  %cmp74.20 = icmp eq i32 %538, 255
  br i1 %cmp74.20, label %if.then110.20, label %lor.lhs.false76.20

lor.lhs.false76.20:                               ; preds = %lor.lhs.false68.20
  %539 = add nuw nsw i64 %525, %indvars.iv.20
  %arrayidx81.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %539
  %540 = load i32, i32* %arrayidx81.20, align 4
  %cmp82.20 = icmp eq i32 %540, 255
  br i1 %cmp82.20, label %if.then110.20, label %lor.lhs.false84.20

lor.lhs.false84.20:                               ; preds = %lor.lhs.false76.20
  %541 = add nuw nsw i64 %530, 63
  %arrayidx90.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %541
  %542 = load i32, i32* %arrayidx90.20, align 4
  %cmp91.20 = icmp eq i32 %542, 255
  br i1 %cmp91.20, label %if.then110.20, label %lor.lhs.false93.20

lor.lhs.false93.20:                               ; preds = %lor.lhs.false84.20
  %543 = add nuw nsw i64 %526, %indvars.iv.20
  %arrayidx98.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %543
  %544 = load i32, i32* %arrayidx98.20, align 4
  %cmp99.20 = icmp eq i32 %544, 255
  br i1 %cmp99.20, label %if.then110.20, label %lor.lhs.false101.20

lor.lhs.false101.20:                              ; preds = %lor.lhs.false93.20
  %545 = add nuw nsw i64 %530, 65
  %arrayidx107.20 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %545
  %546 = load i32, i32* %arrayidx107.20, align 4
  %cmp108.20 = icmp eq i32 %546, 255
  br i1 %cmp108.20, label %if.then110.20, label %if.else113.20

if.else113.20:                                    ; preds = %lor.lhs.false101.20
  %arrayidx115.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %527
  store i8 0, i8* %arrayidx115.20, align 1
  br label %for.inc125.20

if.then110.20:                                    ; preds = %lor.lhs.false101.20, %lor.lhs.false93.20, %lor.lhs.false84.20, %lor.lhs.false76.20, %lor.lhs.false68.20, %lor.lhs.false59.20, %lor.lhs.false51.20, %if.then42.20
  %arrayidx112.20 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %527
  store i8 -1, i8* %arrayidx112.20, align 1
  br label %for.inc125.20

for.inc125.20:                                    ; preds = %if.then110.20, %if.else113.20, %if.else117.20, %if.then35.20
  %indvars.iv.next.20 = add nuw nsw i64 %indvars.iv.20, 1
  %exitcond.20 = icmp eq i64 %indvars.iv.next.20, 64
  br i1 %exitcond.20, label %for.inc128.20, label %for.body23.20, !llvm.loop !1

for.inc128.20:                                    ; preds = %for.inc125.20
  %indvars.iv.next17.20 = or i64 %indvars.iv16, 21
  %547 = shl nsw i64 %indvars.iv.next17.20, 6
  %548 = shl i64 %indvars.iv.next17.20, 6
  %549 = add nsw i64 %548, -64
  %550 = add nsw i64 %547, -1
  %551 = or i64 %547, 1
  %552 = add nuw nsw i64 %548, 64
  br label %for.body23.21

for.body23.21:                                    ; preds = %for.inc125.21, %for.inc128.20
  %indvars.iv.21 = phi i64 [ 0, %for.inc128.20 ], [ %indvars.iv.next.21, %for.inc125.21 ]
  %553 = add nuw nsw i64 %indvars.iv.21, %547
  %554 = trunc i64 %indvars.iv.21 to i32
  switch i32 %554, label %if.else.21 [
    i32 0, label %if.then35.21
    i32 63, label %if.then35.21
  ]

if.then35.21:                                     ; preds = %for.body23.21, %for.body23.21
  %arrayidx37.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %553
  store i8 0, i8* %arrayidx37.21, align 1
  br label %for.inc125.21

if.else.21:                                       ; preds = %for.body23.21
  %arrayidx39.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %553
  %555 = load i32, i32* %arrayidx39.21, align 4
  %cmp40.21 = icmp eq i32 %555, 75
  br i1 %cmp40.21, label %if.then42.21, label %if.else117.21

if.else117.21:                                    ; preds = %if.else.21
  %conv120.21 = trunc i32 %555 to i8
  %arrayidx122.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %553
  store i8 %conv120.21, i8* %arrayidx122.21, align 1
  br label %for.inc125.21

if.then42.21:                                     ; preds = %if.else.21
  %556 = add nuw nsw i64 %indvars.iv.21, %548
  %557 = add nsw i64 %556, -65
  %arrayidx48.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %557
  %558 = load i32, i32* %arrayidx48.21, align 4
  %cmp49.21 = icmp eq i32 %558, 255
  br i1 %cmp49.21, label %if.then110.21, label %lor.lhs.false51.21

lor.lhs.false51.21:                               ; preds = %if.then42.21
  %559 = add nuw nsw i64 %549, %indvars.iv.21
  %arrayidx56.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %559
  %560 = load i32, i32* %arrayidx56.21, align 4
  %cmp57.21 = icmp eq i32 %560, 255
  br i1 %cmp57.21, label %if.then110.21, label %lor.lhs.false59.21

lor.lhs.false59.21:                               ; preds = %lor.lhs.false51.21
  %561 = add nsw i64 %556, -63
  %arrayidx65.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %561
  %562 = load i32, i32* %arrayidx65.21, align 4
  %cmp66.21 = icmp eq i32 %562, 255
  br i1 %cmp66.21, label %if.then110.21, label %lor.lhs.false68.21

lor.lhs.false68.21:                               ; preds = %lor.lhs.false59.21
  %563 = add nuw nsw i64 %550, %indvars.iv.21
  %arrayidx73.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %563
  %564 = load i32, i32* %arrayidx73.21, align 4
  %cmp74.21 = icmp eq i32 %564, 255
  br i1 %cmp74.21, label %if.then110.21, label %lor.lhs.false76.21

lor.lhs.false76.21:                               ; preds = %lor.lhs.false68.21
  %565 = add nuw nsw i64 %551, %indvars.iv.21
  %arrayidx81.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %565
  %566 = load i32, i32* %arrayidx81.21, align 4
  %cmp82.21 = icmp eq i32 %566, 255
  br i1 %cmp82.21, label %if.then110.21, label %lor.lhs.false84.21

lor.lhs.false84.21:                               ; preds = %lor.lhs.false76.21
  %567 = add nuw nsw i64 %556, 63
  %arrayidx90.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %567
  %568 = load i32, i32* %arrayidx90.21, align 4
  %cmp91.21 = icmp eq i32 %568, 255
  br i1 %cmp91.21, label %if.then110.21, label %lor.lhs.false93.21

lor.lhs.false93.21:                               ; preds = %lor.lhs.false84.21
  %569 = add nuw nsw i64 %552, %indvars.iv.21
  %arrayidx98.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %569
  %570 = load i32, i32* %arrayidx98.21, align 4
  %cmp99.21 = icmp eq i32 %570, 255
  br i1 %cmp99.21, label %if.then110.21, label %lor.lhs.false101.21

lor.lhs.false101.21:                              ; preds = %lor.lhs.false93.21
  %571 = add nuw nsw i64 %556, 65
  %arrayidx107.21 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %571
  %572 = load i32, i32* %arrayidx107.21, align 4
  %cmp108.21 = icmp eq i32 %572, 255
  br i1 %cmp108.21, label %if.then110.21, label %if.else113.21

if.else113.21:                                    ; preds = %lor.lhs.false101.21
  %arrayidx115.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %553
  store i8 0, i8* %arrayidx115.21, align 1
  br label %for.inc125.21

if.then110.21:                                    ; preds = %lor.lhs.false101.21, %lor.lhs.false93.21, %lor.lhs.false84.21, %lor.lhs.false76.21, %lor.lhs.false68.21, %lor.lhs.false59.21, %lor.lhs.false51.21, %if.then42.21
  %arrayidx112.21 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %553
  store i8 -1, i8* %arrayidx112.21, align 1
  br label %for.inc125.21

for.inc125.21:                                    ; preds = %if.then110.21, %if.else113.21, %if.else117.21, %if.then35.21
  %indvars.iv.next.21 = add nuw nsw i64 %indvars.iv.21, 1
  %exitcond.21 = icmp eq i64 %indvars.iv.next.21, 64
  br i1 %exitcond.21, label %for.inc128.21, label %for.body23.21, !llvm.loop !1

for.inc128.21:                                    ; preds = %for.inc125.21
  %indvars.iv.next17.21 = or i64 %indvars.iv16, 22
  %573 = shl nsw i64 %indvars.iv.next17.21, 6
  %574 = shl i64 %indvars.iv.next17.21, 6
  %575 = add nsw i64 %574, -64
  %576 = add nsw i64 %573, -1
  %577 = or i64 %573, 1
  %578 = or i64 %574, 64
  br label %for.body23.22

for.body23.22:                                    ; preds = %for.inc125.22, %for.inc128.21
  %indvars.iv.22 = phi i64 [ 0, %for.inc128.21 ], [ %indvars.iv.next.22, %for.inc125.22 ]
  %579 = add nuw nsw i64 %indvars.iv.22, %573
  %580 = trunc i64 %indvars.iv.22 to i32
  switch i32 %580, label %if.else.22 [
    i32 0, label %if.then35.22
    i32 63, label %if.then35.22
  ]

if.then35.22:                                     ; preds = %for.body23.22, %for.body23.22
  %arrayidx37.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %579
  store i8 0, i8* %arrayidx37.22, align 1
  br label %for.inc125.22

if.else.22:                                       ; preds = %for.body23.22
  %arrayidx39.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %579
  %581 = load i32, i32* %arrayidx39.22, align 4
  %cmp40.22 = icmp eq i32 %581, 75
  br i1 %cmp40.22, label %if.then42.22, label %if.else117.22

if.else117.22:                                    ; preds = %if.else.22
  %conv120.22 = trunc i32 %581 to i8
  %arrayidx122.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %579
  store i8 %conv120.22, i8* %arrayidx122.22, align 1
  br label %for.inc125.22

if.then42.22:                                     ; preds = %if.else.22
  %582 = add nuw nsw i64 %indvars.iv.22, %574
  %583 = add nsw i64 %582, -65
  %arrayidx48.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %583
  %584 = load i32, i32* %arrayidx48.22, align 4
  %cmp49.22 = icmp eq i32 %584, 255
  br i1 %cmp49.22, label %if.then110.22, label %lor.lhs.false51.22

lor.lhs.false51.22:                               ; preds = %if.then42.22
  %585 = add nuw nsw i64 %575, %indvars.iv.22
  %arrayidx56.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %585
  %586 = load i32, i32* %arrayidx56.22, align 4
  %cmp57.22 = icmp eq i32 %586, 255
  br i1 %cmp57.22, label %if.then110.22, label %lor.lhs.false59.22

lor.lhs.false59.22:                               ; preds = %lor.lhs.false51.22
  %587 = add nsw i64 %582, -63
  %arrayidx65.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %587
  %588 = load i32, i32* %arrayidx65.22, align 4
  %cmp66.22 = icmp eq i32 %588, 255
  br i1 %cmp66.22, label %if.then110.22, label %lor.lhs.false68.22

lor.lhs.false68.22:                               ; preds = %lor.lhs.false59.22
  %589 = add nuw nsw i64 %576, %indvars.iv.22
  %arrayidx73.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %589
  %590 = load i32, i32* %arrayidx73.22, align 4
  %cmp74.22 = icmp eq i32 %590, 255
  br i1 %cmp74.22, label %if.then110.22, label %lor.lhs.false76.22

lor.lhs.false76.22:                               ; preds = %lor.lhs.false68.22
  %591 = add nuw nsw i64 %577, %indvars.iv.22
  %arrayidx81.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %591
  %592 = load i32, i32* %arrayidx81.22, align 4
  %cmp82.22 = icmp eq i32 %592, 255
  br i1 %cmp82.22, label %if.then110.22, label %lor.lhs.false84.22

lor.lhs.false84.22:                               ; preds = %lor.lhs.false76.22
  %593 = add nuw nsw i64 %582, 63
  %arrayidx90.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %593
  %594 = load i32, i32* %arrayidx90.22, align 4
  %cmp91.22 = icmp eq i32 %594, 255
  br i1 %cmp91.22, label %if.then110.22, label %lor.lhs.false93.22

lor.lhs.false93.22:                               ; preds = %lor.lhs.false84.22
  %595 = add nuw nsw i64 %578, %indvars.iv.22
  %arrayidx98.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %595
  %596 = load i32, i32* %arrayidx98.22, align 4
  %cmp99.22 = icmp eq i32 %596, 255
  br i1 %cmp99.22, label %if.then110.22, label %lor.lhs.false101.22

lor.lhs.false101.22:                              ; preds = %lor.lhs.false93.22
  %597 = add nuw nsw i64 %582, 65
  %arrayidx107.22 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %597
  %598 = load i32, i32* %arrayidx107.22, align 4
  %cmp108.22 = icmp eq i32 %598, 255
  br i1 %cmp108.22, label %if.then110.22, label %if.else113.22

if.else113.22:                                    ; preds = %lor.lhs.false101.22
  %arrayidx115.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %579
  store i8 0, i8* %arrayidx115.22, align 1
  br label %for.inc125.22

if.then110.22:                                    ; preds = %lor.lhs.false101.22, %lor.lhs.false93.22, %lor.lhs.false84.22, %lor.lhs.false76.22, %lor.lhs.false68.22, %lor.lhs.false59.22, %lor.lhs.false51.22, %if.then42.22
  %arrayidx112.22 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %579
  store i8 -1, i8* %arrayidx112.22, align 1
  br label %for.inc125.22

for.inc125.22:                                    ; preds = %if.then110.22, %if.else113.22, %if.else117.22, %if.then35.22
  %indvars.iv.next.22 = add nuw nsw i64 %indvars.iv.22, 1
  %exitcond.22 = icmp eq i64 %indvars.iv.next.22, 64
  br i1 %exitcond.22, label %for.inc128.22, label %for.body23.22, !llvm.loop !1

for.inc128.22:                                    ; preds = %for.inc125.22
  %indvars.iv.next17.22 = or i64 %indvars.iv16, 23
  %599 = shl nsw i64 %indvars.iv.next17.22, 6
  %600 = shl i64 %indvars.iv.next17.22, 6
  %601 = add nsw i64 %600, -64
  %602 = add nsw i64 %599, -1
  %603 = or i64 %599, 1
  %604 = add nuw nsw i64 %600, 64
  br label %for.body23.23

for.body23.23:                                    ; preds = %for.inc125.23, %for.inc128.22
  %indvars.iv.23 = phi i64 [ 0, %for.inc128.22 ], [ %indvars.iv.next.23, %for.inc125.23 ]
  %605 = add nuw nsw i64 %indvars.iv.23, %599
  %606 = trunc i64 %indvars.iv.23 to i32
  switch i32 %606, label %if.else.23 [
    i32 0, label %if.then35.23
    i32 63, label %if.then35.23
  ]

if.then35.23:                                     ; preds = %for.body23.23, %for.body23.23
  %arrayidx37.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %605
  store i8 0, i8* %arrayidx37.23, align 1
  br label %for.inc125.23

if.else.23:                                       ; preds = %for.body23.23
  %arrayidx39.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %605
  %607 = load i32, i32* %arrayidx39.23, align 4
  %cmp40.23 = icmp eq i32 %607, 75
  br i1 %cmp40.23, label %if.then42.23, label %if.else117.23

if.else117.23:                                    ; preds = %if.else.23
  %conv120.23 = trunc i32 %607 to i8
  %arrayidx122.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %605
  store i8 %conv120.23, i8* %arrayidx122.23, align 1
  br label %for.inc125.23

if.then42.23:                                     ; preds = %if.else.23
  %608 = add nuw nsw i64 %indvars.iv.23, %600
  %609 = add nsw i64 %608, -65
  %arrayidx48.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %609
  %610 = load i32, i32* %arrayidx48.23, align 4
  %cmp49.23 = icmp eq i32 %610, 255
  br i1 %cmp49.23, label %if.then110.23, label %lor.lhs.false51.23

lor.lhs.false51.23:                               ; preds = %if.then42.23
  %611 = add nuw nsw i64 %601, %indvars.iv.23
  %arrayidx56.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %611
  %612 = load i32, i32* %arrayidx56.23, align 4
  %cmp57.23 = icmp eq i32 %612, 255
  br i1 %cmp57.23, label %if.then110.23, label %lor.lhs.false59.23

lor.lhs.false59.23:                               ; preds = %lor.lhs.false51.23
  %613 = add nsw i64 %608, -63
  %arrayidx65.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %613
  %614 = load i32, i32* %arrayidx65.23, align 4
  %cmp66.23 = icmp eq i32 %614, 255
  br i1 %cmp66.23, label %if.then110.23, label %lor.lhs.false68.23

lor.lhs.false68.23:                               ; preds = %lor.lhs.false59.23
  %615 = add nuw nsw i64 %602, %indvars.iv.23
  %arrayidx73.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %615
  %616 = load i32, i32* %arrayidx73.23, align 4
  %cmp74.23 = icmp eq i32 %616, 255
  br i1 %cmp74.23, label %if.then110.23, label %lor.lhs.false76.23

lor.lhs.false76.23:                               ; preds = %lor.lhs.false68.23
  %617 = add nuw nsw i64 %603, %indvars.iv.23
  %arrayidx81.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %617
  %618 = load i32, i32* %arrayidx81.23, align 4
  %cmp82.23 = icmp eq i32 %618, 255
  br i1 %cmp82.23, label %if.then110.23, label %lor.lhs.false84.23

lor.lhs.false84.23:                               ; preds = %lor.lhs.false76.23
  %619 = add nuw nsw i64 %608, 63
  %arrayidx90.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %619
  %620 = load i32, i32* %arrayidx90.23, align 4
  %cmp91.23 = icmp eq i32 %620, 255
  br i1 %cmp91.23, label %if.then110.23, label %lor.lhs.false93.23

lor.lhs.false93.23:                               ; preds = %lor.lhs.false84.23
  %621 = add nuw nsw i64 %604, %indvars.iv.23
  %arrayidx98.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %621
  %622 = load i32, i32* %arrayidx98.23, align 4
  %cmp99.23 = icmp eq i32 %622, 255
  br i1 %cmp99.23, label %if.then110.23, label %lor.lhs.false101.23

lor.lhs.false101.23:                              ; preds = %lor.lhs.false93.23
  %623 = add nuw nsw i64 %608, 65
  %arrayidx107.23 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %623
  %624 = load i32, i32* %arrayidx107.23, align 4
  %cmp108.23 = icmp eq i32 %624, 255
  br i1 %cmp108.23, label %if.then110.23, label %if.else113.23

if.else113.23:                                    ; preds = %lor.lhs.false101.23
  %arrayidx115.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %605
  store i8 0, i8* %arrayidx115.23, align 1
  br label %for.inc125.23

if.then110.23:                                    ; preds = %lor.lhs.false101.23, %lor.lhs.false93.23, %lor.lhs.false84.23, %lor.lhs.false76.23, %lor.lhs.false68.23, %lor.lhs.false59.23, %lor.lhs.false51.23, %if.then42.23
  %arrayidx112.23 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %605
  store i8 -1, i8* %arrayidx112.23, align 1
  br label %for.inc125.23

for.inc125.23:                                    ; preds = %if.then110.23, %if.else113.23, %if.else117.23, %if.then35.23
  %indvars.iv.next.23 = add nuw nsw i64 %indvars.iv.23, 1
  %exitcond.23 = icmp eq i64 %indvars.iv.next.23, 64
  br i1 %exitcond.23, label %for.inc128.23, label %for.body23.23, !llvm.loop !1

for.inc128.23:                                    ; preds = %for.inc125.23
  %indvars.iv.next17.23 = or i64 %indvars.iv16, 24
  %625 = shl nsw i64 %indvars.iv.next17.23, 6
  %626 = shl i64 %indvars.iv.next17.23, 6
  %627 = add nsw i64 %626, -64
  %628 = add nsw i64 %625, -1
  %629 = or i64 %625, 1
  %630 = or i64 %626, 64
  br label %for.body23.24

for.body23.24:                                    ; preds = %for.inc125.24, %for.inc128.23
  %indvars.iv.24 = phi i64 [ 0, %for.inc128.23 ], [ %indvars.iv.next.24, %for.inc125.24 ]
  %631 = add nuw nsw i64 %indvars.iv.24, %625
  %632 = trunc i64 %indvars.iv.24 to i32
  switch i32 %632, label %if.else.24 [
    i32 0, label %if.then35.24
    i32 63, label %if.then35.24
  ]

if.then35.24:                                     ; preds = %for.body23.24, %for.body23.24
  %arrayidx37.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %631
  store i8 0, i8* %arrayidx37.24, align 1
  br label %for.inc125.24

if.else.24:                                       ; preds = %for.body23.24
  %arrayidx39.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %631
  %633 = load i32, i32* %arrayidx39.24, align 4
  %cmp40.24 = icmp eq i32 %633, 75
  br i1 %cmp40.24, label %if.then42.24, label %if.else117.24

if.else117.24:                                    ; preds = %if.else.24
  %conv120.24 = trunc i32 %633 to i8
  %arrayidx122.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %631
  store i8 %conv120.24, i8* %arrayidx122.24, align 1
  br label %for.inc125.24

if.then42.24:                                     ; preds = %if.else.24
  %634 = add nuw nsw i64 %indvars.iv.24, %626
  %635 = add nsw i64 %634, -65
  %arrayidx48.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %635
  %636 = load i32, i32* %arrayidx48.24, align 4
  %cmp49.24 = icmp eq i32 %636, 255
  br i1 %cmp49.24, label %if.then110.24, label %lor.lhs.false51.24

lor.lhs.false51.24:                               ; preds = %if.then42.24
  %637 = add nuw nsw i64 %627, %indvars.iv.24
  %arrayidx56.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %637
  %638 = load i32, i32* %arrayidx56.24, align 4
  %cmp57.24 = icmp eq i32 %638, 255
  br i1 %cmp57.24, label %if.then110.24, label %lor.lhs.false59.24

lor.lhs.false59.24:                               ; preds = %lor.lhs.false51.24
  %639 = add nsw i64 %634, -63
  %arrayidx65.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %639
  %640 = load i32, i32* %arrayidx65.24, align 4
  %cmp66.24 = icmp eq i32 %640, 255
  br i1 %cmp66.24, label %if.then110.24, label %lor.lhs.false68.24

lor.lhs.false68.24:                               ; preds = %lor.lhs.false59.24
  %641 = add nuw nsw i64 %628, %indvars.iv.24
  %arrayidx73.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %641
  %642 = load i32, i32* %arrayidx73.24, align 4
  %cmp74.24 = icmp eq i32 %642, 255
  br i1 %cmp74.24, label %if.then110.24, label %lor.lhs.false76.24

lor.lhs.false76.24:                               ; preds = %lor.lhs.false68.24
  %643 = add nuw nsw i64 %629, %indvars.iv.24
  %arrayidx81.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %643
  %644 = load i32, i32* %arrayidx81.24, align 4
  %cmp82.24 = icmp eq i32 %644, 255
  br i1 %cmp82.24, label %if.then110.24, label %lor.lhs.false84.24

lor.lhs.false84.24:                               ; preds = %lor.lhs.false76.24
  %645 = add nuw nsw i64 %634, 63
  %arrayidx90.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %645
  %646 = load i32, i32* %arrayidx90.24, align 4
  %cmp91.24 = icmp eq i32 %646, 255
  br i1 %cmp91.24, label %if.then110.24, label %lor.lhs.false93.24

lor.lhs.false93.24:                               ; preds = %lor.lhs.false84.24
  %647 = add nuw nsw i64 %630, %indvars.iv.24
  %arrayidx98.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %647
  %648 = load i32, i32* %arrayidx98.24, align 4
  %cmp99.24 = icmp eq i32 %648, 255
  br i1 %cmp99.24, label %if.then110.24, label %lor.lhs.false101.24

lor.lhs.false101.24:                              ; preds = %lor.lhs.false93.24
  %649 = add nuw nsw i64 %634, 65
  %arrayidx107.24 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %649
  %650 = load i32, i32* %arrayidx107.24, align 4
  %cmp108.24 = icmp eq i32 %650, 255
  br i1 %cmp108.24, label %if.then110.24, label %if.else113.24

if.else113.24:                                    ; preds = %lor.lhs.false101.24
  %arrayidx115.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %631
  store i8 0, i8* %arrayidx115.24, align 1
  br label %for.inc125.24

if.then110.24:                                    ; preds = %lor.lhs.false101.24, %lor.lhs.false93.24, %lor.lhs.false84.24, %lor.lhs.false76.24, %lor.lhs.false68.24, %lor.lhs.false59.24, %lor.lhs.false51.24, %if.then42.24
  %arrayidx112.24 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %631
  store i8 -1, i8* %arrayidx112.24, align 1
  br label %for.inc125.24

for.inc125.24:                                    ; preds = %if.then110.24, %if.else113.24, %if.else117.24, %if.then35.24
  %indvars.iv.next.24 = add nuw nsw i64 %indvars.iv.24, 1
  %exitcond.24 = icmp eq i64 %indvars.iv.next.24, 64
  br i1 %exitcond.24, label %for.inc128.24, label %for.body23.24, !llvm.loop !1

for.inc128.24:                                    ; preds = %for.inc125.24
  %indvars.iv.next17.24 = or i64 %indvars.iv16, 25
  %651 = shl nsw i64 %indvars.iv.next17.24, 6
  %652 = shl i64 %indvars.iv.next17.24, 6
  %653 = add nsw i64 %652, -64
  %654 = add nsw i64 %651, -1
  %655 = or i64 %651, 1
  %656 = add nuw nsw i64 %652, 64
  br label %for.body23.25

for.body23.25:                                    ; preds = %for.inc125.25, %for.inc128.24
  %indvars.iv.25 = phi i64 [ 0, %for.inc128.24 ], [ %indvars.iv.next.25, %for.inc125.25 ]
  %657 = add nuw nsw i64 %indvars.iv.25, %651
  %658 = trunc i64 %indvars.iv.25 to i32
  switch i32 %658, label %if.else.25 [
    i32 0, label %if.then35.25
    i32 63, label %if.then35.25
  ]

if.then35.25:                                     ; preds = %for.body23.25, %for.body23.25
  %arrayidx37.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %657
  store i8 0, i8* %arrayidx37.25, align 1
  br label %for.inc125.25

if.else.25:                                       ; preds = %for.body23.25
  %arrayidx39.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %657
  %659 = load i32, i32* %arrayidx39.25, align 4
  %cmp40.25 = icmp eq i32 %659, 75
  br i1 %cmp40.25, label %if.then42.25, label %if.else117.25

if.else117.25:                                    ; preds = %if.else.25
  %conv120.25 = trunc i32 %659 to i8
  %arrayidx122.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %657
  store i8 %conv120.25, i8* %arrayidx122.25, align 1
  br label %for.inc125.25

if.then42.25:                                     ; preds = %if.else.25
  %660 = add nuw nsw i64 %indvars.iv.25, %652
  %661 = add nsw i64 %660, -65
  %arrayidx48.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %661
  %662 = load i32, i32* %arrayidx48.25, align 4
  %cmp49.25 = icmp eq i32 %662, 255
  br i1 %cmp49.25, label %if.then110.25, label %lor.lhs.false51.25

lor.lhs.false51.25:                               ; preds = %if.then42.25
  %663 = add nuw nsw i64 %653, %indvars.iv.25
  %arrayidx56.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %663
  %664 = load i32, i32* %arrayidx56.25, align 4
  %cmp57.25 = icmp eq i32 %664, 255
  br i1 %cmp57.25, label %if.then110.25, label %lor.lhs.false59.25

lor.lhs.false59.25:                               ; preds = %lor.lhs.false51.25
  %665 = add nsw i64 %660, -63
  %arrayidx65.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %665
  %666 = load i32, i32* %arrayidx65.25, align 4
  %cmp66.25 = icmp eq i32 %666, 255
  br i1 %cmp66.25, label %if.then110.25, label %lor.lhs.false68.25

lor.lhs.false68.25:                               ; preds = %lor.lhs.false59.25
  %667 = add nuw nsw i64 %654, %indvars.iv.25
  %arrayidx73.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %667
  %668 = load i32, i32* %arrayidx73.25, align 4
  %cmp74.25 = icmp eq i32 %668, 255
  br i1 %cmp74.25, label %if.then110.25, label %lor.lhs.false76.25

lor.lhs.false76.25:                               ; preds = %lor.lhs.false68.25
  %669 = add nuw nsw i64 %655, %indvars.iv.25
  %arrayidx81.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %669
  %670 = load i32, i32* %arrayidx81.25, align 4
  %cmp82.25 = icmp eq i32 %670, 255
  br i1 %cmp82.25, label %if.then110.25, label %lor.lhs.false84.25

lor.lhs.false84.25:                               ; preds = %lor.lhs.false76.25
  %671 = add nuw nsw i64 %660, 63
  %arrayidx90.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %671
  %672 = load i32, i32* %arrayidx90.25, align 4
  %cmp91.25 = icmp eq i32 %672, 255
  br i1 %cmp91.25, label %if.then110.25, label %lor.lhs.false93.25

lor.lhs.false93.25:                               ; preds = %lor.lhs.false84.25
  %673 = add nuw nsw i64 %656, %indvars.iv.25
  %arrayidx98.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %673
  %674 = load i32, i32* %arrayidx98.25, align 4
  %cmp99.25 = icmp eq i32 %674, 255
  br i1 %cmp99.25, label %if.then110.25, label %lor.lhs.false101.25

lor.lhs.false101.25:                              ; preds = %lor.lhs.false93.25
  %675 = add nuw nsw i64 %660, 65
  %arrayidx107.25 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %675
  %676 = load i32, i32* %arrayidx107.25, align 4
  %cmp108.25 = icmp eq i32 %676, 255
  br i1 %cmp108.25, label %if.then110.25, label %if.else113.25

if.else113.25:                                    ; preds = %lor.lhs.false101.25
  %arrayidx115.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %657
  store i8 0, i8* %arrayidx115.25, align 1
  br label %for.inc125.25

if.then110.25:                                    ; preds = %lor.lhs.false101.25, %lor.lhs.false93.25, %lor.lhs.false84.25, %lor.lhs.false76.25, %lor.lhs.false68.25, %lor.lhs.false59.25, %lor.lhs.false51.25, %if.then42.25
  %arrayidx112.25 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %657
  store i8 -1, i8* %arrayidx112.25, align 1
  br label %for.inc125.25

for.inc125.25:                                    ; preds = %if.then110.25, %if.else113.25, %if.else117.25, %if.then35.25
  %indvars.iv.next.25 = add nuw nsw i64 %indvars.iv.25, 1
  %exitcond.25 = icmp eq i64 %indvars.iv.next.25, 64
  br i1 %exitcond.25, label %for.inc128.25, label %for.body23.25, !llvm.loop !1

for.inc128.25:                                    ; preds = %for.inc125.25
  %indvars.iv.next17.25 = or i64 %indvars.iv16, 26
  %677 = shl nsw i64 %indvars.iv.next17.25, 6
  %678 = shl i64 %indvars.iv.next17.25, 6
  %679 = add nsw i64 %678, -64
  %680 = add nsw i64 %677, -1
  %681 = or i64 %677, 1
  %682 = or i64 %678, 64
  br label %for.body23.26

for.body23.26:                                    ; preds = %for.inc125.26, %for.inc128.25
  %indvars.iv.26 = phi i64 [ 0, %for.inc128.25 ], [ %indvars.iv.next.26, %for.inc125.26 ]
  %683 = add nuw nsw i64 %indvars.iv.26, %677
  %684 = trunc i64 %indvars.iv.26 to i32
  switch i32 %684, label %if.else.26 [
    i32 0, label %if.then35.26
    i32 63, label %if.then35.26
  ]

if.then35.26:                                     ; preds = %for.body23.26, %for.body23.26
  %arrayidx37.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %683
  store i8 0, i8* %arrayidx37.26, align 1
  br label %for.inc125.26

if.else.26:                                       ; preds = %for.body23.26
  %arrayidx39.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %683
  %685 = load i32, i32* %arrayidx39.26, align 4
  %cmp40.26 = icmp eq i32 %685, 75
  br i1 %cmp40.26, label %if.then42.26, label %if.else117.26

if.else117.26:                                    ; preds = %if.else.26
  %conv120.26 = trunc i32 %685 to i8
  %arrayidx122.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %683
  store i8 %conv120.26, i8* %arrayidx122.26, align 1
  br label %for.inc125.26

if.then42.26:                                     ; preds = %if.else.26
  %686 = add nuw nsw i64 %indvars.iv.26, %678
  %687 = add nsw i64 %686, -65
  %arrayidx48.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %687
  %688 = load i32, i32* %arrayidx48.26, align 4
  %cmp49.26 = icmp eq i32 %688, 255
  br i1 %cmp49.26, label %if.then110.26, label %lor.lhs.false51.26

lor.lhs.false51.26:                               ; preds = %if.then42.26
  %689 = add nuw nsw i64 %679, %indvars.iv.26
  %arrayidx56.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %689
  %690 = load i32, i32* %arrayidx56.26, align 4
  %cmp57.26 = icmp eq i32 %690, 255
  br i1 %cmp57.26, label %if.then110.26, label %lor.lhs.false59.26

lor.lhs.false59.26:                               ; preds = %lor.lhs.false51.26
  %691 = add nsw i64 %686, -63
  %arrayidx65.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %691
  %692 = load i32, i32* %arrayidx65.26, align 4
  %cmp66.26 = icmp eq i32 %692, 255
  br i1 %cmp66.26, label %if.then110.26, label %lor.lhs.false68.26

lor.lhs.false68.26:                               ; preds = %lor.lhs.false59.26
  %693 = add nuw nsw i64 %680, %indvars.iv.26
  %arrayidx73.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %693
  %694 = load i32, i32* %arrayidx73.26, align 4
  %cmp74.26 = icmp eq i32 %694, 255
  br i1 %cmp74.26, label %if.then110.26, label %lor.lhs.false76.26

lor.lhs.false76.26:                               ; preds = %lor.lhs.false68.26
  %695 = add nuw nsw i64 %681, %indvars.iv.26
  %arrayidx81.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %695
  %696 = load i32, i32* %arrayidx81.26, align 4
  %cmp82.26 = icmp eq i32 %696, 255
  br i1 %cmp82.26, label %if.then110.26, label %lor.lhs.false84.26

lor.lhs.false84.26:                               ; preds = %lor.lhs.false76.26
  %697 = add nuw nsw i64 %686, 63
  %arrayidx90.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %697
  %698 = load i32, i32* %arrayidx90.26, align 4
  %cmp91.26 = icmp eq i32 %698, 255
  br i1 %cmp91.26, label %if.then110.26, label %lor.lhs.false93.26

lor.lhs.false93.26:                               ; preds = %lor.lhs.false84.26
  %699 = add nuw nsw i64 %682, %indvars.iv.26
  %arrayidx98.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %699
  %700 = load i32, i32* %arrayidx98.26, align 4
  %cmp99.26 = icmp eq i32 %700, 255
  br i1 %cmp99.26, label %if.then110.26, label %lor.lhs.false101.26

lor.lhs.false101.26:                              ; preds = %lor.lhs.false93.26
  %701 = add nuw nsw i64 %686, 65
  %arrayidx107.26 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %701
  %702 = load i32, i32* %arrayidx107.26, align 4
  %cmp108.26 = icmp eq i32 %702, 255
  br i1 %cmp108.26, label %if.then110.26, label %if.else113.26

if.else113.26:                                    ; preds = %lor.lhs.false101.26
  %arrayidx115.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %683
  store i8 0, i8* %arrayidx115.26, align 1
  br label %for.inc125.26

if.then110.26:                                    ; preds = %lor.lhs.false101.26, %lor.lhs.false93.26, %lor.lhs.false84.26, %lor.lhs.false76.26, %lor.lhs.false68.26, %lor.lhs.false59.26, %lor.lhs.false51.26, %if.then42.26
  %arrayidx112.26 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %683
  store i8 -1, i8* %arrayidx112.26, align 1
  br label %for.inc125.26

for.inc125.26:                                    ; preds = %if.then110.26, %if.else113.26, %if.else117.26, %if.then35.26
  %indvars.iv.next.26 = add nuw nsw i64 %indvars.iv.26, 1
  %exitcond.26 = icmp eq i64 %indvars.iv.next.26, 64
  br i1 %exitcond.26, label %for.inc128.26, label %for.body23.26, !llvm.loop !1

for.inc128.26:                                    ; preds = %for.inc125.26
  %indvars.iv.next17.26 = or i64 %indvars.iv16, 27
  %703 = shl nsw i64 %indvars.iv.next17.26, 6
  %704 = shl i64 %indvars.iv.next17.26, 6
  %705 = add nsw i64 %704, -64
  %706 = add nsw i64 %703, -1
  %707 = or i64 %703, 1
  %708 = add nuw nsw i64 %704, 64
  br label %for.body23.27

for.body23.27:                                    ; preds = %for.inc125.27, %for.inc128.26
  %indvars.iv.27 = phi i64 [ 0, %for.inc128.26 ], [ %indvars.iv.next.27, %for.inc125.27 ]
  %709 = add nuw nsw i64 %indvars.iv.27, %703
  %710 = trunc i64 %indvars.iv.27 to i32
  switch i32 %710, label %if.else.27 [
    i32 0, label %if.then35.27
    i32 63, label %if.then35.27
  ]

if.then35.27:                                     ; preds = %for.body23.27, %for.body23.27
  %arrayidx37.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %709
  store i8 0, i8* %arrayidx37.27, align 1
  br label %for.inc125.27

if.else.27:                                       ; preds = %for.body23.27
  %arrayidx39.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %709
  %711 = load i32, i32* %arrayidx39.27, align 4
  %cmp40.27 = icmp eq i32 %711, 75
  br i1 %cmp40.27, label %if.then42.27, label %if.else117.27

if.else117.27:                                    ; preds = %if.else.27
  %conv120.27 = trunc i32 %711 to i8
  %arrayidx122.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %709
  store i8 %conv120.27, i8* %arrayidx122.27, align 1
  br label %for.inc125.27

if.then42.27:                                     ; preds = %if.else.27
  %712 = add nuw nsw i64 %indvars.iv.27, %704
  %713 = add nsw i64 %712, -65
  %arrayidx48.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %713
  %714 = load i32, i32* %arrayidx48.27, align 4
  %cmp49.27 = icmp eq i32 %714, 255
  br i1 %cmp49.27, label %if.then110.27, label %lor.lhs.false51.27

lor.lhs.false51.27:                               ; preds = %if.then42.27
  %715 = add nuw nsw i64 %705, %indvars.iv.27
  %arrayidx56.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %715
  %716 = load i32, i32* %arrayidx56.27, align 4
  %cmp57.27 = icmp eq i32 %716, 255
  br i1 %cmp57.27, label %if.then110.27, label %lor.lhs.false59.27

lor.lhs.false59.27:                               ; preds = %lor.lhs.false51.27
  %717 = add nsw i64 %712, -63
  %arrayidx65.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %717
  %718 = load i32, i32* %arrayidx65.27, align 4
  %cmp66.27 = icmp eq i32 %718, 255
  br i1 %cmp66.27, label %if.then110.27, label %lor.lhs.false68.27

lor.lhs.false68.27:                               ; preds = %lor.lhs.false59.27
  %719 = add nuw nsw i64 %706, %indvars.iv.27
  %arrayidx73.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %719
  %720 = load i32, i32* %arrayidx73.27, align 4
  %cmp74.27 = icmp eq i32 %720, 255
  br i1 %cmp74.27, label %if.then110.27, label %lor.lhs.false76.27

lor.lhs.false76.27:                               ; preds = %lor.lhs.false68.27
  %721 = add nuw nsw i64 %707, %indvars.iv.27
  %arrayidx81.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %721
  %722 = load i32, i32* %arrayidx81.27, align 4
  %cmp82.27 = icmp eq i32 %722, 255
  br i1 %cmp82.27, label %if.then110.27, label %lor.lhs.false84.27

lor.lhs.false84.27:                               ; preds = %lor.lhs.false76.27
  %723 = add nuw nsw i64 %712, 63
  %arrayidx90.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %723
  %724 = load i32, i32* %arrayidx90.27, align 4
  %cmp91.27 = icmp eq i32 %724, 255
  br i1 %cmp91.27, label %if.then110.27, label %lor.lhs.false93.27

lor.lhs.false93.27:                               ; preds = %lor.lhs.false84.27
  %725 = add nuw nsw i64 %708, %indvars.iv.27
  %arrayidx98.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %725
  %726 = load i32, i32* %arrayidx98.27, align 4
  %cmp99.27 = icmp eq i32 %726, 255
  br i1 %cmp99.27, label %if.then110.27, label %lor.lhs.false101.27

lor.lhs.false101.27:                              ; preds = %lor.lhs.false93.27
  %727 = add nuw nsw i64 %712, 65
  %arrayidx107.27 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %727
  %728 = load i32, i32* %arrayidx107.27, align 4
  %cmp108.27 = icmp eq i32 %728, 255
  br i1 %cmp108.27, label %if.then110.27, label %if.else113.27

if.else113.27:                                    ; preds = %lor.lhs.false101.27
  %arrayidx115.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %709
  store i8 0, i8* %arrayidx115.27, align 1
  br label %for.inc125.27

if.then110.27:                                    ; preds = %lor.lhs.false101.27, %lor.lhs.false93.27, %lor.lhs.false84.27, %lor.lhs.false76.27, %lor.lhs.false68.27, %lor.lhs.false59.27, %lor.lhs.false51.27, %if.then42.27
  %arrayidx112.27 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %709
  store i8 -1, i8* %arrayidx112.27, align 1
  br label %for.inc125.27

for.inc125.27:                                    ; preds = %if.then110.27, %if.else113.27, %if.else117.27, %if.then35.27
  %indvars.iv.next.27 = add nuw nsw i64 %indvars.iv.27, 1
  %exitcond.27 = icmp eq i64 %indvars.iv.next.27, 64
  br i1 %exitcond.27, label %for.inc128.27, label %for.body23.27, !llvm.loop !1

for.inc128.27:                                    ; preds = %for.inc125.27
  %indvars.iv.next17.27 = or i64 %indvars.iv16, 28
  %729 = shl nsw i64 %indvars.iv.next17.27, 6
  %730 = shl i64 %indvars.iv.next17.27, 6
  %731 = add nsw i64 %730, -64
  %732 = add nsw i64 %729, -1
  %733 = or i64 %729, 1
  %734 = or i64 %730, 64
  br label %for.body23.28

for.body23.28:                                    ; preds = %for.inc125.28, %for.inc128.27
  %indvars.iv.28 = phi i64 [ 0, %for.inc128.27 ], [ %indvars.iv.next.28, %for.inc125.28 ]
  %735 = add nuw nsw i64 %indvars.iv.28, %729
  %736 = trunc i64 %indvars.iv.28 to i32
  switch i32 %736, label %if.else.28 [
    i32 0, label %if.then35.28
    i32 63, label %if.then35.28
  ]

if.then35.28:                                     ; preds = %for.body23.28, %for.body23.28
  %arrayidx37.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %735
  store i8 0, i8* %arrayidx37.28, align 1
  br label %for.inc125.28

if.else.28:                                       ; preds = %for.body23.28
  %arrayidx39.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %735
  %737 = load i32, i32* %arrayidx39.28, align 4
  %cmp40.28 = icmp eq i32 %737, 75
  br i1 %cmp40.28, label %if.then42.28, label %if.else117.28

if.else117.28:                                    ; preds = %if.else.28
  %conv120.28 = trunc i32 %737 to i8
  %arrayidx122.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %735
  store i8 %conv120.28, i8* %arrayidx122.28, align 1
  br label %for.inc125.28

if.then42.28:                                     ; preds = %if.else.28
  %738 = add nuw nsw i64 %indvars.iv.28, %730
  %739 = add nsw i64 %738, -65
  %arrayidx48.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %739
  %740 = load i32, i32* %arrayidx48.28, align 4
  %cmp49.28 = icmp eq i32 %740, 255
  br i1 %cmp49.28, label %if.then110.28, label %lor.lhs.false51.28

lor.lhs.false51.28:                               ; preds = %if.then42.28
  %741 = add nuw nsw i64 %731, %indvars.iv.28
  %arrayidx56.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %741
  %742 = load i32, i32* %arrayidx56.28, align 4
  %cmp57.28 = icmp eq i32 %742, 255
  br i1 %cmp57.28, label %if.then110.28, label %lor.lhs.false59.28

lor.lhs.false59.28:                               ; preds = %lor.lhs.false51.28
  %743 = add nsw i64 %738, -63
  %arrayidx65.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %743
  %744 = load i32, i32* %arrayidx65.28, align 4
  %cmp66.28 = icmp eq i32 %744, 255
  br i1 %cmp66.28, label %if.then110.28, label %lor.lhs.false68.28

lor.lhs.false68.28:                               ; preds = %lor.lhs.false59.28
  %745 = add nuw nsw i64 %732, %indvars.iv.28
  %arrayidx73.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %745
  %746 = load i32, i32* %arrayidx73.28, align 4
  %cmp74.28 = icmp eq i32 %746, 255
  br i1 %cmp74.28, label %if.then110.28, label %lor.lhs.false76.28

lor.lhs.false76.28:                               ; preds = %lor.lhs.false68.28
  %747 = add nuw nsw i64 %733, %indvars.iv.28
  %arrayidx81.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %747
  %748 = load i32, i32* %arrayidx81.28, align 4
  %cmp82.28 = icmp eq i32 %748, 255
  br i1 %cmp82.28, label %if.then110.28, label %lor.lhs.false84.28

lor.lhs.false84.28:                               ; preds = %lor.lhs.false76.28
  %749 = add nuw nsw i64 %738, 63
  %arrayidx90.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %749
  %750 = load i32, i32* %arrayidx90.28, align 4
  %cmp91.28 = icmp eq i32 %750, 255
  br i1 %cmp91.28, label %if.then110.28, label %lor.lhs.false93.28

lor.lhs.false93.28:                               ; preds = %lor.lhs.false84.28
  %751 = add nuw nsw i64 %734, %indvars.iv.28
  %arrayidx98.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %751
  %752 = load i32, i32* %arrayidx98.28, align 4
  %cmp99.28 = icmp eq i32 %752, 255
  br i1 %cmp99.28, label %if.then110.28, label %lor.lhs.false101.28

lor.lhs.false101.28:                              ; preds = %lor.lhs.false93.28
  %753 = add nuw nsw i64 %738, 65
  %arrayidx107.28 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %753
  %754 = load i32, i32* %arrayidx107.28, align 4
  %cmp108.28 = icmp eq i32 %754, 255
  br i1 %cmp108.28, label %if.then110.28, label %if.else113.28

if.else113.28:                                    ; preds = %lor.lhs.false101.28
  %arrayidx115.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %735
  store i8 0, i8* %arrayidx115.28, align 1
  br label %for.inc125.28

if.then110.28:                                    ; preds = %lor.lhs.false101.28, %lor.lhs.false93.28, %lor.lhs.false84.28, %lor.lhs.false76.28, %lor.lhs.false68.28, %lor.lhs.false59.28, %lor.lhs.false51.28, %if.then42.28
  %arrayidx112.28 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %735
  store i8 -1, i8* %arrayidx112.28, align 1
  br label %for.inc125.28

for.inc125.28:                                    ; preds = %if.then110.28, %if.else113.28, %if.else117.28, %if.then35.28
  %indvars.iv.next.28 = add nuw nsw i64 %indvars.iv.28, 1
  %exitcond.28 = icmp eq i64 %indvars.iv.next.28, 64
  br i1 %exitcond.28, label %for.inc128.28, label %for.body23.28, !llvm.loop !1

for.inc128.28:                                    ; preds = %for.inc125.28
  %indvars.iv.next17.28 = or i64 %indvars.iv16, 29
  %755 = shl nsw i64 %indvars.iv.next17.28, 6
  %756 = shl i64 %indvars.iv.next17.28, 6
  %757 = add nsw i64 %756, -64
  %758 = add nsw i64 %755, -1
  %759 = or i64 %755, 1
  %760 = add nuw nsw i64 %756, 64
  br label %for.body23.29

for.body23.29:                                    ; preds = %for.inc125.29, %for.inc128.28
  %indvars.iv.29 = phi i64 [ 0, %for.inc128.28 ], [ %indvars.iv.next.29, %for.inc125.29 ]
  %761 = add nuw nsw i64 %indvars.iv.29, %755
  %762 = trunc i64 %indvars.iv.29 to i32
  switch i32 %762, label %if.else.29 [
    i32 0, label %if.then35.29
    i32 63, label %if.then35.29
  ]

if.then35.29:                                     ; preds = %for.body23.29, %for.body23.29
  %arrayidx37.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %761
  store i8 0, i8* %arrayidx37.29, align 1
  br label %for.inc125.29

if.else.29:                                       ; preds = %for.body23.29
  %arrayidx39.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %761
  %763 = load i32, i32* %arrayidx39.29, align 4
  %cmp40.29 = icmp eq i32 %763, 75
  br i1 %cmp40.29, label %if.then42.29, label %if.else117.29

if.else117.29:                                    ; preds = %if.else.29
  %conv120.29 = trunc i32 %763 to i8
  %arrayidx122.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %761
  store i8 %conv120.29, i8* %arrayidx122.29, align 1
  br label %for.inc125.29

if.then42.29:                                     ; preds = %if.else.29
  %764 = add nuw nsw i64 %indvars.iv.29, %756
  %765 = add nsw i64 %764, -65
  %arrayidx48.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %765
  %766 = load i32, i32* %arrayidx48.29, align 4
  %cmp49.29 = icmp eq i32 %766, 255
  br i1 %cmp49.29, label %if.then110.29, label %lor.lhs.false51.29

lor.lhs.false51.29:                               ; preds = %if.then42.29
  %767 = add nuw nsw i64 %757, %indvars.iv.29
  %arrayidx56.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %767
  %768 = load i32, i32* %arrayidx56.29, align 4
  %cmp57.29 = icmp eq i32 %768, 255
  br i1 %cmp57.29, label %if.then110.29, label %lor.lhs.false59.29

lor.lhs.false59.29:                               ; preds = %lor.lhs.false51.29
  %769 = add nsw i64 %764, -63
  %arrayidx65.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %769
  %770 = load i32, i32* %arrayidx65.29, align 4
  %cmp66.29 = icmp eq i32 %770, 255
  br i1 %cmp66.29, label %if.then110.29, label %lor.lhs.false68.29

lor.lhs.false68.29:                               ; preds = %lor.lhs.false59.29
  %771 = add nuw nsw i64 %758, %indvars.iv.29
  %arrayidx73.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %771
  %772 = load i32, i32* %arrayidx73.29, align 4
  %cmp74.29 = icmp eq i32 %772, 255
  br i1 %cmp74.29, label %if.then110.29, label %lor.lhs.false76.29

lor.lhs.false76.29:                               ; preds = %lor.lhs.false68.29
  %773 = add nuw nsw i64 %759, %indvars.iv.29
  %arrayidx81.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %773
  %774 = load i32, i32* %arrayidx81.29, align 4
  %cmp82.29 = icmp eq i32 %774, 255
  br i1 %cmp82.29, label %if.then110.29, label %lor.lhs.false84.29

lor.lhs.false84.29:                               ; preds = %lor.lhs.false76.29
  %775 = add nuw nsw i64 %764, 63
  %arrayidx90.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %775
  %776 = load i32, i32* %arrayidx90.29, align 4
  %cmp91.29 = icmp eq i32 %776, 255
  br i1 %cmp91.29, label %if.then110.29, label %lor.lhs.false93.29

lor.lhs.false93.29:                               ; preds = %lor.lhs.false84.29
  %777 = add nuw nsw i64 %760, %indvars.iv.29
  %arrayidx98.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %777
  %778 = load i32, i32* %arrayidx98.29, align 4
  %cmp99.29 = icmp eq i32 %778, 255
  br i1 %cmp99.29, label %if.then110.29, label %lor.lhs.false101.29

lor.lhs.false101.29:                              ; preds = %lor.lhs.false93.29
  %779 = add nuw nsw i64 %764, 65
  %arrayidx107.29 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %779
  %780 = load i32, i32* %arrayidx107.29, align 4
  %cmp108.29 = icmp eq i32 %780, 255
  br i1 %cmp108.29, label %if.then110.29, label %if.else113.29

if.else113.29:                                    ; preds = %lor.lhs.false101.29
  %arrayidx115.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %761
  store i8 0, i8* %arrayidx115.29, align 1
  br label %for.inc125.29

if.then110.29:                                    ; preds = %lor.lhs.false101.29, %lor.lhs.false93.29, %lor.lhs.false84.29, %lor.lhs.false76.29, %lor.lhs.false68.29, %lor.lhs.false59.29, %lor.lhs.false51.29, %if.then42.29
  %arrayidx112.29 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %761
  store i8 -1, i8* %arrayidx112.29, align 1
  br label %for.inc125.29

for.inc125.29:                                    ; preds = %if.then110.29, %if.else113.29, %if.else117.29, %if.then35.29
  %indvars.iv.next.29 = add nuw nsw i64 %indvars.iv.29, 1
  %exitcond.29 = icmp eq i64 %indvars.iv.next.29, 64
  br i1 %exitcond.29, label %for.inc128.29, label %for.body23.29, !llvm.loop !1

for.inc128.29:                                    ; preds = %for.inc125.29
  %indvars.iv.next17.29 = or i64 %indvars.iv16, 30
  %781 = shl nsw i64 %indvars.iv.next17.29, 6
  %782 = shl i64 %indvars.iv.next17.29, 6
  %783 = add nsw i64 %782, -64
  %784 = add nsw i64 %781, -1
  %785 = or i64 %781, 1
  %786 = or i64 %782, 64
  br label %for.body23.30

for.body23.30:                                    ; preds = %for.inc125.30, %for.inc128.29
  %indvars.iv.30 = phi i64 [ 0, %for.inc128.29 ], [ %indvars.iv.next.30, %for.inc125.30 ]
  %787 = add nuw nsw i64 %indvars.iv.30, %781
  %788 = trunc i64 %indvars.iv.30 to i32
  switch i32 %788, label %if.else.30 [
    i32 0, label %if.then35.30
    i32 63, label %if.then35.30
  ]

if.then35.30:                                     ; preds = %for.body23.30, %for.body23.30
  %arrayidx37.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %787
  store i8 0, i8* %arrayidx37.30, align 1
  br label %for.inc125.30

if.else.30:                                       ; preds = %for.body23.30
  %arrayidx39.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %787
  %789 = load i32, i32* %arrayidx39.30, align 4
  %cmp40.30 = icmp eq i32 %789, 75
  br i1 %cmp40.30, label %if.then42.30, label %if.else117.30

if.else117.30:                                    ; preds = %if.else.30
  %conv120.30 = trunc i32 %789 to i8
  %arrayidx122.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %787
  store i8 %conv120.30, i8* %arrayidx122.30, align 1
  br label %for.inc125.30

if.then42.30:                                     ; preds = %if.else.30
  %790 = add nuw nsw i64 %indvars.iv.30, %782
  %791 = add nsw i64 %790, -65
  %arrayidx48.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %791
  %792 = load i32, i32* %arrayidx48.30, align 4
  %cmp49.30 = icmp eq i32 %792, 255
  br i1 %cmp49.30, label %if.then110.30, label %lor.lhs.false51.30

lor.lhs.false51.30:                               ; preds = %if.then42.30
  %793 = add nuw nsw i64 %783, %indvars.iv.30
  %arrayidx56.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %793
  %794 = load i32, i32* %arrayidx56.30, align 4
  %cmp57.30 = icmp eq i32 %794, 255
  br i1 %cmp57.30, label %if.then110.30, label %lor.lhs.false59.30

lor.lhs.false59.30:                               ; preds = %lor.lhs.false51.30
  %795 = add nsw i64 %790, -63
  %arrayidx65.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %795
  %796 = load i32, i32* %arrayidx65.30, align 4
  %cmp66.30 = icmp eq i32 %796, 255
  br i1 %cmp66.30, label %if.then110.30, label %lor.lhs.false68.30

lor.lhs.false68.30:                               ; preds = %lor.lhs.false59.30
  %797 = add nuw nsw i64 %784, %indvars.iv.30
  %arrayidx73.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %797
  %798 = load i32, i32* %arrayidx73.30, align 4
  %cmp74.30 = icmp eq i32 %798, 255
  br i1 %cmp74.30, label %if.then110.30, label %lor.lhs.false76.30

lor.lhs.false76.30:                               ; preds = %lor.lhs.false68.30
  %799 = add nuw nsw i64 %785, %indvars.iv.30
  %arrayidx81.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %799
  %800 = load i32, i32* %arrayidx81.30, align 4
  %cmp82.30 = icmp eq i32 %800, 255
  br i1 %cmp82.30, label %if.then110.30, label %lor.lhs.false84.30

lor.lhs.false84.30:                               ; preds = %lor.lhs.false76.30
  %801 = add nuw nsw i64 %790, 63
  %arrayidx90.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %801
  %802 = load i32, i32* %arrayidx90.30, align 4
  %cmp91.30 = icmp eq i32 %802, 255
  br i1 %cmp91.30, label %if.then110.30, label %lor.lhs.false93.30

lor.lhs.false93.30:                               ; preds = %lor.lhs.false84.30
  %803 = add nuw nsw i64 %786, %indvars.iv.30
  %arrayidx98.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %803
  %804 = load i32, i32* %arrayidx98.30, align 4
  %cmp99.30 = icmp eq i32 %804, 255
  br i1 %cmp99.30, label %if.then110.30, label %lor.lhs.false101.30

lor.lhs.false101.30:                              ; preds = %lor.lhs.false93.30
  %805 = add nuw nsw i64 %790, 65
  %arrayidx107.30 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %805
  %806 = load i32, i32* %arrayidx107.30, align 4
  %cmp108.30 = icmp eq i32 %806, 255
  br i1 %cmp108.30, label %if.then110.30, label %if.else113.30

if.else113.30:                                    ; preds = %lor.lhs.false101.30
  %arrayidx115.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %787
  store i8 0, i8* %arrayidx115.30, align 1
  br label %for.inc125.30

if.then110.30:                                    ; preds = %lor.lhs.false101.30, %lor.lhs.false93.30, %lor.lhs.false84.30, %lor.lhs.false76.30, %lor.lhs.false68.30, %lor.lhs.false59.30, %lor.lhs.false51.30, %if.then42.30
  %arrayidx112.30 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %787
  store i8 -1, i8* %arrayidx112.30, align 1
  br label %for.inc125.30

for.inc125.30:                                    ; preds = %if.then110.30, %if.else113.30, %if.else117.30, %if.then35.30
  %indvars.iv.next.30 = add nuw nsw i64 %indvars.iv.30, 1
  %exitcond.30 = icmp eq i64 %indvars.iv.next.30, 64
  br i1 %exitcond.30, label %for.inc128.30, label %for.body23.30, !llvm.loop !1

for.inc128.30:                                    ; preds = %for.inc125.30
  %indvars.iv.next17.30 = or i64 %indvars.iv16, 31
  %807 = shl nsw i64 %indvars.iv.next17.30, 6
  %808 = shl i64 %indvars.iv.next17.30, 6
  %809 = add nsw i64 %808, -64
  %810 = add nsw i64 %807, -1
  %811 = or i64 %807, 1
  %812 = add nuw nsw i64 %808, 64
  %813 = trunc i64 %indvars.iv.next17.30 to i32
  %cond32 = icmp eq i32 %813, 63
  br label %for.body23.31

for.body23.31:                                    ; preds = %for.inc125.31, %for.inc128.30
  %indvars.iv.31 = phi i64 [ 0, %for.inc128.30 ], [ %indvars.iv.next.31, %for.inc125.31 ]
  %814 = add nuw nsw i64 %indvars.iv.31, %807
  br i1 %cond32, label %if.then35.31, label %lor.lhs.false29.31

lor.lhs.false29.31:                               ; preds = %for.body23.31
  %815 = trunc i64 %indvars.iv.31 to i32
  switch i32 %815, label %if.else.31 [
    i32 0, label %if.then35.31
    i32 63, label %if.then35.31
  ]

if.then35.31:                                     ; preds = %for.body23.31, %lor.lhs.false29.31, %lor.lhs.false29.31
  %arrayidx37.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %814
  store i8 0, i8* %arrayidx37.31, align 1
  br label %for.inc125.31

if.else.31:                                       ; preds = %lor.lhs.false29.31
  %arrayidx39.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %814
  %816 = load i32, i32* %arrayidx39.31, align 4
  %cmp40.31 = icmp eq i32 %816, 75
  br i1 %cmp40.31, label %if.then42.31, label %if.else117.31

if.else117.31:                                    ; preds = %if.else.31
  %conv120.31 = trunc i32 %816 to i8
  %arrayidx122.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %814
  store i8 %conv120.31, i8* %arrayidx122.31, align 1
  br label %for.inc125.31

if.then42.31:                                     ; preds = %if.else.31
  %817 = add nuw nsw i64 %indvars.iv.31, %808
  %818 = add nsw i64 %817, -65
  %arrayidx48.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %818
  %819 = load i32, i32* %arrayidx48.31, align 4
  %cmp49.31 = icmp eq i32 %819, 255
  br i1 %cmp49.31, label %if.then110.31, label %lor.lhs.false51.31

lor.lhs.false51.31:                               ; preds = %if.then42.31
  %820 = add nuw nsw i64 %809, %indvars.iv.31
  %arrayidx56.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %820
  %821 = load i32, i32* %arrayidx56.31, align 4
  %cmp57.31 = icmp eq i32 %821, 255
  br i1 %cmp57.31, label %if.then110.31, label %lor.lhs.false59.31

lor.lhs.false59.31:                               ; preds = %lor.lhs.false51.31
  %822 = add nsw i64 %817, -63
  %arrayidx65.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %822
  %823 = load i32, i32* %arrayidx65.31, align 4
  %cmp66.31 = icmp eq i32 %823, 255
  br i1 %cmp66.31, label %if.then110.31, label %lor.lhs.false68.31

lor.lhs.false68.31:                               ; preds = %lor.lhs.false59.31
  %824 = add nuw nsw i64 %810, %indvars.iv.31
  %arrayidx73.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %824
  %825 = load i32, i32* %arrayidx73.31, align 4
  %cmp74.31 = icmp eq i32 %825, 255
  br i1 %cmp74.31, label %if.then110.31, label %lor.lhs.false76.31

lor.lhs.false76.31:                               ; preds = %lor.lhs.false68.31
  %826 = add nuw nsw i64 %811, %indvars.iv.31
  %arrayidx81.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %826
  %827 = load i32, i32* %arrayidx81.31, align 4
  %cmp82.31 = icmp eq i32 %827, 255
  br i1 %cmp82.31, label %if.then110.31, label %lor.lhs.false84.31

lor.lhs.false84.31:                               ; preds = %lor.lhs.false76.31
  %828 = add nuw nsw i64 %817, 63
  %arrayidx90.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %828
  %829 = load i32, i32* %arrayidx90.31, align 4
  %cmp91.31 = icmp eq i32 %829, 255
  br i1 %cmp91.31, label %if.then110.31, label %lor.lhs.false93.31

lor.lhs.false93.31:                               ; preds = %lor.lhs.false84.31
  %830 = add nuw nsw i64 %812, %indvars.iv.31
  %arrayidx98.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %830
  %831 = load i32, i32* %arrayidx98.31, align 4
  %cmp99.31 = icmp eq i32 %831, 255
  br i1 %cmp99.31, label %if.then110.31, label %lor.lhs.false101.31

lor.lhs.false101.31:                              ; preds = %lor.lhs.false93.31
  %832 = add nuw nsw i64 %817, 65
  %arrayidx107.31 = getelementptr inbounds i32, i32* inttoptr (i64 538968096 to i32*), i64 %832
  %833 = load i32, i32* %arrayidx107.31, align 4
  %cmp108.31 = icmp eq i32 %833, 255
  br i1 %cmp108.31, label %if.then110.31, label %if.else113.31

if.else113.31:                                    ; preds = %lor.lhs.false101.31
  %arrayidx115.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %814
  store i8 0, i8* %arrayidx115.31, align 1
  br label %for.inc125.31

if.then110.31:                                    ; preds = %lor.lhs.false101.31, %lor.lhs.false93.31, %lor.lhs.false84.31, %lor.lhs.false76.31, %lor.lhs.false68.31, %lor.lhs.false59.31, %lor.lhs.false51.31, %if.then42.31
  %arrayidx112.31 = getelementptr inbounds i8, i8* inttoptr (i64 539033632 to i8*), i64 %814
  store i8 -1, i8* %arrayidx112.31, align 1
  br label %for.inc125.31

for.inc125.31:                                    ; preds = %if.then110.31, %if.else113.31, %if.else117.31, %if.then35.31
  %indvars.iv.next.31 = add nuw nsw i64 %indvars.iv.31, 1
  %exitcond.31 = icmp eq i64 %indvars.iv.next.31, 64
  br i1 %exitcond.31, label %for.inc128.31, label %for.body23.31, !llvm.loop !1

for.inc128.31:                                    ; preds = %for.inc125.31
  %indvars.iv.next17.31 = add nsw i64 %indvars.iv16, 32
  %exitcond24.31 = icmp eq i64 %indvars.iv.next17.31, 64
  br i1 %exitcond24.31, label %for.end130, label %for.cond20.preheader, !llvm.loop !3
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 "}
!1 = distinct !{!1, !2}
!2 = !{!"llvm.loop.unroll.disable"}
!3 = distinct !{!3, !2}
