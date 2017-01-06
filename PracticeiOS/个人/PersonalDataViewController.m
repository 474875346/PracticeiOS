//
//  PersonalDataViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/20.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "PersonalDataViewController.h"

@interface PersonalDataViewController ()

@end

@implementation PersonalDataViewController
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self tabBarShow];
}
- (PersonalModel *)Personal {
  if (_Personal == nil) {
    _Personal = [[PersonalModel alloc] init];
  }
  return _Personal;
}

- (NSArray *)titleArray {
  if (_titleArray == nil) {
    _titleArray = [[NSArray alloc]
        initWithObjects:@"昵称", @"性别", @"校外住址",
                        @"紧急联系方式", @"实习单位", @"实习岗位",
                        @"岗位老师姓名", @"岗位老师电话", nil];
  }
  return _titleArray;
}

- (UIImage *)selectedImg {
  if (_selectedImg == nil) {
    _selectedImg = [[UIImage alloc] init];
  }
  return _selectedImg;
}
- (UITableView *)PersonalDataTabelView {
  if (_PersonalDataTabelView == nil) {
    _PersonalDataTabelView = [[UITableView alloc]
        initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)
                style:UITableViewStylePlain];
    _PersonalDataTabelView.delegate = self;
    _PersonalDataTabelView.dataSource = self;
    _PersonalDataTabelView.bounces = NO;
    _PersonalDataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_PersonalDataTabelView];
  }
  return _PersonalDataTabelView;
}

- (UIButton *)SaveButton {
  if (_SaveButton == nil) {
    _SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _SaveButton.frame = CGRectMake(ScreenWidth - 80, 20, 60, 44);
    _SaveButton.imageEdgeInsets = UIEdgeInsetsMake(12, 10, 12, 35);
    [_SaveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_SaveButton addTarget:self
                    action:@selector(PersonalDataSave)
          forControlEvents:UIControlEventTouchUpInside];
  }
  return _SaveButton;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self tabBarHidden];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"个人信息"];
  [self addBackButton];
  [self TheAssignment];
  //图片选择器
  _picker = [[UIImagePickerController alloc] init];
  _picker.delegate = self;
  _picker.allowsEditing = YES;
    [self.view addSubview:self.SaveButton];
}
#pragma mark 字符串赋值
- (void)TheAssignment {
  _name = self.Personal.data.name;
  if ([self.Personal.data.sex isEqualToString:@"M"]) {
    _sex = @"男";
  } else if ([self.Personal.data.sex isEqualToString:@"F"]) {
    _sex = @"女";
  } else {
    _sex = @"";
  }
  _address = self.Personal.data.address;
  _emergencyContact = self.Personal.data.emergencyContact;
  _unit = self.Personal.data.unit;
  _post = self.Personal.data.post;
  _teacherName = self.Personal.data.teacherName;
  _teacherContact = self.Personal.data.teacherContact;
  [self.PersonalDataTabelView reloadData];
}
#pragma mark 返回区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}
#pragma mark 返回行数
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  } else {
    return self.titleArray.count;
  }
}
#pragma mark 返回行高
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 80;
  } else {
    return 60;
  }
}
#pragma mark 表格布局
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PersonalDataTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (indexPath.section == 0) {
    if (cell == nil) {
      cell = [[NSBundle mainBundle] loadNibNamed:@"PersonalDataTableViewCell"
                                           owner:nil
                                         options:nil][0];
    }
    ViewBorderRadius(cell.imageV, 30, 0, [UIColor clearColor]);
    if (_isImg) {
      cell.imageV.image = _selectedImg;
    } else {
      if (self.Personal.data.studentHeads.count > 0) {
        [cell.imageV
            sd_setImageWithURL:[NSURL URLWithString:self.Personal.data
                                                        .studentHeads[0][
                                                            @"source"]]
              placeholderImage:IMG(@"iconview")];
      } else {
        cell.imageV.image = [UIImage imageNamed:@"iconview"];
      }
    }
  } else {
    if (cell == nil) {
      cell = [[NSBundle mainBundle] loadNibNamed:@"PersonalDataTableViewCell"
                                           owner:nil
                                         options:nil][1];
    }
    cell.titleLabel.text = self.titleArray[indexPath.row];
    switch (indexPath.row) {
    case 0: {
      cell.contentLabel.text = _name;
    } break;
    case 1: {
      cell.contentLabel.text = _sex;
    } break;
    case 2: {
      cell.contentLabel.text = _address;
    } break;
    case 3: {
      cell.contentLabel.text = _emergencyContact;
    } break;
    case 4: {
      cell.contentLabel.text = _unit;
    } break;
    case 5: {
      cell.contentLabel.text = _post;
    } break;
    case 6: {
      cell.contentLabel.text = _teacherName;
    } break;
    case 7: {
      cell.contentLabel.text = _teacherContact;
    } break;

    default:
      break;
    }
  }
  return cell;
}
#pragma mark 表格点击
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    [self upLoadHeader];
  } else {
    if (indexPath.row != 1) {
      UIAlertView *alertView =
          [[UIAlertView alloc] initWithTitle:self.titleArray[indexPath.row]
                                     message:@""
                                    delegate:self
                           cancelButtonTitle:@"取消"
                           otherButtonTitles:@"确定", nil];
      alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
      alertView.tag = indexPath.row;
      UITextField *textField = [alertView textFieldAtIndex:0];
      textField.placeholder = [NSString
          stringWithFormat:@"请输入%@", self.titleArray[indexPath.row]];
      [alertView show];
    } else {
      UIAlertView *alertView =
          [[UIAlertView alloc] initWithTitle:self.titleArray[indexPath.row]
                                     message:@""
                                    delegate:self
                           cancelButtonTitle:@"男"
                           otherButtonTitles:@"女", nil];
      alertView.tag = indexPath.row;
      alertView.alertViewStyle = UIAlertViewStyleDefault;
      [alertView show];
    }
  }
}
#pragma mark 提示框点击
- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  switch (alertView.tag) {
  case 0: {
    if (buttonIndex == 1) {
      UITextField *textField = [alertView textFieldAtIndex:0];
      _name = textField.text;
      [self.PersonalDataTabelView reloadData];
    }
  } break;
  case 1: {
    if (buttonIndex == 0) {
      _sex = @"男";
    } else {
      _sex = @"女";
    }
    [self.PersonalDataTabelView reloadData];
  } break;
  case 2: {
    if (buttonIndex == 1) {
      UITextField *textField = [alertView textFieldAtIndex:0];
      _address = textField.text;
      [self.PersonalDataTabelView reloadData];
    }
  } break;
  case 3: {
    if (buttonIndex == 1) {
      UITextField *textField = [alertView textFieldAtIndex:0];
      _emergencyContact = textField.text;
      [self.PersonalDataTabelView reloadData];
    }
  } break;
  case 4: {
    if (buttonIndex == 1) {
      UITextField *textField = [alertView textFieldAtIndex:0];
      _unit = textField.text;
      [self.PersonalDataTabelView reloadData];
    }
  } break;
  case 5: {
    if (buttonIndex == 1) {
      UITextField *textField = [alertView textFieldAtIndex:0];
      _post = textField.text;
      [self.PersonalDataTabelView reloadData];
    }
  } break;
  case 6: {
    if (buttonIndex == 1) {
      UITextField *textField = [alertView textFieldAtIndex:0];
      _teacherName = textField.text;
      [self.PersonalDataTabelView reloadData];
    }
  } break;
  case 7: {
    if (buttonIndex == 1) {
      UITextField *textField = [alertView textFieldAtIndex:0];
      _teacherContact = textField.text;
      [self.PersonalDataTabelView reloadData];
    }
  } break;

  default:
    break;
  }
}

