#include "../../common/m5ops.h"
#include "runtime.h"

inline void canny_non_max_driver(
        int device_id, uint32_t img_height, uint32_t img_width,
        uint32_t hypo_addr, uint32_t theta_addr, uint32_t output_addr,
        uint32_t output_spm_addr, volatile acc_state_t *acc) {
#ifdef TIME
    m5_timer_start(4);
#endif
    // accelerator offsets
    const uint32_t offset_dma = CNM0_DMA - CNM0_BASE;
    const uint32_t offset_hypo_spm = CNM0_HYPO_SPM - CNM0_BASE;
    const uint32_t offset_theta_spm = CNM0_THETA_SPM - CNM0_BASE;
    const uint32_t offset_mmr = CNM0_MMR - CNM0_BASE;

    // accelerator addresses
    const uint32_t base_addr = CNM0_BASE + (device_id << 20);
    const uint32_t dma_addr = base_addr + offset_dma;
    const uint32_t hypo_spm_addr = base_addr + offset_hypo_spm;
    const uint32_t theta_spm_addr = base_addr + offset_theta_spm;
    const uint32_t mmr_addr = base_addr + offset_mmr;

    uint32_t data_size = img_height * img_width * 4;

    // DMA flags
    volatile uint8_t  *DmaFlags   = (uint8_t*)  (dma_addr);
    volatile uint64_t *DmaRdAddr  = (uint64_t*) (dma_addr + 1);
    volatile uint64_t *DmaWrAddr  = (uint64_t*) (dma_addr + 9);
    volatile uint32_t *DmaCopyLen = (uint32_t*) (dma_addr + 17);

    // Accelerator flags
    volatile uint8_t  *CNMFlags         = (uint8_t*)  (mmr_addr);
    volatile uint32_t *CNMImgHeight     = (uint32_t*) (mmr_addr + 1);
    volatile uint32_t *CNMImgWidth      = (uint32_t*) (mmr_addr + 9);
    volatile uint32_t *CNMOutputSpmAddr = (uint32_t*) (mmr_addr + 17);

#ifdef TIME
    m5_timer_stop(4);
    m5_timer_start(5);
#endif

    if (acc->status == ACC_STATUS_IDLE) {
        // DMA transfer for hypotenuse
        *DmaRdAddr  = hypo_addr;
        *DmaWrAddr  = hypo_spm_addr;
        *DmaCopyLen = data_size;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_ARG1;
    }
    else if (acc->status == ACC_STATUS_DMA_ARG1) {
        // DMA transfer for theta
        *DmaRdAddr  = theta_addr;
        *DmaWrAddr  = theta_spm_addr;
        *DmaCopyLen = data_size;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_ARG2;
    }
    else if (acc->status == ACC_STATUS_DMA_ARG2) {
        *CNMImgHeight = img_height;
        *CNMImgWidth = img_width;
        *CNMOutputSpmAddr = output_spm_addr;
        *CNMFlags = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_RUNNING;
    }
    else if (acc->status == ACC_STATUS_RUNNING) {
        // DMA transfer for output
        *DmaRdAddr  = output_spm_addr;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = data_size;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_OUT;
    }

#ifdef TIME
    m5_timer_stop(5);
#endif
}

