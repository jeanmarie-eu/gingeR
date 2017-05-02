gvalues <- function(puddingR_obj,format_file,...){
  res <- getV(filename=puddingR_obj$response()$content,format=format_file,...)
  return(res)
}

gsummary <- function(puddingR_obj,format_file,...){
  return(summaryV(filename=puddingR_obj$response()$content,format=format_file,...))
}

getV <- function(filename,format,...) {
  stopifnot(file.exists(filename))
  tmp <- limonade::limonade(filename=filename,format=format)
  return(tmp$extract(...))
}

summaryV <- function(filename,format,...) {
  stopifnot(file.exists(filename))
  tmp <- limonade::limonade(filename=filename,format=format)
  return(tmp$summary(...))
}
