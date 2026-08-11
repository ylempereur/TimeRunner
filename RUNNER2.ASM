        COND    TYPE=DISK
WRITHS  LD      HL,FILES
        LD      DE,DCB
        LD      BC,13
        LDIR
        OPEN    DCB,ERROR,SCR,10*(10+6)
        POSN    DCB,ERROR,0
        WRITLR  DCB,ERROR,TSCOR
        CLOSE   DCB,ERROR
        DINT
        RET
        ENDC
        COND    TYPE=PROT
WRITHS  CALL    WRITE
        RET
        ENDC
SCHST   LD      IY,TSCOR
        CALL    SCOR12
        LD      B,5
        XOR     A
SCH0    OR      (HL)
        INC     HL
        DJNZ    SCH0
        CP      '0'
        RET     Z
        LD      B,10
SCH1    LD      C,10
        CALL    SCOR12
SCH2    LD      A,C
        LD      (SCH3+2),A
SCH3    LD      A,(IY+0)
        CP      (HL)
        JR      C,SCH5
        JR      NZ,SCH4
        INC     HL
        INC     C
        LD      A,C
        CP      16
        JR      NZ,SCH2
SCH4    LD      DE,16
        ADD     IY,DE
        DJNZ    SCH1
        RET
SCH5    PUSH    IY
        LD      A,B
        LD      (SVPL+1),A
        CP      1
        JR      Z,SCH7
        LD      HL,0
        LD      DE,16
        DEC     B
SCH6    ADD     HL,DE
        DJNZ    SCH6
        PUSH    HL
        POP     BC
        LD      HL,TSCOR+9*(10+6)-1
        LD      DE,TSCOR+10*(10+6)-1
        LDDR
SCH7    CALL    SCOR12
        POP     DE
        PUSH    DE
        LD      BC,10
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        LD      BC,6
        LDIR
SVPL    LD      B,0
        LD      HL,VIDEO+832+43
        LD      DE,-64
SCH8    ADD     HL,DE
        DJNZ    SCH8
        LD      IX,BLK1
        LD      A,(PLAY)
        CP      1
        JR      NZ,SCH9
        LD      IX,BLK2
SCH9    LD      (IX),L
        LD      (IX+1),H
        POP     HL
        LD      A,(PLAY)
        LD      B,A
        JP      INGS
SVHL    DEFW    0
SVBC    DEFW    0
WAITER  DEFW    0
INGS    PUSH    HL
        PUSH    BC
        LD      (SVBC),BC
        LD      (SVHL),HL
        LD      B,10
ING5    LD      (HL),' '
        INC     HL
        DJNZ    ING5
        LD      A,1
        LD      (EDIS),A
        LD      HL,15000
        LD      (WAITER),HL
        CALL    CLSSCR
        XOR     A
        LD      (BLINK),A
        CALL    DSCORE
        CALL    DHSCOR
        CALL    AFFHS
        LD      A,' '
        LD      (SCR+20),A
        LD      (SCR+21),A
        CALL    SCRVID
        LD      HL,TAGS
        LD      DE,VIDEO+192+14
ING0    LD      A,(HL)
        INC     HL
        OR      A
        JR      Z,ING1
        DEC     HL
        CALL    AFF1C
        INC     HL
        INC     DE
        JR      ING0
ING1    LD      A,(HL)
        CP      0FFH
        JR      Z,ING2
        LD      C,A
        LD      B,0
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        INC     HL
        JR      ING0
ING2    POP     BC
        LD      A,B
        LD      HL,VIDEO+10
        LD      B,'<'
        CP      1
        JR      Z,ING3
        LD      A,'2'
        LD      B,'>'
        LD      HL,VIDEO+42
        LD      (VIDEO+192+24),A
ING3    LD      A,10
ING4    LD      (HL),B
        INC     HL
        DEC     A
        JR      NZ,ING4
        POP     IX
        LD      B,0
        LD      HL,(BLK1)
        LD      A,(PLAY)
        CP      1
        JR      NZ,INGH
        LD      HL,(BLK2)
INGH    DEC     HL
        LD      (HL),'>'
        INC     HL
        CALL    2BH
ING6    LD      (HL),8FH
ING7    CALL    2BH
        OR      A
        JR      NZ,INGI
INGI0   DEC     A
        JR      NZ,INGI0
        LD      DE,(WAITER)
        DEC     DE
        LD      (WAITER),DE
        LD      A,E
        OR      D
        JR      Z,INGI1
        LD      A,E
        OR      A
        JR      Z,INGI2
        CP      80H
        JR      NZ,INGI3
        LD      A,' '
        LD      (VIDEO+192+24),A
INGI3   LD      A,E
        AND     7FH
        CP      10
        JR      Z,INGI4
        CP      74
        JR      NZ,ING7
        LD      A,8FH
        JR      INGI5
INGI4   LD      A,' '
INGI5   LD      (HL),A
        JR      ING7
INGI2   LD      A,(PLAY)
        ADD     A,'0'
        LD      (VIDEO+192+24),A
        JR      INGI3
INGI    CP      24
        JR      Z,ING9
        CP      0DH
        JR      NZ,INGL
INGI1   LD      (HL),' '
        RET
INGL    CP      8
        JR      Z,ING8
        CP      ' '
        JR      C,ING6
        EX      AF,AF'
        LD      A,B
        CP      10
        JR      Z,ING6
        EX      AF,AF'
        LD      (IX),A
        LD      (HL),A
        INC     HL
        INC     B
        INC     IX
        JR      ING6
ING8    LD      A,B
        OR      A
        JR      Z,ING6
        LD      (HL),' '
        DEC     IX
        DEC     HL
        LD      (IX),' '
        DEC     B
        JR      ING6
ING9    LD      HL,(SVHL)
        LD      BC,(SVBC)
        JP      INGS
TAGS    DEFM    '** Player 1 **'
        DEFB    0
        DEFB    114
        DEFW    0A3B7H
        DEFW    0B791H
        DEFW    90BBH
        DEFW    0B3B7H
        DEFW    0BA81H
        DEFW    95B3H
        DEFW    0B783H
        DEFB    81H
        DEFB    0
        DEFB    49
        DEFW    8C8FH
        DEFW    8F85H
        DEFW    8580H
        DEFW    8C8FH
        DEFW    8F84H
        DEFW    8580H
        DEFW    8F80H
        DEFB    80H
        DEFB    0
        DEFB    49
        DEFW    0B3B7H
        DEFW    0B791H
        DEFW    8583H
        DEFW    0A397H
        DEFW    0B795H
        DEFW    90BBH
        DEFW    0B3B7H
        DEFB    81H
        DEFB    0
        DEFB    49
        DEFW    8E8CH
        DEFW    8F85H
        DEFW    858CH
        DEFW    8E8DH
        DEFW    8F85H
        DEFW    8580H
        DEFW    8C8FH
        DEFB    84H
        DEFB    0
        DEFB    113
        DEFM    'Please   enter'
        DEFB    0
        DEFB    50
        DEFM    'your  name  or'
        DEFB    0
        DEFB    50
        DEFM    '   initials   '
        DEFB    0
        DEFB    0FFH
