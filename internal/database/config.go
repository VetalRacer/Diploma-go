package database

import (
	"os"
)

var dbhost, err = os.LookupEnv("DB_HOST")

var dbDSN = "postgres://psqladminun:H@Sh1CoR3!@" + dbhost + ":5432/nhl"
