package database

type Player struct {
	Id   int
	Name string
	Show bool
	Results
}

type Results struct {
	TimeOnIce            string
	Assists              int
	Goals                int
	Shots                int
	Hits                 int
	PowerPlayGoals       int
	PowerPlayAssists     int
	PowerPlayTimeonice   int
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

type CheckPlayers struct {
	Id       int
	PlayerId string
}
