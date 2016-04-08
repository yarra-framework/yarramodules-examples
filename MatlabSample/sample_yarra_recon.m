% ## sample_yarra_recon -- Example Matlab reconstruction module for Yarra ##
%
% Description: This example shows how Matlab programs can be integrated 
%              with Yarra. In this example, the reconstruction reads the
%              given TWIX file and performs a simple 3D-FFT MRI reconstruction
%              with sum-of-squares combination of the channels. The final
%              images are saved in the DICOM format with naming convention 
%              that enables Yarra to group images correctly into one series.
%
% Parameters:  work_path   -- Path where the TWIX file is located
%              meas_file   -- Name of the TWIX file (without path)
%              output_path -- Path where the final images should be written
%              temp_path   -- Path that can be used for temporary files

function sample_yarra_recon(work_path, meas_file, output_path, temp_path)

    disp('Yarra Matlab Reconstruction Example');
    disp('-----------------------------------');
    disp('');
    
    % Include helper packages (not needed when running inside Yarra because
    % genpath() includes all subfolders automatically
    % addpath('mapVBVD/');          % for reading TWIX files

    % Read the data from the Siemens TWIX file
    twix_obj=mapVBVD([work_path meas_file]);

    % Get the sequence parameters from the file
    baseresolution=double(twix_obj{2}.image.NCol);
    channels=double(twix_obj{2}.image.NCha);
    slices=double(twix_obj{2}.image.NPar);

    % Get the k-space data
    rawdata=twix_obj{2}.image();

    % Run 3D FFT for each channel (including FFT shift) 
    for ic=1:channels
        coilimage(:,ic,:,:)=fftshift(fftn(squeeze(rawdata(:,ic,:,:))));
    end

    % Calculate sum-of-squares combination of all channels to obtain one 3D dataset
    ssq=zeros(size(squeeze(coilimage(:,1,:,:))));
    for iSlc=1:slices
        for iChn=1:channels
            ssq(:,:,iSlc)=ssq(:,:,iSlc)+squeeze(abs(coilimage(:,iChn,:,iSlc).*coilimage(:,iChn,:,iSlc)));
        end
    end
    ssq=sqrt(ssq);

    % Cut out FOV center to remove the 2x readout oversampling 
    result=ssq(end/4+1:end/4*3,:,:,:);

    disp('Saving images as DICOM...');
    
    % Write final images as DICOM files into given output path
    for iSlc=1:slices
        dicomwrite(result(:,:,iSlc), [output_path '/slice' num2str(iSlc, '%03d') '.dcm']);
    end	
    
    disp('Done.');    
end

