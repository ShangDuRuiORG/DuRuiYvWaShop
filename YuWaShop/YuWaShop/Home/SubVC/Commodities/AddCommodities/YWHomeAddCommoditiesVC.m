//
//  YWHomeAddCommoditiesVC.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/11/29.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWHomeAddCommoditiesVC.h"

@interface YWHomeAddCommoditiesVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *introTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (nonatomic,copy)NSString * cameraImageStr;

@end

@implementation YWHomeAddCommoditiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加商品信息";
    [self makeUI];
}

- (void)makeUI{
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
}

- (IBAction)submitBtnAction:(id)sender {
    [self requestChangeIcon];
}

- (IBAction)imageBtnAction:(id)sender {
    [self makeLocalImagePicker];
}
- (void)makeLocalImagePicker{
    WEAKSELF;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//take photo
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [weakSelf myImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
        } else {
            MyLog(@"照片源不可用");
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//to localPhotos
        [weakSelf myImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)myImagePickerWithType:(UIImagePickerControllerSourceType)sourceType{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [picker setSourceType:sourceType];
        [picker setAllowsEditing:YES];
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        MyLog(@"照片源不可用");
    }
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.shopImage.image = info[@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Http
- (void)requestChangeIcon{
    //h33333333333上传商品图片
    if (!self.shopImage.image) {
        [self showHUDWithStr:@"请添加商品相片哟~" withSuccess:NO];
        return;
    }
    
//    self.cameraImageStr = @"";//233333商品相片URL
    [self requestUpData];
}
- (void)requestUpData{
    //h33333333333上传商品
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"请输入商品名称哟~" withSuccess:NO];
        return;
    }else if ([self.introTextField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"请输入商品介绍哟~" withSuccess:NO];
        return;
    }else if ([self.priceTextField.text isEqualToString:@""]||[self.priceTextField.text floatValue]<=0.f) {
        [self showHUDWithStr:@"请输入正确的商品价格哟~" withSuccess:NO];
        return;
    }
    
    [self showHUDWithStr:@"恭喜!添加成功" withSuccess:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end