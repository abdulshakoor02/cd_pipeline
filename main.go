package main

import (
	"fmt"
	"log"
	"net/http"
	"os/exec"
)

func handler(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		http.Error(w, "Invalid method", http.StatusMethodNotAllowed)
		return
	}
	// You can parse the payload here if needed
	go func() {
		cmd := exec.Command("./sh/erp_backend.sh")
		err := cmd.Run()
		if err != nil {
			log.Printf("Deploy failed: %v", err)
		}
	}()
	log.Printf("Deploy triggered %v", w)
}

func cdHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		http.Error(w, "Invalid method", http.StatusMethodNotAllowed)
		return
	}
	// You can parse the payload here if needed
	go func() {
		cmd := exec.Command("./sh/cd_pipeline.sh")
		err := cmd.Run()
		if err != nil {
			log.Printf("Deploy failed: %v", err)
		}
	}()
	log.Printf("Deploy triggered %v", w)
}

func main() {
	http.HandleFunc("/erp_backend", handler)
	http.HandleFunc("/cd", cdHandler)
	fmt.Println("Listening on :9000")
	log.Fatal(http.ListenAndServe(":9000", nil))
}