PRINT   LD      E,(HL)
        INC     HL
        LD      D,(HL)
PRI0    INC     HL
        LD      A,(HL)
        INC     HL
        DEC     A
        RET     Z
        INC     A
        JR      Z,PRINT
        DEC     HL
        CALL    AFF1C
        INC     DE
        JR      PRI0
TABFUN  DEFW    0BFBFH  ; "F"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0B0B0H
        DEFW    0B0B0H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8383H
        DEFW    8383H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFBFH  ; "U"
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BCBCH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "N"
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "S"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0B0B0H
        DEFW    0B3B3H
        DEFW    0B3B3H
        DEFW    8383H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BCBCH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "O"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BCBCH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "F"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0B0B0H
        DEFW    0B0B0H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8383H
        DEFW    8383H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    8F8FH   ; "T"
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
TABPF   DEFW    100H
        DEFW    402H
        DEFW    1008H
        DEFW    4020H
        DEFW    4241H
        DEFW    4844H
        DEFW    6050H
        DEFW    6261H
        DEFW    6864H
        DEFW    7170H
        DEFW    7472H
        DEFW    7978H
        DEFW    7C7AH
        DEFW    7E7DH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    0
        DEFW    7F7FH
        DEFW    0
        DEFW    7F7FH
        DEFW    0
        DEFW    7F7FH
        DEFW    1F3FH
        DEFW    70FH
        DEFW    103H
        DEFW    100H
        DEFW    402H
        DEFW    1008H
        DEFW    4020H
        DEFW    1020H
        DEFW    408H
        DEFW    102H
        DEFW    402H
        DEFW    1008H
        DEFW    4020H
        DEFW    7060H
        DEFW    7C78H
        DEFW    7F7EH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFB    80H
TABDIS  DEFM    'Published by'
        DEFM    'Funsoft, Inc.'
        DEFM    '28611 Canwood'
        DEFM    'Agoura, CA 91301'
        DEFM    '(213) 991-6540'
PLETR   PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      B,4
PLE0    PUSH    BC
        LD      B,8
PLE1    LD      A,(HL)
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    PLE1
        EX      DE,HL
        LD      BC,56
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        DJNZ    PLE0
PLE2    POP     BC
        POP     DE
        POP     HL
        POP     AF
        RET
CLETR   PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        EX      DE,HL
        LD      B,4
CLE0    LD      C,8
CLE1    LD      (HL),80H
        INC     HL
        DEC     C
        JR      NZ,CLE1
        LD      DE,56
        ADD     HL,DE
        DJNZ    CLE0
        JR      PLE2
PFUN    PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        SLA     A
        LD      HL,TABFUN
        LD      B,7
PFU0    PUSH    BC
        SLA     A
        CALL    C,PLETR
        CALL    NC,CLETR
        EX      DE,HL
        LD      BC,9
        ADD     HL,BC
        EX      DE,HL
        LD      BC,4*8
        ADD     HL,BC
        POP     BC
        DJNZ    PFU0
        JR      PLE2
PROFUN  LD      HL,TABPF
        LD      DE,VIDEO+192+1
PRF0    LD      A,(HL)
        INC     HL
        BIT     7,A
        RET     NZ
        CALL    PFUN
        CALL    GLIFUN
        CALL    GLIFUN
        JR      PRF0
CADRE   LD      HL,SCR+960+1
        EXX
        LD      HL,SCR+512+1
        LD      DE,SCR+640+1
        LD      B,62
        LD      A,83H
CAD0    EXX
        LD      (HL),8CH
        INC     HL
        EXX
        LD      (HL),8CH
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    CAD0
        LD      HL,SCR+576
        LD      DE,63
        LD      B,6
CAD1    LD      (HL),0BFH
        ADD     HL,DE
        LD      (HL),0BFH
        INC     HL
        DJNZ    CAD1
        LD      A,0BCH
        LD      (SCR+512),A
        LD      (SCR+512+63),A
        LD      A,8FH
        LD      (SCR+960),A
        LD      (SCR+960+63),A
        RET
TGFUN   DEFM    'FUNSOFT '
CGLI    DEFB    0
GLIFUN  EXX
        LD      A,(CGLI)
        INC     A
        AND     7
        LD      (CGLI),A
        LD      (GLI0+2),A
        LD      IX,TGFUN
        LD      HL,VIDEO+576+1
        LD      B,62
GLI0    LD      A,(IX+0)
        LD      (HL),A
        INC     HL
        LD      A,(GLI0+2)
        INC     A
        AND     7
        LD      (GLI0+2),A
        DJNZ    GLI0
        LD      BC,800H
GLI1    LD      A,(38FFH)
        OR      A
        JR      Z,GLI2
        POP     HL
        RET
GLI2    DEC     BC
        LD      A,B
        OR      C
        JR      NZ,GLI1
        EXX
        RET
DEBUT   DINT
        LD      HL,STACK
        LD      SP,HL
        LD      H,37H
        LD      L,0E4H
        LD      (HL),1
        LD      A,38H
        OUT     (0ECH),A
        COND    TYPE=TAPE
        LD      HL,DEBUT
        LD      (4007H),HL
        ENDC
        COND    TYPE=PROT
        CALL    CHECKS
        ENDC
        CALL    EHS
        COND    TYPE=PROT
        CALL    CHECKR
        ENDC
        CALL    SCR191
        CALL    DISPL
        CALL    CLSSCR
        LD      HL,TABDIS
        LD      DE,SCR+64+26
        LD      BC,12
        CALL    AFF1L
        LD      DE,SCR+704+25
        LD      BC,13
        CALL    AFF1L
        LD      DE,SCR+768+25
        LD      BC,13
        CALL    AFF1L
        LD      DE,SCR+832+24
        LD      BC,16
        CALL    AFF1L
        LD      DE,SCR+896+25
        LD      BC,14
        CALL    AFF1L
        CALL    CADRE
        CALL    DISPL
        CALL    PROFUN
        JP      START
SCOR12  LD      A,(PLAY)
        CP      1
        JR      Z,SC12
        LD      HL,SCORE2
        RET
