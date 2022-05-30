//
//  TweetCell.h
//  twitter
//
//  Created by Makayla Rodriguez on 5/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property (weak, nonatomic) IBOutlet UILabel *numOfRetweets;
@property (weak, nonatomic) IBOutlet UILabel *numOfFavorites;
@property (weak, nonatomic) IBOutlet UIImageView *photoMediaImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoMediaBottomConstraint;



@end

NS_ASSUME_NONNULL_END
