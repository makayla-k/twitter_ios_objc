//
//  DetailsViewController.m
//  twitter
//
//  Created by Makayla Rodriguez on 5/26/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