SC12    LD      HL,SCORE1
        RET
EDIS    DEFB    0
PROC    LD      A,(BASE)
        CP      3
        RET     NZ
        LD      A,(SHP1)
        LD      B,A
        LD      A,(NPLAY)
        CP      1
        LD      A,0
        JR      Z,PROC0
        LD      A,(SHP2)
PROC0   OR      B
        JR      NZ,PROC1
        LD      A,(DEMO)
        OR      A
        JP      NZ,START
        LD      A,(NPLAY)
        CP      1
        JR      NZ,PROC2
        XOR     A
        LD      (EDIS),A
        CALL    SCHST
        COND    0!(TYPE=DISK)!(TYPE=PROT)
        LD      A,(EDIS)
        OR      A
        CALL    NZ,WRITHS
        ENDC
        JP      START
PROC2   LD      HL,SCORE1
        LD      DE,SCORE2
        LD      B,6
PROC3   LD      A,(DE)
        CP      (HL)
        JR      C,PROC4
        JR      NZ,PROC5
        INC     HL
        INC     DE
        DJNZ    PROC3
PROC4   LD      A,1
        JR      PROC6
PROC5   LD      A,2
PROC6   LD      (PLAY),A
        XOR     A
        LD      (EDIS),A
        CALL    SCHST
        LD      A,(PLAY)
        NEG
        ADD     A,3
        LD      (PLAY),A
        CALL    SCHST
        COND    0!(TYPE=DISK)!(TYPE=PROT)
        LD      A,(EDIS)
        OR      A
        CALL    NZ,WRITHS
        ENDC
        JP      START
PROC1   CALL    INIT1
        LD      A,(NPLAY)
        CP      1
        JR      NZ,PROC7
        RET
PROC7   LD      A,(PLAY)
        CP      1
        JR      Z,PROC8
        LD      A,(SHP1)
        JR      PROC9
PROC8   LD      A,(SHP2)
PROC9   OR      A
        RET     Z
        LD      HL,PLAY
        LD      A,3
        SUB     (HL)
        LD      (HL),A
        LD      HL,SCR1
        LD      DE,SCR2
        LD      BC,896
        CALL    EXCH
        LD      HL,TABON
        LD      DE,TABON2
        LD      BC,20*6
        CALL    EXCH
        LD      HL,PHASE
        LD      DE,VAR2
        LD      BC,3
        CALL    EXCH
        CALL    INIT1
        RET
EXCH    EXIR
        RET
        COND    TYPE=PROT
CHECKS  JR      CHES
CHES0   LD      A,(CHKS)
        LD      H,44H
        LD      L,8
        CP      (HL)
        RET     Z
        JR      CLEANP
CHES    LD      HL,3C00H
        LD      BC,1024
        CALL    CHECK
        LD      (CHKS),A
        XOR     A
        LD      (CHECKS+1),A
        JR      CHES0
CHKS    DEFB    0
CLEANP  LD      HL,8000H
        LD      DE,4000H
        LD      BC,8000H
        LDIR
        RET
CHECK   XOR     A
CHE0    ADD     A,(HL)
        LD      E,A
        INC     HL
        DEC     BC
        LD      A,B
        OR      C
        LD      A,E
        JR      NZ,CHE0
        RET
CHECKR  JR      CHER
CHER0   LD      A,(CHKR)
        LD      H,44H
        LD      L,0AH
        CP      (HL)
        RET     Z
        JR      CLEANP
CHER    LD      HL,0A000H
        LD      BC,6000H
        CALL    CHECK
        LD      (CHKR),A
        XOR     A
        LD      (CHECKR+1),A
        JR      CHER0
CHKR    DEFB    0
        ENDC
BRKCLR  LD      A,(3840H)
        AND     6
        CP      6
        JP      Z,DEBUT
        LD      A,(DEMO)
        OR      A
        JR      Z,BRK2
        LD      A,(38FFH)
        OR      A
        RET     Z
        LD      HL,20000
        LD      (IPRO+1),HL
        JP      START
BRK2    LD      A,(3801H)
        AND     1
        RET     Z
        LD      A,(3880H)
        AND     1
        RET     Z
BRK0    LD      A,(38FFH)
        OR      A
        JR      NZ,BRK0
        LD      B,0
        DJNZ    $
BRK1    LD      A,(38FFH)
        OR      A
        JR      Z,BRK1
        LD      B,0
        DJNZ    $
        RET
SCRVID  LD      A,(DEMO)
        OR      A
        JR      Z,SCRV0
        LD      HL,CEI0
        LD      DE,SCR+24
        LD      B,17
SCRV1   LD      A,(HL)
        CALL    DISA
        INC     HL
        INC     DE
        DJNZ    SCRV1
SCRV0   CALL    AFF
        COND    0!(TYPE=TAPE)!(TYPE=PROT)
        CALL    TRCLN
        ENDC
        RET
CEI0    DEFM    '** TIME RUNNER **'
INITS   LD      HL,TINIT
        LD      DE,SCORE1
        LD      BC,TINIT-SCORE1
        LDIR
        LD      HL,TABONI
        LD      DE,TABON
        LD      BC,20*6
        LDIR
        LD      HL,TABONI
        LD      DE,TABON2
        LD      BC,20*6
        LDIR
        RET
INIT0   LD      HL,TINIT0
        LD      DE,BASE
        LD      BC,TINIT-BASE
        LDIR
        LD      HL,TABONI
        LD      DE,TABON
        LD      BC,20*6
        LDIR
        RET
INIT1   LD      HL,TINIT1
        LD      DE,JMPN
        LD      BC,TINIT-JMPN
        LDIR
        CALL    CBAD
        RET
DIALOG  LD      A,(BASE)
        CP      1
        RET     Z
        OR      A
        JR      NZ,DIA0
        LD      HL,TPLAY
        LD      DE,SCR+448+28
        LD      BC,7
        CALL    AFF1L
        LD      A,(PLAY)
        OR      '0'
        LD      (DE),A
        RET
DIA0    CP      2
        RET     NZ
        LD      A,(PLAY)
        CP      1
        JR      NZ,DIA1
        LD      A,'1'
        EX      AF,AF'
        LD      A,(SHP1)
        JR      DIA2
DIA1    LD      A,'2'
        EX      AF,AF'
        LD      A,(SHP2)
DIA2    OR      A
        RET     NZ
        LD      HL,TGAM
        LD      DE,SCR+448+23
        LD      BC,17
        CALL    AFF1L
        EX      AF,AF'
        LD      (DE),A
        RET
