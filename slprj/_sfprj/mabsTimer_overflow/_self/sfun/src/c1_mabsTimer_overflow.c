/* Include files */

#include "mabsTimer_overflow_sfun.h"
#include "c1_mabsTimer_overflow.h"
#include "mwmathutil.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance.chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance.instanceNumber)
#include "mabsTimer_overflow_sfun_debug_macros.h"

/* Type Definitions */

/* Named Constants */
#define c1_IN_NO_ACTIVE_CHILD          (0)
#define c1_IN_A                        (1)
#define c1_IN_B                        (2)
#define c1_IN_C                        (3)

/* Variable Declarations */

/* Variable Definitions */
static SFc1_mabsTimer_overflowInstanceStruct chartInstance;

/* Function Declarations */
static void initialize_c1_mabsTimer_overflow(void);
static void initialize_params_c1_mabsTimer_overflow(void);
static void enable_c1_mabsTimer_overflow(void);
static void disable_c1_mabsTimer_overflow(void);
static void update_debugger_state_c1_mabsTimer_overflow(void);
static const mxArray *get_sim_state_c1_mabsTimer_overflow(void);
static void set_sim_state_c1_mabsTimer_overflow(const mxArray *c1_st);
static void finalize_c1_mabsTimer_overflow(void);
static void sf_c1_mabsTimer_overflow(void);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber);
static uint8_T c1_emlrt_marshallIn(const mxArray *c1_temporary, char *c1_name);
static boolean_T c1_b_emlrt_marshallIn(const mxArray *c1_temporary, char
  *c1_name);
static const mxArray *c1_emlrt_marshallOut(uint8_T c1_u);
static const mxArray *c1_b_emlrt_marshallOut(boolean_T c1_u);
static void init_test_point_addr_map(void);
static void **get_test_point_address_map(void);
static rtwCAPI_ModelMappingInfo *get_test_point_mapping_info(void);
static void init_dsm_address_info(void);

/* Function Definitions */
static void initialize_c1_mabsTimer_overflow(void)
{
  boolean_T *c1_B;
  boolean_T *c1_C;
  c1_C = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 2);
  c1_B = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 1);
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
  chartInstance.c1_tp_A = 0U;
  chartInstance.c1_tp_B = 0U;
  chartInstance.c1_tp_C = 0U;
  chartInstance.c1_is_active_c1_mabsTimer_overflow = 0U;
  chartInstance.c1_is_c1_mabsTimer_overflow = 0U;
  if (!(cdrGetOutputPortReusable(chartInstance.S, 1) != 0)) {
    *c1_B = false;
  }

  if (!(cdrGetOutputPortReusable(chartInstance.S, 2) != 0)) {
    *c1_C = false;
  }

  chartInstance.c1_presentTicks = 0U;
  chartInstance.c1_elapsedTicks = 0U;
  chartInstance.c1_previousTicks = 0U;
}

static void initialize_params_c1_mabsTimer_overflow(void)
{
}

static void enable_c1_mabsTimer_overflow(void)
{
  real_T c1_d0;
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
  c1_d0 = muDoubleScalarFloor(_sfTime_ / 0.1 + 0.5);
  chartInstance.c1_presentTicks = (uint32_T)c1_d0;
  chartInstance.c1_previousTicks = chartInstance.c1_presentTicks;
}

static void disable_c1_mabsTimer_overflow(void)
{
  real_T c1_d1;
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
  c1_d1 = muDoubleScalarFloor(_sfTime_ / 0.1 + 0.5);
  chartInstance.c1_presentTicks = (uint32_T)c1_d1;
  chartInstance.c1_elapsedTicks = chartInstance.c1_presentTicks -
    chartInstance.c1_previousTicks;
  chartInstance.c1_previousTicks = chartInstance.c1_presentTicks;
  if ((uint32_T)chartInstance.c1_temporalCounter_i1 +
      chartInstance.c1_elapsedTicks <= 127U) {
    chartInstance.c1_temporalCounter_i1 = (uint8_T)((uint32_T)
      chartInstance.c1_temporalCounter_i1 + chartInstance.c1_elapsedTicks);
  } else {
    chartInstance.c1_temporalCounter_i1 = 127U;
  }
}

