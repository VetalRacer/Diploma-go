package backend

import (
	"Diploma-go/configs"
	"Diploma-go/internal/backend/jsonconvert"
	"Diploma-go/internal/database"
	"Diploma-go/pkg/api"
	"fmt"
	"log"
	"strconv"
)

var comparePlayer = make(map[int]jsonconvert.Player)

func GetPlayer() {

	//Get last 3 season id
	sgJson := jsonconvert.ConvertSeasonGames(api.GetApiContent(Seasons), jsonconvert.Seasons{})
	SeasonID := getSeasonID(sgJson)

	for _, s := range SeasonID {
		//get AllStar games id
		asJson := jsonconvert.ConvertAllStar(api.GetApiContent(StarGames+s), jsonconvert.AllStar{})
		SeasonAllStar := getAllStarId(asJson)
		PlayerAllStar := make(map[int]jsonconvert.Player)
		if SeasonAllStar != nil {
			//get Players for AllStar games
			for _, v := range SeasonAllStar {
				pasJson := jsonconvert.ConvertGamePlayers(api.GetApiContent(GamePlayers+strconv.Itoa(v)+"/boxscore"), jsonconvert.GamePlayers{})
				getPlayers(pasJson, s, &PlayerAllStar)
			}
		}

		//get Final games id
		sJson := jsonconvert.ConvertSeasonGame(api.GetApiContent(SeasonGames+s), jsonconvert.SeasonGame{})
		SeasonGame, err := getSeasonGameFinal(sJson)
		PlayerFinalGame := make(map[int]jsonconvert.Player)
		if err == nil {
			//get Players for Final game
			psJson := jsonconvert.ConvertGamePlayers(api.GetApiContent(GamePlayers+strconv.Itoa(SeasonGame)+"/boxscore"), jsonconvert.GamePlayers{})
			getPlayers(psJson, s, &PlayerFinalGame)
		}

		//Check people who take part in all-stars-game and the final game
		err = checkPlayer(PlayerFinalGame, PlayerAllStar)
		if err != nil {
			log.Printf("Error: ", err)
		}

		if len(comparePlayer) != 0 {
			database.AddPlayers(comparePlayer)
		}
	}
}

func getSeasonID(sg jsonconvert.Seasons) []string {
	var sd []string
	last3seasonId := len(sg.Seasons) - configs.SetSeason
	for i := last3seasonId; i <= len(sg.Seasons)-1; i++ {
		sd = append(sd, sg.Seasons[i].SeasonID)
	}
	return sd
}

func getAllStarId(as jsonconvert.AllStar) []int {
	var ad []int
	for _, g := range as.Dates {
		for _, id := range g.Games {
			ad = append(ad, id.GamePk)
		}
	}
	return ad
}

func getSeasonGameFinal(s jsonconvert.SeasonGame) (int, error) {
	var sgd []int
	for _, g := range s.Dates {
		for _, id := range g.Games {
			sgd = append(sgd, id.GamePk)
		}
	}
	if sgd != nil {
		return sgd[len(sgd)-1], nil
	} else {
		return 0, fmt.Errorf("not found final game")
	}
}

func getPlayers(p jsonconvert.GamePlayers, s string, playerIDs *map[int]jsonconvert.Player) {
	var Player = new(jsonconvert.Player)
	for _, t := range p.Teams.Away.Players {
		Player.Person.Season = s
		Player.Person.FullName = t.Person.FullName
		Player.Stats.TimeOnIce = t.Stats.SkaterStats.TimeOnIce
		Player.Stats.Assists = t.Stats.SkaterStats.Assists
		Player.Stats.Goals = t.Stats.SkaterStats.Goals
		Player.Stats.Shots = t.Stats.SkaterStats.Shots
		Player.Stats.Hits = t.Stats.SkaterStats.Hits
		Player.Stats.PowerPlayGoals = t.Stats.SkaterStats.PowerPlayGoals
		Player.Stats.PowerPlayAssists = t.Stats.SkaterStats.PowerPlayAssists
		Player.Stats.PenaltyMinutes = t.Stats.SkaterStats.PenaltyMinutes
		Player.Stats.FaceOffPct = t.Stats.SkaterStats.FaceOffPct
		Player.Stats.FaceOffWins = t.Stats.SkaterStats.FaceOffWins
		Player.Stats.FaceoffTaken = t.Stats.SkaterStats.FaceoffTaken
		Player.Stats.Takeaways = t.Stats.SkaterStats.Takeaways
		Player.Stats.Giveaways = t.Stats.SkaterStats.Giveaways
		Player.Stats.ShortHandedGoals = t.Stats.SkaterStats.ShortHandedGoals
		Player.Stats.ShortHandedAssists = t.Stats.SkaterStats.ShortHandedAssists
		Player.Stats.Blocked = t.Stats.SkaterStats.Blocked
		Player.Stats.PlusMinus = t.Stats.SkaterStats.PlusMinus
		Player.Stats.EvenTimeOnIce = t.Stats.SkaterStats.EvenTimeOnIce
		Player.Stats.PowerPlayTimeOnIce = t.Stats.SkaterStats.PowerPlayTimeOnIce
		Player.Stats.ShortHandedTimeOnIce = t.Stats.SkaterStats.ShortHandedTimeOnIce

		(*playerIDs)[t.Person.ID] = *Player
	}
	for _, t := range p.Teams.Home.Players {
		Player.Person.FullName = t.Person.FullName
		Player.Stats.TimeOnIce = t.Stats.SkaterStats.TimeOnIce
		Player.Stats.Assists = t.Stats.SkaterStats.Assists
		Player.Stats.Goals = t.Stats.SkaterStats.Goals
		Player.Stats.Shots = t.Stats.SkaterStats.Shots
		Player.Stats.Hits = t.Stats.SkaterStats.Hits
		Player.Stats.PowerPlayGoals = t.Stats.SkaterStats.PowerPlayGoals
		Player.Stats.PowerPlayAssists = t.Stats.SkaterStats.PowerPlayAssists
		Player.Stats.PenaltyMinutes = t.Stats.SkaterStats.PenaltyMinutes
		Player.Stats.FaceOffPct = t.Stats.SkaterStats.FaceOffPct
		Player.Stats.FaceOffWins = t.Stats.SkaterStats.FaceOffWins
		Player.Stats.FaceoffTaken = t.Stats.SkaterStats.FaceoffTaken
		Player.Stats.Takeaways = t.Stats.SkaterStats.Takeaways
		Player.Stats.Giveaways = t.Stats.SkaterStats.Giveaways
		Player.Stats.ShortHandedGoals = t.Stats.SkaterStats.ShortHandedGoals
		Player.Stats.ShortHandedAssists = t.Stats.SkaterStats.ShortHandedAssists
		Player.Stats.Blocked = t.Stats.SkaterStats.Blocked
		Player.Stats.PlusMinus = t.Stats.SkaterStats.PlusMinus
		Player.Stats.EvenTimeOnIce = t.Stats.SkaterStats.EvenTimeOnIce
		Player.Stats.PowerPlayTimeOnIce = t.Stats.SkaterStats.PowerPlayTimeOnIce
		Player.Stats.ShortHandedTimeOnIce = t.Stats.SkaterStats.ShortHandedTimeOnIce

		(*playerIDs)[t.Person.ID] = *Player
	}
}

func checkPlayer(f, as map[int]jsonconvert.Player) error {
	for fkey, value := range f {
		if _, ok := as[fkey]; ok {
			comparePlayer[fkey] = value
		}
	}
	if len(comparePlayer) != 0 {
		return nil
	}
	return fmt.Errorf("null player")
}
