package main

import (
	"fmt"
	"log"
	"net/http"
	"os/exec"
)

// test
func handler(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		http.Error(w, "Invalid method", http.StatusMethodNotAllowed)
		return
	}

	go func() {
		cmd := exec.Command("zsh", "-lc", "./sh/erp_backend.sh")
		err := cmd.Run()
		if err != nil {
			log.Printf("Deploy for erp_backend failed: %v", err)
		}
	}()
	log.Printf("Deploy triggered %v", w)
}

func cdHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		http.Error(w, "Invalid method", http.StatusMethodNotAllowed)
		return
	}

	go func() {
		cmd := exec.Command("bash", "-lc", "./sh/cd_pipeline.sh")
		err := cmd.Run()
		if err != nil {
			log.Printf("Deploy for cd app failed: %v", err)
			http.Error(w, "success", http.StatusOK)
		}
	}()
	log.Printf("Deploy triggered %v", w)
	http.Error(w, "success", http.StatusOK)
}

func crmHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != "POST" {
		http.Error(w, "Invalid method", http.StatusMethodNotAllowed)
		return
	}
	// You can parse the payload here if needed
	go func() {
		cmd := exec.Command("./sh/crm.sh")
		err := cmd.Run()
		if err != nil {
			log.Printf("Deploy for crm failed: %v", err)
		}
	}()
	log.Printf("Deploy triggered %v", w)
}

func main() {
	http.HandleFunc("/erp_backend", handler)
	http.HandleFunc("/cd", cdHandler)
	http.HandleFunc("/crm", crmHandler)
	fmt.Println("Listening on :9000")
	log.Fatal(http.ListenAndServe(":9000", nil))
}
