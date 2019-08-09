//
//  SFLable.h
//  TestExample
//
//  Created by administrator on 2019/7/29.
//  Copyright © 2019 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFLable : UILabel

// 用来决定上下左右内边距，也可以提供一个借口供外部修改，在这里就先固定写死

@property (assign, nonatomic) IBInspectable UIEdgeInsets edgeInsets;
@property (nonatomic, assign) IBInspectable BOOL isRedBadge;
@property (nonatomic, assign) IBInspectable BOOL isSizeToFit;

@end

NS_ASSUME_NONNULL_END
