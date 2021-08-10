package api

import (
	"log"
	"net/http"
)

//func for get content

func GetApiContent(url string) *http.Response {
	res, err := http.Get(url)
	if err != nil {
		log.Printf("error: %v", err)
	}

	if res.StatusCode != http.StatusOK {
		log.Printf(res.Status)
	}
	//defer res.Body.Close()
	return res
}
