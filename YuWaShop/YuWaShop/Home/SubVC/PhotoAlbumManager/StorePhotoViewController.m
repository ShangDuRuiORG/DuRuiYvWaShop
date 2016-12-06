//
//  StorePhotoViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "StorePhotoViewController.h"
#import "StorePhotoCollectionViewCell.h"


#import "YJSegmentedControl.h"



#define CELL0    @"StorePhotoCollectionViewCell"
@interface StorePhotoViewController ()<YJSegmentedControlDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>


@property(nonatomic,strong)YJSegmentedControl*topView;
@property(nonatomic,strong)UICollectionView*collectionView;

@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)int pagen;
@property(nonatomic,assign)int pages;
@property(nonatomic,strong)NSMutableArray*allDatasModel;


@end

@implementation StorePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"商家相册";
    [self addTopView];
    [self addcollectionView];
    [self setUpMJRefresh];
}


#pragma mark  -- UI
-(void)addTopView{
    NSArray*titleArray=@[@"店铺",@"商品",@"环境",@"其他"];
    YJSegmentedControl*topView=[YJSegmentedControl segmentedControlFrame:CGRectMake(0, 64, kScreen_Width, 44) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [self.view addSubview:topView];
    self.topView=topView;
    
}

-(void)addcollectionView{
    UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=20;
    flowLayout.minimumLineSpacing=15;
    flowLayout.sectionInset=UIEdgeInsetsMake(15, 15, 15, 15);
    flowLayout.itemSize=CGSizeMake((kScreen_Width-20-30)/2, (kScreen_Width-20-30)/2);
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+44, kScreen_Width, kScreen_Height-64-44) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellWithReuseIdentifier:CELL0];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
  
    [self.view addSubview:self.collectionView];
    
    
}

-(void)setUpMJRefresh{
    self.status=0;
    self.pagen=10;
    self.pages=0;
    self.allDatasModel=[NSMutableArray array];
    
    self.collectionView.mj_header=[UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages=0;
        self.allDatasModel=[NSMutableArray array];
        [self getDatas];
        
    }];
    
    //上拉刷新
    self.collectionView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages++;
        [self getDatas];
    }];
    
    //立即刷新
    [self.collectionView.mj_header beginRefreshing];
    
    
    
}


#pragma mark  --collectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:CELL0 forIndexPath:indexPath];
    
  
    return cell;
}

#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"%lu",selection);
    self.status=selection;
    [self.collectionView.mj_header beginRefreshing];
    
}


#pragma mark  -- Datas
-(void)getDatas{
    
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}


@end
