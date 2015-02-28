//
//  TweetCell.m
//  Twitter
//
//  Created by Dan Hipschman on 2/21/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "ComposeViewController.h"

@interface TweetCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controlsHeightConstraint;
@property (nonatomic, assign) BOOL showControls;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    self.textLabel.preferredMaxLayoutWidth = self.textLabel.frame.size.width;
    self.profileImage.layer.cornerRadius = 3;
    self.profileImage.clipsToBounds = YES;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self addTapRecognizerForImage:self.replyImage action:@selector(onReply)];
    [self addTapRecognizerForImage:self.retweetImage action:@selector(onRetweet)];
    [self addTapRecognizerForImage:self.favoriteImage action:@selector(onFavorite)];
    [self addTapRecognizerForImage:self.profileImage action:@selector(onUserTap)];
}

- (void)onReply {
    [self.delegate tweetCellReplyTapped:self];
}

- (void)onRetweet {
    [self.delegate tweetCellRetweetTapped:self];
}

- (void)onFavorite {
    [self.delegate tweetCellFavoriteTapped:self];
}

- (void)onUserTap {
    [self.delegate tweetCellUserTapped:self];
}

- (void)addTapRecognizerForImage:(UIImageView *)image action:(SEL)action {
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [tap setDelegate:self];
    [image addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.preferredMaxLayoutWidth = self.textLabel.frame.size.width;
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.tweetTextLabel.text = tweet.text;
    [self.profileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    
    // Handle the relative time
    NSTimeInterval interval = -tweet.createdAt.timeIntervalSinceNow;
    int minutes = interval / 60;
    int hours = minutes / 60;
    int days = hours / 24;
    if (days > 0) {
        self.timeSinceLabel.text = [NSString stringWithFormat:@"%dd", days];
    } else if (hours > 0) {
        self.timeSinceLabel.text = [NSString stringWithFormat:@"%dh", hours];
    } else {
        self.timeSinceLabel.text = [NSString stringWithFormat:@"%dm", minutes];
    }
}

- (void)setShowControls:(BOOL)showControls {
    _showControls = showControls;
    if (showControls) {
        self.controlsHeightConstraint.constant = 16;
    } else {
        self.controlsHeightConstraint.constant = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

