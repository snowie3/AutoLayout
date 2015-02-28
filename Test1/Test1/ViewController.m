//
//  ViewController.m
//  Test1
//
//  Created by Smitha S on 26/02/15.
//  Copyright (c) 2015 Smitha S. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UIView *moreView;
@property (strong,nonatomic) UITableView *tableView;
  @property (strong, nonatomic) UITableViewCell *customCell;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintWebView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMoreView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController{
    NSArray *tableData;
    NSArray *comment2;
   UIView *commentsView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableData = @[@"Bubbles",@"Chuck",@"Matilda"];
    comment2 = @[@"Great Article...broom",@"Sleepy and Sleepy",@"Yippie! I am back"];

}

- (void) viewWillAppear:(BOOL)animated {
 
    NSString *strURL = @"http://en.m.wikipedia.org/wiki/Angry_Birds_Epic";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //Commented webview for testing purpose
    //[self.webView loadRequest:urlRequest];


    [self shareNews];
    self.moreView.translatesAutoresizingMaskIntoConstraints =NO;

 
    [self.moreView setNeedsLayout];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView sizeToFit];
    self.constraintWebView.constant = self.webView.frame.size.height;
 
}

- (void) shareNews{
   
    UIView *shareView = [[UIView alloc]init];
    shareView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.moreView addSubview:shareView];
    
    NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-1-[shareView]-1-|"
                                                                    options:0
                                                                    metrics:nil
                                                                         views:@{@"shareView":shareView}];
    
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:shareView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                            toItem:self.moreView
                                                            attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0 constant:5.0];
    [self.moreView addConstraint:topConstraint];
    [self.moreView addConstraints:widthConstraint];
    
    
    UILabel *labelLike = [[UILabel alloc]init];
    labelLike.translatesAutoresizingMaskIntoConstraints = NO;
    labelLike.text = @"Liked";
    labelLike.font = [UIFont systemFontOfSize:10];
    labelLike.textAlignment = NSTextAlignmentCenter;
    labelLike.backgroundColor = [UIColor redColor];
    labelLike.textColor = [UIColor whiteColor];
    
    UILabel *labelShare = [[UILabel alloc]init];
    labelShare.translatesAutoresizingMaskIntoConstraints = NO;
    labelShare.text = @"Share this Story";
    labelShare.font = [UIFont systemFontOfSize:10];
    labelShare.textAlignment = NSTextAlignmentCenter;
    labelShare.backgroundColor = [UIColor colorWithRed:178/255.0f green:167/255.0f blue:206/255.0f alpha:0.2f];
    
    UILabel *labelPost = [[UILabel alloc]init];
    labelPost.translatesAutoresizingMaskIntoConstraints = NO;
    labelPost.text = @"Post a comment";
    labelPost.font = [UIFont systemFontOfSize:10];
    labelPost.textAlignment = NSTextAlignmentCenter;
    labelPost.backgroundColor = [UIColor colorWithRed:131/255.0f green:205/255.0f blue:132/255.0f alpha:0.2f];
    
    [shareView addSubview:labelLike];
    [shareView addSubview:labelShare];
    [shareView addSubview:labelPost];
    
    
    NSDictionary *shareDictionary = @{@"shareView":shareView,@"like":labelLike,@"share":labelShare,@"post":labelPost};
    

    NSArray *likeConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[like]|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:shareDictionary];
    
    NSArray *shareConstraint_H = [NSLayoutConstraint
                                  constraintsWithVisualFormat:@"H:|[share]-0-[post(==share)]|"
                                  options:0
                                  metrics:nil
                                  views:shareDictionary];
    
    
    
    NSArray *shareConstraint_V = [NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:|[like]-0-[share]|"
                                  options:0
                                  metrics:nil
                                  views:shareDictionary];
    NSArray *postConstraint_V = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:|[like]-0-[post]|"
                                 options:0
                                 metrics:nil
                                 views:shareDictionary];
    
    [shareView addConstraints:likeConstraint_H];
    [shareView addConstraints:shareConstraint_H];
    
    [shareView addConstraints:shareConstraint_V];
    [shareView addConstraints:postConstraint_V];

    commentsView = [[UIView alloc]init];
    commentsView.translatesAutoresizingMaskIntoConstraints = NO;
    commentsView.backgroundColor = [UIColor whiteColor];
    
    
  
    

    [self.moreView addSubview:commentsView];
    
    
    
    NSArray *commentsWidthConstraint = [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:|[commentsView]|"
                                     options:0
                                     metrics:nil
                                        views:@{@"commentsView":commentsView}];

    topConstraint = [NSLayoutConstraint constraintWithItem:commentsView
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:shareView
                                                    attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0 constant:2.0];
    [self.moreView addConstraint:topConstraint];
    [self.moreView addConstraints:commentsWidthConstraint];
    
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.moreView.frame.size.width, self.moreView.frame.size.height) style:UITableViewStylePlain];
    
    //if you want ot use default constraints
    //self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    //above or below can be added
    //self.tableView.estimatedRowHeight = 30.0f;
    [commentsView addSubview:self.tableView ];
    
   
    
    UILabel *labelPostComment = [[UILabel alloc]init];
    labelPostComment.translatesAutoresizingMaskIntoConstraints = NO;
    labelPostComment.text = @"Post A Comment";
    labelPostComment.font = [UIFont systemFontOfSize:10];
    labelPostComment.textAlignment = NSTextAlignmentCenter;
    labelPostComment.backgroundColor = [UIColor grayColor];
    labelPostComment.textColor = [UIColor whiteColor];

   
        [self.moreView addSubview:labelPostComment];
    
    topConstraint = [NSLayoutConstraint constraintWithItem:labelPostComment
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:commentsView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0 constant:5.0];
    
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:labelPostComment
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.moreView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0 constant:5.0];
    
    
    commentsWidthConstraint = [NSLayoutConstraint
                                        constraintsWithVisualFormat:@"H:|[postComment]|"
                                        options:0
                                        metrics:nil
                                        views:@{@"postComment":labelPostComment}];
    
    [self.moreView addConstraint:topConstraint];
    [self.moreView addConstraint:bottomConstraint];
    [self.moreView addConstraints:commentsWidthConstraint];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HistoryCell";
    
    // Similar to UITableViewCell, but
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    

    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = tableData[indexPath.row] ;
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
   [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[bodyLabel]-5-|" options:0 metrics:nil views:@{ @"bodyLabel": cell.textLabel }]];
    
   [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bodyLabel]|" options:0 metrics:nil views:@{ @"bodyLabel": cell.textLabel }]];
    
    
    [cell setNeedsUpdateConstraints];
    NSLog(@" CEll Heigh %@ ",tableData[indexPath.row] );
    return cell;
    
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
