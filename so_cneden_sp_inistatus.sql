/*$File_version=ms4.3.0.01$*/  
/******************************************************************************************  
file name : so_cneden_sp_inistatus.sql  
version  : 4.0.0.0  
procedure name : so_cneden_sp_inistatus  
purpose  :   
author  :   
date  : 11 sep 2002  
component name : nso  
method name : so_cneden_m_inistatus  
  
objects referred  
 object name  object type  operation  
       (insert/update/delete/select/exec)  
modification details  
 modified by  modified on  remarks  
john    12 May 2004  NSODMS41SYTST_000130  
******************************************************************************************/   
  
/*  
Modified by          :  Manjunatha  
Modified Date      :  27 Mar 2004  
Remarks              :  NSODMS41SYTST_000071  
*/  
create procedure so_cneden_sp_inistatus  
     --temporary store for input parameter assignment  
       
     @ctxt_language   udd_ctxt_language  ,  
     @ctxt_ouinstance   udd_ctxt_ouinstance  ,  
     @ctxt_service   udd_ctxt_service  ,  
     @ctxt_user   udd_ctxt_user  ,  
     @m_errorid  int output --to return execution status  
as  
begin  
     declare @iudmodeflag nvarchar(2)   
  
     -- nocount should be switched on to prevent phantom rows   
     set nocount on  
     -- @m_errorid should be 0 to indicate success  
     select @m_errorid =0  
  
       
  
     if @ctxt_language = -915   
          select @ctxt_language = null  
     if @ctxt_ouinstance = -915   
          select @ctxt_ouinstance = null  
     select @ctxt_service = ltrim(rtrim(@ctxt_service))  
     if @ctxt_service = '~#~'   
          select @ctxt_service = null  
     select @ctxt_user = ltrim(rtrim(@ctxt_user))  
     if @ctxt_user = '~#~'   
          select @ctxt_user = null  
  
  
  
select     
ltrim(rtrim(paramdesc))     'ORD_CONT_STATUS',    
ltrim(rtrim(paramcode))    'STATUSCODE'    
from component_metadata_table(nolock)  
where   ltrim(rtrim(componentname))    =  'NSO'    
and   ltrim(rtrim(paramcategory))   = 'STATUS'    
and   ltrim(rtrim(paramtype))    = 'SO_CON_STATUS'    
and   ltrim(rtrim(paramcode))  in ('FR','DR','RT','AL')/*DMS 41-NSODMS41SYTST_000130*/  
and langid    = @ctxt_language  
  
/*  
template select statement for selecting data to app layer  
select   
ord_cont_status 'ORD_CONT_STATUS',statuscode 'STATUSCODE'  
 from  ***  
*/  
end  
   
  
  
  