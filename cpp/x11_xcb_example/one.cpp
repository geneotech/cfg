#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <climits>

#include <X11/Xlib.h>
#include <X11/Xlib-xcb.h>

#include <xcb/xcb.h>

#include <GL/glx.h>
#include <GL/gl.h>

#define GLX_CONTEXT_MAJOR_VERSION_ARB       0x2091
#define GLX_CONTEXT_MINOR_VERSION_ARB       0x2092
typedef GLXContext (*glXCreateContextAttribsARBProc)(Display*, GLXFBConfig, GLXContext, Bool, const int*);

using namespace std;

GLfloat randfloat()
{
    return (GLfloat) rand() / (GLfloat) INT_MAX;
}

// Helper to check for extension string presence.  Adapted from:
//   http://www.opengl.org/resources/features/OGLextensions/
static bool isExtensionSupported(const char *extList, const char *extension)
{
    const char *start;
    const char *where, *terminator;

    /* Extension names should not have spaces. */
    where = strchr(extension, ' ');
    if (where || *extension == '\0')
        return false;

    /* It takes a bit of care to be fool-proof about parsing the
     OpenGL extensions string. Don't be fooled by sub-strings,
     etc. */
    for (start=extList;;)
    {
        where = strstr(start, extension);

        if (!where)
          break;

        terminator = where + strlen(extension);

        if ( where == start || *(where - 1) == ' ' )
          if ( *terminator == ' ' || *terminator == '\0' )
            return true;

        start = terminator;
    }

    return false;
}

