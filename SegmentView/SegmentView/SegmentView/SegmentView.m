//
//  SegmentView.m
//  SegmentView
//
//  Created by zhanght on 16/5/18.
//  Copyright © 2016年 zhanght. All rights reserved.
//

#import "SegmentView.h"
#import "TitleSelectView.h"


@interface SegmentView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet TitleSelectView *titleSelectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcTitleHeight;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [[NSBundle mainBundle] loadNibNamed:@"SegmentView" owner:self options:nil];
    //contentView
    [self addSubview:self.contentView];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *lcTop = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *lcLeading = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *lcBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *lcTrailing = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self addConstraints:@[lcTop, lcLeading, lcBottom, lcTrailing]];
    
    //collectView
    UICollectionViewFlowLayout *cLayout = [[UICollectionViewFlowLayout alloc] init];
    cLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = cLayout;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
}

- (void)setViewControllers:(NSArray *)viewControllers titleHeight:(CGFloat)titleHeight {
    self.viewControllers = viewControllers;
    self.lcTitleHeight.constant = titleHeight;
    
    //set titles
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.viewControllers) {
        [titles addObject:vc.title];
    }
    [self.titleSelectView setTitles:titles selectHandler:^(NSInteger selectedIndex) {
        NSLog(@"-- ht log -- selectedIndex : %ld", (long)selectedIndex);
        CGFloat width = self.collectionView.bounds.size.width;
        [self.collectionView setContentOffset:(CGPointMake(width * selectedIndex, 0)) animated:NO];
    }];
}

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewControllers.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    
    UIView *v = [cell viewWithTag:100+indexPath.section];
    if (v) [v removeFromSuperview];
    UIViewController *vc = self.viewControllers[indexPath.section];
    vc.view.tag = 100+indexPath.section;
    [cell addSubview:vc.view];
    
    //layout
    vc.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *lcTop = [NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *lcLeading = [NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *lcBottom = [NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *lcTrailing = [NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [cell addConstraints:@[lcTop, lcLeading, lcBottom, lcTrailing]];
    [cell layoutIfNeeded];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat progress = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    self.titleSelectView.scrollProgress = progress;
}




@end







