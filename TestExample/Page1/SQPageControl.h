//
//  SQPageControl.h
//  
//
//  Created by SQ on 2018/11/7.
//  Copyright © 2018 SQ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SQPageControlContentMode){
    
    SQPageControlContentModeLeft=0,
    SQPageControlContentModeCenter,
    SQPageControlContentModeRight,
};

typedef NS_ENUM(NSInteger, SQPageControlStyle)
{
    /** 默认按照 controlSize 设置的值,如果controlSize未设置 则按照大小为5的小圆点 */
    SQPageControlStyleDefault = 0,
    SQPageControlStyleStrokedCircle,
    SQPageControlStyleStrokedOut,
    SQPageControlStyleStrokedIn,
    /** 长条样式 */
    SQPageControlStyleRectangle,
    /** 圆点 + 长条 样式 */
    SQPageControlStyleDotAndRectangle,
    SQPageControlStyleWithPageNumber,
    SQPageControlStyleThumb
};


@class SQPageControl;
@protocol SQPageControlDelegate <NSObject>

-(void)SQPageControlClick:(SQPageControl*_Nonnull)pageControl index:(NSInteger)clickIndex;

@end


@interface SQPageControl : UIControl


/** 位置 默认居中 */
@property (nonatomic, assign) SQPageControlContentMode pageControlContentMode;

/** 滚动条样式 默认按照 controlSize 设置的值,如果controlSize未设置 则为大小为5的小圆点 */
@property (nonatomic, assign) SQPageControlStyle pageControlStyle;
@property (nonatomic, assign) BOOL hidesForSinglePage;
@property (nonatomic, assign) NSInteger numberOfPages;          // default is 0
@property (nonatomic, assign) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1

/** 距离初始位置 间距  默认10 */
@property (nonatomic, assign) CGFloat marginSpacing;
/** 间距 默认3 */
@property (nonatomic, assign) CGFloat itemSpacing;

/** 大小 默认(5,5) 如果设置PageControlStyle,则失效 */
@property (nonatomic, assign) CGSize itemSize;
/***设置矩形时SQPageControlStyleDotAndRectangle，rectangleSize需要设置***/
@property (nonatomic, assign) CGSize rectangleSize;
@property (nonatomic, assign) BOOL isRoundCorner;
@property (nonatomic, assign) CGFloat borderWith;
/***宽度比例 默认是1***/
@property (nonatomic, assign) CGFloat multiple;
/** 其他page颜色 */
@property (nonatomic, strong) UIColor * _Nullable otherColor;
/** 当前page颜色 */
@property (nonatomic, strong) UIColor * _Nullable currentColor;

@property (nonatomic, strong) UIColor * _Nullable strokeNormalColor;
@property (nonatomic, strong) UIColor * _Nullable strokeSelectedColor;

@property (nonatomic, strong) UIColor * _Nullable normalPageNumColor;
@property (nonatomic, strong) UIColor * _Nullable selectedPageNumColor;
/** 设置图片 */
@property (nonatomic, strong) UIImage * _Nullable currentSelectedImg;
@property (nonatomic, strong) UIImage * _Nullable otherImg;

@property(nonatomic,weak)id<SQPageControlDelegate> _Nullable delegate;


@end


