# Photoshop Export - Substance 3D Painter plugin (8K Export Fork)

**Note:** This is a fork of the original Photoshop Export plugin (version 1.1.6, originally found at `https://github.com/AllegorithmicSAS/painter-plugin-photoshop-export`) that was shipped with Substance 3D Painter v.9 (2023). This version has been modified to add an option in the configuration panel to override the export resolution, allowing for exports up to 8K (8192x8192). The repository for this fork can be found at `https://github.com/vengefulcrop/painter-plugin-photoshop-export-8k-2023`.

**Important:** Certain Substance Painter versions may have issues exporting texture maps at 8K using assets and generators that have not been updated to support this resolution, [as described in this Adobe Community issue from last year](https://community.adobe.com/t5/substance-3d-painter-discussions/substance-painter-not-exporting-8k-maps-correctly/td-p/13007331).

This plugin adds an __Export To Photoshop__ button to the Send To menu of Substance 3D Painter. The export action creates one Photoshop document for each channel of each stack of the Substance 3D Painter document, preserving the stack hierarchy (layers and groups). Unfortunately, blending modes and filters are not fully compatible between Photoshop and Substance 3D Painter, hence the final result can be different between the two softwares.

## Installation

Download or clone this project (`https://github.com/vengefulcrop/painter-plugin-photoshop-export-8k-2023`) into the Substance 3D Painter plugins folder. The plugins folder can be opened from Substance 3D Painter through the menu ``Plugins/Plugins folder``. Substance 3D Painter needs to be restarted for the plugin to take effect.

## License

Distributed under the MIT license. See [LICENSE](LICENSE) file for more information.