inline void convolution_driver(
        int device_id, uint32_t img_height, uint32_t img_width,
        uint32_t input_addr, uint32_t kernel_addr, uint32_t kern_height,
        uint32_t kern_width, uint8_t mod_and_floor, uint32_t output_addr,
        uint32_t input_spm_addr, uint32_t output_spm_addr,
        volatile acc_state_t *acc) {
    // accelerator offsets
    const uint32_t offset_dma = CONVOLUTION0_DMA - CONVOLUTION0_BASE;
    const uint32_t offset_kernel_spm =
        CONVOLUTION0_KERNEL_SPM - CONVOLUTION0_BASE;
    const uint32_t offset_mmr = CONVOLUTION0_MMR - CONVOLUTION0_BASE;

    // accelerator addresses
    const uint32_t base_addr = CONVOLUTION0_BASE + (device_id << 20);
    const uint32_t dma_addr = base_addr + offset_dma;
    const uint32_t kernel_spm_addr = base_addr + offset_kernel_spm;
    const uint32_t mmr_addr = base_addr + offset_mmr;

    uint32_t data_size = img_height * img_width * 4;

    // DMA flags
    volatile uint8_t  *DmaFlags   = (uint8_t*)  (dma_addr);
    volatile uint64_t *DmaRdAddr  = (uint64_t*) (dma_addr+1);
    volatile uint64_t *DmaWrAddr  = (uint64_t*) (dma_addr+9);
    volatile uint32_t *DmaCopyLen = (uint32_t*) (dma_addr+17);

    // Accelerator flags
    volatile uint8_t  *ConvolutionFlags         = (uint8_t*)  (mmr_addr);
    volatile uint32_t *ConvolutionImgHeight     = (uint32_t*) (mmr_addr + 1);
    volatile uint32_t *ConvolutionImgWidth      = (uint32_t*) (mmr_addr + 9);
    volatile uint32_t *ConvolutionKernHeight    = (uint32_t*) (mmr_addr + 17);
    volatile uint32_t *ConvolutionKernWidth     = (uint32_t*) (mmr_addr + 25);
    volatile uint8_t  *ConvolutionModFloor      = (uint8_t*)  (mmr_addr + 33);
    volatile uint32_t *ConvolutionInputSpmAddr  = (uint32_t*) (mmr_addr + 41);
    volatile uint32_t *ConvolutionOutputSpmAddr = (uint32_t*) (mmr_addr + 49);

    if (acc->status == ACC_STATUS_IDLE) {
        acc->status = ACC_STATUS_DMA_ARG1;

        // DMA transfer for input data
        if (input_addr != 0) {
            *DmaRdAddr  = input_addr;
            *DmaWrAddr  = input_spm_addr;
            *DmaCopyLen = data_size;
            *DmaFlags   = DEV_INIT;

#ifdef TIME
            m5_timer_stop(0);
            m5_timer_start(0);
#endif

            // Remain in this state only if we actually perform a DMA transfer
            return;
        }
    }

    if (acc->status == ACC_STATUS_DMA_ARG1) {
        // DMA transfer for kernel
        *DmaRdAddr  = kernel_addr;
        *DmaWrAddr  = kernel_spm_addr;
        *DmaCopyLen = kern_height * kern_width * 4;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_ARG2;
    }
    else if (acc->status == ACC_STATUS_DMA_ARG2) {
        // Configure the accelerator
        *ConvolutionImgHeight = img_height;
        *ConvolutionImgWidth = img_width;
        *ConvolutionKernHeight = kern_height;
        *ConvolutionKernWidth = kern_width;
        *ConvolutionModFloor = mod_and_floor;
        *ConvolutionInputSpmAddr = input_spm_addr;
        *ConvolutionOutputSpmAddr = output_spm_addr;
        *ConvolutionFlags = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_RUNNING;
    }
    else if (acc->status == ACC_STATUS_RUNNING) {
        // DMA transfer for output data
        *DmaRdAddr  = output_spm_addr;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = img_height * img_width * 4;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_OUT;
    }
}

inline void edge_tracking_driver(
        int device_id, uint32_t img_height, uint32_t img_width,
        uint32_t input_addr, float thr_weak_ratio, float thr_strong_ratio,
        uint32_t output_addr, uint32_t output_spm_addr,
        volatile acc_state_t *acc) {
    // accelerator offsets
    const uint32_t offset_dma = EDGE_TRACKING0_DMA - EDGE_TRACKING0_BASE;
    const uint32_t offset_input_spm =
        EDGE_TRACKING0_INPUT_SPM - EDGE_TRACKING0_BASE;
    const uint32_t offset_mmr = EDGE_TRACKING0_MMR - EDGE_TRACKING0_BASE;

    // accelerator addresses
    const uint32_t base_addr = EDGE_TRACKING0_BASE + (device_id << 20);
    const uint32_t dma_addr = base_addr + offset_dma;
    const uint32_t input_spm_addr = base_addr + offset_input_spm;
    const uint32_t mmr_addr = base_addr + offset_mmr;

    uint32_t num_elems = img_height * img_width;

    // DMA flags
    volatile uint8_t  *DmaFlags   = (uint8_t*)  (dma_addr);
    volatile uint64_t *DmaRdAddr  = (uint64_t*) (dma_addr + 1);
    volatile uint64_t *DmaWrAddr  = (uint64_t*) (dma_addr + 9);
    volatile uint32_t *DmaCopyLen = (uint32_t*) (dma_addr + 17);

    // Accelerator flags
    volatile uint8_t  *EdgeTrackingFlags         = (uint8_t*)  (mmr_addr);
    volatile uint32_t *EdgeTrackingImgHeight     = (uint32_t*) (mmr_addr + 1);
    volatile uint32_t *EdgeTrackingImgWidth      = (uint32_t*) (mmr_addr + 9);
    volatile float    *EdgeTrackingWeak          = (float*)    (mmr_addr + 17);
    volatile float    *EdgeTrackingStrong        = (float*)    (mmr_addr + 25);
    volatile uint32_t *EdgeTrackingOutputSpmAddr = (uint32_t*) (mmr_addr + 33);

    if (acc->status == ACC_STATUS_IDLE) {
        // DMA transfer for input data
        *DmaRdAddr  = input_addr;
        *DmaWrAddr  = input_spm_addr;
        *DmaCopyLen = num_elems * 4;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_ARG1;
    }
    else if (acc->status == ACC_STATUS_DMA_ARG1) {
        // Configure the accelerator
        *EdgeTrackingImgHeight = img_height;
        *EdgeTrackingImgWidth = img_width;
        *EdgeTrackingWeak = thr_weak_ratio;
        *EdgeTrackingStrong = thr_strong_ratio;
        *EdgeTrackingOutputSpmAddr = output_spm_addr;
        *EdgeTrackingFlags = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_RUNNING;
    }
    else if (acc->status == ACC_STATUS_RUNNING) {
        // DMA transfer for output data
        *DmaRdAddr  = output_spm_addr;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = num_elems;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_OUT;
    }
}

