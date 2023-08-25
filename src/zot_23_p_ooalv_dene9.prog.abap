*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE9
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_ooalv_dene9.
INCLUDE zot_23_i_ooalv_dene9_top.
INCLUDE zot_23_i_ooalv_dene9_cls.
INCLUDE zot_23_i_ooalv_dene9_pbo.
INCLUDE zot_23_i_ooalv_dene9_pai.
*INCLUDE zot_23_i_ooalv_dene9_frm.


INITIALIZATION.
gs_variant_tmp-report = sy-repid.
CREATE OBJECT go_event_receiver.

*CALL FUNCTION 'LVC_VARIANT_DEFAULT_GET'
* EXPORTING
*   I_SAVE              = 'A'
*  CHANGING
*    cs_variant          = gs_variant_tmp
** EXCEPTIONS
**   WRONG_INPUT         = 1
**   NOT_FOUND           = 2
**   PROGRAM_ERROR       = 3
**   OTHERS              = 4
*          .
*IF sy-subrc eq 0.
*p_vari = gs_variant_tmp-variant.
*ENDIF.


AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.
  CALL FUNCTION 'LVC_VARIANT_F4'
    EXPORTING
      is_variant = gs_variant_tmp
*     IT_DEFAULT_FIELDCAT       =
      i_save     = 'A'
    IMPORTING
*     E_EXIT     =
      es_variant = gs_variant_tmp
*   EXCEPTIONS
*     NOT_FOUND  = 1
*     PROGRAM_ERROR             = 2
*     OTHERS     = 3
    .
  IF sy-subrc EQ 0.
    p_vari = gs_variant_tmp-variant.
  ENDIF.

START-OF-SELECTION.
 go_event_receiver->start_of_selection( ).
*  go_event_receiver->get_data( ).
*  go_event_receiver->set_fcat( ).
*  go_event_receiver->set_layout( ).
*  go_event_receiver->display_alv( ).


  CALL SCREEN 0100.