TGAM    DEFM    'Game Over '
TPLAY   DEFM    'Player '
DSCORE  LD      A,(BLINK)
        INC     A
        AND     7
        LD      (BLINK),A
        LD      HL,LAST1
        LD      A,(SCORE1+1)
        CP      (HL)
        JR      Z,DSC0
        LD      (HL),A
        LD      HL,SHP1
        INC     (HL)
        CALL    EXTRA
DSC0    LD      HL,LAST2
        LD      A,(SCORE2+1)
        CP      (HL)
        JR      Z,DSC1
        LD      (HL),A
        LD      HL,SHP2
        INC     (HL)
        CALL    EXTRA
DSC1    LD      A,(PLAY)
        CP      1
        JR      NZ,DSC2
        LD      A,(BLINK)
        CP      4
        JR      NC,DSC3
DSC2    LD      HL,SCORE1
        LD      DE,SCR+3
        LD      BC,600H
DSC4    LD      A,(HL)
        CP      '0'
        JR      NZ,DSC5
        LD      A,C
        OR      A
        JR      Z,DSC6
        LD      A,'0'
DSC5    CALL    DISA
        LD      C,1
DSC6    INC     HL
        INC     DE
        DJNZ    DSC4
        DEC     DE
        LD      A,'0'
        CALL    DISA
        LD      A,(SHP1)
        OR      A
        JR      Z,DSC3
        CP      16H
        JR      C,DSC7
        LD      A,16H
DSC7    LD      DE,SCR+10
        LD      B,A
        LD      A,'+'
DSC8    CALL    DISA
        INC     DE
        DJNZ    DSC8
DSC3    LD      A,(NPLAY)
        CP      1
        JR      Z,DSC20
        LD      A,(PLAY)
        CP      2
        JR      NZ,DSC12
        LD      A,(BLINK)
        CP      4
        JR      NC,DSC20
DSC12   LD      HL,SCORE2
        LD      DE,SCR+37H
        LD      BC,600H
DSC14   LD      A,(HL)
        CP      '0'
        JR      NZ,DSC15
        LD      A,C
        OR      A
        DEC     DE
        JR      Z,DSC16
        INC     DE
        LD      A,'0'
DSC15   CALL    DISA
        LD      C,1
DSC16   INC     DE
        INC     HL
        DJNZ    DSC14
        LD      A,C
        OR      A
        JR      NZ,DSCOP
        LD      A,'0'
        CALL    DISA
DSCOP   LD      A,(SHP2)
        OR      A
        JR      Z,DSC20
        CP      16H
        JR      C,DSC17
        LD      A,16H
DSC17   LD      DE,SCR+35H
        LD      B,A
        LD      A,'+'
DSC18   CALL    DISA
        DEC     DE
        DJNZ    DSC18
DSC20   RET
EXTRA   LD      E,5
EXT0    LD      C,150
EXT1    LD      A,1
        OUT     (255),A
        LD      B,40
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      B,40
        DJNZ    $
        DEC     C
        JR      NZ,EXT1
        DEC     E
        RET     Z
        LD      C,100
EXT2    LD      A,1
        OUT     (255),A
        LD      B,60
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      B,60
        DJNZ    $
        DEC     C
        JR      NZ,EXT2
        JR      EXT0
DHSCOR  LD      A,(DEMO)
        OR      A
        RET     NZ
        LD      A,(NPLAY)
        CP      1
        JR      Z,DHS0
        LD      HL,SCORE1
        LD      DE,SCORE2
        LD      B,5
DHS1    LD      A,(DE)
        CP      (HL)
        JR      C,DHS0
        JR      NZ,DHS2
        INC     HL
        INC     DE
        DJNZ    DHS1
DHS0    LD      HL,SCORE1
        LD      A,1
        EX      AF,AF'
        JR      DHS3
DHS2    LD      HL,SCORE2
        LD      A,2
        EX      AF,AF'
DHS3    LD      DE,HSCORE
        PUSH    DE
        PUSH    HL
        LD      B,5
DHS4    LD      A,(DE)
        CP      (HL)
        JR      C,DHS5
        JR      NZ,DHS6
        INC     HL
        INC     DE
        DJNZ    DHS4
        XOR     A
        EX      AF,AF'
DHS5    POP     HL
        POP     DE
        EX      AF,AF'
        LD      B,A
        LD      A,(PLAY)
        CP      B
        JR      NZ,DHS7
        LD      A,(BLINK)
        CP      4
        RET     NC
        JR      DHS7
DHS6    POP     DE
        POP     HL
DHS7    LD      DE,SCR+1DH
        LD      B,6
DHS8    LD      A,(HL)
        CP      '0'
        JR      NZ,DHS9
        INC     HL
        INC     DE
        DJNZ    DHS8
        RET
DHS9    CALL    DISA
        INC     DE
        INC     HL
        LD      A,(HL)
        DJNZ    DHS9
        RET
DISA    PUSH    BC
        LD      C,A
        LD      A,(DE)
        CP      80H
        LD      A,C
        POP     BC
        RET     NZ
        LD      (DE),A
        RET
RAND    CALL    RND
        LD      E,A
        LD      D,0
        CALL    MUL16
        LD      A,H
        RET
RND     LD      A,R
        ADD     A,C
        RRCA
        LD      L,A
        AND     2
        SRL     A
        LD      H,A
        ADD     A,(HL)
        RRCA
        ADD     A,(HL)
        SRL     A
        SUB     (HL)
        ADD     A,E
        RRCA
        ADD     A,C
RND0    XOR     0
        LD      (RND0+1),A
        RET
DIV16   LD      A,L
        LD      L,H
        LD      H,0
        LD      E,0
        LD      B,16
        LD      IX,0
LOOPD   ADD     HL,HL
        RLA
        JR      NC,LOOPD1
        INC     L
LOOPD1  ADD     IX,IX
        INC     IX
        OR      A
        SBC     HL,DE
        JR      NC,CONTD
        ADD     HL,DE
        DEC     IX
CONTD   DJNZ    LOOPD
        RET
INVERT  LD      HL,VIDEO+64
        LD      BC,1024-64-1
INV0    LD      A,(HL)
        BIT     7,A
        JR      Z,INV1
        XOR     3FH
INV1    LD      (HL),A
        INC     HL
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,INV0
        RET
TPOI    DEFB    1
        DEFB    4
        DEFB    1
        DEFB    3
        DEFB    2
        DEFB    3
        DEFB    3
        DEFB    3
        DEFB    4
        DEFB    3
        DEFB    5
        DEFB    3
        DEFB    6
        DEFB    3
