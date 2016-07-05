//
//  MImagePickerController.m
//  ImagePickerBlockSample
//
//  Created by mohit.kumar on 05/07/16.
//  Copyright © 2016 TIL. All rights reserved.
//

#import "MImagePickerController.h"
#import <objc/runtime.h>

static char completionBlockKey;
static char failureBlockKey;

@interface MImagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    MImagePickerController *controller;
}
@property(nonatomic,strong) successBlock completionBlock;
@property(nonatomic,strong) failureBlock failureBlock;

@end

@implementation MImagePickerController

-(void)pickImageFromCameraWithCompletionBlock:(successBlock)completionBlock andFailureBlock:(failureBlock)failureBlock{

    _completionBlock = completionBlock;
    _failureBlock = failureBlock;
    
    objc_setAssociatedObject(self, &completionBlockKey, completionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &failureBlockKey, failureBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
    UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Warning"
                                                  message:@"Device don't have camera"
                                                  preferredStyle:UIAlertControllerStyleAlert];

        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {

                                   }];
        
        [alertController addAction:okAction];
        
        [[self currentViewController] presentViewController:alertController animated:YES completion:nil];

        _failureBlock([NSError errorWithDomain:@"No Camera Found" code:101 userInfo:nil]);
        
    }else{
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = _allowEditing;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [[self currentViewController] presentViewController:picker animated:YES completion:NULL];

    }

    
}


-(void)pickImageFromGalleryWithCompletionBlock:(successBlock)completionBlock andFailureBlock:(failureBlock)failureBlock{

    _completionBlock = completionBlock;
    _failureBlock = failureBlock;

    objc_setAssociatedObject(completionBlock, &completionBlockKey, self, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(failureBlock, &failureBlockKey, self, OBJC_ASSOCIATION_RETAIN);

    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = _allowEditing;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [[self currentViewController] presentViewController:picker animated:YES completion:NULL];
    
}



#pragma mark - UIImagePickerController Delegate Methods -


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage;
    
    if (_allowEditing) {
         chosenImage= info[UIImagePickerControllerEditedImage];
    }else{
        chosenImage= info[UIImagePickerControllerOriginalImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    objc_removeAssociatedObjects(self);
    
    _completionBlock(chosenImage);
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    objc_removeAssociatedObjects(self);

    _failureBlock(([NSError errorWithDomain:@"Cancelled by user" code:100 userInfo:nil]));
    
}


// Get top root controller
-(id)currentViewController{
    UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
    
    id rootVC = mainWindow.rootViewController.presentedViewController;
    id currentVC;
    
    while (rootVC) {
        currentVC = rootVC;
        if ([currentVC isKindOfClass:[UIViewController class]]) {
            rootVC = [(UIViewController *)currentVC presentedViewController];
            
        }else if ([currentVC isKindOfClass:[UINavigationController class]]){
            rootVC = [(UINavigationController *)currentVC presentedViewController];
        }else if ([currentVC isKindOfClass:[UITabBarController class]]){
            rootVC = [(UITabBarController *)currentVC presentedViewController];
        }
        if (rootVC==nil) {
            return currentVC;
        }
    }
    
    
    return mainWindow.rootViewController;
    
}

@end
