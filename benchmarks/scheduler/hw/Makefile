TARGET=canny_non_max0.ll \
	   convolution0.ll convolution1.ll \
	   edge_tracking0.ll \
	   elem_matrix0.ll elem_matrix1.ll elem_matrix2.ll elem_matrix3.ll \
	   grayscale0.ll \
	   harris_non_max0.ll \
	   isp0.ll
FLAGS = -Wno-int-to-pointer-cast -emit-llvm -c -o $@ $<

build : $(TARGET)
	rm -f *.o

canny_non_max0.o : canny_non_max.c
	clang -D ACC_NUM=0 $(FLAGS)

convolution0.o : convolution.c
	clang -D ACC_NUM=0 $(FLAGS)
convolution1.o : convolution.c
	clang -D ACC_NUM=1 $(FLAGS)

edge_tracking0.o : edge_tracking.c
	clang -D ACC_NUM=0 $(FLAGS)

elem_matrix0.o : elem_matrix.c
	clang -D ACC_NUM=0 $(FLAGS)
elem_matrix1.o : elem_matrix.c
	clang -D ACC_NUM=1 $(FLAGS)
elem_matrix2.o : elem_matrix.c
	clang -D ACC_NUM=2 $(FLAGS)
elem_matrix3.o : elem_matrix.c
	clang -D ACC_NUM=3 $(FLAGS)

grayscale0.o : grayscale.c
	clang -D ACC_NUM=0 $(FLAGS)

harris_non_max0.o : harris_non_max.c
	clang -D ACC_NUM=0 $(FLAGS)

isp0.o : isp.c
	clang -D ACC_NUM=0 $(FLAGS)

#%.o : %.c
#	clang $(FLAGS)

%.bc : %.o
	opt -O1 -mem2reg -simplifycfg -loops -loop-unroll -o $@ $<

%.ll : %.bc
	llvm-dis -o $@ $<

clean:
	rm -f *.ll
