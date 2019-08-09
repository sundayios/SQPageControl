//
//  SQPageControl.m
//  
//
//  Created by SQ on 2018/11/7.
//  Copyright © 2018 SQ. All rights reserved.
//

#import "SQPageControl.h"
#import "UIImage+PageControlExtension.h"

@interface SQPageControl ()
@property (nonatomic, strong) UIView *latestView;
@end


@implementation SQPageControl

-(instancetype)init{
    if(self=[super init]) {
        
        [self initialize];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initialize];
        
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self createPointView];
}

-(void)initialize{
    self.backgroundColor=[UIColor clearColor];
    _pageControlContentMode = SQPageControlContentModeCenter;
    _pageControlStyle = SQPageControlStyleDefault;
    _marginSpacing = 12;
    _numberOfPages =0;
    _currentPage =0;
    _itemSize = CGSizeMake(8, 8);
    _multiple = 1.0;
    _borderWith = 1.0;
    _itemSpacing = 4;
    _otherColor = [UIColor lightGrayColor];
    _currentColor = [UIColor whiteColor];
    _strokeNormalColor = [UIColor lightGrayColor];
    _strokeSelectedColor = [UIColor whiteColor];
    _hidesForSinglePage = true;
}

-(void)setOtherColor:(UIColor *)otherColor{
    
    if(![self isTheSameColor:otherColor andotherColor:_otherColor]){
        _otherColor=otherColor;
        [self createPointView];
    }
}

-(void)setCurrentColor:(UIColor *)currentColor{
    
    if(![self isTheSameColor:currentColor andotherColor:_currentColor]){
        _currentColor=currentColor;
        [self createPointView];
    }
}

-(void)setItemSize:(CGSize)itemSize{
    if(itemSize.width!=_itemSize.width || itemSize.height!=_itemSize.height){
        _itemSize= itemSize;
        [self createPointView];
    }
}

-(void)setItemSpacing:(CGFloat)itemSpacing{
    if(_itemSpacing != itemSpacing){
        _itemSpacing = itemSpacing;
        [self createPointView];
        
    }
}

- (void)setCurrentSelectedImg:(UIImage *)currentSelectedImg{
    if (_currentSelectedImg != currentSelectedImg) {
        _currentSelectedImg = currentSelectedImg;
        [self createPointView];
    }
}

- (void)setOtherImg:(UIImage *)otherImg {
    if (_otherImg != otherImg) {
        _otherImg = otherImg;
        [self createPointView];
    }
}

-(void)setNumberOfPages:(NSInteger)page{
    if(_numberOfPages==page)
        return;
    _numberOfPages=page;
    [self createPointView];
}

- (void)setPageControlContentMode:(SQPageControlContentMode)pageControlContentMode {
    if (_pageControlContentMode == pageControlContentMode) return;
    _pageControlContentMode = pageControlContentMode;
    [self createPointView];
}

- (void)setMarginSpacing:(CGFloat)marginSpacing {
    if (_marginSpacing == marginSpacing) return;
    _marginSpacing = marginSpacing;
    [self createPointView];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    
    if([self.delegate respondsToSelector:@selector(SQPageControlClick:index:)])
    {
        [self.delegate SQPageControlClick:self index:currentPage];
    }
    
    if(_currentPage==currentPage)
        return;
    
    [self exchangeCurrentView:_currentPage new:currentPage];
    _currentPage=currentPage;
    
    
}

-(void)clearView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)setPageControlStyle:(SQPageControlStyle)pageControlStyle{
    if (_pageControlStyle == pageControlStyle) return;
    _pageControlStyle = pageControlStyle;
    [self createPointView];
}

- (void)setStrokeNormalColor:(UIColor *)strokeNormalColor {
    if (_strokeNormalColor != strokeNormalColor) {
        _strokeNormalColor = strokeNormalColor;
        [self createPointView];
    }
}


- (void)setStrokeSelectedColor:(UIColor *)strokeSelectedColor {
    if (_strokeSelectedColor != strokeSelectedColor) {
        _strokeSelectedColor = strokeSelectedColor;
        [self createPointView];
    }
}


- (void)setNormalPageNumColor:(UIColor *)normalPageNumColor {
    if (_normalPageNumColor != normalPageNumColor) {
        _normalPageNumColor = normalPageNumColor;
        [self createPointView];
    }
}

- (void)setSelectedPageNumColor:(UIColor *)selectedPageNumColor {
    
}

