//
//  ComposeViewController.m
//  Twitter
//
//  Created by Dan Hipschman on 2/21/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *tweetText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.text = self.tweetText;
}

- (IBAction)onTweet:(id)sender {
    // FIXME: Check for 140 characters
    NSString *text = self.textField.text;
    [[TwitterClient sharedInstance] updateStatus:text completion:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (id)initWithTweetText:(NSString *)text {
    self = [super init];
    if (self) {
        self.tweetText = text;
    }
    return self;
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
