*&---------------------------------------------------------------------*
*& Report zot_23_p_report
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_report.

INCLUDE zot_ab_i_report_top.
INCLUDE zot_ab_i_report_sel.
INCLUDE zot_ab_i_report_cls.
INCLUDE zot_ab_i_report_mdl.
*
INITIALIZATION.
  go_main = lcl_main_controller=>get_instance( ).

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
*  go_main->select_file( ).

AT SELECTION-SCREEN OUTPUT.
  go_main->selscr_output( ).
*
AT SELECTION-SCREEN.
  go_main->selscr_input( ).
*
START-OF-SELECTION.
  go_main->get_data( ).

END-OF-SELECTION.
  CASE abap_true.
    WHEN p_alv.
*      go_main->display_data( ).
    WHEN p_salv.
      go_main->display_SALV( ).
    WHEN p_grid.
      go_main->display_grid( ).
  ENDCASE.
