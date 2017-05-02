gGET <-function(sugaR_obj,puddingR_obj,url){
  action(sugaR_obj,puddingR_obj,verb="GET",url)
}

gPUT <-function(sugaR_obj,puddingR_obj,url){
  action(sugaR_obj,puddingR_obj,verb="PUT",url)
}

gDELETE <-function(sugaR_obj,puddingR_obj,url){
  action(sugaR_obj,puddingR_obj,verb="DELETE",url)
}

action <- function(sugaR_obj,puddingR_obj,verb,url){
  sugaR_obj$verb(verb)
  puddingR_obj$set_handle(verb=sugaR_obj$info()$handle_list$verb, header=sugaR_obj$info()$handle_list$headers, option=sugaR_obj$info()$handle_list$options)
  puddingR_obj$request(url=url)
}

ginfo <- function(sugaR_obj,puddingR_obj){
  cat("handle: \n")
  cat("\t",unlist(sugaR_obj$info()),"\n")
  cat("response header: \n")
  cat("\t",unlist(puddingR::response(puddingR_obj)$header),"\n")
}

gstatus_code <- function(puddingR_obj){
  return(puddingR_obj$response()$status_code)
}
