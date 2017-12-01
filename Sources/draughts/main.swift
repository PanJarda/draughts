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

    print("   a  b  c  d  e  f  g  h")
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

typealias Rule = (Board, Move) -> MoveValidity

enum MoveValidity: String {
    case valid = "valid move"
    case pieceDoesNotExist = "piece does not exist"
    case notYourPiece = "not your piece"
    case endSquareNotEmpty = "end square is not empty"
}

func pieceExists(_ board: Board, _ move: Move) -> MoveValidity {
    let coord = move.vector.from
    let piece = board[coord.row][coord.col]

    if piece == 0 {
        return MoveValidity.pieceDoesNotExist
    } else if move.player == Player.white && piece < 0 {
        return MoveValidity.notYourPiece
    } else if move.player == Player.black && piece > 0 {
        return MoveValidity.notYourPiece
    }

    return MoveValidity.valid
}

func endSquareIsEmpty(_ board: Board, _ move: Move) -> MoveValidity {
    let coord = move.vector.to
    let square = board[coord.row][coord.col]

    if square == 0 {
        return MoveValidity.valid
    }

    return MoveValidity.endSquareNotEmpty
}

typealias Rules = Array<Rule>

let rules: Rules = [
    pieceExists,
    endSquareIsEmpty
]

func checkValidity(of move: Move, on board: Board, by rules: Rules) -> MoveValidity {
    for rule in rules {
        let moveValidity = rule(board, move)

        if moveValidity != MoveValidity.valid {
            return moveValidity
        }
    }

    return MoveValidity.valid
}

// print(checkValidity(of: move1, on: initialBoard, by: rules).rawValue)

func apply(_ move: Move, on board: Board) -> Board {
    let from = move.vector.from
    let to = move.vector.to
    let piece = board[from.row][from.col]

    var newBoard = board
    newBoard[from.row][from.col] = 0
    newBoard[to.row][to.col] = piece

    return newBoard
}

func translateToVector(from move: String) -> Vector? {
    let cols: [String: Int] = [
        "a": 0,
        "b": 1,
        "c": 2,
        "d": 3,
        "e": 4,
        "f": 5,
        "g": 6,
        "h": 7,
        "A": 0,
        "B": 1,
        "C": 2,
        "D": 3,
        "E": 4,
        "F": 5,
        "G": 6,
        "H": 7
    ]

    let coordinates = move.split(separator: " ")

    if coordinates.count != 2 {
        return nil
    }

    let fromCol = cols[String(coordinates[0].prefix(1))]

    if fromCol == nil {
        return nil
    }

    let fromRowTmp = Int(coordinates[0].dropFirst())

    if fromRowTmp == nil {
        return nil
    }

    let fromRow = 8 - fromRowTmp!

    let toCol = cols[String(coordinates[1].prefix(1))]

    if toCol == nil {
        return nil
    }

    let toRowTmp = Int(coordinates[1].dropFirst())

    if toRowTmp == nil {
        return nil
    }

    let toRow = 8 - toRowTmp!

    return Vector(from: (col: fromCol!, row: fromRow), to: (col: toCol!, row: toRow))
}

func prompt(for player: Player) -> Void {
    switch player {
        case .white:
            print("Player1> ", terminator: "")
        case .black:
            print("Player2> ", terminator: "")
    }
}

func createMove(for player: Player, from move: String) -> Move? {
    let vector = translateToVector(from: move)

    if vector == nil {
        return nil
    }

    return Move(
            player: player,
            vector: vector!
    )
}

func main() -> Void {
    printBoard(initialBoard)
    var board = initialBoard
    var player = Player.white

    while true {
        prompt(for: player)

        let userInput = readLine()

        if userInput == nil {
            print("?")
            continue
        }

        if userInput == "q" {
            break
        }

        let move = createMove(for: player, from: userInput!)

        if move == nil {
            print("?")
            continue
        }

        board = apply(move!, on: board)

        printBoard(board)

        if player == Player.white {
            player = Player.black
        } else {
            player = Player.white
        }
    }
}

main()
