//
//  DYContainerBgView.m
//  QEZB
//
//  Created by 李超群 on 2018/2/2.
//Copyright © 2018年 zhou. All rights reserved.
//  lx  ceshi

#pragma mark ************************************ 透明的视图 可以透过 view ************************************

#import "DYContainerBgView.h"

@implementation DYContainerBgView
/** 可以透过事件 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([super hitTest:point withEvent:event] == self) return nil;
    return [super hitTest:point withEvent:event];
}

@end
