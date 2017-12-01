let initialBoard: Array<Array<Int>> = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [0, 0, 0, 0, 0, 0, 0, 0]
]

let pieces: [Character] = ["K", "M", ".", "m", "k"]

func printBoard(_ board: Array<Array<Int>>, with pieces: Array<Character>) -> Void {
    var rowNum: Int = 8

    for row in board {
        print("\(rowNum) ", terminator: "")

        for square in row {
            print(" \(pieces[square + 2]) ", terminator: "")
        }

        print("")
        rowNum -= 1
    }

    print("   A  B  C  D  E  F  G  H")
}

printBoard(initialBoard, with: pieces)

