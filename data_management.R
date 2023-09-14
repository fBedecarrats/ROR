library(tidyverse)
library(aws.s3)

# upload files to S3
deb_files <- list.files(path = "enter", pattern = "res_deb", 
                        recursive = TRUE, 
                        full.names = TRUE) %>%
  str_subset("stunicode", negate = TRUE) 

deb_dest <- paste0("ROR/", deb_files)
  
# A function to put data from local machine to S3
put_to_s3 <- function(from, to) {
  aws.s3::put_object(
    file = from,
    object = to,
    bucket = "fbedecarrats",
    region = "",
    multipart = TRUE)
}

map2(deb_files, deb_dest, put_to_s3)

Sys.setenv("AWS_ACCESS_KEY_ID" = "XXXXXXXXXXXXXXXXX",
           "AWS_SECRET_ACCESS_KEY" = "XXXXXXXXXXXXXXXXX",
           "AWS_DEFAULT_REGION" = "us-east-1",
           "AWS_SESSION_TOKEN" = "XXXXXXXXXXXXXXXXX",
           "AWS_S3_ENDPOINT"= "minio.lab.sspcloud.fr")
