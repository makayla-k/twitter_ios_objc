//
//  TweetCell.m
//  twitter
//
//  Created by Makayla Rodriguez on 5/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "ProfileViewController.h"
#import "DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.profileImage.layer.cornerRadius = 35;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.profileImage setUserInteractionEnabled:YES];
    [self.profileImage addGestureRecognizer:singleTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

-(void)profileImageTapDetected{
    NSLog(@"single Tap on imageview %@", self.username.text);
    
//    ProfileViewController *profile = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileViewController"];
  }

@end
