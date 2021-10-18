package database

import (
	"context"
	"fmt"
	"log"

	"github.com/jackc/pgx/v4/pgxpool"
)

func GetPlayers() (players map[string][]*Player) {
	players = make(map[string][]*Player)

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

	rows, _ := conn.Query(context.Background(),
		`SELECT players.id
			, players.season
			, players.name
			, results.timeonice
			, results.assists
			, results.goals
			, results.shots
			, results.hits
			, results.powerplaygoals
			, results.powerplayassists
			, results.powerplaytimeonice
			, results.penaltyminutes
			, results.faceoffpct
			, results.faceoffwins
			, results.faceofftaken
			, results.takeaways
			, results.giveaways
			, results.shorthandedgoals
			, results.shorthandedassists
			, results.blocked
			, results.plusminus
			, results.eventimeonice
			, results.shorthandedtimeonice

			
			FROM players
			JOIN results ON players.id = results.playerid`)

	for rows.Next() {
		var p Player
		var season string
		err = rows.Scan(&p.Id, &season, &p.Name, &p.TimeOnIce, &p.Assists, &p.Goals, &p.Shots, &p.Hits, &p.PowerPlayGoals, &p.PowerPlayAssists,
			&p.PowerPlayTimeOnIce, &p.PenaltyMinutes, &p.FaceOffPct, &p.FaceOffWins, &p.FaceoffTaken, &p.Takeaways, &p.Giveaways,
			&p.ShortHandedGoals, &p.ShortHandedAssists, &p.Blocked, &p.PlusMinus, &p.EvenTimeOnIce, &p.ShortHandedTimeOnIce)

		if err != nil {
			fmt.Println("DB ERR:", err)
		}
		players[season] = append(players[season], &p)
	}
	conn.Release()
	return
}
