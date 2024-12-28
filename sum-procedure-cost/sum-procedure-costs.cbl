       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUMPROCEDURECOSTS.

      * SSN First name Last name
      * AB1 Date Cost
      * P34 Date Cost
      * SSN First name Last name
      * AB1 Date Cost
      * P34 Date Cost
      * Ex:
      * H1234567890Cohn      Michael
      * PAB1202412230002345
      * PP34202412240010550

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
       OBJECT-COMPUTER.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PatientProceduresFile
           ASSIGN TO 'patient-procedures.dat'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD PatientProceduresFile.
       01 PatientRecord.
           88 EndOfFile VALUE HIGH-VALUES.
           02 RecordDType   PIC X.
               88 PatientRecordType    VALUE "H".
               88 ProcedureRecordType  VALUE "P".
           02 SSN          PIC 9(9).
           02 Patient.
               05 LastName     PIC X(20).
               05 FirstName    PIC X(15).
       
       01 ProcedureRecord.
           02 RecordType PIC X.
           02 ProcedureCode    PIC X(3).
           02 DateOfTreatment.
               05 Year PIC 9(4).
               05 Month PIC 9(2).
               05 TDay PIC 9(2).
           02 Cost     PIC 9(5)V99.

       WORKING-STORAGE SECTION.
       01  WS-Summary.
           05 WS-SSN           PIC X(9) VALUE ZEROES.
           05 WS-Patient.
               10 WS-FirstName PIC X(15).
               10 WS-LastName  PIC X(20).
           05 WS-TotalCost     PIC 9(5)V99 VALUE ZEROES.
       01  PrintTotal          PIC $$$$$,$$9.99.

       PROCEDURE DIVISION.
       Main.
           OPEN INPUT PatientProceduresFile.
           PERFORM ProcessFile.
           PERFORM EndProgram.

       ProcessFile.
           READ PatientProceduresFile
               AT END SET EndOfFile TO TRUE
           END-READ.

           PERFORM ProcessPatient UNTIL EndOfFile.


       ProcessPatient.
           MOVE SSN TO WS-SSN.
           MOVE Patient TO WS-PATIENT.
           MOVE ZEROES TO WS-TotalCost.

           READ PatientProceduresFile
               AT END SET EndOfFile TO TRUE
           END-READ.
           PERFORM SumUpPatient UNTIL PatientRecordType OR EndOfFile.
           MOVE WS-TotalCost TO PrintTotal.
           DISPLAY WS-SSN " " WS-Patient " " PrintTotal.
           
       SumUpPatient.               
           ADD Cost TO WS-TotalCost.
           READ PatientProceduresFile
               AT END SET EndOfFile TO TRUE
           END-READ.

       EndProgram.
           CLOSE PatientProceduresFile.
           STOP RUN.

       END PROGRAM SUMPROCEDURECOSTS.
       