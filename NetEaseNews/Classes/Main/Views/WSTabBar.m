//
//  WSTabBar.m
//  网易新闻
//
//  Created by WackoSix on 15/12/25.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSTabBar.h"
#define kMargin 4
#define kGrayColor [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1]

#pragma mark -
#pragma mark WSButton
#pragma mark -

@interface WSButton : UIButton

@end

@implementation WSButton

- (void)setHighlighted:(BOOL)highlighted{}

@end

#pragma mark -
#pragma mark WSTabBarItem
#pragma mark -

@interface WSTabBarItem ()

@property (weak, nonatomic) WSButton *itemBtn;
@property (weak, nonatomic) UILabel *itemLbl;

@end

@implementation WSTabBarItem

#pragma mark - event
- (void)setSelected:(BOOL)selected{
    
    _selected = selected;
    
    if (selected) {
        
        self.itemBtn.selected = YES;
        self.itemLbl.textColor = [UIColor redColor];
    }else{
        
        self.itemBtn.selected = NO;
        self.itemLbl.textColor = kGrayColor;
    }
}

- (void)itemBtnClick:(WSButton *)sender{
    
    if (self.itemClick) {
        
        self.itemClick(self);
    }
}


#pragma mark - 初始化

+ (instancetype)tabBarItemWithTitle:(NSString *)title itemImage:(UIImage *)image selectedImage:(UIImage *)selImage{
    
    WSTabBarItem *item = [[WSTabBarItem alloc] init];
    [item.itemBtn setImage:image forState:UIControlStateNormal];
    [item.itemBtn setImage:selImage forState:UIControlStateSelected];
    [item.itemBtn addTarget:item action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    item.itemLbl.text = title;
    item.itemLbl.textAlignment = NSTextAlignmentCenter;
    item.itemLbl.font = [UIFont systemFontOfSize:12];
    item.itemLbl.textColor = kGrayColor;
    
    return item;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat lblH = 13;
    
    self.itemBtn.frame = CGRectMake(0, kMargin, self.frame.size.width, self.frame.size.height - lblH - 2 * kMargin);
    self.itemLbl.frame = CGRectMake(0, CGRectGetMaxY(_itemBtn.frame)-kMargin*0.5, self.frame.size.width, lblH);
    
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.height = 49;
    [super setFrame:frame];
}


- (instancetype)init{
    
    if (self = [super init]) {
        
        WSButton *itemBtn = [WSButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:itemBtn];
        _itemBtn = itemBtn;
        
        UILabel *itemLbl = [[UILabel alloc] init];
        [self addSubview:itemLbl];
        _itemLbl = itemLbl;
    }
    return self;
}

@end


#pragma mark -
#pragma mark WSTabBar
#pragma mark -

@interface WSTabBar ()

@property (weak, nonatomic) WSTabBarItem *selItem;

@property (copy, nonatomic) barItemClickBlock itemClick;

@end

@implementation WSTabBar



+(instancetype)tabBarWithItems:(NSArray *)items itemClick:(nonnull barItemClickBlock)myblock{
    
    WSTabBar *tabBar = [[WSTabBar alloc] init];
    tabBar.items = items;
    [tabBar.items.firstObject setSelected:YES];
    tabBar.selItem = tabBar.items.firstObject;
    tabBar.itemClick = myblock;
    tabBar.backgroundColor = [UIColor whiteColor];
    
    return tabBar;
}

- (void)setSelItem:(WSTabBarItem *)selItem{
    
    _selItem = selItem;
    _selectedIndex = selItem.tag;
    if (self.itemClick) {
        
        self.itemClick(selItem.tag);
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat itemH = 49;
    CGFloat itemW = self.bounds.size.width / self.items.count;
    
    for (NSInteger i=0; i<self.items.count; i++) {
        
        WSTabBarItem *item = self.items[i];
        item.frame = CGRectMake(itemW * i, 0, itemW, itemH);
        [self addSubview:item];
        item.tag = i;
        item.itemClick = ^(WSTabBarItem *item){
          
            self.selItem.selected = NO;
            item.selected = YES;
            self.selItem = item;
        };

    }
}










@end
