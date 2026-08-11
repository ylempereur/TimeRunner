RANDOM  MACRO   #MIN,#MAX
        LD      B,#MAX-#MIN+1
        CALL    RAND
        ADD     A,#MIN
        ENDM
EXIR    MACRO
XI#$YM  LD      A,(HL)
        EX      AF,AF'
        LD      A,(DE)
        LD      (HL),A
        EX      AF,AF'
        LD      (DE),A
        INC     HL
        INC     DE
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,XI#$YM
        ENDM
DINT    MACRO
        LD      A,0F0H
        OR      3
        LD      (IT#$YM),A
IT#$YM  NOP
        XOR     A
        LD      (IT#$YM),A
        ENDM
TROU    MACRO
        LD      A,(HL)
        AND     0B0H
        CP      0B0H
        ENDM
;---------------------------------
VIDEO   EQU     3C00H
STACK   EQU     $
SCR     DEFS    1024
        DEFS    64
SCRTIR  DEFS    1024
DCB     DEFS    64
SCR1    DEFS    896
SCR2    DEFS    896
TALIEN  DEFS    6*9
TABON   DEFS    20*6
TABON2  DEFS    20*6
TABTRA  DEFS    50*2
DEMO    DEFS    1
NPLAY   DEFS    1
HSCORE  EQU     $+10
TSCOR   DEFS    10*(10+6)
        COND    TYPE=PROT
        DEFS    96
        ENDC
SCORE1  DEFM    '000000'
SCORE2  DEFM    '000000'
SHP1    DEFB    0
SHP2    DEFB    0
LAST1   DEFB    '0'
LAST2   DEFB    '0'
PLAY    DEFB    0
PHASE   DEFB    0
NHOLE   DEFB    0
FKILL   DEFB    0
VAR2    DEFB    0
        DEFB    0
        DEFB    0
BLINK   DEFB    0
JMPN    DEFB    0
BASE    DEFB    0
BAX     DEFB    0
BAY     DEFB    0
BADIR   DEFB    0
DECX    DEFB    0
DECY    DEFB    0
BAHL    DEFW    0
BAC     DEFB    0
TRACE   DEFB    0
JMP     DEFB    0
PEBAS   DEFW    0
WBAS    DEFB    0
DEMDIR  DEFB    0
FTROU   DEFB    0
POSTA   DEFW    0
DEMF    DEFB    0
BONUS   DEFM    '000000'
TINIT   DEFM    '000000'
        DEFM    '000000'
        DEFB    3
        DEFB    3
        DEFB    '0'
        DEFB    '0'
        DEFB    1
        DEFB    1
        DEFB    20
        DEFB    0
        DEFB    1
        DEFB    20
        DEFB    0
        DEFB    0
TINIT1  DEFB    3
TINIT0  DEFB    0
        DEFB    2
        DEFB    13
        DEFB    0
        DEFB    12
        DEFB    0
        DEFW    SCR1+832+30
        DEFB    1
        DEFB    100
        DEFB    0
        DEFW    0
        DEFB    16
        DEFB    1
        DEFB    0
        DEFW    TABTRA
        DEFB    0
        DEFM    '003000'
TAMID   DEFW    8C88H   ; 1ST LINE
        DEFW    0BCBCH
        DEFW    8CBCH
        DEFW    0A884H
        DEFW    0BCBCH
        DEFW    0A894H
        DEFW    8CBCH
        DEFW    0BCACH
        DEFW    9CBCH
        DEFW    0BC8CH
        DEFW    0BCBCH
        DEFW    0BC80H
        DEFW    0BCBCH
        DEFW    8C8CH
        DEFB    8CH
        DEFW    8080H   ; 2ND LINE
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0AA95H
        DEFW    80BFH
        DEFW    0BFAAH
        DEFW    95BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    8C8CH
        DEFB    8CH
        DEFW    8080H   ; 3RD LINE
        DEFW    8F8FH
        DEFW    808FH
        DEFW    8A80H
        DEFW    8F8FH
        DEFW    8A85H
        DEFW    808FH
        DEFW    8F8AH
        DEFW    858FH
        DEFW    8F80H
        DEFW    8F8FH
        DEFW    8F80H
        DEFW    8F8FH
        DEFW    8C8CH
        DEFB    8CH
        DEFW    0BCA8H  ; 4TH LINE
        DEFW    9CBCH
        DEFW    0BC8CH
        DEFW    0A894H
        DEFW    0BCBCH
        DEFW    8094H
        DEFW    94BCH
        DEFW    0BCA8H
        DEFW    0AC8CH
        DEFW    0BCBCH
        DEFW    0A894H
        DEFW    8CBCH
        DEFW    0BCACH
        DEFW    94BCH
        DEFW    0BCA8H
        DEFW    9CBCH
        DEFW    8C8CH
        DEFW    0A884H
        DEFW    0BCBCH
        DEFW    8C9CH
        DEFW    94BCH
        DEFW    0BFAAH  ; 5TH LINE
        DEFW    0AD8FH
        DEFW    0BFBCH
        DEFW    0AA91H
        DEFW    0BFBFH
        DEFW    8095H
        DEFW    95BFH
        DEFW    0BFAAH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0AA95H
        DEFW    80BFH
        DEFW    0BFAAH
        DEFW    95BFH
        DEFW    0BFAAH
        DEFW    9DBFH
        DEFW    8C8CH
        DEFW    0AA84H
        DEFW    8FBFH
        DEFW    0BCADH
        DEFW    91BFH
        DEFW    8F8AH   ; 6TH LINE
        DEFW    8A80H
        DEFW    8F8FH
        DEFW    8A85H
        DEFW    8F8FH
        DEFW    8C8DH
        DEFW    858FH
        DEFW    8F8AH
        DEFW    8A80H
        DEFW    8F8FH
        DEFW    8A85H
        DEFW    808FH
        DEFW    8F8AH
        DEFW    858FH
        DEFW    8F8AH
        DEFW    8D8FH
        DEFW    8C8CH
        DEFW    8A84H
        DEFW    808FH
        DEFW    8F8AH
        DEFW    858FH
AMID0   DEFM    'By  Y. Lempereur'
        DEFM    'Copyright (C) 1982 by  Funsoft, Inc.'
        DEFM    '28611 Canwood, Agoura, CA 91301 (213) 991-6540'
ALI1L   DEFW    0BFA6H
        DEFW    84BBH
        DEFW    8588H
        DEFW    808DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BB88H
        DEFW    9DB7H
        DEFW    8E80H
        DEFW    848AH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BC98H
        DEFW    90ACH
        DEFW    97A2H
        DEFW    80B7H
        DEFW    8080H
        DEFW    8080H
        DEFW    0ACA0H
        DEFW    0B49CH
        DEFW    0BB80H
        DEFW    91ABH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B0A0H
        DEFW    80B0H
        DEFW    9F89H
        DEFW    819EH
        DEFW    8182H
        DEFW    8083H
        DEFW    0B080H
        DEFW    90B0H
        DEFW    0AE82H
        DEFW    87ADH
        DEFW    8380H
        DEFW    8182H
ALI1R   DEFW    0BBAEH
        DEFW    84B7H
        DEFW    8588H
        DEFW    808DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B788H
        DEFW    99BFH
        DEFW    8E80H
        DEFW    848AH
        DEFW    8080H
        DEFW    8080H
        DEFW    0ACB8H
        DEFW    909CH
        DEFW    97A2H
        DEFW    80B7H
        DEFW    8080H
        DEFW    8080H
        DEFW    9CA0H
        DEFW    0A4BCH
        DEFW    0BB80H
        DEFW    91ABH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B0A0H
        DEFW    80B0H
        DEFW    9E8BH
        DEFW    819DH
        DEFW    8182H
        DEFW    8083H
        DEFW    0B080H
        DEFW    90B0H
        DEFW    0AD82H
        DEFW    86AFH
        DEFW    8380H
        DEFW    8182H
ALI2    DEFW    0BBA7H
        DEFW    85B3H
        DEFW    8588H
        DEFW    808DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B38AH
        DEFW    9BB7H
        DEFW    8E80H
        DEFW    848AH
        DEFW    8080H
        DEFW    8080H
        DEFW    0AC9CH
        DEFW    948CH
        DEFW    97A2H
        DEFW    80B7H
        DEFW    8080H
        DEFW    8080H
        DEFW    8CA8H
        DEFW    0AC9CH
        DEFW    0BB80H
        DEFW    91ABH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B0B0H
        DEFW    90B0H
        DEFW    9E89H
        DEFW    819CH
        DEFW    8182H
        DEFW    8083H
        DEFW    0B0A0H
        DEFW    0B0B0H
        DEFW    0AC82H
        DEFW    86ADH
        DEFW    8380H
        DEFW    8182H
ALIRE   DEFW    0BFAEH
        DEFW    84BFH
        DEFW    8588H
        DEFW    808DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BF88H
        DEFW    9DBFH
        DEFW    8E80H
        DEFW    848AH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BCB8H
        DEFW    90BCH
        DEFW    97A2H
        DEFW    80B7H
        DEFW    8080H
        DEFW    8080H
        DEFW    0BCA0H
        DEFW    0B4BCH
        DEFW    0BB80H
        DEFW    91ABH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B0A0H
        DEFW    80B0H
        DEFW    9F8BH
        DEFW    819FH
        DEFW    8182H
        DEFW    8083H
        DEFW    0B080H
        DEFW    90B0H
        DEFW    0AF82H
        DEFW    87AFH
        DEFW    8380H
        DEFW    8182H
ALICE   DEFW    0BFAFH
        DEFW    85BFH
        DEFW    8588H
        DEFW    808DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BF8AH
        DEFW    9FBFH
        DEFW    8E80H
        DEFW    848AH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BCBCH
        DEFW    94BCH
        DEFW    97A2H
        DEFW    80B7H
        DEFW    8080H
        DEFW    8080H
        DEFW    0BCA8H
        DEFW    0BCBCH
        DEFW    0BB80H
        DEFW    91ABH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B0B0H
        DEFW    90B0H
        DEFW    9F8BH
        DEFW    819FH
        DEFW    8182H
        DEFW    8083H
        DEFW    0B0A0H
        DEFW    0B0B0H
        DEFW    0AF82H
        DEFW    87AFH
        DEFW    8380H
        DEFW    8182H
ALIRI   DEFW    0B5A2H
        DEFW    80B7H
        DEFW    8F89H
        DEFW    818EH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BB80H
        DEFW    91BAH
        DEFW    8D82H
        DEFW    868FH
        DEFW    8080H
        DEFW    8080H
        DEFW    9488H
        DEFW    809CH
        DEFW    0BFA6H
        DEFW    84BBH
        DEFW    8080H
        DEFW    8080H
        DEFW    0AC80H
        DEFW    84A8H
        DEFW    0B788H
        DEFW    99BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    90A0H
        DEFW    80B0H
        DEFW    0BD98H
        DEFW    90ADH
        DEFW    8382H
        DEFW    8083H
        DEFW    0B080H
        DEFW    90A0H
        DEFW    9EA0H
        DEFW    0A4BEH
        DEFW    8380H
        DEFW    8183H
ALICI   DEFW    0B5A2H
        DEFW    80B7H
        DEFW    8E8DH
        DEFW    858CH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BB80H
        DEFW    91BAH
        DEFW    8C8AH
        DEFW    8E8DH
        DEFW    8080H
        DEFW    8080H
        DEFW    9488H
        DEFW    809CH
        DEFW    0BBB6H
        DEFW    94B3H
        DEFW    8080H
        DEFW    8080H
        DEFW    0AC80H
        DEFW    84A8H
        DEFW    0B3A8H
        DEFW    0B9B7H
        DEFW    8080H
        DEFW    8080H
        DEFW    90A0H
        DEFW    80B0H
        DEFW    0AD98H
        DEFW    908DH
        DEFW    8383H
        DEFW    8183H
        DEFW    0B080H
        DEFW    90A0H
        DEFW    8EA0H
        DEFW    0A49EH
        DEFW    8382H
        DEFW    8383H
TEFF    DEFW    8080H
        DEFW    0AA80H
        DEFW    0B0B0H
        DEFW    0BAB0H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8095H
        DEFW    8080H
        DEFW    0B0B5H
        DEFW    0B0B0H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8383H
        DEFW    0AB83H
        DEFW    8080H
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8397H
        DEFW    8383H
        DEFW    8095H
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    0AF8FH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    0BCBCH
        DEFW    0BEBCH
        DEFW    8F9FH
        DEFW    8F8FH
        DEFW    8095H
        DEFW    8080H
        DEFW    0BCBDH
        DEFW    0BCBCH
TADD    DEFW    ALI1L
        DEFW    ALI1R
        DEFW    ALI2
        DEFW    ALI2
        DEFW    ALIRE
        DEFW    ALIRE
        DEFW    ALICE
        DEFW    ALICE
        DEFW    ALI1L
        DEFW    ALI1R
        DEFW    ALI2
        DEFW    ALI2
        DEFW    ALIRI
        DEFW    ALIRI
        DEFW    ALICI
        DEFW    ALICI
TCAL    DEFB    0*12
        DEFB    1*12
        DEFB    2*12
        DEFB    3*12
        DEFB    4*12
        DEFB    5*12
TABHG   DEFB    4
        DEFB    3
        DEFB    3
        DEFB    3
TABONI  DEFB    0
        DEFW    SCR1+2
        DEFM    '550'
        DEFB    0
        DEFW    SCR1+256+2
        DEFM    '300'
        DEFB    0
        DEFW    SCR1+448+2
        DEFM    '250'
        DEFB    0
        DEFW    SCR1+640+2
        DEFM    '200'
        DEFB    0
        DEFW    SCR1+14
        DEFM    '370'
        DEFB    0
        DEFW    SCR1+192+14
        DEFM    '320'
        DEFB    0
        DEFW    SCR1+384+14
        DEFM    '270'
        DEFB    0
        DEFW    SCR1+576+14
        DEFM    '400'
        DEFB    0
        DEFW    SCR1+26
        DEFM    '550'
        DEFB    0
        DEFW    SCR1+256+26
        DEFM    '300'
        DEFB    0
        DEFW    SCR1+448+26
        DEFM    '250'
        DEFB    0
        DEFW    SCR1+640+26
        DEFM    '200'
        DEFB    0
        DEFW    SCR1+38
        DEFM    '370'
        DEFB    0
        DEFW    SCR1+192+38
        DEFM    '320'
        DEFB    0
        DEFW    SCR1+384+38
        DEFM    '270'
        DEFB    0
        DEFW    SCR1+576+38
        DEFM    '400'
        DEFB    0
        DEFW    SCR1+50
        DEFM    '550'
        DEFB    0
        DEFW    SCR1+256+50
        DEFM    '300'
        DEFB    0
        DEFW    SCR1+448+50
        DEFM    '250'
        DEFB    0
        DEFW    SCR1+640+50
        DEFM    '200'
TBASE   DEFW    8FB6H
        DEFW    94BBH
        DEFW    8F8BH
        DEFW    818FH
        DEFW    8080H
        DEFW    8080H
        DEFW    9BA8H
        DEFW    0BDA7H
        DEFW    8F82H
        DEFW    878FH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BC98H
        DEFW    90ACH
        DEFW    0BCAFH
        DEFW    85BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0ACA0H
        DEFW    0B49CH
        DEFW    0BD8AH
        DEFW    9FBEH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B0A0H
        DEFW    80B0H
        DEFW    0B3BDH
        DEFW    95BEH
        DEFW    8382H
        DEFW    8083H
        DEFW    0B080H
        DEFW    90B0H
        DEFW    0B6AAH
        DEFW    0BFB9H
        DEFW    8380H
        DEFW    8183H
        DEFW    9BBEH
        DEFW    94A7H
        DEFW    8F8BH
        DEFW    818FH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B7A8H
        DEFW    0B98FH
        DEFW    8F82H
        DEFW    878FH
        DEFW    8080H
        DEFW    8080H
        DEFW    0ACB8H
        DEFW    909CH
        DEFW    0BDAFH
        DEFW    85BEH
        DEFW    8080H
        DEFW    8080H
        DEFW    9CA0H
        DEFW    0A4BCH
        DEFW    0BF8AH
        DEFW    9FBCH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B0A0H
        DEFW    80B0H
        DEFW    0B6BFH
        DEFW    95B9H
        DEFW    8382H
        DEFW    8083H
        DEFW    0B080H
        DEFW    90B0H
        DEFW    0BDAAH
        DEFW    0BEB3H
        DEFW    8380H
        DEFW    8183H
SCR191  LD      HL,SCR
        LD      DE,SCR+1
        LD      (HL),0BFH
SCR0    LD      B,15
SCRG1   PUSH    BC
        LD      BC,64
        LDIR
        POP     BC
        DJNZ    SCRG1
        LD      BC,63
        LDIR
        RET
CLSVID  LD      HL,VIDEO
        LD      DE,VIDEO+1
CLS0    LD      (HL),80H
        JR      SCR0
CLSSCR  LD      DE,SCR+1
        LD      HL,SCR
        JR      CLS0
CLSTIR  LD      HL,SCRTIR
        LD      DE,SCRTIR+1
        LD      BC,1024+64-1
        LD      (HL),80H
        LDIR
        RET
AFF     LD      HL,SCR
        LD      DE,VIDEO
        LD      BC,1024
        LDIR
        RET
PAUSE   DEC     BC
        LD      A,B
        OR      C
        JR      NZ,PAUSE
        RET
AFF1L   CALL    AFF1C
        DEC     BC
        INC     HL
        INC     DE
        LD      A,B
        OR      C
        JR      NZ,AFF1L
        RET
AFF1C   LD      A,(HL)
        CP      60H
        JR      C,AFF1C2
        CP      80H
        JR      NC,AFF1C2
        PUSH    HL
        LD      HL,LOWER1
        DEC     (HL)
        POP     HL
        JR      NZ,AFF1C1
        LD      A,(VIDEO)
        PUSH    AF
        LD      A,0C0H
        LD      (VIDEO),A
        LD      A,(VIDEO)
        CP      0C0H
        LD      A,0E0H
        JR      NZ,AFF1C0
        XOR     A
AFF1C0  LD      (LOWER0),A
        POP     AF
        LD      (VIDEO),A
        LD      A,(HL)
AFF1C1  PUSH    HL
        LD      HL,LOWER0
        ADD     A,(HL)
        POP     HL
AFF1C2  LD      (DE),A
        RET
LOWER0  DEFB    0
LOWER1  DEFB    1
MOVE    LD      A,D
        OR      A
MOVE0   JR      Z,MOVE6
        LD      A,B
        JP      P,MOVE2
        DEC     A
        SRL     A
        JR      NC,MOVE1
        INC     B
        DEC     HL
        JR      MOVE4
MOVE1   DEC     B
        JR      MOVE4
MOVE2   INC     A
        SRL     A
        JR      C,MOVE3
        DEC     B
        INC     HL
        JR      MOVE4
MOVE3   INC     B
MOVE4   LD      A,D
        OR      A
        JP      P,MOVE5
        INC     D
        JR      MOVE0
MOVE5   DEC     D
        JR      MOVE0
MOVE6   LD      A,E
        OR      A
MOVE7   RET     Z
        PUSH    DE
        LD      A,B
        JP      P,MOVE11
        SUB     2
        JP      P,MOVE9
        ADD     A,6
        LD      DE,-64
MOVE8   ADD     HL,DE
MOVE9   LD      B,A
        POP     DE
        LD      A,E
        OR      A
        JP      P,MOVE10
        INC     E
        JR      MOVE7
MOVE10  DEC     E
        JR      MOVE7
MOVE11  ADD     A,2
        CP      6
        JR      C,MOVE9
        SUB     6
        LD      DE,64
        JR      MOVE8
AFFLIN  LD      HL,SCR
        LD      DE,SCR+1
        LD      BC,3FH
        LD      (HL),8CH
        LDIR
        LD      HL,SCR+896
        LD      DE,SCR+897
        LD      BC,3FH
        LD      (HL),0B0H
        LDIR
        LD      HL,SCR
        LD      DE,SCR+3FH
        LD      B,0FH
        LD      A,0BCH
EFF1    LD      (HL),A
        LD      (DE),A
        PUSH    BC
        LD      BC,64
        ADD     HL,BC
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        LD      A,0BFH
        DJNZ    EFF1
        RET
EFFPOI  LD      HL,3C00H
        LD      DE,3C01H
        LD      BC,3FH
        LD      (HL),8CH
        LDIR
        LD      HL,3F80H
        LD      DE,3F81H
        LD      BC,3FH
        LD      (HL),0B0H
        LDIR
        LD      HL,3C00H
        LD      DE,3C3FH
        LD      B,0FH
        LD      A,0BCH
EFF0    LD      (HL),A
        LD      (DE),A
        PUSH    BC
        LD      BC,64
        ADD     HL,BC
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        LD      A,0BFH
        DJNZ    EFF0
        RET
AFFPOI  LD      A,(COPOI)
        INC     A
        AND     3
        LD      (COPOI),A
        LD      HL,3F80H
        LD      DE,-64
        LD      B,14
FPO0    OR      A
        JR      Z,FPO3
        CP      1
        JR      Z,FPO2
        CP      2
        JR      Z,FPO1
        LD      (HL),0BCH
        JR      FPO4
FPO1    LD      (HL),0B3H
        JR      FPO4
FPO2    LD      (HL),8FH
        JR      FPO4
FPO3    LD      (HL),0BFH
FPO4    INC     A
        AND     3
        ADD     HL,DE
        DJNZ    FPO0
        LD      A,(COPOI)
        LD      B,64
        CP      3
        JR      Z,FPO5
        OR      A
        JR      Z,FOP0
        LD      (HL),0BCH
        JR      FPO7
FOP0    LD      (HL),0B0H
        JR      FPO7
FPO5    OR      A
        JR      NZ,FPO6
        LD      (HL),80H
        JR      FPO7
FPO6    LD      (HL),8CH
FPO7    INC     HL
        DEC     A
        AND     3
        DJNZ    FPO5
        LD      A,(COPOI)
        OR      A
        JR      Z,FPO8
        CP      3
        JR      NC,FOP1
        DEC     HL
        LD      (HL),0BCH
        JR      FPO8
FOP1    DEC     HL
        LD      (HL),0B0H
FPO8    LD      HL,3C7FH
        LD      B,14
        LD      DE,64
FPO9    OR      A
        JR      Z,FPO12
        CP      1
        JR      Z,FPO11
        CP      2
        JR      Z,FPO10
        LD      (HL),8FH
        JR      FPO13
FPO10   LD      (HL),0B3H
        JR      FPO13
FPO11   LD      (HL),0BCH
        JR      FPO13
FPO12   LD      (HL),0BFH
FPO13   INC     A
        AND     3
        ADD     HL,DE
        DJNZ    FPO9
        LD      A,(COPOI)
        INC     A
        AND     3
        LD      B,62
        LD      HL,3FBEH
FPO14   OR      A
        JR      NZ,FPO15
        LD      (HL),80H
        JR      FPO16
FPO15   LD      (HL),0B0H
FPO16   DEC     HL
        DEC     A
        AND     3
        DJNZ    FPO14
        LD      BC,1000
        CALL    PAUSE
        RET
COPOI   DEFB    0
DISPL   LD      A,(CMODE)
        OR      A
        JP      Z,ESSGLA
        DEC     A
        JP      Z,GRILL
        DEC     A
        JP      Z,ALEA
        JP      RADAR
CMODE   DEFB    2
COMMOD  LD      HL,CMODE
        LD      A,(HL)
        INC     A
        AND     7
        CP      4
        JR      NZ,COM0
        XOR     A
COM0    LD      (HL),A
        RET
        COND    TYPE=TAPE
EHS     EQU     EHA
        ENDC
        COND    TYPE=DISK
FILES   DEFM    'RUNNER/HSC'
        DEFB    0DH
EHS     LD      HL,FILES
        LD      DE,DCB
        LD      BC,13
        LDIR
        INIT    DCB,ERROR,SCR,10*(10+6)
        JR      NC,EHS0
        POSN    DCB,ERROR,0
        CALL    EHA
        WRITLR  DCB,ERROR,TSCOR
        JR      EHS1
EHS0    POSN    DCB,ERROR,0
        READLR  DCB,ERROR,TSCOR
        LD      A,0C9H
        LD      (EHS),A
EHS1    CLOSE   DCB,ERROR
        DINT
        RET
ERROR   JP      0
        ENDC
        COND    TYPE=PROT
EHS     CALL    READ
        LD      A,(TSCOR)
        OR      A
        JR      Z,EHS0
        LD      A,0C9H
        LD      (EHS),A
EHS1    DINT
        RET
EHS0    CALL    EHA
        CALL    WRITE
        JR      EHS1
READ    LD      HL,TSCOR
        JP      4402H
WRITE   LD      HL,TSCOR
        JP      4405H
        ENDC
EHA     LD      HL,TSCOR
        LD      DE,TSCOR+1
        LD      BC,10*(10+6)-1
        LD      (HL),0
        LDIR
        LD      HL,THS
        LD      DE,TSCOR
        LD      BC,16
        LDIR
        LD      A,0C9H
        LD      (EHS),A
        RET
THS     DEFM    'Yves L.   038163'
TADHS   DEFM    'HIGH  SCORES'
AFFHS   LD      HL,TADHS
        LD      DE,SCR+64+46
        LD      BC,12
        CALL    AFF1L
        LD      HL,SCR+128+42
        LD      B,20
AFH0    LD      (HL),8CH
        INC     HL
        DJNZ    AFH0
        LD      HL,SCR+64+41
        LD      DE,SCR+64+62
        LD      A,0BFH
        LD      B,12
AFH1    LD      (HL),A
        LD      (DE),A
        PUSH    BC
        LD      BC,64
        ADD     HL,BC
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        DJNZ    AFH1
        LD      B,22
        LD      HL,SCR+832+41
AFH2    LD      (HL),83H
        INC     HL
        DJNZ    AFH2
        LD      DE,SCR+192+43
        LD      HL,TSCOR
        LD      B,10
AFH3    LD      A,(HL)
        OR      A
        RET     Z
        PUSH    BC
        LD      B,10
AFH4    CALL    AFF1C
        INC     DE
        INC     HL
        DJNZ    AFH4
        LD      A,' '
        LD      (DE),A
        INC     DE
        XOR     A
        LD      (FL00),A
        CALL    AFF3C
        DEC     DE
        LD      A,(DE)
        INC     DE
        CP      80H
        JR      Z,AFH5
        LD      A,','
        LD      (DE),A
AFH5    INC     DE
        CALL    AFF3C
        POP     BC
        PUSH    HL
        LD      HL,46
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        DJNZ    AFH3
        RET
FL00    DEFB    0
AFF3C   LD      B,3
AHK0    LD      A,(HL)
        CP      '0'
        JR      Z,AHK3
AHK1    LD      (DE),A
        LD      A,1
        LD      (FL00),A
AHK2    INC     DE
        INC     HL
        DJNZ    AHK0
        RET
AHK3    LD      A,(FL00)
        OR      A
        JR      Z,AHK2
        LD      A,'0'
        JR      AHK1
BLK1    DEFW    VIDEO+192+43
BLK2    DEFW    0
BLKC    DEFB    0
BLKHS   LD      A,(BLKC)
        INC     A
        AND     0FH
        LD      (BLKC),A
        JR      Z,BLH0
        CP      4
        JR      Z,BLH3
        LD      BC,9
        JP      PAUSE
BLH0    LD      HL,(BLK1)
        CALL    BLH1
        LD      HL,(BLK2)
BLH1    LD      B,18
BLH2    LD      (HL),' '
        INC     HL
        DJNZ    BLH2
        RET
BLH3    LD      DE,(BLK1)
        CALL    BLH4
        LD      DE,(BLK2)
BLH4    LD      A,D
        OR      E
        RET     Z
        LD      HL,SCR-VIDEO
        ADD     HL,DE
        LD      BC,18
        LDIR
        RET
TSP12   DEFM    'Press <1> or <2> to start game'
TSP     DEFM    ', Press <SPACE> for Instructions'
TSPK    DEFM    ', Press <K> to redefine keys'
ALEA    LD      BC,100H
ALE0    CALL    RND
        AND     0FCH
        LD      E,A
        CALL    RND
        AND     3
        LD      D,A
ALE1    LD      HL,SCR
        ADD     HL,DE
        LD      A,(HL)
        OR      A
        JR      Z,ALE2
        CALL    ASQU
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,ALE0
        LD      HL,VIDEO
        LD      DE,SCR
        LD      BC,400H
        LDIR
        RET
ALE2    LD      HL,12
        ADD     HL,DE
        EX      DE,HL
        LD      A,D
        AND     3
        LD      D,A
        JR      ALE1
ASQU    PUSH    DE
        POP     HL
        ADD     HL,HL
        ADD     HL,HL
        LD      D,H
        LD      A,E
        RRCA
        RRCA
        AND     0FH
        LD      E,A
        CALL    SQUARE
        RET
SQUARE  PUSH    DE
        EXX
        POP     DE
        LD      L,D
        LD      H,0
        LD      B,6
SQU0    ADD     HL,HL
        DJNZ    SQU0
        SLA     E
        SLA     E
        LD      D,0
        ADD     HL,DE
        PUSH    HL
        POP     BC
        LD      HL,VIDEO
        ADD     HL,BC
        EX      DE,HL
        LD      HL,SCR
        ADD     HL,BC
        LD      B,4
SQU1    LD      A,(HL)
        LD      (DE),A
        LD      (HL),0
        INC     HL
        INC     DE
        DJNZ    SQU1
        EXX
        CALL    SON1
        RET
SON1    PUSH    DE
        EXX
        POP     DE
        SRL     E
        INC     E
        SLA     D
        INC     D
        LD      C,10H
SOS     LD      A,1
        OUT     (255),A
        LD      B,E
        DJNZ    $
        LD      A,0
        OUT     (255),A
        LD      B,D
        DJNZ    $
        DEC     C
        JR      NZ,SOS
        EXX
        RET
DLINE   LD      HL,(YA)
        LD      DE,(YB)
        CALL    LINE
        LD      A,(RX)
        LD      E,A
        LD      A,(RY)
        LD      D,A
        CALL    SON1
        RET
ESSGLA  LD      HL,1F0FH
        LD      (YA),HL
        LD      HL,0FH
        LD      (YB),HL
ESG0    CALL    DLINE
        LD      A,(YB)
        OR      A
        JR      Z,ESG1
        DEC     A
        LD      (YB),A
        JR      ESG0
ESG1    CALL    DLINE
        LD      A,(XB)
        CP      63
        JR      Z,ESG2
        INC     A
        LD      (XB),A
        JR      ESG1
ESG2    CALL    DLINE
        LD      A,(YB)
        CP      15
        RET     Z
        INC     A
        LD      (YB),A
        JR      ESG2
GRILL   LD      HL,0
        LD      (YA),HL
        LD      HL,3FCH
        LD      (YB),HL
        LD      B,128
GRI0    PUSH    BC
        LD      DE,(YA)
        CALL    ASQU
        LD      DE,(YB)
        CALL    ASQU
        LD      HL,(YA)
        LD      DE,8
        ADD     HL,DE
        LD      (YA),HL
        LD      HL,(YB)
        LD      DE,-8
        ADD     HL,DE
        LD      (YB),HL
        POP     BC
        DJNZ    GRI0
        LD      HL,VIDEO
        LD      DE,SCR
        LD      BC,400H
        LDIR
        RET
RADAR   LD      HL,1F07H
        LD      (YA),HL
        LD      HL,1F00H
        LD      (YB),HL
RAD0    CALL    DLINE
        LD      A,(XB)
        CP      63
        JR      Z,RAD1
        INC     A
        LD      (XB),A
        JR      RAD0
RAD1    CALL    DLINE
        LD      A,(YB)
        CP      15
        JR      Z,RAD2
        INC     A
        LD      (YB),A
        JR      RAD1
RAD2    CALL    DLINE
        LD      A,(XB)
        OR      A
        JR      Z,RAD3
        DEC     A
        LD      (XB),A
        JR      RAD2
RAD3    CALL    DLINE
        LD      A,(YB)
        OR      A
        JR      Z,RAD4
        DEC     A
        LD      (YB),A
        JR      RAD3
RAD4    CALL    DLINE
        LD      A,(XB)
        CP      31
        RET     Z
        INC     A
        LD      (XB),A
        JR      RAD4
YA      DEFB    0
XA      DEFB    0
YB      DEFB    0
XB      DEFB    0
LINE    LD      (RY),HL
        CALL    PLOT
        PUSH    DE
        LD      A,H
        CP      D
        JR      NC,LIN0
        LD      D,1
        JR      LIN1
LIN0    LD      D,0FFH
LIN1    LD      A,L
        CP      E
        JR      NC,LIN2
        LD      E,1
        JR      LIN3
LIN2    LD      E,0FFH
LIN3    POP     BC
        LD      A,H
        SUB     B
        JP      P,LIN4
        NEG
LIN4    LD      H,A
        LD      A,L
        SUB     C
        JP      P,LIN5
        NEG
LIN5    LD      L,A
        LD      A,H
        CP      L
        JR      C,LIN6
        JR      Z,LIN6
        SRL     A
        LD      C,A
        LD      B,H
LIN7    LD      A,(RX)
        ADD     A,D
        LD      (RX),A
        LD      A,C
        ADD     A,L
        LD      C,A
        CP      H
        JR      C,LIN8
        SUB     H
        LD      C,A
        LD      A,(RY)
        ADD     A,E
        LD      (RY),A
LIN8    CALL    PLOT
        DJNZ    LIN7
        RET
LIN6    LD      A,L
        SRL     A
        LD      C,A
        LD      B,L
LIN9    LD      A,(RY)
        ADD     A,E
        LD      (RY),A
        LD      A,C
        ADD     A,H
        LD      C,A
        CP      L
        JR      C,LIN10
        SUB     L
        LD      C,A
        LD      A,(RX)
        ADD     A,D
        LD      (RX),A
LIN10   CALL    PLOT
        DJNZ    LIN9
        RET
RY      DEFB    0
RX      DEFB    0
PLOT    EXX
        LD      A,(RY)
        LD      L,A
        LD      H,0
        LD      B,6
PLO0    ADD     HL,HL
        DJNZ    PLO0
        LD      A,(RX)
        LD      E,A
        LD      D,0
        ADD     HL,DE
        PUSH    HL
        POP     BC
        LD      HL,VIDEO
        ADD     HL,BC
        EX      DE,HL
        LD      HL,SCR
        ADD     HL,BC
        LD      A,(HL)
        LD      (DE),A
        EXX
        RET
DTIT    LD      B,3
        EXX
DTI0    LD      DE,0
        EXX
DTI1    LD      C,0
DTI2    LD      A,(HL)
        LD      (DE),A
        INC     HL
        INC     DE
        DEC     C
        JR      NZ,DTI2
        PUSH    DE
        EXX
        POP     HL
        ADD     HL,DE
        PUSH    HL
        EXX
        POP     DE
        DJNZ    DTI1
        RET
PRORUN  CALL    IPRO
        XOR     A
        LD      (INP1+1),A
        LD      DE,SCR+192+17
        LD      HL,TAMID
        LD      A,29
        LD      (DTI1+1),A
        LD      A,64-29
        LD      (DTI0+1),A
        CALL    DTIT
        LD      DE,SCR+384+11
        LD      A,42
        LD      (DTI1+1),A
        LD      A,64-42
        LD      (DTI0+1),A
        CALL    DTIT
        LD      HL,AMID0
        LD      DE,SCR+704+24
        LD      BC,16
        CALL    AFF1L
        LD      DE,SCR+768+14
        LD      BC,36
        CALL    AFF1L
        LD      DE,SCR+832+9
        LD      BC,46
        CALL    AFF1L
        LD      HL,TSP12
        LD      DE,SCR+960+1
        LD      BC,62
        CALL    AFF1L
        CALL    AFFLIN
        CALL    DISPL
        CALL    AFFPOI
PRB0    CALL    INP12
        CALL    INPSP
        CALL    TRPOI
        CALL    GREY
        JR      PRB0
GREY    LD      A,0
        INC     A
        AND     7
        LD      (GREY+1),A
        RET     NZ
        LD      HL,VIDEO+192+10
        LD      DE,21
        LD      B,6
GRY0    LD      C,42
        LD      A,(HL)
        XOR     2AH
        LD      (HL),A
        INC     HL
GRY1    LD      A,(HL)
        XOR     3FH
        LD      (HL),A
        INC     HL
        DEC     C
        JR      NZ,GRY1
        LD      A,(HL)
        XOR     15H
        LD      (HL),A
        ADD     HL,DE
        DJNZ    GRY0
        RET
PROEXP  CALL    IPRO
        LD      A,1
        LD      (INP1+1),A
        CALL    AFFHS
        LD      HL,TAEXP
        LD      DE,SCR+128+4
        LD      B,12
PRE1    PUSH    DE
PRE2    LD      A,(HL)
        INC     HL
        CP      '%'
        JR      Z,PRE3
        DEC     HL
        CALL    AFF1C
        INC     HL
        INC     DE
        JR      PRE2
PRE3    POP     DE
        PUSH    HL
        LD      HL,64
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        DJNZ    PRE1
        LD      HL,SCR+64+13
        LD      DE,SCR+192+13
        LD      B,15
        LD      A,83H
PRE4    LD      (HL),8CH
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    PRE4
        LD      A,0BCH
        LD      (SCR+64+13),A
        LD      (SCR+64+27),A
        LD      A,0BFH
        LD      (SCR+128+13),A
        LD      (SCR+128+27),A
        LD      A,0C9H
        LD      (CLINE),A
        LD      DE,SCR+576+20
        LD      A,(NUML)
        LD      C,A
        CALL    DISKEY
        LD      DE,SCR+640+20
        LD      A,(NUMR)
        LD      C,A
        CALL    DISKEY
        LD      DE,SCR+704+20
        LD      A,(NUMU)
        LD      C,A
        CALL    DISKEY
        LD      DE,SCR+768+20
        LD      A,(NUMD)
        LD      C,A
        CALL    DISKEY
        LD      DE,SCR+832+20
        LD      A,(NUMF)
        LD      C,A
        CALL    DISKEY
        LD      A,3EH
        LD      (CLINE),A
        LD      HL,TSP12
        LD      DE,SCR+960+3
        LD      BC,30
        CALL    AFF1L
        LD      HL,TSPK
        LD      BC,28
        CALL    AFF1L
        CALL    AFFLIN
        CALL    DISPL
        CALL    AFFPOI
PRE0    CALL    INP12
        CALL    INPK
        CALL    TRPOI
        JR      PRE0
TAEXP   DEFM    '           TIME RUNNER%'
        DEFM    '%'
        DEFM    'Capture territory  by tracing over%'
        DEFM    'the rectangles.  CAREFUL,  roaming%'
        DEFM    'defenders are out to get you. Move%'
        DEFM    'as fast as possible to get maximum%'
        DEFM    'points.  Good luck...%'
        DEFM    'To move left  :%'
        DEFM    'To move right :%'
        DEFM    'To move up    :%'
        DEFM    'To move down  :%'
        DEFM    'To jump       :%'
INP12   LD      A,(3810H)
        AND     6
        JR      Z,INP1
        SRL     A
        CP      1
        JR      Z,INP0
        LD      A,2
INP0    LD      (NPLAY),A
        LD      HL,10000
        LD      (IPRO+1),HL
        POP     HL
        POP     HL
        CALL    EFFPOI
        XOR     A
        JP      STRT0
INP1    LD      A,0
        OR      A
        JR      Z,INP4
INP2    LD      A,6
        DEC     A
        JR      NZ,INP3
        LD      A,6
INP3    LD      (INP2+1),A
        JR      NZ,INP4
;       CALL    AFFSHP
        CALL    BLKHS
        JR      INP5
INP4    LD      B,200
        DJNZ    $
INP5    LD      HL,0
        DEC     HL
        LD      (INP5+1),HL
        LD      A,H
        OR      L
        JR      NZ,BLINKR
        POP     HL
        CALL    EFFPOI
        RET
BLINKR  LD      A,50
        DEC     A
        JR      NZ,BKR0
        LD      A,50
BKR0    LD      (BLINKR+1),A
        JR      NZ,BKR6
BKR7    LD      A,1
        NEG
        LD      (BKR7+1),A
        LD      A,79H
        JP      P,BKR1
        XOR     A
BKR1    LD      (BKR8),A
        LD      HL,SCR+960
        LD      DE,VIDEO+960
        LD      BC,64*256+' '
BKR2    LD      A,(HL)
        CP      '<'
        JR      Z,BKR5
BKR3    INC     HL
        INC     DE
        DJNZ    BKR2
        RET
BKR4    LD      A,(HL)
        CP      '>'
        JR      Z,BKR3
BKR8    NOP
        LD      (DE),A
BKR5    INC     HL
        INC     DE
        DJNZ    BKR4
        RET
BKR6    LD      B,0
        DJNZ    $
        RET
INPSP   LD      A,(3840H)
        AND     80H
        RET     Z
        LD      HL,10000
        LD      (IPRO+1),HL
        POP     HL
        POP     HL
        CALL    EFFPOI
        JP      STRT1
INPK    LD      A,(3802H)
        AND     8
        RET     Z
        LD      HL,10000
        LD      (IPRO+1),HL
REDEF   CALL    EFFPOI
        CALL    IPRO
        LD      HL,TAB1
        CALL    PRINT
        LD      A,(NUML)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        CALL    DISPL
        POP     DE
        LD      HL,VIDEO-SCR
        ADD     HL,DE
        EX      DE,HL
        CALL    INKEY
        JP      NZ,RED0
        LD      A,C
        LD      (NUML),A
        LD      A,B
        LD      (KEYL+1),A
        LD      (ADDL+1),HL
        CALL    DISKEY
        LD      HL,TAB2
        CALL    PRINT
        LD      A,(NUMR)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        POP     DE
RED1    CALL    INKEY
        JP      NZ,RED0
        LD      A,(NUML)
        CP      C
        JR      Z,RED1
        LD      A,C
        LD      (NUMR),A
        LD      A,B
        LD      (KEYR+1),A
        LD      (ADDR+1),HL
        CALL    DISKEY
        LD      HL,TAB5
        CALL    PRINT
        LD      A,(NUMU)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        POP     DE
RED3    CALL    INKEY
        JP      NZ,RED0
        LD      A,(NUML)
        CP      C
        JR      Z,RED3
        LD      A,(NUMR)
        CP      C
        JR      Z,RED3
        LD      A,C
        LD      (NUMU),A
        LD      A,B
        LD      (KEYU+1),A
        LD      (ADDU+1),HL
        CALL    DISKEY
        LD      HL,TAB6
        CALL    PRINT
        LD      A,(NUMD)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        POP     DE
RED4    CALL    INKEY
        JR      NZ,RED0
        LD      A,(NUML)
        CP      C
        JR      Z,RED4
        LD      A,(NUMR)
        CP      C
        JR      Z,RED4
        LD      A,(NUMU)
        CP      C
        JR      Z,RED4
        LD      A,C
        LD      (NUMD),A
        LD      A,B
        LD      (KEYD+1),A
        LD      (ADDD+1),HL
        CALL    DISKEY
        LD      HL,TAB3
        CALL    PRINT
        LD      A,(NUMF)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        POP     DE
RED2    CALL    INKEY
        JR      NZ,RED0
        LD      A,(NUML)
        CP      C
        JR      Z,RED2
        LD      A,(NUMR)
        CP      C
        JR      Z,RED2
        LD      A,(NUMU)
        CP      C
        JR      Z,RED2
        LD      A,(NUMD)
        CP      C
        JR      Z,RED2
        LD      A,C
        LD      (NUMF),A
        LD      A,B
        LD      (KEYF+1),A
        LD      (ADDF+1),HL
        CALL    DISKEY
        LD      HL,TAB4
        CALL    PRINT
        CALL    INKEY
RED0    POP     HL
        JP      PROEXP
NUML    DEFB    53
NUMR    DEFB    54
NUMU    DEFB    51
NUMD    DEFB    52
NUMF    DEFB    55
TAB1    DEFW    SCR+64
        DEFM    '-Redefinition key routine-'
        DEFB    0
        DEFW    SCR+192
        DEFM    'To move left  : '
        DEFB    1
TAB2    DEFW    VIDEO+256
        DEFM    'To move right : '
        DEFB    1
TAB5    DEFW    VIDEO+320
        DEFM    'To move up    : '
        DEFB    1
TAB6    DEFW    VIDEO+384
        DEFM    'To move down  : '
        DEFB    1
TAB3    DEFW    VIDEO+448
        DEFM    'To jump       : '
        DEFB    1
TAB4    DEFW    VIDEO+512
        DEFM    'Press any key to continue.'
        DEFB    1
DISKEY  LD      A,C
        CP      27
        JR      NC,DIK0
        ADD     A,40H
DIK5    LD      (DE),A
        INC     DE
        JR      CLINE
DIK0    CP      32
        JR      NC,DIK2
DIK1    LD      HL,USRK
        JR      DIK8
DIK2    CP      44
        JR      NC,DIK4
        ADD     A,16
        JR      DIK5
DIK4    CP      48
        JR      C,DIK5
        CP      57
        JR      NC,DIK1
        SUB     47
        LD      B,A
        LD      HL,TKEY
DIK6    DJNZ    DIK7
DIK8    LD      A,(HL)
        CP      '$'
        JR      Z,CLINE
        LD      (DE),A
        INC     HL
        INC     DE
        JR      DIK8
DIK7    LD      A,(HL)
        INC     HL
        CP      '$'
        JR      NZ,DIK7
        JR      DIK6
USRK    DEFM    'USER KEY$'
TKEY    DEFM    'ENTER$CLEAR$BREAK$UP ARROW$DOWN ARROW$'
        DEFM    '<--$-->$SPACEBAR$SHIFT$'
CLINE   LD      A,' '
        LD      (DE),A
        INC     DE
        LD      A,E
        AND     1FH
        JR      NZ,CLINE
        RET
INKEY   PUSH    DE
INY0    LD      A,(38FFH)
        OR      A
        JR      NZ,INY0
        LD      B,0
        DJNZ    $
        LD      DE,5000
INY1    LD      HL,3801H
        LD      C,0
INY2    LD      B,1
INY3    LD      A,(HL)
        AND     B
        JR      NZ,INY4
        INC     C
        SLA     B
        JR      NC,INY3
        SLA     L
        JR      NC,INY2
        DEC     DE
        LD      A,D
        OR      E
        JR      NZ,INY1
        POP     DE
        LD      A,1
        OR      A
        RET
INY4    POP     DE
        XOR     A
        RET
IPRO    LD      HL,10000
        LD      (INP5+1),HL
        CALL    SCR191
        CALL    DISPL
        CALL    CLSSCR
        RET
TRPOI   LD      A,8
        DEC     A
        JR      NZ,TPO0
        LD      A,8
TPO0    LD      (TRPOI+1),A
        RET     NZ
        JP      AFFPOI
START   DINT
        LD      HL,STACK
        LD      SP,HL
        LD      H,37H
        LD      L,0E4H
        LD      (HL),1
        CALL    EHS
        CALL    PRORUN
STRT1   CALL    PROEXP
        LD      HL,2000
        LD      (IPRO+1),HL
        LD      A,2
        LD      (NPLAY),A
STRT0   LD      (DEMO),A
        CALL    COMMOD
        JP      BEGIN
MUL16   LD      HL,0
MUL0    SRL     B
        JR      NC,MUL1
        ADD     HL,DE
MUL1    RET     Z
        EX      DE,HL
        ADD     HL,HL
        EX      DE,HL
        JR      MUL0
