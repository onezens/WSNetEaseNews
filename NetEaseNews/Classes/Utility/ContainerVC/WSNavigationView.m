//
//  WSNavigationView.m
//  网易新闻
//
//  Created by WackoSix on 15/12/27.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSNavigationView.h"
#define kViewH 35
#define kItemW 70
#define kMargin 10

@interface WSNavigationView ()

@property (strong, nonatomic) NSMutableArray *btns;

@property (weak, nonatomic) UIButton *selectedItem;

@property (copy, nonatomic) itemClick itemClickBlock;

@end

@implementation WSNavigationView



#pragma mark - event

- (void)itemClick:(UIButton *)sender {
    
    if ([sender isEqual:self.selectedItem]) return;
    
    self.selectedItem.selected = NO;
    sender.selected = YES;
   
    if (self.itemClickBlock) {
        
        self.itemClickBlock(sender.tag);
    }

    //更改字体大小
    [UIView animateWithDuration:0.5 animations:^{
        
        sender.titleLabel.font = [UIFont systemFontOfSize:17];
        self.selectedItem.titleLabel.font = [UIFont systemFontOfSize:13];
    }];
    
    //判断位置
    CGFloat offsetX = sender.center.x - self.center.x;
    
    if (offsetX < 0){
        
        self.contentOffset = CGPointMake(0, 0);
        
    }else if (offsetX > (self.contentSize.width - self.bounds.size.width)){
        
        self.contentOffset = CGPointMake(self.contentSize.width - self.bounds.size.width, 0);
        
    }else{
        
        self.contentOffset = CGPointMake(offsetX, 0);
    }

    
    self.selectedItem = sender;
    
 
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex{
    
    _selectedItemIndex = selectedItemIndex;
    
    UIButton *item = self.btns[selectedItemIndex];
    
    [self itemClick:item];
}


- (void)setContentOffset:(CGPoint)contentOffset{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [super setContentOffset:contentOffset];
    }];
}


#pragma mark - init

+ (instancetype)navigationViewWithItems:(NSArray<NSString *> *)items itemClick:(itemClick)itemClick{
    
    WSNavigationView *nav = [[WSNavigationView alloc] init];
    
    nav.btns = [NSMutableArray arrayWithCapacity:items.count];
    
    nav.itemClickBlock = itemClick;
    
    nav.items = items;
    ////禁用滚动到最顶部的属性
    nav.scrollsToTop = NO;

    return nav;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    for (NSInteger i=0; i<self.btns.count; i++) {
        
        UIButton *item = self.btns[i];
        CGFloat itemX = kMargin + kItemW * i;
        item.frame = CGRectMake(itemX, 0, kItemW, kViewH);
    }
    
    self.contentSize = CGSizeMake(kItemW * self.btns.count + kMargin * 2, kViewH);
}

- (void)setItems:(NSArray<NSString *> *)items{
    
    _items = items;
    
    //创建按钮
    for (NSInteger i=0; i<items.count; i++) {
        
        UIButton *item = [[UIButton alloc] init];
        [item setTitle:items[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:13];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:item];
        [self addSubview:item];
        item.tag = i;
        
    }
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.height = kViewH;
    [super setFrame:frame];
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}




@end
