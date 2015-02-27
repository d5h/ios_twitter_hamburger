//
//  HamburgerMenuViewController.m
//  Twitter
//
//  Created by Dan Hipschman on 2/26/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "HamburgerMenuViewController.h"

@interface HamburgerMenuViewController ()

@property (strong, nonatomic) UIViewController *slidableViewController;
@property (nonatomic, assign) CGPoint originalCenter;

@end

@implementation HamburgerMenuViewController

- (id)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    
    if (self) {
        self.slidableViewController = viewController;
        UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
        [self.slidableViewController.view addGestureRecognizer:gestureRecognizer];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.slidableViewController.view.frame = self.view.frame;
    [self.view addSubview:self.slidableViewController.view];
}

- (void)onPan:(UIPanGestureRecognizer *)sender {
    // Table scroll takes precedence over panning.  Woot!
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalCenter = sender.view.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:self.view];
        CGPoint center = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y + translation.y);
        sender.view.center = center;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        sender.view.center = self.originalCenter;
    }
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
