*&---------------------------------------------------------------------*
*& Report ZOT_23_HELLO_WORLD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_HELLO_WORLD.

WRITE 'Hello World'.

*cl_demo_output=>display( 'Hello World' ).
*
*cl_demo_output=>display( ).

PARAMETERS: sayi TYPE int4,
      sayi2 type int4.

 data: lv_txt type char40,
      lv_txt2 type char40.


      IF sayi = 1.
        lv_txt = 'Gönderilmedi'.
      ELSEIF sayi = 2.
        lv_txt = 'Gönderildi'.
      ELSE.
        lv_txt = 'Hata'.
      ENDIF.

      IF sayi2 = 1.
        lv_txt2 = 'Konşimento'.
      ELSEIF sayi2 = 2.
        lv_txt2 = 'Konteyner'.
      ELSE.
        lv_txt2 = 'Konşimento ve Konteyner'.
      ENDIF.

      cl_demo_output=>write( lv_txt ).

      cl_demo_output=>write( lv_txt2 ).

      cl_demo_output=>display( ).
