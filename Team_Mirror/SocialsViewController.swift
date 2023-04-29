//
//  SocialsViewController.swift
//  Team_Mirror
//
//  Created by Brayden M Dyke on 4/28/23.
//

 import UIKit
 import Swifter

 class SocialsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     @IBOutlet weak var tableView: UITableView!

     var swifter: Swifter!
     var tweets: [JSON] = []
     var user = UserTag.id("114506204")

     override func viewDidLoad() {
         super.viewDidLoad()

         // Set up API keys and access tokens
         // ...
         let apiKey = "YOUR_API_KEY"
         let apiSecretKey = "YOUR_API_SECRET_KEY"
         let accessToken = "YOUR_ACCESS_TOKEN"
         let accessTokenSecret = "YOUR_ACCESS_TOKEN_SECRET"

         swifter = Swifter(consumerKey: apiKey, consumerSecret: apiSecretKey, oauthToken: accessToken, oauthTokenSecret: accessTokenSecret)

         tableView.delegate = self
         tableView.dataSource = self

         fetchTweets()
     }

     func fetchTweets() {
         swifter.getTimeline(for: user, count: 20, success: { json in
             self.tweets = json.array ?? []
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
         }, failure: { error in
             print("Error fetching tweets: \(error.localizedDescription)")
         })
     }

     // MARK: - UITableViewDataSource

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return tweets.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)

         let tweet = tweets[indexPath.row]
         cell.textLabel?.text = tweet["text"].string

         return cell
     }
 }
