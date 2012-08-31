//
//  InstanceTemplateManager.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/18/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instance.h"

@interface InstanceTemplateManager : NSObject
{
    NSMutableDictionary* m_instanceTemplates;
}

@property (nonatomic, retain) NSMutableDictionary* m_instanceTemplates;

+(InstanceTemplateManager*)sharedInstanceTemplateManager;

-(Instance*)LoadInstanceFromTemplatePath:(NSString*)templatePath;
-(Instance*)InitInstaceFromTemplate:(NSDictionary*)templateData;

@end
