//
//  main.m
//  AppLauncher
//
//  Created by Jovi on 9/1/24.
//

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) {
    if (argc < 2) {
        return -1;
    }
    
    const char *pszURL = argv[1];
    NSString *appURLString = [NSString stringWithUTF8String:pszURL];
    NSString *newInstanceKeyString = nil;
    NSString *newInstanceValueString = nil;
    NSString *rootKeyString = nil;
    
    if (argc > 3) {
        const char *pszNewInstanceKey = argv[2];
        const char *pszNewInstanceValue = argv[3];
        newInstanceKeyString = [NSString stringWithUTF8String:pszNewInstanceKey];
        newInstanceValueString = [NSString stringWithUTF8String:pszNewInstanceValue];
    }
    
    if (argc > 4) {
        const char *pszRootKey = argv[4];
        rootKeyString = [NSString stringWithUTF8String:pszRootKey];
    }
    
    BOOL newInstance = NO;
    BOOL root = NO;
    
    if ([newInstanceKeyString isEqualToString:@"-new"] && [newInstanceValueString isEqualToString:@"true"]) {
        newInstance = YES;
    }
    
    if ([rootKeyString isEqualToString:@"-root"]) {
        root = YES;
    }
    
    if (root) {
        NSBundle *appBundle = [NSBundle bundleWithPath: appURLString];
        NSURL *url = [appBundle executableURL];
        NSString *cmd = [NSString stringWithFormat:@"'%@' &", [[url path] stringByReplacingOccurrencesOfString:@"'" withString:@"'\"'\"'"]];

        int status = system([cmd UTF8String]);
        
        if (WIFEXITED(status)) {
            int exitStatus = WEXITSTATUS(status);
            
            if (exitStatus == 0) {
                status = 0;
            } else {
                status = exitStatus;
            }
        }
        
        return status;
    } else {
        NSWorkspaceLaunchOptions option = 0;
        if (newInstance) {
            option = NSWorkspaceLaunchNewInstance;
        }
        NSError *error = nil;
        [[NSWorkspace sharedWorkspace] launchApplicationAtURL:[NSURL fileURLWithPath:appURLString] options:option configuration:@{} error:&error];
        
        if (nil != error) {
            return (int)[error code];
        }
    }

    return 0;
}
