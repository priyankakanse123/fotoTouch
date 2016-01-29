//
//  ViewController.m
//  fotoTouch
//
//  Created by BridgeLabz on 26/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AudioServicesDisposeSystemSoundID(mysound);
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *soundURL=[[NSBundle mainBundle]URLForResource:@"click" withExtension:@"aiff"];
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundURL, &mysound);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addButtonPressed:(id)sender
{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:NULL];
    NSLog(@"Button Pressed");

}
-(void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint newPoint = [gestureRecognizer locationInView:[self view]];
    [[self view]bringSubviewToFront:[gestureRecognizer view]];

    [ [gestureRecognizer view]setCenter:newPoint];
                        
}
-(void)tapGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    [[self view]bringSubviewToFront:[gestureRecognizer view]];
    [UIView animateWithDuration:0.2 animations:^{
        [[gestureRecognizer view] setBounds:CGRectMake(0, 0, 100, 100)];
                                                } completion:^(BOOL finished)
        {
        [UIView animateWithDuration:0.2 animations:^{
            [[gestureRecognizer view] setBounds:CGRectMake(0, 0, 80, 80)];
          
        }];
        
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage ];
    UIImageView *newImage=[[UIImageView alloc]initWithImage:image];
    //[newImage setFrame:CGRectMake(arc4random_uniform(240),arc4random_uniform(360), 80, 80)];
    //[[self view]addSubview:newImage];
    [newImage setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *gestureRecognize =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    //[newImage addGestureRecognizer:gestureRecognize];
    [newImage addGestureRecognizer:gestureRecognize];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognized:)];
    [newImage addGestureRecognizer:tapGestureRecognizer];
    [self dismissViewControllerAnimated:YES completion:^{
        AudioServicesPlaySystemSound(mysound);
        
        [[self view]addSubview:newImage];
        
        [UIView animateWithDuration:0.2 animations:^{
            [newImage setFrame:CGRectMake(arc4random_uniform(240), arc4random_uniform(360), 90, 90)];
            [newImage setAlpha:1.0];
            }];
    }];
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
