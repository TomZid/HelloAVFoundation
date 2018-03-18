//
//  UITableView+layoutCell.m
//  Hello Av Foundation
//
//  Created by tom on 13/03/2018.
//  Copyright © 2018 TZ. All rights reserved.
//

#import "UITableView+layoutCell.h"
#import <objc/runtime.h>

@implementation UITableView (layoutCell)
- (UITableViewCell*)tz_cellForReuseIdentifier:(NSString*)identifier {
    NSParameterAssert(identifier.length > 0);
    NSMutableDictionary<NSString*, UITableViewCell*> *templateCellWithIdentifier = objc_getAssociatedObject(self, _cmd);
    if (nil == templateCellWithIdentifier) {
        templateCellWithIdentifier = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellWithIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UITableViewCell *cell = templateCellWithIdentifier[identifier];
    if (nil == cell) {
        cell = [self dequeueReusableCellWithIdentifier:identifier];
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellWithIdentifier[identifier] = cell;
    }
    return cell;
}

- (CGFloat)tz_heightForCellWithIdentifier:(NSString*)identifier configuration:(void(^)(UITableViewCell *cell))configuration {
    if (nil == identifier) {
        return 0;
    }
    UITableViewCell *cell = [self tz_cellForReuseIdentifier:identifier];
    if (configuration) {
        configuration(cell);
    }
    
    return [self tz_systemFittingHeightForConfigurationCell:cell];
}

- (CGFloat)tz_systemFittingHeightForConfigurationCell:(UITableViewCell*)cell {
    CGFloat height = 0;
    height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    if (height == 0) {
        height = [cell sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0)].height;
    }
    if (height == 0) {
        height = 44;
    }
    NSLog(@"height is: %f", height);
    return height;
}

@end
