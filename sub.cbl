      ******************************************************************
      * Author: Erik Eriksen
      * Date: 2021-04-16
      * Updated: 2022-04-13
      * Purpose: Sub program called by main program.
      * Tectonics: cobc -x main_app.cbl sub.cbl -o a.out
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. sub-app.

       DATA DIVISION.

       FILE SECTION.

      *> Working storage values persist until a "cancel" call is made
      *> on the sub program.
       WORKING-STORAGE SECTION.
       01  ws-test-item-1                 PIC x(10).
       01  ws-test-item-2                 PIC x(10).

      *> Local storage values are fresh on each call of the sub program
      *> even if no "cancel" statement is made.
       LOCAL-STORAGE SECTION.
       01  ls-test-item-1                 PIC x(10).
       01  ls-test-item-2                 PIC x(10).

       LINKAGE SECTION.
       01  l-test-item-1                  PIC x(10).
       01  l-test-item-2                  PIC x(10).

       PROCEDURE DIVISION USING l-test-item-1 l-test-item-2.
       MAIN-PROCEDURE.
           DISPLAY "In sub program: " l-test-item-1 " " l-test-item-2
           DISPLAY SPACE
           DISPLAY "working-storage values at start:"
           DISPLAY "ws-test-item-1: " ws-test-item-1
           DISPLAY "ws-test-item-2: " ws-test-item-2
           DISPLAY SPACE
           DISPLAY "local-storage values at start:"
           DISPLAY "ls-test-item-1: " ls-test-item-1
           DISPLAY "ls-test-item-2: " ls-test-item-2
           DISPLAY SPACE
           DISPLAY "Moving linkage section values to ws and ls vars.."

           MOVE l-test-item-1 TO ws-test-item-1
           MOVE l-test-item-2 TO ws-test-item-2
           MOVE l-test-item-1 TO ls-test-item-1
           MOVE l-test-item-2 TO ls-test-item-2


           DISPLAY "setting input variables to new value..."
           MOVE "replace1" TO l-test-item-1
           MOVE "replace2" TO l-test-item-2

           DISPLAY SPACE
           DISPLAY "working-storage values at end:"
           DISPLAY "ws-test-item-1: " ws-test-item-1
           DISPLAY "ws-test-item-2: " ws-test-item-2
           DISPLAY SPACE
           DISPLAY "local-storage values at end:"
           DISPLAY "ls-test-item-1: " ls-test-item-1
           DISPLAY "ls-test-item-2: " ls-test-item-2
           DISPLAY SPACE
           DISPLAY "Exit sub program: " l-test-item-1 " " l-test-item-2
           GOBACK.

       END PROGRAM sub-app.