ADDPO   SUB     1
        ADD     A,A
        LD      C,A
        LD      B,0
        LD      HL,TPOI
        ADD     HL,BC
        LD      D,(HL)
        INC     HL
        LD      C,(HL)
        LD      B,0
        CALL    SCOR12
        ADD     HL,BC
ADP0    LD      A,(HL)
        ADD     A,D
        CP      '9'+1
        JR      C,ADP3
        LD      D,1
        SUB     10
ADP1    CP      '9'+1
        JR      C,ADP2
        SUB     '9'+1
        INC     D
        JR      ADP1
ADP2    LD      (HL),A
        DEC     C
        DEC     HL
        JP      P,ADP0
        RET
ADP3    LD      (HL),A
        RET
DBASE   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(BAC)
        LD      E,A
        LD      D,0
        LD      HL,TCAL
        ADD     HL,DE
        LD      L,(HL)
        LD      H,0
        LD      A,(BADIR)
        CP      3
        JR      NC,DBS0
        LD      DE,6*12
        ADD     HL,DE
DBS0    LD      DE,TBASE
        ADD     HL,DE
        EX      DE,HL
        LD      HL,(BAHL)
        LD      BC,SCR-SCR1+64
        ADD     HL,BC
        LD      B,3
        PUSH    HL
        EXX
        POP     HL
        LD      DE,SCRTIR-SCR
        ADD     HL,DE
        LD      (PEBAS),HL
        LD      E,0
        EXX
DBS1    LD      C,4
DBS2    LD      A,(DE)
        AND     (HL)
        EXX
        OR      E
        LD      E,A
        EXX
        LD      A,(DE)
        EXX
        LD      (HL),A
        INC     HL
        EXX
        LD      A,(DE)
        OR      (HL)
        LD      (HL),A
        INC     DE
        INC     HL
        DEC     C
        JR      NZ,DBS2
        DJNZ    DBS3
        JR      DBS4
DBS3    PUSH    DE
        LD      DE,64-4
        ADD     HL,DE
        POP     DE
        EXX
        PUSH    DE
        LD      DE,64-4
        ADD     HL,DE
        POP     DE
        EXX
        JR      DBS1
DBS4    EXX
        LD      A,E
        AND     3FH
        RET     Z
MBOS    LD      A,2
        LD      (BASE),A
        LD      A,(PLAY)
        CP      1
        JR      NZ,DBS5
        LD      HL,SHP1
        JR      DBS6
DBS5    LD      HL,SHP2
DBS6    DEC     (HL)
        CALL    INVERT
        RET
EFFBAS  LD      HL,(PEBAS)
        LD      A,H
        OR      L
        JR      Z,EBA2
        LD      B,3
EBA0    LD      C,4
EBA1    LD      (HL),80H
        INC     HL
        DEC     C
        JR      NZ,EBA1
        LD      DE,64-4
        ADD     HL,DE
        DJNZ    EBA0
        LD      HL,0
        LD      (PEBAS),HL
EBA2    LD      A,(BASE)
        CP      1
        JR      Z,EBA7
        CP      2
        RET     NZ
EBA7    LD      A,(BAC)
        LD      E,A
        LD      D,0
        LD      HL,TCAL
        ADD     HL,DE
        LD      A,(HL)
        EXX
        LD      E,A
        LD      D,0
        LD      HL,TEFF
        ADD     HL,DE
        EXX
        LD      L,A
        LD      H,0
        LD      A,(BADIR)
        CP      3
        JR      NC,EBA3
        LD      DE,6*12
        ADD     HL,DE
EBA3    LD      DE,TBASE
        ADD     HL,DE
        EX      DE,HL
        LD      HL,(BAHL)
        LD      BC,SCR-SCR1+64
        ADD     HL,BC
        LD      B,3
EBA4    LD      C,4
EBA5    LD      A,(HL)
        EXX
        AND     (HL)
        INC     HL
        EXX
        LD      (HL),A
        LD      A,(DE)
        OR      (HL)
        LD      (HL),A
        INC     DE
        INC     HL
        DEC     C
        JR      NZ,EBA5
        DJNZ    EBA6
        RET
EBA6    PUSH    DE
        LD      DE,64-4
        ADD     HL,DE
        POP     DE
        JR      EBA4
EXP     LD      A,(BASE)
        CP      2
        RET     NZ
        LD      A,3
        LD      (BASE),A
        CALL    SONH5
        LD      BC,0
        CALL    PAUSE
        LD      A,(PLAY)
        CP      1
        JR      NZ,EXP1
        LD      A,(SHP1)
        JR      EXP2
EXP1    LD      A,(SHP2)
EXP2    OR      A
        JP      Z,MUSIC
        RET
SONH5   LD      L,1
EXP0    LD      A,1
        OUT     (255),A
        LD      B,L
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      B,L
        DJNZ    $
        INC     L
        JR      NZ,EXP0
        RET
MBASE   LD      A,(BASE)
        OR      A
        JR      NZ,MBASE0
        LD      A,(WBAS)
        OR      A
        JR      NZ,MBASE1
        LD      A,1
        LD      (BASE),A
        RET
MBASE1  DEC     A
        LD      (WBAS),A
        RET
MBASE0  CP      1
        RET     NZ
        LD      A,(BADIR)
        BIT     0,A
        JR      NZ,MBA0
        CALL    MBAY
        CALL    MBAX
        RET
MBA0    CALL    MBAX
        CALL    MBAY
        RET
MBAX    LD      H,0
ADDL    LD      A,(3840H)
KEYL    AND     20H
        LD      B,A
        IN      A,(0)
        CPL
        AND     4
        OR      B
        JR      Z,ADDR
        DEC     H
ADDR    LD      A,(3840H)
KEYR    AND     40H
        LD      B,A
        IN      A,(0)
        CPL
        AND     8
        OR      B
        JR      Z,MBH
        INC     H
MBH     LD      A,(DEMO)
        OR      A
        JR      Z,MBH0
        LD      A,(DEMDIR)
        CP      3
        JR      NZ,MBH1
        DEC     H
        JR      MBH0
MBH1    CP      1
        JR      NZ,MBH0
        INC     H
MBH0    LD      A,H
        OR      A
        RET     Z
        JP      P,MBAR
        LD      A,(DECX)
        OR      A
        JR      Z,MBA2
MBA3    DEC     A
        LD      (DECX),A
        CP      256-24
        JR      NZ,MBA1
        XOR     A
        LD      (DECX),A
        LD      A,(BAX)
        DEC     A
        LD      (BAX),A
MBA1    LD      DE,0FF00H
        LD      A,4
        LD      (BADIR),A
        JP      MOVBR
