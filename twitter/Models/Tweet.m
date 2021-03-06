//
//  Tweet.m
//  twitter
//
//  Created by Makayla Rodriguez on 5/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {

        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        // TODO: initialize user
        // initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];

        // TODO: Format and set createdAtString
        
        // Format createdAt date string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        
//        convert Date to time ago since now
        NSNumber *myDoubleNumber = [NSNumber numberWithDouble:date.timeIntervalSinceNow];
        double myNum = labs([myDoubleNumber doubleValue]);
        int temp;
        
        if(myNum > 86400) {
            temp = (myNum / 86400);
            self.timeAgoString = [NSString stringWithFormat: @"%dd", temp];
        }
        else if(myNum > 3600) {
            temp = (myNum / 3600);
            self.timeAgoString = [NSString stringWithFormat: @"%dh", temp];
        }
        else if(myNum > 60) {
            temp = (myNum / 60);
            self.timeAgoString = [NSString stringWithFormat: @"%dm", temp];
        }
        else {
            temp = (myNum / 6);
            self.timeAgoString = [NSString stringWithFormat: @"%ds", temp];
        }
        
//        Get entities
        self.entities = dictionary[@"entities"];
        
//        get media
        if(self.entities[@"media"] != nil) {
            self.media = self.entities[@"media"];
        }
        
//        get user mentions
        if(self.entities[@"user_mentions"] != nil) {
            self.userMentions = self.entities[@"user_mentions"];
        }
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