inline void elem_matrix_driver(
        int device_id, uint32_t img_height, uint32_t img_width,
        uint32_t arg1_addr, uint32_t arg2_addr, uint8_t is_arg2_scalar,
        uint8_t op, uint8_t do_one_minus, uint32_t output_addr,
        uint32_t arg1_spm_addr, uint32_t arg2_spm_addr,
        uint32_t output_spm_addr, volatile acc_state_t *acc) {
    // accelerator offsets
    const uint32_t offset_dma = ELEM_MATRIX0_DMA - ELEM_MATRIX0_BASE;
    const uint32_t offset_mmr = ELEM_MATRIX0_MMR - ELEM_MATRIX0_BASE;

    // accelerator addresses
    const uint32_t base_addr = ELEM_MATRIX0_BASE + (device_id << 20);
    const uint32_t dma_addr = base_addr + offset_dma;
    const uint32_t mmr_addr = base_addr + offset_mmr;

    uint32_t data_size = img_height * img_width * 4;

    // DMA flags
    volatile uint8_t  *DmaFlags   = (uint8_t*)  (dma_addr);
    volatile uint64_t *DmaRdAddr  = (uint64_t*) (dma_addr + 1);
    volatile uint64_t *DmaWrAddr  = (uint64_t*) (dma_addr + 9);
    volatile uint32_t *DmaCopyLen = (uint32_t*) (dma_addr + 17);

    // Accelerator flags
    volatile uint8_t  *EMFlags         = (uint8_t*)  (mmr_addr);
    volatile uint32_t *EMNumElems      = (uint32_t*) (mmr_addr + 1);
    volatile uint8_t  *EMOp            = (uint8_t*)  (mmr_addr + 9);
    volatile uint8_t  *EMArg2Scalar    = (uint8_t*)  (mmr_addr + 17);
    volatile uint8_t  *EMOneMinus      = (uint8_t*)  (mmr_addr + 25);
    volatile uint32_t *EMArg1SpmAddr   = (uint32_t*) (mmr_addr + 33);
    volatile uint32_t *EMArg2SpmAddr   = (uint32_t*) (mmr_addr + 41);
    volatile uint32_t *EMOutputSpmAddr = (uint32_t*) (mmr_addr + 49);

    if (acc->status == ACC_STATUS_IDLE) {
        acc->status = ACC_STATUS_DMA_ARG1;

        // DMA transfer for arg1
        if (arg1_addr != 0) {
            *DmaRdAddr  = arg1_addr;
            *DmaWrAddr  = arg1_spm_addr;
            *DmaCopyLen = data_size;
            *DmaFlags   = DEV_INIT;

#ifdef TIME
            m5_timer_stop(0);
            m5_timer_start(0);
#endif

            // Remain in this state only if we actually perform a DMA transfer
            return;
        }
    }

    if (acc->status == ACC_STATUS_DMA_ARG1) {
        acc->status = ACC_STATUS_DMA_ARG2;

        // DMA transfer for arg2
        if (arg2_addr != 0) {
            *DmaRdAddr = arg2_addr;
            *DmaWrAddr = arg2_spm_addr;

            if (is_arg2_scalar) {
                *DmaCopyLen = 4;
            } else {
                *DmaCopyLen = data_size;
            }

            *DmaFlags = DEV_INIT;

#ifdef TIME
            m5_timer_stop(0);
            m5_timer_start(0);
#endif

            // Remain in this state only if we actually perform a DMA transfer
            return;
        }
    }

    if (acc->status == ACC_STATUS_DMA_ARG2) {
        // Configure the accelerator
        *EMNumElems = img_height * img_width;
        *EMOp = op;
        *EMArg2Scalar = is_arg2_scalar;
        *EMOneMinus = do_one_minus;
        *EMArg1SpmAddr = arg1_spm_addr;
        *EMArg2SpmAddr = arg2_spm_addr;
        *EMOutputSpmAddr = output_spm_addr;
        *EMFlags = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_RUNNING;
    }
    else if (acc->status == ACC_STATUS_RUNNING) {
        // DMA transfer for output
        *DmaRdAddr  = output_spm_addr;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = data_size;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_OUT;
    }
}

