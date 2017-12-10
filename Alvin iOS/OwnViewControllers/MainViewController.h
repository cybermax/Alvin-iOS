//
//  ViewController.h
//  Alvin iOS
//
//  Created by Max on 06.12.17.
//  Copyright © 2017 Dynamic Devices AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"

@interface MainViewController : UIViewController <QRCodeReaderDelegate, UITextFieldDelegate>

- (IBAction) scanAction:(id)sender;

@end

