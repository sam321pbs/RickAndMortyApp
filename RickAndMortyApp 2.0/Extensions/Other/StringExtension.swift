//
//  StringUtils.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/24/23.
//

import Foundation

extension String {
    
    /// Finds the value of a query parameter in a string url
    /// - Parameter param: parameter in query
    /// - Returns: value of query parameter
    func getQueryStringParameter(param: String) -> String? {
      guard let url = URLComponents(string: self) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    
    /// Finds the last '/' in the string and then converts to a substring then trys to convert the string to a number
    /// - Returns: the number at the end of the URL or nil
    func getLastNumberInUrl() -> Int? {
        guard let from = self.lastIndex(where: { $0 == "/"}) else {
            return nil
        }
        
        let number = self.suffix(from: from)
        
        guard let number = Int(number.replacingOccurrences(of: "/", with: "")) else {
            print("Not number \(number)")
            return nil
        }
        
        return number
    }
    
    
}
