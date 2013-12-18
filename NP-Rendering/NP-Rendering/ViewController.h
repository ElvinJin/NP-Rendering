//
//  ViewController.h
//  NP-Rendering
//
//  Created by Elvin Jin on 18/12/13.
//  Copyright (c) 2013 Elvin Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;

- (IBAction)photoFromAlbum:(id)sender;
- (IBAction)photoFromCamera:(id)sender;
- (IBAction)applyImageFilter:(id)sender;
- (IBAction)saveImageToAlbum:(id)sender;

@end
