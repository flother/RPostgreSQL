% $Id: fetch-methods.Rd,v 0.1 2008/07/23 02:38:31 psk Exp $
\name{fetch-methods}
\docType{methods}
\alias{fetch-methods}
\alias{fetch,PostgreSQLResult,numeric-method}
\alias{fetch,PostgreSQLResult,missing-method}
%\alias{fetch,PostgreSQLResult-method}
\title{
  Fetch records from a previously executed query
}
\description{
   This method is a straight-forward implementation of the corresponding
   generic function.
}
\section{Methods}{\describe{

\item{res}{
  an \code{PostgreSQLResult} object.
  }
\item{n}{
  maximum number of records to retrieve per fetch.
  Use \code{n = -1} to retrieve all pending records;
  use a value of \code{n = 0} for fetching the default number 
  of rows \code{fetch.default.rec} defined in the 
  \code{\link{PostgreSQL}} initialization invocation.
  }
\item{\dots }{currently not used.}
}
}
\details{
  The \code{RPostgreSQL} implementations retrieves only \code{n} records,
  and if \code{n} is missing it only returns up to \code{fetch.default.rec}
  as specified in the call to \code{\link{PostgreSQL}} (500 by default).
}
\references{
  See the Database Interface definition document
  \code{DBI.pdf} in the base directory of this package
  or \url{http://stat.bell-labs.com/RS-DBI}.
}
\seealso{
  \code{\link{PostgreSQL}},
  \code{\link[DBI]{dbConnect}},
  \code{\link[DBI]{dbSendQuery}},
  \code{\link[DBI]{dbGetQuery}},
  \code{\link[DBI]{dbClearResult}},
  \code{\link[DBI]{dbCommit}},
  \code{\link[DBI]{dbGetInfo}},
  \code{\link[DBI]{dbReadTable}}.
}
\examples{\dontrun{
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, user = "ruser",password = "123456",dbname = "status")
res <- dbSendQuery(con, statement = paste(
                      "SELECT w.category, w.cost, p.type",
                      "FROM items w, sales P",
                      "WHERE w.category = p.type",
                      "ORDER BY w.cost"))
# we now fetch the first 100 records from the resultSet into a data.frame
data1 <- fetch(res, n = 100)   
dim(data1)

dbHasCompleted(res)

# let's get all remaining records
data2 <- fetch(res, n = -1)
}
}
\keyword{methods}
\keyword{interface}
\keyword{database}
% vim: syntax=tex
