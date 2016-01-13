//
//  GitHubConnector.swift
//  PullRequestNotifierBar
//
//  Created by Nicolas Battelli on 1/13/16.
//  Copyright © 2016 Trend Team. All rights reserved.
//

import Cocoa

class GitHubConnector: NSObject {
    
    let BASE_URL = "https://api.github.com/search/issues"
    
    
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
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                    NSLog(dataString)
                case 401: // unauthorized
                    NSLog("github api returned an 'unauthorized' response.")
                default:
                    NSLog("github api returned response: %d %@", httpResponse.statusCode, NSHTTPURLResponse.localizedStringForStatusCode(httpResponse.statusCode))
                }
            }
        }
        
        task.resume()
    }

}
