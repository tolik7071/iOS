//
//  ThingsDocument.m
//  MyStuff
//
//  Created by Anatoliy Goodz on 10/28/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ThingsDocument.h"
#import "MyWhatsit.h"

@implementation ThingsDocument

+ (ThingsDocument *)documentAtURL:(NSURL *)url
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    ThingsDocument *document = [[ThingsDocument alloc] initWithFileURL:url];
    
    if ([fileManager fileExistsAtPath:[url path]])
    {
        [document openWithCompletionHandler:nil];
    }
    else
    {
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:nil];
    }
 
    return document;
}

- (NSString *)thingsDocumentName
{
    if (_thingsDocumentName == nil)
    {
        _thingsDocumentName = @"Things I Own.mystuff";
    }
    
    return _thingsDocumentName;
}

- (NSURL *)documentURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *documentsDirURL = [fileManager
        URLForDirectory:NSDocumentDirectory
        inDomain:NSUserDomainMask
        appropriateForURL:nil
        create:YES
        error:nil];
    
    return documentsDirURL;
}

- (NSString *)thingsPreferredName
{
    return @"things.data";
}

- (NSString *)imagePreferredName
{
    return @"image.png";
}

- (NSFileWrapper *)docWrapper
{
    if (_fileWrapper == nil)
    {
        _fileWrapper = [[NSFileWrapper alloc] initDirectoryWithFileWrappers:@{}];
    }
    
    return _fileWrapper;
}

- (NSMutableArray<MyWhatsit *> *)things
{
    if (_things == nil)
    {
        _things = [NSMutableArray new];
    }
    
    return _things;
}

- (nullable id)contentsForType:(NSString *)typeName error:(NSError **)outError
{
    NSFileWrapper *wrapper = [self docWrapper].fileWrappers[[self thingsPreferredName]];
    if (wrapper != nil)
    {
        [[self docWrapper] removeFileWrapper:wrapper];
    }
    
    NSData *thingsData = [NSKeyedArchiver archivedDataWithRootObject:self.things];
    [[self docWrapper] addRegularFileWithContents:thingsData preferredFilename:[self thingsPreferredName]];
    
    return [self docWrapper];
}

- (BOOL)loadFromContents:(id)contents
                  ofType:(NSString *)typeName
                   error:(NSError * _Nullable __autoreleasing *)outError
{
    BOOL result = NO;
    
    if ([contents isKindOfClass:[NSFileWrapper class]])
    {
        NSFileWrapper *contentWrapper = (NSFileWrapper *)contents;
        NSFileWrapper *thingsWrapper = contentWrapper.fileWrappers[[self thingsPreferredName]];
        
        NSData *data = thingsWrapper.regularFileContents;
        if (data != nil)
        {
            NSArray<MyWhatsit *> *things = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            for(MyWhatsit *thing in things)
            {
//                [thing imageStorage] = self;
            }
            
            _fileWrapper = contentWrapper;
            result = YES;
        }
    }
    
    return result;
}

@end
