DIPRE ;SFISC/TKW - PRE-INIT FOR PATCH DI*21*29 ;11/27/96  10:50
V ;;22.0T0;VA FileMan;;Nov 09, 1998
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ; Add new WRITE identifier to DIALOG file (.84)
 S ^DD(.84,0,"ID","WRITE")="N DIALID S DIALID(1)=$P($G(^(0)),U,5) S:DIALID(1)="""" DIALID=+$O(^(2,0)),DIALID(1)=$E($G(^(DIALID,0)),1,42) S DIALID(1,""F"")=""?10"" D EN^DDIOL(.DIALID)"
 Q
