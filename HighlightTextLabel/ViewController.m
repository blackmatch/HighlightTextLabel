//
//  ViewController.m
//  HighlightTextLabel
//
//  Created by blackmatch on 2017/2/22.
//  Copyright © 2017年 blackmatch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *strs;

@end

@implementation ViewController

- (NSMutableArray *)strs {
    if (!_strs) {
        _strs = [NSMutableArray array];
    }
    
    return _strs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender {
    [self checkSearchInput];
}

- (void)checkSearchInput {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入有误" message:@"搜索内容不能为空" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:okAction];
    
    
    if (self.searchTextField.text.length < 1) {
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        [self doSearch];
    }
}

- (void)doSearch {
    NSString *keyword = self.searchTextField.text;
    
    [self.strs removeAllObjects];
    for (NSInteger i = 0; i < 20; i++) {
        NSInteger rdn = arc4random() % 3;
        
        NSString *str = nil;
        if (rdn == 0) {
            str = [NSString stringWithFormat:@"%@找到你了", keyword];
        } else {
            str = @"没有找到";
        }
        
        [self.strs addObject:str];
    }
    
    [self.tableView reloadData];
}

- (NSAttributedString *)highlightText:(NSString *)keyword inStr:(NSString *)str {
    NSRange range = [str rangeOfString:keyword];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    if (range.length > 0) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
    } else {
        
    }
    
    return [[NSAttributedString alloc]initWithAttributedString:attrStr];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.strs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [self.strs objectAtIndex:indexPath.row];
    cell.textLabel.attributedText = [self highlightText:self.searchTextField.text inStr:str];
}

@end
