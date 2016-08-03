//
//  CollectionViewCell.m
//  UISearchController
//
//  Created by 程金伟 on 16/6/15.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionModel.h"
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加内部控件
        //imageview
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, totalWidth, totalWidth)];
        self.imageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
        //lable
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, totalHeight+5, totalWidth, 20)];
        self.lable.textAlignment = NSTextAlignmentCenter;
        self.lable.layer.borderWidth = 0.5f;
        self.lable.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.lable.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.lable];
        
    }
    return self;
}

- (void)setCollectionModel:(CollectionModel *)collectionModel{
    self.lable.text = collectionModel.imageName;
}


@end
