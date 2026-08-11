        TITLE   ### TIME RUNNER ###
;               -------------------
PROT    EQU     2
DISK    EQU     1
TAPE    EQU     0
TYPE    EQU     DISK
;
        COND    0!(TYPE=TAPE)!(TYPE=DISK)
        ORG     3C00H+44
        DEFB    191
        DEFM    ' TIME RUNNER     **'
        ORG     3C40H+44
        DEFB    191
        DEFM    ' TRS-80 - MOD I/III'
        ORG     3C80H+44
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        ENDC
        COND    TYPE=PROT
        ORG     4800H
        ENDC
        COND    TYPE=TAPE
        ORG     4280H
        ENDC
        COND    TYPE=DISK
        INCLUDE SYSMACRO
        ORG     8000H
        ENDC
        INCLUDE RUNNER1
        INCLUDE RUNNER2
BEGIN   LD      HL,STACK
        LD      SP,HL
        LD      A,(DEMO)
        OR      A
        JR      Z,BEG0
        LD      A,2
        LD      (NPLAY),A
        JR      BEG1
BEG0    LD      HL,0
        LD      (BLK1),HL
        LD      (BLK2),HL
BEG1    LD      A,1
        LD      (PLAY),A
        CALL    SCR191
        CALL    DISPL
        CALL    INITS
        CALL    CFIELD
        CALL    CFID2
        CALL    CLSSCR
        CALL    CLSTIR
        CALL    DALIEN
        CALL    DBASE
        CALL    DBAB
        CALL    DFIELD
        CALL    EFFAL
        CALL    EFFBAS
        CALL    DPHASE
        CALL    DBONUS
        CALL    DJUMP
        CALL    DCHIF
        CALL    DSCORE
        CALL    DHSCOR
        CALL    DIALOG
        CALL    DISPL
MAIN    CALL    CLSSCR
        CALL    BRKCLR
        CALL    DALIEN
        CALL    DBASE
        CALL    DBAB
        CALL    DFIELD
        CALL    EFFAL
        CALL    EFFBAS
        CALL    DPHASE
        CALL    DBONUS
        CALL    DJUMP
        CALL    DCHIF
        CALL    DSCORE
        CALL    DHSCOR
        CALL    DIALOG
        CALL    SCRVID
        CALL    EXP
        CALL    PROC
        CALL    JUMP
        CALL    MBASED
        CALL    MBASE
        CALL    NPHASE
        CALL    MBONUS
        CALL    TRACER
        CALL    MALIEN
        CALL    MHOLE
        CALL    VCARRE
        CALL    SKILL
        JR      MAIN
CFIELD  LD      HL,SCR1
        LD      DE,SCR1+1
        LD      BC,896-1
        LD      (HL),80H
        LDIR
        XOR     A
        LD      (COL1+2),A
        INC     A
        LD      (COL3+1),A
        LD      IX,TABHG
        LD      HL,SCR1+2
        LD      B,5
CFI0    PUSH    BC
        PUSH    HL
        CALL    COLONE
        POP     HL
        LD      DE,12
        ADD     HL,DE
        POP     BC
        DJNZ    CFI0
        LD      DE,64
        LD      B,13
CFI1    ADD     HL,DE
        LD      (HL),8FH
        DJNZ    CFI1
        LD      HL,SCR1+832+26
        LD      B,13
CFI2    LD      A,(HL)
        OR      0B0H
        LD      (HL),A
        INC     HL
        DJNZ    CFI2
        CALL    CBAD
        RET
COLONE  CALL    MURH
        LD      DE,64
        JR      COL1
COL0    LD      (COL1+2),A
COL1    LD      A,(IX+0)
COL2    ADD     HL,DE
        LD      (HL),8FH
        DEC     A
        JR      NZ,COL2
        CALL    MURH
        LD      A,(COL1+2)
COL3    ADD     A,1
        CP      256-1
        JR      Z,COL4
        CP      4
        JR      NZ,COL0
COL4    LD      A,(COL3+1)
        NEG
        LD      (COL3+1),A
        RET
MURH    PUSH    HL
        LD      B,4
