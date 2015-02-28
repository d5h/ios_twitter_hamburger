//
//  ProfileViewController.m
//  Twitter
//
//  Created by Dan Hipschman on 2/28/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (nonatomic, strong) User *user;


@end

@implementation ProfileViewController

- (id)initWithUser:(User *)user {
    self = [super init];
    
    if (self) {
        self.user = user;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageFullSizeUrl]];
    self.nameLabel.text = self.user.name;
    self.tweetCountLabel.text = [NSString stringWithFormat:@"%ld", self.user.tweetCount];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%ld", self.user.followingCount];
    self.followersCountLabel.text = [NSString stringWithFormat:@"%ld", self.user.followerCount];
    
    self.navigationItem.title = @"Profile";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
