//
//  HamburgerMenuViewController.m
//  Twitter
//
//  Created by Dan Hipschman on 2/26/15.
//  Copyright (c) 2015 Dan Hipschman. All rights reserved.
//

#import "HamburgerMenuViewController.h"
#import "Constants.h"

enum MenuItem {
    None,
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
@property (weak, nonatomic) UIViewController *slidableViewController;
@property (strong, nonatomic) UIViewController *timelineViewController;
@property (strong, nonatomic) UIViewController *profileViewController;
@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, readonly) NSArray *menuItems;
@property (nonatomic, assign) enum MenuItem currentSlidableItem;

@end

@implementation HamburgerMenuViewController

- (id)initWithTimelineViewController:(UIViewController *)timelineViewController profileViewController:(UIViewController *)profileViewController {
    self = [super init];
    
    if (self) {
        self.timelineViewController = timelineViewController;
        [self addPanGestureToViewController:timelineViewController];
        self.slidableViewController = timelineViewController;
        self.currentSlidableItem = Timeline;
        
        self.profileViewController = profileViewController;
        [self addPanGestureToViewController:profileViewController];
        self.profileViewController.view.hidden = YES;
    }

    return self;
}

- (void)addPanGestureToViewController:(UIViewController *)viewController {
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [viewController.view addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.timelineViewController.view.frame = self.view.frame;
    [self.view addSubview:self.timelineViewController.view];
    
    self.profileViewController.view.frame = self.view.frame;
    [self.view addSubview:self.profileViewController.view];
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
    return @[@{@"id": @(None), @"text": @""},  // row for spacing
             @{@"id": @(Profile), @"text": @"Profile", @"viewController": self.profileViewController},
             @{@"id": @(Timeline), @"text": @"Timeline", @"viewController": self.timelineViewController},
             @{@"id": @(Mentions), @"text": @"Mentions", @"viewController": self.timelineViewController}];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.menuItems[indexPath.row][@"text"];
    // Hack!  See comment above on why this should be a navigation bar.
    if (indexPath.row == 0) {
        cell.backgroundColor = twitterBlue();
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *menuDictionary = self.menuItems[indexPath.row];
    enum MenuItem menuItem = [menuDictionary[@"id"] shortValue];
    if (menuItem == None) {
        return;
    }
    if (menuItem != self.currentSlidableItem) {
        CGRect frame = self.slidableViewController.view.frame;
        CGPoint center = self.slidableViewController.view.center;
        self.slidableViewController.view.hidden = YES;

        self.currentSlidableItem = menuItem;
        self.slidableViewController = menuDictionary[@"viewController"];
        self.slidableViewController.view.frame = frame;
        self.slidableViewController.view.center = center;
        self.slidableViewController.view.hidden = NO;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.slidableViewController.view.center = self.view.center;
    }];
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