void draw()
{
    glClearColor(randfloat(), randfloat(), randfloat(), 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
}

int main_loop(Display *display, xcb_connection_t *connection, xcb_window_t window, GLXDrawable drawable)
{
    int running = 1;
    while(running)
    {
        /* Wait for event */
        xcb_generic_event_t *event = xcb_wait_for_event(connection);
        if(!event)
        {
            fprintf(stderr, "i/o error in xcb_wait_for_event");
            return -1;
        }

        switch(event->response_type & ~0x80)
        {
            case XCB_KEY_PRESS:
                /* Quit on key press */
                //running = 0;
                //break;
            case XCB_EXPOSE:
                /* Handle expose event, draw and swap buffers */
                draw();
                glXSwapBuffers(display, drawable);
                break;
            default:
                break;
        }

        free(event);
    }

    return 0;
}

int setup_and_run(Display* display, xcb_connection_t *connection, int default_screen, xcb_screen_t *screen)
{
    int visualID = 0;

    // Get a matching FB config
    static int visual_attribs[] =
    {
        GLX_X_RENDERABLE    , True,
        GLX_DRAWABLE_TYPE   , GLX_WINDOW_BIT,
        GLX_RENDER_TYPE     , GLX_RGBA_BIT,
        GLX_X_VISUAL_TYPE   , GLX_TRUE_COLOR,
        GLX_RED_SIZE        , 8,
        GLX_GREEN_SIZE      , 8,
        GLX_BLUE_SIZE       , 8,
        GLX_ALPHA_SIZE      , 8,
        GLX_DEPTH_SIZE      , 24,
        GLX_STENCIL_SIZE    , 8,
        GLX_DOUBLEBUFFER    , True,
        //GLX_SAMPLE_BUFFERS  , 1,
        //GLX_SAMPLES         , 4,
        None
    };

    int glx_major, glx_minor;

    // FBConfigs were added in GLX version 1.3.
    if ( !glXQueryVersion( display, &glx_major, &glx_minor ) ||
         ( ( glx_major == 1 ) && ( glx_minor < 3 ) ) || ( glx_major < 1 ) )
    {
        printf("Invalid GLX version");
        return -1;
    }

    printf( "Getting matching framebuffer configs\n" );
    int fbcount;
    GLXFBConfig* fbc = glXChooseFBConfig(display, default_screen, visual_attribs, &fbcount);
    if (!fbc)
    {
        printf( "Failed to retrieve a framebuffer config\n" );
        return -1;
    }
    printf( "Found %d matching FB configs.\n", fbcount );

    // Pick the FB config/visual with the most samples per pixel
    printf( "Getting XVisualInfos\n" );
    int best_fbc = -1, worst_fbc = -1, best_num_samp = -1, worst_num_samp = 999;
    for (int i=0; i < fbcount; ++i)
    {
        XVisualInfo *vi = glXGetVisualFromFBConfig( display, fbc[i] );
        if ( vi )
        {
            int samp_buf, samples;
            glXGetFBConfigAttrib( display, fbc[i], GLX_SAMPLE_BUFFERS, &samp_buf );
            glXGetFBConfigAttrib( display, fbc[i], GLX_SAMPLES       , &samples  );

            printf( "  Matching fbconfig %d, visual ID 0x%2x: SAMPLE_BUFFERS = %d, SAMPLES = %d\n", i, vi -> visualid, samp_buf, samples );

            if ( best_fbc < 0 || samp_buf && samples > best_num_samp )
                visualID = vi->visualid, best_fbc = i, best_num_samp = samples;
            if ( worst_fbc < 0 || !samp_buf || samples < worst_num_samp )
                worst_fbc = i, worst_num_samp = samples;
        }
        XFree( vi );
    }

    /* Select framebuffer config and query visualID */
    printf( "Chose fbconfig: %d\n", best_fbc);
    GLXFBConfig fb_config = fbc[ best_fbc ];
    XFree( fbc );

    // Get the default screen's GLX extension list
    const char *glxExts = glXQueryExtensionsString( display, default_screen );

    // NOTE: It is not necessary to create or make current to a context before
    // calling glXGetProcAddressARB
    glXCreateContextAttribsARBProc glXCreateContextAttribsARB = 0;
    glXCreateContextAttribsARB = (glXCreateContextAttribsARBProc) glXGetProcAddressARB( (const GLubyte *) "glXCreateContextAttribsARB" );

    GLXContext context = 0;

    // Install an X error handler so the application won't exit if GL 3.0
    // context allocation fails.
    //
    // Note this error handler is global.  All display connections in all threads
    // of a process use the same error handler, so be sure to guard against other
    // threads issuing X commands while this code is running.
    //ctxErrorOccurred = false;
    //int (*oldHandler)(Display*, XErrorEvent*) =
    //    XSetErrorHandler(&ctxErrorHandler);

    // Check for the GLX_ARB_create_context extension string and the function.
    // If either is not present, use GLX 1.3 context creation method.
    if ( !isExtensionSupported( glxExts, "GLX_ARB_create_context" ) || !glXCreateContextAttribsARB )
    {
        printf( "glXCreateContextAttribsARB() not found ... using old-style GLX context\n" );
        context = glXCreateNewContext( display, fb_config, GLX_RGBA_TYPE, 0, True );
    }

    // If it does, try to get a GL 3.0 context!
    else
    {
        int context_attribs[] =
        {
            GLX_CONTEXT_MAJOR_VERSION_ARB, 4,
            GLX_CONTEXT_MINOR_VERSION_ARB, 3,
            //GLX_CONTEXT_FLAGS_ARB        , GLX_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB,
            None
        };

        printf( "Creating context\n" );
        context = glXCreateContextAttribsARB( display, fb_config, 0, True, context_attribs );

        // Sync to ensure any errors generated are processed.
        XSync( display, False );
        if ( context )
            printf( "Created GL %d.%d context\n", context_attribs[1], context_attribs[3] );

        else
        {
            // Couldn't create GL 3.0 context.  Fall back to old-style 2.x context.
            // When a context version below 3.0 is requested, implementations will
            // return the newest context version compatible with OpenGL versions less
            // than version 3.0.
            // GLX_CONTEXT_MAJOR_VERSION_ARB = 1
            context_attribs[1] = 1;
            // GLX_CONTEXT_MINOR_VERSION_ARB = 0
            context_attribs[3] = 0;

            printf( "Failed to create GL 3.0 context ... using old-style GLX context\n" );
            context = glXCreateContextAttribsARB( display, fb_config, 0, True, context_attribs );
        }
    }

    /* Create XID's for colormap and window */
    xcb_colormap_t colormap = xcb_generate_id(connection);
    xcb_window_t window = xcb_generate_id(connection);

    /* Create colormap */
    xcb_create_colormap(
        connection,
        XCB_COLORMAP_ALLOC_NONE,
        colormap,
        screen->root,
        visualID
    );

    /* Create window */
    uint32_t eventmask = XCB_EVENT_MASK_EXPOSURE | XCB_EVENT_MASK_KEY_PRESS;
    uint32_t valuelist[] = { eventmask, colormap, 0 };
    uint32_t valuemask = XCB_CW_EVENT_MASK | XCB_CW_COLORMAP;

    xcb_create_window(
        connection,
        XCB_COPY_FROM_PARENT,
        window,
        screen->root,
        0, 0,
        150, 150,
        0,
        XCB_WINDOW_CLASS_INPUT_OUTPUT,
        visualID,
        valuemask,
        valuelist
    );


    // NOTE: window must be mapped before glXMakeContextCurrent
    xcb_map_window(connection, window);

    /* Create GLX Window */
    GLXDrawable drawable = 0;
    GLXWindow glxwindow = glXCreateWindow( display, fb_config, window, 0 );

    if(!window)
    {
        xcb_destroy_window(connection, window);
        glXDestroyContext(display, context);

        fprintf(stderr, "glXDestroyContext failed\n");
        return -1;
    }

    drawable = glxwindow;

    /* make OpenGL context current */
    if(!glXMakeContextCurrent(display, drawable, drawable, context))
    {
        xcb_destroy_window(connection, window);
        glXDestroyContext(display, context);

        fprintf(stderr, "glXMakeContextCurrent failed\n");
        return -1;
    }

    /* run main loop */
    int retval = main_loop(display, connection, window, drawable);

    /* Cleanup */
    glXDestroyWindow(display, glxwindow);

    xcb_destroy_window(connection, window);

    glXDestroyContext(display, context);

    return retval;
}

int main(int argc, char* argv[])
{
    srand(time(NULL));
    Display *display;
    int default_screen;

    /* Open Xlib Display */
    display = XOpenDisplay(0);
    if(!display)
    {
        fprintf(stderr, "Can't open display\n");
        return -1;
    }

    default_screen = DefaultScreen(display);

    /* Get the XCB connection from the display */
    xcb_connection_t *connection =
        XGetXCBConnection(display);
    if(!connection)
    {
        XCloseDisplay(display);
        fprintf(stderr, "Can't get xcb connection from display\n");
        return -1;
    }

    /* Acquire event queue ownership */
    XSetEventQueueOwner(display, XCBOwnsEventQueue);

    /* Find XCB screen */
    xcb_screen_t *screen = 0;
    xcb_screen_iterator_t screen_iter =
        xcb_setup_roots_iterator(xcb_get_setup(connection));
    for(int screen_num = default_screen;
        screen_iter.rem && screen_num > 0;
        --screen_num, xcb_screen_next(&screen_iter));
    screen = screen_iter.data;

    /* Initialize window and OpenGL context, run main loop and deinitialize */
    int retval = setup_and_run(display, connection, default_screen, screen);

    /* Cleanup */
    XCloseDisplay(display);

    return retval;
}