MUH0    INC     HL
        LD      (HL),0B0H
        INC     HL
        LD      (HL),0B0H
        INC     HL
        DJNZ    MUH0
        POP     HL
        RET
DFIELD  LD      DE,SCR1
        LD      HL,SCR+64
        LD      BC,896
DFI0    LD      A,(DE)
        OR      (HL)
        LD      (HL),A
        INC     HL
        INC     DE
        DEC     C
        JP      NZ,DFI0
        LD      A,B
        OR      A
        RET     Z
        DEC     B
        JP      DFI0
DCHIF   LD      A,(PHASE)
        AND     1
        RET     NZ
        LD      IX,TABON
        LD      B,20
DCH0    PUSH    BC
        BIT     0,(IX)
        JR      NZ,DCH2
        LD      L,(IX+1)
        LD      H,(IX+2)
        LD      DE,SCR-SCR1+192+4
        ADD     HL,DE
        EX      DE,HL
        PUSH    IX
        POP     HL
        INC     HL
        INC     HL
        INC     HL
        LD      B,3
DCH1    LD      A,(HL)
        CALL    DISA
        INC     HL
        INC     DE
        INC     DE
        DJNZ    DCH1
DCH2    LD      DE,6
        ADD     IX,DE
        POP     BC
        DJNZ    DCH0
        RET
DALIEN  LD      IX,TALIEN
        LD      B,6
DAL0    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,DAL5
        CP      3
        JR      NC,DAL5
        DEC     A
        SLA     A
        SLA     A
        LD      E,A
        LD      D,0
        LD      A,(IX+4)
        AND     0FH
        CP      2
        JR      NC,DAL1
        INC     DE
        INC     DE
DAL1    LD      HL,TADD
        ADD     HL,DE
        EX      DE,HL
        LD      C,(IX+1)
        LD      B,0
        LD      HL,TCAL
        ADD     HL,BC
        LD      L,(HL)
        LD      H,0
        LD      A,(DE)
        LD      C,A
        INC     DE
        LD      A,(DE)
        LD      B,A
        ADD     HL,BC
        EX      DE,HL
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      BC,SCR-SCR1+64
        ADD     HL,BC
        LD      B,3
DAL2    LD      C,4
DAL3    LD      A,(DE)
        OR      (HL)
        LD      (HL),A
        INC     DE
        INC     HL
        DEC     C
        JR      NZ,DAL3
        DJNZ    DAL4
        JR      DAL5
DAL4    PUSH    DE
        LD      DE,64-4
        ADD     HL,DE
        POP     DE
        JR      DAL2
DAL5    LD      DE,9
        ADD     IX,DE
        POP     BC
        DJNZ    DAL0
        RET
        COND    TYPE=TAPE
TRCLN   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      H,40H
        LD      L,0E1H
        INC     H
        INC     L
        LD      A,(HL)
        DEC     A
        CP      79H
        JR      NZ,CLEAN
        INC     HL
        LD      A,(HL)
        DEC     A
        CP      7FH
        JR      NZ,CLEAN
        INC     HL
        LD      A,(HL)
        DEC     A
        CP      42H
        RET     Z
CLEAN   LD      HL,8000H
        LD      DE,4000H
        LD      BC,8000H
        LDIR
        RET
        ENDC
        COND    TYPE=PROT
TRCLN   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      H,44H
        LD      L,10H
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
        XOR     A
        LD      (HL),A
        CP      (HL)
        JP      Z,CLEANP
        DEC     HL
        LD      (HL),A
        CP      (HL)
        JP      NZ,CLEANP
        LD      A,(9000H)
        CP      0CDH
        JP      NZ,CLEANP
        RET
        ENDC
CBAD    LD      IX,TALIEN
        LD      A,(PHASE)
        AND     1
        XOR     1
        INC     A
        LD      (CBA0+3),A
        LD      HL,SCR1
        LD      B,0
