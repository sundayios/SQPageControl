//
//  ViewController.m
//  TestExample
//
//  Created by administrator on 2019/7/29.
//  Copyright © 2019 administrator. All rights reserved.
//

#import "ViewController.h"
#import "SFLable.h"
#import "StyledPageControl.h"

#import "SQPageControl.h"

@interface ViewController ()

@property (nonatomic, strong) SFLable *sflabel;
@property (nonatomic, strong) StyledPageControl *pageControl;
@property (nonatomic, strong) SQPageControl *spageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sflabel.center = CGPointMake(100, 200);
    self.sflabel.backgroundColor = [UIColor redColor];
    self.sflabel.textColor = [UIColor whiteColor];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 70, 30)];
    [button setTitle:@"annaiu" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(updatText:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.pageControl = [[StyledPageControl alloc] initWithFrame:CGRectZero];
    [self.pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:self.pageControl];
    [self.pageControl setFrame:CGRectMake(100,300,300,30)];
    self.pageControl.numberOfPages = 10;
    self.pageControl.currentPage = 5;
    self.pageControl._pageControlStyle = 1;
//    self.pageControl._strokeWidth = 6;
//    self.pageControl.gapWidth = 6;
    
    
    self.spageControl = [[SQPageControl alloc] initWithFrame:CGRectZero];
    [self.spageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:self.spageControl];
    [self.spageControl setFrame:CGRectMake(100,350,300,90)];
    self.spageControl.numberOfPages = 5;
    self.spageControl.currentPage = 0;
    self.spageControl.currentColor = [UIColor redColor];
    self.spageControl.strokeSelectedColor = [UIColor greenColor];
    self.spageControl.strokeNormalColor = [UIColor purpleColor];
    self.spageControl.pageControlStyle = SQPageControlStyleRectangle;
    self.spageControl.itemSpacing = 8;
    self.spageControl.itemSize = CGSizeMake(60, 40);
    self.spageControl.multiple = 2;
    self.spageControl.borderWith = 2;
    self.spageControl.isRoundCorner = true;
}
- (SFLable *)sflabel{
    if (!_sflabel) {
        _sflabel = [[SFLable alloc] init];
        _sflabel.isSizeToFit = true;
        _sflabel.textColor = [UIColor whiteColor];
        _sflabel.edgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
        _sflabel.text = @"你好";
        _sflabel.layer.cornerRadius = 15;
        _sflabel.layer.masksToBounds = YES;
        _sflabel.backgroundColor = [UIColor redColor];
        [_sflabel sizeToFit];
        [self.view addSubview:_sflabel];

    }
    return _sflabel;
}

- (void)updatText:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.sflabel.text = @"2";
//        [self.sflabel sizeToFit];
//        self.sflabel.center = CGPointMake(100, 200);
    }else{
        self.sflabel.text = @"100";
//        [self.sflabel sizeToFit];
//        self.sflabel.center = CGPointMake(100, 200);
    }
    
}

@end
