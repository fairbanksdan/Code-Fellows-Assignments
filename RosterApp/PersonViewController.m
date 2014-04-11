//
//  PersonViewController.m
//  RosterAppDay2
//
//  Created by Daniel Fairbanks on 4/8/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//

#import "PersonViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Person.h"
#import "DataController.h"

@interface PersonViewController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActivityItemSource>

@property (strong,nonatomic) UIActionSheet *myActionSheet;
@property (weak, nonatomic) IBOutlet UIImageView *HeadShot;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *githubTextField;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;

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
    self.nameTextField.delegate = self;
    self.githubTextField.delegate = self;
    self.twitterTextField.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.nameTextField.text = [NSString stringWithFormat:@"%@ %@", self.selectedPerson.firstName, self.selectedPerson.lastName];
    self.githubTextField.text = self.selectedPerson.github;
    self.twitterTextField.text = self.selectedPerson.twitter;
    
    if (_selectedPerson.headShot) {
        self.HeadShot.image = self.selectedPerson.headShot;
    }
        _HeadShot.layer.cornerRadius = _HeadShot.frame.size.width/2.0;
        _HeadShot.layer.masksToBounds = YES;
        
       
        [_HeadShot setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPicture:)];
        [_HeadShot addGestureRecognizer:tapImage];
        self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        
    }

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.selectedPerson.firstName = [[_nameTextField.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] firstObject];
    self.selectedPerson.lastName = [[_nameTextField.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lastObject];
    self.selectedPerson.github = _githubTextField.text;
    self.selectedPerson.twitter = _twitterTextField.text;
    
    [[DataController sharedData] save];
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
    _HeadShot.image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    _HeadShot.layer.cornerRadius = _HeadShot.frame.size.width/2.0;
    _HeadShot.layer.masksToBounds = YES;
    self.selectedPerson.headShot = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Completed");
        
        ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new];
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
            [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIControl *control in self.scrollView.subviews) {
        if ([control isKindOfClass:[UITextField class]]) {
            [control endEditing:YES];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - 200) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(IBAction)sharedPhoto:(id)sender
{
    UIActivityViewController *sharePhotoVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.selectedPerson.headShot] applicationActivities:nil];
    
    [self presentViewController:sharePhotoVC animated:YES completion:nil];
    
   
}
@end
