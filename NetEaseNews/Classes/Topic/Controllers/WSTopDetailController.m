//
//  WSTopDetailController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopDetailController.h"
#import "WSTopicDetail.h"
#import "WSTopicDetailCell.h"
#import "WSTopic.h"
#import "UIImageView+WebCache.h"
#import "YiRefreshFooter.h"

@interface WSTopDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tablviewTop;
@property (weak, nonatomic) IBOutlet UILabel *topLbl;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (weak, nonatomic) IBOutlet UILabel *introLbl;
@property (weak, nonatomic) IBOutlet UILabel *concertCountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *answerIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *classLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *topicDeails;
@property (assign, nonatomic) NSInteger topicIndex;
@property (strong, nonatomic) YiRefreshFooter *refreshFooter;

@end

@implementation WSTopDetailController


#pragma mark - tableview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    
    if (y>0) {
        
        self.topViewTop.constant = -y;
        self.topView.alpha =1-(y/(self.topView.bounds.size.height));
        self.topLbl.alpha = 1 - self.topView.alpha;
        if (y<134) {
            
            self.tablviewTop.constant = 134-y;
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidScroll:scrollView];
}


#pragma mark - tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.topicDeails.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSTopicDetailCell *cell = [WSTopicDetailCell topicDetalWithTableView:tableView];
    
    cell.topicDetail = self.topicDeails[indexPath.section];
    
    return cell;
}




#pragma mark - view



- (IBAction)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.answerIcon.layer.cornerRadius = self.answerIcon.bounds.size.width * 0.5;
    self.answerIcon.layer.masksToBounds = YES;
    self.introLbl.text = self.topic.alias;
    self.concertCountLbl.text = [NSString stringWithFormat:@"%@关注",self.topic.concernCount];
    self.topLbl.text = self.topic.alias;
    self.topLbl.alpha = 0;
    [self.answerIcon sd_setImageWithURL:[NSURL URLWithString:self.topic.headpicurl] placeholderImage:[UIImage imageNamed:@"comment_profile_default"]];
    self.nameLbl.text = self.topic.name;
    self.classLbl.text = self.topic.classification;
    self.detailLbl.text = self.topic.desc;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.topic.picurl] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
//    self.tableView.contentInset = UIEdgeInsetsMake(134, 0, 0, 0);

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
    
    [WSTopicDetail topDetailWithIndex:self.topicIndex isCache:cache expertID:self.topic.expertId getDataSuccess:^(NSArray *dataArr) {

        
        if (weakSelf.topicIndex == 0) [weakSelf.topicDeails removeAllObjects];
        
        [self.topicDeails addObjectsFromArray:dataArr];
        
        if(dataArr.count>0) {
            
            weakSelf.topicIndex += 10;
            [weakSelf.refreshFooter endRefreshing];
        }
        
        [self.tableView reloadData];
        
    } getDataFailure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [weakSelf.refreshFooter endRefreshing];

    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tablviewTop.constant = 134;

    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - init

+ (instancetype)topicDetailWithTopic:(WSTopic *)topic{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Topic" bundle:nil];
    
    WSTopDetailController *vc = [sb instantiateViewControllerWithIdentifier:@"topicDetail"];
    
    vc.topic = topic;
    
    return vc;
}

- (NSMutableArray *)topicDeails{
    
    if (!_topicDeails) {
        _topicDeails = [NSMutableArray arrayWithArray:[WSTopicDetail cacheWithExpertID:self.topic.expertId]]? : [NSMutableArray array];
    }
    return _topicDeails;
}

@end
