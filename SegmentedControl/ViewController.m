//
//  ViewController.m
//  SegmentedControl
//
//  Created by kan xu on 15/11/24.
//  Copyright © 2015年 kan xu. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentedControl.h"
#import  "subSBController.h"
#import  "subXIBController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"HMSegmentedControl Demo";
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat viewHight = CGRectGetHeight(self.view.frame);
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"A", @"B", @"C", @"D"]];
    _segmentedControl.frame = CGRectMake(0, 20, viewWidth, 44);
    _segmentedControl.selectionIndicatorHeight = 4.0f;
    _segmentedControl.backgroundColor = [UIColor whiteColor];
    _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    _segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];;
    _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1]};
    _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.shouldAnimateUserSelection = YES;
    
    __weak typeof(self) weakSelf = self;
    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, weakSelf.scrollView.frame.size.height) animated:YES];
    }];
    
    [self.view addSubview:_segmentedControl];
    
    
    CGFloat myheight = viewHight - 64;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, viewWidth, myheight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 4, myheight);//4
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, self.scrollView.frame.size.height) animated:NO];
    [self.view addSubview:self.scrollView];
    

    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    subSBController *page;
    
    page = [mainStoryboard instantiateViewControllerWithIdentifier:@"subSBController"];
    [page.view setFrame:CGRectMake(0, 0, viewWidth, self.scrollView.frame.size.height)];
    page.nameLbl.text = @"sub1";
    [self.scrollView addSubview:page.view];
    
    page = [mainStoryboard instantiateViewControllerWithIdentifier:@"subSBController"];
    [page.view setFrame:CGRectMake(viewWidth, 0, viewWidth, self.scrollView.frame.size.height)];
    page.nameLbl.text = @"sub2";
    [self.scrollView addSubview:page.view];
    
    page = [mainStoryboard instantiateViewControllerWithIdentifier:@"subSBController"];
    [page.view setFrame:CGRectMake(viewWidth*2, 0, viewWidth, self.scrollView.frame.size.height)];
    page.nameLbl.text = @"sub3";
    [self.scrollView addSubview:page.view];
    
    
    subXIBController *pageXib = [[subXIBController alloc] init];
    [self addChildViewController:pageXib];
    [pageXib.view setFrame:CGRectMake(viewWidth*3, 0, viewWidth, self.scrollView.frame.size.height)];
    pageXib.nameLbl.text = @"Xibsub4";
    [self.scrollView addSubview:pageXib.view];


    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    [self.segmentedControl setSelectedSegmentIndex:page animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.segmentedControl.selectionIndicatorOffsetX = scrollView.contentOffset.x / scrollView.contentSize.width;
}

@end
