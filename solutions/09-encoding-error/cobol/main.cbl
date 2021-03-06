IDENTIFICATION DIVISION.
	PROGRAM-ID. AOC-2020-DAY-09.

ENVIRONMENT DIVISION.
	INPUT-OUTPUT SECTION.
	FILE-CONTROL.
		SELECT InputFile ASSIGN TO "input.txt"
			ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
	FILE SECTION.
	FD InputFile.
	01 INPUT-FILE.
		05 INPUT-LINE PIC X(30).
	
	WORKING-STORAGE SECTION.
	01 WS-EOF PIC 9(1) VALUE 0.
	01 WS-INPUT.
		05 WS-INPUT-LINE PIC X(20).
	01 WS-DATA.
		05 WS-PACKET OCCURS 1000 TIMES INDEXED BY I.
			10 WS-PACKET-VALUE PIC 9(16).
	01 WS-INDEXES.
		05 WS-PREAMBLE-START PIC 9(4) VALUE 1.
		05 WS-PREAMBLE-END PIC 9(4) VALUE 25.
		05 WS-J PIC 9(4).
		05 WS-K PIC 9(4).
		05 WS-RANGE-INDEX PIC 9(4).
		05 WS-RANGE-END PIC 9(4).
	01 WS-SUM PIC 9(16).
	01 WS-RANGE-BREAK PIC 9(1) VALUE 0.
	01 WS-RANGE-MIN PIC 9(16) VALUE 999999999999999.
	01 WS-RANGE-MAX PIC 9(16) VALUE 0.
	01 WS-CHECK-PASSED PIC 9(1).
	01 WS-VULN-NUMBER PIC 9(16) VALUE 0.
	01 WS-WEAKNESS PIC 9(16) VALUE 0.
	01 WS-FORMATTED-NUMBER PIC ZZZZZZZZZZZ.

PROCEDURE DIVISION.
	
	OPEN INPUT InputFile.
		PERFORM VARYING I FROM 1 BY 1 UNTIL WS-EOF=1
			READ InputFile INTO WS-INPUT-LINE
				AT END
					MOVE 1 TO WS-EOF
				NOT AT END
					MOVE WS-INPUT-LINE TO WS-PACKET-VALUE(I)
			END-READ
		END-PERFORM.
	CLOSE InputFile.
	
	PERFORM VARYING I FROM 26 BY 1 UNTIL NOT WS-VULN-NUMBER=0
		PERFORM PREAMBLE-CHECK-PARA
		IF WS-CHECK-PASSED=0
			MOVE WS-PACKET(I) TO WS-VULN-NUMBER
		END-IF
		ADD 1 TO WS-PREAMBLE-START WS-PREAMBLE-END
	END-PERFORM.
	
	MOVE WS-VULN-NUMBER TO WS-FORMATTED-NUMBER.
	DISPLAY "Part 1 answer: " WS-FORMATTED-NUMBER.
	
	PERFORM VARYING I FROM 1 BY 1 UNTIL I>1000
		MOVE 0 TO WS-RANGE-BREAK
		PERFORM VARYING WS-RANGE-END FROM 1 BY 1 UNTIL WS-RANGE-BREAK=1
			MOVE 0 TO WS-SUM
			PERFORM VARYING WS-RANGE-INDEX FROM I BY 1 UNTIL WS-RANGE-INDEX>WS-RANGE-END
				ADD WS-PACKET-VALUE(WS-RANGE-INDEX) TO WS-SUM
				IF WS-SUM>WS-VULN-NUMBER
					MOVE 1 TO WS-RANGE-BREAK
				END-IF
				IF WS-SUM=WS-VULN-NUMBER
					PERFORM GET-MINMAX-PARA
					ADD WS-RANGE-MIN WS-RANGE-MAX TO WS-WEAKNESS
					MOVE WS-WEAKNESS TO WS-FORMATTED-NUMBER
					DISPLAY "Part 2 answer: " WS-FORMATTED-NUMBER
					STOP RUN
				END-IF
			END-PERFORM
		END-PERFORM
	END-PERFORM.
	
	PREAMBLE-CHECK-PARA.
	MOVE 0 TO WS-CHECK-PASSED.
	PERFORM VARYING WS-J FROM WS-PREAMBLE-START BY 1 UNTIL WS-J>WS-PREAMBLE-END
		PERFORM VARYING WS-K FROM WS-J BY 1 UNTIL WS-K>WS-PREAMBLE-END
			ADD WS-PACKET-VALUE(WS-J) TO WS-PACKET-VALUE(WS-K) GIVING WS-SUM
			IF WS-PACKET-VALUE(I)=WS-SUM
				MOVE 1 TO WS-CHECK-PASSED
			END-IF
		END-PERFORM
	END-PERFORM.
	
	GET-MINMAX-PARA.
	PERFORM VARYING WS-J FROM I BY 1 UNTIL WS-J>WS-RANGE-END
		IF WS-PACKET-VALUE(WS-J) < WS-RANGE-MIN
			MOVE WS-PACKET-VALUE(WS-J) TO WS-RANGE-MIN
		END-IF
		IF WS-PACKET-VALUE(WS-J) > WS-RANGE-MAX
			MOVE WS-PACKET-VALUE(WS-J) TO WS-RANGE-MAX
		END-IF
	END-PERFORM.