CBA0    LD      (IX+0),0
        LD      (IX+1),1
        LD      (IX+4),12H
        LD      (IX+5),B
        LD      (IX+7),0
        LD      (IX+8),0
        PUSH    BC
        PUSH    HL
        RANDOM  0,7
        LD      (IX+6),A
        LD      B,A
        LD      DE,64
        CALL    MUL16
        POP     DE
        PUSH    DE
        ADD     HL,DE
        LD      (IX+2),L
        LD      (IX+3),H
        POP     HL
        LD      DE,12
        ADD     HL,DE
        POP     BC
        INC     B
        LD      A,B
        CP      6
        JR      Z,CBA1
        LD      DE,9
        ADD     IX,DE
        JR      CBA0
CBA1    LD      (IX+4),0
        LD      A,(PHASE)
        DEC     A
        SRL     A
        LD      B,A
        SLA     A
        SLA     A
        ADD     A,B
        SLA     A
        SLA     A
        NEG
        ADD     A,200
        LD      (TRACE),A
        LD      A,(PHASE)
        CP      5
        RET     NC
        XOR     A
        LD      (TALIEN),A
        LD      A,(PHASE)
        CP      3
        RET     NC
        XOR     A
        LD      (TALIEN+36),A
        RET
EFFAL   LD      IX,TALIEN
        LD      B,6
EFA0    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,EFA5
        DEC     A
        SLA     A
        SLA     A
        LD      E,A
        LD      D,0
        LD      A,(IX+4)
        AND     0FH
        CP      2
        JR      NC,EFA1
        INC     DE
        INC     DE
EFA1    LD      HL,TADD
        ADD     HL,DE
        EX      DE,HL
        LD      C,(IX+1)
        LD      B,0
        LD      HL,TCAL
        ADD     HL,BC
        LD      A,(HL)
        EXX
        LD      E,A
        LD      D,0
        LD      HL,TEFF
        ADD     HL,DE
        EXX
        LD      L,A
        LD      H,0
        LD      A,(DE)
        LD      C,A
        INC     DE
        LD      A,(DE)
        LD      B,A
        ADD     HL,BC
        EX      DE,HL
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      BC,SCR-SCR1+64
        ADD     HL,BC
        LD      B,3
EFA2    LD      C,4
EFA3    LD      A,(HL)
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
        JR      NZ,EFA3
        DJNZ    EFA4
        JR      EFA5
EFA4    PUSH    DE
        LD      DE,64-4
        ADD     HL,DE
        POP     DE
        JR      EFA2
EFA5    LD      DE,9
        ADD     IX,DE
        POP     BC
        DJNZ    EFA0
        RET
ALTA    DEFB    0
MALIEN  LD      A,(ALTA)
        XOR     1
        LD      (ALTA),A
        LD      A,(JMP)
        OR      A
        RET     NZ
        LD      IX,TALIEN
        LD      B,6
MAL0    PUSH    BC
        LD      A,(IX)
        OR      A
        JP      Z,MAL1
        CP      3
        JP      NC,MAL5
MALK    LD      A,(IX+7)
        OR      A
        JP      Z,MAL2
        LD      A,(IX+4)
        AND     0FH
        JR      Z,MALU
        DEC     A
        JR      Z,MALR
        DEC     A
        JR      Z,MALD
        JR      MALL
MALU    LD      A,(ALTA)
        AND     1
        JR      Z,MAL1
MALU1   DEC     (IX+7)
        LD      A,(IX+7)
        CP      256-3
        JR      NZ,MALU0
        LD      (IX+7),0
        DEC     (IX+6)
MALU0   LD      DE,0FFH
        JR      MOVER
MALD    LD      A,(ALTA)
        AND     1
        JR      Z,MAL1
MALD1   INC     (IX+7)
        LD      A,(IX+7)
        CP      3
        JR      NZ,MALD0
        LD      (IX+7),0
        INC     (IX+6)
MALD0   LD      DE,1
        JR      MOVER
MALR    INC     (IX+7)
        LD      A,(IX+7)
        CP      24
        JR      NZ,MALR0
        LD      (IX+7),0
        INC     (IX+5)
MALR0   LD      DE,100H
        JR      MOVER
MALL    DEC     (IX+7)
        LD      A,(IX+7)
        CP      256-24
        JR      NZ,MALL0
        LD      (IX+7),0
        DEC     (IX+5)
MALL0   LD      DE,0FF00H
MOVER   LD      B,(IX+1)
        LD      L,(IX+2)
        LD      H,(IX+3)
        CALL    MOVE
        LD      (IX+3),H
        LD      (IX+2),L
        LD      (IX+1),B
