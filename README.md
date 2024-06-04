# Hestia Libraries - `hestiaERROR`

[![Hestia Libraries](.src/icons/banner_1200x270.svg)](#)

One Peaceful Frontend+Backend Software Library Suite.

This repository houses the operating components of the error code numbering
definitions and representations for various supported programming languages. The
repository splits itself into multiple parts depending on its language-specific
or deployment-specific usage.




## Why It Matters

This project was initiated primarily because of:

1. **Ensures proper interoperability between programming languages** -
   making sure the `hestiaERROR` library talks to each other seamlessly across
   programming languages with the same context.
2. **Utilizing low memory, language-free, and simple error reporting** -
   using simple 1 byte number across the projects and software layers for
   highest efficiency and works as a signal.
3. **Keeping string representations within the project's language
   internationalization libraries** - making string processing and translations
   a lot more simple to manage and operate.
4. **Simple to integrate** - simple enough to use the supported programming
   language's package manager.




## Setup

This library supports multiple programming languages for the same dataset.
Hence, in order to use it, please import based on your deployed programming
language:

> **NOTE**
>
> To be updated.




## Data Source

The libraries are based on the following data sources:

1. Linux Kernel - Universal Base Error Numbers
   1. Source: `include/uapi/asm-generic/errno-base.h`
2. Linux Kernel - Generic Assembly Error Numbers
   1. Source: `include/uapi/asm-generic/errno.h`
3. Linux Kernel - Extended Error Numbers
   1. Source: `include/linux/errno.h`
4. BASH Exit Status list
   1. Source: https://tldp.org/LDP/abs/html/exitcodes.html
5. PowerShell Error Handling
   1. Source: https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-exceptions

These sources are strongly referencing from the Linux Kernel while maintaining
the definitions usable even at operating system scripting level for both UNIX
and Windows OSes.

The definitions complies to only the following rules:

1. **STRICTLY**: **`0` represents OK**.
2. Restricts within 8-bits unsigned integer (1 byte) range (`0` to `255`).
3. Numbers' definitions are context free (e.g. each software layers can response
   differently).
4. Avoid redefining existing codes (can but frown upon).

Based on years of programming experiences across multiple languages, these error
codes are newly defined and each software layers can redefine the list whenever
needed for independent packaging purposes.




## Test Cases

The library is heavily guarded with unit tests whenever available.




## License

This project is licensed under [OSI compliant Apache 2.0 License](LICENSE.txt).
