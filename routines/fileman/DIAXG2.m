DIAXG2 ;SFISC/DCM-EXTRACT SUBFILES ;9/2/94  06:35
 ;;21.0;VA FileMan;;Dec 28, 1994
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SUBFILE F DIAX(DILL,"FE")=0:0 S DIAX(DILL,"FE")=$O(@(DIAX(DILL,"FGBL")_DIAX(DILL,"FE")_")")) Q:DIAX(DILL,"FE")'=+DIAX(DILL,"FE")!($D(DIAXMSG))  D SUBENTRY
 Q
 ;
SUBENTRY ;
 N DIAXOUT
 D DR S DR(DIAX(DILL,"FILE"))=.01
 S DIAX(DILL,"MUL")=1
 D ^DIAXGU Q:$D(DIAXMSG)!$G(DIAXOUT)
 D DR,DRS
 D ^DIAXU1 G X1:$D(DIAXMSG)
 D RECURSEM
X1 K DIAX(DILL,"MUL"),DA,DR,DIAXDR,DIAXDRR,DIAXEXT,DIAX2,DRX
 Q
 ;
DR K DR S I=0
 F %=DIAX(DILL,"FILE"):0 Q:'$D(^DD(%,0,"UP"))  S X=^("UP"),Y=$O(^DD(X,"SB",%,0)),DR(X)=Y,DA(%)=DIAX(DILL-I,"FE"),%=X,I=I+1
 S DA=DIAX(DILL-I,"FE"),DIC=DIAX(DILL-I,"FILE"),DR=DR(%) K DR(%)
 Q
 ;
DRS S DR(DIAX(DILL,"FILE"))="",DIAXDRR=""
 F DIAX2=0:0 S DIAX2=$O(^DIPT(DIARP,1,DIAXI,"F",DIAX2)) Q:DIAX2'=+DIAX2  I $D(^(DIAX2,0)) S DRX=^(0) D
 . S DR(DIAX(DILL,"FILE"))=DR(DIAX(DILL,"FILE"))_+DRX_";",DIAXDR(+DRX)=$P(DRX,U,3),DIAXEXT(+DRX)=$P(DRX,U,5)
 . I $L(DR(DIAX(DILL,"FILE")))>200 D EN^DIAXG1 S DR(DIAX(DILL,"FILE"))=""
 D EN^DIAXG1:DR(DIAX(DILL,"FILE"))]""
 Q
 ;
RECURSEM D NEXTLVL^DIAXG
 Q
 ;
DIAXG3 ;
FILE F DIAX(DILL,"FE")=0:0 D FILE2 Q:DIAX(DILL,"FE")=""!($D(DIAXMSG))  D ENTRY
 K X
 Q
 ;
FILE2 S DIAX(DILL,"FE")=$O(@(DIAX(DILL,"FGBL")_""""_DIAX(DILL,"XREF")_""","_DIAX(DILL-1,"FE")_","_DIAX(DILL,"FE")_")"))
 Q
 ;
ENTRY S DIAX(DILL,"NAV")=1
 D ^DIAXGU Q:$D(DIAXMSG)
 K DIAX(DILL,"NAV")
 D ^DIAXG1
 D ^DIAXU1 G X1:$D(DIAXMSG)
 D RECURSEF
 Q
 ;
RECURSEF D NEXTLVL^DIAXG
 Q
