DDBRP ;SFISC/DCL-BROWSER PRINT UTILITY ;06:05 PM  2 Sep 2002
 ;;22.0;VA FileMan;**999**;Mar 30, 1999
PRTHELP ; Print Help
 ;
 N DDGLI,DDGLHN1,DDGLHN2
 S (DDGLHN1,DDGLHN2)=$S(DDBRHTF:9202,1:9201)
 ;
BRM ;Clear scroll region, title bar and
 N DX,DY,X
 S DX=0,DY=$P(DDBSY,";"),X=$$CTXT^DDBR($$EZBLD^DIALOG(7076.4),$J("",IOM+1),IOM) ;**'PRINT BROWSER HELP'
 X IOXY
 W $P(DDGLVID,DDGLDEL,6)  ;rvon
 W $P(DDGLVID,DDGLDEL,4)  ;uon
 W X
 W $P(DDGLVID,DDGLDEL,10)  ;rvoff
 F DY=$P(DDBSY,";",2):1:$P(DDBSY,";",4) X IOXY W $P(DDGLCLR,DDGLDEL)
 W $P(DDGLVID,DDGLDEL,6)  ;rvon
 W $P(DDGLVID,DDGLDEL,4)  ;uon
 W X
 W $P(DDGLVID,DDGLDEL,10)  ;rvoff
 W @IOSTBM
 S DY=$P(DDBSY,";",2)
 X IOXY
 ;
 ;Reset for Roll/Scroll mode
 S X=$G(IOM,80) X ^%ZOSF("RM")
 W $P(DDGLVID,DDGLDEL,9)
 ;
 N POP,XQH
 N IOF,IOSL,DDBUC,DDBLC,DDBRZIS
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%K,%M,%N
 N %P,%S,%T,%W,%X,%Y,%XX,%YY
 N %A0,%D1,%D2,%DT,%J1,%W0
 ;
DEVICE ;
 S %ZIS=$S($D(^%ZTSK):"Q",1:""),%ZIS("B")=""
 S %ZIS("S")="I $$UP^DILIBF($P(^(0),U))'[""BROWSE"",$E($$GET1^DIQ(3.5,Y,""SUBTYPE""))=""P""" ;**
 S IOF="#",IOSL=DDBSRL
 D ^%ZIS
 K %ZIS
 ;
 I POP D
 .W !!,$$EZBLD^DIALOG(1901) ;**REPORT CANCELLED
 .H 2
 ;
 ;Queue report
 E  I $D(IO("Q")),$D(^%ZTSK) D
 .S ZTRTN="PRINTHLP^DDBRP"
 .S ZTDESC="Browser help printout."
 .N I F I="DDGLHN1","DDGLHN2" S ZTSAVE(I)=""
 .D ^%ZTLOAD
QUEUED .I $D(ZTSK)#2 W !,$$EZBLD^DIALOG(8161,ZTSK),! ;**
 .E  W !,$$EZBLD^DIALOG(1901),! ;**REPORT CANCELLED
 .K ZTSK
 .S IOP="HOME" D ^%ZIS
 ;
 E  I $E(IOST,1,2)="C-" D  G DEVICE
 .W !,$C(7)_$$EZBLD^DIALOG(7076.3),! ;**NOT ON CRT
 ;
 ;Non-queued report
 E  D
 .W !,"..." ;**
 .U IO
 .D PRINTHLP
 .X $G(^%ZIS("C"))
 ;
 ;Reset for Screen Mode
 S X=0 X ^%ZOSF("RM")
 W $P(DDGLVID,DDGLDEL,8)
 ;
 ;Repaint help screen
 D RPS^DDBRGE
 Q
 ;
PRINTHLP ;
 ;
 N DDGLJ,DDGLL,DDGLP
 F DDGLI=DDGLHN1:1:DDGLHN2 D
 . I DDGLI'=DDGLHN1 D
 .. I $Y+$O(^DI(.84,DDGLI,2," "),-1)+2'<IOSL W @IOF
 .. E  W !!
 . S DDGLJ=0
 . F  S DDGLJ=$O(^DI(.84,DDGLI,2,DDGLJ)) Q:'DDGLJ  D
 .. S DDGLL=$G(^DI(.84,DDGLI,2,DDGLJ,0))
 .. F  Q:DDGLL'["\"  D
 ... S DDGLP=$F(DDGLL,"\") Q:$E(DDGLL,DDGLP)="\"
 ... S $E(DDGLL,DDGLP-1,DDGLP)=""
 .. W !,DDGLL
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
