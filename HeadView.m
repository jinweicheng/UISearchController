//
//  HeadView.m
//  UISearchController
//
//  Created by 程金伟 on 16/6/16.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //lineView视图
        _sectionView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_sectionView];
        _sectionView.backgroundColor = [UIColor grayColor];
    }
    return self;
}

@end