static void update_debugger_state_c1_mabsTimer_overflow(void)
{
  uint32_T c1_prevAniVal;
  c1_prevAniVal = sf_debug_get_animation();
  sf_debug_set_animation(0U);
  if (chartInstance.c1_is_active_c1_mabsTimer_overflow == 1) {
    _SFD_CC_CALL(CHART_ENTER_ENTRY_FUNCTION_TAG,0);
  }

  if (chartInstance.c1_is_c1_mabsTimer_overflow == c1_IN_A) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG,0);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG,0);
  }

  if (chartInstance.c1_is_c1_mabsTimer_overflow == c1_IN_B) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG,1);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG,1);
  }

  if (chartInstance.c1_is_c1_mabsTimer_overflow == c1_IN_C) {
    _SFD_CS_CALL(STATE_ACTIVE_TAG,2);
  } else {
    _SFD_CS_CALL(STATE_INACTIVE_TAG,2);
  }

  sf_debug_set_animation(c1_prevAniVal);
  _SFD_ANIMATE();
}

static const mxArray *get_sim_state_c1_mabsTimer_overflow(void)
{
  const mxArray *c1_st = NULL;
  const mxArray *c1_y = NULL;
  boolean_T *c1_B;
  boolean_T *c1_C;
  c1_C = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 2);
  c1_B = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 1);
  c1_st = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_createcellarray(8));
  sf_mex_setcell(c1_y, 0, c1_emlrt_marshallOut(chartInstance.c1_tp_A));
  sf_mex_setcell(c1_y, 1, c1_emlrt_marshallOut(chartInstance.c1_tp_B));
  sf_mex_setcell(c1_y, 2, c1_emlrt_marshallOut(chartInstance.c1_tp_C));
  sf_mex_setcell(c1_y, 3, c1_emlrt_marshallOut
                 (chartInstance.c1_is_active_c1_mabsTimer_overflow));
  sf_mex_setcell(c1_y, 4, c1_emlrt_marshallOut
                 (chartInstance.c1_is_c1_mabsTimer_overflow));
  sf_mex_setcell(c1_y, 5, c1_b_emlrt_marshallOut(*c1_B));
  sf_mex_setcell(c1_y, 6, c1_b_emlrt_marshallOut(*c1_C));
  sf_mex_setcell(c1_y, 7, c1_emlrt_marshallOut
                 (chartInstance.c1_temporalCounter_i1));
  sf_mex_assign(&c1_st, c1_y);
  return c1_st;
}

static void set_sim_state_c1_mabsTimer_overflow(const mxArray *c1_st)
{
  const mxArray *c1_u;
  boolean_T *c1_B;
  boolean_T *c1_C;
  c1_C = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 2);
  c1_B = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 1);
  c1_u = sf_mex_dup(c1_st);
  chartInstance.c1_tp_A = c1_emlrt_marshallIn(sf_mex_dup(sf_mex_getcell(c1_u, 0)),
    "tp_A");
  chartInstance.c1_tp_B = c1_emlrt_marshallIn(sf_mex_dup(sf_mex_getcell(c1_u, 1)),
    "tp_B");
  chartInstance.c1_tp_C = c1_emlrt_marshallIn(sf_mex_dup(sf_mex_getcell(c1_u, 2)),
    "tp_C");
  chartInstance.c1_is_active_c1_mabsTimer_overflow = c1_emlrt_marshallIn
    (sf_mex_dup(sf_mex_getcell(c1_u, 3)),
     "is_active_c1_mabsTimer_overflow");
  chartInstance.c1_is_c1_mabsTimer_overflow = c1_emlrt_marshallIn(sf_mex_dup
    (sf_mex_getcell(c1_u, 4)), "is_c1_mabsTimer_overflow");
  *c1_B = c1_b_emlrt_marshallIn(sf_mex_dup(sf_mex_getcell(c1_u, 5)), "B");
  *c1_C = c1_b_emlrt_marshallIn(sf_mex_dup(sf_mex_getcell(c1_u, 6)), "C");
  chartInstance.c1_temporalCounter_i1 = c1_emlrt_marshallIn(sf_mex_dup
    (sf_mex_getcell(c1_u, 7)), "temporalCounter_i1");
  sf_mex_destroy(&c1_u);
  update_debugger_state_c1_mabsTimer_overflow();
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_mabsTimer_overflow(void)
{
}

