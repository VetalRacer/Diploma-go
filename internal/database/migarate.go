package database

import (
	"context"
	"github.com/jackc/pgx"
	"github.com/jackc/tern/migrate"
	"log"
)

func MigrateDatabase() {

	conn, err := pgx.Connect(context.Background(), dbDSN)
	if err != nil {
		log.Fatalf("Unable to connection to database: %v", err)
	}
	defer func(conn *pgx.Conn, ctx context.Context) {
		err := conn.Close(ctx)
		if err != nil {

		}
	}(conn, context.Background())
	log.Printf("Connected!")

	migrator, err := migrate.NewMigrator(context.Background(), conn, "schema_version")
	if err != nil {
		log.Fatalf("Unable to create a migrator: %v\n", err)
	}

	err = migrator.LoadMigrations("./migrations")
	if err != nil {
		log.Fatalf("Unable to load migrations: %v\n", err)
	}

	err = migrator.Migrate(context.Background())
	if err != nil {
		log.Fatalf("Unable to migrate: %v\n", err)
	}

	ver, err := migrator.GetCurrentVersion(context.Background())
	if err != nil {
		log.Fatalf("Unable to get current schema version: %v\n", err)
	}

	log.Printf("Migration done. Current schema version: %v\n", ver)
}
