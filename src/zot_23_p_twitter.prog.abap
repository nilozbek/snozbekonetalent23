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
    WHEN tweet_at.

      gs_mytwitter-tweet_id = p_tw_id.
      gs_mytwitter-tweet = p_tweet.
      APPEND gs_mytwitter TO lt_mytwitter.
      CLEAR gs_mytwitter.

      IF gs_mytwitter-tweet_id EQ p_tw_id.      "BAK
      WRITE :/ 'Tweet ID aynı!'.
      ELSE.

      INSERT zot_23_t_tweet FROM TABLE @lt_mytwitter.

      IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
        WRITE :/ 'Tweet Atıldı'.
      ELSE.
        WRITE :/ 'Tweet Atılamadı'.
      ENDIF.
ENDIF.
    WHEN t_degis .
      gs_mytwitter-tweet_id = p_tw_id.
      gs_mytwitter-tweet = p_tweet.
      APPEND gs_mytwitter TO lt_mytwitter.
      CLEAR gs_mytwitter.

      MODIFY zot_23_t_tweet FROM TABLE @lt_mytwitter.

      IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
        WRITE :/ 'Tweetin Değişti!'.
      ELSE.
        WRITE :/ 'Tweetin Değişmedi, dikkat!'.
      ENDIF.

    WHEN t_sil.
      gs_mytwitter-tweet_id = p_tw_id.

      DELETE FROM zot_23_t_tweet WHERE tweet_id = gs_mytwitter-tweet_id.

      IF sy-subrc = 0.
      COMMIT WORK AND WAIT.
        WRITE :/ 'Tweetini Sildin!'.
      ELSE.
        WRITE :/ 'Tweetini Silemedin, kontrol et!'.
      ENDIF.

    WHEN t_goster.
      SELECT * FROM zot_23_t_tweet
        INTO TABLE @lt_mytwitter
        WHERE tweet_id = @p_tw_id.

      IF lt_mytwitter IS NOT INITIAL.
        LOOP AT lt_mytwitter INTO gs_mytwitter.
          WRITE: / 'Tweet ID:', gs_mytwitter-tweet_id.
*         cl_demo_output=>write( |Tweet ID: { gs_mytwitter-tweet_id }| ).

          WRITE: / 'Tweet:', gs_mytwitter-tweet.
*         cl_demo_output=>write( |Tweet: { gs_mytwitter-tweet }| ).
        ENDLOOP.

      ELSE.
        WRITE :/ 'Tweet yok, bulunmadı!'.
      ENDIF.

  ENDCASE.

*         cl_demo_output=>display( ).
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    WHEN tweet_at.
*      gs_mytwitter = VALUE #( ( tweet_id = p_tw_id
*                              tweet = p_tweet ) ).
*                              INSERT zot_23_t_tweet FROM TABLE @gs_mytwitter.
*                              COMMIT WORK AND WAIT.

*    WHEN t_degis.
*    MODIFY zot_23_t_tweet FROM TABLE @gs_mytwitter.
*    COMMIT WORK AND WAIT.

*INSERT zot_23_t_tweet FROM @( VALUE #( tweet_id = p_tw_id
*                                       tweet = p_tweet ) ).

*DELETE FROM zot_23_t_tweet WHERE tweet_id = tweet_id.

*  UPDATE zot_23_t_tweet SET tweet = tweet
*  WHERE tweet_id = tweet_id.
*  COMMIT WORK AND WAIT.
