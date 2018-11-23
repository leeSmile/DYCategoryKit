//
//  UIView+QGMenu.m
//  QGMenuTest
//
//  Created by 李超群 on 16/6/1.
//  Copyright © 2016年 李超群. All rights reserved.
//

#import "UIView+QGMenu.h"

#pragma mark - 全局的变量
/** 记录传过来的菜单类型 */
static QGMenuType   g_menuType;

/** 6个item代码块 */
/**  复制按钮的事件回调 */
copyItemBlock       g_copyItemBlock;

/**  粘贴按钮的事件回调 */
pasteItemBlock      g_pasteItemBlock;

/**  删除按钮的事件回调 */
deleteItemBlock     g_deleteItemBlock;

/**  撤销按钮的事件回调 */
revokeItemBlock     g_revokeItemBlock;

/**  保存按钮的事件回调 */
saveItemBlock       g_saveItemBlock;

/**  更多按钮的事件回调 */
moreItemBlock       g_moreItemBlock;

/**  菜单控制器 */
static UIMenuController *g_menuController;

#pragma mark - 全局的六个按钮
/** 复制的 item */
static UIMenuItem   *   g_copyItem;

/** 粘贴的 item */
static UIMenuItem   *   g_pasteItem;

/** 删除的 item */
static UIMenuItem   *   g_deleteItem;

/** 撤销的 item */
static UIMenuItem   *   g_revokeItem;

/** 保存的 item */
static UIMenuItem   *   g_saveItem;

/** 更多的 item */
static UIMenuItem   *   g_moreItem;

@implementation UIView (QGMenu)

#pragma mark - 添加手势 和 初始化 item 的操作
/** 添加选项菜单 */
-(void)addMenuWithType:(QGMenuType)menuType copyItemBlock:(copyItemBlock)copyItemBlock pasteItemBlock:(pasteItemBlock)pasteItemBlock deleteItemBlock:(deleteItemBlock)deleteItemBlock revokeItemBlock:(revokeItemBlock)revokeItemBlock saveItemBlock:(saveItemBlock)saveItemBlock moreItemBlock:(moreItemBlock)moreItemBlock{
    
    /** 设置可以用户交互 */
    self.userInteractionEnabled = YES;
    /** 添加手势 */
    [self addGesture];
    
     /** 初始化item */
    [self setUpItem];
    
    /** 赋值操作  记录菜单类型*/
    g_menuType = menuType;
    
    /** block 赋值 */
    /** 复制item代码块 */
    g_copyItemBlock     = copyItemBlock;
 
    /** 粘贴item代码块 */
    g_pasteItemBlock   = pasteItemBlock;
   
    /** 删除item代码块 */
    g_deleteItemBlock   = deleteItemBlock;
    
    /** 撤销item 代码块 */
    g_revokeItemBlock   = revokeItemBlock;
   
    /** 保存item 代码块 */
    g_saveItemBlock     = saveItemBlock;
    
    /** 更多item代码块 */
    g_moreItemBlock     = moreItemBlock;

}

/** 添加手势 */
-(void)addGesture{
    /** 给 self 添加长按手势 */
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [self addGestureRecognizer:longPress];

}

 /** 初始化item 和 menuController */
-(void)setUpItem{
    
    /** menuController */
    UIMenuController * menuController = [UIMenuController sharedMenuController];
    g_menuController = menuController;
    
    /** 复制 item */
    UIMenuItem * copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClick:)];
    g_copyItem = copyItem;
    
    /** 粘贴 item */
    UIMenuItem * pasteItem = [[UIMenuItem alloc] initWithTitle:@"粘贴" action:@selector(pasteItemClick:)];
    g_pasteItem =pasteItem;
    
    /** 删除 item */
    UIMenuItem * deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteItemClick:)];
    g_deleteItem = deleteItem;
    
    /** 撤销 item */
    UIMenuItem * revokeItem = [[UIMenuItem alloc] initWithTitle:@"撤销" action:@selector(revokeItemClick:)];
    g_revokeItem = revokeItem;
    
    /** 保存 item */
    UIMenuItem * saveItem = [[UIMenuItem alloc] initWithTitle:@"保存" action:@selector(saveItemClick:)];
    g_saveItem = saveItem;
    
    /** 更多 item */
    UIMenuItem * moreItem = [[UIMenuItem alloc] initWithTitle:@"更多" action:@selector(moreItemClick:)];
    g_moreItem = moreItem;


}

