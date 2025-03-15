#include <Foundation/Foundation.h>
#include <CoreServices/CoreServices.h>

#include <signal.h>
#include <stdio.h>

void signal_handler(int signal) {
    CFRunLoopStop(CFRunLoopGetMain());
}

void callback(ConstFSEventStreamRef streamRef, 
              void *clientCallBackInfo,
              size_t numEvents,
              void *eventPaths,
              const FSEventStreamEventFlags *eventFlags,
              const FSEventStreamEventId *eventIds) {
    system("yabai --restart-service");
}

int main(int argc, char* argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            printf("Please supply watch directory path\n");
            return 1;
        }

        NSArray* watch_paths = @[
            [[NSString alloc] initWithCString:argv[1] 
                              encoding:NSUTF8StringEncoding]
        ];

        FSEventStreamRef stream = FSEventStreamCreate(
            kCFAllocatorDefault,
            callback,
            NULL,
            (__bridge CFArrayRef)watch_paths,
            kFSEventStreamEventIdSinceNow,
            0.5,
            0
        );

        dispatch_queue_t queue = dispatch_queue_create(
            "io.reeperto.yabaiwatch",
            DISPATCH_QUEUE_SERIAL
        );

        FSEventStreamSetDispatchQueue(stream, queue);
        FSEventStreamStart(stream);

        signal(SIGINT, signal_handler);
        CFRunLoopRun();
    }

    return 0;
}
