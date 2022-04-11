package main

import "testing"

func Test_ConvertMetrToFeet(t *testing.T) {
    var v float64
    v = ConvertMetrToFeet(10)
    if v == 30.48 {
        t.Log("Test successful")
    }
}