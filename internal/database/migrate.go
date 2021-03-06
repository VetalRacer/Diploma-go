package database

import (
	"context"
	"log"

	"github.com/jackc/pgx/v4"
	"github.com/jackc/pgx/v4/pgxpool"
	"github.com/jackc/tern/migrate"
)

func Connect() {
	pool, err := pgxpool.Connect(context.Background(), dbDSN)
	if err != nil {
		log.Fatalf("Unable to connection to database: %v", err)
	}
	defer pool.Close()
	log.Printf("[INFO] Connected to database!")

	conn, err := pool.Acquire(context.Background())
	if err != nil {
		log.Fatalf("Unable to acquire a database connection: %v", err)
	}
	migrateDatabase(conn.Conn())
	conn.Release()
}

func migrateDatabase(conn *pgx.Conn) {
	migrator, err := migrate.NewMigrator(context.Background(), conn, "schema_version")
	if err != nil {
		log.Fatalf("Unable to create a migrator: %v", err)
	}

	err = migrator.LoadMigrations("./migrations")
	if err != nil {
		log.Fatalf("Unable to load migrations: %v", err)
	}

	err = migrator.Migrate(context.Background())

	if err != nil {
		log.Fatalf("Unable to migrate: %v", err)
	}

	ver, err := migrator.GetCurrentVersion(context.Background())
	if err != nil {
		log.Fatalf("Unable to get current schema version: %v", err)
	}

	log.Printf("[INFO] Migration done. Current schema version: %v", ver)
}
