//
//  WSCommentController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSCommentController.h"
#import "WSCommentCell.h"
#import "WSComment.h"
#import "WSGetDataTool.h"
#import "YiRefreshFooter.h"
#import "MBProgressHUD.h"

@interface WSCommentController ()<UITableViewDataSource, UITableViewDelegate>
{
    YiRefreshFooter *refresh;
}

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *comments;
@property (assign, nonatomic) NSInteger commentIndex;
@property (assign, nonatomic) BOOL isImage;


@end

@implementation WSCommentController

#pragma mark - tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //分两组（1.热门评论  2.最新评论）
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return [self.comments[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSCommentCell *cell = [WSCommentCell commentCellWithTableView:tableView];
    
    cell.comment = self.comments[indexPath.section][indexPath.row];
    
    return cell;
}


#pragma mark - view

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _isImage = self.postid ? YES : NO;
    
    //加载数据，
    if (self.isImage) {
        
        [self loadDataWithID:self.postid commentType:WSCommentTypeImageContentHot];
    }else{
        
        [self loadDataWithID:self.docid commentType:WSCommentTypeImageContentHot];
    }

    typeof(self) __weak weakSelf = self;
    //添加底部刷新
    refresh = [[YiRefreshFooter alloc] init];
    refresh.scrollView = self.tableView;
    [refresh footer];
    refresh.beginRefreshingBlock = ^(){
      
        if (weakSelf.isImage) {
            
            [weakSelf loadDataWithID:weakSelf.postid commentType:WSCommentTypeImageContentNormal];
        }else{
            
            [weakSelf loadDataWithID:weakSelf.docid commentType:WSCommentTypeContentNormal];
        }
        
    };
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)loadDataWithID:(NSString *)ID commentType:(WSCommentType)type{
    
    typeof(self)  __weak weakSelf = self;
    
    
    [WSComment commentWithID:ID index:self.commentIndex type:type getDataSuccess:^(NSArray *dataArr) {
        
        if (dataArr.count>0) {
            
            NSMutableArray *arrM = nil;
            
            if (type==WSCommentTypeContentHot || type==WSCommentTypeImageContentHot) {
                
                arrM = self.comments.firstObject;
                [arrM addObjectsFromArray:dataArr];
                
            }else if (type==WSCommentTypeContentNormal || type==WSCommentTypeImageContentNormal){
                
                arrM = self.comments.lastObject;
                [arrM addObjectsFromArray:dataArr];
            }
            
            self.commentIndex += 10;
            
            [refresh endRefreshing];
            [weakSelf.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
            weakSelf.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

            
        }else{
            
            NSLog(@"没有更多评论");
        }
        
    } getDataFailure:^(NSError *error) {
        
        NSLog(@"加载评论失败：%@",error);
        [refresh endRefreshing];
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];

    }];

}

- (IBAction)backItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy loading

- (NSArray *)comments{
    
    if (!_comments) {
        
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        _comments = @[arr1,arr2];
    }
    return _comments;
}


@end
