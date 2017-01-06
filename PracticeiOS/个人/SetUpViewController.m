//
//  SetUpViewController.m
//  PracticeiOS
//
//  Created by 新龙信息 on 16/12/20.
//  Copyright © 2016年 新龙信息. All rights reserved.
//

#import "SetUpViewController.h"
#import "JPUSHService.h"

@interface SetUpViewController () <UITableViewDelegate, UITableViewDataSource> {
  UITableView *SetupTableview;
}
@end

@implementation SetUpViewController
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self tabBarHidden];
}
- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self tabBarShow];
}
- (NSArray *)titleArray {
  if (_titleArray == nil) {
    _titleArray = [[NSArray alloc]
        initWithObjects:@"清除缓存", @"修改密码", @"退出登录", nil];
  }
  return _titleArray;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNavigationHeadBackImage];
  [self addtitleWithString:@"设置"];
  [self addBackButton];
  [self CreatUI];
}
#pragma mark 布局
- (void)CreatUI {
  SetupTableview = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)
              style:UITableViewStyleGrouped];
  SetupTableview.delegate = self;
  SetupTableview.dataSource = self;
  [self.view addSubview:SetupTableview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SetUpTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (indexPath.section == 0) {
    if (cell == nil) {
      cell = [[NSBundle mainBundle] loadNibNamed:@"SetUpTableViewCell"
                                           owner:nil
                                         options:nil][0];
    }
    cell.title.text = _titleArray[indexPath.section];
    cell.content.text = [self Cache];
  } else if (indexPath.section == 1) {
    if (cell == nil) {
      cell = [[NSBundle mainBundle] loadNibNamed:@"SetUpTableViewCell"
                                           owner:nil
                                         options:nil][0];
    }
    cell.title.text = _titleArray[indexPath.section];
    cell.content.hidden = YES;
  } else {
    if (cell == nil) {
      cell = [[NSBundle mainBundle] loadNibNamed:@"SetUpTableViewCell"
                                           owner:nil
                                         options:nil][1];
    }
    cell.Cell2title.text = _titleArray[indexPath.section];
  }
  return cell;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    [self CacheClearing];
  } else if (indexPath.section == 1) {
    [self.navigationController
        pushViewController:[ChangeThePasswordViewController new]
                  animated:YES];
  } else {
    [self LogInOutData];
  }
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  if (section == 1) {
    return 1;
  } else {
    return 44;
  }
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
            [[NSUserDefaults standardUserDefaults]synchronize];
            
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
#pragma mark 缓存计算
- (NSString *)Cache {
  NSArray *Documentpaths = NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *Documentpath = [Documentpaths objectAtIndex:0];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                       NSUserDomainMask, YES);
  NSString *path = [paths objectAtIndex:0];
  NSString *str = [NSString
      stringWithFormat:@"%.2fM", [self folderSizeAtPath:path] +
                                     [self folderSizeAtPath:Documentpath]];
  return str;
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
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:Documentpath]) {
    NSArray *childerFiles = [fileManager subpathsAtPath:Documentpath];
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
              isEqualToString:@"Preferences/com.systop.Practice.plist"]) {
        NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:absolutePath error:nil];
      }
    }
  }
  [SetupTableview reloadData];
  KOMG(str);
}
@end