#pragma mark - 根据样式创建点
-(void)createPointView{
    [self clearView];
    if(_numberOfPages<=0)
        return;
    
    switch (_pageControlStyle) {
        case SQPageControlStyleDefault:
        {
            [self CreatDotWithSize:_itemSize];
        }
            break;
        case SQPageControlStyleStrokedCircle:
        {
            [self CreatDotWithSize:_itemSize];
        }
            break;
        case SQPageControlStyleStrokedOut:
        {
            [self CreatDotWithSize:_itemSize];
        }
            break;
        case SQPageControlStyleStrokedIn:
        {
            [self CreatDotWithSize:_itemSize];
        }
            break;
        case SQPageControlStyleRectangle:
        {
            [self CreatDotWithSize:_itemSize];
        }
            break;
        case SQPageControlStyleDotAndRectangle:
        {
            [self CreatDotWithSize:_rectangleSize withOtherDotSize:_itemSize];
        }
            break;
        case SQPageControlStyleWithPageNumber:
        {
        
        }
            break;
        case SQPageControlStyleThumb:
        {
        
        }
            break;
        case SQPageControlStyleCustom:
        {
        
        }
            break;
        default:
            break;
    }
    
    
    
}






#pragma mark - 默认样式创建点
-(void)CreatDotWithSize:(CGSize)DotSize{
    //居中控件
    CGFloat startX=0;
    CGFloat startY=0;
    CGFloat controlSizeW = DotSize.width;
    CGFloat controlSizeH = DotSize.height;
    CGFloat mainWidth=_numberOfPages*(controlSizeW +_itemSpacing);
    
    if(self.frame.size.width<mainWidth){
        startX=0;
    }else{
        if (_pageControlContentMode == SQPageControlContentModeLeft && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = _marginSpacing;
        }else if (_pageControlContentMode == SQPageControlContentModeRight && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = (self.frame.size.width-mainWidth) - _marginSpacing;
        }else {
            startX = (self.frame.size.width-mainWidth)/2;
        }
    }
    if(self.frame.size.height<controlSizeH){
        startY = 0;
    }else{
        startY = (self.frame.size.height-controlSizeH)/2;
    }
    //动态创建点
    for (int page=0; page<_numberOfPages; page++) {
        if(page==_currentPage){
            CGRect selRect = CGRectMake(startX, startY, controlSizeW * _multiple, controlSizeH);
            UIImageView *currPointView=[[UIImageView alloc] init];
            currPointView.tag=page+1000;
            currPointView.userInteractionEnabled=YES;
            currPointView.contentMode = UIViewContentModeScaleAspectFill;
            currPointView.layer.masksToBounds = true;
            switch (_pageControlStyle) {
                case SQPageControlStyleDefault:
                {
                    currPointView.frame = selRect;
                    UIImage *currentImage = [UIImage pc_imageRoundWithColor:_currentColor size:selRect.size radius:controlSizeH/2.0];
                    currPointView.image = currentImage;
                    currPointView.layer.cornerRadius = controlSizeH / 2.0;
                }
                    break;
                case SQPageControlStyleStrokedCircle:
                {
                    currPointView.frame = selRect;
                    UIImage *currentImage = [UIImage pc_imageRoundWithDiameter:selRect.size.height fillColor:_currentColor borderWith:_borderWith borderColor:_strokeSelectedColor];
                    currPointView.image = [currentImage stretchableImageWithLeftCapWidth:selRect.size.width * 0.5 topCapHeight:selRect.size.height * 0.5];
                    currPointView.layer.cornerRadius = controlSizeH / 2.0;
                }
                    break;
                case SQPageControlStyleStrokedOut:
                {
                    CGRect currentRect = CGRectMake(0, 0, controlSizeW * _multiple * 1.3, controlSizeH * 1.3);
                    currPointView.frame = currentRect;
                    UIImage *currentImage = [UIImage pc_imageRoundWithDiameter:currentRect.size.height fillColor:_currentColor borderWith:_borderWith borderColor:_strokeSelectedColor];
                    if (_multiple > 1.0){
                        currPointView.image = [currentImage stretchableImageWithLeftCapWidth:currentRect.size.width * 0.5 topCapHeight:currentRect.size.height];
                    } else {
                        currPointView.image = currentImage;
                    }
                    currPointView.layer.cornerRadius = currentRect.size.height / 2.0;
                
                }
                    break;
                case SQPageControlStyleStrokedIn:
                {
                    CGRect currentRect = CGRectMake(0, 0, controlSizeW * _multiple * 0.9, controlSizeH * 0.9);
                    currPointView.frame = currentRect;
                    UIImage *currentImage = [UIImage pc_imageRoundWithDiameter:currentRect.size.height fillColor:_currentColor borderWith:_borderWith borderColor:_strokeSelectedColor];
                    currPointView.image = [currentImage stretchableImageWithLeftCapWidth:currentRect.size.width * 0.5 topCapHeight:currentRect.size.height * 0.5];
                    currPointView.layer.cornerRadius = currentRect.size.height / 2.0;
                }
                    break;
                case SQPageControlStyleRectangle:
                {
                    currPointView.frame = selRect;
                    if (_isRoundCorner) {
//                        UIImage *currentImage = [UIImage pc_imageRoundWithDiameter:selRect.size.height fillColor:_currentColor borderWith:_borderWith borderColor:_strokeSelectedColor];
                        UIImage *centImage = [UIImage pc_imageWithColor:_currentColor andSize:CGSizeMake(30, 20)];
                        UIImage *currentImage = [UIImage pc_rectangleRoundCornerImageWithOldImage:centImage cornerRadiu:5 corners:UIRectCornerAllCorners borderColor:_strokeSelectedColor borderWidth:2];
                        currPointView.image = [currentImage stretchableImageWithLeftCapWidth:currentImage.size.width * 0.5 topCapHeight:currentImage.size.height * 0.5];
                    }else {
                        UIImage *currentImage = [UIImage pc_imageWithColor:_currentColor];
                        
                        currentImage = [UIImage pc_rectangleImageWithImage:currentImage size:selRect.size borderWith:_borderWith borderColor: _strokeSelectedColor];
                        currPointView.image = currentImage;
                    }
                    if (_isRoundCorner) {
                        currPointView.layer.cornerRadius = selRect.size.height / 2.0;
                    }
                
                }
                    break;
                case SQPageControlStyleWithPageNumber:
                {
                    CGRect currentRect = CGRectMake(startX, startY, controlSizeW * _multiple, controlSizeH * _multiple);
                    UIImage *currentImage = [UIImage pc_imageWithBGColor:_strokeSelectedColor text:[NSString stringWithFormat:@"%d",page] textColor:_selectedPageNumColor];
                    currPointView.frame = currentRect;
                    currPointView.image = currentImage;
                    if (_isRoundCorner) {
                        currPointView.layer.cornerRadius = currentRect.size.height / 2.0;
                    }
                }
                    break;
                case SQPageControlStyleThumb:
                {
                    CGRect currentRect = CGRectMake(startX, startY, controlSizeW * _multiple, controlSizeH * _multiple);
                    currPointView.frame = currentRect;
                    currPointView.image = _currentSelectedImg;
                    if (_isRoundCorner) {
                        currPointView.layer.cornerRadius = currentRect.size.height / 2.0;
                    }
                }
                    break;
               
                    
                default:
                    break;
            }
            
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [currPointView addGestureRecognizer:tapGesture];
            [self addSubview:currPointView];
            currPointView.center = CGPointMake(startX + 0.5 * controlSizeW * _multiple, startY + 0.5 * controlSizeH);
            startX=CGRectGetMaxX(selRect) + _itemSpacing;
            [self bringSubviewToFront:currPointView];
            self.latestView = currPointView;
        }else{
            CGRect otherRect = CGRectMake(startX, startY, controlSizeW, controlSizeH);
            UIImageView *otherPointView=[[UIImageView alloc] init];
            otherPointView.frame = otherRect;
            otherPointView.tag=page+1000;
            otherPointView.userInteractionEnabled=true;
            otherPointView.layer.masksToBounds = true;
            
            switch (_pageControlStyle) {
                case SQPageControlStyleDefault:
                {
                    UIImage *otherImage = [UIImage pc_imageRoundWithDiameter:otherRect.size.height fillColor:_otherColor borderWith:_borderWith borderColor:_strokeNormalColor];
                    otherPointView.image = otherImage;
                    otherPointView.layer.cornerRadius = otherRect.size.height / 2.0;
                }
                    break;
                case SQPageControlStyleStrokedCircle:
                {
                    UIImage *otherImage = [UIImage pc_imageRoundWithDiameter:otherRect.size.height fillColor:_otherColor borderWith:_borderWith borderColor:_strokeNormalColor];
                    otherPointView.image = [otherImage stretchableImageWithLeftCapWidth:otherRect.size.width * 0.5 topCapHeight:otherRect.size.height * 0.5];
                    otherPointView.layer.cornerRadius = otherRect.size.height / 2.0;
                }
                    break;
                case SQPageControlStyleStrokedOut:
                {
                    UIImage *otherImage = [UIImage pc_imageRoundWithDiameter:otherRect.size.height fillColor:_otherColor borderWith:_borderWith borderColor:_strokeNormalColor];
                    otherPointView.image = [otherImage stretchableImageWithLeftCapWidth:otherRect.size.width * 0.5 topCapHeight:otherRect.size.height * 0.5];
                    otherPointView.layer.cornerRadius = otherRect.size.height / 2.0;
                }
                    break;
                case SQPageControlStyleStrokedIn:
                {
                    UIImage *otherImage = [UIImage pc_imageRoundWithDiameter:otherRect.size.height fillColor:_otherColor borderWith:_borderWith borderColor:_strokeNormalColor];
                    otherPointView.image = [otherImage stretchableImageWithLeftCapWidth:otherRect.size.width * 0.5 topCapHeight:otherRect.size.height * 0.5];
                    otherPointView.layer.cornerRadius = otherRect.size.height / 2.0;
                }
                    break;
                case SQPageControlStyleRectangle:
                {

                    if (_isRoundCorner) {
//                        UIImage *otherImage = [UIImage pc_imageRoundWithDiameter:otherRect.size.height fillColor:_otherColor borderWith:_borderWith borderColor:_strokeNormalColor];
                        UIImage *otherCenterImage = [UIImage pc_imageWithColor:_otherColor];
                        UIImage *otherImage = [UIImage pc_rectangleRoundCornerImageWithOldImage:otherCenterImage cornerRadiu:5 corners:UIRectCornerAllCorners borderColor:_strokeNormalColor borderWidth:2];
                        otherPointView.image = [otherImage stretchableImageWithLeftCapWidth:otherRect.size.width * 0.5 topCapHeight:otherRect.size.height * 0.5];
                        otherPointView.layer.cornerRadius = otherRect.size.height / 2.0;
                    }else {
                        UIImage *otherImage = [UIImage pc_imageWithColor:_otherColor];
                        
                        otherImage = [UIImage pc_rectangleImageWithImage:otherImage size:otherRect.size borderWith:1 borderColor: _strokeSelectedColor];
                        otherPointView.image = otherImage;
                    }
                
                }
                    break;
                case SQPageControlStyleWithPageNumber:
                {
                    UIImage *otherImage = [UIImage pc_imageWithBGColor:_strokeSelectedColor text:[NSString stringWithFormat:@"%d",page] textColor:_selectedPageNumColor];
                    otherPointView.image = otherImage;
                    if (_isRoundCorner) {
                        otherPointView.layer.cornerRadius = otherRect.size.height / 2.0;
                    }
                }
                    break;
                case SQPageControlStyleThumb:
                {
                    otherRect = CGRectMake(startX, startY, controlSizeW, controlSizeH);
                    otherPointView.image = _otherImg;
                    if (_isRoundCorner) {
                        otherPointView.layer.cornerRadius = otherRect.size.height / 2.0;
                    }
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            if (self.latestView) {
                [self insertSubview:otherPointView belowSubview:self.latestView];
            }else{
                [self addSubview:otherPointView];
            }
            startX=CGRectGetMaxX(otherPointView.frame)+_itemSpacing;
        }
    }
    
    
}
#pragma mark - 创建  圆点 + 长条形 样式
-(void)CreatDotWithSize:(CGSize)currentDotSize withOtherDotSize:(CGSize)otherDotSize{
    
    //居中控件
    CGFloat startX=0;
    CGFloat startY=0;
    CGFloat currentDotSizeW = currentDotSize.width;
    CGFloat currentDotSizeH = currentDotSize.height;
    CGFloat otherDotSizeW = otherDotSize.width;
    CGFloat otherDotSizeH = otherDotSize.height;
    
    CGFloat mainWidth=_numberOfPages*(currentDotSizeW +_itemSpacing);
    
    if(self.frame.size.width<mainWidth){
        startX=0;
    }else{
        if (_pageControlContentMode == SQPageControlContentModeLeft && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = _marginSpacing;
        }else if (_pageControlContentMode == SQPageControlContentModeRight && self.frame.size.width - _marginSpacing * 2 > mainWidth) {
            startX = (self.frame.size.width-mainWidth) - _marginSpacing;
        }else {
            startX = (self.frame.size.width-mainWidth)/2;
        }
    }
    if(self.frame.size.height<otherDotSizeH){
        startY = 0;
    }else{
        startY = (self.frame.size.height-otherDotSizeH)/2;
        
    }
    //动态创建点
    for (int page=0; page<_numberOfPages; page++) {
        if(page==_currentPage){
            UIView *currPointView=[[UIView alloc] initWithFrame:CGRectMake(startX, startY, currentDotSizeW, currentDotSizeH)];
            currPointView.layer.cornerRadius=currentDotSizeH/2;
            currPointView.tag=page+1000;
            currPointView.backgroundColor=_currentColor;
            currPointView.userInteractionEnabled=YES;
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
            [currPointView addGestureRecognizer:tapGesture];
            [self addSubview:currPointView];
            startX=CGRectGetMaxX(currPointView.frame)+_itemSpacing;
            if(_currentSelectedImg){
                currPointView.backgroundColor=[UIColor clearColor];
                UIImageView *currBkImg=[UIImageView new];
                currBkImg.tag=1234;
                currBkImg.frame=CGRectMake(0, 0, currPointView.frame.size.width, currPointView.frame.size.height);
                currBkImg.image=_currentSelectedImg;
                [currPointView addSubview:currBkImg];
            }
            
        }else{
            
            UIView *otherPointView=[[UIView alloc]initWithFrame:CGRectMake(startX, startY, otherDotSizeW, otherDotSizeH)];
            otherPointView.backgroundColor=_otherColor;
            otherPointView.tag=page+1000;
            otherPointView.layer.cornerRadius=otherDotSizeH/2;
            otherPointView.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [otherPointView addGestureRecognizer:tapGesture];
            [self addSubview:otherPointView];
            startX=CGRectGetMaxX(otherPointView.frame)+_itemSize.width;
        }
    }
    
    
}


-(void)clickAction:(UITapGestureRecognizer*)recognizer{
    
    NSInteger index=recognizer.view.tag-1000;
    [self setCurrentPage:index];
}

-(BOOL)isTheSameColor:(UIColor*)color1 andotherColor:(UIColor*)color2{
    return  CGColorEqualToColor(color1.CGColor, color2.CGColor);
}




//切换当前的点
-(void)exchangeCurrentView:(NSInteger)old new:(NSInteger)new
{
    UIView *oldSelect=[self viewWithTag:1000+old];
    CGRect mpSelect=oldSelect.frame;
    
    UIView *newSeltect=[self viewWithTag:1000+new];
    CGRect newTemp=newSeltect.frame;
    
    if(_currentSelectedImg){
        UIView *imgview=[oldSelect viewWithTag:1234];
        [imgview removeFromSuperview];
        
        newSeltect.backgroundColor=[UIColor clearColor];
        UIImageView *currBkImg=[UIImageView new];
        currBkImg.tag=1234;
        currBkImg.frame=CGRectMake(0, 0, mpSelect.size.width, mpSelect.size.height);
        currBkImg.image=_currentSelectedImg;
        [newSeltect addSubview:currBkImg];
    }
    
    oldSelect.backgroundColor=_otherColor;
    newSeltect.backgroundColor=_currentColor;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        CGFloat lx=mpSelect.origin.x;
        CGFloat pageW = self.itemSize.width;
        CGFloat pageH = self.itemSize.height;
        
        if(new<old)
            lx+=pageW;
        oldSelect.frame=CGRectMake(lx, mpSelect.origin.y, pageW, pageH);
        
        CGFloat mx=newTemp.origin.x;
        if(new>old)
            mx-=pageW;
        newSeltect.frame=CGRectMake(mx, newTemp.origin.y, pageW*2, pageH);
        
        // 左边的时候到右边 越过点击
        if(new-old>1)
        {
            for(NSInteger t=old+1;t<new;t++)
            {
                UIView *ms=[self viewWithTag:1000+t];
                ms.frame=CGRectMake(ms.frame.origin.x-pageW, ms.frame.origin.y, pageW, pageH);
            }
        }
        // 右边选中到左边的时候 越过点击
        if(new-old<-1)
        {
            for(NSInteger t=new+1;t<old;t++)
            {
                UIView *ms=[self viewWithTag:1000+t];
                ms.frame=CGRectMake(ms.frame.origin.x+pageW, ms.frame.origin.y, pageW, pageH);
            }
        }
        
        
    }];
    
    
    
}





@end
