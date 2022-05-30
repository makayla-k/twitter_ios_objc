//
//  DetailsViewController.m
//  twitter
//
//  Created by Makayla Rodriguez on 5/26/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "APIManager.h"
#import "tweet.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.username.text = self.tweet.user.name;
    self.tweetContent.text = self.tweet.text;
    self.numOfRetweets.text = [NSString stringWithFormat: @"%d", self.tweet.retweetCount];
    self.numOfFavorites.text = [NSString stringWithFormat: @"%d", self.tweet.favoriteCount];
    
    NSString *URLString = [self.tweet.user.profilePicture stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];

    self.profileImage.image = [UIImage imageWithData:urlData];
    self.profileImage.layer.cornerRadius = 35;
    
    //    if user mentioned link to their profile
        if ([self.tweet.userMentions count] > 0) {
            NSLog(@"%@", self.tweet.userMentions[0]);
            
            NSString *userMentioned = self.tweet.userMentions[0][@"screen_name"];
            
            NSRange range = [self.tweet.text rangeOfString:userMentioned];
            
            NSMutableAttributedString * mention = [[NSMutableAttributedString alloc] initWithString: self.tweet.text];
            
            NSURL *myUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@", userMentioned]];
            
            [mention addAttribute: NSLinkAttributeName value:myUrl range: NSMakeRange(range.location-1, range.length+1)];
            self.tweetContent.attributedText = mention;
        }
}

-(IBAction)didTapFavorite:(id) sender {
    if(self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                [self.favBtn setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
                [self.numOfFavorites setText:[NSString stringWithFormat: @"%d", self.tweet.favoriteCount]];
            }
        }];
    } else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self.favBtn setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
                [self.numOfFavorites setText:[NSString stringWithFormat: @"%d", self.tweet.favoriteCount]];
            }
        }];
    }
}

-(IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweetting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                [self.retweetBtn setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
                [self.numOfRetweets setText:[NSString stringWithFormat: @"%d", self.tweet.retweetCount]];
            }
        }];
    } else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweetting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self.retweetBtn setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
                [self.numOfRetweets setText:[NSString stringWithFormat: @"%d", self.tweet.retweetCount]];
            }
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
