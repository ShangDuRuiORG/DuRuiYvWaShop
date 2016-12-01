//
//  YWHomeAdvanceOrderTableViewCell.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/12/1.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeAdvanceOrderTableViewCell.h"
#import "JWTools.h"

@implementation YWHomeAdvanceOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.rePlayBtn.layer.borderColor = CNaviColor.CGColor;
    self.rePlayBtn.layer.borderWidth = 1.f;
    self.rePlayBtn.layer.cornerRadius = 5.f;
    self.rePlayBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(YWHomeAdvanceOrderModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}
- (void)dataSet{//233333333
    self.phoneLabel.text = @"13789384585";
//    self.timeLabel.text = [JWTools dateWithStr:<#(NSString *)#>];
    self.timeLabel.text = @"2016-11-20 15:00";
    self.nmberLabel.text = [NSString stringWithFormat:@"%@人",@"22"];
    self.rePlayLabel.text = @"技师发型师007";
}

- (void)setStatus:(NSInteger)status{
    _status = status;
    self.rePlayBtn.hidden = status != 0;
}

- (IBAction)rePlayBtnAction:(id)sender {
    self.rePlayBlock();
}

@end
