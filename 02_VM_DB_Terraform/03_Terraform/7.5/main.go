package main

import "fmt"

func main() {

    for{
        fmt.Println("\nEnter the command: ")
        fmt.Println("1 - Сonvert meters to feet")
        fmt.Println("2 - Finds the smallest element in any given list")
        fmt.Println("3 - Prints numbers from 1 to 100 that are divisible by 3")

        var command int
        fmt.Scanf("%d", &command)
        if command == 1 {
                var meters float64
    fmt.Print("Enter the number of meters: ")
    fmt.Scanf("%f", &meters)
		    fmt.Println("Result: ",ConvertMetrToFeet(meters))
	    } else if command == 2 {
	        fmt.Println("Result: ",FindMinInList())
	    } else if command == 3 {
            fmt.Println("Result:", From1to100div3())
	    } else {
	        fmt.Println("Bad command")
	    }
	}
}

func ConvertMetrToFeet(meters float64) float64{
    return meters * 3.048
}

func FindMinInList() int{

    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}

    for{
        fmt.Println("\nFind min in new list or default?: ")
        fmt.Println("1 - Set New Default list")
        fmt.Println("2 - Find min in Default list")
        fmt.Println("Default List: ",x)


        var command int
        fmt.Scanf("%d",&command)

        switch command{
            case 1:
                new_x := SetList()
                x = new_x
            case 2:
                var min = x[0]
                for i := 0; i < len(x); i++ {
                    if x[i] < min {
                        min = x[i]
                    }
                }
                return min
            default:
                fmt.Println("Bad command")
        }
    }
}

func SetList()[]int{

    fmt.Println("\nSet List: ")
    fmt.Println("Enter count list elements: ")

    var count_list int
    fmt.Scanf("%d",&count_list)

    x := make([]int, count_list)
    for i := 0; i < count_list; i++ {
        fmt.Scanf("%d",&x[i])
    }

    return x
}

func From1to100div3()[]int{

    var k int
    k = 0
    x := make([]int,33)

    for i := 1; i < 100; i++{
        if i%3 == 0{
            x[k] = i
            k++
        }
    }

    return x
}
