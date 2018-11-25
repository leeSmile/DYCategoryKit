//
//  DYContainerBgView.m
//  QEZB
//
//  Created by 李超群 on 2018/2/2.
//Copyright © 2018年 zhou. All rights reserved.
//  lx  ceshi
// 今天天不错啊
// 0.0.4
//0.0.5
//  终于测试完成啦
//修改 0.0.6版本

#pragma mark ************************************ 透明的视图 可以透过 view ************************************

#import "DYContainerBgView.h"

@implementation DYContainerBgView
/** 可以透过事件 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([super hitTest:point withEvent:event] == self) return nil;
    return [super hitTest:point withEvent:event];
}

@end
