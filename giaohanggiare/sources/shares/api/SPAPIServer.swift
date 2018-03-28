//
//  SPAPIServer.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 1/9/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit

let RESPONSECODE_SUCCESS = 1

class SPAPIServer: NSObject {
    static let linkApiServer:String = "http://128.199.126.246:9001/api"
    static let shareInstance = SPAPIServer()
    
    public func doLoginToServer(user: String, pass: String, completedHandle:@escaping (_ success: Bool, _ responseData: NSDictionary?, _ errorString: String) -> ()) {
//        let paramater:NSDictionary = NSMutableDictionary()
//        paramater.setValue(user, forKey: "user_name")
//        paramater.setValue(pass, forKey: "password")
//        doRequestToApiServer(method: "/login", paramater: paramater, completedHandle:completedHandle)
        let string: String = "{\"code\":\"1\",\"message\":\"success\",\"data\":{\"userId\":\"4493d670-3297-11e8-a1df-5d046656e0b9\",\"accessToken\":\"NzE3T296MWV0ZEpaS0o5c0lMQXVoUXpXa01SbUFKMXp2QU95cXRLWno1TUFLelJXYUxnT1doL1lTNEU2NUlkVDA3WGN6OW9QZzlsTU9wdVU1cGJjYlFKTitUR1FMN2ladXlnejY3YTdNZXZWMHAvVlV1OFVWaWZqRDN6KzgxYnRmZ0wvdVY0QkgvK1N2RzNNNkJOdGlFNkJDR0xlQ09UL21CV0QxcWZ6U3hsR2pZem0wNU5OSGdOL2VzbkhReE1Ib1VOekJ3c0RFMy9nbXluZTZuOWVQUGNCWHZVeVlNRnZTRy8xT0JsUDFhTDF5RHpEWlNoTUNoUStLVkVGK3o4eG5hZkdCSVozekkvUmhPdDkrbmxSckZmcFZEZzhVcUJOK2VZWXlXc0RmaHNsWE8wUjVUUG0zd01DVmVlcmlET0xmSUtLNFJTRkYwM294Z1hSY1Rxa2pTVEEyTk5SUzBUVC9WaGtNNWdVbVNGblJtWG0=\",\"userInfo\":{\"__v\":0,\"password\":\"gdyb21LQTcIANtvYMT7QVQ==\",\"phone\":\"0987654321\",\"email\":\"Quan@gmail.com\",\"name\":\"Quan\",\"id\":\"4493d670-3297-11e8-a1df-5d046656e0b9\",\"_id\":\"5abbab8e0c043324422c741a\"}}}"
        let dictionary = string.JSONStringToNSDictionary()
        if let dict = dictionary {
            print("JSON: \n \(dict)")
            let responeData: SPResponseData = self.parserResponeData(dict)
            if responeData.codeRes == RESPONSECODE_SUCCESS {
                completedHandle(true, responeData.dataRes, "")
            } else {
                completedHandle(false, nil, responeData.messageRes)
            }
        }
        
    }
    
    public func doSignUpToServer(userInfo: SPCustomerInfoItem, completedHandle:@escaping (_ success: Bool, _ errorString: String) -> ()) {
        let paramater:NSDictionary = NSMutableDictionary()
        paramater.setValue(userInfo.username, forKey: "name")
        paramater.setValue(userInfo.email, forKey: "email")
        paramater.setValue(userInfo.phone, forKey: "phone")
        paramater.setValue(userInfo.password.base64String(), forKey: "password")
        doRequestToApiServer(method: "/auth/register", paramater: paramater, completedHandle:completedHandle)
    }
    
    private func doRequestToApiServer(method: String, paramater: NSDictionary, completedHandle:@escaping (_ success: Bool, _ errorString: String) -> ()) {
        let urlString = SPAPIServer.linkApiServer.appending(method)
        let bodyString = paramater.dictionaryToString()
        
        makeLogRequest(domain: method, param: bodyString)
        let request = RequestCustom(urlString: urlString, deviceId: getDeviceId(), method: .POST, body: bodyString) { (response) in
            guard let response = response else {
//                self.multicastDelegate.invoke({$0.didDoGETRequestCompleted(response: nil, errorMsg: nil, identify: identify)})
                print("Response is nil!")
                return
            }
            self.makeLogResponse(response: response)
//            self.multicastDelegate.invoke({$0.didDoGETRequestCompleted(response: response, errorMsg: nil, identify: identify)})
        }
        request.makeCompleteRequest()
//        let data = try! JSONSerialization.data(withJSONObject: paramater, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//
//        if let json = json {  print(json) }
//
//        let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
//
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            var isCompleted = false
//            if let data = data {
//                do {
//                    // Convert the data to JSON
//                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//
//                    if let json = jsonSerialized, let url = json["url"], let explanation = json["explanation"] {
//                        print(url)
//                        print(explanation)
//                        isCompleted = true
//                        completedHandle(true, "")
//                    }
//                }  catch let error as NSError {
//                    print(error.localizedDescription)
//                }
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//            if !isCompleted {
//                completedHandle(false, "Loi dang server")
//            }
//        }
//
//        task.resume()
    }
    
