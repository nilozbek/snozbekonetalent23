*&---------------------------------------------------------------------*
*& Report zot_23_p_twitter
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_twitter.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_tw_id TYPE c LENGTH 4 OBLIGATORY,
              p_tweet TYPE c LENGTH 100 OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: tweet_at RADIOBUTTON GROUP grp1,
              t_degis  RADIOBUTTON GROUP grp1,
              t_sil    RADIOBUTTON GROUP grp1,
              t_goster RADIOBUTTON GROUP grp1.

SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.
DATA: gs_mytwitter TYPE zot_23_t_tweet,          "Mantigina tekrar bak
      lt_mytwitter TYPE TABLE OF zot_23_t_tweet.

CASE 'X'.
  WHEN 'X'.

    IF tweet_at = 'X'.         "Ilk yaptigim sekilde hata vermisti nedenini sor Calculatordaki ile ayni mantik!
      gs_mytwitter-tweet_id = p_tw_id.
      gs_mytwitter-tweet = p_tweet.
      APPEND gs_mytwitter TO lt_mytwitter.

      INSERT zot_23_t_tweet FROM TABLE @lt_mytwitter.

      IF sy-subrc = 0.
        WRITE :/ 'Tweet Atıldı'.
      ELSE.
        WRITE :/ 'Tweet Atılamadı'.
      ENDIF.

    ELSEIF t_degis = 'X'.
      gs_mytwitter-tweet_id = p_tw_id.
      gs_mytwitter-tweet = p_tweet.
      APPEND gs_mytwitter TO lt_mytwitter.


      gs_mytwitter-tweet = p_tweet.    "tekrar bak
      MODIFY zot_23_t_tweet FROM TABLE @lt_mytwitter.

      IF sy-subrc = 0.
        WRITE :/ 'Tweetin Değişti!'.
      ELSE.
        WRITE :/ 'Tweetin Değişmedi, dikkat!'.
      ENDIF.

    ELSEIF t_sil = 'X'.
      gs_mytwitter-tweet_id = p_tw_id.

      DELETE FROM zot_23_t_tweet WHERE tweet_id = gs_mytwitter-tweet_id.

      IF sy-subrc = 0.
        WRITE :/ 'Tweetini Sildin!'.
      ELSE.
        WRITE :/ 'Tweetini Silemedin, kontrol et!'.
      ENDIF.

    ELSEIF t_goster = 'X'.
      SELECT * FROM zot_23_t_tweet
        INTO TABLE @lt_mytwitter
        WHERE tweet_id = @p_tw_id.

      IF lt_mytwitter IS NOT INITIAL.
        LOOP AT lt_mytwitter INTO gs_mytwitter.
          WRITE: / 'Tweet ID:', gs_mytwitter-tweet_id.
*         cl_demo_output=>write( |Tweet ID: { gs_mytwitter-tweet_id }| ).  "/" bu sekilde alt satir nasil yapilirdi bak

          WRITE: / 'Tweet:', gs_mytwitter-tweet.
*         cl_demo_output=>write( |Tweet: { gs_mytwitter-tweet }| ).
        ENDLOOP.

      ELSE.
        WRITE :/ 'Tweet yok, bulunmadı!'.
      ENDIF.
    ELSE.
      WRITE :/ 'Başka bir şey seç!'.
    ENDIF.
ENDCASE.

*         cl_demo_output=>display( ).

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    WHEN tweet_at.
*      gs_mytwitter = VALUE #( ( tweet_id = p_tw_id
*                              tweet = p_tweet ) ).
*                              INSERT zot_23_t_tweet FROM TABLE @gs_mytwitter.
*                              COMMIT WORK AND WAIT.
*  IF sy-subrc = 0.
*    WRITE :/ 'Success'.
*  ELSE.
*    WRITE :/ 'Error'.
*  ENDIF.

*    WHEN t_degis.
*    MODIFY zot_23_t_tweet FROM TABLE @gs_mytwitter.
*    COMMIT WORK AND WAIT.
*  IF sy-subrc = 0.
*    WRITE :/ 'Success'.
*  ELSE.
*    WRITE :/ 'Error'.
*  ENDIF.
      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*INSERT zot_23_t_tweet FROM @( VALUE #( tweet_id = p_tw_id
*                                       tweet = p_tweet ) ).



*DELETE FROM zot_23_t_tweet WHERE tweet_id = tweet_id.
*
*  COMMIT WORK AND WAIT.
*  IF sy-subrc = 0.
*    WRITE :/ 'Success'.
*  ELSE.
*    WRITE :/ 'Error'.
*  ENDIF.
*
*  UPDATE zot_23_t_tweet SET tweet = tweet
*  WHERE tweet_id = tweet_id.
*
*  COMMIT WORK AND WAIT.
*  IF sy-subrc = 0.
*    WRITE :/ 'Success'.
*  ELSE.
*    WRITE :/ 'Error'.
*  ENDIF.
