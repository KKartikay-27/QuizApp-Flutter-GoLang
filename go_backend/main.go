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
	Explanation  string   `json:"explanation"`  // Explanation field
	ImageURL     *string  `json:"image_url"`    // Optional image_url field
}

func getQuestions(w http.ResponseWriter, r *http.Request) {
	// Add CORS headers
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "GET, OPTIONS")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

	// Handle preflight OPTIONS request
	if r.Method == http.MethodOptions {
		return
	}

	log.Println("Endpoint Hit: getQuestions") // Log to check if endpoint is called

	questions := []Question{
		{ID: 1, QuestionText: "What is the capital of France?", ImageURL: stringPtr("https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/1920px-Flag_of_France.svg.png"), Options: []string{"Berlin", "Madrid", "Paris", "Rome"}, Answer: 2, Explanation: "Paris is the capital city of France."},
		{ID: 2, QuestionText: "What is the largest planet in our solar system?", ImageURL: stringPtr("https://upload.wikimedia.org/wikipedia/commons/c/c1/Jupiter_New_Horizons.jpg"), Options: []string{"Earth", "Mars", "Jupiter", "Saturn"}, Answer: 2, Explanation: "Jupiter is the largest planet in our solar system."},
		{ID: 3, QuestionText: "Who wrote 'To Kill a Mockingbird'?", Options: []string{"Harper Lee", "Mark Twain", "J.K. Rowling", "Ernest Hemingway"}, Answer: 0, Explanation: "Harper Lee is the author of 'To Kill a Mockingbird'."},
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(questions)
}

// Helper function to return a pointer to a string
func stringPtr(s string) *string {
	return &s
}

func main() {
	http.HandleFunc("/questions", getQuestions)
	log.Println("Server starting on port 8080") // Log to check if the server starts
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