MBA2    LD      A,(DECY)
        OR      A
        RET     NZ
        LD      A,(BAX)
        OR      A
        RET     Z
        LD      HL,(BAHL)
        INC     HL
        LD      A,(HL)
        AND     0B0H
        CP      0B0H
        RET     NZ
        LD      A,(DECX)
        JR      MBA3
MBAR    LD      A,(DECX)
        OR      A
        JR      Z,MBA6
MBA4    INC     A
        LD      (DECX),A
        CP      24
        JR      NZ,MBA5
        XOR     A
        LD      (DECX),A
        LD      A,(BAX)
        INC     A
        LD      (BAX),A
MBA5    LD      DE,100H
        LD      A,2
        LD      (BADIR),A
        JR      MOVBR
MBA6    LD      A,(DECY)
        OR      A
        RET     NZ
        LD      A,(BAX)
        CP      5
        RET     Z
        LD      HL,(BAHL)
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        AND     0B0H
        CP      0B0H
        RET     NZ
        LD      A,(DECX)
        JR      MBA4
MOVBR   LD      A,(BAC)
        LD      B,A
        LD      HL,(BAHL)
        CALL    MOVE
        LD      (BAHL),HL
        LD      A,B
        LD      (BAC),A
        POP     HL
        RET
MBAY    LD      H,0
ADDU    LD      A,(3840H)
KEYU    AND     8
        LD      B,A
        IN      A,(0)
        CPL
        AND     1
        OR      B
        JR      Z,ADDD
        DEC     H
ADDD    LD      A,(3840H)
KEYD    AND     10H
        LD      B,A
        IN      A,(0)
        CPL
        AND     2
        OR      B
        JR      Z,MBV
        INC     H
MBV     LD      A,(DEMO)
        OR      A
        JR      Z,MBV0
        LD      A,(DEMDIR)
        CP      0
        JR      NZ,MBV1
        DEC     H
        JR      MBV0
MBV1    CP      2
        JR      NZ,MBV0
        INC     H
MBV0    LD      A,H
        OR      A
        RET     Z
        JP      P,MBAD
        LD      A,(DECY)
        OR      A
        JR      Z,MBA9
MBA7    LD      B,A
        LD      A,(ALTA)
        AND     1
        LD      A,B
        JR      NZ,MBA7B
        POP     HL
        RET
MBA7B   DEC     A
        LD      (DECY),A
        CP      256-3
        JR      NZ,MBA8
        XOR     A
        LD      (DECY),A
        LD      A,(BAY)
        DEC     A
        LD      (BAY),A
MBA8    LD      DE,0FFH
        LD      A,1
        LD      (BADIR),A
        JP      MOVBR
MBA9    LD      A,(DECX)
        OR      A
        RET     NZ
        LD      A,(BAY)
        OR      A
        RET     Z
        LD      A,(DECY)
        JR      MBA7
MBAD    LD      A,(DECY)
        OR      A
        JR      Z,MBA12
MBA10   LD      B,A
        LD      A,(ALTA)
        AND     1
        LD      A,B
        JR      NZ,MBA10B
        POP     HL
        RET
MBA10B  INC     A
        LD      (DECY),A
        CP      3
        JR      NZ,MBA11
        XOR     A
        LD      (DECY),A
        LD      A,(BAY)
        INC     A
        LD      (BAY),A
MBA11   LD      DE,1
        LD      A,3
        LD      (BADIR),A
        JP      MOVBR
MBA12   LD      A,(DECX)
        OR      A
        RET     NZ
        LD      A,(BAY)
        CP      13
        RET     Z
        LD      A,(DECY)
        JR      MBA10
MHOLE   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(DECY)
        OR      A
        RET     NZ
        LD      A,(DECX)
        OR      A
        JP      P,MHO0
        ADD     A,24
MHO0    OR      A
        JR      Z,MHO1
        CP      6
        JR      Z,MHO1
        CP      12
        JR      Z,MHO1
        CP      18
        RET     NZ
MHO1    LD      HL,(BAHL)
        INC     HL
        INC     HL
        LD      A,(HL)
        AND     0B0H
        CP      80H
        RET     NZ
        LD      A,(HL)
        OR      0B0H
        LD      (HL),A
        LD      A,1
        LD      (FTROU),A
        LD      A,(PHASE)
        BIT     0,A
        JR      Z,MHO3
        LD      A,1
        CALL    ADDPO
MHO3    RET
VCARRE  LD      IX,TABON
        LD      B,20
VCA0    PUSH    BC
        BIT     0,(IX)
        JR      NZ,VCA3
        LD      A,(FTROU)
        OR      A
        JR      Z,VCA1
        LD      L,(IX+1)
        LD      H,(IX+2)
        PUSH    HL
        CALL    CARRE
        POP     HL
        JR      NZ,VCA1
        CALL    FCARRE
        CALL    PCARRE
        CALL    SONCAR
        SET     0,(IX)
        LD      HL,NHOLE
        DEC     (HL)
        JR      VCA3
VCA1    LD      A,(PHASE)
        BIT     0,A
        JR      NZ,VCA3
        BIT     1,(IX)
        JR      Z,VCA2
        CALL    DECAR
        JR      VCA3
VCA2    LD      A,(FTROU)
        OR      A
        JR      Z,VCA3
        LD      L,(IX+1)
        LD      H,(IX+2)
        CALL    CCARRE
        JR      NZ,VCA3
        SET     1,(IX)
VCA3    LD      DE,6
        ADD     IX,DE
        POP     BC
        DJNZ    VCA0
        XOR     A
        LD      (FTROU),A
        RET
SONCAR  LD      L,32
        XOR     A
SOR0    XOR     1
        OUT     (255),A
        LD      B,L
        DJNZ    $
        DEC     L
        JR      NZ,SOR0
        RET
CARRE   CALL    LIGNE
        RET     NZ
        LD      DE,65
CAR0    ADD     HL,DE
        TROU
        DEC     HL
        JR      Z,CAR1
        CALL    LIGE
        RET     NZ
        JR      CAR0
CAR1    CALL    LIGNE
        RET
LIGNE   PUSH    HL
        LD      B,5
LIG0    TROU
        JR      NZ,LIG1
        INC     HL
        INC     HL
        INC     HL
        DJNZ    LIG0
LIG1    POP     HL
        RET
LIGE    TROU
        RET     NZ
        PUSH    HL
        LD      BC,12
        ADD     HL,BC
        TROU
        POP     HL
        RET
FCARRE  INC     HL
        LD      C,0A6H
        LD      DE,64
FCA0    ADD     HL,DE
        PUSH    HL
        LD      B,11
