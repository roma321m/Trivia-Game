import Foundation

class MyData : Decodable {
    var allQuastions: [Quastion]?
    var allAnswers : Answers?
}

class Quastion : Decodable {
    var imageUrl : String?
    var answer : String?
}

class Answers : Decodable {
    var all : [String]?
}
