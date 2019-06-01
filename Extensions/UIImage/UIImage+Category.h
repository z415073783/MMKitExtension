//
//  UIImage+Category.h
//  Odin-UC
//
//  Created by zlm on 2017/8/15.
//  Copyright © 2017年 yealing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
- (UIImage *)imageGrayTranslate;
- (UIImage *)addFilter:(NSString *)filterName;
@end
