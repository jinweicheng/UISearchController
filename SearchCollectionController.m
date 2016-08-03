//
//  SearchCollectionController.m
//  UISearchController
//
//  Created by 程金伟 on 16/6/17.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "SearchCollectionController.h"

#import "CollectionViewCell.h"

#import "CollectionModel.h"

#import "DetailViewController.h"

static NSString * const reuseIdentifier = @"myCell";

@interface SearchCollectionController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property(nonatomic,strong)UICollectionView *collectionView1;

@end

@implementation SearchCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"A8";
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.collectionView1 registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
      [self setOneCollectionView];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)setSearchResults:(NSMutableArray *)searchResults
{
    _searchResults = searchResults;

    [self.collectionView1 reloadData];
    
}


/**
 *  main的collectionview
 */
- (void)setOneCollectionView{
    
    //创建集合视图
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 33;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//分区内边距
    //itemsize大小我们设置为一行4列
    CGFloat totalWidth = kwidth;
    CGFloat itemWidth = (totalWidth-3*5-2*5)/4.0;
    CGFloat itemHeght = 1.0*itemWidth;
    //注意：item的宽高必须要提前算好
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeght);
    //创建collectionView对象，并赋值布局
    self.collectionView1 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kwidth, kheight) collectionViewLayout:flowLayout];
    //设置数据源和代理
    self.collectionView1.dataSource = self;
    self.collectionView1.delegate = self;
    self.collectionView1.bounces = NO;
    self.collectionView1.backgroundColor = [UIColor whiteColor];
    
   
    //注册单元格
    [self.collectionView1 registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //添加
    [self.view addSubview:self.collectionView1];
    
}
#pragma mark--UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.searchResults.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //执行完以下语句后调用   MyCollectionViewCell.m  的 initWithFrame方法
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //设置cell
    cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
    
    CollectionModel *model = [[CollectionModel alloc] init];
    
    model = self.searchResults[indexPath.item];
    cell.lable.text = [NSString stringWithFormat:@"%@",model.imageName];
    return cell;
    
}


#pragma mark--UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld %ld",indexPath.section,indexPath.item);
    
    DetailViewController *detail = [[DetailViewController alloc] init] ;
    CollectionModel *model = [[CollectionModel alloc] init];
    model = self.searchResults[indexPath.item];
    detail.name = model.imageName;
    [self.presentingViewController.navigationController pushViewController:detail animated:YES];
//    [self presentViewController:detail animated:YES completion:nil];
}


@end