MAL1    LD      DE,9
        ADD     IX,DE
        POP     BC
        DEC     B
        JP      NZ,MAL0
        RET
MAL2    POP     BC
        PUSH    BC
        LD      A,B
        CP      1
        JP      Z,MAL2T
        LD      A,(IX+4)
        AND     0FH
        JR      Z,MALUI
        DEC     A
        JR      Z,MALRI
        DEC     A
        JR      Z,MALDI
        JR      MALLI
MALUI   CALL    TURN
        JP      MALU
MALDI   CALL    TURN
        JP      MALD
MALLI   BIT     4,(IX+4)
        JR      NZ,MALLI0
        LD      A,(IX+6)
        OR      A
        JR      Z,MAL4
MAL3    LD      (IX+4),0
        JP      MALU1
MAL4    LD      A,(IX+4)
        XOR     10H
        LD      (IX+4),A
        LD      A,(IX+5)
        OR      A
        JR      Z,MAL6
        JP      MALL
MALLI0  LD      A,(IX+6)
        CP      13
        JR      Z,MAL7
MAL6    LD      (IX+4),12H
        JP      MALD1
MAL7    LD      A,(IX+4)
        XOR     10H
        LD      (IX+4),A
        LD      A,(IX+5)
        OR      A
        JR      Z,MAL3
        JP      MALL
MALRI   BIT     4,(IX+4)
        JR      NZ,MALRI0
        LD      A,(IX+6)
        OR      A
        JR      Z,MAL9
MAL8    LD      (IX+4),0
        JP      MALU1
MAL9    LD      A,(IX+4)
        XOR     10H
        LD      (IX+4),A
        LD      A,(IX+5)
        CP      5
        JR      Z,MAL10
        JP      MALR
MALRI0  LD      A,(IX+6)
        CP      13
        JR      Z,MAL11
MAL10   LD      (IX+4),12H
        JP      MALD1
MAL11   LD      A,(IX+4)
        XOR     10H
        LD      (IX+4),A
        LD      A,(IX+5)
        CP      5
        JR      Z,MAL8
        JP      MALR
TURN    RANDOM  0,1
        OR      A
        JR      NZ,TURN0
        CALL    TURNL
        CALL    TURNR
        RET
TURN0   CALL    TURNR
        CALL    TURNL
        RET
TURNL   LD      L,(IX+2)
        LD      H,(IX+3)
        INC     HL
        LD      A,(HL)
        AND     0B0H
        CP      0B0H
        RET     NZ
        POP     HL
        POP     HL
        LD      A,(IX+4)
        AND     0F0H
        OR      3
        LD      (IX+4),A
        JP      MALL
TURNR   LD      L,(IX+2)
        LD      H,(IX+3)
        LD      DE,3
        ADD     HL,DE
        LD      A,(HL)
        AND     0B0H
        CP      0B0H
        RET     NZ
        POP     HL
        POP     HL
        LD      A,(IX+4)
        AND     0F0H
        OR      1
        LD      (IX+4),A
        JP      MALR
MAL5    CP      7
        JR      NC,MAL13
        DEC     (IX+8)
        LD      A,(IX+8)
        CP      33
        JP      NC,MALK
        OR      A
        JR      Z,MAL12
        AND     3
        JP      NZ,MALK
        BIT     2,(IX+8)
        JR      NZ,MAL12
        LD      A,(IX)
        ADD     A,2
        LD      (IX),A
        JP      MALK
MAL12   LD      A,(IX)
        SUB     2
        LD      (IX),A
        JP      MALK
MAL13   BIT     0,(IX+4)
        JR      Z,MAL14
        LD      A,(IX+7)
        OR      A
        JR      Z,MAL14
MAL15   DEC     (IX+8)
        JP      NZ,MAL1
        DEC     (IX+6)
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      DE,-64
        ADD     HL,DE
        LD      (IX+2),L
        LD      (IX+3),H
        LD      A,(IX)
        SUB     6
        LD      (IX),A
        POP     BC
        PUSH    BC
        LD      A,B
        CP      1
        JP      NZ,MAL1
        LD      A,(IX+6)
        OR      A
        JP      Z,MAL1
        CP      13
        JP      NZ,MAL1
        LD      A,(TRACE)
        OR      A
        JR      Z,MAL15T
        LD      (IX+4),1
        JP      MAL1
