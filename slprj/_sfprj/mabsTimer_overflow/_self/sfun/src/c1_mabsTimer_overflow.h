#ifndef __c1_mabsTimer_overflow_h__
#define __c1_mabsTimer_overflow_h__

/* Include files */
#include "sfc_sf.h"
#include "sfc_mex.h"
#include "rtwtypes.h"
#include "rtw_capi.h"
#include "rtw_modelmap.h"

/* Type Definitions */
typedef struct {
  SimStruct *S;
  void *c1_testPointAddrMap[3];
  uint32_T c1_elapsedTicks;
  uint32_T c1_presentTicks;
  uint32_T c1_previousTicks;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  uint8_T c1_is_active_c1_mabsTimer_overflow;
  uint8_T c1_is_c1_mabsTimer_overflow;
  uint8_T c1_temporalCounter_i1;
  uint8_T c1_tp_A;
  uint8_T c1_tp_B;
  uint8_T c1_tp_C;
  ChartInfoStruct chartInfo;
  rtwCAPI_ModelMappingInfo c1_testPointMappingInfo;
} SFc1_mabsTimer_overflowInstanceStruct;

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
const mxArray *sf_c1_mabsTimer_overflow_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c1_mabsTimer_overflow_get_check_sum(mxArray *plhs[]);
extern void c1_mabsTimer_overflow_method_dispatcher(SimStruct *S, int_T method,
  void *data);

#endif
