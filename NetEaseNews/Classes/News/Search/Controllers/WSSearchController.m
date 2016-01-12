//
//  WSSearchController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSSearchController.h"
#import "WSSearchResult.h"
#import "WSContentController.h"
#import "WSImageContentController.h"

@interface WSSearchController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *result;

@end

@implementation WSSearchController



#pragma mark - searchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [WSSearchResult searchResultWithKey:searchBar.text result:^(NSArray *dataArr) {
        
        [self.result addObjectsFromArray:dataArr];
        [self.tableView reloadData];
        [self.searchBar resignFirstResponder];
    }];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSSearchResult *result = self.result[indexPath.row];
    
    if ([result.skipType isEqualToString:@"doc"]) {
        
        WSContentController *content = [[WSContentController alloc] init];
        content.docid = result.docid;
        [self.navigationController pushViewController:content animated:YES];
        
    }else if ([result.skipType isEqualToString:@"photoset"]){
        
        WSImageContentController *vc = [[WSImageContentController alloc] init];
        vc.replycount = 0;
        vc.photosetID = result.skipID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"resultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    WSSearchResult *result = self.result[indexPath.row];
    
    cell.textLabel.text = result.title;
    cell.detailTextLabel.text = result.ptime;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
    
}





#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (NSMutableArray *)result{
    
    if (!_result) {
        _result = [NSMutableArray array];
    }
    return _result;
}

@end
