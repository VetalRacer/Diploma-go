package jsonconvert

import (
	"encoding/json"
	"fmt"
	"net/http"
)

//All func for convert Json to go-struct

func ConvertSeasonGames(res *http.Response, result Seasons) Seasons {
	if err := json.NewDecoder(res.Body).Decode(&result); err != nil {
		fmt.Println(err)
	}
	return result
}

func ConvertAllStar(res *http.Response, result AllStar) AllStar {
	if err := json.NewDecoder(res.Body).Decode(&result); err != nil {
		fmt.Println(err)
	}
	return result
}

func ConvertGamePlayers(res *http.Response, result GamePlayers) GamePlayers {
	if err := json.NewDecoder(res.Body).Decode(&result); err != nil {
		fmt.Println(err)
	}
	return result
}

func ConvertSeasonGame(res *http.Response, result SeasonGame) SeasonGame {
	if err := json.NewDecoder(res.Body).Decode(&result); err != nil {
		fmt.Println(err)
	}
	return result
}
