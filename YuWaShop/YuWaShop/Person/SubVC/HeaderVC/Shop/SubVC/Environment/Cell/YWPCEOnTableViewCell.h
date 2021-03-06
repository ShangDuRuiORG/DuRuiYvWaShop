//
//  YWPCEOnTableViewCell.h
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWPCEOnTableViewCell : UITableViewCell

@property (nonatomic,copy)void (^chooseBlock)(BOOL);

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *chooseSwich;

@property (nonatomic,assign)BOOL isChoosed;

@end