#pragma mark 选择图片
- (void)upLoadHeader {
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:nil
                       message:nil
                preferredStyle:UIAlertControllerStyleActionSheet];
  UIAlertAction *button1 = [UIAlertAction
      actionWithTitle:@"拍照"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *_Nonnull action) {
                AVAuthorizationStatus authStatus = [AVCaptureDevice
                    authorizationStatusForMediaType:AVMediaTypeVideo];
                if ((authStatus == AVAuthorizationStatusRestricted ||
                     authStatus == AVAuthorizationStatusDenied) &&
                    iOS8Later) {
                  // 无权限 做一个友好的提示
                  UIAlertView *alert =
                      [[UIAlertView alloc] initWithTitle:@"无法使用相机"
                                                 message:@"请在iPhone的"
                                                          "设置-隐私-相机"
                                                          "中允许访问相机"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"设置", nil];
                  [alert show];
                } else {
                  if ([UIImagePickerController
                          isSourceTypeAvailable:
                              UIImagePickerControllerSourceTypeCamera]) {
                    _picker.sourceType =
                        UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:_picker
                                       animated:YES
                                     completion:nil];
                  }
                }
              }];
  UIAlertAction *button2 = [UIAlertAction
      actionWithTitle:@"从相册选取"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *_Nonnull action) {
                if ([UIImagePickerController
                        isSourceTypeAvailable:
                            UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                  _picker.sourceType =
                      UIImagePickerControllerSourceTypePhotoLibrary;
                  [self presentViewController:_picker
                                     animated:YES
                                   completion:nil];
                }
              }];
  UIAlertAction *button3 =
      [UIAlertAction actionWithTitle:@"取消"
                               style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *_Nonnull action){

                             }];
  [alertController addAction:button1];
  [alertController addAction:button2];
  [alertController addAction:button3];
  [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark 选择头像结束
- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info {
  //获取选取的照片
  UIImage *selectedImg = [info objectForKey:UIImagePickerControllerEditedImage];
  self.selectedImg = selectedImg;
  _isImg = YES;
  [self.PersonalDataTabelView reloadData];
  [self upLoadHeaderData];
  [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 保存提交
- (void)PersonalDataSave {
  [self ModifyTheStudentsInFormation];
}
#pragma mark 上传头像
- (void)upLoadHeaderData {
  [[HttpTool sharedInstance] postImage:@[ self.selectedImg ]
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID
      }
      url:student_changeHead
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          KOMG(@"头像上传成功");
        } else {
          KOMG(json[@"msg"]);
        }
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }
      andProgress:^(NSInteger progressNum){

      }];
}
#pragma mark 修改学员信息
- (void)ModifyTheStudentsInFormation {
  NSString *sex = nil;
  if ([_sex isEqualToString:@"M"]) {
    sex = @"M";
  } else {
    sex = @"F";
  }
  [[HttpTool sharedInstance] postWithUrl:student_save
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID,
        @"id" : _Personal.data.id,
        @"name" : _name,
        @"sex" : sex,
        @"address" : _address,
        @"emergencyContact" : _emergencyContact,
        @"unit" : _unit,
        @"post" : _post,
        @"teacherName" : _teacherName,
        @"teacherContact" : _teacherContact,
        @"phone" : _Personal.data.phone
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          KOMG(@"修改信息成功");
          _PersonalData();
          [self.navigationController popViewControllerAnimated:YES];
        } else {
          KOMG(json[@"msg"]);
        }
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}
@end
