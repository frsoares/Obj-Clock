//
//  ServiceProvider.m
//  Obj-ClockTopShelf
//
//  Created by Francisco Soares on 22/08/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

#import "ServiceProvider.h"
#import <UIKit/UIKit.h>

@interface ServiceProvider ()

- (UIImage*) loadImageFromView:(UIView*)view;
- (NSURL*) saveImage:(UIImage*)image;
- (UIView*) makeViewFromString:(NSString*)string;


@end

@implementation ServiceProvider


- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - TVTopShelfProvider protocol

- (TVTopShelfContentStyle)topShelfStyle {
    // Return desired Top Shelf style.
    return TVTopShelfContentStyleSectioned;
}

- (NSArray *)topShelfItems {
    
    TVContentIdentifier* wrapperID = [[TVContentIdentifier alloc] initWithIdentifier:@"wrapper" container:nil];
    TVContentItem* wrapperItem = [[TVContentItem alloc] initWithContentIdentifier:wrapperID];
    
    
    
    NSDate* date = [NSDate new];
    NSDateFormatter* df = [NSDateFormatter new];
    df.dateFormat = @"HH'h'mm";
    NSString* stringDate = [df stringFromDate:date];
    TVContentIdentifier* tvcid = [[TVContentIdentifier alloc] initWithIdentifier:@"Teste" container:wrapperID];
    TVContentItem* tvcItem = [[TVContentItem alloc] initWithContentIdentifier:tvcid];
    tvcItem.title = stringDate;
    tvcItem.imageShape = TVContentItemImageShapeSquare;
    
    // creating the item's image
    UIView* view = [self makeViewFromString:stringDate];
    UIImage* image = [self loadImageFromView:view];
    NSURL* imageUrl = [self saveImage:image];
    
    [tvcItem setImageURL:imageUrl forTraits:TVContentItemImageTraitScreenScale1x];
    
    tvcItem.displayURL = [NSURL URLWithString:@"oclock://teste"];
    tvcItem.playURL = tvcItem.displayURL;
    
    wrapperItem.title = stringDate;
    wrapperItem.topShelfItems = @[tvcItem];
    
    return @[wrapperItem];
}

- (UIImage*) loadImageFromView:(UIView *)view {
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (NSURL*) saveImage:(UIImage *)image {
    
    NSURL* url = [[[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[NSUUID new].UUIDString] URLByAppendingPathExtension:@"png"];
    
    NSData* data = UIImagePNGRepresentation(image);
    if (data != nil) {
        // Ignoring errors and if it finished. Should be treated ideally
        [data writeToURL:url options:0 error:nil];
    }
    
    return url;
    
}

-(UIView*) makeViewFromString:(NSString *)string{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 608, 608)];
    view.backgroundColor = UIColor.whiteColor;
    
    UILabel* lb = [[UILabel alloc] initWithFrame:CGRectMake(18, 304-200, 590, 400)];
    
    lb.font = [UIFont boldSystemFontOfSize:150];
    lb.text = string;
    lb.textColor = UIColor.blackColor;
    lb.backgroundColor = UIColor.clearColor;
    
    [view addSubview:lb];
    return view;
}


@end
