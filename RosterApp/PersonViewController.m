//
//  PersonViewController.m
//  RosterAppDay2
//
//  Created by Daniel Fairbanks on 4/8/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "PersonViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PersonViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) UIActionSheet *myActionSheet;
@property (weak, nonatomic) IBOutlet UIImageView *HeadShot;

@end

@implementation PersonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)findPicture:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.myActionSheet = [[UIActionSheet alloc] initWithTitle:@"Photos" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:@"Take Photo",@"Choose Photo", nil];
        
    }
    
    else {
        
        self.myActionSheet  = [[UIActionSheet alloc] initWithTitle:@"Photos" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:@"Choose Photo", nil];
    }
    
    
    
    
    [self.myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Take Photo"]) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Choose Photo" ]) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    } else {
        
        return;
        
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _HeadShot.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Completed");
        
        ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new];
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
            [assetsLibrary writeImageToSavedPhotosAlbum:originalImage.CGImage
                                            orientation:ALAssetOrientationUp
                                        completionBlock:^(NSURL *assetURL, NSError *error) {
                                            if (error) {
                                                NSLog(@"Error Saving Image: %@", error.localizedDescription);
                                            }
                                        }];
        } else if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot Save Photo"
                                                                message:@"Denied access without authorization"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        } else {
            NSLog(@"Authorization Not Determined");
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
