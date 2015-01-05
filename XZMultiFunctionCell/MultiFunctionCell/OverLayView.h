//
//  OverLayView.h
//  XZMultiFunctionCell
//
//  Created by xiazer on 15/1/5.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OverLayView;

@protocol OverLayViewDelegate <NSObject>
-(UIView *)overLayView:(OverLayView *)view didHitPoint:(CGPoint)didHitPoint withEvent:(UIEvent *)withEvent;
@end


@interface OverLayView : UIView
@property(nonatomic, assign) id<OverLayViewDelegate> delegate;

@end