static void sf_c1_mabsTimer_overflow(void)
{
  real_T c1_d2;
  uint8_T c1_previousEvent;
  boolean_T *c1_B;
  boolean_T *c1_C;
  c1_C = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 2);
  c1_B = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 1);
  _sfTime_ = (real_T)ssGetT(chartInstance.S);
  c1_d2 = muDoubleScalarFloor(_sfTime_ / 0.1 + 0.5);
  chartInstance.c1_presentTicks = (uint32_T)c1_d2;
  chartInstance.c1_elapsedTicks = chartInstance.c1_presentTicks -
    chartInstance.c1_previousTicks;
  chartInstance.c1_previousTicks = chartInstance.c1_presentTicks;
  if ((uint32_T)chartInstance.c1_temporalCounter_i1 +
      chartInstance.c1_elapsedTicks <= 127U) {
    chartInstance.c1_temporalCounter_i1 = (uint8_T)((uint32_T)
      chartInstance.c1_temporalCounter_i1 + chartInstance.c1_elapsedTicks);
  } else {
    chartInstance.c1_temporalCounter_i1 = 127U;
  }

  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG,0);
  _SFD_DATA_RANGE_CHECK((real_T)*c1_B, 0U);
  _SFD_DATA_RANGE_CHECK((real_T)*c1_C, 1U);
  c1_previousEvent = _sfEvent_;
  _sfEvent_ = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG,0);
  if (chartInstance.c1_is_active_c1_mabsTimer_overflow == 0) {
    _SFD_CC_CALL(CHART_ENTER_ENTRY_FUNCTION_TAG,0);
    chartInstance.c1_is_active_c1_mabsTimer_overflow = 1U;
    _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG,0);
    _SFD_CT_CALL(TRANSITION_BEFORE_PROCESSING_TAG,0);
    _SFD_CT_CALL(TRANSITION_ACTIVE_TAG,0);
    chartInstance.c1_is_c1_mabsTimer_overflow = (uint8_T)c1_IN_A;
    _SFD_CS_CALL(STATE_ACTIVE_TAG,0);
    chartInstance.c1_temporalCounter_i1 = 0U;
    chartInstance.c1_tp_A = 1U;
  } else {
    switch (chartInstance.c1_is_c1_mabsTimer_overflow) {
     case c1_IN_A:
      CV_CHART_EVAL(0,0,1);
      _SFD_CS_CALL(STATE_ENTER_DURING_FUNCTION_TAG,0);
      _SFD_CT_CALL(TRANSITION_BEFORE_PROCESSING_TAG,1);
      if (CV_TRANSITION_EVAL(1U, (int32_T)_SFD_CCP_CALL(1,0,(((uint32_T)
              chartInstance.c1_temporalCounter_i1 >= 100U)!=0))) != 0) {
        _SFD_CT_CALL(TRANSITION_ACTIVE_TAG,1);
        _SFD_CS_CALL(STATE_ENTER_EXIT_FUNCTION_TAG,0);
        chartInstance.c1_tp_A = 0U;
        _SFD_CS_CALL(STATE_INACTIVE_TAG,0);
        _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG,0);
        chartInstance.c1_is_c1_mabsTimer_overflow = (uint8_T)c1_IN_B;
        _SFD_CS_CALL(STATE_ACTIVE_TAG,1);
        chartInstance.c1_temporalCounter_i1 = 0U;
        *c1_B = true;
        _SFD_DATA_RANGE_CHECK((real_T)*c1_B, 0U);
        chartInstance.c1_tp_B = 1U;
      }

      _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG,0);
      break;

     case c1_IN_B:
      CV_CHART_EVAL(0,0,2);
      _SFD_CS_CALL(STATE_ENTER_DURING_FUNCTION_TAG,1);
      _SFD_CT_CALL(TRANSITION_BEFORE_PROCESSING_TAG,2);
      if (CV_TRANSITION_EVAL(2U, (int32_T)_SFD_CCP_CALL(2,0,(((uint32_T)
              chartInstance.c1_temporalCounter_i1 >= 100U)!=0))) != 0) {
        _SFD_CT_CALL(TRANSITION_ACTIVE_TAG,2);
        _SFD_CS_CALL(STATE_ENTER_EXIT_FUNCTION_TAG,1);
        *c1_B = false;
        _SFD_DATA_RANGE_CHECK((real_T)*c1_B, 0U);
        chartInstance.c1_tp_B = 0U;
        _SFD_CS_CALL(STATE_INACTIVE_TAG,1);
        _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG,1);
        chartInstance.c1_is_c1_mabsTimer_overflow = (uint8_T)c1_IN_C;
        _SFD_CS_CALL(STATE_ACTIVE_TAG,2);
        *c1_C = true;
        _SFD_DATA_RANGE_CHECK((real_T)*c1_C, 1U);
        chartInstance.c1_tp_C = 1U;
      }

      _SFD_CS_CALL(EXIT_OUT_OF_FUNCTION_TAG,1);
      break;

     case c1_IN_C:
      CV_CHART_EVAL(0,0,3);
      break;

     default:
      CV_CHART_EVAL(0,0,0);
      chartInstance.c1_is_c1_mabsTimer_overflow = (uint8_T)c1_IN_NO_ACTIVE_CHILD;
      _SFD_CS_CALL(STATE_INACTIVE_TAG,0);
      break;
    }
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG,0);
  _sfEvent_ = c1_previousEvent;
  sf_debug_check_for_state_inconsistency(_mabsTimer_overflowMachineNumber_,
    chartInstance.chartNumber, chartInstance.instanceNumber);
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber)
{
}