#pragma mark - 事件监听操作
/** 长按手势事件监听*/
-(void)longPressGesture:(UILongPressGestureRecognizer *)longPress{
    
    /** 初始化按钮的数组 */
    NSMutableArray <UIMenuItem * > * itmes = [NSMutableArray array];
    
    /** 根据参数判断使用什么 item */
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        /** 复制按钮 */
        if (g_menuType & QGMenuTypeCopy) {
            
            [itmes addObject:g_copyItem];
        }
        /** 粘贴按钮 */
        if (g_menuType & QGMenuTypePaste) {
            
            [itmes addObject:g_pasteItem];
        }
        /** 删除按钮 */
        if (g_menuType & QGMenuTypeDelete) {
            
            [itmes addObject:g_deleteItem];
        }
        /** 撤销按钮 */
        if (g_menuType & QGMenuTypeRevoke) {
            
           [itmes addObject:g_revokeItem];
        }
        /** 保存按钮 */
        if (g_menuType & QGMenuTypeSave) {
            
            [itmes addObject:g_saveItem];
        }
        /** 更多按钮 */
        if (g_menuType & QGMenuTypeMore) {
            
            [itmes addObject:g_moreItem];
        }
        [self becomeFirstResponder];
        [g_menuController setMenuItems:itmes];
        
        [g_menuController  setTargetRect:self.superview.frame inView:self.superview];
        
        [g_menuController setMenuVisible:YES  animated:YES];
    }
}
/** 复制按钮 事件监听*/
-(void)copyItemClick:(UIMenuItem *)copyItem{
    
    UIPasteboard  * pastBoard = [UIPasteboard generalPasteboard];
    /** 如果self 是UITextView */
    if ([self isKindOfClass:[UITextView class]]){
        
        UITextView * textView = (UITextView * )self;
        pastBoard.string = textView.text;
    }
     /** 如果self 是UILabel */
    else if ([self isKindOfClass:[UILabel class]]){
        
        UILabel * lable = (UILabel * )self;
        pastBoard.string = lable.text;
    }
    
    /** 如果self 是UITextField */
    else if ([self isKindOfClass:[UITextField class]] ) {
        
        UITextField * textField = (UITextField * )self;
        pastBoard.string = textField.text;
    }
    if (g_copyItemBlock) {
        g_copyItemBlock(self);
    }
}

/** 粘贴按钮 事件监听*/
-(void)pasteItemClick:(UIMenuItem *)pasteItem{
    UIPasteboard  * pastBoard = [UIPasteboard generalPasteboard];
    if (g_pasteItemBlock) {
        g_pasteItemBlock(self, pastBoard.string);
    }
}

/** 删除按钮 事件监听*/
-(void)deleteItemClick:(UIMenuItem *)deleteItem{
    if (g_deleteItemBlock) {
        g_deleteItemBlock(self);
    }
}

/** 撤销按钮 事件监听*/
-(void)revokeItemClick:(UIMenuItem *)revokeItem{
    if (g_revokeItemBlock) {
        g_revokeItemBlock(self);
    }
}

/** 保存按钮 事件监听*/
-(void)saveItemClick:(UIMenuItem *)saveIte{
    if (g_saveItemBlock) {
        g_saveItemBlock(self);
    }
}

/** 更多按钮 事件监听*/
-(void)moreItemClick:(UIMenuItem *)moreItem{
    if (g_moreItemBlock) {
        g_moreItemBlock(self);
    }
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

/** 导航栏的返回按钮 */
+(UIButton *)backButtton{
    UIButton *backBtton = [[UIButton alloc] initWithFrame:CGRectMake(3, 20, 44, 44)];
    UIImage *backImg = [UIImage svgImageNamed:@"user_center_back" size:CGSizeMake(44, 44)];
    [backBtton setImage:backImg forState:UIControlStateNormal];
    return backBtton;
}

@end
