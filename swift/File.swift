import Foundation

func loadFileByLines(filePath: String) -> [String]? {
    let url = URL(filePath: filePath)
    let data = try? Data(contentsOf: url)
    guard let data else {
        return nil
    }
    
    let strings = String(data: data, encoding: .utf8)?
        .components(separatedBy: .newlines)
    
    return strings
}

func loadBundleFileByLines(resourceName: String, ofType type: String) -> [String]? {
    let filePath = Bundle.main.path(forResource: resourceName, ofType: type)
    guard let filePath else {
        return nil
    }
    
    let strings = try? String(contentsOfFile: filePath, encoding: .utf8)
        .components(separatedBy: .newlines)
    
    return strings
}

func readPlist(path: String) -> [[String:String]]? {
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)
    guard let plist = try! PropertyListSerialization.propertyList(
        from: data,
        options: .mutableContainers,
        format: nil
    ) as? [[String:String]] else { return nil }
    
    return plist
}

