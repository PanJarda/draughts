typealias Board = Array<Array<Int>>
let initialBoard: Board = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [0, 0, 0, 0, 0, 0, 0, 0]
]

typealias PieceNames = [Character]
let pieces: PieceNames = ["K", "M", ".", "m", "k"]

func printBoard(_ board: Board, with pieces: PieceNames = pieces) -> Void {
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

enum Player {
    case white, black
}

// printBoard(initialBoard)
typealias Coordinate = (col: Int, row: Int)
typealias Vector = (from: Coordinate, to: Coordinate)

struct Move {
    let player: Player
    let vector: Vector
}

let move1 = Move(
        player: Player.white,
        vector: ((0, 2), (1, 3))
)

func pieceExists(_ board: Board,_ move: Move) -> Bool {
    let coord = move.vector.from
    let piece = board[coord.row][coord.col]

    if piece == 0 {
        return false
    } else if move.player == Player.white && piece > 0 {
        return false
    } else if move.player == Player.black && piece < 0 {
        return false
    }

    return true
}

func endSquareIsEmpty(_ board: Board, _ move: Move) -> Bool {
    let coord = move.vector.to
    let square = board[coord.row][coord.col]

    if square == 0 {
        return true
    }

    return false
}





