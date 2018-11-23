//
//  UIView+QGMenu.h
//  QGMenuTest
//
//  Created by 李超群 on 16/6/1.
//  Copyright © 2016年 李超群. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 菜单的类型 */
typedef enum : NSUInteger {
    
    /** 复制按钮 */
    QGMenuTypeCopy      = 1<< 0,
    
    /** 粘贴按钮 */
    QGMenuTypePaste     = 1<< 1,
    
    /** 删除按钮 */
    QGMenuTypeDelete    = 1<< 2,
    
    /** 撤销按钮 */
    QGMenuTypeRevoke    = 1<< 3,
    
    /** 保存按钮 */
    QGMenuTypeSave      = 1<< 4,
    
    /** 更多按钮 */
    QGMenuTypeMore      = 1<< 5,
  
    
} QGMenuType;

#pragma mark - 6个 item 的事件回调
/**  复制按钮的事件回调 */
typedef void(^copyItemBlock)(UIView * selectView);

/**  粘贴按钮的事件回调 */
typedef void(^pasteItemBlock)(UIView * selectView, NSString * pasteString);

/**  删除按钮的事件回调 */
typedef void(^deleteItemBlock)(UIView * selectView);

/**  撤销按钮的事件回调 */
typedef void(^revokeItemBlock)(UIView * selectView);

/**  保存按钮的事件回调 */
typedef void(^saveItemBlock)(UIView * selectView);

/**  更多按钮的事件回调 */
typedef void(^moreItemBlock)(UIView * selectView);


@interface UIView (QGMenu)

/** 添加选项菜单 */
-(void)addMenuWithType:(QGMenuType)menuType copyItemBlock:(copyItemBlock)copyItemBlock pasteItemBlock:(pasteItemBlock)pasteItemBlock deleteItemBlock:(deleteItemBlock)deleteItemBlock revokeItemBlock:(revokeItemBlock)revokeItemBlock saveItemBlock:(saveItemBlock)saveItemBlock moreItemBlock:(moreItemBlock)moreItemBlock;


/** 导航栏的返回按钮 */
+(UIButton *)backButtton;

@end
