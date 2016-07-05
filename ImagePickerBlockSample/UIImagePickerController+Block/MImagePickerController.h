//
//  MImagePickerController.h
//  ImagePickerBlockSample
//
//  Created by mohit.kumar on 05/07/16.
//  Copyright © 2016 TIL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^successBlock) (UIImage *image);
typedef void (^failureBlock) (NSError *error);

@interface MImagePickerController : NSObject

// Set this property if you want to use inbuild editing. By default it is FALSE.
@property(nonatomic,assign) BOOL allowEditing;

/*!
 * @discussion Use this method if you want to fetch image using Camera instead of gallery.
 * @param completionBlock it will called when image fetched successfully. It will contains Image.
 * @param failureBlock Call in case of any error.
 */

-(void)pickImageFromCameraWithCompletionBlock:(successBlock)completionBlock andFailureBlock:(failureBlock)failureBlock;


/*!
 * @discussion Use this method if you want to fetch image using Gallery instead of Camera.
 * @param completionBlock it will called when image fetched successfully. It will contains Image.
 * @param failureBlock Call in case of any error.
 */

-(void)pickImageFromGalleryWithCompletionBlock:(successBlock)completionBlock andFailureBlock:(failureBlock)failureBlock;


@end
