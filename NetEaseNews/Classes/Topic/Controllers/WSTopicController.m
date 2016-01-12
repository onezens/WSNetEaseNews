//
//  WSTopicController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicController.h"
#import "WSTopic.h"
#import "WSTopicCell.h"
#import "YiRefreshFooter.h"
#import "MBProgressHUD.h"
#import "WSTopDetailController.h"

@interface WSTopicController ()

@property (strong, nonatomic) NSMutableArray *topics;

@property (assign, nonatomic) NSInteger topicIndex;

@property (strong, nonatomic) YiRefreshFooter *refreshFooter;

@end

@implementation WSTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.topicIndex = 0;
    
    [self loadDataWithCache:YES];
 
    typeof(self) __weak weakSelf = self;
    YiRefreshFooter *refresh = [[YiRefreshFooter alloc] init];
    refresh.scrollView = self.tableView;
    [refresh footer];
    refresh.beginRefreshingBlock = ^(){
      
        [weakSelf loadDataWithCache:NO];
    };
    _refreshFooter = refresh;
}

- (void)loadDataWithCache:(BOOL)cache{
    
    typeof(self) __weak weakSelf = self;
    
    [WSTopic topicWithIndex:self.topicIndex isCache:cache getDataSuccess:^(NSArray *dataArr) {
        
        if (dataArr.count == 0) {
            NSLog(@"没有更多数据");
            return ;
        }
        
        if(weakSelf.topicIndex == 0) [weakSelf.topics removeAllObjects];
        
        [weakSelf.topics addObjectsFromArray:dataArr];
        
        [weakSelf.tableView reloadData];
        
        if(dataArr.count>0) weakSelf.topicIndex += 10;
        
    } getDataFaileure:^(NSError *error) {
        
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.refreshFooter endRefreshing];
            
        });
    }];
}


#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSTopDetailController *td = [WSTopDetailController topicDetailWithTopic:self.topics[indexPath.row]];
    
    [self.navigationController pushViewController:td animated:YES];
}


#pragma mark - tableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [WSTopicCell rowHeight];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    WSTopicCell *cell = [WSTopicCell topicCellWithTableView:tableView];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}



#pragma mark - lazy loading

- (NSMutableArray *)topics{
    
    if (!_topics) {
        
        _topics = [NSMutableArray arrayWithArray:[WSTopic cacheTopic]]? :[NSMutableArray array];
    }
    
    return _topics;
}


@end