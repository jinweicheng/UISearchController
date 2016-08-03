//
//  CollectionViewCell.h
//  UISearchController
//
//  Created by 程金伟 on 16/6/15.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionModel;

@interface CollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UILabel *lable;

@property(nonatomic,strong)CollectionModel *collectionModel;
@end
