IDENTIFICATION DIVISION.
	PROGRAM-ID. AOC-2020-DAY-06.

ENVIRONMENT DIVISION.
	INPUT-OUTPUT SECTION.
	FILE-CONTROL.
		SELECT InputFile ASSIGN TO "input.txt"
			ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
	FILE SECTION.
	FD InputFile.
	01 INPUT-FILE.
		05 INPUT-LINE PIC A(30).
	
	WORKING-STORAGE SECTION.
	01 WS-EOF PIC 9(1) VALUE 0.
	01 WS-INPUT.
		05 WS-INPUT-LINE PIC A(30).
	01 WS-QUESTIONS-DATA.
		05 WS-DATA-LINE OCCURS 2400 TIMES INDEXED BY I.
			10 WS-QUESTIONS PIC A(30).
	01 WS-INPUT-SIZE PIC 9(4).
	01 WS-QUESTIONS-LIST.
		05 WS-QUESTION PIC A(1) OCCURS 26 TIMES INDEXED BY Q.
	01 WS-ANY-QUESTIONS-COUNT PIC 9(8) VALUE 0.
	01 WS-ALL-QUESTIONS-COUNT PIC 9(8) VALUE 0.
	01 WS-PRESENT-IN-ONE PIC 9(1).
	01 WS-PRESENT-IN-ALL PIC 9(1).
	01 WS-GROUP.
		05 WS-PERSON OCCURS 5 TIMES INDEXED BY J.
			10 WS-ANSWER PIC A(1) OCCURS 30 TIMES INDEXED BY K.
		05 WS-GROUP-SIZE PIC 9(4).
	01 WS-FORMATTED-NUMBER PIC ZZZZZ.

PROCEDURE DIVISION.
	
	MOVE "abcdefghijklmnopqrstuvwxyz" TO WS-QUESTIONS-LIST.
	
	OPEN INPUT InputFile.
		PERFORM VARYING I FROM 1 BY 1 UNTIL WS-EOF=1
			READ InputFile INTO WS-INPUT-LINE
				AT END
					MOVE 1 TO WS-EOF
				NOT AT END
					MOVE WS-INPUT-LINE TO WS-DATA-LINE(I)
					MOVE I TO WS-INPUT-SIZE
			END-READ
		END-PERFORM.
	CLOSE InputFile.
	
	PERFORM VARYING I FROM 1 BY 1 UNTIL I>WS-INPUT-SIZE
		PERFORM READ-GROUP-PARA
		PERFORM VARYING Q FROM 1 BY 1 UNTIL Q>26
			MOVE 0 TO WS-PRESENT-IN-ONE
			MOVE 1 TO WS-PRESENT-IN-ALL
			PERFORM VARYING J FROM 1 BY 1 UNTIL J>WS-GROUP-SIZE
				SET K TO 1
				SEARCH WS-ANSWER
					AT END
						MOVE 0 TO WS-PRESENT-IN-ALL
					WHEN WS-ANSWER(J, K)=WS-QUESTION(Q)
						MOVE 1 TO WS-PRESENT-IN-ONE
				END-SEARCH
			END-PERFORM
			IF WS-PRESENT-IN-ONE=1
				ADD 1 TO WS-ANY-QUESTIONS-COUNT
			END-IF
			IF WS-PRESENT-IN-ALL=1
				ADD 1 TO WS-ALL-QUESTIONS-COUNT
			END-IF
		END-PERFORM
	END-PERFORM.
	
	MOVE WS-ANY-QUESTIONS-COUNT TO WS-FORMATTED-NUMBER.
	DISPLAY "Part 1 answer: " WS-FORMATTED-NUMBER.
	MOVE WS-ALL-QUESTIONS-COUNT TO WS-FORMATTED-NUMBER.
	DISPLAY "Part 2 answer: " WS-FORMATTED-NUMBER.
	
	STOP RUN.
	
	READ-GROUP-PARA.
	PERFORM VARYING J FROM 1 BY 1 UNTIL J>5
		MOVE SPACES TO WS-PERSON(J)
	END-PERFORM.
	SET J TO 1.
	PERFORM VARYING I FROM I BY 1 UNTIL WS-DATA-LINE(I)=SPACES
		MOVE WS-DATA-LINE(I) TO WS-PERSON(J)
		MOVE J TO WS-GROUP-SIZE
		SET J UP BY 1
	END-PERFORM.
