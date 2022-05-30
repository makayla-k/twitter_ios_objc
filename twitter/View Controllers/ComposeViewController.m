//
//  ComposeViewController.m
//  twitter
//
//  Created by Makayla Rodriguez on 5/25/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetTextView.delegate = self;
    [self.characterCountLabel setText:[NSString stringWithFormat:@"%d", 280]];
}

// Keep track of the number of characters the user has left
- (void)textViewDidChange:(UITextView *)textView {
    // Length of tweet can't exceed 280 characters
    
    NSInteger charactersLeft = 280 - [[self.tweetTextView text] length];
    [self.characterCountLabel setText:[NSString stringWithFormat:@"%ld", (long)charactersLeft]];
    
    if([[self.tweetTextView text] length] >= 280) {
        self.tweetTextView.editable = NO;
    }
    
}

- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetBtn:(id)sender {
//    NSLog([self.tweetText text]);
    NSString *tweetStr = [self.tweetTextView text];
    
    [[APIManager shared]postStatusWithText:tweetStr completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Compose Tweet Success!");
        }
    }];
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
