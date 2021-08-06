package jsonconvert

type Seasons struct {
	Seasons []struct {
		SeasonID string `json:"seasonId"`
	} `json:"seasons"`
}

type AllStar struct {
	Dates []struct {
		Games []struct {
			GamePk int `json:"gamePk"`
		} `json:"games"`
	} `json:"dates"`
}

type SeasonGame struct {
	Dates []struct {
		Games []struct {
			GamePk int `json:"gamePk"`
		} `json:"games"`
	} `json:"dates"`
}

type Player struct {
	Person struct {
		Season   string
		FullName string
	}
	Stats struct {
		TimeOnIce            string
		Assists              int
		Goals                int
		Shots                int
		Hits                 int
		PowerPlayGoals       int
		PowerPlayAssists     int
		PenaltyMinutes       int
		FaceOffPct           float64
		FaceOffWins          int
		FaceoffTaken         int
		Takeaways            int
		Giveaways            int
		ShortHandedGoals     int
		ShortHandedAssists   int
		Blocked              int
		PlusMinus            int
		EvenTimeOnIce        string
		PowerPlayTimeOnIce   string
		ShortHandedTimeOnIce string
	}
}

type GamePlayers struct {
	Teams struct {
		Away struct {
			Players map[string]struct {
				Person struct {
					ID        int    `json:"id"`
					FullName  string `json:"fullName"`
					BirthDate string `json:"birthDate"`
				} `json:"person"`
				Stats struct {
					SkaterStats struct {
						TimeOnIce            string  `json:"timeOnIce"`
						Assists              int     `json:"assists"`
						Goals                int     `json:"goals"`
						Shots                int     `json:"shots"`
						Hits                 int     `json:"hits"`
						PowerPlayGoals       int     `json:"powerPlayGoals"`
						PowerPlayAssists     int     `json:"powerPlayAssists"`
						PenaltyMinutes       int     `json:"penaltyMinutes"`
						FaceOffPct           float64 `json:"faceOffPct"`
						FaceOffWins          int     `json:"faceOffWins"`
						FaceoffTaken         int     `json:"faceoffTaken"`
						Takeaways            int     `json:"takeaways"`
						Giveaways            int     `json:"giveaways"`
						ShortHandedGoals     int     `json:"shortHandedGoals"`
						ShortHandedAssists   int     `json:"shortHandedAssists"`
						Blocked              int     `json:"blocked"`
						PlusMinus            int     `json:"plusMinus"`
						EvenTimeOnIce        string  `json:"evenTimeOnIce"`
						PowerPlayTimeOnIce   string  `json:"powerPlayTimeOnIce"`
						ShortHandedTimeOnIce string  `json:"shortHandedTimeOnIce"`
					} `json:"skaterStats"`
				} `json:"stats"`
			} `json:"players"`
		} `json:"away"`
		Home struct {
			Players map[string]struct {
				Person struct {
					ID        int    `json:"id"`
					FullName  string `json:"fullName"`
					BirthDate string `json:"birthDate"`
				} `json:"person"`
				Stats struct {
					SkaterStats struct {
						TimeOnIce            string  `json:"timeOnIce"`
						Assists              int     `json:"assists"`
						Goals                int     `json:"goals"`
						Shots                int     `json:"shots"`
						Hits                 int     `json:"hits"`
						PowerPlayGoals       int     `json:"powerPlayGoals"`
						PowerPlayAssists     int     `json:"powerPlayAssists"`
						PenaltyMinutes       int     `json:"penaltyMinutes"`
						FaceOffPct           float64 `json:"faceOffPct"`
						FaceOffWins          int     `json:"faceOffWins"`
						FaceoffTaken         int     `json:"faceoffTaken"`
						Takeaways            int     `json:"takeaways"`
						Giveaways            int     `json:"giveaways"`
						ShortHandedGoals     int     `json:"shortHandedGoals"`
						ShortHandedAssists   int     `json:"shortHandedAssists"`
						Blocked              int     `json:"blocked"`
						PlusMinus            int     `json:"plusMinus"`
						EvenTimeOnIce        string  `json:"evenTimeOnIce"`
						PowerPlayTimeOnIce   string  `json:"powerPlayTimeOnIce"`
						ShortHandedTimeOnIce string  `json:"shortHandedTimeOnIce"`
					} `json:"skaterStats"`
				} `json:"stats"`
			} `json:"players"`
		} `json:"home"`
	} `json:"teams"`
}
