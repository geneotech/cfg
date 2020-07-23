# Prepare app

- Set Split application binary to true
- Bump app version from 33 to 34 (in Player settings -> Other settings -> Identification -> **Bundle Version Code**)
- Set android:debuggable to false everywhere

# Test apk+obb setup

- At least on NVIDIA Shield, the obb folder is: /storage/self/primary/Android/obb
- Check **Bundle Version Code**, e.g. if it is 34 then:
	- adb push ./projectname.main.obb /storage/self/primary/Android/obb/com.package.name/main.34.com.package.name
		- if it doesn't work then do this:
		- let the app create the directory
		- upload the obb with different name
		- adb shell into the folder and manually mv it into the proper filename
