//
//  GameViewController.h
//  Squid
//

//  Copyright (c) 2015 Team C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface GameViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) UIImagePickerController *imagePickerController;

- (void)showCamera;

@end
