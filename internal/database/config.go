package database

import (
	"os"
)

var dbhost, _ = os.LookupEnv("DB_HOST")
var dblogin, _ = os.LookupEnv("DB_LOGIN")
var dbpass, _ = os.LookupEnv("DB_PASS")
var dbname, _ = os.LookupEnv("DB_NAME")

var dbDSN = "postgres://" + dblogin + ":" + dbpass + "@" + dbhost + ":5432/" + dbname