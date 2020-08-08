import Foundation

struct CodeJugde {
    static let TEMP = "codejudge_tmp"
    static let EXECUTABLE_SWIFT = URL(fileURLWithPath: "/usr/bin/swift")
    static func judge(swiftFileName: String, inputs: [String], outputs: [String], _ confirmFunc: (String) -> ()) throws -> Bool {
        guard let tmpPath = URL(string: TEMP) else { return false }
        let fileManager = FileManager.default
        fileManager.createFile(atPath: TEMP, contents: nil)
        
        guard fileManager.fileExists(atPath: swiftFileName) else {
            confirmFunc("ファイルが見つかりません。")
            return false
        }
        
        return try zip(inputs, outputs).allSatisfy { (input, output) in
            confirmFunc("input:\n\(input)")
            confirmFunc("correct output:\n\(output)")
            let fileHandle = try FileHandle(forWritingTo: tmpPath)
            fileHandle.write(input.data(using: .utf8)!)
            
            let process = Process()
            if #available(OSX 10.13, *) {
                process.executableURL = EXECUTABLE_SWIFT
            } else {
                // Fallback on earlier versions
                process.launchPath = EXECUTABLE_SWIFT.absoluteString
            }
            process.arguments = [swiftFileName]
            process.standardInput = try FileHandle(forReadingFrom: tmpPath)
            
            let outputPipe = Pipe()
            let errorPipe = Pipe()
            process.standardOutput = outputPipe
            process.standardError = errorPipe
            
            if #available(OSX 10.13, *) {
                try process.run()
            } else {
                process.launch()
            }
            
            if #available(OSX 10.15, *) {
                if let errorData = try errorPipe.fileHandleForReading.readToEnd() {
                    let error = String(decoding: errorData, as: UTF8.self)
                    confirmFunc("error info:\n\(error)")
                    return false
                }
            } else {
                let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
                let error = String(decoding: errorData, as: UTF8.self)
                confirmFunc("error info:\n\(error)")
            }
            
            if #available(OSX 10.15, *) {
                guard let outputData = try outputPipe.fileHandleForReading.readToEnd() else {
                    return false
                }

                let yourOutput = String(decoding: outputData, as: UTF8.self)
                confirmFunc("your output:\n\(yourOutput)")
                let ac = yourOutput.trimmingCharacters(in: .whitespacesAndNewlines)
                            == output.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if ac {
                    confirmFunc("AC")
                } else {
                    confirmFunc("WA")
                }
                return ac
            } else {
                let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                let yourOutput = String(decoding: outputData, as: UTF8.self)
                confirmFunc("your output:\n\(yourOutput)")
                let ac = yourOutput.trimmingCharacters(in: .whitespacesAndNewlines)
                            == output.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if ac {
                    confirmFunc("AC")
                } else {
                    confirmFunc("WA")
                }
                return ac
            }
            
        }
    }
}
