//
//  ViewController.h
//  fotoTouch
//
//  Created by BridgeLabz on 26/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    SystemSoundID mysound ;
}
- (IBAction)addButtonPressed:(id)sender;


@end

