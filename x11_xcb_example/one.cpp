// example.cpp
#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <iostream>

int main()
{
   Display* display = XOpenDisplay(NULL);
   Window window = XCreateSimpleWindow(display,
                                       DefaultRootWindow(display),
                                       0, 0,
                                       500, 400,
                                       0,
                                       0, 0);

   XMapWindow(display, window);
   // register interest in the delete window message
   Atom wmDeleteMessage = XInternAtom(display, "WM_DELETE_WINDOW", False);
   XSetWMProtocols(display, window, &wmDeleteMessage, 1);

   std::cout << "Starting up..." << std::endl;

   while (true) {
      XEvent event;
      XNextEvent(display, &event);

      if (event.type == ClientMessage &&
          event.xclient.data.l[0] == wmDeleteMessage) {
         std::cout << "Shutting down now!!!" << std::endl;
      }
   }

   XCloseDisplay(display);
   return 0;
}
