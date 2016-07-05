//
//  ViewController.m
//  ImagePickerBlockSample
//
//  Created by mohit.kumar on 05/07/16.
//  Copyright © 2016 TIL. All rights reserved.
//

#import "ViewController.h"
#import "MImagePickerController.h"
@interface ViewController ()
{

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pickFromGallery:(id)sender {
    
    MImagePickerController *controller = [[MImagePickerController alloc] init];
    controller.allowEditing = YES;
    [controller pickImageFromGalleryWithCompletionBlock:^(UIImage *image) {
        _imageView.image = image;
    } andFailureBlock:^(NSError *error) {
        
    }];
}
- (IBAction)pickFromCamera:(id)sender {
    MImagePickerController *controller = [[MImagePickerController alloc] init];
    [controller pickImageFromCameraWithCompletionBlock:^(UIImage *image) {
        _imageView.image = image;
    } andFailureBlock:^(NSError *error) {
        
    }];
}

@end
