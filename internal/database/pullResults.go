package database

import (
	"context"
	"fmt"
	"github.com/jackc/pgx"
)

func GetPlayers() (players map[string][]*Player) {
	players = make(map[string][]*Player)

	conn, err := pgx.Connect(context.Background(), dbDSN)
	if err != nil {
		fmt.Println("DB ERR:", err)
		return
	}
	defer func(conn *pgx.Conn, ctx context.Context) {
		err := conn.Close(ctx)
		if err != nil {

		}
	}(conn, context.Background())

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
	return
}
