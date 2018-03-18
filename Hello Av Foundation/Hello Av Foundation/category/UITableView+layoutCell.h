//
//  UITableView+layoutCell.h
//  Hello Av Foundation
//
//  Created by tom on 13/03/2018.
//  Copyright © 2018 TZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (layoutCell)
- (CGFloat)tz_heightForCellWithIdentifier:(NSString*)identifier
                            configuration:(void(^)(UITableViewCell *cell))configuration;
@end
