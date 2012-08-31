//
//  DataHelper.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/19/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper


+(NSDictionary*)ReadPlist:(NSString*)fileName
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    plistPath = [path stringByAppendingPathComponent:fileName];
                           
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    }
   
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *Data = (NSDictionary *)[NSPropertyListSerialization
                                               propertyListFromData:plistXML
                                               mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                               format:&format
                                               errorDescription:&errorDesc];
    if (!Data) {
        NSLog(@"Error reading plist: %@ %@, format: %d", fileName,errorDesc, format);
    }
    return Data;
}

@end


