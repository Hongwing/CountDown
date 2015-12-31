//
//  ViewController.h
//  DemoWithBackwardTimer
//
//  Created by lister on 15/12/31.
//  Copyright (c) 2015年 hongwing.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *buttonToConfirm;
@property (strong, nonatomic) IBOutlet UILabel *labelToDisplay;
@property (strong, nonatomic) IBOutlet UIPickerView *datePicker;


@end

