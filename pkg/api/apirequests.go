package api

import (
	"fmt"
	"log"
	"net/http"
)

//func for get content

func GetApiContent(url string) *http.Response {
	res, err := http.Get(url)
	if err != nil {
		fmt.Println(nil, err)
	}

	if res.StatusCode != http.StatusOK {
		log.Printf(res.Status)
	}
	//defer res.Body.Close()
	return res
}
