# Examples for Yarra Module Development

This repository contains examples that show how Yarra modules can be developed and used.

### MatlabSample ###

This example demonstrates how a reconstruction algorithm written in Matlab can be integrated. Here, a simple 3D FFT reconstruction is done by loading the raw data (using the mapVBVD Matlab library from Philip Ehses), arranging the data on a matrix, running a 3D FFT, and writing the reconstructed images as DICOMs from Matlab. The two included .mode files show how the Matlab function can be called from Yarra. The mode MatlabSample_PACS sends the images into PACS (or onto a DICOM workstations like OsiriX), and MatlabSample_Drive stores the images on a location on the file system.

## License Information
The Yarra framework is provided free of charge for use in research applications. It must not be used for diagnostic applications. The author takes no responsibility of any kind for the accuracy or integrity of the created data sets. No data created using the framework should be used to make diagnostic decisions.

The Yarra framework, including all of its software components, comes without any warranties. Operation of the software is solely on the user’s own risk. The author takes no responsibility for damage or misfunction of any kind caused by the software, including permanent damages to MR systems, temporary unavailability of MR systems, and loss or corruption of research or patient data. This applies to all software components included in the Yarra software package.

The source is released under the GNU General Public License, GPL (http://www.gnu.org/copyleft/gpl.html). The source code is provided without warranties of any kind.

## More Information
More information can be found on the project website http://yarraframework.com