MAL14   LD      A,(IX+6)
        CP      14
        JR      Z,MAL15
        LD      (IX+4),12H
        JP      MALD1
MAL15T  LD      A,1
        LD      (TRACE),A
        LD      (IX+4),1
        JP      MAL1
MAL2T   LD      A,(TRACE)
        OR      A
        JP      Z,MAL17
        DEC     A
        LD      (TRACE),A
        JR      Z,MAL16
MAL16R  LD      A,(IX+4)
        AND     0FH
        JR      Z,MLTU
        DEC     A
        JR      Z,MLTR
        DEC     A
        JR      Z,MLTD
        JR      MLTL
MLTU    LD      A,(IX+6)
        OR      A
        JP      NZ,MALU
        LD      (IX+4),3
        JP      MALL
MLTD    LD      A,(IX+6)
        CP      13
        JP      NZ,MALD
        LD      (IX+4),1
        JP      MALR
MLTL    LD      A,(IX+5)
        OR      A
        JP      NZ,MALL
        LD      (IX+4),2
        JP      MALD1
MLTR    LD      A,(IX+5)
        CP      5
        JP      NZ,MALR
        LD      (IX+4),0
        JP      MALU1
MAL16   LD      A,(IX+6)
        OR      A
        JR      Z,MAL16B
        CP      13
        JR      Z,MAL16B
        LD      A,1
        LD      (TRACE),A
        JR      MAL16R
MAL16B  LD      HL,TABTRA
        LD      (POSTA),HL
        LD      A,(BAX)
        LD      (HL),A
        INC     HL
        LD      A,(BAY)
        LD      (HL),A
        JP      MAL1
MAL17   LD      A,(TABTRA)
        CP      (IX+5)
        JR      Z,MAL19
        JR      NC,MAL18
MAL23   LD      (IX+4),3
        JP      MALL
MAL18   LD      (IX+4),1
        JP      MALR
MAL19   LD      A,(TABTRA+1)
        CP      (IX+6)
        JR      Z,MAL21
        JR      NC,MAL20
        LD      (IX+4),0
        JP      MALU
MAL20   LD      (IX+4),2
        JP      MALD
MAL21   LD      HL,(POSTA)
        LD      DE,TABTRA
        OR      A
        SBC     HL,DE
        JP      Z,MAL22
        LD      HL,(POSTA)
        DEC     HL
        DEC     HL
        LD      (POSTA),HL
        LD      HL,TABTRA+2
        LD      DE,TABTRA
        LD      BC,50*2-2
        LDIR
        JR      MAL17
MAL22   LD      A,(BASE)
        CP      1
        JP      NZ,MAL1
        LD      A,(DECX)
        OR      A
        JP      Z,MAL1
        JP      P,MAL18
        JP      MAL23
DBAB    LD      IX,TALIEN
        LD      B,6
DBA0    PUSH    BC
        LD      A,(IX)
        CP      3
        JP      C,DBA8
        CP      7
        JP      NC,DBA8
        DEC     A
        SLA     A
        SLA     A
        LD      E,A
        LD      D,0
        LD      HL,TADD
        ADD     HL,DE
        EX      DE,HL
        LD      C,(IX+1)
        LD      B,0
        LD      HL,TCAL
        ADD     HL,BC
        LD      L,(HL)
        LD      H,0
        LD      A,(DE)
        LD      C,A
        INC     DE
        LD      A,(DE)
        LD      B,A
        ADD     HL,BC
        EX      DE,HL
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      BC,SCRTIR-SCR1+64
        ADD     HL,BC
        EXX
        LD      E,0
        EXX
        LD      B,3
DBA1    LD      C,4
DBA2    LD      A,(DE)
        AND     (HL)
        EXX
        OR      E
        LD      E,A
        EXX
        INC     DE
        INC     HL
        DEC     C
        JR      NZ,DBA2
        DJNZ    DBA3
        JR      DBA4
