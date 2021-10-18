package database

import (
	"Diploma-go/internal/backend/jsonconvert"
	"Diploma-go/pkg"
	"context"
	"fmt"
	"log"

	"github.com/jackc/pgx/v4"
	"github.com/jackc/pgx/v4/pgxpool"
)

func AddPlayers(players map[int]jsonconvert.Player) bool {

	pool, err := pgxpool.Connect(context.Background(), dbDSN)
	if err != nil {
		log.Fatalf("Unable to connection to database: %v", err)
	}
	defer pool.Close()
	//log.Printf("Connected!")

	conn, err := pool.Acquire(context.Background())
	if err != nil {
		log.Fatalf("Unable to acquire a database connection: %v", err)
	}

	//Drop all database strings
	if cleanResults(conn.Conn()) != nil {
		fmt.Printf("Unable delete: %v", err)
	}
	if cleanPlayers(conn.Conn()) != nil {
		fmt.Printf("Unable delete: %v", err)
	}

	_, err = conn.Exec(context.Background(), "INSERT INTO players (playerid, season, name) VALUES"+pkg.ConvertPlayers(players))
	if err != nil {
		fmt.Printf("Unable to insert: %v", err)
		return false
	}

	_, err = conn.Exec(context.Background(),
		`INSERT INTO results (playerid
		, timeonice
		, assists
		, goals
		, shots
		, hits
		, powerplaygoals
		, powerplayassists
		, penaltyminutes
		, faceoffpct
		, faceoffwins
		, faceofftaken
		, takeaways
		, giveaways
		, shorthandedgoals
		, shorthandedassists
		, blocked
		, plusminus
		, eventimeonice
		, powerplaytimeonice
		, shorthandedtimeonice) VALUES`+pkg.ConvertResults(chPlayers(conn.Conn()), players))
	if err != nil {
		fmt.Printf("Unable to insert: %v", err)
		return false
	}
	conn.Release()
	return true
}

func chPlayers(conn *pgx.Conn) (checkPlayers map[string]int) {

	checkPlayers = make(map[string]int)
	rows, _ := conn.Query(context.Background(),
		`SELECT players.id
			, players.playerid
			FROM players`)

	for rows.Next() {
		var Id int
		var PlayerId string
		err := rows.Scan(&Id, &PlayerId)
		if err != nil {
			fmt.Println("DB ERR:", err)
		}
		checkPlayers[PlayerId] = Id
	}
	return

}

func cleanResults(conn *pgx.Conn) error {
	_, err := conn.Exec(context.Background(), "DELETE FROM results")
	if err != nil {
		return err
	}
	return nil
}

func cleanPlayers(conn *pgx.Conn) error {
	_, err := conn.Exec(context.Background(), "DELETE FROM players")
	if err != nil {
		return err
	}
	return nil
}
