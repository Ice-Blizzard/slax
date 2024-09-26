# slax
Slax Linux Patch
Slax Linux iso: http://ftp.sh.cvut.cz/slax/Slax-15.x/slax-64bit-15.0.0.iso
Scipt works for bootable pendrive with Slax (need at least 8GB).

Script does the following:

1 System update.
a) Using the information from the /var/log/packages directory, downloads the patches of those packages that are installed in the system, skips the rest. Adds Firefox package, but does not update the system kernel.
b) Installs patches.
c) Saves the downloaded packages in the /root/patches/ directory.
d) Using the persistent changes mechanism, records the changes entered in the system.

2
Changes timezone to Europe/Warsaw.

3 Guest + deletion of Chrome.
a) Deletes a guest user.
b) Adds user as a new user.
c) Removes the entry for chrome from the desktop menu that appears when pressed right mouse button.
d) Removes the entry for chrome from the desktop menu that appears when pressed green icon on the taskbar.
e) Using the persistent changes mechanism, records the changes entered in the system.

4 Installing QCL.
a) From the site http://tph.tuwien.ac.at/~oemer/tgz/qcl-0.6.7.tgz downloads sources.
b) Changes MAKEFILE to enable compilation.
c) Compiles qcl.
d) Packs the qcl into a Slax package and places it in the appropriate directory on pendrive so that it loads when the system starts.
e) Deletes qcl sources.
