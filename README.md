# puddingR

[![Travis-CI Build Status](https://travis-ci.org/jeanmarielepioufle/timeManip.svg?branch=master)](https://travis-ci.org/jeanmarielepioufle/puddingR)

puddingR focuses on getting data from remote service.

This is an interface for curl.

Output is raw data.

## Installation

```R
# install.packages("devtools")
devtools::install_github("jeanmarielepioufle/puddingR")
```

## Usage

```R
library(gingeR)

senorge2 <-gingeR(name = "senorge2",format_file="netcdf",auth_type = "none",endpoint = NULL)

# authentication: nothing required here
senorge2$authenticate()

# daily temperature on 2017-03-24
senorge2$GET("http://thredds.met.no/thredds/fileServer/metusers/senorge2/seNorge2/provisional_archive/TEMP1d/gridded_dataset/201703/seNorge_v2_0_TEMP1d_grid_20170324.nc")

# information about handle, header response,...
senorge2$info()
senorge2$status_code()

# information about the values
senorge2$summary()
senorge2$summary(varid="mean_temperature")


# values
senorge2$values(varid="mean_temperature")
senorge2$values(varid="mean_temperature","X")
senorge2$values(varid="mean_temperature","Y")
senorge2$values(varid="mean_temperature","time")

# subset
tmp <- senorge2$values(varid="mean_temperature",offset=list(i=500,j=500,k=1),count=list(i=200,j=200,k=1))

# structure
str(tmp)
image(tmp$vals)
```

I am working on making a vignette.

## Questions and remarks
Don't hesitate to contact me for more details and suggestions.