const mxArray *sf_c1_mabsTimer_overflow_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  sf_mex_assign(&c1_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1));
  return c1_nameCaptureInfo;
}

static uint8_T c1_emlrt_marshallIn(const mxArray *c1_temporary, char *c1_name)
{
  uint8_T c1_y;
  uint8_T c1_u0;
  sf_mex_import(c1_name, sf_mex_dup(c1_temporary), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_y = c1_u0;
  sf_mex_destroy(&c1_temporary);
  return c1_y;
}

static boolean_T c1_b_emlrt_marshallIn(const mxArray *c1_temporary, char
  *c1_name)
{
  boolean_T c1_y;
  boolean_T c1_b0;
  sf_mex_import(c1_name, sf_mex_dup(c1_temporary), &c1_b0, 1, 11, 0U, 0, 0U, 0);
  c1_y = c1_b0;
  sf_mex_destroy(&c1_temporary);
  return c1_y;
}

static const mxArray *c1_emlrt_marshallOut(uint8_T c1_u)
{
  const mxArray *c1_y = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 3, 0U, 0U, 0U, 0));
  return c1_y;
}

static const mxArray *c1_b_emlrt_marshallOut(boolean_T c1_u)
{
  const mxArray *c1_y = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 11, 0U, 0U, 0U, 0));
  return c1_y;
}

static void init_test_point_addr_map(void)
{
  chartInstance.c1_testPointAddrMap[0] = &chartInstance.c1_tp_A;
  chartInstance.c1_testPointAddrMap[1] = &chartInstance.c1_tp_B;
  chartInstance.c1_testPointAddrMap[2] = &chartInstance.c1_tp_C;
}

static void **get_test_point_address_map(void)
{
  return &chartInstance.c1_testPointAddrMap[0];
}

static rtwCAPI_ModelMappingInfo *get_test_point_mapping_info(void)
{
  return &chartInstance.c1_testPointMappingInfo;
}

static void init_dsm_address_info(void)
{
}

/* SFunction Glue Code */
static void init_test_point_mapping_info(SimStruct *S);
void sf_c1_mabsTimer_overflow_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(1026544340U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3131319460U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1274543958U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3119175537U);
}

