//
//  DYLogical0perationTool.h
//  QEZB
//
//  Created by 李超群 on 2018/2/1.
//Copyright © 2018年 zhou. All rights reserved.

#pragma mark ************************************ 逻辑运算的工具类 ************************************

#import <Foundation/Foundation.h>

static inline void setCurrentTypeToTypeStaute(NSInteger* currentType, NSInteger toType, BOOL status){
    if (status) {
        (*currentType) = (*currentType) | (toType);
    }else{
        (*currentType) = (*currentType) & (~toType);
    }
}

static inline BOOL getCurrentTypeIsType(NSInteger* currentType, NSInteger isType){
    return ((*currentType) & isType) == isType;
}
