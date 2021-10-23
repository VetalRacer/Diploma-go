package frontend

import (
	"Diploma-go/internal/backend"
	"Diploma-go/internal/database"
	"Diploma-go/pkg"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"strconv"
)

var displayPlayers = database.GetPlayers()

func HandleRequest() {

	database.Connect()

	//css style
	fs := http.FileServer(http.Dir("./templates/css"))
	http.Handle("/templates/css/", http.StripPrefix("/templates/css/", fs))

	http.HandleFunc("/", indexPage)
	http.HandleFunc("/update/", updateDb)
	http.HandleFunc("/presentation/", downloadPresentation)
	http.HandleFunc("/stresstest/", stressTest)
	err := http.ListenAndServe(":80", nil)
	if err != nil {
		return
	}
}

func indexPage(w http.ResponseWriter, r *http.Request) {

	id := r.URL.Query().Get("id")
	if id != "" {
		if playerId, err := strconv.Atoi(id); err == nil {
			showPlayerTrue(playerId)
			log.Printf("[INFO] Show PlayerId: %d", playerId)
		}
	} else {
		showPlayerTrue(0)
	}

	tmpl, err := template.ParseFiles("templates/index.html")
	if err != nil {
		fmt.Println(err)
	}

	err = tmpl.Execute(w, displayPlayers)
	if err != nil {
		return
	}

}

func updateDb(w http.ResponseWriter, r *http.Request) {

	backend.GetPlayer()
	displayPlayers = database.GetPlayers()
	http.Redirect(w, r, "/", http.StatusSeeOther)

	log.Printf("[INFO] Database success updated!")
}

func downloadPresentation(w http.ResponseWriter, r *http.Request) {

	filename := "Diploma-go.pdf"
	filePath := "raw/Diploma-go.pdf"

	w.Header().Set("Content-Disposition", "attachment; filename="+strconv.Quote(filename))
	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Length", r.Header.Get("Content-Length"))
	http.ServeFile(w, r, filePath)
}

func stressTest(w http.ResponseWriter, r *http.Request) {

	pkg.Stress()
	http.Redirect(w, r, "/", http.StatusSeeOther)
}

func showPlayerTrue(id int) {
	for _, v := range displayPlayers {
		for _, y := range v {
			if y.Id == id {
				y.Show = true
			} else {
				y.Show = false
			}
		}
	}
}
