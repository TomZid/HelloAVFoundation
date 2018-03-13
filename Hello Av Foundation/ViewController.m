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
#import "UITableView+layoutCell.h"

static inline NSString *cellIdentifierForReuse(NSIndexPath *indexPath) {
    return indexPath.row % 2 ? @"rightCell" : @"leftCell";
}

@interface ViewController () <AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) TZSpeechManager *sm;
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
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TZCellTableViewCell *cell = (TZCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierForReuse(indexPath) forIndexPath:indexPath];
    cell.messageLabel.text = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView tz_heightForCellWithIdentifier:cellIdentifierForReuse(indexPath) configuration:^(UITableViewCell *cell) {
        TZCellTableViewCell *c = (TZCellTableViewCell *)cell;
        c.messageLabel.text = self.array[indexPath.row];
    }];
}

#pragma mark - AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    [self.array addObject:utterance.speechString];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.array.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
