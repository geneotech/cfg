/* gcc -o part4 `pkg-config --cflags --libs xi` part4.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/extensions/XInput2.h>

static void createheh(Display *dpy) {
    XIEventMask mask;

    mask.deviceid = XIAllMasterDevices;
    mask.mask_len = XIMaskLen(XI_RawMotion);
	mask.mask = (unsigned char*)calloc(mask.mask_len, sizeof(char));

    mask.deviceid = XIAllDevices;
    memset(mask.mask, 0, mask.mask_len);
    XISetMask(mask.mask, XI_RawMotion);

    XISelectEvents(dpy, DefaultRootWindow(dpy), &mask, 1);

    free(mask.mask);
    XSync(dpy, True);
}

static void print_rawmotion(XIRawEvent *event)
{
    int i;
    double *raw_valuator = event->raw_values,
           *valuator = event->valuators.values;

    printf("    device: %d (%d)\n", event->deviceid, event->sourceid);

    for (i = 0; i < event->valuators.mask_len * 8; i++)
    {
        if (XIMaskIsSet(event->valuators.mask, i))
        {
            printf("  valuator %d: %f\n", i, *valuator );
			printf("  raw_valuator %d: %f\n", i, *raw_valuator);
            valuator++;
            raw_valuator++;
        }
    }
}

int main (int , char **)
{
    Display *dpy;
    int xi_opcode, event, error;
	//Window win;
    XEvent ev;

    dpy = XOpenDisplay(NULL);

    if (!dpy) {
        fprintf(stderr, "Failed to open display.\n");
        return -1;
    }

    if (!XQueryExtension(dpy, "XInputExtension", &xi_opcode, &event, &error)) {
           printf("X Input extension not available.\n");
              return -1;
    }

	//win = create_win(dpy);

	createheh(dpy);
    while(1) {
        XGenericEventCookie *cookie = &ev.xcookie;

        XNextEvent(dpy, &ev);
        if (cookie->type != GenericEvent ||
            cookie->extension != xi_opcode ||
            !XGetEventData(dpy, cookie))
            continue;

        printf("EVENT TYPE %d\n", cookie->evtype);
        switch(cookie->evtype)
        {
            case XI_RawMotion:
			print_rawmotion((XIRawEvent*)cookie->data);
                break;
            default:
                break;
        }

        XFreeEventData(dpy, cookie);
    }

    XCloseDisplay(dpy);
    return 0;
}