    private func parserResponeData(_ resData: NSDictionary) -> SPResponseData {
        var result: SPResponseData = SPResponseData()
        let code: String = resData.object(forKey: "code") as! String
        result.codeRes = Int(code)!
        result.dataRes = resData.object(forKey: "data") as! NSDictionary
        result.messageRes = resData.object(forKey: "message") as! String
        return result
    }
    
    private func getDeviceId () -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    private func makeLogRequest (domain: String, param: String) {
        print("---------------------------")
        print("[api: \(domain)]-")
        print("[parameters:\(param)]")
        print("---------------------------")
    }
    
    private func makeLogResponse (response: String) {
        print("---------------------------")
        print("[Response: \n\(response)]")
        print("---------------------------")
    }
}

extension String {
    func base64String() -> String {
        let md5Data = MD5(string: self)
        let result = md5Data.base64EncodedString()
        return result
    }
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
}

extension NSDictionary {
    func dictionaryToString () -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
}

extension String {
    func JSONStringToNSDictionary() -> NSDictionary! {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

enum HttpMethod:String {
    case POST
    case GET
}

class RequestCustom: NSObject {
    let userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E188a Safari/601.1"
    var currentTask: URLSessionDataTask!
    let package_name = "vn.giaohanggiare.customer"
    let app_mode = "user"
    
    override init() {
        super.init()
    }
    
    init(urlString: String, deviceId: String, method: HttpMethod, body:String, completion:@escaping ((_ response: String?) -> Void)) {
        super.init()
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = method.rawValue//"POST"
        request.addValue(deviceId, forHTTPHeaderField: "device-id")
        request.addValue(package_name, forHTTPHeaderField: "package-name")
        request.addValue(app_mode, forHTTPHeaderField: "app-type")
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = body.data(using: .utf8)
        currentTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                completion(nil)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            completion(responseString)
        }
    }
    
    func makeCompleteRequest() {
        if let task = currentTask {
            task.resume()
        }
    }
}

struct SPResponseData {
    var codeRes: NSInteger = -1
    var dataRes:NSDictionary = NSDictionary()
    var messageRes: String = ""
}

//{"code":"1","message":"success","data":{"userId":"4493d670-3297-11e8-a1df-5d046656e0b9","accessToken":"NzE3T296MWV0ZEpaS0o5c0lMQXVoUXpXa01SbUFKMXp2QU95cXRLWno1TUFLelJXYUxnT1doL1lTNEU2NUlkVDA3WGN6OW9QZzlsTU9wdVU1cGJjYlFKTitUR1FMN2ladXlnejY3YTdNZXZWMHAvVlV1OFVWaWZqRDN6KzgxYnRmZ0wvdVY0QkgvK1N2RzNNNkJOdGlFNkJDR0xlQ09UL21CV0QxcWZ6U3hsR2pZem0wNU5OSGdOL2VzbkhReE1Ib1VOekJ3c0RFMy9nbXluZTZuOWVQUGNCWHZVeVlNRnZTRy8xT0JsUDFhTDF5RHpEWlNoTUNoUStLVkVGK3o4eG5hZkdCSVozekkvUmhPdDkrbmxSckZmcFZEZzhVcUJOK2VZWXlXc0RmaHNsWE8wUjVUUG0zd01DVmVlcmlET0xmSUtLNFJTRkYwM294Z1hSY1Rxa2pTVEEyTk5SUzBUVC9WaGtNNWdVbVNGblJtWG0=","userInfo":{"__v":0,"password":"gdyb21LQTcIANtvYMT7QVQ==","phone":"0987654321","email":"Quan@gmail.com","name":"Quan","id":"4493d670-3297-11e8-a1df-5d046656e0b9","_id":"5abbab8e0c043324422c741a"}}}

