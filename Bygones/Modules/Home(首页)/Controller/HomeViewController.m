//
//  HomeViewController.m
//  Bygones
//
//  Created by lizhao on 2017/12/15.
//  Copyright © 2017年 lizhao. All rights reserved.
//

#import "HomeViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "XYString.h"

#import "ThreeBaseCell.h"
#import "ThreeFirstCell.h"
#import "ThreeSecondCell.h"
#import "ThreeThirdCell.h"
#import "ThreeFourthCell.h"
@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic ,strong) UITableView *tv;
@property(nonatomic ,strong) NSMutableArray *listArry;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.view addSubview:self.tv];
    
    self.tv.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (UITableView *)tv{
    
    /*
     本demo由SDAutoLayout库的使用者“李西亚”提供，感谢“李西亚”对本库的关注与支持！
     */
    
    if (!_tv) {
        
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tv.separatorColor = [UIColor clearColor];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        
        __weak typeof(self) weakSelf = self;
        
        //..下拉刷新
        _tv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.tv.mj_header;
            weakSelf.page = 0;
            [weakSelf loadData];
        }];
        
        // 马上进入刷新状态
        [_tv.mj_header beginRefreshing];
        
        //..上拉刷新
        _tv.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.tv.mj_footer;
            weakSelf.page = weakSelf.page + 10;
            [weakSelf loadData];
        }];
        
        _tv.mj_footer.hidden = YES;
        
        
    }
    return _tv;
}

-(NSMutableArray *)listArry{
    
    if (!_listArry) {
        _listArry = [[NSMutableArray alloc] init];
    }
    return _listArry;
}

#pragma mark - 请求数据
-(void)loadData{
    /*
     本demo由SDAutoLayout库的使用者“李西亚”提供，感谢“李西亚”对本库的关注与支持！
     */
    NSString * urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/%ld-20.html",@"headline/T1348647853363",self.page];
    NSLog(@"______%@",urlString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *_Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        //..keyEnumerator 获取字典里面所有键  objectEnumerator得到里面的对象  keyEnumerator得到里面的键值
        NSString *key = [dict.keyEnumerator nextObject];//.取键值
        NSArray *temArray = dict[key];
        
        // 数组>>model数组
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[ThreeModel mj_objectArrayWithKeyValuesArray:temArray]];
        
        //..下拉刷新
        if (self.myRefreshView == _tv.mj_header) {
            self.listArry = arrayM;
            _tv.mj_footer.hidden = self.listArry.count==0?YES:NO;
            
        }else if(self.myRefreshView == _tv.mj_footer){
            [self.listArry addObjectsFromArray:arrayM];
        }
        
        
        [self doneWithView:self.myRefreshView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        [_myRefreshView endRefreshing];
    }];
}

#pragma mark -  回调刷新
-(void)doneWithView:(MJRefreshComponent*)refreshView{
    [_tv reloadData];
    [_myRefreshView  endRefreshing];
}

#pragma mark - 表的协议方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     本demo由SDAutoLayout库的使用者“李西亚”提供，感谢“李西亚”对本库的关注与支持！
     */
    ThreeBaseCell * cell = nil;
    ThreeModel * threeModel = self.listArry[indexPath.row];
    
    NSString * identifier = [ThreeBaseCell cellIdentifierForRow:threeModel];
    Class mClass =  NSClassFromString(identifier);
    
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.threeModel = threeModel;
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;
    
    ///////////////////////////////////////////////////////////////////////
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // cell自适应设置
    ThreeModel * threeModel = self.listArry[indexPath.row];
    
    NSString * identifier = [ThreeBaseCell cellIdentifierForRow:threeModel];
    Class mClass =  NSClassFromString(identifier);
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self.tv cellHeightForIndexPath:indexPath model:threeModel keyPath:@"threeModel" cellClass:mClass contentViewWidth:[self cellContentViewWidth]];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)cellContentViewWidth
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

@end