DBA3    PUSH    DE
        LD      DE,64-4
        ADD     HL,DE
        POP     DE
        JR      DBA1
DBA4    EXX
        LD      A,E
        AND     3FH
        JR      Z,DBA8
        LD      A,(JMP)
        OR      A
        JR      NZ,DBA8
        LD      IY,TALIEN
        LD      BC,602H
DBA5    LD      A,(IY)
        CP      7
        JR      C,DBA6
        CP      9
        JR      NC,DBA6
        INC     C
DBA6    LD      DE,9
        ADD     IY,DE
        DJNZ    DBA5
        LD      A,C
        CALL    ADDPO
        INC     (IX+6)
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      DE,64
        ADD     HL,DE
        LD      (IX+2),L
        LD      (IX+3),H
        LD      (IX+8),150
        LD      A,(IX)
        AND     1
        NEG
        ADD     A,8
        LD      (IX),A
        CALL    INVERT
        LD      C,80
        XOR     A
DBA7    XOR     1
        OUT     (255),A
        LD      B,40
        DJNZ    $
        DEC     C
        JR      NZ,DBA7
DBA8    LD      DE,9
        ADD     IX,DE
        POP     BC
        DEC     B
        JP      NZ,DBA0
        RET
DJUMP   LD      HL,TABJ
        LD      DE,SCR+960+55
        LD      B,5
DJU0    LD      A,(HL)
        CALL    DISA
        INC     HL
        INC     DE
        DJNZ    DJU0
        LD      A,(JMPN)
DJU1    OR      A
        RET     Z
        EX      AF,AF'
        LD      A,'*'
        CALL    DISA
        INC     DE
        EX      AF,AF'
        DEC     A
        JR      DJU1
TABJ    DEFM    'JUMP '
DPHASE  LD      A,(PHASE)
        LD      L,A
        LD      H,0
        LD      DE,BUFP
        CALL    BXDECL
        LD      HL,TABP
        LD      DE,SCR+960+2
        LD      B,6
DPH0    LD      A,(HL)
        CALL    DISA
        INC     HL
        INC     DE
        DJNZ    DPH0
        LD      HL,BUFP
        LD      B,5
DPH1    LD      A,(HL)
        INC     HL
        CP      '0'
        JR      NZ,DPH3
        DJNZ    DPH1
        CALL    DISA
        RET
DPH2    LD      A,(HL)
        INC     HL
DPH3    CALL    DISA
        INC     DE
        DJNZ    DPH2
        RET
TABP    DEFM    'PHASE '
BUFP    DEFM    '00000'
BXDECL  LD      BC,-10000
        JR      SUBPWR
BXD010  LD      BC,-1000
        JR      SUBPWR
BXD020  LD      BC,-100
        JR      SUBPWR
BXD030  LD      BC,-10
        JR      SUBPWR
BXD040  LD      BC,-1
        JR      SUBPWR
BXD050  RET
SUBPWR  LD      A,0FFH
SUB010  INC     A
        ADD     HL,BC
        JR      C,SUB010
        OR      A
        SBC     HL,BC
        ADD     A,30H
        LD      (DE),A
        INC     DE
        LD      A,C
        CP      0F0H
        JR      Z,BXD010
        CP      18H
        JR      Z,BXD020
        CP      9CH
        JR      Z,BXD030
        CP      0F6H
        JR      Z,BXD040
        JR      BXD050
JUMP    LD      A,(JMP)
        OR      A
        JR      NZ,JUM1
        LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(JMPN)
        OR      A
        RET     Z
ADDF    LD      A,(3840H)
KEYF    AND     80H
        JR      NZ,JUM0
        IN      A,(0)
        CPL
        BIT     4,A
        JR      NZ,JUM0
        AND     3
        CP      3
        RET     NZ
JUM0    LD      A,(JMPN)
        DEC     A
        LD      (JMPN),A
JUM1    LD      A,(JMP)
        INC     A
        LD      (JMP),A
        CP      3
        RET     Z
        CP      5
        RET     Z
        CP      6
        RET     Z
        CP      8
        RET     Z
        CP      12
        RET     Z
        CP      11
        JR      Z,JUM2
        CP      5
        JR      NC,JUM6
