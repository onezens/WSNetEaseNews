

//
//  WSVideoController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSVideoController.h"
#import "WSVideo.h"
#import "WSVideoCell.h"
#import "UIButton+WebCache.h"
#import "NSString+WS.h"
#import "YiRefreshFooter.h"
#import "MoviePlayerViewController.h"

@interface WSVideoController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepWidth;

@property (weak, nonatomic) IBOutlet UIButton *videoList1Btn;
@property (weak, nonatomic) IBOutlet UILabel *videoList1TitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *videoList2Btn;
@property (weak, nonatomic) IBOutlet UILabel *videoList2TitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *videoList3Btn;
@property (weak, nonatomic) IBOutlet UILabel *videoList3TitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *videoList4Btn;
@property (weak, nonatomic) IBOutlet UILabel *videoList4TitleLbl;

@property (strong, nonatomic) YiRefreshFooter *refreshFooter;

@property (strong, nonatomic) NSMutableArray *videos;

@property (strong, nonatomic) NSArray *videoSidList;

@property (assign, nonatomic) NSInteger videoIndex;

@property (strong, nonatomic) UIWindow *videoWin;

@end

@implementation WSVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sepWidth.constant = 0.5;
    
    [self loadDataWithCache:YES];
    
    typeof(self) __weak weakSelf = self;
    YiRefreshFooter *refreshFooter = [[YiRefreshFooter alloc] init];
    refreshFooter.scrollView = self.tableView;
    refreshFooter.beginRefreshingBlock = ^(){
        
        [weakSelf loadDataWithCache:NO];
    };
    [refreshFooter footer];
    _refreshFooter = refreshFooter;
    
}


- (void)loadDataWithCache:(BOOL)cache{
    
    
    typeof(self) __weak weakSelf = self;
    
    [WSVideo videosWithIndex:self.videoIndex cache:cache getDataSuccess:^(NSArray *dataArr) {
        
        [weakSelf.videos addObjectsFromArray:dataArr];
        if(dataArr.count){
            
            weakSelf.videoIndex += 10;
            [weakSelf.tableView reloadData];
            [weakSelf.refreshFooter endRefreshing];
        }
        
        
    
    } videoSidList:^(NSArray *list) {
        
        self.videoSidList = list;
        
    } getDataFailure:^(NSError *error) {
        
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.refreshFooter endRefreshing];
        });
    }];
    
}

- (void)setVideoSidList:(NSArray *)videoSidList{
    
    _videoSidList = videoSidList;
    [self setSidListImg:self.videoList1Btn title:self.videoList1TitleLbl withDict:videoSidList[0]];
    [self setSidListImg:self.videoList2Btn title:self.videoList2TitleLbl withDict:videoSidList[1]];
    [self setSidListImg:self.videoList3Btn title:self.videoList3TitleLbl withDict:videoSidList[2]];
    [self setSidListImg:self.videoList4Btn title:self.videoList4TitleLbl withDict:videoSidList[3]];

}

- (void)setSidListImg:(UIButton *)btn title:(UILabel *)lbl withDict:(NSDictionary *)dict{
    
    [btn sd_setImageWithURL:[NSURL URLWithString:dict[@"imgsrc"]] forState:UIControlStateNormal];
    lbl.text = dict[@"title"];
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSVideo *video = self.videos[indexPath.section];
    
    NSLog(@"%@",video.mp4_url);
    
    MoviePlayerViewController *playerVC = [[MoviePlayerViewController alloc] init];
    
    UIViewController *vc = [[UIViewController alloc] init];
    self.videoWin.rootViewController = vc;
    UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
    
    typeof(self) __weak weakSelf = self;
    playerVC.url = video.mp4_url;
    playerVC.playFinished = ^(){
        
        weakSelf.videoWin.rootViewController = nil;
        [keyWin makeKeyAndVisible];
    };
    [self.videoWin makeKeyAndVisible];
    [vc presentViewController:playerVC animated:YES completion:nil];
}

#pragma mark - tableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [WSVideoCell rowHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.videos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSVideoCell *cell = [WSVideoCell videoCellWithTableView:tableView];
    
    cell.video = self.videos[indexPath.section];
    
    return cell;
}



#pragma mark - init

+ (instancetype)videoController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Media" bundle:nil];
    
    return [sb instantiateViewControllerWithIdentifier:@"videoController"];
}

#pragma mark - lazyloadind

- (UIWindow *)videoWin{
    
    if (!_videoWin) {
        _videoWin = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _videoWin;
}

- (NSMutableArray *)videos{
    
    if (!_videos) {
        
        _videos = [NSMutableArray arrayWithArray:[WSVideo cacheData]] ? : [NSMutableArray array];
    }
    
    return _videos;
}

@end