mxArray *sf_c1_mabsTimer_overflow_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,4,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateDoubleMatrix(4,1,mxREAL);
    double *pr = mxGetPr(mxChecksum);
    pr[0] = (double)(374513884U);
    pr[1] = (double)(66172286U);
    pr[2] = (double)(2743367087U);
    pr[3] = (double)(3888948420U);
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(1));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(1));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  return(mxAutoinheritanceInfo);
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
    /* do this only if simulation is starting */
    if (!sim_mode_is_rtw_gen(S)) {
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (_mabsTimer_overflowMachineNumber_,
           1,
           3,
           3,
           2,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance.chartNumber),
           &(chartInstance.instanceNumber),
           ssGetPath(S),
           (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation(_mabsTimer_overflowMachineNumber_,
            chartInstance.chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (_mabsTimer_overflowMachineNumber_,chartInstance.chartNumber,1);
          sf_debug_set_chart_event_thresholds(_mabsTimer_overflowMachineNumber_,
            chartInstance.chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,2,0,1,SF_UINT8,0,NULL,0,0,0,0.0,1.0,0,"B",0,NULL);
          _SFD_SET_DATA_PROPS(1,2,0,1,SF_UINT8,0,NULL,0,0,0,0.0,1.0,0,"C",0,NULL);
          _SFD_STATE_INFO(0,0,0);
          _SFD_STATE_INFO(1,0,0);
          _SFD_STATE_INFO(2,0,0);
          _SFD_CH_SUBSTATE_COUNT(3);
          _SFD_CH_SUBSTATE_DECOMP(0);
          _SFD_CH_SUBSTATE_INDEX(0,0);
          _SFD_CH_SUBSTATE_INDEX(1,1);
          _SFD_CH_SUBSTATE_INDEX(2,2);
          _SFD_ST_SUBSTATE_COUNT(0,0);
          _SFD_ST_SUBSTATE_COUNT(1,0);
          _SFD_ST_SUBSTATE_COUNT(2,0);
        }

        _SFD_CV_INIT_CHART(3,1,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        {
          _SFD_CV_INIT_STATE(1,0,0,0,0,0,NULL,NULL);
        }

        {
          _SFD_CV_INIT_STATE(2,0,0,0,0,0,NULL,NULL);
        }

        {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 14 };

          static int sPostFixPredicateTree[] = { 0 };

          _SFD_CV_INIT_TRANS(2,1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),1,
                             &(sPostFixPredicateTree[0]));
        }

        {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 14 };

          static int sPostFixPredicateTree[] = { 0 };

          _SFD_CV_INIT_TRANS(1,1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),1,
                             &(sPostFixPredicateTree[0]));
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);
        _SFD_TRANS_COV_WTS(2,0,1,0,0);
        if (chartAlreadyPresent==0) {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 14 };

          _SFD_TRANS_COV_MAPS(2,
                              0,NULL,NULL,
                              1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),
                              0,NULL,NULL,
                              0,NULL,NULL);
        }

        _SFD_TRANS_COV_WTS(1,0,1,0,0);
        if (chartAlreadyPresent==0) {
          static unsigned int sStartGuardMap[] = { 1 };

          static unsigned int sEndGuardMap[] = { 14 };

          _SFD_TRANS_COV_MAPS(1,
                              0,NULL,NULL,
                              1,&(sStartGuardMap[0]),&(sEndGuardMap[0]),
                              0,NULL,NULL,
                              0,NULL,NULL);
        }

        _SFD_TRANS_COV_WTS(0,0,0,0,0);
        if (chartAlreadyPresent==0) {
          _SFD_TRANS_COV_MAPS(0,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              0,NULL,NULL);
        }

        {
          boolean_T *c1_B;
          boolean_T *c1_C;
          c1_C = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 2);
          c1_B = (boolean_T *)ssGetOutputPortSignal(chartInstance.S, 1);
          _SFD_SET_DATA_VALUE_PTR(0U, c1_B);
          _SFD_SET_DATA_VALUE_PTR(1U, c1_C);
        }
      }
    }
  } else {
    sf_debug_reset_current_state_configuration(_mabsTimer_overflowMachineNumber_,
      chartInstance.chartNumber,chartInstance.instanceNumber);
  }
}

static void sf_opaque_initialize_c1_mabsTimer_overflow(void *chartInstanceVar)
{
  chart_debug_initialization(chartInstance.S,0);
  initialize_params_c1_mabsTimer_overflow();
  initialize_c1_mabsTimer_overflow();
}

static void sf_opaque_enable_c1_mabsTimer_overflow(void *chartInstanceVar)
{
  enable_c1_mabsTimer_overflow();
}

