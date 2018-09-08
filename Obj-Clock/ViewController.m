//
//  ViewController.m
//  Obj-Clock
//
//  Created by Francisco Soares on 22/08/18.
//  Copyright © 2018 Francisco Soares. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    
    df.dateFormat = @"HH:mm:ss";
    
    self.timeLabel.text = [df stringFromDate:[NSDate new]];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        self.timeLabel.text = [df stringFromDate:[NSDate new]];
    
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Example of button pressing functions#

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches began");
    UITouch* touch = [touches anyObject];
    NSLog(@"%lf", touch!=nil?(touch.force):0.0);
    [super touchesBegan:touches withEvent:event];
}

- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    NSLog(@"presses began");
    UIPress* press = [presses anyObject];
    NSLog(@"%lf", press!=nil?press.force:0.0);
    

    for (UIPress* press in presses) {
        NSString* toPrint;
        switch (press.type){
            case UIPressTypePlayPause: {
                toPrint = @"pressed play";
                break;
            }
            case UIPressTypeSelect: {
                toPrint = @"pressed select";
                break;
            }
            case UIPressTypeUpArrow: {
                toPrint = @"pressed up";
                break;
            }
            default: toPrint = @"another button pressed";
        }
        NSLog(@"%@",toPrint);
    }
    
    [super pressesBegan:presses withEvent:event];
}

- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    NSLog(@"presses changed");
    UIPress* press = [presses anyObject];
    NSLog(@"%lf", press!=nil?press.force:0.0);
    [super pressesChanged:presses withEvent:event];
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    NSLog(@"presses ended");
    UIPress* press = [presses anyObject];
    NSLog(@"%lf", press!=nil?press.force:0.0);
    [super pressesEnded:presses withEvent:event];
}

// pressesCancelled is usually called when a gesture is identified by a gestureRecognizer, thus turning low-level button press recognition useless.
- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    NSLog(@"presses cancelled");
    UIPress* press = [presses anyObject];
    NSLog(@"%lf", press!=nil?press.force:0.0);
    [super pressesCancelled:presses withEvent:event];
}

@end