inline void grayscale_driver(
        int device_id, uint32_t img_height, uint32_t img_width,
        uint32_t input_addr, uint32_t output_addr, uint32_t output_spm_addr,
        volatile acc_state_t *acc) {
    // accelerator offsets
    const uint32_t offset_dma = GRAYSCALE0_DMA - GRAYSCALE0_BASE;
    const uint32_t offset_input_spm = GRAYSCALE0_INPUT_SPM - GRAYSCALE0_BASE;
    const uint32_t offset_mmr = GRAYSCALE0_MMR - GRAYSCALE0_BASE;

    // accelerator addresses
    const uint32_t base_addr = GRAYSCALE0_BASE + (device_id << 20);
    const uint32_t dma_addr = base_addr + offset_dma;
    const uint32_t input_spm_addr = base_addr + offset_input_spm;
    const uint32_t mmr_addr = base_addr + offset_mmr;

    uint32_t num_elems = img_height * img_width;

    // DMA flags
    volatile uint8_t  *DmaFlags   = (uint8_t*)  (dma_addr);
    volatile uint64_t *DmaRdAddr  = (uint64_t*) (dma_addr + 1);
    volatile uint64_t *DmaWrAddr  = (uint64_t*) (dma_addr + 9);
    volatile uint32_t *DmaCopyLen = (uint32_t*) (dma_addr + 17);

    // Accelerator flags
    volatile uint8_t  *GrayscaleFlags         = (uint8_t*)  (mmr_addr);
    volatile uint32_t *GrayscaleNumElems      = (uint32_t*) (mmr_addr + 1);
    volatile uint32_t *GrayscaleOutputSpmAddr = (uint32_t*) (mmr_addr + 9);

    if (acc->status == ACC_STATUS_IDLE) {
        // DMA transfer for input data
        *DmaRdAddr  = input_addr;
        *DmaWrAddr  = input_spm_addr;
        *DmaCopyLen = num_elems * 3;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_ARG1;
    }
    else if (acc->status == ACC_STATUS_DMA_ARG1) {
        // Configure the accelerator
        *GrayscaleNumElems = num_elems;
        *GrayscaleOutputSpmAddr = output_spm_addr;
        *GrayscaleFlags = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_RUNNING;
    }
    else if (acc->status == ACC_STATUS_RUNNING) {
        // DMA transfer for output data
        *DmaRdAddr  = output_spm_addr;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = num_elems * 4;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_OUT;
    }
}

