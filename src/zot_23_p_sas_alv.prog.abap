*&---------------------------------------------------------------------*
*& Report ZOT_23_P_SAS_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_sas_alv.
INCLUDE zot_23_p_sas_alv_top.
INCLUDE zot_23_p_sas_alv_cls.
INCLUDE zot_23_p_sas_alv_pbo.
INCLUDE zot_23_p_sas_alv_pai.

INITIALIZATION.
  go_event_receiver = NEW #( ).


START-OF-SELECTION.

  go_event_receiver->start_of_selection( ).

  CALL SCREEN 0100.
