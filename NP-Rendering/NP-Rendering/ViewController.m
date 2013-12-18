//
//  ViewController.m
//  NP-Rendering
//
//  Created by Elvin Jin on 18/12/13.
//  Copyright (c) 2013 Elvin Jin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImage *originalImage;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoFromAlbum:(id)sender
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

- (IBAction)photoFromCamera:(id)sender
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

- (IBAction)applyImageFilter:(id)sender
{
}

- (IBAction)saveImageToAlbum:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.selectedImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.saveButton.enabled = YES;
    self.filterButton.enabled = YES;
    originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.selectedImageView setImage:originalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    if(!error)
    {
        alertTitle   = @"Image Saved";
        alertMessage = @"Image saved to photo album successfully.";
    }
    else
    {
        alertTitle   = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
