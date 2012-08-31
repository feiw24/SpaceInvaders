//
//  InputManager.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "InputManager.h"

#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButtonSkinnedBase.h"
#import "DataHelper.h"

@implementation InputManager

@synthesize m_leftJoystick, m_rightButton;

static NSString* UISettingPath = @"UISetting.plist";

static InputManager *DefaultManager = nil;

+ (InputManager *)sharedInputManager {
    
    if (!DefaultManager) DefaultManager = [[self allocWithZone:NULL] init];
    
    return DefaultManager;
    
}

-(void)InitInput:(CCLayer*)layer
{
    NSDictionary* UISetting = [DataHelper ReadPlist:UISettingPath];
    if(UISetting)
    {
        SneakyJoystickSkinnedBase *leftJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        float posX = [[UISetting objectForKey:@"LeftStickPosX"] floatValue];
        float posY = [[UISetting objectForKey:@"LeftStickPosY"] floatValue];
        leftJoy.position = ccp(posX,posY);
        
        // Sprite that will act as the outter circle. Make this the same width as joystick.
        NSString* bgFile = [UISetting objectForKey:@"LeftStickBackgroundImage"];
        leftJoy.backgroundSprite = [CCSprite spriteWithFile:bgFile];
        leftJoy.backgroundSprite.opacity = [[UISetting objectForKey:@"LeftStickBackgroundImageOpacity"] floatValue];
        leftJoy.backgroundSprite.scale = [[UISetting objectForKey:@"LeftStickBackgroundImageScale"] floatValue];
        // Sprite that will act as the actual Joystick. Definitely make this smaller than outer circle.
        NSString* thumbFile = [UISetting objectForKey:@"LeftStickImage"];
        leftJoy.thumbSprite = [CCSprite spriteWithFile:thumbFile];
        leftJoy.thumbSprite.opacity =  [[UISetting objectForKey:@"LeftStickImageOpacity"] floatValue];
        
        float sizeX = [[UISetting objectForKey:@"LeftStickSizeX"] floatValue];
        float sizeY = [[UISetting objectForKey:@"LeftStickSizeY"] floatValue];
        leftJoy.joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,sizeX,sizeY)];
        m_leftJoystick = leftJoy.joystick;
        [layer addChild:leftJoy];
        
        
        SneakyButtonSkinnedBase *rightBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        posX = [[UISetting objectForKey:@"RightButtonPosX"] floatValue];
        posY = [[UISetting objectForKey:@"RightButtonPosY"] floatValue];
        rightBut.position = ccp(posX,posY);
        NSString* buttonFile = [UISetting objectForKey:@"RightButtonImage"];
        rightBut.defaultSprite =  [CCSprite spriteWithFile:buttonFile];
        rightBut.defaultSprite.opacity = [[UISetting objectForKey:@"RightButtonOpacity"] floatValue];
        rightBut.activatedSprite = [CCSprite spriteWithFile:buttonFile];
        rightBut.activatedSprite.opacity = [[UISetting objectForKey:@"RightButtonActivateOpacity"] floatValue];
        rightBut.pressSprite = [CCSprite spriteWithFile:buttonFile];
        rightBut.pressSprite.opacity = [[UISetting objectForKey:@"RightButtonPressOpacity"] floatValue];
        sizeX = [[UISetting objectForKey:@"RightButtonSizeX"] floatValue];
        sizeY = [[UISetting objectForKey:@"RightButtonSizeY"] floatValue];
        rightBut.button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, sizeX, sizeY)];
        
        m_rightButton = rightBut.button;
    
        [layer addChild:rightBut];
    }
   
}



@end
