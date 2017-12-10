//
//  SettingsViewController.h
//  Alvin iOS
//
//  Created by Max on 10.12.17.
//  Copyright © 2017 Dynamic Devices AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *myName;
@property (nonatomic, strong) IBOutlet UITextField *myEmailAddress;
@property (nonatomic, strong) IBOutlet UITextField *myBirthDate;
@property (nonatomic, strong) IBOutlet UILabel *myWeightKg;
@property (nonatomic, strong) IBOutlet UILabel *myHeightCm;
@property (nonatomic, strong) IBOutlet UISlider *myHeightSlider;
@property (nonatomic, strong) IBOutlet UISlider *myWeightSlider;

- (IBAction) storeSettings:(id)sender;
- (IBAction) heightSliderValueChanged:(id)sender;
- (IBAction) weightSliderValueChanged:(id)sender;

@end

