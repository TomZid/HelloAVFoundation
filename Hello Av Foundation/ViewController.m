//
//  ViewController.m
//  Hello Av Foundation
//
//  Created by tom on 09/03/2018.
//  Copyright © 2018 TZ. All rights reserved.
//

#import "ViewController.h"
#import "TZCellTableViewCell.h"
#import "TZSpeechManager.h"

@interface ViewController () <AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) TZSpeechManager *sm;

@property (nonatomic, strong) TZCellTableViewCell *templateCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 20.0f, 0.0f);
    self.sm = [TZSpeechManager share];
    self.sm.speectSynthesizer.delegate = self;
    self.array = [NSMutableArray array];
    [self.sm speakContinuously];
    self.tableView.estimatedRowHeight = 0;

    self.templateCell = [TZCellTableViewCell new];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *id = indexPath.row % 2 ? @"rightCell" : @"leftCell";
    TZCellTableViewCell *cell = (TZCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:id forIndexPath:indexPath];
    cell.messageLabel.text = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.templateCell.textLabel.text = self.array[indexPath.row];
    CGSize size = [self.templateCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"size.height is: %f", size.height);
    return size.height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    C2 *cell = (C2 *)self.prototypeCell;
//    cell.t.text = [self.tableData objectAtIndex:indexPath.row];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    CGSize textViewSize = [cell.t sizeThatFits:CGSizeMake(cell.t.frame.size.width, FLT_MAX)];
//    CGFloat h = size.height + textViewSize.height;
//    h = h > 89 ? h : 89;  //89是图片显示的最低高度， 见xib
//    NSLog(@"h=%f", h);
//    return 1 + h;
//}

#pragma mark - AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    [self.array addObject:utterance.speechString];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.array.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
