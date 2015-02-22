//
//  TweetCell.h
//  Twitter
//
//  Created by Dan Hipschman on 2/21/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;

@protocol TweetCellDelegate <NSObject>

- (void)tweetCellReplyTapped:(TweetCell *)cell;
- (void)tweetCellRetweetTapped:(TweetCell *)cell;
- (void)tweetCellFavoriteTapped:(TweetCell *)cell;

@end

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeSinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;

- (void)setTweet:(Tweet *)tweet;
- (void)setShowControls:(BOOL)showControls;

@end
