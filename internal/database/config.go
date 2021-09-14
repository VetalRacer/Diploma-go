package database

import (
	"os"
)

var dbhost, err = os.LookupEnv("DB_HOST")
var dblogin, err = os.LookupEnv("DB_LOGIN")
var dbpass, err = os.LookupEnv("DB_PASS")

var dbDSN = "postgres://" + dblogin + ":" + dbpass + dbhost + ":5432/nhl"
