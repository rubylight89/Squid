//
//  GameManager.h
//  Squid
//
//  Created by Duong Phan on 6/27/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameManager.h"

@interface GameManager : NSObject

@property (nonatomic, strong) UIImage *takingPhoto;
@property (nonatomic, strong) UIImage *takingPhoto2;
@property (nonatomic, strong) UIImage *takingPhoto3;
@property (nonatomic, strong) UIImage *takingPhoto4;

+(GameManager*)sharedManager;

@end
