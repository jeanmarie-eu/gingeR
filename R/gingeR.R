#' gingeR
#'
#' gingeR
#' @param name name of the service
#' @param format_file format of the files providedd by the service
#' @param auth_type authentication type: "none", "basic", ...
#' @param endpoint endpoint in case auth_type is oauth1 or oauth2
#' @param tmpDir path of temporary folder
#' @keywords gingeR
#' @export
#' @examples
#' \dontrun{
#' gingeR()
#' }
gingeR <- function(name,format_file,auth_type,endpoint=NULL,tmpDir="~\\") {

  stopifnot(is.character(name))
  stopifnot(is.character(format_file))
  stopifnot(is.character(auth_type))
  stopifnot(is.list(endpoint) || is.null(endpoint)  || (endpoint=="none"))
  stopifnot(is.character(tmpDir) || is.null(tmpDir) ) # stopifnot(is.path(tmpDir) || is.null(tmpDir) )

  gingeRdir <- normalizePath(file.path(tmpDir,".gingeR"),mustWork = FALSE)
  dir.create(gingeRdir, showWarnings = FALSE, recursive = TRUE)

  gingeR_object(name,format_file,auth_type,endpoint,gingeRdir)
}


gingeR_object <- function(name,format_file,auth_type,endpoint,tmpDir){

  sugaR_obj <- sugaR::sugaR(name=name,auth_type=auth_type,endpoint=endpoint,cachePath=tmpDir)
  sugaR_obj$header("accept",format_file)
  puddingR_obj <- puddingR::puddingR(cachePath=tmpDir)
  format_file <- format_file

  object <- local({

    authenticate <- function(...){
      gauthenticate(sugaR_obj,...)
    }

    clearCache.Auth <- function(){
      gclearCA(sugaR_obj)
    }

    clearCache.Resp <- function(){
      gclearCR(puddingR_obj)
    }

    GET <- function(url){
      gGET(sugaR_obj,puddingR_obj,url)
    }
    PUT <- function(url){
      gPUT(sugaR_obj,puddingR_obj,url)
    }
    DELETE <- function(url){
      gDELETE(sugaR_obj,puddingR_obj,url)
    }

    info <- function(){
      ginfo(sugaR_obj,puddingR_obj)
    }
    status_code <- function(){
      gstatus_code(puddingR_obj)
    }

    values <- function(...){
      return(gvalues(puddingR_obj,format_file,...))
    }

    summary <- function(...){
      return(gsummary(puddingR_obj,format_file,...))
    }

    environment()
  })
  lockEnvironment(object, TRUE)
  structure(object, class=c("gingeR", class(object)))
}
