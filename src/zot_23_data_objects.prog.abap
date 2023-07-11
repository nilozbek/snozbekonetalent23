*&---------------------------------------------------------------------*
*& Report zot_23_data_objects
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_data_objects.

*DATA: gv_ogrenci_adi(10) TYPE c.

DATA: gv_ogrenci_adi    TYPE c LENGTH 10,
      gv_ogrenci_soyadi TYPE char12,
      gv_tarih          TYPE sy-datum.

*gv_ogrenci_no TYPE p LENGTH 10 DECIMALS 1.

gv_ogrenci_adi    = 'Nil'.
gv_ogrenci_soyadi = 'Özbek'.
gv_tarih          = sy-datum.


cl_demo_output=>write( gv_ogrenci_adi ).
cl_demo_output=>write( gv_ogrenci_soyadi ).
cl_demo_output=>write( gv_tarih ).

*cl_demo_output=>write( |Öğrencinin adı: { gv_ogrenci_adi }, soyadı: { gv_ogrenci_soyadi }| ).

TYPES: gty_char TYPE c LENGTH 50.

DATA: gv_new TYPE gty_char.


"if
DATA: gv_langu TYPE sy-langu.

gv_langu = sy-langu.

IF gv_langu = 'T'.
  cl_demo_output=>write( |Merhaba Dünya| ).
ELSEIF gv_langu EQ 'E'.
  cl_demo_output=>write( |Hello World| ).
ELSE.
  cl_demo_output=>write( |Başka dil bilmiyorum| ).

ENDIF.

"case

CASE gv_langu.
  WHEN 'E'.
    cl_demo_output=>write( |Hello World| ).
  WHEN 'T'.
    cl_demo_output=>write( |Merhaba Dünya| ).
  WHEN OTHERS.
    cl_demo_output=>write( |Başka dil bilmiyorum| ).
ENDCASE.

DATA: gv_text1 TYPE char12.

gv_text1 = 'Hello World'.

DATA(gv_text2) = 'Hello World'.

DATA(gv_bugun) = sy-datum.

DATA(gv_text3) = gv_text1.

gv_text2 = 'Hello Worlllllldddddd'.  "hello world olarak bastırıcak çünkü yeterli karaketer yok

DATA(lv_num) = strlen( gv_text2 ).

DO lv_num TIMES.
  cl_demo_output=>write( 'Test' ).
ENDDO.

WHILE lv_num > 0.
  cl_demo_output=>write( sy-index ).
  lv_num = lv_num - 1.
ENDWHILE.

DATA: lv_number1 TYPE i VALUE 10,
      lv_number2 TYPE i VALUE 5.

DATA(lv_toplama) = lv_number1 + lv_number2.
DATA(lv_cikarma) = lv_number1 - lv_number2.
DATA(lv_carpma) = lv_number1 * lv_number2.
DATA(lv_bolme) = lv_number1 / lv_number2.

cl_demo_output=>write( |{ lv_number1 } + { lv_number2 } = { lv_toplama }| ).
cl_demo_output=>write( |{ lv_number1 } - { lv_number2 } = { lv_cikarma }| ).
cl_demo_output=>write( |{ lv_number1 } x { lv_number2 } = { lv_carpma }| ).
cl_demo_output=>write( |{ lv_number1 } / { lv_number2 } = { lv_bolme }| ).

cl_demo_output=>write( | Clear işleminden önce lv_bolme nin değeri: { lv_bolme }| ).

CLEAR lv_bolme.

cl_demo_output=>write( | Clear işleminden sonra lv_bolme nin değeri: { lv_bolme }| ).








cl_demo_output=>display( ).
