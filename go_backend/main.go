package main

import (
	"encoding/json"
	"log"
	"net/http"
)

type Question struct {
	ID           int      `json:"id"`
	QuestionText string   `json:"question"`
	Options      []string `json:"options"`
	Answer       int      `json:"answer"`       // Index of the correct answer
	Explanation  string   `json:"explanation"`  // Added explanation field
}

func getQuestions(w http.ResponseWriter, r *http.Request) {
	log.Println("Endpoint Hit: getQuestions") // Log to check if endpoint is called

	questions := []Question{
		{ID: 1, QuestionText: "What is Flutter?", Options: []string{"A framework", "A library", "A language", "An IDE"}, Answer: 0, Explanation: "Flutter is a UI toolkit for building natively compiled applications."},
		{ID: 2, QuestionText: "What is Go?", Options: []string{"A framework", "A library", "A language", "An IDE"}, Answer: 2, Explanation: "Go is a statically typed, compiled programming language designed for simplicity and efficiency."},
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(questions)
}

func main() {
	http.HandleFunc("/questions", getQuestions)
	log.Println("Server starting on port 8080") // Log to check if the server starts
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
