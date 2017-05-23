//
//  ViewController.m
//  SegmentView
//
//  Created by zhanght on 16/5/18.
//  Copyright © 2016年 zhanght. All rights reserved.
//

#import "ViewController.h"

#import "SegmentView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *first = [[FirstViewController alloc] init];
    first.title = @"first";

    SecondViewController *second = [[SecondViewController alloc] init];
    second.title = @"second";
    
    ThirdViewController *third = [[ThirdViewController alloc] init];
    third.title = @"third";
    
    FourthViewController *fourth = [[FourthViewController alloc] init];
    fourth.title = @"fourth";
    
    SegmentView *seg = [[SegmentView alloc] initWithFrame:self.view.bounds];
    [seg setViewControllers:@[first, second, third, fourth] titleHeight:100];
    [self.view addSubview:seg];
    
}


@end
