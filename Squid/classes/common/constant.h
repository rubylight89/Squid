//
//  constant.h
//  Squid
//
//  Created by Duong Phan on 6/27/15.
//  Copyright (c) 2015 Team C. All rights reserved.
//

#ifndef Squid_constant_h
#define Squid_constant_h

static NSString* const kCameraAccessNotificationName = @"CameraAccessNotificationName";
static NSString* const kCameraCloseNotificationName = @"CameraClosedNotificationName";
static NSString* const kMonsterNode = @"monster";
static NSString* const kCameraNode = @"camera_buton";
static NSString* const kWeaponR = @"weapon_R";
static NSString* const kWeaponG = @"weapon_G";
static NSString* const kWeaponB = @"weapon_B";
static NSString* const kWeaponBlack = @"weapon_Black";

typedef enum{
    RED = 0,
    GREEN = 1,
    BLUE = 2,
    BLACK = 3
} COLOR_DECTION_RESULT;


#endif
