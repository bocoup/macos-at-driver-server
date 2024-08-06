# MacOS AT Driver Server Maintenance Guide

This package organizes macOS platform code within an Xcode project. It also
relies on Node.js code to expose a command-line interface; the Node.js code is
copied into place from a shared directory during publication time.

## Packaging Requirements

- macOS version 13 ("Ventura") or later
- Xcode
- Node.js version 18 or later

## Packaging Instructions

1. Build the Xcode project
2. Run `npm publish`
