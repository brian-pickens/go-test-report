package main_test

import (
	"testing"
)

func TestPass(t *testing.T) {
	t.Log("This test should pass.")
}

func TestFail(t *testing.T) {
	t.Fatal("This test should fail.")
}
