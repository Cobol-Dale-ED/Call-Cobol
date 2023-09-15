      ******************************************************************
      * Author: Erik Eriksen
      * Date: 2020-04-16
      * Updated: 2022-04-13
      * Purpose: Main application calls sub-app by content and reference
      * Tectonics: cobc -x main_app.cbl sub.cbl -o main_app.exe
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. main-app.

       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.

       01 ws-group-1.
           05 ws-item-1                        PIC x(10).
           05 ws-item-2                        PIC x(10).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY SPACE
           DISPLAY "Enter value for #1: " WITH NO ADVANCING
           ACCEPT ws-item-1

           DISPLAY "Enter value for #2: " WITH NO ADVANCING
           ACCEPT ws-item-2.

           PERFORM display-message

      *> Calling by content, the variables passed will not be modified
      *> upon return to the main application.
           DISPLAY "Calling sub program by content:"
           CALL "sub-app" USING
               BY CONTENT ws-item-1
               BY CONTENT ws-item-2
           END-CALL
           PERFORM display-message

      *> Calling by reference (default) the variables can be modified by
      *> the called sub program. Note that the working-storage variables
      *> of the sub program retain their values between calls where the
      *> linkage section variables do not.
           DISPLAY "Second call of sub program should retain WS values."
           DISPLAY "Calling sub program by reference:"
           CALL "sub-app" USING
               ws-item-1 ws-item-2
           END-CALL
           PERFORM display-message

      *> Cancelling the sub program will reset all variables in the
      *> working storage section back to their original values.
           DISPLAY "Cancelling sub program"
           CANCEL "sub-app"
           DISPLAY "Calling sub program. WS values should be reset:"
           CALL "sub-app" USING
               ws-item-1 ws-item-2
           END-CALL
           PERFORM display-message


           STOP run.

       DISPLAY-MESSAGE.
           DISPLAY space
           DISPLAY "-----------------------------------------------"
           DISPLAY "Main app: " ws-group-1
           EXIT paragraph.


       END PROGRAM main-app.