FCA1    LD      A,(HL)
        OR      C
        LD      (HL),A
        INC     HL
        DJNZ    FCA1
        POP     HL
        TROU
        RET     Z
        LD      A,C
        XOR     3FH
        LD      C,A
        JR      FCA0
BONOS   DEFM    '000000'
PCARRE  LD      A,(PHASE)
        BIT     0,A
        RET     NZ
        LD      A,(IX+3)
        LD      (BONOS+3),A
        LD      A,(IX+4)
        LD      (BONOS+4),A
        LD      A,(IX+5)
        LD      (BONOS+5),A
        CALL    SCOR12
        LD      BC,5
        ADD     HL,BC
        LD      DE,BONOS+5
PCA0    LD      A,(DE)
        SUB     '0'
        ADD     A,(HL)
        ADD     A,B
        CP      '9'+1
        JR      C,PCA3
        LD      B,1
        SUB     10
PCA1    CP      '9'+1
        JR      C,PCA2
        SUB     10
        INC     B
        JR      PCA1
PCA2    LD      (HL),A
        DEC     C
        DEC     HL
        DEC     DE
        JP      P,PCA0
        RET
PCA3    LD      B,0
        JR      PCA2
DECAR   PUSH    IX
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        PUSH    HL
        LD      A,(HL)
        INC     HL
        OR      (HL)
        INC     HL
        OR      (HL)
        POP     HL
        CP      '0'
        RET     Z
        LD      BC,2
        ADD     HL,BC
DECA0   LD      A,(HL)
        DEC     A
        CP      '0'-1
        JR      NZ,DECA1
        ADD     A,10
        LD      (HL),A
        DEC     C
        DEC     HL
        JP      P,DECA0
        RET
DECA1   LD      (HL),A
        RET
CCARRE  PUSH    HL
        CALL    CHOR
        POP     HL
        RET     Z
        CALL    CVER
        RET
CHOR    PUSH    HL
        LD      DE,65
CHO0    ADD     HL,DE
        TROU
        DEC     HL
        JR      NZ,CHO0
        EX      DE,HL
        POP     HL
        LD      B,3
CHO1    INC     HL
        INC     HL
        INC     HL
        INC     DE
        INC     DE
        INC     DE
        TROU
        JR      NZ,CHO2
        LD      A,(DE)
        AND     0B0H
        CP      0B0H
        RET     Z
CHO2    DJNZ    CHO1
        RET
CVER    EX      DE,HL
        LD      HL,12
        ADD     HL,DE
        EX      DE,HL
        LD      BC,64
CVE0    EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        ADD     HL,BC
        INC     HL
        TROU
        DEC     HL
        JR      Z,CVE1
        TROU
        JR      NZ,CVE0
        LD      A,(DE)
        AND     0B0H
        CP      0B0H
        RET     Z
        JR      CVE0
CVE1    LD      A,1
        OR      A
        RET
MBASED  LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(DEMO)
        OR      A
        RET     Z
        LD      A,(DECX)
        LD      B,A
        LD      A,(DECY)
        OR      B
        RET     NZ
        LD      A,(DEMDIR)
        OR      A
        JR      Z,MDBU
        DEC     A
        JR      Z,MDBH
        DEC     A
        JR      Z,MDBU
        JR      MDBH
MDBU    CALL    TRN
        RET
MDBH    LD      A,(ALTA)
        AND     1
        JR      NZ,MDBZ
        LD      A,5
        LD      (DEMDIR),A
        RET
MDBZ    LD      A,(DEMF)
        OR      A
        JR      NZ,MDB1
        LD      A,(BAY)
        OR      A
        JR      Z,MDB2
MDB0    XOR     A
        LD      (DEMDIR),A
        LD      (DEMF),A
        RET
MDB1    LD      A,(BAY)
        CP      13
        JR      Z,MDB0
MDB2    LD      A,2
        LD      (DEMDIR),A
        LD      A,1
        LD      (DEMF),A
        RET
TRN     RANDOM  0,1
        OR      A
        JR      NZ,TRN0
        CALL    TRNL
        CALL    TRNR
        RET
TRN0    CALL    TRNR
        CALL    TRNL
        RET
TRNL    LD      HL,(BAHL)
        INC     HL
        LD      A,(HL)
        AND     0B0H
        CP      0B0H
        RET     NZ
        POP     HL
        POP     HL
        LD      A,3
        LD      (DEMDIR),A
        RET
TRNR    LD      HL,(BAHL)
        INC     HL
        INC     HL
        INC     HL
        LD      A,(HL)
        AND     0B0H
        CP      0B0H
        RET     NZ
        POP     HL
        POP     HL
        LD      A,1
        LD      (DEMDIR),A
        RET
MUSIC   LD      IX,TABLE
        JR      MUSIQ
MUSIC0  LD      IX,TABLE0
MUSIQ   LD      IY,TMI
        LD      A,(125H)
        CP      'I'
        JR      NZ,MUS0
        LD      IY,TMIII
MUS0    LD      A,(IX)
        INC     IX
        CP      'A'
        JP      C,SILENT
        CP      'U'+1
        JP      NC,SILENT
        SUB     'A'
        SLA     A
        LD      B,A
        LD      A,(IX)
        CP      '#'
        JR      NZ,MUS1
        INC     IX
        JR      MUS2
MUS1    INC     B
MUS2    LD      A,B
        LD      (MUS3+2),A
MUS3    LD      A,(IY+0)
        LD      D,A
        LD      E,A
        LD      A,(IX)
        INC     IX
        CP      'A'
        JR      C,MUS4
        CP      'U'+1
        JR      NC,MUS4
        SUB     'A'
        SLA     A
        LD      B,A
        LD      A,(IX)
        CP      '#'
        JR      NZ,MUS5
        INC     IX
        JR      MUS6
MUS5    INC     B
MUS6    LD      A,B
        LD      (MUS7+2),A
MUS7    LD      A,(IY+0)
        LD      E,A
        LD      A,(IX)
        INC     IX
MUS4    CP      '1'
        RET     C
        CP      '5'+1
        RET     NC
        SUB     '1'
        SLA     A
        ADD     A,42
        LD      (MUS8+2),A
        INC     A
        LD      (MUS9+2),A
MUS8    LD      L,(IY+0)
MUS9    LD      H,(IY+0)
        LD      A,(IX)
        CP      '.'
        JR      NZ,MUS10
        INC     IX
        PUSH    HL
        POP     BC
        SRL     B
        RR      C
        ADD     HL,BC
MUS10   LD      B,D
        LD      C,E
        LD      A,1
MUS11   DEC     C
        JP      NZ,MUS12
        LD      C,E
        XOR     1
        OUT     (255),A
