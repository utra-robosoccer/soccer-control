/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * File: PID.h
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

#ifndef RTW_HEADER_PID_h_
#define RTW_HEADER_PID_h_
#include <math.h>
#ifndef PID_COMMON_INCLUDES_
# define PID_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* PID_COMMON_INCLUDES_ */

/* Macros for accessing real-time model data structure */

/* Block signals and states (auto storage) for system '<Root>' */
typedef struct {
  real_T Integrator_DSTATE;            /* '<S1>/Integrator' */
  real_T Filter_DSTATE;                /* '<S1>/Filter' */
} DW_PID_T;

/* External inputs (root inport signals with auto storage) */
typedef struct {
  real_T Reference;                    /* '<Root>/Reference ' */
  real_T Position;                     /* '<Root>/Position' */
} ExtU_PID_T;

/* External outputs (root outports fed by signals with auto storage) */
typedef struct {
  real_T Torque;                       /* '<Root>/Torque' */
  real_T Direction;                    /* '<Root>/Direction' */
} ExtY_PID_T;

/* Block signals and states (auto storage) */
extern DW_PID_T PID_DW;

/* External inputs (root inport signals with auto storage) */
extern ExtU_PID_T PID_U;

/* External outputs (root outports fed by signals with auto storage) */
extern ExtY_PID_T PID_Y;

/*
 * Exported Global Parameters
 *
 * Note: Exported global parameters are tunable parameters with an exported
 * global storage class designation.  Code generation will declare the memory for
 * these parameters and exports their symbols.
 *
 */
extern real_T D;                       /* Variable: D
                                        * Referenced by: '<S1>/Derivative Gain'
                                        */
extern real_T I;                       /* Variable: I
                                        * Referenced by: '<S1>/Integral Gain'
                                        */
extern real_T P;                       /* Variable: P
                                        * Referenced by: '<S1>/Proportional Gain'
                                        */
extern real_T b;                       /* Variable: b
                                        * Referenced by: '<S1>/Setpoint Weighting (Proportional)'
                                        */
extern real_T c;                       /* Variable: c
                                        * Referenced by: '<S1>/Setpoint Weighting (Derivative)'
                                        */
extern uint32_T N;                     /* Variable: N
                                        * Referenced by: '<S1>/Filter Coefficient'
                                        */

/* Model entry point functions */
extern void PID_initialize(void);
extern void PID_step(void);
extern void PID_terminate(void);

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'PID'
 * '<S1>'   : 'PID/PID Controller (2DOF)'
 * '<S2>'   : 'PID/PID Controller (2DOF)/Clamping circuit'
 */

/*-
 * Requirements for '<Root>': PID
 */
#endif                                 /* RTW_HEADER_PID_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
