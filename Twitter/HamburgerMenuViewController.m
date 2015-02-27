//
//  HamburgerMenuViewController.m
//  Twitter
//
//  Created by Dan Hipschman on 2/26/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "HamburgerMenuViewController.h"
#import "Constants.h"

enum MenuItems {
    Profile,
    Timeline,
    Mentions
};

// NOTE: It would have been more generic to make the HamburgerViewController simply
// manage other views.  One would be the menu, and the other the currently selected
// view.  By also making the hamburger view manage the menu, it's hard to add a
// navigation bar to it.
@interface HamburgerMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIViewController *slidableViewController;
@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, readonly) NSArray *menuItems;


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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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
        CGPoint velocity = [sender velocityInView:self.view];
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        CGPoint center;
        if (velocity.x > 0) {
            center = CGPointMake(3 * width / 2 - 64, height / 2 + 32);
        } else {
            center = self.view.center;
        }
        [UIView animateWithDuration:0.2 animations:^{
            sender.view.center = center;
        }];
    }
}

- (NSArray *)menuItems {
    return @[@{@"text": @""},  // row for spacing
             @{@"id": @(Profile), @"text": @"Profile"},
             @{@"id": @(Timeline), @"text": @"Timeline"},
             @{@"id": @(Mentions), @"text": @"Mentions"}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Don't need reusable cells, no scrolling
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HamburgerMenuCell"];
    cell.textLabel.text = self.menuItems[indexPath.row][@"text"];
    // Hack!  See comment above on why this should be a navigation bar.
    if (indexPath.row == 0) {
        cell.backgroundColor = twitterBlue();
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.slidableViewController.view.hidden = YES;
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
