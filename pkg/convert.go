package pkg

import (
	"Diploma-go/internal/backend/jsonconvert"
	"bytes"
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

func ConvertPlayers(s map[int]jsonconvert.Player) string {

	var buffer bytes.Buffer
	re := regexp.MustCompile(`'`)
	for k, v := range s {
		buffer.WriteString(fmt.Sprintf("('%s', '%s','%s'),\n", strconv.Itoa(k), v.Person.Season[:4]+"-"+v.Person.Season[4:], re.ReplaceAllString(v.Person.FullName, " ")))
	}
	w := strings.TrimSuffix(buffer.String(), ",\n")
	return w
}

func ConvertResults(ch map[string]int, s map[int]jsonconvert.Player) string {

	var buffer bytes.Buffer

	for k, v := range s {
		buffer.WriteString(fmt.Sprintf("('%d','%s','%d','%d','%d','%d','%d','%d','%d','%f','%d','%d','%d','%d','%d','%d','%d','%d','%s','%s','%s'),\n",
			ch[strconv.Itoa(k)],
			v.Stats.TimeOnIce,
			v.Stats.Assists,
			v.Stats.Goals,
			v.Stats.Shots,
			v.Stats.Hits,
			v.Stats.PowerPlayGoals,
			v.Stats.PowerPlayAssists,
			v.Stats.PenaltyMinutes,
			v.Stats.FaceOffPct,
			v.Stats.FaceOffWins,
			v.Stats.FaceoffTaken,
			v.Stats.Takeaways,
			v.Stats.Giveaways,
			v.Stats.ShortHandedGoals,
			v.Stats.ShortHandedAssists,
			v.Stats.Blocked,
			v.Stats.PlusMinus,
			v.Stats.EvenTimeOnIce,
			v.Stats.PowerPlayTimeOnIce,
			v.Stats.ShortHandedTimeOnIce))
	}
	return strings.TrimSuffix(buffer.String(), ",\n")
}
