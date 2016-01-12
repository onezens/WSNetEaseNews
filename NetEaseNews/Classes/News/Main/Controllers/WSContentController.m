//
//  WSContentController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/30.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSContentController.h"
#import "WSGetDataTool.h"
#import "WSContent.h"
#import "WSCommentController.h"
#import "MBProgressHUD.h"

@interface WSContentController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) WSContent *content;
@property (weak, nonatomic) IBOutlet UIButton *bottomCommentBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *topCommentBtn;
@end

@implementation WSContentController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.bottomView.hidden = YES;
    self.topCommentBtn.hidden = YES;
    
    self.webView.delegate = self;
    
    [self.webView loadHTMLString:@"<html><body bgcolor=\"#F9F6FA\"></body></html>" baseURL:nil];
    
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    
    [self loadData];
}

- (void)loadData {
    
    typeof(self) __weak weakSelf = self;


    [WSContent contentWithNewsID:self.docid getDataSucces:^(WSContent *content) {
        
        weakSelf.content = content;
        
    } getDataFailure:^(NSError *error) {
        
        NSLog(@"加载失败%@",error);
        [MBProgressHUD hideHUDForView:self.webView animated:YES];
        
    }];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    if ([urlStr containsString:@"imgsrc"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存图片？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        [alert addAction:cancel];
        [alert addAction:save];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    return YES;
}


- (void)setContent:(WSContent *)content{
    
    _content = content;
    
    NSString *count = (content.replyCount <= 9999) ? [NSString stringWithFormat:@"%ld跟帖",content.replyCount] : [NSString stringWithFormat:@"%.1f万跟帖",(float)content.replyCount / 10000];
    
    [self.topCommentBtn setTitle:count forState:UIControlStateNormal];
    [self.bottomCommentBtn setTitle:[NSString stringWithFormat:@"%ld",content.replyCount] forState:UIControlStateNormal];
    
    [self setDataWithContent:content];
}

- (void)setDataWithContent:(WSContent *)content{
    
    //拼接html文档
    NSMutableString *htmlStr = [NSMutableString stringWithFormat:@"<body bgcolor=\"#F9F6FA\" style=\"font-size:17px;\"><h2>%@</h2><p  style=\"color:#008B8B;font-size:13px;\">%@ %@</p> %@ </body>",_content.title,_content.ptime,_content.source,_content.body];
    
    CGFloat width = _webView.bounds.size.width - 16;
    
    //设置图片
    NSString *imageOnload = @"this.onclick = function() {window.location.href = 'sx:imgsrc=' +this.src;};";
    for (NSDictionary *dict in _content.img) {
        
        NSString *imgSize = dict[@"pixel"];
        CGFloat imgWidth = [imgSize substringToIndex:[imgSize rangeOfString:@"*"].location].floatValue;
        CGFloat imgHeight = [imgSize substringFromIndex:[imgSize rangeOfString:@"*"].location + 1].floatValue;
        
        [htmlStr replaceOccurrencesOfString:dict[@"ref"] withString:[NSString stringWithFormat:@"<img onload=\"%@\" src=\"%@\" width=\"%f\" height=\"%f\"/>",imageOnload ,dict[@"src"], width, imgHeight/imgWidth * width] options:0 range:NSMakeRange(0, [htmlStr length])];
    }
    
    //设置视频
    //            <video width="320" height="240" controls="controls">
    //            <source src="movie.mp4" type="video/mp4" />
    //            </video>
    
    NSString *videoOnload = @"this.onclick = function() {window.location.href = 'sx:videosrc=' +this.src;};";
    for (NSDictionary *dict in _content.video) {
        
        [htmlStr replaceOccurrencesOfString:dict[@"ref"] withString:[NSString stringWithFormat:@"<video onload=\"%@\" width=\"%f\" height=\"200\" poster=\"%@\"><source src=\"%@\"></video>",videoOnload ,width,dict[@"cover"],dict[@"url_mp4"]] options:0 range:NSMakeRange(0, [htmlStr length])];
        
    }
    
    
    [_webView loadHTMLString:htmlStr baseURL:nil];
    self.bottomView.hidden = NO;
    self.topCommentBtn.hidden = NO;
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)backItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)commentBtn {
    
    WSCommentController *vc = [[WSCommentController alloc] init];
    vc.docid = self.docid;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - init

+ (instancetype)contentControllerWithID:(NSString *)docID{
    
    id obj = [[self alloc] init];
    
    [obj setDocid:docID];
    
    return obj;
}

@end
