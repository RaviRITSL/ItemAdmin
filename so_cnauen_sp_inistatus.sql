/*$File_version=ms4.3.0.01$*/  
/******************************************************************************************  
file name : so_cnauen_sp_inistatus.sql  
version  : 4.0.0.0  
procedure name : so_cnauen_sp_inistatus  
purpose  :   
author  :   
date  : 11 sep 2002  
component name : nso  
method name : so_cnauen_m_inistatus  
  
objects referred  
 object name  object type  operation  
       (insert/update/delete/select/exec)  
modification details  
modified by   modified on  remarks  
John    12 May 2004  NSODMS41SYTST_000130  
Damodharan R   17 July 2006  NSODMS412AT_000328  
******************************************************************************************/   
create procedure so_cnauen_sp_inistatus  
     --temporary store for input parameter assignment  
     @ctxt_language   udd_ctxt_language  ,  
     @ctxt_ouinstance   udd_ctxt_ouinstance  ,  
     @ctxt_service   udd_ctxt_service  ,  
     @ctxt_user   udd_ctxt_user  ,  
     @m_errorid  int output --to return execution status  
as  
begin  
     --declare @iudmodeflag nvarchar(2) --Code commenetd by Damodharan R for Exception  
  
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
  
 select  rtrim(paramdesc)     'ORD_CONT_STATUS',    
  rtrim(paramcode)    'STATUSCODE'   
 from  component_metadata_table(nolock)    
 where   upper(rtrim(componentname)) = 'NSO'   
 and    upper(rtrim(paramcategory)) = 'STATUS'   
 and    upper(rtrim(paramtype))     = 'SO_CON_STATUS'   
 and    upper(rtrim(paramcode))    in ('FR','AM','AL')/*DMS 41-NSODMS41SYTST_000130*/  
 and langid     = @ctxt_language  
 /* Code added by Damodharan R for OTS ID NSODMS412AT_000328 begins here */  
        order by paramcode  
 /* Code added by Damodharan R for OTS ID NSODMS412AT_000328 ends here */  
end  