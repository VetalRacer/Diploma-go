package database

import (
	"os"
)

var dbhost, err = os.LookupEnv("DB_HOST")

var dbDSN = "postgres://postgres:s3cr3t@" + dbhost + ":5432/nhl"
