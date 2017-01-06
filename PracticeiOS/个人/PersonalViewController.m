//
//  PersonalViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/14.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "PersonalViewController.h"
#import "JPUSHService.h"
#import "PersonTableViewCell.h"
#import "PersonalDataViewController.h"
#import "SetUpViewController.h"

@interface PersonalViewController () <UITableViewDataSource,
                                      UITableViewDelegate> {
  UITableView *_personalTableview;

  NSArray *_titleArray;
}
@end

@implementation PersonalViewController
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if ([UDOBJ(@"LogInOut") isEqualToString:@"YES"]) {
    [self LoadData];
    UDSETOBJ(@"NO", @"LogInOut");
  }
}
- (PersonalModel *)Personal {
  if (_Personal == nil) {
    _Personal = [[PersonalModel alloc] init];
  }
  return _Personal;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self LoadData];
  self.view.backgroundColor = [UIColor whiteColor];
  //数据
  _titleArray =
      [[NSArray alloc] initWithObjects:@"15732157899", @"清除缓存",
                                       @"修改密码", @"退出登录", nil];
  [self CreatUI];
}
- (void)CreatUI {
  _personalTableview =
      [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, SCREEN_HEIGHT)
                                   style:UITableViewStyleGrouped];
  _personalTableview.delegate = self;
  _personalTableview.dataSource = self;
  _personalTableview.bounces = NO;
  _personalTableview.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:_personalTableview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  } else {
    return _titleArray.count;
  }
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 70;
  } else {
    return 50;
  }
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForFooterInSection:(NSInteger)section {
  return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    PersonTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"PersonTableViewCell"];
    if (cell == nil) {
      cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell"
                                            owner:nil
                                          options:nil] objectAtIndex:0];
    }
    cell.imageV.layer.cornerRadius = 25;
    cell.imageV.clipsToBounds = YES;
    if (_Personal.data.studentHeads.count > 0) {
      [cell.imageV
          sd_setImageWithURL:[NSURL
                                 URLWithString:_Personal.data
                                                   .studentHeads[0][@"source"]]
            placeholderImage:IMG(@"iconview")];
    } else {
      cell.imageV.image = [UIImage imageNamed:@"iconview"];
    }
    cell.nameLabel.text = _Personal.data.name;
    return cell;
  } else {
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:@"cell"];
    }
    cell.imageView.image = IMG(@"shezhi");
      if (indexPath.row == 0) {
          cell.textLabel.text = self.Personal.data.phone;
      }else {
          cell.textLabel.text = _titleArray[indexPath.row];
      }
    return cell;
  }
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    //进入个人信息
    PersonalDataViewController *dataVC =
        [[PersonalDataViewController alloc] init];
    dataVC.Personal = self.Personal;
    dataVC.PersonalData = ^{
      [self LoadData];
    };
    [self.navigationController pushViewController:dataVC animated:YES];
  } else {
    switch (indexPath.row) {
    case 1: {
      [self CacheClearing];
    } break;
    case 2: {
      [self.navigationController
          pushViewController:[ChangeThePasswordViewController new]
                    animated:true];
    } break;
    case 3: {
      [self LogInOutData];
    } break;
    default:
      break;
    }
  }

  [self slide];
}
#pragma mark 获取学生信息
- (void)LoadData {
  [[HttpTool sharedInstance] postWithUrl:Student_info
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID
      }
      sucess:^(id json) {
        [self.Personal mj_setKeyValues:json];
        if (_Personal.status == 200) {
          [_personalTableview reloadData];
        } else {
          KOMG(_Personal.msg);
        }
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}
#pragma mark 退出登录
- (void)LogInOutData {
  [[HttpTool sharedInstance] postWithUrl:student_loginOut
      parameters:@{
        @"app_token" : UDOBJ(ZToken),
        @"client" : DEVICEUUID
      }
      sucess:^(id json) {
        if ([json[@"status"] intValue] == 200) {
          KOMG(@"退出登录成功");
          //推送修改别名
          [JPUSHService setAlias:@"" callbackSelector:nil object:self];
          UDSETOBJ(@"N", @"haveBieMing");
          [[NSUserDefaults standardUserDefaults] synchronize];

          kremove(ZToken);
          ViewController *VC = [ViewController new];
          VC.LogInOut = YES;
          UDSETOBJ(@"YES", @"LogInOut");
          [self.navigationController pushViewController:VC animated:YES];
        } else {
          KOMG(json[@"msg"]);
        }
        [self TimerStop];
      }
      failur:^(NSError *error) {
        KOMG(kHttpError);
      }];
}

#pragma mark 清理缓存
- (void)CacheClearing {
  NSArray *Documentpaths = NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *Documentpath = [Documentpaths objectAtIndex:0];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                       NSUserDomainMask, YES);
  NSString *path = [paths objectAtIndex:0];
  NSString *str =
      [NSString stringWithFormat:@"清理缓存%.2fM",
                                 [self folderSizeAtPath:path] +
                                     [self folderSizeAtPath:Documentpath]];
  UIAlertController *alertController = [UIAlertController
      alertControllerWithTitle:@"提示"
                       message:str
                preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *otherAction =
      [UIAlertAction actionWithTitle:@"取消"
                               style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action){

                             }];

  [alertController addAction:otherAction];

  UIAlertAction *sureAction = [UIAlertAction
      actionWithTitle:@"确定"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager fileExistsAtPath:Documentpath]) {
                  NSArray *childerFiles =
                      [fileManager subpathsAtPath:Documentpath];
                  for (NSString *fileName in childerFiles) {
                    NSString *absolutePath =
                        [Documentpath stringByAppendingPathComponent:fileName];
                    [fileManager removeItemAtPath:absolutePath error:nil];
                  }
                }
                if ([fileManager fileExistsAtPath:path]) {
                  NSArray *childerFiles = [fileManager subpathsAtPath:path];
                  for (NSString *fileName in childerFiles) {
                    //如有需要，加入条件，过滤掉不想删除的文件
                    if (![fileName isEqualToString:@"Preferences"] &&
                        ![fileName
                            isEqualToString:
                                @"Preferences/com.systop.Practice.plist"]) {
                      NSString *absolutePath =
                          [path stringByAppendingPathComponent:fileName];
                      [fileManager removeItemAtPath:absolutePath error:nil];
                    }
                  }
                }
                [_personalTableview reloadData];
              }];
  [alertController addAction:sureAction];
  [self presentViewController:alertController animated:YES completion:nil];
}
- (float)folderSizeAtPath:(NSString *)folderPath {
  NSFileManager *manager = [NSFileManager defaultManager];
  if (![manager fileExistsAtPath:folderPath])
    return 0;
  NSEnumerator *childFilesEnumerator =
      [[manager subpathsAtPath:folderPath] objectEnumerator];
  NSString *fileName;
  long long folderSize = 0;
  while ((fileName = [childFilesEnumerator nextObject]) != nil) {
    NSString *fileAbsolutePath =
        [folderPath stringByAppendingPathComponent:fileName];
    folderSize += [self fileSizeAtPath:fileAbsolutePath];
  }
  return folderSize / (1024.0 * 1024.0);
}
- (long long)fileSizeAtPath:(NSString *)filePath {
  NSFileManager *manager = [NSFileManager defaultManager];
  if ([manager fileExistsAtPath:filePath]) {
    return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
  }
  return 0;
}
@end