static void sf_opaque_disable_c1_mabsTimer_overflow(void *chartInstanceVar)
{
  disable_c1_mabsTimer_overflow();
}

static void sf_opaque_gateway_c1_mabsTimer_overflow(void *chartInstanceVar)
{
  sf_c1_mabsTimer_overflow();
}

static mxArray* sf_opaque_get_sim_state_c1_mabsTimer_overflow(void
  *chartInstanceVar)
{
  mxArray *st = (mxArray *) get_sim_state_c1_mabsTimer_overflow();
  return st;
}

static void sf_opaque_set_sim_state_c1_mabsTimer_overflow(void *chartInstanceVar,
  const mxArray *st)
{
  set_sim_state_c1_mabsTimer_overflow(sf_mex_dup(st));
}

static void sf_opaque_terminate_c1_mabsTimer_overflow(void *chartInstanceVar)
{
  if (sim_mode_is_rtw_gen(chartInstance.S) || sim_mode_is_external
      (chartInstance.S)) {
    sf_clear_rtw_identifier(chartInstance.S);
  }

  finalize_c1_mabsTimer_overflow();
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_mabsTimer_overflow(SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_mabsTimer_overflow();
  }
}

static void mdlSetWorkWidths_c1_mabsTimer_overflow(SimStruct *S)
{
  ssSetNeedAbsoluteTime(S,1);
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable("mabsTimer_overflow","mabsTimer_overflow",1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop("mabsTimer_overflow","mabsTimer_overflow",
                1,"RTWCG"));
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop("mabsTimer_overflow",
      "mabsTimer_overflow",1,"gatewayCannotBeInlinedMultipleTimes"));
    if (chartIsInlinable) {
      sf_mark_chart_reusable_outputs(S,"mabsTimer_overflow","mabsTimer_overflow",
        1,2);
    }

    sf_set_rtw_dwork_info(S,"mabsTimer_overflow","mabsTimer_overflow",1);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
    ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  }

  ssSetChecksum0(S,(843904473U));
  ssSetChecksum1(S,(257691245U));
  ssSetChecksum2(S,(534954672U));
  ssSetChecksum3(S,(2788195476U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
}

static void mdlRTW_c1_mabsTimer_overflow(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    sf_write_symbol_mapping(S, "mabsTimer_overflow", "mabsTimer_overflow",1);
    ssWriteRTWStrParam(S, "StateflowChartType", "Stateflow");
  }
}

static void mdlStart_c1_mabsTimer_overflow(SimStruct *S)
{
  chartInstance.chartInfo.chartInstance = NULL;
  chartInstance.chartInfo.isEMLChart = 0;
  chartInstance.chartInfo.chartInitialized = 0;
  chartInstance.chartInfo.sFunctionGateway =
    sf_opaque_gateway_c1_mabsTimer_overflow;
  chartInstance.chartInfo.initializeChart =
    sf_opaque_initialize_c1_mabsTimer_overflow;
  chartInstance.chartInfo.terminateChart =
    sf_opaque_terminate_c1_mabsTimer_overflow;
  chartInstance.chartInfo.enableChart = sf_opaque_enable_c1_mabsTimer_overflow;
  chartInstance.chartInfo.disableChart = sf_opaque_disable_c1_mabsTimer_overflow;
  chartInstance.chartInfo.getSimState =
    sf_opaque_get_sim_state_c1_mabsTimer_overflow;
  chartInstance.chartInfo.setSimState =
    sf_opaque_set_sim_state_c1_mabsTimer_overflow;
  chartInstance.chartInfo.zeroCrossings = NULL;
  chartInstance.chartInfo.outputs = NULL;
  chartInstance.chartInfo.derivatives = NULL;
  chartInstance.chartInfo.mdlRTW = mdlRTW_c1_mabsTimer_overflow;
  chartInstance.chartInfo.mdlStart = mdlStart_c1_mabsTimer_overflow;
  chartInstance.chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c1_mabsTimer_overflow;
  chartInstance.chartInfo.extModeExec = NULL;
  chartInstance.chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance.chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance.chartInfo.storeCurrentConfiguration = NULL;
  chartInstance.S = S;
  ssSetUserData(S,(void *)(&(chartInstance.chartInfo)));/* register the chart instance with simstruct */
  if (!sim_mode_is_rtw_gen(S)) {
    init_test_point_mapping_info(S);
    init_dsm_address_info();
  }

  chart_debug_initialization(S,1);
}

