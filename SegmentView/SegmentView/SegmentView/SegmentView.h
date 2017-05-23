//
//  SegmentView.h
//  SegmentView
//
//  Created by zhanght on 16/5/18.
//  Copyright © 2016年 zhanght. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  实现多个页面横屏切换的效果
 */
@interface SegmentView : UIView

- (void)setViewControllers:(NSArray *)viewControllers titleHeight:(CGFloat)titleHeight;

@end
