# Download and Prepare Image Script

This script automates the process of downloading a tar.gz image file, extracting it, and preparing the contents.

## Prerequisites

- `axel`: This script uses `axel` for accelerated downloads. If you don't have it, install it using your package manager (e.g., `sudo apt install axel` on Debian/Ubuntu).

## Usage

1.  Make sure the script `download_and_prepare_image.sh` is executable:
    ```bash
    chmod +x download_and_prepare_image.sh
    ```

2.  Run the script by providing the download link as a command-line argument:
    ```bash
    ./download_and_prepare_image.sh <your_download_link>
    ```
    Replace `<your_download_link>` with the actual URL of the tar.gz file.

## Script Steps

1.  **Downloads the File**: Uses `axel -n 100 <link> -o image.tar.gz` to download the specified tar.gz file.
2.  **Creates `updateImage` Directory**: A directory named `updateImage` is created in the same location as the script.
3.  **Extracts Archive**: The downloaded `image.tar.gz` is extracted into the `updateImage` directory.
4.  **Deletes `image.tar.gz`**: The downloaded archive file is removed after successful extraction.
5.  **File Operations in `updateImage`**:
    *   Deletes `dtb.bin`.
    *   Renames `do_not_use.img` to `data.img`.
    *   Renames `dtb_RW.bin` to `dtb.bin`.
6.  **Error Handling**: The script includes error checks at each major step and will exit if an error occurs.
