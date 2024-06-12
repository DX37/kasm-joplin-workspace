# kasm-joplin-workspace

I got bored. Here's Joplin workspace for Kasm, so Desktop app can act like it is web version.

![изображение](https://github.com/DX37/kasm-joplin-workspace/assets/12829428/670ddb14-36b9-4411-b787-73f3f693a82c)

Made this because there's networks, like corporate one, where's Kerberos or NTLM proxy don't work with Joplin, so you can install Desktop app, but you can't sync notes with anything but local storage.

## Using

Simply create workspace in Kasm, fill Docker Image with `ghcr.io/dx37/kasm-joplin-workspace:main` and Docker Registry with `https://ghcr.io` and you're set for downloading and running this workspace.

You can also fill other fiels like:

* Friendly Name as `Joplin`
* Description as `A note taking and to-do application with synchronization capabilities.`
* Thumbnail URL as Joplin's `https://joplinapp.org/images/Icon512.png`
* Categories as `Productivity`

Other necessary fields should be filled as you wish.