inline void harris_non_max_driver(
        int device_id, uint32_t img_height, uint32_t img_width,
        uint32_t input_addr, uint32_t output_addr, uint32_t output_spm_addr,
        volatile acc_state_t *acc) {
    // accelerator offsets
    const uint32_t offset_dma = HNM0_DMA - HNM0_BASE;
    const uint32_t offset_input_spm = HNM0_INPUT_SPM - HNM0_BASE;
    const uint32_t offset_mmr = HNM0_MMR - HNM0_BASE;

    // accelerator addresses
    const uint32_t base_addr = HNM0_BASE + (device_id << 20);
    const uint32_t dma_addr = base_addr + offset_dma;
    const uint32_t input_spm_addr = base_addr + offset_input_spm;
    const uint32_t mmr_addr = base_addr + offset_mmr;

    // DMA flags
    volatile uint8_t  *DmaFlags   = (uint8_t*)  (dma_addr);
    volatile uint64_t *DmaRdAddr  = (uint64_t*) (dma_addr + 1);
    volatile uint64_t *DmaWrAddr  = (uint64_t*) (dma_addr + 9);
    volatile uint32_t *DmaCopyLen = (uint32_t*) (dma_addr + 17);

    // Accelerator flags
    volatile uint8_t  *HNMFlags         = (uint8_t*)  (mmr_addr);
    volatile uint32_t *HNMImgHeight     = (uint32_t*) (mmr_addr + 1);
    volatile uint32_t *HNMImgWidth      = (uint32_t*) (mmr_addr + 9);
    volatile uint32_t *HNMOutputSpmAddr = (uint32_t*) (mmr_addr + 17);

    if (acc->status == ACC_STATUS_IDLE) {
        // DMA transfer for input data
        *DmaRdAddr  = input_addr;
        *DmaWrAddr  = input_spm_addr;
        *DmaCopyLen = img_height * img_width * 4;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_ARG1;
    }
    else if (acc->status == ACC_STATUS_DMA_ARG1) {
        // Configure the accelerator
        *HNMImgHeight = img_height;
        *HNMImgWidth = img_width;
        *HNMOutputSpmAddr = output_spm_addr;
        *HNMFlags = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_RUNNING;
    }
    else if (acc->status == ACC_STATUS_RUNNING) {
        // DMA transfer for output data
        *DmaRdAddr  = output_spm_addr;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = img_height * img_width;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_OUT;
    }
}

inline void isp_driver(int device_id,
        uint32_t img_height, uint32_t img_width, uint32_t input_addr,
        uint32_t output_addr, uint32_t output_spm_addr,
        volatile acc_state_t *acc) {
    // accelerator offsets
    const uint32_t offset_dma = ISP0_DMA - ISP0_BASE;
    const uint32_t offset_input_spm = ISP0_INPUT_SPM - ISP0_BASE;
    const uint32_t offset_mmr = ISP0_MMR - ISP0_BASE;

    // accelerator addresses
    const uint32_t base_addr = ISP0_BASE + (device_id << 20);
    const uint32_t dma_addr = base_addr + offset_dma;
    const uint32_t input_spm_addr = base_addr + offset_input_spm;
    const uint32_t mmr_addr = base_addr + offset_mmr;

    // DMA flags
    volatile uint8_t  *DmaFlags   = (uint8_t*)  (dma_addr);
    volatile uint64_t *DmaRdAddr  = (uint64_t*) (dma_addr + 1);
    volatile uint64_t *DmaWrAddr  = (uint64_t*) (dma_addr + 9);
    volatile uint32_t *DmaCopyLen = (uint32_t*) (dma_addr + 17);

    // Accelerator flags
    volatile uint8_t  *IspFlags         = (uint8_t*)  (mmr_addr);
    volatile uint32_t *IspImgHeight     = (uint32_t*) (mmr_addr + 1);
    volatile uint32_t *IspImgWidth      = (uint32_t*) (mmr_addr + 9);
    volatile uint32_t *IspOutputSpmAddr = (uint32_t*) (mmr_addr + 17);

    if (acc->status == ACC_STATUS_IDLE) {
        // DMA transfer for input data
        *DmaRdAddr  = input_addr;
        *DmaWrAddr  = input_spm_addr;
        *DmaCopyLen = (img_height + 2) * (img_width + 2);
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_ARG1;
    }
    else if (acc->status == ACC_STATUS_DMA_ARG1) {
        // Configure the accelerator
        *IspImgHeight = img_height;
        *IspImgWidth = img_width;
        *IspOutputSpmAddr = output_spm_addr;
        *IspFlags = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_RUNNING;
    }
    else if (acc->status == ACC_STATUS_RUNNING) {
        // DMA transfer for output data
        *DmaRdAddr  = output_spm_addr;
        *DmaWrAddr  = output_addr;
        *DmaCopyLen = img_height * img_width * 3;
        *DmaFlags   = DEV_INIT;

#ifdef TIME
        m5_timer_stop(0);
        m5_timer_start(0);
#endif

        acc->status = ACC_STATUS_DMA_OUT;
    }
}