MUS12   DJNZ    MUS13
        LD      B,D
        XOR     2
        OUT     (255),A
MUS13   DEC     L
        JP      NZ,MUS11
        DEC     H
        JP      NZ,MUS11
        JP      MUS0
SILENT  CP      '<'
        RET     NZ
        LD      A,(IX)
        INC     IX
        CP      '1'
        RET     C
        CP      '5'+1
        RET     NC
        SUB     '1'
        SLA     A
        ADD     A,42
        LD      (SIL0+2),A
        INC     A
        LD      (SIL1+2),A
SIL0    LD      L,(IY+0)
SIL1    LD      H,(IY+0)
        LD      A,(IX)
        CP      '.'
        JR      NZ,SIL2
        INC     IX
        PUSH    HL
        POP     BC
        SRL     B
        RR      C
        ADD     HL,BC
SIL2    LD      (0),HL
        DEC     HL
        LD      A,H
        OR      L
        JR      NZ,SIL2
        JP      MUS0
TMI     DEFB    22
        DEFB    22
        DEFB    23
        DEFB    25
        DEFB    26
        DEFB    28
        DEFB    29
        DEFB    31
        DEFB    33
        DEFB    33
        DEFB    35
        DEFB    37
        DEFB    39
        DEFB    41
        DEFB    44
        DEFB    44
        DEFB    46
        DEFB    49
        DEFB    52
        DEFB    55
        DEFB    58
        DEFB    62
        DEFB    66
        DEFB    66
        DEFB    69
        DEFB    74
        DEFB    78
        DEFB    83
        DEFB    87
        DEFB    87
        DEFB    93
        DEFB    98
        DEFB    104
        DEFB    110
        DEFB    117
        DEFB    124
        DEFB    131
        DEFB    131
        DEFB    139
        DEFB    147
        DEFB    156
        DEFB    165
        DEFW    43171
        DEFW    21586
        DEFW    10793
        DEFW    5396
        DEFW    7195
TMIII   DEFB    25
        DEFB    25
        DEFB    27
        DEFB    28
        DEFB    30
        DEFB    32
        DEFB    33
        DEFB    35
        DEFB    37
        DEFB    37
        DEFB    40
        DEFB    42
        DEFB    45
        DEFB    47
        DEFB    50
        DEFB    50
        DEFB    53
        DEFB    56
        DEFB    60
        DEFB    63
        DEFB    67
        DEFB    71
        DEFB    75
        DEFB    75
        DEFB    80
        DEFB    84
        DEFB    89
        DEFB    95
        DEFB    100
        DEFB    100
        DEFB    106
        DEFB    112
        DEFB    119
        DEFB    126
        DEFB    134
        DEFB    142
        DEFB    150
        DEFB    150
        DEFB    159
        DEFB    169
        DEFB    179
        DEFB    189
        DEFW    49452
        DEFW    24726
        DEFW    12363
        DEFW    6182
        DEFW    8242
TABLE   DEFM    'J4I5J4I#U5U4I#S5S4I#Q5Q4I#P5P4I#'
        DEFM    'N5N4M#P5P4LQ5Q4QT5Q4I#U5U4IS5S4J'
        DEFM    'Q5Q4LP5P4I#N5N4M#P5P4LQ5Q4SU5S4F'
        DEFM    '#R5R4FP5P4GN5N4IM5M4F#K5K4FM5M4G'
        DEFM    'N5N4M#P5P4LU5U4SU5U4SQ5U4PR5U4P#'
        DEFM    'Q5U4PR5U4QS5U4T#5S4HQ5Q4I#O5O4HM'
        DEFM    '5M4I#L5L4HK5K4IL5L4JM5M4M#O5O4NS'
        DEFM    '5JO4K#P#5JO4J#N5IN#4I#M5HM#4GL5<'
        DEFM    '4M#R#3LQ2$'
TABLE0  DEFM    'NS3LQ5JN4NS3LQ5JN4KP3IN5GK4KP3IN'
        DEFM    '5GK4JO3HM5FJ4JO3HM5FJ4GL5IM4JN5L'
        DEFM    'Q4NS2NS3LQ5JN4NS3LQ5JN4KP3IN5GK4'
        DEFM    'KP3IN5GK4JO3HM5FJ4JO3HM5FJ4GL5JM'
        DEFM    '4IK5HJ4GJ2$'
BONUS0  LD      A,(PHASE)
        BIT     0,A
        RET     Z
        CALL    SCOR12
        LD      BC,4
        ADD     HL,BC
        LD      DE,BONUS+4
BUN0    LD      A,(DE)
        SUB     '0'
        ADD     A,(HL)
        ADD     A,B
        CP      '9'+1
        JR      C,BUN3
        LD      B,1
        SUB     10
BUN1    CP      '9'+1
        JR      C,BUN2
        SUB     10
        INC     B
        JR      BUN1
BUN3    LD      B,0
BUN2    LD      (HL),A
        DEC     C
        DEC     HL
        DEC     DE
        JP      P,BUN0
        LD      HL,BONUS
        LD      DE,BONUS+1
        LD      BC,5
        LD      (HL),'0'
        LDIR
        RET
DBONUS  LD      A,(PHASE)
        BIT     0,A
        RET     Z
        LD      HL,TBON
        LD      DE,SCR+960+14
        LD      B,8
DBO0    LD      A,(HL)
        CALL    DISA
        INC     DE
        INC     HL
        DJNZ    DBO0
        LD      HL,BONUS
        LD      B,6
DBO1    LD      A,(HL)
        INC     HL
        CP      '0'
        JR      NZ,DBO3
        DJNZ    DBO1
        CALL    DISA
        RET
DBO2    LD      A,(HL)
        INC     HL
DBO3    CALL    DISA
        INC     DE
        DJNZ    DBO2
        RET
TBON    DEFM    'BONUS : '
MBONUS  LD      A,(PHASE)
        BIT     0,A
        RET     Z
        LD      A,(BASE)
        CP      1
        RET     NZ
MBO0    LD      A,0
        INC     A
        AND     7
        LD      (MBO0+1),A
        RET     NZ
        LD      HL,BONUS
        LD      BC,4
        ADD     HL,BC
MBO1    LD      A,(HL)
        DEC     A
        CP      '0'-1
        JR      NZ,MBO2
        ADD     A,10
        LD      (HL),A
        DEC     C
        DEC     HL
        JP      P,MBO1
        LD      HL,BONUS
        LD      DE,BONUS+1
        LD      BC,5
        LD      (HL),'0'
        LDIR
        JP      MBOS
MBO2    LD      (HL),A
        RET