JUM2    LD      IX,TALIEN
        LD      B,6
JUM3    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,JUM5
        CP      3
        JR      NC,JUM4
        ADD     A,4
        LD      (IX),A
JUM4    CP      5
        JR      C,JUM5
        CP      7
        JR      NC,JUM5
        LD      DE,0FFH
        CALL    MOVR
JUM5    LD      DE,9
        ADD     IX,DE
        POP     BC
        DJNZ    JUM3
        RET
JUM6    LD      IX,TALIEN
        LD      B,6
JUM7    PUSH    BC
        LD      A,(IX)
        CP      5
        JR      C,JUM8
        CP      7
        JR      NC,JUM8
        LD      DE,1
        CALL    MOVR
JUM8    LD      DE,9
        ADD     IX,DE
        POP     BC
        DJNZ    JUM7
        LD      A,(JMP)
        CP      16
        RET     NZ
        XOR     A
        LD      (JMP),A
        LD      IX,TALIEN
        LD      B,6
JUM9    LD      A,(IX)
        CP      5
        JR      C,JUM10
        CP      7
        JR      NC,JUM10
        ADD     A,2
        LD      (IX),A
        LD      (IX+8),30
        INC     (IX+6)
JUM10   LD      DE,9
        ADD     IX,DE
        DJNZ    JUM9
        RET
MOVR    LD      B,(IX+1)
        LD      L,(IX+2)
        LD      H,(IX+3)
        CALL    MOVE
        LD      (IX+3),H
        LD      (IX+2),L
        LD      (IX+1),B
        RET
NPHASE  LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(NHOLE)
        OR      A
        RET     NZ
        CALL    BONUS0
        LD      A,(PHASE)
        INC     A
        CP      21
        JR      NZ,NPH0
        SUB     2
NPH0    LD      (PHASE),A
        CALL    INIT0
        LD      A,20
        LD      (NHOLE),A
        XOR     A
        LD      (FKILL),A
        CALL    CFIELD
        LD      BC,4000H
        CALL    PAUSE
        JP      MUSIC0
SKILL   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(FKILL)
        OR      A
        RET     NZ
        LD      A,(TABON)
        BIT     0,A
        RET     Z
        LD      A,(TABON+3*6)
        BIT     0,A
        RET     Z
        LD      A,(TABON+16*6)
        BIT     0,A
        RET     Z
        LD      A,(TABON+19*6)
        BIT     0,A
        RET     Z
        LD      A,1
        LD      (FKILL),A
        LD      IX,TALIEN
        LD      B,6
KIL0    LD      A,(IX)
        OR      A
        JR      Z,KIL1
        CP      3
        JR      NC,KIL1
        ADD     A,2
        LD      (IX),A
        LD      (IX+8),150
KIL1    LD      DE,9
        ADD     IX,DE
        DJNZ    KIL0
        RET
TRACER  LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(TRACE)
        OR      A
        RET     NZ
        LD      A,(DECX)
        LD      B,A
        LD      A,(DECY)
        OR      B
        RET     NZ
        LD      HL,(POSTA)
        LD      A,(BAX)
        CP      (HL)
        JR      NZ,TRC0
        INC     HL
        LD      A,(BAY)
        CP      (HL)
        RET     Z
TRC0    LD      HL,(POSTA)
        LD      DE,TABTRA+49*2
        OR      A
        SBC     HL,DE
        RET     Z
        LD      HL,(POSTA)
        INC     HL
        INC     HL
        LD      (POSTA),HL
        LD      A,(BAX)
        LD      (HL),A
        INC     HL
        LD      A,(BAY)
        LD      (HL),A
        RET
CFID2   LD      HL,SCR1
        LD      DE,SCR2
        LD      BC,896
        LDIR
        RET
        COND    0!(TYPE=DISK)!(TYPE=PROT)
        DEFM    '--( TIME RUNNER IS THE 7TH '
        DEFM    'PROGRAM OF Y. LEMPEREUR )--'
        END     DEBUT
        ENDC
        COND    TYPE=TAPE
        ORG     4321H
        JP      DEBUT
        END     CLEAN
        ENDC
