import Utilities
import XCTest
import Lexer

/// Test file: https://daringfireball.net/projects/markdown/syntax.text
final class LexerTests: XCTestCase {
    let lexer: Lexer = {
        let generators = HandlerList<TokenGenerator>(handlers: [
            MarkdownSymbolGenerator(),
            AlphaNumericGenerator(),
            NewLineGenerator()
        ], default: DefaultGenerator())
        return Lexer(generators: generators)
    }()

    let markdown = { () -> [UInt8] in
        let url = URL(string: "https://daringfireball.net/projects/markdown/syntax.text")!
        return try! Array(Data(contentsOf: url))
    }()
    
    func testMeasureLex() throws {

        // Baseline: 0.044
        measure {
            do {
                _ = try self.lexer.lex(string: self.markdown)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
