#ifndef __DEFINES_H__
#define __DEFINES_H__

#define IMG_HEIGHT          128
#define IMG_WIDTH           128
#define NUM_PIXELS          (IMG_HEIGHT * IMG_WIDTH)
#define DIM(x,y)            (((x) * IMG_WIDTH) + (y))
#define KERN_DIM(x,y)       (((x)*kern_width) + (y))
#define ISP_IN_DIM(x,y)     (img_width + 3 + ((x)*(2+img_width)) + (y))
#define ISP_OUT_DIM(x,y,c)  (3*((x)*img_width + (y)) + (c))

#define PI      3.141592653589793238462643
#define WEAK    75
#define STRONG  255

enum operation {
    ADD = 0, SUB,
    MUL, DIV,
    SQR, SQRT,
    ATAN2, TANH,
    SIGMOID,
    NUM_OPS
};

// Device flags
#define DEV_INIT    0x01
#define DEV_INTR    0x04

/* The following addresses represent the initial SPM partitioning for each
 * accelerator instance. For some of them, it may change over time.
 */

// Canny non-max (1/1)
#define CNM0_BASE           0x21000000
#define CNM0_DMA            0x21000007  // 21 B
#define CNM0_HYPO_SPM       0x21000020  // 64 KB
#define CNM0_THETA_SPM      0x21010020  // 64 KB
#define CNM0_OUTPUT0_SPM    0x21020020  // 64 KB
#define CNM0_OUTPUT1_SPM    0x21030020  // 64 KB
#define CNM0_MMR            0x21040027

// Convolution (1/2)
#define CONVOLUTION0_BASE           0x22000000
#define CONVOLUTION0_DMA            0x22000007  // 21 B
#define CONVOLUTION0_INPUT_SPM      0x22000020  // 64 KB
#define CONVOLUTION0_OUTPUT0_SPM    0x22010020  // 64 KB
#define CONVOLUTION0_OUTPUT1_SPM    0x22020020  // 64 KB
#define CONVOLUTION0_KERNEL_SPM     0x22030020  // 100 B
#define CONVOLUTION0_MMR            0x22030097

// Convolution (2/2)
#define CONVOLUTION1_BASE           0x22100000
#define CONVOLUTION1_DMA            0x22100007  // 21 B
#define CONVOLUTION1_INPUT_SPM      0x22100020  // 64 KB
#define CONVOLUTION1_OUTPUT0_SPM    0x22110020  // 64 KB
#define CONVOLUTION1_OUTPUT1_SPM    0x22120020  // 64 KB
#define CONVOLUTION1_KERNEL_SPM     0x22130020  // 100 B
#define CONVOLUTION1_MMR            0x22130097

// Edge tracking (1/1)
#define EDGE_TRACKING0_BASE                 0x23000000
#define EDGE_TRACKING0_DMA                  0x23000007  // 21 B
#define EDGE_TRACKING0_INPUT_SPM            0x23000020  // 64 KB
#define EDGE_TRACKING0_OUTPUT0_SPM          0x23010020  // 16 KB
#define EDGE_TRACKING0_OUTPUT1_SPM          0x23014020  // 16 KB
#define EDGE_TRACKING0_LOCAL_MAXIMA_SPM     0x23018020  // 128 B
#define EDGE_TRACKING0_MMR                  0x230180a7

// Elem-matrix (1/4)
#define ELEM_MATRIX0_BASE           0x24000000
#define ELEM_MATRIX0_DMA            0x24000007  // 21 B
#define ELEM_MATRIX0_ARG1_SPM       0x24000020  // 64 KB
#define ELEM_MATRIX0_ARG2_SPM       0x24010020  // 64 KB
#define ELEM_MATRIX0_OUTPUT0_SPM    0x24020020  // 64 KB
#define ELEM_MATRIX0_OUTPUT1_SPM    0x24030020  // 64 KB
#define ELEM_MATRIX0_MMR            0x24040027

// Elem-matrix (2/4)
#define ELEM_MATRIX1_BASE           0x24100000
#define ELEM_MATRIX1_DMA            0x24100007  // 21 B
#define ELEM_MATRIX1_ARG1_SPM       0x24100020  // 64 KB
#define ELEM_MATRIX1_ARG2_SPM       0x24110020  // 64 KB
#define ELEM_MATRIX1_OUTPUT0_SPM    0x24120020  // 64 KB
#define ELEM_MATRIX1_OUTPUT1_SPM    0x24130020  // 64 KB
#define ELEM_MATRIX1_MMR            0x24140027

// Elem-matrix (3/4)
#define ELEM_MATRIX2_BASE           0x24200000
#define ELEM_MATRIX2_DMA            0x24200007  // 21 B
#define ELEM_MATRIX2_ARG1_SPM       0x24200020  // 64 KB
#define ELEM_MATRIX2_ARG2_SPM       0x24210020  // 64 KB
#define ELEM_MATRIX2_OUTPUT0_SPM    0x24220020  // 64 KB
#define ELEM_MATRIX2_OUTPUT1_SPM    0x24230020  // 64 KB
#define ELEM_MATRIX2_MMR            0x24240027

// Elem-matrix (4/4)
#define ELEM_MATRIX3_BASE           0x24300000
#define ELEM_MATRIX3_DMA            0x24300007  // 21 B
#define ELEM_MATRIX3_ARG1_SPM       0x24300020  // 64 KB
#define ELEM_MATRIX3_ARG2_SPM       0x24310020  // 64 KB
#define ELEM_MATRIX3_OUTPUT0_SPM    0x24320020  // 64 KB
#define ELEM_MATRIX3_OUTPUT1_SPM    0x24330020  // 64 KB
#define ELEM_MATRIX3_MMR            0x24340027

// Grayscale (1/1)
#define GRAYSCALE0_BASE         0x25000000
#define GRAYSCALE0_DMA          0x25000007  // 21 B
#define GRAYSCALE0_INPUT_SPM    0x25000020  // 48 KB
#define GRAYSCALE0_OUTPUT0_SPM  0x2500c020  // 64 KB
#define GRAYSCALE0_OUTPUT1_SPM  0x2501c020  // 64 KB
#define GRAYSCALE0_MMR          0x2502c027

// Harris non-max (1/1)
#define HNM0_BASE           0x26000000
#define HNM0_DMA            0x26000007  // 21 B
#define HNM0_INPUT_SPM      0x26000020  // 64 KB
#define HNM0_OUTPUT0_SPM    0x26010020  // 64 KB
#define HNM0_OUTPUT1_SPM    0x26020020  // 64 KB
#define HNM0_MMR            0x26030027

// ISP (1/1)
#define ISP0_BASE           0x27000000
#define ISP0_DMA            0x27000007  // 21 B
#define ISP0_INPUT_SPM      0x27000020  // 16900 B
#define ISP0_OUTPUT0_SPM    0x27004224  // 48 KB
#define ISP0_OUTPUT1_SPM    0x27010224  // 48 KB
#define ISP0_MMR            0x2701c237

// Memory management
void *get_memory_aligned(uint32_t, uint32_t);
void *get_memory(uint32_t);

// all sizes are in bytes
#define CACHELINE_SIZE 64
#define L1D_CACHE_SIZE 32768
#define L1D_CACHE_SETS (L1D_CACHE_SIZE / CACHELINE_SIZE)

#endif
