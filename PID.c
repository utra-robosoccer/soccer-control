/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * File: PID.c
 *
 * Code generated for Simulink model 'PID'.
 *
 * Model version                  : 1.13
 * Simulink Coder version         : 8.12 (R2017a) 16-Feb-2017
 * C/C++ source code generated on : Mon Feb 19 19:59:34 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. Traceability
 *    3. Safety precaution
 *    4. RAM efficiency
 * Validation result: Not run
 */

#include "PID.h"

/* Exported block parameters */
real_T D = 1.0;                        /* Variable: D
                                        * Referenced by: '<S1>/Derivative Gain'
                                        */
real_T I = 1.0;                        /* Variable: I
                                        * Referenced by: '<S1>/Integral Gain'
                                        */
real_T P = 1.0;                        /* Variable: P
                                        * Referenced by: '<S1>/Proportional Gain'
                                        */
real_T b = 1.0;                        /* Variable: b
                                        * Referenced by: '<S1>/Setpoint Weighting (Proportional)'
                                        */
real_T c = 1.0;                        /* Variable: c
                                        * Referenced by: '<S1>/Setpoint Weighting (Derivative)'
                                        */
uint32_T N = 100U;                     /* Variable: N
                                        * Referenced by: '<S1>/Filter Coefficient'
                                        */

/* Block signals and states (auto storage) */
DW_PID_T PID_DW;

/* External inputs (root inport signals with auto storage) */
ExtU_PID_T PID_U;

/* External outputs (root outports fed by signals with auto storage) */
ExtY_PID_T PID_Y;

/* Model step function */
void PID_step(void)
{
  real_T rtb_FilterCoefficient;
  real_T rtb_SignDeltaU;
  real_T rtb_SignPreIntegrator;
  boolean_T rtb_NotEqual;
  real_T tmp;
  int8_T rtb_SignDeltaU_0;
  int8_T tmp_0;

  /* Gain: '<S1>/Filter Coefficient' incorporates:
   *  DiscreteIntegrator: '<S1>/Filter'
   *  Gain: '<S1>/Derivative Gain'
   *  Gain: '<S1>/Setpoint Weighting (Derivative)'
   *  Inport: '<Root>/Position'
   *  Inport: '<Root>/Reference '
   *  Sum: '<S1>/Sum3'
   *  Sum: '<S1>/SumD'
   */
  rtb_FilterCoefficient = ((c * PID_U.Reference - PID_U.Position) * D -
    PID_DW.Filter_DSTATE) * (real_T)N;

  /* Sum: '<S1>/Sum' incorporates:
   *  DiscreteIntegrator: '<S1>/Integrator'
   *  Gain: '<S1>/Proportional Gain'
   *  Gain: '<S1>/Setpoint Weighting (Proportional)'
   *  Inport: '<Root>/Position'
   *  Inport: '<Root>/Reference '
   *  Sum: '<S1>/Sum1'
   */
  rtb_SignDeltaU = ((b * PID_U.Reference - PID_U.Position) * P +
                    PID_DW.Integrator_DSTATE) + rtb_FilterCoefficient;

  /* Saturate: '<S1>/Saturate' */
  if (rtb_SignDeltaU > 1.0) {
    rtb_SignPreIntegrator = 1.0;
  } else if (rtb_SignDeltaU < -1.0) {
    rtb_SignPreIntegrator = -1.0;
  } else {
    rtb_SignPreIntegrator = rtb_SignDeltaU;
  }

  /* End of Saturate: '<S1>/Saturate' */

  /* Outport: '<Root>/Torque' incorporates:
   *  Abs: '<Root>/Abs'
   */
  PID_Y.Torque = fabs(rtb_SignPreIntegrator);

  /* Signum: '<Root>/Sign' */
  if (rtb_SignPreIntegrator < 0.0) {
    /* Outport: '<Root>/Direction' */
    PID_Y.Direction = -1.0;
  } else if (rtb_SignPreIntegrator > 0.0) {
    /* Outport: '<Root>/Direction' */
    PID_Y.Direction = 1.0;
  } else {
    /* Outport: '<Root>/Direction' */
    PID_Y.Direction = rtb_SignPreIntegrator;
  }

  /* End of Signum: '<Root>/Sign' */

  /* DeadZone: '<S2>/DeadZone' */
  if (rtb_SignDeltaU > 1.0) {
    rtb_SignDeltaU--;
  } else if (rtb_SignDeltaU >= -1.0) {
    rtb_SignDeltaU = 0.0;
  } else {
    rtb_SignDeltaU -= -1.0;
  }

  /* End of DeadZone: '<S2>/DeadZone' */

  /* RelationalOperator: '<S2>/NotEqual' */
  rtb_NotEqual = (0.0 != rtb_SignDeltaU);

  /* Signum: '<S2>/SignDeltaU' */
  if (rtb_SignDeltaU < 0.0) {
    rtb_SignDeltaU = -1.0;
  } else {
    if (rtb_SignDeltaU > 0.0) {
      rtb_SignDeltaU = 1.0;
    }
  }

  /* End of Signum: '<S2>/SignDeltaU' */

  /* Gain: '<S1>/Integral Gain' incorporates:
   *  Inport: '<Root>/Position'
   *  Inport: '<Root>/Reference '
   *  Sum: '<S1>/Sum2'
   */
  rtb_SignPreIntegrator = (PID_U.Reference - PID_U.Position) * I;

  /* Signum: '<S2>/SignPreIntegrator' */
  if (rtb_SignPreIntegrator < 0.0) {
    /* DataTypeConversion: '<S2>/DataTypeConv2' */
    tmp = -1.0;
  } else if (rtb_SignPreIntegrator > 0.0) {
    /* DataTypeConversion: '<S2>/DataTypeConv2' */
    tmp = 1.0;
  } else {
    /* DataTypeConversion: '<S2>/DataTypeConv2' */
    tmp = rtb_SignPreIntegrator;
  }

  /* End of Signum: '<S2>/SignPreIntegrator' */

  /* DataTypeConversion: '<S2>/DataTypeConv1' */
  if (rtb_SignDeltaU < 128.0) {
    rtb_SignDeltaU_0 = (int8_T)rtb_SignDeltaU;
  } else {
    rtb_SignDeltaU_0 = MAX_int8_T;
  }

  /* End of DataTypeConversion: '<S2>/DataTypeConv1' */

  /* DataTypeConversion: '<S2>/DataTypeConv2' */
  if (tmp < 128.0) {
    tmp_0 = (int8_T)tmp;
  } else {
    tmp_0 = MAX_int8_T;
  }

  /* Switch: '<S1>/Switch' incorporates:
   *  Constant: '<S1>/Constant'
   *  Logic: '<S2>/AND'
   *  RelationalOperator: '<S2>/Equal'
   */
  if (rtb_NotEqual && (rtb_SignDeltaU_0 == tmp_0)) {
    rtb_SignPreIntegrator = 0.0;
  }

  /* End of Switch: '<S1>/Switch' */

  /* Update for DiscreteIntegrator: '<S1>/Integrator' */
  PID_DW.Integrator_DSTATE += 0.001 * rtb_SignPreIntegrator;

  /* Update for DiscreteIntegrator: '<S1>/Filter' */
  PID_DW.Filter_DSTATE += 0.001 * rtb_FilterCoefficient;
}

/* Model initialize function */
void PID_initialize(void)
{
  /* (no initialization code required) */
}

/* Model terminate function */
void PID_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
