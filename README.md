*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************

This shim review request is coming direct from the iPXE project.  The
EV code signing certificate is issued by DigiCert and owned by Fen
Systems Ltd.

*******************************************************************************
### What product or service is this for?
*******************************************************************************

This shim will be used to load [iPXE](https://ipxe.org)

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************

Many people have asked over the years for a version of iPXE that can
be run with Secure Boot enabled.  For example:

* https://forum.ipxe.org/showthread.php?tid=7533
* https://lists.ipxe.org/pipermail/ipxe-devel/2017-December/005921.html
* https://github.com/ipxe/ipxe/discussions/488

Enquiries have also been received from several large companies via the
vendor-support@ipxe.org address.

Some OEMs have also reported (in private communication) that the lack
of a Secure Boot signed iPXE is one of the reasons driving customers
to disable Secure Boot.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************

No distro is currently providing Secure Boot signed versions of iPXE.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Michael Brown
- Position: Lead developer/maintainer of iPXE
- Position: Managing Director, Fen Systems Ltd.
- Email address: mcb30@ipxe.org
- Email address: mbrown@fensystems.co.uk
- PGP key fingerprint: [`E00F AF4C 0698 C19B 6B25 32FC 0235 B10A 00EB 4450`](http://keyserver.ubuntu.com/pks/lookup?search=0x0235B10A00EB4450&fingerprint=on&op=index)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Geert Stappers
- Position: Contributor
- Email address: stappers@stappers.nl
- PGP key fingerprint: [`8A7F 208C 6D9E 7329 1657 414D 2135 D123 D8C1 9BEC`](http://keyserver.ubuntu.com/pks/lookup?search=0x2135D123D8C19BEC&fingerprint=on&op=index)

*******************************************************************************
### Were these binaries created from the 15.8 shim release tar?
Please create your shim binaries starting with the 15.8 shim release tar file: https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.8 and contains the appropriate gnu-efi source.

*******************************************************************************

Yes, these binaries were created from the `15.8` tag.

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************

https://github.com/ipxe/shim/tree/ipxe-15.8

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************

* [ipxe: Add documentation](https://github.com/ipxe/shim/commit/1b447b03)
* [ipxe: Allow next loader path to be derived from shim path](https://github.com/ipxe/shim/commit/97cee9b9)
* [ipxe: Add vendor SBAT data](https://github.com/ipxe/shim/commit/ff35d645)
* [ipxe: Set "ipxe.efi" as default loader binary name](https://github.com/ipxe/shim/commit/d34c065e)
* [ipxe: Use iPXE code-signing certificate as vendor certificate](https://github.com/ipxe/shim/commit/933ca6cf)
* [ipxe: Add GitHub workflow to build x64 and aa64 binaries](https://github.com/ipxe/shim/commit/929b314a)

Almost all of the above are standard housekeeping patches such as
adding the vendor certificate.  The one functional change is [ipxe:
Allow next loader path to be derived from shim
path](https://github.com/ipxe/shim/commit/97cee9b9):

```
ipxe: Allow next loader path to be derived from shim path

Allow loader path to be constructed from the path used to load the
shim itself, e.g.:

    ipxe-shimx64.efi      -> ipxe.efi
    ipxe-shimaa64.efi     -> ipxe.efi
    snponly-shimx64.efi   -> snponly.efi
    snponly-shimaa64.efi  -> snponly.efi

This reduces the complexity of using a signed shim binary to load
iPXE, which (unlike GRUB) has a variety of possible binary names
depending on the requested driver set.  For example, if a site uses
all three of ipxe.efi, intel.efi, and snponly.efi then symlinks can be
used to provide the appropriate shim files:

    # iPXE binaries
    /var/lib/tftpboot/ipxe.efi
    /var/lib/tftpboot/intel.efi
    /var/lib/tftpboot/snponly.efi

    # shim binary (from this repository)
    /var/lib/tftpboot/ipxe-shimx64.efi

    # shim symlinks
    /var/lib/tftpboot/intel-shimx64.efi -> ipxe-shimx64.efi
    /var/lib/tftpboot/snponly-shimx64.efi -> ipxe-shimx64.efi
```

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************

No, the NX bit is not set.

While it is believed that the shim+iPXE boot stack is NX-compatible
(and the iPXE binary is already built with the NX bit set), we do not
intend to set the NX bit in the shim until it is set by default in the
shim release.

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of GRUB2 affected by any of the CVEs in the July 2020, the March 2021, the June 7th 2022, the November 15th 2022, or 3rd of October 2023 GRUB2 CVE list, have fixes for all these CVEs been applied?

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
The entry should look similar to: `grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************

Not applicable: this shim will not be used to load a Linux kernel.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************

Not applicable: this shim will not be used to load a Linux kernel.

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************

Not applicable: this shim will not be used to load a Linux kernel.

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************

Not applicable: only a single certificate is used and there are no
allow-listed hashes.

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************

The [`Dockerfile`](Dockerfile) provides a reproducible build.

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************

The [`build.log`](build.log) contains the build log.

*******************************************************************************
### What changes were made in the distor's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..
*******************************************************************************

Not applicable: this is a new submission.

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
[`shimx64.efi`](shimx64.efi) 636d581943f1872d4eb17af39b3b7e07ed8dfc5ec5e85779550fa2c01fa3aeae

[`shimaa64.efi`](shimaa64.efi) 986978b520a3b159f74da9e16939aac6a986b8467f6f41929e4d94ef87863ad0

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************

Key is held in a hardware security module provided by DigiCert.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************

Yes, the certificate [`ipxe.der`](ipxe.der) is an EV certificate
issued by DigiCert.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide exact SBAT entries for all shim binaries as well as all SBAT binaries that shim will directly boot.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
If you are using a downstream implementation of GRUB2 or systemd-boot (e.g.
from Fedora or Debian), please preserve the SBAT entry from those distributions
and only append your own. More information on how SBAT works can be found
[here](https://github.com/rhboot/shim/blob/main/SBAT.md).
*******************************************************************************

Yes.

This shim binary includes the vendor SBAT data:
```
shim.ipxe,1,iPXE,shim,1,https://github.com/ipxe/shim
```

This shim will be used to load iPXE, which includes SBAT metadata as
of commit [f4f9adf61](https://github.com/ipxe/ipxe/commit/f4f9adf61).
The current SBAT content in iPXE at the time of writing is:

```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
ipxe,1,iPXE,ipxe.efi,1.21.1+ (g182ee),https://ipxe.org
```

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************

Not applicable: this shim will not be used to load systemd-boot.

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************

https://github.com/ipxe/ipxe

iPXE currently uses a rolling release model.  With a signed shim, this
will switch to regular (potentially quarterly) releases.

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************

This shim will be used only to launch iPXE.

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************

By design, iPXE does not implement any direct binary loaders when
running as a UEFI binary.  All binary image loading is delegated to
the platform's `LoadImage()` and `StartImage()` calls.  There is
therefore no way for iPXE to execute a binary that is not itself
already signed for Secure Boot.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB2)?
*******************************************************************************

No.

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************

Not applicable: this shim will not be used to load a Linux kernel.

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************

iPXE has previously been signed directly for Secure Boot and has
therefore been subject to several security audits, the results of
which have been shared with Microsoft.

Portions of the codebase that are ineligible to be included in Secure
Boot signed builds are well understood and documented in the [UEFI
Signing Requirements][signingreq] document.

Microsoft has commented in its [iPXE Security Assurance
Review][securityreview] that iPXE's code is of high quality and that
its use of the EFI boot services stack is exceptionally well
documented.

The most recent security audit carried out for Secure Boot signing
found only a single potential bug, which could be exploited only by a
[malicious PCI device](https://github.com/ipxe/ipxe/commit/7b60a4875).

This submission was created over a year ago, in February 2023.  It has
been rebased upon the shim-15.8 release in February 2024.

Given that the Secure Boot team at Microsoft is already well aware of
iPXE, we would like to ask the shim-review team to please review only
the shim submission aspects (e.g. the correctness of the GPG tags, the
reproducibility of the build, the SBAT metadata, and the list of
patches), to accept the submission on this basis, and to leave to
Microsoft the substantive decision on signing the resulting shim.


[signingreq]: https://techcommunity.microsoft.com/t5/hardware-dev-center/updated-uefi-signing-requirements/ba-p/1062916
[securityreview]: https://techcommunity.microsoft.com/t5/hardware-dev-center/ipxe-security-assurance-review/ba-p/1062943
