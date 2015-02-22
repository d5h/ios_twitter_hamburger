//
//  TweetCell.m
//  Twitter
//
//  Created by Dan Hipschman on 2/21/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    self.textLabel.preferredMaxLayoutWidth = self.textLabel.frame.size.width;
    self.profileImage.layer.cornerRadius = 3;
    self.profileImage.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.preferredMaxLayoutWidth = self.textLabel.frame.size.width;
}

- (void)setTweet:(Tweet *)tweet {
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.tweetTextLabel.text = tweet.text;
    [self.profileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
