# Hestia Libraries - `hestiaERROR`

[![Hestia Libraries](/src/icons/banner_1200x270.svg)](#)

One Peaceful Frontend+Backend Software Library Suite.

This repository facilitates error numbering definitions for error reporting in
memory constrained environment.




## Why It Matters

This project was initiated primarily because of:

1. **Ensures proper interoperability between programming languages** -
   making sure the `hestiaERROR` library talks to each other seamlessly across
   programming languages with the same context.
2. **Utilizing low memory, language-free, and simple error reporting** -
   using simple 1 byte number across all technologies and software layers for
   highest signal consistencies.
3. **Keeping string error representations internationalization capable** -
   making string translations a lot easier to manage.
5. **Simple to integrate** - simple enough to use for all supported programming
   languages.




## Design Principles

The definitions complies to only the following rules:

1. **STRICTLY**: **`0` represents OK**.
2. Restricts within 8-bits unsigned integer (1 byte) range (`0` to `255`).
3. Numbers' definitions are context free (e.g. each software layers can response
   differently).
4. Avoid redefining existing codes (can but frown upon).

Based on years of programming experiences across multiple programming languages,
each software layer or project can redefine the list whenever needed
for independent packaging purposes as long as the rules' above are complied.

Also, this library is heavily guarded with unit tests whenever available.




## Setup

This library supports multiple programming languages for the same dataset.
Please import based on your programming language(s) using the instructions in
the sub-sections below.

Please do note that branches like `main`, `next`, and `experimental` are for
maintenance & development uses (as in, the production factory itself). Hence,
please avoid them and only use it at your own risk.



### Javascript|Typescript Ecosystems

To use `hestiaERROR` library in your Javascript|Typescript project, you may use
the following methods for integrations:


#### Git Release Branches (Recommended)

It's highly recommended to use `git` release branches inside your `package.json`
dependencies list. This is to avoid the registry configurations problem
involving `npm`:

```
{
  "dependencies": {
    ...
    "@chewkeanho/hestiaERROR": "git+https://github.com/ChewKeanHo/hestiaERROR.git#[VERSION]_js"
    ...
  }
}
```

For always latest release, please use the `latest` version tag. Example:

```
{
  ...
  "dependencies": {
    ...
    "@chewkeanho/hestiaERROR": "git+https://github.com/ChewKeanHo/hestiaERROR.git#latest_js"
    ...
  }
  ...
}
```


#### NPM

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
4. BASH Exit Statuses
   1. Source: https://tldp.org/LDP/abs/html/exitcodes.html
5. PowerShell Error Handling
   1. Source: https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-exceptions

These sources are strongly referencing from the Linux Kernel while maintaining
the definitions usable even at operating system scripting level for both UNIX
and Windows OSes.




## License

This project is licensed under [OSI compliant Apache 2.0 License](LICENSE.txt).
