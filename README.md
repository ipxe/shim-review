*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************

This shim review request is coming direct from the iPXE project
(https://ipxe.org).  The EV code signing certificate is issued by
SSL.com and owned by Fen Systems Ltd (https://www.fensystems.co.uk).

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
*******************************************************************************

Fen Systems Ltd is registered in England and Wales with registration
number 03981413.

https://find-and-update.company-information.service.gov.uk/company/03981413

The EV certificate used for signing .cab files at Microsoft Hardware
Dev Center File Signing Services has the details:

```
Issuer: C=US, ST=Texas, L=Houston, O=SSL Corp, CN=SSL.com EV Code Signing Intermediate CA RSA R3
Subject: C=GB, L=Cambridge, O=FEN SYSTEMS LTD., serialNumber=03981413, CN=FEN SYSTEMS LTD., businessCategory=Private Organization, jurisdictionC=GB
```

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
### Were these binaries created from the 16.1 shim release tar?
*******************************************************************************

Yes, these binaries were created from the `16.1` tag.

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
*******************************************************************************

https://github.com/ipxe/shim/tree/ipxe-16.1

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************

* [ipxe: Add documentation](https://github.com/ipxe/shim/commit/76555293)
* [ipxe: Allow next loader path to be derived from shim path](https://github.com/ipxe/shim/commit/1b02ba2c)
* [ipxe: Add vendor SBAT data](https://github.com/ipxe/shim/commit/4048a557)
* [ipxe: Set "ipxe.efi" as default loader binary name](https://github.com/ipxe/shim/commit/e6494a8d)
* [ipxe: Use iPXE code-signing certificate as vendor certificate](https://github.com/ipxe/shim/commit/5f4b6894)
* [ipxe: Add GitHub workflow to build x64 and aa64 binaries](https://github.com/ipxe/shim/commit/61954232)

Almost all of the above are standard housekeeping patches such as
adding the vendor certificate.  The one functional change is [ipxe: Allow next loader path to be derived from shim path](https://github.com/ipxe/shim/commit/1b02ba2c):

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
*******************************************************************************

No, the NX bit is not set.

While it is believed that the shim+iPXE boot stack is NX-compatible
(and the iPXE binary is already built with the NX bit set), we do not
intend to set the NX bit in the shim until it is set by default in the
shim release.

*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
*******************************************************************************

Not applicable: no old shims have been signed by Microsoft.

*******************************************************************************
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
### How does your signed kernel enforce lockdown when your system runs
### with Secure Boot enabled?
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
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
*******************************************************************************

Not applicable: this shim will not be used to load GRUB2.

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
*******************************************************************************

The [`Dockerfile`](Dockerfile) provides a reproducible build.

*******************************************************************************
### Which files in this repo are the logs for your build?
*******************************************************************************

The [`build.log`](build.log) contains the build log.

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
*******************************************************************************

Not applicable: this is a new submission.

*******************************************************************************
### What is the SHA256 hash of your final shim binary?
*******************************************************************************
[`shimx64.efi`](shimx64.efi) 88ba41738f650b8376d4ce390fdb94315b02fc61ff83498f13e58949e4d74344

[`shimaa64.efi`](shimaa64.efi) 1387aebc8b4c5c970c573c34f8e61763e66d4b3157e44196e5e3bd1b4ac2ccbd

*******************************************************************************
### How do you manage and protect the keys used in your shim?
*******************************************************************************

Key is held in a Yubikey FIPS hardware security module as used for the
SSL.com EV Code Signing certificate.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
*******************************************************************************

Yes, the certificate [`ipxe.der`](ipxe.der) is an EV certificate
issued by SSL.com.

*******************************************************************************
### Are you embedding a CA certificate in your shim?
*******************************************************************************

No.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
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
ipxe,1,iPXE,ipxe.efi,1.21.1+ (gc8f08),https://ipxe.org
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
### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.
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
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************

No.

*******************************************************************************
### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?
*******************************************************************************

Not applicable: this shim will not be used to load a Linux kernel.

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
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

This submission was created over two years ago, in February 2023.  It
has been rebased upon the shim-15.8 release in February 2024, and then
rebased again upon the shim-16.1 release in October 2025.

Given that the Secure Boot team at Microsoft is already well aware of
iPXE, we would like to ask the shim-review team to please review only
the shim submission aspects (e.g. the correctness of the GPG tags, the
reproducibility of the build, the SBAT metadata, and the list of
patches), to accept the submission on this basis, and to leave to
Microsoft the substantive decision on signing the resulting shim.

Microsoft has [commented][mscomment] in October 2025 that "the shim
review process will suffice for these submissions, so all submissions
leveraging this iPXE shim will be to go through the shim review
process for approval before submitting to Microsoft for review and
signing", and has updated the [UEFI Signing Requirements][signingreq]
document to state explicitly that iPXE shims should use [this
submission][selfissue].

[signingreq]: https://techcommunity.microsoft.com/t5/hardware-dev-center/updated-uefi-signing-requirements/ba-p/1062916
[securityreview]: https://techcommunity.microsoft.com/t5/hardware-dev-center/ipxe-security-assurance-review/ba-p/1062943
[mscomment]: https://github.com/rhboot/shim-review/issues/319#issuecomment-3356075767
[selfissue]: https://github.com/rhboot/shim-review/issues/319
