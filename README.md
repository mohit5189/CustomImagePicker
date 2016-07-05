# CustomImagePicker

CustomImagePicker is a block based implementation of UIImagePickerController. Purpose of this library is to help developer to pick the image with minimum number of lines.

For implementation you need to import MImagePickerController:

#import "MImagePickerController.h"


Now call method as follows:

MImagePickerController *controller = [[MImagePickerController alloc] init];
controller.allowEditing = YES;
[controller pickImageFromGalleryWithCompletionBlock:^(UIImage *image) {
_imageView.image = image;
} andFailureBlock:^(NSError *error) {

}];
