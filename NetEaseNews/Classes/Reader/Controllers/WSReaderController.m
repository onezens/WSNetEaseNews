//
//  WSReaderController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/27.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSReaderController.h"
#import "WSNews.h"
#import "WSContentController.h"
#import "WSImageContentController.h"
#import "WSReaderCell.h"
#import "YiRefreshFooter.h"
#import "YiRefreshHeader.h"
#import "MBProgressHUD.h"

@interface WSReaderController ()

@property (strong, nonatomic) NSMutableArray *news;

@property (strong, nonatomic) YiRefreshFooter *refreshFooter;

@property (strong, nonatomic) YiRefreshHeader *refreshHeader;

@end

@implementation WSReaderController


#pragma mark - tableview deleagate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSNews *news = self.news[indexPath.row];
    
    WSContentController *contentVC = [WSContentController contentControllerWithID:news.docid];
    
    [self.navigationController pushViewController:contentVC animated:YES];
}


#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    WSNews *news = self.news[indexPath.row];
    
    WSReaderCellType type = 0;
    
    if (news.imgnewextra.count == 2) {
        type = WSReaderCellTypeMulImage;
    }
    
    WSReaderCell *cell = [WSReaderCell readerCellWithTableView:tableView cellType:type];
    
    cell.news = self.news[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSNews *news = self.news[indexPath.row];
    
    WSReaderCellType type = 0;
    
    if (news.imgnewextra.count ==2) {
        type = WSReaderCellTypeMulImage;
    }
    
    return [WSReaderCell rowHeightWithCellType:type];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //rightItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_readerplus"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self loadData];
    
}

- (void)loadData{
    
    
    typeof(self) __weak weakSelf = self;
    
    [WSNews newsListDataWithNewsID:@"recommend/getSubDocPic?from=yuedu&passport=&devId=vLWbfIXxCa1CK9%2B20Q0f98IOSn9ZTn2pjLRXOOBn3fttg3OsEQzfSL238z3USCkJ&size=20&version=5.5.0&spever=false&net=wifi&lat=&lon=&ts=1452345806&sign=Vf9VSXMe%2FiPTnV%2FkraURuEGN6C35Qa4lVvtutXIvCjJ48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore" newsCache:YES getDataSuccess:^(NSArray *dataArr) {
        
        if (dataArr.count>0) {
            
            [self.news addObjectsFromArray:dataArr];
            [weakSelf.tableView reloadData];
            [weakSelf.refreshFooter endRefreshing];
            [weakSelf.refreshHeader endRefreshing];
            
        }
        
    } getFailure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [weakSelf.refreshFooter endRefreshing];
        [weakSelf.refreshHeader endRefreshing];
        
    }];
}

- (void)rightItemClick {
    
    
}

- (NSMutableArray *)news{
    
    if (!_news) {
        
        _news = [NSMutableArray arrayWithArray:[WSNews cacheFileArrWithChannelID:@"推荐"]] ? :[NSMutableArray array];
    }
    return _news;
}

@end