void c1_mabsTimer_overflow_method_dispatcher(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_mabsTimer_overflow(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_mabsTimer_overflow(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_mabsTimer_overflow(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_mabsTimer_overflow_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}

static const rtwCAPI_DataTypeMap dataTypeMap[] = {
  /* cName, mwName, numElements, elemMapIndex, dataSize, slDataId, isComplex, isPointer */
  { "uint8_T", "uint8_T", 0, 0, sizeof(uint8_T), SS_UINT8, 0, 0 } };

static const rtwCAPI_FixPtMap fixedPointMap[] = {
  /* *fracSlope, *bias, scaleType, wordLength, exponent, isSigned */
  { NULL, NULL, rtwCAPI_FIX_RESERVED, 64, 0, 0 } };

static const rtwCAPI_DimensionMap dimensionMap[] = {
  /* dataOrientation, dimArrayIndex, numDims*/
  { rtwCAPI_SCALAR, 0, 2 } };

static const uint_T dimensionArray[] = {
  1, 1 };

static real_T sfCAPIsampleTimeZero = 0.0;
static const rtwCAPI_SampleTimeMap sampleTimeMap[] = {
  /* *period, *offset, taskId, mode */
  { &sfCAPIsampleTimeZero, &sfCAPIsampleTimeZero, 0, 0 }
};

static const rtwCAPI_Signals testPointSignals[] = {
  /* addrMapIndex, sysNum, SFRelativePath, dataName, portNumber, dataTypeIndex, dimIndex, fixPtIdx, sTimeIndex */
  { 0, 0, "StateflowChart/A", "A", 0, 0, 0, 0, 0 },

  { 1, 0, "StateflowChart/B", "B", 0, 0, 0, 0, 0 },

  { 2, 0, "StateflowChart/C", "C", 0, 0, 0, 0, 0 } };

static rtwCAPI_ModelMappingStaticInfo testPointMappingStaticInfo = {
  /* block signal monitoring */
  {
    testPointSignals,                  /* Block signals Array  */
    3                                  /* Num Block IO signals */
  },

  /* parameter tuning */
  {
    NULL,                              /* Block parameters Array    */
    0,                                 /* Num block parameters      */
    NULL,                              /* Variable parameters Array */
    0                                  /* Num variable parameters   */
  },

  /* block states */
  {
    NULL,                              /* Block States array        */
    0                                  /* Num Block States          */
  },

  /* Static maps */
  {
    dataTypeMap,                       /* Data Type Map            */
    dimensionMap,                      /* Data Dimension Map       */
    fixedPointMap,                     /* Fixed Point Map          */
    NULL,                              /* Structure Element map    */
    sampleTimeMap,                     /* Sample Times Map         */
    dimensionArray                     /* Dimension Array          */
  },

  /* Target type */
  "float"
};

static void init_test_point_mapping_info(SimStruct *S)
{
  rtwCAPI_ModelMappingInfo *testPointMappingInfo;
  void **testPointAddrMap;
  init_test_point_addr_map();
  testPointMappingInfo = get_test_point_mapping_info();
  testPointAddrMap = get_test_point_address_map();
  rtwCAPI_SetStaticMap(*testPointMappingInfo, &testPointMappingStaticInfo);
  rtwCAPI_SetLoggingStaticMap(*testPointMappingInfo, NULL);
  rtwCAPI_SetInstanceLoggingInfo(*testPointMappingInfo, NULL);
  rtwCAPI_SetPath(*testPointMappingInfo, "");
  rtwCAPI_SetFullPath(*testPointMappingInfo, NULL);
  rtwCAPI_SetDataAddressMap(*testPointMappingInfo, testPointAddrMap);
  rtwCAPI_SetChildMMIArray(*testPointMappingInfo, NULL);
  rtwCAPI_SetChildMMIArrayLen(*testPointMappingInfo, 0);
  ssSetModelMappingInfoPtr(S, testPointMappingInfo);
}
