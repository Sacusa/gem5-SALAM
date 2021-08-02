TARGET=canny_non_max0.ll \
	   convolution0.ll convolution1.ll \
	   edge_tracking0.ll \
	   elem_matrix0.ll elem_matrix1.ll elem_matrix2.ll elem_matrix3.ll \
	   grayscale0.ll \
	   harris_non_max0.ll \
	   isp0.ll

build : $(TARGET)
	rm -f *.o

canny_non_max0.o : canny_non_max.c
	clang -D ACC_NUM=0 -emit-llvm -c -o $@ $<

convolution0.o : convolution.c
	clang -D ACC_NUM=0 -emit-llvm -c -o $@ $<
convolution1.o : convolution.c
	clang -D ACC_NUM=1 -emit-llvm -c -o $@ $<

edge_tracking0.o : edge_tracking.c
	clang -D ACC_NUM=0 -emit-llvm -c -o $@ $<

elem_matrix0.o : elem_matrix.c
	clang -D ACC_NUM=0 -emit-llvm -c -o $@ $<
elem_matrix1.o : elem_matrix.c
	clang -D ACC_NUM=1 -emit-llvm -c -o $@ $<
elem_matrix2.o : elem_matrix.c
	clang -D ACC_NUM=2 -emit-llvm -c -o $@ $<
elem_matrix3.o : elem_matrix.c
	clang -D ACC_NUM=3 -emit-llvm -c -o $@ $<

grayscale0.o : grayscale.c
	clang -D ACC_NUM=0 -emit-llvm -c -o $@ $<

harris_non_max0.o : harris_non_max.c
	clang -D ACC_NUM=0 -emit-llvm -c -o $@ $<

isp0.o : isp.c
	clang -D ACC_NUM=0 -emit-llvm -c -o $@ $<

#%.o : %.c
#	clang -emit-llvm -c -o $@ $<

%.bc : %.o
	opt -O1 -mem2reg -simplifycfg -loops -loop-unroll -o $@ $<

%.ll : %.bc
	llvm-dis -o $@ $<

clean:
	rm -f *.ll
