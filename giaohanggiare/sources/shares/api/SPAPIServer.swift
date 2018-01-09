//
//  SPAPIServer.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/9/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

class SPAPIServer: NSObject {
    static let linkApiServer:String = "http://103.18.4.14:9001/api"
    static let shareInstance = SPAPIServer()
    
    public func doLoginToServer(user: String, pass: String, completedHandle:@escaping (_ success: Bool, _ errorString: String) -> ()) {
        let paramater:NSDictionary = NSMutableDictionary()
        paramater.setValue(user, forKey: "user_name")
        paramater.setValue(pass, forKey: "password")
        doRequestToApiServer(method: "/login", paramater: paramater, completedHandle:completedHandle)
    }
    
    private func doRequestToApiServer(method: String, paramater: NSDictionary, completedHandle:@escaping (_ success: Bool, _ errorString: String) -> ()) {
        let url = URL(string: SPAPIServer.linkApiServer)
        
        let data = try! JSONSerialization.data(withJSONObject: paramater, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        if let json = json {  print(json) }
        
        let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var isCompleted = false
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let url = json["url"], let explanation = json["explanation"] {
                        print(url)
                        print(explanation)
                        isCompleted = true
                        completedHandle(true, "")
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
            if !isCompleted {
                completedHandle(false, "Loi dang server")
            }
        }
        
        task.resume()
    }
}
