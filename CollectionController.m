//
//  CollectionController.m
//  UISearchController
//
//  Created by 程金伟 on 16/6/15.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "CollectionController.h"

#import "CollectionViewCell.h"

#import "CollectionModel.h"

#import "DetailViewController.h"

#import "SearchCollectionController.h"

#import "HeadView.h"

static NSString * const reuseIdentifier = @"myCell";
//static NSString * const reuseIdentifierHead = @"Cell";
@interface CollectionController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>
/**
 *  存放tableViewCell的展示数据内容a
 */
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;//全部数据数组
@property (nonatomic,strong)NSMutableArray *searchArray;//搜索结果数组
@property (nonatomic,strong)UISearchController *searchC;//搜索框
//@property (nonatomic,strong)HeadView *headView;
@property (nonatomic,strong)SearchCollectionController *searchCollectionC;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
//@property(nonatomic,assign)BOOL *clearedOutside;

@end

@implementation CollectionController

//懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)searchArray
{
    if (!_searchArray) {
        _searchArray = [[NSMutableArray alloc]init];
    }
    return _searchArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //此代码的问题解决方案－－－－－888666
    self.searchC.automaticallyAdjustsScrollViewInsets = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.searchC.hidesNavigationBarDuringPresentation = NO;
    
    
    self.navigationItem.title = @"search";
    
    [self setOneCollectionView];
    //添加搜索栏
    self.searchCollectionC = [[SearchCollectionController alloc] init];
    self.searchCollectionC.view.frame = CGRectMake(0, 64, kwidth, 1.5*kheight);
    
    [self.searchC.searchBar sizeToFit];
    self.searchC = [[UISearchController alloc] initWithSearchResultsController:self.searchCollectionC ];
    //代码设置的问题－－－－－888666
   self.searchC.searchBar.frame = CGRectMake(self.searchC.searchBar.frame.origin.x, self.searchC.searchBar.frame.origin.y, kwidth,44);
    
    [self.collectionView addSubview:self.searchC.searchBar];
    self.searchC.delegate = self;
    self.searchC.searchBar.delegate = self;

    
    //2016-06-17添加
    self.definesPresentationContext = YES;
    [self.view addSubview:self.searchC.searchBar];

    //更新代理
    self.searchC.searchResultsUpdater = self;
    self.searchC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchC.searchBar.barTintColor = [UIColor redColor];
    self.searchC.searchBar.placeholder = @"请输入市场名称";
    //搜索结果不变灰
    self.searchC.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    //便利初始化创建数据
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"a",@"b",@"c",@"z菲",@"wbe",@"ABe",@"aBS",@"wang@12.com", @"wan@126.cn",@"cheng",@"tian",@"jia",@"zai",@"程",@"为",@"逛",@"哈哈",@"kkk",@"yyy",nil];
    
    for (int i = 0; i < nameArray.count; i++) {
        CollectionModel *model = [[CollectionModel alloc] init];
        model.imageName = nameArray[i];
        //把全部人存到数组当中去
        [self.dataArray addObject:model];
    }
    
    
    
}


//-(void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear: animated];
////    self.searchC.active = true;
////    [self viewDidLoad];
////    [self  setOneCollectionView];
//    [self.searchC.searchBar becomeFirstResponder];
//}
/**
 *  main的collectionview
 */
- (void)setOneCollectionView{
    
    //创建集合视图
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.minimumInteritemSpacing = 5;
    self.flowLayout.minimumLineSpacing = 33;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//分区内边距
    //itemsize大小我们设置为一行4列
    CGFloat totalWidth = kwidth;
    CGFloat itemWidth = (totalWidth-3*5-2*5)/4.0;
    CGFloat itemHeght = 1.0*itemWidth;
    //注意：item的宽高必须要提前算好
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemHeght);
    //创建collectionView对象，并赋值布局
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kwidth, kheight) collectionViewLayout:self.flowLayout];
    //设置数据源和代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
       //注册单元格
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //添加
    [self.view addSubview:self.collectionView];
    
}
#pragma mark--UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //执行完以下语句后调用   MyCollectionViewCell.m  的 initWithFrame方法
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //设置cell
    cell.imageView.image = [UIImage imageNamed:@"1.jpg"];

    CollectionModel *model = [[CollectionModel alloc] init];
    
    model = self.dataArray[indexPath.item];
    cell.lable.text = [NSString stringWithFormat:@"%@",model.imageName];
    return cell;
}

#pragma mark--UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld %ld",indexPath.section,indexPath.item);
    
    
    DetailViewController *detail = [[DetailViewController alloc] init] ;
    CollectionModel *model = [[CollectionModel alloc] init];
    model = self.dataArray[indexPath.item];
    detail.name = model.imageName;
    [self.navigationController pushViewController:detail animated:YES];
//    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark---搜索代理方法，搜索框获得第一响应或内容变化时触发
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
        //    得到搜索框的文字
    NSString* str = searchController.searchBar.text;
    NSLog(@"%@",str);
    //创建个谓词
    
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"imageName CONTAINS[c]%@ ",str];
    
    //清空搜索数组
    [self.searchArray removeAllObjects];
    
    self.searchArray =  [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:namePredicate]];
    
    self.searchCollectionC.searchResults = self.searchArray;
    for (CollectionModel *model in self.searchArray) {
        NSLog(@"%@",model.imageName);
    }
    

    
}

@end
