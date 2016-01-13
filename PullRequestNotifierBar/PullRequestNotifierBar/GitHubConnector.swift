//
//  GitHubConnector.swift
//  PullRequestNotifierBar
//
//  Created by Nicolas Battelli on 1/13/16.
//  Copyright © 2016 Trend Team. All rights reserved.
//

import Cocoa

protocol GitHubConnectorDelegate {
    func pendingPullRequestDidUpdate(pendingPullRequestModel: PendingPullRequestModel)
}

class GitHubConnector: NSObject {
    
    let BASE_URL = "https://api.github.com/search/issues"
    
    var delegate: GitHubConnectorDelegate?

    init(delegate: GitHubConnectorDelegate) {
        self.delegate = delegate
    }
    
    func fetchPendingPullRequest(userName : String, token : String) {
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "\(BASE_URL)?q=type:pr+is:open+assignee:\(userName)&sort=created&order=asc&access_token=\(token)");

        let task = session.dataTaskWithURL(url!) { data, response, err in            
            if let error = err {
                NSLog("Github api error \(error)")
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // all good!
                    if let pendingPullRequestModel = self.pendingPullRequestModelFromJSON(data!) {
                        self.delegate?.pendingPullRequestDidUpdate(pendingPullRequestModel)
                    }
                case 401: // unauthorized
                    NSLog("github api returned an 'unauthorized' response.")
                default:
                    NSLog("github api returned response: %d %@", httpResponse.statusCode, NSHTTPURLResponse.localizedStringForStatusCode(httpResponse.statusCode))
                }
            }
        }
        
        task.resume()
    }

    
    func pendingPullRequestModelFromJSON(data: NSData) -> PendingPullRequestModel? {
        typealias JSONDict = [String:AnyObject]
        let json : JSONDict
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! JSONDict
        } catch {
            NSLog("JSON parsing failed: \(error)")
            return nil
        }
        
        let pendingPullRequestModel = PendingPullRequestModel (
            totalCount:json["total_count"] as! NSNumber
        )
        
        return pendingPullRequestModel
    }
}

struct PendingPullRequestModel:CustomStringConvertible {
    var totalCount : NSNumber
    
    var description: String {
        return "Tenes \(totalCount) PR"
    }
}
